Return-Path: <linux-kernel+bounces-74031-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F1CB85CF14
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 04:48:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7EFCE285F30
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 03:48:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 366FE39FF4;
	Wed, 21 Feb 2024 03:43:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="XoI7UVks"
Received: from mail-yb1-f173.google.com (mail-yb1-f173.google.com [209.85.219.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2A8A3F9D3
	for <linux-kernel@vger.kernel.org>; Wed, 21 Feb 2024 03:43:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708486986; cv=none; b=mNHgSAOYwxw9hoDz0DjEryOMkkiNAPoNXwFePUL61GKQpsp50iERei8pFSGAk4JBdh2g6UGVW3juXfYDG0FETkON2X5c7+BcYxjy4Balg0OmUS24RUQF/vbG21E/8FTrELgvWn3DBQt5FTDyoAdc9yFz7kTswcdaHGlRvaIlUnk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708486986; c=relaxed/simple;
	bh=qsTRANnrjgd64sASVvI7UVSejFTBTbY3eqvdV6V3DBI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=snYNfVPre2K3s0UQCxYBF7Z9BXGf83pDIOVkuQLz+PXDiWXTBNO3OqToG3KznQapR6nuU4mEeswGSzcd+nWyv3zJoAonEOTzz8qxfXwu/YUWKRR0MmvfPBIaFvny3OZzocjC+Ggu7BL7VOhiCySHvD+BLGXBLmQhMYjyTkte2m0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=XoI7UVks; arc=none smtp.client-ip=209.85.219.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f173.google.com with SMTP id 3f1490d57ef6-dcd7c526cc0so6625376276.1
        for <linux-kernel@vger.kernel.org>; Tue, 20 Feb 2024 19:43:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1708486984; x=1709091784; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lMWC/34/1lB2iFGC1C191+CE0mmpbC06CHuKaoqNo+A=;
        b=XoI7UVksB4uLlrnBOBMFLjH5uQX6C1DXPPrBd103pkgJdlfY8oM5ygQtRFpIU1dmJ/
         yYf5tNwDfMPL8axwDTUYxbs0ult8Lo/iegFzB2CptKWoV4Fd/jiGuMxztuPBLCk/NBMn
         c7J63SdftZAsR0pt+zGlmfpIIJNzVFTJNkQzv2Rpez4Sv/cPcAxBnUSRBla4BmcWbNVR
         SNPkgJH7sw16nJ3MKJrSNbFgROF9UPRBeF8gYkP9KBsjrgi0K/mf6UWJGL7rP6YSte2+
         ywAS0QKiFg+ZD0dMavYZlRL9nvO3woz4/sLQeL/y9YLkWTxs/8DpuD5kLKyRuMA8dL8m
         a/Ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708486984; x=1709091784;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lMWC/34/1lB2iFGC1C191+CE0mmpbC06CHuKaoqNo+A=;
        b=cxWYOA4y2ZiPWM4V8qAM0RpNomby5BN4EGqpkmhwk1dY4om+BlzMXzq/xp2jtPlxNF
         dwy75nxDIUKivfwpHvzLFJW4zvqDaykGorEtVnbXNL3ZTiSiMlsWD+0nk6/rfDv7J8og
         cajeCO1lNS+fDIZCHFEY+V1Ou3P7Vt9Z1gqSKBpPCfz3LYe1dCfwWCwgeNR0rFnfAaEX
         WPYliir4ODAFIE6h264W512XGOXpoTOUgibGtAjaiiXZqk8+8I7BxFmSjBbTZUXfOEVu
         vbiDQdQqyvaKav9Pv4RxGgwwippGtUvoIUe3SpVKqLmubjD8mPUDWOb1VTB6IIx8mqD/
         1GyQ==
X-Forwarded-Encrypted: i=1; AJvYcCV0L+XeJpw5AUezEyHgq4k340x6RvJtC/lPrCBfXgPwWtDUA7Pp9lPyw/n5CNNiSrD61hEvAHxNzUPgpKFyE3l/KsBF0E3cPwuhyE7p
X-Gm-Message-State: AOJu0YzYl05zqWkD5UASZGTfDKYEV7a3TS9LRsq4K4KbNe0Gm1eUOTpY
	6hxie981qaKhAE43CE6liScpxvNaplP38jYDMku/xXJzE1AMDORDqNWpmhi/O/NpxcifPCCAufU
	=
X-Google-Smtp-Source: AGHT+IFoFxNTPVX6AYcyNJvC5R/M4h/yj/eDYHvxkLrWpMM1VzrykZKmMDaBGJa79H9TInBX7rulPA==
X-Received: by 2002:a25:680e:0:b0:dbd:553d:9d6a with SMTP id d14-20020a25680e000000b00dbd553d9d6amr17080328ybc.40.1708486983790;
        Tue, 20 Feb 2024 19:43:03 -0800 (PST)
Received: from [127.0.1.1] ([117.207.28.224])
        by smtp.gmail.com with ESMTPSA id o23-20020a056a001b5700b006e466369645sm4436231pfv.132.2024.02.20.19.43.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Feb 2024 19:43:03 -0800 (PST)
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Date: Wed, 21 Feb 2024 09:12:02 +0530
Subject: [PATCH 16/21] arm64: dts: qcom: ipq6018: Add PCIe bridge node
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240221-pcie-qcom-bridge-dts-v1-16-6c6df0f9450d@linaro.org>
References: <20240221-pcie-qcom-bridge-dts-v1-0-6c6df0f9450d@linaro.org>
In-Reply-To: <20240221-pcie-qcom-bridge-dts-v1-0-6c6df0f9450d@linaro.org>
To: Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konrad.dybcio@linaro.org>, Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, cros-qcom-dts-watchers@chromium.org
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=openpgp-sha256; l=864;
 i=manivannan.sadhasivam@linaro.org; h=from:subject:message-id;
 bh=qsTRANnrjgd64sASVvI7UVSejFTBTbY3eqvdV6V3DBI=;
 b=owEBbQGS/pANAwAKAVWfEeb+kc71AcsmYgBl1XEI4GuKDxlUOKGNWONCyizTCfOoFRRVxbzEF
 UanCwpZpq2JATMEAAEKAB0WIQRnpUMqgUjL2KRYJ5dVnxHm/pHO9QUCZdVxCAAKCRBVnxHm/pHO
 9e7VCACMFnB0KOZ6Sg5L+PDiQMokuVJLdLVeRCeTsTQbt2frYDiSOsL/KC+zGc2GTEVLnqOe5Ez
 I++j9VbkeCIGSWigy99M/UYP8yCS34tJPQPclv0TAUZzqX1uS4Q/fo0J1BpIURx7aDzqiKJ2t37
 Yj5gln4r5l7WBtsecS4HXDkPVxMatD2nFO2QEFNWLE85EauEIE+wNTCL0bEPQNJJ2Qu/hXB1iHE
 Rz2oRG+zhmUav0DcEJ2OPMikrBb9Szl9aSRBL0nZKD/vmvtJhSM1Jvxs7h+atFHkggE58oBB9HH
 XvX5QR2w9RRojsKZCRzX2xEElDvLb1OYTgK3i8xtTh1loLqk
X-Developer-Key: i=manivannan.sadhasivam@linaro.org; a=openpgp;
 fpr=C668AEC3C3188E4C611465E7488550E901166008

On Qcom SoCs, the PCIe host bridge is connected to a single PCIe bridge
for each controller instance. Hence, add a node to represent the bridge.

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 arch/arm64/boot/dts/qcom/ipq6018.dtsi | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/ipq6018.dtsi b/arch/arm64/boot/dts/qcom/ipq6018.dtsi
index 5e1277fea725..a6ace7789815 100644
--- a/arch/arm64/boot/dts/qcom/ipq6018.dtsi
+++ b/arch/arm64/boot/dts/qcom/ipq6018.dtsi
@@ -864,6 +864,16 @@ pcie0: pcie@20000000 {
 				      "axi_s_sticky";
 
 			status = "disabled";
+
+			pcie@0 {
+				device_type = "pci";
+				reg = <0x0 0x0 0x0 0x0 0x0>;
+				bus-range = <0x01 0xff>;
+
+				#address-cells = <3>;
+				#size-cells = <2>;
+				ranges;
+			};
 		};
 	};
 

-- 
2.25.1


