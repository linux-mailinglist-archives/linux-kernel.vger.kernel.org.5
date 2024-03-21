Return-Path: <linux-kernel+bounces-109952-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F09A3885829
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 12:22:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 91B3B1F21A46
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 11:22:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C1DB58228;
	Thu, 21 Mar 2024 11:22:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="LOz98dEX"
Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0C2057303
	for <linux-kernel@vger.kernel.org>; Thu, 21 Mar 2024 11:22:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711020141; cv=none; b=TQw3HAA6U5pz8fCIMKMKb1QGZFsdDntyvD0zES3M5YbX4Sn1Dth3PazQEMwd/vT1K7IyHyL0FGB4C1bFG2mTJ7Ny1Z6fr/LVbW7t/ofeN8/eJmu6Zjh42udeWsqF5/V8GVnYrclQxKyz9/kROoS2JX6Jso4AeWEv6b8KK2E5juE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711020141; c=relaxed/simple;
	bh=JSxYNSwZyUXf+sG/uNBnaGpYsgIXqQ6uEzUtMXC11Fc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ah7D8jhaPj+dOQIvw/EajN8zjpymqH7VRAsu3030amlTfI9h3aA2iooDddqxQA6Wyp96NNIJ9n2v7HhRp08DvnN7FyuSiwAu7v0LaZ5i0NkFn9gE/ZtipZboPbYVwXt2Dqw7cHb2dcbrIVUlBabv8YsueGbccXI+LRf1H1kOiYU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=LOz98dEX; arc=none smtp.client-ip=209.85.128.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-60a068e26d8so9729867b3.3
        for <linux-kernel@vger.kernel.org>; Thu, 21 Mar 2024 04:22:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1711020139; x=1711624939; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/DFL0n6uM1RWjK/gTquIUFnPYTmGA9Q/FVUWQCJfJOM=;
        b=LOz98dEXsZlgNzH6xIisuMIrQ18vI2AeNgUgt+2ClAaykAnzURceJZP797ajQRCpAz
         J91D4N9VJLV5gsuj5HXJal9QgApD7cQWutuZjooWj6X+MGxcxrQE9aFMdalbHCQJ5ob2
         JbXW8YfaLWXCQ/1HZkuVTtS9XQsB+7qCeOi4BKC9syfsvnkI3RhKvdsbEP1sy6bqKwlW
         fjnv7+d2DzWbuAkEHLejWHB8W6aYh8cdtqhGdtirjv+glRocHeTV90722C+k1a3CepuY
         6rci/mzWQWQFtq18iVyvQloCPUb+6oiHIqKMXPI1RieWerESaOOj1saBvo9EEdZqsbX8
         /ruQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711020139; x=1711624939;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/DFL0n6uM1RWjK/gTquIUFnPYTmGA9Q/FVUWQCJfJOM=;
        b=fj1yGJrsGBjueFanWR3htXuVU25ZF5ijkeNoBz9NlF+2m3hikrxq/6cWekh1+qfcGX
         mm+DR23bmthh42siPdNMXXra7F575E8KKXMLCdmjHJNOQepxVMWkmbRaxE1RTbbUWuBq
         UiNwuEfnnzzPyujSEu5bMfSV6jzTcNlR9/8EjLM47l9nCRZrYTY+RlJAIZZF1XnwYrvm
         Md4NOfdKlALxBeaK6M+8vSq8d3tk40h8U6w3okYwX3fyjLMQl8fdfkjkW8z12cocLD5c
         tZlr0IZb7jEkKPBFJNfK0JeISVmt6jRvNgFJ7N//sBkjSkAtXZjo/MHe5VEEZL23XsT8
         IqAg==
X-Forwarded-Encrypted: i=1; AJvYcCVAfSXCJxpWERPXRAXPOf/0CLam58L9bQhCrnPIFMRvtFIOeS9oJR23HBmBt9i9fBXGiiPUYi5ozwCnl72/p/dseK8r3NynPR2/3dvj
X-Gm-Message-State: AOJu0YyDvyJ2EsozvPvfGCyPadT66WC4oQw/Ka9GNT3qdGXNrFwCVvCA
	SAKtzvBUEQeHDpr2MXihILmCsH+5aSS8dqWYrx2g5pTCJE5s+zGov22tRQEY4Z2K0MCBoWKG15s
	=
X-Google-Smtp-Source: AGHT+IFnnfnUYQZH5pd7/YUgsJ4wox7bRd256T69ILjci7PbIhxOrPZftFdDT+qvcZ8eiYXZxjtzTA==
X-Received: by 2002:a05:6a21:195:b0:1a3:6b62:397f with SMTP id le21-20020a056a21019500b001a36b62397fmr2076350pzb.15.1711019805043;
        Thu, 21 Mar 2024 04:16:45 -0700 (PDT)
Received: from [127.0.1.1] ([2409:40f4:102b:a64b:d832:a82a:837c:6d3])
        by smtp.gmail.com with ESMTPSA id ka6-20020a056a00938600b006e7324d32bbsm5531120pfb.122.2024.03.21.04.16.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Mar 2024 04:16:44 -0700 (PDT)
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Date: Thu, 21 Mar 2024 16:46:22 +0530
Subject: [PATCH v2 02/21] arm64: dts: qcom: sdm845: Add PCIe bridge node
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240321-pcie-qcom-bridge-dts-v2-2-1eb790c53e43@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1223;
 i=manivannan.sadhasivam@linaro.org; h=from:subject:message-id;
 bh=JSxYNSwZyUXf+sG/uNBnaGpYsgIXqQ6uEzUtMXC11Fc=;
 b=owEBbQGS/pANAwAKAVWfEeb+kc71AcsmYgBl/BcJALvhllgPxWyYG2RbYV7RcHMfPdLNxktb1
 PwME9FSf9SJATMEAAEKAB0WIQRnpUMqgUjL2KRYJ5dVnxHm/pHO9QUCZfwXCQAKCRBVnxHm/pHO
 9Vc3CACfh0cbDFSipSCFGPlbj1SXAbaBC9s/ON4t358aRPbZ/l2XqcKBJ7mW6TyzlOfsWfev+GS
 ijBvvd98iL3tr5hQAw5HWyRMR3iNZCF0VtnJl1aXwZyLoJygs+5T0zttLZ1BFP3hpr3wik5bsGE
 f3PgB2fWPArDoVnCOxD1oPOV1XCDLWUMvFr5EhyRjg/nQwz3M6+7wotJ7Y3Z2iduVFGUk9FF3ye
 7kpqVLQZxZ5mvBe5iBu5XO9lXv6S7eZX8dpRTYNtFvnSw6E4D2x2hSzK/ZHCc5EVStQPnBKlu7T
 3eVdwj5xjwok+wcwtNvpbYSim4884p711N6X555225OA3+Df
X-Developer-Key: i=manivannan.sadhasivam@linaro.org; a=openpgp;
 fpr=C668AEC3C3188E4C611465E7488550E901166008

On Qcom SoCs, the PCIe host bridge is connected to a single PCIe bridge
for each controller instance. Hence, add a node to represent the bridge.

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 arch/arm64/boot/dts/qcom/sdm845.dtsi | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sdm845.dtsi b/arch/arm64/boot/dts/qcom/sdm845.dtsi
index 2f20be99ee7e..10de2bd46ffc 100644
--- a/arch/arm64/boot/dts/qcom/sdm845.dtsi
+++ b/arch/arm64/boot/dts/qcom/sdm845.dtsi
@@ -2375,6 +2375,16 @@ pcie0: pcie@1c00000 {
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
 
 		pcie0_phy: phy@1c06000 {
@@ -2479,6 +2489,16 @@ pcie1: pcie@1c08000 {
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
 
 		pcie1_phy: phy@1c0a000 {

-- 
2.25.1


