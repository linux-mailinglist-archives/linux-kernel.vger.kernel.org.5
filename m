Return-Path: <linux-kernel+bounces-143708-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 93C1E8A3C7E
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Apr 2024 13:26:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3A363282B71
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Apr 2024 11:26:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 509E4446A1;
	Sat, 13 Apr 2024 11:25:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="GvGNSD7b"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38E723E498;
	Sat, 13 Apr 2024 11:25:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713007545; cv=none; b=uAmSZsSc9TVEmsIE4FzwD2G0M4eyPtPy9xRfOR6ETGX0tfoNgNfhLOtduIHe2n7nN7cTkKvaN8t72B2ZYO4HjJZQgszeelgZb0NaTW9Ua0ZtgFSxLUzB6rZIV7Xqwk3UqRIfIohmbqTnPfTBvT5ChaUm3/ezvIUsjhL98s58X38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713007545; c=relaxed/simple;
	bh=0K9J4qFxTZPdtoWfRJOblEUEzYfjPfpebbXF76I9L3E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Yjj0DkTLW8XzyIv3ElcjcTKrjYc1kWoWfOsHVy+ynj/f6PPiaZR8ezG6+9YCreEtFBSbRyMimoWoDYqVtFaQg2VUxBoyRfRYzd0y9xoq7QzfNRo+0R7RCbw8+g5pWvnsNsoLuzhu2+efTvhD4VcTqnklPmuGeq21IAezWDgFNWE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=GvGNSD7b; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB733C2BBFC;
	Sat, 13 Apr 2024 11:25:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1713007544;
	bh=0K9J4qFxTZPdtoWfRJOblEUEzYfjPfpebbXF76I9L3E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=GvGNSD7bYlpNWli96MWn5+t++MYUXPe1Vfmeox8UClUsZ+4qhpZogXKCtNmY4gPOT
	 L6/tN7fx/9SUM13K3w5ISpRoEZZUp/KoW4xKnRj3dGVDfFelTC5jtKnBQT2zuMNrUS
	 zl/EAjr83EkO2qSbG+cxN9mCD1vBxC7ddW6k+JgI=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: Linux 4.19.312
Date: Sat, 13 Apr 2024 13:25:34 +0200
Message-ID: <2024041334-niece-grudge-c829@gregkh>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <2024041333-trapper-blank-61b3@gregkh>
References: <2024041333-trapper-blank-61b3@gregkh>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

diff --git a/Documentation/admin-guide/hw-vuln/spectre.rst b/Documentation/admin-guide/hw-vuln/spectre.rst
index 0fba3758d0da..305600351209 100644
--- a/Documentation/admin-guide/hw-vuln/spectre.rst
+++ b/Documentation/admin-guide/hw-vuln/spectre.rst
@@ -484,11 +484,14 @@ Spectre variant 2
 
    Systems which support enhanced IBRS (eIBRS) enable IBRS protection once at
    boot, by setting the IBRS bit, and they're automatically protected against
-   Spectre v2 variant attacks, including cross-thread branch target injections
-   on SMT systems (STIBP). In other words, eIBRS enables STIBP too.
+   Spectre v2 variant attacks.
 
-   Legacy IBRS systems clear the IBRS bit on exit to userspace and
-   therefore explicitly enable STIBP for that
+   On Intel's enhanced IBRS systems, this includes cross-thread branch target
+   injections on SMT systems (STIBP). In other words, Intel eIBRS enables
+   STIBP, too.
+
+   AMD Automatic IBRS does not protect userspace, and Legacy IBRS systems clear
+   the IBRS bit on exit to userspace, therefore both explicitly enable STIBP.
 
    The retpoline mitigation is turned on by default on vulnerable
    CPUs. It can be forced on or off by the administrator
@@ -622,9 +625,10 @@ kernel command line.
                 retpoline,generic       Retpolines
                 retpoline,lfence        LFENCE; indirect branch
                 retpoline,amd           alias for retpoline,lfence
-                eibrs                   enhanced IBRS
-                eibrs,retpoline         enhanced IBRS + Retpolines
-                eibrs,lfence            enhanced IBRS + LFENCE
+                eibrs                   Enhanced/Auto IBRS
+                eibrs,retpoline         Enhanced/Auto IBRS + Retpolines
+                eibrs,lfence            Enhanced/Auto IBRS + LFENCE
+                ibrs                    use IBRS to protect kernel
 
 		Not specifying this option is equivalent to
 		spectre_v2=auto.
diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 84c34f7e8984..20553b627020 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -4403,9 +4403,9 @@
 			retpoline,generic - Retpolines
 			retpoline,lfence  - LFENCE; indirect branch
 			retpoline,amd     - alias for retpoline,lfence
-			eibrs		  - enhanced IBRS
-			eibrs,retpoline   - enhanced IBRS + Retpolines
-			eibrs,lfence      - enhanced IBRS + LFENCE
+			eibrs		  - Enhanced/Auto IBRS
+			eibrs,retpoline   - Enhanced/Auto IBRS + Retpolines
+			eibrs,lfence      - Enhanced/Auto IBRS + LFENCE
 			ibrs		  - use IBRS to protect kernel
 
 			Not specifying this option is equivalent to
diff --git a/Makefile b/Makefile
index 296db299ab39..b0ae93c88a68 100644
--- a/Makefile
+++ b/Makefile
@@ -1,7 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0
 VERSION = 4
 PATCHLEVEL = 19
-SUBLEVEL = 311
+SUBLEVEL = 312
 EXTRAVERSION =
 NAME = "People's Front"
 
diff --git a/arch/arm/boot/dts/mmp2-brownstone.dts b/arch/arm/boot/dts/mmp2-brownstone.dts
index 350208c5e1ed..f12d5aa773f3 100644
--- a/arch/arm/boot/dts/mmp2-brownstone.dts
+++ b/arch/arm/boot/dts/mmp2-brownstone.dts
@@ -21,176 +21,174 @@
 	memory {
 		reg = <0x00000000 0x08000000>;
 	};
+};
+
+&uart3 {
+	status = "okay";
+};
 
-	soc {
-		apb@d4000000 {
-			uart3: uart@d4018000 {
-				status = "okay";
-			};
-			twsi1: i2c@d4011000 {
-				status = "okay";
-				pmic: max8925@3c {
-					compatible = "maxium,max8925";
-					reg = <0x3c>;
-					interrupts = <1>;
-					interrupt-parent = <&intcmux4>;
-					interrupt-controller;
-					#interrupt-cells = <1>;
-					maxim,tsc-irq = <0>;
+&twsi1 {
+	status = "okay";
+	pmic: max8925@3c {
+		compatible = "maxim,max8925";
+		reg = <0x3c>;
+		interrupts = <1>;
+		interrupt-parent = <&intcmux4>;
+		interrupt-controller;
+		#interrupt-cells = <1>;
+		maxim,tsc-irq = <0>;
 
-					regulators {
-						SDV1 {
-							regulator-min-microvolt = <637500>;
-							regulator-max-microvolt = <1425000>;
-							regulator-boot-on;
-							regulator-always-on;
-						};
-						SDV2 {
-							regulator-min-microvolt = <650000>;
-							regulator-max-microvolt = <2225000>;
-							regulator-boot-on;
-							regulator-always-on;
-						};
-						SDV3 {
-							regulator-min-microvolt = <750000>;
-							regulator-max-microvolt = <3900000>;
-							regulator-boot-on;
-							regulator-always-on;
-						};
-						LDO1 {
-							regulator-min-microvolt = <750000>;
-							regulator-max-microvolt = <3900000>;
-							regulator-boot-on;
-							regulator-always-on;
-						};
-						LDO2 {
-							regulator-min-microvolt = <650000>;
-							regulator-max-microvolt = <2250000>;
-							regulator-boot-on;
-							regulator-always-on;
-						};
-						LDO3 {
-							regulator-min-microvolt = <650000>;
-							regulator-max-microvolt = <2250000>;
-							regulator-boot-on;
-							regulator-always-on;
-						};
-						LDO4 {
-							regulator-min-microvolt = <750000>;
-							regulator-max-microvolt = <3900000>;
-							regulator-boot-on;
-							regulator-always-on;
-						};
-						LDO5 {
-							regulator-min-microvolt = <750000>;
-							regulator-max-microvolt = <3900000>;
-							regulator-boot-on;
-							regulator-always-on;
-						};
-						LDO6 {
-							regulator-min-microvolt = <750000>;
-							regulator-max-microvolt = <3900000>;
-							regulator-boot-on;
-							regulator-always-on;
-						};
-						LDO7 {
-							regulator-min-microvolt = <750000>;
-							regulator-max-microvolt = <3900000>;
-							regulator-boot-on;
-							regulator-always-on;
-						};
-						LDO8 {
-							regulator-min-microvolt = <750000>;
-							regulator-max-microvolt = <3900000>;
-							regulator-boot-on;
-							regulator-always-on;
-						};
-						LDO9 {
-							regulator-min-microvolt = <750000>;
-							regulator-max-microvolt = <3900000>;
-							regulator-boot-on;
-							regulator-always-on;
-						};
-						LDO10 {
-							regulator-min-microvolt = <750000>;
-							regulator-max-microvolt = <3900000>;
-						};
-						LDO11 {
-							regulator-min-microvolt = <750000>;
-							regulator-max-microvolt = <3900000>;
-							regulator-boot-on;
-							regulator-always-on;
-						};
-						LDO12 {
-							regulator-min-microvolt = <750000>;
-							regulator-max-microvolt = <3900000>;
-							regulator-boot-on;
-							regulator-always-on;
-						};
-						LDO13 {
-							regulator-min-microvolt = <750000>;
-							regulator-max-microvolt = <3900000>;
-							regulator-boot-on;
-							regulator-always-on;
-						};
-						LDO14 {
-							regulator-min-microvolt = <750000>;
-							regulator-max-microvolt = <3900000>;
-							regulator-boot-on;
-							regulator-always-on;
-						};
-						LDO15 {
-							regulator-min-microvolt = <750000>;
-							regulator-max-microvolt = <3900000>;
-							regulator-boot-on;
-							regulator-always-on;
-						};
-						LDO16 {
-							regulator-min-microvolt = <750000>;
-							regulator-max-microvolt = <3900000>;
-							regulator-boot-on;
-							regulator-always-on;
-						};
-						LDO17 {
-							regulator-min-microvolt = <650000>;
-							regulator-max-microvolt = <2250000>;
-							regulator-boot-on;
-							regulator-always-on;
-						};
-						LDO18 {
-							regulator-min-microvolt = <650000>;
-							regulator-max-microvolt = <2250000>;
-							regulator-boot-on;
-							regulator-always-on;
-						};
-						LDO19 {
-							regulator-min-microvolt = <750000>;
-							regulator-max-microvolt = <3900000>;
-							regulator-boot-on;
-							regulator-always-on;
-						};
-						LDO20 {
-							regulator-min-microvolt = <750000>;
-							regulator-max-microvolt = <3900000>;
-							regulator-boot-on;
-							regulator-always-on;
-						};
-					};
-					backlight {
-						maxim,max8925-dual-string = <0>;
-					};
-					charger {
-						batt-detect = <0>;
-						topoff-threshold = <1>;
-						fast-charge = <7>;
-						no-temp-support = <0>;
-						no-insert-detect = <0>;
-					};
-				};
-			};
-			rtc: rtc@d4010000 {
-				status = "okay";
+		regulators {
+			SDV1 {
+				regulator-min-microvolt = <637500>;
+				regulator-max-microvolt = <1425000>;
+				regulator-boot-on;
+				regulator-always-on;
+			};
+			SDV2 {
+				regulator-min-microvolt = <650000>;
+				regulator-max-microvolt = <2225000>;
+				regulator-boot-on;
+				regulator-always-on;
+			};
+			SDV3 {
+				regulator-min-microvolt = <750000>;
+				regulator-max-microvolt = <3900000>;
+				regulator-boot-on;
+				regulator-always-on;
+			};
+			LDO1 {
+				regulator-min-microvolt = <750000>;
+				regulator-max-microvolt = <3900000>;
+				regulator-boot-on;
+				regulator-always-on;
+			};
+			LDO2 {
+				regulator-min-microvolt = <650000>;
+				regulator-max-microvolt = <2250000>;
+				regulator-boot-on;
+				regulator-always-on;
+			};
+			LDO3 {
+				regulator-min-microvolt = <650000>;
+				regulator-max-microvolt = <2250000>;
+				regulator-boot-on;
+				regulator-always-on;
+			};
+			LDO4 {
+				regulator-min-microvolt = <750000>;
+				regulator-max-microvolt = <3900000>;
+				regulator-boot-on;
+				regulator-always-on;
+			};
+			LDO5 {
+				regulator-min-microvolt = <750000>;
+				regulator-max-microvolt = <3900000>;
+				regulator-boot-on;
+				regulator-always-on;
+			};
+			LDO6 {
+				regulator-min-microvolt = <750000>;
+				regulator-max-microvolt = <3900000>;
+				regulator-boot-on;
+				regulator-always-on;
+			};
+			LDO7 {
+				regulator-min-microvolt = <750000>;
+				regulator-max-microvolt = <3900000>;
+				regulator-boot-on;
+				regulator-always-on;
+			};
+			LDO8 {
+				regulator-min-microvolt = <750000>;
+				regulator-max-microvolt = <3900000>;
+				regulator-boot-on;
+				regulator-always-on;
+			};
+			LDO9 {
+				regulator-min-microvolt = <750000>;
+				regulator-max-microvolt = <3900000>;
+				regulator-boot-on;
+				regulator-always-on;
+			};
+			LDO10 {
+				regulator-min-microvolt = <750000>;
+				regulator-max-microvolt = <3900000>;
 			};
+			LDO11 {
+				regulator-min-microvolt = <750000>;
+				regulator-max-microvolt = <3900000>;
+				regulator-boot-on;
+				regulator-always-on;
+			};
+			LDO12 {
+				regulator-min-microvolt = <750000>;
+				regulator-max-microvolt = <3900000>;
+				regulator-boot-on;
+				regulator-always-on;
+			};
+			LDO13 {
+				regulator-min-microvolt = <750000>;
+				regulator-max-microvolt = <3900000>;
+				regulator-boot-on;
+				regulator-always-on;
+			};
+			LDO14 {
+				regulator-min-microvolt = <750000>;
+				regulator-max-microvolt = <3900000>;
+				regulator-boot-on;
+				regulator-always-on;
+			};
+			LDO15 {
+				regulator-min-microvolt = <750000>;
+				regulator-max-microvolt = <3900000>;
+				regulator-boot-on;
+				regulator-always-on;
+			};
+			LDO16 {
+				regulator-min-microvolt = <750000>;
+				regulator-max-microvolt = <3900000>;
+				regulator-boot-on;
+				regulator-always-on;
+			};
+			LDO17 {
+				regulator-min-microvolt = <650000>;
+				regulator-max-microvolt = <2250000>;
+				regulator-boot-on;
+				regulator-always-on;
+			};
+			LDO18 {
+				regulator-min-microvolt = <650000>;
+				regulator-max-microvolt = <2250000>;
+				regulator-boot-on;
+				regulator-always-on;
+			};
+			LDO19 {
+				regulator-min-microvolt = <750000>;
+				regulator-max-microvolt = <3900000>;
+				regulator-boot-on;
+				regulator-always-on;
+			};
+			LDO20 {
+				regulator-min-microvolt = <750000>;
+				regulator-max-microvolt = <3900000>;
+				regulator-boot-on;
+				regulator-always-on;
+			};
+		};
+		backlight {
+			maxim,max8925-dual-string = <0>;
+		};
+		charger {
+			batt-detect = <0>;
+			topoff-threshold = <1>;
+			fast-charge = <7>;
+			no-temp-support = <0>;
+			no-insert-detect = <0>;
 		};
 	};
 };
+
+&rtc {
+	status = "okay";
+};
diff --git a/arch/arm64/boot/dts/rockchip/rk3399.dtsi b/arch/arm64/boot/dts/rockchip/rk3399.dtsi
index 5a60faa8e999..f19d43021a4e 100644
--- a/arch/arm64/boot/dts/rockchip/rk3399.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3399.dtsi
@@ -1683,6 +1683,7 @@
 	hdmi: hdmi@ff940000 {
 		compatible = "rockchip,rk3399-dw-hdmi";
 		reg = <0x0 0xff940000 0x0 0x20000>;
+		reg-io-width = <4>;
 		interrupts = <GIC_SPI 23 IRQ_TYPE_LEVEL_HIGH 0>;
 		clocks = <&cru PCLK_HDMI_CTRL>,
 			 <&cru SCLK_HDMI_SFR>,
@@ -1691,13 +1692,16 @@
 			 <&cru PLL_VPLL>;
 		clock-names = "iahb", "isfr", "cec", "grf", "vpll";
 		power-domains = <&power RK3399_PD_HDCP>;
-		reg-io-width = <4>;
 		rockchip,grf = <&grf>;
 		#sound-dai-cells = <0>;
 		status = "disabled";
 
 		ports {
-			hdmi_in: port {
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			hdmi_in: port@0 {
+				reg = <0>;
 				#address-cells = <1>;
 				#size-cells = <0>;
 
@@ -1710,6 +1714,10 @@
 					remote-endpoint = <&vopl_out_hdmi>;
 				};
 			};
+
+			hdmi_out: port@1 {
+				reg = <1>;
+			};
 		};
 	};
 
diff --git a/arch/parisc/include/asm/checksum.h b/arch/parisc/include/asm/checksum.h
index 3cbf1f1c1188..ef34e8f839d5 100644
--- a/arch/parisc/include/asm/checksum.h
+++ b/arch/parisc/include/asm/checksum.h
@@ -42,31 +42,32 @@ extern __wsum csum_partial_copy_from_user(const void __user *src,
 static inline __sum16 ip_fast_csum(const void *iph, unsigned int ihl)
 {
 	unsigned int sum;
+	unsigned long t0, t1, t2;
 
 	__asm__ __volatile__ (
 "	ldws,ma		4(%1), %0\n"
 "	addib,<=	-4, %2, 2f\n"
 "\n"
-"	ldws		4(%1), %%r20\n"
-"	ldws		8(%1), %%r21\n"
-"	add		%0, %%r20, %0\n"
-"	ldws,ma		12(%1), %%r19\n"
-"	addc		%0, %%r21, %0\n"
-"	addc		%0, %%r19, %0\n"
-"1:	ldws,ma		4(%1), %%r19\n"
-"	addib,<		0, %2, 1b\n"
-"	addc		%0, %%r19, %0\n"
+"	ldws		4(%1), %4\n"
+"	ldws		8(%1), %5\n"
+"	add		%0, %4, %0\n"
+"	ldws,ma		12(%1), %3\n"
+"	addc		%0, %5, %0\n"
+"	addc		%0, %3, %0\n"
+"1:	ldws,ma		4(%1), %3\n"
+"	addib,>		-1, %2, 1b\n"
+"	addc		%0, %3, %0\n"
 "\n"
-"	extru		%0, 31, 16, %%r20\n"
-"	extru		%0, 15, 16, %%r21\n"
-"	addc		%%r20, %%r21, %0\n"
-"	extru		%0, 15, 16, %%r21\n"
-"	add		%0, %%r21, %0\n"
+"	extru		%0, 31, 16, %4\n"
+"	extru		%0, 15, 16, %5\n"
+"	addc		%4, %5, %0\n"
+"	extru		%0, 15, 16, %5\n"
+"	add		%0, %5, %0\n"
 "	subi		-1, %0, %0\n"
 "2:\n"
-	: "=r" (sum), "=r" (iph), "=r" (ihl)
+	: "=r" (sum), "=r" (iph), "=r" (ihl), "=r" (t0), "=r" (t1), "=r" (t2)
 	: "1" (iph), "2" (ihl)
-	: "r19", "r20", "r21", "memory");
+	: "memory");
 
 	return (__force __sum16)sum;
 }
@@ -126,6 +127,10 @@ static __inline__ __sum16 csum_ipv6_magic(const struct in6_addr *saddr,
 					  __u32 len, __u8 proto,
 					  __wsum sum)
 {
+	unsigned long t0, t1, t2, t3;
+
+	len += proto;	/* add 16-bit proto + len */
+
 	__asm__ __volatile__ (
 
 #if BITS_PER_LONG > 32
@@ -136,20 +141,20 @@ static __inline__ __sum16 csum_ipv6_magic(const struct in6_addr *saddr,
 	** Try to keep 4 registers with "live" values ahead of the ALU.
 	*/
 
-"	ldd,ma		8(%1), %%r19\n"	/* get 1st saddr word */
-"	ldd,ma		8(%2), %%r20\n"	/* get 1st daddr word */
-"	add		%8, %3, %3\n"/* add 16-bit proto + len */
-"	add		%%r19, %0, %0\n"
-"	ldd,ma		8(%1), %%r21\n"	/* 2cd saddr */
-"	ldd,ma		8(%2), %%r22\n"	/* 2cd daddr */
-"	add,dc		%%r20, %0, %0\n"
-"	add,dc		%%r21, %0, %0\n"
-"	add,dc		%%r22, %0, %0\n"
+"	depdi		0, 31, 32, %0\n"/* clear upper half of incoming checksum */
+"	ldd,ma		8(%1), %4\n"	/* get 1st saddr word */
+"	ldd,ma		8(%2), %5\n"	/* get 1st daddr word */
+"	add		%4, %0, %0\n"
+"	ldd,ma		8(%1), %6\n"	/* 2nd saddr */
+"	ldd,ma		8(%2), %7\n"	/* 2nd daddr */
+"	add,dc		%5, %0, %0\n"
+"	add,dc		%6, %0, %0\n"
+"	add,dc		%7, %0, %0\n"
 "	add,dc		%3, %0, %0\n"  /* fold in proto+len | carry bit */
-"	extrd,u		%0, 31, 32, %%r19\n"	/* copy upper half down */
-"	depdi		0, 31, 32, %0\n"	/* clear upper half */
-"	add		%%r19, %0, %0\n"	/* fold into 32-bits */
-"	addc		0, %0, %0\n"		/* add carry */
+"	extrd,u		%0, 31, 32, %4\n"/* copy upper half down */
+"	depdi		0, 31, 32, %0\n"/* clear upper half */
+"	add,dc		%4, %0, %0\n"	/* fold into 32-bits, plus carry */
+"	addc		0, %0, %0\n"	/* add final carry */
 
 #else
 
@@ -158,30 +163,30 @@ static __inline__ __sum16 csum_ipv6_magic(const struct in6_addr *saddr,
 	** Insn stream is serialized on the carry bit here too.
 	** result from the previous operation (eg r0 + x)
 	*/
-
-"	ldw,ma		4(%1), %%r19\n"	/* get 1st saddr word */
-"	ldw,ma		4(%2), %%r20\n"	/* get 1st daddr word */
-"	add		%8, %3, %3\n"	/* add 16-bit proto + len */
-"	add		%%r19, %0, %0\n"
-"	ldw,ma		4(%1), %%r21\n"	/* 2cd saddr */
-"	addc		%%r20, %0, %0\n"
-"	ldw,ma		4(%2), %%r22\n"	/* 2cd daddr */
-"	addc		%%r21, %0, %0\n"
-"	ldw,ma		4(%1), %%r19\n"	/* 3rd saddr */
-"	addc		%%r22, %0, %0\n"
-"	ldw,ma		4(%2), %%r20\n"	/* 3rd daddr */
-"	addc		%%r19, %0, %0\n"
-"	ldw,ma		4(%1), %%r21\n"	/* 4th saddr */
-"	addc		%%r20, %0, %0\n"
-"	ldw,ma		4(%2), %%r22\n"	/* 4th daddr */
-"	addc		%%r21, %0, %0\n"
-"	addc		%%r22, %0, %0\n"
-"	addc		%3, %0, %0\n"	/* fold in proto+len, catch carry */
+"	ldw,ma		4(%1), %4\n"	/* get 1st saddr word */
+"	ldw,ma		4(%2), %5\n"	/* get 1st daddr word */
+"	add		%4, %0, %0\n"
+"	ldw,ma		4(%1), %6\n"	/* 2nd saddr */
+"	addc		%5, %0, %0\n"
+"	ldw,ma		4(%2), %7\n"	/* 2nd daddr */
+"	addc		%6, %0, %0\n"
+"	ldw,ma		4(%1), %4\n"	/* 3rd saddr */
+"	addc		%7, %0, %0\n"
+"	ldw,ma		4(%2), %5\n"	/* 3rd daddr */
+"	addc		%4, %0, %0\n"
+"	ldw,ma		4(%1), %6\n"	/* 4th saddr */
+"	addc		%5, %0, %0\n"
+"	ldw,ma		4(%2), %7\n"	/* 4th daddr */
+"	addc		%6, %0, %0\n"
+"	addc		%7, %0, %0\n"
+"	addc		%3, %0, %0\n"	/* fold in proto+len */
+"	addc		0, %0, %0\n"	/* add carry */
 
 #endif
-	: "=r" (sum), "=r" (saddr), "=r" (daddr), "=r" (len)
-	: "0" (sum), "1" (saddr), "2" (daddr), "3" (len), "r" (proto)
-	: "r19", "r20", "r21", "r22", "memory");
+	: "=r" (sum), "=r" (saddr), "=r" (daddr), "=r" (len),
+	  "=r" (t0), "=r" (t1), "=r" (t2), "=r" (t3)
+	: "0" (sum), "1" (saddr), "2" (daddr), "3" (len)
+	: "memory");
 	return csum_fold(sum);
 }
 
diff --git a/arch/powerpc/include/asm/reg_fsl_emb.h b/arch/powerpc/include/asm/reg_fsl_emb.h
index a21f529c43d9..8359c06d92d9 100644
--- a/arch/powerpc/include/asm/reg_fsl_emb.h
+++ b/arch/powerpc/include/asm/reg_fsl_emb.h
@@ -12,9 +12,16 @@
 #ifndef __ASSEMBLY__
 /* Performance Monitor Registers */
 #define mfpmr(rn)	({unsigned int rval; \
-			asm volatile("mfpmr %0," __stringify(rn) \
+			asm volatile(".machine push; " \
+				     ".machine e300; " \
+				     "mfpmr %0," __stringify(rn) ";" \
+				     ".machine pop; " \
 				     : "=r" (rval)); rval;})
-#define mtpmr(rn, v)	asm volatile("mtpmr " __stringify(rn) ",%0" : : "r" (v))
+#define mtpmr(rn, v)	asm volatile(".machine push; " \
+				     ".machine e300; " \
+				     "mtpmr " __stringify(rn) ",%0; " \
+				     ".machine pop; " \
+				     : : "r" (v))
 #endif /* __ASSEMBLY__ */
 
 /* Freescale Book E Performance Monitor APU Registers */
diff --git a/arch/powerpc/lib/Makefile b/arch/powerpc/lib/Makefile
index f0aa6fc8c6b2..0dc53f5c656d 100644
--- a/arch/powerpc/lib/Makefile
+++ b/arch/powerpc/lib/Makefile
@@ -46,6 +46,6 @@ obj-$(CONFIG_PPC_LIB_RHEAP) += rheap.o
 obj-$(CONFIG_FTR_FIXUP_SELFTEST) += feature-fixups-test.o
 
 obj-$(CONFIG_ALTIVEC)	+= xor_vmx.o xor_vmx_glue.o
-CFLAGS_xor_vmx.o += -maltivec $(call cc-option,-mabi=altivec)
+CFLAGS_xor_vmx.o += -mhard-float -maltivec $(call cc-option,-mabi=altivec)
 
 obj-$(CONFIG_PPC64) += $(obj64-y)
diff --git a/arch/sparc/kernel/nmi.c b/arch/sparc/kernel/nmi.c
index 8babbeb30adf..1f356928a06d 100644
--- a/arch/sparc/kernel/nmi.c
+++ b/arch/sparc/kernel/nmi.c
@@ -273,7 +273,7 @@ static int __init setup_nmi_watchdog(char *str)
 	if (!strncmp(str, "panic", 5))
 		panic_on_timeout = 1;
 
-	return 0;
+	return 1;
 }
 __setup("nmi_watchdog=", setup_nmi_watchdog);
 
diff --git a/arch/sparc/vdso/vma.c b/arch/sparc/vdso/vma.c
index 5eaff3c1aa0c..1869e4b36db2 100644
--- a/arch/sparc/vdso/vma.c
+++ b/arch/sparc/vdso/vma.c
@@ -262,9 +262,8 @@ static __init int vdso_setup(char *s)
 	unsigned long val;
 
 	err = kstrtoul(s, 10, &val);
-	if (err)
-		return err;
-	vdso_enabled = val;
-	return 0;
+	if (!err)
+		vdso_enabled = val;
+	return 1;
 }
 __setup("vdso=", vdso_setup);
diff --git a/arch/x86/include/asm/cpufeatures.h b/arch/x86/include/asm/cpufeatures.h
index 5cf8dca571cf..464b2b5d87bd 100644
--- a/arch/x86/include/asm/cpufeatures.h
+++ b/arch/x86/include/asm/cpufeatures.h
@@ -369,6 +369,8 @@
 #define X86_FEATURE_ARCH_CAPABILITIES	(18*32+29) /* IA32_ARCH_CAPABILITIES MSR (Intel) */
 #define X86_FEATURE_SPEC_CTRL_SSBD	(18*32+31) /* "" Speculative Store Bypass Disable */
 
+#define X86_FEATURE_AUTOIBRS		(20*32+ 8) /* "" Automatic IBRS */
+
 /*
  * BUG word(s)
  */
diff --git a/arch/x86/include/asm/msr-index.h b/arch/x86/include/asm/msr-index.h
index 4be36bfb2477..51354e09ebb1 100644
--- a/arch/x86/include/asm/msr-index.h
+++ b/arch/x86/include/asm/msr-index.h
@@ -30,6 +30,7 @@
 #define _EFER_SVME		12 /* Enable virtualization */
 #define _EFER_LMSLE		13 /* Long Mode Segment Limit Enable */
 #define _EFER_FFXSR		14 /* Enable Fast FXSAVE/FXRSTOR */
+#define _EFER_AUTOIBRS		21 /* Enable Automatic IBRS */
 
 #define EFER_SCE		(1<<_EFER_SCE)
 #define EFER_LME		(1<<_EFER_LME)
@@ -38,6 +39,7 @@
 #define EFER_SVME		(1<<_EFER_SVME)
 #define EFER_LMSLE		(1<<_EFER_LMSLE)
 #define EFER_FFXSR		(1<<_EFER_FFXSR)
+#define EFER_AUTOIBRS		(1<<_EFER_AUTOIBRS)
 
 /* Intel MSRs. Some also available on other CPUs */
 
diff --git a/arch/x86/kernel/cpu/amd.c b/arch/x86/kernel/cpu/amd.c
index 5b75a4ff6802..3f6188477e01 100644
--- a/arch/x86/kernel/cpu/amd.c
+++ b/arch/x86/kernel/cpu/amd.c
@@ -988,11 +988,11 @@ static bool cpu_has_zenbleed_microcode(void)
 	u32 good_rev = 0;
 
 	switch (boot_cpu_data.x86_model) {
-	case 0x30 ... 0x3f: good_rev = 0x0830107a; break;
-	case 0x60 ... 0x67: good_rev = 0x0860010b; break;
-	case 0x68 ... 0x6f: good_rev = 0x08608105; break;
-	case 0x70 ... 0x7f: good_rev = 0x08701032; break;
-	case 0xa0 ... 0xaf: good_rev = 0x08a00008; break;
+	case 0x30 ... 0x3f: good_rev = 0x0830107b; break;
+	case 0x60 ... 0x67: good_rev = 0x0860010c; break;
+	case 0x68 ... 0x6f: good_rev = 0x08608107; break;
+	case 0x70 ... 0x7f: good_rev = 0x08701033; break;
+	case 0xa0 ... 0xaf: good_rev = 0x08a00009; break;
 
 	default:
 		return false;
diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu/bugs.c
index 6e1acbdd27a5..26d5d5b0e4e0 100644
--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -1153,19 +1153,21 @@ spectre_v2_user_select_mitigation(void)
 	}
 
 	/*
-	 * If no STIBP, enhanced IBRS is enabled, or SMT impossible, STIBP
+	 * If no STIBP, Intel enhanced IBRS is enabled, or SMT impossible, STIBP
 	 * is not required.
 	 *
-	 * Enhanced IBRS also protects against cross-thread branch target
+	 * Intel's Enhanced IBRS also protects against cross-thread branch target
 	 * injection in user-mode as the IBRS bit remains always set which
 	 * implicitly enables cross-thread protections.  However, in legacy IBRS
 	 * mode, the IBRS bit is set only on kernel entry and cleared on return
-	 * to userspace. This disables the implicit cross-thread protection,
-	 * so allow for STIBP to be selected in that case.
+	 * to userspace.  AMD Automatic IBRS also does not protect userspace.
+	 * These modes therefore disable the implicit cross-thread protection,
+	 * so allow for STIBP to be selected in those cases.
 	 */
 	if (!boot_cpu_has(X86_FEATURE_STIBP) ||
 	    !smt_possible ||
-	    spectre_v2_in_eibrs_mode(spectre_v2_enabled))
+	    (spectre_v2_in_eibrs_mode(spectre_v2_enabled) &&
+	     !boot_cpu_has(X86_FEATURE_AUTOIBRS)))
 		return;
 
 	/*
@@ -1187,9 +1189,9 @@ static const char * const spectre_v2_strings[] = {
 	[SPECTRE_V2_NONE]			= "Vulnerable",
 	[SPECTRE_V2_RETPOLINE]			= "Mitigation: Retpolines",
 	[SPECTRE_V2_LFENCE]			= "Mitigation: LFENCE",
-	[SPECTRE_V2_EIBRS]			= "Mitigation: Enhanced IBRS",
-	[SPECTRE_V2_EIBRS_LFENCE]		= "Mitigation: Enhanced IBRS + LFENCE",
-	[SPECTRE_V2_EIBRS_RETPOLINE]		= "Mitigation: Enhanced IBRS + Retpolines",
+	[SPECTRE_V2_EIBRS]			= "Mitigation: Enhanced / Automatic IBRS",
+	[SPECTRE_V2_EIBRS_LFENCE]		= "Mitigation: Enhanced / Automatic IBRS + LFENCE",
+	[SPECTRE_V2_EIBRS_RETPOLINE]		= "Mitigation: Enhanced / Automatic IBRS + Retpolines",
 	[SPECTRE_V2_IBRS]			= "Mitigation: IBRS",
 };
 
@@ -1258,7 +1260,7 @@ static enum spectre_v2_mitigation_cmd __init spectre_v2_parse_cmdline(void)
 	     cmd == SPECTRE_V2_CMD_EIBRS_LFENCE ||
 	     cmd == SPECTRE_V2_CMD_EIBRS_RETPOLINE) &&
 	    !boot_cpu_has(X86_FEATURE_IBRS_ENHANCED)) {
-		pr_err("%s selected but CPU doesn't have eIBRS. Switching to AUTO select\n",
+		pr_err("%s selected but CPU doesn't have Enhanced or Automatic IBRS. Switching to AUTO select\n",
 		       mitigation_options[i].option);
 		return SPECTRE_V2_CMD_AUTO;
 	}
@@ -1437,8 +1439,12 @@ static void __init spectre_v2_select_mitigation(void)
 		pr_err(SPECTRE_V2_EIBRS_EBPF_MSG);
 
 	if (spectre_v2_in_ibrs_mode(mode)) {
-		x86_spec_ctrl_base |= SPEC_CTRL_IBRS;
-		update_spec_ctrl(x86_spec_ctrl_base);
+		if (boot_cpu_has(X86_FEATURE_AUTOIBRS)) {
+			msr_set_bit(MSR_EFER, _EFER_AUTOIBRS);
+		} else {
+			x86_spec_ctrl_base |= SPEC_CTRL_IBRS;
+			update_spec_ctrl(x86_spec_ctrl_base);
+		}
 	}
 
 	switch (mode) {
@@ -1522,8 +1528,8 @@ static void __init spectre_v2_select_mitigation(void)
 	/*
 	 * Retpoline protects the kernel, but doesn't protect firmware.  IBRS
 	 * and Enhanced IBRS protect firmware too, so enable IBRS around
-	 * firmware calls only when IBRS / Enhanced IBRS aren't otherwise
-	 * enabled.
+	 * firmware calls only when IBRS / Enhanced / Automatic IBRS aren't
+	 * otherwise enabled.
 	 *
 	 * Use "mode" to check Enhanced IBRS instead of boot_cpu_has(), because
 	 * the user might select retpoline on the kernel command line and if
@@ -2133,69 +2139,69 @@ static const char * const l1tf_vmx_states[] = {
 static ssize_t l1tf_show_state(char *buf)
 {
 	if (l1tf_vmx_mitigation == VMENTER_L1D_FLUSH_AUTO)
-		return sprintf(buf, "%s\n", L1TF_DEFAULT_MSG);
+		return sysfs_emit(buf, "%s\n", L1TF_DEFAULT_MSG);
 
 	if (l1tf_vmx_mitigation == VMENTER_L1D_FLUSH_EPT_DISABLED ||
 	    (l1tf_vmx_mitigation == VMENTER_L1D_FLUSH_NEVER &&
 	     sched_smt_active())) {
-		return sprintf(buf, "%s; VMX: %s\n", L1TF_DEFAULT_MSG,
-			       l1tf_vmx_states[l1tf_vmx_mitigation]);
+		return sysfs_emit(buf, "%s; VMX: %s\n", L1TF_DEFAULT_MSG,
+				  l1tf_vmx_states[l1tf_vmx_mitigation]);
 	}
 
-	return sprintf(buf, "%s; VMX: %s, SMT %s\n", L1TF_DEFAULT_MSG,
-		       l1tf_vmx_states[l1tf_vmx_mitigation],
-		       sched_smt_active() ? "vulnerable" : "disabled");
+	return sysfs_emit(buf, "%s; VMX: %s, SMT %s\n", L1TF_DEFAULT_MSG,
+			  l1tf_vmx_states[l1tf_vmx_mitigation],
+			  sched_smt_active() ? "vulnerable" : "disabled");
 }
 
 static ssize_t itlb_multihit_show_state(char *buf)
 {
 	if (itlb_multihit_kvm_mitigation)
-		return sprintf(buf, "KVM: Mitigation: Split huge pages\n");
+		return sysfs_emit(buf, "KVM: Mitigation: Split huge pages\n");
 	else
-		return sprintf(buf, "KVM: Vulnerable\n");
+		return sysfs_emit(buf, "KVM: Vulnerable\n");
 }
 #else
 static ssize_t l1tf_show_state(char *buf)
 {
-	return sprintf(buf, "%s\n", L1TF_DEFAULT_MSG);
+	return sysfs_emit(buf, "%s\n", L1TF_DEFAULT_MSG);
 }
 
 static ssize_t itlb_multihit_show_state(char *buf)
 {
-	return sprintf(buf, "Processor vulnerable\n");
+	return sysfs_emit(buf, "Processor vulnerable\n");
 }
 #endif
 
 static ssize_t mds_show_state(char *buf)
 {
 	if (boot_cpu_has(X86_FEATURE_HYPERVISOR)) {
-		return sprintf(buf, "%s; SMT Host state unknown\n",
-			       mds_strings[mds_mitigation]);
+		return sysfs_emit(buf, "%s; SMT Host state unknown\n",
+				  mds_strings[mds_mitigation]);
 	}
 
 	if (boot_cpu_has(X86_BUG_MSBDS_ONLY)) {
-		return sprintf(buf, "%s; SMT %s\n", mds_strings[mds_mitigation],
-			       (mds_mitigation == MDS_MITIGATION_OFF ? "vulnerable" :
-			        sched_smt_active() ? "mitigated" : "disabled"));
+		return sysfs_emit(buf, "%s; SMT %s\n", mds_strings[mds_mitigation],
+				  (mds_mitigation == MDS_MITIGATION_OFF ? "vulnerable" :
+				   sched_smt_active() ? "mitigated" : "disabled"));
 	}
 
-	return sprintf(buf, "%s; SMT %s\n", mds_strings[mds_mitigation],
-		       sched_smt_active() ? "vulnerable" : "disabled");
+	return sysfs_emit(buf, "%s; SMT %s\n", mds_strings[mds_mitigation],
+			  sched_smt_active() ? "vulnerable" : "disabled");
 }
 
 static ssize_t tsx_async_abort_show_state(char *buf)
 {
 	if ((taa_mitigation == TAA_MITIGATION_TSX_DISABLED) ||
 	    (taa_mitigation == TAA_MITIGATION_OFF))
-		return sprintf(buf, "%s\n", taa_strings[taa_mitigation]);
+		return sysfs_emit(buf, "%s\n", taa_strings[taa_mitigation]);
 
 	if (boot_cpu_has(X86_FEATURE_HYPERVISOR)) {
-		return sprintf(buf, "%s; SMT Host state unknown\n",
-			       taa_strings[taa_mitigation]);
+		return sysfs_emit(buf, "%s; SMT Host state unknown\n",
+				  taa_strings[taa_mitigation]);
 	}
 
-	return sprintf(buf, "%s; SMT %s\n", taa_strings[taa_mitigation],
-		       sched_smt_active() ? "vulnerable" : "disabled");
+	return sysfs_emit(buf, "%s; SMT %s\n", taa_strings[taa_mitigation],
+			  sched_smt_active() ? "vulnerable" : "disabled");
 }
 
 static ssize_t mmio_stale_data_show_state(char *buf)
@@ -2217,7 +2223,8 @@ static ssize_t mmio_stale_data_show_state(char *buf)
 
 static char *stibp_state(void)
 {
-	if (spectre_v2_in_eibrs_mode(spectre_v2_enabled))
+	if (spectre_v2_in_eibrs_mode(spectre_v2_enabled) &&
+	    !boot_cpu_has(X86_FEATURE_AUTOIBRS))
 		return "";
 
 	switch (spectre_v2_user_stibp) {
@@ -2263,33 +2270,33 @@ static char *pbrsb_eibrs_state(void)
 static ssize_t spectre_v2_show_state(char *buf)
 {
 	if (spectre_v2_enabled == SPECTRE_V2_LFENCE)
-		return sprintf(buf, "Vulnerable: LFENCE\n");
+		return sysfs_emit(buf, "Vulnerable: LFENCE\n");
 
 	if (spectre_v2_enabled == SPECTRE_V2_EIBRS && unprivileged_ebpf_enabled())
-		return sprintf(buf, "Vulnerable: eIBRS with unprivileged eBPF\n");
+		return sysfs_emit(buf, "Vulnerable: eIBRS with unprivileged eBPF\n");
 
 	if (sched_smt_active() && unprivileged_ebpf_enabled() &&
 	    spectre_v2_enabled == SPECTRE_V2_EIBRS_LFENCE)
-		return sprintf(buf, "Vulnerable: eIBRS+LFENCE with unprivileged eBPF and SMT\n");
+		return sysfs_emit(buf, "Vulnerable: eIBRS+LFENCE with unprivileged eBPF and SMT\n");
 
-	return sprintf(buf, "%s%s%s%s%s%s%s\n",
-		       spectre_v2_strings[spectre_v2_enabled],
-		       ibpb_state(),
-		       boot_cpu_has(X86_FEATURE_USE_IBRS_FW) ? ", IBRS_FW" : "",
-		       stibp_state(),
-		       boot_cpu_has(X86_FEATURE_RSB_CTXSW) ? ", RSB filling" : "",
-		       pbrsb_eibrs_state(),
-		       spectre_v2_module_string());
+	return sysfs_emit(buf, "%s%s%s%s%s%s%s\n",
+			  spectre_v2_strings[spectre_v2_enabled],
+			  ibpb_state(),
+			  boot_cpu_has(X86_FEATURE_USE_IBRS_FW) ? ", IBRS_FW" : "",
+			  stibp_state(),
+			  boot_cpu_has(X86_FEATURE_RSB_CTXSW) ? ", RSB filling" : "",
+			  pbrsb_eibrs_state(),
+			  spectre_v2_module_string());
 }
 
 static ssize_t srbds_show_state(char *buf)
 {
-	return sprintf(buf, "%s\n", srbds_strings[srbds_mitigation]);
+	return sysfs_emit(buf, "%s\n", srbds_strings[srbds_mitigation]);
 }
 
 static ssize_t retbleed_show_state(char *buf)
 {
-	return sprintf(buf, "%s\n", retbleed_strings[retbleed_mitigation]);
+	return sysfs_emit(buf, "%s\n", retbleed_strings[retbleed_mitigation]);
 }
 
 static ssize_t gds_show_state(char *buf)
@@ -2301,26 +2308,26 @@ static ssize_t cpu_show_common(struct device *dev, struct device_attribute *attr
 			       char *buf, unsigned int bug)
 {
 	if (!boot_cpu_has_bug(bug))
-		return sprintf(buf, "Not affected\n");
+		return sysfs_emit(buf, "Not affected\n");
 
 	switch (bug) {
 	case X86_BUG_CPU_MELTDOWN:
 		if (boot_cpu_has(X86_FEATURE_PTI))
-			return sprintf(buf, "Mitigation: PTI\n");
+			return sysfs_emit(buf, "Mitigation: PTI\n");
 
 		if (hypervisor_is_type(X86_HYPER_XEN_PV))
-			return sprintf(buf, "Unknown (XEN PV detected, hypervisor mitigation required)\n");
+			return sysfs_emit(buf, "Unknown (XEN PV detected, hypervisor mitigation required)\n");
 
 		break;
 
 	case X86_BUG_SPECTRE_V1:
-		return sprintf(buf, "%s\n", spectre_v1_strings[spectre_v1_mitigation]);
+		return sysfs_emit(buf, "%s\n", spectre_v1_strings[spectre_v1_mitigation]);
 
 	case X86_BUG_SPECTRE_V2:
 		return spectre_v2_show_state(buf);
 
 	case X86_BUG_SPEC_STORE_BYPASS:
-		return sprintf(buf, "%s\n", ssb_strings[ssb_mode]);
+		return sysfs_emit(buf, "%s\n", ssb_strings[ssb_mode]);
 
 	case X86_BUG_L1TF:
 		if (boot_cpu_has(X86_FEATURE_L1TF_PTEINV))
@@ -2353,7 +2360,7 @@ static ssize_t cpu_show_common(struct device *dev, struct device_attribute *attr
 		break;
 	}
 
-	return sprintf(buf, "Vulnerable\n");
+	return sysfs_emit(buf, "Vulnerable\n");
 }
 
 ssize_t cpu_show_meltdown(struct device *dev, struct device_attribute *attr, char *buf)
diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.c
index d315e928b95c..86c88ecbb092 100644
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -1025,7 +1025,7 @@ static const __initconst struct x86_cpu_id cpu_vuln_whitelist[] = {
 	VULNWL_AMD(0x12,	NO_MELTDOWN | NO_SSB | NO_L1TF | NO_MDS | NO_SWAPGS | NO_ITLB_MULTIHIT | NO_MMIO),
 
 	/* FAMILY_ANY must be last, otherwise 0x0f - 0x12 matches won't work */
-	VULNWL_AMD(X86_FAMILY_ANY,	NO_MELTDOWN | NO_L1TF | NO_MDS | NO_SWAPGS | NO_ITLB_MULTIHIT | NO_MMIO),
+	VULNWL_AMD(X86_FAMILY_ANY,	NO_MELTDOWN | NO_L1TF | NO_MDS | NO_SWAPGS | NO_ITLB_MULTIHIT | NO_MMIO | NO_EIBRS_PBRSB),
 	{}
 };
 
@@ -1133,8 +1133,16 @@ static void __init cpu_set_bug_bits(struct cpuinfo_x86 *c)
 	   !cpu_has(c, X86_FEATURE_AMD_SSB_NO))
 		setup_force_cpu_bug(X86_BUG_SPEC_STORE_BYPASS);
 
-	if (ia32_cap & ARCH_CAP_IBRS_ALL)
+	/*
+	 * AMD's AutoIBRS is equivalent to Intel's eIBRS - use the Intel feature
+	 * flag and protect from vendor-specific bugs via the whitelist.
+	 */
+	if ((ia32_cap & ARCH_CAP_IBRS_ALL) || cpu_has(c, X86_FEATURE_AUTOIBRS)) {
 		setup_force_cpu_cap(X86_FEATURE_IBRS_ENHANCED);
+		if (!cpu_matches(cpu_vuln_whitelist, NO_EIBRS_PBRSB) &&
+		    !(ia32_cap & ARCH_CAP_PBRSB_NO))
+			setup_force_cpu_bug(X86_BUG_EIBRS_PBRSB);
+	}
 
 	if (!cpu_matches(cpu_vuln_whitelist, NO_MDS) &&
 	    !(ia32_cap & ARCH_CAP_MDS_NO)) {
@@ -1196,11 +1204,6 @@ static void __init cpu_set_bug_bits(struct cpuinfo_x86 *c)
 			setup_force_cpu_bug(X86_BUG_RETBLEED);
 	}
 
-	if (cpu_has(c, X86_FEATURE_IBRS_ENHANCED) &&
-	    !cpu_matches(cpu_vuln_whitelist, NO_EIBRS_PBRSB) &&
-	    !(ia32_cap & ARCH_CAP_PBRSB_NO))
-		setup_force_cpu_bug(X86_BUG_EIBRS_PBRSB);
-
 	/*
 	 * Check if CPU is vulnerable to GDS. If running in a virtual machine on
 	 * an affected processor, the VMM may have disabled the use of GATHER by
diff --git a/arch/x86/mm/ident_map.c b/arch/x86/mm/ident_map.c
index f50cc210a981..968d7005f4a7 100644
--- a/arch/x86/mm/ident_map.c
+++ b/arch/x86/mm/ident_map.c
@@ -26,31 +26,18 @@ static int ident_pud_init(struct x86_mapping_info *info, pud_t *pud_page,
 	for (; addr < end; addr = next) {
 		pud_t *pud = pud_page + pud_index(addr);
 		pmd_t *pmd;
-		bool use_gbpage;
 
 		next = (addr & PUD_MASK) + PUD_SIZE;
 		if (next > end)
 			next = end;
 
-		/* if this is already a gbpage, this portion is already mapped */
-		if (pud_large(*pud))
-			continue;
-
-		/* Is using a gbpage allowed? */
-		use_gbpage = info->direct_gbpages;
-
-		/* Don't use gbpage if it maps more than the requested region. */
-		/* at the begining: */
-		use_gbpage &= ((addr & ~PUD_MASK) == 0);
-		/* ... or at the end: */
-		use_gbpage &= ((next & ~PUD_MASK) == 0);
-
-		/* Never overwrite existing mappings */
-		use_gbpage &= !pud_present(*pud);
-
-		if (use_gbpage) {
+		if (info->direct_gbpages) {
 			pud_t pudval;
 
+			if (pud_present(*pud))
+				continue;
+
+			addr &= PUD_MASK;
 			pudval = __pud((addr - info->offset) | info->page_flag);
 			set_pud(pud, pudval);
 			continue;
diff --git a/arch/x86/mm/pat.c b/arch/x86/mm/pat.c
index b33304c0042a..3467dbf085ae 100644
--- a/arch/x86/mm/pat.c
+++ b/arch/x86/mm/pat.c
@@ -33,6 +33,7 @@
 
 #include "pat_internal.h"
 #include "mm_internal.h"
+#include "../../mm/internal.h"	/* is_cow_mapping() */
 
 #undef pr_fmt
 #define pr_fmt(fmt) "" fmt
@@ -954,6 +955,38 @@ static void free_pfn_range(u64 paddr, unsigned long size)
 		free_memtype(paddr, paddr + size);
 }
 
+static int get_pat_info(struct vm_area_struct *vma, resource_size_t *paddr,
+		pgprot_t *pgprot)
+{
+	unsigned long prot;
+
+	VM_WARN_ON_ONCE(!(vma->vm_flags & VM_PAT));
+
+	/*
+	 * We need the starting PFN and cachemode used for track_pfn_remap()
+	 * that covered the whole VMA. For most mappings, we can obtain that
+	 * information from the page tables. For COW mappings, we might now
+	 * suddenly have anon folios mapped and follow_phys() will fail.
+	 *
+	 * Fallback to using vma->vm_pgoff, see remap_pfn_range_notrack(), to
+	 * detect the PFN. If we need the cachemode as well, we're out of luck
+	 * for now and have to fail fork().
+	 */
+	if (!follow_phys(vma, vma->vm_start, 0, &prot, paddr)) {
+		if (pgprot)
+			*pgprot = __pgprot(prot);
+		return 0;
+	}
+	if (is_cow_mapping(vma->vm_flags)) {
+		if (pgprot)
+			return -EINVAL;
+		*paddr = (resource_size_t)vma->vm_pgoff << PAGE_SHIFT;
+		return 0;
+	}
+	WARN_ON_ONCE(1);
+	return -EINVAL;
+}
+
 /*
  * track_pfn_copy is called when vma that is covering the pfnmap gets
  * copied through copy_page_range().
@@ -964,20 +997,13 @@ static void free_pfn_range(u64 paddr, unsigned long size)
 int track_pfn_copy(struct vm_area_struct *vma)
 {
 	resource_size_t paddr;
-	unsigned long prot;
 	unsigned long vma_size = vma->vm_end - vma->vm_start;
 	pgprot_t pgprot;
 
 	if (vma->vm_flags & VM_PAT) {
-		/*
-		 * reserve the whole chunk covered by vma. We need the
-		 * starting address and protection from pte.
-		 */
-		if (follow_phys(vma, vma->vm_start, 0, &prot, &paddr)) {
-			WARN_ON_ONCE(1);
+		if (get_pat_info(vma, &paddr, &pgprot))
 			return -EINVAL;
-		}
-		pgprot = __pgprot(prot);
+		/* reserve the whole chunk covered by vma. */
 		return reserve_pfn_range(paddr, vma_size, &pgprot, 1);
 	}
 
@@ -1052,7 +1078,6 @@ void untrack_pfn(struct vm_area_struct *vma, unsigned long pfn,
 		 unsigned long size)
 {
 	resource_size_t paddr;
-	unsigned long prot;
 
 	if (vma && !(vma->vm_flags & VM_PAT))
 		return;
@@ -1060,11 +1085,8 @@ void untrack_pfn(struct vm_area_struct *vma, unsigned long pfn,
 	/* free the chunk starting from pfn or the whole chunk */
 	paddr = (resource_size_t)pfn << PAGE_SHIFT;
 	if (!paddr && !size) {
-		if (follow_phys(vma, vma->vm_start, 0, &prot, &paddr)) {
-			WARN_ON_ONCE(1);
+		if (get_pat_info(vma, &paddr, NULL))
 			return;
-		}
-
 		size = vma->vm_end - vma->vm_start;
 	}
 	free_pfn_range(paddr, size);
diff --git a/block/blk-stat.c b/block/blk-stat.c
index 7587b1c3caaf..507ac714423b 100644
--- a/block/blk-stat.c
+++ b/block/blk-stat.c
@@ -27,7 +27,7 @@ void blk_rq_stat_init(struct blk_rq_stat *stat)
 /* src is a per-cpu stat, mean isn't initialized */
 void blk_rq_stat_sum(struct blk_rq_stat *dst, struct blk_rq_stat *src)
 {
-	if (!src->nr_samples)
+	if (dst->nr_samples + src->nr_samples <= dst->nr_samples)
 		return;
 
 	dst->min = min(dst->min, src->min);
diff --git a/drivers/ata/ahci.c b/drivers/ata/ahci.c
index abdfd440987b..ab3ea47ecce3 100644
--- a/drivers/ata/ahci.c
+++ b/drivers/ata/ahci.c
@@ -634,11 +634,6 @@ MODULE_PARM_DESC(mobile_lpm_policy, "Default LPM policy for mobile chipsets");
 static void ahci_pci_save_initial_config(struct pci_dev *pdev,
 					 struct ahci_host_priv *hpriv)
 {
-	if (pdev->vendor == PCI_VENDOR_ID_ASMEDIA && pdev->device == 0x1166) {
-		dev_info(&pdev->dev, "ASM1166 has only six ports\n");
-		hpriv->saved_port_map = 0x3f;
-	}
-
 	if (pdev->vendor == PCI_VENDOR_ID_JMICRON && pdev->device == 0x2361) {
 		dev_info(&pdev->dev, "JMB361 has only one port\n");
 		hpriv->force_port_map = 1;
diff --git a/drivers/ata/sata_mv.c b/drivers/ata/sata_mv.c
index 84ea284502d5..001656642fff 100644
--- a/drivers/ata/sata_mv.c
+++ b/drivers/ata/sata_mv.c
@@ -796,37 +796,6 @@ static const struct ata_port_info mv_port_info[] = {
 	},
 };
 
-static const struct pci_device_id mv_pci_tbl[] = {
-	{ PCI_VDEVICE(MARVELL, 0x5040), chip_504x },
-	{ PCI_VDEVICE(MARVELL, 0x5041), chip_504x },
-	{ PCI_VDEVICE(MARVELL, 0x5080), chip_5080 },
-	{ PCI_VDEVICE(MARVELL, 0x5081), chip_508x },
-	/* RocketRAID 1720/174x have different identifiers */
-	{ PCI_VDEVICE(TTI, 0x1720), chip_6042 },
-	{ PCI_VDEVICE(TTI, 0x1740), chip_6042 },
-	{ PCI_VDEVICE(TTI, 0x1742), chip_6042 },
-
-	{ PCI_VDEVICE(MARVELL, 0x6040), chip_604x },
-	{ PCI_VDEVICE(MARVELL, 0x6041), chip_604x },
-	{ PCI_VDEVICE(MARVELL, 0x6042), chip_6042 },
-	{ PCI_VDEVICE(MARVELL, 0x6080), chip_608x },
-	{ PCI_VDEVICE(MARVELL, 0x6081), chip_608x },
-
-	{ PCI_VDEVICE(ADAPTEC2, 0x0241), chip_604x },
-
-	/* Adaptec 1430SA */
-	{ PCI_VDEVICE(ADAPTEC2, 0x0243), chip_7042 },
-
-	/* Marvell 7042 support */
-	{ PCI_VDEVICE(MARVELL, 0x7042), chip_7042 },
-
-	/* Highpoint RocketRAID PCIe series */
-	{ PCI_VDEVICE(TTI, 0x2300), chip_7042 },
-	{ PCI_VDEVICE(TTI, 0x2310), chip_7042 },
-
-	{ }			/* terminate list */
-};
-
 static const struct mv_hw_ops mv5xxx_ops = {
 	.phy_errata		= mv5_phy_errata,
 	.enable_leds		= mv5_enable_leds,
@@ -4320,6 +4289,36 @@ static int mv_pci_init_one(struct pci_dev *pdev,
 static int mv_pci_device_resume(struct pci_dev *pdev);
 #endif
 
+static const struct pci_device_id mv_pci_tbl[] = {
+	{ PCI_VDEVICE(MARVELL, 0x5040), chip_504x },
+	{ PCI_VDEVICE(MARVELL, 0x5041), chip_504x },
+	{ PCI_VDEVICE(MARVELL, 0x5080), chip_5080 },
+	{ PCI_VDEVICE(MARVELL, 0x5081), chip_508x },
+	/* RocketRAID 1720/174x have different identifiers */
+	{ PCI_VDEVICE(TTI, 0x1720), chip_6042 },
+	{ PCI_VDEVICE(TTI, 0x1740), chip_6042 },
+	{ PCI_VDEVICE(TTI, 0x1742), chip_6042 },
+
+	{ PCI_VDEVICE(MARVELL, 0x6040), chip_604x },
+	{ PCI_VDEVICE(MARVELL, 0x6041), chip_604x },
+	{ PCI_VDEVICE(MARVELL, 0x6042), chip_6042 },
+	{ PCI_VDEVICE(MARVELL, 0x6080), chip_608x },
+	{ PCI_VDEVICE(MARVELL, 0x6081), chip_608x },
+
+	{ PCI_VDEVICE(ADAPTEC2, 0x0241), chip_604x },
+
+	/* Adaptec 1430SA */
+	{ PCI_VDEVICE(ADAPTEC2, 0x0243), chip_7042 },
+
+	/* Marvell 7042 support */
+	{ PCI_VDEVICE(MARVELL, 0x7042), chip_7042 },
+
+	/* Highpoint RocketRAID PCIe series */
+	{ PCI_VDEVICE(TTI, 0x2300), chip_7042 },
+	{ PCI_VDEVICE(TTI, 0x2310), chip_7042 },
+
+	{ }			/* terminate list */
+};
 
 static struct pci_driver mv_pci_driver = {
 	.name			= DRV_NAME,
@@ -4332,6 +4331,7 @@ static struct pci_driver mv_pci_driver = {
 #endif
 
 };
+MODULE_DEVICE_TABLE(pci, mv_pci_tbl);
 
 /* move to PCI layer or libata core? */
 static int pci_go_64(struct pci_dev *pdev)
@@ -4534,7 +4534,6 @@ static void __exit mv_exit(void)
 MODULE_AUTHOR("Brett Russ");
 MODULE_DESCRIPTION("SCSI low-level driver for Marvell SATA controllers");
 MODULE_LICENSE("GPL v2");
-MODULE_DEVICE_TABLE(pci, mv_pci_tbl);
 MODULE_VERSION(DRV_VERSION);
 MODULE_ALIAS("platform:" DRV_NAME);
 
diff --git a/drivers/ata/sata_sx4.c b/drivers/ata/sata_sx4.c
index 0d742457925e..f217ac8e17b1 100644
--- a/drivers/ata/sata_sx4.c
+++ b/drivers/ata/sata_sx4.c
@@ -1020,8 +1020,7 @@ static void pdc20621_get_from_dimm(struct ata_host *host, void *psource,
 
 	offset -= (idx * window_size);
 	idx++;
-	dist = ((long) (window_size - (offset + size))) >= 0 ? size :
-		(long) (window_size - offset);
+	dist = min(size, window_size - offset);
 	memcpy_fromio(psource, dimm_mmio + offset / 4, dist);
 
 	psource += dist;
@@ -1069,8 +1068,7 @@ static void pdc20621_put_to_dimm(struct ata_host *host, void *psource,
 	readl(mmio + PDC_DIMM_WINDOW_CTLR);
 	offset -= (idx * window_size);
 	idx++;
-	dist = ((long)(s32)(window_size - (offset + size))) >= 0 ? size :
-		(long) (window_size - offset);
+	dist = min(size, window_size - offset);
 	memcpy_toio(dimm_mmio + offset / 4, psource, dist);
 	writel(0x01, mmio + PDC_GENERAL_CTLR);
 	readl(mmio + PDC_GENERAL_CTLR);
diff --git a/drivers/base/power/wakeirq.c b/drivers/base/power/wakeirq.c
index e7ba51499916..bc3637b45cbf 100644
--- a/drivers/base/power/wakeirq.c
+++ b/drivers/base/power/wakeirq.c
@@ -376,8 +376,10 @@ void dev_pm_enable_wake_irq_complete(struct device *dev)
 		return;
 
 	if (wirq->status & WAKE_IRQ_DEDICATED_MANAGED &&
-	    wirq->status & WAKE_IRQ_DEDICATED_REVERSE)
+	    wirq->status & WAKE_IRQ_DEDICATED_REVERSE) {
 		enable_irq(wirq->irq);
+		wirq->status |= WAKE_IRQ_DEDICATED_ENABLED;
+	}
 }
 
 /**
diff --git a/drivers/block/loop.c b/drivers/block/loop.c
index 2e6c3f658894..6050b039e4d2 100644
--- a/drivers/block/loop.c
+++ b/drivers/block/loop.c
@@ -225,24 +225,30 @@ static void __loop_update_dio(struct loop_device *lo, bool dio)
 	blk_mq_unfreeze_queue(lo->lo_queue);
 }
 
-static int
-figure_loop_size(struct loop_device *lo, loff_t offset, loff_t sizelimit)
+/**
+ * loop_set_size() - sets device size and notifies userspace
+ * @lo: struct loop_device to set the size for
+ * @size: new size of the loop device
+ *
+ * Callers must validate that the size passed into this function fits into
+ * a sector_t, eg using loop_validate_size()
+ */
+static void loop_set_size(struct loop_device *lo, loff_t size)
 {
-	loff_t size = get_size(offset, sizelimit, lo->lo_backing_file);
-	sector_t x = (sector_t)size;
 	struct block_device *bdev = lo->lo_device;
 
-	if (unlikely((loff_t)x != size))
-		return -EFBIG;
-	if (lo->lo_offset != offset)
-		lo->lo_offset = offset;
-	if (lo->lo_sizelimit != sizelimit)
-		lo->lo_sizelimit = sizelimit;
-	set_capacity(lo->lo_disk, x);
-	bd_set_size(bdev, (loff_t)get_capacity(bdev->bd_disk) << 9);
+	set_capacity(lo->lo_disk, size);
+	bd_set_size(bdev, size << SECTOR_SHIFT);
 	/* let user-space know about the new size */
 	kobject_uevent(&disk_to_dev(bdev->bd_disk)->kobj, KOBJ_CHANGE);
-	return 0;
+}
+
+static void
+figure_loop_size(struct loop_device *lo, loff_t offset, loff_t sizelimit)
+{
+	loff_t size = get_size(offset, sizelimit, lo->lo_backing_file);
+
+	loop_set_size(lo, size);
 }
 
 static inline int
@@ -934,6 +940,24 @@ static int loop_prepare_queue(struct loop_device *lo)
 	return 0;
 }
 
+static void loop_update_rotational(struct loop_device *lo)
+{
+	struct file *file = lo->lo_backing_file;
+	struct inode *file_inode = file->f_mapping->host;
+	struct block_device *file_bdev = file_inode->i_sb->s_bdev;
+	struct request_queue *q = lo->lo_queue;
+	bool nonrot = true;
+
+	/* not all filesystems (e.g. tmpfs) have a sb->s_bdev */
+	if (file_bdev)
+		nonrot = blk_queue_nonrot(bdev_get_queue(file_bdev));
+
+	if (nonrot)
+		blk_queue_flag_set(QUEUE_FLAG_NONROT, q);
+	else
+		blk_queue_flag_clear(QUEUE_FLAG_NONROT, q);
+}
+
 static int loop_set_fd(struct loop_device *lo, fmode_t mode,
 		       struct block_device *bdev, unsigned int arg)
 {
@@ -972,10 +996,8 @@ static int loop_set_fd(struct loop_device *lo, fmode_t mode,
 	    !file->f_op->write_iter)
 		lo_flags |= LO_FLAGS_READ_ONLY;
 
-	error = -EFBIG;
 	size = get_loop_size(lo, file);
-	if ((loff_t)(sector_t)size != size)
-		goto out_unlock;
+
 	error = loop_prepare_queue(lo);
 	if (error)
 		goto out_unlock;
@@ -997,12 +1019,10 @@ static int loop_set_fd(struct loop_device *lo, fmode_t mode,
 	if (!(lo_flags & LO_FLAGS_READ_ONLY) && file->f_op->fsync)
 		blk_queue_write_cache(lo->lo_queue, true, false);
 
+	loop_update_rotational(lo);
 	loop_update_dio(lo);
-	set_capacity(lo->lo_disk, size);
-	bd_set_size(bdev, size << 9);
 	loop_sysfs_init(lo);
-	/* let user-space know about the new size */
-	kobject_uevent(&disk_to_dev(bdev->bd_disk)->kobj, KOBJ_CHANGE);
+	loop_set_size(lo, size);
 
 	set_blocksize(bdev, S_ISBLK(inode->i_mode) ?
 		      block_size(inode->i_bdev) : PAGE_SIZE);
@@ -1211,82 +1231,50 @@ static int loop_clr_fd(struct loop_device *lo)
 	return __loop_clr_fd(lo, false);
 }
 
+/**
+ * loop_set_status_from_info - configure device from loop_info
+ * @lo: struct loop_device to configure
+ * @info: struct loop_info64 to configure the device with
+ *
+ * Configures the loop device parameters according to the passed
+ * in loop_info64 configuration.
+ */
 static int
-loop_set_status(struct loop_device *lo, const struct loop_info64 *info)
+loop_set_status_from_info(struct loop_device *lo,
+			  const struct loop_info64 *info)
 {
 	int err;
 	struct loop_func_table *xfer;
 	kuid_t uid = current_uid();
-	struct block_device *bdev;
-	bool partscan = false;
 
-	err = mutex_lock_killable(&loop_ctl_mutex);
-	if (err)
-		return err;
-	if (lo->lo_encrypt_key_size &&
-	    !uid_eq(lo->lo_key_owner, uid) &&
-	    !capable(CAP_SYS_ADMIN)) {
-		err = -EPERM;
-		goto out_unlock;
-	}
-	if (lo->lo_state != Lo_bound) {
-		err = -ENXIO;
-		goto out_unlock;
-	}
-	if ((unsigned int) info->lo_encrypt_key_size > LO_KEY_SIZE) {
-		err = -EINVAL;
-		goto out_unlock;
-	}
-
-	if (lo->lo_offset != info->lo_offset ||
-	    lo->lo_sizelimit != info->lo_sizelimit) {
-		sync_blockdev(lo->lo_device);
-		invalidate_bdev(lo->lo_device);
-	}
-
-	/* I/O need to be drained during transfer transition */
-	blk_mq_freeze_queue(lo->lo_queue);
+	if ((unsigned int) info->lo_encrypt_key_size > LO_KEY_SIZE)
+		return -EINVAL;
 
 	err = loop_release_xfer(lo);
 	if (err)
-		goto out_unfreeze;
+		return err;
 
 	if (info->lo_encrypt_type) {
 		unsigned int type = info->lo_encrypt_type;
 
-		if (type >= MAX_LO_CRYPT) {
-			err = -EINVAL;
-			goto out_unfreeze;
-		}
+		if (type >= MAX_LO_CRYPT)
+			return -EINVAL;
 		xfer = xfer_funcs[type];
-		if (xfer == NULL) {
-			err = -EINVAL;
-			goto out_unfreeze;
-		}
+		if (xfer == NULL)
+			return -EINVAL;
 	} else
 		xfer = NULL;
 
 	err = loop_init_xfer(lo, xfer, info);
 	if (err)
-		goto out_unfreeze;
+		return err;
 
-	if (lo->lo_offset != info->lo_offset ||
-	    lo->lo_sizelimit != info->lo_sizelimit) {
-		/* kill_bdev should have truncated all the pages */
-		if (lo->lo_device->bd_inode->i_mapping->nrpages) {
-			err = -EAGAIN;
-			pr_warn("%s: loop%d (%s) has still dirty pages (nrpages=%lu)\n",
-				__func__, lo->lo_number, lo->lo_file_name,
-				lo->lo_device->bd_inode->i_mapping->nrpages);
-			goto out_unfreeze;
-		}
-		if (figure_loop_size(lo, info->lo_offset, info->lo_sizelimit)) {
-			err = -EFBIG;
-			goto out_unfreeze;
-		}
-	}
+	/* Avoid assigning overflow values */
+	if (info->lo_offset > LLONG_MAX || info->lo_sizelimit > LLONG_MAX)
+		return -EOVERFLOW;
 
-	loop_config_discard(lo);
+	lo->lo_offset = info->lo_offset;
+	lo->lo_sizelimit = info->lo_sizelimit;
 
 	memcpy(lo->lo_file_name, info->lo_file_name, LO_NAME_SIZE);
 	memcpy(lo->lo_crypt_name, info->lo_crypt_name, LO_NAME_SIZE);
@@ -1311,6 +1299,63 @@ loop_set_status(struct loop_device *lo, const struct loop_info64 *info)
 		lo->lo_key_owner = uid;
 	}
 
+	return 0;
+}
+
+static int
+loop_set_status(struct loop_device *lo, const struct loop_info64 *info)
+{
+	int err;
+	struct block_device *bdev;
+	kuid_t uid = current_uid();
+	bool partscan = false;
+	bool size_changed = false;
+
+	err = mutex_lock_killable(&loop_ctl_mutex);
+	if (err)
+		return err;
+	if (lo->lo_encrypt_key_size &&
+	    !uid_eq(lo->lo_key_owner, uid) &&
+	    !capable(CAP_SYS_ADMIN)) {
+		err = -EPERM;
+		goto out_unlock;
+	}
+	if (lo->lo_state != Lo_bound) {
+		err = -ENXIO;
+		goto out_unlock;
+	}
+
+	if (lo->lo_offset != info->lo_offset ||
+	    lo->lo_sizelimit != info->lo_sizelimit) {
+		size_changed = true;
+		sync_blockdev(lo->lo_device);
+		invalidate_bdev(lo->lo_device);
+	}
+
+	/* I/O need to be drained during transfer transition */
+	blk_mq_freeze_queue(lo->lo_queue);
+
+	if (size_changed && lo->lo_device->bd_inode->i_mapping->nrpages) {
+		/* If any pages were dirtied after invalidate_bdev(), try again */
+		err = -EAGAIN;
+		pr_warn("%s: loop%d (%s) has still dirty pages (nrpages=%lu)\n",
+			__func__, lo->lo_number, lo->lo_file_name,
+			lo->lo_device->bd_inode->i_mapping->nrpages);
+		goto out_unfreeze;
+	}
+
+	err = loop_set_status_from_info(lo, info);
+	if (err)
+		goto out_unfreeze;
+
+	if (size_changed) {
+		loff_t new_size = get_size(lo->lo_offset, lo->lo_sizelimit,
+					   lo->lo_backing_file);
+		loop_set_size(lo, new_size);
+	}
+
+	loop_config_discard(lo);
+
 	/* update dio if lo_offset or transfer is changed */
 	__loop_update_dio(lo, lo->use_dio);
 
@@ -1351,11 +1396,6 @@ loop_get_status(struct loop_device *lo, struct loop_info64 *info)
 	info->lo_number = lo->lo_number;
 	info->lo_offset = lo->lo_offset;
 	info->lo_sizelimit = lo->lo_sizelimit;
-
-	/* loff_t vars have been assigned __u64 */
-	if (lo->lo_offset < 0 || lo->lo_sizelimit < 0)
-		return -EOVERFLOW;
-
 	info->lo_flags = lo->lo_flags;
 	memcpy(info->lo_file_name, lo->lo_file_name, LO_NAME_SIZE);
 	memcpy(info->lo_crypt_name, lo->lo_crypt_name, LO_NAME_SIZE);
@@ -1491,7 +1531,9 @@ static int loop_set_capacity(struct loop_device *lo)
 	if (unlikely(lo->lo_state != Lo_bound))
 		return -ENXIO;
 
-	return figure_loop_size(lo, lo->lo_offset, lo->lo_sizelimit);
+	figure_loop_size(lo, lo->lo_offset, lo->lo_sizelimit);
+
+	return 0;
 }
 
 static int loop_set_dio(struct loop_device *lo, unsigned long arg)
diff --git a/drivers/bluetooth/btintel.c b/drivers/bluetooth/btintel.c
index 5270d5513201..360daa3f8059 100644
--- a/drivers/bluetooth/btintel.c
+++ b/drivers/bluetooth/btintel.c
@@ -361,7 +361,7 @@ int btintel_read_version(struct hci_dev *hdev, struct intel_version *ver)
 		return PTR_ERR(skb);
 	}
 
-	if (skb->len != sizeof(*ver)) {
+	if (!skb || skb->len != sizeof(*ver)) {
 		bt_dev_err(hdev, "Intel version event size mismatch");
 		kfree_skb(skb);
 		return -EILSEQ;
diff --git a/drivers/clk/qcom/gcc-ipq8074.c b/drivers/clk/qcom/gcc-ipq8074.c
index eff38d22738c..e38a1f87263b 100644
--- a/drivers/clk/qcom/gcc-ipq8074.c
+++ b/drivers/clk/qcom/gcc-ipq8074.c
@@ -980,6 +980,7 @@ static struct clk_rcg2 pcie0_axi_clk_src = {
 
 static const struct freq_tbl ftbl_pcie_aux_clk_src[] = {
 	F(19200000, P_XO, 1, 0, 0),
+	{ }
 };
 
 static struct clk_rcg2 pcie0_aux_clk_src = {
@@ -1085,6 +1086,7 @@ static const struct freq_tbl ftbl_sdcc_ice_core_clk_src[] = {
 	F(19200000, P_XO, 1, 0, 0),
 	F(160000000, P_GPLL0, 5, 0, 0),
 	F(308570000, P_GPLL6, 3.5, 0, 0),
+	{ }
 };
 
 static struct clk_rcg2 sdcc1_ice_core_clk_src = {
diff --git a/drivers/clk/qcom/mmcc-apq8084.c b/drivers/clk/qcom/mmcc-apq8084.c
index 4ce1d7c88377..36a40b0ddfa1 100644
--- a/drivers/clk/qcom/mmcc-apq8084.c
+++ b/drivers/clk/qcom/mmcc-apq8084.c
@@ -341,6 +341,7 @@ static struct freq_tbl ftbl_mmss_axi_clk[] = {
 	F(333430000, P_MMPLL1, 3.5, 0, 0),
 	F(400000000, P_MMPLL0, 2, 0, 0),
 	F(466800000, P_MMPLL1, 2.5, 0, 0),
+	{ }
 };
 
 static struct clk_rcg2 mmss_axi_clk_src = {
@@ -365,6 +366,7 @@ static struct freq_tbl ftbl_ocmemnoc_clk[] = {
 	F(150000000, P_GPLL0, 4, 0, 0),
 	F(228570000, P_MMPLL0, 3.5, 0, 0),
 	F(320000000, P_MMPLL0, 2.5, 0, 0),
+	{ }
 };
 
 static struct clk_rcg2 ocmemnoc_clk_src = {
diff --git a/drivers/clk/qcom/mmcc-msm8974.c b/drivers/clk/qcom/mmcc-msm8974.c
index 91818516c3e0..124d21f19e2c 100644
--- a/drivers/clk/qcom/mmcc-msm8974.c
+++ b/drivers/clk/qcom/mmcc-msm8974.c
@@ -291,6 +291,7 @@ static struct freq_tbl ftbl_mmss_axi_clk[] = {
 	F(291750000, P_MMPLL1, 4, 0, 0),
 	F(400000000, P_MMPLL0, 2, 0, 0),
 	F(466800000, P_MMPLL1, 2.5, 0, 0),
+	{ }
 };
 
 static struct clk_rcg2 mmss_axi_clk_src = {
@@ -315,6 +316,7 @@ static struct freq_tbl ftbl_ocmemnoc_clk[] = {
 	F(150000000, P_GPLL0, 4, 0, 0),
 	F(291750000, P_MMPLL1, 4, 0, 0),
 	F(400000000, P_MMPLL0, 2, 0, 0),
+	{ }
 };
 
 static struct clk_rcg2 ocmemnoc_clk_src = {
diff --git a/drivers/crypto/qat/qat_common/adf_aer.c b/drivers/crypto/qat/qat_common/adf_aer.c
index 9225d060e18f..7242a1ee86de 100644
--- a/drivers/crypto/qat/qat_common/adf_aer.c
+++ b/drivers/crypto/qat/qat_common/adf_aer.c
@@ -139,18 +139,28 @@ static void adf_device_reset_worker(struct work_struct *work)
 	if (adf_dev_init(accel_dev) || adf_dev_start(accel_dev)) {
 		/* The device hanged and we can't restart it so stop here */
 		dev_err(&GET_DEV(accel_dev), "Restart device failed\n");
-		kfree(reset_data);
+		if (reset_data->mode == ADF_DEV_RESET_ASYNC ||
+		    completion_done(&reset_data->compl))
+			kfree(reset_data);
 		WARN(1, "QAT: device restart failed. Device is unusable\n");
 		return;
 	}
 	adf_dev_restarted_notify(accel_dev);
 	clear_bit(ADF_STATUS_RESTARTING, &accel_dev->status);
 
-	/* The dev is back alive. Notify the caller if in sync mode */
-	if (reset_data->mode == ADF_DEV_RESET_SYNC)
-		complete(&reset_data->compl);
-	else
+	/*
+	 * The dev is back alive. Notify the caller if in sync mode
+	 *
+	 * If device restart will take a more time than expected,
+	 * the schedule_reset() function can timeout and exit. This can be
+	 * detected by calling the completion_done() function. In this case
+	 * the reset_data structure needs to be freed here.
+	 */
+	if (reset_data->mode == ADF_DEV_RESET_ASYNC ||
+	    completion_done(&reset_data->compl))
 		kfree(reset_data);
+	else
+		complete(&reset_data->compl);
 }
 
 static int adf_dev_aer_schedule_reset(struct adf_accel_dev *accel_dev,
@@ -183,8 +193,9 @@ static int adf_dev_aer_schedule_reset(struct adf_accel_dev *accel_dev,
 			dev_err(&GET_DEV(accel_dev),
 				"Reset device timeout expired\n");
 			ret = -EFAULT;
+		} else {
+			kfree(reset_data);
 		}
-		kfree(reset_data);
 		return ret;
 	}
 	return 0;
diff --git a/drivers/firmware/efi/vars.c b/drivers/firmware/efi/vars.c
index e619ced030d5..88c3f894f1f1 100644
--- a/drivers/firmware/efi/vars.c
+++ b/drivers/firmware/efi/vars.c
@@ -440,7 +440,7 @@ int efivar_init(int (*func)(efi_char16_t *, efi_guid_t, unsigned long, void *),
 		void *data, bool duplicates, struct list_head *head)
 {
 	const struct efivar_operations *ops;
-	unsigned long variable_name_size = 1024;
+	unsigned long variable_name_size = 512;
 	efi_char16_t *variable_name;
 	efi_status_t status;
 	efi_guid_t vendor_guid;
@@ -463,12 +463,13 @@ int efivar_init(int (*func)(efi_char16_t *, efi_guid_t, unsigned long, void *),
 	}
 
 	/*
-	 * Per EFI spec, the maximum storage allocated for both
-	 * the variable name and variable data is 1024 bytes.
+	 * A small set of old UEFI implementations reject sizes
+	 * above a certain threshold, the lowest seen in the wild
+	 * is 512.
 	 */
 
 	do {
-		variable_name_size = 1024;
+		variable_name_size = 512;
 
 		status = ops->get_next_variable(&variable_name_size,
 						variable_name,
@@ -512,9 +513,13 @@ int efivar_init(int (*func)(efi_char16_t *, efi_guid_t, unsigned long, void *),
 			break;
 		case EFI_NOT_FOUND:
 			break;
+		case EFI_BUFFER_TOO_SMALL:
+			pr_warn("efivars: Variable name size exceeds maximum (%lu > 512)\n",
+				variable_name_size);
+			status = EFI_NOT_FOUND;
+			break;
 		default:
-			printk(KERN_WARNING "efivars: get_next_variable: status=%lx\n",
-				status);
+			pr_warn("efivars: get_next_variable: status=%lx\n", status);
 			status = EFI_NOT_FOUND;
 			break;
 		}
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
index 297b36c26a05..840dfe8524e4 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
@@ -923,8 +923,8 @@ static int kfd_ioctl_get_process_apertures_new(struct file *filp,
 	 * nodes, but not more than args->num_of_nodes as that is
 	 * the amount of memory allocated by user
 	 */
-	pa = kzalloc((sizeof(struct kfd_process_device_apertures) *
-				args->num_of_nodes), GFP_KERNEL);
+	pa = kcalloc(args->num_of_nodes, sizeof(struct kfd_process_device_apertures),
+		     GFP_KERNEL);
 	if (!pa)
 		return -ENOMEM;
 
diff --git a/drivers/gpu/drm/amd/display/modules/inc/mod_stats.h b/drivers/gpu/drm/amd/display/modules/inc/mod_stats.h
index 3812094b52e8..88b312c3eb43 100644
--- a/drivers/gpu/drm/amd/display/modules/inc/mod_stats.h
+++ b/drivers/gpu/drm/amd/display/modules/inc/mod_stats.h
@@ -51,10 +51,10 @@ void mod_stats_update_event(struct mod_stats *mod_stats,
 		unsigned int length);
 
 void mod_stats_update_flip(struct mod_stats *mod_stats,
-		unsigned long timestamp_in_ns);
+		unsigned long long timestamp_in_ns);
 
 void mod_stats_update_vupdate(struct mod_stats *mod_stats,
-		unsigned long timestamp_in_ns);
+		unsigned long long timestamp_in_ns);
 
 void mod_stats_update_freesync(struct mod_stats *mod_stats,
 		unsigned int v_total_min,
diff --git a/drivers/gpu/drm/imx/parallel-display.c b/drivers/gpu/drm/imx/parallel-display.c
index e9dff31b377c..585db8961705 100644
--- a/drivers/gpu/drm/imx/parallel-display.c
+++ b/drivers/gpu/drm/imx/parallel-display.c
@@ -72,14 +72,14 @@ static int imx_pd_connector_get_modes(struct drm_connector *connector)
 		int ret;
 
 		if (!mode)
-			return -EINVAL;
+			return 0;
 
 		ret = of_get_drm_display_mode(np, &imxpd->mode,
 					      &imxpd->bus_flags,
 					      OF_USE_NATIVE_MODE);
 		if (ret) {
 			drm_mode_destroy(connector->dev, mode);
-			return ret;
+			return 0;
 		}
 
 		drm_mode_copy(mode, &imxpd->mode);
diff --git a/drivers/gpu/drm/vc4/vc4_hdmi.c b/drivers/gpu/drm/vc4/vc4_hdmi.c
index 116166266457..013dfc63c824 100644
--- a/drivers/gpu/drm/vc4/vc4_hdmi.c
+++ b/drivers/gpu/drm/vc4/vc4_hdmi.c
@@ -276,7 +276,7 @@ static int vc4_hdmi_connector_get_modes(struct drm_connector *connector)
 	edid = drm_get_edid(connector, vc4->hdmi->ddc);
 	cec_s_phys_addr_from_edid(vc4->hdmi->cec_adap, edid);
 	if (!edid)
-		return -ENODEV;
+		return 0;
 
 	vc4_encoder->hdmi_monitor = drm_detect_hdmi_monitor(edid);
 
diff --git a/drivers/gpu/drm/vkms/vkms_drv.c b/drivers/gpu/drm/vkms/vkms_drv.c
index b1201c18d3eb..d32e08f17427 100644
--- a/drivers/gpu/drm/vkms/vkms_drv.c
+++ b/drivers/gpu/drm/vkms/vkms_drv.c
@@ -39,7 +39,6 @@ static void vkms_release(struct drm_device *dev)
 	struct vkms_device *vkms = container_of(dev, struct vkms_device, drm);
 
 	platform_device_unregister(vkms->platform);
-	drm_atomic_helper_shutdown(&vkms->drm);
 	drm_mode_config_cleanup(&vkms->drm);
 	drm_dev_fini(&vkms->drm);
 }
@@ -137,6 +136,7 @@ static void __exit vkms_exit(void)
 	}
 
 	drm_dev_unregister(&vkms_device->drm);
+	drm_atomic_helper_shutdown(&vkms_device->drm);
 	drm_dev_put(&vkms_device->drm);
 
 	kfree(vkms_device);
diff --git a/drivers/hwmon/amc6821.c b/drivers/hwmon/amc6821.c
index 46b4e35fd555..b562337df7b3 100644
--- a/drivers/hwmon/amc6821.c
+++ b/drivers/hwmon/amc6821.c
@@ -1003,10 +1003,21 @@ static const struct i2c_device_id amc6821_id[] = {
 
 MODULE_DEVICE_TABLE(i2c, amc6821_id);
 
+static const struct of_device_id __maybe_unused amc6821_of_match[] = {
+	{
+		.compatible = "ti,amc6821",
+		.data = (void *)amc6821,
+	},
+	{ }
+};
+
+MODULE_DEVICE_TABLE(of, amc6821_of_match);
+
 static struct i2c_driver amc6821_driver = {
 	.class = I2C_CLASS_HWMON,
 	.driver = {
 		.name	= "amc6821",
+		.of_match_table = of_match_ptr(amc6821_of_match),
 	},
 	.probe = amc6821_probe,
 	.id_table = amc6821_id,
diff --git a/drivers/input/rmi4/rmi_driver.c b/drivers/input/rmi4/rmi_driver.c
index ac6a20f7afdf..0da814b41e72 100644
--- a/drivers/input/rmi4/rmi_driver.c
+++ b/drivers/input/rmi4/rmi_driver.c
@@ -1199,7 +1199,11 @@ static int rmi_driver_probe(struct device *dev)
 		}
 		rmi_driver_set_input_params(rmi_dev, data->input);
 		data->input->phys = devm_kasprintf(dev, GFP_KERNEL,
-						"%s/input0", dev_name(dev));
+						   "%s/input0", dev_name(dev));
+		if (!data->input->phys) {
+			retval = -ENOMEM;
+			goto err;
+		}
 	}
 
 	retval = rmi_init_functions(data);
diff --git a/drivers/md/dm-raid.c b/drivers/md/dm-raid.c
index 1759134fce82..2a8746f9c6d8 100644
--- a/drivers/md/dm-raid.c
+++ b/drivers/md/dm-raid.c
@@ -4023,7 +4023,9 @@ static void raid_resume(struct dm_target *ti)
 		 * Take this opportunity to check whether any failed
 		 * devices are reachable again.
 		 */
+		mddev_lock_nointr(mddev);
 		attempt_restore_of_faulty_devices(rs);
+		mddev_unlock(mddev);
 	}
 
 	if (test_and_clear_bit(RT_FLAG_RS_SUSPENDED, &rs->runtime_flags)) {
diff --git a/drivers/md/raid5.c b/drivers/md/raid5.c
index e2fcc09a18cd..b98abe927d06 100644
--- a/drivers/md/raid5.c
+++ b/drivers/md/raid5.c
@@ -44,6 +44,7 @@
  */
 
 #include <linux/blkdev.h>
+#include <linux/delay.h>
 #include <linux/kthread.h>
 #include <linux/raid/pq.h>
 #include <linux/async_tx.h>
@@ -6329,7 +6330,18 @@ static void raid5d(struct md_thread *thread)
 			spin_unlock_irq(&conf->device_lock);
 			md_check_recovery(mddev);
 			spin_lock_irq(&conf->device_lock);
+
+			/*
+			 * Waiting on MD_SB_CHANGE_PENDING below may deadlock
+			 * seeing md_check_recovery() is needed to clear
+			 * the flag when using mdmon.
+			 */
+			continue;
 		}
+
+		wait_event_lock_irq(mddev->sb_wait,
+			!test_bit(MD_SB_CHANGE_PENDING, &mddev->sb_flags),
+			conf->device_lock);
 	}
 	pr_debug("%d stripes handled\n", handled);
 
diff --git a/drivers/media/pci/sta2x11/sta2x11_vip.c b/drivers/media/pci/sta2x11/sta2x11_vip.c
index 1858efedaf1a..33d6c95b3613 100644
--- a/drivers/media/pci/sta2x11/sta2x11_vip.c
+++ b/drivers/media/pci/sta2x11/sta2x11_vip.c
@@ -780,7 +780,7 @@ static const struct video_device video_dev_template = {
 /**
  * vip_irq - interrupt routine
  * @irq: Number of interrupt ( not used, correct number is assumed )
- * @vip: local data structure containing all information
+ * @data: local data structure containing all information
  *
  * check for both frame interrupts set ( top and bottom ).
  * check FIFO overflow, but limit number of log messages after open.
@@ -790,8 +790,9 @@ static const struct video_device video_dev_template = {
  *
  * IRQ_HANDLED, interrupt done.
  */
-static irqreturn_t vip_irq(int irq, struct sta2x11_vip *vip)
+static irqreturn_t vip_irq(int irq, void *data)
 {
+	struct sta2x11_vip *vip = data;
 	unsigned int status;
 
 	status = reg_read(vip, DVP_ITS);
@@ -1073,9 +1074,7 @@ static int sta2x11_vip_init_one(struct pci_dev *pdev,
 
 	spin_lock_init(&vip->slock);
 
-	ret = request_irq(pdev->irq,
-			  (irq_handler_t) vip_irq,
-			  IRQF_SHARED, KBUILD_MODNAME, vip);
+	ret = request_irq(pdev->irq, vip_irq, IRQF_SHARED, KBUILD_MODNAME, vip);
 	if (ret) {
 		dev_err(&pdev->dev, "request_irq failed\n");
 		ret = -ENODEV;
diff --git a/drivers/media/tuners/xc4000.c b/drivers/media/tuners/xc4000.c
index 0ef8f054a795..6017602aead6 100644
--- a/drivers/media/tuners/xc4000.c
+++ b/drivers/media/tuners/xc4000.c
@@ -1527,10 +1527,10 @@ static int xc4000_get_frequency(struct dvb_frontend *fe, u32 *freq)
 {
 	struct xc4000_priv *priv = fe->tuner_priv;
 
+	mutex_lock(&priv->lock);
 	*freq = priv->freq_hz + priv->freq_offset;
 
 	if (debug) {
-		mutex_lock(&priv->lock);
 		if ((priv->cur_fw.type
 		     & (BASE | FM | DTV6 | DTV7 | DTV78 | DTV8)) == BASE) {
 			u16	snr = 0;
@@ -1541,8 +1541,8 @@ static int xc4000_get_frequency(struct dvb_frontend *fe, u32 *freq)
 				return 0;
 			}
 		}
-		mutex_unlock(&priv->lock);
 	}
+	mutex_unlock(&priv->lock);
 
 	dprintk(1, "%s()\n", __func__);
 
diff --git a/drivers/misc/vmw_vmci/vmci_datagram.c b/drivers/misc/vmw_vmci/vmci_datagram.c
index 8a4b6bbe1bee..129dd088866c 100644
--- a/drivers/misc/vmw_vmci/vmci_datagram.c
+++ b/drivers/misc/vmw_vmci/vmci_datagram.c
@@ -242,7 +242,8 @@ static int dg_dispatch_as_host(u32 context_id, struct vmci_datagram *dg)
 
 			dg_info->in_dg_host_queue = true;
 			dg_info->entry = dst_entry;
-			memcpy(&dg_info->msg, dg, dg_size);
+			dg_info->msg = *dg;
+			memcpy(&dg_info->msg_payload, dg + 1, dg->payload_size);
 
 			INIT_WORK(&dg_info->work, dg_delayed_dispatch);
 			schedule_work(&dg_info->work);
@@ -385,7 +386,8 @@ int vmci_datagram_invoke_guest_handler(struct vmci_datagram *dg)
 
 		dg_info->in_dg_host_queue = false;
 		dg_info->entry = dst_entry;
-		memcpy(&dg_info->msg, dg, VMCI_DG_SIZE(dg));
+		dg_info->msg = *dg;
+		memcpy(&dg_info->msg_payload, dg + 1, dg->payload_size);
 
 		INIT_WORK(&dg_info->work, dg_delayed_dispatch);
 		schedule_work(&dg_info->work);
diff --git a/drivers/mmc/core/block.c b/drivers/mmc/core/block.c
index ef9422917e1c..c3b329946429 100644
--- a/drivers/mmc/core/block.c
+++ b/drivers/mmc/core/block.c
@@ -851,10 +851,11 @@ static const struct block_device_operations mmc_bdops = {
 static int mmc_blk_part_switch_pre(struct mmc_card *card,
 				   unsigned int part_type)
 {
-	const unsigned int mask = EXT_CSD_PART_CONFIG_ACC_RPMB;
+	const unsigned int mask = EXT_CSD_PART_CONFIG_ACC_MASK;
+	const unsigned int rpmb = EXT_CSD_PART_CONFIG_ACC_RPMB;
 	int ret = 0;
 
-	if ((part_type & mask) == mask) {
+	if ((part_type & mask) == rpmb) {
 		if (card->ext_csd.cmdq_en) {
 			ret = mmc_cmdq_disable(card);
 			if (ret)
@@ -869,10 +870,11 @@ static int mmc_blk_part_switch_pre(struct mmc_card *card,
 static int mmc_blk_part_switch_post(struct mmc_card *card,
 				    unsigned int part_type)
 {
-	const unsigned int mask = EXT_CSD_PART_CONFIG_ACC_RPMB;
+	const unsigned int mask = EXT_CSD_PART_CONFIG_ACC_MASK;
+	const unsigned int rpmb = EXT_CSD_PART_CONFIG_ACC_RPMB;
 	int ret = 0;
 
-	if ((part_type & mask) == mask) {
+	if ((part_type & mask) == rpmb) {
 		mmc_retune_unpause(card->host);
 		if (card->reenable_cmdq && !card->ext_csd.cmdq_en)
 			ret = mmc_cmdq_enable(card);
diff --git a/drivers/mmc/host/tmio_mmc_core.c b/drivers/mmc/host/tmio_mmc_core.c
index f819757e125e..ae8913e5adc7 100644
--- a/drivers/mmc/host/tmio_mmc_core.c
+++ b/drivers/mmc/host/tmio_mmc_core.c
@@ -213,6 +213,8 @@ static void tmio_mmc_reset_work(struct work_struct *work)
 	else
 		mrq->cmd->error = -ETIMEDOUT;
 
+	/* No new calls yet, but disallow concurrent tmio_mmc_done_work() */
+	host->mrq = ERR_PTR(-EBUSY);
 	host->cmd = NULL;
 	host->data = NULL;
 
diff --git a/drivers/mtd/ubi/fastmap.c b/drivers/mtd/ubi/fastmap.c
index d45c1d6587d1..e24fc0131d79 100644
--- a/drivers/mtd/ubi/fastmap.c
+++ b/drivers/mtd/ubi/fastmap.c
@@ -95,9 +95,10 @@ size_t ubi_calc_fm_size(struct ubi_device *ubi)
 		sizeof(struct ubi_fm_scan_pool) +
 		sizeof(struct ubi_fm_scan_pool) +
 		(ubi->peb_count * sizeof(struct ubi_fm_ec)) +
-		(sizeof(struct ubi_fm_eba) +
-		(ubi->peb_count * sizeof(__be32))) +
-		sizeof(struct ubi_fm_volhdr) * UBI_MAX_VOLUMES;
+		((sizeof(struct ubi_fm_eba) +
+		  sizeof(struct ubi_fm_volhdr)) *
+		 (UBI_MAX_VOLUMES + UBI_INT_VOL_COUNT)) +
+		(ubi->peb_count * sizeof(__be32));
 	return roundup(size, ubi->leb_size);
 }
 
diff --git a/drivers/mtd/ubi/vtbl.c b/drivers/mtd/ubi/vtbl.c
index 1bc82154bb18..634ec95a1e71 100644
--- a/drivers/mtd/ubi/vtbl.c
+++ b/drivers/mtd/ubi/vtbl.c
@@ -804,6 +804,12 @@ int ubi_read_volume_table(struct ubi_device *ubi, struct ubi_attach_info *ai)
 	 * The number of supported volumes is limited by the eraseblock size
 	 * and by the UBI_MAX_VOLUMES constant.
 	 */
+
+	if (ubi->leb_size < UBI_VTBL_RECORD_SIZE) {
+		ubi_err(ubi, "LEB size too small for a volume record");
+		return -EINVAL;
+	}
+
 	ubi->vtbl_slots = ubi->leb_size / UBI_VTBL_RECORD_SIZE;
 	if (ubi->vtbl_slots > UBI_MAX_VOLUMES)
 		ubi->vtbl_slots = UBI_MAX_VOLUMES;
diff --git a/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c b/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
index 412f8002f918..9c0d01eba36c 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
@@ -1317,8 +1317,8 @@ bool i40e_reset_all_vfs(struct i40e_pf *pf, bool flr)
 {
 	struct i40e_hw *hw = &pf->hw;
 	struct i40e_vf *vf;
-	int i, v;
 	u32 reg;
+	int i;
 
 	/* If we don't have any VFs, then there is nothing to reset */
 	if (!pf->num_alloc_vfs)
@@ -1329,11 +1329,10 @@ bool i40e_reset_all_vfs(struct i40e_pf *pf, bool flr)
 		return false;
 
 	/* Begin reset on all VFs at once */
-	for (v = 0; v < pf->num_alloc_vfs; v++) {
-		vf = &pf->vf[v];
+	for (vf = &pf->vf[0]; vf < &pf->vf[pf->num_alloc_vfs]; ++vf) {
 		/* If VF is being reset no need to trigger reset again */
 		if (!test_bit(I40E_VF_STATE_RESETTING, &vf->vf_states))
-			i40e_trigger_vf_reset(&pf->vf[v], flr);
+			i40e_trigger_vf_reset(vf, flr);
 	}
 
 	/* HW requires some time to make sure it can flush the FIFO for a VF
@@ -1342,14 +1341,13 @@ bool i40e_reset_all_vfs(struct i40e_pf *pf, bool flr)
 	 * the VFs using a simple iterator that increments once that VF has
 	 * finished resetting.
 	 */
-	for (i = 0, v = 0; i < 10 && v < pf->num_alloc_vfs; i++) {
+	for (i = 0, vf = &pf->vf[0]; i < 10 && vf < &pf->vf[pf->num_alloc_vfs]; ++i) {
 		usleep_range(10000, 20000);
 
 		/* Check each VF in sequence, beginning with the VF to fail
 		 * the previous check.
 		 */
-		while (v < pf->num_alloc_vfs) {
-			vf = &pf->vf[v];
+		while (vf < &pf->vf[pf->num_alloc_vfs]) {
 			if (!test_bit(I40E_VF_STATE_RESETTING, &vf->vf_states)) {
 				reg = rd32(hw, I40E_VPGEN_VFRSTAT(vf->vf_id));
 				if (!(reg & I40E_VPGEN_VFRSTAT_VFRD_MASK))
@@ -1359,7 +1357,7 @@ bool i40e_reset_all_vfs(struct i40e_pf *pf, bool flr)
 			/* If the current VF has finished resetting, move on
 			 * to the next VF in sequence.
 			 */
-			v++;
+			++vf;
 		}
 	}
 
@@ -1369,39 +1367,39 @@ bool i40e_reset_all_vfs(struct i40e_pf *pf, bool flr)
 	/* Display a warning if at least one VF didn't manage to reset in
 	 * time, but continue on with the operation.
 	 */
-	if (v < pf->num_alloc_vfs)
+	if (vf < &pf->vf[pf->num_alloc_vfs])
 		dev_err(&pf->pdev->dev, "VF reset check timeout on VF %d\n",
-			pf->vf[v].vf_id);
+			vf->vf_id);
 	usleep_range(10000, 20000);
 
 	/* Begin disabling all the rings associated with VFs, but do not wait
 	 * between each VF.
 	 */
-	for (v = 0; v < pf->num_alloc_vfs; v++) {
+	for (vf = &pf->vf[0]; vf < &pf->vf[pf->num_alloc_vfs]; ++vf) {
 		/* On initial reset, we don't have any queues to disable */
-		if (pf->vf[v].lan_vsi_idx == 0)
+		if (vf->lan_vsi_idx == 0)
 			continue;
 
 		/* If VF is reset in another thread just continue */
 		if (test_bit(I40E_VF_STATE_RESETTING, &vf->vf_states))
 			continue;
 
-		i40e_vsi_stop_rings_no_wait(pf->vsi[pf->vf[v].lan_vsi_idx]);
+		i40e_vsi_stop_rings_no_wait(pf->vsi[vf->lan_vsi_idx]);
 	}
 
 	/* Now that we've notified HW to disable all of the VF rings, wait
 	 * until they finish.
 	 */
-	for (v = 0; v < pf->num_alloc_vfs; v++) {
+	for (vf = &pf->vf[0]; vf < &pf->vf[pf->num_alloc_vfs]; ++vf) {
 		/* On initial reset, we don't have any queues to disable */
-		if (pf->vf[v].lan_vsi_idx == 0)
+		if (vf->lan_vsi_idx == 0)
 			continue;
 
 		/* If VF is reset in another thread just continue */
 		if (test_bit(I40E_VF_STATE_RESETTING, &vf->vf_states))
 			continue;
 
-		i40e_vsi_wait_queues_disabled(pf->vsi[pf->vf[v].lan_vsi_idx]);
+		i40e_vsi_wait_queues_disabled(pf->vsi[vf->lan_vsi_idx]);
 	}
 
 	/* Hw may need up to 50ms to finish disabling the RX queues. We
@@ -1410,12 +1408,12 @@ bool i40e_reset_all_vfs(struct i40e_pf *pf, bool flr)
 	mdelay(50);
 
 	/* Finish the reset on each VF */
-	for (v = 0; v < pf->num_alloc_vfs; v++) {
+	for (vf = &pf->vf[0]; vf < &pf->vf[pf->num_alloc_vfs]; ++vf) {
 		/* If VF is reset in another thread just continue */
 		if (test_bit(I40E_VF_STATE_RESETTING, &vf->vf_states))
 			continue;
 
-		i40e_cleanup_reset_vf(&pf->vf[v]);
+		i40e_cleanup_reset_vf(vf);
 	}
 
 	i40e_flush(hw);
diff --git a/drivers/net/ethernet/realtek/r8169_main.c b/drivers/net/ethernet/realtek/r8169_main.c
index ecdf628e3bb8..1dcb8f7af2bc 100644
--- a/drivers/net/ethernet/realtek/r8169_main.c
+++ b/drivers/net/ethernet/realtek/r8169_main.c
@@ -7303,6 +7303,15 @@ static int r8169_mdio_register(struct rtl8169_private *tp)
 	struct mii_bus *new_bus;
 	int ret;
 
+	/* On some boards with this chip version the BIOS is buggy and misses
+	 * to reset the PHY page selector. This results in the PHY ID read
+	 * accessing registers on a different page, returning a more or
+	 * less random value. Fix this by resetting the page selector first.
+	 */
+	if (tp->mac_version == RTL_GIGA_MAC_VER_25 ||
+	    tp->mac_version == RTL_GIGA_MAC_VER_26)
+		r8169_mdio_write(tp, 0x1f, 0);
+
 	new_bus = devm_mdiobus_alloc(&pdev->dev);
 	if (!new_bus)
 		return -ENOMEM;
diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac4_core.c b/drivers/net/ethernet/stmicro/stmmac/dwmac4_core.c
index 00b6af0b2f3a..9e68422d60b7 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac4_core.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac4_core.c
@@ -84,19 +84,41 @@ static void dwmac4_rx_queue_priority(struct mac_device_info *hw,
 				     u32 prio, u32 queue)
 {
 	void __iomem *ioaddr = hw->pcsr;
-	u32 base_register;
-	u32 value;
+	u32 clear_mask = 0;
+	u32 ctrl2, ctrl3;
+	int i;
 
-	base_register = (queue < 4) ? GMAC_RXQ_CTRL2 : GMAC_RXQ_CTRL3;
-	if (queue >= 4)
-		queue -= 4;
+	ctrl2 = readl(ioaddr + GMAC_RXQ_CTRL2);
+	ctrl3 = readl(ioaddr + GMAC_RXQ_CTRL3);
 
-	value = readl(ioaddr + base_register);
+	/* The software must ensure that the same priority
+	 * is not mapped to multiple Rx queues
+	 */
+	for (i = 0; i < 4; i++)
+		clear_mask |= ((prio << GMAC_RXQCTRL_PSRQX_SHIFT(i)) &
+						GMAC_RXQCTRL_PSRQX_MASK(i));
 
-	value &= ~GMAC_RXQCTRL_PSRQX_MASK(queue);
-	value |= (prio << GMAC_RXQCTRL_PSRQX_SHIFT(queue)) &
+	ctrl2 &= ~clear_mask;
+	ctrl3 &= ~clear_mask;
+
+	/* First assign new priorities to a queue, then
+	 * clear them from others queues
+	 */
+	if (queue < 4) {
+		ctrl2 |= (prio << GMAC_RXQCTRL_PSRQX_SHIFT(queue)) &
 						GMAC_RXQCTRL_PSRQX_MASK(queue);
-	writel(value, ioaddr + base_register);
+
+		writel(ctrl2, ioaddr + GMAC_RXQ_CTRL2);
+		writel(ctrl3, ioaddr + GMAC_RXQ_CTRL3);
+	} else {
+		queue -= 4;
+
+		ctrl3 |= (prio << GMAC_RXQCTRL_PSRQX_SHIFT(queue)) &
+						GMAC_RXQCTRL_PSRQX_MASK(queue);
+
+		writel(ctrl3, ioaddr + GMAC_RXQ_CTRL3);
+		writel(ctrl2, ioaddr + GMAC_RXQ_CTRL2);
+	}
 }
 
 static void dwmac4_tx_queue_priority(struct mac_device_info *hw,
diff --git a/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_core.c b/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_core.c
index 870302a7177e..9fd03c3e52a5 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_core.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_core.c
@@ -103,17 +103,41 @@ static void dwxgmac2_rx_queue_prio(struct mac_device_info *hw, u32 prio,
 				   u32 queue)
 {
 	void __iomem *ioaddr = hw->pcsr;
-	u32 value, reg;
-
-	reg = (queue < 4) ? XGMAC_RXQ_CTRL2 : XGMAC_RXQ_CTRL3;
-	if (queue >= 4)
+	u32 clear_mask = 0;
+	u32 ctrl2, ctrl3;
+	int i;
+
+	ctrl2 = readl(ioaddr + XGMAC_RXQ_CTRL2);
+	ctrl3 = readl(ioaddr + XGMAC_RXQ_CTRL3);
+
+	/* The software must ensure that the same priority
+	 * is not mapped to multiple Rx queues
+	 */
+	for (i = 0; i < 4; i++)
+		clear_mask |= ((prio << XGMAC_PSRQ_SHIFT(i)) &
+						XGMAC_PSRQ(i));
+
+	ctrl2 &= ~clear_mask;
+	ctrl3 &= ~clear_mask;
+
+	/* First assign new priorities to a queue, then
+	 * clear them from others queues
+	 */
+	if (queue < 4) {
+		ctrl2 |= (prio << XGMAC_PSRQ_SHIFT(queue)) &
+						XGMAC_PSRQ(queue);
+
+		writel(ctrl2, ioaddr + XGMAC_RXQ_CTRL2);
+		writel(ctrl3, ioaddr + XGMAC_RXQ_CTRL3);
+	} else {
 		queue -= 4;
 
-	value = readl(ioaddr + reg);
-	value &= ~XGMAC_PSRQ(queue);
-	value |= (prio << XGMAC_PSRQ_SHIFT(queue)) & XGMAC_PSRQ(queue);
+		ctrl3 |= (prio << XGMAC_PSRQ_SHIFT(queue)) &
+						XGMAC_PSRQ(queue);
 
-	writel(value, ioaddr + reg);
+		writel(ctrl3, ioaddr + XGMAC_RXQ_CTRL3);
+		writel(ctrl2, ioaddr + XGMAC_RXQ_CTRL2);
+	}
 }
 
 static void dwxgmac2_prog_mtl_rx_algorithms(struct mac_device_info *hw,
diff --git a/drivers/net/wireless/ath/ath9k/antenna.c b/drivers/net/wireless/ath/ath9k/antenna.c
index a3668433dc02..deac6184dd01 100644
--- a/drivers/net/wireless/ath/ath9k/antenna.c
+++ b/drivers/net/wireless/ath/ath9k/antenna.c
@@ -643,7 +643,7 @@ static void ath_ant_try_scan(struct ath_ant_comb *antcomb,
 				conf->main_lna_conf = ATH_ANT_DIV_COMB_LNA1;
 				conf->alt_lna_conf = ATH_ANT_DIV_COMB_LNA1_PLUS_LNA2;
 			} else if (antcomb->rssi_sub >
-				   antcomb->rssi_lna1) {
+				   antcomb->rssi_lna2) {
 				/* set to A-B */
 				conf->main_lna_conf = ATH_ANT_DIV_COMB_LNA1;
 				conf->alt_lna_conf = ATH_ANT_DIV_COMB_LNA1_MINUS_LNA2;
diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c
index 1827be85f115..fe8f1134a5f3 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c
@@ -690,8 +690,7 @@ s32 brcmf_notify_escan_complete(struct brcmf_cfg80211_info *cfg,
 	scan_request = cfg->scan_request;
 	cfg->scan_request = NULL;
 
-	if (timer_pending(&cfg->escan_timeout))
-		del_timer_sync(&cfg->escan_timeout);
+	timer_delete_sync(&cfg->escan_timeout);
 
 	if (fw_abort) {
 		/* Do a scan abort to stop the driver's scan engine */
@@ -7093,6 +7092,7 @@ void brcmf_cfg80211_detach(struct brcmf_cfg80211_info *cfg)
 	wiphy_unregister(cfg->wiphy);
 	kfree(cfg->ops);
 	wl_deinit_priv(cfg);
+	cancel_work_sync(&cfg->escan_timeout_work);
 	brcmf_free_wiphy(cfg->wiphy);
 	kfree(cfg);
 }
diff --git a/drivers/pci/pci-driver.c b/drivers/pci/pci-driver.c
index 78ae1cab9af7..031908e42fb5 100644
--- a/drivers/pci/pci-driver.c
+++ b/drivers/pci/pci-driver.c
@@ -439,16 +439,21 @@ static int pci_device_remove(struct device *dev)
 	struct pci_dev *pci_dev = to_pci_dev(dev);
 	struct pci_driver *drv = pci_dev->driver;
 
-	if (drv) {
-		if (drv->remove) {
-			pm_runtime_get_sync(dev);
-			drv->remove(pci_dev);
-			pm_runtime_put_noidle(dev);
-		}
-		pcibios_free_irq(pci_dev);
-		pci_dev->driver = NULL;
-		pci_iov_remove(pci_dev);
+	if (drv->remove) {
+		pm_runtime_get_sync(dev);
+		/*
+		 * If the driver provides a .runtime_idle() callback and it has
+		 * started to run already, it may continue to run in parallel
+		 * with the code below, so wait until all of the runtime PM
+		 * activity has completed.
+		 */
+		pm_runtime_barrier(dev);
+		drv->remove(pci_dev);
+		pm_runtime_put_noidle(dev);
 	}
+	pcibios_free_irq(pci_dev);
+	pci_dev->driver = NULL;
+	pci_iov_remove(pci_dev);
 
 	/* Undo the runtime PM settings in local_pci_probe() */
 	pm_runtime_put_sync(dev);
diff --git a/drivers/s390/crypto/zcrypt_api.c b/drivers/s390/crypto/zcrypt_api.c
index b7cb897cd83e..3a47e622db10 100644
--- a/drivers/s390/crypto/zcrypt_api.c
+++ b/drivers/s390/crypto/zcrypt_api.c
@@ -158,6 +158,7 @@ static inline struct zcrypt_queue *zcrypt_pick_queue(struct zcrypt_card *zc,
 {
 	if (!zq || !try_module_get(zq->queue->ap_dev.drv->driver.owner))
 		return NULL;
+	zcrypt_card_get(zc);
 	zcrypt_queue_get(zq);
 	get_device(&zq->queue->ap_dev.device);
 	atomic_add(weight, &zc->load);
@@ -177,6 +178,7 @@ static inline void zcrypt_drop_queue(struct zcrypt_card *zc,
 	atomic_sub(weight, &zq->load);
 	put_device(&zq->queue->ap_dev.device);
 	zcrypt_queue_put(zq);
+	zcrypt_card_put(zc);
 	module_put(mod);
 }
 
diff --git a/drivers/scsi/lpfc/lpfc_nportdisc.c b/drivers/scsi/lpfc/lpfc_nportdisc.c
index f666518d84b0..0890c2e38eec 100644
--- a/drivers/scsi/lpfc/lpfc_nportdisc.c
+++ b/drivers/scsi/lpfc/lpfc_nportdisc.c
@@ -601,8 +601,10 @@ lpfc_rcv_padisc(struct lpfc_vport *vport, struct lpfc_nodelist *ndlp,
 				/* Save the ELS cmd */
 				elsiocb->drvrTimeout = cmd;
 
-				lpfc_sli4_resume_rpi(ndlp,
-					lpfc_mbx_cmpl_resume_rpi, elsiocb);
+				if (lpfc_sli4_resume_rpi(ndlp,
+						lpfc_mbx_cmpl_resume_rpi,
+						elsiocb))
+					kfree(elsiocb);
 				goto out;
 			}
 		}
diff --git a/drivers/scsi/lpfc/lpfc_nvmet.c b/drivers/scsi/lpfc/lpfc_nvmet.c
index 23ead17e60fe..c9b3524ec4eb 100644
--- a/drivers/scsi/lpfc/lpfc_nvmet.c
+++ b/drivers/scsi/lpfc/lpfc_nvmet.c
@@ -1308,7 +1308,7 @@ lpfc_nvmet_setup_io_context(struct lpfc_hba *phba)
 		wqe = &nvmewqe->wqe;
 
 		/* Initialize WQE */
-		memset(wqe, 0, sizeof(union lpfc_wqe));
+		memset(wqe, 0, sizeof(*wqe));
 
 		ctx_buf->iocbq->context1 = NULL;
 		spin_lock(&phba->sli4_hba.sgl_list_lock);
diff --git a/drivers/scsi/qla2xxx/qla_target.c b/drivers/scsi/qla2xxx/qla_target.c
index 27d3293eadf5..0322eee4221b 100644
--- a/drivers/scsi/qla2xxx/qla_target.c
+++ b/drivers/scsi/qla2xxx/qla_target.c
@@ -1037,6 +1037,16 @@ void qlt_free_session_done(struct work_struct *work)
 		    "%s: sess %p logout completed\n", __func__, sess);
 	}
 
+	/* check for any straggling io left behind */
+	if (!(sess->flags & FCF_FCP2_DEVICE) &&
+	    qla2x00_eh_wait_for_pending_commands(sess->vha, sess->d_id.b24, 0, WAIT_TARGET)) {
+		ql_log(ql_log_warn, vha, 0x3027,
+		    "IO not return. Resetting.\n");
+		set_bit(ISP_ABORT_NEEDED, &vha->dpc_flags);
+		qla2xxx_wake_dpc(vha);
+		qla2x00_wait_for_chip_reset(vha);
+	}
+
 	if (sess->logo_ack_needed) {
 		sess->logo_ack_needed = 0;
 		qla24xx_async_notify_ack(vha, sess,
diff --git a/drivers/slimbus/core.c b/drivers/slimbus/core.c
index 3e63e4ce45b0..6270b4165644 100644
--- a/drivers/slimbus/core.c
+++ b/drivers/slimbus/core.c
@@ -409,8 +409,8 @@ static int slim_device_alloc_laddr(struct slim_device *sbdev,
 		if (ret < 0)
 			goto err;
 	} else if (report_present) {
-		ret = ida_simple_get(&ctrl->laddr_ida,
-				     0, SLIM_LA_MANAGER - 1, GFP_KERNEL);
+		ret = ida_alloc_max(&ctrl->laddr_ida,
+				    SLIM_LA_MANAGER - 1, GFP_KERNEL);
 		if (ret < 0)
 			goto err;
 
diff --git a/drivers/soc/fsl/qbman/qman.c b/drivers/soc/fsl/qbman/qman.c
index d7bf456fd10e..ce08ce98142d 100644
--- a/drivers/soc/fsl/qbman/qman.c
+++ b/drivers/soc/fsl/qbman/qman.c
@@ -976,7 +976,7 @@ struct qman_portal {
 	/* linked-list of CSCN handlers. */
 	struct list_head cgr_cbs;
 	/* list lock */
-	spinlock_t cgr_lock;
+	raw_spinlock_t cgr_lock;
 	struct work_struct congestion_work;
 	struct work_struct mr_work;
 	char irqname[MAX_IRQNAME];
@@ -1194,7 +1194,7 @@ static int qman_create_portal(struct qman_portal *portal,
 		/* if the given mask is NULL, assume all CGRs can be seen */
 		qman_cgrs_fill(&portal->cgrs[0]);
 	INIT_LIST_HEAD(&portal->cgr_cbs);
-	spin_lock_init(&portal->cgr_lock);
+	raw_spin_lock_init(&portal->cgr_lock);
 	INIT_WORK(&portal->congestion_work, qm_congestion_task);
 	INIT_WORK(&portal->mr_work, qm_mr_process_task);
 	portal->bits = 0;
@@ -1369,11 +1369,14 @@ static void qm_congestion_task(struct work_struct *work)
 	union qm_mc_result *mcr;
 	struct qman_cgr *cgr;
 
-	spin_lock(&p->cgr_lock);
+	/*
+	 * FIXME: QM_MCR_TIMEOUT is 10ms, which is too long for a raw spinlock!
+	 */
+	raw_spin_lock_irq(&p->cgr_lock);
 	qm_mc_start(&p->p);
 	qm_mc_commit(&p->p, QM_MCC_VERB_QUERYCONGESTION);
 	if (!qm_mc_result_timeout(&p->p, &mcr)) {
-		spin_unlock(&p->cgr_lock);
+		raw_spin_unlock_irq(&p->cgr_lock);
 		dev_crit(p->config->dev, "QUERYCONGESTION timeout\n");
 		qman_p_irqsource_add(p, QM_PIRQ_CSCI);
 		return;
@@ -1389,7 +1392,7 @@ static void qm_congestion_task(struct work_struct *work)
 	list_for_each_entry(cgr, &p->cgr_cbs, node)
 		if (cgr->cb && qman_cgrs_get(&c, cgr->cgrid))
 			cgr->cb(p, cgr, qman_cgrs_get(&rr, cgr->cgrid));
-	spin_unlock(&p->cgr_lock);
+	raw_spin_unlock_irq(&p->cgr_lock);
 	qman_p_irqsource_add(p, QM_PIRQ_CSCI);
 }
 
@@ -2346,7 +2349,7 @@ int qman_create_cgr(struct qman_cgr *cgr, u32 flags,
 	preempt_enable();
 
 	cgr->chan = p->config->channel;
-	spin_lock(&p->cgr_lock);
+	raw_spin_lock_irq(&p->cgr_lock);
 
 	if (opts) {
 		struct qm_mcc_initcgr local_opts = *opts;
@@ -2383,19 +2386,14 @@ int qman_create_cgr(struct qman_cgr *cgr, u32 flags,
 	    qman_cgrs_get(&p->cgrs[1], cgr->cgrid))
 		cgr->cb(p, cgr, 1);
 out:
-	spin_unlock(&p->cgr_lock);
+	raw_spin_unlock_irq(&p->cgr_lock);
 	put_affine_portal();
 	return ret;
 }
 EXPORT_SYMBOL(qman_create_cgr);
 
-int qman_delete_cgr(struct qman_cgr *cgr)
+static struct qman_portal *qman_cgr_get_affine_portal(struct qman_cgr *cgr)
 {
-	unsigned long irqflags;
-	struct qm_mcr_querycgr cgr_state;
-	struct qm_mcc_initcgr local_opts;
-	int ret = 0;
-	struct qman_cgr *i;
 	struct qman_portal *p = get_affine_portal();
 
 	if (cgr->chan != p->config->channel) {
@@ -2403,12 +2401,27 @@ int qman_delete_cgr(struct qman_cgr *cgr)
 		dev_err(p->config->dev, "CGR not owned by current portal");
 		dev_dbg(p->config->dev, " create 0x%x, delete 0x%x\n",
 			cgr->chan, p->config->channel);
-
-		ret = -EINVAL;
-		goto put_portal;
+		put_affine_portal();
+		return NULL;
 	}
+
+	return p;
+}
+
+int qman_delete_cgr(struct qman_cgr *cgr)
+{
+	unsigned long irqflags;
+	struct qm_mcr_querycgr cgr_state;
+	struct qm_mcc_initcgr local_opts;
+	int ret = 0;
+	struct qman_cgr *i;
+	struct qman_portal *p = qman_cgr_get_affine_portal(cgr);
+
+	if (!p)
+		return -EINVAL;
+
 	memset(&local_opts, 0, sizeof(struct qm_mcc_initcgr));
-	spin_lock_irqsave(&p->cgr_lock, irqflags);
+	raw_spin_lock_irqsave(&p->cgr_lock, irqflags);
 	list_del(&cgr->node);
 	/*
 	 * If there are no other CGR objects for this CGRID in the list,
@@ -2433,8 +2446,7 @@ int qman_delete_cgr(struct qman_cgr *cgr)
 		/* add back to the list */
 		list_add(&cgr->node, &p->cgr_cbs);
 release_lock:
-	spin_unlock_irqrestore(&p->cgr_lock, irqflags);
-put_portal:
+	raw_spin_unlock_irqrestore(&p->cgr_lock, irqflags);
 	put_affine_portal();
 	return ret;
 }
@@ -2465,6 +2477,54 @@ void qman_delete_cgr_safe(struct qman_cgr *cgr)
 }
 EXPORT_SYMBOL(qman_delete_cgr_safe);
 
+static int qman_update_cgr(struct qman_cgr *cgr, struct qm_mcc_initcgr *opts)
+{
+	int ret;
+	unsigned long irqflags;
+	struct qman_portal *p = qman_cgr_get_affine_portal(cgr);
+
+	if (!p)
+		return -EINVAL;
+
+	raw_spin_lock_irqsave(&p->cgr_lock, irqflags);
+	ret = qm_modify_cgr(cgr, 0, opts);
+	raw_spin_unlock_irqrestore(&p->cgr_lock, irqflags);
+	put_affine_portal();
+	return ret;
+}
+
+struct update_cgr_params {
+	struct qman_cgr *cgr;
+	struct qm_mcc_initcgr *opts;
+	int ret;
+};
+
+static void qman_update_cgr_smp_call(void *p)
+{
+	struct update_cgr_params *params = p;
+
+	params->ret = qman_update_cgr(params->cgr, params->opts);
+}
+
+int qman_update_cgr_safe(struct qman_cgr *cgr, struct qm_mcc_initcgr *opts)
+{
+	struct update_cgr_params params = {
+		.cgr = cgr,
+		.opts = opts,
+	};
+
+	preempt_disable();
+	if (qman_cgr_cpus[cgr->cgrid] != smp_processor_id())
+		smp_call_function_single(qman_cgr_cpus[cgr->cgrid],
+					 qman_update_cgr_smp_call, &params,
+					 true);
+	else
+		params.ret = qman_update_cgr(cgr, opts);
+	preempt_enable();
+	return params.ret;
+}
+EXPORT_SYMBOL(qman_update_cgr_safe);
+
 /* Cleanup FQs */
 
 static int _qm_mr_consume_and_match_verb(struct qm_portal *p, int v)
diff --git a/drivers/staging/comedi/drivers/comedi_test.c b/drivers/staging/comedi/drivers/comedi_test.c
index d437af721bd8..f5df8cce6f7e 100644
--- a/drivers/staging/comedi/drivers/comedi_test.c
+++ b/drivers/staging/comedi/drivers/comedi_test.c
@@ -87,6 +87,8 @@ struct waveform_private {
 	struct comedi_device *dev;	/* parent comedi device */
 	u64 ao_last_scan_time;		/* time of previous AO scan in usec */
 	unsigned int ao_scan_period;	/* AO scan period in usec */
+	bool ai_timer_enable:1;		/* should AI timer be running? */
+	bool ao_timer_enable:1;		/* should AO timer be running? */
 	unsigned short ao_loopbacks[N_CHANS];
 };
 
@@ -236,8 +238,12 @@ static void waveform_ai_timer(struct timer_list *t)
 			time_increment = devpriv->ai_convert_time - now;
 		else
 			time_increment = 1;
-		mod_timer(&devpriv->ai_timer,
-			  jiffies + usecs_to_jiffies(time_increment));
+		spin_lock(&dev->spinlock);
+		if (devpriv->ai_timer_enable) {
+			mod_timer(&devpriv->ai_timer,
+				  jiffies + usecs_to_jiffies(time_increment));
+		}
+		spin_unlock(&dev->spinlock);
 	}
 
 overrun:
@@ -393,9 +399,12 @@ static int waveform_ai_cmd(struct comedi_device *dev,
 	 * Seem to need an extra jiffy here, otherwise timer expires slightly
 	 * early!
 	 */
+	spin_lock_bh(&dev->spinlock);
+	devpriv->ai_timer_enable = true;
 	devpriv->ai_timer.expires =
 		jiffies + usecs_to_jiffies(devpriv->ai_convert_period) + 1;
 	add_timer(&devpriv->ai_timer);
+	spin_unlock_bh(&dev->spinlock);
 	return 0;
 }
 
@@ -404,6 +413,9 @@ static int waveform_ai_cancel(struct comedi_device *dev,
 {
 	struct waveform_private *devpriv = dev->private;
 
+	spin_lock_bh(&dev->spinlock);
+	devpriv->ai_timer_enable = false;
+	spin_unlock_bh(&dev->spinlock);
 	if (in_softirq()) {
 		/* Assume we were called from the timer routine itself. */
 		del_timer(&devpriv->ai_timer);
@@ -495,8 +507,12 @@ static void waveform_ao_timer(struct timer_list *t)
 		unsigned int time_inc = devpriv->ao_last_scan_time +
 					devpriv->ao_scan_period - now;
 
-		mod_timer(&devpriv->ao_timer,
-			  jiffies + usecs_to_jiffies(time_inc));
+		spin_lock(&dev->spinlock);
+		if (devpriv->ao_timer_enable) {
+			mod_timer(&devpriv->ao_timer,
+				  jiffies + usecs_to_jiffies(time_inc));
+		}
+		spin_unlock(&dev->spinlock);
 	}
 
 underrun:
@@ -517,9 +533,12 @@ static int waveform_ao_inttrig_start(struct comedi_device *dev,
 	async->inttrig = NULL;
 
 	devpriv->ao_last_scan_time = ktime_to_us(ktime_get());
+	spin_lock_bh(&dev->spinlock);
+	devpriv->ao_timer_enable = true;
 	devpriv->ao_timer.expires =
 		jiffies + usecs_to_jiffies(devpriv->ao_scan_period);
 	add_timer(&devpriv->ao_timer);
+	spin_unlock_bh(&dev->spinlock);
 
 	return 1;
 }
@@ -604,6 +623,9 @@ static int waveform_ao_cancel(struct comedi_device *dev,
 	struct waveform_private *devpriv = dev->private;
 
 	s->async->inttrig = NULL;
+	spin_lock_bh(&dev->spinlock);
+	devpriv->ao_timer_enable = false;
+	spin_unlock_bh(&dev->spinlock);
 	if (in_softirq()) {
 		/* Assume we were called from the timer routine itself. */
 		del_timer(&devpriv->ao_timer);
diff --git a/drivers/staging/speakup/synth.c b/drivers/staging/speakup/synth.c
index 3568bfb89912..b5944e7bdbf6 100644
--- a/drivers/staging/speakup/synth.c
+++ b/drivers/staging/speakup/synth.c
@@ -208,8 +208,10 @@ void spk_do_flush(void)
 	wake_up_process(speakup_task);
 }
 
-void synth_write(const char *buf, size_t count)
+void synth_write(const char *_buf, size_t count)
 {
+	const unsigned char *buf = (const unsigned char *) _buf;
+
 	while (count--)
 		synth_buffer_add(*buf++);
 	synth_start();
diff --git a/drivers/staging/vc04_services/bcm2835-camera/mmal-vchiq.c b/drivers/staging/vc04_services/bcm2835-camera/mmal-vchiq.c
index daa2b9656552..a6ba608fed93 100644
--- a/drivers/staging/vc04_services/bcm2835-camera/mmal-vchiq.c
+++ b/drivers/staging/vc04_services/bcm2835-camera/mmal-vchiq.c
@@ -31,8 +31,11 @@
 #define USE_VCHIQ_ARM
 #include "interface/vchi/vchi.h"
 
-/* maximum number of components supported */
-#define VCHIQ_MMAL_MAX_COMPONENTS 4
+/*
+ * maximum number of components supported.
+ * This matches the maximum permitted by default on the VPU
+ */
+#define VCHIQ_MMAL_MAX_COMPONENTS 64
 
 /*#define FULL_MSG_DUMP 1*/
 
@@ -165,8 +168,6 @@ struct vchiq_mmal_instance {
 	/* protect accesses to context_map */
 	struct mutex context_map_lock;
 
-	/* component to use next */
-	int component_idx;
 	struct vchiq_mmal_component component[VCHIQ_MMAL_MAX_COMPONENTS];
 };
 
@@ -845,9 +846,9 @@ static int port_info_get(struct vchiq_mmal_instance *instance,
 		goto release_msg;
 
 	if (rmsg->u.port_info_get_reply.port.is_enabled == 0)
-		port->enabled = false;
+		port->enabled = 0;
 	else
-		port->enabled = true;
+		port->enabled = 1;
 
 	/* copy the values out of the message */
 	port->handle = rmsg->u.port_info_get_reply.port_handle;
@@ -919,9 +920,10 @@ static int create_component(struct vchiq_mmal_instance *instance,
 
 	/* build component create message */
 	m.h.type = MMAL_MSG_TYPE_COMPONENT_CREATE;
-	m.u.component_create.client_component = (u32)(unsigned long)component;
-	strncpy(m.u.component_create.name, name,
-		sizeof(m.u.component_create.name));
+	m.u.component_create.client_component = component->client_component;
+	strscpy_pad(m.u.component_create.name, name,
+		    sizeof(m.u.component_create.name));
+	m.u.component_create.pid = 0;
 
 	ret = send_synchronous_mmal_msg(instance, &m,
 					sizeof(m.u.component_create),
@@ -1283,7 +1285,7 @@ static int port_disable(struct vchiq_mmal_instance *instance,
 	if (!port->enabled)
 		return 0;
 
-	port->enabled = false;
+	port->enabled = 0;
 
 	ret = port_action_port(instance, port,
 			       MMAL_MSG_PORT_ACTION_TYPE_DISABLE);
@@ -1335,7 +1337,7 @@ static int port_enable(struct vchiq_mmal_instance *instance,
 	if (ret)
 		goto done;
 
-	port->enabled = true;
+	port->enabled = 1;
 
 	if (port->buffer_cb) {
 		/* send buffer headers to videocore */
@@ -1502,7 +1504,7 @@ int vchiq_mmal_port_connect_tunnel(struct vchiq_mmal_instance *instance,
 			pr_err("failed disconnecting src port\n");
 			goto release_unlock;
 		}
-		src->connected->enabled = false;
+		src->connected->enabled = 0;
 		src->connected = NULL;
 	}
 
@@ -1607,17 +1609,29 @@ int vchiq_mmal_component_init(struct vchiq_mmal_instance *instance,
 {
 	int ret;
 	int idx;		/* port index */
-	struct vchiq_mmal_component *component;
+	struct vchiq_mmal_component *component = NULL;
 
 	if (mutex_lock_interruptible(&instance->vchiq_mutex))
 		return -EINTR;
 
-	if (instance->component_idx == VCHIQ_MMAL_MAX_COMPONENTS) {
+	for (idx = 0; idx < VCHIQ_MMAL_MAX_COMPONENTS; idx++) {
+		if (!instance->component[idx].in_use) {
+			component = &instance->component[idx];
+			component->in_use = 1;
+			break;
+		}
+	}
+
+	if (!component) {
 		ret = -EINVAL;	/* todo is this correct error? */
 		goto unlock;
 	}
 
-	component = &instance->component[instance->component_idx];
+	/* We need a handle to reference back to our component structure.
+	 * Use the array index in instance->component rather than rolling
+	 * another IDR.
+	 */
+	component->client_component = idx;
 
 	ret = create_component(instance, component, name);
 	if (ret < 0)
@@ -1666,8 +1680,6 @@ int vchiq_mmal_component_init(struct vchiq_mmal_instance *instance,
 			goto release_component;
 	}
 
-	instance->component_idx++;
-
 	*component_out = component;
 
 	mutex_unlock(&instance->vchiq_mutex);
@@ -1677,6 +1689,8 @@ int vchiq_mmal_component_init(struct vchiq_mmal_instance *instance,
 release_component:
 	destroy_component(instance, component);
 unlock:
+	if (component)
+		component->in_use = 0;
 	mutex_unlock(&instance->vchiq_mutex);
 
 	return ret;
@@ -1698,6 +1712,8 @@ int vchiq_mmal_component_finalise(struct vchiq_mmal_instance *instance,
 
 	ret = destroy_component(instance, component);
 
+	component->in_use = 0;
+
 	mutex_unlock(&instance->vchiq_mutex);
 
 	return ret;
@@ -1746,7 +1762,7 @@ int vchiq_mmal_component_disable(struct vchiq_mmal_instance *instance,
 
 	ret = disable_component(instance, component);
 	if (ret == 0)
-		component->enabled = false;
+		component->enabled = 0;
 
 	mutex_unlock(&instance->vchiq_mutex);
 
diff --git a/drivers/staging/vc04_services/bcm2835-camera/mmal-vchiq.h b/drivers/staging/vc04_services/bcm2835-camera/mmal-vchiq.h
index b0ee1716525b..d20d5182577d 100644
--- a/drivers/staging/vc04_services/bcm2835-camera/mmal-vchiq.h
+++ b/drivers/staging/vc04_services/bcm2835-camera/mmal-vchiq.h
@@ -47,7 +47,7 @@ typedef void (*vchiq_mmal_buffer_cb)(
 		unsigned long length, u32 mmal_flags, s64 dts, s64 pts);
 
 struct vchiq_mmal_port {
-	bool enabled;
+	u32 enabled:1;
 	u32 handle;
 	u32 type; /* port type, cached to use on port info set */
 	u32 index; /* port index, cached to use on port info set */
@@ -81,7 +81,8 @@ struct vchiq_mmal_port {
 };
 
 struct vchiq_mmal_component {
-	bool enabled;
+	u32 in_use:1;
+	u32 enabled:1;
 	u32 handle;  /* VideoCore handle for component */
 	u32 inputs;  /* Number of input ports */
 	u32 outputs; /* Number of output ports */
@@ -90,6 +91,7 @@ struct vchiq_mmal_component {
 	struct vchiq_mmal_port input[MAX_PORT_COUNT]; /* input ports */
 	struct vchiq_mmal_port output[MAX_PORT_COUNT]; /* output ports */
 	struct vchiq_mmal_port clock[MAX_PORT_COUNT]; /* clock ports */
+	u32 client_component;	/* Used to ref back to client struct */
 };
 
 int vchiq_mmal_init(struct vchiq_mmal_instance **out_instance);
diff --git a/drivers/tty/n_gsm.c b/drivers/tty/n_gsm.c
index 4a890011eba3..a38539fd8253 100644
--- a/drivers/tty/n_gsm.c
+++ b/drivers/tty/n_gsm.c
@@ -2435,6 +2435,9 @@ static int gsmld_open(struct tty_struct *tty)
 	struct gsm_mux *gsm;
 	int ret;
 
+	if (!capable(CAP_NET_ADMIN))
+		return -EPERM;
+
 	if (tty->ops->write == NULL)
 		return -EINVAL;
 
diff --git a/drivers/tty/serial/fsl_lpuart.c b/drivers/tty/serial/fsl_lpuart.c
index af23d41b9843..3c94c283e7cb 100644
--- a/drivers/tty/serial/fsl_lpuart.c
+++ b/drivers/tty/serial/fsl_lpuart.c
@@ -1753,9 +1753,12 @@ lpuart32_set_termios(struct uart_port *port, struct ktermios *termios,
 		       UARTCTRL);
 
 	lpuart32_serial_setbrg(sport, baud);
-	lpuart32_write(&sport->port, modem, UARTMODIR);
-	lpuart32_write(&sport->port, ctrl, UARTCTRL);
+	/* disable CTS before enabling UARTCTRL_TE to avoid pending idle preamble */
+	lpuart32_write(&sport->port, modem & ~UARTMODIR_TXCTSE, UARTMODIR);
 	/* restore control register */
+	lpuart32_write(&sport->port, ctrl, UARTCTRL);
+	/* re-enable the CTS if needed */
+	lpuart32_write(&sport->port, modem, UARTMODIR);
 
 	spin_unlock_irqrestore(&sport->port.lock, flags);
 }
diff --git a/drivers/tty/vt/vt.c b/drivers/tty/vt/vt.c
index c9083d853076..abcacd377e09 100644
--- a/drivers/tty/vt/vt.c
+++ b/drivers/tty/vt/vt.c
@@ -405,7 +405,7 @@ static void vc_uniscr_delete(struct vc_data *vc, unsigned int nr)
 		char32_t *ln = uniscr->lines[vc->vc_y];
 		unsigned int x = vc->vc_x, cols = vc->vc_cols;
 
-		memcpy(&ln[x], &ln[x + nr], (cols - x - nr) * sizeof(*ln));
+		memmove(&ln[x], &ln[x + nr], (cols - x - nr) * sizeof(*ln));
 		memset32(&ln[cols - nr], ' ', nr);
 	}
 }
@@ -855,7 +855,7 @@ static void delete_char(struct vc_data *vc, unsigned int nr)
 	unsigned short *p = (unsigned short *) vc->vc_pos;
 
 	vc_uniscr_delete(vc, nr);
-	scr_memcpyw(p, p + nr, (vc->vc_cols - vc->vc_x - nr) * 2);
+	scr_memmovew(p, p + nr, (vc->vc_cols - vc->vc_x - nr) * 2);
 	scr_memsetw(p + vc->vc_cols - vc->vc_x - nr, vc->vc_video_erase_char,
 			nr * 2);
 	vc->vc_need_wrap = 0;
diff --git a/drivers/usb/class/cdc-wdm.c b/drivers/usb/class/cdc-wdm.c
index b60a4200fc2b..bc2f07b0de7c 100644
--- a/drivers/usb/class/cdc-wdm.c
+++ b/drivers/usb/class/cdc-wdm.c
@@ -471,6 +471,7 @@ static ssize_t wdm_write
 static int service_outstanding_interrupt(struct wdm_device *desc)
 {
 	int rv = 0;
+	int used;
 
 	/* submit read urb only if the device is waiting for it */
 	if (!desc->resp_count || !--desc->resp_count)
@@ -485,7 +486,10 @@ static int service_outstanding_interrupt(struct wdm_device *desc)
 		goto out;
 	}
 
-	set_bit(WDM_RESPONDING, &desc->flags);
+	used = test_and_set_bit(WDM_RESPONDING, &desc->flags);
+	if (used)
+		goto out;
+
 	spin_unlock_irq(&desc->iuspin);
 	rv = usb_submit_urb(desc->response, GFP_KERNEL);
 	spin_lock_irq(&desc->iuspin);
diff --git a/drivers/usb/core/port.c b/drivers/usb/core/port.c
index 1fe83b522d5f..c03c63ac0745 100644
--- a/drivers/usb/core/port.c
+++ b/drivers/usb/core/port.c
@@ -431,7 +431,7 @@ static int match_location(struct usb_device *peer_hdev, void *p)
 	struct usb_hub *peer_hub = usb_hub_to_struct_hub(peer_hdev);
 	struct usb_device *hdev = to_usb_device(port_dev->dev.parent->parent);
 
-	if (!peer_hub)
+	if (!peer_hub || port_dev->connect_type == USB_PORT_NOT_USED)
 		return 0;
 
 	hcd = bus_to_hcd(hdev->bus);
@@ -442,7 +442,8 @@ static int match_location(struct usb_device *peer_hdev, void *p)
 
 	for (port1 = 1; port1 <= peer_hdev->maxchild; port1++) {
 		peer = peer_hub->ports[port1 - 1];
-		if (peer && peer->location == port_dev->location) {
+		if (peer && peer->connect_type != USB_PORT_NOT_USED &&
+		    peer->location == port_dev->location) {
 			link_peers_report(port_dev, peer);
 			return 1; /* done */
 		}
diff --git a/drivers/usb/core/sysfs.c b/drivers/usb/core/sysfs.c
index 7e88fdfe3cf5..314f2d996c56 100644
--- a/drivers/usb/core/sysfs.c
+++ b/drivers/usb/core/sysfs.c
@@ -1069,14 +1069,24 @@ static ssize_t interface_authorized_store(struct device *dev,
 {
 	struct usb_interface *intf = to_usb_interface(dev);
 	bool val;
+	struct kernfs_node *kn;
 
 	if (strtobool(buf, &val) != 0)
 		return -EINVAL;
 
-	if (val)
+	if (val) {
 		usb_authorize_interface(intf);
-	else
-		usb_deauthorize_interface(intf);
+	} else {
+		/*
+		 * Prevent deadlock if another process is concurrently
+		 * trying to unregister intf.
+		 */
+		kn = sysfs_break_active_protection(&dev->kobj, &attr->attr);
+		if (kn) {
+			usb_deauthorize_interface(intf);
+			sysfs_unbreak_active_protection(kn);
+		}
+	}
 
 	return count;
 }
diff --git a/drivers/usb/dwc2/core.h b/drivers/usb/dwc2/core.h
index 828803b672aa..e48393cedf8d 100644
--- a/drivers/usb/dwc2/core.h
+++ b/drivers/usb/dwc2/core.h
@@ -716,8 +716,14 @@ struct dwc2_dregs_backup {
  * struct dwc2_hregs_backup - Holds host registers state before
  * entering partial power down
  * @hcfg:		Backup of HCFG register
+ * @hflbaddr:		Backup of HFLBADDR register
  * @haintmsk:		Backup of HAINTMSK register
+ * @hcchar:		Backup of HCCHAR register
+ * @hcsplt:		Backup of HCSPLT register
  * @hcintmsk:		Backup of HCINTMSK register
+ * @hctsiz:		Backup of HCTSIZ register
+ * @hdma:		Backup of HCDMA register
+ * @hcdmab:		Backup of HCDMAB register
  * @hprt0:		Backup of HPTR0 register
  * @hfir:		Backup of HFIR register
  * @hptxfsiz:		Backup of HPTXFSIZ register
@@ -725,8 +731,14 @@ struct dwc2_dregs_backup {
  */
 struct dwc2_hregs_backup {
 	u32 hcfg;
+	u32 hflbaddr;
 	u32 haintmsk;
+	u32 hcchar[MAX_EPS_CHANNELS];
+	u32 hcsplt[MAX_EPS_CHANNELS];
 	u32 hcintmsk[MAX_EPS_CHANNELS];
+	u32 hctsiz[MAX_EPS_CHANNELS];
+	u32 hcidma[MAX_EPS_CHANNELS];
+	u32 hcidmab[MAX_EPS_CHANNELS];
 	u32 hprt0;
 	u32 hfir;
 	u32 hptxfsiz;
@@ -1052,6 +1064,7 @@ struct dwc2_hsotg {
 	bool needs_byte_swap;
 
 	/* DWC OTG HW Release versions */
+#define DWC2_CORE_REV_4_30a	0x4f54430a
 #define DWC2_CORE_REV_2_71a	0x4f54271a
 #define DWC2_CORE_REV_2_72a     0x4f54272a
 #define DWC2_CORE_REV_2_80a	0x4f54280a
@@ -1282,6 +1295,7 @@ int dwc2_backup_global_registers(struct dwc2_hsotg *hsotg);
 int dwc2_restore_global_registers(struct dwc2_hsotg *hsotg);
 
 void dwc2_enable_acg(struct dwc2_hsotg *hsotg);
+void dwc2_wakeup_from_lpm_l1(struct dwc2_hsotg *hsotg, bool remotewakeup);
 
 /* This function should be called on every hardware interrupt. */
 irqreturn_t dwc2_handle_common_intr(int irq, void *dev);
diff --git a/drivers/usb/dwc2/core_intr.c b/drivers/usb/dwc2/core_intr.c
index 5919ecb7d4b7..4de913f50b28 100644
--- a/drivers/usb/dwc2/core_intr.c
+++ b/drivers/usb/dwc2/core_intr.c
@@ -349,10 +349,11 @@ static void dwc2_handle_session_req_intr(struct dwc2_hsotg *hsotg)
  * @hsotg: Programming view of DWC_otg controller
  *
  */
-static void dwc2_wakeup_from_lpm_l1(struct dwc2_hsotg *hsotg)
+void dwc2_wakeup_from_lpm_l1(struct dwc2_hsotg *hsotg, bool remotewakeup)
 {
 	u32 glpmcfg;
-	u32 i = 0;
+	u32 pcgctl;
+	u32 dctl;
 
 	if (hsotg->lx_state != DWC2_L1) {
 		dev_err(hsotg->dev, "Core isn't in DWC2_L1 state\n");
@@ -361,37 +362,57 @@ static void dwc2_wakeup_from_lpm_l1(struct dwc2_hsotg *hsotg)
 
 	glpmcfg = dwc2_readl(hsotg, GLPMCFG);
 	if (dwc2_is_device_mode(hsotg)) {
-		dev_dbg(hsotg->dev, "Exit from L1 state\n");
+		dev_dbg(hsotg->dev, "Exit from L1 state, remotewakeup=%d\n", remotewakeup);
 		glpmcfg &= ~GLPMCFG_ENBLSLPM;
-		glpmcfg &= ~GLPMCFG_HIRD_THRES_EN;
+		glpmcfg &= ~GLPMCFG_HIRD_THRES_MASK;
 		dwc2_writel(hsotg, glpmcfg, GLPMCFG);
 
-		do {
-			glpmcfg = dwc2_readl(hsotg, GLPMCFG);
+		pcgctl = dwc2_readl(hsotg, PCGCTL);
+		pcgctl &= ~PCGCTL_ENBL_SLEEP_GATING;
+		dwc2_writel(hsotg, pcgctl, PCGCTL);
 
-			if (!(glpmcfg & (GLPMCFG_COREL1RES_MASK |
-					 GLPMCFG_L1RESUMEOK | GLPMCFG_SLPSTS)))
-				break;
+		glpmcfg = dwc2_readl(hsotg, GLPMCFG);
+		if (glpmcfg & GLPMCFG_ENBESL) {
+			glpmcfg |= GLPMCFG_RSTRSLPSTS;
+			dwc2_writel(hsotg, glpmcfg, GLPMCFG);
+		}
+
+		if (remotewakeup) {
+			if (dwc2_hsotg_wait_bit_set(hsotg, GLPMCFG, GLPMCFG_L1RESUMEOK, 1000)) {
+				dev_warn(hsotg->dev, "%s: timeout GLPMCFG_L1RESUMEOK\n", __func__);
+				goto fail;
+				return;
+			}
+
+			dctl = dwc2_readl(hsotg, DCTL);
+			dctl |= DCTL_RMTWKUPSIG;
+			dwc2_writel(hsotg, dctl, DCTL);
 
-			udelay(1);
-		} while (++i < 200);
+			if (dwc2_hsotg_wait_bit_set(hsotg, GINTSTS, GINTSTS_WKUPINT, 1000)) {
+				dev_warn(hsotg->dev, "%s: timeout GINTSTS_WKUPINT\n", __func__);
+				goto fail;
+				return;
+			}
+		}
 
-		if (i == 200) {
-			dev_err(hsotg->dev, "Failed to exit L1 sleep state in 200us.\n");
+		glpmcfg = dwc2_readl(hsotg, GLPMCFG);
+		if (glpmcfg & GLPMCFG_COREL1RES_MASK || glpmcfg & GLPMCFG_SLPSTS ||
+		    glpmcfg & GLPMCFG_L1RESUMEOK) {
+			goto fail;
 			return;
 		}
-		dwc2_gadget_init_lpm(hsotg);
+
+		/* Inform gadget to exit from L1 */
+		call_gadget(hsotg, resume);
+		/* Change to L0 state */
+		hsotg->lx_state = DWC2_L0;
+		hsotg->bus_suspended = false;
+fail:		dwc2_gadget_init_lpm(hsotg);
 	} else {
 		/* TODO */
 		dev_err(hsotg->dev, "Host side LPM is not supported.\n");
 		return;
 	}
-
-	/* Change to L0 state */
-	hsotg->lx_state = DWC2_L0;
-
-	/* Inform gadget to exit from L1 */
-	call_gadget(hsotg, resume);
 }
 
 /*
@@ -412,7 +433,7 @@ static void dwc2_handle_wakeup_detected_intr(struct dwc2_hsotg *hsotg)
 	dev_dbg(hsotg->dev, "%s lxstate = %d\n", __func__, hsotg->lx_state);
 
 	if (hsotg->lx_state == DWC2_L1) {
-		dwc2_wakeup_from_lpm_l1(hsotg);
+		dwc2_wakeup_from_lpm_l1(hsotg, false);
 		return;
 	}
 
diff --git a/drivers/usb/dwc2/gadget.c b/drivers/usb/dwc2/gadget.c
index 85d25f7e9c27..06ee984237db 100644
--- a/drivers/usb/dwc2/gadget.c
+++ b/drivers/usb/dwc2/gadget.c
@@ -1308,6 +1308,10 @@ static int dwc2_hsotg_ep_queue(struct usb_ep *ep, struct usb_request *req,
 		ep->name, req, req->length, req->buf, req->no_interrupt,
 		req->zero, req->short_not_ok);
 
+	if (hs->lx_state == DWC2_L1) {
+		dwc2_wakeup_from_lpm_l1(hs, true);
+	}
+
 	/* Prevent new request submission when controller is suspended */
 	if (hs->lx_state != DWC2_L0) {
 		dev_dbg(hs->dev, "%s: submit request only in active state\n",
diff --git a/drivers/usb/dwc2/hcd.c b/drivers/usb/dwc2/hcd.c
index 91fa831328fc..7255767591d0 100644
--- a/drivers/usb/dwc2/hcd.c
+++ b/drivers/usb/dwc2/hcd.c
@@ -2929,8 +2929,11 @@ enum dwc2_transaction_type dwc2_hcd_select_transactions(
 			hsotg->available_host_channels--;
 		}
 		qh = list_entry(qh_ptr, struct dwc2_qh, qh_list_entry);
-		if (dwc2_assign_and_init_hc(hsotg, qh))
+		if (dwc2_assign_and_init_hc(hsotg, qh)) {
+			if (hsotg->params.uframe_sched)
+				hsotg->available_host_channels++;
 			break;
+		}
 
 		/*
 		 * Move the QH from the periodic ready schedule to the
@@ -2963,8 +2966,11 @@ enum dwc2_transaction_type dwc2_hcd_select_transactions(
 			hsotg->available_host_channels--;
 		}
 
-		if (dwc2_assign_and_init_hc(hsotg, qh))
+		if (dwc2_assign_and_init_hc(hsotg, qh)) {
+			if (hsotg->params.uframe_sched)
+				hsotg->available_host_channels++;
 			break;
+		}
 
 		/*
 		 * Move the QH from the non-periodic inactive schedule to the
@@ -4320,6 +4326,8 @@ void dwc2_host_complete(struct dwc2_hsotg *hsotg, struct dwc2_qtd *qtd,
 			 urb->actual_length);
 
 	if (usb_pipetype(urb->pipe) == PIPE_ISOCHRONOUS) {
+		if (!hsotg->params.dma_desc_enable)
+			urb->start_frame = qtd->qh->start_active_frame;
 		urb->error_count = dwc2_hcd_urb_get_error_count(qtd->urb);
 		for (i = 0; i < urb->number_of_packets; ++i) {
 			urb->iso_frame_desc[i].actual_length =
@@ -5480,9 +5488,16 @@ int dwc2_backup_host_registers(struct dwc2_hsotg *hsotg)
 	/* Backup Host regs */
 	hr = &hsotg->hr_backup;
 	hr->hcfg = dwc2_readl(hsotg, HCFG);
+	hr->hflbaddr = dwc2_readl(hsotg, HFLBADDR);
 	hr->haintmsk = dwc2_readl(hsotg, HAINTMSK);
-	for (i = 0; i < hsotg->params.host_channels; ++i)
+	for (i = 0; i < hsotg->params.host_channels; ++i) {
+		hr->hcchar[i] = dwc2_readl(hsotg, HCCHAR(i));
+		hr->hcsplt[i] = dwc2_readl(hsotg, HCSPLT(i));
 		hr->hcintmsk[i] = dwc2_readl(hsotg, HCINTMSK(i));
+		hr->hctsiz[i] = dwc2_readl(hsotg, HCTSIZ(i));
+		hr->hcidma[i] = dwc2_readl(hsotg, HCDMA(i));
+		hr->hcidmab[i] = dwc2_readl(hsotg, HCDMAB(i));
+	}
 
 	hr->hprt0 = dwc2_read_hprt0(hsotg);
 	hr->hfir = dwc2_readl(hsotg, HFIR);
@@ -5516,10 +5531,17 @@ int dwc2_restore_host_registers(struct dwc2_hsotg *hsotg)
 	hr->valid = false;
 
 	dwc2_writel(hsotg, hr->hcfg, HCFG);
+	dwc2_writel(hsotg, hr->hflbaddr, HFLBADDR);
 	dwc2_writel(hsotg, hr->haintmsk, HAINTMSK);
 
-	for (i = 0; i < hsotg->params.host_channels; ++i)
+	for (i = 0; i < hsotg->params.host_channels; ++i) {
+		dwc2_writel(hsotg, hr->hcchar[i], HCCHAR(i));
+		dwc2_writel(hsotg, hr->hcsplt[i], HCSPLT(i));
 		dwc2_writel(hsotg, hr->hcintmsk[i], HCINTMSK(i));
+		dwc2_writel(hsotg, hr->hctsiz[i], HCTSIZ(i));
+		dwc2_writel(hsotg, hr->hcidma[i], HCDMA(i));
+		dwc2_writel(hsotg, hr->hcidmab[i], HCDMAB(i));
+	}
 
 	dwc2_writel(hsotg, hr->hprt0, HPRT0);
 	dwc2_writel(hsotg, hr->hfir, HFIR);
@@ -5684,10 +5706,12 @@ int dwc2_host_exit_hibernation(struct dwc2_hsotg *hsotg, int rem_wakeup,
 	dwc2_writel(hsotg, hr->hcfg, HCFG);
 
 	/* De-assert Wakeup Logic */
-	gpwrdn = dwc2_readl(hsotg, GPWRDN);
-	gpwrdn &= ~GPWRDN_PMUACTV;
-	dwc2_writel(hsotg, gpwrdn, GPWRDN);
-	udelay(10);
+	if (!(rem_wakeup && hsotg->hw_params.snpsid >= DWC2_CORE_REV_4_30a)) {
+		gpwrdn = dwc2_readl(hsotg, GPWRDN);
+		gpwrdn &= ~GPWRDN_PMUACTV;
+		dwc2_writel(hsotg, gpwrdn, GPWRDN);
+		udelay(10);
+	}
 
 	hprt0 = hr->hprt0;
 	hprt0 |= HPRT0_PWR;
@@ -5712,6 +5736,13 @@ int dwc2_host_exit_hibernation(struct dwc2_hsotg *hsotg, int rem_wakeup,
 		hprt0 |= HPRT0_RES;
 		dwc2_writel(hsotg, hprt0, HPRT0);
 
+		/* De-assert Wakeup Logic */
+		if ((rem_wakeup && hsotg->hw_params.snpsid >= DWC2_CORE_REV_4_30a)) {
+			gpwrdn = dwc2_readl(hsotg, GPWRDN);
+			gpwrdn &= ~GPWRDN_PMUACTV;
+			dwc2_writel(hsotg, gpwrdn, GPWRDN);
+			udelay(10);
+		}
 		/* Wait for Resume time and then program HPRT again */
 		mdelay(100);
 		hprt0 &= ~HPRT0_RES;
diff --git a/drivers/usb/dwc2/hcd_ddma.c b/drivers/usb/dwc2/hcd_ddma.c
index a858b5f9c1d6..6a4aa71da103 100644
--- a/drivers/usb/dwc2/hcd_ddma.c
+++ b/drivers/usb/dwc2/hcd_ddma.c
@@ -589,7 +589,7 @@ static void dwc2_init_isoc_dma_desc(struct dwc2_hsotg *hsotg,
 	idx = qh->td_last;
 	inc = qh->host_interval;
 	hsotg->frame_number = dwc2_hcd_get_frame_number(hsotg);
-	cur_idx = dwc2_frame_list_idx(hsotg->frame_number);
+	cur_idx = idx;
 	next_idx = dwc2_desclist_idx_inc(qh->td_last, inc, qh->dev_speed);
 
 	/*
@@ -896,6 +896,8 @@ static int dwc2_cmpl_host_isoc_dma_desc(struct dwc2_hsotg *hsotg,
 {
 	struct dwc2_dma_desc *dma_desc;
 	struct dwc2_hcd_iso_packet_desc *frame_desc;
+	u16 frame_desc_idx;
+	struct urb *usb_urb = qtd->urb->priv;
 	u16 remain = 0;
 	int rc = 0;
 
@@ -908,8 +910,11 @@ static int dwc2_cmpl_host_isoc_dma_desc(struct dwc2_hsotg *hsotg,
 				DMA_FROM_DEVICE);
 
 	dma_desc = &qh->desc_list[idx];
+	frame_desc_idx = (idx - qtd->isoc_td_first) & (usb_urb->number_of_packets - 1);
 
-	frame_desc = &qtd->urb->iso_descs[qtd->isoc_frame_index_last];
+	frame_desc = &qtd->urb->iso_descs[frame_desc_idx];
+	if (idx == qtd->isoc_td_first)
+		usb_urb->start_frame = dwc2_hcd_get_frame_number(hsotg);
 	dma_desc->buf = (u32)(qtd->urb->dma + frame_desc->offset);
 	if (chan->ep_is_in)
 		remain = (dma_desc->status & HOST_DMA_ISOC_NBYTES_MASK) >>
@@ -930,7 +935,7 @@ static int dwc2_cmpl_host_isoc_dma_desc(struct dwc2_hsotg *hsotg,
 		frame_desc->status = 0;
 	}
 
-	if (++qtd->isoc_frame_index == qtd->urb->packet_count) {
+	if (++qtd->isoc_frame_index == usb_urb->number_of_packets) {
 		/*
 		 * urb->status is not used for isoc transfers here. The
 		 * individual frame_desc status are used instead.
@@ -1035,11 +1040,11 @@ static void dwc2_complete_isoc_xfer_ddma(struct dwc2_hsotg *hsotg,
 				return;
 			idx = dwc2_desclist_idx_inc(idx, qh->host_interval,
 						    chan->speed);
-			if (!rc)
+			if (rc == 0)
 				continue;
 
-			if (rc == DWC2_CMPL_DONE)
-				break;
+			if (rc == DWC2_CMPL_DONE || rc == DWC2_CMPL_STOP)
+				goto stop_scan;
 
 			/* rc == DWC2_CMPL_STOP */
 
diff --git a/drivers/usb/dwc2/hw.h b/drivers/usb/dwc2/hw.h
index 0ca8e7bc7aaf..c2c7de88df79 100644
--- a/drivers/usb/dwc2/hw.h
+++ b/drivers/usb/dwc2/hw.h
@@ -701,7 +701,7 @@
 #define TXSTS_QTOP_TOKEN_MASK		(0x3 << 25)
 #define TXSTS_QTOP_TOKEN_SHIFT		25
 #define TXSTS_QTOP_TERMINATE		BIT(24)
-#define TXSTS_QSPCAVAIL_MASK		(0xff << 16)
+#define TXSTS_QSPCAVAIL_MASK		(0x7f << 16)
 #define TXSTS_QSPCAVAIL_SHIFT		16
 #define TXSTS_FSPCAVAIL_MASK		(0xffff << 0)
 #define TXSTS_FSPCAVAIL_SHIFT		0
diff --git a/drivers/usb/gadget/function/f_ncm.c b/drivers/usb/gadget/function/f_ncm.c
index b8597d4a4864..ca50257b9538 100644
--- a/drivers/usb/gadget/function/f_ncm.c
+++ b/drivers/usb/gadget/function/f_ncm.c
@@ -1357,7 +1357,7 @@ static int ncm_unwrap_ntb(struct gether *port,
 	if (to_process == 1 &&
 	    (*(unsigned char *)(ntb_ptr + block_len) == 0x00)) {
 		to_process--;
-	} else if (to_process > 0) {
+	} else if ((to_process > 0) && (block_len != 0)) {
 		ntb_ptr = (unsigned char *)(ntb_ptr + block_len);
 		goto parse_ntb;
 	}
diff --git a/drivers/usb/gadget/udc/core.c b/drivers/usb/gadget/udc/core.c
index e3dc74cdba83..e51e223d0dc7 100644
--- a/drivers/usb/gadget/udc/core.c
+++ b/drivers/usb/gadget/udc/core.c
@@ -273,7 +273,9 @@ int usb_ep_queue(struct usb_ep *ep,
 {
 	int ret = 0;
 
-	if (WARN_ON_ONCE(!ep->enabled && ep->address)) {
+	if (!ep->enabled && ep->address) {
+		pr_debug("USB gadget: queue request to disabled ep 0x%x (%s)\n",
+				 ep->address, ep->name);
 		ret = -ESHUTDOWN;
 		goto out;
 	}
diff --git a/drivers/usb/host/sl811-hcd.c b/drivers/usb/host/sl811-hcd.c
index 6dedefada92b..873300e8cd27 100644
--- a/drivers/usb/host/sl811-hcd.c
+++ b/drivers/usb/host/sl811-hcd.c
@@ -585,6 +585,7 @@ done(struct sl811 *sl811, struct sl811h_ep *ep, u8 bank)
 		finish_request(sl811, ep, urb, urbstat);
 }
 
+#ifdef QUIRK2
 static inline u8 checkdone(struct sl811 *sl811)
 {
 	u8	ctl;
@@ -616,6 +617,7 @@ static inline u8 checkdone(struct sl811 *sl811)
 #endif
 	return irqstat;
 }
+#endif
 
 static irqreturn_t sl811h_irq(struct usb_hcd *hcd)
 {
diff --git a/drivers/usb/serial/cp210x.c b/drivers/usb/serial/cp210x.c
index b58ca66dc3ae..4686cf7c6b0a 100644
--- a/drivers/usb/serial/cp210x.c
+++ b/drivers/usb/serial/cp210x.c
@@ -57,6 +57,8 @@ static const struct usb_device_id id_table[] = {
 	{ USB_DEVICE(0x0471, 0x066A) }, /* AKTAKOM ACE-1001 cable */
 	{ USB_DEVICE(0x0489, 0xE000) }, /* Pirelli Broadband S.p.A, DP-L10 SIP/GSM Mobile */
 	{ USB_DEVICE(0x0489, 0xE003) }, /* Pirelli Broadband S.p.A, DP-L10 SIP/GSM Mobile */
+	{ USB_DEVICE(0x04BF, 0x1301) }, /* TDK Corporation NC0110013M - Network Controller */
+	{ USB_DEVICE(0x04BF, 0x1303) }, /* TDK Corporation MM0110113M - i3 Micro Module */
 	{ USB_DEVICE(0x0745, 0x1000) }, /* CipherLab USB CCD Barcode Scanner 1000 */
 	{ USB_DEVICE(0x0846, 0x1100) }, /* NetGear Managed Switch M4100 series, M5300 series, M7100 series */
 	{ USB_DEVICE(0x08e6, 0x5501) }, /* Gemalto Prox-PU/CU contactless smartcard reader */
@@ -145,6 +147,7 @@ static const struct usb_device_id id_table[] = {
 	{ USB_DEVICE(0x10C4, 0x85EA) }, /* AC-Services IBUS-IF */
 	{ USB_DEVICE(0x10C4, 0x85EB) }, /* AC-Services CIS-IBUS */
 	{ USB_DEVICE(0x10C4, 0x85F8) }, /* Virtenio Preon32 */
+	{ USB_DEVICE(0x10C4, 0x863C) }, /* MGP Instruments PDS100 */
 	{ USB_DEVICE(0x10C4, 0x8664) }, /* AC-Services CAN-IF */
 	{ USB_DEVICE(0x10C4, 0x8665) }, /* AC-Services OBD-IF */
 	{ USB_DEVICE(0x10C4, 0x87ED) }, /* IMST USB-Stick for Smart Meter */
@@ -178,6 +181,7 @@ static const struct usb_device_id id_table[] = {
 	{ USB_DEVICE(0x10C4, 0xF004) }, /* Elan Digital Systems USBcount50 */
 	{ USB_DEVICE(0x10C5, 0xEA61) }, /* Silicon Labs MobiData GPRS USB Modem */
 	{ USB_DEVICE(0x10CE, 0xEA6A) }, /* Silicon Labs MobiData GPRS USB Modem 100EU */
+	{ USB_DEVICE(0x11CA, 0x0212) }, /* Verifone USB to Printer (UART, CP2102) */
 	{ USB_DEVICE(0x12B8, 0xEC60) }, /* Link G4 ECU */
 	{ USB_DEVICE(0x12B8, 0xEC62) }, /* Link G4+ ECU */
 	{ USB_DEVICE(0x13AD, 0x9999) }, /* Baltech card reader */
diff --git a/drivers/usb/serial/ftdi_sio.c b/drivers/usb/serial/ftdi_sio.c
index 6d4c572807a4..755cbc9525a1 100644
--- a/drivers/usb/serial/ftdi_sio.c
+++ b/drivers/usb/serial/ftdi_sio.c
@@ -1045,6 +1045,8 @@ static const struct usb_device_id id_table_combined[] = {
 		.driver_info = (kernel_ulong_t)&ftdi_jtag_quirk },
 	{ USB_DEVICE(FTDI_VID, FTDI_FALCONIA_JTAG_UNBUF_PID),
 		.driver_info = (kernel_ulong_t)&ftdi_jtag_quirk },
+	/* GMC devices */
+	{ USB_DEVICE(GMC_VID, GMC_Z216C_PID) },
 	{ }					/* Terminating entry */
 };
 
diff --git a/drivers/usb/serial/ftdi_sio_ids.h b/drivers/usb/serial/ftdi_sio_ids.h
index 9a0f9fc99124..b2aec1106678 100644
--- a/drivers/usb/serial/ftdi_sio_ids.h
+++ b/drivers/usb/serial/ftdi_sio_ids.h
@@ -1599,3 +1599,9 @@
 #define UBLOX_VID			0x1546
 #define UBLOX_C099F9P_ZED_PID		0x0502
 #define UBLOX_C099F9P_ODIN_PID		0x0503
+
+/*
+ * GMC devices
+ */
+#define GMC_VID				0x1cd7
+#define GMC_Z216C_PID			0x0217 /* GMC Z216C Adapter IR-USB */
diff --git a/drivers/usb/serial/option.c b/drivers/usb/serial/option.c
index 5014f45c7c6a..7f4baceb540c 100644
--- a/drivers/usb/serial/option.c
+++ b/drivers/usb/serial/option.c
@@ -613,6 +613,11 @@ static void option_instat_callback(struct urb *urb);
 /* Luat Air72*U series based on UNISOC UIS8910 uses UNISOC's vendor ID */
 #define LUAT_PRODUCT_AIR720U			0x4e00
 
+/* MeiG Smart Technology products */
+#define MEIGSMART_VENDOR_ID			0x2dee
+/* MeiG Smart SLM320 based on UNISOC UIS8910 */
+#define MEIGSMART_PRODUCT_SLM320		0x4d41
+
 /* Device flags */
 
 /* Highest interface number which can be used with NCTRL() and RSVD() */
@@ -2282,6 +2287,7 @@ static const struct usb_device_id option_ids[] = {
 	{ USB_DEVICE_AND_INTERFACE_INFO(SIERRA_VENDOR_ID, SIERRA_PRODUCT_EM9191, 0xff, 0, 0) },
 	{ USB_DEVICE_AND_INTERFACE_INFO(UNISOC_VENDOR_ID, TOZED_PRODUCT_LT70C, 0xff, 0, 0) },
 	{ USB_DEVICE_AND_INTERFACE_INFO(UNISOC_VENDOR_ID, LUAT_PRODUCT_AIR720U, 0xff, 0, 0) },
+	{ USB_DEVICE_AND_INTERFACE_INFO(MEIGSMART_VENDOR_ID, MEIGSMART_PRODUCT_SLM320, 0xff, 0, 0) },
 	{ } /* Terminating entry */
 };
 MODULE_DEVICE_TABLE(usb, option_ids);
diff --git a/drivers/usb/storage/isd200.c b/drivers/usb/storage/isd200.c
index f5e4500d9970..b7255659229c 100644
--- a/drivers/usb/storage/isd200.c
+++ b/drivers/usb/storage/isd200.c
@@ -1104,7 +1104,7 @@ static void isd200_dump_driveid(struct us_data *us, u16 *id)
 static int isd200_get_inquiry_data( struct us_data *us )
 {
 	struct isd200_info *info = (struct isd200_info *)us->extra;
-	int retStatus = ISD200_GOOD;
+	int retStatus;
 	u16 *id = info->id;
 
 	usb_stor_dbg(us, "Entering isd200_get_inquiry_data\n");
@@ -1136,6 +1136,13 @@ static int isd200_get_inquiry_data( struct us_data *us )
 				isd200_fix_driveid(id);
 				isd200_dump_driveid(us, id);
 
+				/* Prevent division by 0 in isd200_scsi_to_ata() */
+				if (id[ATA_ID_HEADS] == 0 || id[ATA_ID_SECTORS] == 0) {
+					usb_stor_dbg(us, "   Invalid ATA Identify data\n");
+					retStatus = ISD200_ERROR;
+					goto Done;
+				}
+
 				memset(&info->InquiryData, 0, sizeof(info->InquiryData));
 
 				/* Standard IDE interface only supports disks */
@@ -1201,6 +1208,7 @@ static int isd200_get_inquiry_data( struct us_data *us )
 		}
 	}
 
+ Done:
 	usb_stor_dbg(us, "Leaving isd200_get_inquiry_data %08X\n", retStatus);
 
 	return(retStatus);
@@ -1480,22 +1488,27 @@ static int isd200_init_info(struct us_data *us)
 
 static int isd200_Initialization(struct us_data *us)
 {
+	int rc = 0;
+
 	usb_stor_dbg(us, "ISD200 Initialization...\n");
 
 	/* Initialize ISD200 info struct */
 
-	if (isd200_init_info(us) == ISD200_ERROR) {
+	if (isd200_init_info(us) < 0) {
 		usb_stor_dbg(us, "ERROR Initializing ISD200 Info struct\n");
+		rc = -ENOMEM;
 	} else {
 		/* Get device specific data */
 
-		if (isd200_get_inquiry_data(us) != ISD200_GOOD)
+		if (isd200_get_inquiry_data(us) != ISD200_GOOD) {
 			usb_stor_dbg(us, "ISD200 Initialization Failure\n");
-		else
+			rc = -EINVAL;
+		} else {
 			usb_stor_dbg(us, "ISD200 Initialization complete\n");
+		}
 	}
 
-	return 0;
+	return rc;
 }
 
 
diff --git a/drivers/vfio/platform/vfio_platform_irq.c b/drivers/vfio/platform/vfio_platform_irq.c
index 46d4750f43a8..c53a9b443873 100644
--- a/drivers/vfio/platform/vfio_platform_irq.c
+++ b/drivers/vfio/platform/vfio_platform_irq.c
@@ -329,8 +329,11 @@ void vfio_platform_irq_cleanup(struct vfio_platform_device *vdev)
 {
 	int i;
 
-	for (i = 0; i < vdev->num_irqs; i++)
+	for (i = 0; i < vdev->num_irqs; i++) {
+		vfio_virqfd_disable(&vdev->irqs[i].mask);
+		vfio_virqfd_disable(&vdev->irqs[i].unmask);
 		vfio_set_trigger(vdev, i, -1, NULL);
+	}
 
 	vdev->num_irqs = 0;
 	kfree(vdev->irqs);
diff --git a/drivers/video/fbdev/core/fbmon.c b/drivers/video/fbdev/core/fbmon.c
index 8607439d6932..e4040fb860bb 100644
--- a/drivers/video/fbdev/core/fbmon.c
+++ b/drivers/video/fbdev/core/fbmon.c
@@ -1309,7 +1309,7 @@ int fb_get_mode(int flags, u32 val, struct fb_var_screeninfo *var, struct fb_inf
 int fb_videomode_from_videomode(const struct videomode *vm,
 				struct fb_videomode *fbmode)
 {
-	unsigned int htotal, vtotal;
+	unsigned int htotal, vtotal, total;
 
 	fbmode->xres = vm->hactive;
 	fbmode->left_margin = vm->hback_porch;
@@ -1342,8 +1342,9 @@ int fb_videomode_from_videomode(const struct videomode *vm,
 	vtotal = vm->vactive + vm->vfront_porch + vm->vback_porch +
 		 vm->vsync_len;
 	/* prevent division by zero */
-	if (htotal && vtotal) {
-		fbmode->refresh = vm->pixelclock / (htotal * vtotal);
+	total = htotal * vtotal;
+	if (total) {
+		fbmode->refresh = vm->pixelclock / total;
 	/* a mode must have htotal and vtotal != 0 or it is invalid */
 	} else {
 		fbmode->refresh = 0;
diff --git a/drivers/video/fbdev/via/accel.c b/drivers/video/fbdev/via/accel.c
index eb3615c69987..f542b01568df 100644
--- a/drivers/video/fbdev/via/accel.c
+++ b/drivers/video/fbdev/via/accel.c
@@ -129,7 +129,7 @@ static int hw_bitblt_1(void __iomem *engine, u8 op, u32 width, u32 height,
 
 	if (op != VIA_BITBLT_FILL) {
 		tmp = src_mem ? 0 : src_addr;
-		if (dst_addr & 0xE0000007) {
+		if (tmp & 0xE0000007) {
 			printk(KERN_WARNING "hw_bitblt_1: Unsupported source "
 				"address %X\n", tmp);
 			return -EINVAL;
@@ -274,7 +274,7 @@ static int hw_bitblt_2(void __iomem *engine, u8 op, u32 width, u32 height,
 		writel(tmp, engine + 0x18);
 
 		tmp = src_mem ? 0 : src_addr;
-		if (dst_addr & 0xE0000007) {
+		if (tmp & 0xE0000007) {
 			printk(KERN_WARNING "hw_bitblt_2: Unsupported source "
 				"address %X\n", tmp);
 			return -EINVAL;
diff --git a/drivers/virtio/virtio.c b/drivers/virtio/virtio.c
index 89935105df49..3a16ac6b47fc 100644
--- a/drivers/virtio/virtio.c
+++ b/drivers/virtio/virtio.c
@@ -376,13 +376,19 @@ EXPORT_SYMBOL_GPL(unregister_virtio_device);
 int virtio_device_freeze(struct virtio_device *dev)
 {
 	struct virtio_driver *drv = drv_to_virtio(dev->dev.driver);
+	int ret;
 
 	virtio_config_disable(dev);
 
 	dev->failed = dev->config->get_status(dev) & VIRTIO_CONFIG_S_FAILED;
 
-	if (drv && drv->freeze)
-		return drv->freeze(dev);
+	if (drv && drv->freeze) {
+		ret = drv->freeze(dev);
+		if (ret) {
+			virtio_config_enable(dev);
+			return ret;
+		}
+	}
 
 	return 0;
 }
diff --git a/fs/aio.c b/fs/aio.c
index 8ad748dd3e48..146681fb7e8a 100644
--- a/fs/aio.c
+++ b/fs/aio.c
@@ -562,8 +562,8 @@ static int aio_setup_ring(struct kioctx *ctx, unsigned int nr_events)
 
 void kiocb_set_cancel_fn(struct kiocb *iocb, kiocb_cancel_fn *cancel)
 {
-	struct aio_kiocb *req = container_of(iocb, struct aio_kiocb, rw);
-	struct kioctx *ctx = req->ki_ctx;
+	struct aio_kiocb *req;
+	struct kioctx *ctx;
 	unsigned long flags;
 
 	/*
@@ -573,9 +573,13 @@ void kiocb_set_cancel_fn(struct kiocb *iocb, kiocb_cancel_fn *cancel)
 	if (!(iocb->ki_flags & IOCB_AIO_RW))
 		return;
 
+	req = container_of(iocb, struct aio_kiocb, rw);
+
 	if (WARN_ON_ONCE(!list_empty(&req->ki_list)))
 		return;
 
+	ctx = req->ki_ctx;
+
 	spin_lock_irqsave(&ctx->ctx_lock, flags);
 	list_add_tail(&req->ki_list, &ctx->active_reqs);
 	req->ki_cancel = cancel;
diff --git a/fs/btrfs/export.c b/fs/btrfs/export.c
index ecc33e3a3c06..01e9a5afc33b 100644
--- a/fs/btrfs/export.c
+++ b/fs/btrfs/export.c
@@ -182,8 +182,15 @@ struct dentry *btrfs_get_parent(struct dentry *child)
 	ret = btrfs_search_slot(NULL, root, &key, path, 0, 0);
 	if (ret < 0)
 		goto fail;
+	if (ret == 0) {
+		/*
+		 * Key with offset of -1 found, there would have to exist an
+		 * inode with such number or a root with such id.
+		 */
+		ret = -EUCLEAN;
+		goto fail;
+	}
 
-	BUG_ON(ret == 0); /* Key with offset of -1 found */
 	if (path->slots[0] == 0) {
 		ret = -ENOENT;
 		goto fail;
diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
index a4c0fc19c5e8..b77dffd32208 100644
--- a/fs/btrfs/ioctl.c
+++ b/fs/btrfs/ioctl.c
@@ -2992,7 +2992,7 @@ static int btrfs_ioctl_defrag(struct file *file, void __user *argp)
 {
 	struct inode *inode = file_inode(file);
 	struct btrfs_root *root = BTRFS_I(inode)->root;
-	struct btrfs_ioctl_defrag_range_args *range;
+	struct btrfs_ioctl_defrag_range_args range = {0};
 	int ret;
 
 	ret = mnt_want_write_file(file);
@@ -3024,37 +3024,28 @@ static int btrfs_ioctl_defrag(struct file *file, void __user *argp)
 			goto out;
 		}
 
-		range = kzalloc(sizeof(*range), GFP_KERNEL);
-		if (!range) {
-			ret = -ENOMEM;
-			goto out;
-		}
-
 		if (argp) {
-			if (copy_from_user(range, argp,
-					   sizeof(*range))) {
+			if (copy_from_user(&range, argp, sizeof(range))) {
 				ret = -EFAULT;
-				kfree(range);
 				goto out;
 			}
-			if (range->flags & ~BTRFS_DEFRAG_RANGE_FLAGS_SUPP) {
+			if (range.flags & ~BTRFS_DEFRAG_RANGE_FLAGS_SUPP) {
 				ret = -EOPNOTSUPP;
 				goto out;
 			}
 			/* compression requires us to start the IO */
-			if ((range->flags & BTRFS_DEFRAG_RANGE_COMPRESS)) {
-				range->flags |= BTRFS_DEFRAG_RANGE_START_IO;
-				range->extent_thresh = (u32)-1;
+			if ((range.flags & BTRFS_DEFRAG_RANGE_COMPRESS)) {
+				range.flags |= BTRFS_DEFRAG_RANGE_START_IO;
+				range.extent_thresh = (u32)-1;
 			}
 		} else {
 			/* the rest are all set to zero by kzalloc */
-			range->len = (u64)-1;
+			range.len = (u64)-1;
 		}
 		ret = btrfs_defrag_file(file_inode(file), file,
-					range, BTRFS_OLDEST_GENERATION, 0);
+					&range, BTRFS_OLDEST_GENERATION, 0);
 		if (ret > 0)
 			ret = 0;
-		kfree(range);
 		break;
 	default:
 		ret = -EINVAL;
diff --git a/fs/btrfs/send.c b/fs/btrfs/send.c
index 0c86409a316e..e3b6ca9176af 100644
--- a/fs/btrfs/send.c
+++ b/fs/btrfs/send.c
@@ -958,7 +958,15 @@ static int iterate_inode_ref(struct btrfs_root *root, struct btrfs_path *path,
 					ret = PTR_ERR(start);
 					goto out;
 				}
-				BUG_ON(start < p->buf);
+				if (unlikely(start < p->buf)) {
+					btrfs_err(root->fs_info,
+			"send: path ref buffer underflow for key (%llu %u %llu)",
+						  found_key->objectid,
+						  found_key->type,
+						  found_key->offset);
+					ret = -EINVAL;
+					goto out;
+				}
 			}
 			p->start = start;
 		} else {
diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index ceced5e56c5a..30b5646b2c0d 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -2948,7 +2948,17 @@ static int btrfs_relocate_sys_chunks(struct btrfs_fs_info *fs_info)
 			mutex_unlock(&fs_info->delete_unused_bgs_mutex);
 			goto error;
 		}
-		BUG_ON(ret == 0); /* Corruption */
+		if (ret == 0) {
+			/*
+			 * On the first search we would find chunk tree with
+			 * offset -1, which is not possible. On subsequent
+			 * loops this would find an existing item on an invalid
+			 * offset (one less than the previous one, wrong
+			 * alignment and size).
+			 */
+			ret = -EUCLEAN;
+			goto error;
+		}
 
 		ret = btrfs_previous_item(chunk_root, path, key.objectid,
 					  key.type);
diff --git a/fs/exec.c b/fs/exec.c
index 28e3b5eb2f4a..7ada94402ec9 100644
--- a/fs/exec.c
+++ b/fs/exec.c
@@ -823,6 +823,7 @@ int transfer_args_to_stack(struct linux_binprm *bprm,
 			goto out;
 	}
 
+	bprm->exec += *sp_location - MAX_ARG_PAGES * PAGE_SIZE;
 	*sp_location = sp;
 
 out:
diff --git a/fs/ext4/resize.c b/fs/ext4/resize.c
index 97af09d6e7e6..7d615c00b632 100644
--- a/fs/ext4/resize.c
+++ b/fs/ext4/resize.c
@@ -1567,7 +1567,8 @@ static int ext4_flex_group_add(struct super_block *sb,
 		int gdb_num = group / EXT4_DESC_PER_BLOCK(sb);
 		int gdb_num_end = ((group + flex_gd->count - 1) /
 				   EXT4_DESC_PER_BLOCK(sb));
-		int meta_bg = ext4_has_feature_meta_bg(sb);
+		int meta_bg = ext4_has_feature_meta_bg(sb) &&
+			      gdb_num >= le32_to_cpu(es->s_first_meta_bg);
 		sector_t padding_blocks = meta_bg ? 0 : sbi->s_sbh->b_blocknr -
 					 ext4_group_first_block_no(sb, 0);
 		sector_t old_gdb = 0;
diff --git a/fs/fat/nfs.c b/fs/fat/nfs.c
index eb192656fba2..f442a8d2f114 100644
--- a/fs/fat/nfs.c
+++ b/fs/fat/nfs.c
@@ -139,6 +139,12 @@ fat_encode_fh_nostale(struct inode *inode, __u32 *fh, int *lenp,
 		fid->parent_i_gen = parent->i_generation;
 		type = FILEID_FAT_WITH_PARENT;
 		*lenp = FAT_FID_SIZE_WITH_PARENT;
+	} else {
+		/*
+		 * We need to initialize this field because the fh is actually
+		 * 12 bytes long
+		 */
+		fid->parent_i_pos_hi = 0;
 	}
 
 	return type;
diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
index 1c754a02fb06..aa0a5e396090 100644
--- a/fs/fuse/fuse_i.h
+++ b/fs/fuse/fuse_i.h
@@ -706,7 +706,6 @@ static inline u64 get_node_id(struct inode *inode)
 
 static inline void fuse_make_bad(struct inode *inode)
 {
-	remove_inode_hash(inode);
 	set_bit(FUSE_I_BAD, &get_fuse_inode(inode)->state);
 }
 
diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
index 3b51c881baf8..a67769c357b2 100644
--- a/fs/fuse/inode.c
+++ b/fs/fuse/inode.c
@@ -324,8 +324,11 @@ struct inode *fuse_iget(struct super_block *sb, u64 nodeid,
 	} else if ((inode->i_mode ^ attr->mode) & S_IFMT) {
 		/* Inode has changed type, any I/O on the old should fail */
 		fuse_make_bad(inode);
-		iput(inode);
-		goto retry;
+		if (inode != d_inode(sb->s_root)) {
+			remove_inode_hash(inode);
+			iput(inode);
+			goto retry;
+		}
 	}
 
 	fi = get_fuse_inode(inode);
diff --git a/fs/isofs/inode.c b/fs/isofs/inode.c
index 6e4e2cfd40b9..aec11a7676c9 100644
--- a/fs/isofs/inode.c
+++ b/fs/isofs/inode.c
@@ -910,8 +910,22 @@ static int isofs_fill_super(struct super_block *s, void *data, int silent)
 	 * we then decide whether to use the Joliet descriptor.
 	 */
 	inode = isofs_iget(s, sbi->s_firstdatazone, 0);
-	if (IS_ERR(inode))
-		goto out_no_root;
+
+	/*
+	 * Fix for broken CDs with a corrupt root inode but a correct Joliet
+	 * root directory.
+	 */
+	if (IS_ERR(inode)) {
+		if (joliet_level && sbi->s_firstdatazone != first_data_zone) {
+			printk(KERN_NOTICE
+			       "ISOFS: root inode is unusable. "
+			       "Disabling Rock Ridge and switching to Joliet.");
+			sbi->s_rock = 0;
+			inode = NULL;
+		} else {
+			goto out_no_root;
+		}
+	}
 
 	/*
 	 * Fix for broken CDs with Rock Ridge and empty ISO root directory but
diff --git a/fs/nilfs2/alloc.c b/fs/nilfs2/alloc.c
index bbd82f650e93..279d945d4ebe 100644
--- a/fs/nilfs2/alloc.c
+++ b/fs/nilfs2/alloc.c
@@ -614,10 +614,10 @@ void nilfs_palloc_commit_free_entry(struct inode *inode,
 	lock = nilfs_mdt_bgl_lock(inode, group);
 
 	if (!nilfs_clear_bit_atomic(lock, group_offset, bitmap))
-		nilfs_msg(inode->i_sb, KERN_WARNING,
-			  "%s (ino=%lu): entry number %llu already freed",
-			  __func__, inode->i_ino,
-			  (unsigned long long)req->pr_entry_nr);
+		nilfs_warn(inode->i_sb,
+			   "%s (ino=%lu): entry number %llu already freed",
+			   __func__, inode->i_ino,
+			   (unsigned long long)req->pr_entry_nr);
 	else
 		nilfs_palloc_group_desc_add_entries(desc, lock, 1);
 
@@ -655,10 +655,10 @@ void nilfs_palloc_abort_alloc_entry(struct inode *inode,
 	lock = nilfs_mdt_bgl_lock(inode, group);
 
 	if (!nilfs_clear_bit_atomic(lock, group_offset, bitmap))
-		nilfs_msg(inode->i_sb, KERN_WARNING,
-			  "%s (ino=%lu): entry number %llu already freed",
-			  __func__, inode->i_ino,
-			  (unsigned long long)req->pr_entry_nr);
+		nilfs_warn(inode->i_sb,
+			   "%s (ino=%lu): entry number %llu already freed",
+			   __func__, inode->i_ino,
+			   (unsigned long long)req->pr_entry_nr);
 	else
 		nilfs_palloc_group_desc_add_entries(desc, lock, 1);
 
@@ -764,10 +764,10 @@ int nilfs_palloc_freev(struct inode *inode, __u64 *entry_nrs, size_t nitems)
 		do {
 			if (!nilfs_clear_bit_atomic(lock, group_offset,
 						    bitmap)) {
-				nilfs_msg(inode->i_sb, KERN_WARNING,
-					  "%s (ino=%lu): entry number %llu already freed",
-					  __func__, inode->i_ino,
-					  (unsigned long long)entry_nrs[j]);
+				nilfs_warn(inode->i_sb,
+					   "%s (ino=%lu): entry number %llu already freed",
+					   __func__, inode->i_ino,
+					   (unsigned long long)entry_nrs[j]);
 			} else {
 				n++;
 			}
@@ -809,10 +809,10 @@ int nilfs_palloc_freev(struct inode *inode, __u64 *entry_nrs, size_t nitems)
 			ret = nilfs_palloc_delete_entry_block(inode,
 							      last_nrs[k]);
 			if (ret && ret != -ENOENT)
-				nilfs_msg(inode->i_sb, KERN_WARNING,
-					  "error %d deleting block that object (entry=%llu, ino=%lu) belongs to",
-					  ret, (unsigned long long)last_nrs[k],
-					  inode->i_ino);
+				nilfs_warn(inode->i_sb,
+					   "error %d deleting block that object (entry=%llu, ino=%lu) belongs to",
+					   ret, (unsigned long long)last_nrs[k],
+					   inode->i_ino);
 		}
 
 		desc_kaddr = kmap_atomic(desc_bh->b_page);
@@ -827,9 +827,9 @@ int nilfs_palloc_freev(struct inode *inode, __u64 *entry_nrs, size_t nitems)
 		if (nfree == nilfs_palloc_entries_per_group(inode)) {
 			ret = nilfs_palloc_delete_bitmap_block(inode, group);
 			if (ret && ret != -ENOENT)
-				nilfs_msg(inode->i_sb, KERN_WARNING,
-					  "error %d deleting bitmap block of group=%lu, ino=%lu",
-					  ret, group, inode->i_ino);
+				nilfs_warn(inode->i_sb,
+					   "error %d deleting bitmap block of group=%lu, ino=%lu",
+					   ret, group, inode->i_ino);
 		}
 	}
 	return 0;
diff --git a/fs/nilfs2/btree.c b/fs/nilfs2/btree.c
index a0e37530dcf3..4905b7cd7bf3 100644
--- a/fs/nilfs2/btree.c
+++ b/fs/nilfs2/btree.c
@@ -352,10 +352,10 @@ static int nilfs_btree_node_broken(const struct nilfs_btree_node *node,
 		     (flags & NILFS_BTREE_NODE_ROOT) ||
 		     nchildren < 0 ||
 		     nchildren > NILFS_BTREE_NODE_NCHILDREN_MAX(size))) {
-		nilfs_msg(inode->i_sb, KERN_CRIT,
-			  "bad btree node (ino=%lu, blocknr=%llu): level = %d, flags = 0x%x, nchildren = %d",
-			  inode->i_ino, (unsigned long long)blocknr, level,
-			  flags, nchildren);
+		nilfs_crit(inode->i_sb,
+			   "bad btree node (ino=%lu, blocknr=%llu): level = %d, flags = 0x%x, nchildren = %d",
+			   inode->i_ino, (unsigned long long)blocknr, level,
+			   flags, nchildren);
 		ret = 1;
 	}
 	return ret;
@@ -382,9 +382,9 @@ static int nilfs_btree_root_broken(const struct nilfs_btree_node *node,
 		     level >= NILFS_BTREE_LEVEL_MAX ||
 		     nchildren < 0 ||
 		     nchildren > NILFS_BTREE_ROOT_NCHILDREN_MAX)) {
-		nilfs_msg(inode->i_sb, KERN_CRIT,
-			  "bad btree root (ino=%lu): level = %d, flags = 0x%x, nchildren = %d",
-			  inode->i_ino, level, flags, nchildren);
+		nilfs_crit(inode->i_sb,
+			   "bad btree root (ino=%lu): level = %d, flags = 0x%x, nchildren = %d",
+			   inode->i_ino, level, flags, nchildren);
 		ret = 1;
 	}
 	return ret;
@@ -451,10 +451,10 @@ static int nilfs_btree_bad_node(const struct nilfs_bmap *btree,
 {
 	if (unlikely(nilfs_btree_node_get_level(node) != level)) {
 		dump_stack();
-		nilfs_msg(btree->b_inode->i_sb, KERN_CRIT,
-			  "btree level mismatch (ino=%lu): %d != %d",
-			  btree->b_inode->i_ino,
-			  nilfs_btree_node_get_level(node), level);
+		nilfs_crit(btree->b_inode->i_sb,
+			   "btree level mismatch (ino=%lu): %d != %d",
+			   btree->b_inode->i_ino,
+			   nilfs_btree_node_get_level(node), level);
 		return 1;
 	}
 	return 0;
@@ -519,7 +519,7 @@ static int __nilfs_btree_get_block(const struct nilfs_bmap *btree, __u64 ptr,
 
  out_no_wait:
 	if (!buffer_uptodate(bh)) {
-		nilfs_msg(btree->b_inode->i_sb, KERN_ERR,
+		nilfs_err(btree->b_inode->i_sb,
 			  "I/O error reading b-tree node block (ino=%lu, blocknr=%llu)",
 			  btree->b_inode->i_ino, (unsigned long long)ptr);
 		brelse(bh);
@@ -724,7 +724,7 @@ static int nilfs_btree_lookup_contig(const struct nilfs_bmap *btree,
 		dat = nilfs_bmap_get_dat(btree);
 		ret = nilfs_dat_translate(dat, ptr, &blocknr);
 		if (ret < 0)
-			goto out;
+			goto dat_error;
 		ptr = blocknr;
 	}
 	cnt = 1;
@@ -743,7 +743,7 @@ static int nilfs_btree_lookup_contig(const struct nilfs_bmap *btree,
 			if (dat) {
 				ret = nilfs_dat_translate(dat, ptr2, &blocknr);
 				if (ret < 0)
-					goto out;
+					goto dat_error;
 				ptr2 = blocknr;
 			}
 			if (ptr2 != ptr + cnt || ++cnt == maxblocks)
@@ -782,6 +782,11 @@ static int nilfs_btree_lookup_contig(const struct nilfs_bmap *btree,
  out:
 	nilfs_btree_free_path(path);
 	return ret;
+
+ dat_error:
+	if (ret == -ENOENT)
+		ret = -EINVAL;  /* Notify bmap layer of metadata corruption */
+	goto out;
 }
 
 static void nilfs_btree_promote_key(struct nilfs_bmap *btree,
@@ -2089,10 +2094,10 @@ static int nilfs_btree_propagate(struct nilfs_bmap *btree,
 	ret = nilfs_btree_do_lookup(btree, path, key, NULL, level + 1, 0);
 	if (ret < 0) {
 		if (unlikely(ret == -ENOENT))
-			nilfs_msg(btree->b_inode->i_sb, KERN_CRIT,
-				  "writing node/leaf block does not appear in b-tree (ino=%lu) at key=%llu, level=%d",
-				  btree->b_inode->i_ino,
-				  (unsigned long long)key, level);
+			nilfs_crit(btree->b_inode->i_sb,
+				   "writing node/leaf block does not appear in b-tree (ino=%lu) at key=%llu, level=%d",
+				   btree->b_inode->i_ino,
+				   (unsigned long long)key, level);
 		goto out;
 	}
 
@@ -2129,11 +2134,11 @@ static void nilfs_btree_add_dirty_buffer(struct nilfs_bmap *btree,
 	if (level < NILFS_BTREE_LEVEL_NODE_MIN ||
 	    level >= NILFS_BTREE_LEVEL_MAX) {
 		dump_stack();
-		nilfs_msg(btree->b_inode->i_sb, KERN_WARNING,
-			  "invalid btree level: %d (key=%llu, ino=%lu, blocknr=%llu)",
-			  level, (unsigned long long)key,
-			  btree->b_inode->i_ino,
-			  (unsigned long long)bh->b_blocknr);
+		nilfs_warn(btree->b_inode->i_sb,
+			   "invalid btree level: %d (key=%llu, ino=%lu, blocknr=%llu)",
+			   level, (unsigned long long)key,
+			   btree->b_inode->i_ino,
+			   (unsigned long long)bh->b_blocknr);
 		return;
 	}
 
diff --git a/fs/nilfs2/cpfile.c b/fs/nilfs2/cpfile.c
index 8d41311b5db4..86d4d850d130 100644
--- a/fs/nilfs2/cpfile.c
+++ b/fs/nilfs2/cpfile.c
@@ -322,7 +322,7 @@ int nilfs_cpfile_delete_checkpoints(struct inode *cpfile,
 	int ret, ncps, nicps, nss, count, i;
 
 	if (unlikely(start == 0 || start > end)) {
-		nilfs_msg(cpfile->i_sb, KERN_ERR,
+		nilfs_err(cpfile->i_sb,
 			  "cannot delete checkpoints: invalid range [%llu, %llu)",
 			  (unsigned long long)start, (unsigned long long)end);
 		return -EINVAL;
@@ -376,7 +376,7 @@ int nilfs_cpfile_delete_checkpoints(struct inode *cpfile,
 								   cpfile, cno);
 					if (ret == 0)
 						continue;
-					nilfs_msg(cpfile->i_sb, KERN_ERR,
+					nilfs_err(cpfile->i_sb,
 						  "error %d deleting checkpoint block",
 						  ret);
 					break;
@@ -981,12 +981,10 @@ int nilfs_cpfile_read(struct super_block *sb, size_t cpsize,
 	int err;
 
 	if (cpsize > sb->s_blocksize) {
-		nilfs_msg(sb, KERN_ERR,
-			  "too large checkpoint size: %zu bytes", cpsize);
+		nilfs_err(sb, "too large checkpoint size: %zu bytes", cpsize);
 		return -EINVAL;
 	} else if (cpsize < NILFS_MIN_CHECKPOINT_SIZE) {
-		nilfs_msg(sb, KERN_ERR,
-			  "too small checkpoint size: %zu bytes", cpsize);
+		nilfs_err(sb, "too small checkpoint size: %zu bytes", cpsize);
 		return -EINVAL;
 	}
 
diff --git a/fs/nilfs2/dat.c b/fs/nilfs2/dat.c
index b9c759addd50..c47e1f6f23a8 100644
--- a/fs/nilfs2/dat.c
+++ b/fs/nilfs2/dat.c
@@ -354,11 +354,11 @@ int nilfs_dat_move(struct inode *dat, __u64 vblocknr, sector_t blocknr)
 	kaddr = kmap_atomic(entry_bh->b_page);
 	entry = nilfs_palloc_block_get_entry(dat, vblocknr, entry_bh, kaddr);
 	if (unlikely(entry->de_blocknr == cpu_to_le64(0))) {
-		nilfs_msg(dat->i_sb, KERN_CRIT,
-			  "%s: invalid vblocknr = %llu, [%llu, %llu)",
-			  __func__, (unsigned long long)vblocknr,
-			  (unsigned long long)le64_to_cpu(entry->de_start),
-			  (unsigned long long)le64_to_cpu(entry->de_end));
+		nilfs_crit(dat->i_sb,
+			   "%s: invalid vblocknr = %llu, [%llu, %llu)",
+			   __func__, (unsigned long long)vblocknr,
+			   (unsigned long long)le64_to_cpu(entry->de_start),
+			   (unsigned long long)le64_to_cpu(entry->de_end));
 		kunmap_atomic(kaddr);
 		brelse(entry_bh);
 		return -EINVAL;
@@ -485,11 +485,11 @@ int nilfs_dat_read(struct super_block *sb, size_t entry_size,
 	int err;
 
 	if (entry_size > sb->s_blocksize) {
-		nilfs_msg(sb, KERN_ERR, "too large DAT entry size: %zu bytes",
+		nilfs_err(sb, "too large DAT entry size: %zu bytes",
 			  entry_size);
 		return -EINVAL;
 	} else if (entry_size < NILFS_MIN_DAT_ENTRY_SIZE) {
-		nilfs_msg(sb, KERN_ERR, "too small DAT entry size: %zu bytes",
+		nilfs_err(sb, "too small DAT entry size: %zu bytes",
 			  entry_size);
 		return -EINVAL;
 	}
diff --git a/fs/nilfs2/direct.c b/fs/nilfs2/direct.c
index 533e24ea3a88..7faf8c285d6c 100644
--- a/fs/nilfs2/direct.c
+++ b/fs/nilfs2/direct.c
@@ -66,7 +66,7 @@ static int nilfs_direct_lookup_contig(const struct nilfs_bmap *direct,
 		dat = nilfs_bmap_get_dat(direct);
 		ret = nilfs_dat_translate(dat, ptr, &blocknr);
 		if (ret < 0)
-			return ret;
+			goto dat_error;
 		ptr = blocknr;
 	}
 
@@ -79,7 +79,7 @@ static int nilfs_direct_lookup_contig(const struct nilfs_bmap *direct,
 		if (dat) {
 			ret = nilfs_dat_translate(dat, ptr2, &blocknr);
 			if (ret < 0)
-				return ret;
+				goto dat_error;
 			ptr2 = blocknr;
 		}
 		if (ptr2 != ptr + cnt)
@@ -87,6 +87,11 @@ static int nilfs_direct_lookup_contig(const struct nilfs_bmap *direct,
 	}
 	*ptrp = ptr;
 	return cnt;
+
+ dat_error:
+	if (ret == -ENOENT)
+		ret = -EINVAL;  /* Notify bmap layer of metadata corruption */
+	return ret;
 }
 
 static __u64
@@ -328,16 +333,18 @@ static int nilfs_direct_assign(struct nilfs_bmap *bmap,
 
 	key = nilfs_bmap_data_get_key(bmap, *bh);
 	if (unlikely(key > NILFS_DIRECT_KEY_MAX)) {
-		nilfs_msg(bmap->b_inode->i_sb, KERN_CRIT,
-			  "%s (ino=%lu): invalid key: %llu", __func__,
-			  bmap->b_inode->i_ino, (unsigned long long)key);
+		nilfs_crit(bmap->b_inode->i_sb,
+			   "%s (ino=%lu): invalid key: %llu",
+			   __func__,
+			   bmap->b_inode->i_ino, (unsigned long long)key);
 		return -EINVAL;
 	}
 	ptr = nilfs_direct_get_ptr(bmap, key);
 	if (unlikely(ptr == NILFS_BMAP_INVALID_PTR)) {
-		nilfs_msg(bmap->b_inode->i_sb, KERN_CRIT,
-			  "%s (ino=%lu): invalid pointer: %llu", __func__,
-			  bmap->b_inode->i_ino, (unsigned long long)ptr);
+		nilfs_crit(bmap->b_inode->i_sb,
+			   "%s (ino=%lu): invalid pointer: %llu",
+			   __func__,
+			   bmap->b_inode->i_ino, (unsigned long long)ptr);
 		return -EINVAL;
 	}
 
diff --git a/fs/nilfs2/gcinode.c b/fs/nilfs2/gcinode.c
index cef46650102e..b0077f5f7112 100644
--- a/fs/nilfs2/gcinode.c
+++ b/fs/nilfs2/gcinode.c
@@ -143,7 +143,7 @@ int nilfs_gccache_wait_and_mark_dirty(struct buffer_head *bh)
 	if (!buffer_uptodate(bh)) {
 		struct inode *inode = bh->b_page->mapping->host;
 
-		nilfs_msg(inode->i_sb, KERN_ERR,
+		nilfs_err(inode->i_sb,
 			  "I/O error reading %s block for GC (ino=%lu, vblocknr=%llu)",
 			  buffer_nilfs_node(bh) ? "node" : "data",
 			  inode->i_ino, (unsigned long long)bh->b_blocknr);
diff --git a/fs/nilfs2/ifile.c b/fs/nilfs2/ifile.c
index 4140d232cadc..02727ed3a7c6 100644
--- a/fs/nilfs2/ifile.c
+++ b/fs/nilfs2/ifile.c
@@ -142,8 +142,8 @@ int nilfs_ifile_get_inode_block(struct inode *ifile, ino_t ino,
 
 	err = nilfs_palloc_get_entry_block(ifile, ino, 0, out_bh);
 	if (unlikely(err))
-		nilfs_msg(sb, KERN_WARNING, "error %d reading inode: ino=%lu",
-			  err, (unsigned long)ino);
+		nilfs_warn(sb, "error %d reading inode: ino=%lu",
+			   err, (unsigned long)ino);
 	return err;
 }
 
diff --git a/fs/nilfs2/inode.c b/fs/nilfs2/inode.c
index ea94dc21af0c..530edb813add 100644
--- a/fs/nilfs2/inode.c
+++ b/fs/nilfs2/inode.c
@@ -107,11 +107,11 @@ int nilfs_get_block(struct inode *inode, sector_t blkoff,
 				 * However, the page having this block must
 				 * be locked in this case.
 				 */
-				nilfs_msg(inode->i_sb, KERN_WARNING,
-					  "%s (ino=%lu): a race condition while inserting a data block at offset=%llu",
-					  __func__, inode->i_ino,
-					  (unsigned long long)blkoff);
-				err = 0;
+				nilfs_warn(inode->i_sb,
+					   "%s (ino=%lu): a race condition while inserting a data block at offset=%llu",
+					   __func__, inode->i_ino,
+					   (unsigned long long)blkoff);
+				err = -EAGAIN;
 			}
 			nilfs_transaction_abort(inode->i_sb);
 			goto out;
@@ -862,9 +862,8 @@ static void nilfs_truncate_bmap(struct nilfs_inode_info *ii,
 		goto repeat;
 
 failed:
-	nilfs_msg(ii->vfs_inode.i_sb, KERN_WARNING,
-		  "error %d truncating bmap (ino=%lu)", ret,
-		  ii->vfs_inode.i_ino);
+	nilfs_warn(ii->vfs_inode.i_sb, "error %d truncating bmap (ino=%lu)",
+		   ret, ii->vfs_inode.i_ino);
 }
 
 void nilfs_truncate(struct inode *inode)
@@ -1097,9 +1096,9 @@ int nilfs_set_file_dirty(struct inode *inode, unsigned int nr_dirty)
 			 * This will happen when somebody is freeing
 			 * this inode.
 			 */
-			nilfs_msg(inode->i_sb, KERN_WARNING,
-				  "cannot set file dirty (ino=%lu): the file is being freed",
-				  inode->i_ino);
+			nilfs_warn(inode->i_sb,
+				   "cannot set file dirty (ino=%lu): the file is being freed",
+				   inode->i_ino);
 			spin_unlock(&nilfs->ns_inode_lock);
 			return -EINVAL; /*
 					 * NILFS_I_DIRTY may remain for
@@ -1128,9 +1127,9 @@ int __nilfs_mark_inode_dirty(struct inode *inode, int flags)
 
 	err = nilfs_load_inode_block(inode, &ibh);
 	if (unlikely(err)) {
-		nilfs_msg(inode->i_sb, KERN_WARNING,
-			  "cannot mark inode dirty (ino=%lu): error %d loading inode block",
-			  inode->i_ino, err);
+		nilfs_warn(inode->i_sb,
+			   "cannot mark inode dirty (ino=%lu): error %d loading inode block",
+			   inode->i_ino, err);
 		return err;
 	}
 	nilfs_update_inode(inode, ibh, flags);
@@ -1156,8 +1155,8 @@ void nilfs_dirty_inode(struct inode *inode, int flags)
 	struct nilfs_mdt_info *mdi = NILFS_MDT(inode);
 
 	if (is_bad_inode(inode)) {
-		nilfs_msg(inode->i_sb, KERN_WARNING,
-			  "tried to mark bad_inode dirty. ignored.");
+		nilfs_warn(inode->i_sb,
+			   "tried to mark bad_inode dirty. ignored.");
 		dump_stack();
 		return;
 	}
diff --git a/fs/nilfs2/ioctl.c b/fs/nilfs2/ioctl.c
index dfb2083b8ce1..ecb5e4cf058b 100644
--- a/fs/nilfs2/ioctl.c
+++ b/fs/nilfs2/ioctl.c
@@ -574,25 +574,25 @@ static int nilfs_ioctl_move_inode_block(struct inode *inode,
 
 	if (unlikely(ret < 0)) {
 		if (ret == -ENOENT)
-			nilfs_msg(inode->i_sb, KERN_CRIT,
-				  "%s: invalid virtual block address (%s): ino=%llu, cno=%llu, offset=%llu, blocknr=%llu, vblocknr=%llu",
-				  __func__, vdesc->vd_flags ? "node" : "data",
-				  (unsigned long long)vdesc->vd_ino,
-				  (unsigned long long)vdesc->vd_cno,
-				  (unsigned long long)vdesc->vd_offset,
-				  (unsigned long long)vdesc->vd_blocknr,
-				  (unsigned long long)vdesc->vd_vblocknr);
+			nilfs_crit(inode->i_sb,
+				   "%s: invalid virtual block address (%s): ino=%llu, cno=%llu, offset=%llu, blocknr=%llu, vblocknr=%llu",
+				   __func__, vdesc->vd_flags ? "node" : "data",
+				   (unsigned long long)vdesc->vd_ino,
+				   (unsigned long long)vdesc->vd_cno,
+				   (unsigned long long)vdesc->vd_offset,
+				   (unsigned long long)vdesc->vd_blocknr,
+				   (unsigned long long)vdesc->vd_vblocknr);
 		return ret;
 	}
 	if (unlikely(!list_empty(&bh->b_assoc_buffers))) {
-		nilfs_msg(inode->i_sb, KERN_CRIT,
-			  "%s: conflicting %s buffer: ino=%llu, cno=%llu, offset=%llu, blocknr=%llu, vblocknr=%llu",
-			  __func__, vdesc->vd_flags ? "node" : "data",
-			  (unsigned long long)vdesc->vd_ino,
-			  (unsigned long long)vdesc->vd_cno,
-			  (unsigned long long)vdesc->vd_offset,
-			  (unsigned long long)vdesc->vd_blocknr,
-			  (unsigned long long)vdesc->vd_vblocknr);
+		nilfs_crit(inode->i_sb,
+			   "%s: conflicting %s buffer: ino=%llu, cno=%llu, offset=%llu, blocknr=%llu, vblocknr=%llu",
+			   __func__, vdesc->vd_flags ? "node" : "data",
+			   (unsigned long long)vdesc->vd_ino,
+			   (unsigned long long)vdesc->vd_cno,
+			   (unsigned long long)vdesc->vd_offset,
+			   (unsigned long long)vdesc->vd_blocknr,
+			   (unsigned long long)vdesc->vd_vblocknr);
 		brelse(bh);
 		return -EEXIST;
 	}
@@ -842,8 +842,7 @@ int nilfs_ioctl_prepare_clean_segments(struct the_nilfs *nilfs,
 	return 0;
 
  failed:
-	nilfs_msg(nilfs->ns_sb, KERN_ERR, "error %d preparing GC: %s", ret,
-		  msg);
+	nilfs_err(nilfs->ns_sb, "error %d preparing GC: %s", ret, msg);
 	return ret;
 }
 
@@ -952,7 +951,7 @@ static int nilfs_ioctl_clean_segments(struct inode *inode, struct file *filp,
 
 	ret = nilfs_ioctl_move_blocks(inode->i_sb, &argv[0], kbufs[0]);
 	if (ret < 0) {
-		nilfs_msg(inode->i_sb, KERN_ERR,
+		nilfs_err(inode->i_sb,
 			  "error %d preparing GC: cannot read source blocks",
 			  ret);
 	} else {
diff --git a/fs/nilfs2/mdt.c b/fs/nilfs2/mdt.c
index 7c9055d767d1..e80ef2c0a785 100644
--- a/fs/nilfs2/mdt.c
+++ b/fs/nilfs2/mdt.c
@@ -199,7 +199,7 @@ static int nilfs_mdt_read_block(struct inode *inode, unsigned long block,
  out_no_wait:
 	err = -EIO;
 	if (!buffer_uptodate(first_bh)) {
-		nilfs_msg(inode->i_sb, KERN_ERR,
+		nilfs_err(inode->i_sb,
 			  "I/O error reading meta-data file (ino=%lu, block-offset=%lu)",
 			  inode->i_ino, block);
 		goto failed_bh;
diff --git a/fs/nilfs2/namei.c b/fs/nilfs2/namei.c
index 9fe6d4ab74f0..a6ec7961d4f5 100644
--- a/fs/nilfs2/namei.c
+++ b/fs/nilfs2/namei.c
@@ -272,9 +272,9 @@ static int nilfs_do_unlink(struct inode *dir, struct dentry *dentry)
 		goto out;
 
 	if (!inode->i_nlink) {
-		nilfs_msg(inode->i_sb, KERN_WARNING,
-			  "deleting nonexistent file (ino=%lu), %d",
-			  inode->i_ino, inode->i_nlink);
+		nilfs_warn(inode->i_sb,
+			   "deleting nonexistent file (ino=%lu), %d",
+			   inode->i_ino, inode->i_nlink);
 		set_nlink(inode, 1);
 	}
 	err = nilfs_delete_entry(de, page);
diff --git a/fs/nilfs2/nilfs.h b/fs/nilfs2/nilfs.h
index cca30f0f965c..d8dc6e546feb 100644
--- a/fs/nilfs2/nilfs.h
+++ b/fs/nilfs2/nilfs.h
@@ -321,6 +321,15 @@ void __nilfs_error(struct super_block *sb, const char *function,
 
 #endif /* CONFIG_PRINTK */
 
+#define nilfs_crit(sb, fmt, ...)					\
+	nilfs_msg(sb, KERN_CRIT, fmt, ##__VA_ARGS__)
+#define nilfs_err(sb, fmt, ...)						\
+	nilfs_msg(sb, KERN_ERR, fmt, ##__VA_ARGS__)
+#define nilfs_warn(sb, fmt, ...)					\
+	nilfs_msg(sb, KERN_WARNING, fmt, ##__VA_ARGS__)
+#define nilfs_info(sb, fmt, ...)					\
+	nilfs_msg(sb, KERN_INFO, fmt, ##__VA_ARGS__)
+
 extern struct nilfs_super_block *
 nilfs_read_super_block(struct super_block *, u64, int, struct buffer_head **);
 extern int nilfs_store_magic_and_option(struct super_block *,
diff --git a/fs/nilfs2/page.c b/fs/nilfs2/page.c
index e5fee7fac915..762dd277099e 100644
--- a/fs/nilfs2/page.c
+++ b/fs/nilfs2/page.c
@@ -401,9 +401,8 @@ void nilfs_clear_dirty_page(struct page *page, bool silent)
 	BUG_ON(!PageLocked(page));
 
 	if (!silent)
-		nilfs_msg(sb, KERN_WARNING,
-			  "discard dirty page: offset=%lld, ino=%lu",
-			  page_offset(page), inode->i_ino);
+		nilfs_warn(sb, "discard dirty page: offset=%lld, ino=%lu",
+			   page_offset(page), inode->i_ino);
 
 	ClearPageUptodate(page);
 	ClearPageMappedToDisk(page);
@@ -419,9 +418,9 @@ void nilfs_clear_dirty_page(struct page *page, bool silent)
 		do {
 			lock_buffer(bh);
 			if (!silent)
-				nilfs_msg(sb, KERN_WARNING,
-					  "discard dirty block: blocknr=%llu, size=%zu",
-					  (u64)bh->b_blocknr, bh->b_size);
+				nilfs_warn(sb,
+					   "discard dirty block: blocknr=%llu, size=%zu",
+					   (u64)bh->b_blocknr, bh->b_size);
 
 			set_mask_bits(&bh->b_state, clear_bits, 0);
 			unlock_buffer(bh);
diff --git a/fs/nilfs2/recovery.c b/fs/nilfs2/recovery.c
index 18feb9c7c706..0923231e9e60 100644
--- a/fs/nilfs2/recovery.c
+++ b/fs/nilfs2/recovery.c
@@ -51,7 +51,7 @@ static int nilfs_warn_segment_error(struct super_block *sb, int err)
 
 	switch (err) {
 	case NILFS_SEG_FAIL_IO:
-		nilfs_msg(sb, KERN_ERR, "I/O error reading segment");
+		nilfs_err(sb, "I/O error reading segment");
 		return -EIO;
 	case NILFS_SEG_FAIL_MAGIC:
 		msg = "Magic number mismatch";
@@ -72,10 +72,10 @@ static int nilfs_warn_segment_error(struct super_block *sb, int err)
 		msg = "No super root in the last segment";
 		break;
 	default:
-		nilfs_msg(sb, KERN_ERR, "unrecognized segment error %d", err);
+		nilfs_err(sb, "unrecognized segment error %d", err);
 		return -EINVAL;
 	}
-	nilfs_msg(sb, KERN_WARNING, "invalid segment: %s", msg);
+	nilfs_warn(sb, "invalid segment: %s", msg);
 	return -EINVAL;
 }
 
@@ -544,10 +544,10 @@ static int nilfs_recover_dsync_blocks(struct the_nilfs *nilfs,
 		put_page(page);
 
  failed_inode:
-		nilfs_msg(sb, KERN_WARNING,
-			  "error %d recovering data block (ino=%lu, block-offset=%llu)",
-			  err, (unsigned long)rb->ino,
-			  (unsigned long long)rb->blkoff);
+		nilfs_warn(sb,
+			   "error %d recovering data block (ino=%lu, block-offset=%llu)",
+			   err, (unsigned long)rb->ino,
+			   (unsigned long long)rb->blkoff);
 		if (!err2)
 			err2 = err;
  next:
@@ -670,8 +670,7 @@ static int nilfs_do_roll_forward(struct the_nilfs *nilfs,
 	}
 
 	if (nsalvaged_blocks) {
-		nilfs_msg(sb, KERN_INFO, "salvaged %lu blocks",
-			  nsalvaged_blocks);
+		nilfs_info(sb, "salvaged %lu blocks", nsalvaged_blocks);
 		ri->ri_need_recovery = NILFS_RECOVERY_ROLLFORWARD_DONE;
 	}
  out:
@@ -682,7 +681,7 @@ static int nilfs_do_roll_forward(struct the_nilfs *nilfs,
  confused:
 	err = -EINVAL;
  failed:
-	nilfs_msg(sb, KERN_ERR,
+	nilfs_err(sb,
 		  "error %d roll-forwarding partial segment at blocknr = %llu",
 		  err, (unsigned long long)pseg_start);
 	goto out;
@@ -704,8 +703,8 @@ static void nilfs_finish_roll_forward(struct the_nilfs *nilfs,
 	set_buffer_dirty(bh);
 	err = sync_dirty_buffer(bh);
 	if (unlikely(err))
-		nilfs_msg(nilfs->ns_sb, KERN_WARNING,
-			  "buffer sync write failed during post-cleaning of recovery.");
+		nilfs_warn(nilfs->ns_sb,
+			   "buffer sync write failed during post-cleaning of recovery.");
 	brelse(bh);
 }
 
@@ -740,8 +739,7 @@ int nilfs_salvage_orphan_logs(struct the_nilfs *nilfs,
 
 	err = nilfs_attach_checkpoint(sb, ri->ri_cno, true, &root);
 	if (unlikely(err)) {
-		nilfs_msg(sb, KERN_ERR,
-			  "error %d loading the latest checkpoint", err);
+		nilfs_err(sb, "error %d loading the latest checkpoint", err);
 		return err;
 	}
 
@@ -752,8 +750,7 @@ int nilfs_salvage_orphan_logs(struct the_nilfs *nilfs,
 	if (ri->ri_need_recovery == NILFS_RECOVERY_ROLLFORWARD_DONE) {
 		err = nilfs_prepare_segment_for_recovery(nilfs, sb, ri);
 		if (unlikely(err)) {
-			nilfs_msg(sb, KERN_ERR,
-				  "error %d preparing segment for recovery",
+			nilfs_err(sb, "error %d preparing segment for recovery",
 				  err);
 			goto failed;
 		}
@@ -767,8 +764,7 @@ int nilfs_salvage_orphan_logs(struct the_nilfs *nilfs,
 		nilfs_detach_log_writer(sb);
 
 		if (unlikely(err)) {
-			nilfs_msg(sb, KERN_ERR,
-				  "error %d writing segment for recovery",
+			nilfs_err(sb, "error %d writing segment for recovery",
 				  err);
 			goto failed;
 		}
diff --git a/fs/nilfs2/segbuf.c b/fs/nilfs2/segbuf.c
index e72466fc8ca9..9f435879a048 100644
--- a/fs/nilfs2/segbuf.c
+++ b/fs/nilfs2/segbuf.c
@@ -511,7 +511,7 @@ static int nilfs_segbuf_wait(struct nilfs_segment_buffer *segbuf)
 	} while (--segbuf->sb_nbio > 0);
 
 	if (unlikely(atomic_read(&segbuf->sb_err) > 0)) {
-		nilfs_msg(segbuf->sb_super, KERN_ERR,
+		nilfs_err(segbuf->sb_super,
 			  "I/O error writing log (start-blocknr=%llu, block-count=%lu) in segment %llu",
 			  (unsigned long long)segbuf->sb_pseg_start,
 			  segbuf->sb_sum.nblocks,
diff --git a/fs/nilfs2/segment.c b/fs/nilfs2/segment.c
index 7d1860d33723..d4610f71d21b 100644
--- a/fs/nilfs2/segment.c
+++ b/fs/nilfs2/segment.c
@@ -158,7 +158,7 @@ static int nilfs_prepare_segment_lock(struct super_block *sb,
 		 * it is saved and will be restored on
 		 * nilfs_transaction_commit().
 		 */
-		nilfs_msg(sb, KERN_WARNING, "journal info from a different FS");
+		nilfs_warn(sb, "journal info from a different FS");
 		save = current->journal_info;
 	}
 	if (!ti) {
@@ -1983,9 +1983,9 @@ static int nilfs_segctor_collect_dirty_files(struct nilfs_sc_info *sci,
 			err = nilfs_ifile_get_inode_block(
 				ifile, ii->vfs_inode.i_ino, &ibh);
 			if (unlikely(err)) {
-				nilfs_msg(sci->sc_super, KERN_WARNING,
-					  "log writer: error %d getting inode block (ino=%lu)",
-					  err, ii->vfs_inode.i_ino);
+				nilfs_warn(sci->sc_super,
+					   "log writer: error %d getting inode block (ino=%lu)",
+					   err, ii->vfs_inode.i_ino);
 				return err;
 			}
 			spin_lock(&nilfs->ns_inode_lock);
@@ -2495,7 +2495,7 @@ int nilfs_clean_segments(struct super_block *sb, struct nilfs_argv *argv,
 		if (likely(!err))
 			break;
 
-		nilfs_msg(sb, KERN_WARNING, "error %d cleaning segments", err);
+		nilfs_warn(sb, "error %d cleaning segments", err);
 		set_current_state(TASK_INTERRUPTIBLE);
 		schedule_timeout(sci->sc_interval);
 	}
@@ -2503,9 +2503,9 @@ int nilfs_clean_segments(struct super_block *sb, struct nilfs_argv *argv,
 		int ret = nilfs_discard_segments(nilfs, sci->sc_freesegs,
 						 sci->sc_nfreesegs);
 		if (ret) {
-			nilfs_msg(sb, KERN_WARNING,
-				  "error %d on discard request, turning discards off for the device",
-				  ret);
+			nilfs_warn(sb,
+				   "error %d on discard request, turning discards off for the device",
+				   ret);
 			nilfs_clear_opt(nilfs, DISCARD);
 		}
 	}
@@ -2586,9 +2586,9 @@ static int nilfs_segctor_thread(void *arg)
 	/* start sync. */
 	sci->sc_task = current;
 	wake_up(&sci->sc_wait_task); /* for nilfs_segctor_start_thread() */
-	nilfs_msg(sci->sc_super, KERN_INFO,
-		  "segctord starting. Construction interval = %lu seconds, CP frequency < %lu seconds",
-		  sci->sc_interval / HZ, sci->sc_mjcp_freq / HZ);
+	nilfs_info(sci->sc_super,
+		   "segctord starting. Construction interval = %lu seconds, CP frequency < %lu seconds",
+		   sci->sc_interval / HZ, sci->sc_mjcp_freq / HZ);
 
 	spin_lock(&sci->sc_state_lock);
  loop:
@@ -2661,8 +2661,8 @@ static int nilfs_segctor_start_thread(struct nilfs_sc_info *sci)
 	if (IS_ERR(t)) {
 		int err = PTR_ERR(t);
 
-		nilfs_msg(sci->sc_super, KERN_ERR,
-			  "error %d creating segctord thread", err);
+		nilfs_err(sci->sc_super, "error %d creating segctord thread",
+			  err);
 		return err;
 	}
 	wait_event(sci->sc_wait_task, sci->sc_task != NULL);
@@ -2772,14 +2772,14 @@ static void nilfs_segctor_destroy(struct nilfs_sc_info *sci)
 		nilfs_segctor_write_out(sci);
 
 	if (!list_empty(&sci->sc_dirty_files)) {
-		nilfs_msg(sci->sc_super, KERN_WARNING,
-			  "disposed unprocessed dirty file(s) when stopping log writer");
+		nilfs_warn(sci->sc_super,
+			   "disposed unprocessed dirty file(s) when stopping log writer");
 		nilfs_dispose_list(nilfs, &sci->sc_dirty_files, 1);
 	}
 
 	if (!list_empty(&sci->sc_iput_queue)) {
-		nilfs_msg(sci->sc_super, KERN_WARNING,
-			  "disposed unprocessed inode(s) in iput queue when stopping log writer");
+		nilfs_warn(sci->sc_super,
+			   "disposed unprocessed inode(s) in iput queue when stopping log writer");
 		nilfs_dispose_list(nilfs, &sci->sc_iput_queue, 1);
 	}
 
@@ -2858,8 +2858,8 @@ void nilfs_detach_log_writer(struct super_block *sb)
 	spin_lock(&nilfs->ns_inode_lock);
 	if (!list_empty(&nilfs->ns_dirty_files)) {
 		list_splice_init(&nilfs->ns_dirty_files, &garbage_list);
-		nilfs_msg(sb, KERN_WARNING,
-			  "disposed unprocessed dirty file(s) when detaching log writer");
+		nilfs_warn(sb,
+			   "disposed unprocessed dirty file(s) when detaching log writer");
 	}
 	spin_unlock(&nilfs->ns_inode_lock);
 	up_write(&nilfs->ns_segctor_sem);
diff --git a/fs/nilfs2/sufile.c b/fs/nilfs2/sufile.c
index 4626540008c1..379db0c54227 100644
--- a/fs/nilfs2/sufile.c
+++ b/fs/nilfs2/sufile.c
@@ -171,9 +171,9 @@ int nilfs_sufile_updatev(struct inode *sufile, __u64 *segnumv, size_t nsegs,
 	down_write(&NILFS_MDT(sufile)->mi_sem);
 	for (seg = segnumv; seg < segnumv + nsegs; seg++) {
 		if (unlikely(*seg >= nilfs_sufile_get_nsegments(sufile))) {
-			nilfs_msg(sufile->i_sb, KERN_WARNING,
-				  "%s: invalid segment number: %llu",
-				  __func__, (unsigned long long)*seg);
+			nilfs_warn(sufile->i_sb,
+				   "%s: invalid segment number: %llu",
+				   __func__, (unsigned long long)*seg);
 			nerr++;
 		}
 	}
@@ -230,9 +230,8 @@ int nilfs_sufile_update(struct inode *sufile, __u64 segnum, int create,
 	int ret;
 
 	if (unlikely(segnum >= nilfs_sufile_get_nsegments(sufile))) {
-		nilfs_msg(sufile->i_sb, KERN_WARNING,
-			  "%s: invalid segment number: %llu",
-			  __func__, (unsigned long long)segnum);
+		nilfs_warn(sufile->i_sb, "%s: invalid segment number: %llu",
+			   __func__, (unsigned long long)segnum);
 		return -EINVAL;
 	}
 	down_write(&NILFS_MDT(sufile)->mi_sem);
@@ -410,9 +409,8 @@ void nilfs_sufile_do_cancel_free(struct inode *sufile, __u64 segnum,
 	kaddr = kmap_atomic(su_bh->b_page);
 	su = nilfs_sufile_block_get_segment_usage(sufile, segnum, su_bh, kaddr);
 	if (unlikely(!nilfs_segment_usage_clean(su))) {
-		nilfs_msg(sufile->i_sb, KERN_WARNING,
-			  "%s: segment %llu must be clean", __func__,
-			  (unsigned long long)segnum);
+		nilfs_warn(sufile->i_sb, "%s: segment %llu must be clean",
+			   __func__, (unsigned long long)segnum);
 		kunmap_atomic(kaddr);
 		return;
 	}
@@ -468,9 +466,8 @@ void nilfs_sufile_do_free(struct inode *sufile, __u64 segnum,
 	kaddr = kmap_atomic(su_bh->b_page);
 	su = nilfs_sufile_block_get_segment_usage(sufile, segnum, su_bh, kaddr);
 	if (nilfs_segment_usage_clean(su)) {
-		nilfs_msg(sufile->i_sb, KERN_WARNING,
-			  "%s: segment %llu is already clean",
-			  __func__, (unsigned long long)segnum);
+		nilfs_warn(sufile->i_sb, "%s: segment %llu is already clean",
+			   __func__, (unsigned long long)segnum);
 		kunmap_atomic(kaddr);
 		return;
 	}
@@ -1213,12 +1210,12 @@ int nilfs_sufile_read(struct super_block *sb, size_t susize,
 	int err;
 
 	if (susize > sb->s_blocksize) {
-		nilfs_msg(sb, KERN_ERR,
-			  "too large segment usage size: %zu bytes", susize);
+		nilfs_err(sb, "too large segment usage size: %zu bytes",
+			  susize);
 		return -EINVAL;
 	} else if (susize < NILFS_MIN_SEGMENT_USAGE_SIZE) {
-		nilfs_msg(sb, KERN_ERR,
-			  "too small segment usage size: %zu bytes", susize);
+		nilfs_err(sb, "too small segment usage size: %zu bytes",
+			  susize);
 		return -EINVAL;
 	}
 
diff --git a/fs/nilfs2/super.c b/fs/nilfs2/super.c
index 99bcb4ab47a6..6d33eecff261 100644
--- a/fs/nilfs2/super.c
+++ b/fs/nilfs2/super.c
@@ -106,7 +106,7 @@ static void nilfs_set_error(struct super_block *sb)
  *
  * This implements the body of nilfs_error() macro.  Normally,
  * nilfs_error() should be used.  As for sustainable errors such as a
- * single-shot I/O error, nilfs_msg() should be used instead.
+ * single-shot I/O error, nilfs_err() should be used instead.
  *
  * Callers should not add a trailing newline since this will do it.
  */
@@ -186,8 +186,7 @@ static int nilfs_sync_super(struct super_block *sb, int flag)
 	}
 
 	if (unlikely(err)) {
-		nilfs_msg(sb, KERN_ERR, "unable to write superblock: err=%d",
-			  err);
+		nilfs_err(sb, "unable to write superblock: err=%d", err);
 		if (err == -EIO && nilfs->ns_sbh[1]) {
 			/*
 			 * sbp[0] points to newer log than sbp[1],
@@ -257,7 +256,7 @@ struct nilfs_super_block **nilfs_prepare_super(struct super_block *sb,
 		    sbp[1]->s_magic == cpu_to_le16(NILFS_SUPER_MAGIC)) {
 			memcpy(sbp[0], sbp[1], nilfs->ns_sbsize);
 		} else {
-			nilfs_msg(sb, KERN_CRIT, "superblock broke");
+			nilfs_crit(sb, "superblock broke");
 			return NULL;
 		}
 	} else if (sbp[1] &&
@@ -367,9 +366,9 @@ static int nilfs_move_2nd_super(struct super_block *sb, loff_t sb2off)
 	offset = sb2off & (nilfs->ns_blocksize - 1);
 	nsbh = sb_getblk(sb, newblocknr);
 	if (!nsbh) {
-		nilfs_msg(sb, KERN_WARNING,
-			  "unable to move secondary superblock to block %llu",
-			  (unsigned long long)newblocknr);
+		nilfs_warn(sb,
+			   "unable to move secondary superblock to block %llu",
+			   (unsigned long long)newblocknr);
 		ret = -EIO;
 		goto out;
 	}
@@ -563,7 +562,7 @@ int nilfs_attach_checkpoint(struct super_block *sb, __u64 cno, int curr_mnt,
 	up_read(&nilfs->ns_segctor_sem);
 	if (unlikely(err)) {
 		if (err == -ENOENT || err == -EINVAL) {
-			nilfs_msg(sb, KERN_ERR,
+			nilfs_err(sb,
 				  "Invalid checkpoint (checkpoint number=%llu)",
 				  (unsigned long long)cno);
 			err = -EINVAL;
@@ -661,8 +660,7 @@ static int nilfs_statfs(struct dentry *dentry, struct kstatfs *buf)
 	err = nilfs_ifile_count_free_inodes(root->ifile,
 					    &nmaxinodes, &nfreeinodes);
 	if (unlikely(err)) {
-		nilfs_msg(sb, KERN_WARNING,
-			  "failed to count free inodes: err=%d", err);
+		nilfs_warn(sb, "failed to count free inodes: err=%d", err);
 		if (err == -ERANGE) {
 			/*
 			 * If nilfs_palloc_count_max_entries() returns
@@ -794,7 +792,7 @@ static int parse_options(char *options, struct super_block *sb, int is_remount)
 			break;
 		case Opt_snapshot:
 			if (is_remount) {
-				nilfs_msg(sb, KERN_ERR,
+				nilfs_err(sb,
 					  "\"%s\" option is invalid for remount",
 					  p);
 				return 0;
@@ -810,8 +808,7 @@ static int parse_options(char *options, struct super_block *sb, int is_remount)
 			nilfs_clear_opt(nilfs, DISCARD);
 			break;
 		default:
-			nilfs_msg(sb, KERN_ERR,
-				  "unrecognized mount option \"%s\"", p);
+			nilfs_err(sb, "unrecognized mount option \"%s\"", p);
 			return 0;
 		}
 	}
@@ -847,10 +844,10 @@ static int nilfs_setup_super(struct super_block *sb, int is_mount)
 	mnt_count = le16_to_cpu(sbp[0]->s_mnt_count);
 
 	if (nilfs->ns_mount_state & NILFS_ERROR_FS) {
-		nilfs_msg(sb, KERN_WARNING, "mounting fs with errors");
+		nilfs_warn(sb, "mounting fs with errors");
 #if 0
 	} else if (max_mnt_count >= 0 && mnt_count >= max_mnt_count) {
-		nilfs_msg(sb, KERN_WARNING, "maximal mount count reached");
+		nilfs_warn(sb, "maximal mount count reached");
 #endif
 	}
 	if (!max_mnt_count)
@@ -913,7 +910,7 @@ int nilfs_check_feature_compatibility(struct super_block *sb,
 	features = le64_to_cpu(sbp->s_feature_incompat) &
 		~NILFS_FEATURE_INCOMPAT_SUPP;
 	if (features) {
-		nilfs_msg(sb, KERN_ERR,
+		nilfs_err(sb,
 			  "couldn't mount because of unsupported optional features (%llx)",
 			  (unsigned long long)features);
 		return -EINVAL;
@@ -921,7 +918,7 @@ int nilfs_check_feature_compatibility(struct super_block *sb,
 	features = le64_to_cpu(sbp->s_feature_compat_ro) &
 		~NILFS_FEATURE_COMPAT_RO_SUPP;
 	if (!sb_rdonly(sb) && features) {
-		nilfs_msg(sb, KERN_ERR,
+		nilfs_err(sb,
 			  "couldn't mount RDWR because of unsupported optional features (%llx)",
 			  (unsigned long long)features);
 		return -EINVAL;
@@ -940,12 +937,12 @@ static int nilfs_get_root_dentry(struct super_block *sb,
 	inode = nilfs_iget(sb, root, NILFS_ROOT_INO);
 	if (IS_ERR(inode)) {
 		ret = PTR_ERR(inode);
-		nilfs_msg(sb, KERN_ERR, "error %d getting root inode", ret);
+		nilfs_err(sb, "error %d getting root inode", ret);
 		goto out;
 	}
 	if (!S_ISDIR(inode->i_mode) || !inode->i_blocks || !inode->i_size) {
 		iput(inode);
-		nilfs_msg(sb, KERN_ERR, "corrupt root inode");
+		nilfs_err(sb, "corrupt root inode");
 		ret = -EINVAL;
 		goto out;
 	}
@@ -973,7 +970,7 @@ static int nilfs_get_root_dentry(struct super_block *sb,
 	return ret;
 
  failed_dentry:
-	nilfs_msg(sb, KERN_ERR, "error %d getting root dentry", ret);
+	nilfs_err(sb, "error %d getting root dentry", ret);
 	goto out;
 }
 
@@ -993,7 +990,7 @@ static int nilfs_attach_snapshot(struct super_block *s, __u64 cno,
 		ret = (ret == -ENOENT) ? -EINVAL : ret;
 		goto out;
 	} else if (!ret) {
-		nilfs_msg(s, KERN_ERR,
+		nilfs_err(s,
 			  "The specified checkpoint is not a snapshot (checkpoint number=%llu)",
 			  (unsigned long long)cno);
 		ret = -EINVAL;
@@ -1002,7 +999,7 @@ static int nilfs_attach_snapshot(struct super_block *s, __u64 cno,
 
 	ret = nilfs_attach_checkpoint(s, cno, false, &root);
 	if (ret) {
-		nilfs_msg(s, KERN_ERR,
+		nilfs_err(s,
 			  "error %d while loading snapshot (checkpoint number=%llu)",
 			  ret, (unsigned long long)cno);
 		goto out;
@@ -1099,7 +1096,7 @@ nilfs_fill_super(struct super_block *sb, void *data, int silent)
 	cno = nilfs_last_cno(nilfs);
 	err = nilfs_attach_checkpoint(sb, cno, true, &fsroot);
 	if (err) {
-		nilfs_msg(sb, KERN_ERR,
+		nilfs_err(sb,
 			  "error %d while loading last checkpoint (checkpoint number=%llu)",
 			  err, (unsigned long long)cno);
 		goto failed_unload;
@@ -1162,8 +1159,8 @@ static int nilfs_remount(struct super_block *sb, int *flags, char *data)
 	err = -EINVAL;
 
 	if (!nilfs_valid_fs(nilfs)) {
-		nilfs_msg(sb, KERN_WARNING,
-			  "couldn't remount because the filesystem is in an incomplete recovery state");
+		nilfs_warn(sb,
+			   "couldn't remount because the filesystem is in an incomplete recovery state");
 		goto restore_opts;
 	}
 
@@ -1193,9 +1190,9 @@ static int nilfs_remount(struct super_block *sb, int *flags, char *data)
 			~NILFS_FEATURE_COMPAT_RO_SUPP;
 		up_read(&nilfs->ns_sem);
 		if (features) {
-			nilfs_msg(sb, KERN_WARNING,
-				  "couldn't remount RDWR because of unsupported optional features (%llx)",
-				  (unsigned long long)features);
+			nilfs_warn(sb,
+				   "couldn't remount RDWR because of unsupported optional features (%llx)",
+				   (unsigned long long)features);
 			err = -EROFS;
 			goto restore_opts;
 		}
@@ -1254,7 +1251,7 @@ static int nilfs_parse_snapshot_option(const char *option,
 	return 0;
 
 parse_error:
-	nilfs_msg(NULL, KERN_ERR, "invalid option \"%s\": %s", option, msg);
+	nilfs_err(NULL, "invalid option \"%s\": %s", option, msg);
 	return 1;
 }
 
@@ -1357,7 +1354,7 @@ nilfs_mount(struct file_system_type *fs_type, int flags,
 	} else if (!sd.cno) {
 		if (nilfs_tree_is_busy(s->s_root)) {
 			if ((flags ^ s->s_flags) & SB_RDONLY) {
-				nilfs_msg(s, KERN_ERR,
+				nilfs_err(s,
 					  "the device already has a %s mount.",
 					  sb_rdonly(s) ? "read-only" : "read/write");
 				err = -EBUSY;
diff --git a/fs/nilfs2/sysfs.c b/fs/nilfs2/sysfs.c
index 28a2db3b1787..57afd06db62d 100644
--- a/fs/nilfs2/sysfs.c
+++ b/fs/nilfs2/sysfs.c
@@ -261,8 +261,8 @@ nilfs_checkpoints_checkpoints_number_show(struct nilfs_checkpoints_attr *attr,
 	err = nilfs_cpfile_get_stat(nilfs->ns_cpfile, &cpstat);
 	up_read(&nilfs->ns_segctor_sem);
 	if (err < 0) {
-		nilfs_msg(nilfs->ns_sb, KERN_ERR,
-			  "unable to get checkpoint stat: err=%d", err);
+		nilfs_err(nilfs->ns_sb, "unable to get checkpoint stat: err=%d",
+			  err);
 		return err;
 	}
 
@@ -284,8 +284,8 @@ nilfs_checkpoints_snapshots_number_show(struct nilfs_checkpoints_attr *attr,
 	err = nilfs_cpfile_get_stat(nilfs->ns_cpfile, &cpstat);
 	up_read(&nilfs->ns_segctor_sem);
 	if (err < 0) {
-		nilfs_msg(nilfs->ns_sb, KERN_ERR,
-			  "unable to get checkpoint stat: err=%d", err);
+		nilfs_err(nilfs->ns_sb, "unable to get checkpoint stat: err=%d",
+			  err);
 		return err;
 	}
 
@@ -403,8 +403,8 @@ nilfs_segments_dirty_segments_show(struct nilfs_segments_attr *attr,
 	err = nilfs_sufile_get_stat(nilfs->ns_sufile, &sustat);
 	up_read(&nilfs->ns_segctor_sem);
 	if (err < 0) {
-		nilfs_msg(nilfs->ns_sb, KERN_ERR,
-			  "unable to get segment stat: err=%d", err);
+		nilfs_err(nilfs->ns_sb, "unable to get segment stat: err=%d",
+			  err);
 		return err;
 	}
 
@@ -777,15 +777,15 @@ nilfs_superblock_sb_update_frequency_store(struct nilfs_superblock_attr *attr,
 
 	err = kstrtouint(skip_spaces(buf), 0, &val);
 	if (err) {
-		nilfs_msg(nilfs->ns_sb, KERN_ERR,
-			  "unable to convert string: err=%d", err);
+		nilfs_err(nilfs->ns_sb, "unable to convert string: err=%d",
+			  err);
 		return err;
 	}
 
 	if (val < NILFS_SB_FREQ) {
 		val = NILFS_SB_FREQ;
-		nilfs_msg(nilfs->ns_sb, KERN_WARNING,
-			  "superblock update frequency cannot be lesser than 10 seconds");
+		nilfs_warn(nilfs->ns_sb,
+			   "superblock update frequency cannot be lesser than 10 seconds");
 	}
 
 	down_write(&nilfs->ns_sem);
@@ -988,8 +988,7 @@ int nilfs_sysfs_create_device_group(struct super_block *sb)
 	nilfs->ns_dev_subgroups = kzalloc(devgrp_size, GFP_KERNEL);
 	if (unlikely(!nilfs->ns_dev_subgroups)) {
 		err = -ENOMEM;
-		nilfs_msg(sb, KERN_ERR,
-			  "unable to allocate memory for device group");
+		nilfs_err(sb, "unable to allocate memory for device group");
 		goto failed_create_device_group;
 	}
 
@@ -1098,15 +1097,13 @@ int __init nilfs_sysfs_init(void)
 	nilfs_kset = kset_create_and_add(NILFS_ROOT_GROUP_NAME, NULL, fs_kobj);
 	if (!nilfs_kset) {
 		err = -ENOMEM;
-		nilfs_msg(NULL, KERN_ERR,
-			  "unable to create sysfs entry: err=%d", err);
+		nilfs_err(NULL, "unable to create sysfs entry: err=%d", err);
 		goto failed_sysfs_init;
 	}
 
 	err = sysfs_create_group(&nilfs_kset->kobj, &nilfs_feature_attr_group);
 	if (unlikely(err)) {
-		nilfs_msg(NULL, KERN_ERR,
-			  "unable to create feature group: err=%d", err);
+		nilfs_err(NULL, "unable to create feature group: err=%d", err);
 		goto cleanup_sysfs_init;
 	}
 
diff --git a/fs/nilfs2/the_nilfs.c b/fs/nilfs2/the_nilfs.c
index c8d869bc25b0..0480034644aa 100644
--- a/fs/nilfs2/the_nilfs.c
+++ b/fs/nilfs2/the_nilfs.c
@@ -183,7 +183,7 @@ static int nilfs_store_log_cursor(struct the_nilfs *nilfs,
 		nilfs_get_segnum_of_block(nilfs, nilfs->ns_last_pseg);
 	nilfs->ns_cno = nilfs->ns_last_cno + 1;
 	if (nilfs->ns_segnum >= nilfs->ns_nsegments) {
-		nilfs_msg(nilfs->ns_sb, KERN_ERR,
+		nilfs_err(nilfs->ns_sb,
 			  "pointed segment number is out of range: segnum=%llu, nsegments=%lu",
 			  (unsigned long long)nilfs->ns_segnum,
 			  nilfs->ns_nsegments);
@@ -210,12 +210,12 @@ int load_nilfs(struct the_nilfs *nilfs, struct super_block *sb)
 	int err;
 
 	if (!valid_fs) {
-		nilfs_msg(sb, KERN_WARNING, "mounting unchecked fs");
+		nilfs_warn(sb, "mounting unchecked fs");
 		if (s_flags & SB_RDONLY) {
-			nilfs_msg(sb, KERN_INFO,
-				  "recovery required for readonly filesystem");
-			nilfs_msg(sb, KERN_INFO,
-				  "write access will be enabled during recovery");
+			nilfs_info(sb,
+				   "recovery required for readonly filesystem");
+			nilfs_info(sb,
+				   "write access will be enabled during recovery");
 		}
 	}
 
@@ -230,12 +230,11 @@ int load_nilfs(struct the_nilfs *nilfs, struct super_block *sb)
 			goto scan_error;
 
 		if (!nilfs_valid_sb(sbp[1])) {
-			nilfs_msg(sb, KERN_WARNING,
-				  "unable to fall back to spare super block");
+			nilfs_warn(sb,
+				   "unable to fall back to spare super block");
 			goto scan_error;
 		}
-		nilfs_msg(sb, KERN_INFO,
-			  "trying rollback from an earlier position");
+		nilfs_info(sb, "trying rollback from an earlier position");
 
 		/*
 		 * restore super block with its spare and reconfigure
@@ -248,9 +247,9 @@ int load_nilfs(struct the_nilfs *nilfs, struct super_block *sb)
 		/* verify consistency between two super blocks */
 		blocksize = BLOCK_SIZE << le32_to_cpu(sbp[0]->s_log_block_size);
 		if (blocksize != nilfs->ns_blocksize) {
-			nilfs_msg(sb, KERN_WARNING,
-				  "blocksize differs between two super blocks (%d != %d)",
-				  blocksize, nilfs->ns_blocksize);
+			nilfs_warn(sb,
+				   "blocksize differs between two super blocks (%d != %d)",
+				   blocksize, nilfs->ns_blocksize);
 			goto scan_error;
 		}
 
@@ -269,8 +268,7 @@ int load_nilfs(struct the_nilfs *nilfs, struct super_block *sb)
 
 	err = nilfs_load_super_root(nilfs, sb, ri.ri_super_root);
 	if (unlikely(err)) {
-		nilfs_msg(sb, KERN_ERR, "error %d while loading super root",
-			  err);
+		nilfs_err(sb, "error %d while loading super root", err);
 		goto failed;
 	}
 
@@ -285,28 +283,28 @@ int load_nilfs(struct the_nilfs *nilfs, struct super_block *sb)
 		__u64 features;
 
 		if (nilfs_test_opt(nilfs, NORECOVERY)) {
-			nilfs_msg(sb, KERN_INFO,
-				  "norecovery option specified, skipping roll-forward recovery");
+			nilfs_info(sb,
+				   "norecovery option specified, skipping roll-forward recovery");
 			goto skip_recovery;
 		}
 		features = le64_to_cpu(nilfs->ns_sbp[0]->s_feature_compat_ro) &
 			~NILFS_FEATURE_COMPAT_RO_SUPP;
 		if (features) {
-			nilfs_msg(sb, KERN_ERR,
+			nilfs_err(sb,
 				  "couldn't proceed with recovery because of unsupported optional features (%llx)",
 				  (unsigned long long)features);
 			err = -EROFS;
 			goto failed_unload;
 		}
 		if (really_read_only) {
-			nilfs_msg(sb, KERN_ERR,
+			nilfs_err(sb,
 				  "write access unavailable, cannot proceed");
 			err = -EROFS;
 			goto failed_unload;
 		}
 		sb->s_flags &= ~SB_RDONLY;
 	} else if (nilfs_test_opt(nilfs, NORECOVERY)) {
-		nilfs_msg(sb, KERN_ERR,
+		nilfs_err(sb,
 			  "recovery cancelled because norecovery option was specified for a read/write mount");
 		err = -EINVAL;
 		goto failed_unload;
@@ -322,12 +320,12 @@ int load_nilfs(struct the_nilfs *nilfs, struct super_block *sb)
 	up_write(&nilfs->ns_sem);
 
 	if (err) {
-		nilfs_msg(sb, KERN_ERR,
+		nilfs_err(sb,
 			  "error %d updating super block. recovery unfinished.",
 			  err);
 		goto failed_unload;
 	}
-	nilfs_msg(sb, KERN_INFO, "recovery complete");
+	nilfs_info(sb, "recovery complete");
 
  skip_recovery:
 	nilfs_clear_recovery_info(&ri);
@@ -335,7 +333,7 @@ int load_nilfs(struct the_nilfs *nilfs, struct super_block *sb)
 	return 0;
 
  scan_error:
-	nilfs_msg(sb, KERN_ERR, "error %d while searching super root", err);
+	nilfs_err(sb, "error %d while searching super root", err);
 	goto failed;
 
  failed_unload:
@@ -399,7 +397,7 @@ static int nilfs_store_disk_layout(struct the_nilfs *nilfs,
 	u64 nsegments, nblocks;
 
 	if (le32_to_cpu(sbp->s_rev_level) < NILFS_MIN_SUPP_REV) {
-		nilfs_msg(nilfs->ns_sb, KERN_ERR,
+		nilfs_err(nilfs->ns_sb,
 			  "unsupported revision (superblock rev.=%d.%d, current rev.=%d.%d). Please check the version of mkfs.nilfs(2).",
 			  le32_to_cpu(sbp->s_rev_level),
 			  le16_to_cpu(sbp->s_minor_rev_level),
@@ -412,13 +410,11 @@ static int nilfs_store_disk_layout(struct the_nilfs *nilfs,
 
 	nilfs->ns_inode_size = le16_to_cpu(sbp->s_inode_size);
 	if (nilfs->ns_inode_size > nilfs->ns_blocksize) {
-		nilfs_msg(nilfs->ns_sb, KERN_ERR,
-			  "too large inode size: %d bytes",
+		nilfs_err(nilfs->ns_sb, "too large inode size: %d bytes",
 			  nilfs->ns_inode_size);
 		return -EINVAL;
 	} else if (nilfs->ns_inode_size < NILFS_MIN_INODE_SIZE) {
-		nilfs_msg(nilfs->ns_sb, KERN_ERR,
-			  "too small inode size: %d bytes",
+		nilfs_err(nilfs->ns_sb, "too small inode size: %d bytes",
 			  nilfs->ns_inode_size);
 		return -EINVAL;
 	}
@@ -427,8 +423,7 @@ static int nilfs_store_disk_layout(struct the_nilfs *nilfs,
 
 	nilfs->ns_blocks_per_segment = le32_to_cpu(sbp->s_blocks_per_segment);
 	if (nilfs->ns_blocks_per_segment < NILFS_SEG_MIN_BLOCKS) {
-		nilfs_msg(nilfs->ns_sb, KERN_ERR,
-			  "too short segment: %lu blocks",
+		nilfs_err(nilfs->ns_sb, "too short segment: %lu blocks",
 			  nilfs->ns_blocks_per_segment);
 		return -EINVAL;
 	}
@@ -438,7 +433,7 @@ static int nilfs_store_disk_layout(struct the_nilfs *nilfs,
 		le32_to_cpu(sbp->s_r_segments_percentage);
 	if (nilfs->ns_r_segments_percentage < 1 ||
 	    nilfs->ns_r_segments_percentage > 99) {
-		nilfs_msg(nilfs->ns_sb, KERN_ERR,
+		nilfs_err(nilfs->ns_sb,
 			  "invalid reserved segments percentage: %lu",
 			  nilfs->ns_r_segments_percentage);
 		return -EINVAL;
@@ -580,16 +575,16 @@ static int nilfs_load_super_block(struct the_nilfs *nilfs,
 
 	if (!sbp[0]) {
 		if (!sbp[1]) {
-			nilfs_msg(sb, KERN_ERR, "unable to read superblock");
+			nilfs_err(sb, "unable to read superblock");
 			return -EIO;
 		}
-		nilfs_msg(sb, KERN_WARNING,
-			  "unable to read primary superblock (blocksize = %d)",
-			  blocksize);
+		nilfs_warn(sb,
+			   "unable to read primary superblock (blocksize = %d)",
+			   blocksize);
 	} else if (!sbp[1]) {
-		nilfs_msg(sb, KERN_WARNING,
-			  "unable to read secondary superblock (blocksize = %d)",
-			  blocksize);
+		nilfs_warn(sb,
+			   "unable to read secondary superblock (blocksize = %d)",
+			   blocksize);
 	}
 
 	/*
@@ -611,14 +606,14 @@ static int nilfs_load_super_block(struct the_nilfs *nilfs,
 	}
 	if (!valid[swp]) {
 		nilfs_release_super_block(nilfs);
-		nilfs_msg(sb, KERN_ERR, "couldn't find nilfs on the device");
+		nilfs_err(sb, "couldn't find nilfs on the device");
 		return -EINVAL;
 	}
 
 	if (!valid[!swp])
-		nilfs_msg(sb, KERN_WARNING,
-			  "broken superblock, retrying with spare superblock (blocksize = %d)",
-			  blocksize);
+		nilfs_warn(sb,
+			   "broken superblock, retrying with spare superblock (blocksize = %d)",
+			   blocksize);
 	if (swp)
 		nilfs_swap_super_block(nilfs);
 
@@ -652,7 +647,7 @@ int init_nilfs(struct the_nilfs *nilfs, struct super_block *sb, char *data)
 
 	blocksize = sb_min_blocksize(sb, NILFS_MIN_BLOCK_SIZE);
 	if (!blocksize) {
-		nilfs_msg(sb, KERN_ERR, "unable to set blocksize");
+		nilfs_err(sb, "unable to set blocksize");
 		err = -EINVAL;
 		goto out;
 	}
@@ -671,7 +666,7 @@ int init_nilfs(struct the_nilfs *nilfs, struct super_block *sb, char *data)
 	blocksize = BLOCK_SIZE << le32_to_cpu(sbp->s_log_block_size);
 	if (blocksize < NILFS_MIN_BLOCK_SIZE ||
 	    blocksize > NILFS_MAX_BLOCK_SIZE) {
-		nilfs_msg(sb, KERN_ERR,
+		nilfs_err(sb,
 			  "couldn't mount because of unsupported filesystem blocksize %d",
 			  blocksize);
 		err = -EINVAL;
@@ -681,7 +676,7 @@ int init_nilfs(struct the_nilfs *nilfs, struct super_block *sb, char *data)
 		int hw_blocksize = bdev_logical_block_size(sb->s_bdev);
 
 		if (blocksize < hw_blocksize) {
-			nilfs_msg(sb, KERN_ERR,
+			nilfs_err(sb,
 				  "blocksize %d too small for device (sector-size = %d)",
 				  blocksize, hw_blocksize);
 			err = -EINVAL;
diff --git a/fs/open.c b/fs/open.c
index 76996f920ebf..fc634ab5af0d 100644
--- a/fs/open.c
+++ b/fs/open.c
@@ -569,14 +569,19 @@ static int chmod_common(const struct path *path, umode_t mode)
 	return error;
 }
 
+int vfs_fchmod(struct file *file, umode_t mode)
+{
+	audit_file(file);
+	return chmod_common(&file->f_path, mode);
+}
+
 int ksys_fchmod(unsigned int fd, umode_t mode)
 {
 	struct fd f = fdget(fd);
 	int err = -EBADF;
 
 	if (f.file) {
-		audit_file(f.file);
-		err = chmod_common(&f.file->f_path, mode);
+		err = vfs_fchmod(f.file, mode);
 		fdput(f);
 	}
 	return err;
@@ -707,23 +712,28 @@ SYSCALL_DEFINE3(lchown, const char __user *, filename, uid_t, user, gid_t, group
 			   AT_SYMLINK_NOFOLLOW);
 }
 
+int vfs_fchown(struct file *file, uid_t user, gid_t group)
+{
+	int error;
+
+	error = mnt_want_write_file(file);
+	if (error)
+		return error;
+	audit_file(file);
+	error = chown_common(&file->f_path, user, group);
+	mnt_drop_write_file(file);
+	return error;
+}
+
 int ksys_fchown(unsigned int fd, uid_t user, gid_t group)
 {
 	struct fd f = fdget(fd);
 	int error = -EBADF;
 
-	if (!f.file)
-		goto out;
-
-	error = mnt_want_write_file(f.file);
-	if (error)
-		goto out_fput;
-	audit_file(f.file);
-	error = chown_common(&f.file->f_path, user, group);
-	mnt_drop_write_file(f.file);
-out_fput:
-	fdput(f);
-out:
+	if (f.file) {
+		error = vfs_fchown(f.file, user, group);
+		fdput(f);
+	}
 	return error;
 }
 
diff --git a/fs/sysv/itree.c b/fs/sysv/itree.c
index e3d1673b8ec9..ef9bcfeec21a 100644
--- a/fs/sysv/itree.c
+++ b/fs/sysv/itree.c
@@ -82,9 +82,6 @@ static inline sysv_zone_t *block_end(struct buffer_head *bh)
 	return (sysv_zone_t*)((char*)bh->b_data + bh->b_size);
 }
 
-/*
- * Requires read_lock(&pointers_lock) or write_lock(&pointers_lock)
- */
 static Indirect *get_branch(struct inode *inode,
 			    int depth,
 			    int offsets[],
@@ -104,15 +101,18 @@ static Indirect *get_branch(struct inode *inode,
 		bh = sb_bread(sb, block);
 		if (!bh)
 			goto failure;
+		read_lock(&pointers_lock);
 		if (!verify_chain(chain, p))
 			goto changed;
 		add_chain(++p, bh, (sysv_zone_t*)bh->b_data + *++offsets);
+		read_unlock(&pointers_lock);
 		if (!p->key)
 			goto no_block;
 	}
 	return NULL;
 
 changed:
+	read_unlock(&pointers_lock);
 	brelse(bh);
 	*err = -EAGAIN;
 	goto no_block;
@@ -218,9 +218,7 @@ static int get_block(struct inode *inode, sector_t iblock, struct buffer_head *b
 		goto out;
 
 reread:
-	read_lock(&pointers_lock);
 	partial = get_branch(inode, depth, offsets, chain, &err);
-	read_unlock(&pointers_lock);
 
 	/* Simplest case - block found, no allocation needed */
 	if (!partial) {
@@ -290,9 +288,9 @@ static Indirect *find_shared(struct inode *inode,
 	*top = 0;
 	for (k = depth; k > 1 && !offsets[k-1]; k--)
 		;
+	partial = get_branch(inode, k, offsets, chain, &err);
 
 	write_lock(&pointers_lock);
-	partial = get_branch(inode, k, offsets, chain, &err);
 	if (!partial)
 		partial = chain + k-1;
 	/*
diff --git a/fs/ubifs/file.c b/fs/ubifs/file.c
index fca3b7f483c7..e373e5d057fd 100644
--- a/fs/ubifs/file.c
+++ b/fs/ubifs/file.c
@@ -274,9 +274,6 @@ static int write_begin_slow(struct address_space *mapping,
 				return err;
 			}
 		}
-
-		SetPageUptodate(page);
-		ClearPageError(page);
 	}
 
 	if (PagePrivate(page))
@@ -475,9 +472,6 @@ static int ubifs_write_begin(struct file *file, struct address_space *mapping,
 				return err;
 			}
 		}
-
-		SetPageUptodate(page);
-		ClearPageError(page);
 	}
 
 	err = allocate_budget(c, page, ui, appending);
@@ -487,10 +481,8 @@ static int ubifs_write_begin(struct file *file, struct address_space *mapping,
 		 * If we skipped reading the page because we were going to
 		 * write all of it, then it is not up to date.
 		 */
-		if (skipped_read) {
+		if (skipped_read)
 			ClearPageChecked(page);
-			ClearPageUptodate(page);
-		}
 		/*
 		 * Budgeting failed which means it would have to force
 		 * write-back but didn't, because we set the @fast flag in the
@@ -581,6 +573,9 @@ static int ubifs_write_end(struct file *file, struct address_space *mapping,
 		goto out;
 	}
 
+	if (len == PAGE_SIZE)
+		SetPageUptodate(page);
+
 	if (!PagePrivate(page)) {
 		SetPagePrivate(page);
 		atomic_long_inc(&c->dirty_pg_cnt);
diff --git a/include/linux/fs.h b/include/linux/fs.h
index e2c87c056742..95e35e074011 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -1660,6 +1660,9 @@ int vfs_mkobj(struct dentry *, umode_t,
 		int (*f)(struct dentry *, umode_t, void *),
 		void *);
 
+int vfs_fchown(struct file *file, uid_t user, gid_t group);
+int vfs_fchmod(struct file *file, umode_t mode);
+
 extern long vfs_ioctl(struct file *file, unsigned int cmd, unsigned long arg);
 
 /*
diff --git a/include/linux/gfp.h b/include/linux/gfp.h
index f78d1e89593f..6f8ace5c73d9 100644
--- a/include/linux/gfp.h
+++ b/include/linux/gfp.h
@@ -608,6 +608,15 @@ static inline bool pm_suspended_storage(void)
 }
 #endif /* CONFIG_PM_SLEEP */
 
+/*
+ * Check if the gfp flags allow compaction - GFP_NOIO is a really
+ * tricky context because the migration might require IO.
+ */
+static inline bool gfp_compaction_allowed(gfp_t gfp_mask)
+{
+	return IS_ENABLED(CONFIG_COMPACTION) && (gfp_mask & __GFP_IO);
+}
+
 #if (defined(CONFIG_MEMORY_ISOLATION) && defined(CONFIG_COMPACTION)) || defined(CONFIG_CMA)
 /* The below functions must be run on a range from a single zone. */
 extern int alloc_contig_range(unsigned long start, unsigned long end,
diff --git a/include/linux/sunrpc/sched.h b/include/linux/sunrpc/sched.h
index 96837ae07822..ca0a568fd824 100644
--- a/include/linux/sunrpc/sched.h
+++ b/include/linux/sunrpc/sched.h
@@ -190,7 +190,7 @@ struct rpc_wait_queue {
 	unsigned char		maxpriority;		/* maximum priority (0 if queue is not a priority queue) */
 	unsigned char		priority;		/* current priority */
 	unsigned char		nr;			/* # tasks remaining for cookie */
-	unsigned short		qlen;			/* total # tasks waiting in queue */
+	unsigned int		qlen;			/* total # tasks waiting in queue */
 	struct rpc_timer	timer_list;
 #if IS_ENABLED(CONFIG_SUNRPC_DEBUG) || IS_ENABLED(CONFIG_TRACEPOINTS)
 	const char *		name;
diff --git a/include/linux/timer.h b/include/linux/timer.h
index 7b066fd38248..aef40cac2add 100644
--- a/include/linux/timer.h
+++ b/include/linux/timer.h
@@ -171,12 +171,20 @@ extern int timer_reduce(struct timer_list *timer, unsigned long expires);
 extern void add_timer(struct timer_list *timer);
 
 extern int try_to_del_timer_sync(struct timer_list *timer);
+extern int timer_delete_sync(struct timer_list *timer);
 
-#ifdef CONFIG_SMP
-  extern int del_timer_sync(struct timer_list *timer);
-#else
-# define del_timer_sync(t)		del_timer(t)
-#endif
+/**
+ * del_timer_sync - Delete a pending timer and wait for a running callback
+ * @timer:	The timer to be deleted
+ *
+ * See timer_delete_sync() for detailed explanation.
+ *
+ * Do not use in new code. Use timer_delete_sync() instead.
+ */
+static inline int del_timer_sync(struct timer_list *timer)
+{
+	return timer_delete_sync(timer);
+}
 
 #define del_singleshot_timer_sync(t) del_timer_sync(t)
 
diff --git a/include/net/erspan.h b/include/net/erspan.h
index b39643ef4c95..0d9e86bd9893 100644
--- a/include/net/erspan.h
+++ b/include/net/erspan.h
@@ -2,7 +2,19 @@
 #define __LINUX_ERSPAN_H
 
 /*
- * GRE header for ERSPAN encapsulation (8 octets [34:41]) -- 8 bytes
+ * GRE header for ERSPAN type I encapsulation (4 octets [34:37])
+ *      0                   1                   2                   3
+ *      0 1 2 3 4 5 6 7 8 9 0 1 2 3 4 5 6 7 8 9 0 1 2 3 4 5 6 7 8 9 0 1
+ *     +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
+ *     |0|0|0|0|0|00000|000000000|00000|    Protocol Type for ERSPAN   |
+ *     +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
+ *
+ *  The Type I ERSPAN frame format is based on the barebones IP + GRE
+ *  encapsulation (as described above) on top of the raw mirrored frame.
+ *  There is no extra ERSPAN header.
+ *
+ *
+ * GRE header for ERSPAN type II and II encapsulation (8 octets [34:41])
  *       0                   1                   2                   3
  *      0 1 2 3 4 5 6 7 8 9 0 1 2 3 4 5 6 7 8 9 0 1 2 3 4 5 6 7 8 9 0 1
  *     +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
@@ -43,7 +55,7 @@
  * |                  Platform Specific Info                       |
  * +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
  *
- * GRE proto ERSPAN type II = 0x88BE, type III = 0x22EB
+ * GRE proto ERSPAN type I/II = 0x88BE, type III = 0x22EB
  */
 
 #include <uapi/linux/erspan.h>
@@ -139,6 +151,9 @@ static inline u8 get_hwid(const struct erspan_md2 *md2)
 
 static inline int erspan_hdr_len(int version)
 {
+	if (version == 0)
+		return 0;
+
 	return sizeof(struct erspan_base_hdr) +
 	       (version == 1 ? ERSPAN_V1_MDSIZE : ERSPAN_V2_MDSIZE);
 }
diff --git a/include/net/inet_connection_sock.h b/include/net/inet_connection_sock.h
index da8a582ab032..6141fe1932c8 100644
--- a/include/net/inet_connection_sock.h
+++ b/include/net/inet_connection_sock.h
@@ -177,6 +177,7 @@ void inet_csk_init_xmit_timers(struct sock *sk,
 			       void (*delack_handler)(struct timer_list *),
 			       void (*keepalive_handler)(struct timer_list *));
 void inet_csk_clear_xmit_timers(struct sock *sk);
+void inet_csk_clear_xmit_timers_sync(struct sock *sk);
 
 static inline void inet_csk_schedule_ack(struct sock *sk)
 {
diff --git a/include/net/sock.h b/include/net/sock.h
index 81888513b3b9..b5a929a4bc74 100644
--- a/include/net/sock.h
+++ b/include/net/sock.h
@@ -1589,6 +1589,13 @@ static inline void sock_owned_by_me(const struct sock *sk)
 #endif
 }
 
+static inline void sock_not_owned_by_me(const struct sock *sk)
+{
+#ifdef CONFIG_LOCKDEP
+	WARN_ON_ONCE(lockdep_sock_is_held(sk) && debug_locks);
+#endif
+}
+
 static inline bool sock_owned_by_user(const struct sock *sk)
 {
 	sock_owned_by_me(sk);
@@ -2194,6 +2201,8 @@ void sk_reset_timer(struct sock *sk, struct timer_list *timer,
 
 void sk_stop_timer(struct sock *sk, struct timer_list *timer);
 
+void sk_stop_timer_sync(struct sock *sk, struct timer_list *timer);
+
 int __sk_queue_drop_skb(struct sock *sk, struct sk_buff_head *sk_queue,
 			struct sk_buff *skb, unsigned int flags,
 			void (*destructor)(struct sock *sk,
diff --git a/include/soc/fsl/qman.h b/include/soc/fsl/qman.h
index 597783b8a3a0..b67f2e83bbef 100644
--- a/include/soc/fsl/qman.h
+++ b/include/soc/fsl/qman.h
@@ -1159,6 +1159,15 @@ int qman_delete_cgr(struct qman_cgr *cgr);
  */
 void qman_delete_cgr_safe(struct qman_cgr *cgr);
 
+/**
+ * qman_update_cgr_safe - Modifies a congestion group object from any CPU
+ * @cgr: the 'cgr' object to modify
+ * @opts: state of the CGR settings
+ *
+ * This will select the proper CPU and modify the CGR settings.
+ */
+int qman_update_cgr_safe(struct qman_cgr *cgr, struct qm_mcc_initcgr *opts);
+
 /**
  * qman_query_cgr_congested - Queries CGR's congestion status
  * @cgr: the 'cgr' object to query
diff --git a/include/trace/events/timer.h b/include/trace/events/timer.h
index 350b046e7576..295517f109d7 100644
--- a/include/trace/events/timer.h
+++ b/include/trace/events/timer.h
@@ -73,7 +73,7 @@ TRACE_EVENT(timer_start,
 		__entry->flags		= flags;
 	),
 
-	TP_printk("timer=%p function=%pf expires=%lu [timeout=%ld] cpu=%u idx=%u flags=%s",
+	TP_printk("timer=%p function=%ps expires=%lu [timeout=%ld] cpu=%u idx=%u flags=%s",
 		  __entry->timer, __entry->function, __entry->expires,
 		  (long)__entry->expires - __entry->now,
 		  __entry->flags & TIMER_CPUMASK,
@@ -89,23 +89,27 @@ TRACE_EVENT(timer_start,
  */
 TRACE_EVENT(timer_expire_entry,
 
-	TP_PROTO(struct timer_list *timer),
+	TP_PROTO(struct timer_list *timer, unsigned long baseclk),
 
-	TP_ARGS(timer),
+	TP_ARGS(timer, baseclk),
 
 	TP_STRUCT__entry(
 		__field( void *,	timer	)
 		__field( unsigned long,	now	)
 		__field( void *,	function)
+		__field( unsigned long,	baseclk	)
 	),
 
 	TP_fast_assign(
 		__entry->timer		= timer;
 		__entry->now		= jiffies;
 		__entry->function	= timer->function;
+		__entry->baseclk	= baseclk;
 	),
 
-	TP_printk("timer=%p function=%pf now=%lu", __entry->timer, __entry->function,__entry->now)
+	TP_printk("timer=%p function=%ps now=%lu baseclk=%lu",
+		  __entry->timer, __entry->function, __entry->now,
+		  __entry->baseclk)
 );
 
 /**
@@ -210,7 +214,7 @@ TRACE_EVENT(hrtimer_start,
 		__entry->mode		= mode;
 	),
 
-	TP_printk("hrtimer=%p function=%pf expires=%llu softexpires=%llu "
+	TP_printk("hrtimer=%p function=%ps expires=%llu softexpires=%llu "
 		  "mode=%s", __entry->hrtimer, __entry->function,
 		  (unsigned long long) __entry->expires,
 		  (unsigned long long) __entry->softexpires,
@@ -243,7 +247,8 @@ TRACE_EVENT(hrtimer_expire_entry,
 		__entry->function	= hrtimer->function;
 	),
 
-	TP_printk("hrtimer=%p function=%pf now=%llu", __entry->hrtimer, __entry->function,
+	TP_printk("hrtimer=%p function=%ps now=%llu",
+		  __entry->hrtimer, __entry->function,
 		  (unsigned long long) __entry->now)
 );
 
diff --git a/include/uapi/linux/input-event-codes.h b/include/uapi/linux/input-event-codes.h
index 1c011379a996..76b524895dea 100644
--- a/include/uapi/linux/input-event-codes.h
+++ b/include/uapi/linux/input-event-codes.h
@@ -596,6 +596,7 @@
 
 #define KEY_ALS_TOGGLE		0x230	/* Ambient light sensor */
 #define KEY_ROTATE_LOCK_TOGGLE	0x231	/* Display rotation lock */
+#define KEY_REFRESH_RATE_TOGGLE	0x232	/* Display refresh rate toggle */
 
 #define KEY_BUTTONCONFIG		0x240	/* AL Button Configuration */
 #define KEY_TASKMANAGER		0x241	/* AL Task/Project Manager */
diff --git a/init/initramfs.c b/init/initramfs.c
index dab8d63459f6..fceede4cff6e 100644
--- a/init/initramfs.c
+++ b/init/initramfs.c
@@ -11,13 +11,14 @@
 #include <linux/utime.h>
 #include <linux/file.h>
 
-static ssize_t __init xwrite(int fd, const char *p, size_t count)
+static ssize_t __init xwrite(struct file *file, const char *p, size_t count,
+		loff_t *pos)
 {
 	ssize_t out = 0;
 
 	/* sys_write only can write MAX_RW_COUNT aka 2G-4K bytes at most */
 	while (count) {
-		ssize_t rv = ksys_write(fd, p, count);
+		ssize_t rv = kernel_write(file, p, count, pos);
 
 		if (rv < 0) {
 			if (rv == -EINTR || rv == -EAGAIN)
@@ -315,7 +316,8 @@ static int __init maybe_link(void)
 	return 0;
 }
 
-static __initdata int wfd;
+static __initdata struct file *wfile;
+static __initdata loff_t wfile_pos;
 
 static int __init do_name(void)
 {
@@ -332,16 +334,17 @@ static int __init do_name(void)
 			int openflags = O_WRONLY|O_CREAT;
 			if (ml != 1)
 				openflags |= O_TRUNC;
-			wfd = ksys_open(collected, openflags, mode);
-
-			if (wfd >= 0) {
-				ksys_fchown(wfd, uid, gid);
-				ksys_fchmod(wfd, mode);
-				if (body_len)
-					ksys_ftruncate(wfd, body_len);
-				vcollected = kstrdup(collected, GFP_KERNEL);
-				state = CopyFile;
-			}
+			wfile = filp_open(collected, openflags, mode);
+			if (IS_ERR(wfile))
+				return 0;
+			wfile_pos = 0;
+
+			vfs_fchown(wfile, uid, gid);
+			vfs_fchmod(wfile, mode);
+			if (body_len)
+				vfs_truncate(&wfile->f_path, body_len);
+			vcollected = kstrdup(collected, GFP_KERNEL);
+			state = CopyFile;
 		}
 	} else if (S_ISDIR(mode)) {
 		ksys_mkdir(collected, mode);
@@ -363,16 +366,16 @@ static int __init do_name(void)
 static int __init do_copy(void)
 {
 	if (byte_count >= body_len) {
-		if (xwrite(wfd, victim, body_len) != body_len)
+		if (xwrite(wfile, victim, body_len, &wfile_pos) != body_len)
 			error("write error");
-		ksys_close(wfd);
+		fput(wfile);
 		do_utime(vcollected, mtime);
 		kfree(vcollected);
 		eat(body_len);
 		state = SkipIt;
 		return 0;
 	} else {
-		if (xwrite(wfd, victim, byte_count) != byte_count)
+		if (xwrite(wfile, victim, byte_count, &wfile_pos) != byte_count)
 			error("write error");
 		body_len -= byte_count;
 		eat(byte_count);
@@ -599,6 +602,30 @@ static void __init clean_rootfs(void)
 }
 #endif
 
+#ifdef CONFIG_BLK_DEV_RAM
+static void __init populate_initrd_image(char *err)
+{
+	ssize_t written;
+	struct file *file;
+	loff_t pos = 0;
+
+	unpack_to_rootfs(__initramfs_start, __initramfs_size);
+
+	printk(KERN_INFO "rootfs image is not initramfs (%s); looks like an initrd\n",
+			err);
+	file = filp_open("/initrd.image", O_WRONLY|O_CREAT|O_LARGEFILE, 0700);
+	if (IS_ERR(file))
+		return;
+
+	written = xwrite(file, (char *)initrd_start, initrd_end - initrd_start,
+			&pos);
+	if (written != initrd_end - initrd_start)
+		pr_err("/initrd.image: incomplete write (%zd != %ld)\n",
+		       written, initrd_end - initrd_start);
+	fput(file);
+}
+#endif /* CONFIG_BLK_DEV_RAM */
+
 static int __init populate_rootfs(void)
 {
 	/* Load the built in initramfs */
@@ -608,7 +635,6 @@ static int __init populate_rootfs(void)
 	/* If available load the bootloader supplied initrd */
 	if (initrd_start && !IS_ENABLED(CONFIG_INITRAMFS_FORCE)) {
 #ifdef CONFIG_BLK_DEV_RAM
-		int fd;
 		printk(KERN_INFO "Trying to unpack rootfs image as initramfs...\n");
 		err = unpack_to_rootfs((char *)initrd_start,
 			initrd_end - initrd_start);
@@ -616,22 +642,7 @@ static int __init populate_rootfs(void)
 			goto done;
 
 		clean_rootfs();
-		unpack_to_rootfs(__initramfs_start, __initramfs_size);
-
-		printk(KERN_INFO "rootfs image is not initramfs (%s)"
-				"; looks like an initrd\n", err);
-		fd = ksys_open("/initrd.image",
-			      O_WRONLY|O_CREAT, 0700);
-		if (fd >= 0) {
-			ssize_t written = xwrite(fd, (char *)initrd_start,
-						initrd_end - initrd_start);
-
-			if (written != initrd_end - initrd_start)
-				pr_err("/initrd.image: incomplete write (%zd != %ld)\n",
-				       written, initrd_end - initrd_start);
-
-			ksys_close(fd);
-		}
+		populate_initrd_image(err);
 	done:
 		/* empty statement */;
 #else
diff --git a/kernel/events/core.c b/kernel/events/core.c
index 1f215aa8f30d..ef422d1326a8 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -6253,9 +6253,16 @@ static void perf_output_read_group(struct perf_output_handle *handle,
 {
 	struct perf_event *leader = event->group_leader, *sub;
 	u64 read_format = event->attr.read_format;
+	unsigned long flags;
 	u64 values[6];
 	int n = 0;
 
+	/*
+	 * Disabling interrupts avoids all counter scheduling
+	 * (context switches, timer based rotation and IPIs).
+	 */
+	local_irq_save(flags);
+
 	values[n++] = 1 + leader->nr_siblings;
 
 	if (read_format & PERF_FORMAT_TOTAL_TIME_ENABLED)
@@ -6291,6 +6298,8 @@ static void perf_output_read_group(struct perf_output_handle *handle,
 
 		__output_copy(handle, values, n * sizeof(u64));
 	}
+
+	local_irq_restore(flags);
 }
 
 #define PERF_FORMAT_TOTAL_TIMES (PERF_FORMAT_TOTAL_TIME_ENABLED|\
diff --git a/kernel/power/suspend.c b/kernel/power/suspend.c
index 0bd595a0b610..7a080015a1b3 100644
--- a/kernel/power/suspend.c
+++ b/kernel/power/suspend.c
@@ -202,6 +202,7 @@ static int __init mem_sleep_default_setup(char *str)
 		if (mem_sleep_labels[state] &&
 		    !strcmp(str, mem_sleep_labels[state])) {
 			mem_sleep_default = state;
+			mem_sleep_current = state;
 			break;
 		}
 
diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index 2ba16c426ba5..66c78dfd1792 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -1732,6 +1732,12 @@ static int console_trylock_spinning(void)
 	 */
 	mutex_acquire(&console_lock_dep_map, 0, 1, _THIS_IP_);
 
+	/*
+	 * Update @console_may_schedule for trylock because the previous
+	 * owner may have been schedulable.
+	 */
+	console_may_schedule = 0;
+
 	return 1;
 }
 
diff --git a/kernel/time/timer.c b/kernel/time/timer.c
index a6e88d9bb931..e3120af29f53 100644
--- a/kernel/time/timer.c
+++ b/kernel/time/timer.c
@@ -198,6 +198,10 @@ EXPORT_SYMBOL(jiffies_64);
 struct timer_base {
 	raw_spinlock_t		lock;
 	struct timer_list	*running_timer;
+#ifdef CONFIG_PREEMPT_RT
+	spinlock_t		expiry_lock;
+	atomic_t		timer_waiters;
+#endif
 	unsigned long		clk;
 	unsigned long		next_expiry;
 	unsigned int		cpu;
@@ -1033,7 +1037,7 @@ __mod_timer(struct timer_list *timer, unsigned long expires, unsigned int option
 		/*
 		 * We are trying to schedule the timer on the new base.
 		 * However we can't change timer's base while it is running,
-		 * otherwise del_timer_sync() can't detect that the timer's
+		 * otherwise timer_delete_sync() can't detect that the timer's
 		 * handler yet has not finished. This also guarantees that the
 		 * timer is serialized wrt itself.
 		 */
@@ -1074,14 +1078,16 @@ __mod_timer(struct timer_list *timer, unsigned long expires, unsigned int option
 }
 
 /**
- * mod_timer_pending - modify a pending timer's timeout
- * @timer: the pending timer to be modified
- * @expires: new timeout in jiffies
+ * mod_timer_pending - Modify a pending timer's timeout
+ * @timer:	The pending timer to be modified
+ * @expires:	New absolute timeout in jiffies
  *
- * mod_timer_pending() is the same for pending timers as mod_timer(),
- * but will not re-activate and modify already deleted timers.
+ * mod_timer_pending() is the same for pending timers as mod_timer(), but
+ * will not activate inactive timers.
  *
- * It is useful for unserialized use of timers.
+ * Return:
+ * * %0 - The timer was inactive and not modified
+ * * %1 - The timer was active and requeued to expire at @expires
  */
 int mod_timer_pending(struct timer_list *timer, unsigned long expires)
 {
@@ -1090,24 +1096,27 @@ int mod_timer_pending(struct timer_list *timer, unsigned long expires)
 EXPORT_SYMBOL(mod_timer_pending);
 
 /**
- * mod_timer - modify a timer's timeout
- * @timer: the timer to be modified
- * @expires: new timeout in jiffies
- *
- * mod_timer() is a more efficient way to update the expire field of an
- * active timer (if the timer is inactive it will be activated)
+ * mod_timer - Modify a timer's timeout
+ * @timer:	The timer to be modified
+ * @expires:	New absolute timeout in jiffies
  *
  * mod_timer(timer, expires) is equivalent to:
  *
  *     del_timer(timer); timer->expires = expires; add_timer(timer);
  *
+ * mod_timer() is more efficient than the above open coded sequence. In
+ * case that the timer is inactive, the del_timer() part is a NOP. The
+ * timer is in any case activated with the new expiry time @expires.
+ *
  * Note that if there are multiple unserialized concurrent users of the
  * same timer, then mod_timer() is the only safe way to modify the timeout,
  * since add_timer() cannot modify an already running timer.
  *
- * The function returns whether it has modified a pending timer or not.
- * (ie. mod_timer() of an inactive timer returns 0, mod_timer() of an
- * active timer returns 1.)
+ * Return:
+ * * %0 - The timer was inactive and started
+ * * %1 - The timer was active and requeued to expire at @expires or
+ *	  the timer was active and not modified because @expires did
+ *	  not change the effective expiry time
  */
 int mod_timer(struct timer_list *timer, unsigned long expires)
 {
@@ -1118,11 +1127,18 @@ EXPORT_SYMBOL(mod_timer);
 /**
  * timer_reduce - Modify a timer's timeout if it would reduce the timeout
  * @timer:	The timer to be modified
- * @expires:	New timeout in jiffies
+ * @expires:	New absolute timeout in jiffies
  *
  * timer_reduce() is very similar to mod_timer(), except that it will only
- * modify a running timer if that would reduce the expiration time (it will
- * start a timer that isn't running).
+ * modify an enqueued timer if that would reduce the expiration time. If
+ * @timer is not enqueued it starts the timer.
+ *
+ * Return:
+ * * %0 - The timer was inactive and started
+ * * %1 - The timer was active and requeued to expire at @expires or
+ *	  the timer was active and not modified because @expires
+ *	  did not change the effective expiry time such that the
+ *	  timer would expire earlier than already scheduled
  */
 int timer_reduce(struct timer_list *timer, unsigned long expires)
 {
@@ -1131,18 +1147,21 @@ int timer_reduce(struct timer_list *timer, unsigned long expires)
 EXPORT_SYMBOL(timer_reduce);
 
 /**
- * add_timer - start a timer
- * @timer: the timer to be added
+ * add_timer - Start a timer
+ * @timer:	The timer to be started
  *
- * The kernel will do a ->function(@timer) callback from the
- * timer interrupt at the ->expires point in the future. The
- * current time is 'jiffies'.
+ * Start @timer to expire at @timer->expires in the future. @timer->expires
+ * is the absolute expiry time measured in 'jiffies'. When the timer expires
+ * timer->function(timer) will be invoked from soft interrupt context.
  *
- * The timer's ->expires, ->function fields must be set prior calling this
- * function.
+ * The @timer->expires and @timer->function fields must be set prior
+ * to calling this function.
+ *
+ * If @timer->expires is already in the past @timer will be queued to
+ * expire at the next timer tick.
  *
- * Timers with an ->expires field in the past will be executed in the next
- * timer tick.
+ * This can only operate on an inactive timer. Attempts to invoke this on
+ * an active timer are rejected with a warning.
  */
 void add_timer(struct timer_list *timer)
 {
@@ -1152,11 +1171,13 @@ void add_timer(struct timer_list *timer)
 EXPORT_SYMBOL(add_timer);
 
 /**
- * add_timer_on - start a timer on a particular CPU
- * @timer: the timer to be added
- * @cpu: the CPU to start it on
+ * add_timer_on - Start a timer on a particular CPU
+ * @timer:	The timer to be started
+ * @cpu:	The CPU to start it on
  *
- * This is not very scalable on SMP. Double adds are not possible.
+ * Same as add_timer() except that it starts the timer on the given CPU.
+ *
+ * See add_timer() for further details.
  */
 void add_timer_on(struct timer_list *timer, int cpu)
 {
@@ -1191,15 +1212,18 @@ void add_timer_on(struct timer_list *timer, int cpu)
 EXPORT_SYMBOL_GPL(add_timer_on);
 
 /**
- * del_timer - deactivate a timer.
- * @timer: the timer to be deactivated
- *
- * del_timer() deactivates a timer - this works on both active and inactive
- * timers.
- *
- * The function returns whether it has deactivated a pending timer or not.
- * (ie. del_timer() of an inactive timer returns 0, del_timer() of an
- * active timer returns 1.)
+ * del_timer - Deactivate a timer.
+ * @timer:	The timer to be deactivated
+ *
+ * The function only deactivates a pending timer, but contrary to
+ * timer_delete_sync() it does not take into account whether the timer's
+ * callback function is concurrently executed on a different CPU or not.
+ * It neither prevents rearming of the timer. If @timer can be rearmed
+ * concurrently then the return value of this function is meaningless.
+ *
+ * Return:
+ * * %0 - The timer was not pending
+ * * %1 - The timer was pending and deactivated
  */
 int del_timer(struct timer_list *timer)
 {
@@ -1221,10 +1245,19 @@ EXPORT_SYMBOL(del_timer);
 
 /**
  * try_to_del_timer_sync - Try to deactivate a timer
- * @timer: timer to delete
+ * @timer:	Timer to deactivate
+ *
+ * This function tries to deactivate a timer. On success the timer is not
+ * queued and the timer callback function is not running on any CPU.
  *
- * This function tries to deactivate a timer. Upon successful (ret >= 0)
- * exit the timer is not queued and the handler is not running on any CPU.
+ * This function does not guarantee that the timer cannot be rearmed right
+ * after dropping the base lock. That needs to be prevented by the calling
+ * code if necessary.
+ *
+ * Return:
+ * * %0  - The timer was not pending
+ * * %1  - The timer was pending and deactivated
+ * * %-1 - The timer callback function is running on a different CPU
  */
 int try_to_del_timer_sync(struct timer_list *timer)
 {
@@ -1245,25 +1278,91 @@ int try_to_del_timer_sync(struct timer_list *timer)
 }
 EXPORT_SYMBOL(try_to_del_timer_sync);
 
-#ifdef CONFIG_SMP
-/**
- * del_timer_sync - deactivate a timer and wait for the handler to finish.
- * @timer: the timer to be deactivated
+#ifdef CONFIG_PREEMPT_RT
+static __init void timer_base_init_expiry_lock(struct timer_base *base)
+{
+	spin_lock_init(&base->expiry_lock);
+}
+
+static inline void timer_base_lock_expiry(struct timer_base *base)
+{
+	spin_lock(&base->expiry_lock);
+}
+
+static inline void timer_base_unlock_expiry(struct timer_base *base)
+{
+	spin_unlock(&base->expiry_lock);
+}
+
+/*
+ * The counterpart to del_timer_wait_running().
+ *
+ * If there is a waiter for base->expiry_lock, then it was waiting for the
+ * timer callback to finish. Drop expiry_lock and reaquire it. That allows
+ * the waiter to acquire the lock and make progress.
+ */
+static void timer_sync_wait_running(struct timer_base *base)
+{
+	if (atomic_read(&base->timer_waiters)) {
+		spin_unlock(&base->expiry_lock);
+		spin_lock(&base->expiry_lock);
+	}
+}
+
+/*
+ * This function is called on PREEMPT_RT kernels when the fast path
+ * deletion of a timer failed because the timer callback function was
+ * running.
  *
- * This function only differs from del_timer() on SMP: besides deactivating
- * the timer it also makes sure the handler has finished executing on other
- * CPUs.
+ * This prevents priority inversion, if the softirq thread on a remote CPU
+ * got preempted, and it prevents a life lock when the task which tries to
+ * delete a timer preempted the softirq thread running the timer callback
+ * function.
+ */
+static void del_timer_wait_running(struct timer_list *timer)
+{
+	u32 tf;
+
+	tf = READ_ONCE(timer->flags);
+	if (!(tf & TIMER_MIGRATING)) {
+		struct timer_base *base = get_timer_base(tf);
+
+		/*
+		 * Mark the base as contended and grab the expiry lock,
+		 * which is held by the softirq across the timer
+		 * callback. Drop the lock immediately so the softirq can
+		 * expire the next timer. In theory the timer could already
+		 * be running again, but that's more than unlikely and just
+		 * causes another wait loop.
+		 */
+		atomic_inc(&base->timer_waiters);
+		spin_lock_bh(&base->expiry_lock);
+		atomic_dec(&base->timer_waiters);
+		spin_unlock_bh(&base->expiry_lock);
+	}
+}
+#else
+static inline void timer_base_init_expiry_lock(struct timer_base *base) { }
+static inline void timer_base_lock_expiry(struct timer_base *base) { }
+static inline void timer_base_unlock_expiry(struct timer_base *base) { }
+static inline void timer_sync_wait_running(struct timer_base *base) { }
+static inline void del_timer_wait_running(struct timer_list *timer) { }
+#endif
+
+/**
+ * timer_delete_sync - Deactivate a timer and wait for the handler to finish.
+ * @timer:	The timer to be deactivated
  *
  * Synchronization rules: Callers must prevent restarting of the timer,
  * otherwise this function is meaningless. It must not be called from
  * interrupt contexts unless the timer is an irqsafe one. The caller must
- * not hold locks which would prevent completion of the timer's
- * handler. The timer's handler must not call add_timer_on(). Upon exit the
- * timer is not queued and the handler is not running on any CPU.
+ * not hold locks which would prevent completion of the timer's callback
+ * function. The timer's handler must not call add_timer_on(). Upon exit
+ * the timer is not queued and the handler is not running on any CPU.
  *
- * Note: For !irqsafe timers, you must not hold locks that are held in
- *   interrupt context while calling this function. Even if the lock has
- *   nothing to do with the timer in question.  Here's why::
+ * For !irqsafe timers, the caller must not hold locks that are held in
+ * interrupt context. Even if the lock has nothing to do with the timer in
+ * question.  Here's why::
  *
  *    CPU0                             CPU1
  *    ----                             ----
@@ -1273,17 +1372,26 @@ EXPORT_SYMBOL(try_to_del_timer_sync);
  *    spin_lock_irq(somelock);
  *                                     <IRQ>
  *                                        spin_lock(somelock);
- *    del_timer_sync(mytimer);
+ *    timer_delete_sync(mytimer);
  *    while (base->running_timer == mytimer);
  *
- * Now del_timer_sync() will never return and never release somelock.
- * The interrupt on the other CPU is waiting to grab somelock but
- * it has interrupted the softirq that CPU0 is waiting to finish.
+ * Now timer_delete_sync() will never return and never release somelock.
+ * The interrupt on the other CPU is waiting to grab somelock but it has
+ * interrupted the softirq that CPU0 is waiting to finish.
+ *
+ * This function cannot guarantee that the timer is not rearmed again by
+ * some concurrent or preempting code, right after it dropped the base
+ * lock. If there is the possibility of a concurrent rearm then the return
+ * value of the function is meaningless.
  *
- * The function returns whether it has deactivated a pending timer or not.
+ * Return:
+ * * %0	- The timer was not pending
+ * * %1	- The timer was pending and deactivated
  */
-int del_timer_sync(struct timer_list *timer)
+int timer_delete_sync(struct timer_list *timer)
 {
+	int ret;
+
 #ifdef CONFIG_LOCKDEP
 	unsigned long flags;
 
@@ -1301,17 +1409,23 @@ int del_timer_sync(struct timer_list *timer)
 	 * could lead to deadlock.
 	 */
 	WARN_ON(in_irq() && !(timer->flags & TIMER_IRQSAFE));
-	for (;;) {
-		int ret = try_to_del_timer_sync(timer);
-		if (ret >= 0)
-			return ret;
-		cpu_relax();
-	}
+
+	do {
+		ret = try_to_del_timer_sync(timer);
+
+		if (unlikely(ret < 0)) {
+			del_timer_wait_running(timer);
+			cpu_relax();
+		}
+	} while (ret < 0);
+
+	return ret;
 }
-EXPORT_SYMBOL(del_timer_sync);
-#endif
+EXPORT_SYMBOL(timer_delete_sync);
 
-static void call_timer_fn(struct timer_list *timer, void (*fn)(struct timer_list *))
+static void call_timer_fn(struct timer_list *timer,
+			  void (*fn)(struct timer_list *),
+			  unsigned long baseclk)
 {
 	int count = preempt_count();
 
@@ -1329,12 +1443,12 @@ static void call_timer_fn(struct timer_list *timer, void (*fn)(struct timer_list
 #endif
 	/*
 	 * Couple the lock chain with the lock chain at
-	 * del_timer_sync() by acquiring the lock_map around the fn()
-	 * call here and in del_timer_sync().
+	 * timer_delete_sync() by acquiring the lock_map around the fn()
+	 * call here and in timer_delete_sync().
 	 */
 	lock_map_acquire(&lockdep_map);
 
-	trace_timer_expire_entry(timer);
+	trace_timer_expire_entry(timer, baseclk);
 	fn(timer);
 	trace_timer_expire_exit(timer);
 
@@ -1355,6 +1469,13 @@ static void call_timer_fn(struct timer_list *timer, void (*fn)(struct timer_list
 
 static void expire_timers(struct timer_base *base, struct hlist_head *head)
 {
+	/*
+	 * This value is required only for tracing. base->clk was
+	 * incremented directly before expire_timers was called. But expiry
+	 * is related to the old base->clk value.
+	 */
+	unsigned long baseclk = base->clk - 1;
+
 	while (!hlist_empty(head)) {
 		struct timer_list *timer;
 		void (*fn)(struct timer_list *);
@@ -1368,11 +1489,14 @@ static void expire_timers(struct timer_base *base, struct hlist_head *head)
 
 		if (timer->flags & TIMER_IRQSAFE) {
 			raw_spin_unlock(&base->lock);
-			call_timer_fn(timer, fn);
+			call_timer_fn(timer, fn, baseclk);
+			base->running_timer = NULL;
 			raw_spin_lock(&base->lock);
 		} else {
 			raw_spin_unlock_irq(&base->lock);
-			call_timer_fn(timer, fn);
+			call_timer_fn(timer, fn, baseclk);
+			base->running_timer = NULL;
+			timer_sync_wait_running(base);
 			raw_spin_lock_irq(&base->lock);
 		}
 	}
@@ -1669,6 +1793,7 @@ static inline void __run_timers(struct timer_base *base)
 	if (!time_after_eq(jiffies, base->clk))
 		return;
 
+	timer_base_lock_expiry(base);
 	raw_spin_lock_irq(&base->lock);
 
 	/*
@@ -1695,8 +1820,8 @@ static inline void __run_timers(struct timer_base *base)
 		while (levels--)
 			expire_timers(base, heads + levels);
 	}
-	base->running_timer = NULL;
 	raw_spin_unlock_irq(&base->lock);
+	timer_base_unlock_expiry(base);
 }
 
 /*
@@ -1941,6 +2066,7 @@ static void __init init_timer_cpu(int cpu)
 		base->cpu = cpu;
 		raw_spin_lock_init(&base->lock);
 		base->clk = jiffies;
+		timer_base_init_expiry_lock(base);
 	}
 }
 
diff --git a/mm/compaction.c b/mm/compaction.c
index 5079ddbec8f9..7dc5a5d684fd 100644
--- a/mm/compaction.c
+++ b/mm/compaction.c
@@ -1751,16 +1751,11 @@ enum compact_result try_to_compact_pages(gfp_t gfp_mask, unsigned int order,
 		unsigned int alloc_flags, const struct alloc_context *ac,
 		enum compact_priority prio)
 {
-	int may_perform_io = gfp_mask & __GFP_IO;
 	struct zoneref *z;
 	struct zone *zone;
 	enum compact_result rc = COMPACT_SKIPPED;
 
-	/*
-	 * Check if the GFP flags allow compaction - GFP_NOIO is really
-	 * tricky context because the migration might require IO
-	 */
-	if (!may_perform_io)
+	if (!gfp_compaction_allowed(gfp_mask))
 		return COMPACT_SKIPPED;
 
 	trace_mm_compaction_try_to_compact_pages(order, gfp_mask, prio);
diff --git a/mm/memory-failure.c b/mm/memory-failure.c
index c971d5e11f93..5fce5df0fe35 100644
--- a/mm/memory-failure.c
+++ b/mm/memory-failure.c
@@ -1033,7 +1033,7 @@ static bool hwpoison_user_mappings(struct page *p, unsigned long pfn,
 	if (kill)
 		collect_procs(hpage, &tokill, flags & MF_ACTION_REQUIRED);
 
-	unmap_success = try_to_unmap(p, ttu);
+	unmap_success = try_to_unmap(hpage, ttu);
 	if (!unmap_success)
 		pr_err("Memory failure: %#lx: failed to unmap page (mapcount=%d)\n",
 		       pfn, page_mapcount(p));
diff --git a/mm/memory.c b/mm/memory.c
index 1e108db4405c..65601ce49642 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -4612,6 +4612,10 @@ int follow_phys(struct vm_area_struct *vma,
 		goto out;
 	pte = *ptep;
 
+	/* Never return PFNs of anon folios in COW mappings. */
+	if (vm_normal_page(vma, address, pte))
+		goto unlock;
+
 	if ((flags & FOLL_WRITE) && !pte_write(pte))
 		goto unlock;
 
diff --git a/mm/memtest.c b/mm/memtest.c
index f53ace709ccd..d407373f225b 100644
--- a/mm/memtest.c
+++ b/mm/memtest.c
@@ -46,10 +46,10 @@ static void __init memtest(u64 pattern, phys_addr_t start_phys, phys_addr_t size
 	last_bad = 0;
 
 	for (p = start; p < end; p++)
-		*p = pattern;
+		WRITE_ONCE(*p, pattern);
 
 	for (p = start; p < end; p++, start_phys_aligned += incr) {
-		if (*p == pattern)
+		if (READ_ONCE(*p) == pattern)
 			continue;
 		if (start_phys_aligned == last_bad + incr) {
 			last_bad += incr;
diff --git a/mm/migrate.c b/mm/migrate.c
index 171573613c39..893ea04498f7 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -514,8 +514,12 @@ int migrate_page_move_mapping(struct address_space *mapping,
 	if (PageSwapBacked(page)) {
 		__SetPageSwapBacked(newpage);
 		if (PageSwapCache(page)) {
+			int i;
+
 			SetPageSwapCache(newpage);
-			set_page_private(newpage, page_private(page));
+			for (i = 0; i < (1 << compound_order(page)); i++)
+				set_page_private(newpage + i,
+						 page_private(page + i));
 		}
 	} else {
 		VM_BUG_ON_PAGE(PageSwapCache(page), page);
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 4553cc848abc..147b67d31431 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -4099,6 +4099,7 @@ __alloc_pages_slowpath(gfp_t gfp_mask, unsigned int order,
 						struct alloc_context *ac)
 {
 	bool can_direct_reclaim = gfp_mask & __GFP_DIRECT_RECLAIM;
+	bool can_compact = gfp_compaction_allowed(gfp_mask);
 	const bool costly_order = order > PAGE_ALLOC_COSTLY_ORDER;
 	struct page *page = NULL;
 	unsigned int alloc_flags;
@@ -4164,7 +4165,7 @@ __alloc_pages_slowpath(gfp_t gfp_mask, unsigned int order,
 	 * Don't try this for allocations that are allowed to ignore
 	 * watermarks, as the ALLOC_NO_WATERMARKS attempt didn't yet happen.
 	 */
-	if (can_direct_reclaim &&
+	if (can_direct_reclaim && can_compact &&
 			(costly_order ||
 			   (order > 0 && ac->migratetype != MIGRATE_MOVABLE))
 			&& !gfp_pfmemalloc_allowed(gfp_mask)) {
@@ -4251,9 +4252,10 @@ __alloc_pages_slowpath(gfp_t gfp_mask, unsigned int order,
 
 	/*
 	 * Do not retry costly high order allocations unless they are
-	 * __GFP_RETRY_MAYFAIL
+	 * __GFP_RETRY_MAYFAIL and we can compact
 	 */
-	if (costly_order && !(gfp_mask & __GFP_RETRY_MAYFAIL))
+	if (costly_order && (!can_compact ||
+			     !(gfp_mask & __GFP_RETRY_MAYFAIL)))
 		goto nopage;
 
 	if (should_reclaim_retry(gfp_mask, order, ac, alloc_flags,
@@ -4266,7 +4268,7 @@ __alloc_pages_slowpath(gfp_t gfp_mask, unsigned int order,
 	 * implementation of the compaction depends on the sufficient amount
 	 * of free memory (see __compaction_suitable)
 	 */
-	if (did_some_progress > 0 &&
+	if (did_some_progress > 0 && can_compact &&
 			should_compact_retry(ac, order, alloc_flags,
 				compact_result, &compact_priority,
 				&compaction_retries))
diff --git a/mm/vmscan.c b/mm/vmscan.c
index b7d7f6d65bd5..b23016615c54 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -2595,7 +2595,7 @@ static void shrink_node_memcg(struct pglist_data *pgdat, struct mem_cgroup *memc
 /* Use reclaim/compaction for costly allocs or under memory pressure */
 static bool in_reclaim_compaction(struct scan_control *sc)
 {
-	if (IS_ENABLED(CONFIG_COMPACTION) && sc->order &&
+	if (gfp_compaction_allowed(sc->gfp_mask) && sc->order &&
 			(sc->order > PAGE_ALLOC_COSTLY_ORDER ||
 			 sc->priority < DEF_PRIORITY - 2))
 		return true;
@@ -2869,6 +2869,9 @@ static inline bool compaction_ready(struct zone *zone, struct scan_control *sc)
 	unsigned long watermark;
 	enum compact_result suitable;
 
+	if (!gfp_compaction_allowed(sc->gfp_mask))
+		return false;
+
 	suitable = compaction_suitable(zone, sc->order, 0, sc->reclaim_idx);
 	if (suitable == COMPACT_SUCCESS)
 		/* Allocation should succeed already. Don't reclaim. */
diff --git a/net/bluetooth/hci_debugfs.c b/net/bluetooth/hci_debugfs.c
index 51f5b1efc3a5..a01479f84929 100644
--- a/net/bluetooth/hci_debugfs.c
+++ b/net/bluetooth/hci_debugfs.c
@@ -200,10 +200,12 @@ static int conn_info_min_age_set(void *data, u64 val)
 {
 	struct hci_dev *hdev = data;
 
-	if (val == 0 || val > hdev->conn_info_max_age)
+	hci_dev_lock(hdev);
+	if (val == 0 || val > hdev->conn_info_max_age) {
+		hci_dev_unlock(hdev);
 		return -EINVAL;
+	}
 
-	hci_dev_lock(hdev);
 	hdev->conn_info_min_age = val;
 	hci_dev_unlock(hdev);
 
@@ -228,10 +230,12 @@ static int conn_info_max_age_set(void *data, u64 val)
 {
 	struct hci_dev *hdev = data;
 
-	if (val == 0 || val < hdev->conn_info_min_age)
+	hci_dev_lock(hdev);
+	if (val == 0 || val < hdev->conn_info_min_age) {
+		hci_dev_unlock(hdev);
 		return -EINVAL;
+	}
 
-	hci_dev_lock(hdev);
 	hdev->conn_info_max_age = val;
 	hci_dev_unlock(hdev);
 
@@ -479,10 +483,12 @@ static int sniff_min_interval_set(void *data, u64 val)
 {
 	struct hci_dev *hdev = data;
 
-	if (val == 0 || val % 2 || val > hdev->sniff_max_interval)
+	hci_dev_lock(hdev);
+	if (val == 0 || val % 2 || val > hdev->sniff_max_interval) {
+		hci_dev_unlock(hdev);
 		return -EINVAL;
+	}
 
-	hci_dev_lock(hdev);
 	hdev->sniff_min_interval = val;
 	hci_dev_unlock(hdev);
 
@@ -507,10 +513,12 @@ static int sniff_max_interval_set(void *data, u64 val)
 {
 	struct hci_dev *hdev = data;
 
-	if (val == 0 || val % 2 || val < hdev->sniff_min_interval)
+	hci_dev_lock(hdev);
+	if (val == 0 || val % 2 || val < hdev->sniff_min_interval) {
+		hci_dev_unlock(hdev);
 		return -EINVAL;
+	}
 
-	hci_dev_lock(hdev);
 	hdev->sniff_max_interval = val;
 	hci_dev_unlock(hdev);
 
@@ -749,10 +757,12 @@ static int conn_min_interval_set(void *data, u64 val)
 {
 	struct hci_dev *hdev = data;
 
-	if (val < 0x0006 || val > 0x0c80 || val > hdev->le_conn_max_interval)
+	hci_dev_lock(hdev);
+	if (val < 0x0006 || val > 0x0c80 || val > hdev->le_conn_max_interval) {
+		hci_dev_unlock(hdev);
 		return -EINVAL;
+	}
 
-	hci_dev_lock(hdev);
 	hdev->le_conn_min_interval = val;
 	hci_dev_unlock(hdev);
 
@@ -777,10 +787,12 @@ static int conn_max_interval_set(void *data, u64 val)
 {
 	struct hci_dev *hdev = data;
 
-	if (val < 0x0006 || val > 0x0c80 || val < hdev->le_conn_min_interval)
+	hci_dev_lock(hdev);
+	if (val < 0x0006 || val > 0x0c80 || val < hdev->le_conn_min_interval) {
+		hci_dev_unlock(hdev);
 		return -EINVAL;
+	}
 
-	hci_dev_lock(hdev);
 	hdev->le_conn_max_interval = val;
 	hci_dev_unlock(hdev);
 
@@ -889,10 +901,12 @@ static int adv_min_interval_set(void *data, u64 val)
 {
 	struct hci_dev *hdev = data;
 
-	if (val < 0x0020 || val > 0x4000 || val > hdev->le_adv_max_interval)
+	hci_dev_lock(hdev);
+	if (val < 0x0020 || val > 0x4000 || val > hdev->le_adv_max_interval) {
+		hci_dev_unlock(hdev);
 		return -EINVAL;
+	}
 
-	hci_dev_lock(hdev);
 	hdev->le_adv_min_interval = val;
 	hci_dev_unlock(hdev);
 
@@ -917,10 +931,12 @@ static int adv_max_interval_set(void *data, u64 val)
 {
 	struct hci_dev *hdev = data;
 
-	if (val < 0x0020 || val > 0x4000 || val < hdev->le_adv_min_interval)
+	hci_dev_lock(hdev);
+	if (val < 0x0020 || val > 0x4000 || val < hdev->le_adv_min_interval) {
+		hci_dev_unlock(hdev);
 		return -EINVAL;
+	}
 
-	hci_dev_lock(hdev);
 	hdev->le_adv_max_interval = val;
 	hci_dev_unlock(hdev);
 
diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index 0e9325057b3a..31ab3ae78792 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -2453,6 +2453,31 @@ static void hci_conn_complete_evt(struct hci_dev *hdev, struct sk_buff *skb)
 		if (test_bit(HCI_ENCRYPT, &hdev->flags))
 			set_bit(HCI_CONN_ENCRYPT, &conn->flags);
 
+		/* "Link key request" completed ahead of "connect request" completes */
+		if (ev->encr_mode == 1 && !test_bit(HCI_CONN_ENCRYPT, &conn->flags) &&
+		    ev->link_type == ACL_LINK) {
+			struct link_key *key;
+			struct hci_cp_read_enc_key_size cp;
+
+			key = hci_find_link_key(hdev, &ev->bdaddr);
+			if (key) {
+				set_bit(HCI_CONN_ENCRYPT, &conn->flags);
+
+				if (!(hdev->commands[20] & 0x10)) {
+					conn->enc_key_size = HCI_LINK_KEY_SIZE;
+				} else {
+					cp.handle = cpu_to_le16(conn->handle);
+					if (hci_send_cmd(hdev, HCI_OP_READ_ENC_KEY_SIZE,
+							 sizeof(cp), &cp)) {
+						bt_dev_err(hdev, "sending read key size failed");
+						conn->enc_key_size = HCI_LINK_KEY_SIZE;
+					}
+				}
+
+				hci_encrypt_cfm(conn, ev->status);
+			}
+		}
+
 		/* Get remote features */
 		if (conn->type == ACL_LINK) {
 			struct hci_cp_read_remote_features cp;
diff --git a/net/core/sock.c b/net/core/sock.c
index 62d169bcfcfa..eaa6f1ca414d 100644
--- a/net/core/sock.c
+++ b/net/core/sock.c
@@ -2804,6 +2804,13 @@ void sk_stop_timer(struct sock *sk, struct timer_list* timer)
 }
 EXPORT_SYMBOL(sk_stop_timer);
 
+void sk_stop_timer_sync(struct sock *sk, struct timer_list *timer)
+{
+	if (del_timer_sync(timer))
+		__sock_put(sk);
+}
+EXPORT_SYMBOL(sk_stop_timer_sync);
+
 void sock_init_data(struct socket *sock, struct sock *sk)
 {
 	sk_init_common(sk);
diff --git a/net/ipv4/inet_connection_sock.c b/net/ipv4/inet_connection_sock.c
index 7392a744c677..17a900c85aa6 100644
--- a/net/ipv4/inet_connection_sock.c
+++ b/net/ipv4/inet_connection_sock.c
@@ -557,6 +557,20 @@ void inet_csk_clear_xmit_timers(struct sock *sk)
 }
 EXPORT_SYMBOL(inet_csk_clear_xmit_timers);
 
+void inet_csk_clear_xmit_timers_sync(struct sock *sk)
+{
+	struct inet_connection_sock *icsk = inet_csk(sk);
+
+	/* ongoing timer handlers need to acquire socket lock. */
+	sock_not_owned_by_me(sk);
+
+	icsk->icsk_pending = icsk->icsk_ack.pending = 0;
+
+	sk_stop_timer_sync(sk, &icsk->icsk_retransmit_timer);
+	sk_stop_timer_sync(sk, &icsk->icsk_delack_timer);
+	sk_stop_timer_sync(sk, &sk->sk_timer);
+}
+
 void inet_csk_delete_keepalive_timer(struct sock *sk)
 {
 	sk_stop_timer(sk, &sk->sk_timer);
diff --git a/net/ipv4/ip_gre.c b/net/ipv4/ip_gre.c
index 38c8db78cda1..2f5d2109c919 100644
--- a/net/ipv4/ip_gre.c
+++ b/net/ipv4/ip_gre.c
@@ -251,6 +251,15 @@ static void gre_err(struct sk_buff *skb, u32 info)
 	ipgre_err(skb, info, &tpi);
 }
 
+static bool is_erspan_type1(int gre_hdr_len)
+{
+	/* Both ERSPAN type I (version 0) and type II (version 1) use
+	 * protocol 0x88BE, but the type I has only 4-byte GRE header,
+	 * while type II has 8-byte.
+	 */
+	return gre_hdr_len == 4;
+}
+
 static int erspan_rcv(struct sk_buff *skb, struct tnl_ptk_info *tpi,
 		      int gre_hdr_len)
 {
@@ -265,17 +274,31 @@ static int erspan_rcv(struct sk_buff *skb, struct tnl_ptk_info *tpi,
 	int len;
 
 	itn = net_generic(net, erspan_net_id);
-
 	iph = ip_hdr(skb);
-	ershdr = (struct erspan_base_hdr *)(skb->data + gre_hdr_len);
-	ver = ershdr->ver;
+	if (is_erspan_type1(gre_hdr_len)) {
+		ver = 0;
+		tunnel = ip_tunnel_lookup(itn, skb->dev->ifindex,
+					  tpi->flags | TUNNEL_NO_KEY,
+					  iph->saddr, iph->daddr, 0);
+	} else {
+		if (unlikely(!pskb_may_pull(skb,
+					    gre_hdr_len + sizeof(*ershdr))))
+			return PACKET_REJECT;
 
-	tunnel = ip_tunnel_lookup(itn, skb->dev->ifindex,
-				  tpi->flags | TUNNEL_KEY,
-				  iph->saddr, iph->daddr, tpi->key);
+		ershdr = (struct erspan_base_hdr *)(skb->data + gre_hdr_len);
+		ver = ershdr->ver;
+		iph = ip_hdr(skb);
+		tunnel = ip_tunnel_lookup(itn, skb->dev->ifindex,
+					  tpi->flags | TUNNEL_KEY,
+					  iph->saddr, iph->daddr, tpi->key);
+	}
 
 	if (tunnel) {
-		len = gre_hdr_len + erspan_hdr_len(ver);
+		if (is_erspan_type1(gre_hdr_len))
+			len = gre_hdr_len;
+		else
+			len = gre_hdr_len + erspan_hdr_len(ver);
+
 		if (unlikely(!pskb_may_pull(skb, len)))
 			return PACKET_REJECT;
 
@@ -746,7 +769,10 @@ static netdev_tx_t erspan_xmit(struct sk_buff *skb,
 	}
 
 	/* Push ERSPAN header */
-	if (tunnel->erspan_ver == 1) {
+	if (tunnel->erspan_ver == 0) {
+		proto = htons(ETH_P_ERSPAN);
+		tunnel->parms.o_flags &= ~TUNNEL_SEQ;
+	} else if (tunnel->erspan_ver == 1) {
 		erspan_build_header(skb, ntohl(tunnel->parms.o_key),
 				    tunnel->index,
 				    truncate, true);
@@ -1156,7 +1182,11 @@ static int erspan_validate(struct nlattr *tb[], struct nlattr *data[],
 	if (ret)
 		return ret;
 
-	/* ERSPAN should only have GRE sequence and key flag */
+	if (data[IFLA_GRE_ERSPAN_VER] &&
+	    nla_get_u8(data[IFLA_GRE_ERSPAN_VER]) == 0)
+		return 0;
+
+	/* ERSPAN type II/III should only have GRE sequence and key flag */
 	if (data[IFLA_GRE_OFLAGS])
 		flags |= nla_get_be16(data[IFLA_GRE_OFLAGS]);
 	if (data[IFLA_GRE_IFLAGS])
@@ -1264,7 +1294,7 @@ static int erspan_netlink_parms(struct net_device *dev,
 	if (data[IFLA_GRE_ERSPAN_VER]) {
 		t->erspan_ver = nla_get_u8(data[IFLA_GRE_ERSPAN_VER]);
 
-		if (t->erspan_ver != 1 && t->erspan_ver != 2)
+		if (t->erspan_ver > 2)
 			return -EINVAL;
 	}
 
@@ -1349,7 +1379,11 @@ static int erspan_tunnel_init(struct net_device *dev)
 {
 	struct ip_tunnel *tunnel = netdev_priv(dev);
 
-	tunnel->tun_hlen = 8;
+	if (tunnel->erspan_ver == 0)
+		tunnel->tun_hlen = 4; /* 4-byte GRE hdr. */
+	else
+		tunnel->tun_hlen = 8; /* 8-byte GRE hdr. */
+
 	tunnel->parms.iph.protocol = IPPROTO_GRE;
 	tunnel->hlen = tunnel->tun_hlen + tunnel->encap_hlen +
 		       erspan_hdr_len(tunnel->erspan_ver);
@@ -1552,24 +1586,6 @@ static int ipgre_fill_info(struct sk_buff *skb, const struct net_device *dev)
 	struct ip_tunnel_parm *p = &t->parms;
 	__be16 o_flags = p->o_flags;
 
-	if (t->erspan_ver == 1 || t->erspan_ver == 2) {
-		if (!t->collect_md)
-			o_flags |= TUNNEL_KEY;
-
-		if (nla_put_u8(skb, IFLA_GRE_ERSPAN_VER, t->erspan_ver))
-			goto nla_put_failure;
-
-		if (t->erspan_ver == 1) {
-			if (nla_put_u32(skb, IFLA_GRE_ERSPAN_INDEX, t->index))
-				goto nla_put_failure;
-		} else {
-			if (nla_put_u8(skb, IFLA_GRE_ERSPAN_DIR, t->dir))
-				goto nla_put_failure;
-			if (nla_put_u16(skb, IFLA_GRE_ERSPAN_HWID, t->hwid))
-				goto nla_put_failure;
-		}
-	}
-
 	if (nla_put_u32(skb, IFLA_GRE_LINK, p->link) ||
 	    nla_put_be16(skb, IFLA_GRE_IFLAGS,
 			 gre_tnl_flags_to_gre_flags(p->i_flags)) ||
@@ -1610,6 +1626,34 @@ static int ipgre_fill_info(struct sk_buff *skb, const struct net_device *dev)
 	return -EMSGSIZE;
 }
 
+static int erspan_fill_info(struct sk_buff *skb, const struct net_device *dev)
+{
+	struct ip_tunnel *t = netdev_priv(dev);
+
+	if (t->erspan_ver <= 2) {
+		if (t->erspan_ver != 0 && !t->collect_md)
+			t->parms.o_flags |= TUNNEL_KEY;
+
+		if (nla_put_u8(skb, IFLA_GRE_ERSPAN_VER, t->erspan_ver))
+			goto nla_put_failure;
+
+		if (t->erspan_ver == 1) {
+			if (nla_put_u32(skb, IFLA_GRE_ERSPAN_INDEX, t->index))
+				goto nla_put_failure;
+		} else if (t->erspan_ver == 2) {
+			if (nla_put_u8(skb, IFLA_GRE_ERSPAN_DIR, t->dir))
+				goto nla_put_failure;
+			if (nla_put_u16(skb, IFLA_GRE_ERSPAN_HWID, t->hwid))
+				goto nla_put_failure;
+		}
+	}
+
+	return ipgre_fill_info(skb, dev);
+
+nla_put_failure:
+	return -EMSGSIZE;
+}
+
 static void erspan_setup(struct net_device *dev)
 {
 	struct ip_tunnel *t = netdev_priv(dev);
@@ -1688,7 +1732,7 @@ static struct rtnl_link_ops erspan_link_ops __read_mostly = {
 	.changelink	= erspan_changelink,
 	.dellink	= ip_tunnel_dellink,
 	.get_size	= ipgre_get_size,
-	.fill_info	= ipgre_fill_info,
+	.fill_info	= erspan_fill_info,
 	.get_link_net	= ip_tunnel_get_link_net,
 };
 
diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
index 3df973d22295..54d6058dcb5c 100644
--- a/net/ipv4/tcp.c
+++ b/net/ipv4/tcp.c
@@ -2514,6 +2514,8 @@ void tcp_close(struct sock *sk, long timeout)
 	lock_sock(sk);
 	__tcp_close(sk, timeout);
 	release_sock(sk);
+	if (!sk->sk_net_refcnt)
+		inet_csk_clear_xmit_timers_sync(sk);
 	sock_put(sk);
 }
 EXPORT_SYMBOL(tcp_close);
diff --git a/net/ipv6/ip6_fib.c b/net/ipv6/ip6_fib.c
index 92bc56028b8b..63fb9e01eb4e 100644
--- a/net/ipv6/ip6_fib.c
+++ b/net/ipv6/ip6_fib.c
@@ -587,19 +587,19 @@ static int inet6_dump_fib(struct sk_buff *skb, struct netlink_callback *cb)
 	if (!w) {
 		/* New dump:
 		 *
-		 * 1. hook callback destructor.
-		 */
-		cb->args[3] = (long)cb->done;
-		cb->done = fib6_dump_done;
-
-		/*
-		 * 2. allocate and initialize walker.
+		 * 1. allocate and initialize walker.
 		 */
 		w = kzalloc(sizeof(*w), GFP_ATOMIC);
 		if (!w)
 			return -ENOMEM;
 		w->func = fib6_dump_node;
 		cb->args[2] = (long)w;
+
+		/* 2. hook callback destructor.
+		 */
+		cb->args[3] = (long)cb->done;
+		cb->done = fib6_dump_done;
+
 	}
 
 	arg.skb = skb;
diff --git a/net/ipv6/ip6_gre.c b/net/ipv6/ip6_gre.c
index aa8ada354a39..58e1fc8e4124 100644
--- a/net/ipv6/ip6_gre.c
+++ b/net/ipv6/ip6_gre.c
@@ -551,6 +551,9 @@ static int ip6erspan_rcv(struct sk_buff *skb, struct tnl_ptk_info *tpi,
 	struct ip6_tnl *tunnel;
 	u8 ver;
 
+	if (unlikely(!pskb_may_pull(skb, sizeof(*ershdr))))
+		return PACKET_REJECT;
+
 	ipv6h = ipv6_hdr(skb);
 	ershdr = (struct erspan_base_hdr *)skb->data;
 	ver = ershdr->ver;
diff --git a/net/mac80211/cfg.c b/net/mac80211/cfg.c
index 77d8ed184c1c..cfbaafcea0a4 100644
--- a/net/mac80211/cfg.c
+++ b/net/mac80211/cfg.c
@@ -1548,15 +1548,14 @@ static int ieee80211_change_station(struct wiphy *wiphy,
 		}
 
 		if (sta->sdata->vif.type == NL80211_IFTYPE_AP_VLAN &&
-		    sta->sdata->u.vlan.sta) {
-			ieee80211_clear_fast_rx(sta);
+		    sta->sdata->u.vlan.sta)
 			RCU_INIT_POINTER(sta->sdata->u.vlan.sta, NULL);
-		}
 
 		if (test_sta_flag(sta, WLAN_STA_AUTHORIZED))
 			ieee80211_vif_dec_num_mcast(sta->sdata);
 
 		sta->sdata = vlansdata;
+		ieee80211_check_fast_rx(sta);
 		ieee80211_check_fast_xmit(sta);
 
 		if (test_sta_flag(sta, WLAN_STA_AUTHORIZED)) {
diff --git a/net/netfilter/nf_tables_api.c b/net/netfilter/nf_tables_api.c
index 94f1104b0487..dc40222a9e66 100644
--- a/net/netfilter/nf_tables_api.c
+++ b/net/netfilter/nf_tables_api.c
@@ -3560,6 +3560,12 @@ static int nf_tables_newset(struct net *net, struct sock *nlsk,
 		if ((flags & (NFT_SET_EVAL | NFT_SET_OBJECT)) ==
 			     (NFT_SET_EVAL | NFT_SET_OBJECT))
 			return -EOPNOTSUPP;
+		if ((flags & (NFT_SET_ANONYMOUS | NFT_SET_TIMEOUT | NFT_SET_EVAL)) ==
+			     (NFT_SET_ANONYMOUS | NFT_SET_TIMEOUT))
+			return -EOPNOTSUPP;
+		if ((flags & (NFT_SET_CONSTANT | NFT_SET_TIMEOUT)) ==
+			     (NFT_SET_CONSTANT | NFT_SET_TIMEOUT))
+			return -EOPNOTSUPP;
 	}
 
 	dtype = 0;
@@ -3601,6 +3607,9 @@ static int nf_tables_newset(struct net *net, struct sock *nlsk,
 		if (!(flags & NFT_SET_TIMEOUT))
 			return -EINVAL;
 
+		if (flags & NFT_SET_ANONYMOUS)
+			return -EOPNOTSUPP;
+
 		err = nf_msecs_to_jiffies64(nla[NFTA_SET_TIMEOUT], &timeout);
 		if (err)
 			return err;
@@ -3609,6 +3618,10 @@ static int nf_tables_newset(struct net *net, struct sock *nlsk,
 	if (nla[NFTA_SET_GC_INTERVAL] != NULL) {
 		if (!(flags & NFT_SET_TIMEOUT))
 			return -EINVAL;
+
+		if (flags & NFT_SET_ANONYMOUS)
+			return -EOPNOTSUPP;
+
 		gc_int = ntohl(nla_get_be32(nla[NFTA_SET_GC_INTERVAL]));
 	}
 
@@ -5708,11 +5721,12 @@ static int nf_tables_flowtable_parse_hook(const struct nft_ctx *ctx,
 	return err;
 }
 
+/* call under rcu_read_lock */
 static const struct nf_flowtable_type *__nft_flowtable_type_get(u8 family)
 {
 	const struct nf_flowtable_type *type;
 
-	list_for_each_entry(type, &nf_tables_flowtables, list) {
+	list_for_each_entry_rcu(type, &nf_tables_flowtables, list) {
 		if (family == type->family)
 			return type;
 	}
@@ -5724,9 +5738,13 @@ nft_flowtable_type_get(struct net *net, u8 family)
 {
 	const struct nf_flowtable_type *type;
 
+	rcu_read_lock();
 	type = __nft_flowtable_type_get(family);
-	if (type != NULL && try_module_get(type->owner))
+	if (type != NULL && try_module_get(type->owner)) {
+		rcu_read_unlock();
 		return type;
+	}
+	rcu_read_unlock();
 
 	lockdep_nfnl_nft_mutex_not_held();
 #ifdef CONFIG_MODULES
diff --git a/net/nfc/nci/core.c b/net/nfc/nci/core.c
index 2e885b7a02a1..1f863ccf2121 100644
--- a/net/nfc/nci/core.c
+++ b/net/nfc/nci/core.c
@@ -1511,6 +1511,11 @@ static void nci_rx_work(struct work_struct *work)
 		nfc_send_to_raw_sock(ndev->nfc_dev, skb,
 				     RAW_PAYLOAD_NCI, NFC_DIRECTION_RX);
 
+		if (!nci_plen(skb->data)) {
+			kfree_skb(skb);
+			break;
+		}
+
 		/* Process frame */
 		switch (nci_mt(skb->data)) {
 		case NCI_MT_RSP_PKT:
diff --git a/net/rds/rdma.c b/net/rds/rdma.c
index 2632f3f3aa28..51f1c50c9177 100644
--- a/net/rds/rdma.c
+++ b/net/rds/rdma.c
@@ -279,7 +279,7 @@ static int __rds_rdma_map(struct rds_sock *rs, struct rds_get_mr_args *args,
 		kfree(sg);
 		ret = PTR_ERR(trans_private);
 		/* Trigger connection so that its ready for the next retry */
-		if (ret == -ENODEV)
+		if (ret == -ENODEV && cp)
 			rds_conn_connect_if_down(cp->cp_conn);
 		goto out;
 	}
diff --git a/net/sched/act_skbmod.c b/net/sched/act_skbmod.c
index 03a272af664a..51d4696aeea3 100644
--- a/net/sched/act_skbmod.c
+++ b/net/sched/act_skbmod.c
@@ -210,13 +210,13 @@ static int tcf_skbmod_dump(struct sk_buff *skb, struct tc_action *a,
 	struct tcf_skbmod *d = to_skbmod(a);
 	unsigned char *b = skb_tail_pointer(skb);
 	struct tcf_skbmod_params  *p;
-	struct tc_skbmod opt = {
-		.index   = d->tcf_index,
-		.refcnt  = refcount_read(&d->tcf_refcnt) - ref,
-		.bindcnt = atomic_read(&d->tcf_bindcnt) - bind,
-	};
+	struct tc_skbmod opt;
 	struct tcf_t t;
 
+	memset(&opt, 0, sizeof(opt));
+	opt.index   = d->tcf_index;
+	opt.refcnt  = refcount_read(&d->tcf_refcnt) - ref,
+	opt.bindcnt = atomic_read(&d->tcf_bindcnt) - bind;
 	spin_lock_bh(&d->tcf_lock);
 	opt.action = d->tcf_action;
 	p = rcu_dereference_protected(d->skbmod_p,
diff --git a/net/xfrm/xfrm_user.c b/net/xfrm/xfrm_user.c
index 699e544b4bfd..5892ff68d168 100644
--- a/net/xfrm/xfrm_user.c
+++ b/net/xfrm/xfrm_user.c
@@ -1703,6 +1703,9 @@ static int copy_to_user_tmpl(struct xfrm_policy *xp, struct sk_buff *skb)
 	if (xp->xfrm_nr == 0)
 		return 0;
 
+	if (xp->xfrm_nr > XFRM_MAX_DEPTH)
+		return -ENOBUFS;
+
 	for (i = 0; i < xp->xfrm_nr; i++) {
 		struct xfrm_user_tmpl *up = &vec[i];
 		struct xfrm_tmpl *kp = &xp->xfrm_vec[i];
diff --git a/scripts/Makefile.extrawarn b/scripts/Makefile.extrawarn
index e15cd63428ba..c2e41daf373f 100644
--- a/scripts/Makefile.extrawarn
+++ b/scripts/Makefile.extrawarn
@@ -75,5 +75,7 @@ KBUILD_CFLAGS += $(call cc-disable-warning, uninitialized)
 KBUILD_CFLAGS += $(call cc-disable-warning, pointer-to-enum-cast)
 KBUILD_CFLAGS += $(call cc-disable-warning, unaligned-access)
 KBUILD_CFLAGS += $(call cc-disable-warning, cast-function-type-strict)
+KBUILD_CFLAGS += -Wno-enum-compare-conditional
+KBUILD_CFLAGS += -Wno-enum-enum-conversion
 endif
 endif
diff --git a/security/smack/smack_lsm.c b/security/smack/smack_lsm.c
index 128a5f464740..d9bff4ba7f2e 100644
--- a/security/smack/smack_lsm.c
+++ b/security/smack/smack_lsm.c
@@ -1341,7 +1341,8 @@ static int smack_inode_setxattr(struct dentry *dentry, const char *name,
 		check_star = 1;
 	} else if (strcmp(name, XATTR_NAME_SMACKTRANSMUTE) == 0) {
 		check_priv = 1;
-		if (size != TRANS_TRUE_SIZE ||
+		if (!S_ISDIR(d_backing_inode(dentry)->i_mode) ||
+		    size != TRANS_TRUE_SIZE ||
 		    strncmp(value, TRANS_TRUE, TRANS_TRUE_SIZE) != 0)
 			rc = -EINVAL;
 	} else
@@ -2801,6 +2802,15 @@ static int smack_inode_setsecurity(struct inode *inode, const char *name,
 	if (value == NULL || size > SMK_LONGLABEL || size == 0)
 		return -EINVAL;
 
+	if (strcmp(name, XATTR_SMACK_TRANSMUTE) == 0) {
+		if (!S_ISDIR(inode->i_mode) || size != TRANS_TRUE_SIZE ||
+		    strncmp(value, TRANS_TRUE, TRANS_TRUE_SIZE) != 0)
+			return -EINVAL;
+
+		nsp->smk_flags |= SMK_INODE_TRANSMUTE;
+		return 0;
+	}
+
 	skp = smk_import_entry(value, size);
 	if (IS_ERR(skp))
 		return PTR_ERR(skp);
diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index 2b345ba083d8..60dfaf2adaaf 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -7218,7 +7218,7 @@ static const struct snd_pci_quirk alc269_fixup_tbl[] = {
 	SND_PCI_QUIRK(0x10cf, 0x1629, "Lifebook U7x7", ALC255_FIXUP_LIFEBOOK_U7x7_HEADSET_MIC),
 	SND_PCI_QUIRK(0x10cf, 0x1845, "Lifebook U904", ALC269_FIXUP_LIFEBOOK_EXTMIC),
 	SND_PCI_QUIRK(0x10ec, 0x10f2, "Intel Reference board", ALC700_FIXUP_INTEL_REFERENCE),
-	SND_PCI_QUIRK(0x10f7, 0x8338, "Panasonic CF-SZ6", ALC269_FIXUP_HEADSET_MODE),
+	SND_PCI_QUIRK(0x10f7, 0x8338, "Panasonic CF-SZ6", ALC269_FIXUP_ASPIRE_HEADSET_MIC),
 	SND_PCI_QUIRK(0x144d, 0xc109, "Samsung Ativ book 9 (NP900X3G)", ALC269_FIXUP_INV_DMIC),
 	SND_PCI_QUIRK(0x144d, 0xc740, "Samsung Ativ book 8 (NP870Z5G)", ALC269_FIXUP_ATIV_BOOK_8),
 	SND_PCI_QUIRK(0x1458, 0xfa53, "Gigabyte BXBT-2807", ALC283_FIXUP_HEADSET_MIC),
@@ -8593,8 +8593,7 @@ static void alc897_hp_automute_hook(struct hda_codec *codec,
 
 	snd_hda_gen_hp_automute(codec, jack);
 	vref = spec->gen.hp_jack_present ? (PIN_HP | AC_PINCTL_VREF_100) : PIN_HP;
-	snd_hda_codec_write(codec, 0x1b, 0, AC_VERB_SET_PIN_WIDGET_CONTROL,
-			    vref);
+	snd_hda_set_pin_ctl(codec, 0x1b, vref);
 }
 
 static void alc897_fixup_lenovo_headset_mic(struct hda_codec *codec,
@@ -8603,6 +8602,10 @@ static void alc897_fixup_lenovo_headset_mic(struct hda_codec *codec,
 	struct alc_spec *spec = codec->spec;
 	if (action == HDA_FIXUP_ACT_PRE_PROBE) {
 		spec->gen.hp_automute_hook = alc897_hp_automute_hook;
+		spec->no_shutup_pins = 1;
+	}
+	if (action == HDA_FIXUP_ACT_PROBE) {
+		snd_hda_set_pin_ctl_cache(codec, 0x1a, PIN_IN | AC_PINCTL_VREF_100);
 	}
 }
 
diff --git a/sound/sh/aica.c b/sound/sh/aica.c
index 69ac44b33560..3df531bc50ad 100644
--- a/sound/sh/aica.c
+++ b/sound/sh/aica.c
@@ -295,7 +295,8 @@ static void run_spu_dma(struct work_struct *work)
 		dreamcastcard->clicks++;
 		if (unlikely(dreamcastcard->clicks >= AICA_PERIOD_NUMBER))
 			dreamcastcard->clicks %= AICA_PERIOD_NUMBER;
-		mod_timer(&dreamcastcard->timer, jiffies + 1);
+		if (snd_pcm_running(dreamcastcard->substream))
+			mod_timer(&dreamcastcard->timer, jiffies + 1);
 	}
 }
 
@@ -307,6 +308,8 @@ static void aica_period_elapsed(struct timer_list *t)
 	/*timer function - so cannot sleep */
 	int play_period;
 	struct snd_pcm_runtime *runtime;
+	if (!snd_pcm_running(substream))
+		return;
 	runtime = substream->runtime;
 	dreamcastcard = substream->pcm->private_data;
 	/* Have we played out an additional period? */
@@ -367,12 +370,19 @@ static int snd_aicapcm_pcm_open(struct snd_pcm_substream
 	return 0;
 }
 
+static int snd_aicapcm_pcm_sync_stop(struct snd_pcm_substream *substream)
+{
+	struct snd_card_aica *dreamcastcard = substream->pcm->private_data;
+
+	del_timer_sync(&dreamcastcard->timer);
+	cancel_work_sync(&dreamcastcard->spu_dma_work);
+	return 0;
+}
+
 static int snd_aicapcm_pcm_close(struct snd_pcm_substream
 				 *substream)
 {
 	struct snd_card_aica *dreamcastcard = substream->pcm->private_data;
-	flush_work(&(dreamcastcard->spu_dma_work));
-	del_timer(&dreamcastcard->timer);
 	dreamcastcard->substream = NULL;
 	kfree(dreamcastcard->channel);
 	spu_disable();
@@ -438,6 +448,7 @@ static const struct snd_pcm_ops snd_aicapcm_playback_ops = {
 	.prepare = snd_aicapcm_pcm_prepare,
 	.trigger = snd_aicapcm_pcm_trigger,
 	.pointer = snd_aicapcm_pcm_pointer,
+	.sync_stop = snd_aicapcm_pcm_sync_stop,
 };
 
 /* TO DO: set up to handle more than one pcm instance */
diff --git a/sound/soc/soc-ops.c b/sound/soc/soc-ops.c
index e01f3bf3ef17..08ed973b2d97 100644
--- a/sound/soc/soc-ops.c
+++ b/sound/soc/soc-ops.c
@@ -252,7 +252,7 @@ int snd_soc_get_volsw(struct snd_kcontrol *kcontrol,
 	int max = mc->max;
 	int min = mc->min;
 	int sign_bit = mc->sign_bit;
-	unsigned int mask = (1 << fls(max)) - 1;
+	unsigned int mask = (1ULL << fls(max)) - 1;
 	unsigned int invert = mc->invert;
 	int val;
 	int ret;
diff --git a/tools/iio/iio_utils.c b/tools/iio/iio_utils.c
index d174487b2f22..1ef51c7e7b04 100644
--- a/tools/iio/iio_utils.c
+++ b/tools/iio/iio_utils.c
@@ -376,7 +376,7 @@ int build_channel_array(const char *device_dir,
 		goto error_close_dir;
 	}
 
-	seekdir(dp, 0);
+	rewinddir(dp);
 	while (ent = readdir(dp), ent) {
 		if (strcmp(ent->d_name + strlen(ent->d_name) - strlen("_en"),
 			   "_en") == 0) {
diff --git a/tools/power/x86/x86_energy_perf_policy/x86_energy_perf_policy.c b/tools/power/x86/x86_energy_perf_policy/x86_energy_perf_policy.c
index 2aba622d1c5a..470d03e14342 100644
--- a/tools/power/x86/x86_energy_perf_policy/x86_energy_perf_policy.c
+++ b/tools/power/x86/x86_energy_perf_policy/x86_energy_perf_policy.c
@@ -1112,6 +1112,7 @@ unsigned int get_pkg_num(int cpu)
 	retval = fscanf(fp, "%d\n", &pkg);
 	if (retval != 1)
 		errx(1, "%s: failed to parse", pathname);
+	fclose(fp);
 	return pkg;
 }
 
diff --git a/tools/testing/ktest/ktest.pl b/tools/testing/ktest/ktest.pl
index 128a7fe45a1e..a29d9e125b00 100755
--- a/tools/testing/ktest/ktest.pl
+++ b/tools/testing/ktest/ktest.pl
@@ -765,6 +765,7 @@ sub set_value {
     if ($lvalue =~ /^(TEST|BISECT|CONFIG_BISECT)_TYPE(\[.*\])?$/ &&
 	$prvalue !~ /^(config_|)bisect$/ &&
 	$prvalue !~ /^build$/ &&
+	$prvalue !~ /^make_warnings_file$/ &&
 	$buildonly) {
 
 	# Note if a test is something other than build, then we
diff --git a/tools/testing/selftests/net/reuseaddr_conflict.c b/tools/testing/selftests/net/reuseaddr_conflict.c
index 7c5b12664b03..bfb07dc49518 100644
--- a/tools/testing/selftests/net/reuseaddr_conflict.c
+++ b/tools/testing/selftests/net/reuseaddr_conflict.c
@@ -109,6 +109,6 @@ int main(void)
 	fd1 = open_port(0, 1);
 	if (fd1 >= 0)
 		error(1, 0, "Was allowed to create an ipv4 reuseport on an already bound non-reuseport socket with no ipv6");
-	fprintf(stderr, "Success");
+	fprintf(stderr, "Success\n");
 	return 0;
 }
diff --git a/virt/kvm/async_pf.c b/virt/kvm/async_pf.c
index c9861c2315e8..3e17f8c7432c 100644
--- a/virt/kvm/async_pf.c
+++ b/virt/kvm/async_pf.c
@@ -110,7 +110,27 @@ static void async_pf_execute(struct work_struct *work)
 		swake_up_one(&vcpu->wq);
 
 	mmput(mm);
-	kvm_put_kvm(vcpu->kvm);
+}
+
+static void kvm_flush_and_free_async_pf_work(struct kvm_async_pf *work)
+{
+	/*
+	 * The async #PF is "done", but KVM must wait for the work item itself,
+	 * i.e. async_pf_execute(), to run to completion.  If KVM is a module,
+	 * KVM must ensure *no* code owned by the KVM (the module) can be run
+	 * after the last call to module_put().  Note, flushing the work item
+	 * is always required when the item is taken off the completion queue.
+	 * E.g. even if the vCPU handles the item in the "normal" path, the VM
+	 * could be terminated before async_pf_execute() completes.
+	 *
+	 * Wake all events skip the queue and go straight done, i.e. don't
+	 * need to be flushed (but sanity check that the work wasn't queued).
+	 */
+	if (work->wakeup_all)
+		WARN_ON_ONCE(work->work.func);
+	else
+		flush_work(&work->work);
+	kmem_cache_free(async_pf_cache, work);
 }
 
 void kvm_clear_async_pf_completion_queue(struct kvm_vcpu *vcpu)
@@ -137,7 +157,6 @@ void kvm_clear_async_pf_completion_queue(struct kvm_vcpu *vcpu)
 #else
 		if (cancel_work_sync(&work->work)) {
 			mmput(work->mm);
-			kvm_put_kvm(vcpu->kvm); /* == work->vcpu->kvm */
 			kmem_cache_free(async_pf_cache, work);
 		}
 #endif
@@ -149,7 +168,10 @@ void kvm_clear_async_pf_completion_queue(struct kvm_vcpu *vcpu)
 			list_first_entry(&vcpu->async_pf.done,
 					 typeof(*work), link);
 		list_del(&work->link);
-		kmem_cache_free(async_pf_cache, work);
+
+		spin_unlock(&vcpu->async_pf.lock);
+		kvm_flush_and_free_async_pf_work(work);
+		spin_lock(&vcpu->async_pf.lock);
 	}
 	spin_unlock(&vcpu->async_pf.lock);
 
@@ -173,7 +195,7 @@ void kvm_check_async_pf_completion(struct kvm_vcpu *vcpu)
 
 		list_del(&work->queue);
 		vcpu->async_pf.queued--;
-		kmem_cache_free(async_pf_cache, work);
+		kvm_flush_and_free_async_pf_work(work);
 	}
 }
 
@@ -202,7 +224,6 @@ int kvm_setup_async_pf(struct kvm_vcpu *vcpu, gpa_t cr2_or_gpa,
 	work->arch = *arch;
 	work->mm = current->mm;
 	mmget(work->mm);
-	kvm_get_kvm(work->vcpu->kvm);
 
 	/* this can't really happen otherwise gfn_to_pfn_async
 	   would succeed */

