Return-Path: <linux-kernel+bounces-143715-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B62B8A3C8E
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Apr 2024 13:27:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1D9A6281C58
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Apr 2024 11:27:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC22947F79;
	Sat, 13 Apr 2024 11:26:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="zs+ifSSO"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D159E47F6F;
	Sat, 13 Apr 2024 11:26:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713007578; cv=none; b=Klpj3b0THy+WaBVmj3jwMRmOv4gTPxWnUM2SP5OYUD1O57KAfUvYKne7OrC1Ru/IlXnBhgWuI79Ry57wT889PM9V1Z3wKv8NT7D6ChNNd2i/208OEJHcTGphzzaT8bp+GWmK+99k1IAMMOw10Z0VnsmB2dh+Po8MF+tvmD665F4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713007578; c=relaxed/simple;
	bh=fK8km9trBy8/OtN6Kl7x58y82e4zROvzrvOlD3klOmg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hWbJ/zTo3Qxl0eqiqlbY7y1+YfFkqmvM53mh6iH+EhdoX6bBXKosq8gqW3yAmEVI323ZHk/IFq2CNdRpTP7AR9A2ZMx0Tte5Pv1UlOS5DSHwmKovgApLnIEIUpyqRZwq6sVszPxe2vvk4ElLuBMQ90fbY6nSZMYDI9ZAFeDJnTc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=zs+ifSSO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A328AC2BBFC;
	Sat, 13 Apr 2024 11:26:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1713007578;
	bh=fK8km9trBy8/OtN6Kl7x58y82e4zROvzrvOlD3klOmg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=zs+ifSSO64l/0H1Le7vI9BJVf74ehBDwqeKDhr19Exl/bXp0nviPuSKdR+ivFU3dL
	 Wgan5XrN6kduYZgYAb+c2G/5IP8XCYFvJ9SYjOWGJ5Opav+JQxowOBB3TSLAfddVVt
	 yadM3UuowCM6bIJjPGbYY5nsvma2bcCBJdGgz6OA=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: Linux 6.1.86
Date: Sat, 13 Apr 2024 13:26:09 +0200
Message-ID: <2024041309-glitzy-geology-5d7e@gregkh>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <2024041309-imminent-spousal-c099@gregkh>
References: <2024041309-imminent-spousal-c099@gregkh>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

diff --git a/Makefile b/Makefile
index 5dff9ff99998..baddd8ed8186 100644
--- a/Makefile
+++ b/Makefile
@@ -1,7 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0
 VERSION = 6
 PATCHLEVEL = 1
-SUBLEVEL = 85
+SUBLEVEL = 86
 EXTRAVERSION =
 NAME = Curry Ramen
 
diff --git a/arch/arm64/boot/dts/rockchip/rk3328.dtsi b/arch/arm64/boot/dts/rockchip/rk3328.dtsi
index 905a50aa5dc3..d42846efff2f 100644
--- a/arch/arm64/boot/dts/rockchip/rk3328.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3328.dtsi
@@ -741,11 +741,20 @@ hdmi: hdmi@ff3c0000 {
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
index a7e6eccb14cc..8363cc13ec51 100644
--- a/arch/arm64/boot/dts/rockchip/rk3399.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3399.dtsi
@@ -1906,6 +1906,7 @@ simple-audio-card,codec {
 	hdmi: hdmi@ff940000 {
 		compatible = "rockchip,rk3399-dw-hdmi";
 		reg = <0x0 0xff940000 0x0 0x20000>;
+		reg-io-width = <4>;
 		interrupts = <GIC_SPI 23 IRQ_TYPE_LEVEL_HIGH 0>;
 		clocks = <&cru PCLK_HDMI_CTRL>,
 			 <&cru SCLK_HDMI_SFR>,
@@ -1914,13 +1915,16 @@ hdmi: hdmi@ff940000 {
 			 <&cru PLL_VPLL>;
 		clock-names = "iahb", "isfr", "cec", "grf", "ref";
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
 
@@ -1933,6 +1937,10 @@ hdmi_in_vopl: endpoint@1 {
 					remote-endpoint = <&vopl_out_hdmi>;
 				};
 			};
+
+			hdmi_out: port@1 {
+				reg = <1>;
+			};
 		};
 	};
 
diff --git a/arch/x86/events/amd/lbr.c b/arch/x86/events/amd/lbr.c
index b8fe74e8e0a6..48f4095f500d 100644
--- a/arch/x86/events/amd/lbr.c
+++ b/arch/x86/events/amd/lbr.c
@@ -173,9 +173,11 @@ void amd_pmu_lbr_read(void)
 
 		/*
 		 * Check if a branch has been logged; if valid = 0, spec = 0
-		 * then no branch was recorded
+		 * then no branch was recorded; if reserved = 1 then an
+		 * erroneous branch was recorded (see Erratum 1452)
 		 */
-		if (!entry.to.split.valid && !entry.to.split.spec)
+		if ((!entry.to.split.valid && !entry.to.split.spec) ||
+		    entry.to.split.reserved)
 			continue;
 
 		perf_clear_branch_entry_bitfields(br + out);
diff --git a/block/blk-stat.c b/block/blk-stat.c
index da9407b7d4ab..41be89ecaf20 100644
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
diff --git a/drivers/acpi/sleep.c b/drivers/acpi/sleep.c
index 539c12fbd2f1..6026e20f022a 100644
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
 
diff --git a/drivers/bluetooth/btintel.c b/drivers/bluetooth/btintel.c
index bbad1207cdfd..7a9d2da3c814 100644
--- a/drivers/bluetooth/btintel.c
+++ b/drivers/bluetooth/btintel.c
@@ -411,7 +411,7 @@ int btintel_read_version(struct hci_dev *hdev, struct intel_version *ver)
 		return PTR_ERR(skb);
 	}
 
-	if (skb->len != sizeof(*ver)) {
+	if (!skb || skb->len != sizeof(*ver)) {
 		bt_dev_err(hdev, "Intel version event size mismatch");
 		kfree_skb(skb);
 		return -EILSEQ;
diff --git a/drivers/bluetooth/btmtk.c b/drivers/bluetooth/btmtk.c
index 809762d64fc6..b77e337778a4 100644
--- a/drivers/bluetooth/btmtk.c
+++ b/drivers/bluetooth/btmtk.c
@@ -288,4 +288,5 @@ MODULE_LICENSE("GPL");
 MODULE_FIRMWARE(FIRMWARE_MT7622);
 MODULE_FIRMWARE(FIRMWARE_MT7663);
 MODULE_FIRMWARE(FIRMWARE_MT7668);
+MODULE_FIRMWARE(FIRMWARE_MT7922);
 MODULE_FIRMWARE(FIRMWARE_MT7961);
diff --git a/drivers/bluetooth/btmtk.h b/drivers/bluetooth/btmtk.h
index 2a88ea8e475e..ee0b1d27aa5c 100644
--- a/drivers/bluetooth/btmtk.h
+++ b/drivers/bluetooth/btmtk.h
@@ -4,6 +4,7 @@
 #define FIRMWARE_MT7622		"mediatek/mt7622pr2h.bin"
 #define FIRMWARE_MT7663		"mediatek/mt7663pr2h.bin"
 #define FIRMWARE_MT7668		"mediatek/mt7668pr2h.bin"
+#define FIRMWARE_MT7922		"mediatek/BT_RAM_CODE_MT7922_1_1_hdr.bin"
 #define FIRMWARE_MT7961		"mediatek/BT_RAM_CODE_MT7961_1_2_hdr.bin"
 
 #define HCI_EV_WMT 0xe4
diff --git a/drivers/bus/mhi/host/init.c b/drivers/bus/mhi/host/init.c
index 04fbccff65ac..60c1df048fa2 100644
--- a/drivers/bus/mhi/host/init.c
+++ b/drivers/bus/mhi/host/init.c
@@ -62,6 +62,7 @@ static const char * const mhi_pm_state_str[] = {
 	[MHI_PM_STATE_FW_DL_ERR] = "Firmware Download Error",
 	[MHI_PM_STATE_SYS_ERR_DETECT] = "SYS ERROR Detect",
 	[MHI_PM_STATE_SYS_ERR_PROCESS] = "SYS ERROR Process",
+	[MHI_PM_STATE_SYS_ERR_FAIL] = "SYS ERROR Failure",
 	[MHI_PM_STATE_SHUTDOWN_PROCESS] = "SHUTDOWN Process",
 	[MHI_PM_STATE_LD_ERR_FATAL_DETECT] = "Linkdown or Error Fatal Detect",
 };
diff --git a/drivers/bus/mhi/host/internal.h b/drivers/bus/mhi/host/internal.h
index 01fd10a399b6..6abf09da4f61 100644
--- a/drivers/bus/mhi/host/internal.h
+++ b/drivers/bus/mhi/host/internal.h
@@ -88,6 +88,7 @@ enum mhi_pm_state {
 	MHI_PM_STATE_FW_DL_ERR,
 	MHI_PM_STATE_SYS_ERR_DETECT,
 	MHI_PM_STATE_SYS_ERR_PROCESS,
+	MHI_PM_STATE_SYS_ERR_FAIL,
 	MHI_PM_STATE_SHUTDOWN_PROCESS,
 	MHI_PM_STATE_LD_ERR_FATAL_DETECT,
 	MHI_PM_STATE_MAX
@@ -104,14 +105,16 @@ enum mhi_pm_state {
 #define MHI_PM_FW_DL_ERR				BIT(7)
 #define MHI_PM_SYS_ERR_DETECT				BIT(8)
 #define MHI_PM_SYS_ERR_PROCESS				BIT(9)
-#define MHI_PM_SHUTDOWN_PROCESS				BIT(10)
+#define MHI_PM_SYS_ERR_FAIL				BIT(10)
+#define MHI_PM_SHUTDOWN_PROCESS				BIT(11)
 /* link not accessible */
-#define MHI_PM_LD_ERR_FATAL_DETECT			BIT(11)
+#define MHI_PM_LD_ERR_FATAL_DETECT			BIT(12)
 
 #define MHI_REG_ACCESS_VALID(pm_state)			((pm_state & (MHI_PM_POR | MHI_PM_M0 | \
 						MHI_PM_M2 | MHI_PM_M3_ENTER | MHI_PM_M3_EXIT | \
 						MHI_PM_SYS_ERR_DETECT | MHI_PM_SYS_ERR_PROCESS | \
-						MHI_PM_SHUTDOWN_PROCESS | MHI_PM_FW_DL_ERR)))
+						MHI_PM_SYS_ERR_FAIL | MHI_PM_SHUTDOWN_PROCESS |  \
+						MHI_PM_FW_DL_ERR)))
 #define MHI_PM_IN_ERROR_STATE(pm_state)			(pm_state >= MHI_PM_FW_DL_ERR)
 #define MHI_PM_IN_FATAL_STATE(pm_state)			(pm_state == MHI_PM_LD_ERR_FATAL_DETECT)
 #define MHI_DB_ACCESS_VALID(mhi_cntrl)			(mhi_cntrl->pm_state & mhi_cntrl->db_access)
diff --git a/drivers/bus/mhi/host/pm.c b/drivers/bus/mhi/host/pm.c
index 8a4362d75fc4..27f8a40f288c 100644
--- a/drivers/bus/mhi/host/pm.c
+++ b/drivers/bus/mhi/host/pm.c
@@ -36,7 +36,10 @@
  *     M0 <--> M0
  *     M0 -> FW_DL_ERR
  *     M0 -> M3_ENTER -> M3 -> M3_EXIT --> M0
- * L1: SYS_ERR_DETECT -> SYS_ERR_PROCESS --> POR
+ * L1: SYS_ERR_DETECT -> SYS_ERR_PROCESS
+ *     SYS_ERR_PROCESS -> SYS_ERR_FAIL
+ *     SYS_ERR_FAIL -> SYS_ERR_DETECT
+ *     SYS_ERR_PROCESS --> POR
  * L2: SHUTDOWN_PROCESS -> LD_ERR_FATAL_DETECT
  *     SHUTDOWN_PROCESS -> DISABLE
  * L3: LD_ERR_FATAL_DETECT <--> LD_ERR_FATAL_DETECT
@@ -93,7 +96,12 @@ static const struct mhi_pm_transitions dev_state_transitions[] = {
 	},
 	{
 		MHI_PM_SYS_ERR_PROCESS,
-		MHI_PM_POR | MHI_PM_SHUTDOWN_PROCESS |
+		MHI_PM_POR | MHI_PM_SYS_ERR_FAIL | MHI_PM_SHUTDOWN_PROCESS |
+		MHI_PM_LD_ERR_FATAL_DETECT
+	},
+	{
+		MHI_PM_SYS_ERR_FAIL,
+		MHI_PM_SYS_ERR_DETECT | MHI_PM_SHUTDOWN_PROCESS |
 		MHI_PM_LD_ERR_FATAL_DETECT
 	},
 	/* L2 States */
@@ -624,7 +632,13 @@ static void mhi_pm_sys_error_transition(struct mhi_controller *mhi_cntrl)
 					!in_reset, timeout);
 		if (!ret || in_reset) {
 			dev_err(dev, "Device failed to exit MHI Reset state\n");
-			goto exit_sys_error_transition;
+			write_lock_irq(&mhi_cntrl->pm_lock);
+			cur_state = mhi_tryset_pm_state(mhi_cntrl,
+							MHI_PM_SYS_ERR_FAIL);
+			write_unlock_irq(&mhi_cntrl->pm_lock);
+			/* Shutdown may have occurred, otherwise cleanup now */
+			if (cur_state != MHI_PM_SYS_ERR_FAIL)
+				goto exit_sys_error_transition;
 		}
 
 		/*
diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
index c8912756fc06..91efa23e0e8f 100644
--- a/drivers/cpufreq/cpufreq.c
+++ b/drivers/cpufreq/cpufreq.c
@@ -1525,7 +1525,8 @@ static int cpufreq_online(unsigned int cpu)
 	if (cpufreq_driver->ready)
 		cpufreq_driver->ready(policy);
 
-	if (cpufreq_thermal_control_enabled(cpufreq_driver))
+	/* Register cpufreq cooling only for a new policy */
+	if (new_policy && cpufreq_thermal_control_enabled(cpufreq_driver))
 		policy->cdev = of_cpufreq_cooling_register(policy);
 
 	pr_debug("initialization complete\n");
@@ -1609,11 +1610,6 @@ static void __cpufreq_offline(unsigned int cpu, struct cpufreq_policy *policy)
 	else
 		policy->last_policy = policy->policy;
 
-	if (cpufreq_thermal_control_enabled(cpufreq_driver)) {
-		cpufreq_cooling_unregister(policy->cdev);
-		policy->cdev = NULL;
-	}
-
 	if (has_target())
 		cpufreq_exit_governor(policy);
 
@@ -1674,6 +1670,15 @@ static void cpufreq_remove_dev(struct device *dev, struct subsys_interface *sif)
 		return;
 	}
 
+	/*
+	 * Unregister cpufreq cooling once all the CPUs of the policy are
+	 * removed.
+	 */
+	if (cpufreq_thermal_control_enabled(cpufreq_driver)) {
+		cpufreq_cooling_unregister(policy->cdev);
+		policy->cdev = NULL;
+	}
+
 	/* We did light-weight exit earlier, do full tear down now */
 	if (cpufreq_driver->offline)
 		cpufreq_driver->exit(policy);
diff --git a/drivers/cpuidle/driver.c b/drivers/cpuidle/driver.c
index f70aa17e2a8e..c594e28adddf 100644
--- a/drivers/cpuidle/driver.c
+++ b/drivers/cpuidle/driver.c
@@ -16,6 +16,7 @@
 #include <linux/cpumask.h>
 #include <linux/tick.h>
 #include <linux/cpu.h>
+#include <linux/math64.h>
 
 #include "cpuidle.h"
 
@@ -185,7 +186,7 @@ static void __cpuidle_driver_init(struct cpuidle_driver *drv)
 			s->target_residency_ns = 0;
 
 		if (s->exit_latency > 0)
-			s->exit_latency_ns = s->exit_latency * NSEC_PER_USEC;
+			s->exit_latency_ns = mul_u32_u32(s->exit_latency, NSEC_PER_USEC);
 		else if (s->exit_latency_ns < 0)
 			s->exit_latency_ns =  0;
 	}
diff --git a/drivers/firmware/tegra/bpmp-debugfs.c b/drivers/firmware/tegra/bpmp-debugfs.c
index 9d3874cdaaee..34e4152477f3 100644
--- a/drivers/firmware/tegra/bpmp-debugfs.c
+++ b/drivers/firmware/tegra/bpmp-debugfs.c
@@ -81,7 +81,7 @@ static const char *get_filename(struct tegra_bpmp *bpmp,
 
 	root_path_buf = kzalloc(root_path_buf_len, GFP_KERNEL);
 	if (!root_path_buf)
-		goto out;
+		return NULL;
 
 	root_path = dentry_path(bpmp->debugfs_mirror, root_path_buf,
 				root_path_buf_len);
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
index e191d38f3da6..3f403afd6de8 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
@@ -765,8 +765,8 @@ static int kfd_ioctl_get_process_apertures_new(struct file *filp,
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
diff --git a/drivers/gpu/drm/drm_panel_orientation_quirks.c b/drivers/gpu/drm/drm_panel_orientation_quirks.c
index d5c15292ae93..3fe5e6439c40 100644
--- a/drivers/gpu/drm/drm_panel_orientation_quirks.c
+++ b/drivers/gpu/drm/drm_panel_orientation_quirks.c
@@ -117,6 +117,12 @@ static const struct drm_dmi_panel_orientation_data lcd1080x1920_leftside_up = {
 	.orientation = DRM_MODE_PANEL_ORIENTATION_LEFT_UP,
 };
 
+static const struct drm_dmi_panel_orientation_data lcd1080x1920_rightside_up = {
+	.width = 1080,
+	.height = 1920,
+	.orientation = DRM_MODE_PANEL_ORIENTATION_RIGHT_UP,
+};
+
 static const struct drm_dmi_panel_orientation_data lcd1200x1920_rightside_up = {
 	.width = 1200,
 	.height = 1920,
@@ -279,6 +285,12 @@ static const struct dmi_system_id orientation_data[] = {
 		  DMI_EXACT_MATCH(DMI_PRODUCT_NAME, "G1618-03")
 		},
 		.driver_data = (void *)&lcd720x1280_rightside_up,
+	}, {	/* GPD Win Mini */
+		.matches = {
+		  DMI_EXACT_MATCH(DMI_SYS_VENDOR, "GPD"),
+		  DMI_EXACT_MATCH(DMI_PRODUCT_NAME, "G1617-01")
+		},
+		.driver_data = (void *)&lcd1080x1920_rightside_up,
 	}, {	/* I.T.Works TW891 */
 		.matches = {
 		  DMI_EXACT_MATCH(DMI_SYS_VENDOR, "To be filled by O.E.M."),
diff --git a/drivers/gpu/drm/vc4/vc4_plane.c b/drivers/gpu/drm/vc4/vc4_plane.c
index eb08020154f3..7e6648b277b2 100644
--- a/drivers/gpu/drm/vc4/vc4_plane.c
+++ b/drivers/gpu/drm/vc4/vc4_plane.c
@@ -1415,9 +1415,6 @@ static int vc4_prepare_fb(struct drm_plane *plane,
 
 	drm_gem_plane_helper_prepare_fb(plane, state);
 
-	if (plane->state->fb == state->fb)
-		return 0;
-
 	return vc4_bo_inc_usecnt(bo);
 }
 
@@ -1426,7 +1423,7 @@ static void vc4_cleanup_fb(struct drm_plane *plane,
 {
 	struct vc4_bo *bo;
 
-	if (plane->state->fb == state->fb || !state->fb)
+	if (!state->fb)
 		return;
 
 	bo = to_vc4_bo(&drm_fb_dma_get_gem_obj(state->fb, 0)->base);
diff --git a/drivers/infiniband/core/cm.c b/drivers/infiniband/core/cm.c
index b7f902344289..462a10d6a576 100644
--- a/drivers/infiniband/core/cm.c
+++ b/drivers/infiniband/core/cm.c
@@ -34,6 +34,7 @@ MODULE_AUTHOR("Sean Hefty");
 MODULE_DESCRIPTION("InfiniBand CM");
 MODULE_LICENSE("Dual BSD/GPL");
 
+#define CM_DESTROY_ID_WAIT_TIMEOUT 10000 /* msecs */
 static const char * const ibcm_rej_reason_strs[] = {
 	[IB_CM_REJ_NO_QP]			= "no QP",
 	[IB_CM_REJ_NO_EEC]			= "no EEC",
@@ -1025,10 +1026,20 @@ static void cm_reset_to_idle(struct cm_id_private *cm_id_priv)
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
@@ -1135,7 +1146,14 @@ static void cm_destroy_id(struct ib_cm_id *cm_id, int err)
 
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
diff --git a/drivers/input/touchscreen/imagis.c b/drivers/input/touchscreen/imagis.c
index e2697e6c6d2a..2636e1c9435d 100644
--- a/drivers/input/touchscreen/imagis.c
+++ b/drivers/input/touchscreen/imagis.c
@@ -1,5 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0-only
 
+#include <linux/bitfield.h>
 #include <linux/bits.h>
 #include <linux/delay.h>
 #include <linux/i2c.h>
@@ -23,12 +24,9 @@
 #define IST3038C_I2C_RETRY_COUNT	3
 #define IST3038C_MAX_FINGER_NUM		10
 #define IST3038C_X_MASK			GENMASK(23, 12)
-#define IST3038C_X_SHIFT		12
 #define IST3038C_Y_MASK			GENMASK(11, 0)
 #define IST3038C_AREA_MASK		GENMASK(27, 24)
-#define IST3038C_AREA_SHIFT		24
 #define IST3038C_FINGER_COUNT_MASK	GENMASK(15, 12)
-#define IST3038C_FINGER_COUNT_SHIFT	12
 #define IST3038C_FINGER_STATUS_MASK	GENMASK(9, 0)
 
 struct imagis_ts {
@@ -92,8 +90,7 @@ static irqreturn_t imagis_interrupt(int irq, void *dev_id)
 		goto out;
 	}
 
-	finger_count = (intr_message & IST3038C_FINGER_COUNT_MASK) >>
-				IST3038C_FINGER_COUNT_SHIFT;
+	finger_count = FIELD_GET(IST3038C_FINGER_COUNT_MASK, intr_message);
 	if (finger_count > IST3038C_MAX_FINGER_NUM) {
 		dev_err(&ts->client->dev,
 			"finger count %d is more than maximum supported\n",
@@ -101,7 +98,7 @@ static irqreturn_t imagis_interrupt(int irq, void *dev_id)
 		goto out;
 	}
 
-	finger_pressed = intr_message & IST3038C_FINGER_STATUS_MASK;
+	finger_pressed = FIELD_GET(IST3038C_FINGER_STATUS_MASK, intr_message);
 
 	for (i = 0; i < finger_count; i++) {
 		error = imagis_i2c_read_reg(ts,
@@ -118,12 +115,11 @@ static irqreturn_t imagis_interrupt(int irq, void *dev_id)
 		input_mt_report_slot_state(ts->input_dev, MT_TOOL_FINGER,
 					   finger_pressed & BIT(i));
 		touchscreen_report_pos(ts->input_dev, &ts->prop,
-				       (finger_status & IST3038C_X_MASK) >>
-						IST3038C_X_SHIFT,
-				       finger_status & IST3038C_Y_MASK, 1);
+				       FIELD_GET(IST3038C_X_MASK, finger_status),
+				       FIELD_GET(IST3038C_Y_MASK, finger_status),
+				       true);
 		input_report_abs(ts->input_dev, ABS_MT_TOUCH_MAJOR,
-				 (finger_status & IST3038C_AREA_MASK) >>
-					IST3038C_AREA_SHIFT);
+				 FIELD_GET(IST3038C_AREA_MASK, finger_status));
 	}
 
 	input_mt_sync_frame(ts->input_dev);
@@ -210,7 +206,7 @@ static int imagis_init_input_dev(struct imagis_ts *ts)
 
 	input_set_capability(input_dev, EV_ABS, ABS_MT_POSITION_X);
 	input_set_capability(input_dev, EV_ABS, ABS_MT_POSITION_Y);
-	input_set_abs_params(input_dev, ABS_MT_TOUCH_MAJOR, 0, 255, 0, 0);
+	input_set_abs_params(input_dev, ABS_MT_TOUCH_MAJOR, 0, 16, 0, 0);
 
 	touchscreen_parse_properties(input_dev, true, &ts->prop);
 	if (!ts->prop.max_x || !ts->prop.max_y) {
diff --git a/drivers/media/pci/sta2x11/sta2x11_vip.c b/drivers/media/pci/sta2x11/sta2x11_vip.c
index 8535e49a4c4f..1f7ab56de4a0 100644
--- a/drivers/media/pci/sta2x11/sta2x11_vip.c
+++ b/drivers/media/pci/sta2x11/sta2x11_vip.c
@@ -756,7 +756,7 @@ static const struct video_device video_dev_template = {
 /**
  * vip_irq - interrupt routine
  * @irq: Number of interrupt ( not used, correct number is assumed )
- * @vip: local data structure containing all information
+ * @data: local data structure containing all information
  *
  * check for both frame interrupts set ( top and bottom ).
  * check FIFO overflow, but limit number of log messages after open.
@@ -766,8 +766,9 @@ static const struct video_device video_dev_template = {
  *
  * IRQ_HANDLED, interrupt done.
  */
-static irqreturn_t vip_irq(int irq, struct sta2x11_vip *vip)
+static irqreturn_t vip_irq(int irq, void *data)
 {
+	struct sta2x11_vip *vip = data;
 	unsigned int status;
 
 	status = reg_read(vip, DVP_ITS);
@@ -1049,9 +1050,7 @@ static int sta2x11_vip_init_one(struct pci_dev *pdev,
 
 	spin_lock_init(&vip->slock);
 
-	ret = request_irq(pdev->irq,
-			  (irq_handler_t) vip_irq,
-			  IRQF_SHARED, KBUILD_MODNAME, vip);
+	ret = request_irq(pdev->irq, vip_irq, IRQF_SHARED, KBUILD_MODNAME, vip);
 	if (ret) {
 		dev_err(&pdev->dev, "request_irq failed\n");
 		ret = -ENODEV;
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
diff --git a/drivers/net/ethernet/broadcom/bnx2x/bnx2x_cmn.c b/drivers/net/ethernet/broadcom/bnx2x/bnx2x_cmn.c
index 4950fde82d17..b04c5b51eb59 100644
--- a/drivers/net/ethernet/broadcom/bnx2x/bnx2x_cmn.c
+++ b/drivers/net/ethernet/broadcom/bnx2x/bnx2x_cmn.c
@@ -147,10 +147,11 @@ void bnx2x_fill_fw_str(struct bnx2x *bp, char *buf, size_t buf_len)
 
 		phy_fw_ver[0] = '\0';
 		bnx2x_get_ext_phy_fw_version(&bp->link_params,
-					     phy_fw_ver, PHY_FW_VER_LEN);
-		strscpy(buf, bp->fw_ver, buf_len);
-		snprintf(buf + strlen(bp->fw_ver), 32 - strlen(bp->fw_ver),
-			 "bc %d.%d.%d%s%s",
+					     phy_fw_ver, sizeof(phy_fw_ver));
+		/* This may become truncated. */
+		scnprintf(buf, buf_len,
+			 "%sbc %d.%d.%d%s%s",
+			 bp->fw_ver,
 			 (bp->common.bc_ver & 0xff0000) >> 16,
 			 (bp->common.bc_ver & 0xff00) >> 8,
 			 (bp->common.bc_ver & 0xff),
diff --git a/drivers/net/ethernet/broadcom/bnx2x/bnx2x_ethtool.c b/drivers/net/ethernet/broadcom/bnx2x/bnx2x_ethtool.c
index bda3ccc28eca..f920976c36f0 100644
--- a/drivers/net/ethernet/broadcom/bnx2x/bnx2x_ethtool.c
+++ b/drivers/net/ethernet/broadcom/bnx2x/bnx2x_ethtool.c
@@ -1132,7 +1132,7 @@ static void bnx2x_get_drvinfo(struct net_device *dev,
 	}
 
 	memset(version, 0, sizeof(version));
-	bnx2x_fill_fw_str(bp, version, ETHTOOL_FWVERS_LEN);
+	bnx2x_fill_fw_str(bp, version, sizeof(version));
 	strlcat(info->fw_version, version, sizeof(info->fw_version));
 
 	strscpy(info->bus_info, pci_name(bp->pdev), sizeof(info->bus_info));
diff --git a/drivers/net/ethernet/broadcom/bnx2x/bnx2x_link.c b/drivers/net/ethernet/broadcom/bnx2x/bnx2x_link.c
index 02808513ffe4..ea310057fe3a 100644
--- a/drivers/net/ethernet/broadcom/bnx2x/bnx2x_link.c
+++ b/drivers/net/ethernet/broadcom/bnx2x/bnx2x_link.c
@@ -6163,8 +6163,8 @@ static void bnx2x_link_int_ack(struct link_params *params,
 
 static int bnx2x_null_format_ver(u32 spirom_ver, u8 *str, u16 *len)
 {
-	str[0] = '\0';
-	(*len)--;
+	if (*len)
+		str[0] = '\0';
 	return 0;
 }
 
@@ -6173,7 +6173,7 @@ static int bnx2x_format_ver(u32 num, u8 *str, u16 *len)
 	u16 ret;
 
 	if (*len < 10) {
-		/* Need more than 10chars for this format */
+		/* Need more than 10 chars for this format */
 		bnx2x_null_format_ver(num, str, len);
 		return -EINVAL;
 	}
@@ -6188,8 +6188,8 @@ static int bnx2x_3_seq_format_ver(u32 num, u8 *str, u16 *len)
 {
 	u16 ret;
 
-	if (*len < 10) {
-		/* Need more than 10chars for this format */
+	if (*len < 9) {
+		/* Need more than 9 chars for this format */
 		bnx2x_null_format_ver(num, str, len);
 		return -EINVAL;
 	}
@@ -6208,7 +6208,7 @@ int bnx2x_get_ext_phy_fw_version(struct link_params *params, u8 *version,
 	int status = 0;
 	u8 *ver_p = version;
 	u16 remain_len = len;
-	if (version == NULL || params == NULL)
+	if (version == NULL || params == NULL || len == 0)
 		return -EINVAL;
 	bp = params->bp;
 
@@ -11546,7 +11546,7 @@ static int bnx2x_7101_format_ver(u32 spirom_ver, u8 *str, u16 *len)
 	str[2] = (spirom_ver & 0xFF0000) >> 16;
 	str[3] = (spirom_ver & 0xFF000000) >> 24;
 	str[4] = '\0';
-	*len -= 5;
+	*len -= 4;
 	return 0;
 }
 
diff --git a/drivers/net/ethernet/intel/ice/ice_virtchnl.c b/drivers/net/ethernet/intel/ice/ice_virtchnl.c
index 4b71392f60df..e64bef490a17 100644
--- a/drivers/net/ethernet/intel/ice/ice_virtchnl.c
+++ b/drivers/net/ethernet/intel/ice/ice_virtchnl.c
@@ -493,7 +493,7 @@ static int ice_vc_get_vf_res_msg(struct ice_vf *vf, u8 *msg)
 	vfres->rss_lut_size = ICE_VSIQF_HLUT_ARRAY_SIZE;
 	vfres->max_mtu = ice_vc_get_max_frame_size(vf);
 
-	vfres->vsi_res[0].vsi_id = vf->lan_vsi_num;
+	vfres->vsi_res[0].vsi_id = ICE_VF_VSI_ID;
 	vfres->vsi_res[0].vsi_type = VIRTCHNL_VSI_SRIOV;
 	vfres->vsi_res[0].num_queue_pairs = vsi->num_txq;
 	ether_addr_copy(vfres->vsi_res[0].default_mac_addr,
@@ -539,12 +539,7 @@ static void ice_vc_reset_vf_msg(struct ice_vf *vf)
  */
 bool ice_vc_isvalid_vsi_id(struct ice_vf *vf, u16 vsi_id)
 {
-	struct ice_pf *pf = vf->pf;
-	struct ice_vsi *vsi;
-
-	vsi = ice_find_vsi(pf, vsi_id);
-
-	return (vsi && (vsi->vf == vf));
+	return vsi_id == ICE_VF_VSI_ID;
 }
 
 /**
diff --git a/drivers/net/ethernet/intel/ice/ice_virtchnl.h b/drivers/net/ethernet/intel/ice/ice_virtchnl.h
index b5a3fd8adbb4..6073d3b2d2d6 100644
--- a/drivers/net/ethernet/intel/ice/ice_virtchnl.h
+++ b/drivers/net/ethernet/intel/ice/ice_virtchnl.h
@@ -18,6 +18,15 @@
  */
 #define ICE_MAX_MACADDR_PER_VF		18
 
+/* VFs only get a single VSI. For ice hardware, the VF does not need to know
+ * its VSI index. However, the virtchnl interface requires a VSI number,
+ * mainly due to legacy hardware.
+ *
+ * Since the VF doesn't need this information, report a static value to the VF
+ * instead of leaking any information about the PF or hardware setup.
+ */
+#define ICE_VF_VSI_ID	1
+
 struct ice_virtchnl_ops {
 	int (*get_ver_msg)(struct ice_vf *vf, u8 *msg);
 	int (*get_vf_res_msg)(struct ice_vf *vf, u8 *msg);
diff --git a/drivers/net/ethernet/pensando/ionic/ionic_lif.c b/drivers/net/ethernet/pensando/ionic/ionic_lif.c
index fcc3faecb060..d33cf8ee7c33 100644
--- a/drivers/net/ethernet/pensando/ionic/ionic_lif.c
+++ b/drivers/net/ethernet/pensando/ionic/ionic_lif.c
@@ -3216,9 +3216,12 @@ static int ionic_lif_adminq_init(struct ionic_lif *lif)
 
 	napi_enable(&qcq->napi);
 
-	if (qcq->flags & IONIC_QCQ_F_INTR)
+	if (qcq->flags & IONIC_QCQ_F_INTR) {
+		irq_set_affinity_hint(qcq->intr.vector,
+				      &qcq->intr.affinity_mask);
 		ionic_intr_mask(idev->intr_ctrl, qcq->intr.index,
 				IONIC_INTR_MASK_CLEAR);
+	}
 
 	qcq->flags |= IONIC_QCQ_F_INITED;
 
diff --git a/drivers/net/pcs/pcs-xpcs.c b/drivers/net/pcs/pcs-xpcs.c
index 3f882bce37f4..d126273daab4 100644
--- a/drivers/net/pcs/pcs-xpcs.c
+++ b/drivers/net/pcs/pcs-xpcs.c
@@ -262,7 +262,7 @@ static int xpcs_soft_reset(struct dw_xpcs *xpcs,
 		dev = MDIO_MMD_VEND2;
 		break;
 	default:
-		return -1;
+		return -EINVAL;
 	}
 
 	ret = xpcs_write(xpcs, dev, MDIO_CTRL1, MDIO_CTRL1_RESET);
@@ -904,7 +904,7 @@ int xpcs_do_config(struct dw_xpcs *xpcs, phy_interface_t interface,
 			return ret;
 		break;
 	default:
-		return -1;
+		return -EINVAL;
 	}
 
 	if (compat->pma_config) {
diff --git a/drivers/net/wireless/ath/ath11k/mhi.c b/drivers/net/wireless/ath/ath11k/mhi.c
index a62ee05c5409..4bea36cc7108 100644
--- a/drivers/net/wireless/ath/ath11k/mhi.c
+++ b/drivers/net/wireless/ath/ath11k/mhi.c
@@ -105,7 +105,7 @@ static struct mhi_controller_config ath11k_mhi_config_qca6390 = {
 	.max_channels = 128,
 	.timeout_ms = 2000,
 	.use_bounce_buf = false,
-	.buf_len = 0,
+	.buf_len = 8192,
 	.num_channels = ARRAY_SIZE(ath11k_mhi_channels_qca6390),
 	.ch_cfg = ath11k_mhi_channels_qca6390,
 	.num_events = ARRAY_SIZE(ath11k_mhi_events_qca6390),
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
diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/dmi.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/dmi.c
index 86ff174936a9..c3a602197662 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/dmi.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/dmi.c
@@ -82,6 +82,15 @@ static const struct dmi_system_id dmi_platform_data[] = {
 		},
 		.driver_data = (void *)&acepc_t8_data,
 	},
+	{
+		/* ACEPC W5 Pro Cherry Trail Z8350 HDMI stick, same wifi as the T8 */
+		.matches = {
+			DMI_MATCH(DMI_BOARD_NAME, "T3 MRD"),
+			DMI_MATCH(DMI_CHASSIS_TYPE, "3"),
+			DMI_MATCH(DMI_BIOS_VENDOR, "American Megatrends Inc."),
+		},
+		.driver_data = (void *)&acepc_t8_data,
+	},
 	{
 		/* Chuwi Hi8 Pro with D2D3_Hi8Pro.233 BIOS */
 		.matches = {
diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/drv.c b/drivers/net/wireless/intel/iwlwifi/pcie/drv.c
index 4d4db5f6836b..7f30e6add993 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/drv.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/drv.c
@@ -505,6 +505,7 @@ static const struct pci_device_id iwl_hw_card_ids[] = {
 
 /* Bz devices */
 	{IWL_PCI_DEVICE(0x2727, PCI_ANY_ID, iwl_bz_trans_cfg)},
+	{IWL_PCI_DEVICE(0x272D, PCI_ANY_ID, iwl_bz_trans_cfg)},
 	{IWL_PCI_DEVICE(0x272b, PCI_ANY_ID, iwl_bz_trans_cfg)},
 	{IWL_PCI_DEVICE(0xA840, PCI_ANY_ID, iwl_bz_trans_cfg)},
 	{IWL_PCI_DEVICE(0x7740, PCI_ANY_ID, iwl_bz_trans_cfg)},
diff --git a/drivers/net/wireless/realtek/rtw89/pci.h b/drivers/net/wireless/realtek/rtw89/pci.h
index 179740607778..d982c5dc0889 100644
--- a/drivers/net/wireless/realtek/rtw89/pci.h
+++ b/drivers/net/wireless/realtek/rtw89/pci.h
@@ -546,7 +546,7 @@
 #define RTW89_PCI_TXWD_NUM_MAX		512
 #define RTW89_PCI_TXWD_PAGE_SIZE	128
 #define RTW89_PCI_ADDRINFO_MAX		4
-#define RTW89_PCI_RX_BUF_SIZE		11460
+#define RTW89_PCI_RX_BUF_SIZE		(11454 + 40) /* +40 for rtw89_rxdesc_long_v2 */
 
 #define RTW89_PCI_POLL_BDRAM_RST_CNT	100
 #define RTW89_PCI_MULTITAG		8
diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 3d01290994d8..5ff09f2cacab 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -3471,6 +3471,9 @@ static const struct pci_device_id nvme_id_table[] = {
 				NVME_QUIRK_BOGUS_NID, },
 	{ PCI_VDEVICE(REDHAT, 0x0010),	/* Qemu emulated controller */
 		.driver_data = NVME_QUIRK_BOGUS_NID, },
+	{ PCI_DEVICE(0x126f, 0x2262),	/* Silicon Motion generic */
+		.driver_data = NVME_QUIRK_NO_DEEPEST_PS |
+				NVME_QUIRK_BOGUS_NID, },
 	{ PCI_DEVICE(0x126f, 0x2263),	/* Silicon Motion unidentified */
 		.driver_data = NVME_QUIRK_NO_NS_DESC_LIST |
 				NVME_QUIRK_BOGUS_NID, },
diff --git a/drivers/pinctrl/renesas/core.c b/drivers/pinctrl/renesas/core.c
index c91102d3f1d1..1c7f8caf7f7c 100644
--- a/drivers/pinctrl/renesas/core.c
+++ b/drivers/pinctrl/renesas/core.c
@@ -921,9 +921,11 @@ static void __init sh_pfc_check_cfg_reg(const char *drvname,
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
diff --git a/drivers/platform/x86/intel/vbtn.c b/drivers/platform/x86/intel/vbtn.c
index c10c99a31a90..224139006a43 100644
--- a/drivers/platform/x86/intel/vbtn.c
+++ b/drivers/platform/x86/intel/vbtn.c
@@ -136,8 +136,6 @@ static int intel_vbtn_input_setup(struct platform_device *device)
 	priv->switches_dev->id.bustype = BUS_HOST;
 
 	if (priv->has_switches) {
-		detect_tablet_mode(&device->dev);
-
 		ret = input_register_device(priv->switches_dev);
 		if (ret)
 			return ret;
@@ -316,6 +314,9 @@ static int intel_vbtn_probe(struct platform_device *device)
 		if (ACPI_FAILURE(status))
 			dev_err(&device->dev, "Error VBDL failed with ACPI status %d\n", status);
 	}
+	// Check switches after buttons since VBDL may have side effects.
+	if (has_switches)
+		detect_tablet_mode(&device->dev);
 
 	device_init_wakeup(&device->dev, true);
 	/*
diff --git a/drivers/platform/x86/touchscreen_dmi.c b/drivers/platform/x86/touchscreen_dmi.c
index 11d72a353355..399b97b54dd0 100644
--- a/drivers/platform/x86/touchscreen_dmi.c
+++ b/drivers/platform/x86/touchscreen_dmi.c
@@ -1177,6 +1177,15 @@ const struct dmi_system_id touchscreen_dmi_table[] = {
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
diff --git a/drivers/scsi/lpfc/lpfc_nportdisc.c b/drivers/scsi/lpfc/lpfc_nportdisc.c
index b86ff9fcdf0c..f21396a0ba9d 100644
--- a/drivers/scsi/lpfc/lpfc_nportdisc.c
+++ b/drivers/scsi/lpfc/lpfc_nportdisc.c
@@ -748,8 +748,10 @@ lpfc_rcv_padisc(struct lpfc_vport *vport, struct lpfc_nodelist *ndlp,
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
diff --git a/drivers/scsi/scsi_lib.c b/drivers/scsi/scsi_lib.c
index edd296f950a3..5c5954b78585 100644
--- a/drivers/scsi/scsi_lib.c
+++ b/drivers/scsi/scsi_lib.c
@@ -185,37 +185,39 @@ void scsi_queue_insert(struct scsi_cmnd *cmd, int reason)
 	__scsi_queue_insert(cmd, reason, true);
 }
 
+
 /**
- * scsi_execute_cmd - insert request and wait for the result
- * @sdev:	scsi_device
+ * __scsi_execute - insert request and wait for the result
+ * @sdev:	scsi device
  * @cmd:	scsi command
- * @opf:	block layer request cmd_flags
+ * @data_direction: data direction
  * @buffer:	data buffer
  * @bufflen:	len of buffer
+ * @sense:	optional sense buffer
+ * @sshdr:	optional decoded sense header
  * @timeout:	request timeout in HZ
  * @retries:	number of times to retry request
- * @args:	Optional args. See struct definition for field descriptions
+ * @flags:	flags for ->cmd_flags
+ * @rq_flags:	flags for ->rq_flags
+ * @resid:	optional residual length
  *
  * Returns the scsi_cmnd result field if a command was executed, or a negative
  * Linux error code if we didn't get that far.
  */
-int scsi_execute_cmd(struct scsi_device *sdev, const unsigned char *cmd,
-		     blk_opf_t opf, void *buffer, unsigned int bufflen,
-		     int timeout, int retries,
-		     const struct scsi_exec_args *args)
+int __scsi_execute(struct scsi_device *sdev, const unsigned char *cmd,
+		 int data_direction, void *buffer, unsigned bufflen,
+		 unsigned char *sense, struct scsi_sense_hdr *sshdr,
+		 int timeout, int retries, blk_opf_t flags,
+		 req_flags_t rq_flags, int *resid)
 {
-	static const struct scsi_exec_args default_args;
 	struct request *req;
 	struct scsi_cmnd *scmd;
 	int ret;
 
-	if (!args)
-		args = &default_args;
-	else if (WARN_ON_ONCE(args->sense &&
-			      args->sense_len != SCSI_SENSE_BUFFERSIZE))
-		return -EINVAL;
-
-	req = scsi_alloc_request(sdev->request_queue, opf, args->req_flags);
+	req = scsi_alloc_request(sdev->request_queue,
+			data_direction == DMA_TO_DEVICE ?
+			REQ_OP_DRV_OUT : REQ_OP_DRV_IN,
+			rq_flags & RQF_PM ? BLK_MQ_REQ_PM : 0);
 	if (IS_ERR(req))
 		return PTR_ERR(req);
 
@@ -230,7 +232,8 @@ int scsi_execute_cmd(struct scsi_device *sdev, const unsigned char *cmd,
 	memcpy(scmd->cmnd, cmd, scmd->cmd_len);
 	scmd->allowed = retries;
 	req->timeout = timeout;
-	req->rq_flags |= RQF_QUIET;
+	req->cmd_flags |= flags;
+	req->rq_flags |= rq_flags | RQF_QUIET;
 
 	/*
 	 * head injection *required* here otherwise quiesce won't work
@@ -246,21 +249,20 @@ int scsi_execute_cmd(struct scsi_device *sdev, const unsigned char *cmd,
 	if (unlikely(scmd->resid_len > 0 && scmd->resid_len <= bufflen))
 		memset(buffer + bufflen - scmd->resid_len, 0, scmd->resid_len);
 
-	if (args->resid)
-		*args->resid = scmd->resid_len;
-	if (args->sense)
-		memcpy(args->sense, scmd->sense_buffer, SCSI_SENSE_BUFFERSIZE);
-	if (args->sshdr)
+	if (resid)
+		*resid = scmd->resid_len;
+	if (sense && scmd->sense_len)
+		memcpy(sense, scmd->sense_buffer, SCSI_SENSE_BUFFERSIZE);
+	if (sshdr)
 		scsi_normalize_sense(scmd->sense_buffer, scmd->sense_len,
-				     args->sshdr);
-
+				     sshdr);
 	ret = scmd->result;
  out:
 	blk_mq_free_request(req);
 
 	return ret;
 }
-EXPORT_SYMBOL(scsi_execute_cmd);
+EXPORT_SYMBOL(__scsi_execute);
 
 /*
  * Wake up the error handler if necessary. Avoid as follows that the error
diff --git a/drivers/scsi/sd.c b/drivers/scsi/sd.c
index f32236c3f81c..3ec9b324fdcf 100644
--- a/drivers/scsi/sd.c
+++ b/drivers/scsi/sd.c
@@ -3299,8 +3299,8 @@ static void sd_read_block_zero(struct scsi_disk *sdkp)
 	put_unaligned_be32(0, &cmd[2]); /* Logical block address 0 */
 	put_unaligned_be16(1, &cmd[7]);	/* Transfer 1 logical block */
 
-	scsi_execute_cmd(sdkp->device, cmd, REQ_OP_DRV_IN, buffer, buf_len,
-			 SD_TIMEOUT, sdkp->max_retries, NULL);
+	scsi_execute_req(sdkp->device, cmd, DMA_FROM_DEVICE, buffer, buf_len,
+			 NULL, SD_TIMEOUT, sdkp->max_retries, NULL);
 	kfree(buffer);
 }
 
diff --git a/drivers/soundwire/dmi-quirks.c b/drivers/soundwire/dmi-quirks.c
index 9ebdd0cd0b1c..91ab97a456fa 100644
--- a/drivers/soundwire/dmi-quirks.c
+++ b/drivers/soundwire/dmi-quirks.c
@@ -130,6 +130,14 @@ static const struct dmi_system_id adr_remap_quirk_table[] = {
 		},
 		.driver_data = (void *)intel_rooks_county,
 	},
+	{
+		/* quirk used for NUC15 LAPRC710 skew */
+		.matches = {
+			DMI_MATCH(DMI_BOARD_VENDOR, "Intel Corporation"),
+			DMI_MATCH(DMI_BOARD_NAME, "LAPRC710"),
+		},
+		.driver_data = (void *)intel_rooks_county,
+	},
 	{
 		.matches = {
 			DMI_MATCH(DMI_SYS_VENDOR, "Dell Inc"),
diff --git a/drivers/thermal/thermal_of.c b/drivers/thermal/thermal_of.c
index 4104743dbc17..202dce0d2e30 100644
--- a/drivers/thermal/thermal_of.c
+++ b/drivers/thermal/thermal_of.c
@@ -337,14 +337,18 @@ static int thermal_of_monitor_init(struct device_node *np, int *delay, int *pdel
 	int ret;
 
 	ret = of_property_read_u32(np, "polling-delay-passive", pdelay);
-	if (ret < 0) {
-		pr_err("%pOFn: missing polling-delay-passive property\n", np);
+	if (ret == -EINVAL) {
+		*pdelay = 0;
+	} else if (ret < 0) {
+		pr_err("%pOFn: Couldn't get polling-delay-passive: %d\n", np, ret);
 		return ret;
 	}
 
 	ret = of_property_read_u32(np, "polling-delay", delay);
-	if (ret < 0) {
-		pr_err("%pOFn: missing polling-delay property\n", np);
+	if (ret == -EINVAL) {
+		*delay = 0;
+	} else if (ret < 0) {
+		pr_err("%pOFn: Couldn't get polling-delay: %d\n", np, ret);
 		return ret;
 	}
 
diff --git a/drivers/thunderbolt/quirks.c b/drivers/thunderbolt/quirks.c
index 4ab3803e10c8..638cb5fb22c1 100644
--- a/drivers/thunderbolt/quirks.c
+++ b/drivers/thunderbolt/quirks.c
@@ -42,6 +42,12 @@ static void quirk_usb3_maximum_bandwidth(struct tb_switch *sw)
 	}
 }
 
+static void quirk_block_rpm_in_redrive(struct tb_switch *sw)
+{
+	sw->quirks |= QUIRK_KEEP_POWER_IN_DP_REDRIVE;
+	tb_sw_dbg(sw, "preventing runtime PM in DP redrive mode\n");
+}
+
 struct tb_quirk {
 	u16 hw_vendor_id;
 	u16 hw_device_id;
@@ -85,6 +91,14 @@ static const struct tb_quirk tb_quirks[] = {
 		  quirk_usb3_maximum_bandwidth },
 	{ 0x8087, PCI_DEVICE_ID_INTEL_BARLOW_RIDGE_HUB_40G_BRIDGE, 0x0000, 0x0000,
 		  quirk_usb3_maximum_bandwidth },
+	/*
+	 * Block Runtime PM in DP redrive mode for Intel Barlow Ridge host
+	 * controllers.
+	 */
+	{ 0x8087, PCI_DEVICE_ID_INTEL_BARLOW_RIDGE_HOST_80G_NHI, 0x0000, 0x0000,
+		  quirk_block_rpm_in_redrive },
+	{ 0x8087, PCI_DEVICE_ID_INTEL_BARLOW_RIDGE_HOST_40G_NHI, 0x0000, 0x0000,
+		  quirk_block_rpm_in_redrive },
 	/*
 	 * CLx is not supported on AMD USB4 Yellow Carp and Pink Sardine platforms.
 	 */
diff --git a/drivers/thunderbolt/tb.c b/drivers/thunderbolt/tb.c
index e1eb092ad1d6..e83269dc2b06 100644
--- a/drivers/thunderbolt/tb.c
+++ b/drivers/thunderbolt/tb.c
@@ -1050,6 +1050,49 @@ static void tb_tunnel_dp(struct tb *tb)
 	pm_runtime_put_autosuspend(&in->sw->dev);
 }
 
+static void tb_enter_redrive(struct tb_port *port)
+{
+	struct tb_switch *sw = port->sw;
+
+	if (!(sw->quirks & QUIRK_KEEP_POWER_IN_DP_REDRIVE))
+		return;
+
+	/*
+	 * If we get hot-unplug for the DP IN port of the host router
+	 * and the DP resource is not available anymore it means there
+	 * is a monitor connected directly to the Type-C port and we are
+	 * in "redrive" mode. For this to work we cannot enter RTD3 so
+	 * we bump up the runtime PM reference count here.
+	 */
+	if (!tb_port_is_dpin(port))
+		return;
+	if (tb_route(sw))
+		return;
+	if (!tb_switch_query_dp_resource(sw, port)) {
+		port->redrive = true;
+		pm_runtime_get(&sw->dev);
+		tb_port_dbg(port, "enter redrive mode, keeping powered\n");
+	}
+}
+
+static void tb_exit_redrive(struct tb_port *port)
+{
+	struct tb_switch *sw = port->sw;
+
+	if (!(sw->quirks & QUIRK_KEEP_POWER_IN_DP_REDRIVE))
+		return;
+
+	if (!tb_port_is_dpin(port))
+		return;
+	if (tb_route(sw))
+		return;
+	if (port->redrive && tb_switch_query_dp_resource(sw, port)) {
+		port->redrive = false;
+		pm_runtime_put(&sw->dev);
+		tb_port_dbg(port, "exit redrive mode\n");
+	}
+}
+
 static void tb_dp_resource_unavailable(struct tb *tb, struct tb_port *port)
 {
 	struct tb_port *in, *out;
@@ -1066,7 +1109,10 @@ static void tb_dp_resource_unavailable(struct tb *tb, struct tb_port *port)
 	}
 
 	tunnel = tb_find_tunnel(tb, TB_TUNNEL_DP, in, out);
-	tb_deactivate_and_free_tunnel(tunnel);
+	if (tunnel)
+		tb_deactivate_and_free_tunnel(tunnel);
+	else
+		tb_enter_redrive(port);
 	list_del_init(&port->list);
 
 	/*
@@ -1092,6 +1138,7 @@ static void tb_dp_resource_available(struct tb *tb, struct tb_port *port)
 	tb_port_dbg(port, "DP %s resource available\n",
 		    tb_port_is_dpin(port) ? "IN" : "OUT");
 	list_add_tail(&port->list, &tcm->dp_resources);
+	tb_exit_redrive(port);
 
 	/* Look for suitable DP IN <-> DP OUT pairs now */
 	tb_tunnel_dp(tb);
diff --git a/drivers/thunderbolt/tb.h b/drivers/thunderbolt/tb.h
index f79cae48a8ea..b3fec5f8e20c 100644
--- a/drivers/thunderbolt/tb.h
+++ b/drivers/thunderbolt/tb.h
@@ -27,6 +27,8 @@
 #define QUIRK_FORCE_POWER_LINK_CONTROLLER		BIT(0)
 /* Disable CLx if not supported */
 #define QUIRK_NO_CLX					BIT(1)
+/* Need to keep power on while USB4 port is in redrive mode */
+#define QUIRK_KEEP_POWER_IN_DP_REDRIVE			BIT(2)
 
 /**
  * struct tb_nvm - Structure holding NVM information
@@ -254,6 +256,7 @@ struct tb_switch {
  *		 DMA paths through this port.
  * @max_bw: Maximum possible bandwidth through this adapter if set to
  *	    non-zero.
+ * @redrive: For DP IN, if true the adapter is in redrive mode.
  *
  * In USB4 terminology this structure represents an adapter (protocol or
  * lane adapter).
@@ -280,6 +283,7 @@ struct tb_port {
 	unsigned int ctl_credits;
 	unsigned int dma_credits;
 	unsigned int max_bw;
+	bool redrive;
 };
 
 /**
diff --git a/drivers/tty/n_gsm.c b/drivers/tty/n_gsm.c
index 6b6abce6b69f..d2daf0a72e34 100644
--- a/drivers/tty/n_gsm.c
+++ b/drivers/tty/n_gsm.c
@@ -2969,6 +2969,9 @@ static int gsmld_open(struct tty_struct *tty)
 {
 	struct gsm_mux *gsm;
 
+	if (!capable(CAP_NET_ADMIN))
+		return -EPERM;
+
 	if (tty->ops->write == NULL)
 		return -EINVAL;
 
diff --git a/drivers/usb/gadget/function/uvc_video.c b/drivers/usb/gadget/function/uvc_video.c
index e81865978299..be48d5ab17c7 100644
--- a/drivers/usb/gadget/function/uvc_video.c
+++ b/drivers/usb/gadget/function/uvc_video.c
@@ -35,6 +35,9 @@ uvc_video_encode_header(struct uvc_video *video, struct uvc_buffer *buf,
 
 	data[1] = UVC_STREAM_EOH | video->fid;
 
+	if (video->queue.flags & UVC_QUEUE_DROP_INCOMPLETE)
+		data[1] |= UVC_STREAM_ERR;
+
 	if (video->queue.buf_used == 0 && ts.tv_sec) {
 		/* dwClockFrequency is 48 MHz */
 		u32 pts = ((u64)ts.tv_sec * USEC_PER_SEC + ts.tv_nsec / NSEC_PER_USEC) * 48;
diff --git a/drivers/usb/host/sl811-hcd.c b/drivers/usb/host/sl811-hcd.c
index b8b90eec9107..48478eb71211 100644
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
diff --git a/drivers/usb/typec/tcpm/tcpci.c b/drivers/usb/typec/tcpm/tcpci.c
index 816945913ed0..f649769912e5 100644
--- a/drivers/usb/typec/tcpm/tcpci.c
+++ b/drivers/usb/typec/tcpm/tcpci.c
@@ -875,6 +875,7 @@ MODULE_DEVICE_TABLE(i2c, tcpci_id);
 #ifdef CONFIG_OF
 static const struct of_device_id tcpci_of_match[] = {
 	{ .compatible = "nxp,ptn5110", },
+	{ .compatible = "tcpci", },
 	{},
 };
 MODULE_DEVICE_TABLE(of, tcpci_of_match);
diff --git a/drivers/video/fbdev/core/fbmon.c b/drivers/video/fbdev/core/fbmon.c
index b0e690f41025..9ca99da3a56a 100644
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
index 828ced060742..1ef094427f29 100644
--- a/drivers/virtio/virtio.c
+++ b/drivers/virtio/virtio.c
@@ -489,13 +489,19 @@ EXPORT_SYMBOL_GPL(unregister_virtio_device);
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
diff --git a/fs/btrfs/export.c b/fs/btrfs/export.c
index fab7eb76e53b..58b0f04d7123 100644
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
diff --git a/fs/btrfs/send.c b/fs/btrfs/send.c
index 9f7ffd9ef6fd..754a9fb0165f 100644
--- a/fs/btrfs/send.c
+++ b/fs/btrfs/send.c
@@ -1015,7 +1015,15 @@ static int iterate_inode_ref(struct btrfs_root *root, struct btrfs_path *path,
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
index 03cfb425ea4e..ab5d410d560e 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -3381,7 +3381,17 @@ static int btrfs_relocate_sys_chunks(struct btrfs_fs_info *fs_info)
 			mutex_unlock(&fs_info->reclaim_bgs_lock);
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
diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
index bc0ca45a5d81..a843f964332c 100644
--- a/fs/ext4/mballoc.c
+++ b/fs/ext4/mballoc.c
@@ -2905,7 +2905,10 @@ static int ext4_mb_seq_groups_show(struct seq_file *seq, void *v)
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
diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index 601e097e1720..274542d869d0 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -6751,6 +6751,10 @@ static int ext4_write_dquot(struct dquot *dquot)
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
@@ -6767,6 +6771,10 @@ static int ext4_acquire_dquot(struct dquot *dquot)
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
@@ -6786,6 +6794,10 @@ static int ext4_release_dquot(struct dquot *dquot)
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
diff --git a/fs/isofs/inode.c b/fs/isofs/inode.c
index df9d70588b60..8a6c7fdc1d5f 100644
--- a/fs/isofs/inode.c
+++ b/fs/isofs/inode.c
@@ -908,8 +908,22 @@ static int isofs_fill_super(struct super_block *s, void *data, int silent)
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
diff --git a/fs/orangefs/super.c b/fs/orangefs/super.c
index 5254256a224d..4ca8ed410c3c 100644
--- a/fs/orangefs/super.c
+++ b/fs/orangefs/super.c
@@ -527,7 +527,7 @@ struct dentry *orangefs_mount(struct file_system_type *fst,
 	sb->s_fs_info = kzalloc(sizeof(struct orangefs_sb_info_s), GFP_KERNEL);
 	if (!ORANGEFS_SB(sb)) {
 		d = ERR_PTR(-ENOMEM);
-		goto free_sb_and_op;
+		goto free_op;
 	}
 
 	ret = orangefs_fill_sb(sb,
diff --git a/fs/pstore/zone.c b/fs/pstore/zone.c
index 2770746bb7aa..abca117725c8 100644
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
index 9925cfe57159..17c7d76770a0 100644
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
diff --git a/include/linux/randomize_kstack.h b/include/linux/randomize_kstack.h
index 5d868505a94e..6d92b68efbf6 100644
--- a/include/linux/randomize_kstack.h
+++ b/include/linux/randomize_kstack.h
@@ -80,7 +80,7 @@ DECLARE_PER_CPU(u32, kstack_offset);
 	if (static_branch_maybe(CONFIG_RANDOMIZE_KSTACK_OFFSET_DEFAULT,	\
 				&randomize_kstack_offset)) {		\
 		u32 offset = raw_cpu_read(kstack_offset);		\
-		offset ^= (rand);					\
+		offset = ror32(offset, 5) ^ (rand);			\
 		raw_cpu_write(kstack_offset, offset);			\
 	}								\
 } while (0)
diff --git a/include/linux/rcupdate.h b/include/linux/rcupdate.h
index 319698087d66..6858cae98da9 100644
--- a/include/linux/rcupdate.h
+++ b/include/linux/rcupdate.h
@@ -205,9 +205,9 @@ void rcu_tasks_trace_qs_blkd(struct task_struct *t);
 	do {									\
 		int ___rttq_nesting = READ_ONCE((t)->trc_reader_nesting);	\
 										\
-		if (likely(!READ_ONCE((t)->trc_reader_special.b.need_qs)) &&	\
+		if (unlikely(READ_ONCE((t)->trc_reader_special.b.need_qs) == TRC_NEED_QS) &&	\
 		    likely(!___rttq_nesting)) {					\
-			rcu_trc_cmpxchg_need_qs((t), 0,	TRC_NEED_QS_CHECKED);	\
+			rcu_trc_cmpxchg_need_qs((t), TRC_NEED_QS, TRC_NEED_QS_CHECKED);	\
 		} else if (___rttq_nesting && ___rttq_nesting != INT_MIN &&	\
 			   !READ_ONCE((t)->trc_reader_special.b.blocked)) {	\
 			rcu_tasks_trace_qs_blkd(t);				\
diff --git a/include/linux/skbuff.h b/include/linux/skbuff.h
index c4a8520dc748..d5f888fe0e33 100644
--- a/include/linux/skbuff.h
+++ b/include/linux/skbuff.h
@@ -2603,6 +2603,8 @@ static inline void skb_put_u8(struct sk_buff *skb, u8 val)
 void *skb_push(struct sk_buff *skb, unsigned int len);
 static inline void *__skb_push(struct sk_buff *skb, unsigned int len)
 {
+	DEBUG_NET_WARN_ON_ONCE(len > INT_MAX);
+
 	skb->data -= len;
 	skb->len  += len;
 	return skb->data;
@@ -2611,6 +2613,8 @@ static inline void *__skb_push(struct sk_buff *skb, unsigned int len)
 void *skb_pull(struct sk_buff *skb, unsigned int len);
 static inline void *__skb_pull(struct sk_buff *skb, unsigned int len)
 {
+	DEBUG_NET_WARN_ON_ONCE(len > INT_MAX);
+
 	skb->len -= len;
 	if (unlikely(skb->len < skb->data_len)) {
 #if defined(CONFIG_DEBUG_NET)
@@ -2634,6 +2638,8 @@ void *__pskb_pull_tail(struct sk_buff *skb, int delta);
 
 static inline bool pskb_may_pull(struct sk_buff *skb, unsigned int len)
 {
+	DEBUG_NET_WARN_ON_ONCE(len > INT_MAX);
+
 	if (likely(len <= skb_headlen(skb)))
 		return true;
 	if (unlikely(len > skb->len))
@@ -2796,6 +2802,11 @@ static inline void skb_set_inner_network_header(struct sk_buff *skb,
 	skb->inner_network_header += offset;
 }
 
+static inline bool skb_inner_network_header_was_set(const struct sk_buff *skb)
+{
+	return skb->inner_network_header > 0;
+}
+
 static inline unsigned char *skb_inner_mac_header(const struct sk_buff *skb)
 {
 	return skb->head + skb->inner_mac_header;
diff --git a/include/linux/sunrpc/sched.h b/include/linux/sunrpc/sched.h
index 8ada7dc802d3..8f9bee0e21c3 100644
--- a/include/linux/sunrpc/sched.h
+++ b/include/linux/sunrpc/sched.h
@@ -186,7 +186,7 @@ struct rpc_wait_queue {
 	unsigned char		maxpriority;		/* maximum priority (0 if queue is not a priority queue) */
 	unsigned char		priority;		/* current priority */
 	unsigned char		nr;			/* # tasks remaining for cookie */
-	unsigned short		qlen;			/* total # tasks waiting in queue */
+	unsigned int		qlen;			/* total # tasks waiting in queue */
 	struct rpc_timer	timer_list;
 #if IS_ENABLED(CONFIG_SUNRPC_DEBUG) || IS_ENABLED(CONFIG_TRACEPOINTS)
 	const char *		name;
diff --git a/include/scsi/scsi_device.h b/include/scsi/scsi_device.h
index a64713fe5264..1504d3137cc6 100644
--- a/include/scsi/scsi_device.h
+++ b/include/scsi/scsi_device.h
@@ -480,51 +480,28 @@ extern const char *scsi_device_state_name(enum scsi_device_state);
 extern int scsi_is_sdev_device(const struct device *);
 extern int scsi_is_target_device(const struct device *);
 extern void scsi_sanitize_inquiry_string(unsigned char *s, int len);
-
-/* Optional arguments to scsi_execute_cmd */
-struct scsi_exec_args {
-	unsigned char *sense;		/* sense buffer */
-	unsigned int sense_len;		/* sense buffer len */
-	struct scsi_sense_hdr *sshdr;	/* decoded sense header */
-	blk_mq_req_flags_t req_flags;	/* BLK_MQ_REQ flags */
-	int *resid;			/* residual length */
-};
-
-int scsi_execute_cmd(struct scsi_device *sdev, const unsigned char *cmd,
-		     blk_opf_t opf, void *buffer, unsigned int bufflen,
-		     int timeout, int retries,
-		     const struct scsi_exec_args *args);
-
+extern int __scsi_execute(struct scsi_device *sdev, const unsigned char *cmd,
+			int data_direction, void *buffer, unsigned bufflen,
+			unsigned char *sense, struct scsi_sense_hdr *sshdr,
+			int timeout, int retries, blk_opf_t flags,
+			req_flags_t rq_flags, int *resid);
 /* Make sure any sense buffer is the correct size. */
-#define scsi_execute(_sdev, _cmd, _data_dir, _buffer, _bufflen, _sense,	\
-		     _sshdr, _timeout, _retries, _flags, _rq_flags,	\
-		     _resid)						\
+#define scsi_execute(sdev, cmd, data_direction, buffer, bufflen, sense,	\
+		     sshdr, timeout, retries, flags, rq_flags, resid)	\
 ({									\
-	scsi_execute_cmd(_sdev, _cmd, (_data_dir == DMA_TO_DEVICE ?	\
-			 REQ_OP_DRV_OUT : REQ_OP_DRV_IN) | _flags,	\
-			 _buffer, _bufflen, _timeout, _retries,	\
-			 &(struct scsi_exec_args) {			\
-				.sense = _sense,			\
-				.sshdr = _sshdr,			\
-				.req_flags = _rq_flags & RQF_PM  ?	\
-						BLK_MQ_REQ_PM : 0,	\
-				.resid = _resid,			\
-			 });						\
+	BUILD_BUG_ON((sense) != NULL &&					\
+		     sizeof(sense) != SCSI_SENSE_BUFFERSIZE);		\
+	__scsi_execute(sdev, cmd, data_direction, buffer, bufflen,	\
+		       sense, sshdr, timeout, retries, flags, rq_flags,	\
+		       resid);						\
 })
-
 static inline int scsi_execute_req(struct scsi_device *sdev,
 	const unsigned char *cmd, int data_direction, void *buffer,
 	unsigned bufflen, struct scsi_sense_hdr *sshdr, int timeout,
 	int retries, int *resid)
 {
-	return scsi_execute_cmd(sdev, cmd,
-				data_direction == DMA_TO_DEVICE ?
-				REQ_OP_DRV_OUT : REQ_OP_DRV_IN, buffer,
-				bufflen, timeout, retries,
-				&(struct scsi_exec_args) {
-					.sshdr = sshdr,
-					.resid = resid,
-				});
+	return scsi_execute(sdev, cmd, data_direction, buffer,
+		bufflen, NULL, sshdr, timeout, retries,  0, 0, resid);
 }
 extern void sdev_disable_disk_events(struct scsi_device *sdev);
 extern void sdev_enable_disk_events(struct scsi_device *sdev);
diff --git a/include/uapi/linux/input-event-codes.h b/include/uapi/linux/input-event-codes.h
index 7ad931a32970..1ce8a91349e9 100644
--- a/include/uapi/linux/input-event-codes.h
+++ b/include/uapi/linux/input-event-codes.h
@@ -602,6 +602,7 @@
 
 #define KEY_ALS_TOGGLE		0x230	/* Ambient light sensor */
 #define KEY_ROTATE_LOCK_TOGGLE	0x231	/* Display rotation lock */
+#define KEY_REFRESH_RATE_TOGGLE	0x232	/* Display refresh rate toggle */
 
 #define KEY_BUTTONCONFIG		0x240	/* AL Button Configuration */
 #define KEY_TASKMANAGER		0x241	/* AL Task/Project Manager */
diff --git a/io_uring/io_uring.c b/io_uring/io_uring.c
index 415248c1f82c..68f1b6f8699a 100644
--- a/io_uring/io_uring.c
+++ b/io_uring/io_uring.c
@@ -1978,6 +1978,13 @@ static void io_init_req_drain(struct io_kiocb *req)
 	}
 }
 
+static __cold int io_init_fail_req(struct io_kiocb *req, int err)
+{
+	/* ensure per-opcode data is cleared if we fail before prep */
+	memset(&req->cmd.data, 0, sizeof(req->cmd.data));
+	return err;
+}
+
 static int io_init_req(struct io_ring_ctx *ctx, struct io_kiocb *req,
 		       const struct io_uring_sqe *sqe)
 	__must_hold(&ctx->uring_lock)
@@ -1998,29 +2005,29 @@ static int io_init_req(struct io_ring_ctx *ctx, struct io_kiocb *req,
 
 	if (unlikely(opcode >= IORING_OP_LAST)) {
 		req->opcode = 0;
-		return -EINVAL;
+		return io_init_fail_req(req, -EINVAL);
 	}
 	def = &io_op_defs[opcode];
 	if (unlikely(sqe_flags & ~SQE_COMMON_FLAGS)) {
 		/* enforce forwards compatibility on users */
 		if (sqe_flags & ~SQE_VALID_FLAGS)
-			return -EINVAL;
+			return io_init_fail_req(req, -EINVAL);
 		if (sqe_flags & IOSQE_BUFFER_SELECT) {
 			if (!def->buffer_select)
-				return -EOPNOTSUPP;
+				return io_init_fail_req(req, -EOPNOTSUPP);
 			req->buf_index = READ_ONCE(sqe->buf_group);
 		}
 		if (sqe_flags & IOSQE_CQE_SKIP_SUCCESS)
 			ctx->drain_disabled = true;
 		if (sqe_flags & IOSQE_IO_DRAIN) {
 			if (ctx->drain_disabled)
-				return -EOPNOTSUPP;
+				return io_init_fail_req(req, -EOPNOTSUPP);
 			io_init_req_drain(req);
 		}
 	}
 	if (unlikely(ctx->restricted || ctx->drain_active || ctx->drain_next)) {
 		if (ctx->restricted && !io_check_restriction(ctx, req, sqe_flags))
-			return -EACCES;
+			return io_init_fail_req(req, -EACCES);
 		/* knock it to the slow queue path, will be drained there */
 		if (ctx->drain_active)
 			req->flags |= REQ_F_FORCE_ASYNC;
@@ -2033,9 +2040,9 @@ static int io_init_req(struct io_ring_ctx *ctx, struct io_kiocb *req,
 	}
 
 	if (!def->ioprio && sqe->ioprio)
-		return -EINVAL;
+		return io_init_fail_req(req, -EINVAL);
 	if (!def->iopoll && (ctx->flags & IORING_SETUP_IOPOLL))
-		return -EINVAL;
+		return io_init_fail_req(req, -EINVAL);
 
 	if (def->needs_file) {
 		struct io_submit_state *state = &ctx->submit_state;
@@ -2059,12 +2066,12 @@ static int io_init_req(struct io_ring_ctx *ctx, struct io_kiocb *req,
 
 		req->creds = xa_load(&ctx->personalities, personality);
 		if (!req->creds)
-			return -EINVAL;
+			return io_init_fail_req(req, -EINVAL);
 		get_cred(req->creds);
 		ret = security_uring_override_creds(req->creds);
 		if (ret) {
 			put_cred(req->creds);
-			return ret;
+			return io_init_fail_req(req, ret);
 		}
 		req->flags |= REQ_F_CREDS;
 	}
diff --git a/kernel/dma/direct.c b/kernel/dma/direct.c
index 63859a101ed8..d4215739efc7 100644
--- a/kernel/dma/direct.c
+++ b/kernel/dma/direct.c
@@ -296,7 +296,7 @@ void *dma_direct_alloc(struct device *dev, size_t size,
 	} else {
 		ret = page_address(page);
 		if (dma_set_decrypted(dev, ret, size))
-			goto out_free_pages;
+			goto out_leak_pages;
 	}
 
 	memset(ret, 0, size);
@@ -317,6 +317,8 @@ void *dma_direct_alloc(struct device *dev, size_t size,
 out_free_pages:
 	__dma_direct_free_pages(dev, page, size);
 	return NULL;
+out_leak_pages:
+	return NULL;
 }
 
 void dma_direct_free(struct device *dev, size_t size,
@@ -379,12 +381,11 @@ struct page *dma_direct_alloc_pages(struct device *dev, size_t size,
 
 	ret = page_address(page);
 	if (dma_set_decrypted(dev, ret, size))
-		goto out_free_pages;
+		goto out_leak_pages;
 	memset(ret, 0, size);
 	*dma_handle = phys_to_dma_direct(dev, page_to_phys(page));
 	return page;
-out_free_pages:
-	__dma_direct_free_pages(dev, page, size);
+out_leak_pages:
 	return NULL;
 }
 
diff --git a/kernel/panic.c b/kernel/panic.c
index 63e94f3bd8dc..e6c2bf04a32c 100644
--- a/kernel/panic.c
+++ b/kernel/panic.c
@@ -441,6 +441,14 @@ void panic(const char *fmt, ...)
 
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
diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
index 431a922e5c89..d2947de3021a 100644
--- a/kernel/trace/ring_buffer.c
+++ b/kernel/trace/ring_buffer.c
@@ -4431,7 +4431,7 @@ int ring_buffer_iter_empty(struct ring_buffer_iter *iter)
 	cpu_buffer = iter->cpu_buffer;
 	reader = cpu_buffer->reader_page;
 	head_page = cpu_buffer->head_page;
-	commit_page = cpu_buffer->commit_page;
+	commit_page = READ_ONCE(cpu_buffer->commit_page);
 	commit_ts = commit_page->page->time_stamp;
 
 	/*
diff --git a/net/mpls/mpls_gso.c b/net/mpls/mpls_gso.c
index 1482259de9b5..40334d4d89de 100644
--- a/net/mpls/mpls_gso.c
+++ b/net/mpls/mpls_gso.c
@@ -26,6 +26,9 @@ static struct sk_buff *mpls_gso_segment(struct sk_buff *skb,
 	__be16 mpls_protocol;
 	unsigned int mpls_hlen;
 
+	if (!skb_inner_network_header_was_set(skb))
+		goto out;
+
 	skb_reset_network_header(skb);
 	mpls_hlen = skb_inner_network_header(skb) - skb_network_header(skb);
 	if (unlikely(!mpls_hlen || mpls_hlen % MPLS_HLEN))
diff --git a/net/netfilter/nf_tables_api.c b/net/netfilter/nf_tables_api.c
index 8d38cd504769..8152a69d8268 100644
--- a/net/netfilter/nf_tables_api.c
+++ b/net/netfilter/nf_tables_api.c
@@ -1192,6 +1192,24 @@ static void nf_tables_table_disable(struct net *net, struct nft_table *table)
 #define __NFT_TABLE_F_UPDATE		(__NFT_TABLE_F_WAS_DORMANT | \
 					 __NFT_TABLE_F_WAS_AWAKEN)
 
+static bool nft_table_pending_update(const struct nft_ctx *ctx)
+{
+	struct nftables_pernet *nft_net = nft_pernet(ctx->net);
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
@@ -1215,7 +1233,7 @@ static int nf_tables_updtable(struct nft_ctx *ctx)
 		return -EOPNOTSUPP;
 
 	/* No dormant off/on/off/on games in single transaction */
-	if (ctx->table->flags & __NFT_TABLE_F_UPDATE)
+	if (nft_table_pending_update(ctx))
 		return -EINVAL;
 
 	trans = nft_trans_alloc(ctx, NFT_MSG_NEWTABLE,
@@ -9902,10 +9920,11 @@ static int __nf_tables_abort(struct net *net, enum nfnl_abort_action action)
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
@@ -10076,12 +10095,7 @@ static int __nf_tables_abort(struct net *net, enum nfnl_abort_action action)
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
@@ -10095,6 +10109,16 @@ static int nf_tables_abort(struct net *net, struct sk_buff *skb,
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
@@ -10892,9 +10916,10 @@ static void __net_exit nf_tables_exit_net(struct net *net)
 
 	gc_seq = nft_gc_seq_begin(nft_net);
 
-	if (!list_empty(&nft_net->commit_list) ||
-	    !list_empty(&nft_net->module_list))
-		__nf_tables_abort(net, NFNL_ABORT_NONE);
+	WARN_ON_ONCE(!list_empty(&nft_net->commit_list));
+
+	if (!list_empty(&nft_net->module_list))
+		nf_tables_module_autoload_cleanup(net);
 
 	__nft_release_tables(net);
 
diff --git a/net/smc/smc_pnet.c b/net/smc/smc_pnet.c
index 25fb2fd186e2..21b8bf23e4ee 100644
--- a/net/smc/smc_pnet.c
+++ b/net/smc/smc_pnet.c
@@ -802,6 +802,16 @@ static void smc_pnet_create_pnetids_list(struct net *net)
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
diff --git a/scripts/gcc-plugins/stackleak_plugin.c b/scripts/gcc-plugins/stackleak_plugin.c
index c5c2ce113c92..d20c47d21ad8 100644
--- a/scripts/gcc-plugins/stackleak_plugin.c
+++ b/scripts/gcc-plugins/stackleak_plugin.c
@@ -467,6 +467,8 @@ static bool stackleak_gate(void)
 			return false;
 		if (STRING_EQUAL(section, ".entry.text"))
 			return false;
+		if (STRING_EQUAL(section, ".head.text"))
+			return false;
 	}
 
 	return track_frame_size >= 0;
diff --git a/sound/firewire/amdtp-stream.c b/sound/firewire/amdtp-stream.c
index f8b644cb9157..875312568369 100644
--- a/sound/firewire/amdtp-stream.c
+++ b/sound/firewire/amdtp-stream.c
@@ -771,10 +771,14 @@ static int check_cip_header(struct amdtp_stream *s, const __be32 *buf,
 	} else {
 		unsigned int dbc_interval;
 
-		if (*data_blocks > 0 && s->ctx_data.tx.dbc_interval > 0)
-			dbc_interval = s->ctx_data.tx.dbc_interval;
-		else
-			dbc_interval = *data_blocks;
+		if (!(s->flags & CIP_DBC_IS_PAYLOAD_QUADLETS)) {
+			if (*data_blocks > 0 && s->ctx_data.tx.dbc_interval > 0)
+				dbc_interval = s->ctx_data.tx.dbc_interval;
+			else
+				dbc_interval = *data_blocks;
+		} else {
+			dbc_interval = payload_length / sizeof(__be32);
+		}
 
 		lost = dbc != ((*data_block_counter + dbc_interval) & 0xff);
 	}
diff --git a/sound/firewire/amdtp-stream.h b/sound/firewire/amdtp-stream.h
index 1f957c946c95..cf9ab347277f 100644
--- a/sound/firewire/amdtp-stream.h
+++ b/sound/firewire/amdtp-stream.h
@@ -37,6 +37,9 @@
  *	the value of current SYT_INTERVAL; e.g. initial value is not zero.
  * @CIP_UNAWARE_SYT: For outgoing packet, the value in SYT field of CIP is 0xffff.
  *	For incoming packet, the value in SYT field of CIP is not handled.
+ * @CIP_DBC_IS_PAYLOAD_QUADLETS: Available for incoming packet, and only effective with
+ *	CIP_DBC_IS_END_EVENT flag. The value of dbc field is the number of accumulated quadlets
+ *	in CIP payload, instead of the number of accumulated data blocks.
  */
 enum cip_flags {
 	CIP_NONBLOCKING		= 0x00,
@@ -51,6 +54,7 @@ enum cip_flags {
 	CIP_NO_HEADER		= 0x100,
 	CIP_UNALIGHED_DBC	= 0x200,
 	CIP_UNAWARE_SYT		= 0x400,
+	CIP_DBC_IS_PAYLOAD_QUADLETS = 0x800,
 };
 
 /**
diff --git a/sound/soc/intel/boards/sof_sdw.c b/sound/soc/intel/boards/sof_sdw.c
index 985012f2003e..d1e6e4208c37 100644
--- a/sound/soc/intel/boards/sof_sdw.c
+++ b/sound/soc/intel/boards/sof_sdw.c
@@ -224,6 +224,17 @@ static const struct dmi_system_id sof_sdw_quirk_table[] = {
 					SOF_SDW_PCH_DMIC |
 					RT711_JD2_100K),
 	},
+	{
+		/* NUC15 LAPRC710 skews */
+		.callback = sof_sdw_quirk_cb,
+		.matches = {
+			DMI_MATCH(DMI_BOARD_VENDOR, "Intel Corporation"),
+			DMI_MATCH(DMI_BOARD_NAME, "LAPRC710"),
+		},
+		.driver_data = (void *)(SOF_SDW_TGL_HDMI |
+					SOF_SDW_PCH_DMIC |
+					RT711_JD2_100K),
+	},
 	/* TigerLake-SDCA devices */
 	{
 		.callback = sof_sdw_quirk_cb,
diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index a409fbed8f34..6a4101dc15a5 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -1020,6 +1020,9 @@ int snd_soc_add_pcm_runtime(struct snd_soc_card *card,
 			if (!snd_soc_is_matching_component(platform, component))
 				continue;
 
+			if (snd_soc_component_is_dummy(component) && component->num_dai)
+				continue;
+
 			snd_soc_rtd_add_component(rtd, component);
 		}
 	}
diff --git a/tools/iio/iio_utils.c b/tools/iio/iio_utils.c
index 6a00a6eecaef..c5c5082cb24e 100644
--- a/tools/iio/iio_utils.c
+++ b/tools/iio/iio_utils.c
@@ -376,7 +376,7 @@ int build_channel_array(const char *device_dir, int buffer_idx,
 		goto error_close_dir;
 	}
 
-	seekdir(dp, 0);
+	rewinddir(dp);
 	while (ent = readdir(dp), ent) {
 		if (strcmp(ent->d_name + strlen(ent->d_name) - strlen("_en"),
 			   "_en") == 0) {
diff --git a/tools/lib/perf/evlist.c b/tools/lib/perf/evlist.c
index 61b637f29b82..b871923c7e5c 100644
--- a/tools/lib/perf/evlist.c
+++ b/tools/lib/perf/evlist.c
@@ -233,10 +233,10 @@ u64 perf_evlist__read_format(struct perf_evlist *evlist)
 
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
@@ -254,21 +254,27 @@ void perf_evlist__reset_id_hash(struct perf_evlist *evlist)
 
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
@@ -297,7 +303,7 @@ int perf_evlist__id_add_fd(struct perf_evlist *evlist,
 	id = read_data[id_idx];
 
 add:
-	perf_evlist__id_add(evlist, evsel, cpu, thread, id);
+	perf_evlist__id_add(evlist, evsel, cpu_map_idx, thread, id);
 	return 0;
 }
 
diff --git a/tools/lib/perf/include/internal/evlist.h b/tools/lib/perf/include/internal/evlist.h
index 850f07070036..cf77db75291b 100644
--- a/tools/lib/perf/include/internal/evlist.h
+++ b/tools/lib/perf/include/internal/evlist.h
@@ -127,11 +127,11 @@ u64 perf_evlist__read_format(struct perf_evlist *evlist);
 
 void perf_evlist__id_add(struct perf_evlist *evlist,
 			 struct perf_evsel *evsel,
-			 int cpu, int thread, u64 id);
+			 int cpu_map_idx, int thread, u64 id);
 
 int perf_evlist__id_add_fd(struct perf_evlist *evlist,
 			   struct perf_evsel *evsel,
-			   int cpu, int thread, int fd);
+			   int cpu_map_idx, int thread, int fd);
 
 void perf_evlist__reset_id_hash(struct perf_evlist *evlist);
 
diff --git a/tools/power/x86/x86_energy_perf_policy/x86_energy_perf_policy.c b/tools/power/x86/x86_energy_perf_policy/x86_energy_perf_policy.c
index 5fd9e594079c..ebda9c366b2b 100644
--- a/tools/power/x86/x86_energy_perf_policy/x86_energy_perf_policy.c
+++ b/tools/power/x86/x86_energy_perf_policy/x86_energy_perf_policy.c
@@ -1241,6 +1241,7 @@ unsigned int get_pkg_num(int cpu)
 	retval = fscanf(fp, "%d\n", &pkg);
 	if (retval != 1)
 		errx(1, "%s: failed to parse", pathname);
+	fclose(fp);
 	return pkg;
 }
 
diff --git a/tools/testing/ktest/ktest.pl b/tools/testing/ktest/ktest.pl
index e6c381498e63..449e45bd6966 100755
--- a/tools/testing/ktest/ktest.pl
+++ b/tools/testing/ktest/ktest.pl
@@ -836,6 +836,7 @@ sub set_value {
     if ($lvalue =~ /^(TEST|BISECT|CONFIG_BISECT)_TYPE(\[.*\])?$/ &&
 	$prvalue !~ /^(config_|)bisect$/ &&
 	$prvalue !~ /^build$/ &&
+	$prvalue !~ /^make_warnings_file$/ &&
 	$buildonly) {
 
 	# Note if a test is something other than build, then we

