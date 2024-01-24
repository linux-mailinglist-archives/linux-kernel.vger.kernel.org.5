Return-Path: <linux-kernel+bounces-36565-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4368B83A322
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 08:40:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E7004283809
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 07:40:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEDBA18035;
	Wed, 24 Jan 2024 07:37:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="f6n0ox3Y"
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2AEB18036
	for <linux-kernel@vger.kernel.org>; Wed, 24 Jan 2024 07:37:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706081858; cv=none; b=ClBIGS2esFs2BuR5G7pEbNJ5v2EOwFY4jZCMUN99wwL3FbedE0k69n/9iWfM3p40nMxIEzAp/eyL2dK02U9k6/fVaye2E/oogJk0yHMdQhAxDJSn0gJ8klchEOqwKv2znY8GUCJgSE95C9JM0I3TFvRTjkSH5WCfdt4JsQz5kFQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706081858; c=relaxed/simple;
	bh=49EHGJo+BF0aAusaw6YV9QxMus+FF03TSQS/+RfWzT8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=jZViqLkkAcflWPUU09h1LuIYjHi3bZx0p/HUYtRSLG+IggOjSnkZT4XSTCAoA2KqP837ggdhsLqLofv8U98rni6p4s3VmdSKjDzL2ruh/vsHGAE59D1wB8vuO76QXBD1+mDXBTWPQRv/5JasxWDhoas74wnS4Oj6Ql58Het+n9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=f6n0ox3Y; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-1d76943baafso16005245ad.2
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jan 2024 23:37:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706081856; x=1706686656; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=l7zLlm6d5CA8X7mFvOVBpegHqSNqfCtqpbevUvsC+dc=;
        b=f6n0ox3Ye0bBgUyud1D+I8nRBT87hhyONbKULfaA4t8eZmWEFrNQAN6cvBTY8+n6Tq
         IpAeQh7Wrp36z9hBRUGBdcE4ULSBGkW+ujYpwGiIlZirJXmB22ASUHVPKlfcXpVyC/Bj
         TFQXrOYSIwPJH9wvnic5gPzA+CNByEWwIDqPxQQQbSFw9v89djL8RqKuknL2l5JiBbVg
         CeYcC8aw/YnLbRTO5cLlRCB2WZCJL8wXEB6NTptyTppXaxL2Wc2jiqrHSxsqI2S+SC+L
         xmtehyDS/o/DC7SFwE1MFgVlVkV3Njanl2TjX9sGjX5elH9dWXJEuk+x9d+xShqo8Vm/
         jcsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706081856; x=1706686656;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=l7zLlm6d5CA8X7mFvOVBpegHqSNqfCtqpbevUvsC+dc=;
        b=rsKsI/bDBIp1nkz7L8MQQfhhIT5BZ+5IkxQ/0Hp0cKK9qYPJus8RAZxfy6qrsSM8G/
         13+RiMlh07ggD6HWpJb0NZJ7K1ozCaljj55dmxkYpdDFME1LB+Fw5K0tyqrtNPYYnhcT
         6CIcqQcO9YtITkOk723j7rEQjq/ygH9R7zkVpRwqIqPTfBBLIca30grQqvhULB7472n9
         jLphpgYUtf/4OCRks33fh9mBfPRiRbA3296qXL2IXMECQDk6o/uG+lmYVNiFua9pu+29
         Jiv/nUPASaRZtYFwuHggiELSwzOP9XdkYXGFoUbSdtMhJGqDbn+iVQyj9PJvSZNvtrSv
         vk8g==
X-Gm-Message-State: AOJu0YzhH0r8wDxDmrxNH2th1Q2tvEIiJJWrVTED+oPJSvtDIBRz4pwl
	Lhj1yLPgggY2n2mD0B05cuP80GmRsDorhKIf2nrPc9dYjZAQj/Yk/ftFo8uA4CA7e8MDeu+ZtaQ
	=
X-Google-Smtp-Source: AGHT+IHlsAL4NqkYacbzZuLMy3cYbkj5DCyJUwh+SajhTTNjeDpitNlfwHG4VfJa42WgZplyNBAqSw==
X-Received: by 2002:a17:903:11cc:b0:1d7:46a2:9383 with SMTP id q12-20020a17090311cc00b001d746a29383mr326721plh.33.1706081856061;
        Tue, 23 Jan 2024 23:37:36 -0800 (PST)
Received: from [127.0.1.1] ([117.217.189.109])
        by smtp.gmail.com with ESMTPSA id t3-20020a170902b20300b001d726d9f591sm7386982plr.196.2024.01.23.23.37.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jan 2024 23:37:35 -0800 (PST)
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Date: Wed, 24 Jan 2024 13:06:38 +0530
Subject: [PATCH 10/14] arm64: dts: qcom: sm8350: Drop PCIE_AUX_CLK from
 pcie_phy nodes
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240124-pcie-aux-clk-fix-v1-10-d8a4852b6ba6@linaro.org>
References: <20240124-pcie-aux-clk-fix-v1-0-d8a4852b6ba6@linaro.org>
In-Reply-To: <20240124-pcie-aux-clk-fix-v1-0-d8a4852b6ba6@linaro.org>
To: Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konrad.dybcio@linaro.org>, Vinod Koul <vkoul@kernel.org>, 
 Kishon Vijay Abraham I <kishon@kernel.org>, 
 Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, cros-qcom-dts-watchers@chromium.org
Cc: linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=openpgp-sha256; l=1736;
 i=manivannan.sadhasivam@linaro.org; h=from:subject:message-id;
 bh=49EHGJo+BF0aAusaw6YV9QxMus+FF03TSQS/+RfWzT8=;
 b=owEBbQGS/pANAwAKAVWfEeb+kc71AcsmYgBlsL4EBMA0JPQ+taWm5D5iCJHV6WyXEqHPIoZZD
 U6GiyBn8wSJATMEAAEKAB0WIQRnpUMqgUjL2KRYJ5dVnxHm/pHO9QUCZbC+BAAKCRBVnxHm/pHO
 9Tf9B/wNcnSzONZ35yT0CY2kXhWYHcTu/lh+g6/zyMICDLDyuUoIMb84lVoC1rzB15CMmHG5HYL
 uc14OFvnZFRmLblaowYZ/f5Gc/MX1XdfLaBrkYtj5V4xNaBjlT3cOdSRxXbtW8dda2fkIz2CJ48
 CcESQ81hAKgTLVk0h4dD0nAy/7E32DB/JFTlLbbe6CcTCpY4lBw/o3JSZuA+5xqXgJMGl2SkwM8
 1IJb0QfcO1jIR2kcVwtinNom162H83LDvSZhcvgCf0WQlH802OzK6Mv+nDTLUUEPlvNrMRgul5z
 VFa01hCGZD73rM3RkRBHO3v8SvvcXVIl/u4NTdYV5umIymGM
X-Developer-Key: i=manivannan.sadhasivam@linaro.org; a=openpgp;
 fpr=C668AEC3C3188E4C611465E7488550E901166008

PCIe PHY hw doesn't require PCIE_AUX_CLK for functioning. This clock is
only required by the PCIe controller. Hence drop it from pcie_phy nodes.

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 arch/arm64/boot/dts/qcom/sm8350.dtsi | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sm8350.dtsi b/arch/arm64/boot/dts/qcom/sm8350.dtsi
index e78c83a897c2..23a9060f21d9 100644
--- a/arch/arm64/boot/dts/qcom/sm8350.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8350.dtsi
@@ -1571,12 +1571,11 @@ pcie0: pcie@1c00000 {
 		pcie0_phy: phy@1c06000 {
 			compatible = "qcom,sm8350-qmp-gen3x1-pcie-phy";
 			reg = <0 0x01c06000 0 0x2000>;
-			clocks = <&gcc GCC_PCIE_0_AUX_CLK>,
-				 <&gcc GCC_PCIE_0_CFG_AHB_CLK>,
+			clocks = <&gcc GCC_PCIE_0_CFG_AHB_CLK>,
 				 <&gcc GCC_PCIE_0_CLKREF_EN>,
 				 <&gcc GCC_PCIE0_PHY_RCHNG_CLK>,
 				 <&gcc GCC_PCIE_0_PIPE_CLK>;
-			clock-names = "aux", "cfg_ahb", "ref", "rchng", "pipe";
+			clock-names = "cfg_ahb", "ref", "rchng", "pipe";
 
 			resets = <&gcc GCC_PCIE_0_PHY_BCR>;
 			reset-names = "phy";
@@ -1654,12 +1653,11 @@ pcie1: pcie@1c08000 {
 		pcie1_phy: phy@1c0e000 {
 			compatible = "qcom,sm8350-qmp-gen3x2-pcie-phy";
 			reg = <0 0x01c0e000 0 0x2000>;
-			clocks = <&gcc GCC_PCIE_1_AUX_CLK>,
-				 <&gcc GCC_PCIE_1_CFG_AHB_CLK>,
+			clocks = <&gcc GCC_PCIE_1_CFG_AHB_CLK>,
 				 <&gcc GCC_PCIE_1_CLKREF_EN>,
 				 <&gcc GCC_PCIE1_PHY_RCHNG_CLK>,
 				 <&gcc GCC_PCIE_1_PIPE_CLK>;
-			clock-names = "aux", "cfg_ahb", "ref", "rchng", "pipe";
+			clock-names = "cfg_ahb", "ref", "rchng", "pipe";
 
 			resets = <&gcc GCC_PCIE_1_PHY_BCR>;
 			reset-names = "phy";

-- 
2.25.1


