Return-Path: <linux-kernel+bounces-74032-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E38685CF17
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 04:49:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9E6D7B240C8
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 03:48:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52AC33A1A8;
	Wed, 21 Feb 2024 03:43:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="EgfhxhlJ"
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C26DA3F9EB
	for <linux-kernel@vger.kernel.org>; Wed, 21 Feb 2024 03:43:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708486990; cv=none; b=o627A6+i2k50nXZ3vr+QHv25N4QsFcf6IAZ+q+9jACAzeZrFfPbn/bzce0AyNzUi5R6KiTR0VfVfXYEiEdahtG8hsi5lC7qsEcCJwHP3r0YZZRCnm0Hqrw7KMcniakSDDPa/vhCcXNx2ptuJUrno/z32Sn3Nrhm/zY97diPW8A0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708486990; c=relaxed/simple;
	bh=WgAHSHEBS+WPHpzKCuKbWd6zQ7JQttxC3Rezz4uCsKo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=QClH0fshNqB3G0KaTdqjc5ZNobuFRv0LHUxEPR54V6w8S+9dlHKLBHZq/3Ik+aj2bqlwDw9dnsLrRw1jgcTG5NVWjL5it9R94uAnCBGSPW6THBBlvqCUh5Pbp83BWBFwY1Z55R56RXNqB+e7kmV45Np3fmJDw8qjL73S47JLKKY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=EgfhxhlJ; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-6e46e07ff07so1738161b3a.3
        for <linux-kernel@vger.kernel.org>; Tue, 20 Feb 2024 19:43:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1708486987; x=1709091787; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jqTTWkO7wb0/aHORfRcfU1fgshn4zr5mjp3j8EXBQlM=;
        b=EgfhxhlJu70FtX+lSLtNHPrbkJEJqz2U89cEe4R8VGGVwaDtcrhNpF4ID3G5lJo0rn
         4wwePCtMV89tXYtig0zmUAAl7FlrHurYdxZU75eaj1/gteRNTYp/9NvywmgPr2gnosUP
         wDTpfhdF+Rmf9EoEMtD9F+CzukZn3JkcM+YKGcNHpWTlwohdAXGaTgs0np0v+6tMopdQ
         0v39jaBV1OZw5HFAKhXP10euMqso8DErjRcp9Ev7bdEoN56nWBYlUqrM6A1Bc2Vuu7tu
         7GYi940ebvVwMnGyl2wicL/hX7aL5Zyihqow1XC9wU98RZEf4CIANT5Njnzdjl1NTYkV
         JGRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708486987; x=1709091787;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jqTTWkO7wb0/aHORfRcfU1fgshn4zr5mjp3j8EXBQlM=;
        b=ru620dJ9uB0Lk1+vhkUv6Cm4g/D4Mlx8+kFoPWZDMrgJlKXKBCUseUoThnymAYuu7x
         +WgP9l3cFe1UyU9CNcFvM9+scrR3iMzzqsJvNegPomNcl+5+vEpurTpATJ41nV8OXHeH
         Sa4JuP5C2oV/N8PxN8IkLe0QR+8aDwXdX8aDJdDyzLFIe0OLyQmEHwxMgG/5b1I84hNn
         noJIwmZLPLoHPmJhXnVVRJmCLbdItDiujzcsbV2QHTToMCfh8TDlnqbCGpDNTyIEkP6Z
         YHZZuK8v0HuSEczuvv7tbJawyGG4CmrCHhWh1M0tkxzpjfalvX3Kp+zvfFZkXw4lJAeQ
         ItDg==
X-Forwarded-Encrypted: i=1; AJvYcCXGy8kaNnmpJzkSFHT48XldMssRcagYh86yS1YvcQ9N74GACU/uh5TZJjxACDzoW/X5JNRyUteemBWxs9xZm4KCIlBqzMqEOExe2xjg
X-Gm-Message-State: AOJu0YwovRyUyr2LaTapukk1k06/A0zqDUbrXjtc8MrTEVBCFE0tnOxR
	eBTtBaa+a3beqjGYKSjDJ1O1tSCoCWVXRAnFh75wN/fti1U4tDXQxrG1xQHGWWKsPGqUlz4QGDA
	=
X-Google-Smtp-Source: AGHT+IE3shMOMlafFIGY6Q+VTfpMTFzlivckWMpFfeWH+Xc+MBvOj/M7a3gdfP0EHK9PcBrj3lvgnw==
X-Received: by 2002:aa7:8a03:0:b0:6e4:62ff:d74 with SMTP id m3-20020aa78a03000000b006e462ff0d74mr7427870pfa.3.1708486987166;
        Tue, 20 Feb 2024 19:43:07 -0800 (PST)
Received: from [127.0.1.1] ([117.207.28.224])
        by smtp.gmail.com with ESMTPSA id o23-20020a056a001b5700b006e466369645sm4436231pfv.132.2024.02.20.19.43.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Feb 2024 19:43:06 -0800 (PST)
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Date: Wed, 21 Feb 2024 09:12:03 +0530
Subject: [PATCH 17/21] ARM: dts: qcom: ipq8064: Add PCIe bridge node
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240221-pcie-qcom-bridge-dts-v1-17-6c6df0f9450d@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1664;
 i=manivannan.sadhasivam@linaro.org; h=from:subject:message-id;
 bh=WgAHSHEBS+WPHpzKCuKbWd6zQ7JQttxC3Rezz4uCsKo=;
 b=owEBbQGS/pANAwAKAVWfEeb+kc71AcsmYgBl1XEJ3hJUl2zeUGvykR59nE7EJUol1/NGPC+WF
 qpk+24wV9WJATMEAAEKAB0WIQRnpUMqgUjL2KRYJ5dVnxHm/pHO9QUCZdVxCQAKCRBVnxHm/pHO
 9aaSB/9uagosTtJLUmQD1vD4GU8InYag5R/MDKqz1MNyJAtIYsO9vNh7H9UkBSnTirnVS+mFi4M
 mukfdXM4atkpzvkPQzWEnqn/d/EfIVOPHhmALeHVPWFRUOVKGOag3zRv6IjdovifRPIC0PDeA7E
 6b4+KGzsLhEWj8LgjnS/B68YJoGSbmI0zOY9DDZNuWrWKkq2kYXS/vPwEwI+xic06apHLu9wS7L
 7TFp1qRQLdL6VBAF+veOJm4XG1WTKV2NkHG2koWRlKrrcq3b2AWqQTBkDrww5ZV8T2haveMKPT7
 sUJHn8vNZ4ZcshIFaJ32Li29f+G7J9J1lw6bwv9zAOs+cnlO
X-Developer-Key: i=manivannan.sadhasivam@linaro.org; a=openpgp;
 fpr=C668AEC3C3188E4C611465E7488550E901166008

On Qcom SoCs, the PCIe host bridge is connected to a single PCIe bridge
for each controller instance. Hence, add a node to represent the bridge.

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 arch/arm/boot/dts/qcom/qcom-ipq8064.dtsi | 30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/arch/arm/boot/dts/qcom/qcom-ipq8064.dtsi b/arch/arm/boot/dts/qcom/qcom-ipq8064.dtsi
index 6a7f4dd0f775..98448ea6ffca 100644
--- a/arch/arm/boot/dts/qcom/qcom-ipq8064.dtsi
+++ b/arch/arm/boot/dts/qcom/qcom-ipq8064.dtsi
@@ -1125,6 +1125,16 @@ pcie0: pcie@1b500000 {
 
 			status = "disabled";
 			perst-gpios = <&qcom_pinmux 3 GPIO_ACTIVE_LOW>;
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
 
 		pcie1: pcie@1b700000 {
@@ -1176,6 +1186,16 @@ pcie1: pcie@1b700000 {
 
 			status = "disabled";
 			perst-gpios = <&qcom_pinmux 48 GPIO_ACTIVE_LOW>;
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
 
 		pcie2: pcie@1b900000 {
@@ -1227,6 +1247,16 @@ pcie2: pcie@1b900000 {
 
 			status = "disabled";
 			perst-gpios = <&qcom_pinmux 63 GPIO_ACTIVE_LOW>;
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
 
 		qsgmii_csr: syscon@1bb00000 {

-- 
2.25.1


