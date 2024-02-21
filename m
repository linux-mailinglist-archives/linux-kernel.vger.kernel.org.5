Return-Path: <linux-kernel+bounces-74023-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C1DA585CEFC
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 04:46:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F3EC91C222B0
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 03:46:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF3CF3D3A8;
	Wed, 21 Feb 2024 03:42:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="bBXzc6QF"
Received: from mail-oo1-f48.google.com (mail-oo1-f48.google.com [209.85.161.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F8C33D0D0
	for <linux-kernel@vger.kernel.org>; Wed, 21 Feb 2024 03:42:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708486960; cv=none; b=BKVeiPDJbmTXgraUO//2SqOMdN5MKpvHIiDMGkiiI9PSevWXXrzCFCX9ewjv9R7qFUhk37rKkwz5KJtkNb1AOFwsD2YX0xw5/fSxTenHZYuUAMzA3V0mb3XPEwct1jiK+kshhZdn7SzsZwCWHutXyuLZlKBl5uxriQsZeWXre9Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708486960; c=relaxed/simple;
	bh=2Q/c7cqWrxsgCvrUBqcb1kHsDO6XcH9wkH7M5swouBc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=XlLY9GbBPz/nLFfvfvzm0MT+55aVpJV6yyaxgfumzIbu6mOR0M/X83DQESqAdDH8nXJ4Se+BPlZzhj0U2sDqc5JrhUhpT9Wr6pMGVn9QgKirvuul2EAfNihQrpjFMWF4fF4jmv7bqeRtJ6QhBZ9BjOW6TqBpNtl+HfCSI3GPmx4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=bBXzc6QF; arc=none smtp.client-ip=209.85.161.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-oo1-f48.google.com with SMTP id 006d021491bc7-59ffbff2841so666127eaf.2
        for <linux-kernel@vger.kernel.org>; Tue, 20 Feb 2024 19:42:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1708486957; x=1709091757; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gdJpMsEJXCfnbuJdfeEgIk0A3Aka66MaEAybndFuIgY=;
        b=bBXzc6QFTxJPELxIoVsqx95KDgW/Ea25MboIoGBnEb+S0Sq36SMQTNTy74Pe9rxkzj
         YB8CLutnctI+JMzvKNRgNnsmhcf/W1e3JYQdQy0gw+5Cpgb0FRrCyTjypu2yVOVGpuxT
         SA95mw5RCue9uXx+7ApXufew/BBaJHeBkykrkp51JuF67nS5rbGG8vnXWE3QgiECxC2+
         oeTjSvGXjnZnBNc6pIB7BEmjrJx3S+jj7Dr1kmH8wTJ1RDxVqAU5GZuxs+v2728pKW7a
         edGIeQ717HeCfNWW79ZQlxGs1+lGGkeqLr+W3pYKZcTKShAAw3B1f6bpDJ88vB9RO7z0
         OAkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708486957; x=1709091757;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gdJpMsEJXCfnbuJdfeEgIk0A3Aka66MaEAybndFuIgY=;
        b=rrDZqPggdMvCmTKnnOzNXLIOcEmZhwdsaovHIFGWPLDGbarWyRNMWRqfys9xC/J3dZ
         F2xkuwht1RYc1BMI60ozqhpri8+94FtXgFE6nevbUkxxeHCOj0xyKhXWDzGT9ZEkjzqY
         JNbwBdD13l33I4Qtm6nkbFz/e+qK3q1SpOlWfuotPUF/UoltSUkkV13Az3cr2xGkZX8g
         Lup8T4nzyr2VBYXubDzsCnUU1tx8oL/UE8KR8PjkPEs2tfwktColtdItKUWn2IXkqdY9
         yMWrVi/QNcXNzzlAlJXHAts/sjT0+fzOALOxNrD/b4HS5vct21oDKlDADN3h6Kl8FEcK
         aadg==
X-Forwarded-Encrypted: i=1; AJvYcCVqUx0SzGvVAKWGtgFFmoEGIqpIXCk1Mbn7x5ZE+Ywn7Xcjl8FpkC9E76Ft0B+fxU4+6uhQP0z/jRy9DmJBou1lb0v+Rwik4jqFCUIj
X-Gm-Message-State: AOJu0Yxlp2pe2ZNw1hLxZJxqUr70NZTDa/hw+M/ICOR4A/GwVMUQBUWw
	F8ldBltkxZZvycMYm577iKogiEWRXfB2b8mhDhnFfIFXLjEfUsj+5xeXuESeFMSnnzIo1vOXV74
	=
X-Google-Smtp-Source: AGHT+IHBsEMmKzRMGNztlIYHFtnKFfn4++Gsz0Ujp6913/iD8DkXORuxF96J2/09UtBpCGb8KxbMGg==
X-Received: by 2002:a05:6358:2913:b0:177:afce:b12 with SMTP id y19-20020a056358291300b00177afce0b12mr16822385rwb.31.1708486952514;
        Tue, 20 Feb 2024 19:42:32 -0800 (PST)
Received: from [127.0.1.1] ([117.207.28.224])
        by smtp.gmail.com with ESMTPSA id o23-20020a056a001b5700b006e466369645sm4436231pfv.132.2024.02.20.19.42.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Feb 2024 19:42:32 -0800 (PST)
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Date: Wed, 21 Feb 2024 09:11:53 +0530
Subject: [PATCH 07/21] arm64: dts: qcom: sm8650: Add PCIe bridge node
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240221-pcie-qcom-bridge-dts-v1-7-6c6df0f9450d@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1286;
 i=manivannan.sadhasivam@linaro.org; h=from:subject:message-id;
 bh=2Q/c7cqWrxsgCvrUBqcb1kHsDO6XcH9wkH7M5swouBc=;
 b=owEBbQGS/pANAwAKAVWfEeb+kc71AcsmYgBl1XEG3L/MMQLUUU5YiEPeYWXMJ3zBIYu2KPjm4
 u+aES6erhyJATMEAAEKAB0WIQRnpUMqgUjL2KRYJ5dVnxHm/pHO9QUCZdVxBgAKCRBVnxHm/pHO
 9U2QB/kBs6laNU7JRlhgMKm6ASX0OS6MYaQvS2tL1rajvK8SCI69MfZTsB80Q8ODw/yvJz4cMoB
 NCZN+LPTealKSn8cdF7Jdj2Pw5PVTpMPGZdhNoR3qKAWYYKrHZZ80qVW9yBYfyryS1uiSd/pPRb
 8ivwqpEEWugE/H4tUbYYY11Z232YEuuCHE2KlGRUPST1rv3BBp0CAMWfkyACBuX/ked5WvqNa7i
 EcJt3noB63jTK4wKTeFUEi0ReVpHZhytL7eLBolR+ezbyGIWMFNdiqbu+o7i8+G+ssissRac5w4
 9EJmUIOIlinZT7iRQQbWIH/Iu9FVIfulRzxlOiLnanrIXick
X-Developer-Key: i=manivannan.sadhasivam@linaro.org; a=openpgp;
 fpr=C668AEC3C3188E4C611465E7488550E901166008

On Qcom SoCs, the PCIe host bridge is connected to a single PCIe bridge
for each controller instance. Hence, add a node to represent the bridge.

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 arch/arm64/boot/dts/qcom/sm8650.dtsi | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sm8650.dtsi b/arch/arm64/boot/dts/qcom/sm8650.dtsi
index 2df77123a8c7..57a1ea84aa59 100644
--- a/arch/arm64/boot/dts/qcom/sm8650.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8650.dtsi
@@ -2270,6 +2270,16 @@ &mc_virt SLAVE_EBI1 QCOM_ICC_TAG_ALWAYS>,
 			dma-coherent;
 
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
@@ -2379,6 +2389,16 @@ &mc_virt SLAVE_EBI1 QCOM_ICC_TAG_ALWAYS>,
 				 <0x02000000 0 0x40300000 0 0x40300000 0 0x1fd00000>;
 
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


