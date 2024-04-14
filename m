Return-Path: <linux-kernel+bounces-143712-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AA048A3C94
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Apr 2024 13:28:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 523D81F2228F
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Apr 2024 11:28:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 803BB5028B;
	Sat, 13 Apr 2024 11:26:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="a7uhFyoF"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED3813FE55;
	Sat, 13 Apr 2024 11:26:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713007566; cv=none; b=TXczcPDaiWWqJDcX2WPVKPyfgIesL5TeEcGlUuzBFOw531p7uYIdICmWdwbDjiFtetGMjmIyVuysoEmRmZL9J/oA2TYuC5iiD7r61Tmp9Ch/odWvJogOHLDYPlB98QNNMoy93qO8ayaRYEX4kiLFIrPyzp7hKnTpYuAc507btK8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713007566; c=relaxed/simple;
	bh=jUDFLXctANwfom7I+snngZW4ZbWVm4E1T0ZHYmT3/V8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=diyMTDwA7K9TasXHh5Ia5/hiTkslu3mlcGHvYuMyYCZBDQVrl97kzSIdi9cFj2IJYhxQUoVmDeAGl6TmwyZODTxwoa5aPTUHC1Eej/lkrtQ1V2tF8rQ81oXe/g66CO98mgILt38kLAMN/oaSShaJxztUAebu6zvxJFIkO08FeN8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=a7uhFyoF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5137DC3277B;
	Sat, 13 Apr 2024 11:26:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1713007565;
	bh=jUDFLXctANwfom7I+snngZW4ZbWVm4E1T0ZHYmT3/V8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=a7uhFyoFiHw0ZmqMD8jAqIQKtkSV+H0wNSWu90/iLl4n59O6QBLtJAyxjYgM3lJJI
	 hNz7xMUc+9t3Vwo1W2O+Wc0OAi3E31WwhRv709Lq/p+MWd3yVSeHhCS7GqIMkBQMaL
	 v/e5dWccPtyRcYXkWkN3GQBuBAjKdwR+EsOpA5Ac=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: Linux 5.10.215
Date: Sat, 13 Apr 2024 13:25:50 +0200
Message-ID: <2024041350-wanting-consensus-a097@gregkh>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <2024041350-crestless-humility-04b2@gregkh>
References: <2024041350-crestless-humility-04b2@gregkh>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

diff --git a/Documentation/ABI/testing/sysfs-devices-system-cpu b/Documentation/ABI/testing/sysfs-devices-system-cpu
index bfb4f4fada33..2a273bfebed0 100644
--- a/Documentation/ABI/testing/sysfs-devices-system-cpu
+++ b/Documentation/ABI/testing/sysfs-devices-system-cpu
@@ -507,6 +507,7 @@ What:		/sys/devices/system/cpu/vulnerabilities
 		/sys/devices/system/cpu/vulnerabilities/mds
 		/sys/devices/system/cpu/vulnerabilities/meltdown
 		/sys/devices/system/cpu/vulnerabilities/mmio_stale_data
+		/sys/devices/system/cpu/vulnerabilities/reg_file_data_sampling
 		/sys/devices/system/cpu/vulnerabilities/retbleed
 		/sys/devices/system/cpu/vulnerabilities/spec_store_bypass
 		/sys/devices/system/cpu/vulnerabilities/spectre_v1
diff --git a/Documentation/admin-guide/hw-vuln/index.rst b/Documentation/admin-guide/hw-vuln/index.rst
index 84742be223ff..e020d1637e1c 100644
--- a/Documentation/admin-guide/hw-vuln/index.rst
+++ b/Documentation/admin-guide/hw-vuln/index.rst
@@ -18,3 +18,4 @@ are configurable at compile, boot or run time.
    processor_mmio_stale_data.rst
    gather_data_sampling.rst
    srso
+   reg-file-data-sampling
diff --git a/Documentation/admin-guide/hw-vuln/reg-file-data-sampling.rst b/Documentation/admin-guide/hw-vuln/reg-file-data-sampling.rst
new file mode 100644
index 000000000000..810424b4b7f6
--- /dev/null
+++ b/Documentation/admin-guide/hw-vuln/reg-file-data-sampling.rst
@@ -0,0 +1,104 @@
+==================================
+Register File Data Sampling (RFDS)
+==================================
+
+Register File Data Sampling (RFDS) is a microarchitectural vulnerability that
+only affects Intel Atom parts(also branded as E-cores). RFDS may allow
+a malicious actor to infer data values previously used in floating point
+registers, vector registers, or integer registers. RFDS does not provide the
+ability to choose which data is inferred. CVE-2023-28746 is assigned to RFDS.
+
+Affected Processors
+===================
+Below is the list of affected Intel processors [#f1]_:
+
+   ===================  ============
+   Common name          Family_Model
+   ===================  ============
+   ATOM_GOLDMONT           06_5CH
+   ATOM_GOLDMONT_D         06_5FH
+   ATOM_GOLDMONT_PLUS      06_7AH
+   ATOM_TREMONT_D          06_86H
+   ATOM_TREMONT            06_96H
+   ALDERLAKE               06_97H
+   ALDERLAKE_L             06_9AH
+   ATOM_TREMONT_L          06_9CH
+   RAPTORLAKE              06_B7H
+   RAPTORLAKE_P            06_BAH
+   ALDERLAKE_N             06_BEH
+   RAPTORLAKE_S            06_BFH
+   ===================  ============
+
+As an exception to this table, Intel Xeon E family parts ALDERLAKE(06_97H) and
+RAPTORLAKE(06_B7H) codenamed Catlow are not affected. They are reported as
+vulnerable in Linux because they share the same family/model with an affected
+part. Unlike their affected counterparts, they do not enumerate RFDS_CLEAR or
+CPUID.HYBRID. This information could be used to distinguish between the
+affected and unaffected parts, but it is deemed not worth adding complexity as
+the reporting is fixed automatically when these parts enumerate RFDS_NO.
+
+Mitigation
+==========
+Intel released a microcode update that enables software to clear sensitive
+information using the VERW instruction. Like MDS, RFDS deploys the same
+mitigation strategy to force the CPU to clear the affected buffers before an
+attacker can extract the secrets. This is achieved by using the otherwise
+unused and obsolete VERW instruction in combination with a microcode update.
+The microcode clears the affected CPU buffers when the VERW instruction is
+executed.
+
+Mitigation points
+-----------------
+VERW is executed by the kernel before returning to user space, and by KVM
+before VMentry. None of the affected cores support SMT, so VERW is not required
+at C-state transitions.
+
+New bits in IA32_ARCH_CAPABILITIES
+----------------------------------
+Newer processors and microcode update on existing affected processors added new
+bits to IA32_ARCH_CAPABILITIES MSR. These bits can be used to enumerate
+vulnerability and mitigation capability:
+
+- Bit 27 - RFDS_NO - When set, processor is not affected by RFDS.
+- Bit 28 - RFDS_CLEAR - When set, processor is affected by RFDS, and has the
+  microcode that clears the affected buffers on VERW execution.
+
+Mitigation control on the kernel command line
+---------------------------------------------
+The kernel command line allows to control RFDS mitigation at boot time with the
+parameter "reg_file_data_sampling=". The valid arguments are:
+
+  ==========  =================================================================
+  on          If the CPU is vulnerable, enable mitigation; CPU buffer clearing
+              on exit to userspace and before entering a VM.
+  off         Disables mitigation.
+  ==========  =================================================================
+
+Mitigation default is selected by CONFIG_MITIGATION_RFDS.
+
+Mitigation status information
+-----------------------------
+The Linux kernel provides a sysfs interface to enumerate the current
+vulnerability status of the system: whether the system is vulnerable, and
+which mitigations are active. The relevant sysfs file is:
+
+	/sys/devices/system/cpu/vulnerabilities/reg_file_data_sampling
+
+The possible values in this file are:
+
+  .. list-table::
+
+     * - 'Not affected'
+       - The processor is not vulnerable
+     * - 'Vulnerable'
+       - The processor is vulnerable, but no mitigation enabled
+     * - 'Vulnerable: No microcode'
+       - The processor is vulnerable but microcode is not updated.
+     * - 'Mitigation: Clear Register File'
+       - The processor is vulnerable and the CPU buffer clearing mitigation is
+	 enabled.
+
+References
+----------
+.. [#f1] Affected Processors
+   https://www.intel.com/content/www/us/en/developer/topic-technology/software-security-guidance/processors-affected-consolidated-product-cpu-model.html
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
index f1f7c068cf65..8e4882bb8cf8 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -993,6 +993,26 @@
 			The filter can be disabled or changed to another
 			driver later using sysfs.
 
+	reg_file_data_sampling=
+			[X86] Controls mitigation for Register File Data
+			Sampling (RFDS) vulnerability. RFDS is a CPU
+			vulnerability which may allow userspace to infer
+			kernel data values previously stored in floating point
+			registers, vector registers, or integer registers.
+			RFDS only affects Intel Atom processors.
+
+			on:	Turns ON the mitigation.
+			off:	Turns OFF the mitigation.
+
+			This parameter overrides the compile time default set
+			by CONFIG_MITIGATION_RFDS. Mitigation cannot be
+			disabled when other VERW based mitigations (like MDS)
+			are enabled. In order to disable RFDS mitigation all
+			VERW based mitigations need to be disabled.
+
+			For details see:
+			Documentation/admin-guide/hw-vuln/reg-file-data-sampling.rst
+
 	driver_async_probe=  [KNL]
 			List of driver names to be probed asynchronously.
 			Format: <driver_name1>,<driver_name2>...
@@ -2919,6 +2939,7 @@
 					       nopti [X86,PPC]
 					       nospectre_v1 [X86,PPC]
 					       nospectre_v2 [X86,PPC,S390,ARM64]
+					       reg_file_data_sampling=off [X86]
 					       retbleed=off [X86]
 					       spec_store_bypass_disable=off [X86,PPC]
 					       spectre_v2_user=off [X86]
@@ -5091,9 +5112,9 @@
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
diff --git a/Documentation/block/queue-sysfs.rst b/Documentation/block/queue-sysfs.rst
index 2638d3446b79..c8bf8bc3c03a 100644
--- a/Documentation/block/queue-sysfs.rst
+++ b/Documentation/block/queue-sysfs.rst
@@ -273,4 +273,11 @@ devices are described in the ZBC (Zoned Block Commands) and ZAC
 do not support zone commands, they will be treated as regular block devices
 and zoned will report "none".
 
+zone_write_granularity (RO)
+---------------------------
+This indicates the alignment constraint, in bytes, for write operations in
+sequential zones of zoned block devices (devices with a zoned attributed
+that reports "host-managed" or "host-aware"). This value is always 0 for
+regular block devices.
+
 Jens Axboe <jens.axboe@oracle.com>, February 2009
diff --git a/Documentation/x86/mds.rst b/Documentation/x86/mds.rst
index 5d4330be200f..e801df0bb3a8 100644
--- a/Documentation/x86/mds.rst
+++ b/Documentation/x86/mds.rst
@@ -95,6 +95,9 @@ The kernel provides a function to invoke the buffer clearing:
 
     mds_clear_cpu_buffers()
 
+Also macro CLEAR_CPU_BUFFERS can be used in ASM late in exit-to-user path.
+Other than CFLAGS.ZF, this macro doesn't clobber any registers.
+
 The mitigation is invoked on kernel/userspace, hypervisor/guest and C-state
 (idle) transitions.
 
@@ -138,17 +141,30 @@ Mitigation points
 
    When transitioning from kernel to user space the CPU buffers are flushed
    on affected CPUs when the mitigation is not disabled on the kernel
-   command line. The migitation is enabled through the static key
-   mds_user_clear.
-
-   The mitigation is invoked in prepare_exit_to_usermode() which covers
-   all but one of the kernel to user space transitions.  The exception
-   is when we return from a Non Maskable Interrupt (NMI), which is
-   handled directly in do_nmi().
-
-   (The reason that NMI is special is that prepare_exit_to_usermode() can
-    enable IRQs.  In NMI context, NMIs are blocked, and we don't want to
-    enable IRQs with NMIs blocked.)
+   command line. The mitigation is enabled through the feature flag
+   X86_FEATURE_CLEAR_CPU_BUF.
+
+   The mitigation is invoked just before transitioning to userspace after
+   user registers are restored. This is done to minimize the window in
+   which kernel data could be accessed after VERW e.g. via an NMI after
+   VERW.
+
+   **Corner case not handled**
+   Interrupts returning to kernel don't clear CPUs buffers since the
+   exit-to-user path is expected to do that anyways. But, there could be
+   a case when an NMI is generated in kernel after the exit-to-user path
+   has cleared the buffers. This case is not handled and NMI returning to
+   kernel don't clear CPU buffers because:
+
+   1. It is rare to get an NMI after VERW, but before returning to userspace.
+   2. For an unprivileged user, there is no known way to make that NMI
+      less rare or target it.
+   3. It would take a large number of these precisely-timed NMIs to mount
+      an actual attack.  There's presumably not enough bandwidth.
+   4. The NMI in question occurs after a VERW, i.e. when user state is
+      restored and most interesting data is already scrubbed. Whats left
+      is only the data that NMI touches, and that may or may not be of
+      any interest.
 
 
 2. C-State transition
diff --git a/Makefile b/Makefile
index 88d4de93aed7..2af799d3ce78 100644
--- a/Makefile
+++ b/Makefile
@@ -1,7 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0
 VERSION = 5
 PATCHLEVEL = 10
-SUBLEVEL = 214
+SUBLEVEL = 215
 EXTRAVERSION =
 NAME = Dare mighty things
 
diff --git a/arch/arm/boot/dts/mmp2-brownstone.dts b/arch/arm/boot/dts/mmp2-brownstone.dts
index 04f1ae1382e7..bc64348b8218 100644
--- a/arch/arm/boot/dts/mmp2-brownstone.dts
+++ b/arch/arm/boot/dts/mmp2-brownstone.dts
@@ -28,7 +28,7 @@ &uart3 {
 &twsi1 {
 	status = "okay";
 	pmic: max8925@3c {
-		compatible = "maxium,max8925";
+		compatible = "maxim,max8925";
 		reg = <0x3c>;
 		interrupts = <1>;
 		interrupt-parent = <&intcmux4>;
diff --git a/arch/arm64/boot/dts/qcom/sc7180-trogdor.dtsi b/arch/arm64/boot/dts/qcom/sc7180-trogdor.dtsi
index cb2c47f13a8a..9ce8bfbf7ea2 100644
--- a/arch/arm64/boot/dts/qcom/sc7180-trogdor.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc7180-trogdor.dtsi
@@ -810,7 +810,8 @@ bluetooth: bluetooth {
 		vddrf-supply = <&pp1300_l2c>;
 		vddch0-supply = <&pp3300_l10c>;
 		max-speed = <3200000>;
-		clocks = <&rpmhcc RPMH_RF_CLK2>;
+
+		qcom,local-bd-address-broken;
 	};
 };
 
diff --git a/arch/arm64/boot/dts/rockchip/rk3328.dtsi b/arch/arm64/boot/dts/rockchip/rk3328.dtsi
index 72112fe05a5c..10df6636a6b6 100644
--- a/arch/arm64/boot/dts/rockchip/rk3328.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3328.dtsi
@@ -732,11 +732,20 @@ hdmi: hdmi@ff3c0000 {
 		status = "disabled";
 
 		ports {
-			hdmi_in: port {
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			hdmi_in: port@0 {
+				reg = <0>;
+
 				hdmi_in_vop: endpoint {
 					remote-endpoint = <&vop_out_hdmi>;
 				};
 			};
+
+			hdmi_out: port@1 {
+				reg = <1>;
+			};
 		};
 	};
 
diff --git a/arch/arm64/boot/dts/rockchip/rk3399.dtsi b/arch/arm64/boot/dts/rockchip/rk3399.dtsi
index 3180f576ed02..e2515218ff73 100644
--- a/arch/arm64/boot/dts/rockchip/rk3399.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3399.dtsi
@@ -1769,6 +1769,7 @@ simple-audio-card,codec {
 	hdmi: hdmi@ff940000 {
 		compatible = "rockchip,rk3399-dw-hdmi";
 		reg = <0x0 0xff940000 0x0 0x20000>;
+		reg-io-width = <4>;
 		interrupts = <GIC_SPI 23 IRQ_TYPE_LEVEL_HIGH 0>;
 		clocks = <&cru PCLK_HDMI_CTRL>,
 			 <&cru SCLK_HDMI_SFR>,
@@ -1777,13 +1778,16 @@ hdmi: hdmi@ff940000 {
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
 
@@ -1796,6 +1800,10 @@ hdmi_in_vopl: endpoint@1 {
 					remote-endpoint = <&vopl_out_hdmi>;
 				};
 			};
+
+			hdmi_out: port@1 {
+				reg = <1>;
+			};
 		};
 	};
 
diff --git a/arch/hexagon/kernel/vmlinux.lds.S b/arch/hexagon/kernel/vmlinux.lds.S
index 57465bff1fe4..df7f349c8d4f 100644
--- a/arch/hexagon/kernel/vmlinux.lds.S
+++ b/arch/hexagon/kernel/vmlinux.lds.S
@@ -64,6 +64,7 @@ SECTIONS
 	STABS_DEBUG
 	DWARF_DEBUG
 	ELF_DETAILS
+	.hexagon.attributes 0 : { *(.hexagon.attributes) }
 
 	DISCARDS
 }
diff --git a/arch/parisc/include/asm/assembly.h b/arch/parisc/include/asm/assembly.h
index a39250cb7dfc..d3f23ed570c6 100644
--- a/arch/parisc/include/asm/assembly.h
+++ b/arch/parisc/include/asm/assembly.h
@@ -83,26 +83,28 @@
 	 * version takes two arguments: a src and destination register.
 	 * However, the source and destination registers can not be
 	 * the same register.
+	 *
+	 * We use add,l to avoid clobbering the C/B bits in the PSW.
 	 */
 
 	.macro  tophys  grvirt, grphys
-	ldil    L%(__PAGE_OFFSET), \grphys
-	sub     \grvirt, \grphys, \grphys
+	ldil    L%(-__PAGE_OFFSET), \grphys
+	addl    \grvirt, \grphys, \grphys
 	.endm
-	
+
 	.macro  tovirt  grphys, grvirt
 	ldil    L%(__PAGE_OFFSET), \grvirt
-	add     \grphys, \grvirt, \grvirt
+	addl    \grphys, \grvirt, \grvirt
 	.endm
 
 	.macro  tophys_r1  gr
-	ldil    L%(__PAGE_OFFSET), %r1
-	sub     \gr, %r1, \gr
+	ldil    L%(-__PAGE_OFFSET), %r1
+	addl    \gr, %r1, \gr
 	.endm
-	
+
 	.macro  tovirt_r1  gr
 	ldil    L%(__PAGE_OFFSET), %r1
-	add     \gr, %r1, \gr
+	addl    \gr, %r1, \gr
 	.endm
 
 	.macro delay value
diff --git a/arch/parisc/include/asm/checksum.h b/arch/parisc/include/asm/checksum.h
index 3c43baca7b39..2aceebcd695c 100644
--- a/arch/parisc/include/asm/checksum.h
+++ b/arch/parisc/include/asm/checksum.h
@@ -40,7 +40,7 @@ static inline __sum16 ip_fast_csum(const void *iph, unsigned int ihl)
 "	addc		%0, %5, %0\n"
 "	addc		%0, %3, %0\n"
 "1:	ldws,ma		4(%1), %3\n"
-"	addib,<		0, %2, 1b\n"
+"	addib,>		-1, %2, 1b\n"
 "	addc		%0, %3, %0\n"
 "\n"
 "	extru		%0, 31, 16, %4\n"
@@ -126,6 +126,7 @@ static __inline__ __sum16 csum_ipv6_magic(const struct in6_addr *saddr,
 	** Try to keep 4 registers with "live" values ahead of the ALU.
 	*/
 
+"	depdi		0, 31, 32, %0\n"/* clear upper half of incoming checksum */
 "	ldd,ma		8(%1), %4\n"	/* get 1st saddr word */
 "	ldd,ma		8(%2), %5\n"	/* get 1st daddr word */
 "	add		%4, %0, %0\n"
@@ -137,8 +138,8 @@ static __inline__ __sum16 csum_ipv6_magic(const struct in6_addr *saddr,
 "	add,dc		%3, %0, %0\n"  /* fold in proto+len | carry bit */
 "	extrd,u		%0, 31, 32, %4\n"/* copy upper half down */
 "	depdi		0, 31, 32, %0\n"/* clear upper half */
-"	add		%4, %0, %0\n"	/* fold into 32-bits */
-"	addc		0, %0, %0\n"	/* add carry */
+"	add,dc		%4, %0, %0\n"	/* fold into 32-bits, plus carry */
+"	addc		0, %0, %0\n"	/* add final carry */
 
 #else
 
@@ -163,7 +164,8 @@ static __inline__ __sum16 csum_ipv6_magic(const struct in6_addr *saddr,
 "	ldw,ma		4(%2), %7\n"	/* 4th daddr */
 "	addc		%6, %0, %0\n"
 "	addc		%7, %0, %0\n"
-"	addc		%3, %0, %0\n"	/* fold in proto+len, catch carry */
+"	addc		%3, %0, %0\n"	/* fold in proto+len */
+"	addc		0, %0, %0\n"	/* add carry */
 
 #endif
 	: "=r" (sum), "=r" (saddr), "=r" (daddr), "=r" (len),
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
index 321cab5c3ea0..bd5012aa94e3 100644
--- a/arch/powerpc/lib/Makefile
+++ b/arch/powerpc/lib/Makefile
@@ -67,6 +67,6 @@ obj-$(CONFIG_PPC_LIB_RHEAP) += rheap.o
 obj-$(CONFIG_FTR_FIXUP_SELFTEST) += feature-fixups-test.o
 
 obj-$(CONFIG_ALTIVEC)	+= xor_vmx.o xor_vmx_glue.o
-CFLAGS_xor_vmx.o += -maltivec $(call cc-option,-mabi=altivec)
+CFLAGS_xor_vmx.o += -mhard-float -maltivec $(call cc-option,-mabi=altivec)
 
 obj-$(CONFIG_PPC64) += $(obj64-y)
diff --git a/arch/riscv/include/asm/uaccess.h b/arch/riscv/include/asm/uaccess.h
index 66af6abfe8af..c351231b7792 100644
--- a/arch/riscv/include/asm/uaccess.h
+++ b/arch/riscv/include/asm/uaccess.h
@@ -468,7 +468,7 @@ unsigned long __must_check clear_user(void __user *to, unsigned long n)
 
 #define __get_kernel_nofault(dst, src, type, err_label)			\
 do {									\
-	long __kr_err;							\
+	long __kr_err = 0;						\
 									\
 	__get_user_nocheck(*((type *)(dst)), (type *)(src), __kr_err);	\
 	if (unlikely(__kr_err))						\
@@ -477,7 +477,7 @@ do {									\
 
 #define __put_kernel_nofault(dst, src, type, err_label)			\
 do {									\
-	long __kr_err;							\
+	long __kr_err = 0;						\
 									\
 	__put_user_nocheck(*((type *)(src)), (type *)(dst), __kr_err);	\
 	if (unlikely(__kr_err))						\
diff --git a/arch/s390/kernel/entry.S b/arch/s390/kernel/entry.S
index 88ecbcf097a3..127a8d295ae3 100644
--- a/arch/s390/kernel/entry.S
+++ b/arch/s390/kernel/entry.S
@@ -1298,6 +1298,7 @@ ENDPROC(stack_overflow)
 
 #endif
 	.section .rodata, "a"
+	.balign	8
 #define SYSCALL(esame,emu)	.quad __s390x_ ## esame
 	.globl	sys_call_table
 sys_call_table:
diff --git a/arch/sparc/kernel/nmi.c b/arch/sparc/kernel/nmi.c
index 060fff95a305..fbf25e926f67 100644
--- a/arch/sparc/kernel/nmi.c
+++ b/arch/sparc/kernel/nmi.c
@@ -274,7 +274,7 @@ static int __init setup_nmi_watchdog(char *str)
 	if (!strncmp(str, "panic", 5))
 		panic_on_timeout = 1;
 
-	return 0;
+	return 1;
 }
 __setup("nmi_watchdog=", setup_nmi_watchdog);
 
diff --git a/arch/sparc/vdso/vma.c b/arch/sparc/vdso/vma.c
index cc19e09b0fa1..b073153c711a 100644
--- a/arch/sparc/vdso/vma.c
+++ b/arch/sparc/vdso/vma.c
@@ -449,9 +449,8 @@ static __init int vdso_setup(char *s)
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
diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 6dc670e36393..9b3fa05e4622 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -352,10 +352,6 @@ config X86_64_SMP
 	def_bool y
 	depends on X86_64 && SMP
 
-config X86_32_LAZY_GS
-	def_bool y
-	depends on X86_32 && !STACKPROTECTOR
-
 config ARCH_SUPPORTS_UPROBES
 	def_bool y
 
@@ -378,7 +374,8 @@ config CC_HAS_SANE_STACKPROTECTOR
 	default $(success,$(srctree)/scripts/gcc-x86_32-has-stack-protector.sh $(CC))
 	help
 	   We have to make sure stack protector is unconditionally disabled if
-	   the compiler produces broken code.
+	   the compiler produces broken code or if it does not let us control
+	   the segment on 32-bit kernels.
 
 menu "Processor type and features"
 
@@ -2511,6 +2508,17 @@ config GDS_FORCE_MITIGATION
 
 	  If in doubt, say N.
 
+config MITIGATION_RFDS
+	bool "RFDS Mitigation"
+	depends on CPU_SUP_INTEL
+	default y
+	help
+	  Enable mitigation for Register File Data Sampling (RFDS) by default.
+	  RFDS is a hardware vulnerability which affects Intel Atom CPUs. It
+	  allows unprivileged speculative access to stale data previously
+	  stored in floating point, vector and integer registers.
+	  See also <file:Documentation/admin-guide/hw-vuln/reg-file-data-sampling.rst>
+
 endif
 
 config ARCH_HAS_ADD_PAGES
diff --git a/arch/x86/Makefile b/arch/x86/Makefile
index 1f796050c6dd..8b9fa777f513 100644
--- a/arch/x86/Makefile
+++ b/arch/x86/Makefile
@@ -87,6 +87,14 @@ ifeq ($(CONFIG_X86_32),y)
 
         # temporary until string.h is fixed
         KBUILD_CFLAGS += -ffreestanding
+
+	ifeq ($(CONFIG_STACKPROTECTOR),y)
+		ifeq ($(CONFIG_SMP),y)
+			KBUILD_CFLAGS += -mstack-protector-guard-reg=fs -mstack-protector-guard-symbol=__stack_chk_guard
+		else
+			KBUILD_CFLAGS += -mstack-protector-guard=global
+		endif
+	endif
 else
         BITS := 64
         UTS_MACHINE := x86_64
diff --git a/arch/x86/entry/entry.S b/arch/x86/entry/entry.S
index bfb7bcb362bc..09e99d13fc0b 100644
--- a/arch/x86/entry/entry.S
+++ b/arch/x86/entry/entry.S
@@ -6,6 +6,9 @@
 #include <linux/linkage.h>
 #include <asm/export.h>
 #include <asm/msr-index.h>
+#include <asm/unwind_hints.h>
+#include <asm/segment.h>
+#include <asm/cache.h>
 
 .pushsection .noinstr.text, "ax"
 
@@ -20,3 +23,23 @@ SYM_FUNC_END(entry_ibpb)
 EXPORT_SYMBOL_GPL(entry_ibpb);
 
 .popsection
+
+/*
+ * Define the VERW operand that is disguised as entry code so that
+ * it can be referenced with KPTI enabled. This ensure VERW can be
+ * used late in exit-to-user path after page tables are switched.
+ */
+.pushsection .entry.text, "ax"
+
+.align L1_CACHE_BYTES, 0xcc
+SYM_CODE_START_NOALIGN(mds_verw_sel)
+	UNWIND_HINT_EMPTY
+	ANNOTATE_NOENDBR
+	.word __KERNEL_DS
+.align L1_CACHE_BYTES, 0xcc
+SYM_CODE_END(mds_verw_sel);
+/* For KVM */
+EXPORT_SYMBOL_GPL(mds_verw_sel);
+
+.popsection
+
diff --git a/arch/x86/entry/entry_32.S b/arch/x86/entry/entry_32.S
index 70bd81b6c612..97d422f31c77 100644
--- a/arch/x86/entry/entry_32.S
+++ b/arch/x86/entry/entry_32.S
@@ -20,7 +20,7 @@
  *	1C(%esp) - %ds
  *	20(%esp) - %es
  *	24(%esp) - %fs
- *	28(%esp) - %gs		saved iff !CONFIG_X86_32_LAZY_GS
+ *	28(%esp) - unused -- was %gs on old stackprotector kernels
  *	2C(%esp) - orig_eax
  *	30(%esp) - %eip
  *	34(%esp) - %cs
@@ -56,14 +56,9 @@
 /*
  * User gs save/restore
  *
- * %gs is used for userland TLS and kernel only uses it for stack
- * canary which is required to be at %gs:20 by gcc.  Read the comment
- * at the top of stackprotector.h for more info.
- *
- * Local labels 98 and 99 are used.
+ * This is leftover junk from CONFIG_X86_32_LAZY_GS.  A subsequent patch
+ * will remove it entirely.
  */
-#ifdef CONFIG_X86_32_LAZY_GS
-
  /* unfortunately push/pop can't be no-op */
 .macro PUSH_GS
 	pushl	$0
@@ -86,49 +81,6 @@
 .macro SET_KERNEL_GS reg
 .endm
 
-#else	/* CONFIG_X86_32_LAZY_GS */
-
-.macro PUSH_GS
-	pushl	%gs
-.endm
-
-.macro POP_GS pop=0
-98:	popl	%gs
-  .if \pop <> 0
-	add	$\pop, %esp
-  .endif
-.endm
-.macro POP_GS_EX
-.pushsection .fixup, "ax"
-99:	movl	$0, (%esp)
-	jmp	98b
-.popsection
-	_ASM_EXTABLE(98b, 99b)
-.endm
-
-.macro PTGS_TO_GS
-98:	mov	PT_GS(%esp), %gs
-.endm
-.macro PTGS_TO_GS_EX
-.pushsection .fixup, "ax"
-99:	movl	$0, PT_GS(%esp)
-	jmp	98b
-.popsection
-	_ASM_EXTABLE(98b, 99b)
-.endm
-
-.macro GS_TO_REG reg
-	movl	%gs, \reg
-.endm
-.macro REG_TO_PTGS reg
-	movl	\reg, PT_GS(%esp)
-.endm
-.macro SET_KERNEL_GS reg
-	movl	$(__KERNEL_STACK_CANARY), \reg
-	movl	\reg, %gs
-.endm
-
-#endif /* CONFIG_X86_32_LAZY_GS */
 
 /* Unconditionally switch to user cr3 */
 .macro SWITCH_TO_USER_CR3 scratch_reg:req
@@ -779,7 +731,7 @@ SYM_CODE_START(__switch_to_asm)
 
 #ifdef CONFIG_STACKPROTECTOR
 	movl	TASK_stack_canary(%edx), %ebx
-	movl	%ebx, PER_CPU_VAR(stack_canary)+stack_canary_offset
+	movl	%ebx, PER_CPU_VAR(__stack_chk_guard)
 #endif
 
 	/*
@@ -997,6 +949,7 @@ SYM_FUNC_START(entry_SYSENTER_32)
 	BUG_IF_WRONG_CR3 no_user_check=1
 	popfl
 	popl	%eax
+	CLEAR_CPU_BUFFERS
 
 	/*
 	 * Return back to the vDSO, which will pop ecx and edx.
@@ -1069,6 +1022,7 @@ restore_all_switch_stack:
 
 	/* Restore user state */
 	RESTORE_REGS pop=4			# skip orig_eax/error_code
+	CLEAR_CPU_BUFFERS
 .Lirq_return:
 	/*
 	 * ARCH_HAS_MEMBARRIER_SYNC_CORE rely on IRET core serialization
@@ -1267,6 +1221,7 @@ SYM_CODE_START(asm_exc_nmi)
 
 	/* Not on SYSENTER stack. */
 	call	exc_nmi
+	CLEAR_CPU_BUFFERS
 	jmp	.Lnmi_return
 
 .Lnmi_from_sysenter_stack:
diff --git a/arch/x86/entry/entry_64.S b/arch/x86/entry/entry_64.S
index 23212c53cef7..1631a9a1566e 100644
--- a/arch/x86/entry/entry_64.S
+++ b/arch/x86/entry/entry_64.S
@@ -615,6 +615,7 @@ SYM_INNER_LABEL(swapgs_restore_regs_and_return_to_usermode, SYM_L_GLOBAL)
 	/* Restore RDI. */
 	popq	%rdi
 	SWAPGS
+	CLEAR_CPU_BUFFERS
 	INTERRUPT_RETURN
 
 
@@ -721,6 +722,8 @@ native_irq_return_ldt:
 	 */
 	popq	%rax				/* Restore user RAX */
 
+	CLEAR_CPU_BUFFERS
+
 	/*
 	 * RSP now points to an ordinary IRET frame, except that the page
 	 * is read-only and RSP[31:16] are preloaded with the userspace
@@ -1487,6 +1490,12 @@ nmi_restore:
 	std
 	movq	$0, 5*8(%rsp)		/* clear "NMI executing" */
 
+	/*
+	 * Skip CLEAR_CPU_BUFFERS here, since it only helps in rare cases like
+	 * NMI in kernel after user state is restored. For an unprivileged user
+	 * these conditions are hard to meet.
+	 */
+
 	/*
 	 * iretq reads the "iret" frame and exits the NMI stack in a
 	 * single instruction.  We are returning to kernel mode, so this
@@ -1504,6 +1513,7 @@ SYM_CODE_END(asm_exc_nmi)
 SYM_CODE_START(ignore_sysret)
 	UNWIND_HINT_EMPTY
 	mov	$-ENOSYS, %eax
+	CLEAR_CPU_BUFFERS
 	sysretl
 SYM_CODE_END(ignore_sysret)
 #endif
diff --git a/arch/x86/entry/entry_64_compat.S b/arch/x86/entry/entry_64_compat.S
index 4d637a965efb..7f09e7ad3c74 100644
--- a/arch/x86/entry/entry_64_compat.S
+++ b/arch/x86/entry/entry_64_compat.S
@@ -319,6 +319,7 @@ sysret32_from_system_call:
 	xorl	%r9d, %r9d
 	xorl	%r10d, %r10d
 	swapgs
+	CLEAR_CPU_BUFFERS
 	sysretl
 SYM_CODE_END(entry_SYSCALL_compat)
 
diff --git a/arch/x86/include/asm/asm-prototypes.h b/arch/x86/include/asm/asm-prototypes.h
index 8f80de627c60..5cdccea45554 100644
--- a/arch/x86/include/asm/asm-prototypes.h
+++ b/arch/x86/include/asm/asm-prototypes.h
@@ -12,6 +12,7 @@
 #include <asm/special_insns.h>
 #include <asm/preempt.h>
 #include <asm/asm.h>
+#include <asm/nospec-branch.h>
 
 #ifndef CONFIG_X86_CMPXCHG64
 extern void cmpxchg8b_emu(void);
diff --git a/arch/x86/include/asm/asm.h b/arch/x86/include/asm/asm.h
index 0603c7423aca..c01005d7a4ed 100644
--- a/arch/x86/include/asm/asm.h
+++ b/arch/x86/include/asm/asm.h
@@ -6,12 +6,14 @@
 # define __ASM_FORM(x)	x
 # define __ASM_FORM_RAW(x)     x
 # define __ASM_FORM_COMMA(x) x,
+# define __ASM_REGPFX			%
 #else
 #include <linux/stringify.h>
 
 # define __ASM_FORM(x)	" " __stringify(x) " "
 # define __ASM_FORM_RAW(x)     __stringify(x)
 # define __ASM_FORM_COMMA(x) " " __stringify(x) ","
+# define __ASM_REGPFX			%%
 #endif
 
 #ifndef __x86_64__
@@ -48,6 +50,9 @@
 #define _ASM_SI		__ASM_REG(si)
 #define _ASM_DI		__ASM_REG(di)
 
+/* Adds a (%rip) suffix on 64 bits only; for immediate memory references */
+#define _ASM_RIP(x)	__ASM_SEL_RAW(x, x (__ASM_REGPFX rip))
+
 #ifndef __x86_64__
 /* 32 bit */
 
diff --git a/arch/x86/include/asm/cpufeature.h b/arch/x86/include/asm/cpufeature.h
index cc3f62f5d551..955ca6b13e35 100644
--- a/arch/x86/include/asm/cpufeature.h
+++ b/arch/x86/include/asm/cpufeature.h
@@ -33,6 +33,8 @@ enum cpuid_leafs
 	CPUID_7_EDX,
 	CPUID_8000_001F_EAX,
 	CPUID_8000_0021_EAX,
+	CPUID_LNX_5,
+	NR_CPUID_WORDS,
 };
 
 #ifdef CONFIG_X86_FEATURE_NAMES
@@ -93,8 +95,9 @@ extern const char * const x86_bug_flags[NBUGINTS*32];
 	   CHECK_BIT_IN_MASK_WORD(REQUIRED_MASK, 18, feature_bit) ||	\
 	   CHECK_BIT_IN_MASK_WORD(REQUIRED_MASK, 19, feature_bit) ||	\
 	   CHECK_BIT_IN_MASK_WORD(REQUIRED_MASK, 20, feature_bit) ||	\
+	   CHECK_BIT_IN_MASK_WORD(REQUIRED_MASK, 21, feature_bit) ||	\
 	   REQUIRED_MASK_CHECK					  ||	\
-	   BUILD_BUG_ON_ZERO(NCAPINTS != 21))
+	   BUILD_BUG_ON_ZERO(NCAPINTS != 22))
 
 #define DISABLED_MASK_BIT_SET(feature_bit)				\
 	 ( CHECK_BIT_IN_MASK_WORD(DISABLED_MASK,  0, feature_bit) ||	\
@@ -118,8 +121,9 @@ extern const char * const x86_bug_flags[NBUGINTS*32];
 	   CHECK_BIT_IN_MASK_WORD(DISABLED_MASK, 18, feature_bit) ||	\
 	   CHECK_BIT_IN_MASK_WORD(DISABLED_MASK, 19, feature_bit) ||	\
 	   CHECK_BIT_IN_MASK_WORD(DISABLED_MASK, 20, feature_bit) ||	\
+	   CHECK_BIT_IN_MASK_WORD(DISABLED_MASK, 21, feature_bit) ||	\
 	   DISABLED_MASK_CHECK					  ||	\
-	   BUILD_BUG_ON_ZERO(NCAPINTS != 21))
+	   BUILD_BUG_ON_ZERO(NCAPINTS != 22))
 
 #define cpu_has(c, bit)							\
 	(__builtin_constant_p(bit) && REQUIRED_MASK_BIT_SET(bit) ? 1 :	\
diff --git a/arch/x86/include/asm/cpufeatures.h b/arch/x86/include/asm/cpufeatures.h
index 5a54c3685a06..e1bc2bad8cff 100644
--- a/arch/x86/include/asm/cpufeatures.h
+++ b/arch/x86/include/asm/cpufeatures.h
@@ -13,7 +13,7 @@
 /*
  * Defines x86 CPU feature bits
  */
-#define NCAPINTS			21	   /* N 32-bit words worth of info */
+#define NCAPINTS			22	   /* N 32-bit words worth of info */
 #define NBUGINTS			2	   /* N 32-bit bug flags */
 
 /*
@@ -300,6 +300,7 @@
 #define X86_FEATURE_USE_IBPB_FW		(11*32+16) /* "" Use IBPB during runtime firmware calls */
 #define X86_FEATURE_RSB_VMEXIT_LITE	(11*32+17) /* "" Fill RSB on VM exit when EIBRS is enabled */
 #define X86_FEATURE_MSR_TSX_CTRL	(11*32+18) /* "" MSR IA32_TSX_CTRL (Intel) implemented */
+#define X86_FEATURE_CLEAR_CPU_BUF	(11*32+19) /* "" Clear CPU buffers using VERW */
 
 #define X86_FEATURE_SRSO		(11*32+24) /* "" AMD BTB untrain RETs */
 #define X86_FEATURE_SRSO_ALIAS		(11*32+25) /* "" AMD BTB untrain RETs through aliasing */
@@ -403,6 +404,7 @@
 #define X86_FEATURE_SEV_ES		(19*32+ 3) /* AMD Secure Encrypted Virtualization - Encrypted State */
 #define X86_FEATURE_SME_COHERENT	(19*32+10) /* "" AMD hardware-enforced cache coherency */
 
+#define X86_FEATURE_AUTOIBRS		(20*32+ 8) /* "" Automatic IBRS */
 #define X86_FEATURE_SBPB		(20*32+27) /* "" Selective Branch Prediction Barrier */
 #define X86_FEATURE_IBPB_BRTYPE		(20*32+28) /* "" MSR_PRED_CMD[IBPB] flushes all branch type predictions */
 #define X86_FEATURE_SRSO_NO		(20*32+29) /* "" CPU is not affected by SRSO */
@@ -452,4 +454,5 @@
 /* BUG word 2 */
 #define X86_BUG_SRSO			X86_BUG(1*32 + 0) /* AMD SRSO bug */
 #define X86_BUG_DIV0			X86_BUG(1*32 + 1) /* AMD DIV0 speculation bug */
+#define X86_BUG_RFDS			X86_BUG(1*32 + 2) /* CPU is vulnerable to Register File Data Sampling */
 #endif /* _ASM_X86_CPUFEATURES_H */
diff --git a/arch/x86/include/asm/disabled-features.h b/arch/x86/include/asm/disabled-features.h
index 3c24378e67be..e5f44a3e275c 100644
--- a/arch/x86/include/asm/disabled-features.h
+++ b/arch/x86/include/asm/disabled-features.h
@@ -103,6 +103,7 @@
 #define DISABLED_MASK18	0
 #define DISABLED_MASK19	0
 #define DISABLED_MASK20	0
-#define DISABLED_MASK_CHECK BUILD_BUG_ON_ZERO(NCAPINTS != 21)
+#define DISABLED_MASK21	0
+#define DISABLED_MASK_CHECK BUILD_BUG_ON_ZERO(NCAPINTS != 22)
 
 #endif /* _ASM_X86_DISABLED_FEATURES_H */
diff --git a/arch/x86/include/asm/entry-common.h b/arch/x86/include/asm/entry-common.h
index 5443851d3aa6..264ab414e9f6 100644
--- a/arch/x86/include/asm/entry-common.h
+++ b/arch/x86/include/asm/entry-common.h
@@ -77,7 +77,6 @@ static inline void arch_exit_to_user_mode_prepare(struct pt_regs *regs,
 
 static __always_inline void arch_exit_to_user_mode(void)
 {
-	mds_user_clear_cpu_buffers();
 	amd_clear_divider();
 }
 #define arch_exit_to_user_mode arch_exit_to_user_mode
diff --git a/arch/x86/include/asm/irqflags.h b/arch/x86/include/asm/irqflags.h
index 8c86edefa115..f40dea50dfbf 100644
--- a/arch/x86/include/asm/irqflags.h
+++ b/arch/x86/include/asm/irqflags.h
@@ -134,6 +134,7 @@ static __always_inline unsigned long arch_local_irq_save(void)
 #define INTERRUPT_RETURN	jmp native_iret
 #define USERGS_SYSRET64				\
 	swapgs;					\
+	CLEAR_CPU_BUFFERS;			\
 	sysretq;
 #define USERGS_SYSRET32				\
 	swapgs;					\
diff --git a/arch/x86/include/asm/msr-index.h b/arch/x86/include/asm/msr-index.h
index 7d7a3cbb8e01..52a6d43ed2f9 100644
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
 
@@ -166,6 +168,14 @@
 						 * CPU is not vulnerable to Gather
 						 * Data Sampling (GDS).
 						 */
+#define ARCH_CAP_RFDS_NO		BIT(27)	/*
+						 * Not susceptible to Register
+						 * File Data Sampling.
+						 */
+#define ARCH_CAP_RFDS_CLEAR		BIT(28)	/*
+						 * VERW clears CPU Register
+						 * File.
+						 */
 
 #define MSR_IA32_FLUSH_CMD		0x0000010b
 #define L1D_FLUSH			BIT(0)	/*
diff --git a/arch/x86/include/asm/nospec-branch.h b/arch/x86/include/asm/nospec-branch.h
index 7711ba5342a1..87e1ff064025 100644
--- a/arch/x86/include/asm/nospec-branch.h
+++ b/arch/x86/include/asm/nospec-branch.h
@@ -155,11 +155,20 @@
 .Lskip_rsb_\@:
 .endm
 
+/*
+ * The CALL to srso_alias_untrain_ret() must be patched in directly at
+ * the spot where untraining must be done, ie., srso_alias_untrain_ret()
+ * must be the target of a CALL instruction instead of indirectly
+ * jumping to a wrapper which then calls it. Therefore, this macro is
+ * called outside of __UNTRAIN_RET below, for the time being, before the
+ * kernel can support nested alternatives with arbitrary nesting.
+ */
+.macro CALL_UNTRAIN_RET
 #ifdef CONFIG_CPU_UNRET_ENTRY
-#define CALL_UNTRAIN_RET	"call entry_untrain_ret"
-#else
-#define CALL_UNTRAIN_RET	""
+	ALTERNATIVE_2 "", "call entry_untrain_ret", X86_FEATURE_UNRET, \
+		          "call srso_alias_untrain_ret", X86_FEATURE_SRSO_ALIAS
 #endif
+.endm
 
 /*
  * Mitigate RETBleed for AMD/Hygon Zen uarch. Requires KERNEL CR3 because the
@@ -176,12 +185,24 @@
 #if defined(CONFIG_CPU_UNRET_ENTRY) || defined(CONFIG_CPU_IBPB_ENTRY) || \
 	defined(CONFIG_CPU_SRSO)
 	ANNOTATE_UNRET_END
-	ALTERNATIVE_2 "",						\
-		      CALL_UNTRAIN_RET, X86_FEATURE_UNRET,		\
-		      "call entry_ibpb", X86_FEATURE_ENTRY_IBPB
+	CALL_UNTRAIN_RET
+	ALTERNATIVE "", "call entry_ibpb", X86_FEATURE_ENTRY_IBPB
 #endif
 .endm
 
+/*
+ * Macro to execute VERW instruction that mitigate transient data sampling
+ * attacks such as MDS. On affected systems a microcode update overloaded VERW
+ * instruction to also clear the CPU buffers. VERW clobbers CFLAGS.ZF.
+ *
+ * Note: Only the memory operand variant of VERW clears the CPU buffers.
+ */
+.macro CLEAR_CPU_BUFFERS
+	ALTERNATIVE "jmp .Lskip_verw_\@", "", X86_FEATURE_CLEAR_CPU_BUF
+	verw _ASM_RIP(mds_verw_sel)
+.Lskip_verw_\@:
+.endm
+
 #else /* __ASSEMBLY__ */
 
 #define ANNOTATE_RETPOLINE_SAFE					\
@@ -357,11 +378,12 @@ DECLARE_STATIC_KEY_FALSE(switch_to_cond_stibp);
 DECLARE_STATIC_KEY_FALSE(switch_mm_cond_ibpb);
 DECLARE_STATIC_KEY_FALSE(switch_mm_always_ibpb);
 
-DECLARE_STATIC_KEY_FALSE(mds_user_clear);
 DECLARE_STATIC_KEY_FALSE(mds_idle_clear);
 
 DECLARE_STATIC_KEY_FALSE(mmio_stale_data_clear);
 
+extern u16 mds_verw_sel;
+
 #include <asm/segment.h>
 
 /**
@@ -387,17 +409,6 @@ static __always_inline void mds_clear_cpu_buffers(void)
 	asm volatile("verw %[ds]" : : [ds] "m" (ds) : "cc");
 }
 
-/**
- * mds_user_clear_cpu_buffers - Mitigation for MDS and TAA vulnerability
- *
- * Clear CPU buffers if the corresponding static key is enabled
- */
-static __always_inline void mds_user_clear_cpu_buffers(void)
-{
-	if (static_branch_likely(&mds_user_clear))
-		mds_clear_cpu_buffers();
-}
-
 /**
  * mds_idle_clear_cpu_buffers - Mitigation for MDS vulnerability
  *
diff --git a/arch/x86/include/asm/processor.h b/arch/x86/include/asm/processor.h
index d7e017b0b4c3..6dc3c5f0be07 100644
--- a/arch/x86/include/asm/processor.h
+++ b/arch/x86/include/asm/processor.h
@@ -441,6 +441,9 @@ struct fixed_percpu_data {
 	 * GCC hardcodes the stack canary as %gs:40.  Since the
 	 * irq_stack is the object at %gs:0, we reserve the bottom
 	 * 48 bytes of the irq stack for the canary.
+	 *
+	 * Once we are willing to require -mstack-protector-guard-symbol=
+	 * support for x86_64 stackprotector, we can get rid of this.
 	 */
 	char		gs_base[40];
 	unsigned long	stack_canary;
@@ -461,17 +464,7 @@ extern asmlinkage void ignore_sysret(void);
 void current_save_fsgs(void);
 #else	/* X86_64 */
 #ifdef CONFIG_STACKPROTECTOR
-/*
- * Make sure stack canary segment base is cached-aligned:
- *   "For Intel Atom processors, avoid non zero segment base address
- *    that is not aligned to cache line boundary at all cost."
- * (Optim Ref Manual Assembly/Compiler Coding Rule 15.)
- */
-struct stack_canary {
-	char __pad[20];		/* canary at %gs:20 */
-	unsigned long canary;
-};
-DECLARE_PER_CPU_ALIGNED(struct stack_canary, stack_canary);
+DECLARE_PER_CPU(unsigned long, __stack_chk_guard);
 #endif
 /* Per CPU softirq stack pointer */
 DECLARE_PER_CPU(struct irq_stack *, softirq_stack_ptr);
diff --git a/arch/x86/include/asm/ptrace.h b/arch/x86/include/asm/ptrace.h
index 409f661481e1..b94f615600d5 100644
--- a/arch/x86/include/asm/ptrace.h
+++ b/arch/x86/include/asm/ptrace.h
@@ -37,7 +37,10 @@ struct pt_regs {
 	unsigned short __esh;
 	unsigned short fs;
 	unsigned short __fsh;
-	/* On interrupt, gs and __gsh store the vector number. */
+	/*
+	 * On interrupt, gs and __gsh store the vector number.  They never
+	 * store gs any more.
+	 */
 	unsigned short gs;
 	unsigned short __gsh;
 	/* On interrupt, this is the error code. */
diff --git a/arch/x86/include/asm/required-features.h b/arch/x86/include/asm/required-features.h
index 9bf60a8b9e9c..1fbe53583e95 100644
--- a/arch/x86/include/asm/required-features.h
+++ b/arch/x86/include/asm/required-features.h
@@ -103,6 +103,7 @@
 #define REQUIRED_MASK18	0
 #define REQUIRED_MASK19	0
 #define REQUIRED_MASK20	0
-#define REQUIRED_MASK_CHECK BUILD_BUG_ON_ZERO(NCAPINTS != 21)
+#define REQUIRED_MASK21	0
+#define REQUIRED_MASK_CHECK BUILD_BUG_ON_ZERO(NCAPINTS != 22)
 
 #endif /* _ASM_X86_REQUIRED_FEATURES_H */
diff --git a/arch/x86/include/asm/segment.h b/arch/x86/include/asm/segment.h
index 7fdd4facfce7..72044026eb3c 100644
--- a/arch/x86/include/asm/segment.h
+++ b/arch/x86/include/asm/segment.h
@@ -95,7 +95,7 @@
  *
  *  26 - ESPFIX small SS
  *  27 - per-cpu			[ offset to per-cpu data area ]
- *  28 - stack_canary-20		[ for stack protector ]		<=== cacheline #8
+ *  28 - unused
  *  29 - unused
  *  30 - unused
  *  31 - TSS for double fault handler
@@ -118,7 +118,6 @@
 
 #define GDT_ENTRY_ESPFIX_SS		26
 #define GDT_ENTRY_PERCPU		27
-#define GDT_ENTRY_STACK_CANARY		28
 
 #define GDT_ENTRY_DOUBLEFAULT_TSS	31
 
@@ -158,12 +157,6 @@
 # define __KERNEL_PERCPU		0
 #endif
 
-#ifdef CONFIG_STACKPROTECTOR
-# define __KERNEL_STACK_CANARY		(GDT_ENTRY_STACK_CANARY*8)
-#else
-# define __KERNEL_STACK_CANARY		0
-#endif
-
 #else /* 64-bit: */
 
 #include <asm/cache.h>
@@ -364,22 +357,15 @@ static inline void __loadsegment_fs(unsigned short value)
 	asm("mov %%" #seg ",%0":"=r" (value) : : "memory")
 
 /*
- * x86-32 user GS accessors:
+ * x86-32 user GS accessors.  This is ugly and could do with some cleaning up.
  */
 #ifdef CONFIG_X86_32
-# ifdef CONFIG_X86_32_LAZY_GS
-#  define get_user_gs(regs)		(u16)({ unsigned long v; savesegment(gs, v); v; })
-#  define set_user_gs(regs, v)		loadsegment(gs, (unsigned long)(v))
-#  define task_user_gs(tsk)		((tsk)->thread.gs)
-#  define lazy_save_gs(v)		savesegment(gs, (v))
-#  define lazy_load_gs(v)		loadsegment(gs, (v))
-# else	/* X86_32_LAZY_GS */
-#  define get_user_gs(regs)		(u16)((regs)->gs)
-#  define set_user_gs(regs, v)		do { (regs)->gs = (v); } while (0)
-#  define task_user_gs(tsk)		(task_pt_regs(tsk)->gs)
-#  define lazy_save_gs(v)		do { } while (0)
-#  define lazy_load_gs(v)		do { } while (0)
-# endif	/* X86_32_LAZY_GS */
+# define get_user_gs(regs)		(u16)({ unsigned long v; savesegment(gs, v); v; })
+# define set_user_gs(regs, v)		loadsegment(gs, (unsigned long)(v))
+# define task_user_gs(tsk)		((tsk)->thread.gs)
+# define lazy_save_gs(v)		savesegment(gs, (v))
+# define lazy_load_gs(v)		loadsegment(gs, (v))
+# define load_gs_index(v)		loadsegment(gs, (v))
 #endif	/* X86_32 */
 
 #endif /* !__ASSEMBLY__ */
diff --git a/arch/x86/include/asm/setup.h b/arch/x86/include/asm/setup.h
index 4e1757bf66a8..d65bfc293a48 100644
--- a/arch/x86/include/asm/setup.h
+++ b/arch/x86/include/asm/setup.h
@@ -49,7 +49,6 @@ extern unsigned long saved_video_mode;
 extern void reserve_standard_io_resources(void);
 extern void i386_reserve_resources(void);
 extern unsigned long __startup_64(unsigned long physaddr, struct boot_params *bp);
-extern unsigned long __startup_secondary_64(void);
 extern void startup_64_setup_env(unsigned long physbase);
 extern void early_setup_idt(void);
 extern void __init do_early_exception(struct pt_regs *regs, int trapnr);
diff --git a/arch/x86/include/asm/stackprotector.h b/arch/x86/include/asm/stackprotector.h
index 7fb482f0f25b..b6ffe58c70fa 100644
--- a/arch/x86/include/asm/stackprotector.h
+++ b/arch/x86/include/asm/stackprotector.h
@@ -5,30 +5,23 @@
  * Stack protector works by putting predefined pattern at the start of
  * the stack frame and verifying that it hasn't been overwritten when
  * returning from the function.  The pattern is called stack canary
- * and unfortunately gcc requires it to be at a fixed offset from %gs.
- * On x86_64, the offset is 40 bytes and on x86_32 20 bytes.  x86_64
- * and x86_32 use segment registers differently and thus handles this
- * requirement differently.
+ * and unfortunately gcc historically required it to be at a fixed offset
+ * from the percpu segment base.  On x86_64, the offset is 40 bytes.
  *
- * On x86_64, %gs is shared by percpu area and stack canary.  All
- * percpu symbols are zero based and %gs points to the base of percpu
- * area.  The first occupant of the percpu area is always
- * fixed_percpu_data which contains stack_canary at offset 40.  Userland
- * %gs is always saved and restored on kernel entry and exit using
- * swapgs, so stack protector doesn't add any complexity there.
+ * The same segment is shared by percpu area and stack canary.  On
+ * x86_64, percpu symbols are zero based and %gs (64-bit) points to the
+ * base of percpu area.  The first occupant of the percpu area is always
+ * fixed_percpu_data which contains stack_canary at the approproate
+ * offset.  On x86_32, the stack canary is just a regular percpu
+ * variable.
  *
- * On x86_32, it's slightly more complicated.  As in x86_64, %gs is
- * used for userland TLS.  Unfortunately, some processors are much
- * slower at loading segment registers with different value when
- * entering and leaving the kernel, so the kernel uses %fs for percpu
- * area and manages %gs lazily so that %gs is switched only when
- * necessary, usually during task switch.
+ * Putting percpu data in %fs on 32-bit is a minor optimization compared to
+ * using %gs.  Since 32-bit userspace normally has %fs == 0, we are likely
+ * to load 0 into %fs on exit to usermode, whereas with percpu data in
+ * %gs, we are likely to load a non-null %gs on return to user mode.
  *
- * As gcc requires the stack canary at %gs:20, %gs can't be managed
- * lazily if stack protector is enabled, so the kernel saves and
- * restores userland %gs on kernel entry and exit.  This behavior is
- * controlled by CONFIG_X86_32_LAZY_GS and accessors are defined in
- * system.h to hide the details.
+ * Once we are willing to require GCC 8.1 or better for 64-bit stackprotector
+ * support, we can remove some of this complexity.
  */
 
 #ifndef _ASM_STACKPROTECTOR_H
@@ -44,14 +37,6 @@
 #include <linux/random.h>
 #include <linux/sched.h>
 
-/*
- * 24 byte read-only segment initializer for stack canary.  Linker
- * can't handle the address bit shifting.  Address will be set in
- * head_32 for boot CPU and setup_per_cpu_areas() for others.
- */
-#define GDT_STACK_CANARY_INIT						\
-	[GDT_ENTRY_STACK_CANARY] = GDT_ENTRY_INIT(0x4090, 0, 0x18),
-
 /*
  * Initialize the stackprotector canary value.
  *
@@ -86,7 +71,7 @@ static __always_inline void boot_init_stack_canary(void)
 #ifdef CONFIG_X86_64
 	this_cpu_write(fixed_percpu_data.stack_canary, canary);
 #else
-	this_cpu_write(stack_canary.canary, canary);
+	this_cpu_write(__stack_chk_guard, canary);
 #endif
 }
 
@@ -95,48 +80,16 @@ static inline void cpu_init_stack_canary(int cpu, struct task_struct *idle)
 #ifdef CONFIG_X86_64
 	per_cpu(fixed_percpu_data.stack_canary, cpu) = idle->stack_canary;
 #else
-	per_cpu(stack_canary.canary, cpu) = idle->stack_canary;
-#endif
-}
-
-static inline void setup_stack_canary_segment(int cpu)
-{
-#ifdef CONFIG_X86_32
-	unsigned long canary = (unsigned long)&per_cpu(stack_canary, cpu);
-	struct desc_struct *gdt_table = get_cpu_gdt_rw(cpu);
-	struct desc_struct desc;
-
-	desc = gdt_table[GDT_ENTRY_STACK_CANARY];
-	set_desc_base(&desc, canary);
-	write_gdt_entry(gdt_table, GDT_ENTRY_STACK_CANARY, &desc, DESCTYPE_S);
-#endif
-}
-
-static inline void load_stack_canary_segment(void)
-{
-#ifdef CONFIG_X86_32
-	asm("mov %0, %%gs" : : "r" (__KERNEL_STACK_CANARY) : "memory");
+	per_cpu(__stack_chk_guard, cpu) = idle->stack_canary;
 #endif
 }
 
 #else	/* STACKPROTECTOR */
 
-#define GDT_STACK_CANARY_INIT
-
 /* dummy boot_init_stack_canary() is defined in linux/stackprotector.h */
 
-static inline void setup_stack_canary_segment(int cpu)
-{ }
-
 static inline void cpu_init_stack_canary(int cpu, struct task_struct *idle)
 { }
 
-static inline void load_stack_canary_segment(void)
-{
-#ifdef CONFIG_X86_32
-	asm volatile ("mov %0, %%gs" : : "r" (0));
-#endif
-}
-
 #endif	/* STACKPROTECTOR */
 #endif	/* _ASM_STACKPROTECTOR_H */
diff --git a/arch/x86/include/asm/suspend_32.h b/arch/x86/include/asm/suspend_32.h
index 3b97aa921543..d8416b3bf832 100644
--- a/arch/x86/include/asm/suspend_32.h
+++ b/arch/x86/include/asm/suspend_32.h
@@ -12,13 +12,6 @@
 
 /* image of the saved processor state */
 struct saved_context {
-	/*
-	 * On x86_32, all segment registers, with the possible exception of
-	 * gs, are saved at kernel entry in pt_regs.
-	 */
-#ifdef CONFIG_X86_32_LAZY_GS
-	u16 gs;
-#endif
 	unsigned long cr0, cr2, cr3, cr4;
 	u64 misc_enable;
 	struct saved_msrs saved_msrs;
@@ -29,6 +22,11 @@ struct saved_context {
 	unsigned long tr;
 	unsigned long safety;
 	unsigned long return_address;
+	/*
+	 * On x86_32, all segment registers except gs are saved at kernel
+	 * entry in pt_regs.
+	 */
+	u16 gs;
 	bool misc_enable_saved;
 } __attribute__((packed));
 
diff --git a/arch/x86/kernel/Makefile b/arch/x86/kernel/Makefile
index c06f3a961d64..fd5a2a53f41f 100644
--- a/arch/x86/kernel/Makefile
+++ b/arch/x86/kernel/Makefile
@@ -49,7 +49,6 @@ endif
 # non-deterministic coverage.
 KCOV_INSTRUMENT		:= n
 
-CFLAGS_head$(BITS).o	+= -fno-stack-protector
 CFLAGS_cc_platform.o	+= -fno-stack-protector
 
 CFLAGS_irq.o := -I $(srctree)/$(src)/../include/asm/trace
diff --git a/arch/x86/kernel/asm-offsets_32.c b/arch/x86/kernel/asm-offsets_32.c
index 6e043f295a60..2b411cd00a4e 100644
--- a/arch/x86/kernel/asm-offsets_32.c
+++ b/arch/x86/kernel/asm-offsets_32.c
@@ -53,11 +53,6 @@ void foo(void)
 	       offsetof(struct cpu_entry_area, tss.x86_tss.sp1) -
 	       offsetofend(struct cpu_entry_area, entry_stack_page.stack));
 
-#ifdef CONFIG_STACKPROTECTOR
-	BLANK();
-	OFFSET(stack_canary_offset, stack_canary, canary);
-#endif
-
 	BLANK();
 	DEFINE(EFI_svam, offsetof(efi_runtime_services_t, set_virtual_address_map));
 }
diff --git a/arch/x86/kernel/cpu/amd.c b/arch/x86/kernel/cpu/amd.c
index f29c6bed9d65..3b02cb8b0533 100644
--- a/arch/x86/kernel/cpu/amd.c
+++ b/arch/x86/kernel/cpu/amd.c
@@ -1049,11 +1049,11 @@ static bool cpu_has_zenbleed_microcode(void)
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
index d9fda0b6eb19..d6e14190cf80 100644
--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -109,9 +109,6 @@ DEFINE_STATIC_KEY_FALSE(switch_mm_cond_ibpb);
 /* Control unconditional IBPB in switch_mm() */
 DEFINE_STATIC_KEY_FALSE(switch_mm_always_ibpb);
 
-/* Control MDS CPU buffer clear before returning to user space */
-DEFINE_STATIC_KEY_FALSE(mds_user_clear);
-EXPORT_SYMBOL_GPL(mds_user_clear);
 /* Control MDS CPU buffer clear before idling (halt, mwait) */
 DEFINE_STATIC_KEY_FALSE(mds_idle_clear);
 EXPORT_SYMBOL_GPL(mds_idle_clear);
@@ -249,7 +246,7 @@ static void __init mds_select_mitigation(void)
 		if (!boot_cpu_has(X86_FEATURE_MD_CLEAR))
 			mds_mitigation = MDS_MITIGATION_VMWERV;
 
-		static_branch_enable(&mds_user_clear);
+		setup_force_cpu_cap(X86_FEATURE_CLEAR_CPU_BUF);
 
 		if (!boot_cpu_has(X86_BUG_MSBDS_ONLY) &&
 		    (mds_nosmt || cpu_mitigations_auto_nosmt()))
@@ -353,7 +350,7 @@ static void __init taa_select_mitigation(void)
 	 * For guests that can't determine whether the correct microcode is
 	 * present on host, enable the mitigation for UCODE_NEEDED as well.
 	 */
-	static_branch_enable(&mds_user_clear);
+	setup_force_cpu_cap(X86_FEATURE_CLEAR_CPU_BUF);
 
 	if (taa_nosmt || cpu_mitigations_auto_nosmt())
 		cpu_smt_disable(false);
@@ -421,7 +418,14 @@ static void __init mmio_select_mitigation(void)
 	 */
 	if (boot_cpu_has_bug(X86_BUG_MDS) || (boot_cpu_has_bug(X86_BUG_TAA) &&
 					      boot_cpu_has(X86_FEATURE_RTM)))
-		static_branch_enable(&mds_user_clear);
+		setup_force_cpu_cap(X86_FEATURE_CLEAR_CPU_BUF);
+
+	/*
+	 * X86_FEATURE_CLEAR_CPU_BUF could be enabled by other VERW based
+	 * mitigations, disable KVM-only mitigation in that case.
+	 */
+	if (boot_cpu_has(X86_FEATURE_CLEAR_CPU_BUF))
+		static_branch_disable(&mmio_stale_data_clear);
 	else
 		static_branch_enable(&mmio_stale_data_clear);
 
@@ -473,6 +477,57 @@ static int __init mmio_stale_data_parse_cmdline(char *str)
 }
 early_param("mmio_stale_data", mmio_stale_data_parse_cmdline);
 
+#undef pr_fmt
+#define pr_fmt(fmt)	"Register File Data Sampling: " fmt
+
+enum rfds_mitigations {
+	RFDS_MITIGATION_OFF,
+	RFDS_MITIGATION_VERW,
+	RFDS_MITIGATION_UCODE_NEEDED,
+};
+
+/* Default mitigation for Register File Data Sampling */
+static enum rfds_mitigations rfds_mitigation __ro_after_init =
+	IS_ENABLED(CONFIG_MITIGATION_RFDS) ? RFDS_MITIGATION_VERW : RFDS_MITIGATION_OFF;
+
+static const char * const rfds_strings[] = {
+	[RFDS_MITIGATION_OFF]			= "Vulnerable",
+	[RFDS_MITIGATION_VERW]			= "Mitigation: Clear Register File",
+	[RFDS_MITIGATION_UCODE_NEEDED]		= "Vulnerable: No microcode",
+};
+
+static void __init rfds_select_mitigation(void)
+{
+	if (!boot_cpu_has_bug(X86_BUG_RFDS) || cpu_mitigations_off()) {
+		rfds_mitigation = RFDS_MITIGATION_OFF;
+		return;
+	}
+	if (rfds_mitigation == RFDS_MITIGATION_OFF)
+		return;
+
+	if (x86_read_arch_cap_msr() & ARCH_CAP_RFDS_CLEAR)
+		setup_force_cpu_cap(X86_FEATURE_CLEAR_CPU_BUF);
+	else
+		rfds_mitigation = RFDS_MITIGATION_UCODE_NEEDED;
+}
+
+static __init int rfds_parse_cmdline(char *str)
+{
+	if (!str)
+		return -EINVAL;
+
+	if (!boot_cpu_has_bug(X86_BUG_RFDS))
+		return 0;
+
+	if (!strcmp(str, "off"))
+		rfds_mitigation = RFDS_MITIGATION_OFF;
+	else if (!strcmp(str, "on"))
+		rfds_mitigation = RFDS_MITIGATION_VERW;
+
+	return 0;
+}
+early_param("reg_file_data_sampling", rfds_parse_cmdline);
+
 #undef pr_fmt
 #define pr_fmt(fmt)     "" fmt
 
@@ -481,12 +536,12 @@ static void __init md_clear_update_mitigation(void)
 	if (cpu_mitigations_off())
 		return;
 
-	if (!static_key_enabled(&mds_user_clear))
+	if (!boot_cpu_has(X86_FEATURE_CLEAR_CPU_BUF))
 		goto out;
 
 	/*
-	 * mds_user_clear is now enabled. Update MDS, TAA and MMIO Stale Data
-	 * mitigation, if necessary.
+	 * X86_FEATURE_CLEAR_CPU_BUF is now enabled. Update MDS, TAA and MMIO
+	 * Stale Data mitigation, if necessary.
 	 */
 	if (mds_mitigation == MDS_MITIGATION_OFF &&
 	    boot_cpu_has_bug(X86_BUG_MDS)) {
@@ -498,11 +553,19 @@ static void __init md_clear_update_mitigation(void)
 		taa_mitigation = TAA_MITIGATION_VERW;
 		taa_select_mitigation();
 	}
-	if (mmio_mitigation == MMIO_MITIGATION_OFF &&
-	    boot_cpu_has_bug(X86_BUG_MMIO_STALE_DATA)) {
+	/*
+	 * MMIO_MITIGATION_OFF is not checked here so that mmio_stale_data_clear
+	 * gets updated correctly as per X86_FEATURE_CLEAR_CPU_BUF state.
+	 */
+	if (boot_cpu_has_bug(X86_BUG_MMIO_STALE_DATA)) {
 		mmio_mitigation = MMIO_MITIGATION_VERW;
 		mmio_select_mitigation();
 	}
+	if (rfds_mitigation == RFDS_MITIGATION_OFF &&
+	    boot_cpu_has_bug(X86_BUG_RFDS)) {
+		rfds_mitigation = RFDS_MITIGATION_VERW;
+		rfds_select_mitigation();
+	}
 out:
 	if (boot_cpu_has_bug(X86_BUG_MDS))
 		pr_info("MDS: %s\n", mds_strings[mds_mitigation]);
@@ -512,6 +575,8 @@ static void __init md_clear_update_mitigation(void)
 		pr_info("MMIO Stale Data: %s\n", mmio_strings[mmio_mitigation]);
 	else if (boot_cpu_has_bug(X86_BUG_MMIO_UNKNOWN))
 		pr_info("MMIO Stale Data: Unknown: No mitigations\n");
+	if (boot_cpu_has_bug(X86_BUG_RFDS))
+		pr_info("Register File Data Sampling: %s\n", rfds_strings[rfds_mitigation]);
 }
 
 static void __init md_clear_select_mitigation(void)
@@ -519,11 +584,12 @@ static void __init md_clear_select_mitigation(void)
 	mds_select_mitigation();
 	taa_select_mitigation();
 	mmio_select_mitigation();
+	rfds_select_mitigation();
 
 	/*
-	 * As MDS, TAA and MMIO Stale Data mitigations are inter-related, update
-	 * and print their mitigation after MDS, TAA and MMIO Stale Data
-	 * mitigation selection is done.
+	 * As these mitigations are inter-related and rely on VERW instruction
+	 * to clear the microarchitural buffers, update and print their status
+	 * after mitigation selection is done for each of these vulnerabilities.
 	 */
 	md_clear_update_mitigation();
 }
@@ -1251,19 +1317,21 @@ spectre_v2_user_select_mitigation(void)
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
@@ -1293,9 +1361,9 @@ static const char * const spectre_v2_strings[] = {
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
 
@@ -1364,7 +1432,7 @@ static enum spectre_v2_mitigation_cmd __init spectre_v2_parse_cmdline(void)
 	     cmd == SPECTRE_V2_CMD_EIBRS_LFENCE ||
 	     cmd == SPECTRE_V2_CMD_EIBRS_RETPOLINE) &&
 	    !boot_cpu_has(X86_FEATURE_IBRS_ENHANCED)) {
-		pr_err("%s selected but CPU doesn't have eIBRS. Switching to AUTO select\n",
+		pr_err("%s selected but CPU doesn't have Enhanced or Automatic IBRS. Switching to AUTO select\n",
 		       mitigation_options[i].option);
 		return SPECTRE_V2_CMD_AUTO;
 	}
@@ -1549,8 +1617,12 @@ static void __init spectre_v2_select_mitigation(void)
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
@@ -1634,8 +1706,8 @@ static void __init spectre_v2_select_mitigation(void)
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
@@ -2432,74 +2504,74 @@ static const char * const l1tf_vmx_states[] = {
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
 	if (!boot_cpu_has(X86_FEATURE_MSR_IA32_FEAT_CTL) ||
 	    !boot_cpu_has(X86_FEATURE_VMX))
-		return sprintf(buf, "KVM: Mitigation: VMX unsupported\n");
+		return sysfs_emit(buf, "KVM: Mitigation: VMX unsupported\n");
 	else if (!(cr4_read_shadow() & X86_CR4_VMXE))
-		return sprintf(buf, "KVM: Mitigation: VMX disabled\n");
+		return sysfs_emit(buf, "KVM: Mitigation: VMX disabled\n");
 	else if (itlb_multihit_kvm_mitigation)
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
@@ -2519,9 +2591,15 @@ static ssize_t mmio_stale_data_show_state(char *buf)
 			  sched_smt_active() ? "vulnerable" : "disabled");
 }
 
+static ssize_t rfds_show_state(char *buf)
+{
+	return sysfs_emit(buf, "%s\n", rfds_strings[rfds_mitigation]);
+}
+
 static char *stibp_state(void)
 {
-	if (spectre_v2_in_eibrs_mode(spectre_v2_enabled))
+	if (spectre_v2_in_eibrs_mode(spectre_v2_enabled) &&
+	    !boot_cpu_has(X86_FEATURE_AUTOIBRS))
 		return "";
 
 	switch (spectre_v2_user_stibp) {
@@ -2567,47 +2645,46 @@ static char *pbrsb_eibrs_state(void)
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
 	if (retbleed_mitigation == RETBLEED_MITIGATION_UNRET ||
 	    retbleed_mitigation == RETBLEED_MITIGATION_IBPB) {
-	    if (boot_cpu_data.x86_vendor != X86_VENDOR_AMD &&
-		boot_cpu_data.x86_vendor != X86_VENDOR_HYGON)
-		    return sprintf(buf, "Vulnerable: untrained return thunk / IBPB on non-AMD based uarch\n");
+		if (boot_cpu_data.x86_vendor != X86_VENDOR_AMD &&
+		    boot_cpu_data.x86_vendor != X86_VENDOR_HYGON)
+			return sysfs_emit(buf, "Vulnerable: untrained return thunk / IBPB on non-AMD based uarch\n");
 
-	    return sprintf(buf, "%s; SMT %s\n",
-			   retbleed_strings[retbleed_mitigation],
-			   !sched_smt_active() ? "disabled" :
-			   spectre_v2_user_stibp == SPECTRE_V2_USER_STRICT ||
-			   spectre_v2_user_stibp == SPECTRE_V2_USER_STRICT_PREFERRED ?
-			   "enabled with STIBP protection" : "vulnerable");
+		return sysfs_emit(buf, "%s; SMT %s\n", retbleed_strings[retbleed_mitigation],
+				  !sched_smt_active() ? "disabled" :
+				  spectre_v2_user_stibp == SPECTRE_V2_USER_STRICT ||
+				  spectre_v2_user_stibp == SPECTRE_V2_USER_STRICT_PREFERRED ?
+				  "enabled with STIBP protection" : "vulnerable");
 	}
 
-	return sprintf(buf, "%s\n", retbleed_strings[retbleed_mitigation]);
+	return sysfs_emit(buf, "%s\n", retbleed_strings[retbleed_mitigation]);
 }
 
 static ssize_t gds_show_state(char *buf)
@@ -2629,26 +2706,26 @@ static ssize_t cpu_show_common(struct device *dev, struct device_attribute *attr
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
@@ -2680,11 +2757,14 @@ static ssize_t cpu_show_common(struct device *dev, struct device_attribute *attr
 	case X86_BUG_SRSO:
 		return srso_show_state(buf);
 
+	case X86_BUG_RFDS:
+		return rfds_show_state(buf);
+
 	default:
 		break;
 	}
 
-	return sprintf(buf, "Vulnerable\n");
+	return sysfs_emit(buf, "Vulnerable\n");
 }
 
 ssize_t cpu_show_meltdown(struct device *dev, struct device_attribute *attr, char *buf)
@@ -2754,4 +2834,9 @@ ssize_t cpu_show_spec_rstack_overflow(struct device *dev, struct device_attribut
 {
 	return cpu_show_common(dev, attr, buf, X86_BUG_SRSO);
 }
+
+ssize_t cpu_show_reg_file_data_sampling(struct device *dev, struct device_attribute *attr, char *buf)
+{
+	return cpu_show_common(dev, attr, buf, X86_BUG_RFDS);
+}
 #endif
diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.c
index 4ecc6072e9a4..a496a9867f4b 100644
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -166,7 +166,6 @@ DEFINE_PER_CPU_PAGE_ALIGNED(struct gdt_page, gdt_page) = { .gdt = {
 
 	[GDT_ENTRY_ESPFIX_SS]		= GDT_ENTRY_INIT(0xc092, 0, 0xfffff),
 	[GDT_ENTRY_PERCPU]		= GDT_ENTRY_INIT(0xc092, 0, 0xfffff),
-	GDT_STACK_CANARY_INIT
 #endif
 } };
 EXPORT_PER_CPU_SYMBOL_GPL(gdt_page);
@@ -600,7 +599,6 @@ void load_percpu_segment(int cpu)
 	__loadsegment_simple(gs, 0);
 	wrmsrl(MSR_GS_BASE, cpu_kernelmode_gs_base(cpu));
 #endif
-	load_stack_canary_segment();
 }
 
 #ifdef CONFIG_X86_32
@@ -1098,8 +1096,8 @@ static const __initconst struct x86_cpu_id cpu_vuln_whitelist[] = {
 	VULNWL_AMD(0x12,	NO_MELTDOWN | NO_SSB | NO_L1TF | NO_MDS | NO_SWAPGS | NO_ITLB_MULTIHIT | NO_MMIO),
 
 	/* FAMILY_ANY must be last, otherwise 0x0f - 0x12 matches won't work */
-	VULNWL_AMD(X86_FAMILY_ANY,	NO_MELTDOWN | NO_L1TF | NO_MDS | NO_SWAPGS | NO_ITLB_MULTIHIT | NO_MMIO),
-	VULNWL_HYGON(X86_FAMILY_ANY,	NO_MELTDOWN | NO_L1TF | NO_MDS | NO_SWAPGS | NO_ITLB_MULTIHIT | NO_MMIO),
+	VULNWL_AMD(X86_FAMILY_ANY,	NO_MELTDOWN | NO_L1TF | NO_MDS | NO_SWAPGS | NO_ITLB_MULTIHIT | NO_MMIO | NO_EIBRS_PBRSB),
+	VULNWL_HYGON(X86_FAMILY_ANY,	NO_MELTDOWN | NO_L1TF | NO_MDS | NO_SWAPGS | NO_ITLB_MULTIHIT | NO_MMIO | NO_EIBRS_PBRSB),
 
 	/* Zhaoxin Family 7 */
 	VULNWL(CENTAUR,	7, X86_MODEL_ANY,	NO_SPECTRE_V2 | NO_SWAPGS | NO_MMIO),
@@ -1134,6 +1132,8 @@ static const __initconst struct x86_cpu_id cpu_vuln_whitelist[] = {
 #define SRSO		BIT(5)
 /* CPU is affected by GDS */
 #define GDS		BIT(6)
+/* CPU is affected by Register File Data Sampling */
+#define RFDS		BIT(7)
 
 static const struct x86_cpu_id cpu_vuln_blacklist[] __initconst = {
 	VULNBL_INTEL_STEPPINGS(IVYBRIDGE,	X86_STEPPING_ANY,		SRBDS),
@@ -1161,14 +1161,23 @@ static const struct x86_cpu_id cpu_vuln_blacklist[] __initconst = {
 	VULNBL_INTEL_STEPPINGS(TIGERLAKE,	X86_STEPPING_ANY,		GDS),
 	VULNBL_INTEL_STEPPINGS(LAKEFIELD,	X86_STEPPING_ANY,		MMIO | MMIO_SBDS | RETBLEED),
 	VULNBL_INTEL_STEPPINGS(ROCKETLAKE,	X86_STEPPING_ANY,		MMIO | RETBLEED | GDS),
-	VULNBL_INTEL_STEPPINGS(ATOM_TREMONT,	X86_STEPPING_ANY,		MMIO | MMIO_SBDS),
-	VULNBL_INTEL_STEPPINGS(ATOM_TREMONT_D,	X86_STEPPING_ANY,		MMIO),
-	VULNBL_INTEL_STEPPINGS(ATOM_TREMONT_L,	X86_STEPPING_ANY,		MMIO | MMIO_SBDS),
+	VULNBL_INTEL_STEPPINGS(ALDERLAKE,	X86_STEPPING_ANY,		RFDS),
+	VULNBL_INTEL_STEPPINGS(ALDERLAKE_L,	X86_STEPPING_ANY,		RFDS),
+	VULNBL_INTEL_STEPPINGS(RAPTORLAKE,	X86_STEPPING_ANY,		RFDS),
+	VULNBL_INTEL_STEPPINGS(RAPTORLAKE_P,	X86_STEPPING_ANY,		RFDS),
+	VULNBL_INTEL_STEPPINGS(RAPTORLAKE_S,	X86_STEPPING_ANY,		RFDS),
+	VULNBL_INTEL_STEPPINGS(ALDERLAKE_N,	X86_STEPPING_ANY,		RFDS),
+	VULNBL_INTEL_STEPPINGS(ATOM_TREMONT,	X86_STEPPING_ANY,		MMIO | MMIO_SBDS | RFDS),
+	VULNBL_INTEL_STEPPINGS(ATOM_TREMONT_D,	X86_STEPPING_ANY,		MMIO | RFDS),
+	VULNBL_INTEL_STEPPINGS(ATOM_TREMONT_L,	X86_STEPPING_ANY,		MMIO | MMIO_SBDS | RFDS),
+	VULNBL_INTEL_STEPPINGS(ATOM_GOLDMONT,	X86_STEPPING_ANY,		RFDS),
+	VULNBL_INTEL_STEPPINGS(ATOM_GOLDMONT_D,	X86_STEPPING_ANY,		RFDS),
+	VULNBL_INTEL_STEPPINGS(ATOM_GOLDMONT_PLUS, X86_STEPPING_ANY,		RFDS),
 
 	VULNBL_AMD(0x15, RETBLEED),
 	VULNBL_AMD(0x16, RETBLEED),
 	VULNBL_AMD(0x17, RETBLEED | SRSO),
-	VULNBL_HYGON(0x18, RETBLEED),
+	VULNBL_HYGON(0x18, RETBLEED | SRSO),
 	VULNBL_AMD(0x19, SRSO),
 	{}
 };
@@ -1197,6 +1206,24 @@ static bool arch_cap_mmio_immune(u64 ia32_cap)
 		ia32_cap & ARCH_CAP_SBDR_SSDP_NO);
 }
 
+static bool __init vulnerable_to_rfds(u64 ia32_cap)
+{
+	/* The "immunity" bit trumps everything else: */
+	if (ia32_cap & ARCH_CAP_RFDS_NO)
+		return false;
+
+	/*
+	 * VMMs set ARCH_CAP_RFDS_CLEAR for processors not in the blacklist to
+	 * indicate that mitigation is needed because guest is running on a
+	 * vulnerable hardware or may migrate to such hardware:
+	 */
+	if (ia32_cap & ARCH_CAP_RFDS_CLEAR)
+		return true;
+
+	/* Only consult the blacklist when there is no enumeration: */
+	return cpu_matches(cpu_vuln_blacklist, RFDS);
+}
+
 static void __init cpu_set_bug_bits(struct cpuinfo_x86 *c)
 {
 	u64 ia32_cap = x86_read_arch_cap_msr();
@@ -1219,8 +1246,16 @@ static void __init cpu_set_bug_bits(struct cpuinfo_x86 *c)
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
@@ -1282,11 +1317,6 @@ static void __init cpu_set_bug_bits(struct cpuinfo_x86 *c)
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
@@ -1302,6 +1332,9 @@ static void __init cpu_set_bug_bits(struct cpuinfo_x86 *c)
 			setup_force_cpu_bug(X86_BUG_SRSO);
 	}
 
+	if (vulnerable_to_rfds(ia32_cap))
+		setup_force_cpu_bug(X86_BUG_RFDS);
+
 	if (cpu_matches(cpu_vuln_whitelist, NO_MELTDOWN))
 		return;
 
@@ -1937,7 +1970,8 @@ DEFINE_PER_CPU(unsigned long, cpu_current_top_of_stack) =
 EXPORT_PER_CPU_SYMBOL(cpu_current_top_of_stack);
 
 #ifdef CONFIG_STACKPROTECTOR
-DEFINE_PER_CPU_ALIGNED(struct stack_canary, stack_canary);
+DEFINE_PER_CPU(unsigned long, __stack_chk_guard);
+EXPORT_PER_CPU_SYMBOL(__stack_chk_guard);
 #endif
 
 #endif	/* CONFIG_X86_64 */
diff --git a/arch/x86/kernel/cpu/mce/core.c b/arch/x86/kernel/cpu/mce/core.c
index 18a6ed2afca0..97ab29429093 100644
--- a/arch/x86/kernel/cpu/mce/core.c
+++ b/arch/x86/kernel/cpu/mce/core.c
@@ -2389,12 +2389,14 @@ static ssize_t set_bank(struct device *s, struct device_attribute *attr,
 		return -EINVAL;
 
 	b = &per_cpu(mce_banks_array, s->id)[bank];
-
 	if (!b->init)
 		return -ENODEV;
 
 	b->ctl = new;
+
+	mutex_lock(&mce_sysfs_mutex);
 	mce_restart();
+	mutex_unlock(&mce_sysfs_mutex);
 
 	return size;
 }
diff --git a/arch/x86/kernel/doublefault_32.c b/arch/x86/kernel/doublefault_32.c
index 759d392cbe9f..d1d49e3d536b 100644
--- a/arch/x86/kernel/doublefault_32.c
+++ b/arch/x86/kernel/doublefault_32.c
@@ -100,9 +100,7 @@ DEFINE_PER_CPU_PAGE_ALIGNED(struct doublefault_stack, doublefault_stack) = {
 		.ss		= __KERNEL_DS,
 		.ds		= __USER_DS,
 		.fs		= __KERNEL_PERCPU,
-#ifndef CONFIG_X86_32_LAZY_GS
-		.gs		= __KERNEL_STACK_CANARY,
-#endif
+		.gs		= 0,
 
 		.__cr3		= __pa_nodebug(swapper_pg_dir),
 	},
diff --git a/arch/x86/kernel/head64.c b/arch/x86/kernel/head64.c
index 8596b4dca945..2988ffd099da 100644
--- a/arch/x86/kernel/head64.c
+++ b/arch/x86/kernel/head64.c
@@ -302,15 +302,6 @@ unsigned long __head __startup_64(unsigned long physaddr,
 	return sme_get_me_mask();
 }
 
-unsigned long __startup_secondary_64(void)
-{
-	/*
-	 * Return the SME encryption mask (if SME is active) to be used as a
-	 * modifier for the initial pgdir entry programmed into CR3.
-	 */
-	return sme_get_me_mask();
-}
-
 /* Wipe all early page tables except for the kernel symbol map */
 static void __init reset_early_page_tables(void)
 {
diff --git a/arch/x86/kernel/head_32.S b/arch/x86/kernel/head_32.S
index 3f1691b89231..0359333f6bde 100644
--- a/arch/x86/kernel/head_32.S
+++ b/arch/x86/kernel/head_32.S
@@ -319,8 +319,8 @@ SYM_FUNC_START(startup_32_smp)
 	movl $(__KERNEL_PERCPU), %eax
 	movl %eax,%fs			# set this cpu's percpu
 
-	movl $(__KERNEL_STACK_CANARY),%eax
-	movl %eax,%gs
+	xorl %eax,%eax
+	movl %eax,%gs			# clear possible garbage in %gs
 
 	xorl %eax,%eax			# Clear LDT
 	lldt %ax
@@ -340,20 +340,6 @@ SYM_FUNC_END(startup_32_smp)
  */
 __INIT
 setup_once:
-#ifdef CONFIG_STACKPROTECTOR
-	/*
-	 * Configure the stack canary. The linker can't handle this by
-	 * relocation.  Manually set base address in stack canary
-	 * segment descriptor.
-	 */
-	movl $gdt_page,%eax
-	movl $stack_canary,%ecx
-	movw %cx, 8 * GDT_ENTRY_STACK_CANARY + 2(%eax)
-	shrl $16, %ecx
-	movb %cl, 8 * GDT_ENTRY_STACK_CANARY + 4(%eax)
-	movb %ch, 8 * GDT_ENTRY_STACK_CANARY + 7(%eax)
-#endif
-
 	andl $0,setup_once_ref	/* Once is enough, thanks */
 	RET
 
diff --git a/arch/x86/kernel/head_64.S b/arch/x86/kernel/head_64.S
index 0424c2a6c15b..713b1ac34639 100644
--- a/arch/x86/kernel/head_64.S
+++ b/arch/x86/kernel/head_64.S
@@ -74,6 +74,22 @@ SYM_CODE_START_NOALIGN(startup_64)
 	leaq	(__end_init_task - SIZEOF_PTREGS)(%rip), %rsp
 
 	leaq	_text(%rip), %rdi
+
+	/*
+	 * initial_gs points to initial fixed_percpu_data struct with storage for
+	 * the stack protector canary. Global pointer fixups are needed at this
+	 * stage, so apply them as is done in fixup_pointer(), and initialize %gs
+	 * such that the canary can be accessed at %gs:40 for subsequent C calls.
+	 */
+	movl	$MSR_GS_BASE, %ecx
+	movq	initial_gs(%rip), %rax
+	movq	$_text, %rdx
+	subq	%rdx, %rax
+	addq	%rdi, %rax
+	movq	%rax, %rdx
+	shrq	$32,  %rdx
+	wrmsr
+
 	pushq	%rsi
 	call	startup_64_setup_env
 	popq	%rsi
@@ -141,9 +157,11 @@ SYM_INNER_LABEL(secondary_startup_64_no_verify, SYM_L_GLOBAL)
 	 * Retrieve the modifier (SME encryption mask if SME is active) to be
 	 * added to the initial pgdir entry that will be programmed into CR3.
 	 */
-	pushq	%rsi
-	call	__startup_secondary_64
-	popq	%rsi
+#ifdef CONFIG_AMD_MEM_ENCRYPT
+	movq	sme_me_mask, %rax
+#else
+	xorq	%rax, %rax
+#endif
 
 	/* Form the CR3 value being sure to include the CR3 modifier */
 	addq	$(init_top_pgt - __START_KERNEL_map), %rax
diff --git a/arch/x86/kernel/nmi.c b/arch/x86/kernel/nmi.c
index 2ef961cf4cfc..f2e53b20df7e 100644
--- a/arch/x86/kernel/nmi.c
+++ b/arch/x86/kernel/nmi.c
@@ -519,9 +519,6 @@ DEFINE_IDTENTRY_RAW(exc_nmi)
 		write_cr2(this_cpu_read(nmi_cr2));
 	if (this_cpu_dec_return(nmi_state))
 		goto nmi_restart;
-
-	if (user_mode(regs))
-		mds_user_clear_cpu_buffers();
 }
 
 #if defined(CONFIG_X86_64) && IS_ENABLED(CONFIG_KVM_INTEL)
diff --git a/arch/x86/kernel/setup_percpu.c b/arch/x86/kernel/setup_percpu.c
index fd945ce78554..0941d2f44f2a 100644
--- a/arch/x86/kernel/setup_percpu.c
+++ b/arch/x86/kernel/setup_percpu.c
@@ -224,7 +224,6 @@ void __init setup_per_cpu_areas(void)
 		per_cpu(this_cpu_off, cpu) = per_cpu_offset(cpu);
 		per_cpu(cpu_number, cpu) = cpu;
 		setup_percpu_segment(cpu);
-		setup_stack_canary_segment(cpu);
 		/*
 		 * Copy data used in early init routines from the
 		 * initial arrays to the per cpu data areas.  These
diff --git a/arch/x86/kernel/tls.c b/arch/x86/kernel/tls.c
index 64a496a0687f..3c883e064242 100644
--- a/arch/x86/kernel/tls.c
+++ b/arch/x86/kernel/tls.c
@@ -164,17 +164,11 @@ int do_set_thread_area(struct task_struct *p, int idx,
 		savesegment(fs, sel);
 		if (sel == modified_sel)
 			loadsegment(fs, sel);
-
-		savesegment(gs, sel);
-		if (sel == modified_sel)
-			load_gs_index(sel);
 #endif
 
-#ifdef CONFIG_X86_32_LAZY_GS
 		savesegment(gs, sel);
 		if (sel == modified_sel)
-			loadsegment(gs, sel);
-#endif
+			load_gs_index(sel);
 	} else {
 #ifdef CONFIG_X86_64
 		if (p->thread.fsindex == modified_sel)
diff --git a/arch/x86/kvm/cpuid.h b/arch/x86/kvm/cpuid.h
index 1ba9313d26b9..e25853c2eb0f 100644
--- a/arch/x86/kvm/cpuid.h
+++ b/arch/x86/kvm/cpuid.h
@@ -76,10 +76,12 @@ static const struct cpuid_reg reverse_cpuid[] = {
  */
 static __always_inline void reverse_cpuid_check(unsigned int x86_leaf)
 {
+	BUILD_BUG_ON(NR_CPUID_WORDS != NCAPINTS);
 	BUILD_BUG_ON(x86_leaf == CPUID_LNX_1);
 	BUILD_BUG_ON(x86_leaf == CPUID_LNX_2);
 	BUILD_BUG_ON(x86_leaf == CPUID_LNX_3);
 	BUILD_BUG_ON(x86_leaf == CPUID_LNX_4);
+	BUILD_BUG_ON(x86_leaf == CPUID_LNX_5);
 	BUILD_BUG_ON(x86_leaf >= ARRAY_SIZE(reverse_cpuid));
 	BUILD_BUG_ON(reverse_cpuid[x86_leaf].function == 0);
 }
diff --git a/arch/x86/kvm/svm/sev.c b/arch/x86/kvm/svm/sev.c
index c2b34998c27d..52e14d6aa496 100644
--- a/arch/x86/kvm/svm/sev.c
+++ b/arch/x86/kvm/svm/sev.c
@@ -1024,20 +1024,22 @@ int svm_register_enc_region(struct kvm *kvm,
 		goto e_free;
 	}
 
-	region->uaddr = range->addr;
-	region->size = range->size;
-
-	list_add_tail(&region->list, &sev->regions_list);
-	mutex_unlock(&kvm->lock);
-
 	/*
 	 * The guest may change the memory encryption attribute from C=0 -> C=1
 	 * or vice versa for this memory range. Lets make sure caches are
 	 * flushed to ensure that guest data gets written into memory with
-	 * correct C-bit.
+	 * correct C-bit.  Note, this must be done before dropping kvm->lock,
+	 * as region and its array of pages can be freed by a different task
+	 * once kvm->lock is released.
 	 */
 	sev_clflush_pages(region->pages, region->npages);
 
+	region->uaddr = range->addr;
+	region->size = range->size;
+
+	list_add_tail(&region->list, &sev->regions_list);
+	mutex_unlock(&kvm->lock);
+
 	return ret;
 
 e_free:
diff --git a/arch/x86/kvm/vmx/run_flags.h b/arch/x86/kvm/vmx/run_flags.h
index edc3f16cc189..6a9bfdfbb6e5 100644
--- a/arch/x86/kvm/vmx/run_flags.h
+++ b/arch/x86/kvm/vmx/run_flags.h
@@ -2,7 +2,10 @@
 #ifndef __KVM_X86_VMX_RUN_FLAGS_H
 #define __KVM_X86_VMX_RUN_FLAGS_H
 
-#define VMX_RUN_VMRESUME	(1 << 0)
-#define VMX_RUN_SAVE_SPEC_CTRL	(1 << 1)
+#define VMX_RUN_VMRESUME_SHIFT		0
+#define VMX_RUN_SAVE_SPEC_CTRL_SHIFT	1
+
+#define VMX_RUN_VMRESUME		BIT(VMX_RUN_VMRESUME_SHIFT)
+#define VMX_RUN_SAVE_SPEC_CTRL		BIT(VMX_RUN_SAVE_SPEC_CTRL_SHIFT)
 
 #endif /* __KVM_X86_VMX_RUN_FLAGS_H */
diff --git a/arch/x86/kvm/vmx/vmenter.S b/arch/x86/kvm/vmx/vmenter.S
index 982138bebb70..7a4b999d5701 100644
--- a/arch/x86/kvm/vmx/vmenter.S
+++ b/arch/x86/kvm/vmx/vmenter.S
@@ -77,7 +77,7 @@ SYM_FUNC_START(__vmx_vcpu_run)
 	mov (%_ASM_SP), %_ASM_AX
 
 	/* Check if vmlaunch or vmresume is needed */
-	testb $VMX_RUN_VMRESUME, %bl
+	bt   $VMX_RUN_VMRESUME_SHIFT, %bx
 
 	/* Load guest registers.  Don't clobber flags. */
 	mov VCPU_RCX(%_ASM_AX), %_ASM_CX
@@ -99,8 +99,11 @@ SYM_FUNC_START(__vmx_vcpu_run)
 	/* Load guest RAX.  This kills the @regs pointer! */
 	mov VCPU_RAX(%_ASM_AX), %_ASM_AX
 
-	/* Check EFLAGS.ZF from 'testb' above */
-	jz .Lvmlaunch
+	/* Clobbers EFLAGS.ZF */
+	CLEAR_CPU_BUFFERS
+
+	/* Check EFLAGS.CF from the VMX_RUN_VMRESUME bit test above. */
+	jnc .Lvmlaunch
 
 	/*
 	 * After a successful VMRESUME/VMLAUNCH, control flow "magically"
diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
index 2445c6103895..3e9bb9ae836d 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -397,7 +397,8 @@ static __always_inline void vmx_enable_fb_clear(struct vcpu_vmx *vmx)
 
 static void vmx_update_fb_clear_dis(struct kvm_vcpu *vcpu, struct vcpu_vmx *vmx)
 {
-	vmx->disable_fb_clear = vmx_fb_clear_ctrl_available;
+	vmx->disable_fb_clear = !cpu_feature_enabled(X86_FEATURE_CLEAR_CPU_BUF) &&
+		vmx_fb_clear_ctrl_available;
 
 	/*
 	 * If guest will not execute VERW, there is no need to set FB_CLEAR_DIS
@@ -6792,11 +6793,14 @@ static noinstr void vmx_vcpu_enter_exit(struct kvm_vcpu *vcpu,
 	guest_enter_irqoff();
 	lockdep_hardirqs_on(CALLER_ADDR0);
 
-	/* L1D Flush includes CPU buffer clear to mitigate MDS */
+	/*
+	 * L1D Flush includes CPU buffer clear to mitigate MDS, but VERW
+	 * mitigation for MDS is done late in VMentry and is still
+	 * executed in spite of L1D Flush. This is because an extra VERW
+	 * should not matter much after the big hammer L1D Flush.
+	 */
 	if (static_branch_unlikely(&vmx_l1d_should_flush))
 		vmx_l1d_flush(vcpu);
-	else if (static_branch_unlikely(&mds_user_clear))
-		mds_clear_cpu_buffers();
 	else if (static_branch_unlikely(&mmio_stale_data_clear) &&
 		 kvm_arch_has_assigned_device(vcpu->kvm))
 		mds_clear_cpu_buffers();
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 6c2bf7cd7aec..8e0b957c6219 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -1389,7 +1389,8 @@ static unsigned int num_msr_based_features;
 	 ARCH_CAP_SKIP_VMENTRY_L1DFLUSH | ARCH_CAP_SSB_NO | ARCH_CAP_MDS_NO | \
 	 ARCH_CAP_PSCHANGE_MC_NO | ARCH_CAP_TSX_CTRL_MSR | ARCH_CAP_TAA_NO | \
 	 ARCH_CAP_SBDR_SSDP_NO | ARCH_CAP_FBSDP_NO | ARCH_CAP_PSDP_NO | \
-	 ARCH_CAP_FB_CLEAR | ARCH_CAP_RRSBA | ARCH_CAP_PBRSB_NO | ARCH_CAP_GDS_NO)
+	 ARCH_CAP_FB_CLEAR | ARCH_CAP_RRSBA | ARCH_CAP_PBRSB_NO | ARCH_CAP_GDS_NO | \
+	 ARCH_CAP_RFDS_NO | ARCH_CAP_RFDS_CLEAR)
 
 static u64 kvm_get_arch_capabilities(void)
 {
@@ -1426,6 +1427,8 @@ static u64 kvm_get_arch_capabilities(void)
 		data |= ARCH_CAP_SSB_NO;
 	if (!boot_cpu_has_bug(X86_BUG_MDS))
 		data |= ARCH_CAP_MDS_NO;
+	if (!boot_cpu_has_bug(X86_BUG_RFDS))
+		data |= ARCH_CAP_RFDS_NO;
 
 	if (!boot_cpu_has(X86_FEATURE_RTM)) {
 		/*
diff --git a/arch/x86/lib/insn-eval.c b/arch/x86/lib/insn-eval.c
index ffc8b7dcf1fe..6ed542e310ad 100644
--- a/arch/x86/lib/insn-eval.c
+++ b/arch/x86/lib/insn-eval.c
@@ -404,10 +404,6 @@ static short get_segment_selector(struct pt_regs *regs, int seg_reg_idx)
 	case INAT_SEG_REG_FS:
 		return (unsigned short)(regs->fs & 0xffff);
 	case INAT_SEG_REG_GS:
-		/*
-		 * GS may or may not be in regs as per CONFIG_X86_32_LAZY_GS.
-		 * The macro below takes care of both cases.
-		 */
 		return get_user_gs(regs);
 	case INAT_SEG_REG_IGNORE:
 	default:
diff --git a/arch/x86/lib/retpoline.S b/arch/x86/lib/retpoline.S
index 6f5321b36dbb..ab9b047790dd 100644
--- a/arch/x86/lib/retpoline.S
+++ b/arch/x86/lib/retpoline.S
@@ -108,6 +108,7 @@ SYM_START(srso_alias_untrain_ret, SYM_L_GLOBAL, SYM_A_NONE)
 	ret
 	int3
 SYM_FUNC_END(srso_alias_untrain_ret)
+__EXPORT_THUNK(srso_alias_untrain_ret)
 #endif
 
 SYM_START(srso_alias_safe_ret, SYM_L_GLOBAL, SYM_A_NONE)
@@ -249,9 +250,7 @@ SYM_CODE_START(srso_return_thunk)
 SYM_CODE_END(srso_return_thunk)
 
 SYM_FUNC_START(entry_untrain_ret)
-	ALTERNATIVE_2 "jmp retbleed_untrain_ret", \
-		      "jmp srso_untrain_ret", X86_FEATURE_SRSO, \
-		      "jmp srso_alias_untrain_ret", X86_FEATURE_SRSO_ALIAS
+	ALTERNATIVE "jmp retbleed_untrain_ret", "jmp srso_untrain_ret", X86_FEATURE_SRSO
 SYM_FUNC_END(entry_untrain_ret)
 __EXPORT_THUNK(entry_untrain_ret)
 
@@ -259,6 +258,7 @@ SYM_CODE_START(__x86_return_thunk)
 	UNWIND_HINT_FUNC
 	ANNOTATE_NOENDBR
 	ANNOTATE_UNRET_SAFE
+	ANNOTATE_NOENDBR
 	ret
 	int3
 SYM_CODE_END(__x86_return_thunk)
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
diff --git a/arch/x86/mm/pat/memtype.c b/arch/x86/mm/pat/memtype.c
index f9c53a710740..adc76b4133ab 100644
--- a/arch/x86/mm/pat/memtype.c
+++ b/arch/x86/mm/pat/memtype.c
@@ -56,6 +56,7 @@
 
 #include "memtype.h"
 #include "../mm_internal.h"
+#include "../../../mm/internal.h"	/* is_cow_mapping() */
 
 #undef pr_fmt
 #define pr_fmt(fmt) "" fmt
@@ -987,6 +988,38 @@ static void free_pfn_range(u64 paddr, unsigned long size)
 		memtype_free(paddr, paddr + size);
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
@@ -997,20 +1030,13 @@ static void free_pfn_range(u64 paddr, unsigned long size)
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
 
@@ -1085,7 +1111,6 @@ void untrack_pfn(struct vm_area_struct *vma, unsigned long pfn,
 		 unsigned long size)
 {
 	resource_size_t paddr;
-	unsigned long prot;
 
 	if (vma && !(vma->vm_flags & VM_PAT))
 		return;
@@ -1093,11 +1118,8 @@ void untrack_pfn(struct vm_area_struct *vma, unsigned long pfn,
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
diff --git a/arch/x86/platform/pvh/head.S b/arch/x86/platform/pvh/head.S
index 43b4d864817e..afbf0bb252da 100644
--- a/arch/x86/platform/pvh/head.S
+++ b/arch/x86/platform/pvh/head.S
@@ -45,10 +45,8 @@
 
 #define PVH_GDT_ENTRY_CS	1
 #define PVH_GDT_ENTRY_DS	2
-#define PVH_GDT_ENTRY_CANARY	3
 #define PVH_CS_SEL		(PVH_GDT_ENTRY_CS * 8)
 #define PVH_DS_SEL		(PVH_GDT_ENTRY_DS * 8)
-#define PVH_CANARY_SEL		(PVH_GDT_ENTRY_CANARY * 8)
 
 SYM_CODE_START_LOCAL(pvh_start_xen)
 	cld
@@ -109,17 +107,6 @@ SYM_CODE_START_LOCAL(pvh_start_xen)
 
 #else /* CONFIG_X86_64 */
 
-	/* Set base address in stack canary descriptor. */
-	movl $_pa(gdt_start),%eax
-	movl $_pa(canary),%ecx
-	movw %cx, (PVH_GDT_ENTRY_CANARY * 8) + 2(%eax)
-	shrl $16, %ecx
-	movb %cl, (PVH_GDT_ENTRY_CANARY * 8) + 4(%eax)
-	movb %ch, (PVH_GDT_ENTRY_CANARY * 8) + 7(%eax)
-
-	mov $PVH_CANARY_SEL,%eax
-	mov %eax,%gs
-
 	call mk_early_pgtbl_32
 
 	mov $_pa(initial_page_table), %eax
@@ -163,7 +150,6 @@ SYM_DATA_START_LOCAL(gdt_start)
 	.quad GDT_ENTRY(0xc09a, 0, 0xfffff) /* PVH_CS_SEL */
 #endif
 	.quad GDT_ENTRY(0xc092, 0, 0xfffff) /* PVH_DS_SEL */
-	.quad GDT_ENTRY(0x4090, 0, 0x18)    /* PVH_CANARY_SEL */
 SYM_DATA_END_LABEL(gdt_start, SYM_L_LOCAL, gdt_end)
 
 	.balign 16
diff --git a/arch/x86/power/cpu.c b/arch/x86/power/cpu.c
index 4e4e76ecd3ec..84c7b2312ea9 100644
--- a/arch/x86/power/cpu.c
+++ b/arch/x86/power/cpu.c
@@ -101,11 +101,8 @@ static void __save_processor_state(struct saved_context *ctxt)
 	/*
 	 * segment registers
 	 */
-#ifdef CONFIG_X86_32_LAZY_GS
 	savesegment(gs, ctxt->gs);
-#endif
 #ifdef CONFIG_X86_64
-	savesegment(gs, ctxt->gs);
 	savesegment(fs, ctxt->fs);
 	savesegment(ds, ctxt->ds);
 	savesegment(es, ctxt->es);
@@ -234,7 +231,6 @@ static void notrace __restore_processor_state(struct saved_context *ctxt)
 	wrmsrl(MSR_GS_BASE, ctxt->kernelmode_gs_base);
 #else
 	loadsegment(fs, __KERNEL_PERCPU);
-	loadsegment(gs, __KERNEL_STACK_CANARY);
 #endif
 
 	/* Restore the TSS, RO GDT, LDT, and usermode-relevant MSRs. */
@@ -257,7 +253,7 @@ static void notrace __restore_processor_state(struct saved_context *ctxt)
 	 */
 	wrmsrl(MSR_FS_BASE, ctxt->fs_base);
 	wrmsrl(MSR_KERNEL_GS_BASE, ctxt->usermode_gs_base);
-#elif defined(CONFIG_X86_32_LAZY_GS)
+#else
 	loadsegment(gs, ctxt->gs);
 #endif
 
diff --git a/arch/x86/xen/enlighten_pv.c b/arch/x86/xen/enlighten_pv.c
index 815030b7f6fa..94804670caab 100644
--- a/arch/x86/xen/enlighten_pv.c
+++ b/arch/x86/xen/enlighten_pv.c
@@ -1193,7 +1193,6 @@ static void __init xen_setup_gdt(int cpu)
 	pv_ops.cpu.write_gdt_entry = xen_write_gdt_entry_boot;
 	pv_ops.cpu.load_gdt = xen_load_gdt_boot;
 
-	setup_stack_canary_segment(cpu);
 	switch_to_new_gdt(cpu);
 
 	pv_ops.cpu.write_gdt_entry = xen_write_gdt_entry;
diff --git a/block/blk-settings.c b/block/blk-settings.c
index c3aa7f8ee388..ebd373469c80 100644
--- a/block/blk-settings.c
+++ b/block/blk-settings.c
@@ -60,6 +60,7 @@ void blk_set_default_limits(struct queue_limits *lim)
 	lim->io_opt = 0;
 	lim->misaligned = 0;
 	lim->zoned = BLK_ZONED_NONE;
+	lim->zone_write_granularity = 0;
 }
 EXPORT_SYMBOL(blk_set_default_limits);
 
@@ -353,6 +354,28 @@ void blk_queue_physical_block_size(struct request_queue *q, unsigned int size)
 }
 EXPORT_SYMBOL(blk_queue_physical_block_size);
 
+/**
+ * blk_queue_zone_write_granularity - set zone write granularity for the queue
+ * @q:  the request queue for the zoned device
+ * @size:  the zone write granularity size, in bytes
+ *
+ * Description:
+ *   This should be set to the lowest possible size allowing to write in
+ *   sequential zones of a zoned block device.
+ */
+void blk_queue_zone_write_granularity(struct request_queue *q,
+				      unsigned int size)
+{
+	if (WARN_ON_ONCE(!blk_queue_is_zoned(q)))
+		return;
+
+	q->limits.zone_write_granularity = size;
+
+	if (q->limits.zone_write_granularity < q->limits.logical_block_size)
+		q->limits.zone_write_granularity = q->limits.logical_block_size;
+}
+EXPORT_SYMBOL_GPL(blk_queue_zone_write_granularity);
+
 /**
  * blk_queue_alignment_offset - set physical block alignment offset
  * @q:	the request queue for the device
@@ -630,7 +653,13 @@ int blk_stack_limits(struct queue_limits *t, struct queue_limits *b,
 			t->discard_granularity;
 	}
 
+	t->zone_write_granularity = max(t->zone_write_granularity,
+					b->zone_write_granularity);
 	t->zoned = max(t->zoned, b->zoned);
+	if (!t->zoned) {
+		t->zone_write_granularity = 0;
+		t->max_zone_append_sectors = 0;
+	}
 	return ret;
 }
 EXPORT_SYMBOL(blk_stack_limits);
@@ -846,6 +875,8 @@ EXPORT_SYMBOL_GPL(blk_queue_can_use_dma_map_merging);
  */
 void blk_queue_set_zoned(struct gendisk *disk, enum blk_zoned_model model)
 {
+	struct request_queue *q = disk->queue;
+
 	switch (model) {
 	case BLK_ZONED_HM:
 		/*
@@ -874,7 +905,15 @@ void blk_queue_set_zoned(struct gendisk *disk, enum blk_zoned_model model)
 		break;
 	}
 
-	disk->queue->limits.zoned = model;
+	q->limits.zoned = model;
+	if (model != BLK_ZONED_NONE) {
+		/*
+		 * Set the zone write granularity to the device logical block
+		 * size by default. The driver can change this value if needed.
+		 */
+		blk_queue_zone_write_granularity(q,
+						queue_logical_block_size(q));
+	}
 }
 EXPORT_SYMBOL_GPL(blk_queue_set_zoned);
 
diff --git a/block/blk-stat.c b/block/blk-stat.c
index ae3dd1fb8e61..6e602f9b966e 100644
--- a/block/blk-stat.c
+++ b/block/blk-stat.c
@@ -28,7 +28,7 @@ void blk_rq_stat_init(struct blk_rq_stat *stat)
 /* src is a per-cpu stat, mean isn't initialized */
 void blk_rq_stat_sum(struct blk_rq_stat *dst, struct blk_rq_stat *src)
 {
-	if (!src->nr_samples)
+	if (dst->nr_samples + src->nr_samples <= dst->nr_samples)
 		return;
 
 	dst->min = min(dst->min, src->min);
diff --git a/block/blk-sysfs.c b/block/blk-sysfs.c
index 9174137a913c..ddf23bf3e0f1 100644
--- a/block/blk-sysfs.c
+++ b/block/blk-sysfs.c
@@ -219,6 +219,12 @@ static ssize_t queue_write_zeroes_max_show(struct request_queue *q, char *page)
 		(unsigned long long)q->limits.max_write_zeroes_sectors << 9);
 }
 
+static ssize_t queue_zone_write_granularity_show(struct request_queue *q,
+						 char *page)
+{
+	return queue_var_show(queue_zone_write_granularity(q), page);
+}
+
 static ssize_t queue_zone_append_max_show(struct request_queue *q, char *page)
 {
 	unsigned long long max_sectors = q->limits.max_zone_append_sectors;
@@ -585,6 +591,7 @@ QUEUE_RO_ENTRY(queue_discard_zeroes_data, "discard_zeroes_data");
 QUEUE_RO_ENTRY(queue_write_same_max, "write_same_max_bytes");
 QUEUE_RO_ENTRY(queue_write_zeroes_max, "write_zeroes_max_bytes");
 QUEUE_RO_ENTRY(queue_zone_append_max, "zone_append_max_bytes");
+QUEUE_RO_ENTRY(queue_zone_write_granularity, "zone_write_granularity");
 
 QUEUE_RO_ENTRY(queue_zoned, "zoned");
 QUEUE_RO_ENTRY(queue_nr_zones, "nr_zones");
@@ -639,6 +646,7 @@ static struct attribute *queue_attrs[] = {
 	&queue_write_same_max_entry.attr,
 	&queue_write_zeroes_max_entry.attr,
 	&queue_zone_append_max_entry.attr,
+	&queue_zone_write_granularity_entry.attr,
 	&queue_nonrot_entry.attr,
 	&queue_zoned_entry.attr,
 	&queue_nr_zones_entry.attr,
diff --git a/block/ioctl.c b/block/ioctl.c
index 24f8042f12b6..bc97698e0e8a 100644
--- a/block/ioctl.c
+++ b/block/ioctl.c
@@ -17,7 +17,7 @@ static int blkpg_do_ioctl(struct block_device *bdev,
 			  struct blkpg_partition __user *upart, int op)
 {
 	struct blkpg_partition p;
-	long long start, length;
+	sector_t start, length;
 
 	if (!capable(CAP_SYS_ADMIN))
 		return -EACCES;
@@ -32,6 +32,12 @@ static int blkpg_do_ioctl(struct block_device *bdev,
 	if (op == BLKPG_DEL_PARTITION)
 		return bdev_del_partition(bdev, p.pno);
 
+	if (p.start < 0 || p.length <= 0 || p.start + p.length < 0)
+		return -EINVAL;
+	/* Check that the partition is aligned to the block size */
+	if (!IS_ALIGNED(p.start | p.length, bdev_logical_block_size(bdev)))
+		return -EINVAL;
+
 	start = p.start >> SECTOR_SHIFT;
 	length = p.length >> SECTOR_SHIFT;
 
@@ -46,9 +52,6 @@ static int blkpg_do_ioctl(struct block_device *bdev,
 
 	switch (op) {
 	case BLKPG_ADD_PARTITION:
-		/* check if partition is aligned to blocksize */
-		if (p.start & (bdev_logical_block_size(bdev) - 1))
-			return -EINVAL;
 		return bdev_add_partition(bdev, p.pno, start, length);
 	case BLKPG_RESIZE_PARTITION:
 		return bdev_resize_partition(bdev, p.pno, start, length);
diff --git a/drivers/accessibility/speakup/synth.c b/drivers/accessibility/speakup/synth.c
index ac47dbac7207..82cfc5ec6bdf 100644
--- a/drivers/accessibility/speakup/synth.c
+++ b/drivers/accessibility/speakup/synth.c
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
diff --git a/drivers/acpi/acpica/dbnames.c b/drivers/acpi/acpica/dbnames.c
index b91155ea9c34..c9131259f717 100644
--- a/drivers/acpi/acpica/dbnames.c
+++ b/drivers/acpi/acpica/dbnames.c
@@ -550,8 +550,12 @@ acpi_db_walk_for_fields(acpi_handle obj_handle,
 	ACPI_FREE(buffer.pointer);
 
 	buffer.length = ACPI_ALLOCATE_LOCAL_BUFFER;
-	acpi_evaluate_object(obj_handle, NULL, NULL, &buffer);
-
+	status = acpi_evaluate_object(obj_handle, NULL, NULL, &buffer);
+	if (ACPI_FAILURE(status)) {
+		acpi_os_printf("Could Not evaluate object %p\n",
+			       obj_handle);
+		return (AE_OK);
+	}
 	/*
 	 * Since this is a field unit, surround the output in braces
 	 */
diff --git a/drivers/acpi/sleep.c b/drivers/acpi/sleep.c
index 097a5b5f46ab..e79c004ca0b2 100644
--- a/drivers/acpi/sleep.c
+++ b/drivers/acpi/sleep.c
@@ -385,18 +385,6 @@ static const struct dmi_system_id acpisleep_dmi_table[] __initconst = {
 		DMI_MATCH(DMI_PRODUCT_NAME, "20GGA00L00"),
 		},
 	},
-	/*
-	 * ASUS B1400CEAE hangs on resume from suspend (see
-	 * https://bugzilla.kernel.org/show_bug.cgi?id=215742).
-	 */
-	{
-	.callback = init_default_s3,
-	.ident = "ASUS B1400CEAE",
-	.matches = {
-		DMI_MATCH(DMI_SYS_VENDOR, "ASUSTeK COMPUTER INC."),
-		DMI_MATCH(DMI_PRODUCT_NAME, "ASUS EXPERTBOOK B1400CEAE"),
-		},
-	},
 	{},
 };
 
diff --git a/drivers/ata/ahci.c b/drivers/ata/ahci.c
index 6f7f8e41404d..55a07dbe1d8a 100644
--- a/drivers/ata/ahci.c
+++ b/drivers/ata/ahci.c
@@ -662,11 +662,6 @@ MODULE_PARM_DESC(mobile_lpm_policy, "Default LPM policy for mobile chipsets");
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
index 11be88f70690..cede4b517646 100644
--- a/drivers/ata/sata_mv.c
+++ b/drivers/ata/sata_mv.c
@@ -783,37 +783,6 @@ static const struct ata_port_info mv_port_info[] = {
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
@@ -4307,6 +4276,36 @@ static int mv_pci_init_one(struct pci_dev *pdev,
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
@@ -4319,6 +4318,7 @@ static struct pci_driver mv_pci_driver = {
 #endif
 
 };
+MODULE_DEVICE_TABLE(pci, mv_pci_tbl);
 
 /**
  *      mv_print_info - Dump key info to kernel log for perusal.
@@ -4491,7 +4491,6 @@ static void __exit mv_exit(void)
 MODULE_AUTHOR("Brett Russ");
 MODULE_DESCRIPTION("SCSI low-level driver for Marvell SATA controllers");
 MODULE_LICENSE("GPL v2");
-MODULE_DEVICE_TABLE(pci, mv_pci_tbl);
 MODULE_VERSION(DRV_VERSION);
 MODULE_ALIAS("platform:" DRV_NAME);
 
diff --git a/drivers/ata/sata_sx4.c b/drivers/ata/sata_sx4.c
index 4c01190a5e37..c95685f693a6 100644
--- a/drivers/ata/sata_sx4.c
+++ b/drivers/ata/sata_sx4.c
@@ -1004,8 +1004,7 @@ static void pdc20621_get_from_dimm(struct ata_host *host, void *psource,
 
 	offset -= (idx * window_size);
 	idx++;
-	dist = ((long) (window_size - (offset + size))) >= 0 ? size :
-		(long) (window_size - offset);
+	dist = min(size, window_size - offset);
 	memcpy_fromio(psource, dimm_mmio + offset / 4, dist);
 
 	psource += dist;
@@ -1053,8 +1052,7 @@ static void pdc20621_put_to_dimm(struct ata_host *host, void *psource,
 	readl(mmio + PDC_DIMM_WINDOW_CTLR);
 	offset -= (idx * window_size);
 	idx++;
-	dist = ((long)(s32)(window_size - (offset + size))) >= 0 ? size :
-		(long) (window_size - offset);
+	dist = min(size, window_size - offset);
 	memcpy_toio(dimm_mmio + offset / 4, psource, dist);
 	writel(0x01, mmio + PDC_GENERAL_CTLR);
 	readl(mmio + PDC_GENERAL_CTLR);
diff --git a/drivers/base/core.c b/drivers/base/core.c
index d98cab88c38a..2c978941b488 100644
--- a/drivers/base/core.c
+++ b/drivers/base/core.c
@@ -53,6 +53,7 @@ static unsigned int defer_sync_state_count = 1;
 static unsigned int defer_fw_devlink_count;
 static LIST_HEAD(deferred_fw_devlink);
 static DEFINE_MUTEX(defer_fw_devlink_lock);
+static struct workqueue_struct *device_link_wq;
 static bool fw_devlink_is_permissive(void);
 
 #ifdef CONFIG_SRCU
@@ -364,12 +365,26 @@ static void devlink_dev_release(struct device *dev)
 	/*
 	 * It may take a while to complete this work because of the SRCU
 	 * synchronization in device_link_release_fn() and if the consumer or
-	 * supplier devices get deleted when it runs, so put it into the "long"
-	 * workqueue.
+	 * supplier devices get deleted when it runs, so put it into the
+	 * dedicated workqueue.
 	 */
-	queue_work(system_long_wq, &link->rm_work);
+	queue_work(device_link_wq, &link->rm_work);
 }
 
+/**
+ * device_link_wait_removal - Wait for ongoing devlink removal jobs to terminate
+ */
+void device_link_wait_removal(void)
+{
+	/*
+	 * devlink removal jobs are queued in the dedicated work queue.
+	 * To be sure that all removal jobs are terminated, ensure that any
+	 * scheduled work has run to completion.
+	 */
+	flush_workqueue(device_link_wq);
+}
+EXPORT_SYMBOL_GPL(device_link_wait_removal);
+
 static struct class devlink_class = {
 	.name = "devlink",
 	.owner = THIS_MODULE,
@@ -3415,9 +3430,14 @@ int __init devices_init(void)
 	sysfs_dev_char_kobj = kobject_create_and_add("char", dev_kobj);
 	if (!sysfs_dev_char_kobj)
 		goto char_kobj_err;
+	device_link_wq = alloc_workqueue("device_link_wq", 0, 0);
+	if (!device_link_wq)
+		goto wq_err;
 
 	return 0;
 
+ wq_err:
+	kobject_put(sysfs_dev_char_kobj);
  char_kobj_err:
 	kobject_put(sysfs_dev_block_kobj);
  block_kobj_err:
diff --git a/drivers/base/cpu.c b/drivers/base/cpu.c
index 2db1e0e8c1a7..e3aed8333f09 100644
--- a/drivers/base/cpu.c
+++ b/drivers/base/cpu.c
@@ -591,6 +591,12 @@ ssize_t __weak cpu_show_spec_rstack_overflow(struct device *dev,
 	return sysfs_emit(buf, "Not affected\n");
 }
 
+ssize_t __weak cpu_show_reg_file_data_sampling(struct device *dev,
+					       struct device_attribute *attr, char *buf)
+{
+	return sysfs_emit(buf, "Not affected\n");
+}
+
 static DEVICE_ATTR(meltdown, 0444, cpu_show_meltdown, NULL);
 static DEVICE_ATTR(spectre_v1, 0444, cpu_show_spectre_v1, NULL);
 static DEVICE_ATTR(spectre_v2, 0444, cpu_show_spectre_v2, NULL);
@@ -604,6 +610,7 @@ static DEVICE_ATTR(mmio_stale_data, 0444, cpu_show_mmio_stale_data, NULL);
 static DEVICE_ATTR(retbleed, 0444, cpu_show_retbleed, NULL);
 static DEVICE_ATTR(gather_data_sampling, 0444, cpu_show_gds, NULL);
 static DEVICE_ATTR(spec_rstack_overflow, 0444, cpu_show_spec_rstack_overflow, NULL);
+static DEVICE_ATTR(reg_file_data_sampling, 0444, cpu_show_reg_file_data_sampling, NULL);
 
 static struct attribute *cpu_root_vulnerabilities_attrs[] = {
 	&dev_attr_meltdown.attr,
@@ -619,6 +626,7 @@ static struct attribute *cpu_root_vulnerabilities_attrs[] = {
 	&dev_attr_retbleed.attr,
 	&dev_attr_gather_data_sampling.attr,
 	&dev_attr_spec_rstack_overflow.attr,
+	&dev_attr_reg_file_data_sampling.attr,
 	NULL
 };
 
diff --git a/drivers/base/power/wakeirq.c b/drivers/base/power/wakeirq.c
index aea690c64e39..4f4310724fee 100644
--- a/drivers/base/power/wakeirq.c
+++ b/drivers/base/power/wakeirq.c
@@ -365,8 +365,10 @@ void dev_pm_enable_wake_irq_complete(struct device *dev)
 		return;
 
 	if (wirq->status & WAKE_IRQ_DEDICATED_MANAGED &&
-	    wirq->status & WAKE_IRQ_DEDICATED_REVERSE)
+	    wirq->status & WAKE_IRQ_DEDICATED_REVERSE) {
 		enable_irq(wirq->irq);
+		wirq->status |= WAKE_IRQ_DEDICATED_ENABLED;
+	}
 }
 
 /**
diff --git a/drivers/bluetooth/btintel.c b/drivers/bluetooth/btintel.c
index 88ce5f0ffc4b..2538bdee31d8 100644
--- a/drivers/bluetooth/btintel.c
+++ b/drivers/bluetooth/btintel.c
@@ -350,7 +350,7 @@ int btintel_read_version(struct hci_dev *hdev, struct intel_version *ver)
 		return PTR_ERR(skb);
 	}
 
-	if (skb->len != sizeof(*ver)) {
+	if (!skb || skb->len != sizeof(*ver)) {
 		bt_dev_err(hdev, "Intel version event size mismatch");
 		kfree_skb(skb);
 		return -EILSEQ;
diff --git a/drivers/clk/qcom/gcc-ipq6018.c b/drivers/clk/qcom/gcc-ipq6018.c
index 4c5c7a8f41d0..b9844e41cf99 100644
--- a/drivers/clk/qcom/gcc-ipq6018.c
+++ b/drivers/clk/qcom/gcc-ipq6018.c
@@ -1557,6 +1557,7 @@ static struct clk_regmap_div nss_ubi0_div_clk_src = {
 
 static const struct freq_tbl ftbl_pcie_aux_clk_src[] = {
 	F(24000000, P_XO, 1, 0, 0),
+	{ }
 };
 
 static const struct clk_parent_data gcc_xo_gpll0_core_pi_sleep_clk[] = {
@@ -1737,6 +1738,7 @@ static const struct freq_tbl ftbl_sdcc_ice_core_clk_src[] = {
 	F(160000000, P_GPLL0, 5, 0, 0),
 	F(216000000, P_GPLL6, 5, 0, 0),
 	F(308570000, P_GPLL6, 3.5, 0, 0),
+	{ }
 };
 
 static const struct clk_parent_data gcc_xo_gpll0_gpll6_gpll0_div2[] = {
diff --git a/drivers/clk/qcom/gcc-ipq8074.c b/drivers/clk/qcom/gcc-ipq8074.c
index 0393154fea2f..649e75a41f7a 100644
--- a/drivers/clk/qcom/gcc-ipq8074.c
+++ b/drivers/clk/qcom/gcc-ipq8074.c
@@ -972,6 +972,7 @@ static struct clk_rcg2 pcie0_axi_clk_src = {
 
 static const struct freq_tbl ftbl_pcie_aux_clk_src[] = {
 	F(19200000, P_XO, 1, 0, 0),
+	{ }
 };
 
 static struct clk_rcg2 pcie0_aux_clk_src = {
@@ -1077,6 +1078,7 @@ static const struct freq_tbl ftbl_sdcc_ice_core_clk_src[] = {
 	F(19200000, P_XO, 1, 0, 0),
 	F(160000000, P_GPLL0, 5, 0, 0),
 	F(308570000, P_GPLL6, 3.5, 0, 0),
+	{ }
 };
 
 static struct clk_rcg2 sdcc1_ice_core_clk_src = {
diff --git a/drivers/clk/qcom/gcc-sdm845.c b/drivers/clk/qcom/gcc-sdm845.c
index 90f7febaf528..a6b07aa8eb65 100644
--- a/drivers/clk/qcom/gcc-sdm845.c
+++ b/drivers/clk/qcom/gcc-sdm845.c
@@ -3646,3 +3646,4 @@ module_exit(gcc_sdm845_exit);
 MODULE_DESCRIPTION("QTI GCC SDM845 Driver");
 MODULE_LICENSE("GPL v2");
 MODULE_ALIAS("platform:gcc-sdm845");
+MODULE_SOFTDEP("pre: rpmhpd");
diff --git a/drivers/clk/qcom/mmcc-apq8084.c b/drivers/clk/qcom/mmcc-apq8084.c
index fbfcf0006739..c2fd0e8f4bc0 100644
--- a/drivers/clk/qcom/mmcc-apq8084.c
+++ b/drivers/clk/qcom/mmcc-apq8084.c
@@ -333,6 +333,7 @@ static struct freq_tbl ftbl_mmss_axi_clk[] = {
 	F(333430000, P_MMPLL1, 3.5, 0, 0),
 	F(400000000, P_MMPLL0, 2, 0, 0),
 	F(466800000, P_MMPLL1, 2.5, 0, 0),
+	{ }
 };
 
 static struct clk_rcg2 mmss_axi_clk_src = {
@@ -357,6 +358,7 @@ static struct freq_tbl ftbl_ocmemnoc_clk[] = {
 	F(150000000, P_GPLL0, 4, 0, 0),
 	F(228570000, P_MMPLL0, 3.5, 0, 0),
 	F(320000000, P_MMPLL0, 2.5, 0, 0),
+	{ }
 };
 
 static struct clk_rcg2 ocmemnoc_clk_src = {
diff --git a/drivers/clk/qcom/mmcc-msm8974.c b/drivers/clk/qcom/mmcc-msm8974.c
index 015426262d08..dfc377463a7a 100644
--- a/drivers/clk/qcom/mmcc-msm8974.c
+++ b/drivers/clk/qcom/mmcc-msm8974.c
@@ -283,6 +283,7 @@ static struct freq_tbl ftbl_mmss_axi_clk[] = {
 	F(291750000, P_MMPLL1, 4, 0, 0),
 	F(400000000, P_MMPLL0, 2, 0, 0),
 	F(466800000, P_MMPLL1, 2.5, 0, 0),
+	{ }
 };
 
 static struct clk_rcg2 mmss_axi_clk_src = {
@@ -307,6 +308,7 @@ static struct freq_tbl ftbl_ocmemnoc_clk[] = {
 	F(150000000, P_GPLL0, 4, 0, 0),
 	F(291750000, P_MMPLL1, 4, 0, 0),
 	F(400000000, P_MMPLL0, 2, 0, 0),
+	{ }
 };
 
 static struct clk_rcg2 ocmemnoc_clk_src = {
diff --git a/drivers/cpufreq/brcmstb-avs-cpufreq.c b/drivers/cpufreq/brcmstb-avs-cpufreq.c
index 38ec0fedb247..552db816ed22 100644
--- a/drivers/cpufreq/brcmstb-avs-cpufreq.c
+++ b/drivers/cpufreq/brcmstb-avs-cpufreq.c
@@ -481,10 +481,11 @@ static bool brcm_avs_is_firmware_loaded(struct private_data *priv)
 static unsigned int brcm_avs_cpufreq_get(unsigned int cpu)
 {
 	struct cpufreq_policy *policy = cpufreq_cpu_get(cpu);
+	struct private_data *priv;
+
 	if (!policy)
 		return 0;
-	struct private_data *priv = policy->driver_data;
-
+	priv = policy->driver_data;
 	cpufreq_cpu_put(policy);
 
 	return brcm_avs_get_frequency(priv->base);
diff --git a/drivers/cpufreq/cpufreq-dt.c b/drivers/cpufreq/cpufreq-dt.c
index e363ae04aac6..44cc596ca0a5 100644
--- a/drivers/cpufreq/cpufreq-dt.c
+++ b/drivers/cpufreq/cpufreq-dt.c
@@ -251,7 +251,7 @@ static int dt_cpufreq_early_init(struct device *dev, int cpu)
 	if (!priv)
 		return -ENOMEM;
 
-	if (!alloc_cpumask_var(&priv->cpus, GFP_KERNEL))
+	if (!zalloc_cpumask_var(&priv->cpus, GFP_KERNEL))
 		return -ENOMEM;
 
 	priv->cpu_dev = cpu_dev;
diff --git a/drivers/crypto/qat/qat_common/adf_aer.c b/drivers/crypto/qat/qat_common/adf_aer.c
index d2ae293d0df6..dc0feedf5270 100644
--- a/drivers/crypto/qat/qat_common/adf_aer.c
+++ b/drivers/crypto/qat/qat_common/adf_aer.c
@@ -95,18 +95,28 @@ static void adf_device_reset_worker(struct work_struct *work)
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
@@ -139,8 +149,9 @@ static int adf_dev_aer_schedule_reset(struct adf_accel_dev *accel_dev,
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
index cae590bd08f2..eaed1ddcc803 100644
--- a/drivers/firmware/efi/vars.c
+++ b/drivers/firmware/efi/vars.c
@@ -415,7 +415,7 @@ int efivar_init(int (*func)(efi_char16_t *, efi_guid_t, unsigned long, void *),
 		void *data, bool duplicates, struct list_head *head)
 {
 	const struct efivar_operations *ops;
-	unsigned long variable_name_size = 1024;
+	unsigned long variable_name_size = 512;
 	efi_char16_t *variable_name;
 	efi_status_t status;
 	efi_guid_t vendor_guid;
@@ -438,12 +438,13 @@ int efivar_init(int (*func)(efi_char16_t *, efi_guid_t, unsigned long, void *),
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
@@ -491,9 +492,13 @@ int efivar_init(int (*func)(efi_char16_t *, efi_guid_t, unsigned long, void *),
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
index 8cc51cec988a..799a91a064a1 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
@@ -959,8 +959,8 @@ static int kfd_ioctl_get_process_apertures_new(struct file *filp,
 	 * nodes, but not more than args->num_of_nodes as that is
 	 * the amount of memory allocated by user
 	 */
-	pa = kzalloc((sizeof(struct kfd_process_device_apertures) *
-				args->num_of_nodes), GFP_KERNEL);
+	pa = kcalloc(args->num_of_nodes, sizeof(struct kfd_process_device_apertures),
+		     GFP_KERNEL);
 	if (!pa)
 		return -ENOMEM;
 
diff --git a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_hwseq.c b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_hwseq.c
index 22c77e96f6a5..02d22f62c003 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_hwseq.c
@@ -641,10 +641,20 @@ void dcn30_set_avmute(struct pipe_ctx *pipe_ctx, bool enable)
 	if (pipe_ctx == NULL)
 		return;
 
-	if (dc_is_hdmi_tmds_signal(pipe_ctx->stream->signal) && pipe_ctx->stream_res.stream_enc != NULL)
+	if (dc_is_hdmi_tmds_signal(pipe_ctx->stream->signal) && pipe_ctx->stream_res.stream_enc != NULL) {
 		pipe_ctx->stream_res.stream_enc->funcs->set_avmute(
 				pipe_ctx->stream_res.stream_enc,
 				enable);
+
+		/* Wait for two frame to make sure AV mute is sent out */
+		if (enable) {
+			pipe_ctx->stream_res.tg->funcs->wait_for_state(pipe_ctx->stream_res.tg, CRTC_STATE_VACTIVE);
+			pipe_ctx->stream_res.tg->funcs->wait_for_state(pipe_ctx->stream_res.tg, CRTC_STATE_VBLANK);
+			pipe_ctx->stream_res.tg->funcs->wait_for_state(pipe_ctx->stream_res.tg, CRTC_STATE_VACTIVE);
+			pipe_ctx->stream_res.tg->funcs->wait_for_state(pipe_ctx->stream_res.tg, CRTC_STATE_VBLANK);
+			pipe_ctx->stream_res.tg->funcs->wait_for_state(pipe_ctx->stream_res.tg, CRTC_STATE_VACTIVE);
+		}
+	}
 }
 
 void dcn30_update_info_frame(struct pipe_ctx *pipe_ctx)
diff --git a/drivers/gpu/drm/amd/display/modules/hdcp/hdcp_psp.c b/drivers/gpu/drm/amd/display/modules/hdcp/hdcp_psp.c
index 972f2600f967..05d96fa68135 100644
--- a/drivers/gpu/drm/amd/display/modules/hdcp/hdcp_psp.c
+++ b/drivers/gpu/drm/amd/display/modules/hdcp/hdcp_psp.c
@@ -405,6 +405,9 @@ enum mod_hdcp_status mod_hdcp_hdcp2_create_session(struct mod_hdcp *hdcp)
 	hdcp_cmd = (struct ta_hdcp_shared_memory *)psp->hdcp_context.hdcp_shared_buf;
 	memset(hdcp_cmd, 0, sizeof(struct ta_hdcp_shared_memory));
 
+	if (!display)
+		return MOD_HDCP_STATUS_DISPLAY_NOT_FOUND;
+
 	hdcp_cmd->in_msg.hdcp2_create_session_v2.display_handle = display->index;
 
 	if (hdcp->connection.link.adjust.hdcp2.force_type == MOD_HDCP_FORCE_TYPE_0)
diff --git a/drivers/gpu/drm/amd/display/modules/inc/mod_stats.h b/drivers/gpu/drm/amd/display/modules/inc/mod_stats.h
index 4220fd8fdd60..54cd86060f4d 100644
--- a/drivers/gpu/drm/amd/display/modules/inc/mod_stats.h
+++ b/drivers/gpu/drm/amd/display/modules/inc/mod_stats.h
@@ -57,10 +57,10 @@ void mod_stats_update_event(struct mod_stats *mod_stats,
 		unsigned int length);
 
 void mod_stats_update_flip(struct mod_stats *mod_stats,
-		unsigned long timestamp_in_ns);
+		unsigned long long timestamp_in_ns);
 
 void mod_stats_update_vupdate(struct mod_stats *mod_stats,
-		unsigned long timestamp_in_ns);
+		unsigned long long timestamp_in_ns);
 
 void mod_stats_update_freesync(struct mod_stats *mod_stats,
 		unsigned int v_total_min,
diff --git a/drivers/gpu/drm/drm_panel.c b/drivers/gpu/drm/drm_panel.c
index f634371c717a..7fd3de89ed07 100644
--- a/drivers/gpu/drm/drm_panel.c
+++ b/drivers/gpu/drm/drm_panel.c
@@ -207,19 +207,24 @@ EXPORT_SYMBOL(drm_panel_disable);
  * The modes probed from the panel are automatically added to the connector
  * that the panel is attached to.
  *
- * Return: The number of modes available from the panel on success or a
- * negative error code on failure.
+ * Return: The number of modes available from the panel on success, or 0 on
+ * failure (no modes).
  */
 int drm_panel_get_modes(struct drm_panel *panel,
 			struct drm_connector *connector)
 {
 	if (!panel)
-		return -EINVAL;
+		return 0;
 
-	if (panel->funcs && panel->funcs->get_modes)
-		return panel->funcs->get_modes(panel, connector);
+	if (panel->funcs && panel->funcs->get_modes) {
+		int num;
 
-	return -EOPNOTSUPP;
+		num = panel->funcs->get_modes(panel, connector);
+		if (num > 0)
+			return num;
+	}
+
+	return 0;
 }
 EXPORT_SYMBOL(drm_panel_get_modes);
 
diff --git a/drivers/gpu/drm/etnaviv/etnaviv_drv.c b/drivers/gpu/drm/etnaviv/etnaviv_drv.c
index a9a3afaef9a1..edf9387069cd 100644
--- a/drivers/gpu/drm/etnaviv/etnaviv_drv.c
+++ b/drivers/gpu/drm/etnaviv/etnaviv_drv.c
@@ -511,7 +511,7 @@ static struct drm_driver etnaviv_drm_driver = {
 	.desc               = "etnaviv DRM",
 	.date               = "20151214",
 	.major              = 1,
-	.minor              = 3,
+	.minor              = 4,
 };
 
 /*
diff --git a/drivers/gpu/drm/etnaviv/etnaviv_hwdb.c b/drivers/gpu/drm/etnaviv/etnaviv_hwdb.c
index 167971a09be7..e9b777ab3be7 100644
--- a/drivers/gpu/drm/etnaviv/etnaviv_hwdb.c
+++ b/drivers/gpu/drm/etnaviv/etnaviv_hwdb.c
@@ -73,6 +73,9 @@ static const struct etnaviv_chip_identity etnaviv_chip_identities[] = {
 bool etnaviv_fill_identity_from_hwdb(struct etnaviv_gpu *gpu)
 {
 	struct etnaviv_chip_identity *ident = &gpu->identity;
+	const u32 product_id = ident->product_id;
+	const u32 customer_id = ident->customer_id;
+	const u32 eco_id = ident->eco_id;
 	int i;
 
 	for (i = 0; i < ARRAY_SIZE(etnaviv_chip_identities); i++) {
@@ -86,6 +89,12 @@ bool etnaviv_fill_identity_from_hwdb(struct etnaviv_gpu *gpu)
 			 etnaviv_chip_identities[i].eco_id == ~0U)) {
 			memcpy(ident, &etnaviv_chip_identities[i],
 			       sizeof(*ident));
+
+			/* Restore some id values as ~0U aka 'don't care' might been used. */
+			ident->product_id = product_id;
+			ident->customer_id = customer_id;
+			ident->eco_id = eco_id;
+
 			return true;
 		}
 	}
diff --git a/drivers/gpu/drm/exynos/exynos_drm_vidi.c b/drivers/gpu/drm/exynos/exynos_drm_vidi.c
index e96436e11a36..e1ffe8a28b64 100644
--- a/drivers/gpu/drm/exynos/exynos_drm_vidi.c
+++ b/drivers/gpu/drm/exynos/exynos_drm_vidi.c
@@ -315,14 +315,14 @@ static int vidi_get_modes(struct drm_connector *connector)
 	 */
 	if (!ctx->raw_edid) {
 		DRM_DEV_DEBUG_KMS(ctx->dev, "raw_edid is null.\n");
-		return -EFAULT;
+		return 0;
 	}
 
 	edid_len = (1 + ctx->raw_edid->extensions) * EDID_LENGTH;
 	edid = kmemdup(ctx->raw_edid, edid_len, GFP_KERNEL);
 	if (!edid) {
 		DRM_DEV_DEBUG_KMS(ctx->dev, "failed to allocate edid\n");
-		return -ENOMEM;
+		return 0;
 	}
 
 	drm_connector_update_edid_property(connector, edid);
diff --git a/drivers/gpu/drm/exynos/exynos_hdmi.c b/drivers/gpu/drm/exynos/exynos_hdmi.c
index 981bffacda24..576fcf180716 100644
--- a/drivers/gpu/drm/exynos/exynos_hdmi.c
+++ b/drivers/gpu/drm/exynos/exynos_hdmi.c
@@ -878,11 +878,11 @@ static int hdmi_get_modes(struct drm_connector *connector)
 	int ret;
 
 	if (!hdata->ddc_adpt)
-		return -ENODEV;
+		return 0;
 
 	edid = drm_get_edid(connector, hdata->ddc_adpt);
 	if (!edid)
-		return -ENODEV;
+		return 0;
 
 	hdata->dvi_mode = !drm_detect_hdmi_monitor(edid);
 	DRM_DEV_DEBUG_KMS(hdata->dev, "%s : width[%d] x height[%d]\n",
diff --git a/drivers/gpu/drm/i915/gt/intel_engine_pm.c b/drivers/gpu/drm/i915/gt/intel_engine_pm.c
index f7b2e07e2229..f9fdbd79c0f3 100644
--- a/drivers/gpu/drm/i915/gt/intel_engine_pm.c
+++ b/drivers/gpu/drm/i915/gt/intel_engine_pm.c
@@ -250,9 +250,6 @@ static int __engine_park(struct intel_wakeref *wf)
 	intel_engine_park_heartbeat(engine);
 	intel_breadcrumbs_park(engine->breadcrumbs);
 
-	/* Must be reset upon idling, or we may miss the busy wakeup. */
-	GEM_BUG_ON(engine->execlists.queue_priority_hint != INT_MIN);
-
 	if (engine->park)
 		engine->park(engine);
 
diff --git a/drivers/gpu/drm/i915/gt/intel_lrc.c b/drivers/gpu/drm/i915/gt/intel_lrc.c
index ee9b33c3aff8..5a414d989dca 100644
--- a/drivers/gpu/drm/i915/gt/intel_lrc.c
+++ b/drivers/gpu/drm/i915/gt/intel_lrc.c
@@ -5032,6 +5032,9 @@ static void execlists_park(struct intel_engine_cs *engine)
 {
 	cancel_timer(&engine->execlists.timer);
 	cancel_timer(&engine->execlists.preempt);
+
+	/* Reset upon idling, or we may delay the busy wakeup. */
+	WRITE_ONCE(engine->execlists.queue_priority_hint, INT_MIN);
 }
 
 void intel_execlists_set_default_submission(struct intel_engine_cs *engine)
diff --git a/drivers/gpu/drm/imx/parallel-display.c b/drivers/gpu/drm/imx/parallel-display.c
index b61bfa84b6bb..bcd6b9ee8eea 100644
--- a/drivers/gpu/drm/imx/parallel-display.c
+++ b/drivers/gpu/drm/imx/parallel-display.c
@@ -65,14 +65,14 @@ static int imx_pd_connector_get_modes(struct drm_connector *connector)
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
diff --git a/drivers/gpu/drm/ttm/ttm_memory.c b/drivers/gpu/drm/ttm/ttm_memory.c
index 89d50f38c0f2..5af52012fc5c 100644
--- a/drivers/gpu/drm/ttm/ttm_memory.c
+++ b/drivers/gpu/drm/ttm/ttm_memory.c
@@ -431,8 +431,10 @@ int ttm_mem_global_init(struct ttm_mem_global *glob)
 
 	si_meminfo(&si);
 
+	spin_lock(&glob->lock);
 	/* set it as 0 by default to keep original behavior of OOM */
 	glob->lower_mem_limit = 0;
+	spin_unlock(&glob->lock);
 
 	ret = ttm_mem_init_kernel_zone(glob, &si);
 	if (unlikely(ret != 0))
diff --git a/drivers/gpu/drm/vc4/vc4_hdmi.c b/drivers/gpu/drm/vc4/vc4_hdmi.c
index 7e8620838de9..6d01258349fa 100644
--- a/drivers/gpu/drm/vc4/vc4_hdmi.c
+++ b/drivers/gpu/drm/vc4/vc4_hdmi.c
@@ -197,7 +197,7 @@ static int vc4_hdmi_connector_get_modes(struct drm_connector *connector)
 	edid = drm_get_edid(connector, vc4_hdmi->ddc);
 	cec_s_phys_addr_from_edid(vc4_hdmi->cec_adap, edid);
 	if (!edid)
-		return -ENODEV;
+		return 0;
 
 	vc4_encoder->hdmi_monitor = drm_detect_hdmi_monitor(edid);
 
diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_binding.c b/drivers/gpu/drm/vmwgfx/vmwgfx_binding.c
index f41550797970..4da4bf3b7f0b 100644
--- a/drivers/gpu/drm/vmwgfx/vmwgfx_binding.c
+++ b/drivers/gpu/drm/vmwgfx/vmwgfx_binding.c
@@ -713,7 +713,7 @@ static int vmw_binding_scrub_cb(struct vmw_ctx_bindinfo *bi, bool rebind)
  * without checking which bindings actually need to be emitted
  *
  * @cbs: Pointer to the context's struct vmw_ctx_binding_state
- * @bi: Pointer to where the binding info array is stored in @cbs
+ * @biv: Pointer to where the binding info array is stored in @cbs
  * @max_num: Maximum number of entries in the @bi array.
  *
  * Scans the @bi array for bindings and builds a buffer of view id data.
@@ -723,11 +723,9 @@ static int vmw_binding_scrub_cb(struct vmw_ctx_bindinfo *bi, bool rebind)
  * contains the command data.
  */
 static void vmw_collect_view_ids(struct vmw_ctx_binding_state *cbs,
-				 const struct vmw_ctx_bindinfo *bi,
+				 const struct vmw_ctx_bindinfo_view *biv,
 				 u32 max_num)
 {
-	const struct vmw_ctx_bindinfo_view *biv =
-		container_of(bi, struct vmw_ctx_bindinfo_view, bi);
 	unsigned long i;
 
 	cbs->bind_cmd_count = 0;
@@ -835,7 +833,7 @@ static int vmw_emit_set_sr(struct vmw_ctx_binding_state *cbs,
  */
 static int vmw_emit_set_rt(struct vmw_ctx_binding_state *cbs)
 {
-	const struct vmw_ctx_bindinfo *loc = &cbs->render_targets[0].bi;
+	const struct vmw_ctx_bindinfo_view *loc = &cbs->render_targets[0];
 	struct {
 		SVGA3dCmdHeader header;
 		SVGA3dCmdDXSetRenderTargets body;
@@ -871,7 +869,7 @@ static int vmw_emit_set_rt(struct vmw_ctx_binding_state *cbs)
  * without checking which bindings actually need to be emitted
  *
  * @cbs: Pointer to the context's struct vmw_ctx_binding_state
- * @bi: Pointer to where the binding info array is stored in @cbs
+ * @biso: Pointer to where the binding info array is stored in @cbs
  * @max_num: Maximum number of entries in the @bi array.
  *
  * Scans the @bi array for bindings and builds a buffer of SVGA3dSoTarget data.
@@ -881,11 +879,9 @@ static int vmw_emit_set_rt(struct vmw_ctx_binding_state *cbs)
  * contains the command data.
  */
 static void vmw_collect_so_targets(struct vmw_ctx_binding_state *cbs,
-				   const struct vmw_ctx_bindinfo *bi,
+				   const struct vmw_ctx_bindinfo_so_target *biso,
 				   u32 max_num)
 {
-	const struct vmw_ctx_bindinfo_so_target *biso =
-		container_of(bi, struct vmw_ctx_bindinfo_so_target, bi);
 	unsigned long i;
 	SVGA3dSoTarget *so_buffer = (SVGA3dSoTarget *) cbs->bind_cmd_buffer;
 
@@ -916,7 +912,7 @@ static void vmw_collect_so_targets(struct vmw_ctx_binding_state *cbs,
  */
 static int vmw_emit_set_so_target(struct vmw_ctx_binding_state *cbs)
 {
-	const struct vmw_ctx_bindinfo *loc = &cbs->so_targets[0].bi;
+	const struct vmw_ctx_bindinfo_so_target *loc = &cbs->so_targets[0];
 	struct {
 		SVGA3dCmdHeader header;
 		SVGA3dCmdDXSetSOTargets body;
@@ -1063,7 +1059,7 @@ static int vmw_emit_set_vb(struct vmw_ctx_binding_state *cbs)
 
 static int vmw_emit_set_uav(struct vmw_ctx_binding_state *cbs)
 {
-	const struct vmw_ctx_bindinfo *loc = &cbs->ua_views[0].views[0].bi;
+	const struct vmw_ctx_bindinfo_view *loc = &cbs->ua_views[0].views[0];
 	struct {
 		SVGA3dCmdHeader header;
 		SVGA3dCmdDXSetUAViews body;
@@ -1093,7 +1089,7 @@ static int vmw_emit_set_uav(struct vmw_ctx_binding_state *cbs)
 
 static int vmw_emit_set_cs_uav(struct vmw_ctx_binding_state *cbs)
 {
-	const struct vmw_ctx_bindinfo *loc = &cbs->ua_views[1].views[0].bi;
+	const struct vmw_ctx_bindinfo_view *loc = &cbs->ua_views[1].views[0];
 	struct {
 		SVGA3dCmdHeader header;
 		SVGA3dCmdDXSetCSUAViews body;
diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_blit.c b/drivers/gpu/drm/vmwgfx/vmwgfx_blit.c
index e8d66182cd7b..ea2f2f937eb3 100644
--- a/drivers/gpu/drm/vmwgfx/vmwgfx_blit.c
+++ b/drivers/gpu/drm/vmwgfx/vmwgfx_blit.c
@@ -459,9 +459,9 @@ int vmw_bo_cpu_blit(struct ttm_buffer_object *dst,
 	int ret = 0;
 
 	/* Buffer objects need to be either pinned or reserved: */
-	if (!(dst->mem.placement & TTM_PL_FLAG_NO_EVICT))
+	if (!(dst->pin_count))
 		dma_resv_assert_held(dst->base.resv);
-	if (!(src->mem.placement & TTM_PL_FLAG_NO_EVICT))
+	if (!(src->pin_count))
 		dma_resv_assert_held(src->base.resv);
 
 	if (!ttm_tt_is_populated(dst->ttm)) {
diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_bo.c b/drivers/gpu/drm/vmwgfx/vmwgfx_bo.c
index 813f1b148094..9a66ba254326 100644
--- a/drivers/gpu/drm/vmwgfx/vmwgfx_bo.c
+++ b/drivers/gpu/drm/vmwgfx/vmwgfx_bo.c
@@ -106,7 +106,7 @@ int vmw_bo_pin_in_placement(struct vmw_private *dev_priv,
 	if (unlikely(ret != 0))
 		goto err;
 
-	if (buf->pin_count > 0)
+	if (buf->base.pin_count > 0)
 		ret = ttm_bo_mem_compat(placement, &bo->mem,
 					&new_flags) == true ? 0 : -EINVAL;
 	else
@@ -155,7 +155,7 @@ int vmw_bo_pin_in_vram_or_gmr(struct vmw_private *dev_priv,
 	if (unlikely(ret != 0))
 		goto err;
 
-	if (buf->pin_count > 0) {
+	if (buf->base.pin_count > 0) {
 		ret = ttm_bo_mem_compat(&vmw_vram_gmr_placement, &bo->mem,
 					&new_flags) == true ? 0 : -EINVAL;
 		goto out_unreserve;
@@ -246,12 +246,12 @@ int vmw_bo_pin_in_start_of_vram(struct vmw_private *dev_priv,
 	if (bo->mem.mem_type == TTM_PL_VRAM &&
 	    bo->mem.start < bo->num_pages &&
 	    bo->mem.start > 0 &&
-	    buf->pin_count == 0) {
+	    buf->base.pin_count == 0) {
 		ctx.interruptible = false;
 		(void) ttm_bo_validate(bo, &vmw_sys_placement, &ctx);
 	}
 
-	if (buf->pin_count > 0)
+	if (buf->base.pin_count > 0)
 		ret = ttm_bo_mem_compat(&placement, &bo->mem,
 					&new_flags) == true ? 0 : -EINVAL;
 	else
@@ -343,23 +343,13 @@ void vmw_bo_pin_reserved(struct vmw_buffer_object *vbo, bool pin)
 
 	dma_resv_assert_held(bo->base.resv);
 
-	if (pin) {
-		if (vbo->pin_count++ > 0)
-			return;
-	} else {
-		WARN_ON(vbo->pin_count <= 0);
-		if (--vbo->pin_count > 0)
-			return;
-	}
+	if (pin == !!bo->pin_count)
+		return;
 
 	pl.fpfn = 0;
 	pl.lpfn = 0;
 	pl.mem_type = bo->mem.mem_type;
 	pl.flags = bo->mem.placement;
-	if (pin)
-		pl.flags |= TTM_PL_FLAG_NO_EVICT;
-	else
-		pl.flags &= ~TTM_PL_FLAG_NO_EVICT;
 
 	memset(&placement, 0, sizeof(placement));
 	placement.num_placement = 1;
@@ -368,8 +358,12 @@ void vmw_bo_pin_reserved(struct vmw_buffer_object *vbo, bool pin)
 	ret = ttm_bo_validate(bo, &placement, &ctx);
 
 	BUG_ON(ret != 0 || bo->mem.mem_type != old_mem_type);
-}
 
+	if (pin)
+		ttm_bo_pin(bo);
+	else
+		ttm_bo_unpin(bo);
+}
 
 /**
  * vmw_bo_map_and_cache - Map a buffer object and cache the map
@@ -487,6 +481,49 @@ static void vmw_user_bo_destroy(struct ttm_buffer_object *bo)
 	ttm_prime_object_kfree(vmw_user_bo, prime);
 }
 
+/**
+ * vmw_bo_create_kernel - Create a pinned BO for internal kernel use.
+ *
+ * @dev_priv: Pointer to the device private struct
+ * @size: size of the BO we need
+ * @placement: where to put it
+ * @p_bo: resulting BO
+ *
+ * Creates and pin a simple BO for in kernel use.
+ */
+int vmw_bo_create_kernel(struct vmw_private *dev_priv, unsigned long size,
+			 struct ttm_placement *placement,
+			 struct ttm_buffer_object **p_bo)
+{
+	unsigned npages = PAGE_ALIGN(size) >> PAGE_SHIFT;
+	struct ttm_operation_ctx ctx = { false, false };
+	struct ttm_buffer_object *bo;
+	size_t acc_size;
+	int ret;
+
+	bo = kzalloc(sizeof(*bo), GFP_KERNEL);
+	if (unlikely(!bo))
+		return -ENOMEM;
+
+	acc_size = ttm_round_pot(sizeof(*bo));
+	acc_size += ttm_round_pot(npages * sizeof(void *));
+	acc_size += ttm_round_pot(sizeof(struct ttm_tt));
+	ret = ttm_bo_init_reserved(&dev_priv->bdev, bo, size,
+				   ttm_bo_type_device, placement, 0,
+				   &ctx, acc_size, NULL, NULL, NULL);
+	if (unlikely(ret))
+		goto error_free;
+
+	ttm_bo_pin(bo);
+	ttm_bo_unreserve(bo);
+	*p_bo = bo;
+
+	return 0;
+
+error_free:
+	kfree(bo);
+	return ret;
+}
 
 /**
  * vmw_bo_init - Initialize a vmw buffer object
@@ -496,6 +533,7 @@ static void vmw_user_bo_destroy(struct ttm_buffer_object *bo)
  * @size: Buffer object size in bytes.
  * @placement: Initial placement.
  * @interruptible: Whether waits should be performed interruptible.
+ * @pin: If the BO should be created pinned at a fixed location.
  * @bo_free: The buffer object destructor.
  * Returns: Zero on success, negative error code on error.
  *
@@ -504,9 +542,10 @@ static void vmw_user_bo_destroy(struct ttm_buffer_object *bo)
 int vmw_bo_init(struct vmw_private *dev_priv,
 		struct vmw_buffer_object *vmw_bo,
 		size_t size, struct ttm_placement *placement,
-		bool interruptible,
+		bool interruptible, bool pin,
 		void (*bo_free)(struct ttm_buffer_object *bo))
 {
+	struct ttm_operation_ctx ctx = { interruptible, false };
 	struct ttm_bo_device *bdev = &dev_priv->bdev;
 	size_t acc_size;
 	int ret;
@@ -520,11 +559,16 @@ int vmw_bo_init(struct vmw_private *dev_priv,
 	vmw_bo->base.priority = 3;
 	vmw_bo->res_tree = RB_ROOT;
 
-	ret = ttm_bo_init(bdev, &vmw_bo->base, size,
-			  ttm_bo_type_device, placement,
-			  0, interruptible, acc_size,
-			  NULL, NULL, bo_free);
-	return ret;
+	ret = ttm_bo_init_reserved(bdev, &vmw_bo->base, size,
+				   ttm_bo_type_device, placement,
+				   0, &ctx, acc_size, NULL, NULL, bo_free);
+	if (unlikely(ret))
+		return ret;
+
+	if (pin)
+		ttm_bo_pin(&vmw_bo->base);
+	ttm_bo_unreserve(&vmw_bo->base);
+	return 0;
 }
 
 
@@ -613,7 +657,7 @@ int vmw_user_bo_alloc(struct vmw_private *dev_priv,
 	ret = vmw_bo_init(dev_priv, &user_bo->vbo, size,
 			  (dev_priv->has_mob) ?
 			  &vmw_sys_placement :
-			  &vmw_vram_sys_placement, true,
+			  &vmw_vram_sys_placement, true, false,
 			  &vmw_user_bo_destroy);
 	if (unlikely(ret != 0))
 		return ret;
diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_cmdbuf.c b/drivers/gpu/drm/vmwgfx/vmwgfx_cmdbuf.c
index 3b41cf63110a..87a39721e5bc 100644
--- a/drivers/gpu/drm/vmwgfx/vmwgfx_cmdbuf.c
+++ b/drivers/gpu/drm/vmwgfx/vmwgfx_cmdbuf.c
@@ -514,7 +514,7 @@ static void vmw_cmdbuf_work_func(struct work_struct *work)
 	struct vmw_cmdbuf_man *man =
 		container_of(work, struct vmw_cmdbuf_man, work);
 	struct vmw_cmdbuf_header *entry, *next;
-	uint32_t dummy;
+	uint32_t dummy = 0;
 	bool send_fence = false;
 	struct list_head restart_head[SVGA_CB_CONTEXT_MAX];
 	int i;
@@ -1245,9 +1245,9 @@ int vmw_cmdbuf_set_pool_size(struct vmw_cmdbuf_man *man,
 		    !dev_priv->has_mob)
 			return -ENOMEM;
 
-		ret = ttm_bo_create(&dev_priv->bdev, size, ttm_bo_type_device,
-				    &vmw_mob_ne_placement, 0, false,
-				    &man->cmd_space);
+		ret = vmw_bo_create_kernel(dev_priv, size,
+					   &vmw_mob_placement,
+					   &man->cmd_space);
 		if (ret)
 			return ret;
 
diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_cmdbuf_res.c b/drivers/gpu/drm/vmwgfx/vmwgfx_cmdbuf_res.c
index 44d858ce4ce7..f212368c0312 100644
--- a/drivers/gpu/drm/vmwgfx/vmwgfx_cmdbuf_res.c
+++ b/drivers/gpu/drm/vmwgfx/vmwgfx_cmdbuf_res.c
@@ -168,8 +168,8 @@ void vmw_cmdbuf_res_revert(struct list_head *list)
 			vmw_cmdbuf_res_free(entry->man, entry);
 			break;
 		case VMW_CMDBUF_RES_DEL:
-			ret = drm_ht_insert_item(&entry->man->resources,
-						 &entry->hash);
+			ret = drm_ht_insert_item(&entry->man->resources, &entry->hash);
+			BUG_ON(ret);
 			list_del(&entry->head);
 			list_add_tail(&entry->head, &entry->man->list);
 			entry->state = VMW_CMDBUF_RES_COMMITTED;
diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_cotable.c b/drivers/gpu/drm/vmwgfx/vmwgfx_cotable.c
index 65e8e7a97724..984d8884357d 100644
--- a/drivers/gpu/drm/vmwgfx/vmwgfx_cotable.c
+++ b/drivers/gpu/drm/vmwgfx/vmwgfx_cotable.c
@@ -410,8 +410,8 @@ static int vmw_cotable_resize(struct vmw_resource *res, size_t new_size)
 	if (!buf)
 		return -ENOMEM;
 
-	ret = vmw_bo_init(dev_priv, buf, new_size, &vmw_mob_ne_placement,
-			  true, vmw_bo_bo_free);
+	ret = vmw_bo_init(dev_priv, buf, new_size, &vmw_mob_placement,
+			  true, true, vmw_bo_bo_free);
 	if (ret) {
 		DRM_ERROR("Failed initializing new cotable MOB.\n");
 		return ret;
diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_drv.c b/drivers/gpu/drm/vmwgfx/vmwgfx_drv.c
index 31e3e5c9f362..bdb7a5e96560 100644
--- a/drivers/gpu/drm/vmwgfx/vmwgfx_drv.c
+++ b/drivers/gpu/drm/vmwgfx/vmwgfx_drv.c
@@ -372,7 +372,7 @@ static int vmw_dummy_query_bo_create(struct vmw_private *dev_priv)
 		return -ENOMEM;
 
 	ret = vmw_bo_init(dev_priv, vbo, PAGE_SIZE,
-			  &vmw_sys_ne_placement, false,
+			  &vmw_sys_placement, false, true,
 			  &vmw_bo_bo_free);
 	if (unlikely(ret != 0))
 		return ret;
diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_drv.h b/drivers/gpu/drm/vmwgfx/vmwgfx_drv.h
index 0a79c57c7db6..fa285c20d6da 100644
--- a/drivers/gpu/drm/vmwgfx/vmwgfx_drv.h
+++ b/drivers/gpu/drm/vmwgfx/vmwgfx_drv.h
@@ -99,7 +99,6 @@ struct vmw_fpriv {
  * struct vmw_buffer_object - TTM buffer object with vmwgfx additions
  * @base: The TTM buffer object
  * @res_tree: RB tree of resources using this buffer object as a backing MOB
- * @pin_count: pin depth
  * @cpu_writers: Number of synccpu write grabs. Protected by reservation when
  * increased. May be decreased without reservation.
  * @dx_query_ctx: DX context if this buffer object is used as a DX query MOB
@@ -110,7 +109,6 @@ struct vmw_fpriv {
 struct vmw_buffer_object {
 	struct ttm_buffer_object base;
 	struct rb_root res_tree;
-	s32 pin_count;
 	atomic_t cpu_writers;
 	/* Not ref-counted.  Protected by binding_mutex */
 	struct vmw_resource *dx_query_ctx;
@@ -845,10 +843,14 @@ extern void vmw_bo_get_guest_ptr(const struct ttm_buffer_object *buf,
 				 SVGAGuestPtr *ptr);
 extern void vmw_bo_pin_reserved(struct vmw_buffer_object *bo, bool pin);
 extern void vmw_bo_bo_free(struct ttm_buffer_object *bo);
+extern int vmw_bo_create_kernel(struct vmw_private *dev_priv,
+				unsigned long size,
+				struct ttm_placement *placement,
+				struct ttm_buffer_object **p_bo);
 extern int vmw_bo_init(struct vmw_private *dev_priv,
 		       struct vmw_buffer_object *vmw_bo,
 		       size_t size, struct ttm_placement *placement,
-		       bool interruptible,
+		       bool interruptible, bool pin,
 		       void (*bo_free)(struct ttm_buffer_object *bo));
 extern int vmw_user_bo_verify_access(struct ttm_buffer_object *bo,
 				     struct ttm_object_file *tfile);
@@ -1005,16 +1007,13 @@ extern void vmw_validation_mem_init_ttm(struct vmw_private *dev_priv,
 
 extern const size_t vmw_tt_size;
 extern struct ttm_placement vmw_vram_placement;
-extern struct ttm_placement vmw_vram_ne_placement;
 extern struct ttm_placement vmw_vram_sys_placement;
 extern struct ttm_placement vmw_vram_gmr_placement;
 extern struct ttm_placement vmw_vram_gmr_ne_placement;
 extern struct ttm_placement vmw_sys_placement;
-extern struct ttm_placement vmw_sys_ne_placement;
 extern struct ttm_placement vmw_evictable_placement;
 extern struct ttm_placement vmw_srf_placement;
 extern struct ttm_placement vmw_mob_placement;
-extern struct ttm_placement vmw_mob_ne_placement;
 extern struct ttm_placement vmw_nonfixed_placement;
 extern struct ttm_bo_driver vmw_bo_driver;
 extern const struct vmw_sg_table *
diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_execbuf.c b/drivers/gpu/drm/vmwgfx/vmwgfx_execbuf.c
index 00082c679170..616f6cb62278 100644
--- a/drivers/gpu/drm/vmwgfx/vmwgfx_execbuf.c
+++ b/drivers/gpu/drm/vmwgfx/vmwgfx_execbuf.c
@@ -467,7 +467,7 @@ static int vmw_resource_context_res_add(struct vmw_private *dev_priv,
 	    vmw_res_type(ctx) == vmw_res_dx_context) {
 		for (i = 0; i < cotable_max; ++i) {
 			res = vmw_context_cotable(ctx, i);
-			if (IS_ERR(res))
+			if (IS_ERR_OR_NULL(res))
 				continue;
 
 			ret = vmw_execbuf_res_noctx_val_add(sw_context, res,
@@ -1272,6 +1272,8 @@ static int vmw_cmd_dx_define_query(struct vmw_private *dev_priv,
 		return -EINVAL;
 
 	cotable_res = vmw_context_cotable(ctx_node->ctx, SVGA_COTABLE_DXQUERY);
+	if (IS_ERR_OR_NULL(cotable_res))
+		return cotable_res ? PTR_ERR(cotable_res) : -EINVAL;
 	ret = vmw_cotable_notify(cotable_res, cmd->body.queryId);
 
 	return ret;
@@ -2450,6 +2452,8 @@ static int vmw_cmd_dx_view_define(struct vmw_private *dev_priv,
 		return ret;
 
 	res = vmw_context_cotable(ctx_node->ctx, vmw_view_cotables[view_type]);
+	if (IS_ERR_OR_NULL(res))
+		return res ? PTR_ERR(res) : -EINVAL;
 	ret = vmw_cotable_notify(res, cmd->defined_id);
 	if (unlikely(ret != 0))
 		return ret;
@@ -2535,6 +2539,8 @@ static int vmw_cmd_dx_so_define(struct vmw_private *dev_priv,
 
 	so_type = vmw_so_cmd_to_type(header->id);
 	res = vmw_context_cotable(ctx_node->ctx, vmw_so_cotables[so_type]);
+	if (IS_ERR_OR_NULL(res))
+		return res ? PTR_ERR(res) : -EINVAL;
 	cmd = container_of(header, typeof(*cmd), header);
 	ret = vmw_cotable_notify(res, cmd->defined_id);
 
@@ -2653,6 +2659,8 @@ static int vmw_cmd_dx_define_shader(struct vmw_private *dev_priv,
 		return -EINVAL;
 
 	res = vmw_context_cotable(ctx_node->ctx, SVGA_COTABLE_DXSHADER);
+	if (IS_ERR_OR_NULL(res))
+		return res ? PTR_ERR(res) : -EINVAL;
 	ret = vmw_cotable_notify(res, cmd->body.shaderId);
 	if (ret)
 		return ret;
@@ -2974,6 +2982,8 @@ static int vmw_cmd_dx_define_streamoutput(struct vmw_private *dev_priv,
 	}
 
 	res = vmw_context_cotable(ctx_node->ctx, SVGA_COTABLE_STREAMOUTPUT);
+	if (IS_ERR_OR_NULL(res))
+		return res ? PTR_ERR(res) : -EINVAL;
 	ret = vmw_cotable_notify(res, cmd->body.soid);
 	if (ret)
 		return ret;
diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_fb.c b/drivers/gpu/drm/vmwgfx/vmwgfx_fb.c
index 97d9d2557447..3923acc3ab1e 100644
--- a/drivers/gpu/drm/vmwgfx/vmwgfx_fb.c
+++ b/drivers/gpu/drm/vmwgfx/vmwgfx_fb.c
@@ -406,7 +406,7 @@ static int vmw_fb_create_bo(struct vmw_private *vmw_priv,
 
 	ret = vmw_bo_init(vmw_priv, vmw_bo, size,
 			      &vmw_sys_placement,
-			      false,
+			      false, false,
 			      &vmw_bo_bo_free);
 	if (unlikely(ret != 0))
 		goto err_unlock; /* init frees the buffer on failure */
diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_mob.c b/drivers/gpu/drm/vmwgfx/vmwgfx_mob.c
index 7f95ed6aa224..fb0797b380dd 100644
--- a/drivers/gpu/drm/vmwgfx/vmwgfx_mob.c
+++ b/drivers/gpu/drm/vmwgfx/vmwgfx_mob.c
@@ -494,11 +494,13 @@ static void vmw_mob_pt_setup(struct vmw_mob *mob,
 {
 	unsigned long num_pt_pages = 0;
 	struct ttm_buffer_object *bo = mob->pt_bo;
-	struct vmw_piter save_pt_iter;
+	struct vmw_piter save_pt_iter = {0};
 	struct vmw_piter pt_iter;
 	const struct vmw_sg_table *vsgt;
 	int ret;
 
+	BUG_ON(num_data_pages == 0);
+
 	ret = ttm_bo_reserve(bo, false, true, NULL);
 	BUG_ON(ret != 0);
 
diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_msg.c b/drivers/gpu/drm/vmwgfx/vmwgfx_msg.c
index 15b5bde69324..751582f5ab0b 100644
--- a/drivers/gpu/drm/vmwgfx/vmwgfx_msg.c
+++ b/drivers/gpu/drm/vmwgfx/vmwgfx_msg.c
@@ -154,6 +154,7 @@ static unsigned long vmw_port_hb_out(struct rpc_channel *channel,
 	/* HB port can't access encrypted memory. */
 	if (hb && !mem_encrypt_active()) {
 		unsigned long bp = channel->cookie_high;
+		u32 channel_id = (channel->channel_id << 16);
 
 		si = (uintptr_t) msg;
 		di = channel->cookie_low;
@@ -161,7 +162,7 @@ static unsigned long vmw_port_hb_out(struct rpc_channel *channel,
 		VMW_PORT_HB_OUT(
 			(MESSAGE_STATUS_SUCCESS << 16) | VMW_PORT_CMD_HB_MSG,
 			msg_len, si, di,
-			VMWARE_HYPERVISOR_HB | (channel->channel_id << 16) |
+			VMWARE_HYPERVISOR_HB | channel_id |
 			VMWARE_HYPERVISOR_OUT,
 			VMW_HYPERVISOR_MAGIC, bp,
 			eax, ebx, ecx, edx, si, di);
@@ -209,6 +210,7 @@ static unsigned long vmw_port_hb_in(struct rpc_channel *channel, char *reply,
 	/* HB port can't access encrypted memory */
 	if (hb && !mem_encrypt_active()) {
 		unsigned long bp = channel->cookie_low;
+		u32 channel_id = (channel->channel_id << 16);
 
 		si = channel->cookie_high;
 		di = (uintptr_t) reply;
@@ -216,7 +218,7 @@ static unsigned long vmw_port_hb_in(struct rpc_channel *channel, char *reply,
 		VMW_PORT_HB_IN(
 			(MESSAGE_STATUS_SUCCESS << 16) | VMW_PORT_CMD_HB_MSG,
 			reply_len, si, di,
-			VMWARE_HYPERVISOR_HB | (channel->channel_id << 16),
+			VMWARE_HYPERVISOR_HB | channel_id,
 			VMW_HYPERVISOR_MAGIC, bp,
 			eax, ebx, ecx, edx, si, di);
 
diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_resource.c b/drivers/gpu/drm/vmwgfx/vmwgfx_resource.c
index c0f156078dda..26f88d64879f 100644
--- a/drivers/gpu/drm/vmwgfx/vmwgfx_resource.c
+++ b/drivers/gpu/drm/vmwgfx/vmwgfx_resource.c
@@ -114,6 +114,7 @@ static void vmw_resource_release(struct kref *kref)
 	    container_of(kref, struct vmw_resource, kref);
 	struct vmw_private *dev_priv = res->dev_priv;
 	int id;
+	int ret;
 	struct idr *idr = &dev_priv->res_idr[res->func->res_type];
 
 	spin_lock(&dev_priv->resource_lock);
@@ -122,7 +123,8 @@ static void vmw_resource_release(struct kref *kref)
 	if (res->backup) {
 		struct ttm_buffer_object *bo = &res->backup->base;
 
-		ttm_bo_reserve(bo, false, false, NULL);
+		ret = ttm_bo_reserve(bo, false, false, NULL);
+		BUG_ON(ret);
 		if (vmw_resource_mob_attached(res) &&
 		    res->func->unbind != NULL) {
 			struct ttm_validate_buffer val_buf;
@@ -370,7 +372,7 @@ static int vmw_resource_buf_alloc(struct vmw_resource *res,
 
 	ret = vmw_bo_init(res->dev_priv, backup, res->backup_size,
 			      res->func->backup_placement,
-			      interruptible,
+			      interruptible, false,
 			      &vmw_bo_bo_free);
 	if (unlikely(ret != 0))
 		goto out_no_bo;
@@ -1001,8 +1003,10 @@ int vmw_resource_pin(struct vmw_resource *res, bool interruptible)
 		if (res->backup) {
 			vbo = res->backup;
 
-			ttm_bo_reserve(&vbo->base, interruptible, false, NULL);
-			if (!vbo->pin_count) {
+			ret = ttm_bo_reserve(&vbo->base, interruptible, false, NULL);
+			if (ret)
+				goto out_no_validate;
+			if (!vbo->base.pin_count) {
 				ret = ttm_bo_validate
 					(&vbo->base,
 					 res->func->backup_placement,
diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_scrn.c b/drivers/gpu/drm/vmwgfx/vmwgfx_scrn.c
index 2b6590344468..9c8109efefbd 100644
--- a/drivers/gpu/drm/vmwgfx/vmwgfx_scrn.c
+++ b/drivers/gpu/drm/vmwgfx/vmwgfx_scrn.c
@@ -451,8 +451,8 @@ vmw_sou_primary_plane_prepare_fb(struct drm_plane *plane,
 	 */
 	vmw_overlay_pause_all(dev_priv);
 	ret = vmw_bo_init(dev_priv, vps->bo, size,
-			      &vmw_vram_ne_placement,
-			      false, &vmw_bo_bo_free);
+			      &vmw_vram_placement,
+			      false, true, &vmw_bo_bo_free);
 	vmw_overlay_resume_all(dev_priv);
 	if (ret) {
 		vps->bo = NULL; /* vmw_bo_init frees on error */
diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_shader.c b/drivers/gpu/drm/vmwgfx/vmwgfx_shader.c
index e139fdfd1635..f328aa5839a2 100644
--- a/drivers/gpu/drm/vmwgfx/vmwgfx_shader.c
+++ b/drivers/gpu/drm/vmwgfx/vmwgfx_shader.c
@@ -978,8 +978,8 @@ int vmw_compat_shader_add(struct vmw_private *dev_priv,
 	if (unlikely(!buf))
 		return -ENOMEM;
 
-	ret = vmw_bo_init(dev_priv, buf, size, &vmw_sys_ne_placement,
-			      true, vmw_bo_bo_free);
+	ret = vmw_bo_init(dev_priv, buf, size, &vmw_sys_placement,
+			      true, true, vmw_bo_bo_free);
 	if (unlikely(ret != 0))
 		goto out;
 
diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_so.c b/drivers/gpu/drm/vmwgfx/vmwgfx_so.c
index 3f97b61dd5d8..9330f1a0f174 100644
--- a/drivers/gpu/drm/vmwgfx/vmwgfx_so.c
+++ b/drivers/gpu/drm/vmwgfx/vmwgfx_so.c
@@ -538,7 +538,8 @@ const SVGACOTableType vmw_so_cotables[] = {
 	[vmw_so_ds] = SVGA_COTABLE_DEPTHSTENCIL,
 	[vmw_so_rs] = SVGA_COTABLE_RASTERIZERSTATE,
 	[vmw_so_ss] = SVGA_COTABLE_SAMPLER,
-	[vmw_so_so] = SVGA_COTABLE_STREAMOUTPUT
+	[vmw_so_so] = SVGA_COTABLE_STREAMOUTPUT,
+	[vmw_so_max]= SVGA_COTABLE_MAX
 };
 
 
diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_ttm_buffer.c b/drivers/gpu/drm/vmwgfx/vmwgfx_ttm_buffer.c
index 73116ec70ba5..89b3356ec27f 100644
--- a/drivers/gpu/drm/vmwgfx/vmwgfx_ttm_buffer.c
+++ b/drivers/gpu/drm/vmwgfx/vmwgfx_ttm_buffer.c
@@ -37,13 +37,6 @@ static const struct ttm_place vram_placement_flags = {
 	.flags = TTM_PL_FLAG_CACHED
 };
 
-static const struct ttm_place vram_ne_placement_flags = {
-	.fpfn = 0,
-	.lpfn = 0,
-	.mem_type = TTM_PL_VRAM,
-	.flags = TTM_PL_FLAG_CACHED | TTM_PL_FLAG_NO_EVICT
-};
-
 static const struct ttm_place sys_placement_flags = {
 	.fpfn = 0,
 	.lpfn = 0,
@@ -51,13 +44,6 @@ static const struct ttm_place sys_placement_flags = {
 	.flags = TTM_PL_FLAG_CACHED
 };
 
-static const struct ttm_place sys_ne_placement_flags = {
-	.fpfn = 0,
-	.lpfn = 0,
-	.mem_type = TTM_PL_SYSTEM,
-	.flags = TTM_PL_FLAG_CACHED | TTM_PL_FLAG_NO_EVICT
-};
-
 static const struct ttm_place gmr_placement_flags = {
 	.fpfn = 0,
 	.lpfn = 0,
@@ -79,13 +65,6 @@ static const struct ttm_place mob_placement_flags = {
 	.flags = TTM_PL_FLAG_CACHED
 };
 
-static const struct ttm_place mob_ne_placement_flags = {
-	.fpfn = 0,
-	.lpfn = 0,
-	.mem_type = VMW_PL_MOB,
-	.flags = TTM_PL_FLAG_CACHED | TTM_PL_FLAG_NO_EVICT
-};
-
 struct ttm_placement vmw_vram_placement = {
 	.num_placement = 1,
 	.placement = &vram_placement_flags,
@@ -158,13 +137,6 @@ struct ttm_placement vmw_vram_sys_placement = {
 	.busy_placement = &sys_placement_flags
 };
 
-struct ttm_placement vmw_vram_ne_placement = {
-	.num_placement = 1,
-	.placement = &vram_ne_placement_flags,
-	.num_busy_placement = 1,
-	.busy_placement = &vram_ne_placement_flags
-};
-
 struct ttm_placement vmw_sys_placement = {
 	.num_placement = 1,
 	.placement = &sys_placement_flags,
@@ -172,13 +144,6 @@ struct ttm_placement vmw_sys_placement = {
 	.busy_placement = &sys_placement_flags
 };
 
-struct ttm_placement vmw_sys_ne_placement = {
-	.num_placement = 1,
-	.placement = &sys_ne_placement_flags,
-	.num_busy_placement = 1,
-	.busy_placement = &sys_ne_placement_flags
-};
-
 static const struct ttm_place evictable_placement_flags[] = {
 	{
 		.fpfn = 0,
@@ -243,13 +208,6 @@ struct ttm_placement vmw_mob_placement = {
 	.busy_placement = &mob_placement_flags
 };
 
-struct ttm_placement vmw_mob_ne_placement = {
-	.num_placement = 1,
-	.num_busy_placement = 1,
-	.placement = &mob_ne_placement_flags,
-	.busy_placement = &mob_ne_placement_flags
-};
-
 struct ttm_placement vmw_nonfixed_placement = {
 	.num_placement = 3,
 	.placement = nonfixed_placement_flags,
@@ -817,11 +775,9 @@ int vmw_bo_create_and_populate(struct vmw_private *dev_priv,
 	struct ttm_buffer_object *bo;
 	int ret;
 
-	ret = ttm_bo_create(&dev_priv->bdev, bo_size,
-			    ttm_bo_type_device,
-			    &vmw_sys_ne_placement,
-			    0, false, &bo);
-
+	ret = vmw_bo_create_kernel(dev_priv, bo_size,
+				   &vmw_sys_placement,
+				   &bo);
 	if (unlikely(ret != 0))
 		return ret;
 
diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_validation.c b/drivers/gpu/drm/vmwgfx/vmwgfx_validation.c
index e69bc373ae2e..cc1cfc827bb9 100644
--- a/drivers/gpu/drm/vmwgfx/vmwgfx_validation.c
+++ b/drivers/gpu/drm/vmwgfx/vmwgfx_validation.c
@@ -540,7 +540,7 @@ int vmw_validation_bo_validate_single(struct ttm_buffer_object *bo,
 	if (atomic_read(&vbo->cpu_writers))
 		return -EBUSY;
 
-	if (vbo->pin_count > 0)
+	if (vbo->base.pin_count > 0)
 		return 0;
 
 	if (validate_as_mob)
@@ -585,13 +585,13 @@ int vmw_validation_bo_validate(struct vmw_validation_context *ctx, bool intr)
 			container_of(entry->base.bo, typeof(*vbo), base);
 
 		if (entry->cpu_blit) {
-			struct ttm_operation_ctx ctx = {
+			struct ttm_operation_ctx ttm_ctx = {
 				.interruptible = intr,
 				.no_wait_gpu = false
 			};
 
 			ret = ttm_bo_validate(entry->base.bo,
-					      &vmw_nonfixed_placement, &ctx);
+					      &vmw_nonfixed_placement, &ttm_ctx);
 		} else {
 			ret = vmw_validation_bo_validate_single
 			(entry->base.bo, intr, entry->as_mob);
diff --git a/drivers/hwmon/amc6821.c b/drivers/hwmon/amc6821.c
index 6b1ce2242c61..60dfdb0f5523 100644
--- a/drivers/hwmon/amc6821.c
+++ b/drivers/hwmon/amc6821.c
@@ -934,10 +934,21 @@ static const struct i2c_device_id amc6821_id[] = {
 
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
 	.probe_new = amc6821_probe,
 	.id_table = amc6821_id,
diff --git a/drivers/infiniband/core/cm.c b/drivers/infiniband/core/cm.c
index db1a25fbe2fa..2a30b25c5e7e 100644
--- a/drivers/infiniband/core/cm.c
+++ b/drivers/infiniband/core/cm.c
@@ -33,6 +33,7 @@ MODULE_AUTHOR("Sean Hefty");
 MODULE_DESCRIPTION("InfiniBand CM");
 MODULE_LICENSE("Dual BSD/GPL");
 
+#define CM_DESTROY_ID_WAIT_TIMEOUT 10000 /* msecs */
 static const char * const ibcm_rej_reason_strs[] = {
 	[IB_CM_REJ_NO_QP]			= "no QP",
 	[IB_CM_REJ_NO_EEC]			= "no EEC",
@@ -1056,10 +1057,20 @@ static void cm_reset_to_idle(struct cm_id_private *cm_id_priv)
 	}
 }
 
+static noinline void cm_destroy_id_wait_timeout(struct ib_cm_id *cm_id)
+{
+	struct cm_id_private *cm_id_priv;
+
+	cm_id_priv = container_of(cm_id, struct cm_id_private, id);
+	pr_err("%s: cm_id=%p timed out. state=%d refcnt=%d\n", __func__,
+	       cm_id, cm_id->state, refcount_read(&cm_id_priv->refcount));
+}
+
 static void cm_destroy_id(struct ib_cm_id *cm_id, int err)
 {
 	struct cm_id_private *cm_id_priv;
 	struct cm_work *work;
+	int ret;
 
 	cm_id_priv = container_of(cm_id, struct cm_id_private, id);
 	spin_lock_irq(&cm_id_priv->lock);
@@ -1171,7 +1182,14 @@ static void cm_destroy_id(struct ib_cm_id *cm_id, int err)
 
 	xa_erase(&cm.local_id_table, cm_local_id(cm_id->local_id));
 	cm_deref_id(cm_id_priv);
-	wait_for_completion(&cm_id_priv->comp);
+	do {
+		ret = wait_for_completion_timeout(&cm_id_priv->comp,
+						  msecs_to_jiffies(
+						  CM_DESTROY_ID_WAIT_TIMEOUT));
+		if (!ret) /* timeout happened */
+			cm_destroy_id_wait_timeout(cm_id);
+	} while (!ret);
+
 	while ((work = cm_dequeue_work(cm_id_priv)) != NULL)
 		cm_free_work(work);
 
diff --git a/drivers/input/rmi4/rmi_driver.c b/drivers/input/rmi4/rmi_driver.c
index 258d5fe3d395..aa32371f04af 100644
--- a/drivers/input/rmi4/rmi_driver.c
+++ b/drivers/input/rmi4/rmi_driver.c
@@ -1196,7 +1196,11 @@ static int rmi_driver_probe(struct device *dev)
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
diff --git a/drivers/md/dm-integrity.c b/drivers/md/dm-integrity.c
index 62cae34ca3b4..067be1d9f51c 100644
--- a/drivers/md/dm-integrity.c
+++ b/drivers/md/dm-integrity.c
@@ -3937,7 +3937,7 @@ static int dm_integrity_ctr(struct dm_target *ti, unsigned argc, char **argv)
 		} else if (sscanf(opt_string, "sectors_per_bit:%llu%c", &llval, &dummy) == 1) {
 			log2_sectors_per_bitmap_bit = !llval ? 0 : __ilog2_u64(llval);
 		} else if (sscanf(opt_string, "bitmap_flush_interval:%u%c", &val, &dummy) == 1) {
-			if (val >= (uint64_t)UINT_MAX * 1000 / HZ) {
+			if ((uint64_t)val >= (uint64_t)UINT_MAX * 1000 / HZ) {
 				r = -EINVAL;
 				ti->error = "Invalid bitmap_flush_interval argument";
 				goto bad;
diff --git a/drivers/md/dm-raid.c b/drivers/md/dm-raid.c
index e523ecdf947f..99995b1804b3 100644
--- a/drivers/md/dm-raid.c
+++ b/drivers/md/dm-raid.c
@@ -4019,7 +4019,9 @@ static void raid_resume(struct dm_target *ti)
 		 * Take this opportunity to check whether any failed
 		 * devices are reachable again.
 		 */
+		mddev_lock_nointr(mddev);
 		attempt_restore_of_faulty_devices(rs);
+		mddev_unlock(mddev);
 	}
 
 	if (test_and_clear_bit(RT_FLAG_RS_SUSPENDED, &rs->runtime_flags)) {
diff --git a/drivers/md/dm-snap.c b/drivers/md/dm-snap.c
index 41735a25d50a..de73fe79640f 100644
--- a/drivers/md/dm-snap.c
+++ b/drivers/md/dm-snap.c
@@ -685,8 +685,10 @@ static void dm_exception_table_exit(struct dm_exception_table *et,
 	for (i = 0; i < size; i++) {
 		slot = et->table + i;
 
-		hlist_bl_for_each_entry_safe(ex, pos, n, slot, hash_list)
+		hlist_bl_for_each_entry_safe(ex, pos, n, slot, hash_list) {
 			kmem_cache_free(mem, ex);
+			cond_resched();
+		}
 	}
 
 	vfree(et->table);
diff --git a/drivers/md/raid5.c b/drivers/md/raid5.c
index 00995e60d46b..9f114b9d8dc6 100644
--- a/drivers/md/raid5.c
+++ b/drivers/md/raid5.c
@@ -36,6 +36,7 @@
  */
 
 #include <linux/blkdev.h>
+#include <linux/delay.h>
 #include <linux/kthread.h>
 #include <linux/raid/pq.h>
 #include <linux/async_tx.h>
@@ -6519,7 +6520,18 @@ static void raid5d(struct md_thread *thread)
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
index 336df65c8af1..01ca940aecc2 100644
--- a/drivers/media/pci/sta2x11/sta2x11_vip.c
+++ b/drivers/media/pci/sta2x11/sta2x11_vip.c
@@ -760,7 +760,7 @@ static const struct video_device video_dev_template = {
 /**
  * vip_irq - interrupt routine
  * @irq: Number of interrupt ( not used, correct number is assumed )
- * @vip: local data structure containing all information
+ * @data: local data structure containing all information
  *
  * check for both frame interrupts set ( top and bottom ).
  * check FIFO overflow, but limit number of log messages after open.
@@ -770,8 +770,9 @@ static const struct video_device video_dev_template = {
  *
  * IRQ_HANDLED, interrupt done.
  */
-static irqreturn_t vip_irq(int irq, struct sta2x11_vip *vip)
+static irqreturn_t vip_irq(int irq, void *data)
 {
+	struct sta2x11_vip *vip = data;
 	unsigned int status;
 
 	status = reg_read(vip, DVP_ITS);
@@ -1053,9 +1054,7 @@ static int sta2x11_vip_init_one(struct pci_dev *pdev,
 
 	spin_lock_init(&vip->slock);
 
-	ret = request_irq(pdev->irq,
-			  (irq_handler_t) vip_irq,
-			  IRQF_SHARED, KBUILD_MODNAME, vip);
+	ret = request_irq(pdev->irq, vip_irq, IRQF_SHARED, KBUILD_MODNAME, vip);
 	if (ret) {
 		dev_err(&pdev->dev, "request_irq failed\n");
 		ret = -ENODEV;
diff --git a/drivers/media/tuners/xc4000.c b/drivers/media/tuners/xc4000.c
index ef9af052007c..849df4d1c573 100644
--- a/drivers/media/tuners/xc4000.c
+++ b/drivers/media/tuners/xc4000.c
@@ -1517,10 +1517,10 @@ static int xc4000_get_frequency(struct dvb_frontend *fe, u32 *freq)
 {
 	struct xc4000_priv *priv = fe->tuner_priv;
 
+	mutex_lock(&priv->lock);
 	*freq = priv->freq_hz + priv->freq_offset;
 
 	if (debug) {
-		mutex_lock(&priv->lock);
 		if ((priv->cur_fw.type
 		     & (BASE | FM | DTV6 | DTV7 | DTV78 | DTV8)) == BASE) {
 			u16	snr = 0;
@@ -1531,8 +1531,8 @@ static int xc4000_get_frequency(struct dvb_frontend *fe, u32 *freq)
 				return 0;
 			}
 		}
-		mutex_unlock(&priv->lock);
 	}
+	mutex_unlock(&priv->lock);
 
 	dprintk(1, "%s()\n", __func__);
 
diff --git a/drivers/misc/mei/hw-me-regs.h b/drivers/misc/mei/hw-me-regs.h
index eabbdf17b0c6..28acedb10737 100644
--- a/drivers/misc/mei/hw-me-regs.h
+++ b/drivers/misc/mei/hw-me-regs.h
@@ -112,6 +112,8 @@
 #define MEI_DEV_ID_RPL_S      0x7A68  /* Raptor Lake Point S */
 
 #define MEI_DEV_ID_MTL_M      0x7E70  /* Meteor Lake Point M */
+#define MEI_DEV_ID_ARL_S      0x7F68  /* Arrow Lake Point S */
+#define MEI_DEV_ID_ARL_H      0x7770  /* Arrow Lake Point H */
 
 /*
  * MEI HW Section
diff --git a/drivers/misc/mei/pci-me.c b/drivers/misc/mei/pci-me.c
index f2765d6b8c04..91586d8afcaa 100644
--- a/drivers/misc/mei/pci-me.c
+++ b/drivers/misc/mei/pci-me.c
@@ -118,6 +118,8 @@ static const struct pci_device_id mei_me_pci_tbl[] = {
 	{MEI_PCI_DEVICE(MEI_DEV_ID_RPL_S, MEI_ME_PCH15_CFG)},
 
 	{MEI_PCI_DEVICE(MEI_DEV_ID_MTL_M, MEI_ME_PCH15_CFG)},
+	{MEI_PCI_DEVICE(MEI_DEV_ID_ARL_S, MEI_ME_PCH15_CFG)},
+	{MEI_PCI_DEVICE(MEI_DEV_ID_ARL_H, MEI_ME_PCH15_CFG)},
 
 	/* required last entry */
 	{0, }
diff --git a/drivers/misc/vmw_vmci/vmci_datagram.c b/drivers/misc/vmw_vmci/vmci_datagram.c
index f50d22882476..a0ad1f3a69f7 100644
--- a/drivers/misc/vmw_vmci/vmci_datagram.c
+++ b/drivers/misc/vmw_vmci/vmci_datagram.c
@@ -234,7 +234,8 @@ static int dg_dispatch_as_host(u32 context_id, struct vmci_datagram *dg)
 
 			dg_info->in_dg_host_queue = true;
 			dg_info->entry = dst_entry;
-			memcpy(&dg_info->msg, dg, dg_size);
+			dg_info->msg = *dg;
+			memcpy(&dg_info->msg_payload, dg + 1, dg->payload_size);
 
 			INIT_WORK(&dg_info->work, dg_delayed_dispatch);
 			schedule_work(&dg_info->work);
@@ -377,7 +378,8 @@ int vmci_datagram_invoke_guest_handler(struct vmci_datagram *dg)
 
 		dg_info->in_dg_host_queue = false;
 		dg_info->entry = dst_entry;
-		memcpy(&dg_info->msg, dg, VMCI_DG_SIZE(dg));
+		dg_info->msg = *dg;
+		memcpy(&dg_info->msg_payload, dg + 1, dg->payload_size);
 
 		INIT_WORK(&dg_info->work, dg_delayed_dispatch);
 		schedule_work(&dg_info->work);
diff --git a/drivers/mmc/core/block.c b/drivers/mmc/core/block.c
index 2058f31a1bce..71ecdb13477a 100644
--- a/drivers/mmc/core/block.c
+++ b/drivers/mmc/core/block.c
@@ -359,7 +359,7 @@ static struct mmc_blk_ioc_data *mmc_blk_ioctl_copy_from_user(
 	struct mmc_blk_ioc_data *idata;
 	int err;
 
-	idata = kmalloc(sizeof(*idata), GFP_KERNEL);
+	idata = kzalloc(sizeof(*idata), GFP_KERNEL);
 	if (!idata) {
 		err = -ENOMEM;
 		goto out;
@@ -468,7 +468,7 @@ static int __mmc_blk_ioctl_cmd(struct mmc_card *card, struct mmc_blk_data *md,
 	if (idata->flags & MMC_BLK_IOC_DROP)
 		return 0;
 
-	if (idata->flags & MMC_BLK_IOC_SBC)
+	if (idata->flags & MMC_BLK_IOC_SBC && i > 0)
 		prev_idata = idatas[i - 1];
 
 	/*
@@ -823,10 +823,11 @@ static const struct block_device_operations mmc_bdops = {
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
@@ -841,10 +842,11 @@ static int mmc_blk_part_switch_pre(struct mmc_card *card,
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
index abf36acb2641..0482920a7968 100644
--- a/drivers/mmc/host/tmio_mmc_core.c
+++ b/drivers/mmc/host/tmio_mmc_core.c
@@ -216,6 +216,8 @@ static void tmio_mmc_reset_work(struct work_struct *work)
 	else
 		mrq->cmd->error = -ETIMEDOUT;
 
+	/* No new calls yet, but disallow concurrent tmio_mmc_done_work() */
+	host->mrq = ERR_PTR(-EBUSY);
 	host->cmd = NULL;
 	host->data = NULL;
 
diff --git a/drivers/mtd/nand/raw/meson_nand.c b/drivers/mtd/nand/raw/meson_nand.c
index 6bb0fca4a91d..9a64190f30e9 100644
--- a/drivers/mtd/nand/raw/meson_nand.c
+++ b/drivers/mtd/nand/raw/meson_nand.c
@@ -59,7 +59,7 @@
 #define CMDRWGEN(cmd_dir, ran, bch, short_mode, page_size, pages)	\
 	(								\
 		(cmd_dir)			|			\
-		((ran) << 19)			|			\
+		(ran)				|			\
 		((bch) << 14)			|			\
 		((short_mode) << 13)		|			\
 		(((page_size) & 0x7f) << 6)	|			\
diff --git a/drivers/mtd/ubi/fastmap.c b/drivers/mtd/ubi/fastmap.c
index 6e95c4b1473e..8081fc760d34 100644
--- a/drivers/mtd/ubi/fastmap.c
+++ b/drivers/mtd/ubi/fastmap.c
@@ -86,9 +86,10 @@ size_t ubi_calc_fm_size(struct ubi_device *ubi)
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
index f700f0e4f2ec..6e5489e233dd 100644
--- a/drivers/mtd/ubi/vtbl.c
+++ b/drivers/mtd/ubi/vtbl.c
@@ -791,6 +791,12 @@ int ubi_read_volume_table(struct ubi_device *ubi, struct ubi_attach_info *ai)
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
diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_trace.h b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_trace.h
index 5b0b71bd6120..e8e67321e963 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_trace.h
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_trace.h
@@ -24,7 +24,7 @@ TRACE_EVENT(hclge_pf_mbx_get,
 		__field(u8, code)
 		__field(u8, subcode)
 		__string(pciname, pci_name(hdev->pdev))
-		__string(devname, &hdev->vport[0].nic.kinfo.netdev->name)
+		__string(devname, hdev->vport[0].nic.kinfo.netdev->name)
 		__array(u32, mbx_data, PF_GET_MBX_LEN)
 	),
 
@@ -33,7 +33,7 @@ TRACE_EVENT(hclge_pf_mbx_get,
 		__entry->code = req->msg.code;
 		__entry->subcode = req->msg.subcode;
 		__assign_str(pciname, pci_name(hdev->pdev));
-		__assign_str(devname, &hdev->vport[0].nic.kinfo.netdev->name);
+		__assign_str(devname, hdev->vport[0].nic.kinfo.netdev->name);
 		memcpy(__entry->mbx_data, req,
 		       sizeof(struct hclge_mbx_vf_to_pf_cmd));
 	),
@@ -56,7 +56,7 @@ TRACE_EVENT(hclge_pf_mbx_send,
 		__field(u8, vfid)
 		__field(u16, code)
 		__string(pciname, pci_name(hdev->pdev))
-		__string(devname, &hdev->vport[0].nic.kinfo.netdev->name)
+		__string(devname, hdev->vport[0].nic.kinfo.netdev->name)
 		__array(u32, mbx_data, PF_SEND_MBX_LEN)
 	),
 
@@ -64,7 +64,7 @@ TRACE_EVENT(hclge_pf_mbx_send,
 		__entry->vfid = req->dest_vfid;
 		__entry->code = req->msg.code;
 		__assign_str(pciname, pci_name(hdev->pdev));
-		__assign_str(devname, &hdev->vport[0].nic.kinfo.netdev->name);
+		__assign_str(devname, hdev->vport[0].nic.kinfo.netdev->name);
 		memcpy(__entry->mbx_data, req,
 		       sizeof(struct hclge_mbx_pf_to_vf_cmd));
 	),
diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_trace.h b/drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_trace.h
index e4bfb6191fef..a208af567909 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_trace.h
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_trace.h
@@ -23,7 +23,7 @@ TRACE_EVENT(hclge_vf_mbx_get,
 		__field(u8, vfid)
 		__field(u16, code)
 		__string(pciname, pci_name(hdev->pdev))
-		__string(devname, &hdev->nic.kinfo.netdev->name)
+		__string(devname, hdev->nic.kinfo.netdev->name)
 		__array(u32, mbx_data, VF_GET_MBX_LEN)
 	),
 
@@ -31,7 +31,7 @@ TRACE_EVENT(hclge_vf_mbx_get,
 		__entry->vfid = req->dest_vfid;
 		__entry->code = req->msg.code;
 		__assign_str(pciname, pci_name(hdev->pdev));
-		__assign_str(devname, &hdev->nic.kinfo.netdev->name);
+		__assign_str(devname, hdev->nic.kinfo.netdev->name);
 		memcpy(__entry->mbx_data, req,
 		       sizeof(struct hclge_mbx_pf_to_vf_cmd));
 	),
@@ -55,7 +55,7 @@ TRACE_EVENT(hclge_vf_mbx_send,
 		__field(u8, code)
 		__field(u8, subcode)
 		__string(pciname, pci_name(hdev->pdev))
-		__string(devname, &hdev->nic.kinfo.netdev->name)
+		__string(devname, hdev->nic.kinfo.netdev->name)
 		__array(u32, mbx_data, VF_SEND_MBX_LEN)
 	),
 
@@ -64,7 +64,7 @@ TRACE_EVENT(hclge_vf_mbx_send,
 		__entry->code = req->msg.code;
 		__entry->subcode = req->msg.subcode;
 		__assign_str(pciname, pci_name(hdev->pdev));
-		__assign_str(devname, &hdev->nic.kinfo.netdev->name);
+		__assign_str(devname, hdev->nic.kinfo.netdev->name);
 		memcpy(__entry->mbx_data, req,
 		       sizeof(struct hclge_mbx_vf_to_pf_cmd));
 	),
diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c b/drivers/net/ethernet/intel/i40e/i40e_main.c
index 58c87d79c126..6ea2d94c3dde 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_main.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
@@ -1230,8 +1230,11 @@ int i40e_count_filters(struct i40e_vsi *vsi)
 	int bkt;
 	int cnt = 0;
 
-	hash_for_each_safe(vsi->mac_filter_hash, bkt, h, f, hlist)
-		++cnt;
+	hash_for_each_safe(vsi->mac_filter_hash, bkt, h, f, hlist) {
+		if (f->state == I40E_FILTER_NEW ||
+		    f->state == I40E_FILTER_ACTIVE)
+			++cnt;
+	}
 
 	return cnt;
 }
diff --git a/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c b/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
index f79795cc9152..4f23243bbfbb 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
@@ -1573,8 +1573,8 @@ bool i40e_reset_all_vfs(struct i40e_pf *pf, bool flr)
 {
 	struct i40e_hw *hw = &pf->hw;
 	struct i40e_vf *vf;
-	int i, v;
 	u32 reg;
+	int i;
 
 	/* If we don't have any VFs, then there is nothing to reset */
 	if (!pf->num_alloc_vfs)
@@ -1585,11 +1585,10 @@ bool i40e_reset_all_vfs(struct i40e_pf *pf, bool flr)
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
@@ -1598,14 +1597,13 @@ bool i40e_reset_all_vfs(struct i40e_pf *pf, bool flr)
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
@@ -1615,7 +1613,7 @@ bool i40e_reset_all_vfs(struct i40e_pf *pf, bool flr)
 			/* If the current VF has finished resetting, move on
 			 * to the next VF in sequence.
 			 */
-			v++;
+			++vf;
 		}
 	}
 
@@ -1625,39 +1623,39 @@ bool i40e_reset_all_vfs(struct i40e_pf *pf, bool flr)
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
@@ -1666,12 +1664,12 @@ bool i40e_reset_all_vfs(struct i40e_pf *pf, bool flr)
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
diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_ipsec.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_ipsec.c
index 319620856cba..512da34e70a3 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_ipsec.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_ipsec.c
@@ -909,7 +909,13 @@ int ixgbe_ipsec_vf_add_sa(struct ixgbe_adapter *adapter, u32 *msgbuf, u32 vf)
 		goto err_out;
 	}
 
-	xs = kzalloc(sizeof(*xs), GFP_KERNEL);
+	algo = xfrm_aead_get_byname(aes_gcm_name, IXGBE_IPSEC_AUTH_BITS, 1);
+	if (unlikely(!algo)) {
+		err = -ENOENT;
+		goto err_out;
+	}
+
+	xs = kzalloc(sizeof(*xs), GFP_ATOMIC);
 	if (unlikely(!xs)) {
 		err = -ENOMEM;
 		goto err_out;
@@ -925,14 +931,8 @@ int ixgbe_ipsec_vf_add_sa(struct ixgbe_adapter *adapter, u32 *msgbuf, u32 vf)
 		memcpy(&xs->id.daddr.a4, sam->addr, sizeof(xs->id.daddr.a4));
 	xs->xso.dev = adapter->netdev;
 
-	algo = xfrm_aead_get_byname(aes_gcm_name, IXGBE_IPSEC_AUTH_BITS, 1);
-	if (unlikely(!algo)) {
-		err = -ENOENT;
-		goto err_xs;
-	}
-
 	aead_len = sizeof(*xs->aead) + IXGBE_IPSEC_KEY_BITS / 8;
-	xs->aead = kzalloc(aead_len, GFP_KERNEL);
+	xs->aead = kzalloc(aead_len, GFP_ATOMIC);
 	if (unlikely(!xs->aead)) {
 		err = -ENOMEM;
 		goto err_xs;
diff --git a/drivers/net/ethernet/marvell/octeontx2/af/cgx.c b/drivers/net/ethernet/marvell/octeontx2/af/cgx.c
index 55dfe1a20bc9..7f82baf8e740 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/cgx.c
+++ b/drivers/net/ethernet/marvell/octeontx2/af/cgx.c
@@ -403,6 +403,11 @@ int cgx_lmac_set_pause_frm(void *cgxd, int lmac_id,
 	if (!cgx || lmac_id >= cgx->lmac_count)
 		return -ENODEV;
 
+	cfg = cgx_read(cgx, lmac_id, CGXX_GMP_GMI_RXX_FRM_CTL);
+	cfg &= ~CGX_GMP_GMI_RXX_FRM_CTL_CTL_BCK;
+	cfg |= rx_pause ? CGX_GMP_GMI_RXX_FRM_CTL_CTL_BCK : 0x0;
+	cgx_write(cgx, lmac_id, CGXX_GMP_GMI_RXX_FRM_CTL, cfg);
+
 	cfg = cgx_read(cgx, lmac_id, CGXX_SMUX_RX_FRM_CTL);
 	cfg &= ~CGX_SMUX_RX_FRM_CTL_CTL_BCK;
 	cfg |= rx_pause ? CGX_SMUX_RX_FRM_CTL_CTL_BCK : 0x0;
diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c
index d6f7a2a58aee..aada28868ac5 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c
@@ -1598,7 +1598,7 @@ int otx2_open(struct net_device *netdev)
 	 * mcam entries are enabled to receive the packets. Hence disable the
 	 * packet I/O.
 	 */
-	if (err == EIO)
+	if (err == -EIO)
 		goto err_disable_rxtx;
 	else if (err)
 		goto err_tx_stop_queues;
diff --git a/drivers/net/ethernet/neterion/vxge/vxge-config.c b/drivers/net/ethernet/neterion/vxge/vxge-config.c
index f5d48d7c4ce2..da48dd85770c 100644
--- a/drivers/net/ethernet/neterion/vxge/vxge-config.c
+++ b/drivers/net/ethernet/neterion/vxge/vxge-config.c
@@ -1121,7 +1121,7 @@ static void __vxge_hw_blockpool_destroy(struct __vxge_hw_blockpool *blockpool)
 
 	list_for_each_safe(p, n, &blockpool->free_entry_list) {
 		list_del(&((struct __vxge_hw_blockpool_entry *)p)->item);
-		kfree((void *)p);
+		kfree(p);
 	}
 
 	return;
diff --git a/drivers/net/ethernet/pensando/ionic/ionic_lif.c b/drivers/net/ethernet/pensando/ionic/ionic_lif.c
index 49c28134ac2c..a37ca4b1e566 100644
--- a/drivers/net/ethernet/pensando/ionic/ionic_lif.c
+++ b/drivers/net/ethernet/pensando/ionic/ionic_lif.c
@@ -2708,9 +2708,12 @@ static int ionic_lif_adminq_init(struct ionic_lif *lif)
 
 	napi_enable(&qcq->napi);
 
-	if (qcq->flags & IONIC_QCQ_F_INTR)
+	if (qcq->flags & IONIC_QCQ_F_INTR) {
+		irq_set_affinity_hint(qcq->intr.vector,
+				      &qcq->intr.affinity_mask);
 		ionic_intr_mask(idev->intr_ctrl, qcq->intr.index,
 				IONIC_INTR_MASK_CLEAR);
+	}
 
 	qcq->flags |= IONIC_QCQ_F_INITED;
 
diff --git a/drivers/net/ethernet/realtek/r8169_main.c b/drivers/net/ethernet/realtek/r8169_main.c
index c72ff0fd38c4..c29d43c5f450 100644
--- a/drivers/net/ethernet/realtek/r8169_main.c
+++ b/drivers/net/ethernet/realtek/r8169_main.c
@@ -5181,6 +5181,15 @@ static int r8169_mdio_register(struct rtl8169_private *tp)
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
diff --git a/drivers/net/ethernet/renesas/ravb_main.c b/drivers/net/ethernet/renesas/ravb_main.c
index 8a4dff0566f7..b08478aabc6e 100644
--- a/drivers/net/ethernet/renesas/ravb_main.c
+++ b/drivers/net/ethernet/renesas/ravb_main.c
@@ -911,12 +911,12 @@ static int ravb_poll(struct napi_struct *napi, int budget)
 	int q = napi - priv->napi;
 	int mask = BIT(q);
 	int quota = budget;
+	bool unmask;
 
 	/* Processing RX Descriptor Ring */
 	/* Clear RX interrupt */
 	ravb_write(ndev, ~(mask | RIS0_RESERVED), RIS0);
-	if (ravb_rx(ndev, &quota, q))
-		goto out;
+	unmask = !ravb_rx(ndev, &quota, q);
 
 	/* Processing RX Descriptor Ring */
 	spin_lock_irqsave(&priv->lock, flags);
@@ -926,6 +926,9 @@ static int ravb_poll(struct napi_struct *napi, int budget)
 	netif_wake_subqueue(ndev, q);
 	spin_unlock_irqrestore(&priv->lock, flags);
 
+	if (!unmask)
+		goto out;
+
 	napi_complete(napi);
 
 	/* Re-enable RX/TX interrupts */
diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac4_core.c b/drivers/net/ethernet/stmicro/stmmac/dwmac4_core.c
index cd11be005390..5c6073d95f02 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac4_core.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac4_core.c
@@ -75,19 +75,41 @@ static void dwmac4_rx_queue_priority(struct mac_device_info *hw,
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
index 9a5dc5fde24a..86f70ea9a520 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_core.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_core.c
@@ -97,17 +97,41 @@ static void dwxgmac2_rx_queue_prio(struct mac_device_info *hw, u32 prio,
 				   u32 queue)
 {
 	void __iomem *ioaddr = hw->pcsr;
-	u32 value, reg;
+	u32 clear_mask = 0;
+	u32 ctrl2, ctrl3;
+	int i;
 
-	reg = (queue < 4) ? XGMAC_RXQ_CTRL2 : XGMAC_RXQ_CTRL3;
-	if (queue >= 4)
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
 
 static void dwxgmac2_tx_queue_prio(struct mac_device_info *hw, u32 prio,
diff --git a/drivers/net/ethernet/xilinx/ll_temac_main.c b/drivers/net/ethernet/xilinx/ll_temac_main.c
index da136abba152..e50b59efe188 100644
--- a/drivers/net/ethernet/xilinx/ll_temac_main.c
+++ b/drivers/net/ethernet/xilinx/ll_temac_main.c
@@ -1427,7 +1427,7 @@ static int temac_probe(struct platform_device *pdev)
 	}
 
 	/* map device registers */
-	lp->regs = devm_platform_ioremap_resource_byname(pdev, 0);
+	lp->regs = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(lp->regs)) {
 		dev_err(&pdev->dev, "could not map TEMAC registers\n");
 		return -ENOMEM;
diff --git a/drivers/net/wireguard/netlink.c b/drivers/net/wireguard/netlink.c
index f5bc279c9a8c..9dc02fa51ed0 100644
--- a/drivers/net/wireguard/netlink.c
+++ b/drivers/net/wireguard/netlink.c
@@ -164,8 +164,8 @@ get_peer(struct wg_peer *peer, struct sk_buff *skb, struct dump_ctx *ctx)
 	if (!allowedips_node)
 		goto no_allowedips;
 	if (!ctx->allowedips_seq)
-		ctx->allowedips_seq = peer->device->peer_allowedips.seq;
-	else if (ctx->allowedips_seq != peer->device->peer_allowedips.seq)
+		ctx->allowedips_seq = ctx->wg->peer_allowedips.seq;
+	else if (ctx->allowedips_seq != ctx->wg->peer_allowedips.seq)
 		goto no_allowedips;
 
 	allowedips_nest = nla_nest_start(skb, WGPEER_A_ALLOWEDIPS);
@@ -255,17 +255,17 @@ static int wg_get_device_dump(struct sk_buff *skb, struct netlink_callback *cb)
 	if (!peers_nest)
 		goto out;
 	ret = 0;
-	/* If the last cursor was removed via list_del_init in peer_remove, then
+	lockdep_assert_held(&wg->device_update_lock);
+	/* If the last cursor was removed in peer_remove or peer_remove_all, then
 	 * we just treat this the same as there being no more peers left. The
 	 * reason is that seq_nr should indicate to userspace that this isn't a
 	 * coherent dump anyway, so they'll try again.
 	 */
 	if (list_empty(&wg->peer_list) ||
-	    (ctx->next_peer && list_empty(&ctx->next_peer->peer_list))) {
+	    (ctx->next_peer && ctx->next_peer->is_dead)) {
 		nla_nest_cancel(skb, peers_nest);
 		goto out;
 	}
-	lockdep_assert_held(&wg->device_update_lock);
 	peer = list_prepare_entry(ctx->next_peer, &wg->peer_list, peer_list);
 	list_for_each_entry_continue(peer, &wg->peer_list, peer_list) {
 		if (get_peer(peer, skb, ctx)) {
diff --git a/drivers/net/wireless/ath/ath9k/antenna.c b/drivers/net/wireless/ath/ath9k/antenna.c
index 988222cea9df..acc84e6711b0 100644
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
index baf5f0afe802..fbb5e29530e3 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c
@@ -790,8 +790,7 @@ s32 brcmf_notify_escan_complete(struct brcmf_cfg80211_info *cfg,
 	scan_request = cfg->scan_request;
 	cfg->scan_request = NULL;
 
-	if (timer_pending(&cfg->escan_timeout))
-		del_timer_sync(&cfg->escan_timeout);
+	timer_delete_sync(&cfg->escan_timeout);
 
 	if (fw_abort) {
 		/* Do a scan abort to stop the driver's scan engine */
@@ -7674,6 +7673,7 @@ void brcmf_cfg80211_detach(struct brcmf_cfg80211_info *cfg)
 	brcmf_btcoex_detach(cfg);
 	wiphy_unregister(cfg->wiphy);
 	wl_deinit_priv(cfg);
+	cancel_work_sync(&cfg->escan_timeout_work);
 	brcmf_free_wiphy(cfg->wiphy);
 	kfree(cfg);
 }
diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 970a1b374a66..5242feda5471 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -3199,6 +3199,9 @@ static const struct pci_device_id nvme_id_table[] = {
 				NVME_QUIRK_BOGUS_NID, },
 	{ PCI_VDEVICE(REDHAT, 0x0010),	/* Qemu emulated controller */
 		.driver_data = NVME_QUIRK_BOGUS_NID, },
+	{ PCI_DEVICE(0x126f, 0x2262),	/* Silicon Motion generic */
+		.driver_data = NVME_QUIRK_NO_DEEPEST_PS |
+				NVME_QUIRK_BOGUS_NID, },
 	{ PCI_DEVICE(0x126f, 0x2263),	/* Silicon Motion unidentified */
 		.driver_data = NVME_QUIRK_NO_NS_DESC_LIST, },
 	{ PCI_DEVICE(0x1bb1, 0x0100),   /* Seagate Nytro Flash Storage */
diff --git a/drivers/nvmem/meson-efuse.c b/drivers/nvmem/meson-efuse.c
index d6b533497ce1..ba2714bef8d0 100644
--- a/drivers/nvmem/meson-efuse.c
+++ b/drivers/nvmem/meson-efuse.c
@@ -47,7 +47,6 @@ static int meson_efuse_probe(struct platform_device *pdev)
 	struct nvmem_config *econfig;
 	struct clk *clk;
 	unsigned int size;
-	int ret;
 
 	sm_np = of_parse_phandle(pdev->dev.of_node, "secure-monitor", 0);
 	if (!sm_np) {
@@ -60,27 +59,9 @@ static int meson_efuse_probe(struct platform_device *pdev)
 	if (!fw)
 		return -EPROBE_DEFER;
 
-	clk = devm_clk_get(dev, NULL);
-	if (IS_ERR(clk)) {
-		ret = PTR_ERR(clk);
-		if (ret != -EPROBE_DEFER)
-			dev_err(dev, "failed to get efuse gate");
-		return ret;
-	}
-
-	ret = clk_prepare_enable(clk);
-	if (ret) {
-		dev_err(dev, "failed to enable gate");
-		return ret;
-	}
-
-	ret = devm_add_action_or_reset(dev,
-				       (void(*)(void *))clk_disable_unprepare,
-				       clk);
-	if (ret) {
-		dev_err(dev, "failed to add disable callback");
-		return ret;
-	}
+	clk = devm_clk_get_enabled(dev, NULL);
+	if (IS_ERR(clk))
+		return dev_err_probe(dev, PTR_ERR(clk), "failed to get efuse gate");
 
 	if (meson_sm_call(fw, SM_EFUSE_USER_MAX, &size, 0, 0, 0, 0, 0) < 0) {
 		dev_err(dev, "failed to get max user");
diff --git a/drivers/of/dynamic.c b/drivers/of/dynamic.c
index b6a3ee65437b..4d80167d39d4 100644
--- a/drivers/of/dynamic.c
+++ b/drivers/of/dynamic.c
@@ -9,6 +9,7 @@
 
 #define pr_fmt(fmt)	"OF: " fmt
 
+#include <linux/device.h>
 #include <linux/of.h>
 #include <linux/spinlock.h>
 #include <linux/slab.h>
@@ -675,6 +676,17 @@ void of_changeset_destroy(struct of_changeset *ocs)
 {
 	struct of_changeset_entry *ce, *cen;
 
+	/*
+	 * When a device is deleted, the device links to/from it are also queued
+	 * for deletion. Until these device links are freed, the devices
+	 * themselves aren't freed. If the device being deleted is due to an
+	 * overlay change, this device might be holding a reference to a device
+	 * node that will be freed. So, wait until all already pending device
+	 * links are deleted before freeing a device node. This ensures we don't
+	 * free any device node that has a non-zero reference count.
+	 */
+	device_link_wait_removal();
+
 	list_for_each_entry_safe_reverse(ce, cen, &ocs->entries, node)
 		__of_changeset_entry_destroy(ce);
 }
diff --git a/drivers/pci/controller/dwc/pcie-designware-ep.c b/drivers/pci/controller/dwc/pcie-designware-ep.c
index 339318e790e2..8ed1df61f9c7 100644
--- a/drivers/pci/controller/dwc/pcie-designware-ep.c
+++ b/drivers/pci/controller/dwc/pcie-designware-ep.c
@@ -662,8 +662,13 @@ int dw_pcie_ep_init_complete(struct dw_pcie_ep *ep)
 		nbars = (reg & PCI_REBAR_CTRL_NBAR_MASK) >>
 			PCI_REBAR_CTRL_NBAR_SHIFT;
 
+		/*
+		 * PCIe r6.0, sec 7.8.6.2 require us to support at least one
+		 * size in the range from 1 MB to 512 GB. Advertise support
+		 * for 1 MB BAR size only.
+		 */
 		for (i = 0; i < nbars; i++, offset += PCI_REBAR_CTRL)
-			dw_pcie_writel_dbi(pci, offset + PCI_REBAR_CAP, 0x0);
+			dw_pcie_writel_dbi(pci, offset + PCI_REBAR_CAP, BIT(4));
 	}
 
 	dw_pcie_setup(pci);
diff --git a/drivers/pci/pci-driver.c b/drivers/pci/pci-driver.c
index c22cc20db1a7..ae675c5a4715 100644
--- a/drivers/pci/pci-driver.c
+++ b/drivers/pci/pci-driver.c
@@ -444,16 +444,21 @@ static int pci_device_remove(struct device *dev)
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
diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 1f8106ec7094..d1631109b142 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -31,6 +31,7 @@
 #include <linux/vmalloc.h>
 #include <asm/dma.h>
 #include <linux/aer.h>
+#include <linux/bitfield.h>
 #include "pci.h"
 
 DEFINE_MUTEX(pci_slot_mutex);
@@ -4572,13 +4573,10 @@ EXPORT_SYMBOL(pci_wait_for_pending_transaction);
  */
 bool pcie_has_flr(struct pci_dev *dev)
 {
-	u32 cap;
-
 	if (dev->dev_flags & PCI_DEV_FLAGS_NO_FLR_RESET)
 		return false;
 
-	pcie_capability_read_dword(dev, PCI_EXP_DEVCAP, &cap);
-	return cap & PCI_EXP_DEVCAP_FLR;
+	return FIELD_GET(PCI_EXP_DEVCAP_FLR, dev->devcap) == 1;
 }
 EXPORT_SYMBOL_GPL(pcie_has_flr);
 
diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index 32fa07bfc448..da40f29036d6 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -442,6 +442,15 @@ int aer_get_device_error_info(struct pci_dev *dev, struct aer_err_info *info);
 void aer_print_error(struct pci_dev *dev, struct aer_err_info *info);
 #endif	/* CONFIG_PCIEAER */
 
+#ifdef CONFIG_PCIEPORTBUS
+/* Cached RCEC Endpoint Association */
+struct rcec_ea {
+	u8		nextbusn;
+	u8		lastbusn;
+	u32		bitmap;
+};
+#endif
+
 #ifdef CONFIG_PCIE_DPC
 void pci_save_dpc_state(struct pci_dev *dev);
 void pci_restore_dpc_state(struct pci_dev *dev);
@@ -456,6 +465,14 @@ static inline void pci_dpc_init(struct pci_dev *pdev) {}
 static inline bool pci_dpc_recovered(struct pci_dev *pdev) { return false; }
 #endif
 
+#ifdef CONFIG_PCIEPORTBUS
+void pci_rcec_init(struct pci_dev *dev);
+void pci_rcec_exit(struct pci_dev *dev);
+#else
+static inline void pci_rcec_init(struct pci_dev *dev) {}
+static inline void pci_rcec_exit(struct pci_dev *dev) {}
+#endif
+
 #ifdef CONFIG_PCI_ATS
 /* Address Translation Service */
 void pci_ats_init(struct pci_dev *dev);
diff --git a/drivers/pci/pcie/Makefile b/drivers/pci/pcie/Makefile
index 9a7085668466..b2980db88cc0 100644
--- a/drivers/pci/pcie/Makefile
+++ b/drivers/pci/pcie/Makefile
@@ -2,7 +2,7 @@
 #
 # Makefile for PCI Express features and port driver
 
-pcieportdrv-y			:= portdrv_core.o portdrv_pci.o err.o
+pcieportdrv-y			:= portdrv_core.o portdrv_pci.o err.o rcec.o
 
 obj-$(CONFIG_PCIEPORTBUS)	+= pcieportdrv.o
 
diff --git a/drivers/pci/pcie/dpc.c b/drivers/pci/pcie/dpc.c
index cf0d4ba2e157..ab83f78f3eb1 100644
--- a/drivers/pci/pcie/dpc.c
+++ b/drivers/pci/pcie/dpc.c
@@ -335,11 +335,16 @@ void pci_dpc_init(struct pci_dev *pdev)
 		return;
 
 	pdev->dpc_rp_extensions = true;
-	pdev->dpc_rp_log_size = (cap & PCI_EXP_DPC_RP_PIO_LOG_SIZE) >> 8;
-	if (pdev->dpc_rp_log_size < 4 || pdev->dpc_rp_log_size > 9) {
-		pci_err(pdev, "RP PIO log size %u is invalid\n",
-			pdev->dpc_rp_log_size);
-		pdev->dpc_rp_log_size = 0;
+
+	/* Quirks may set dpc_rp_log_size if device or firmware is buggy */
+	if (!pdev->dpc_rp_log_size) {
+		pdev->dpc_rp_log_size =
+			(cap & PCI_EXP_DPC_RP_PIO_LOG_SIZE) >> 8;
+		if (pdev->dpc_rp_log_size < 4 || pdev->dpc_rp_log_size > 9) {
+			pci_err(pdev, "RP PIO log size %u is invalid\n",
+				pdev->dpc_rp_log_size);
+			pdev->dpc_rp_log_size = 0;
+		}
 	}
 }
 
diff --git a/drivers/pci/pcie/err.c b/drivers/pci/pcie/err.c
index 984aa023c753..bb4febcf45ba 100644
--- a/drivers/pci/pcie/err.c
+++ b/drivers/pci/pcie/err.c
@@ -13,6 +13,7 @@
 #define dev_fmt(fmt) "AER: " fmt
 
 #include <linux/pci.h>
+#include <linux/pm_runtime.h>
 #include <linux/module.h>
 #include <linux/kernel.h>
 #include <linux/errno.h>
@@ -79,6 +80,18 @@ static int report_error_detected(struct pci_dev *dev,
 	return 0;
 }
 
+static int pci_pm_runtime_get_sync(struct pci_dev *pdev, void *data)
+{
+	pm_runtime_get_sync(&pdev->dev);
+	return 0;
+}
+
+static int pci_pm_runtime_put(struct pci_dev *pdev, void *data)
+{
+	pm_runtime_put(&pdev->dev);
+	return 0;
+}
+
 static int report_frozen_detected(struct pci_dev *dev, void *data)
 {
 	return report_error_detected(dev, pci_channel_io_frozen, data);
@@ -176,6 +189,7 @@ pci_ers_result_t pcie_do_recovery(struct pci_dev *dev,
 	int type = pci_pcie_type(dev);
 	struct pci_dev *bridge;
 	pci_ers_result_t status = PCI_ERS_RESULT_CAN_RECOVER;
+	struct pci_host_bridge *host = pci_find_host_bridge(dev->bus);
 
 	/*
 	 * If the error was detected by a Root Port, Downstream Port, or
@@ -193,6 +207,8 @@ pci_ers_result_t pcie_do_recovery(struct pci_dev *dev,
 	else
 		bridge = pci_upstream_bridge(dev);
 
+	pci_walk_bridge(bridge, pci_pm_runtime_get_sync, NULL);
+
 	pci_dbg(bridge, "broadcast error_detected message\n");
 	if (state == pci_channel_io_frozen) {
 		pci_walk_bridge(bridge, report_frozen_detected, &status);
@@ -227,13 +243,26 @@ pci_ers_result_t pcie_do_recovery(struct pci_dev *dev,
 	pci_dbg(bridge, "broadcast resume message\n");
 	pci_walk_bridge(bridge, report_resume, &status);
 
-	if (pcie_aer_is_native(bridge))
+	/*
+	 * If we have native control of AER, clear error status in the Root
+	 * Port or Downstream Port that signaled the error.  If the
+	 * platform retained control of AER, it is responsible for clearing
+	 * this status.  In that case, the signaling device may not even be
+	 * visible to the OS.
+	 */
+	if (host->native_aer || pcie_ports_native) {
 		pcie_clear_device_status(bridge);
-	pci_aer_clear_nonfatal_status(bridge);
+		pci_aer_clear_nonfatal_status(bridge);
+	}
+
+	pci_walk_bridge(bridge, pci_pm_runtime_put, NULL);
+
 	pci_info(bridge, "device recovery successful\n");
 	return status;
 
 failed:
+	pci_walk_bridge(bridge, pci_pm_runtime_put, NULL);
+
 	pci_uevent_ers(bridge, PCI_ERS_RESULT_DISCONNECT);
 
 	/* TODO: Should kernel panic here? */
diff --git a/drivers/pci/pcie/rcec.c b/drivers/pci/pcie/rcec.c
new file mode 100644
index 000000000000..038e9d706d5f
--- /dev/null
+++ b/drivers/pci/pcie/rcec.c
@@ -0,0 +1,59 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Root Complex Event Collector Support
+ *
+ * Authors:
+ *  Sean V Kelley <sean.v.kelley@intel.com>
+ *  Qiuxu Zhuo <qiuxu.zhuo@intel.com>
+ *
+ * Copyright (C) 2020 Intel Corp.
+ */
+
+#include <linux/kernel.h>
+#include <linux/pci.h>
+#include <linux/pci_regs.h>
+
+#include "../pci.h"
+
+void pci_rcec_init(struct pci_dev *dev)
+{
+	struct rcec_ea *rcec_ea;
+	u32 rcec, hdr, busn;
+	u8 ver;
+
+	/* Only for Root Complex Event Collectors */
+	if (pci_pcie_type(dev) != PCI_EXP_TYPE_RC_EC)
+		return;
+
+	rcec = pci_find_ext_capability(dev, PCI_EXT_CAP_ID_RCEC);
+	if (!rcec)
+		return;
+
+	rcec_ea = kzalloc(sizeof(*rcec_ea), GFP_KERNEL);
+	if (!rcec_ea)
+		return;
+
+	pci_read_config_dword(dev, rcec + PCI_RCEC_RCIEP_BITMAP,
+			      &rcec_ea->bitmap);
+
+	/* Check whether RCEC BUSN register is present */
+	pci_read_config_dword(dev, rcec, &hdr);
+	ver = PCI_EXT_CAP_VER(hdr);
+	if (ver >= PCI_RCEC_BUSN_REG_VER) {
+		pci_read_config_dword(dev, rcec + PCI_RCEC_BUSN, &busn);
+		rcec_ea->nextbusn = PCI_RCEC_BUSN_NEXT(busn);
+		rcec_ea->lastbusn = PCI_RCEC_BUSN_LAST(busn);
+	} else {
+		/* Avoid later ver check by setting nextbusn */
+		rcec_ea->nextbusn = 0xff;
+		rcec_ea->lastbusn = 0x00;
+	}
+
+	dev->rcec_ea = rcec_ea;
+}
+
+void pci_rcec_exit(struct pci_dev *dev)
+{
+	kfree(dev->rcec_ea);
+	dev->rcec_ea = NULL;
+}
diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index ece90a23936d..02a75f3b5920 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -19,6 +19,7 @@
 #include <linux/hypervisor.h>
 #include <linux/irqdomain.h>
 #include <linux/pm_runtime.h>
+#include <linux/bitfield.h>
 #include "pci.h"
 
 #define CARDBUS_LATENCY_TIMER	176	/* secondary latency timer */
@@ -1496,8 +1497,8 @@ void set_pcie_port_type(struct pci_dev *pdev)
 	pdev->pcie_cap = pos;
 	pci_read_config_word(pdev, pos + PCI_EXP_FLAGS, &reg16);
 	pdev->pcie_flags_reg = reg16;
-	pci_read_config_word(pdev, pos + PCI_EXP_DEVCAP, &reg16);
-	pdev->pcie_mpss = reg16 & PCI_EXP_DEVCAP_PAYLOAD;
+	pci_read_config_dword(pdev, pos + PCI_EXP_DEVCAP, &pdev->devcap);
+	pdev->pcie_mpss = FIELD_GET(PCI_EXP_DEVCAP_PAYLOAD, pdev->devcap);
 
 	parent = pci_upstream_bridge(pdev);
 	if (!parent)
@@ -2216,6 +2217,7 @@ static void pci_configure_device(struct pci_dev *dev)
 static void pci_release_capabilities(struct pci_dev *dev)
 {
 	pci_aer_exit(dev);
+	pci_rcec_exit(dev);
 	pci_vpd_release(dev);
 	pci_iov_release(dev);
 	pci_free_cap_save_buffers(dev);
@@ -2416,6 +2418,7 @@ static void pci_init_capabilities(struct pci_dev *dev)
 	pci_ptm_init(dev);		/* Precision Time Measurement */
 	pci_aer_init(dev);		/* Advanced Error Reporting */
 	pci_dpc_init(dev);		/* Downstream Port Containment */
+	pci_rcec_init(dev);		/* Root Complex Event Collector */
 
 	pcie_report_downtraining(dev);
 
diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index 646807a443e2..60a469bdc7e3 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -12,6 +12,7 @@
  * file, where their drivers can use them.
  */
 
+#include <linux/bitfield.h>
 #include <linux/types.h>
 #include <linux/kernel.h>
 #include <linux/export.h>
@@ -5852,3 +5853,102 @@ static void nvidia_ion_ahci_fixup(struct pci_dev *pdev)
 	pdev->dev_flags |= PCI_DEV_FLAGS_HAS_MSI_MASKING;
 }
 DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_NVIDIA, 0x0ab8, nvidia_ion_ahci_fixup);
+
+static void rom_bar_overlap_defect(struct pci_dev *dev)
+{
+	pci_info(dev, "working around ROM BAR overlap defect\n");
+	dev->rom_bar_overlap = 1;
+}
+DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_INTEL, 0x1533, rom_bar_overlap_defect);
+DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_INTEL, 0x1536, rom_bar_overlap_defect);
+DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_INTEL, 0x1537, rom_bar_overlap_defect);
+DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_INTEL, 0x1538, rom_bar_overlap_defect);
+
+#ifdef CONFIG_PCIEASPM
+/*
+ * Several Intel DG2 graphics devices advertise that they can only tolerate
+ * 1us latency when transitioning from L1 to L0, which may prevent ASPM L1
+ * from being enabled.  But in fact these devices can tolerate unlimited
+ * latency.  Override their Device Capabilities value to allow ASPM L1 to
+ * be enabled.
+ */
+static void aspm_l1_acceptable_latency(struct pci_dev *dev)
+{
+	u32 l1_lat = FIELD_GET(PCI_EXP_DEVCAP_L1, dev->devcap);
+
+	if (l1_lat < 7) {
+		dev->devcap |= FIELD_PREP(PCI_EXP_DEVCAP_L1, 7);
+		pci_info(dev, "ASPM: overriding L1 acceptable latency from %#x to 0x7\n",
+			 l1_lat);
+	}
+}
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x4f80, aspm_l1_acceptable_latency);
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x4f81, aspm_l1_acceptable_latency);
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x4f82, aspm_l1_acceptable_latency);
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x4f83, aspm_l1_acceptable_latency);
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x4f84, aspm_l1_acceptable_latency);
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x4f85, aspm_l1_acceptable_latency);
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x4f86, aspm_l1_acceptable_latency);
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x4f87, aspm_l1_acceptable_latency);
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x4f88, aspm_l1_acceptable_latency);
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x5690, aspm_l1_acceptable_latency);
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x5691, aspm_l1_acceptable_latency);
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x5692, aspm_l1_acceptable_latency);
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x5693, aspm_l1_acceptable_latency);
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x5694, aspm_l1_acceptable_latency);
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x5695, aspm_l1_acceptable_latency);
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x56a0, aspm_l1_acceptable_latency);
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x56a1, aspm_l1_acceptable_latency);
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x56a2, aspm_l1_acceptable_latency);
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x56a3, aspm_l1_acceptable_latency);
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x56a4, aspm_l1_acceptable_latency);
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x56a5, aspm_l1_acceptable_latency);
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x56a6, aspm_l1_acceptable_latency);
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x56b0, aspm_l1_acceptable_latency);
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x56b1, aspm_l1_acceptable_latency);
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x56c0, aspm_l1_acceptable_latency);
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x56c1, aspm_l1_acceptable_latency);
+#endif
+
+#ifdef CONFIG_PCIE_DPC
+/*
+ * Intel Ice Lake, Tiger Lake and Alder Lake BIOS has a bug that clears
+ * the DPC RP PIO Log Size of the integrated Thunderbolt PCIe Root
+ * Ports.
+ */
+static void dpc_log_size(struct pci_dev *dev)
+{
+	u16 dpc, val;
+
+	dpc = pci_find_ext_capability(dev, PCI_EXT_CAP_ID_DPC);
+	if (!dpc)
+		return;
+
+	pci_read_config_word(dev, dpc + PCI_EXP_DPC_CAP, &val);
+	if (!(val & PCI_EXP_DPC_CAP_RP_EXT))
+		return;
+
+	if (!((val & PCI_EXP_DPC_RP_PIO_LOG_SIZE) >> 8)) {
+		pci_info(dev, "Overriding RP PIO Log Size to 4\n");
+		dev->dpc_rp_log_size = 4;
+	}
+}
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x461f, dpc_log_size);
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x462f, dpc_log_size);
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x463f, dpc_log_size);
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x466e, dpc_log_size);
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x8a1d, dpc_log_size);
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x8a1f, dpc_log_size);
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x8a21, dpc_log_size);
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x8a23, dpc_log_size);
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x9a23, dpc_log_size);
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x9a25, dpc_log_size);
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x9a27, dpc_log_size);
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x9a29, dpc_log_size);
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x9a2b, dpc_log_size);
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x9a2d, dpc_log_size);
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x9a2f, dpc_log_size);
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x9a31, dpc_log_size);
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0xa73f, dpc_log_size);
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0xa76e, dpc_log_size);
+#endif
diff --git a/drivers/pci/setup-res.c b/drivers/pci/setup-res.c
index 875d50c16f19..b492e67c3d87 100644
--- a/drivers/pci/setup-res.c
+++ b/drivers/pci/setup-res.c
@@ -75,12 +75,16 @@ static void pci_std_update_resource(struct pci_dev *dev, int resno)
 		 * as zero when disabled, so don't update ROM BARs unless
 		 * they're enabled.  See
 		 * https://lore.kernel.org/r/43147B3D.1030309@vc.cvut.cz/
+		 * But we must update ROM BAR for buggy devices where even a
+		 * disabled ROM can conflict with other BARs.
 		 */
-		if (!(res->flags & IORESOURCE_ROM_ENABLE))
+		if (!(res->flags & IORESOURCE_ROM_ENABLE) &&
+		    !dev->rom_bar_overlap)
 			return;
 
 		reg = dev->rom_base_reg;
-		new |= PCI_ROM_ADDRESS_ENABLE;
+		if (res->flags & IORESOURCE_ROM_ENABLE)
+			new |= PCI_ROM_ADDRESS_ENABLE;
 	} else
 		return;
 
diff --git a/drivers/phy/tegra/xusb.c b/drivers/phy/tegra/xusb.c
index 8f11b293c48d..856397def89a 100644
--- a/drivers/phy/tegra/xusb.c
+++ b/drivers/phy/tegra/xusb.c
@@ -1399,6 +1399,19 @@ int tegra_xusb_padctl_get_usb3_companion(struct tegra_xusb_padctl *padctl,
 }
 EXPORT_SYMBOL_GPL(tegra_xusb_padctl_get_usb3_companion);
 
+int tegra_xusb_padctl_get_port_number(struct phy *phy)
+{
+	struct tegra_xusb_lane *lane;
+
+	if (!phy)
+		return -ENODEV;
+
+	lane = phy_get_drvdata(phy);
+
+	return lane->index;
+}
+EXPORT_SYMBOL_GPL(tegra_xusb_padctl_get_port_number);
+
 MODULE_AUTHOR("Thierry Reding <treding@nvidia.com>");
 MODULE_DESCRIPTION("Tegra XUSB Pad Controller driver");
 MODULE_LICENSE("GPL v2");
diff --git a/drivers/pinctrl/renesas/core.c b/drivers/pinctrl/renesas/core.c
index 54f1a7334027..c39085448368 100644
--- a/drivers/pinctrl/renesas/core.c
+++ b/drivers/pinctrl/renesas/core.c
@@ -868,9 +868,11 @@ static void __init sh_pfc_check_cfg_reg(const char *drvname,
 		sh_pfc_err("reg 0x%x: var_field_width declares %u instead of %u bits\n",
 			   cfg_reg->reg, rw, cfg_reg->reg_width);
 
-	if (n != cfg_reg->nr_enum_ids)
+	if (n != cfg_reg->nr_enum_ids) {
 		sh_pfc_err("reg 0x%x: enum_ids[] has %u instead of %u values\n",
 			   cfg_reg->reg, cfg_reg->nr_enum_ids, n);
+		n = cfg_reg->nr_enum_ids;
+	}
 
 check_enum_ids:
 	sh_pfc_check_reg_enums(drvname, cfg_reg->reg, cfg_reg->enum_ids, n);
diff --git a/drivers/platform/x86/touchscreen_dmi.c b/drivers/platform/x86/touchscreen_dmi.c
index ebe959db1eeb..fbaa61859462 100644
--- a/drivers/platform/x86/touchscreen_dmi.c
+++ b/drivers/platform/x86/touchscreen_dmi.c
@@ -1084,6 +1084,15 @@ const struct dmi_system_id touchscreen_dmi_table[] = {
 			DMI_MATCH(DMI_BIOS_VERSION, "CHUWI.D86JLBNR"),
 		},
 	},
+	{
+		/* Chuwi Vi8 dual-boot (CWI506) */
+		.driver_data = (void *)&chuwi_vi8_data,
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "Insyde"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "i86"),
+			DMI_MATCH(DMI_BIOS_VERSION, "CHUWI2.D86JHBNR02"),
+		},
+	},
 	{
 		/* Chuwi Vi8 Plus (CWI519) */
 		.driver_data = (void *)&chuwi_vi8_plus_data,
diff --git a/drivers/s390/crypto/zcrypt_api.c b/drivers/s390/crypto/zcrypt_api.c
index b518009715ee..dde10a5c7d50 100644
--- a/drivers/s390/crypto/zcrypt_api.c
+++ b/drivers/s390/crypto/zcrypt_api.c
@@ -576,6 +576,7 @@ static inline struct zcrypt_queue *zcrypt_pick_queue(struct zcrypt_card *zc,
 {
 	if (!zq || !try_module_get(zq->queue->ap_dev.drv->driver.owner))
 		return NULL;
+	zcrypt_card_get(zc);
 	zcrypt_queue_get(zq);
 	get_device(&zq->queue->ap_dev.device);
 	atomic_add(weight, &zc->load);
@@ -595,6 +596,7 @@ static inline void zcrypt_drop_queue(struct zcrypt_card *zc,
 	atomic_sub(weight, &zq->load);
 	put_device(&zq->queue->ap_dev.device);
 	zcrypt_queue_put(zq);
+	zcrypt_card_put(zc);
 	module_put(mod);
 }
 
diff --git a/drivers/scsi/hosts.c b/drivers/scsi/hosts.c
index 59eb6c296986..297f2b412d07 100644
--- a/drivers/scsi/hosts.c
+++ b/drivers/scsi/hosts.c
@@ -334,12 +334,13 @@ static void scsi_host_dev_release(struct device *dev)
 
 	if (shost->shost_state == SHOST_CREATED) {
 		/*
-		 * Free the shost_dev device name here if scsi_host_alloc()
-		 * and scsi_host_put() have been called but neither
+		 * Free the shost_dev device name and remove the proc host dir
+		 * here if scsi_host_{alloc,put}() have been called but neither
 		 * scsi_host_add() nor scsi_host_remove() has been called.
 		 * This avoids that the memory allocated for the shost_dev
-		 * name is leaked.
+		 * name as well as the proc dir structure are leaked.
 		 */
+		scsi_proc_hostdir_rm(shost->hostt);
 		kfree(dev_name(&shost->shost_dev));
 	}
 
diff --git a/drivers/scsi/lpfc/lpfc_nportdisc.c b/drivers/scsi/lpfc/lpfc_nportdisc.c
index 1e22364a31fc..d6287c58d504 100644
--- a/drivers/scsi/lpfc/lpfc_nportdisc.c
+++ b/drivers/scsi/lpfc/lpfc_nportdisc.c
@@ -784,8 +784,10 @@ lpfc_rcv_padisc(struct lpfc_vport *vport, struct lpfc_nodelist *ndlp,
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
index deab8931ab48..59dc37925122 100644
--- a/drivers/scsi/lpfc/lpfc_nvmet.c
+++ b/drivers/scsi/lpfc/lpfc_nvmet.c
@@ -1579,7 +1579,7 @@ lpfc_nvmet_setup_io_context(struct lpfc_hba *phba)
 		wqe = &nvmewqe->wqe;
 
 		/* Initialize WQE */
-		memset(wqe, 0, sizeof(union lpfc_wqe));
+		memset(wqe, 0, sizeof(*wqe));
 
 		ctx_buf->iocbq->context1 = NULL;
 		spin_lock(&phba->sli4_hba.sgl_list_lock);
diff --git a/drivers/scsi/myrb.c b/drivers/scsi/myrb.c
index ad17c2beaaca..d4c3f00faf1b 100644
--- a/drivers/scsi/myrb.c
+++ b/drivers/scsi/myrb.c
@@ -1803,9 +1803,9 @@ static ssize_t raid_state_show(struct device *dev,
 
 		name = myrb_devstate_name(ldev_info->state);
 		if (name)
-			ret = snprintf(buf, 32, "%s\n", name);
+			ret = snprintf(buf, 64, "%s\n", name);
 		else
-			ret = snprintf(buf, 32, "Invalid (%02X)\n",
+			ret = snprintf(buf, 64, "Invalid (%02X)\n",
 				       ldev_info->state);
 	} else {
 		struct myrb_pdev_state *pdev_info = sdev->hostdata;
@@ -1824,9 +1824,9 @@ static ssize_t raid_state_show(struct device *dev,
 		else
 			name = myrb_devstate_name(pdev_info->state);
 		if (name)
-			ret = snprintf(buf, 32, "%s\n", name);
+			ret = snprintf(buf, 64, "%s\n", name);
 		else
-			ret = snprintf(buf, 32, "Invalid (%02X)\n",
+			ret = snprintf(buf, 64, "Invalid (%02X)\n",
 				       pdev_info->state);
 	}
 	return ret;
@@ -1914,11 +1914,11 @@ static ssize_t raid_level_show(struct device *dev,
 
 		name = myrb_raidlevel_name(ldev_info->raid_level);
 		if (!name)
-			return snprintf(buf, 32, "Invalid (%02X)\n",
+			return snprintf(buf, 64, "Invalid (%02X)\n",
 					ldev_info->state);
-		return snprintf(buf, 32, "%s\n", name);
+		return snprintf(buf, 64, "%s\n", name);
 	}
-	return snprintf(buf, 32, "Physical Drive\n");
+	return snprintf(buf, 64, "Physical Drive\n");
 }
 static DEVICE_ATTR_RO(raid_level);
 
@@ -1931,15 +1931,15 @@ static ssize_t rebuild_show(struct device *dev,
 	unsigned char status;
 
 	if (sdev->channel < myrb_logical_channel(sdev->host))
-		return snprintf(buf, 32, "physical device - not rebuilding\n");
+		return snprintf(buf, 64, "physical device - not rebuilding\n");
 
 	status = myrb_get_rbld_progress(cb, &rbld_buf);
 
 	if (rbld_buf.ldev_num != sdev->id ||
 	    status != MYRB_STATUS_SUCCESS)
-		return snprintf(buf, 32, "not rebuilding\n");
+		return snprintf(buf, 64, "not rebuilding\n");
 
-	return snprintf(buf, 32, "rebuilding block %u of %u\n",
+	return snprintf(buf, 64, "rebuilding block %u of %u\n",
 			rbld_buf.ldev_size - rbld_buf.blocks_left,
 			rbld_buf.ldev_size);
 }
diff --git a/drivers/scsi/myrs.c b/drivers/scsi/myrs.c
index e6a6678967e5..857a73e856a1 100644
--- a/drivers/scsi/myrs.c
+++ b/drivers/scsi/myrs.c
@@ -950,9 +950,9 @@ static ssize_t raid_state_show(struct device *dev,
 
 		name = myrs_devstate_name(ldev_info->dev_state);
 		if (name)
-			ret = snprintf(buf, 32, "%s\n", name);
+			ret = snprintf(buf, 64, "%s\n", name);
 		else
-			ret = snprintf(buf, 32, "Invalid (%02X)\n",
+			ret = snprintf(buf, 64, "Invalid (%02X)\n",
 				       ldev_info->dev_state);
 	} else {
 		struct myrs_pdev_info *pdev_info;
@@ -961,9 +961,9 @@ static ssize_t raid_state_show(struct device *dev,
 		pdev_info = sdev->hostdata;
 		name = myrs_devstate_name(pdev_info->dev_state);
 		if (name)
-			ret = snprintf(buf, 32, "%s\n", name);
+			ret = snprintf(buf, 64, "%s\n", name);
 		else
-			ret = snprintf(buf, 32, "Invalid (%02X)\n",
+			ret = snprintf(buf, 64, "Invalid (%02X)\n",
 				       pdev_info->dev_state);
 	}
 	return ret;
@@ -1069,13 +1069,13 @@ static ssize_t raid_level_show(struct device *dev,
 		ldev_info = sdev->hostdata;
 		name = myrs_raid_level_name(ldev_info->raid_level);
 		if (!name)
-			return snprintf(buf, 32, "Invalid (%02X)\n",
+			return snprintf(buf, 64, "Invalid (%02X)\n",
 					ldev_info->dev_state);
 
 	} else
 		name = myrs_raid_level_name(MYRS_RAID_PHYSICAL);
 
-	return snprintf(buf, 32, "%s\n", name);
+	return snprintf(buf, 64, "%s\n", name);
 }
 static DEVICE_ATTR_RO(raid_level);
 
@@ -1089,7 +1089,7 @@ static ssize_t rebuild_show(struct device *dev,
 	unsigned char status;
 
 	if (sdev->channel < cs->ctlr_info->physchan_present)
-		return snprintf(buf, 32, "physical device - not rebuilding\n");
+		return snprintf(buf, 64, "physical device - not rebuilding\n");
 
 	ldev_info = sdev->hostdata;
 	ldev_num = ldev_info->ldev_num;
@@ -1101,11 +1101,11 @@ static ssize_t rebuild_show(struct device *dev,
 		return -EIO;
 	}
 	if (ldev_info->rbld_active) {
-		return snprintf(buf, 32, "rebuilding block %zu of %zu\n",
+		return snprintf(buf, 64, "rebuilding block %zu of %zu\n",
 				(size_t)ldev_info->rbld_lba,
 				(size_t)ldev_info->cfg_devsize);
 	} else
-		return snprintf(buf, 32, "not rebuilding\n");
+		return snprintf(buf, 64, "not rebuilding\n");
 }
 
 static ssize_t rebuild_store(struct device *dev,
@@ -1194,7 +1194,7 @@ static ssize_t consistency_check_show(struct device *dev,
 	unsigned char status;
 
 	if (sdev->channel < cs->ctlr_info->physchan_present)
-		return snprintf(buf, 32, "physical device - not checking\n");
+		return snprintf(buf, 64, "physical device - not checking\n");
 
 	ldev_info = sdev->hostdata;
 	if (!ldev_info)
@@ -1202,11 +1202,11 @@ static ssize_t consistency_check_show(struct device *dev,
 	ldev_num = ldev_info->ldev_num;
 	status = myrs_get_ldev_info(cs, ldev_num, ldev_info);
 	if (ldev_info->cc_active)
-		return snprintf(buf, 32, "checking block %zu of %zu\n",
+		return snprintf(buf, 64, "checking block %zu of %zu\n",
 				(size_t)ldev_info->cc_lba,
 				(size_t)ldev_info->cfg_devsize);
 	else
-		return snprintf(buf, 32, "not checking\n");
+		return snprintf(buf, 64, "not checking\n");
 }
 
 static ssize_t consistency_check_store(struct device *dev,
diff --git a/drivers/scsi/qla2xxx/qla_attr.c b/drivers/scsi/qla2xxx/qla_attr.c
index f919da0bbf75..e23a93374eaf 100644
--- a/drivers/scsi/qla2xxx/qla_attr.c
+++ b/drivers/scsi/qla2xxx/qla_attr.c
@@ -2689,7 +2689,13 @@ qla2x00_dev_loss_tmo_callbk(struct fc_rport *rport)
 		return;
 
 	if (unlikely(pci_channel_offline(fcport->vha->hw->pdev))) {
-		qla2x00_abort_all_cmds(fcport->vha, DID_NO_CONNECT << 16);
+		/* Will wait for wind down of adapter */
+		ql_dbg(ql_dbg_aer, fcport->vha, 0x900c,
+		    "%s pci offline detected (id %06x)\n", __func__,
+		    fcport->d_id.b24);
+		qla_pci_set_eeh_busy(fcport->vha);
+		qla2x00_eh_wait_for_pending_commands(fcport->vha, fcport->d_id.b24,
+		    0, WAIT_TARGET);
 		return;
 	}
 }
@@ -2711,7 +2717,11 @@ qla2x00_terminate_rport_io(struct fc_rport *rport)
 	vha = fcport->vha;
 
 	if (unlikely(pci_channel_offline(fcport->vha->hw->pdev))) {
-		qla2x00_abort_all_cmds(fcport->vha, DID_NO_CONNECT << 16);
+		/* Will wait for wind down of adapter */
+		ql_dbg(ql_dbg_aer, fcport->vha, 0x900b,
+		    "%s pci offline detected (id %06x)\n", __func__,
+		    fcport->d_id.b24);
+		qla_pci_set_eeh_busy(vha);
 		qla2x00_eh_wait_for_pending_commands(fcport->vha, fcport->d_id.b24,
 			0, WAIT_TARGET);
 		return;
diff --git a/drivers/scsi/qla2xxx/qla_def.h b/drivers/scsi/qla2xxx/qla_def.h
index 6645b69fc2a0..b8628bceb3ae 100644
--- a/drivers/scsi/qla2xxx/qla_def.h
+++ b/drivers/scsi/qla2xxx/qla_def.h
@@ -56,7 +56,7 @@ typedef struct {
 #include "qla_nvme.h"
 #define QLA2XXX_DRIVER_NAME	"qla2xxx"
 #define QLA2XXX_APIDEV		"ql2xapidev"
-#define QLA2XXX_MANUFACTURER	"QLogic Corporation"
+#define QLA2XXX_MANUFACTURER	"Marvell"
 
 /*
  * We have MAILBOX_REGISTER_COUNT sized arrays in a few places,
diff --git a/drivers/scsi/qla2xxx/qla_gs.c b/drivers/scsi/qla2xxx/qla_gs.c
index 20bbd69e35e5..d9ac17dbad78 100644
--- a/drivers/scsi/qla2xxx/qla_gs.c
+++ b/drivers/scsi/qla2xxx/qla_gs.c
@@ -1614,7 +1614,7 @@ qla2x00_hba_attributes(scsi_qla_host_t *vha, void *entries,
 	eiter->type = cpu_to_be16(FDMI_HBA_MANUFACTURER);
 	alen = scnprintf(
 		eiter->a.manufacturer, sizeof(eiter->a.manufacturer),
-		"%s", "QLogic Corporation");
+		"%s", QLA2XXX_MANUFACTURER);
 	alen += FDMI_ATTR_ALIGNMENT(alen);
 	alen += FDMI_ATTR_TYPELEN(eiter);
 	eiter->len = cpu_to_be16(alen);
diff --git a/drivers/scsi/qla2xxx/qla_init.c b/drivers/scsi/qla2xxx/qla_init.c
index a8d2c06285c2..3d56f971cdc4 100644
--- a/drivers/scsi/qla2xxx/qla_init.c
+++ b/drivers/scsi/qla2xxx/qla_init.c
@@ -2280,6 +2280,40 @@ qla83xx_nic_core_fw_load(scsi_qla_host_t *vha)
 	return rval;
 }
 
+static void qla_enable_fce_trace(scsi_qla_host_t *vha)
+{
+	int rval;
+	struct qla_hw_data *ha = vha->hw;
+
+	if (ha->fce) {
+		ha->flags.fce_enabled = 1;
+		memset(ha->fce, 0, fce_calc_size(ha->fce_bufs));
+		rval = qla2x00_enable_fce_trace(vha,
+		    ha->fce_dma, ha->fce_bufs, ha->fce_mb, &ha->fce_bufs);
+
+		if (rval) {
+			ql_log(ql_log_warn, vha, 0x8033,
+			    "Unable to reinitialize FCE (%d).\n", rval);
+			ha->flags.fce_enabled = 0;
+		}
+	}
+}
+
+static void qla_enable_eft_trace(scsi_qla_host_t *vha)
+{
+	int rval;
+	struct qla_hw_data *ha = vha->hw;
+
+	if (ha->eft) {
+		memset(ha->eft, 0, EFT_SIZE);
+		rval = qla2x00_enable_eft_trace(vha, ha->eft_dma, EFT_NUM_BUFFERS);
+
+		if (rval) {
+			ql_log(ql_log_warn, vha, 0x8034,
+			    "Unable to reinitialize EFT (%d).\n", rval);
+		}
+	}
+}
 /*
 * qla2x00_initialize_adapter
 *      Initialize board.
@@ -3230,9 +3264,8 @@ qla24xx_chip_diag(scsi_qla_host_t *vha)
 }
 
 static void
-qla2x00_init_fce_trace(scsi_qla_host_t *vha)
+qla2x00_alloc_fce_trace(scsi_qla_host_t *vha)
 {
-	int rval;
 	dma_addr_t tc_dma;
 	void *tc;
 	struct qla_hw_data *ha = vha->hw;
@@ -3261,27 +3294,17 @@ qla2x00_init_fce_trace(scsi_qla_host_t *vha)
 		return;
 	}
 
-	rval = qla2x00_enable_fce_trace(vha, tc_dma, FCE_NUM_BUFFERS,
-					ha->fce_mb, &ha->fce_bufs);
-	if (rval) {
-		ql_log(ql_log_warn, vha, 0x00bf,
-		       "Unable to initialize FCE (%d).\n", rval);
-		dma_free_coherent(&ha->pdev->dev, FCE_SIZE, tc, tc_dma);
-		return;
-	}
-
 	ql_dbg(ql_dbg_init, vha, 0x00c0,
 	       "Allocated (%d KB) for FCE...\n", FCE_SIZE / 1024);
 
-	ha->flags.fce_enabled = 1;
 	ha->fce_dma = tc_dma;
 	ha->fce = tc;
+	ha->fce_bufs = FCE_NUM_BUFFERS;
 }
 
 static void
-qla2x00_init_eft_trace(scsi_qla_host_t *vha)
+qla2x00_alloc_eft_trace(scsi_qla_host_t *vha)
 {
-	int rval;
 	dma_addr_t tc_dma;
 	void *tc;
 	struct qla_hw_data *ha = vha->hw;
@@ -3306,14 +3329,6 @@ qla2x00_init_eft_trace(scsi_qla_host_t *vha)
 		return;
 	}
 
-	rval = qla2x00_enable_eft_trace(vha, tc_dma, EFT_NUM_BUFFERS);
-	if (rval) {
-		ql_log(ql_log_warn, vha, 0x00c2,
-		       "Unable to initialize EFT (%d).\n", rval);
-		dma_free_coherent(&ha->pdev->dev, EFT_SIZE, tc, tc_dma);
-		return;
-	}
-
 	ql_dbg(ql_dbg_init, vha, 0x00c3,
 	       "Allocated (%d KB) EFT ...\n", EFT_SIZE / 1024);
 
@@ -3321,13 +3336,6 @@ qla2x00_init_eft_trace(scsi_qla_host_t *vha)
 	ha->eft = tc;
 }
 
-static void
-qla2x00_alloc_offload_mem(scsi_qla_host_t *vha)
-{
-	qla2x00_init_fce_trace(vha);
-	qla2x00_init_eft_trace(vha);
-}
-
 void
 qla2x00_alloc_fw_dump(scsi_qla_host_t *vha)
 {
@@ -3382,10 +3390,10 @@ qla2x00_alloc_fw_dump(scsi_qla_host_t *vha)
 		if (ha->tgt.atio_ring)
 			mq_size += ha->tgt.atio_q_length * sizeof(request_t);
 
-		qla2x00_init_fce_trace(vha);
+		qla2x00_alloc_fce_trace(vha);
 		if (ha->fce)
 			fce_size = sizeof(struct qla2xxx_fce_chain) + FCE_SIZE;
-		qla2x00_init_eft_trace(vha);
+		qla2x00_alloc_eft_trace(vha);
 		if (ha->eft)
 			eft_size = EFT_SIZE;
 	}
@@ -3784,7 +3792,6 @@ qla2x00_setup_chip(scsi_qla_host_t *vha)
 	struct qla_hw_data *ha = vha->hw;
 	struct device_reg_2xxx __iomem *reg = &ha->iobase->isp;
 	unsigned long flags;
-	uint16_t fw_major_version;
 	int done_once = 0;
 
 	if (IS_P3P_TYPE(ha)) {
@@ -3851,7 +3858,6 @@ qla2x00_setup_chip(scsi_qla_host_t *vha)
 					goto failed;
 
 enable_82xx_npiv:
-				fw_major_version = ha->fw_major_version;
 				if (IS_P3P_TYPE(ha))
 					qla82xx_check_md_needed(vha);
 				else
@@ -3880,12 +3886,11 @@ qla2x00_setup_chip(scsi_qla_host_t *vha)
 				if (rval != QLA_SUCCESS)
 					goto failed;
 
-				if (!fw_major_version && !(IS_P3P_TYPE(ha)))
-					qla2x00_alloc_offload_mem(vha);
-
 				if (ql2xallocfwdump && !(IS_P3P_TYPE(ha)))
 					qla2x00_alloc_fw_dump(vha);
 
+				qla_enable_fce_trace(vha);
+				qla_enable_eft_trace(vha);
 			} else {
 				goto failed;
 			}
@@ -7012,7 +7017,6 @@ qla2x00_abort_isp_cleanup(scsi_qla_host_t *vha)
 int
 qla2x00_abort_isp(scsi_qla_host_t *vha)
 {
-	int rval;
 	uint8_t        status = 0;
 	struct qla_hw_data *ha = vha->hw;
 	struct scsi_qla_host *vp;
@@ -7100,31 +7104,7 @@ qla2x00_abort_isp(scsi_qla_host_t *vha)
 
 			if (IS_QLA81XX(ha) || IS_QLA8031(ha))
 				qla2x00_get_fw_version(vha);
-			if (ha->fce) {
-				ha->flags.fce_enabled = 1;
-				memset(ha->fce, 0,
-				    fce_calc_size(ha->fce_bufs));
-				rval = qla2x00_enable_fce_trace(vha,
-				    ha->fce_dma, ha->fce_bufs, ha->fce_mb,
-				    &ha->fce_bufs);
-				if (rval) {
-					ql_log(ql_log_warn, vha, 0x8033,
-					    "Unable to reinitialize FCE "
-					    "(%d).\n", rval);
-					ha->flags.fce_enabled = 0;
-				}
-			}
 
-			if (ha->eft) {
-				memset(ha->eft, 0, EFT_SIZE);
-				rval = qla2x00_enable_eft_trace(vha,
-				    ha->eft_dma, EFT_NUM_BUFFERS);
-				if (rval) {
-					ql_log(ql_log_warn, vha, 0x8034,
-					    "Unable to reinitialize EFT "
-					    "(%d).\n", rval);
-				}
-			}
 		} else {	/* failed the ISP abort */
 			vha->flags.online = 1;
 			if (test_bit(ISP_ABORT_RETRY, &vha->dpc_flags)) {
diff --git a/drivers/scsi/qla2xxx/qla_target.c b/drivers/scsi/qla2xxx/qla_target.c
index fdb424501da5..d2433f162815 100644
--- a/drivers/scsi/qla2xxx/qla_target.c
+++ b/drivers/scsi/qla2xxx/qla_target.c
@@ -1038,6 +1038,16 @@ void qlt_free_session_done(struct work_struct *work)
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
diff --git a/drivers/scsi/sd.c b/drivers/scsi/sd.c
index 58f66176bcb2..f2dfd9853d34 100644
--- a/drivers/scsi/sd.c
+++ b/drivers/scsi/sd.c
@@ -3026,8 +3026,13 @@ static void sd_read_block_characteristics(struct scsi_disk *sdkp)
 	}
 
 	if (sdkp->device->type == TYPE_ZBC) {
-		/* Host-managed */
+		/*
+		 * Host-managed: Per ZBC and ZAC specifications, writes in
+		 * sequential write required zones of host-managed devices must
+		 * be aligned to the device physical block size.
+		 */
 		blk_queue_set_zoned(sdkp->disk, BLK_ZONED_HM);
+		blk_queue_zone_write_granularity(q, sdkp->physical_block_size);
 	} else {
 		sdkp->zoned = (buffer[8] >> 4) & 3;
 		if (sdkp->zoned == 1) {
diff --git a/drivers/slimbus/core.c b/drivers/slimbus/core.c
index 1d2bc181da05..69f6178f294c 100644
--- a/drivers/slimbus/core.c
+++ b/drivers/slimbus/core.c
@@ -438,8 +438,8 @@ static int slim_device_alloc_laddr(struct slim_device *sbdev,
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
index feb97470699d..7abc9b6a04ab 100644
--- a/drivers/soc/fsl/qbman/qman.c
+++ b/drivers/soc/fsl/qbman/qman.c
@@ -991,7 +991,7 @@ struct qman_portal {
 	/* linked-list of CSCN handlers. */
 	struct list_head cgr_cbs;
 	/* list lock */
-	spinlock_t cgr_lock;
+	raw_spinlock_t cgr_lock;
 	struct work_struct congestion_work;
 	struct work_struct mr_work;
 	char irqname[MAX_IRQNAME];
@@ -1281,7 +1281,7 @@ static int qman_create_portal(struct qman_portal *portal,
 		/* if the given mask is NULL, assume all CGRs can be seen */
 		qman_cgrs_fill(&portal->cgrs[0]);
 	INIT_LIST_HEAD(&portal->cgr_cbs);
-	spin_lock_init(&portal->cgr_lock);
+	raw_spin_lock_init(&portal->cgr_lock);
 	INIT_WORK(&portal->congestion_work, qm_congestion_task);
 	INIT_WORK(&portal->mr_work, qm_mr_process_task);
 	portal->bits = 0;
@@ -1456,11 +1456,14 @@ static void qm_congestion_task(struct work_struct *work)
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
@@ -1476,7 +1479,7 @@ static void qm_congestion_task(struct work_struct *work)
 	list_for_each_entry(cgr, &p->cgr_cbs, node)
 		if (cgr->cb && qman_cgrs_get(&c, cgr->cgrid))
 			cgr->cb(p, cgr, qman_cgrs_get(&rr, cgr->cgrid));
-	spin_unlock(&p->cgr_lock);
+	raw_spin_unlock_irq(&p->cgr_lock);
 	qman_p_irqsource_add(p, QM_PIRQ_CSCI);
 }
 
@@ -2440,7 +2443,7 @@ int qman_create_cgr(struct qman_cgr *cgr, u32 flags,
 	preempt_enable();
 
 	cgr->chan = p->config->channel;
-	spin_lock(&p->cgr_lock);
+	raw_spin_lock_irq(&p->cgr_lock);
 
 	if (opts) {
 		struct qm_mcc_initcgr local_opts = *opts;
@@ -2477,19 +2480,14 @@ int qman_create_cgr(struct qman_cgr *cgr, u32 flags,
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
@@ -2497,12 +2495,27 @@ int qman_delete_cgr(struct qman_cgr *cgr)
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
@@ -2527,8 +2540,7 @@ int qman_delete_cgr(struct qman_cgr *cgr)
 		/* add back to the list */
 		list_add(&cgr->node, &p->cgr_cbs);
 release_lock:
-	spin_unlock_irqrestore(&p->cgr_lock, irqflags);
-put_portal:
+	raw_spin_unlock_irqrestore(&p->cgr_lock, irqflags);
 	put_affine_portal();
 	return ret;
 }
@@ -2559,6 +2571,54 @@ void qman_delete_cgr_safe(struct qman_cgr *cgr)
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
index cbc225eb1991..bea9a3adf08c 100644
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
diff --git a/drivers/staging/media/ipu3/ipu3-v4l2.c b/drivers/staging/media/ipu3/ipu3-v4l2.c
index 103f84466f6f..371117b511e2 100644
--- a/drivers/staging/media/ipu3/ipu3-v4l2.c
+++ b/drivers/staging/media/ipu3/ipu3-v4l2.c
@@ -1063,6 +1063,11 @@ static int imgu_v4l2_subdev_register(struct imgu_device *imgu,
 	struct imgu_media_pipe *imgu_pipe = &imgu->imgu_pipe[pipe];
 
 	/* Initialize subdev media entity */
+	imgu_sd->subdev.entity.ops = &imgu_media_ops;
+	for (i = 0; i < IMGU_NODE_NUM; i++) {
+		imgu_sd->subdev_pads[i].flags = imgu_pipe->nodes[i].output ?
+			MEDIA_PAD_FL_SINK : MEDIA_PAD_FL_SOURCE;
+	}
 	r = media_entity_pads_init(&imgu_sd->subdev.entity, IMGU_NODE_NUM,
 				   imgu_sd->subdev_pads);
 	if (r) {
@@ -1070,11 +1075,6 @@ static int imgu_v4l2_subdev_register(struct imgu_device *imgu,
 			"failed initialize subdev media entity (%d)\n", r);
 		return r;
 	}
-	imgu_sd->subdev.entity.ops = &imgu_media_ops;
-	for (i = 0; i < IMGU_NODE_NUM; i++) {
-		imgu_sd->subdev_pads[i].flags = imgu_pipe->nodes[i].output ?
-			MEDIA_PAD_FL_SINK : MEDIA_PAD_FL_SOURCE;
-	}
 
 	/* Initialize subdev */
 	v4l2_subdev_init(&imgu_sd->subdev, &imgu_subdev_ops);
@@ -1169,15 +1169,15 @@ static int imgu_v4l2_node_setup(struct imgu_device *imgu, unsigned int pipe,
 	}
 
 	/* Initialize media entities */
+	node->vdev_pad.flags = node->output ?
+		MEDIA_PAD_FL_SOURCE : MEDIA_PAD_FL_SINK;
+	vdev->entity.ops = NULL;
 	r = media_entity_pads_init(&vdev->entity, 1, &node->vdev_pad);
 	if (r) {
 		dev_err(dev, "failed initialize media entity (%d)\n", r);
 		mutex_destroy(&node->lock);
 		return r;
 	}
-	node->vdev_pad.flags = node->output ?
-		MEDIA_PAD_FL_SOURCE : MEDIA_PAD_FL_SINK;
-	vdev->entity.ops = NULL;
 
 	/* Initialize vbq */
 	vbq->type = node->vdev_fmt.type;
diff --git a/drivers/staging/vc04_services/vchiq-mmal/mmal-vchiq.c b/drivers/staging/vc04_services/vchiq-mmal/mmal-vchiq.c
index d697ea55a0da..3306ec5bb291 100644
--- a/drivers/staging/vc04_services/vchiq-mmal/mmal-vchiq.c
+++ b/drivers/staging/vc04_services/vchiq-mmal/mmal-vchiq.c
@@ -940,8 +940,9 @@ static int create_component(struct vchiq_mmal_instance *instance,
 	/* build component create message */
 	m.h.type = MMAL_MSG_TYPE_COMPONENT_CREATE;
 	m.u.component_create.client_component = component->client_component;
-	strncpy(m.u.component_create.name, name,
-		sizeof(m.u.component_create.name));
+	strscpy_pad(m.u.component_create.name, name,
+		    sizeof(m.u.component_create.name));
+	m.u.component_create.pid = 0;
 
 	ret = send_synchronous_mmal_msg(instance, &m,
 					sizeof(m.u.component_create),
diff --git a/drivers/tee/optee/device.c b/drivers/tee/optee/device.c
index 3cb39f02fae0..26683697ca30 100644
--- a/drivers/tee/optee/device.c
+++ b/drivers/tee/optee/device.c
@@ -90,13 +90,14 @@ static int optee_register_device(const uuid_t *device_uuid, u32 func)
 	if (rc) {
 		pr_err("device registration failed, err: %d\n", rc);
 		put_device(&optee_device->dev);
+		return rc;
 	}
 
 	if (func == PTA_CMD_GET_DEVICES_SUPP)
 		device_create_file(&optee_device->dev,
 				   &dev_attr_need_supplicant);
 
-	return rc;
+	return 0;
 }
 
 static int __optee_enumerate_devices(u32 func)
diff --git a/drivers/tty/n_gsm.c b/drivers/tty/n_gsm.c
index fa49529682ce..c20f69a4c5e9 100644
--- a/drivers/tty/n_gsm.c
+++ b/drivers/tty/n_gsm.c
@@ -2661,6 +2661,9 @@ static int gsmld_open(struct tty_struct *tty)
 {
 	struct gsm_mux *gsm;
 
+	if (!capable(CAP_NET_ADMIN))
+		return -EPERM;
+
 	if (tty->ops->write == NULL)
 		return -EINVAL;
 
diff --git a/drivers/tty/serial/8250/8250_port.c b/drivers/tty/serial/8250/8250_port.c
index 8b49ac4856d2..6098e87a3404 100644
--- a/drivers/tty/serial/8250/8250_port.c
+++ b/drivers/tty/serial/8250/8250_port.c
@@ -1358,9 +1358,6 @@ static void autoconfig_irq(struct uart_8250_port *up)
 		inb_p(ICP);
 	}
 
-	if (uart_console(port))
-		console_lock();
-
 	/* forget possible initially masked and pending IRQ */
 	probe_irq_off(probe_irq_on());
 	save_mcr = serial8250_in_MCR(up);
@@ -1391,9 +1388,6 @@ static void autoconfig_irq(struct uart_8250_port *up)
 	if (port->flags & UPF_FOURPORT)
 		outb_p(save_ICP, ICP);
 
-	if (uart_console(port))
-		console_unlock();
-
 	port->irq = (irq > 0) ? irq : 0;
 }
 
diff --git a/drivers/tty/serial/fsl_lpuart.c b/drivers/tty/serial/fsl_lpuart.c
index 227fb2d32046..b16ad6db1ef8 100644
--- a/drivers/tty/serial/fsl_lpuart.c
+++ b/drivers/tty/serial/fsl_lpuart.c
@@ -2178,9 +2178,12 @@ lpuart32_set_termios(struct uart_port *port, struct ktermios *termios,
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
 
 	if (old && sport->lpuart_dma_rx_use) {
 		if (!lpuart_start_rx_dma(sport))
diff --git a/drivers/tty/serial/max310x.c b/drivers/tty/serial/max310x.c
index 5570fd3b84e1..363b68555fe6 100644
--- a/drivers/tty/serial/max310x.c
+++ b/drivers/tty/serial/max310x.c
@@ -1636,13 +1636,16 @@ static unsigned short max310x_i2c_slave_addr(unsigned short addr,
 
 static int max310x_i2c_probe(struct i2c_client *client)
 {
-	const struct max310x_devtype *devtype =
-			device_get_match_data(&client->dev);
+	const struct max310x_devtype *devtype;
 	struct i2c_client *port_client;
 	struct regmap *regmaps[4];
 	unsigned int i;
 	u8 port_addr;
 
+	devtype = device_get_match_data(&client->dev);
+	if (!devtype)
+		return dev_err_probe(&client->dev, -ENODEV, "Failed to match device\n");
+
 	if (client->addr < devtype->slave_addr.min ||
 		client->addr > devtype->slave_addr.max)
 		return dev_err_probe(&client->dev, -EINVAL,
diff --git a/drivers/tty/serial/sc16is7xx.c b/drivers/tty/serial/sc16is7xx.c
index 31e0c5c3ddea..29f05db0d49b 100644
--- a/drivers/tty/serial/sc16is7xx.c
+++ b/drivers/tty/serial/sc16is7xx.c
@@ -376,9 +376,7 @@ static void sc16is7xx_fifo_read(struct uart_port *port, unsigned int rxlen)
 	const u8 line = sc16is7xx_line(port);
 	u8 addr = (SC16IS7XX_RHR_REG << SC16IS7XX_REG_SHIFT) | line;
 
-	regcache_cache_bypass(s->regmap, true);
-	regmap_raw_read(s->regmap, addr, s->buf, rxlen);
-	regcache_cache_bypass(s->regmap, false);
+	regmap_noinc_read(s->regmap, addr, s->buf, rxlen);
 }
 
 static void sc16is7xx_fifo_write(struct uart_port *port, u8 to_send)
@@ -394,9 +392,7 @@ static void sc16is7xx_fifo_write(struct uart_port *port, u8 to_send)
 	if (unlikely(!to_send))
 		return;
 
-	regcache_cache_bypass(s->regmap, true);
-	regmap_raw_write(s->regmap, addr, s->buf, to_send);
-	regcache_cache_bypass(s->regmap, false);
+	regmap_noinc_write(s->regmap, addr, s->buf, to_send);
 }
 
 static void sc16is7xx_port_update(struct uart_port *port, u8 reg,
@@ -489,6 +485,11 @@ static bool sc16is7xx_regmap_precious(struct device *dev, unsigned int reg)
 	return false;
 }
 
+static bool sc16is7xx_regmap_noinc(struct device *dev, unsigned int reg)
+{
+	return reg == SC16IS7XX_RHR_REG;
+}
+
 static int sc16is7xx_set_baud(struct uart_port *port, int baud)
 {
 	struct sc16is7xx_port *s = dev_get_drvdata(port->dev);
@@ -1439,6 +1440,8 @@ static struct regmap_config regcfg = {
 	.cache_type = REGCACHE_RBTREE,
 	.volatile_reg = sc16is7xx_regmap_volatile,
 	.precious_reg = sc16is7xx_regmap_precious,
+	.writeable_noinc_reg = sc16is7xx_regmap_noinc,
+	.readable_noinc_reg = sc16is7xx_regmap_noinc,
 };
 
 #ifdef CONFIG_SERIAL_SC16IS7XX_SPI
diff --git a/drivers/tty/serial/serial_core.c b/drivers/tty/serial/serial_core.c
index 40fff38588d4..10b8785b9982 100644
--- a/drivers/tty/serial/serial_core.c
+++ b/drivers/tty/serial/serial_core.c
@@ -2431,7 +2431,12 @@ uart_configure_port(struct uart_driver *drv, struct uart_state *state,
 			port->type = PORT_UNKNOWN;
 			flags |= UART_CONFIG_TYPE;
 		}
+		/* Synchronize with possible boot console. */
+		if (uart_console(port))
+			console_lock();
 		port->ops->config_port(port, flags);
+		if (uart_console(port))
+			console_unlock();
 	}
 
 	if (port->type != PORT_UNKNOWN) {
@@ -2439,6 +2444,10 @@ uart_configure_port(struct uart_driver *drv, struct uart_state *state,
 
 		uart_report_port(drv, port);
 
+		/* Synchronize with possible boot console. */
+		if (uart_console(port))
+			console_lock();
+
 		/* Power up port for set_mctrl() */
 		uart_change_pm(state, UART_PM_STATE_ON);
 
@@ -2455,6 +2464,9 @@ uart_configure_port(struct uart_driver *drv, struct uart_state *state,
 			port->rs485_config(port, &port->rs485);
 		spin_unlock_irqrestore(&port->lock, flags);
 
+		if (uart_console(port))
+			console_unlock();
+
 		/*
 		 * If this driver supports console, and it hasn't been
 		 * successfully registered yet, try to re-register it.
diff --git a/drivers/tty/vt/vt.c b/drivers/tty/vt/vt.c
index df645d127e40..a070f2e7d960 100644
--- a/drivers/tty/vt/vt.c
+++ b/drivers/tty/vt/vt.c
@@ -398,7 +398,7 @@ static void vc_uniscr_delete(struct vc_data *vc, unsigned int nr)
 		char32_t *ln = uniscr->lines[vc->state.y];
 		unsigned int x = vc->state.x, cols = vc->vc_cols;
 
-		memcpy(&ln[x], &ln[x + nr], (cols - x - nr) * sizeof(*ln));
+		memmove(&ln[x], &ln[x + nr], (cols - x - nr) * sizeof(*ln));
 		memset32(&ln[cols - nr], ' ', nr);
 	}
 }
diff --git a/drivers/usb/class/cdc-wdm.c b/drivers/usb/class/cdc-wdm.c
index 80332b6a1963..58423b16022b 100644
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
diff --git a/drivers/usb/core/hub.c b/drivers/usb/core/hub.c
index 91b974aa59bf..eef78141ffca 100644
--- a/drivers/usb/core/hub.c
+++ b/drivers/usb/core/hub.c
@@ -116,7 +116,6 @@ EXPORT_SYMBOL_GPL(ehci_cf_port_reset_rwsem);
 #define HUB_DEBOUNCE_STEP	  25
 #define HUB_DEBOUNCE_STABLE	 100
 
-static void hub_release(struct kref *kref);
 static int usb_reset_and_verify_device(struct usb_device *udev);
 static int hub_port_disable(struct usb_hub *hub, int port1, int set_state);
 static bool hub_port_warm_reset_required(struct usb_hub *hub, int port1,
@@ -678,14 +677,14 @@ static void kick_hub_wq(struct usb_hub *hub)
 	 */
 	intf = to_usb_interface(hub->intfdev);
 	usb_autopm_get_interface_no_resume(intf);
-	kref_get(&hub->kref);
+	hub_get(hub);
 
 	if (queue_work(hub_wq, &hub->events))
 		return;
 
 	/* the work has already been scheduled */
 	usb_autopm_put_interface_async(intf);
-	kref_put(&hub->kref, hub_release);
+	hub_put(hub);
 }
 
 void usb_kick_hub_wq(struct usb_device *hdev)
@@ -1053,7 +1052,7 @@ static void hub_activate(struct usb_hub *hub, enum hub_activation_type type)
 			goto init2;
 		goto init3;
 	}
-	kref_get(&hub->kref);
+	hub_get(hub);
 
 	/* The superspeed hub except for root hub has to use Hub Depth
 	 * value as an offset into the route string to locate the bits
@@ -1301,7 +1300,7 @@ static void hub_activate(struct usb_hub *hub, enum hub_activation_type type)
 		device_unlock(&hdev->dev);
 	}
 
-	kref_put(&hub->kref, hub_release);
+	hub_put(hub);
 }
 
 /* Implement the continuations for the delays above */
@@ -1717,6 +1716,16 @@ static void hub_release(struct kref *kref)
 	kfree(hub);
 }
 
+void hub_get(struct usb_hub *hub)
+{
+	kref_get(&hub->kref);
+}
+
+void hub_put(struct usb_hub *hub)
+{
+	kref_put(&hub->kref, hub_release);
+}
+
 static unsigned highspeed_hubs;
 
 static void hub_disconnect(struct usb_interface *intf)
@@ -1763,7 +1772,7 @@ static void hub_disconnect(struct usb_interface *intf)
 	if (hub->quirk_disable_autosuspend)
 		usb_autopm_put_interface(intf);
 
-	kref_put(&hub->kref, hub_release);
+	hub_put(hub);
 }
 
 static bool hub_descriptor_is_sane(struct usb_host_interface *desc)
@@ -5857,7 +5866,7 @@ static void hub_event(struct work_struct *work)
 
 	/* Balance the stuff in kick_hub_wq() and allow autosuspend */
 	usb_autopm_put_interface(intf);
-	kref_put(&hub->kref, hub_release);
+	hub_put(hub);
 
 	kcov_remote_stop();
 }
diff --git a/drivers/usb/core/hub.h b/drivers/usb/core/hub.h
index db4c7e2c5960..dd049bc85f88 100644
--- a/drivers/usb/core/hub.h
+++ b/drivers/usb/core/hub.h
@@ -117,6 +117,8 @@ extern void usb_hub_remove_port_device(struct usb_hub *hub,
 extern int usb_hub_set_port_power(struct usb_device *hdev, struct usb_hub *hub,
 		int port1, bool set);
 extern struct usb_hub *usb_hub_to_struct_hub(struct usb_device *hdev);
+extern void hub_get(struct usb_hub *hub);
+extern void hub_put(struct usb_hub *hub);
 extern int hub_port_debounce(struct usb_hub *hub, int port1,
 		bool must_be_connected);
 extern int usb_clear_port_feature(struct usb_device *hdev,
diff --git a/drivers/usb/core/port.c b/drivers/usb/core/port.c
index 235a7c645503..336ecf6e1967 100644
--- a/drivers/usb/core/port.c
+++ b/drivers/usb/core/port.c
@@ -450,7 +450,7 @@ static int match_location(struct usb_device *peer_hdev, void *p)
 	struct usb_hub *peer_hub = usb_hub_to_struct_hub(peer_hdev);
 	struct usb_device *hdev = to_usb_device(port_dev->dev.parent->parent);
 
-	if (!peer_hub)
+	if (!peer_hub || port_dev->connect_type == USB_PORT_NOT_USED)
 		return 0;
 
 	hcd = bus_to_hcd(hdev->bus);
@@ -461,7 +461,8 @@ static int match_location(struct usb_device *peer_hdev, void *p)
 
 	for (port1 = 1; port1 <= peer_hdev->maxchild; port1++) {
 		peer = peer_hub->ports[port1 - 1];
-		if (peer && peer->location == port_dev->location) {
+		if (peer && peer->connect_type != USB_PORT_NOT_USED &&
+		    peer->location == port_dev->location) {
 			link_peers_report(port_dev, peer);
 			return 1; /* done */
 		}
diff --git a/drivers/usb/core/sysfs.c b/drivers/usb/core/sysfs.c
index 35ce8b87e939..366c09521785 100644
--- a/drivers/usb/core/sysfs.c
+++ b/drivers/usb/core/sysfs.c
@@ -1166,14 +1166,24 @@ static ssize_t interface_authorized_store(struct device *dev,
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
index 03d16a08261d..03cc331d3b93 100644
--- a/drivers/usb/dwc2/core.h
+++ b/drivers/usb/dwc2/core.h
@@ -748,8 +748,14 @@ struct dwc2_dregs_backup {
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
@@ -757,8 +763,14 @@ struct dwc2_dregs_backup {
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
@@ -1097,6 +1109,7 @@ struct dwc2_hsotg {
 	bool needs_byte_swap;
 
 	/* DWC OTG HW Release versions */
+#define DWC2_CORE_REV_4_30a	0x4f54430a
 #define DWC2_CORE_REV_2_71a	0x4f54271a
 #define DWC2_CORE_REV_2_72a     0x4f54272a
 #define DWC2_CORE_REV_2_80a	0x4f54280a
@@ -1335,6 +1348,7 @@ int dwc2_backup_global_registers(struct dwc2_hsotg *hsotg);
 int dwc2_restore_global_registers(struct dwc2_hsotg *hsotg);
 
 void dwc2_enable_acg(struct dwc2_hsotg *hsotg);
+void dwc2_wakeup_from_lpm_l1(struct dwc2_hsotg *hsotg, bool remotewakeup);
 
 /* This function should be called on every hardware interrupt. */
 irqreturn_t dwc2_handle_common_intr(int irq, void *dev);
diff --git a/drivers/usb/dwc2/core_intr.c b/drivers/usb/dwc2/core_intr.c
index e3f429f1575e..8deb2ea214b0 100644
--- a/drivers/usb/dwc2/core_intr.c
+++ b/drivers/usb/dwc2/core_intr.c
@@ -344,10 +344,11 @@ static void dwc2_handle_session_req_intr(struct dwc2_hsotg *hsotg)
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
@@ -356,37 +357,57 @@ static void dwc2_wakeup_from_lpm_l1(struct dwc2_hsotg *hsotg)
 
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
@@ -407,7 +428,7 @@ static void dwc2_handle_wakeup_detected_intr(struct dwc2_hsotg *hsotg)
 	dev_dbg(hsotg->dev, "%s lxstate = %d\n", __func__, hsotg->lx_state);
 
 	if (hsotg->lx_state == DWC2_L1) {
-		dwc2_wakeup_from_lpm_l1(hsotg);
+		dwc2_wakeup_from_lpm_l1(hsotg, false);
 		return;
 	}
 
diff --git a/drivers/usb/dwc2/gadget.c b/drivers/usb/dwc2/gadget.c
index da0df69cc234..d8b83665581f 100644
--- a/drivers/usb/dwc2/gadget.c
+++ b/drivers/usb/dwc2/gadget.c
@@ -1416,6 +1416,10 @@ static int dwc2_hsotg_ep_queue(struct usb_ep *ep, struct usb_request *req,
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
index 14925fedb01a..9c32a64bc8c2 100644
--- a/drivers/usb/dwc2/hcd.c
+++ b/drivers/usb/dwc2/hcd.c
@@ -2736,8 +2736,11 @@ enum dwc2_transaction_type dwc2_hcd_select_transactions(
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
@@ -2770,8 +2773,11 @@ enum dwc2_transaction_type dwc2_hcd_select_transactions(
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
@@ -4125,6 +4131,8 @@ void dwc2_host_complete(struct dwc2_hsotg *hsotg, struct dwc2_qtd *qtd,
 			 urb->actual_length);
 
 	if (usb_pipetype(urb->pipe) == PIPE_ISOCHRONOUS) {
+		if (!hsotg->params.dma_desc_enable)
+			urb->start_frame = qtd->qh->start_active_frame;
 		urb->error_count = dwc2_hcd_urb_get_error_count(qtd->urb);
 		for (i = 0; i < urb->number_of_packets; ++i) {
 			urb->iso_frame_desc[i].actual_length =
@@ -5319,9 +5327,16 @@ int dwc2_backup_host_registers(struct dwc2_hsotg *hsotg)
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
@@ -5355,10 +5370,17 @@ int dwc2_restore_host_registers(struct dwc2_hsotg *hsotg)
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
@@ -5523,10 +5545,12 @@ int dwc2_host_exit_hibernation(struct dwc2_hsotg *hsotg, int rem_wakeup,
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
@@ -5551,6 +5575,13 @@ int dwc2_host_exit_hibernation(struct dwc2_hsotg *hsotg, int rem_wakeup,
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
index c3d6dde2aca4..6ad7ba054432 100644
--- a/drivers/usb/dwc2/hw.h
+++ b/drivers/usb/dwc2/hw.h
@@ -727,7 +727,7 @@
 #define TXSTS_QTOP_TOKEN_MASK		(0x3 << 25)
 #define TXSTS_QTOP_TOKEN_SHIFT		25
 #define TXSTS_QTOP_TERMINATE		BIT(24)
-#define TXSTS_QSPCAVAIL_MASK		(0xff << 16)
+#define TXSTS_QSPCAVAIL_MASK		(0x7f << 16)
 #define TXSTS_QSPCAVAIL_SHIFT		16
 #define TXSTS_FSPCAVAIL_MASK		(0xffff << 0)
 #define TXSTS_FSPCAVAIL_SHIFT		0
diff --git a/drivers/usb/gadget/function/f_ncm.c b/drivers/usb/gadget/function/f_ncm.c
index 8fac7a67db76..752951b56ad3 100644
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
index 7b3c0787d5a4..e80aa717c8b5 100644
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
diff --git a/drivers/usb/gadget/udc/tegra-xudc.c b/drivers/usb/gadget/udc/tegra-xudc.c
index c5f0fbb8ffe4..9d3e36c867e8 100644
--- a/drivers/usb/gadget/udc/tegra-xudc.c
+++ b/drivers/usb/gadget/udc/tegra-xudc.c
@@ -3480,8 +3480,8 @@ static void tegra_xudc_device_params_init(struct tegra_xudc *xudc)
 
 static int tegra_xudc_phy_get(struct tegra_xudc *xudc)
 {
-	int err = 0, usb3;
-	unsigned int i;
+	int err = 0, usb3_companion_port;
+	unsigned int i, j;
 
 	xudc->utmi_phy = devm_kcalloc(xudc->dev, xudc->soc->num_phys,
 					   sizeof(*xudc->utmi_phy), GFP_KERNEL);
@@ -3508,10 +3508,8 @@ static int tegra_xudc_phy_get(struct tegra_xudc *xudc)
 		xudc->utmi_phy[i] = devm_phy_optional_get(xudc->dev, phy_name);
 		if (IS_ERR(xudc->utmi_phy[i])) {
 			err = PTR_ERR(xudc->utmi_phy[i]);
-			if (err != -EPROBE_DEFER)
-				dev_err(xudc->dev, "failed to get usb2-%d PHY: %d\n",
-					i, err);
-
+			dev_err_probe(xudc->dev, err,
+				"failed to get PHY for phy-name usb2-%d\n", i);
 			goto clean_up;
 		} else if (xudc->utmi_phy[i]) {
 			/* Get usb-phy, if utmi phy is available */
@@ -3530,21 +3528,30 @@ static int tegra_xudc_phy_get(struct tegra_xudc *xudc)
 		}
 
 		/* Get USB3 phy */
-		usb3 = tegra_xusb_padctl_get_usb3_companion(xudc->padctl, i);
-		if (usb3 < 0)
+		usb3_companion_port = tegra_xusb_padctl_get_usb3_companion(xudc->padctl, i);
+		if (usb3_companion_port < 0)
 			continue;
 
-		snprintf(phy_name, sizeof(phy_name), "usb3-%d", usb3);
-		xudc->usb3_phy[i] = devm_phy_optional_get(xudc->dev, phy_name);
-		if (IS_ERR(xudc->usb3_phy[i])) {
-			err = PTR_ERR(xudc->usb3_phy[i]);
-			if (err != -EPROBE_DEFER)
-				dev_err(xudc->dev, "failed to get usb3-%d PHY: %d\n",
-					usb3, err);
-
-			goto clean_up;
-		} else if (xudc->usb3_phy[i])
-			dev_dbg(xudc->dev, "usb3-%d PHY registered", usb3);
+		for (j = 0; j < xudc->soc->num_phys; j++) {
+			snprintf(phy_name, sizeof(phy_name), "usb3-%d", j);
+			xudc->usb3_phy[i] = devm_phy_optional_get(xudc->dev, phy_name);
+			if (IS_ERR(xudc->usb3_phy[i])) {
+				err = PTR_ERR(xudc->usb3_phy[i]);
+				dev_err_probe(xudc->dev, err,
+					"failed to get PHY for phy-name usb3-%d\n", j);
+				goto clean_up;
+			} else if (xudc->usb3_phy[i]) {
+				int usb2_port =
+					tegra_xusb_padctl_get_port_number(xudc->utmi_phy[i]);
+				int usb3_port =
+					tegra_xusb_padctl_get_port_number(xudc->usb3_phy[i]);
+				if (usb3_port == usb3_companion_port) {
+					dev_dbg(xudc->dev, "USB2 port %d is paired with USB3 port %d for device mode port %d\n",
+					 usb2_port, usb3_port, i);
+					break;
+				}
+			}
+		}
 	}
 
 	return err;
@@ -3781,9 +3788,7 @@ static int tegra_xudc_probe(struct platform_device *pdev)
 
 	err = devm_clk_bulk_get(&pdev->dev, xudc->soc->num_clks, xudc->clks);
 	if (err) {
-		if (err != -EPROBE_DEFER)
-			dev_err(xudc->dev, "failed to request clocks: %d\n", err);
-
+		dev_err_probe(xudc->dev, err, "failed to request clocks\n");
 		return err;
 	}
 
@@ -3798,9 +3803,7 @@ static int tegra_xudc_probe(struct platform_device *pdev)
 	err = devm_regulator_bulk_get(&pdev->dev, xudc->soc->num_supplies,
 				      xudc->supplies);
 	if (err) {
-		if (err != -EPROBE_DEFER)
-			dev_err(xudc->dev, "failed to request regulators: %d\n", err);
-
+		dev_err_probe(xudc->dev, err, "failed to request regulators\n");
 		return err;
 	}
 
diff --git a/drivers/usb/host/sl811-hcd.c b/drivers/usb/host/sl811-hcd.c
index 9465fce99c82..f803079a9f26 100644
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
diff --git a/drivers/usb/phy/phy-generic.c b/drivers/usb/phy/phy-generic.c
index 34b9f8140187..661a229c105d 100644
--- a/drivers/usb/phy/phy-generic.c
+++ b/drivers/usb/phy/phy-generic.c
@@ -268,13 +268,6 @@ int usb_phy_gen_create_phy(struct device *dev, struct usb_phy_generic *nop)
 			return -EPROBE_DEFER;
 	}
 
-	nop->vbus_draw = devm_regulator_get_exclusive(dev, "vbus");
-	if (PTR_ERR(nop->vbus_draw) == -ENODEV)
-		nop->vbus_draw = NULL;
-	if (IS_ERR(nop->vbus_draw))
-		return dev_err_probe(dev, PTR_ERR(nop->vbus_draw),
-				     "could not get vbus regulator\n");
-
 	nop->dev		= dev;
 	nop->phy.dev		= nop->dev;
 	nop->phy.label		= "nop-xceiv";
diff --git a/drivers/usb/serial/cp210x.c b/drivers/usb/serial/cp210x.c
index d161b64416a4..294f7f01656a 100644
--- a/drivers/usb/serial/cp210x.c
+++ b/drivers/usb/serial/cp210x.c
@@ -60,6 +60,8 @@ static const struct usb_device_id id_table[] = {
 	{ USB_DEVICE(0x0471, 0x066A) }, /* AKTAKOM ACE-1001 cable */
 	{ USB_DEVICE(0x0489, 0xE000) }, /* Pirelli Broadband S.p.A, DP-L10 SIP/GSM Mobile */
 	{ USB_DEVICE(0x0489, 0xE003) }, /* Pirelli Broadband S.p.A, DP-L10 SIP/GSM Mobile */
+	{ USB_DEVICE(0x04BF, 0x1301) }, /* TDK Corporation NC0110013M - Network Controller */
+	{ USB_DEVICE(0x04BF, 0x1303) }, /* TDK Corporation MM0110113M - i3 Micro Module */
 	{ USB_DEVICE(0x0745, 0x1000) }, /* CipherLab USB CCD Barcode Scanner 1000 */
 	{ USB_DEVICE(0x0846, 0x1100) }, /* NetGear Managed Switch M4100 series, M5300 series, M7100 series */
 	{ USB_DEVICE(0x08e6, 0x5501) }, /* Gemalto Prox-PU/CU contactless smartcard reader */
@@ -148,6 +150,7 @@ static const struct usb_device_id id_table[] = {
 	{ USB_DEVICE(0x10C4, 0x85EA) }, /* AC-Services IBUS-IF */
 	{ USB_DEVICE(0x10C4, 0x85EB) }, /* AC-Services CIS-IBUS */
 	{ USB_DEVICE(0x10C4, 0x85F8) }, /* Virtenio Preon32 */
+	{ USB_DEVICE(0x10C4, 0x863C) }, /* MGP Instruments PDS100 */
 	{ USB_DEVICE(0x10C4, 0x8664) }, /* AC-Services CAN-IF */
 	{ USB_DEVICE(0x10C4, 0x8665) }, /* AC-Services OBD-IF */
 	{ USB_DEVICE(0x10C4, 0x87ED) }, /* IMST USB-Stick for Smart Meter */
@@ -181,6 +184,7 @@ static const struct usb_device_id id_table[] = {
 	{ USB_DEVICE(0x10C4, 0xF004) }, /* Elan Digital Systems USBcount50 */
 	{ USB_DEVICE(0x10C5, 0xEA61) }, /* Silicon Labs MobiData GPRS USB Modem */
 	{ USB_DEVICE(0x10CE, 0xEA6A) }, /* Silicon Labs MobiData GPRS USB Modem 100EU */
+	{ USB_DEVICE(0x11CA, 0x0212) }, /* Verifone USB to Printer (UART, CP2102) */
 	{ USB_DEVICE(0x12B8, 0xEC60) }, /* Link G4 ECU */
 	{ USB_DEVICE(0x12B8, 0xEC62) }, /* Link G4+ ECU */
 	{ USB_DEVICE(0x13AD, 0x9999) }, /* Baltech card reader */
diff --git a/drivers/usb/serial/ftdi_sio.c b/drivers/usb/serial/ftdi_sio.c
index 4d7f4a4ab69f..66aa999efa6d 100644
--- a/drivers/usb/serial/ftdi_sio.c
+++ b/drivers/usb/serial/ftdi_sio.c
@@ -1055,6 +1055,8 @@ static const struct usb_device_id id_table_combined[] = {
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
index 43e8cb17b4c7..fb1eba835e50 100644
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
index 3c76336e43bb..1d22db59f7bd 100644
--- a/drivers/usb/storage/isd200.c
+++ b/drivers/usb/storage/isd200.c
@@ -1105,7 +1105,7 @@ static void isd200_dump_driveid(struct us_data *us, u16 *id)
 static int isd200_get_inquiry_data( struct us_data *us )
 {
 	struct isd200_info *info = (struct isd200_info *)us->extra;
-	int retStatus = ISD200_GOOD;
+	int retStatus;
 	u16 *id = info->id;
 
 	usb_stor_dbg(us, "Entering isd200_get_inquiry_data\n");
@@ -1137,6 +1137,13 @@ static int isd200_get_inquiry_data( struct us_data *us )
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
@@ -1202,6 +1209,7 @@ static int isd200_get_inquiry_data( struct us_data *us )
 		}
 	}
 
+ Done:
 	usb_stor_dbg(us, "Leaving isd200_get_inquiry_data %08X\n", retStatus);
 
 	return(retStatus);
@@ -1481,22 +1489,27 @@ static int isd200_init_info(struct us_data *us)
 
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
 
 
diff --git a/drivers/usb/typec/tcpm/tcpci.c b/drivers/usb/typec/tcpm/tcpci.c
index e34e46df8024..33c67adf7c67 100644
--- a/drivers/usb/typec/tcpm/tcpci.c
+++ b/drivers/usb/typec/tcpm/tcpci.c
@@ -732,6 +732,7 @@ MODULE_DEVICE_TABLE(i2c, tcpci_id);
 #ifdef CONFIG_OF
 static const struct of_device_id tcpci_of_match[] = {
 	{ .compatible = "nxp,ptn5110", },
+	{ .compatible = "tcpci", },
 	{},
 };
 MODULE_DEVICE_TABLE(of, tcpci_of_match);
diff --git a/drivers/usb/typec/ucsi/ucsi.c b/drivers/usb/typec/ucsi/ucsi.c
index cd3689005c31..2ddc8936a893 100644
--- a/drivers/usb/typec/ucsi/ucsi.c
+++ b/drivers/usb/typec/ucsi/ucsi.c
@@ -138,8 +138,12 @@ static int ucsi_exec_command(struct ucsi *ucsi, u64 cmd)
 	if (!(cci & UCSI_CCI_COMMAND_COMPLETE))
 		return -EIO;
 
-	if (cci & UCSI_CCI_NOT_SUPPORTED)
+	if (cci & UCSI_CCI_NOT_SUPPORTED) {
+		if (ucsi_acknowledge_command(ucsi) < 0)
+			dev_err(ucsi->dev,
+				"ACK of unsupported command failed\n");
 		return -EOPNOTSUPP;
+	}
 
 	if (cci & UCSI_CCI_ERROR) {
 		if (cmd == UCSI_GET_ERROR_STATUS)
@@ -848,13 +852,47 @@ static int ucsi_reset_connector(struct ucsi_connector *con, bool hard)
 
 static int ucsi_reset_ppm(struct ucsi *ucsi)
 {
-	u64 command = UCSI_PPM_RESET;
+	u64 command;
 	unsigned long tmo;
 	u32 cci;
 	int ret;
 
 	mutex_lock(&ucsi->ppm_lock);
 
+	ret = ucsi->ops->read(ucsi, UCSI_CCI, &cci, sizeof(cci));
+	if (ret < 0)
+		goto out;
+
+	/*
+	 * If UCSI_CCI_RESET_COMPLETE is already set we must clear
+	 * the flag before we start another reset. Send a
+	 * UCSI_SET_NOTIFICATION_ENABLE command to achieve this.
+	 * Ignore a timeout and try the reset anyway if this fails.
+	 */
+	if (cci & UCSI_CCI_RESET_COMPLETE) {
+		command = UCSI_SET_NOTIFICATION_ENABLE;
+		ret = ucsi->ops->async_write(ucsi, UCSI_CONTROL, &command,
+					     sizeof(command));
+		if (ret < 0)
+			goto out;
+
+		tmo = jiffies + msecs_to_jiffies(UCSI_TIMEOUT_MS);
+		do {
+			ret = ucsi->ops->read(ucsi, UCSI_CCI,
+					      &cci, sizeof(cci));
+			if (ret < 0)
+				goto out;
+			if (cci & UCSI_CCI_COMMAND_COMPLETE)
+				break;
+			if (time_is_before_jiffies(tmo))
+				break;
+			msleep(20);
+		} while (1);
+
+		WARN_ON(cci & UCSI_CCI_RESET_COMPLETE);
+	}
+
+	command = UCSI_PPM_RESET;
 	ret = ucsi->ops->async_write(ucsi, UCSI_CONTROL, &command,
 				     sizeof(command));
 	if (ret < 0)
diff --git a/drivers/usb/typec/ucsi/ucsi.h b/drivers/usb/typec/ucsi/ucsi.h
index fce23ad16c6d..41e1a64da82e 100644
--- a/drivers/usb/typec/ucsi/ucsi.h
+++ b/drivers/usb/typec/ucsi/ucsi.h
@@ -219,12 +219,12 @@ struct ucsi_cable_property {
 #define UCSI_CABLE_PROP_FLAG_VBUS_IN_CABLE	BIT(0)
 #define UCSI_CABLE_PROP_FLAG_ACTIVE_CABLE	BIT(1)
 #define UCSI_CABLE_PROP_FLAG_DIRECTIONALITY	BIT(2)
-#define UCSI_CABLE_PROP_FLAG_PLUG_TYPE(_f_)	((_f_) & GENMASK(3, 0))
+#define UCSI_CABLE_PROP_FLAG_PLUG_TYPE(_f_)	(((_f_) & GENMASK(4, 3)) >> 3)
 #define   UCSI_CABLE_PROPERTY_PLUG_TYPE_A	0
 #define   UCSI_CABLE_PROPERTY_PLUG_TYPE_B	1
 #define   UCSI_CABLE_PROPERTY_PLUG_TYPE_C	2
 #define   UCSI_CABLE_PROPERTY_PLUG_OTHER	3
-#define UCSI_CABLE_PROP_MODE_SUPPORT		BIT(5)
+#define UCSI_CABLE_PROP_FLAG_MODE_SUPPORT	BIT(5)
 	u8 latency;
 } __packed;
 
diff --git a/drivers/vfio/fsl-mc/vfio_fsl_mc_intr.c b/drivers/vfio/fsl-mc/vfio_fsl_mc_intr.c
index 0d9f3002df7f..86f770e6d0f8 100644
--- a/drivers/vfio/fsl-mc/vfio_fsl_mc_intr.c
+++ b/drivers/vfio/fsl-mc/vfio_fsl_mc_intr.c
@@ -142,13 +142,14 @@ static int vfio_fsl_mc_set_irq_trigger(struct vfio_fsl_mc_device *vdev,
 	irq = &vdev->mc_irqs[index];
 
 	if (flags & VFIO_IRQ_SET_DATA_NONE) {
-		vfio_fsl_mc_irq_handler(hwirq, irq);
+		if (irq->trigger)
+			eventfd_signal(irq->trigger, 1);
 
 	} else if (flags & VFIO_IRQ_SET_DATA_BOOL) {
 		u8 trigger = *(u8 *)data;
 
-		if (trigger)
-			vfio_fsl_mc_irq_handler(hwirq, irq);
+		if (trigger && irq->trigger)
+			eventfd_signal(irq->trigger, 1);
 	}
 
 	return 0;
diff --git a/drivers/vfio/pci/vfio_pci_intrs.c b/drivers/vfio/pci/vfio_pci_intrs.c
index 869dce5f134d..5b0b7fab3ba1 100644
--- a/drivers/vfio/pci/vfio_pci_intrs.c
+++ b/drivers/vfio/pci/vfio_pci_intrs.c
@@ -29,15 +29,22 @@ static void vfio_send_intx_eventfd(void *opaque, void *unused)
 {
 	struct vfio_pci_device *vdev = opaque;
 
-	if (likely(is_intx(vdev) && !vdev->virq_disabled))
-		eventfd_signal(vdev->ctx[0].trigger, 1);
+	if (likely(is_intx(vdev) && !vdev->virq_disabled)) {
+		struct eventfd_ctx *trigger;
+
+		trigger = READ_ONCE(vdev->ctx[0].trigger);
+		if (likely(trigger))
+			eventfd_signal(trigger, 1);
+	}
 }
 
-void vfio_pci_intx_mask(struct vfio_pci_device *vdev)
+static void __vfio_pci_intx_mask(struct vfio_pci_device *vdev)
 {
 	struct pci_dev *pdev = vdev->pdev;
 	unsigned long flags;
 
+	lockdep_assert_held(&vdev->igate);
+
 	spin_lock_irqsave(&vdev->irqlock, flags);
 
 	/*
@@ -65,6 +72,13 @@ void vfio_pci_intx_mask(struct vfio_pci_device *vdev)
 	spin_unlock_irqrestore(&vdev->irqlock, flags);
 }
 
+void vfio_pci_intx_mask(struct vfio_pci_device *vdev)
+{
+	mutex_lock(&vdev->igate);
+	__vfio_pci_intx_mask(vdev);
+	mutex_unlock(&vdev->igate);
+}
+
 /*
  * If this is triggered by an eventfd, we can't call eventfd_signal
  * or else we'll deadlock on the eventfd wait queue.  Return >0 when
@@ -107,12 +121,21 @@ static int vfio_pci_intx_unmask_handler(void *opaque, void *unused)
 	return ret;
 }
 
-void vfio_pci_intx_unmask(struct vfio_pci_device *vdev)
+static void __vfio_pci_intx_unmask(struct vfio_pci_device *vdev)
 {
+	lockdep_assert_held(&vdev->igate);
+
 	if (vfio_pci_intx_unmask_handler(vdev, NULL) > 0)
 		vfio_send_intx_eventfd(vdev, NULL);
 }
 
+void vfio_pci_intx_unmask(struct vfio_pci_device *vdev)
+{
+	mutex_lock(&vdev->igate);
+	__vfio_pci_intx_unmask(vdev);
+	mutex_unlock(&vdev->igate);
+}
+
 static irqreturn_t vfio_intx_handler(int irq, void *dev_id)
 {
 	struct vfio_pci_device *vdev = dev_id;
@@ -139,95 +162,104 @@ static irqreturn_t vfio_intx_handler(int irq, void *dev_id)
 	return ret;
 }
 
-static int vfio_intx_enable(struct vfio_pci_device *vdev)
+static int vfio_intx_enable(struct vfio_pci_device *vdev,
+			    struct eventfd_ctx *trigger)
 {
+	struct pci_dev *pdev = vdev->pdev;
+	unsigned long irqflags;
+	char *name;
+	int ret;
+
 	if (!is_irq_none(vdev))
 		return -EINVAL;
 
-	if (!vdev->pdev->irq)
+	if (!pdev->irq)
 		return -ENODEV;
 
+	name = kasprintf(GFP_KERNEL, "vfio-intx(%s)", pci_name(pdev));
+	if (!name)
+		return -ENOMEM;
+
 	vdev->ctx = kzalloc(sizeof(struct vfio_pci_irq_ctx), GFP_KERNEL);
 	if (!vdev->ctx)
 		return -ENOMEM;
 
 	vdev->num_ctx = 1;
 
+	vdev->ctx[0].name = name;
+	vdev->ctx[0].trigger = trigger;
+
 	/*
-	 * If the virtual interrupt is masked, restore it.  Devices
-	 * supporting DisINTx can be masked at the hardware level
-	 * here, non-PCI-2.3 devices will have to wait until the
-	 * interrupt is enabled.
+	 * Fill the initial masked state based on virq_disabled.  After
+	 * enable, changing the DisINTx bit in vconfig directly changes INTx
+	 * masking.  igate prevents races during setup, once running masked
+	 * is protected via irqlock.
+	 *
+	 * Devices supporting DisINTx also reflect the current mask state in
+	 * the physical DisINTx bit, which is not affected during IRQ setup.
+	 *
+	 * Devices without DisINTx support require an exclusive interrupt.
+	 * IRQ masking is performed at the IRQ chip.  Again, igate protects
+	 * against races during setup and IRQ handlers and irqfds are not
+	 * yet active, therefore masked is stable and can be used to
+	 * conditionally auto-enable the IRQ.
+	 *
+	 * irq_type must be stable while the IRQ handler is registered,
+	 * therefore it must be set before request_irq().
 	 */
 	vdev->ctx[0].masked = vdev->virq_disabled;
-	if (vdev->pci_2_3)
-		pci_intx(vdev->pdev, !vdev->ctx[0].masked);
+	if (vdev->pci_2_3) {
+		pci_intx(pdev, !vdev->ctx[0].masked);
+		irqflags = IRQF_SHARED;
+	} else {
+		irqflags = vdev->ctx[0].masked ? IRQF_NO_AUTOEN : 0;
+	}
 
 	vdev->irq_type = VFIO_PCI_INTX_IRQ_INDEX;
 
+	ret = request_irq(pdev->irq, vfio_intx_handler,
+			  irqflags, vdev->ctx[0].name, vdev);
+	if (ret) {
+		vdev->irq_type = VFIO_PCI_NUM_IRQS;
+		kfree(name);
+		vdev->num_ctx = 0;
+		kfree(vdev->ctx);
+		return ret;
+	}
+
 	return 0;
 }
 
-static int vfio_intx_set_signal(struct vfio_pci_device *vdev, int fd)
+static int vfio_intx_set_signal(struct vfio_pci_device *vdev,
+				struct eventfd_ctx *trigger)
 {
 	struct pci_dev *pdev = vdev->pdev;
-	unsigned long irqflags = IRQF_SHARED;
-	struct eventfd_ctx *trigger;
-	unsigned long flags;
-	int ret;
+	struct eventfd_ctx *old;
 
-	if (vdev->ctx[0].trigger) {
-		free_irq(pdev->irq, vdev);
-		kfree(vdev->ctx[0].name);
-		eventfd_ctx_put(vdev->ctx[0].trigger);
-		vdev->ctx[0].trigger = NULL;
-	}
-
-	if (fd < 0) /* Disable only */
-		return 0;
-
-	vdev->ctx[0].name = kasprintf(GFP_KERNEL, "vfio-intx(%s)",
-				      pci_name(pdev));
-	if (!vdev->ctx[0].name)
-		return -ENOMEM;
-
-	trigger = eventfd_ctx_fdget(fd);
-	if (IS_ERR(trigger)) {
-		kfree(vdev->ctx[0].name);
-		return PTR_ERR(trigger);
-	}
-
-	vdev->ctx[0].trigger = trigger;
+	old = vdev->ctx[0].trigger;
 
-	if (!vdev->pci_2_3)
-		irqflags = 0;
+	WRITE_ONCE(vdev->ctx[0].trigger, trigger);
 
-	ret = request_irq(pdev->irq, vfio_intx_handler,
-			  irqflags, vdev->ctx[0].name, vdev);
-	if (ret) {
-		vdev->ctx[0].trigger = NULL;
-		kfree(vdev->ctx[0].name);
-		eventfd_ctx_put(trigger);
-		return ret;
+	/* Releasing an old ctx requires synchronizing in-flight users */
+	if (old) {
+		synchronize_irq(pdev->irq);
+		vfio_virqfd_flush_thread(&vdev->ctx[0].unmask);
+		eventfd_ctx_put(old);
 	}
 
-	/*
-	 * INTx disable will stick across the new irq setup,
-	 * disable_irq won't.
-	 */
-	spin_lock_irqsave(&vdev->irqlock, flags);
-	if (!vdev->pci_2_3 && vdev->ctx[0].masked)
-		disable_irq_nosync(pdev->irq);
-	spin_unlock_irqrestore(&vdev->irqlock, flags);
-
 	return 0;
 }
 
 static void vfio_intx_disable(struct vfio_pci_device *vdev)
 {
+	struct pci_dev *pdev = vdev->pdev;
+
 	vfio_virqfd_disable(&vdev->ctx[0].unmask);
 	vfio_virqfd_disable(&vdev->ctx[0].mask);
-	vfio_intx_set_signal(vdev, -1);
+	free_irq(pdev->irq, vdev);
+	if (vdev->ctx[0].trigger)
+		eventfd_ctx_put(vdev->ctx[0].trigger);
+	kfree(vdev->ctx[0].name);
 	vdev->irq_type = VFIO_PCI_NUM_IRQS;
 	vdev->num_ctx = 0;
 	kfree(vdev->ctx);
@@ -425,11 +457,11 @@ static int vfio_pci_set_intx_unmask(struct vfio_pci_device *vdev,
 		return -EINVAL;
 
 	if (flags & VFIO_IRQ_SET_DATA_NONE) {
-		vfio_pci_intx_unmask(vdev);
+		__vfio_pci_intx_unmask(vdev);
 	} else if (flags & VFIO_IRQ_SET_DATA_BOOL) {
 		uint8_t unmask = *(uint8_t *)data;
 		if (unmask)
-			vfio_pci_intx_unmask(vdev);
+			__vfio_pci_intx_unmask(vdev);
 	} else if (flags & VFIO_IRQ_SET_DATA_EVENTFD) {
 		int32_t fd = *(int32_t *)data;
 		if (fd >= 0)
@@ -452,11 +484,11 @@ static int vfio_pci_set_intx_mask(struct vfio_pci_device *vdev,
 		return -EINVAL;
 
 	if (flags & VFIO_IRQ_SET_DATA_NONE) {
-		vfio_pci_intx_mask(vdev);
+		__vfio_pci_intx_mask(vdev);
 	} else if (flags & VFIO_IRQ_SET_DATA_BOOL) {
 		uint8_t mask = *(uint8_t *)data;
 		if (mask)
-			vfio_pci_intx_mask(vdev);
+			__vfio_pci_intx_mask(vdev);
 	} else if (flags & VFIO_IRQ_SET_DATA_EVENTFD) {
 		return -ENOTTY; /* XXX implement me */
 	}
@@ -477,19 +509,23 @@ static int vfio_pci_set_intx_trigger(struct vfio_pci_device *vdev,
 		return -EINVAL;
 
 	if (flags & VFIO_IRQ_SET_DATA_EVENTFD) {
+		struct eventfd_ctx *trigger = NULL;
 		int32_t fd = *(int32_t *)data;
 		int ret;
 
-		if (is_intx(vdev))
-			return vfio_intx_set_signal(vdev, fd);
+		if (fd >= 0) {
+			trigger = eventfd_ctx_fdget(fd);
+			if (IS_ERR(trigger))
+				return PTR_ERR(trigger);
+		}
 
-		ret = vfio_intx_enable(vdev);
-		if (ret)
-			return ret;
+		if (is_intx(vdev))
+			ret = vfio_intx_set_signal(vdev, trigger);
+		else
+			ret = vfio_intx_enable(vdev, trigger);
 
-		ret = vfio_intx_set_signal(vdev, fd);
-		if (ret)
-			vfio_intx_disable(vdev);
+		if (ret && trigger)
+			eventfd_ctx_put(trigger);
 
 		return ret;
 	}
diff --git a/drivers/vfio/platform/vfio_platform_irq.c b/drivers/vfio/platform/vfio_platform_irq.c
index c5b09ec0a3c9..7f4341a8d718 100644
--- a/drivers/vfio/platform/vfio_platform_irq.c
+++ b/drivers/vfio/platform/vfio_platform_irq.c
@@ -136,6 +136,16 @@ static int vfio_platform_set_irq_unmask(struct vfio_platform_device *vdev,
 	return 0;
 }
 
+/*
+ * The trigger eventfd is guaranteed valid in the interrupt path
+ * and protected by the igate mutex when triggered via ioctl.
+ */
+static void vfio_send_eventfd(struct vfio_platform_irq *irq_ctx)
+{
+	if (likely(irq_ctx->trigger))
+		eventfd_signal(irq_ctx->trigger, 1);
+}
+
 static irqreturn_t vfio_automasked_irq_handler(int irq, void *dev_id)
 {
 	struct vfio_platform_irq *irq_ctx = dev_id;
@@ -155,7 +165,7 @@ static irqreturn_t vfio_automasked_irq_handler(int irq, void *dev_id)
 	spin_unlock_irqrestore(&irq_ctx->lock, flags);
 
 	if (ret == IRQ_HANDLED)
-		eventfd_signal(irq_ctx->trigger, 1);
+		vfio_send_eventfd(irq_ctx);
 
 	return ret;
 }
@@ -164,22 +174,19 @@ static irqreturn_t vfio_irq_handler(int irq, void *dev_id)
 {
 	struct vfio_platform_irq *irq_ctx = dev_id;
 
-	eventfd_signal(irq_ctx->trigger, 1);
+	vfio_send_eventfd(irq_ctx);
 
 	return IRQ_HANDLED;
 }
 
 static int vfio_set_trigger(struct vfio_platform_device *vdev, int index,
-			    int fd, irq_handler_t handler)
+			    int fd)
 {
 	struct vfio_platform_irq *irq = &vdev->irqs[index];
 	struct eventfd_ctx *trigger;
-	int ret;
 
 	if (irq->trigger) {
-		irq_clear_status_flags(irq->hwirq, IRQ_NOAUTOEN);
-		free_irq(irq->hwirq, irq);
-		kfree(irq->name);
+		disable_irq(irq->hwirq);
 		eventfd_ctx_put(irq->trigger);
 		irq->trigger = NULL;
 	}
@@ -187,30 +194,20 @@ static int vfio_set_trigger(struct vfio_platform_device *vdev, int index,
 	if (fd < 0) /* Disable only */
 		return 0;
 
-	irq->name = kasprintf(GFP_KERNEL, "vfio-irq[%d](%s)",
-						irq->hwirq, vdev->name);
-	if (!irq->name)
-		return -ENOMEM;
-
 	trigger = eventfd_ctx_fdget(fd);
-	if (IS_ERR(trigger)) {
-		kfree(irq->name);
+	if (IS_ERR(trigger))
 		return PTR_ERR(trigger);
-	}
 
 	irq->trigger = trigger;
 
-	irq_set_status_flags(irq->hwirq, IRQ_NOAUTOEN);
-	ret = request_irq(irq->hwirq, handler, 0, irq->name, irq);
-	if (ret) {
-		kfree(irq->name);
-		eventfd_ctx_put(trigger);
-		irq->trigger = NULL;
-		return ret;
-	}
-
-	if (!irq->masked)
-		enable_irq(irq->hwirq);
+	/*
+	 * irq->masked effectively provides nested disables within the overall
+	 * enable relative to trigger.  Specifically request_irq() is called
+	 * with NO_AUTOEN, therefore the IRQ is initially disabled.  The user
+	 * may only further disable the IRQ with a MASK operations because
+	 * irq->masked is initially false.
+	 */
+	enable_irq(irq->hwirq);
 
 	return 0;
 }
@@ -229,7 +226,7 @@ static int vfio_platform_set_irq_trigger(struct vfio_platform_device *vdev,
 		handler = vfio_irq_handler;
 
 	if (!count && (flags & VFIO_IRQ_SET_DATA_NONE))
-		return vfio_set_trigger(vdev, index, -1, handler);
+		return vfio_set_trigger(vdev, index, -1);
 
 	if (start != 0 || count != 1)
 		return -EINVAL;
@@ -237,7 +234,7 @@ static int vfio_platform_set_irq_trigger(struct vfio_platform_device *vdev,
 	if (flags & VFIO_IRQ_SET_DATA_EVENTFD) {
 		int32_t fd = *(int32_t *)data;
 
-		return vfio_set_trigger(vdev, index, fd, handler);
+		return vfio_set_trigger(vdev, index, fd);
 	}
 
 	if (flags & VFIO_IRQ_SET_DATA_NONE) {
@@ -261,6 +258,14 @@ int vfio_platform_set_irqs_ioctl(struct vfio_platform_device *vdev,
 		    unsigned start, unsigned count, uint32_t flags,
 		    void *data) = NULL;
 
+	/*
+	 * For compatibility, errors from request_irq() are local to the
+	 * SET_IRQS path and reflected in the name pointer.  This allows,
+	 * for example, polling mode fallback for an exclusive IRQ failure.
+	 */
+	if (IS_ERR(vdev->irqs[index].name))
+		return PTR_ERR(vdev->irqs[index].name);
+
 	switch (flags & VFIO_IRQ_SET_ACTION_TYPE_MASK) {
 	case VFIO_IRQ_SET_ACTION_MASK:
 		func = vfio_platform_set_irq_mask;
@@ -281,7 +286,7 @@ int vfio_platform_set_irqs_ioctl(struct vfio_platform_device *vdev,
 
 int vfio_platform_irq_init(struct vfio_platform_device *vdev)
 {
-	int cnt = 0, i;
+	int cnt = 0, i, ret = 0;
 
 	while (vdev->get_irq(vdev, cnt) >= 0)
 		cnt++;
@@ -292,37 +297,70 @@ int vfio_platform_irq_init(struct vfio_platform_device *vdev)
 
 	for (i = 0; i < cnt; i++) {
 		int hwirq = vdev->get_irq(vdev, i);
+		irq_handler_t handler = vfio_irq_handler;
 
-		if (hwirq < 0)
+		if (hwirq < 0) {
+			ret = -EINVAL;
 			goto err;
+		}
 
 		spin_lock_init(&vdev->irqs[i].lock);
 
 		vdev->irqs[i].flags = VFIO_IRQ_INFO_EVENTFD;
 
-		if (irq_get_trigger_type(hwirq) & IRQ_TYPE_LEVEL_MASK)
+		if (irq_get_trigger_type(hwirq) & IRQ_TYPE_LEVEL_MASK) {
 			vdev->irqs[i].flags |= VFIO_IRQ_INFO_MASKABLE
 						| VFIO_IRQ_INFO_AUTOMASKED;
+			handler = vfio_automasked_irq_handler;
+		}
 
 		vdev->irqs[i].count = 1;
 		vdev->irqs[i].hwirq = hwirq;
 		vdev->irqs[i].masked = false;
+		vdev->irqs[i].name = kasprintf(GFP_KERNEL,
+					       "vfio-irq[%d](%s)", hwirq,
+					       vdev->name);
+		if (!vdev->irqs[i].name) {
+			ret = -ENOMEM;
+			goto err;
+		}
+
+		ret = request_irq(hwirq, handler, IRQF_NO_AUTOEN,
+				  vdev->irqs[i].name, &vdev->irqs[i]);
+		if (ret) {
+			kfree(vdev->irqs[i].name);
+			vdev->irqs[i].name = ERR_PTR(ret);
+		}
 	}
 
 	vdev->num_irqs = cnt;
 
 	return 0;
 err:
+	for (--i; i >= 0; i--) {
+		if (!IS_ERR(vdev->irqs[i].name)) {
+			free_irq(vdev->irqs[i].hwirq, &vdev->irqs[i]);
+			kfree(vdev->irqs[i].name);
+		}
+	}
 	kfree(vdev->irqs);
-	return -EINVAL;
+	return ret;
 }
 
 void vfio_platform_irq_cleanup(struct vfio_platform_device *vdev)
 {
 	int i;
 
-	for (i = 0; i < vdev->num_irqs; i++)
-		vfio_set_trigger(vdev, i, -1, NULL);
+	for (i = 0; i < vdev->num_irqs; i++) {
+		vfio_virqfd_disable(&vdev->irqs[i].mask);
+		vfio_virqfd_disable(&vdev->irqs[i].unmask);
+		if (!IS_ERR(vdev->irqs[i].name)) {
+			free_irq(vdev->irqs[i].hwirq, &vdev->irqs[i]);
+			if (vdev->irqs[i].trigger)
+				eventfd_ctx_put(vdev->irqs[i].trigger);
+			kfree(vdev->irqs[i].name);
+		}
+	}
 
 	vdev->num_irqs = 0;
 	kfree(vdev->irqs);
diff --git a/drivers/vfio/virqfd.c b/drivers/vfio/virqfd.c
index 997cb5d0a657..1cff533017ab 100644
--- a/drivers/vfio/virqfd.c
+++ b/drivers/vfio/virqfd.c
@@ -101,6 +101,13 @@ static void virqfd_inject(struct work_struct *work)
 		virqfd->thread(virqfd->opaque, virqfd->data);
 }
 
+static void virqfd_flush_inject(struct work_struct *work)
+{
+	struct virqfd *virqfd = container_of(work, struct virqfd, flush_inject);
+
+	flush_work(&virqfd->inject);
+}
+
 int vfio_virqfd_enable(void *opaque,
 		       int (*handler)(void *, void *),
 		       void (*thread)(void *, void *),
@@ -124,6 +131,7 @@ int vfio_virqfd_enable(void *opaque,
 
 	INIT_WORK(&virqfd->shutdown, virqfd_shutdown);
 	INIT_WORK(&virqfd->inject, virqfd_inject);
+	INIT_WORK(&virqfd->flush_inject, virqfd_flush_inject);
 
 	irqfd = fdget(fd);
 	if (!irqfd.file) {
@@ -214,6 +222,19 @@ void vfio_virqfd_disable(struct virqfd **pvirqfd)
 }
 EXPORT_SYMBOL_GPL(vfio_virqfd_disable);
 
+void vfio_virqfd_flush_thread(struct virqfd **pvirqfd)
+{
+	unsigned long flags;
+
+	spin_lock_irqsave(&virqfd_lock, flags);
+	if (*pvirqfd && (*pvirqfd)->thread)
+		queue_work(vfio_irqfd_cleanup_wq, &(*pvirqfd)->flush_inject);
+	spin_unlock_irqrestore(&virqfd_lock, flags);
+
+	flush_workqueue(vfio_irqfd_cleanup_wq);
+}
+EXPORT_SYMBOL_GPL(vfio_virqfd_flush_thread);
+
 module_init(vfio_virqfd_init);
 module_exit(vfio_virqfd_exit);
 
diff --git a/drivers/video/fbdev/core/fbmon.c b/drivers/video/fbdev/core/fbmon.c
index 1bf82dbc9e3c..3c29a5eb4380 100644
--- a/drivers/video/fbdev/core/fbmon.c
+++ b/drivers/video/fbdev/core/fbmon.c
@@ -1311,7 +1311,7 @@ int fb_get_mode(int flags, u32 val, struct fb_var_screeninfo *var, struct fb_inf
 int fb_videomode_from_videomode(const struct videomode *vm,
 				struct fb_videomode *fbmode)
 {
-	unsigned int htotal, vtotal;
+	unsigned int htotal, vtotal, total;
 
 	fbmode->xres = vm->hactive;
 	fbmode->left_margin = vm->hback_porch;
@@ -1344,8 +1344,9 @@ int fb_videomode_from_videomode(const struct videomode *vm,
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
index 0a1bc7a4d785..1e04026f0809 100644
--- a/drivers/video/fbdev/via/accel.c
+++ b/drivers/video/fbdev/via/accel.c
@@ -115,7 +115,7 @@ static int hw_bitblt_1(void __iomem *engine, u8 op, u32 width, u32 height,
 
 	if (op != VIA_BITBLT_FILL) {
 		tmp = src_mem ? 0 : src_addr;
-		if (dst_addr & 0xE0000007) {
+		if (tmp & 0xE0000007) {
 			printk(KERN_WARNING "hw_bitblt_1: Unsupported source "
 				"address %X\n", tmp);
 			return -EINVAL;
@@ -260,7 +260,7 @@ static int hw_bitblt_2(void __iomem *engine, u8 op, u32 width, u32 height,
 		writel(tmp, engine + 0x18);
 
 		tmp = src_mem ? 0 : src_addr;
-		if (dst_addr & 0xE0000007) {
+		if (tmp & 0xE0000007) {
 			printk(KERN_WARNING "hw_bitblt_2: Unsupported source "
 				"address %X\n", tmp);
 			return -EINVAL;
diff --git a/drivers/virtio/virtio.c b/drivers/virtio/virtio.c
index 441bc057896f..5df51095d8e1 100644
--- a/drivers/virtio/virtio.c
+++ b/drivers/virtio/virtio.c
@@ -403,13 +403,19 @@ EXPORT_SYMBOL_GPL(unregister_virtio_device);
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
diff --git a/drivers/xen/events/events_base.c b/drivers/xen/events/events_base.c
index 24e39984914f..f608663bdfd5 100644
--- a/drivers/xen/events/events_base.c
+++ b/drivers/xen/events/events_base.c
@@ -885,8 +885,8 @@ static void shutdown_pirq(struct irq_data *data)
 		return;
 
 	do_mask(info, EVT_MASK_REASON_EXPLICIT);
-	xen_evtchn_close(evtchn);
 	xen_irq_info_cleanup(info);
+	xen_evtchn_close(evtchn);
 }
 
 static void enable_pirq(struct irq_data *data)
@@ -929,8 +929,6 @@ static void __unbind_from_irq(unsigned int irq)
 	if (VALID_EVTCHN(evtchn)) {
 		unsigned int cpu = cpu_from_irq(irq);
 
-		xen_evtchn_close(evtchn);
-
 		switch (type_from_irq(irq)) {
 		case IRQT_VIRQ:
 			per_cpu(virq_to_irq, cpu)[virq_from_irq(irq)] = -1;
@@ -943,6 +941,7 @@ static void __unbind_from_irq(unsigned int irq)
 		}
 
 		xen_irq_info_cleanup(info);
+		xen_evtchn_close(evtchn);
 	}
 
 	xen_free_irq(irq);
diff --git a/fs/aio.c b/fs/aio.c
index 900ed5207540..93b6bbf01d71 100644
--- a/fs/aio.c
+++ b/fs/aio.c
@@ -565,8 +565,8 @@ static int aio_setup_ring(struct kioctx *ctx, unsigned int nr_events)
 
 void kiocb_set_cancel_fn(struct kiocb *iocb, kiocb_cancel_fn *cancel)
 {
-	struct aio_kiocb *req = container_of(iocb, struct aio_kiocb, rw);
-	struct kioctx *ctx = req->ki_ctx;
+	struct aio_kiocb *req;
+	struct kioctx *ctx;
 	unsigned long flags;
 
 	/*
@@ -576,9 +576,13 @@ void kiocb_set_cancel_fn(struct kiocb *iocb, kiocb_cancel_fn *cancel)
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
index bfa2bf44529c..d908afa1f313 100644
--- a/fs/btrfs/export.c
+++ b/fs/btrfs/export.c
@@ -161,8 +161,15 @@ struct dentry *btrfs_get_parent(struct dentry *child)
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
index 049b837934e5..ab8ed187746e 100644
--- a/fs/btrfs/ioctl.c
+++ b/fs/btrfs/ioctl.c
@@ -3148,7 +3148,7 @@ static int btrfs_ioctl_defrag(struct file *file, void __user *argp)
 {
 	struct inode *inode = file_inode(file);
 	struct btrfs_root *root = BTRFS_I(inode)->root;
-	struct btrfs_ioctl_defrag_range_args *range;
+	struct btrfs_ioctl_defrag_range_args range = {0};
 	int ret;
 
 	ret = mnt_want_write_file(file);
@@ -3180,37 +3180,28 @@ static int btrfs_ioctl_defrag(struct file *file, void __user *argp)
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
index 0b04adfd4a4a..0519a3557697 100644
--- a/fs/btrfs/send.c
+++ b/fs/btrfs/send.c
@@ -966,7 +966,15 @@ static int iterate_inode_ref(struct btrfs_root *root, struct btrfs_path *path,
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
index eaf5cd043dac..09c23626feba 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -1471,7 +1471,7 @@ static bool contains_pending_extent(struct btrfs_device *device, u64 *start,
 
 		if (in_range(physical_start, *start, len) ||
 		    in_range(*start, physical_start,
-			     physical_end - physical_start)) {
+			     physical_end + 1 - physical_start)) {
 			*start = physical_end + 1;
 			return true;
 		}
@@ -3178,7 +3178,17 @@ static int btrfs_relocate_sys_chunks(struct btrfs_fs_info *fs_info)
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
index 2006e245b8f3..ebe9011955b9 100644
--- a/fs/exec.c
+++ b/fs/exec.c
@@ -888,6 +888,7 @@ int transfer_args_to_stack(struct linux_binprm *bprm,
 			goto out;
 	}
 
+	bprm->exec += *sp_location - MAX_ARG_PAGES * PAGE_SIZE;
 	*sp_location = sp;
 
 out:
diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
index 61988b7b5be7..c1d632725c2c 100644
--- a/fs/ext4/mballoc.c
+++ b/fs/ext4/mballoc.c
@@ -2591,7 +2591,10 @@ static int ext4_mb_seq_groups_show(struct seq_file *seq, void *v)
 	for (i = 0; i <= 13; i++)
 		seq_printf(seq, " %-5u", i <= blocksize_bits + 1 ?
 				sg.info.bb_counters[i] : 0);
-	seq_puts(seq, " ]\n");
+	seq_puts(seq, " ]");
+	if (EXT4_MB_GRP_BBITMAP_CORRUPT(&sg.info))
+		seq_puts(seq, " Block bitmap corrupted!");
+	seq_puts(seq, "\n");
 
 	return 0;
 }
@@ -4162,10 +4165,16 @@ ext4_mb_new_inode_pa(struct ext4_allocation_context *ac)
 			.fe_len = ac->ac_g_ex.fe_len,
 		};
 		loff_t orig_goal_end = extent_logical_end(sbi, &ex);
+		loff_t o_ex_end = extent_logical_end(sbi, &ac->ac_o_ex);
 
-		/* we can't allocate as much as normalizer wants.
-		 * so, found space must get proper lstart
-		 * to cover original request */
+		/*
+		 * We can't allocate as much as normalizer wants, so we try
+		 * to get proper lstart to cover the original request, except
+		 * when the goal doesn't cover the original request as below:
+		 *
+		 * orig_ex:2045/2055(10), isize:8417280 -> normalized:0/2048
+		 * best_ex:0/200(200) -> adjusted: 1848/2048(200)
+		 */
 		BUG_ON(ac->ac_g_ex.fe_logical > ac->ac_o_ex.fe_logical);
 		BUG_ON(ac->ac_g_ex.fe_len < ac->ac_o_ex.fe_len);
 
@@ -4177,7 +4186,7 @@ ext4_mb_new_inode_pa(struct ext4_allocation_context *ac)
 		 * 1. Check if best ex can be kept at end of goal and still
 		 *    cover original start
 		 * 2. Else, check if best ex can be kept at start of goal and
-		 *    still cover original start
+		 *    still cover original end
 		 * 3. Else, keep the best ex at start of original request.
 		 */
 		ex.fe_len = ac->ac_b_ex.fe_len;
@@ -4187,7 +4196,7 @@ ext4_mb_new_inode_pa(struct ext4_allocation_context *ac)
 			goto adjust_bex;
 
 		ex.fe_logical = ac->ac_g_ex.fe_logical;
-		if (ac->ac_o_ex.fe_logical < extent_logical_end(sbi, &ex))
+		if (o_ex_end <= extent_logical_end(sbi, &ex))
 			goto adjust_bex;
 
 		ex.fe_logical = ac->ac_o_ex.fe_logical;
@@ -4195,7 +4204,6 @@ ext4_mb_new_inode_pa(struct ext4_allocation_context *ac)
 		ac->ac_b_ex.fe_logical = ex.fe_logical;
 
 		BUG_ON(ac->ac_o_ex.fe_logical < ac->ac_b_ex.fe_logical);
-		BUG_ON(ac->ac_o_ex.fe_len > ac->ac_b_ex.fe_len);
 		BUG_ON(extent_logical_end(sbi, &ex) > orig_goal_end);
 	}
 
diff --git a/fs/ext4/resize.c b/fs/ext4/resize.c
index 06e0eaf2ea4e..5d45ec29e61a 100644
--- a/fs/ext4/resize.c
+++ b/fs/ext4/resize.c
@@ -1545,7 +1545,8 @@ static int ext4_flex_group_add(struct super_block *sb,
 		int gdb_num = group / EXT4_DESC_PER_BLOCK(sb);
 		int gdb_num_end = ((group + flex_gd->count - 1) /
 				   EXT4_DESC_PER_BLOCK(sb));
-		int meta_bg = ext4_has_feature_meta_bg(sb);
+		int meta_bg = ext4_has_feature_meta_bg(sb) &&
+			      gdb_num >= le32_to_cpu(es->s_first_meta_bg);
 		sector_t padding_blocks = meta_bg ? 0 : sbi->s_sbh->b_blocknr -
 					 ext4_group_first_block_no(sb, 0);
 		sector_t old_gdb = 0;
diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index e386d67cff9d..0149d3c2cfd7 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -6205,6 +6205,10 @@ static int ext4_write_dquot(struct dquot *dquot)
 	if (IS_ERR(handle))
 		return PTR_ERR(handle);
 	ret = dquot_commit(dquot);
+	if (ret < 0)
+		ext4_error_err(dquot->dq_sb, -ret,
+			       "Failed to commit dquot type %d",
+			       dquot->dq_id.type);
 	err = ext4_journal_stop(handle);
 	if (!ret)
 		ret = err;
@@ -6221,6 +6225,10 @@ static int ext4_acquire_dquot(struct dquot *dquot)
 	if (IS_ERR(handle))
 		return PTR_ERR(handle);
 	ret = dquot_acquire(dquot);
+	if (ret < 0)
+		ext4_error_err(dquot->dq_sb, -ret,
+			      "Failed to acquire dquot type %d",
+			      dquot->dq_id.type);
 	err = ext4_journal_stop(handle);
 	if (!ret)
 		ret = err;
@@ -6240,6 +6248,10 @@ static int ext4_release_dquot(struct dquot *dquot)
 		return PTR_ERR(handle);
 	}
 	ret = dquot_release(dquot);
+	if (ret < 0)
+		ext4_error_err(dquot->dq_sb, -ret,
+			       "Failed to release dquot type %d",
+			       dquot->dq_id.type);
 	err = ext4_journal_stop(handle);
 	if (!ret)
 		ret = err;
diff --git a/fs/fat/nfs.c b/fs/fat/nfs.c
index af191371c352..bab63eeaf9cb 100644
--- a/fs/fat/nfs.c
+++ b/fs/fat/nfs.c
@@ -130,6 +130,12 @@ fat_encode_fh_nostale(struct inode *inode, __u32 *fh, int *lenp,
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
diff --git a/fs/fuse/dir.c b/fs/fuse/dir.c
index b0c701c007c6..d131f34cd3e1 100644
--- a/fs/fuse/dir.c
+++ b/fs/fuse/dir.c
@@ -451,6 +451,10 @@ int fuse_lookup_name(struct super_block *sb, u64 nodeid, const struct qstr *name
 		goto out_put_forget;
 	if (fuse_invalid_attr(&outarg->attr))
 		goto out_put_forget;
+	if (outarg->nodeid == FUSE_ROOT_ID && outarg->generation != 0) {
+		pr_warn_once("root generation should be zero\n");
+		outarg->generation = 0;
+	}
 
 	*inode = fuse_iget(sb, outarg->nodeid, outarg->generation,
 			   &outarg->attr, entry_attr_timeout(outarg),
diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
index ceaa6868386e..33eb5fefc06b 100644
--- a/fs/fuse/fuse_i.h
+++ b/fs/fuse/fuse_i.h
@@ -873,7 +873,6 @@ static inline bool fuse_stale_inode(const struct inode *inode, int generation,
 
 static inline void fuse_make_bad(struct inode *inode)
 {
-	remove_inode_hash(inode);
 	set_bit(FUSE_I_BAD, &get_fuse_inode(inode)->state);
 }
 
diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
index 9ea175ff9c8e..4a7ebccd359e 100644
--- a/fs/fuse/inode.c
+++ b/fs/fuse/inode.c
@@ -352,8 +352,11 @@ struct inode *fuse_iget(struct super_block *sb, u64 nodeid,
 	} else if (fuse_stale_inode(inode, generation, attr)) {
 		/* nodeid was reused, any I/O on the old inode should fail */
 		fuse_make_bad(inode);
-		iput(inode);
-		goto retry;
+		if (inode != d_inode(sb->s_root)) {
+			remove_inode_hash(inode);
+			iput(inode);
+			goto retry;
+		}
 	}
 done:
 	fi = get_fuse_inode(inode);
diff --git a/fs/isofs/inode.c b/fs/isofs/inode.c
index f62b5a501566..4c763f573faf 100644
--- a/fs/isofs/inode.c
+++ b/fs/isofs/inode.c
@@ -907,8 +907,22 @@ static int isofs_fill_super(struct super_block *s, void *data, int silent)
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
diff --git a/fs/nfs/direct.c b/fs/nfs/direct.c
index 5d86ffa72cea..499519f0f6ec 100644
--- a/fs/nfs/direct.c
+++ b/fs/nfs/direct.c
@@ -678,10 +678,17 @@ static void nfs_direct_commit_schedule(struct nfs_direct_req *dreq)
 	LIST_HEAD(mds_list);
 
 	nfs_init_cinfo_from_dreq(&cinfo, dreq);
+	nfs_commit_begin(cinfo.mds);
 	nfs_scan_commit(dreq->inode, &mds_list, &cinfo);
 	res = nfs_generic_commit_list(dreq->inode, &mds_list, 0, &cinfo);
-	if (res < 0) /* res == -ENOMEM */
-		nfs_direct_write_reschedule(dreq);
+	if (res < 0) { /* res == -ENOMEM */
+		spin_lock(&dreq->lock);
+		if (dreq->flags == 0)
+			dreq->flags = NFS_ODIRECT_RESCHED_WRITES;
+		spin_unlock(&dreq->lock);
+	}
+	if (nfs_commit_end(cinfo.mds))
+		nfs_direct_write_complete(dreq);
 }
 
 static void nfs_direct_write_clear_reqs(struct nfs_direct_req *dreq)
diff --git a/fs/nfs/write.c b/fs/nfs/write.c
index d3cd099ffb6e..4cf060691979 100644
--- a/fs/nfs/write.c
+++ b/fs/nfs/write.c
@@ -1637,7 +1637,7 @@ static int wait_on_commit(struct nfs_mds_commit_info *cinfo)
 				       !atomic_read(&cinfo->rpcs_out));
 }
 
-static void nfs_commit_begin(struct nfs_mds_commit_info *cinfo)
+void nfs_commit_begin(struct nfs_mds_commit_info *cinfo)
 {
 	atomic_inc(&cinfo->rpcs_out);
 }
diff --git a/fs/nilfs2/btree.c b/fs/nilfs2/btree.c
index 65cd599cb2ab..4905b7cd7bf3 100644
--- a/fs/nilfs2/btree.c
+++ b/fs/nilfs2/btree.c
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
diff --git a/fs/nilfs2/direct.c b/fs/nilfs2/direct.c
index f353101955e3..7faf8c285d6c 100644
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
diff --git a/fs/nilfs2/inode.c b/fs/nilfs2/inode.c
index d144e08a9003..06f4deb550c9 100644
--- a/fs/nilfs2/inode.c
+++ b/fs/nilfs2/inode.c
@@ -112,7 +112,7 @@ int nilfs_get_block(struct inode *inode, sector_t blkoff,
 					   "%s (ino=%lu): a race condition while inserting a data block at offset=%llu",
 					   __func__, inode->i_ino,
 					   (unsigned long long)blkoff);
-				err = 0;
+				err = -EAGAIN;
 			}
 			nilfs_transaction_abort(inode->i_sb);
 			goto out;
diff --git a/fs/pstore/zone.c b/fs/pstore/zone.c
index b50fc33f2ab2..2426fb6794fd 100644
--- a/fs/pstore/zone.c
+++ b/fs/pstore/zone.c
@@ -973,6 +973,8 @@ static ssize_t psz_kmsg_read(struct pstore_zone *zone,
 		char *buf = kasprintf(GFP_KERNEL, "%s: Total %d times\n",
 				      kmsg_dump_reason_str(record->reason),
 				      record->count);
+		if (!buf)
+			return -ENOMEM;
 		hlen = strlen(buf);
 		record->buf = krealloc(buf, hlen + size, GFP_KERNEL);
 		if (!record->buf) {
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
index 19fdcda04589..18df7a82517f 100644
--- a/fs/ubifs/file.c
+++ b/fs/ubifs/file.c
@@ -262,9 +262,6 @@ static int write_begin_slow(struct address_space *mapping,
 				return err;
 			}
 		}
-
-		SetPageUptodate(page);
-		ClearPageError(page);
 	}
 
 	if (PagePrivate(page))
@@ -463,9 +460,6 @@ static int ubifs_write_begin(struct file *file, struct address_space *mapping,
 				return err;
 			}
 		}
-
-		SetPageUptodate(page);
-		ClearPageError(page);
 	}
 
 	err = allocate_budget(c, page, ui, appending);
@@ -475,10 +469,8 @@ static int ubifs_write_begin(struct file *file, struct address_space *mapping,
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
@@ -569,6 +561,9 @@ static int ubifs_write_end(struct file *file, struct address_space *mapping,
 		goto out;
 	}
 
+	if (len == PAGE_SIZE)
+		SetPageUptodate(page);
+
 	if (!PagePrivate(page)) {
 		attach_page_private(page, (void *)1);
 		atomic_long_inc(&c->dirty_pg_cnt);
diff --git a/fs/vboxsf/super.c b/fs/vboxsf/super.c
index c578e772cbd5..f11bcbac7727 100644
--- a/fs/vboxsf/super.c
+++ b/fs/vboxsf/super.c
@@ -151,7 +151,7 @@ static int vboxsf_fill_super(struct super_block *sb, struct fs_context *fc)
 		if (!sbi->nls) {
 			vbg_err("vboxsf: Count not load '%s' nls\n", nls_name);
 			err = -EINVAL;
-			goto fail_free;
+			goto fail_destroy_idr;
 		}
 	}
 
@@ -224,6 +224,7 @@ static int vboxsf_fill_super(struct super_block *sb, struct fs_context *fc)
 		ida_simple_remove(&vboxsf_bdi_ida, sbi->bdi_id);
 	if (sbi->nls)
 		unload_nls(sbi->nls);
+fail_destroy_idr:
 	idr_destroy(&sbi->ino_idr);
 	kfree(sbi);
 	return err;
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 583824f11107..a47e1aebaff2 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -345,6 +345,7 @@ struct queue_limits {
 	unsigned int		max_zone_append_sectors;
 	unsigned int		discard_granularity;
 	unsigned int		discard_alignment;
+	unsigned int		zone_write_granularity;
 
 	unsigned short		max_segments;
 	unsigned short		max_integrity_segments;
@@ -1169,6 +1170,8 @@ extern void blk_queue_logical_block_size(struct request_queue *, unsigned int);
 extern void blk_queue_max_zone_append_sectors(struct request_queue *q,
 		unsigned int max_zone_append_sectors);
 extern void blk_queue_physical_block_size(struct request_queue *, unsigned int);
+void blk_queue_zone_write_granularity(struct request_queue *q,
+				      unsigned int size);
 extern void blk_queue_alignment_offset(struct request_queue *q,
 				       unsigned int alignment);
 void blk_queue_update_readahead(struct request_queue *q);
@@ -1480,6 +1483,18 @@ static inline int bdev_io_opt(struct block_device *bdev)
 	return queue_io_opt(bdev_get_queue(bdev));
 }
 
+static inline unsigned int
+queue_zone_write_granularity(const struct request_queue *q)
+{
+	return q->limits.zone_write_granularity;
+}
+
+static inline unsigned int
+bdev_zone_write_granularity(struct block_device *bdev)
+{
+	return queue_zone_write_granularity(bdev_get_queue(bdev));
+}
+
 static inline int queue_alignment_offset(const struct request_queue *q)
 {
 	if (q->limits.misaligned)
diff --git a/include/linux/cpu.h b/include/linux/cpu.h
index 6d7ab016127c..2099226d8623 100644
--- a/include/linux/cpu.h
+++ b/include/linux/cpu.h
@@ -74,6 +74,8 @@ extern ssize_t cpu_show_spec_rstack_overflow(struct device *dev,
 					     struct device_attribute *attr, char *buf);
 extern ssize_t cpu_show_gds(struct device *dev,
 			    struct device_attribute *attr, char *buf);
+extern ssize_t cpu_show_reg_file_data_sampling(struct device *dev,
+					       struct device_attribute *attr, char *buf);
 
 extern __printf(4, 5)
 struct device *cpu_device_create(struct device *parent, void *drvdata,
diff --git a/include/linux/device.h b/include/linux/device.h
index 6394c4b70a09..9c9ce573c737 100644
--- a/include/linux/device.h
+++ b/include/linux/device.h
@@ -973,6 +973,7 @@ void device_link_del(struct device_link *link);
 void device_link_remove(void *consumer, struct device *supplier);
 void device_links_supplier_sync_state_pause(void);
 void device_links_supplier_sync_state_resume(void);
+void device_link_wait_removal(void);
 
 extern __printf(3, 4)
 int dev_err_probe(const struct device *dev, int err, const char *fmt, ...);
diff --git a/include/linux/gfp.h b/include/linux/gfp.h
index c603237e006c..973f4143f9f6 100644
--- a/include/linux/gfp.h
+++ b/include/linux/gfp.h
@@ -623,6 +623,15 @@ static inline bool pm_suspended_storage(void)
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
 #ifdef CONFIG_CONTIG_ALLOC
 /* The below functions must be run on a range from a single zone. */
 extern int alloc_contig_range(unsigned long start, unsigned long end,
diff --git a/include/linux/hyperv.h b/include/linux/hyperv.h
index 2aaf450c8d80..b606a203de88 100644
--- a/include/linux/hyperv.h
+++ b/include/linux/hyperv.h
@@ -164,8 +164,28 @@ struct hv_ring_buffer {
 	u8 buffer[];
 } __packed;
 
+
+/*
+ * If the requested ring buffer size is at least 8 times the size of the
+ * header, steal space from the ring buffer for the header. Otherwise, add
+ * space for the header so that is doesn't take too much of the ring buffer
+ * space.
+ *
+ * The factor of 8 is somewhat arbitrary. The goal is to prevent adding a
+ * relatively small header (4 Kbytes on x86) to a large-ish power-of-2 ring
+ * buffer size (such as 128 Kbytes) and so end up making a nearly twice as
+ * large allocation that will be almost half wasted. As a contrasting example,
+ * on ARM64 with 64 Kbyte page size, we don't want to take 64 Kbytes for the
+ * header from a 128 Kbyte allocation, leaving only 64 Kbytes for the ring.
+ * In this latter case, we must add 64 Kbytes for the header and not worry
+ * about what's wasted.
+ */
+#define VMBUS_HEADER_ADJ(payload_sz) \
+	((payload_sz) >=  8 * sizeof(struct hv_ring_buffer) ? \
+	0 : sizeof(struct hv_ring_buffer))
+
 /* Calculate the proper size of a ringbuffer, it must be page-aligned */
-#define VMBUS_RING_SIZE(payload_sz) PAGE_ALIGN(sizeof(struct hv_ring_buffer) + \
+#define VMBUS_RING_SIZE(payload_sz) PAGE_ALIGN(VMBUS_HEADER_ADJ(payload_sz) + \
 					       (payload_sz))
 
 struct hv_ring_buffer_info {
diff --git a/include/linux/nfs_fs.h b/include/linux/nfs_fs.h
index e39342945a80..7488864589a7 100644
--- a/include/linux/nfs_fs.h
+++ b/include/linux/nfs_fs.h
@@ -553,6 +553,7 @@ extern int nfs_wb_page_cancel(struct inode *inode, struct page* page);
 extern int  nfs_commit_inode(struct inode *, int);
 extern struct nfs_commit_data *nfs_commitdata_alloc(void);
 extern void nfs_commit_free(struct nfs_commit_data *data);
+void nfs_commit_begin(struct nfs_mds_commit_info *cinfo);
 bool nfs_commit_end(struct nfs_mds_commit_info *cinfo);
 
 static inline int
diff --git a/include/linux/objtool.h b/include/linux/objtool.h
index d17fa7f4001d..0f13875acc5e 100644
--- a/include/linux/objtool.h
+++ b/include/linux/objtool.h
@@ -141,6 +141,12 @@ struct unwind_hint {
 	.popsection
 .endm
 
+.macro STACK_FRAME_NON_STANDARD func:req
+	.pushsection .discard.func_stack_frame_non_standard, "aw"
+		.long \func - .
+	.popsection
+.endm
+
 #endif /* __ASSEMBLY__ */
 
 #else /* !CONFIG_STACK_VALIDATION */
@@ -158,6 +164,8 @@ struct unwind_hint {
 .endm
 .macro ANNOTATE_NOENDBR
 .endm
+.macro STACK_FRAME_NON_STANDARD func:req
+.endm
 #endif
 
 #endif /* CONFIG_STACK_VALIDATION */
diff --git a/include/linux/pci.h b/include/linux/pci.h
index bf46453475e3..5b24a6fbfa0b 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -306,6 +306,7 @@ struct pcie_link_state;
 struct pci_vpd;
 struct pci_sriov;
 struct pci_p2pdma;
+struct rcec_ea;
 
 /* The pci_dev structure describes PCI devices */
 struct pci_dev {
@@ -329,6 +330,10 @@ struct pci_dev {
 	u16		aer_cap;	/* AER capability offset */
 	struct aer_stats *aer_stats;	/* AER stats for this device */
 #endif
+#ifdef CONFIG_PCIEPORTBUS
+	struct rcec_ea	*rcec_ea;	/* RCEC cached endpoint association */
+#endif
+	u32		devcap;		/* PCIe Device Capabilities */
 	u8		pcie_cap;	/* PCIe capability offset */
 	u8		msi_cap;	/* MSI capability offset */
 	u8		msix_cap;	/* MSI-X capability offset */
@@ -449,6 +454,7 @@ struct pci_dev {
 	unsigned int	link_active_reporting:1;/* Device capable of reporting link active */
 	unsigned int	no_vf_scan:1;		/* Don't scan for VFs after IOV enablement */
 	unsigned int	no_command_memory:1;	/* No PCI_COMMAND_MEMORY */
+	unsigned int	rom_bar_overlap:1;	/* ROM BAR disable broken */
 	pci_dev_flags_t dev_flags;
 	atomic_t	enable_cnt;	/* pci_enable_device has been called */
 
diff --git a/include/linux/phy/tegra/xusb.h b/include/linux/phy/tegra/xusb.h
index 71d956935405..86ccd90e425c 100644
--- a/include/linux/phy/tegra/xusb.h
+++ b/include/linux/phy/tegra/xusb.h
@@ -23,4 +23,6 @@ int tegra_xusb_padctl_set_vbus_override(struct tegra_xusb_padctl *padctl,
 int tegra_phy_xusb_utmi_port_reset(struct phy *phy);
 int tegra_xusb_padctl_get_usb3_companion(struct tegra_xusb_padctl *padctl,
 					 unsigned int port);
+int tegra_xusb_padctl_get_port_number(struct phy *phy);
+
 #endif /* PHY_TEGRA_XUSB_H */
diff --git a/include/linux/sunrpc/sched.h b/include/linux/sunrpc/sched.h
index 256dff36cf72..0527a4bc9a36 100644
--- a/include/linux/sunrpc/sched.h
+++ b/include/linux/sunrpc/sched.h
@@ -197,7 +197,7 @@ struct rpc_wait_queue {
 	unsigned char		maxpriority;		/* maximum priority (0 if queue is not a priority queue) */
 	unsigned char		priority;		/* current priority */
 	unsigned char		nr;			/* # tasks remaining for cookie */
-	unsigned short		qlen;			/* total # tasks waiting in queue */
+	unsigned int		qlen;			/* total # tasks waiting in queue */
 	struct rpc_timer	timer_list;
 #if IS_ENABLED(CONFIG_SUNRPC_DEBUG) || IS_ENABLED(CONFIG_TRACEPOINTS)
 	const char *		name;
diff --git a/include/linux/timer.h b/include/linux/timer.h
index d10bc7e73b41..a3d04c4f1263 100644
--- a/include/linux/timer.h
+++ b/include/linux/timer.h
@@ -183,12 +183,20 @@ extern int timer_reduce(struct timer_list *timer, unsigned long expires);
 extern void add_timer(struct timer_list *timer);
 
 extern int try_to_del_timer_sync(struct timer_list *timer);
+extern int timer_delete_sync(struct timer_list *timer);
 
-#if defined(CONFIG_SMP) || defined(CONFIG_PREEMPT_RT)
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
 
diff --git a/include/linux/udp.h b/include/linux/udp.h
index ae58ff3b6b5b..a220880019d6 100644
--- a/include/linux/udp.h
+++ b/include/linux/udp.h
@@ -131,6 +131,24 @@ static inline void udp_cmsg_recv(struct msghdr *msg, struct sock *sk,
 	}
 }
 
+DECLARE_STATIC_KEY_FALSE(udp_encap_needed_key);
+#if IS_ENABLED(CONFIG_IPV6)
+DECLARE_STATIC_KEY_FALSE(udpv6_encap_needed_key);
+#endif
+
+static inline bool udp_encap_needed(void)
+{
+	if (static_branch_unlikely(&udp_encap_needed_key))
+		return true;
+
+#if IS_ENABLED(CONFIG_IPV6)
+	if (static_branch_unlikely(&udpv6_encap_needed_key))
+		return true;
+#endif
+
+	return false;
+}
+
 static inline bool udp_unexpected_gso(struct sock *sk, struct sk_buff *skb)
 {
 	if (!skb_is_gso(skb))
@@ -142,6 +160,16 @@ static inline bool udp_unexpected_gso(struct sock *sk, struct sk_buff *skb)
 	if (skb_shinfo(skb)->gso_type & SKB_GSO_FRAGLIST && !udp_sk(sk)->accept_udp_fraglist)
 		return true;
 
+	/* GSO packets lacking the SKB_GSO_UDP_TUNNEL/_CSUM bits might still
+	 * land in a tunnel as the socket check in udp_gro_receive cannot be
+	 * foolproof.
+	 */
+	if (udp_encap_needed() &&
+	    READ_ONCE(udp_sk(sk)->encap_rcv) &&
+	    !(skb_shinfo(skb)->gso_type &
+	      (SKB_GSO_UDP_TUNNEL | SKB_GSO_UDP_TUNNEL_CSUM)))
+		return true;
+
 	return false;
 }
 
diff --git a/include/linux/vfio.h b/include/linux/vfio.h
index f479c5d7f2c3..56d18912c41a 100644
--- a/include/linux/vfio.h
+++ b/include/linux/vfio.h
@@ -221,6 +221,7 @@ struct virqfd {
 	wait_queue_entry_t		wait;
 	poll_table		pt;
 	struct work_struct	shutdown;
+	struct work_struct	flush_inject;
 	struct virqfd		**pvirqfd;
 };
 
@@ -229,5 +230,6 @@ extern int vfio_virqfd_enable(void *opaque,
 			      void (*thread)(void *, void *),
 			      void *data, struct virqfd **pvirqfd, int fd);
 extern void vfio_virqfd_disable(struct virqfd **pvirqfd);
+void vfio_virqfd_flush_thread(struct virqfd **pvirqfd);
 
 #endif /* VFIO_H */
diff --git a/include/net/cfg802154.h b/include/net/cfg802154.h
index 6ed07844eb24..5290781abba3 100644
--- a/include/net/cfg802154.h
+++ b/include/net/cfg802154.h
@@ -257,6 +257,7 @@ struct ieee802154_llsec_key {
 
 struct ieee802154_llsec_key_entry {
 	struct list_head list;
+	struct rcu_head rcu;
 
 	struct ieee802154_llsec_key_id id;
 	struct ieee802154_llsec_key *key;
diff --git a/include/net/inet_connection_sock.h b/include/net/inet_connection_sock.h
index 568121fa0965..f5967805c33f 100644
--- a/include/net/inet_connection_sock.h
+++ b/include/net/inet_connection_sock.h
@@ -172,6 +172,7 @@ void inet_csk_init_xmit_timers(struct sock *sk,
 			       void (*delack_handler)(struct timer_list *),
 			       void (*keepalive_handler)(struct timer_list *));
 void inet_csk_clear_xmit_timers(struct sock *sk);
+void inet_csk_clear_xmit_timers_sync(struct sock *sk);
 
 static inline void inet_csk_schedule_ack(struct sock *sk)
 {
diff --git a/include/net/sock.h b/include/net/sock.h
index 87ee284ea9cb..8bcc96bf291c 100644
--- a/include/net/sock.h
+++ b/include/net/sock.h
@@ -1681,6 +1681,13 @@ static inline void sock_owned_by_me(const struct sock *sk)
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
diff --git a/include/soc/fsl/qman.h b/include/soc/fsl/qman.h
index 9f484113cfda..3cecbfdb0f8c 100644
--- a/include/soc/fsl/qman.h
+++ b/include/soc/fsl/qman.h
@@ -1170,6 +1170,15 @@ int qman_delete_cgr(struct qman_cgr *cgr);
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
diff --git a/include/uapi/linux/input-event-codes.h b/include/uapi/linux/input-event-codes.h
index 7989d9483ea7..bed20a89c14c 100644
--- a/include/uapi/linux/input-event-codes.h
+++ b/include/uapi/linux/input-event-codes.h
@@ -602,6 +602,7 @@
 
 #define KEY_ALS_TOGGLE		0x230	/* Ambient light sensor */
 #define KEY_ROTATE_LOCK_TOGGLE	0x231	/* Display rotation lock */
+#define KEY_REFRESH_RATE_TOGGLE	0x232	/* Display refresh rate toggle */
 
 #define KEY_BUTTONCONFIG		0x240	/* AL Button Configuration */
 #define KEY_TASKMANAGER		0x241	/* AL Task/Project Manager */
diff --git a/init/initramfs.c b/init/initramfs.c
index 55b74d7e5260..ff0946072723 100644
--- a/init/initramfs.c
+++ b/init/initramfs.c
@@ -589,7 +589,7 @@ static void __init populate_initrd_image(char *err)
 
 	printk(KERN_INFO "rootfs image is not initramfs (%s); looks like an initrd\n",
 			err);
-	file = filp_open("/initrd.image", O_WRONLY | O_CREAT, 0700);
+	file = filp_open("/initrd.image", O_WRONLY|O_CREAT|O_LARGEFILE, 0700);
 	if (IS_ERR(file))
 		return;
 
diff --git a/io_uring/io_uring.c b/io_uring/io_uring.c
index fc60396c9039..93f9ecedc59f 100644
--- a/io_uring/io_uring.c
+++ b/io_uring/io_uring.c
@@ -8247,7 +8247,7 @@ static int io_sqe_files_register(struct io_ring_ctx *ctx, void __user *arg,
 	}
 
 	io_rsrc_node_switch(ctx, NULL);
-	return ret;
+	return 0;
 out_fput:
 	for (i = 0; i < ctx->nr_user_files; i++) {
 		file = io_file_from_index(ctx, i);
diff --git a/kernel/bounds.c b/kernel/bounds.c
index 9795d75b09b2..a94e3769347e 100644
--- a/kernel/bounds.c
+++ b/kernel/bounds.c
@@ -19,7 +19,7 @@ int main(void)
 	DEFINE(NR_PAGEFLAGS, __NR_PAGEFLAGS);
 	DEFINE(MAX_NR_ZONES, __MAX_NR_ZONES);
 #ifdef CONFIG_SMP
-	DEFINE(NR_CPUS_BITS, ilog2(CONFIG_NR_CPUS));
+	DEFINE(NR_CPUS_BITS, bits_per(CONFIG_NR_CPUS));
 #endif
 	DEFINE(SPINLOCK_SIZE, sizeof(spinlock_t));
 	/* End of constants */
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index fce2345f600f..25f8a8716e88 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -3941,6 +3941,11 @@ static int check_stack_access_within_bounds(
 	err = check_stack_slot_within_bounds(min_off, state, type);
 	if (!err && max_off > 0)
 		err = -EINVAL; /* out of stack access into non-negative offsets */
+	if (!err && access_size < 0)
+		/* access_size should not be negative (or overflow an int); others checks
+		 * along the way should have prevented such an access.
+		 */
+		err = -EFAULT; /* invalid negative access size; integer overflow? */
 
 	if (err) {
 		if (tnum_is_const(reg->var_off)) {
diff --git a/kernel/events/core.c b/kernel/events/core.c
index bd569cf23569..e0b47bed8675 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -6890,9 +6890,16 @@ static void perf_output_read_group(struct perf_output_handle *handle,
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
@@ -6928,6 +6935,8 @@ static void perf_output_read_group(struct perf_output_handle *handle,
 
 		__output_copy(handle, values, n * sizeof(u64));
 	}
+
+	local_irq_restore(flags);
 }
 
 #define PERF_FORMAT_TOTAL_TIMES (PERF_FORMAT_TOTAL_TIME_ENABLED|\
diff --git a/kernel/panic.c b/kernel/panic.c
index bc39e2b27d31..30d8da0d43d8 100644
--- a/kernel/panic.c
+++ b/kernel/panic.c
@@ -427,6 +427,14 @@ void panic(const char *fmt, ...)
 
 	/* Do not scroll important messages printed above */
 	suppress_printk = 1;
+
+	/*
+	 * The final messages may not have been printed if in a context that
+	 * defers printing (such as NMI) and irq_work is not available.
+	 * Explicitly flush the kernel log buffer one last time.
+	 */
+	console_flush_on_panic(CONSOLE_FLUSH_PENDING);
+
 	local_irq_enable();
 	for (i = 0; ; i += PANIC_TIMER_STEP) {
 		touch_softlockup_watchdog();
diff --git a/kernel/power/suspend.c b/kernel/power/suspend.c
index 4aa4d5d3947f..14e981c0588a 100644
--- a/kernel/power/suspend.c
+++ b/kernel/power/suspend.c
@@ -187,6 +187,7 @@ static int __init mem_sleep_default_setup(char *str)
 		if (mem_sleep_labels[state] &&
 		    !strcmp(str, mem_sleep_labels[state])) {
 			mem_sleep_default = state;
+			mem_sleep_current = state;
 			break;
 		}
 
diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index 17a310dcb6d9..a8af93cbc293 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -1866,6 +1866,12 @@ static int console_trylock_spinning(void)
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
 
@@ -2684,6 +2690,21 @@ static int __init keep_bootcon_setup(char *str)
 
 early_param("keep_bootcon", keep_bootcon_setup);
 
+static int console_call_setup(struct console *newcon, char *options)
+{
+	int err;
+
+	if (!newcon->setup)
+		return 0;
+
+	/* Synchronize with possible boot console. */
+	console_lock();
+	err = newcon->setup(newcon, options);
+	console_unlock();
+
+	return err;
+}
+
 /*
  * This is called by register_console() to try to match
  * the newly registered console with any of the ones selected
@@ -2693,7 +2714,8 @@ early_param("keep_bootcon", keep_bootcon_setup);
  * Care need to be taken with consoles that are statically
  * enabled such as netconsole
  */
-static int try_enable_new_console(struct console *newcon, bool user_specified)
+static int try_enable_preferred_console(struct console *newcon,
+					bool user_specified)
 {
 	struct console_cmdline *c;
 	int i, err;
@@ -2718,8 +2740,8 @@ static int try_enable_new_console(struct console *newcon, bool user_specified)
 			if (_braille_register_console(newcon, c))
 				return 0;
 
-			if (newcon->setup &&
-			    (err = newcon->setup(newcon, c->options)) != 0)
+			err = console_call_setup(newcon, c->options);
+			if (err)
 				return err;
 		}
 		newcon->flags |= CON_ENABLED;
@@ -2741,6 +2763,23 @@ static int try_enable_new_console(struct console *newcon, bool user_specified)
 	return -ENOENT;
 }
 
+/* Try to enable the console unconditionally */
+static void try_enable_default_console(struct console *newcon)
+{
+	if (newcon->index < 0)
+		newcon->index = 0;
+
+	if (console_call_setup(newcon, NULL) != 0)
+		return;
+
+	newcon->flags |= CON_ENABLED;
+
+	if (newcon->device) {
+		newcon->flags |= CON_CONSDEV;
+		has_preferred_console = true;
+	}
+}
+
 /*
  * The console driver calls this routine during kernel initialization
  * to register the console printing procedure with printk() and to
@@ -2797,25 +2836,15 @@ void register_console(struct console *newcon)
 	 *	didn't select a console we take the first one
 	 *	that registers here.
 	 */
-	if (!has_preferred_console) {
-		if (newcon->index < 0)
-			newcon->index = 0;
-		if (newcon->setup == NULL ||
-		    newcon->setup(newcon, NULL) == 0) {
-			newcon->flags |= CON_ENABLED;
-			if (newcon->device) {
-				newcon->flags |= CON_CONSDEV;
-				has_preferred_console = true;
-			}
-		}
-	}
+	if (!has_preferred_console)
+		try_enable_default_console(newcon);
 
 	/* See if this console matches one we selected on the command line */
-	err = try_enable_new_console(newcon, true);
+	err = try_enable_preferred_console(newcon, true);
 
 	/* If not, try to match against the platform default(s) */
 	if (err == -ENOENT)
-		err = try_enable_new_console(newcon, false);
+		err = try_enable_preferred_console(newcon, false);
 
 	/* printk() messages are not printed to the Braille console. */
 	if (err || newcon->flags & CON_BRL)
diff --git a/kernel/time/timer.c b/kernel/time/timer.c
index e87e638c31bd..c135cefa44ac 100644
--- a/kernel/time/timer.c
+++ b/kernel/time/timer.c
@@ -1030,7 +1030,7 @@ __mod_timer(struct timer_list *timer, unsigned long expires, unsigned int option
 		/*
 		 * We are trying to schedule the timer on the new base.
 		 * However we can't change timer's base while it is running,
-		 * otherwise del_timer_sync() can't detect that the timer's
+		 * otherwise timer_delete_sync() can't detect that the timer's
 		 * handler yet has not finished. This also guarantees that the
 		 * timer is serialized wrt itself.
 		 */
@@ -1068,14 +1068,16 @@ __mod_timer(struct timer_list *timer, unsigned long expires, unsigned int option
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
@@ -1084,24 +1086,27 @@ int mod_timer_pending(struct timer_list *timer, unsigned long expires)
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
@@ -1112,11 +1117,18 @@ EXPORT_SYMBOL(mod_timer);
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
@@ -1125,18 +1137,21 @@ int timer_reduce(struct timer_list *timer, unsigned long expires)
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
  *
- * Timers with an ->expires field in the past will be executed in the next
- * timer tick.
+ * If @timer->expires is already in the past @timer will be queued to
+ * expire at the next timer tick.
+ *
+ * This can only operate on an inactive timer. Attempts to invoke this on
+ * an active timer are rejected with a warning.
  */
 void add_timer(struct timer_list *timer)
 {
@@ -1146,11 +1161,13 @@ void add_timer(struct timer_list *timer)
 EXPORT_SYMBOL(add_timer);
 
 /**
- * add_timer_on - start a timer on a particular CPU
- * @timer: the timer to be added
- * @cpu: the CPU to start it on
+ * add_timer_on - Start a timer on a particular CPU
+ * @timer:	The timer to be started
+ * @cpu:	The CPU to start it on
+ *
+ * Same as add_timer() except that it starts the timer on the given CPU.
  *
- * This is not very scalable on SMP. Double adds are not possible.
+ * See add_timer() for further details.
  */
 void add_timer_on(struct timer_list *timer, int cpu)
 {
@@ -1185,15 +1202,18 @@ void add_timer_on(struct timer_list *timer, int cpu)
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
@@ -1215,10 +1235,19 @@ EXPORT_SYMBOL(del_timer);
 
 /**
  * try_to_del_timer_sync - Try to deactivate a timer
- * @timer: timer to delete
+ * @timer:	Timer to deactivate
+ *
+ * This function tries to deactivate a timer. On success the timer is not
+ * queued and the timer callback function is not running on any CPU.
+ *
+ * This function does not guarantee that the timer cannot be rearmed right
+ * after dropping the base lock. That needs to be prevented by the calling
+ * code if necessary.
  *
- * This function tries to deactivate a timer. Upon successful (ret >= 0)
- * exit the timer is not queued and the handler is not running on any CPU.
+ * Return:
+ * * %0  - The timer was not pending
+ * * %1  - The timer was pending and deactivated
+ * * %-1 - The timer callback function is running on a different CPU
  */
 int try_to_del_timer_sync(struct timer_list *timer)
 {
@@ -1312,25 +1341,20 @@ static inline void timer_sync_wait_running(struct timer_base *base) { }
 static inline void del_timer_wait_running(struct timer_list *timer) { }
 #endif
 
-#if defined(CONFIG_SMP) || defined(CONFIG_PREEMPT_RT)
 /**
- * del_timer_sync - deactivate a timer and wait for the handler to finish.
- * @timer: the timer to be deactivated
- *
- * This function only differs from del_timer() on SMP: besides deactivating
- * the timer it also makes sure the handler has finished executing on other
- * CPUs.
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
@@ -1340,16 +1364,23 @@ static inline void del_timer_wait_running(struct timer_list *timer) { }
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
 	int ret;
 
@@ -1382,8 +1413,7 @@ int del_timer_sync(struct timer_list *timer)
 
 	return ret;
 }
-EXPORT_SYMBOL(del_timer_sync);
-#endif
+EXPORT_SYMBOL(timer_delete_sync);
 
 static void call_timer_fn(struct timer_list *timer,
 			  void (*fn)(struct timer_list *),
@@ -1405,8 +1435,8 @@ static void call_timer_fn(struct timer_list *timer,
 #endif
 	/*
 	 * Couple the lock chain with the lock chain at
-	 * del_timer_sync() by acquiring the lock_map around the fn()
-	 * call here and in del_timer_sync().
+	 * timer_delete_sync() by acquiring the lock_map around the fn()
+	 * call here and in timer_delete_sync().
 	 */
 	lock_map_acquire(&lockdep_map);
 
diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
index 4a43b8846b49..2df8e13a29e5 100644
--- a/kernel/trace/ring_buffer.c
+++ b/kernel/trace/ring_buffer.c
@@ -415,7 +415,6 @@ struct rb_irq_work {
 	struct irq_work			work;
 	wait_queue_head_t		waiters;
 	wait_queue_head_t		full_waiters;
-	long				wait_index;
 	bool				waiters_pending;
 	bool				full_waiters_pending;
 	bool				wakeup_full;
@@ -832,8 +831,19 @@ static void rb_wake_up_waiters(struct irq_work *work)
 
 	wake_up_all(&rbwork->waiters);
 	if (rbwork->full_waiters_pending || rbwork->wakeup_full) {
+		/* Only cpu_buffer sets the above flags */
+		struct ring_buffer_per_cpu *cpu_buffer =
+			container_of(rbwork, struct ring_buffer_per_cpu, irq_work);
+
+		/* Called from interrupt context */
+		raw_spin_lock(&cpu_buffer->reader_lock);
 		rbwork->wakeup_full = false;
 		rbwork->full_waiters_pending = false;
+
+		/* Waking up all waiters, they will reset the shortest full */
+		cpu_buffer->shortest_full = 0;
+		raw_spin_unlock(&cpu_buffer->reader_lock);
+
 		wake_up_all(&rbwork->full_waiters);
 	}
 }
@@ -862,14 +872,41 @@ void ring_buffer_wake_waiters(struct trace_buffer *buffer, int cpu)
 		rbwork = &cpu_buffer->irq_work;
 	}
 
-	rbwork->wait_index++;
-	/* make sure the waiters see the new index */
-	smp_wmb();
-
 	/* This can be called in any context */
 	irq_work_queue(&rbwork->work);
 }
 
+static bool rb_watermark_hit(struct trace_buffer *buffer, int cpu, int full)
+{
+	struct ring_buffer_per_cpu *cpu_buffer;
+	bool ret = false;
+
+	/* Reads of all CPUs always waits for any data */
+	if (cpu == RING_BUFFER_ALL_CPUS)
+		return !ring_buffer_empty(buffer);
+
+	cpu_buffer = buffer->buffers[cpu];
+
+	if (!ring_buffer_empty_cpu(buffer, cpu)) {
+		unsigned long flags;
+		bool pagebusy;
+
+		if (!full)
+			return true;
+
+		raw_spin_lock_irqsave(&cpu_buffer->reader_lock, flags);
+		pagebusy = cpu_buffer->reader_page == cpu_buffer->commit_page;
+		ret = !pagebusy && full_hit(buffer, cpu, full);
+
+		if (!ret && (!cpu_buffer->shortest_full ||
+			     cpu_buffer->shortest_full > full)) {
+		    cpu_buffer->shortest_full = full;
+		}
+		raw_spin_unlock_irqrestore(&cpu_buffer->reader_lock, flags);
+	}
+	return ret;
+}
+
 /**
  * ring_buffer_wait - wait for input to the ring buffer
  * @buffer: buffer to wait on
@@ -885,7 +922,6 @@ int ring_buffer_wait(struct trace_buffer *buffer, int cpu, int full)
 	struct ring_buffer_per_cpu *cpu_buffer;
 	DEFINE_WAIT(wait);
 	struct rb_irq_work *work;
-	long wait_index;
 	int ret = 0;
 
 	/*
@@ -904,81 +940,54 @@ int ring_buffer_wait(struct trace_buffer *buffer, int cpu, int full)
 		work = &cpu_buffer->irq_work;
 	}
 
-	wait_index = READ_ONCE(work->wait_index);
-
-	while (true) {
-		if (full)
-			prepare_to_wait(&work->full_waiters, &wait, TASK_INTERRUPTIBLE);
-		else
-			prepare_to_wait(&work->waiters, &wait, TASK_INTERRUPTIBLE);
-
-		/*
-		 * The events can happen in critical sections where
-		 * checking a work queue can cause deadlocks.
-		 * After adding a task to the queue, this flag is set
-		 * only to notify events to try to wake up the queue
-		 * using irq_work.
-		 *
-		 * We don't clear it even if the buffer is no longer
-		 * empty. The flag only causes the next event to run
-		 * irq_work to do the work queue wake up. The worse
-		 * that can happen if we race with !trace_empty() is that
-		 * an event will cause an irq_work to try to wake up
-		 * an empty queue.
-		 *
-		 * There's no reason to protect this flag either, as
-		 * the work queue and irq_work logic will do the necessary
-		 * synchronization for the wake ups. The only thing
-		 * that is necessary is that the wake up happens after
-		 * a task has been queued. It's OK for spurious wake ups.
-		 */
-		if (full)
-			work->full_waiters_pending = true;
-		else
-			work->waiters_pending = true;
-
-		if (signal_pending(current)) {
-			ret = -EINTR;
-			break;
-		}
-
-		if (cpu == RING_BUFFER_ALL_CPUS && !ring_buffer_empty(buffer))
-			break;
-
-		if (cpu != RING_BUFFER_ALL_CPUS &&
-		    !ring_buffer_empty_cpu(buffer, cpu)) {
-			unsigned long flags;
-			bool pagebusy;
-			bool done;
-
-			if (!full)
-				break;
-
-			raw_spin_lock_irqsave(&cpu_buffer->reader_lock, flags);
-			pagebusy = cpu_buffer->reader_page == cpu_buffer->commit_page;
-			done = !pagebusy && full_hit(buffer, cpu, full);
+	if (full)
+		prepare_to_wait(&work->full_waiters, &wait, TASK_INTERRUPTIBLE);
+	else
+		prepare_to_wait(&work->waiters, &wait, TASK_INTERRUPTIBLE);
 
-			if (!cpu_buffer->shortest_full ||
-			    cpu_buffer->shortest_full > full)
-				cpu_buffer->shortest_full = full;
-			raw_spin_unlock_irqrestore(&cpu_buffer->reader_lock, flags);
-			if (done)
-				break;
-		}
+	/*
+	 * The events can happen in critical sections where
+	 * checking a work queue can cause deadlocks.
+	 * After adding a task to the queue, this flag is set
+	 * only to notify events to try to wake up the queue
+	 * using irq_work.
+	 *
+	 * We don't clear it even if the buffer is no longer
+	 * empty. The flag only causes the next event to run
+	 * irq_work to do the work queue wake up. The worse
+	 * that can happen if we race with !trace_empty() is that
+	 * an event will cause an irq_work to try to wake up
+	 * an empty queue.
+	 *
+	 * There's no reason to protect this flag either, as
+	 * the work queue and irq_work logic will do the necessary
+	 * synchronization for the wake ups. The only thing
+	 * that is necessary is that the wake up happens after
+	 * a task has been queued. It's OK for spurious wake ups.
+	 */
+	if (full)
+		work->full_waiters_pending = true;
+	else
+		work->waiters_pending = true;
 
-		schedule();
+	if (rb_watermark_hit(buffer, cpu, full))
+		goto out;
 
-		/* Make sure to see the new wait index */
-		smp_rmb();
-		if (wait_index != work->wait_index)
-			break;
+	if (signal_pending(current)) {
+		ret = -EINTR;
+		goto out;
 	}
 
+	schedule();
+ out:
 	if (full)
 		finish_wait(&work->full_waiters, &wait);
 	else
 		finish_wait(&work->waiters, &wait);
 
+	if (!ret && !rb_watermark_hit(buffer, cpu, full) && signal_pending(current))
+		ret = -EINTR;
+
 	return ret;
 }
 
@@ -1001,30 +1010,51 @@ __poll_t ring_buffer_poll_wait(struct trace_buffer *buffer, int cpu,
 			  struct file *filp, poll_table *poll_table, int full)
 {
 	struct ring_buffer_per_cpu *cpu_buffer;
-	struct rb_irq_work *work;
+	struct rb_irq_work *rbwork;
 
 	if (cpu == RING_BUFFER_ALL_CPUS) {
-		work = &buffer->irq_work;
+		rbwork = &buffer->irq_work;
 		full = 0;
 	} else {
 		if (!cpumask_test_cpu(cpu, buffer->cpumask))
 			return EPOLLERR;
 
 		cpu_buffer = buffer->buffers[cpu];
-		work = &cpu_buffer->irq_work;
+		rbwork = &cpu_buffer->irq_work;
 	}
 
 	if (full) {
-		poll_wait(filp, &work->full_waiters, poll_table);
-		work->full_waiters_pending = true;
+		unsigned long flags;
+
+		poll_wait(filp, &rbwork->full_waiters, poll_table);
+
+		raw_spin_lock_irqsave(&cpu_buffer->reader_lock, flags);
 		if (!cpu_buffer->shortest_full ||
 		    cpu_buffer->shortest_full > full)
 			cpu_buffer->shortest_full = full;
-	} else {
-		poll_wait(filp, &work->waiters, poll_table);
-		work->waiters_pending = true;
+		raw_spin_unlock_irqrestore(&cpu_buffer->reader_lock, flags);
+		if (full_hit(buffer, cpu, full))
+			return EPOLLIN | EPOLLRDNORM;
+		/*
+		 * Only allow full_waiters_pending update to be seen after
+		 * the shortest_full is set. If the writer sees the
+		 * full_waiters_pending flag set, it will compare the
+		 * amount in the ring buffer to shortest_full. If the amount
+		 * in the ring buffer is greater than the shortest_full
+		 * percent, it will call the irq_work handler to wake up
+		 * this list. The irq_handler will reset shortest_full
+		 * back to zero. That's done under the reader_lock, but
+		 * the below smp_mb() makes sure that the update to
+		 * full_waiters_pending doesn't leak up into the above.
+		 */
+		smp_mb();
+		rbwork->full_waiters_pending = true;
+		return 0;
 	}
 
+	poll_wait(filp, &rbwork->waiters, poll_table);
+	rbwork->waiters_pending = true;
+
 	/*
 	 * There's a tight race between setting the waiters_pending and
 	 * checking if the ring buffer is empty.  Once the waiters_pending bit
@@ -1040,9 +1070,6 @@ __poll_t ring_buffer_poll_wait(struct trace_buffer *buffer, int cpu,
 	 */
 	smp_mb();
 
-	if (full)
-		return full_hit(buffer, cpu, full) ? EPOLLIN | EPOLLRDNORM : 0;
-
 	if ((cpu == RING_BUFFER_ALL_CPUS && !ring_buffer_empty(buffer)) ||
 	    (cpu != RING_BUFFER_ALL_CPUS && !ring_buffer_empty_cpu(buffer, cpu)))
 		return EPOLLIN | EPOLLRDNORM;
@@ -4184,7 +4211,7 @@ int ring_buffer_iter_empty(struct ring_buffer_iter *iter)
 	cpu_buffer = iter->cpu_buffer;
 	reader = cpu_buffer->reader_page;
 	head_page = cpu_buffer->head_page;
-	commit_page = cpu_buffer->commit_page;
+	commit_page = READ_ONCE(cpu_buffer->commit_page);
 	commit_ts = commit_page->page->time_stamp;
 
 	/*
diff --git a/mm/compaction.c b/mm/compaction.c
index b58021666e1a..77ca5e6f4980 100644
--- a/mm/compaction.c
+++ b/mm/compaction.c
@@ -2466,16 +2466,11 @@ enum compact_result try_to_compact_pages(gfp_t gfp_mask, unsigned int order,
 		unsigned int alloc_flags, const struct alloc_context *ac,
 		enum compact_priority prio, struct page **capture)
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
index f320ff02cc19..dba2936292cf 100644
--- a/mm/memory-failure.c
+++ b/mm/memory-failure.c
@@ -1075,7 +1075,7 @@ static bool hwpoison_user_mappings(struct page *p, unsigned long pfn,
 				unmap_success = false;
 			}
 		} else {
-			unmap_success = try_to_unmap(p, ttu);
+			unmap_success = try_to_unmap(hpage, ttu);
 		}
 	}
 	if (!unmap_success)
diff --git a/mm/memory.c b/mm/memory.c
index 1d101aeae416..2183003687ce 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -4934,6 +4934,10 @@ int follow_phys(struct vm_area_struct *vma,
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
index fcb7eb6a6eca..c0a8f3c9e256 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -447,8 +447,12 @@ int migrate_page_move_mapping(struct address_space *mapping,
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
index 124ab9324610..ed66601044be 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -4644,6 +4644,7 @@ __alloc_pages_slowpath(gfp_t gfp_mask, unsigned int order,
 						struct alloc_context *ac)
 {
 	bool can_direct_reclaim = gfp_mask & __GFP_DIRECT_RECLAIM;
+	bool can_compact = gfp_compaction_allowed(gfp_mask);
 	const bool costly_order = order > PAGE_ALLOC_COSTLY_ORDER;
 	struct page *page = NULL;
 	unsigned int alloc_flags;
@@ -4709,7 +4710,7 @@ __alloc_pages_slowpath(gfp_t gfp_mask, unsigned int order,
 	 * Don't try this for allocations that are allowed to ignore
 	 * watermarks, as the ALLOC_NO_WATERMARKS attempt didn't yet happen.
 	 */
-	if (can_direct_reclaim &&
+	if (can_direct_reclaim && can_compact &&
 			(costly_order ||
 			   (order > 0 && ac->migratetype != MIGRATE_MOVABLE))
 			&& !gfp_pfmemalloc_allowed(gfp_mask)) {
@@ -4806,9 +4807,10 @@ __alloc_pages_slowpath(gfp_t gfp_mask, unsigned int order,
 
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
@@ -4821,7 +4823,7 @@ __alloc_pages_slowpath(gfp_t gfp_mask, unsigned int order,
 	 * implementation of the compaction depends on the sufficient amount
 	 * of free memory (see __compaction_suitable)
 	 */
-	if (did_some_progress > 0 &&
+	if (did_some_progress > 0 && can_compact &&
 			should_compact_retry(ac, order, alloc_flags,
 				compact_result, &compact_priority,
 				&compaction_retries))
diff --git a/mm/swapfile.c b/mm/swapfile.c
index 86ade667a7af..4ca1d04d8732 100644
--- a/mm/swapfile.c
+++ b/mm/swapfile.c
@@ -1271,6 +1271,11 @@ static unsigned char __swap_entry_free_locked(struct swap_info_struct *p,
 }
 
 /*
+ * Note that when only holding the PTL, swapoff might succeed immediately
+ * after freeing a swap entry. Therefore, immediately after
+ * __swap_entry_free(), the swap info might become stale and should not
+ * be touched without a prior get_swap_device().
+ *
  * Check whether swap entry is valid in the swap device.  If so,
  * return pointer to swap_info_struct, and keep the swap entry valid
  * via preventing the swap device from being swapoff, until
@@ -1797,13 +1802,19 @@ int free_swap_and_cache(swp_entry_t entry)
 	if (non_swap_entry(entry))
 		return 1;
 
-	p = _swap_info_get(entry);
+	p = get_swap_device(entry);
 	if (p) {
+		if (WARN_ON(data_race(!p->swap_map[swp_offset(entry)]))) {
+			put_swap_device(p);
+			return 0;
+		}
+
 		count = __swap_entry_free(p, entry);
 		if (count == SWAP_HAS_CACHE &&
 		    !swap_page_trans_huge_swapped(p, entry))
 			__try_to_reclaim_swap(p, swp_offset(entry),
 					      TTRS_UNMAPPED | TTRS_FULL);
+		put_swap_device(p);
 	}
 	return p != NULL;
 }
diff --git a/mm/vmscan.c b/mm/vmscan.c
index 51ccd80e70b6..e2b8cee1dbc3 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -2546,7 +2546,7 @@ static void shrink_lruvec(struct lruvec *lruvec, struct scan_control *sc)
 /* Use reclaim/compaction for costly allocs or under memory pressure */
 static bool in_reclaim_compaction(struct scan_control *sc)
 {
-	if (IS_ENABLED(CONFIG_COMPACTION) && sc->order &&
+	if (gfp_compaction_allowed(sc->gfp_mask) && sc->order &&
 			(sc->order > PAGE_ALLOC_COSTLY_ORDER ||
 			 sc->priority < DEF_PRIORITY - 2))
 		return true;
@@ -2873,6 +2873,9 @@ static inline bool compaction_ready(struct zone *zone, struct scan_control *sc)
 	unsigned long watermark;
 	enum compact_result suitable;
 
+	if (!gfp_compaction_allowed(sc->gfp_mask))
+		return false;
+
 	suitable = compaction_suitable(zone, sc->order, 0, sc->reclaim_idx);
 	if (suitable == COMPACT_SUCCESS)
 		/* Allocation should succeed already. Don't reclaim. */
diff --git a/net/bluetooth/hci_debugfs.c b/net/bluetooth/hci_debugfs.c
index d4efc4aa55af..131bb56bf2af 100644
--- a/net/bluetooth/hci_debugfs.c
+++ b/net/bluetooth/hci_debugfs.c
@@ -216,10 +216,12 @@ static int conn_info_min_age_set(void *data, u64 val)
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
 
@@ -244,10 +246,12 @@ static int conn_info_max_age_set(void *data, u64 val)
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
 
@@ -526,10 +530,12 @@ static int sniff_min_interval_set(void *data, u64 val)
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
 
@@ -554,10 +560,12 @@ static int sniff_max_interval_set(void *data, u64 val)
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
 
@@ -798,10 +806,12 @@ static int conn_min_interval_set(void *data, u64 val)
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
 
@@ -826,10 +836,12 @@ static int conn_max_interval_set(void *data, u64 val)
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
 
@@ -938,10 +950,12 @@ static int adv_min_interval_set(void *data, u64 val)
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
 
@@ -966,10 +980,12 @@ static int adv_max_interval_set(void *data, u64 val)
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
index a0d9bc99f4e1..58c029958759 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -2636,6 +2636,31 @@ static void hci_conn_complete_evt(struct hci_dev *hdev, struct sk_buff *skb)
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
diff --git a/net/bridge/netfilter/ebtables.c b/net/bridge/netfilter/ebtables.c
index bab14186f9ad..14a06d8b1a2d 100644
--- a/net/bridge/netfilter/ebtables.c
+++ b/net/bridge/netfilter/ebtables.c
@@ -1070,6 +1070,8 @@ static int do_replace(struct net *net, sockptr_t arg, unsigned int len)
 	struct ebt_table_info *newinfo;
 	struct ebt_replace tmp;
 
+	if (len < sizeof(tmp))
+		return -EINVAL;
 	if (copy_from_sockptr(&tmp, arg, sizeof(tmp)) != 0)
 		return -EFAULT;
 
@@ -1309,6 +1311,8 @@ static int update_counters(struct net *net, sockptr_t arg, unsigned int len)
 {
 	struct ebt_replace hlp;
 
+	if (len < sizeof(hlp))
+		return -EINVAL;
 	if (copy_from_sockptr(&hlp, arg, sizeof(hlp)))
 		return -EFAULT;
 
@@ -2238,6 +2242,8 @@ static int compat_update_counters(struct net *net, sockptr_t arg,
 {
 	struct compat_ebt_replace hlp;
 
+	if (len < sizeof(hlp))
+		return -EINVAL;
 	if (copy_from_sockptr(&hlp, arg, sizeof(hlp)))
 		return -EFAULT;
 
diff --git a/net/core/sock_map.c b/net/core/sock_map.c
index f375ef150149..52e395a189df 100644
--- a/net/core/sock_map.c
+++ b/net/core/sock_map.c
@@ -422,6 +422,9 @@ static int __sock_map_delete(struct bpf_stab *stab, struct sock *sk_test,
 	struct sock *sk;
 	int err = 0;
 
+	if (irqs_disabled())
+		return -EOPNOTSUPP; /* locks here are hardirq-unsafe */
+
 	raw_spin_lock_bh(&stab->lock);
 	sk = *psk;
 	if (!sk_test || sk_test == sk)
@@ -955,6 +958,9 @@ static int sock_hash_delete_elem(struct bpf_map *map, void *key)
 	struct bpf_shtab_elem *elem;
 	int ret = -ENOENT;
 
+	if (irqs_disabled())
+		return -EOPNOTSUPP; /* locks here are hardirq-unsafe */
+
 	hash = sock_hash_bucket_hash(key, key_size);
 	bucket = sock_hash_select_bucket(htab, hash);
 
diff --git a/net/ipv4/inet_connection_sock.c b/net/ipv4/inet_connection_sock.c
index b15c9ad0095a..6ebe43b4d28f 100644
--- a/net/ipv4/inet_connection_sock.c
+++ b/net/ipv4/inet_connection_sock.c
@@ -580,6 +580,20 @@ void inet_csk_clear_xmit_timers(struct sock *sk)
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
index a6ad0fe1387c..0ac652fef06d 100644
--- a/net/ipv4/ip_gre.c
+++ b/net/ipv4/ip_gre.c
@@ -278,8 +278,13 @@ static int erspan_rcv(struct sk_buff *skb, struct tnl_ptk_info *tpi,
 					  tpi->flags | TUNNEL_NO_KEY,
 					  iph->saddr, iph->daddr, 0);
 	} else {
+		if (unlikely(!pskb_may_pull(skb,
+					    gre_hdr_len + sizeof(*ershdr))))
+			return PACKET_REJECT;
+
 		ershdr = (struct erspan_base_hdr *)(skb->data + gre_hdr_len);
 		ver = ershdr->ver;
+		iph = ip_hdr(skb);
 		tunnel = ip_tunnel_lookup(itn, skb->dev->ifindex,
 					  tpi->flags | TUNNEL_KEY,
 					  iph->saddr, iph->daddr, tpi->key);
diff --git a/net/ipv4/netfilter/arp_tables.c b/net/ipv4/netfilter/arp_tables.c
index d6d45d820d79..48c6aa3d91ae 100644
--- a/net/ipv4/netfilter/arp_tables.c
+++ b/net/ipv4/netfilter/arp_tables.c
@@ -955,6 +955,8 @@ static int do_replace(struct net *net, sockptr_t arg, unsigned int len)
 	void *loc_cpu_entry;
 	struct arpt_entry *iter;
 
+	if (len < sizeof(tmp))
+		return -EINVAL;
 	if (copy_from_sockptr(&tmp, arg, sizeof(tmp)) != 0)
 		return -EFAULT;
 
@@ -1253,6 +1255,8 @@ static int compat_do_replace(struct net *net, sockptr_t arg, unsigned int len)
 	void *loc_cpu_entry;
 	struct arpt_entry *iter;
 
+	if (len < sizeof(tmp))
+		return -EINVAL;
 	if (copy_from_sockptr(&tmp, arg, sizeof(tmp)) != 0)
 		return -EFAULT;
 
diff --git a/net/ipv4/netfilter/ip_tables.c b/net/ipv4/netfilter/ip_tables.c
index ec981618b7b2..b46d58b9f3fe 100644
--- a/net/ipv4/netfilter/ip_tables.c
+++ b/net/ipv4/netfilter/ip_tables.c
@@ -1109,6 +1109,8 @@ do_replace(struct net *net, sockptr_t arg, unsigned int len)
 	void *loc_cpu_entry;
 	struct ipt_entry *iter;
 
+	if (len < sizeof(tmp))
+		return -EINVAL;
 	if (copy_from_sockptr(&tmp, arg, sizeof(tmp)) != 0)
 		return -EFAULT;
 
@@ -1493,6 +1495,8 @@ compat_do_replace(struct net *net, sockptr_t arg, unsigned int len)
 	void *loc_cpu_entry;
 	struct ipt_entry *iter;
 
+	if (len < sizeof(tmp))
+		return -EINVAL;
 	if (copy_from_sockptr(&tmp, arg, sizeof(tmp)) != 0)
 		return -EFAULT;
 
diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
index 2e874ec85971..ac6cb2dc6038 100644
--- a/net/ipv4/tcp.c
+++ b/net/ipv4/tcp.c
@@ -2717,6 +2717,8 @@ void tcp_close(struct sock *sk, long timeout)
 	lock_sock(sk);
 	__tcp_close(sk, timeout);
 	release_sock(sk);
+	if (!sk->sk_net_refcnt)
+		inet_csk_clear_xmit_timers_sync(sk);
 	sock_put(sk);
 }
 EXPORT_SYMBOL(tcp_close);
diff --git a/net/ipv4/udp.c b/net/ipv4/udp.c
index b2541c7d7c87..0b7e76e6f202 100644
--- a/net/ipv4/udp.c
+++ b/net/ipv4/udp.c
@@ -602,6 +602,13 @@ static inline bool __udp_is_mcast_sock(struct net *net, struct sock *sk,
 }
 
 DEFINE_STATIC_KEY_FALSE(udp_encap_needed_key);
+EXPORT_SYMBOL(udp_encap_needed_key);
+
+#if IS_ENABLED(CONFIG_IPV6)
+DEFINE_STATIC_KEY_FALSE(udpv6_encap_needed_key);
+EXPORT_SYMBOL(udpv6_encap_needed_key);
+#endif
+
 void udp_encap_enable(void)
 {
 	static_branch_inc(&udp_encap_needed_key);
diff --git a/net/ipv4/udp_offload.c b/net/ipv4/udp_offload.c
index f4b8e56068e0..445d8bc30fdd 100644
--- a/net/ipv4/udp_offload.c
+++ b/net/ipv4/udp_offload.c
@@ -512,6 +512,11 @@ struct sk_buff *udp_gro_receive(struct list_head *head, struct sk_buff *skb,
 	unsigned int off = skb_gro_offset(skb);
 	int flush = 1;
 
+	/* We can do L4 aggregation only if the packet can't land in a tunnel
+	 * otherwise we could corrupt the inner stream. Detecting such packets
+	 * cannot be foolproof and the aggregation might still happen in some
+	 * cases. Such packets should be caught in udp_unexpected_gso later.
+	 */
 	NAPI_GRO_CB(skb)->is_flist = 0;
 	if (skb->dev->features & NETIF_F_GRO_FRAGLIST)
 		NAPI_GRO_CB(skb)->is_flist = sk ? !udp_sk(sk)->gro_enabled: 1;
@@ -668,13 +673,7 @@ INDIRECT_CALLABLE_SCOPE int udp4_gro_complete(struct sk_buff *skb, int nhoff)
 		skb_shinfo(skb)->gso_type |= (SKB_GSO_FRAGLIST|SKB_GSO_UDP_L4);
 		skb_shinfo(skb)->gso_segs = NAPI_GRO_CB(skb)->count;
 
-		if (skb->ip_summed == CHECKSUM_UNNECESSARY) {
-			if (skb->csum_level < SKB_MAX_CSUM_LEVEL)
-				skb->csum_level++;
-		} else {
-			skb->ip_summed = CHECKSUM_UNNECESSARY;
-			skb->csum_level = 0;
-		}
+		__skb_incr_checksum_unnecessary(skb);
 
 		return 0;
 	}
diff --git a/net/ipv6/ip6_fib.c b/net/ipv6/ip6_fib.c
index 608205c632c8..d70783283a41 100644
--- a/net/ipv6/ip6_fib.c
+++ b/net/ipv6/ip6_fib.c
@@ -643,19 +643,19 @@ static int inet6_dump_fib(struct sk_buff *skb, struct netlink_callback *cb)
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
index 2df1036330f8..13ac0ccdc8d7 100644
--- a/net/ipv6/ip6_gre.c
+++ b/net/ipv6/ip6_gre.c
@@ -533,6 +533,9 @@ static int ip6erspan_rcv(struct sk_buff *skb,
 	struct ip6_tnl *tunnel;
 	u8 ver;
 
+	if (unlikely(!pskb_may_pull(skb, sizeof(*ershdr))))
+		return PACKET_REJECT;
+
 	ipv6h = ipv6_hdr(skb);
 	ershdr = (struct erspan_base_hdr *)skb->data;
 	ver = ershdr->ver;
diff --git a/net/ipv6/netfilter/ip6_tables.c b/net/ipv6/netfilter/ip6_tables.c
index 99bb11d16712..d013395be05f 100644
--- a/net/ipv6/netfilter/ip6_tables.c
+++ b/net/ipv6/netfilter/ip6_tables.c
@@ -1127,6 +1127,8 @@ do_replace(struct net *net, sockptr_t arg, unsigned int len)
 	void *loc_cpu_entry;
 	struct ip6t_entry *iter;
 
+	if (len < sizeof(tmp))
+		return -EINVAL;
 	if (copy_from_sockptr(&tmp, arg, sizeof(tmp)) != 0)
 		return -EFAULT;
 
@@ -1503,6 +1505,8 @@ compat_do_replace(struct net *net, sockptr_t arg, unsigned int len)
 	void *loc_cpu_entry;
 	struct ip6t_entry *iter;
 
+	if (len < sizeof(tmp))
+		return -EINVAL;
 	if (copy_from_sockptr(&tmp, arg, sizeof(tmp)) != 0)
 		return -EFAULT;
 
diff --git a/net/ipv6/udp.c b/net/ipv6/udp.c
index 5385037209a6..b5d879f2501d 100644
--- a/net/ipv6/udp.c
+++ b/net/ipv6/udp.c
@@ -474,7 +474,7 @@ int udpv6_recvmsg(struct sock *sk, struct msghdr *msg, size_t len,
 	goto try_again;
 }
 
-DEFINE_STATIC_KEY_FALSE(udpv6_encap_needed_key);
+DECLARE_STATIC_KEY_FALSE(udpv6_encap_needed_key);
 void udpv6_encap_enable(void)
 {
 	static_branch_inc(&udpv6_encap_needed_key);
diff --git a/net/ipv6/udp_offload.c b/net/ipv6/udp_offload.c
index ebee748f25b9..7752e1e921f8 100644
--- a/net/ipv6/udp_offload.c
+++ b/net/ipv6/udp_offload.c
@@ -169,13 +169,7 @@ INDIRECT_CALLABLE_SCOPE int udp6_gro_complete(struct sk_buff *skb, int nhoff)
 		skb_shinfo(skb)->gso_type |= (SKB_GSO_FRAGLIST|SKB_GSO_UDP_L4);
 		skb_shinfo(skb)->gso_segs = NAPI_GRO_CB(skb)->count;
 
-		if (skb->ip_summed == CHECKSUM_UNNECESSARY) {
-			if (skb->csum_level < SKB_MAX_CSUM_LEVEL)
-				skb->csum_level++;
-		} else {
-			skb->ip_summed = CHECKSUM_UNNECESSARY;
-			skb->csum_level = 0;
-		}
+		__skb_incr_checksum_unnecessary(skb);
 
 		return 0;
 	}
diff --git a/net/mac80211/cfg.c b/net/mac80211/cfg.c
index 45bb6f275598..0c3da7771b48 100644
--- a/net/mac80211/cfg.c
+++ b/net/mac80211/cfg.c
@@ -1811,15 +1811,14 @@ static int ieee80211_change_station(struct wiphy *wiphy,
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
diff --git a/net/mac802154/llsec.c b/net/mac802154/llsec.c
index 55550ead2ced..a4cc9d077c59 100644
--- a/net/mac802154/llsec.c
+++ b/net/mac802154/llsec.c
@@ -265,19 +265,27 @@ int mac802154_llsec_key_add(struct mac802154_llsec *sec,
 	return -ENOMEM;
 }
 
+static void mac802154_llsec_key_del_rcu(struct rcu_head *rcu)
+{
+	struct ieee802154_llsec_key_entry *pos;
+	struct mac802154_llsec_key *mkey;
+
+	pos = container_of(rcu, struct ieee802154_llsec_key_entry, rcu);
+	mkey = container_of(pos->key, struct mac802154_llsec_key, key);
+
+	llsec_key_put(mkey);
+	kfree_sensitive(pos);
+}
+
 int mac802154_llsec_key_del(struct mac802154_llsec *sec,
 			    const struct ieee802154_llsec_key_id *key)
 {
 	struct ieee802154_llsec_key_entry *pos;
 
 	list_for_each_entry(pos, &sec->table.keys, list) {
-		struct mac802154_llsec_key *mkey;
-
-		mkey = container_of(pos->key, struct mac802154_llsec_key, key);
-
 		if (llsec_key_id_equal(&pos->id, key)) {
 			list_del_rcu(&pos->list);
-			llsec_key_put(mkey);
+			call_rcu(&pos->rcu, mac802154_llsec_key_del_rcu);
 			return 0;
 		}
 	}
diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index adbe6350f980..6be7e7592291 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -2218,9 +2218,6 @@ static struct sock *mptcp_accept(struct sock *sk, int flags, int *err,
 
 		__MPTCP_INC_STATS(sock_net(sk), MPTCP_MIB_MPCAPABLEPASSIVEACK);
 		local_bh_enable();
-	} else {
-		MPTCP_INC_STATS(sock_net(sk),
-				MPTCP_MIB_MPCAPABLEPASSIVEFALLBACK);
 	}
 
 out:
diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index 607519246bf2..276fe9f44df7 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -595,6 +595,9 @@ static struct sock *subflow_syn_recv_sock(const struct sock *sk,
 			if (fallback_is_fatal)
 				goto dispose_child;
 
+			if (fallback)
+				SUBFLOW_REQ_INC_STATS(req, MPTCP_MIB_MPCAPABLEPASSIVEFALLBACK);
+
 			subflow_drop_ctx(child);
 			goto out;
 		}
diff --git a/net/netfilter/nf_tables_api.c b/net/netfilter/nf_tables_api.c
index 8d4472b127e4..ab7f7e45b984 100644
--- a/net/netfilter/nf_tables_api.c
+++ b/net/netfilter/nf_tables_api.c
@@ -1084,6 +1084,24 @@ static void nf_tables_table_disable(struct net *net, struct nft_table *table)
 #define __NFT_TABLE_F_UPDATE		(__NFT_TABLE_F_WAS_DORMANT | \
 					 __NFT_TABLE_F_WAS_AWAKEN)
 
+static bool nft_table_pending_update(const struct nft_ctx *ctx)
+{
+	struct nftables_pernet *nft_net = net_generic(ctx->net, nf_tables_net_id);
+	struct nft_trans *trans;
+
+	if (ctx->table->flags & __NFT_TABLE_F_UPDATE)
+		return true;
+
+	list_for_each_entry(trans, &nft_net->commit_list, list) {
+		if (trans->ctx.table == ctx->table &&
+		    trans->msg_type == NFT_MSG_DELCHAIN &&
+		    nft_is_base_chain(trans->ctx.chain))
+			return true;
+	}
+
+	return false;
+}
+
 static int nf_tables_updtable(struct nft_ctx *ctx)
 {
 	struct nft_trans *trans;
@@ -1101,7 +1119,7 @@ static int nf_tables_updtable(struct nft_ctx *ctx)
 		return 0;
 
 	/* No dormant off/on/off/on games in single transaction */
-	if (ctx->table->flags & __NFT_TABLE_F_UPDATE)
+	if (nft_table_pending_update(ctx))
 		return -EINVAL;
 
 	trans = nft_trans_alloc(ctx, NFT_MSG_NEWTABLE,
@@ -2225,6 +2243,9 @@ static int nf_tables_addchain(struct nft_ctx *ctx, u8 family, u8 genmask,
 		struct nft_stats __percpu *stats = NULL;
 		struct nft_chain_hook hook;
 
+		if (table->flags & __NFT_TABLE_F_UPDATE)
+			return -EINVAL;
+
 		if (flags & NFT_CHAIN_BINDING)
 			return -EOPNOTSUPP;
 
@@ -4410,6 +4431,12 @@ static int nf_tables_newset(struct net *net, struct sock *nlsk,
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
@@ -4451,6 +4478,9 @@ static int nf_tables_newset(struct net *net, struct sock *nlsk,
 		if (!(flags & NFT_SET_TIMEOUT))
 			return -EINVAL;
 
+		if (flags & NFT_SET_ANONYMOUS)
+			return -EOPNOTSUPP;
+
 		err = nf_msecs_to_jiffies64(nla[NFTA_SET_TIMEOUT], &timeout);
 		if (err)
 			return err;
@@ -4459,6 +4489,10 @@ static int nf_tables_newset(struct net *net, struct sock *nlsk,
 	if (nla[NFTA_SET_GC_INTERVAL] != NULL) {
 		if (!(flags & NFT_SET_TIMEOUT))
 			return -EINVAL;
+
+		if (flags & NFT_SET_ANONYMOUS)
+			return -EOPNOTSUPP;
+
 		gc_int = ntohl(nla_get_be32(nla[NFTA_SET_GC_INTERVAL]));
 	}
 
@@ -4754,6 +4788,7 @@ static void nf_tables_unbind_set(const struct nft_ctx *ctx, struct nft_set *set,
 
 	if (list_empty(&set->bindings) && nft_set_is_anonymous(set)) {
 		list_del_rcu(&set->list);
+		set->dead = 1;
 		if (event)
 			nf_tables_set_notify(ctx, set, NFT_MSG_DELSET,
 					     GFP_KERNEL);
@@ -6862,11 +6897,12 @@ static int nft_flowtable_parse_hook(const struct nft_ctx *ctx,
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
@@ -6878,9 +6914,13 @@ nft_flowtable_type_get(struct net *net, u8 family)
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
@@ -8778,10 +8818,11 @@ static int __nf_tables_abort(struct net *net, enum nfnl_abort_action action)
 	struct nft_trans *trans, *next;
 	LIST_HEAD(set_update_list);
 	struct nft_trans_elem *te;
+	int err = 0;
 
 	if (action == NFNL_ABORT_VALIDATE &&
 	    nf_tables_validate(net) < 0)
-		return -EAGAIN;
+		err = -EAGAIN;
 
 	list_for_each_entry_safe_reverse(trans, next, &nft_net->commit_list,
 					 list) {
@@ -8941,12 +8982,7 @@ static int __nf_tables_abort(struct net *net, enum nfnl_abort_action action)
 		nf_tables_abort_release(trans);
 	}
 
-	if (action == NFNL_ABORT_AUTOLOAD)
-		nf_tables_module_autoload(net);
-	else
-		nf_tables_module_autoload_cleanup(net);
-
-	return 0;
+	return err;
 }
 
 static int nf_tables_abort(struct net *net, struct sk_buff *skb,
@@ -8960,6 +8996,16 @@ static int nf_tables_abort(struct net *net, struct sk_buff *skb,
 	ret = __nf_tables_abort(net, action);
 	nft_gc_seq_end(nft_net, gc_seq);
 
+	WARN_ON_ONCE(!list_empty(&nft_net->commit_list));
+
+	/* module autoload needs to happen after GC sequence update because it
+	 * temporarily releases and grabs mutex again.
+	 */
+	if (action == NFNL_ABORT_AUTOLOAD)
+		nf_tables_module_autoload(net);
+	else
+		nf_tables_module_autoload_cleanup(net);
+
 	mutex_unlock(&nft_net->commit_mutex);
 
 	return ret;
@@ -9694,8 +9740,11 @@ static void __net_exit nf_tables_exit_net(struct net *net)
 
 	gc_seq = nft_gc_seq_begin(nft_net);
 
-	if (!list_empty(&nft_net->commit_list))
-		__nf_tables_abort(net, NFNL_ABORT_NONE);
+	WARN_ON_ONCE(!list_empty(&nft_net->commit_list));
+
+	if (!list_empty(&nft_net->module_list))
+		nf_tables_module_autoload_cleanup(net);
+
 	__nft_release_tables(net);
 
 	nft_gc_seq_end(nft_net, gc_seq);
@@ -9779,6 +9828,7 @@ static void __exit nf_tables_module_exit(void)
 	unregister_netdevice_notifier(&nf_tables_flowtable_notifier);
 	nft_chain_filter_fini();
 	nft_chain_route_fini();
+	nf_tables_trans_destroy_flush_work();
 	unregister_pernet_subsys(&nf_tables_net_ops);
 	cancel_work_sync(&trans_gc_work);
 	cancel_work_sync(&trans_destroy_work);
diff --git a/net/nfc/nci/core.c b/net/nfc/nci/core.c
index 5bfaf06f7be7..d8002065baae 100644
--- a/net/nfc/nci/core.c
+++ b/net/nfc/nci/core.c
@@ -1502,6 +1502,11 @@ static void nci_rx_work(struct work_struct *work)
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
index c29c7a59f205..3df0affff6b0 100644
--- a/net/rds/rdma.c
+++ b/net/rds/rdma.c
@@ -302,7 +302,7 @@ static int __rds_rdma_map(struct rds_sock *rs, struct rds_get_mr_args *args,
 		}
 		ret = PTR_ERR(trans_private);
 		/* Trigger connection so that its ready for the next retry */
-		if (ret == -ENODEV)
+		if (ret == -ENODEV && cp)
 			rds_conn_connect_if_down(cp->cp_conn);
 		goto out;
 	}
diff --git a/net/sched/act_skbmod.c b/net/sched/act_skbmod.c
index aa98dcac94b9..934765a2edeb 100644
--- a/net/sched/act_skbmod.c
+++ b/net/sched/act_skbmod.c
@@ -219,13 +219,13 @@ static int tcf_skbmod_dump(struct sk_buff *skb, struct tc_action *a,
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
diff --git a/net/smc/smc_pnet.c b/net/smc/smc_pnet.c
index 30bae60d626c..ed9cfa11b589 100644
--- a/net/smc/smc_pnet.c
+++ b/net/smc/smc_pnet.c
@@ -797,6 +797,16 @@ static void smc_pnet_create_pnetids_list(struct net *net)
 	u8 ndev_pnetid[SMC_MAX_PNETID_LEN];
 	struct net_device *dev;
 
+	/* Newly created netns do not have devices.
+	 * Do not even acquire rtnl.
+	 */
+	if (list_empty(&net->dev_base_head))
+		return;
+
+	/* Note: This might not be needed, because smc_pnet_netdev_event()
+	 * is also calling smc_pnet_add_base_pnetid() when handling
+	 * NETDEV_UP event.
+	 */
 	rtnl_lock();
 	for_each_netdev(net, dev)
 		smc_pnet_add_base_pnetid(net, dev, ndev_pnetid);
diff --git a/net/xfrm/xfrm_user.c b/net/xfrm/xfrm_user.c
index 8fce2e93bb3b..070946d09381 100644
--- a/net/xfrm/xfrm_user.c
+++ b/net/xfrm/xfrm_user.c
@@ -1753,6 +1753,9 @@ static int copy_to_user_tmpl(struct xfrm_policy *xp, struct sk_buff *skb)
 	if (xp->xfrm_nr == 0)
 		return 0;
 
+	if (xp->xfrm_nr > XFRM_MAX_DEPTH)
+		return -ENOBUFS;
+
 	for (i = 0; i < xp->xfrm_nr; i++) {
 		struct xfrm_user_tmpl *up = &vec[i];
 		struct xfrm_tmpl *kp = &xp->xfrm_vec[i];
diff --git a/scripts/Makefile.extrawarn b/scripts/Makefile.extrawarn
index fe327a4532dd..eb01e8d07e28 100644
--- a/scripts/Makefile.extrawarn
+++ b/scripts/Makefile.extrawarn
@@ -53,6 +53,8 @@ KBUILD_CFLAGS += $(call cc-disable-warning, pointer-to-enum-cast)
 KBUILD_CFLAGS += -Wno-tautological-constant-out-of-range-compare
 KBUILD_CFLAGS += $(call cc-disable-warning, unaligned-access)
 KBUILD_CFLAGS += $(call cc-disable-warning, cast-function-type-strict)
+KBUILD_CFLAGS += -Wno-enum-compare-conditional
+KBUILD_CFLAGS += -Wno-enum-enum-conversion
 endif
 
 endif
diff --git a/scripts/dummy-tools/gcc b/scripts/dummy-tools/gcc
index 485427f40dba..91df612bf937 100755
--- a/scripts/dummy-tools/gcc
+++ b/scripts/dummy-tools/gcc
@@ -76,7 +76,11 @@ fi
 if arg_contain -S "$@"; then
 	# For scripts/gcc-x86-*-has-stack-protector.sh
 	if arg_contain -fstack-protector "$@"; then
-		echo "%gs"
+		if arg_contain -mstack-protector-guard-reg=fs "$@"; then
+			echo "%fs"
+		else
+			echo "%gs"
+		fi
 		exit 0
 	fi
 fi
diff --git a/scripts/gcc-x86_32-has-stack-protector.sh b/scripts/gcc-x86_32-has-stack-protector.sh
index f5c119495254..825c75c5b715 100755
--- a/scripts/gcc-x86_32-has-stack-protector.sh
+++ b/scripts/gcc-x86_32-has-stack-protector.sh
@@ -1,4 +1,8 @@
 #!/bin/sh
 # SPDX-License-Identifier: GPL-2.0
 
-echo "int foo(void) { char X[200]; return 3; }" | $* -S -x c -c -m32 -O0 -fstack-protector - -o - 2> /dev/null | grep -q "%gs"
+# This requires GCC 8.1 or better.  Specifically, we require
+# -mstack-protector-guard-reg, added by
+# https://gcc.gnu.org/bugzilla/show_bug.cgi?id=81708
+
+echo "int foo(void) { char X[200]; return 3; }" | $* -S -x c -c -m32 -O0 -fstack-protector -mstack-protector-guard-reg=fs -mstack-protector-guard-symbol=__stack_chk_guard - -o - 2> /dev/null | grep -q "%fs"
diff --git a/scripts/kernel-doc b/scripts/kernel-doc
index 7a04d4c05326..8e3257f1ea2c 100755
--- a/scripts/kernel-doc
+++ b/scripts/kernel-doc
@@ -1233,7 +1233,7 @@ sub dump_struct($$) {
 	# replace DECLARE_KFIFO_PTR
 	$members =~ s/DECLARE_KFIFO_PTR\s*\(([^,)]+),\s*([^,)]+)\)/$2 \*$1/gos;
 	# replace DECLARE_FLEX_ARRAY
-	$members =~ s/(?:__)?DECLARE_FLEX_ARRAY\s*\($args,\s*$args\)/$1 $2\[\]/gos;
+	$members =~ s/(?:__)?DECLARE_FLEX_ARRAY\s*\(([^,)]+),\s*([^,)]+)\)/$1 $2\[\]/gos;
 	my $declaration = $members;
 
 	# Split nested struct/union elements as newer ones
diff --git a/security/smack/smack_lsm.c b/security/smack/smack_lsm.c
index 5388f143eecd..750f6007bbbb 100644
--- a/security/smack/smack_lsm.c
+++ b/security/smack/smack_lsm.c
@@ -1280,7 +1280,8 @@ static int smack_inode_setxattr(struct dentry *dentry, const char *name,
 		check_star = 1;
 	} else if (strcmp(name, XATTR_NAME_SMACKTRANSMUTE) == 0) {
 		check_priv = 1;
-		if (size != TRANS_TRUE_SIZE ||
+		if (!S_ISDIR(d_backing_inode(dentry)->i_mode) ||
+		    size != TRANS_TRUE_SIZE ||
 		    strncmp(value, TRANS_TRUE, TRANS_TRUE_SIZE) != 0)
 			rc = -EINVAL;
 	} else
@@ -2721,6 +2722,15 @@ static int smack_inode_setsecurity(struct inode *inode, const char *name,
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
index 038837481c27..84df5582cde2 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -9192,7 +9192,7 @@ static const struct snd_pci_quirk alc269_fixup_tbl[] = {
 	SND_PCI_QUIRK(0x10ec, 0x124c, "Intel Reference board", ALC295_FIXUP_CHROME_BOOK),
 	SND_PCI_QUIRK(0x10ec, 0x1252, "Intel Reference board", ALC295_FIXUP_CHROME_BOOK),
 	SND_PCI_QUIRK(0x10ec, 0x1254, "Intel Reference board", ALC295_FIXUP_CHROME_BOOK),
-	SND_PCI_QUIRK(0x10f7, 0x8338, "Panasonic CF-SZ6", ALC269_FIXUP_HEADSET_MODE),
+	SND_PCI_QUIRK(0x10f7, 0x8338, "Panasonic CF-SZ6", ALC269_FIXUP_ASPIRE_HEADSET_MIC),
 	SND_PCI_QUIRK(0x144d, 0xc109, "Samsung Ativ book 9 (NP900X3G)", ALC269_FIXUP_INV_DMIC),
 	SND_PCI_QUIRK(0x144d, 0xc169, "Samsung Notebook 9 Pen (NP930SBE-K01US)", ALC298_FIXUP_SAMSUNG_AMP),
 	SND_PCI_QUIRK(0x144d, 0xc176, "Samsung Notebook 9 Pro (NP930MBE-K04US)", ALC298_FIXUP_SAMSUNG_AMP),
@@ -10692,8 +10692,7 @@ static void alc897_hp_automute_hook(struct hda_codec *codec,
 
 	snd_hda_gen_hp_automute(codec, jack);
 	vref = spec->gen.hp_jack_present ? (PIN_HP | AC_PINCTL_VREF_100) : PIN_HP;
-	snd_hda_codec_write(codec, 0x1b, 0, AC_VERB_SET_PIN_WIDGET_CONTROL,
-			    vref);
+	snd_hda_set_pin_ctl(codec, 0x1b, vref);
 }
 
 static void alc897_fixup_lenovo_headset_mic(struct hda_codec *codec,
@@ -10702,6 +10701,10 @@ static void alc897_fixup_lenovo_headset_mic(struct hda_codec *codec,
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
index 8fa68432d3c1..2d59e3907fcf 100644
--- a/sound/sh/aica.c
+++ b/sound/sh/aica.c
@@ -279,7 +279,8 @@ static void run_spu_dma(struct work_struct *work)
 		dreamcastcard->clicks++;
 		if (unlikely(dreamcastcard->clicks >= AICA_PERIOD_NUMBER))
 			dreamcastcard->clicks %= AICA_PERIOD_NUMBER;
-		mod_timer(&dreamcastcard->timer, jiffies + 1);
+		if (snd_pcm_running(dreamcastcard->substream))
+			mod_timer(&dreamcastcard->timer, jiffies + 1);
 	}
 }
 
@@ -291,6 +292,8 @@ static void aica_period_elapsed(struct timer_list *t)
 	/*timer function - so cannot sleep */
 	int play_period;
 	struct snd_pcm_runtime *runtime;
+	if (!snd_pcm_running(substream))
+		return;
 	runtime = substream->runtime;
 	dreamcastcard = substream->pcm->private_data;
 	/* Have we played out an additional period? */
@@ -351,12 +354,19 @@ static int snd_aicapcm_pcm_open(struct snd_pcm_substream
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
@@ -402,6 +412,7 @@ static const struct snd_pcm_ops snd_aicapcm_playback_ops = {
 	.prepare = snd_aicapcm_pcm_prepare,
 	.trigger = snd_aicapcm_pcm_trigger,
 	.pointer = snd_aicapcm_pcm_pointer,
+	.sync_stop = snd_aicapcm_pcm_sync_stop,
 };
 
 /* TO DO: set up to handle more than one pcm instance */
diff --git a/sound/soc/soc-ops.c b/sound/soc/soc-ops.c
index daecd386d5ec..a83cd8d8a963 100644
--- a/sound/soc/soc-ops.c
+++ b/sound/soc/soc-ops.c
@@ -246,7 +246,7 @@ int snd_soc_get_volsw(struct snd_kcontrol *kcontrol,
 	int max = mc->max;
 	int min = mc->min;
 	int sign_bit = mc->sign_bit;
-	unsigned int mask = (1 << fls(max)) - 1;
+	unsigned int mask = (1ULL << fls(max)) - 1;
 	unsigned int invert = mc->invert;
 	int val;
 	int ret;
diff --git a/tools/iio/iio_utils.c b/tools/iio/iio_utils.c
index 48360994c2a1..b8745873928c 100644
--- a/tools/iio/iio_utils.c
+++ b/tools/iio/iio_utils.c
@@ -373,7 +373,7 @@ int build_channel_array(const char *device_dir,
 		goto error_close_dir;
 	}
 
-	seekdir(dp, 0);
+	rewinddir(dp);
 	while (ent = readdir(dp), ent) {
 		if (strcmp(ent->d_name + strlen(ent->d_name) - strlen("_en"),
 			   "_en") == 0) {
diff --git a/tools/include/linux/objtool.h b/tools/include/linux/objtool.h
index d17fa7f4001d..0f13875acc5e 100644
--- a/tools/include/linux/objtool.h
+++ b/tools/include/linux/objtool.h
@@ -141,6 +141,12 @@ struct unwind_hint {
 	.popsection
 .endm
 
+.macro STACK_FRAME_NON_STANDARD func:req
+	.pushsection .discard.func_stack_frame_non_standard, "aw"
+		.long \func - .
+	.popsection
+.endm
+
 #endif /* __ASSEMBLY__ */
 
 #else /* !CONFIG_STACK_VALIDATION */
@@ -158,6 +164,8 @@ struct unwind_hint {
 .endm
 .macro ANNOTATE_NOENDBR
 .endm
+.macro STACK_FRAME_NON_STANDARD func:req
+.endm
 #endif
 
 #endif /* CONFIG_STACK_VALIDATION */
diff --git a/tools/lib/perf/evlist.c b/tools/lib/perf/evlist.c
index f76b1a9d5a6e..53cff32b2cb8 100644
--- a/tools/lib/perf/evlist.c
+++ b/tools/lib/perf/evlist.c
@@ -226,10 +226,10 @@ u64 perf_evlist__read_format(struct perf_evlist *evlist)
 
 static void perf_evlist__id_hash(struct perf_evlist *evlist,
 				 struct perf_evsel *evsel,
-				 int cpu, int thread, u64 id)
+				 int cpu_map_idx, int thread, u64 id)
 {
 	int hash;
-	struct perf_sample_id *sid = SID(evsel, cpu, thread);
+	struct perf_sample_id *sid = SID(evsel, cpu_map_idx, thread);
 
 	sid->id = id;
 	sid->evsel = evsel;
@@ -239,21 +239,27 @@ static void perf_evlist__id_hash(struct perf_evlist *evlist,
 
 void perf_evlist__id_add(struct perf_evlist *evlist,
 			 struct perf_evsel *evsel,
-			 int cpu, int thread, u64 id)
+			 int cpu_map_idx, int thread, u64 id)
 {
-	perf_evlist__id_hash(evlist, evsel, cpu, thread, id);
+	if (!SID(evsel, cpu_map_idx, thread))
+		return;
+
+	perf_evlist__id_hash(evlist, evsel, cpu_map_idx, thread, id);
 	evsel->id[evsel->ids++] = id;
 }
 
 int perf_evlist__id_add_fd(struct perf_evlist *evlist,
 			   struct perf_evsel *evsel,
-			   int cpu, int thread, int fd)
+			   int cpu_map_idx, int thread, int fd)
 {
 	u64 read_data[4] = { 0, };
 	int id_idx = 1; /* The first entry is the counter value */
 	u64 id;
 	int ret;
 
+	if (!SID(evsel, cpu_map_idx, thread))
+		return -1;
+
 	ret = ioctl(fd, PERF_EVENT_IOC_ID, &id);
 	if (!ret)
 		goto add;
@@ -282,7 +288,7 @@ int perf_evlist__id_add_fd(struct perf_evlist *evlist,
 	id = read_data[id_idx];
 
 add:
-	perf_evlist__id_add(evlist, evsel, cpu, thread, id);
+	perf_evlist__id_add(evlist, evsel, cpu_map_idx, thread, id);
 	return 0;
 }
 
diff --git a/tools/lib/perf/include/internal/evlist.h b/tools/lib/perf/include/internal/evlist.h
index 2d0fa02b036f..8999f2cc8ee4 100644
--- a/tools/lib/perf/include/internal/evlist.h
+++ b/tools/lib/perf/include/internal/evlist.h
@@ -118,10 +118,10 @@ u64 perf_evlist__read_format(struct perf_evlist *evlist);
 
 void perf_evlist__id_add(struct perf_evlist *evlist,
 			 struct perf_evsel *evsel,
-			 int cpu, int thread, u64 id);
+			 int cpu_map_idx, int thread, u64 id);
 
 int perf_evlist__id_add_fd(struct perf_evlist *evlist,
 			   struct perf_evsel *evsel,
-			   int cpu, int thread, int fd);
+			   int cpu_map_idx, int thread, int fd);
 
 #endif /* __LIBPERF_INTERNAL_EVLIST_H */
diff --git a/tools/power/x86/x86_energy_perf_policy/x86_energy_perf_policy.c b/tools/power/x86/x86_energy_perf_policy/x86_energy_perf_policy.c
index ff6c6661f075..1c80aa498d54 100644
--- a/tools/power/x86/x86_energy_perf_policy/x86_energy_perf_policy.c
+++ b/tools/power/x86/x86_energy_perf_policy/x86_energy_perf_policy.c
@@ -1152,6 +1152,7 @@ unsigned int get_pkg_num(int cpu)
 	retval = fscanf(fp, "%d\n", &pkg);
 	if (retval != 1)
 		errx(1, "%s: failed to parse", pathname);
+	fclose(fp);
 	return pkg;
 }
 
diff --git a/tools/testing/ktest/ktest.pl b/tools/testing/ktest/ktest.pl
index ea26f2b0c1bc..f72da30795dd 100755
--- a/tools/testing/ktest/ktest.pl
+++ b/tools/testing/ktest/ktest.pl
@@ -773,6 +773,7 @@ sub set_value {
     if ($lvalue =~ /^(TEST|BISECT|CONFIG_BISECT)_TYPE(\[.*\])?$/ &&
 	$prvalue !~ /^(config_|)bisect$/ &&
 	$prvalue !~ /^build$/ &&
+	$prvalue !~ /^make_warnings_file$/ &&
 	$buildonly) {
 
 	# Note if a test is something other than build, then we
diff --git a/tools/testing/selftests/mqueue/setting b/tools/testing/selftests/mqueue/setting
new file mode 100644
index 000000000000..a953c96aa16e
--- /dev/null
+++ b/tools/testing/selftests/mqueue/setting
@@ -0,0 +1 @@
+timeout=180
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
index dd777688d14a..952afb1bc83b 100644
--- a/virt/kvm/async_pf.c
+++ b/virt/kvm/async_pf.c
@@ -88,7 +88,27 @@ static void async_pf_execute(struct work_struct *work)
 	rcuwait_wake_up(&vcpu->wait);
 
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
@@ -115,7 +135,6 @@ void kvm_clear_async_pf_completion_queue(struct kvm_vcpu *vcpu)
 #else
 		if (cancel_work_sync(&work->work)) {
 			mmput(work->mm);
-			kvm_put_kvm(vcpu->kvm); /* == work->vcpu->kvm */
 			kmem_cache_free(async_pf_cache, work);
 		}
 #endif
@@ -127,7 +146,10 @@ void kvm_clear_async_pf_completion_queue(struct kvm_vcpu *vcpu)
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
 
@@ -152,7 +174,7 @@ void kvm_check_async_pf_completion(struct kvm_vcpu *vcpu)
 
 		list_del(&work->queue);
 		vcpu->async_pf.queued--;
-		kmem_cache_free(async_pf_cache, work);
+		kvm_flush_and_free_async_pf_work(work);
 	}
 }
 
@@ -187,7 +209,6 @@ bool kvm_setup_async_pf(struct kvm_vcpu *vcpu, gpa_t cr2_or_gpa,
 	work->arch = *arch;
 	work->mm = current->mm;
 	mmget(work->mm);
-	kvm_get_kvm(work->vcpu->kvm);
 
 	INIT_WORK(&work->work, async_pf_execute);
 

