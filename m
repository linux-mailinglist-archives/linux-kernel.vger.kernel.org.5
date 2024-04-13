Return-Path: <linux-kernel+bounces-143820-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C693C8A3DD5
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Apr 2024 19:03:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 53B391F21853
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Apr 2024 17:03:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5ACA524D0;
	Sat, 13 Apr 2024 17:03:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lj93eOnv"
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C86440BE7;
	Sat, 13 Apr 2024 17:03:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713027811; cv=none; b=smN7kaAdtzweOD9bttbVssfMVdaDB+8idUnMHng+6HQ7edNx6DRInh5b15aHBpThPjwdIU7vMYAOImPMLgxmUeKmDqBd8UZmUyHxVB2x4iGIyviyrDY3zaqcSjgPFBxXWgPA2fh6DQKaaLWwvWB/umdlEDZiy7N/Y5itJgiOMbs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713027811; c=relaxed/simple;
	bh=9pkXLlIZF374osaBV+eI1C7R/HMu//q75xIYUjjHffg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=FIO2AS4P6HrZV/s87up1zhKiaxS6iAy4WWvmJ4T5Om6jRuow8gh53Wf0utQgt390e6xnLLhGW8cLTL9cU+YAdfdP43NzhWcmxkZSJJDFeS95mtqRT/U83iisKssTw98XcQJB5GC6UNkqlWm1n0dCThBGT5bdJBlh+MZ2SNgnJfQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lj93eOnv; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-56e78970853so4471243a12.0;
        Sat, 13 Apr 2024 10:03:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713027807; x=1713632607; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6fFoNwrz7Z2PTKzKuXP+UfswKZFc2fljpsBuXAAeuEI=;
        b=lj93eOnvy94ceWGxcNpRSnkFDYPW6HQdxQrvhv8SuSpdmA1UHKtdNjZ8PpoqaDwm+2
         2m1KgqQ1sgQHQepMqIXLGUZqsxZMHqG6HMtm9JmmnlDiTddJCKcMJIPHPr7hQfnvil2r
         kuz6/9tuSoxZWxiSrhS/5UJ+z46A7SvDCx0MKaw4DQ3sPg9VkuaZW/KJHUSQNE7dkLNb
         TBK1dVYrGH7GharVxPRf8TIYDt9897jRdmfPh166O5EmVhsILkaxG4NNuzMzR098ZYoU
         w+ak2Yp/BRwhaIcGzyIA7Wfxerp4IU7B0T67V+EM8uQxBqsXiXq9AEHv/qKIWHwLG6SG
         yj9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713027807; x=1713632607;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6fFoNwrz7Z2PTKzKuXP+UfswKZFc2fljpsBuXAAeuEI=;
        b=ooBR8vqnDr/NP1xcfFNGr6T2tpmBY9UnS4J3yHn6dAj3rDp5CBbLwpWNmRq4IFIk7e
         Od3IrCjUlvK5e1ZlQtpjKyIlTzucvVF/wACQYTS0QPxYMS6ADy3fcoGW2zxLfAUq/IDk
         CFjxWaza+fMQgGrAYLyaRG1duDWOP+4rYoRSC6NUiRcHS6IfnMLrivlMDJy56YqDum/m
         5xDt+6nzw2XMMHRTNgp4K3dPNBfgMyesFff7znHkPpnu859alLH9zoxlM7HNIu5F1PWO
         62Fw5ZqaWbl2rUABJjxNb8qNtvRw/cKGUE/mo+J23piGsOoTB8URNmnpAVcLDaTYyZ76
         bANg==
X-Forwarded-Encrypted: i=1; AJvYcCWjyISgloh0k0kLp9lBMamrfZTx1ntCUIKh2a2AYwfCWnq9MlE2k9xQLCugeKTisp7F4Mtb99SFMrQ083zlz6E6H67l8y0I4DXdhHi4+FmnFfBz25CXU5PhVoHr9m2KBBiJHEPumqp3LvAkK6b98+LuwLHHSLl9jXfnZh24sQGNkRAA2dHTUtk=
X-Gm-Message-State: AOJu0Yx5Vb+VXo+V0mXyjO3JLYAh/ecjK5tdU9cgx82wNZrI2UgdkVPw
	/Rso+ok0K3YbPVvzKjIB7g6efRv/0cEnw4oECsm5/QZTFOzF2erPmsYnZw==
X-Google-Smtp-Source: AGHT+IHyH/OHAz0VH25NxBTjJ/zSD+y/aMVNJJZmwDCiXzfYS39Gc0ZLTQblGf135PDbpcAGv8ZOXA==
X-Received: by 2002:a17:907:720c:b0:a52:1e5a:3ec4 with SMTP id dr12-20020a170907720c00b00a521e5a3ec4mr7827000ejc.5.1713027807383;
        Sat, 13 Apr 2024 10:03:27 -0700 (PDT)
Received: from localhost.localdomain (ccu225.neoplus.adsl.tpnet.pl. [83.30.144.225])
        by smtp.gmail.com with ESMTPSA id kj15-20020a170907764f00b00a51a60bf400sm3195967ejc.76.2024.04.13.10.03.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 13 Apr 2024 10:03:26 -0700 (PDT)
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
Subject: [PATCH v3 1/4] arm64: dts: qcom: msm8976: Add IOMMU nodes
Date: Sat, 13 Apr 2024 19:03:14 +0200
Message-Id: <20240413170317.34553-2-a39.skl@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240413170317.34553-1-a39.skl@gmail.com>
References: <20240413170317.34553-1-a39.skl@gmail.com>
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


