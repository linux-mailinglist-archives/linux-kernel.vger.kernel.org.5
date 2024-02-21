Return-Path: <linux-kernel+bounces-74035-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B5BF385CF20
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 04:49:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 70A58286D8D
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 03:49:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B64CD40BED;
	Wed, 21 Feb 2024 03:43:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="c2Yrls1s"
Received: from mail-yb1-f174.google.com (mail-yb1-f174.google.com [209.85.219.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FEC140BEA
	for <linux-kernel@vger.kernel.org>; Wed, 21 Feb 2024 03:43:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708487000; cv=none; b=FYI76xJ6SodhHZtqRUTcKSl3bMtRNsN2vu9vt193vmJsA8M5JdC4iBtxv23kkJP8ziU+tKImkh3Rj8fngZo3yFffwL+gki9kClkwDuk+t3xHUuJ8fVFTWttFtRMdOY9uZDjod+9VQBIy0YvNVp+tHuWuBw97LUo83cl/A/omM1c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708487000; c=relaxed/simple;
	bh=3jx7xcLFBNs3MoMPC7hOG3cqD1b3y0NhSb/veZhqzaw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=uXePdnFUDfPzpv3mV9o3INvG6WQZWGbOfhKXeD+5Ky6+DYnA6CTrqOD4GiBzAiVrIQ6ySthWmvZJgGJGHtInz0IVzWdOAyJh6kOyiUdpWEsItFRgc25iJemr9GPa7OyDJYLEskz+lcS+hV1BozTgkacB0DCr2p2ntFuHaO0D00I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=c2Yrls1s; arc=none smtp.client-ip=209.85.219.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f174.google.com with SMTP id 3f1490d57ef6-dcc80d6004bso231845276.0
        for <linux-kernel@vger.kernel.org>; Tue, 20 Feb 2024 19:43:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1708486997; x=1709091797; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=syX1Qx9Iem4TSxZ/KaGRejBy0YhBu2VJFkbJL0HV4dk=;
        b=c2Yrls1sCcQWZrqNHGjCgD5NjXVbECXzjkixS9VwHo0hqs03B2HaCKhmgTpgVwjT3z
         /MBnBxKiqzfTToBP2I5+GgrQ+pGrtN/8H6VeI9+XmoTGsje5UIsBaE1tgGI+ssq/vs7+
         rmK9uZ1FiQjPZJx1afc/8tjWmy4ZLUoZUqGZJaj19mBEmXlltR3Mq7tsTo9M6wy8uNCX
         MF2bcHcxR5S3nRjgdJclU3+3sard8sCt6n+ZPOtzAoGdqfE1mnW8Mxf9J7b7XxdFLpaR
         CvL3dJoK/GZoSEjM2uud6nxpnxThhPlP/gAjmL4M0T0eh+fxBhVV26MTg1qBLGqnpzz1
         2IWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708486997; x=1709091797;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=syX1Qx9Iem4TSxZ/KaGRejBy0YhBu2VJFkbJL0HV4dk=;
        b=BI9DG+IbpLAHuoV6Cts5eUzq4WkXHL6TSfIT2aQqNMPgGUAkK6Enb63Q0x6G44WBn1
         9ea4RpgAn5hbE/LsmkRWHHgMgRcByQdu6AFbF3YVYf9gI29F+gFj3HBwYF2rYIdXDLqn
         qb5r4ktXp20bXfw6sXCWIepMnyNOkOD5dJGnv6OrQqy6vAqd1xBFqLvKm1lAPm7ZFE7f
         yXVx/CUhPCnoc7tLmLYvclqtSAeClkZQGo3lvJo5sLxuvLxVFTnvU7kHl5yL9MdNW2s2
         x5MENJkYTTuE6bYwSfvUUvSY9ZjXtBkoiHIm8GA7Sh2v7vBGN0GGhbnAqqWsT56lht2q
         En1Q==
X-Forwarded-Encrypted: i=1; AJvYcCUeVkh358xqkEFVGAyIjMg4bwlvx9T1218hQiMafQlTd+NgckNAoDlmboblnvf8Nk5jEqEOFs89QFDxjbYg5yUmRzJWiiPjtmU7o4LP
X-Gm-Message-State: AOJu0YwAmcqesvtIPc3SW8xdDmcTRtgENz5Pl6uY6eh6mP+VLuIUB9cH
	HD/txbjJ4snOPZfSMk+yHSFUIvgJ3+ZbaK96vE9CncEIOLk2e6OmffynWxej8Fu1bGHlrC4NVdE
	=
X-Google-Smtp-Source: AGHT+IFBVWJpECMedkEX8/nOsa0s8lpnyOvjOn6f9DzOfF+clVYwUoyuh7w/f2/VM3FW8kxweFZPbw==
X-Received: by 2002:a25:a109:0:b0:dc6:fee4:e889 with SMTP id z9-20020a25a109000000b00dc6fee4e889mr14755046ybh.13.1708486997281;
        Tue, 20 Feb 2024 19:43:17 -0800 (PST)
Received: from [127.0.1.1] ([117.207.28.224])
        by smtp.gmail.com with ESMTPSA id o23-20020a056a001b5700b006e466369645sm4436231pfv.132.2024.02.20.19.43.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Feb 2024 19:43:16 -0800 (PST)
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Date: Wed, 21 Feb 2024 09:12:06 +0530
Subject: [PATCH 20/21] ARM: dts: qcom: sdx55: Add PCIe bridge node
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240221-pcie-qcom-bridge-dts-v1-20-6c6df0f9450d@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=895;
 i=manivannan.sadhasivam@linaro.org; h=from:subject:message-id;
 bh=3jx7xcLFBNs3MoMPC7hOG3cqD1b3y0NhSb/veZhqzaw=;
 b=owEBbQGS/pANAwAKAVWfEeb+kc71AcsmYgBl1XEJ0dYtKghZH8nSt5KbXAa7K43VgCuWjwSTS
 qwWd7D9xTWJATMEAAEKAB0WIQRnpUMqgUjL2KRYJ5dVnxHm/pHO9QUCZdVxCQAKCRBVnxHm/pHO
 9eSqCACVezpkM5fzyHWjKwcI9D/5H8bEjfZ3JGxrFTpT375ZlftDiC8YFM9PwY6TARsaUtuir4h
 QfFsjMoctfImFxsrv4v8mIQE84JUA0BP3dQJYMZS7EHSIDs0p4KjQ7ywnV9YVW03kn0TJ+oFbWs
 KpqT4BHsfA2KrxztKIdc0cdc38ZZGl33T9w85pOb2E+hQXmyMPLDSiuucJZjZo/uVIXnCa4xc15
 0Xs/pCa1/EmlelG3a/0za6AoeGqOoFKXqLC4AUwhQ6FiG4zwogrgR+T+Es6Sdv86YoUHsX2t5K+
 AQytcdZsnb28J7q8Tw2qgQP7rJoO7MTdAJshR5hVXhg83OVl
X-Developer-Key: i=manivannan.sadhasivam@linaro.org; a=openpgp;
 fpr=C668AEC3C3188E4C611465E7488550E901166008

On Qcom SoCs, the PCIe host bridge is connected to a single PCIe bridge
for each controller instance. Hence, add a node to represent the bridge.

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 arch/arm/boot/dts/qcom/qcom-sdx55.dtsi | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/arm/boot/dts/qcom/qcom-sdx55.dtsi b/arch/arm/boot/dts/qcom/qcom-sdx55.dtsi
index 2045fc779f88..053dac097c70 100644
--- a/arch/arm/boot/dts/qcom/qcom-sdx55.dtsi
+++ b/arch/arm/boot/dts/qcom/qcom-sdx55.dtsi
@@ -378,6 +378,16 @@ pcie_rc: pcie@1c00000 {
 			phy-names = "pciephy";
 
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
 
 		pcie_ep: pcie-ep@1c00000 {

-- 
2.25.1


