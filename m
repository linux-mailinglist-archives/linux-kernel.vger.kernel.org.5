Return-Path: <linux-kernel+bounces-58869-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C7DB84EDE0
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 00:40:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AFB9A1F24372
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 23:40:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C17C55E61;
	Thu,  8 Feb 2024 23:25:13 +0000 (UTC)
Received: from relmlie5.idc.renesas.com (relmlor1.renesas.com [210.160.252.171])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF98455E64;
	Thu,  8 Feb 2024 23:25:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.160.252.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707434713; cv=none; b=aCQO5pu6r6RYsOzB9unr+vvUdCaC+ohMIgUZm1d2Ir0YOoJriewC1HLOF4/sQ5yc5mgvwnBu3JGRF9iBdXDyhIALYC9yBAdpw6/Sav1Nqlu5JudNEQ/t6rnowl+MlM1aqO3rczzUxavSIH1CTkCnSsanQ/sNu0SySLweaWcv52s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707434713; c=relaxed/simple;
	bh=NuN1mxlRgAizqoNK4SmyoLdJd2EHPH4LHxe6CQ0ptu0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=u0HUWXKWIB0kfKqHzz95AOTqQD6nw99m5zH0FeGLSVcs17jVqMfpWu2gMFYWJ5dGlXjdSllzYTLqUzrvZJZFEbTK0ZC319Xx3iz9tauZW/jyaw4v/XeZFM/735DoOO6X+1IRbUxTyfEiSK+HrgmdvZXczefcG7SUE3q9ij2Kl3M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com; spf=pass smtp.mailfrom=renesas.com; arc=none smtp.client-ip=210.160.252.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=renesas.com
X-IronPort-AV: E=Sophos;i="6.05,255,1701097200"; 
   d="scan'208";a="193379754"
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie5.idc.renesas.com with ESMTP; 09 Feb 2024 08:25:03 +0900
Received: from mulinux.home (unknown [10.226.92.227])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id DEA944007F23;
	Fri,  9 Feb 2024 08:24:59 +0900 (JST)
From: Fabrizio Castro <fabrizio.castro.jz@renesas.com>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	Magnus Damm <magnus.damm@gmail.com>,
	linux-renesas-soc@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>
Subject: [PATCH v6 3/4] arm64: dts: renesas: r9a09g011: Add pwm nodes
Date: Thu,  8 Feb 2024 23:24:10 +0000
Message-Id: <20240208232411.316936-4-fabrizio.castro.jz@renesas.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240208232411.316936-1-fabrizio.castro.jz@renesas.com>
References: <20240208232411.316936-1-fabrizio.castro.jz@renesas.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Biju Das <biju.das.jz@bp.renesas.com>

Add device nodes for the pwm timer channels that are not assigned
to the ISP.

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
---

v5->v6:
 * No change.
v4->v5:
 * No change.
v3->v4:
 * No change
v2->v3:
 * Added Rb tag from Geert
v1->v2:
 * Added resets property

 arch/arm64/boot/dts/renesas/r9a09g011.dtsi | 98 ++++++++++++++++++++++
 1 file changed, 98 insertions(+)

diff --git a/arch/arm64/boot/dts/renesas/r9a09g011.dtsi b/arch/arm64/boot/dts/renesas/r9a09g011.dtsi
index 50ed66d42a24..bb006772e31e 100644
--- a/arch/arm64/boot/dts/renesas/r9a09g011.dtsi
+++ b/arch/arm64/boot/dts/renesas/r9a09g011.dtsi
@@ -236,6 +236,104 @@ sys: system-controller@a3f03000 {
 			reg = <0 0xa3f03000 0 0x400>;
 		};
 
+		pwm8: pwm@a4010400 {
+			compatible = "renesas,r9a09g011-pwm",
+				     "renesas,rzv2m-pwm";
+			reg = <0 0xa4010400 0 0x80>;
+			interrupts = <GIC_SPI 376 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&cpg CPG_MOD R9A09G011_CPERI_GRPF_PCLK>,
+				 <&cpg CPG_MOD R9A09G011_PWM8_CLK>;
+			clock-names = "apb", "pwm";
+			resets = <&cpg R9A09G011_PWM_GPF_PRESETN>;
+			power-domains = <&cpg>;
+			#pwm-cells = <2>;
+			status = "disabled";
+		};
+
+		pwm9: pwm@a4010480 {
+			compatible = "renesas,r9a09g011-pwm",
+				     "renesas,rzv2m-pwm";
+			reg = <0 0xa4010480 0 0x80>;
+			interrupts = <GIC_SPI 377 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&cpg CPG_MOD R9A09G011_CPERI_GRPF_PCLK>,
+				 <&cpg CPG_MOD R9A09G011_PWM9_CLK>;
+			clock-names = "apb", "pwm";
+			resets = <&cpg R9A09G011_PWM_GPF_PRESETN>;
+			power-domains = <&cpg>;
+			#pwm-cells = <2>;
+			status = "disabled";
+		};
+
+		pwm10: pwm@a4010500 {
+			compatible = "renesas,r9a09g011-pwm",
+				     "renesas,rzv2m-pwm";
+			reg = <0 0xa4010500 0 0x80>;
+			interrupts = <GIC_SPI 378 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&cpg CPG_MOD R9A09G011_CPERI_GRPF_PCLK>,
+				 <&cpg CPG_MOD R9A09G011_PWM10_CLK>;
+			clock-names = "apb", "pwm";
+			resets = <&cpg R9A09G011_PWM_GPF_PRESETN>;
+			power-domains = <&cpg>;
+			#pwm-cells = <2>;
+			status = "disabled";
+		};
+
+		pwm11: pwm@a4010580 {
+			compatible = "renesas,r9a09g011-pwm",
+				     "renesas,rzv2m-pwm";
+			reg = <0 0xa4010580 0 0x80>;
+			interrupts = <GIC_SPI 379 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&cpg CPG_MOD R9A09G011_CPERI_GRPF_PCLK>,
+				 <&cpg CPG_MOD R9A09G011_PWM11_CLK>;
+			clock-names = "apb", "pwm";
+			resets = <&cpg R9A09G011_PWM_GPF_PRESETN>;
+			power-domains = <&cpg>;
+			#pwm-cells = <2>;
+			status = "disabled";
+		};
+
+		pwm12: pwm@a4010600 {
+			compatible = "renesas,r9a09g011-pwm",
+				     "renesas,rzv2m-pwm";
+			reg = <0 0xa4010600 0 0x80>;
+			interrupts = <GIC_SPI 380 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&cpg CPG_MOD R9A09G011_CPERI_GRPF_PCLK>,
+				 <&cpg CPG_MOD R9A09G011_PWM12_CLK>;
+			clock-names = "apb", "pwm";
+			resets = <&cpg R9A09G011_PWM_GPF_PRESETN>;
+			power-domains = <&cpg>;
+			#pwm-cells = <2>;
+			status = "disabled";
+		};
+
+		pwm13: pwm@a4010680 {
+			compatible = "renesas,r9a09g011-pwm",
+				     "renesas,rzv2m-pwm";
+			reg = <0 0xa4010680 0 0x80>;
+			interrupts = <GIC_SPI 381 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&cpg CPG_MOD R9A09G011_CPERI_GRPF_PCLK>,
+				 <&cpg CPG_MOD R9A09G011_PWM13_CLK>;
+			clock-names = "apb", "pwm";
+			resets = <&cpg R9A09G011_PWM_GPF_PRESETN>;
+			power-domains = <&cpg>;
+			#pwm-cells = <2>;
+			status = "disabled";
+		};
+
+		pwm14: pwm@a4010700 {
+			compatible = "renesas,r9a09g011-pwm",
+				     "renesas,rzv2m-pwm";
+			reg = <0 0xa4010700 0 0x80>;
+			interrupts = <GIC_SPI 382 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&cpg CPG_MOD R9A09G011_CPERI_GRPF_PCLK>,
+				 <&cpg CPG_MOD R9A09G011_PWM14_CLK>;
+			clock-names = "apb", "pwm";
+			resets = <&cpg R9A09G011_PWM_GPF_PRESETN>;
+			power-domains = <&cpg>;
+			#pwm-cells = <2>;
+			status = "disabled";
+		};
+
 		csi0: spi@a4020000 {
 			compatible = "renesas,rzv2m-csi";
 			reg = <0 0xa4020000 0 0x80>;
-- 
2.34.1


