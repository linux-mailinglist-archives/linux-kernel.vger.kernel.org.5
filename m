Return-Path: <linux-kernel+bounces-109954-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 09B5B88582D
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 12:23:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BA09028255C
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 11:23:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64D265821C;
	Thu, 21 Mar 2024 11:23:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="C+X4YClq"
Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FCAE57302
	for <linux-kernel@vger.kernel.org>; Thu, 21 Mar 2024 11:22:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711020180; cv=none; b=WmxBLcofc9uYOi4QJlDn5FzoGPWVJL3r0A+s+rsDh/MfOr0NNlBLvRdaGWzIWEdbq3QnwKGrm1Gaf+8payP3fzghbo7lGR7EnZDonnFdLloSv3k7vdtKhmjNd5QG/99IARUXNqRWwe8UshV+aZ9LDvf1b/JEsjsty/NVCEZS7F0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711020180; c=relaxed/simple;
	bh=YRWj7tUuWaozGIBwXID8VtXGQiJ2rzifS+2Bco4hG08=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=cfyqM9OaaYChSZNWhYLYawhumQdKYYPzVKuWtznUCohUxuVh93HPhYmqHwJVdDuxhKE2kBN1A+IIoW4poqdUN+hZmGLZvMnqEn2dnjfyVDhz1NPTd714QOOhGOWs8rsUMcT1/+lbG04Go9rGOLoYtGvZtKTexQLN9aIRTN6yJHI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=C+X4YClq; arc=none smtp.client-ip=209.85.222.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-789f3bbe3d6so62506285a.0
        for <linux-kernel@vger.kernel.org>; Thu, 21 Mar 2024 04:22:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1711020178; x=1711624978; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MKov5O1lFAGwk/wL55gxbWjBq9FqkMhV/kf6YNRLDok=;
        b=C+X4YClqh55IiflZ73VUmNNhgsGr0yAAuZAizIbo7kHR7b2iULzTmECQYr8kO2ttkp
         SHJSCmkqwPGjqvJnszFHDFqW6YdyQ2A9XvvdF2bWO1ekw9htFYZnOI0UOeAidSwYoPcd
         OMdkXQk7BX7zwbiQPDqwciIdCNUzSovc/nUBM7Q0ofSncyqAFW8BtX8krDrrNTT6mK40
         XV/lVpq+WVGYb4mIBgF/oMu/oH5a4j4i5yz7mncMvgYWs9S1u4/Mgq4JOd9H1Zvq6qZ5
         ToSkKBCEvu+7mstWgDXSaSLNxknUOOo+/cawiVIbafwwUesgFEfZNbUU9epvOMqj+CTd
         nIjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711020178; x=1711624978;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MKov5O1lFAGwk/wL55gxbWjBq9FqkMhV/kf6YNRLDok=;
        b=Ubjoqg30tRbPt6Icp4aKMTbc7OwWXe3mwwST3WBZRWEHbCFmvmlWONH8iJpJvBkz8g
         UefI7GunIRr454HL9623u+7Jyr1gAlUnhvtFwdRevTthu0+Ar7v8u2tE0MiM0F7l27ys
         MSwAuuP7pRg0v92mNhiHQQWpBmp/hNS/SaGKnd+L/7PcSPWzcID5evEFlJUOkAufosTr
         mcVLZFnK5XzrpDOMMGk171xX0YmmDz+kf5k2WrVBB39Arag9haMRzzYDAVmF9aemqQzL
         bUwYW51OrSsifEHZ/3qAWSnjeLKrrERFeR3fb1XShjAo6jnMDYqwcjGSeJTLOzZ7ZAxW
         VKHg==
X-Forwarded-Encrypted: i=1; AJvYcCWt3RCDIExrDQVSFQoL/N0qoZTdJjIgiKX6fj5yKXbrP71tuy4MWQK/OzR2HCy52Z9jWHjsWWtNi9Mmn1tu/r3TqBHeC+AX/fg6IqdN
X-Gm-Message-State: AOJu0YxhqURlHHJvPCw+mAkwdIh4HvwfY2Rj7kOoDYKS+COBmffDQMVY
	DJMqVkoZoCvB1XMbit5gPzKli1cS/IPpAZuZZhyyCZfWyqNjkDcm8rnYX9lLyoORAq6N7tTUk94
	=
X-Google-Smtp-Source: AGHT+IFEF9zGB/LdeZhJbbnFlyxqqaJFUZ7TW2VrIUFAnJy5wTVwAoPqE1PhloEVUkpQfD6YLYxRjA==
X-Received: by 2002:a05:6a20:4e28:b0:1a3:50be:b3bb with SMTP id gk40-20020a056a204e2800b001a350beb3bbmr3542415pzb.53.1711019809214;
        Thu, 21 Mar 2024 04:16:49 -0700 (PDT)
Received: from [127.0.1.1] ([2409:40f4:102b:a64b:d832:a82a:837c:6d3])
        by smtp.gmail.com with ESMTPSA id ka6-20020a056a00938600b006e7324d32bbsm5531120pfb.122.2024.03.21.04.16.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Mar 2024 04:16:48 -0700 (PDT)
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Date: Thu, 21 Mar 2024 16:46:23 +0530
Subject: [PATCH v2 03/21] arm64: dts: qcom: sm8150: Add PCIe bridge node
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240321-pcie-qcom-bridge-dts-v2-3-1eb790c53e43@linaro.org>
References: <20240321-pcie-qcom-bridge-dts-v2-0-1eb790c53e43@linaro.org>
In-Reply-To: <20240321-pcie-qcom-bridge-dts-v2-0-1eb790c53e43@linaro.org>
To: Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konrad.dybcio@linaro.org>, Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, cros-qcom-dts-watchers@chromium.org, 
 Rob Herring <robh@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=openpgp-sha256; l=1249;
 i=manivannan.sadhasivam@linaro.org; h=from:subject:message-id;
 bh=YRWj7tUuWaozGIBwXID8VtXGQiJ2rzifS+2Bco4hG08=;
 b=owEBbQGS/pANAwAKAVWfEeb+kc71AcsmYgBl/BcJJxAyVnzVSonO4oMAUO+Ag2f2+i0I0Vglr
 D3M3ea0HX+JATMEAAEKAB0WIQRnpUMqgUjL2KRYJ5dVnxHm/pHO9QUCZfwXCQAKCRBVnxHm/pHO
 9dFSCACSscUDSAGMxHspwNenzJ2yAY3/YhnjNqPcuON1yIn5KEMU4NcL85gsz5ggk1DmBND5arp
 QnsacCfTvv8ouytMnA212VVS785S8U4vfNepNYiRyu/sU0pPGf+FNyGucNr6+N3DqeArGAQElXk
 K1JKIfDKiR/PLo+2pi2GSoPefirnf+ihJlV+ZEQe/l8QJJdbfV3LsmvW9RgXtSaVkJS3V7z9F5Q
 1cc6NSQcDbL0dSewn5GvYENeBluWKlL3OGjwPacgL2GoUyrosu2i210TQT3EAbjVsDSSkfGrHeK
 ETFVXUv/Zkiczln/g4rNtXe79CaE09LIGMpQfUL3Ftu9UDzq
X-Developer-Key: i=manivannan.sadhasivam@linaro.org; a=openpgp;
 fpr=C668AEC3C3188E4C611465E7488550E901166008

On Qcom SoCs, the PCIe host bridge is connected to a single PCIe bridge
for each controller instance. Hence, add a node to represent the bridge.

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 arch/arm64/boot/dts/qcom/sm8150.dtsi | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sm8150.dtsi b/arch/arm64/boot/dts/qcom/sm8150.dtsi
index a35c0852b5a1..ff22e4346660 100644
--- a/arch/arm64/boot/dts/qcom/sm8150.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8150.dtsi
@@ -1901,6 +1901,16 @@ pcie0: pcie@1c00000 {
 			pinctrl-0 = <&pcie0_default_state>;
 
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
 
 		pcie0_phy: phy@1c06000 {
@@ -2011,6 +2021,16 @@ pcie1: pcie@1c08000 {
 			pinctrl-0 = <&pcie1_default_state>;
 
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
 
 		pcie1_phy: phy@1c0e000 {

-- 
2.25.1


