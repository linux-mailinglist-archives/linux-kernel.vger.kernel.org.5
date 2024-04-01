Return-Path: <linux-kernel+bounces-126902-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EC8A894431
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 19:22:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F1D991F23079
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 17:22:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0981F4E1CE;
	Mon,  1 Apr 2024 17:22:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NkX4Zgi5"
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AEB14CDF9;
	Mon,  1 Apr 2024 17:22:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711992124; cv=none; b=qGCj79nF0RivD+ijl2YkkD5+GgX62NTRUGTi0Txa4j4aYgkVrkRIywu7PpZD5+sljYho8p+jA+aDnaepyyJaSM7BLrmfZl/ot1FLixf2LRL47ex5C8HuHyjuS3Co5PMLxm8psto4+IWpe+Pu7ldT4EPaaPrenEN13L+haGr9r6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711992124; c=relaxed/simple;
	bh=9pkXLlIZF374osaBV+eI1C7R/HMu//q75xIYUjjHffg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=r2j8j3nnwRYu0G6gCzb0oWIKvwYePlD9cDr4X37YppW0kpmhyU3jidqPHpSXP3qsLHDnIp7Vkyc6MYB9jB/xde+AE2kwaIQfrQske9DNZymKXn0BBtBtnkDX1RLpAaTEb7avioBRYmSOcO0LsQlycJcnyT+mxC05DpUeVNaYek8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NkX4Zgi5; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-56ca3e11006so2264830a12.3;
        Mon, 01 Apr 2024 10:22:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711992120; x=1712596920; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6fFoNwrz7Z2PTKzKuXP+UfswKZFc2fljpsBuXAAeuEI=;
        b=NkX4Zgi5H8z+sJPPdRdVCyK/fG1WLgT7DdzhXF4nNaiKbSeSXEmRg9st3FGS+z12dJ
         kwuJSyvFHsVK03enw2Xc/IW7yoCbLGszAV94mYwoEVaR3mCUl05LH20OxAk1hr/ty7Om
         kBwfeuaYhvK4jQUS9vMjUICi9dVORM57V2TtReslD4yyiJweR/VE4VNVsQp7utaQBbq4
         hhhZdlUhNfhuVhdpphOXeth7F1oyuBDlupluccSwGUN3BZcQQyJ9X/uz4ortLw8jchnP
         sqXJTgvIyoMp/SMRcv9/wpDQNsQELEN3bl7A25zwyCURAn2wwSFvNNMVF/l4NMvnBdX0
         V2OA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711992120; x=1712596920;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6fFoNwrz7Z2PTKzKuXP+UfswKZFc2fljpsBuXAAeuEI=;
        b=P6Ay+s7WTGAaBN0N0k2W7TNt4CFEMPeCl5+jJHPG+K3UqBlaIHwPJ2+7jj0Dr1nRlR
         lceJNkRhJT7CKQ4kSqq72BSNMwNQS+b0jK0uAl1F3U8v8ArhrgXuiCc1xAOuRqIExibE
         pYu9R3wk2KJYdFWMMpMrlVTsfBh9waF7cLKjvOSIl8APtgsMojstZJgDInvZWi6qXfWT
         n+PqlSIz00b+Q8Dw6WGTdlsNDPPXNl/uWraNWpFMS1T0xIMTP4cdlyZqA7Y+1NoNdahj
         CZTH1vIrsybWKFqtXUxXWsFsf+U91X0aGjCzMTdpCZI8a1I8L7KnyQ6Q753NYH+BuhqL
         URxQ==
X-Forwarded-Encrypted: i=1; AJvYcCXxUxU8BJtqEPVv2eVMxPdIGNe5cfYZOkIlBV+3o5zj7hjlgnKrbVQyhzVQSawPthuEM8LEjz35barXetQCOYnufKiini+0Ekdwnbyzg0Z3iNRNhFNWTgpYVk6yDHh3YZPzDzPFO0te5ehEVJU+vElJKYc+T9B+ehm93t0lN4CNFzdHl9KgDR4=
X-Gm-Message-State: AOJu0YzTrf6KYL3gUcvH/6tOBOndS9fKpRenabSqwlm7zMJ4rgXt0j7Y
	Y3SxIrMaz2rxG4KEXiWHP4vf5boLc4QvecLfJeipT9PtdWGQCjTScaY1kySpbXo=
X-Google-Smtp-Source: AGHT+IE4/VG0B5HoTCKmvqLWYLnVT8FpSlPmSR5QEOjh2WrU/JieThc0k2yE0m2DF5xwILNzl2mMDg==
X-Received: by 2002:a17:907:9445:b0:a4e:5540:7c0c with SMTP id dl5-20020a170907944500b00a4e55407c0cmr4420351ejc.70.1711992119948;
        Mon, 01 Apr 2024 10:21:59 -0700 (PDT)
Received: from localhost.localdomain (ccu40.neoplus.adsl.tpnet.pl. [83.30.144.40])
        by smtp.gmail.com with ESMTPSA id xi7-20020a170906dac700b00a4e23486a5dsm5347949ejb.20.2024.04.01.10.21.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Apr 2024 10:21:59 -0700 (PDT)
From: Adam Skladowski <a39.skl@gmail.com>
To: 
Cc: phone-devel@vger.kernel.org,
	~postmarketos/upstreaming@lists.sr.ht,
	Adam Skladowski <a39.skl@gmail.com>,
	Andy Gross <agross@kernel.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	linux-arm-msm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/4] arm64: dts: qcom: msm8976: Add IOMMU nodes
Date: Mon,  1 Apr 2024 19:21:50 +0200
Message-Id: <20240401172153.9231-2-a39.skl@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240401172153.9231-1-a39.skl@gmail.com>
References: <20240401172153.9231-1-a39.skl@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add the nodes describing the apps and gpu iommu and its context banks
that are found on msm8976 SoCs.

Signed-off-by: Adam Skladowski <a39.skl@gmail.com>
---
 arch/arm64/boot/dts/qcom/msm8976.dtsi | 81 +++++++++++++++++++++++++++
 1 file changed, 81 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/msm8976.dtsi b/arch/arm64/boot/dts/qcom/msm8976.dtsi
index d2bb1ada361a..8bdcc1438177 100644
--- a/arch/arm64/boot/dts/qcom/msm8976.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8976.dtsi
@@ -808,6 +808,87 @@ tcsr: syscon@1937000 {
 			reg = <0x01937000 0x30000>;
 		};
 
+		apps_iommu: iommu@1ee0000 {
+			compatible = "qcom,msm8976-iommu", "qcom,msm-iommu-v2";
+			reg = <0x01ee0000 0x3000>;
+			ranges  = <0 0x01e20000 0x20000>;
+
+			clocks = <&gcc GCC_SMMU_CFG_CLK>,
+				 <&gcc GCC_APSS_TCU_CLK>;
+			clock-names = "iface", "bus";
+
+			qcom,iommu-secure-id = <17>;
+
+			#address-cells = <1>;
+			#size-cells = <1>;
+			#iommu-cells = <1>;
+
+			/* VFE */
+			iommu-ctx@15000 {
+				compatible = "qcom,msm-iommu-v2-ns";
+				reg = <0x15000 0x1000>;
+				qcom,ctx-asid = <20>;
+				interrupts = <GIC_SPI 113 IRQ_TYPE_LEVEL_HIGH>;
+			};
+
+			/* VENUS NS */
+			iommu-ctx@16000 {
+				compatible = "qcom,msm-iommu-v2-ns";
+				reg = <0x16000 0x1000>;
+				qcom,ctx-asid = <21>;
+				interrupts = <GIC_SPI 114 IRQ_TYPE_LEVEL_HIGH>;
+			};
+
+			/* MDP0 */
+			iommu-ctx@17000 {
+				compatible = "qcom,msm-iommu-v2-ns";
+				reg = <0x17000 0x1000>;
+				qcom,ctx-asid = <22>;
+				interrupts = <GIC_SPI 115 IRQ_TYPE_LEVEL_HIGH>;
+			};
+		};
+
+		gpu_iommu: iommu@1f08000 {
+			compatible = "qcom,msm8976-iommu", "qcom,msm-iommu-v2";
+			ranges = <0 0x01f08000 0x8000>;
+
+			clocks = <&gcc GCC_SMMU_CFG_CLK>,
+				 <&gcc GCC_GFX3D_TCU_CLK>;
+			clock-names = "iface", "bus";
+
+			power-domains = <&gcc OXILI_CX_GDSC>;
+
+			qcom,iommu-secure-id = <18>;
+
+			#address-cells = <1>;
+			#size-cells = <1>;
+			#iommu-cells = <1>;
+
+			/* gfx3d user */
+			iommu-ctx@0 {
+				compatible = "qcom,msm-iommu-v2-ns";
+				reg = <0x0 0x1000>;
+				qcom,ctx-asid = <0>;
+				interrupts = <GIC_SPI 240 IRQ_TYPE_LEVEL_HIGH>;
+			};
+
+			/* gfx3d secure */
+			iommu-ctx@1000 {
+				compatible = "qcom,msm-iommu-v2-sec";
+				reg = <0x1000 0x1000>;
+				qcom,ctx-asid = <2>;
+				interrupts = <GIC_SPI 241 IRQ_TYPE_LEVEL_HIGH>;
+			};
+
+			/* gfx3d priv */
+			iommu-ctx@2000 {
+				compatible = "qcom,msm-iommu-v2-sec";
+				reg = <0x2000 0x1000>;
+				qcom,ctx-asid = <1>;
+				interrupts = <GIC_SPI 242 IRQ_TYPE_LEVEL_HIGH>;
+			};
+		};
+
 		spmi_bus: spmi@200f000 {
 			compatible = "qcom,spmi-pmic-arb";
 			reg = <0x0200f000 0x1000>,
-- 
2.44.0


