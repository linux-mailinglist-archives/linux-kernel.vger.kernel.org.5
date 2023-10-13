Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7DDA57C8084
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Oct 2023 10:39:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230228AbjJMIjJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Oct 2023 04:39:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230221AbjJMIjF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Oct 2023 04:39:05 -0400
Received: from m12.mail.163.com (m12.mail.163.com [220.181.12.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 75B0AA9;
        Fri, 13 Oct 2023 01:38:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=MDBOJ
        KfUuh4/VHlviBX0aVYr7w0hhC5DNatuWUc75DQ=; b=gVjozwGojhuqXRl8JGHdq
        STxPZQk+ul7tKee+bO38GKqQ2hEQWaDir4OcopTT+ufmsHSNBsKwOwR5iFypwHSn
        RIM/vuiYySNoBNh/ceWkEAj25Wpk78ioNUH8+b50PoUXyZMCmHgCp/XR4GD+wwNq
        h6gRwKYxP4LiO3R3gy/etw=
Received: from test-Z390-GAMING-X.bayhubtech.com (unknown [58.48.115.170])
        by zwqz-smtp-mta-g3-1 (Coremail) with SMTP id _____wDnDxgMASllSyO8AQ--.5797S2;
        Fri, 13 Oct 2023 16:34:20 +0800 (CST)
From:   liuchang_125125@163.com
To:     jejb@linux.ibm.com, martin.petersen@oracle.com,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     mark.tao@bayhubtech.com, shaper.liu@bayhubtech.com,
        thomas.hu@bayhubtech.com, chevron.li@bayhubtech.com,
        charl.liu@bayhubtech.com, Charl Liu <liuchang_125125@163.com>
Subject: [PATCH 6/9] scsi: bht: linux_os: Add the source files related to SCSI frame and driver entry
Date:   Fri, 13 Oct 2023 16:34:15 +0800
Message-Id: <20231013083415.10330-1-liuchang_125125@163.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: _____wDnDxgMASllSyO8AQ--.5797S2
X-Coremail-Antispam: 1Uf129KBjvAXoWkJFWfZFyxXr15AFyDCrWruFg_yoWDuryfGo
        WfZFsxtwn5JryUuw1vkr1xtFy7XrZa9FyYyr4rAr4kua1kArZ0gr9Fkw43Ga43Jr40grZr
        X3s7Ca4xtFZ8trn3n29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73VFW2AGmfu7bjvjm3
        AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvj4RiPEfDUUUU
X-Originating-IP: [58.48.115.170]
X-CM-SenderInfo: polxux5dqjsiqsvrjki6rwjhhfrp/xtbB0BIIWWEssyseLQAAs1
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Charl Liu <liuchang_125125@163.com>

1.linux_api: package system basic functions
2.linux_base: define device & pci initialization functions
3.linux_scsi: define related functions for adapting SCSI frame

Signed-off-by: Charl Liu <liuchang_125125@163.com>
---
Change in V1:
Add the source files related to SCSI frame and driver entry.
---
 drivers/scsi/bht/linux_os/linux_api.c  | 2207 ++++++++++++++++++++++++
 drivers/scsi/bht/linux_os/linux_api.h  |   90 +
 drivers/scsi/bht/linux_os/linux_base.c |  985 +++++++++++
 drivers/scsi/bht/linux_os/linux_scsi.c | 1076 ++++++++++++
 drivers/scsi/bht/linux_os/linux_scsi.h |  239 +++
 5 files changed, 4597 insertions(+)
 create mode 100644 drivers/scsi/bht/linux_os/linux_api.c
 create mode 100644 drivers/scsi/bht/linux_os/linux_api.h
 create mode 100644 drivers/scsi/bht/linux_os/linux_base.c
 create mode 100644 drivers/scsi/bht/linux_os/linux_scsi.c
 create mode 100644 drivers/scsi/bht/linux_os/linux_scsi.h

diff --git a/drivers/scsi/bht/linux_os/linux_api.c b/drivers/scsi/bht/linux_os/linux_api.c
new file mode 100644
index 000000000000..be7b44b641a3
--- /dev/null
+++ b/drivers/scsi/bht/linux_os/linux_api.c
@@ -0,0 +1,2207 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (c) 2014 BHT Inc.
+ *
+ * File Name: linux_api.c
+ *
+ * Abstract: Linux api definition
+ *
+ * Version: 1.00
+ *
+ * Author: Peter
+ *
+ * Environment:	Linux
+ *
+ * History:
+ *
+ * 5/20/2015		Creation	Peter.Guo
+ */
+
+#include <linux/version.h>
+#include "../include/basic.h"
+#include "../include/debug.h"
+#include "../include/util.h"
+#include "../include/funcapi.h"
+#include "../include/hostapi.h"
+#include "../include/hostvenapi.h"
+#include <linux/moduleparam.h>
+#include <linux/kthread.h>
+#include <linux/random.h>
+#include <scsi/scsi_device.h>
+#include "../linux_os/linux_scsi.h"
+#if BHT_LINUX_ENABLE_RTD3
+#include <linux/pm_runtime.h>
+#endif
+
+/* ----------linux Module param management---------- */
+
+/* This Flag is used to control emmc */
+static ulong m_emmc_mode;
+module_param(m_emmc_mode, ulong, 0444);
+
+/* Use to select dma mode, adma2 adma3 */
+static ulong m_dma_mode;
+module_param(m_dma_mode, ulong, 0444);
+
+/* use to enable or disable infinite transfer */
+static ulong m_infinite_ctrl = 0x8000000f;
+module_param(m_infinite_ctrl, ulong, 0444);
+
+/* use for tag queue capability */
+static ulong m_tag_cap;
+module_param(m_tag_cap, ulong, 0444);
+
+/* use for sdmode disable */
+static ulong m_sdmode_dis;
+module_param(m_sdmode_dis, ulong, 0444);
+
+/* use to disable mmc support */
+static ulong m_mmc_dis;
+module_param(m_mmc_dis, ulong, 0444);
+
+/* uhs2 range/half/low select */
+static ulong m_uhs2_ctrl = 0x97400012;
+module_param(m_uhs2_ctrl, ulong, 0444);
+
+/* output tuning control */
+static ulong m_output_tuning = 0x98030036;
+module_param(m_output_tuning, ulong, 0444);
+
+/* auto stop infinite control */
+static ulong m_auto_stopinf;
+module_param(m_auto_stopinf, ulong, 0444);
+
+/* auto poweroff card function */
+static ulong m_auto_poweroff;
+module_param(m_auto_poweroff, ulong, 0444);
+
+/* uhs2 auto go dormant/hbr function */
+static ulong m_auto_dmt;
+module_param(m_auto_dmt, ulong, 0444);
+
+/* Enable need set to 0x8004_0100 */
+static ulong m_psd_mode = 0x80000000;
+module_param(m_psd_mode, ulong, 0444);
+
+/* Enable need set to 0x8004_0100 */
+static ulong m_sw_sel_inject_sdr50 = 0x67f;
+module_param(m_sw_sel_inject_sdr50, ulong, 0444);
+
+static unsigned int pcr_setting_count;
+char *pcr_settings[MAX_PCR_SETTING_SIZE] = { 0 };
+
+module_param_array(pcr_settings, charp, &pcr_setting_count, 0444);
+MODULE_PARM_DESC(pcr_settings,
+		 "pcr_settings is a reg=value like string list split by comma");
+
+static unsigned int dmdn_setting_count;
+char *dmdn_settings[MAX_FREQ_SUPP] = { 0 };
+
+module_param_array(dmdn_settings, charp, &dmdn_setting_count, 0444);
+MODULE_PARM_DESC(dmdn_settings,
+		 "dmdn_settings is a reg=value like string list split by comma");
+
+uint m_sd_3v3_clk_driver_strength = 2;
+module_param(m_sd_3v3_clk_driver_strength, uint, 0444);
+
+uint m_sd_3v3_cmddata_driver_strength = 2;
+module_param(m_sd_3v3_cmddata_driver_strength, uint, 0444);
+
+uint m_sd_1v8_clk_driver_strength = 2;
+module_param(m_sd_1v8_clk_driver_strength, uint, 0444);
+
+uint m_sd_1v8_cmddata_driver_strength = 1;
+module_param(m_sd_1v8_cmddata_driver_strength, uint, 0444);
+
+uint m_cnfg_drv;
+module_param(m_cnfg_drv, uint, 0444);
+
+uint m_cnfg_trm_code_tx = 8;
+module_param(m_cnfg_trm_code_tx, uint, 0444);
+
+uint m_cnfg_trm_code_rx = 7;
+module_param(m_cnfg_trm_code_rx, uint, 0444);
+
+uint m_cnfg_rint_code = 9;
+module_param(m_cnfg_rint_code, uint, 0444);
+
+uint m_ram_ema = 0x42492000;
+module_param(m_ram_ema, uint, 0444);
+
+uint m_vdd1_vdd2_source;
+module_param(m_vdd1_vdd2_source, uint, 0444);
+
+uint m_vdd18_debounce_time = 1;
+module_param(m_vdd18_debounce_time, uint, 0444);
+
+uint m_ssc_enable;
+module_param(m_ssc_enable, uint, 0444);
+
+static ulong m_driver_item = 0x8080000a;
+module_param(m_driver_item, ulong, 0444);
+
+/* sd7_sd_mode_switch_control, 300: camera, 100: pc */
+static ulong m_sd7_sdmode_switch_control = 0x00000300;
+module_param(m_sd7_sdmode_switch_control, ulong, 0444);
+
+/* mmc_mode_dis */
+static ulong m_mmc_mode_dis = 0x80000000;
+module_param(m_mmc_mode_dis, ulong, 0444);
+
+/* pcie_wake_setting */
+static ulong m_pcie_wake_setting;
+module_param(m_pcie_wake_setting, ulong, 0444);
+
+/* sd_card_mode_dis */
+static ulong m_sd_card_mode_dis = 0x80000021;
+module_param(m_sd_card_mode_dis, ulong, 0444);
+
+/* vdd_power_source_item */
+static ulong m_vdd_power_source_item = 0x00090a0c;
+module_param(m_vdd_power_source_item, ulong, 0444);
+
+/* hsmux_vcme_enable */
+static ulong m_hsmux_vcme_enable;
+module_param(m_hsmux_vcme_enable, ulong, 0444);
+
+/* test_max_access_mode */
+static ulong m_test_max_access_mode = 0x80000005;
+module_param(m_test_max_access_mode, ulong, 0444);
+
+/* host_drive_strength */
+static ulong m_host_drive_strength = 0x80001125;
+module_param(m_host_drive_strength, ulong, 0444);
+
+/* auto_detect_refclk_counter_range_ctl */
+static ulong m_auto_detect_refclk_counter_range_ctl = 0x80640000;
+module_param(m_auto_detect_refclk_counter_range_ctl, ulong, 0444);
+
+/* refclk_stable_detection_counter1 */
+static ulong m_refclk_stable_detection_counter1 = 0x00000003;
+module_param(m_refclk_stable_detection_counter1, ulong, 0444);
+
+static ulong m_refclk_stable_detection_counter2 = 0x001e044c;
+module_param(m_refclk_stable_detection_counter2, ulong, 0444);
+
+static ulong m_refclk_stable_detection_counter3 = 0x04b024b0;
+module_param(m_refclk_stable_detection_counter3, ulong, 0444);
+
+static ulong m_l1_enter_exit_logic_ctl;
+module_param(m_l1_enter_exit_logic_ctl, ulong, 0444);
+
+/* pcie_phy_amplitude_adjust */
+static ulong m_pcie_phy_amplitude_adjust = 0x0000006a;
+module_param(m_pcie_phy_amplitude_adjust, ulong, 0444);
+
+static ulong m_output_tuning_item = 0xc01837bb;
+module_param(m_output_tuning_item, ulong, 0444);
+
+static ulong m_test_driver_strength_sel;
+module_param(m_test_driver_strength_sel, ulong, 0444);
+
+static ulong m_test_max_power_limit = 0x80000003;
+module_param(m_test_max_power_limit, ulong, 0444);
+
+static ulong m_test_uhs2_setting2 = 0x80000006;
+module_param(m_test_uhs2_setting2, ulong, 0444);
+
+static ulong m_test_sdma_boundary = 0x00000020;
+module_param(m_test_sdma_boundary, ulong, 0444);
+
+static ulong m_test_dma_mode_setting = 0x80000071;
+module_param(m_test_dma_mode_setting, ulong, 0444);
+
+static ulong m_test_ocb_ctrl;
+module_param(m_test_ocb_ctrl, ulong, 0444);
+
+static ulong m_bios_l1_substate = 0x8000000f;
+module_param(m_bios_l1_substate, ulong, 0444);
+
+static ulong m_test_main_ldo_setting;
+module_param(m_test_main_ldo_setting, ulong, 0444);
+
+static ulong m_auto_sleep_control;
+module_param(m_auto_sleep_control, ulong, 0444);
+
+static ulong m_power_wait_time = 0x0024000a;
+module_param(m_power_wait_time, ulong, 0444);
+
+static ulong m_test_write_data_timeout = 0x80001770;
+module_param(m_test_write_data_timeout, ulong, 0444);
+
+static ulong m_test_read_data_timeout = 0x80001770;
+module_param(m_test_read_data_timeout, ulong, 0444);
+
+static ulong m_test_non_data_timeout = 0x800003e8;
+module_param(m_test_non_data_timeout, ulong, 0444);
+
+static ulong m_test_r1b_data_timeout = 0x80001194;
+module_param(m_test_r1b_data_timeout, ulong, 0444);
+
+static ulong m_test_card_init_timeout = 0x800005dc;
+module_param(m_test_card_init_timeout, ulong, 0444);
+
+extern cfg_item_t g_cfg[SUPPORT_CHIP_COUNT][2];
+
+struct kmem_cache *srb_ext_cachep;
+
+/*
+ *  SD Spec Standard Memory register access
+ */
+
+u32 sdhci_readl(sd_host_t *host, u16 offset)
+{
+	u32 regval = 0;
+
+	regval = readl(host->pci_dev.membase + offset);
+	DbgInfo(MODULE_SD_HOST, FEATURE_SDREG_TRACER, NOT_TO_RAM,
+		"%s(0x%08X): 0x%08X\n", __func__, offset, regval);
+
+	return regval;
+}
+
+void sdhci_writel(sd_host_t *host, u16 offset, u32 value)
+{
+	DbgInfo(MODULE_SD_HOST, FEATURE_SDREG_TRACEW, NOT_TO_RAM,
+		"%s(0x%08X): 0x%08X\n", __func__, offset, value);
+	writel(value, host->pci_dev.membase + offset);
+}
+
+void sdhci_or32(sd_host_t *host, u16 offset, u32 value)
+{
+	u32 regval = 0;
+
+	regval = sdhci_readl(host, offset);
+	regval |= value;
+	sdhci_writel(host, offset, regval);
+}
+
+void sdhci_and32(sd_host_t *host, u16 offset, u32 value)
+{
+	u32 regval = 0;
+
+	regval = sdhci_readl(host, offset);
+	regval &= (value);
+	sdhci_writel(host, offset, regval);
+
+}
+
+void sdhci_writew(sd_host_t *host, u16 offset, u16 value)
+{
+	writew(value, host->pci_dev.membase + offset);
+	DbgInfo(MODULE_SD_HOST, FEATURE_SDREG_TRACEW, NOT_TO_RAM,
+		"%s(0x%04X): 0x%08X\n", __func__, offset, value);
+
+}
+
+u16 sdhci_readw(sd_host_t *host, u16 offset)
+{
+	u16 regval = 0;
+
+	regval = readw(host->pci_dev.membase + offset);
+	DbgInfo(MODULE_SD_HOST, FEATURE_SDREG_TRACER, NOT_TO_RAM,
+		"%s(0x%04X): 0x%08X\n", __func__, offset, regval);
+
+	return regval;
+}
+
+void sdhci_or16(sd_host_t *host, u16 offset, u16 value)
+{
+	u16 regval = 0;
+
+	regval = sdhci_readw(host, offset);
+	regval |= value;
+	sdhci_writew(host, offset, regval);
+}
+
+void sdhci_and16(sd_host_t *host, u16 offset, u16 value)
+{
+	u16 regval = 0;
+
+	regval = sdhci_readw(host, offset);
+	regval &= value;
+	sdhci_writew(host, offset, regval);
+}
+
+/*
+ *  Vendor Memory register access
+ */
+
+/* 16bit access */
+u16 ven_readw(sd_host_t *host, u16 offset)
+{
+	u16 regval = 0;
+
+	regval = readw(host->pci_dev.membase2 + offset);
+
+	DbgInfo(MODULE_SD_HOST, FEATURE_VENREG_TRACER, NOT_TO_RAM,
+		"[Memory Base 2]  Readw(0x%08X): 0x%08X\n", offset, regval);
+	return regval;
+}
+
+void ven_writew(sd_host_t *host, u16 offset, u16 value)
+{
+
+	writew(value, host->pci_dev.membase2 + offset);
+	DbgInfo(MODULE_SD_HOST, FEATURE_VENREG_TRACEW, NOT_TO_RAM,
+		"[Memory Base 2] Writew(0x%08X): 0x%08X\n", offset, value);
+
+}
+
+void ven_or16(sd_host_t *host, u16 offset, u16 value)
+{
+	u16 regval = 0;
+
+	regval = ven_readw(host, offset);
+	regval |= value;
+	ven_writew(host, offset, regval);
+}
+
+void ven_and16(sd_host_t *host, u16 offset, u16 value)
+{
+	u16 regval = 0;
+
+	regval = ven_readw(host, offset);
+	regval &= (value);
+	ven_writew(host, offset, regval);
+}
+
+/* 32bit access */
+u32 ven_readl(sd_host_t *host, u16 offset)
+{
+	u32 regval = 0;
+
+	regval = readl(host->pci_dev.membase2 + offset);
+
+	DbgInfo(MODULE_SD_HOST, FEATURE_VENREG_TRACER, NOT_TO_RAM,
+		"[Memory Base 2]  Readl(0x%08X): 0x%08X\n", offset, regval);
+	return regval;
+}
+
+void ven_writel(sd_host_t *host, u16 offset, u32 value)
+{
+
+	writel(value, host->pci_dev.membase2 + offset);
+
+	DbgInfo(MODULE_SD_HOST, FEATURE_VENREG_TRACEW, NOT_TO_RAM,
+		"[Memory Base 2] Writel(0x%08X): 0x%08X\n", offset, value);
+
+}
+
+void ven_or32(sd_host_t *host, u16 offset, u32 value)
+{
+	u32 regval = 0;
+
+	regval = ven_readl(host, offset);
+	regval |= value;
+	ven_writel(host, offset, regval);
+
+}
+
+void ven_and32(sd_host_t *host, u16 offset, u32 value)
+{
+	u32 regval = 0;
+
+	regval = ven_readl(host, offset);
+	regval &= (value);
+	ven_writel(host, offset, regval);
+
+}
+
+/*
+ *  PCI config register accessing
+ */
+void pci_port_writel(sd_host_t *host, u32 port, u32 data)
+{
+
+	pci_write_config_dword(host->pci_dev.pci_dev, port, data);
+
+	DbgInfo(MODULE_SD_HOST, FEATURE_PCIREG_TRACEW, NOT_TO_RAM,
+		"%s(0x%08X): 0x%08X\n", __func__, port, data);
+
+}
+
+u32 pci_port_readl(sd_host_t *host, u32 port)
+{
+	u32 regval = 0;
+
+	pci_read_config_dword(host->pci_dev.pci_dev, port, &regval);
+
+	DbgInfo(MODULE_SD_HOST, FEATURE_PCIREG_TRACER, NOT_TO_RAM,
+		"%s(0x%08X): 0x%08X\n", __func__, port, regval);
+
+	return regval;
+}
+
+/*
+ *  PCI config register accessing by configuration IO method
+ */
+void pci_cfgio_writel(sd_host_t *host, u16 offset, u32 value)
+{
+	pci_write_config_dword(host->pci_dev.pci_dev, offset, value);
+}
+
+u32 pci_cfgio_readl(sd_host_t *host, u16 offset)
+{
+	u32 regval = 0;
+
+	pci_read_config_dword(host->pci_dev.pci_dev, offset, &regval);
+	DbgInfo(MODULE_SD_HOST, FEATURE_PCIREG_TRACER, NOT_TO_RAM,
+		"%s(0x%08X): 0x%08X\n", __func__, offset, regval);
+
+	return regval;
+}
+
+/*
+ *
+ * Function Name: timer_auto_cb
+ *
+ * Abstract:
+ *
+ *			for timer callback
+ *
+ * Input:
+ *
+ *			PVOID	pctx [in]: Pointer to  pdx
+ *
+ * Output:
+ *
+ *			None
+ *
+ * Return value:
+ *
+ *			null
+ *
+ * Notes:
+ *
+ *           Caller: OS
+ */
+#if LINUX_VERSION_CODE >= KERNEL_VERSION(4, 15, 0)
+void timer_auto_cb2(struct timer_list *t)
+{
+	os_struct *o = from_timer(o, t, timer);
+	bht_dev_ext_t *pdx = container_of(o, bht_dev_ext_t, os);
+
+	func_timer_callback(pdx);
+}
+#else
+void timer_auto_cb2(PVOID pdx)
+{
+	func_timer_callback(pdx);
+}
+#endif
+
+/*
+ *
+ * Function Name: timer_subid_cb
+ *
+ * Abstract:
+ *
+ *			  for timer callback
+ *
+ * Input:
+ *
+ *			PVOID	pctx [in]: Pointer to  pdx
+ *
+ * Output:
+ *
+ *			None
+ *
+ * Return value:
+ *
+ *			null
+ *
+ * Notes:
+ *
+ *           Caller: OS
+ */
+
+void timer_subid_cb(PVOID ctx, PVOID pdx)
+{
+	/* todo */
+}
+
+/*
+ * Function Name: os_start_timer
+ * Abstract: This Function is used to start a timer
+ *
+ * Input:
+ *			os_struct *os,
+ *			e_timer_t t timer id
+ *			u32 time_ms
+ *
+ *
+ *
+ * IRQL: any
+ *
+ *        so giving the routine another name requires you to modify the build tools.
+ */
+
+void os_start_timer(void *p, os_struct *os, e_timer_t t, u32 time_ms)
+{
+	if (t >= MAX_TIMER_NUM)
+		return;
+
+	if ((u32) t != 0) {
+		DbgErr("Timer %d not support now\n", t);
+		return;
+	}
+
+	mod_timer(&os->timer, jiffies + msecs_to_jiffies(time_ms));
+}
+
+/*
+ * Function Name: os_cancel_timer
+ * Abstract: This Function is used to start a timer
+ *
+ * Input:
+ *			os_struct *os,
+ *			e_timer_t t timer id
+ *			u32 time_ms
+ *
+ *
+ * IRQL:any
+ *
+ *        so giving the routine another name requires you to modify the build tools.
+ */
+void os_cancel_timer(void *p, os_struct *os, e_timer_t t)
+{
+
+	if (t >= MAX_TIMER_NUM)
+		return;
+
+	del_timer(&os->timer);
+
+}
+
+void os_stop_timer(void *p, os_struct *os, e_timer_t t)
+{
+
+	if (t >= MAX_TIMER_NUM)
+		return;
+}
+
+/*
+ *
+ * Function Name:  os_set_event
+ *
+ * Abstract:
+ *
+ *			 1. set event to thread
+ *
+ * Input:
+ *
+ *			os_struct *os [in]: pointer to the OS structure
+ *			e_event_t event [in]: the event need set
+ *
+ * Output:
+ *
+ *			None
+ *
+ * Return value:
+ *
+ *			None
+ *
+ * IRQL:any
+ *
+ *
+ */
+
+void os_set_event(os_struct *os, e_event_t event)
+{
+	spin_lock(&os->event.lock);
+
+	set_bit((int)event, &os->event.evt_flag);
+
+	atomic_set(&os->event.evt_comming, 1);
+
+	spin_unlock(&os->event.lock);
+
+	wake_up_interruptible(&os->event.evt_control);
+}
+
+/*
+ *
+ * Function Name:  os_clear_event
+ *
+ * Abstract:
+ *
+ *			 1. clear event to thread
+ *
+ * Input:
+ *
+ *			os_struct *os [in]: pointer to the OS structure
+ *			e_event_t event [in]: the event need send
+ *
+ * Output:
+ *
+ *			None
+ *
+ * Return value:
+ *
+ *			None
+ *
+ *
+ *
+ */
+
+void os_clear_event(os_struct *os, e_event_t event)
+{
+	/* nothing to do as event is auto cleared  by os_wait_event */
+}
+
+/*
+ *
+ * Function Name:  os_wait_event
+ *
+ * Abstract:
+ *
+ *			 1. wait any one signaled event of  multiple events
+ *
+ * Input:
+ *
+ *			os_struct *os [in]: pointer to the OS structure
+ *			s32 timeout [in]: timeout value
+ *
+ * Output:
+ *
+ *			None
+ *
+ * Return value:
+ *
+ *			None
+ *
+ *
+ *
+ */
+e_event_t os_wait_event(os_struct *os)
+{
+	e_event_t event = EVENT_NONE;
+	int i;
+
+	if (atomic_read(&os->event.evt_comming))
+		goto next;
+
+	wait_event_interruptible(os->event.evt_control,
+				 ((atomic_read(&os->event.evt_comming) != 0)
+				  || (kthread_should_stop())));
+
+next:
+	if (kthread_should_stop()) {
+		event = EVENT_TERMINATE;
+		clear_bit(event, &os->event.evt_flag);
+		atomic_set(&os->event.evt_comming, 0);
+		goto exit;
+	}
+
+	if (atomic_read(&os->event.evt_comming) == 0)
+		goto exit;
+
+	spin_lock(&(os->event.lock));
+
+	for (i = 0; i < EVENT_NONE; i++) {
+		if (test_bit(i, &os->event.evt_flag)) {
+			event = i;
+			clear_bit(i, &os->event.evt_flag);
+			break;
+		}
+	}
+
+	if (os->event.evt_flag == 0)
+		atomic_set(&os->event.evt_comming, 0);
+
+	spin_unlock(&(os->event.lock));
+
+exit:
+	return event;
+
+}
+
+/*
+ *
+ * Function Name:  os_create_thread
+ *
+ * Abstract:
+ *
+ *			 1. create thread
+ *
+ * Input:
+ *
+ *			thread_t *[in]: pointer to the thread entry
+ *			void *param, [in]:  the parameter which pass to thread entity
+ *			thread_cb_t func [in]: the entry of thread enity
+ *
+ * Output:
+ *
+ *			None
+ *
+ * Return value:
+ *
+ *			TRUE: create ok
+ *			FALSE: create failed
+ *
+ *
+ *
+ */
+bool os_create_thread(thread_t *thr, void *param, thread_cb_t func)
+{
+
+	thr->pthread =
+	    kthread_run((void *)func, (PVOID) param, "bhtsd_scsi_thread");
+	if (thr->pthread == NULL)
+		return FALSE;
+	return TRUE;
+}
+
+/*
+ *
+ * Function Name:  os_stop_thread
+ *
+ * Abstract:
+ *
+ *			 1. stop the thread
+ *
+ * Input:
+ *
+ *			thread_t *[in]: pointer to the thread entry
+ *
+ * Output:
+ *
+ *			None
+ *
+ * Return value:
+ *
+ *			TRUE: stop ok
+ *			FALSE:stop failed
+ *
+ *
+ *
+ */
+bool os_stop_thread(os_struct *os, thread_t *thr)
+{
+	bool ret = FALSE;
+	int i = 0;
+
+	DbgInfo(MODULE_OS_API, FEATURE_THREAD_TRACE, NOT_TO_RAM, "Enter %s\n",
+		__func__);
+
+	if (thr != NULL && thr->pthread != NULL && os != NULL) {
+		os->thread.freeze = TRUE;
+		os_set_event(os, EVENT_TERMINATE);
+		kthread_stop(os->thread.pthread);
+		while (test_bit(EVENT_TERMINATE, &os->event.evt_flag)) {
+			os_mdelay(20);
+			i++;
+			if (i > 150)
+				goto exit;
+		}
+
+		ret = TRUE;
+	}
+exit:
+	DbgInfo(MODULE_OS_API, FEATURE_THREAD_TRACE, NOT_TO_RAM,
+		"Exit %s  ret=%xh\n", __func__, ret);
+	return ret;
+}
+
+void os_kill_thread(os_struct *os, thread_t *thr)
+{
+}
+
+bool os_thread_is_freeze(void *pdx)
+{
+	os_struct *os = &((bht_dev_ext_t *) pdx)->os;
+
+	if (os->thread.freeze || os->thread.pthread == NULL)
+		return TRUE;
+	else
+		return FALSE;
+}
+
+/*
+ *
+ * Function Name:  os_pending_thread
+ *
+ * Abstract:
+ *
+ *			 pending thread or resume thread
+ *
+ *
+ * Input:
+ *
+ *			thread_t *[in]: pointer to the thread entry
+ *			bool pending [in]: TRUE means pending thread
+ *
+ * Output:
+ *
+ *			None
+ *
+ * Return value:
+ *
+ *			TRUE: operate ok
+ *			FALSE:operate failed
+ *
+ * IRQL:ANY
+ *
+ *
+ */
+bool os_pending_thread(void *pdx, bool pending)
+{
+	os_struct *os = &((bht_dev_ext_t *) pdx)->os;
+	u32 i = 600;
+	bool ret = TRUE;
+
+	DbgInfo(MODULE_OS_API, FEATURE_THREAD_TRACE, NOT_TO_RAM, "Enter %s\n",
+		__func__);
+	if (os->thread.pthread == NULL) {
+		DbgErr("thread obj null\n");
+		return FALSE;
+	}
+
+	os->thread.pending_lock = FALSE;
+	if (pending == TRUE) {
+		ret = FALSE;
+		os_init_completion(pdx, &os->thread.break_pending);
+		os->thread.freeze = TRUE;
+		os_set_event(os, EVENT_PENDING);
+		while (i--) {
+			if (os->thread.pending_lock == TRUE) {
+				ret = TRUE;
+				break;
+			}
+			os_mdelay(20);
+		}
+
+	} else {
+		os_finish_completion(pdx, &os->thread.break_pending);
+		os->thread.freeze = FALSE;
+
+	}
+
+	if (ret == FALSE)
+		DbgErr("%s timeout\n", __func__);
+	DbgInfo(MODULE_OS_API, FEATURE_THREAD_TRACE, NOT_TO_RAM,
+		"Exit %s  ret=%xh\n", __func__, ret);
+	return ret;
+}
+
+/*
+ * completion API
+ */
+
+/*
+ *
+ * Function Name:  os_init_completion
+ *
+ * Abstract:
+ *
+ *			 1.init the completion.
+ *
+ * Input:
+ *
+ *			completion_t *p[in]: pointer to completion
+ *
+ * Output:
+ *
+ *			None
+ *
+ * Return value:
+ *
+ *
+ * IRQL:any
+ *
+ *
+ */
+
+void os_init_completion(void *pdx, completion_t *p)
+{
+	init_completion(p);
+}
+
+/*
+ *
+ * Function Name: os_finish_completion
+ *
+ * Abstract:
+ *
+ *			 1.wake the thread which wait for this completion.
+ *
+ * Input:
+ *
+ *			completion_t *p[in]: pointer to completion
+ *
+ * Output:
+ *
+ *			None
+ *
+ * Return value:
+ *
+ *
+ * Notes:
+ *
+ *
+ */
+void os_finish_completion(void *pdx, completion_t *p)
+{
+	complete(p);
+}
+
+/*
+ *
+ * Function Name: os_finish_completion
+ *
+ * Abstract:
+ *
+ *			 1.wake the thread which wait for this completion.
+ *
+ * Input:
+ *
+ *			completion_t *p[in]: pointer to completion
+ *			s32 timeout [in]: unit ms .if timeout =0,
+ *			mean wait for signal until it completed
+ *
+ * Output:
+ *
+ *			None
+ *
+ * Return value:
+ *
+ *
+ * Notes:
+ *
+ *
+ */
+
+bool os_wait_for_completion(void *pdx, completion_t *p, s32 timeout)
+{
+	s32 ret = wait_for_completion_timeout(p, msecs_to_jiffies(timeout));
+
+	if (ret == 0)
+		return FALSE;
+	else
+		return TRUE;
+}
+
+/*
+ *
+ * Function Name:os_list_locked_remove_head
+ *
+ * Abstract:
+ *
+ *     remove the list_entry to list head node
+ *
+ * Input:
+ *
+ *   list_t *p [in]: pointer to list
+ *
+ * Output:
+ *
+ *    None
+ *
+ * Return value:
+ *
+ *
+ * IRQL:ANY
+ *
+ *
+ */
+list_entry *os_list_locked_remove_head(list_t *p)
+{
+	unsigned long flags;
+	list_entry *entry = NULL;
+
+	spin_lock_irqsave(&p->lock, flags);
+
+	if (list_empty(&p->list_hd))
+		goto exit;
+
+	entry = p->list_hd.next;
+	list_del_init(entry);
+
+exit:
+	spin_unlock_irqrestore(&p->lock, flags);
+	/* need with verify with chuanjing */
+	return entry;
+}
+
+/*
+ *
+ * Function Name: os_list_locked_insert_tail
+ *
+ * Abstract:
+ *
+ *     insert the list etry to list tail
+ *
+ * Input:
+ *
+ *   list_t *p [in]: pointer to list
+ *
+ * Output:
+ *
+ *    None
+ *
+ * Return value:
+ *
+ *
+ * Notes:
+ *
+ *
+ */
+void os_list_locked_insert_tail(list_t *p, list_entry *entry)
+{
+	unsigned long flags;
+
+	spin_lock_irqsave(&p->lock, flags);
+
+	list_add_tail(entry, &p->list_hd);
+
+	spin_unlock_irqrestore(&p->lock, flags);
+}
+
+/*
+ *
+ * Function Name: os_list_locked_insert_head
+ *
+ * Abstract:
+ *
+ *     insert the node to list head
+ *
+ * Input:
+ *
+ *   list_t *p [in]: pointer to list
+ *
+ * Output:
+ *
+ *    None
+ *
+ * Return value:
+ *
+ *
+ * Notes:
+ *
+ *
+ */
+void os_list_locked_insert_head(list_t *p, list_entry *entry)
+{
+	unsigned long flags;
+
+	spin_lock_irqsave(&p->lock, flags);
+
+	list_add(entry, &p->list_hd);
+
+	spin_unlock_irqrestore(&p->lock, flags);
+
+}
+
+/*
+ *
+ * Function Name: os_list_init
+ *
+ * Abstract:
+ *
+ *			  init the list with lock
+ *
+ * Input:
+ *
+ *			list_t *p [in]: pointer to list
+ *
+ * Output:
+ *
+ *			 None
+ *
+ * Return value:
+ *
+ *
+ * Notes:
+ *
+ *
+ */
+void os_list_init(list_t *p)
+{
+	p->lock = __SPIN_LOCK_UNLOCKED(p->lock);
+	INIT_LIST_HEAD(&p->list_hd);
+	os_atomic_set(&p->cnt, 0);
+
+}
+
+/*
+ *
+ * Function Name:  os_layer_init
+ *
+ * Abstract:
+ *
+ *			 1.init the os layer.
+ *
+ * Input:
+ *
+ *			os_struct *os [in]: pointer to os structure
+ *
+ * Output:
+ *
+ *			None
+ *
+ * Return value:
+ *
+ *
+ * irql:any
+ *
+ *
+ */
+#if LINUX_VERSION_CODE >= KERNEL_VERSION(4, 15, 0)
+typedef void (*func_timer)(struct timer_list *);
+#else
+typedef void (*func_timer)(unsigned long);
+#endif
+
+bool os_layer_init(void *p, os_struct *os)
+{
+
+#if LINUX_VERSION_CODE >= KERNEL_VERSION(4, 15, 0)
+	timer_setup(&os->timer, timer_auto_cb2, 0);
+#else
+	init_timer(&os->timer);
+	os->timer.data = (unsigned long)pdx;
+	os->timer.function = (func_timer) timer_auto_cb2;
+#endif
+	os->lock = __SPIN_LOCK_UNLOCKED(os->lock);
+
+	atomic_set(&os->event.evt_comming, 0);
+	init_waitqueue_head(&os->event.evt_control);
+	os->rt_pm_cnt = 0;
+	os->event.evt_flag = 0;
+	os->dma_mapped = 0;
+	os->virt_buff = vmalloc(CFG_MAX_TRANSFER_LENGTH);
+
+	if (os->virt_buff == NULL) {
+		DbgErr("Vmalloc failed for %d length\n",
+		       CFG_MAX_TRANSFER_LENGTH);
+	}
+
+	DbgInfo(MODULE_OS_API, FEATURE_DRIVER_INIT, NOT_TO_RAM, "Exit %s\n",
+		__func__);
+	return TRUE;
+}
+
+/*
+ *
+ * Function Name:  os_layer_uinit
+ *
+ * Abstract:
+ *
+ *			 1.uninit the os layer
+ *
+ * Input:
+ *
+ *			os_struct *os [in]: pointer to os structure
+ *
+ * Output:
+ *
+ *			None
+ *
+ * Return value:
+ *
+ *
+ * Notes:
+ *
+ *
+ */
+bool os_layer_uinit(void *pdx, os_struct *os)
+{
+	DbgInfo(MODULE_OS_API, FEATURE_DRIVER_INIT, NOT_TO_RAM, "Enter %s\n",
+		__func__);
+
+	os_cancel_timer(pdx, os, (e_timer_t) 0);
+	if (os->virt_buff != NULL)
+		vfree(os->virt_buff);
+
+	return TRUE;
+}
+
+/*
+ *
+ * Function Name:  os_alloc_dma_buffer
+ *
+ * Abstract:
+ *
+ *			 1. allocate DMA buffer resource
+ *
+ * Input:
+ *
+ *			bht_dev_ext_t *pdx [in]: pointer to device extension
+ *			PPORT_CONFIGURATION_INFORMATION ConfigInfo [in]:
+ *				pointer to config information
+ *			u32 nbytes [in]: the size allocate
+ *			dma_desc_buf_t *pdma [in]: pointer to the DMA information,
+ *				include physical address & virtual address
+ *
+ * Output:
+ *
+ *			dma_desc_buf_t *pdma [out]: pointer to the DMA information,
+ *				include physical address & virtual address
+ *
+ * Return value:
+ *
+ *
+ * Notes:
+ *
+ *
+ */
+bool os_alloc_dma_buffer(void *p, void *ctx, u32 nbytes, dma_desc_buf_t *pdma)
+{
+#define DMA_BUF_ALIGN_SIZE (1<<12)
+	u32 retry = 0;
+	bht_dev_ext_t *pdx = p;
+
+	if (pdma->len < DMA_BUF_ALIGN_SIZE)
+		pdma->len = DMA_BUF_ALIGN_SIZE;
+
+	pdma->len = nbytes;
+	DbgInfo(MODULE_OS_API, FEATURE_DRIVER_INIT, NOT_TO_RAM,
+		"Enter %s size=%xh\n", __func__, nbytes);
+
+	for (retry = 1; retry < 10; retry++) {
+		pdma->pa = 0;
+		pdma->va =
+		    (void *)dmam_alloc_coherent(&pdx->host.pci_dev.pci_dev->dev,
+						pdma->len,
+						(dma_addr_t *) (&pdma->pa),
+						GFP_KERNEL);
+
+		if (pdma->va == NULL) {
+			DbgInfo(MODULE_OS_API, FEATURE_DRIVER_INIT, 0,
+				"os alloc dma buffer failed!!!,retry %d\n",
+				retry);
+		} else {
+			pdx->os.dma_info = *pdma;
+			break;
+		}
+	}
+	if (pdma->va == NULL) {
+		memset(&pdx->os.dma_info, 0, sizeof(dma_desc_buf_t));
+		DbgErr("dmam_alloc_coherent(%xh) failed!!!\n", pdma->len);
+		return FALSE;
+	} else {
+		DbgInfo(MODULE_OS_API, FEATURE_DRIVER_INIT, 0,
+			"GetUncachedExtension return OK with length 0x%x\n",
+			pdma->len);
+		DbgInfo(MODULE_OS_API, FEATURE_DRIVER_INIT, 0,
+			" - Before alignment, DMA buffer physical address =h[%x] l[%X]\n",
+			os_get_phy_addr32h(pdma->pa),
+			os_get_phy_addr32l(pdma->pa));
+		DbgInfo(MODULE_OS_API, FEATURE_DRIVER_INIT, 0,
+			" - Before alignment, DMA buffer virtual address = 0x%Xh\n",
+			pdma->va);
+	}
+	DbgInfo(MODULE_OS_API, FEATURE_DRIVER_INIT, NOT_TO_RAM, "Exit %s\n",
+		__func__);
+
+	return TRUE;
+}
+
+/*
+ *
+ * Function Name: os_free_dma_buffer
+ *
+ * Abstract:
+ *
+ *			 1. free DMA buffer resource
+ *
+ * Input:
+ *
+ *			bht_dev_ext_t *pdx [in]: pointer to device extension
+ *			dma_desc_buf_t *pdma [in]: pointer to the DMA information,
+ *				include physical address & virtual address
+ *
+ * Output:
+ *
+ *
+ *
+ * Return value:
+ *
+ *
+ * Notes:
+ */
+bool os_free_dma_buffer(void *p, dma_desc_buf_t *dma)
+{
+	bht_dev_ext_t *pdx = p;
+	dma_desc_buf_t *pdma = &pdx->os.dma_info;
+
+	DbgInfo(MODULE_OS_API, FEATURE_DRIVER_INIT, NOT_TO_RAM, "Enter %s\n",
+		__func__);
+
+	if (pdma->len == 0)
+		goto exit;
+
+	dmam_free_coherent(&pdx->host.pci_dev.pci_dev->dev, pdma->len, pdma->va,
+			   (dma_addr_t) pdma->pa);
+	pdma->pa = 0;
+	pdma->va = 0;
+	pdma->len = 0;
+exit:
+	DbgInfo(MODULE_OS_API, FEATURE_DRIVER_INIT, NOT_TO_RAM, "Exit %s\n",
+		__func__);
+	return TRUE;
+}
+
+/*
+ *
+ * Function Name: _os_sleep
+ *
+ * Abstract:
+ *
+ *			 1. sleep current thread
+ *
+ * Input:
+ *
+ *			u32 time_ms [in]:  sleep times
+ *
+ * Output:
+ *
+ *
+ *
+ * Return value:
+ *			FALSE : means can't sleep, reture immediately
+ *			TRUE: sleep ok
+ *
+ * Notes:
+ *			Delay in ms. It won't ties up the CPU.
+ *			But it is not so accurate. And it must be called in PASSIVE_LEVEL
+ *
+ */
+void os_sleep(u32 time_ms)
+{
+	u32 tick = os_get_cur_tick();
+
+	while (os_is_timeout(tick, time_ms) == FALSE)
+		schedule();
+}
+
+/*
+ *
+ * Function Name: os_udelay
+ *
+ * Abstract:
+ *
+ *			 1. CPU busy delay
+ *
+ * Input:
+ *
+ *			u32 time_us [in]:  busy delay times
+ *
+ * Output:
+ *
+ *
+ *
+ * Return value:
+ *
+ * Notes:
+ *
+ */
+
+void os_udelay(u32 time_us)
+{
+	udelay(time_us);
+}
+
+/*
+ *
+ * Function Name: os_mdelay
+ *
+ * Abstract:
+ *
+ *			 1. CPU busy delay
+ *
+ * Input:
+ *
+ *			u32 time_ms [in]:  busy delay times, unit ms
+ *
+ * Output:
+ *
+ *
+ *
+ * Return value:
+ *
+ * Notes:
+ *
+ */
+void os_mdelay(u32 time_ms)
+{
+	mdelay(time_ms);
+}
+
+/*
+ *
+ * Function Name: os_print
+ *
+ * Abstract:
+ *
+ *			 1. print string to debugview
+ *
+ * Input:
+ *
+ *			byte * s [in]:  pointer to string
+ *
+ * Output:
+ *
+ *
+ *
+ * Return value:
+ *
+ * Notes:
+ *
+ */
+
+void os_print(byte *s)
+{
+	printk(s);
+}
+
+/*
+ *
+ * Function Name: os_alloc_vbuff
+ *
+ * Abstract:
+ *
+ *			 1. allocate virtual buffer
+ *
+ * Input:
+ *
+ *			u32 length [in]:  buffer length to allocate
+ *
+ * Output:
+ *
+ *
+ *
+ * Return value:
+ *
+ *			the buffer address which allocate
+ *
+ * Notes:
+ *
+ */
+
+void *os_alloc_vbuff(u32 length)
+{
+	return kmalloc(length, GFP_KERNEL);
+}
+
+/*
+ *
+ * Function Name: os_free_vbuff
+ *
+ * Abstract:
+ *
+ *			 1. free the virtual buffer
+ *
+ * Input:
+ *
+ *			u32 length [in]:  buffer length to free
+ *
+ * Output:
+ *
+ *
+ *
+ * Return value:
+ *
+ *			none
+ *
+ * Notes:
+ *
+ */
+void os_free_vbuff(void *vbuff)
+{
+	kfree(vbuff);
+}
+
+/*
+ *
+ * Function Name: os_get_phy_addr32l
+ *
+ * Abstract:
+ *
+ *			 1.  get physical address low 32bit value
+ *
+ * Input:
+ *
+ *
+ *
+ * Output:
+ *
+ *
+ *
+ * Return value:
+ *
+ *			none
+ *
+ * Notes:
+ *
+ */
+u32 os_get_phy_addr32l(phy_addr_t phy_addr)
+{
+	return (phy_addr & 0x000000FFFFFFFF);
+}
+
+u64 os_get_phy_addr64(phy_addr_t phy_addr)
+{
+	return phy_addr;
+}
+
+/*
+ *
+ * Function Name: os_get_phy_addr32h
+ *
+ * Abstract:
+ *
+ *			 1.  get physical address high 32bit value
+ *
+ * Input:
+ *
+ *
+ *
+ * Output:
+ *
+ *
+ *
+ * Return value:
+ *
+ *			none
+ *
+ * Notes:
+ *
+ */
+u32 os_get_phy_addr32h(phy_addr_t phy_addr)
+{
+	return ((phy_addr & 0xFFFFFFFF00000000) >> 32);
+}
+
+/*
+ *
+ * Function Name: os_set_phy_addr32l
+ *
+ * Abstract:
+ *
+ *			 1.  set physical address low 32bit value
+ *
+ * Input:
+ *
+ *
+ *
+ * Output:
+ *
+ *
+ *
+ * Return value:
+ *
+ *			none
+ *
+ * Notes:
+ *
+ */
+void os_set_phy_addr32l(phy_addr_t *phy_addr, u32 addr)
+{
+	u32 *haddr = (u32 *) phy_addr;
+	*haddr = addr;
+
+}
+
+/*
+ *
+ * Function Name: os_set_phy_addr32h
+ *
+ * Abstract:
+ *
+ *			 1.  set physical address high 32bit value
+ *
+ * Input:
+ *
+ *
+ *
+ * Output:
+ *
+ *
+ *
+ * Return value:
+ *
+ *			none
+ *
+ * Notes:
+ *
+ */
+void os_set_phy_addr32h(phy_addr_t *phy_addr, u32 addr)
+{
+	u32 *haddr = (u32 *) phy_addr;
+
+	haddr++;
+	*haddr = addr;
+}
+
+/*
+ *
+ * Function Name: os_set_phy_add64
+ *
+ * Abstract:
+ *
+ *			 1.  set 64bit physical address
+ *
+ * Input:
+ *
+ *
+ *
+ * Output:
+ *
+ *
+ *
+ * Return value:
+ *
+ *			none
+ *
+ * Notes:
+ *
+ */
+void os_set_phy_add64(phy_addr_t *phy_addr, u64 addr)
+{
+
+	*phy_addr = addr;
+
+}
+
+/*
+ *
+ * Function Name: srb_parse_sgl
+ *
+ * Abstract:
+ *
+ *			 1.  get the SG list information for the SRB
+ *
+ * Input:
+ *
+ *
+ *
+ * Output:
+ *
+ *
+ *
+ * Return value:
+ *
+ *			none
+ *
+ * Notes:
+ *
+ */
+u32 os_get_sg_list(void *p, scsi_srb *pSrb, sg_list_t *sg)
+{
+	bht_dev_ext_t *pdx = p;
+	u32 sg_count = 0;
+	u32 i = 0;
+	u32 k = 0;
+	struct scatterlist *pAddList = NULL;
+	u32 dma_64bit =
+	    pdx->cfg->host_item.test_dma_mode_setting.enable_dma_64bit_address;
+
+	sg_count =
+	    dma_map_sg(&pdx->host.pci_dev.pci_dev->dev, scsi_sglist(pSrb),
+		       scsi_sg_count(pSrb), pSrb->sc_data_direction);
+	if (sg_count > 0)
+		pdx->os.dma_mapped = TRUE;
+
+	scsi_for_each_sg(pSrb, pAddList, sg_count, k) {
+		if (dma_64bit)
+			sg[i].Address =
+			    os_get_phy_addr64(sg_dma_address(pAddList));
+		else
+			sg[i].Address =
+			    os_get_phy_addr32l(sg_dma_address(pAddList));
+
+		sg[i].Length = sg_dma_len(pAddList);
+		if (sg[i].Length % 4) {
+			DbgErr
+			    ("PortGetPhysicalAddress() return unaligned length: 0x%x!\n",
+			     sg[i].Length);
+			return 0;
+		}
+		i++;
+	}
+
+	return i;
+}
+
+void os_free_sg_list(void *p, scsi_srb *Srb)
+{
+	bht_dev_ext_t *pdx = p;
+
+	if (pdx->os.dma_mapped) {
+		pdx->os.dma_mapped = FALSE;
+		dma_unmap_sg(&pdx->host.pci_dev.pci_dev->dev, scsi_sglist(Srb),
+			     scsi_sg_count(Srb), Srb->sc_data_direction);
+	}
+}
+
+/*
+ *
+ * Function Name: os_set_dev_busy
+ *
+ * Abstract:
+ *
+ *			 1. notify Power manager device is busy state
+ *
+ * Input:
+ *
+ *			void *p [in]: pointer to device extension
+ *
+ * Output:
+ *
+ *
+ *
+ * Return value:
+ *
+ *			none
+ *
+ * Notes:
+ *
+ */
+#if BHT_LINUX_ENABLE_RTD3
+void os_set_dev_busy(void *p)
+{
+	bht_dev_ext_t *pdx = p;
+
+	if (pdx->pm_state.rtd3_en == FALSE)
+		return;
+	pdx->os.rt_pm_cnt++;
+	if (pdx->os.rt_pm_cnt == 1)
+		pm_runtime_get_sync(&pdx->host.pci_dev.pci_dev->dev);
+}
+
+void os_set_dev_idle(void *p)
+{
+	bht_dev_ext_t *pdx = p;
+
+	if (pdx->pm_state.rtd3_en == FALSE)
+		return;
+	if (pdx->os.rt_pm_cnt == 0) {
+		DbgErr("rt pm set idle cnt not right\n");
+	} else {
+
+		pdx->os.rt_pm_cnt--;
+		if (pdx->os.rt_pm_cnt == 0) {
+			pm_runtime_mark_last_busy(&pdx->host.pci_dev.pci_dev->dev);
+			pm_runtime_put_autosuspend(&pdx->host.pci_dev.pci_dev->dev);
+		}
+	}
+}
+#else
+void os_set_dev_busy(void *p)
+{
+}
+
+void os_set_dev_idle(void *pdx)
+{
+}
+
+#endif
+
+void os_bus_change(void *p)
+{
+	bht_dev_ext_t *pdx = p;
+
+	DbgErr("Enter os bus change with (%d)\n", pdx->card.card_present);
+
+	if (pdx->card.card_present)
+		bht_scsi_init(pdx, pdx->dev);
+	else
+		bht_scsi_uinit(pdx);
+
+}
+
+u32 os_get_cur_tick(void)
+{
+	return jiffies_to_msecs(jiffies);
+}
+
+bool os_is_timeout(u32 start_tck, u32 time_ms)
+{
+	if ((start_tck + time_ms) <= os_get_cur_tick())
+		return TRUE;
+	else
+		return FALSE;
+}
+
+/*
+ *
+ * Function Name: os_memset
+ *
+ * Abstract:
+ *
+ *			Fill a block of memory with zeros,
+ *			given a pointer to the block and the length,
+ *			in bytes, to be filled.
+ *
+ * Input:
+ *
+ *
+ *                          memory_len [in]: The number of bytes to fill with zeros.
+ *
+ *
+ * Output:
+ *
+ *			buffer [out]: A pointer to the memory block to be filled with zeros.
+ *
+ * Return value:
+ *
+ *			None
+ *
+ * Notes:
+ *
+ *                         IRQL Any level
+ *
+ */
+void os_memset(void *buffer, byte fill, s32 len)
+{
+	memset(buffer, fill, len);
+}
+
+/*
+ *
+ * Function Name: os_memcpy
+ *
+ * Abstract:
+ *
+ *			Copy the contents of a source memory block to a destination memory block.
+ *
+ * Input:
+ *
+ *			sbuf [in]: A pointer to the source memory block to copy the bytes from.
+ *			memory_len [in]: The number of bytes to copy from
+ *				the source to the destination.
+ *
+ * Output:
+ *
+ *			dbuf [out]: A pointer to the destination memory block to copy the bytes to.
+ *
+ * Return value:
+ *
+ *			None
+ *
+ * Notes:
+ *
+ *                         IRQL Any level
+ *
+ */
+void os_memcpy(void *dbuf, void *sbuf, s32 len)
+{
+	memcpy(dbuf, sbuf, len);
+}
+
+s32 os_memcpr(void *dbuf, void *sbuf, s32 len)
+{
+	return memcmp(dbuf, sbuf, len);
+}
+
+void os_enum_reg_cfg(void *cfg_item, e_chip_type chip_type, const byte *ustr,
+		     cb_enum_reg_t func)
+{
+	char *idx_string = NULL;
+	char *addr_string = NULL;
+	char *value_string = NULL;
+	char *separator = NULL;
+	u32 i = 0;
+	u32 idx = 0;
+	u32 type = (u32) -1;
+	u32 addr = 0;
+	u32 value = 0;
+	int err = 0;
+	char cfg_buf[512];
+
+	if (strcmp(ustr, "\\pcr") == 0) {
+		for (i = 0; i < pcr_setting_count; i++) {
+			PrintMsg("pcr_settings[%d] = %s\n", i, pcr_settings[i]);
+
+			if (strlen(pcr_settings[i]) >= sizeof(cfg_buf)) {
+				DbgErr("pcr setting string %d is too long\n",
+				       i);
+				continue;
+			} else if (strlen(pcr_settings[i]) < 14) {
+				DbgErr("pcr setting string %d is too short\n",
+				       i);
+				continue;
+			}
+			strcpy(cfg_buf, pcr_settings[i]);
+			idx_string = cfg_buf;
+			if (idx_string[3] != '_') {
+				DbgErr
+				    ("failed to find separator between idx and type\n");
+				continue;
+			}
+			idx_string[3] = '\0';
+			err = kstrtou32(idx_string, 16, &idx);
+			if (err) {
+				DbgErr
+				    ("failed to parse idx from pcr setting: %s\n",
+				     pcr_settings[i]);
+				continue;
+			}
+			if (idx_string[4] == 'P' || idx_string[4] == 'p')
+				type = 0;
+			else if (idx_string[4] == 'M' || idx_string[4] == 'm')
+				type = 1;
+			else if (idx_string[4] == 'V' || idx_string[4] == 'v')
+				type = 2;
+			else {
+				DbgErr
+				    ("failed to parse type from pcr setting: %s\n",
+				     pcr_settings[i]);
+				continue;
+			}
+			addr_string = cfg_buf + 5;
+			separator = strchr(addr_string, '=');
+			if (separator == NULL) {
+				DbgErr
+				    ("failed to find separator between addr and value\n");
+				continue;
+			}
+			*separator = '\0';
+			value_string = ++separator;
+			err = kstrtou32(addr_string, 16, &addr);
+			if (err) {
+				DbgErr
+				    ("failed to parse addr from pcr setting: %s\n",
+				     pcr_settings[i]);
+				continue;
+			}
+			err = kstrtou32(value_string, 16, &value);
+			if (err) {
+				DbgErr
+				    ("failed to parse value from pcr setting: %s\n",
+				     pcr_settings[i]);
+				continue;
+			}
+			PrintMsg("pcr[0x%08x]=0x%08x, type = %d, idx=%d\n",
+				 addr, value, type, idx);
+			if (func)
+				func(cfg_item, type, idx, addr, value);
+		}
+	} else if (strcmp(ustr, "\\dmdn") == 0) {
+		for (i = 0; i < dmdn_setting_count; i++) {
+			if (strlen(pcr_settings[i]) >= sizeof(cfg_buf)) {
+				DbgErr("dmdn setting string %d is too long\n",
+				       i);
+				continue;
+			}
+			strcpy(cfg_buf, dmdn_settings[i]);
+			addr_string = cfg_buf;
+			separator = strchr(addr_string, '=');
+			if (separator == NULL) {
+				DbgErr
+				    ("failed to parse value from dmdn setting: %s\n",
+				     dmdn_settings[i]);
+				continue;
+			}
+			*separator = '\0';
+			value_string = ++separator;
+			err = kstrtou32(addr_string, 16, &addr);
+			if (err) {
+				DbgErr
+				    ("failed to parse addr from dmdn setting: %s\n",
+				     dmdn_settings[i]);
+				continue;
+			}
+			err = kstrtou32(value_string, 16, &value);
+			if (err) {
+				DbgErr
+				    ("failed to parse value from dmdn setting: %s\n",
+				     dmdn_settings[i]);
+				continue;
+			}
+			PrintMsg("dmdn[0x%08x]=0x%08x\n", addr, value);
+			if (func)
+				func(cfg_item, 0, 0, addr, value);
+		}
+	} else
+		PrintMsg("current only support pcr or dmdnsettings\n",
+			 __func__);
+}
+
+void os_pm_init(void *dev_evt)
+{
+	DbgInfo(MODULE_OS_API, FEATURE_DRIVER_INIT, NOT_TO_RAM, "Enter %s\n",
+		__func__);
+	/* todo for PM part */
+
+	DbgInfo(MODULE_OS_API, FEATURE_DRIVER_INIT, NOT_TO_RAM, "Exit %s\n",
+		__func__);
+
+}
+
+bool os_pcr_pesistent_restore(u16 *addr_tb, u32 *val_tb, u32 tb_len)
+{
+	return FALSE;
+}
+
+bool os_pcr_pesistent_save(u16 *addr_tb, u32 *val_tb, u32 tb_len)
+{
+	return FALSE;
+}
+
+void os_random_init(void)
+{
+	/* no implement for linux */
+
+}
+
+u32 os_random_get(u32 max_value)
+{
+#if LINUX_VERSION_CODE > KERNEL_VERSION(3, 9, 0)
+	return (get_random_long() % max_value);
+#else
+	return random32();
+#endif
+}
+
+void os_bak_reg_hibernate(void)
+{
+	/* no implement for linux */
+
+}
+
+u64 os_get_performance_tick(u64 *cpu_freq)
+{
+	/* no implement for linux */
+	return 0;
+}
+
+/*
+ *
+ * Function Name: os_cfg_load
+ *
+ * Abstract:
+ *			 1. Read total reigstry information
+ *
+ * Input:
+ *            cfg_item_t *cfg: Pointer to the registry config structure
+ *            e_chip_type chip_type;
+ *
+ * Output:
+ *			None
+ *
+ * Return value:
+ *           None
+ *
+ * Notes:
+ *           Caller: cfgmng_init
+ */
+void os_cfg_load(void *cfg_item, e_chip_type chip_type)
+{
+	cfg_item_t *cfg = cfg_item;
+
+	if (m_emmc_mode & BIT31)
+		os_memcpy(&cfg->card_item.emmc_mode, &m_emmc_mode, 4);
+
+	if (m_dma_mode & BIT31) {
+		os_memcpy(&cfg->host_item.test_dma_mode_setting, &m_dma_mode,
+			  4);
+	}
+
+	if (m_infinite_ctrl & BIT31) {
+		os_memcpy(&cfg->host_item.test_infinite_transfer_mode,
+			  &m_infinite_ctrl, 4);
+	}
+
+	if (m_tag_cap & BIT31) {
+		os_memcpy(&cfg->host_item.test_tag_queue_capability, &m_tag_cap,
+			  4);
+	}
+
+	if (m_sdmode_dis & BIT31)
+		os_memcpy(&cfg->card_item.sd_card_mode_dis, &m_sdmode_dis, 4);
+
+	if (m_mmc_dis & BIT31)
+		os_memcpy(&cfg->card_item.mmc_mode_dis, &m_mmc_dis, 4);
+
+	if (m_uhs2_ctrl & BIT31)
+		os_memcpy(&cfg->card_item.uhs2_setting, &m_uhs2_ctrl, 4);
+
+	if (m_output_tuning & BIT31) {
+		os_memcpy(&cfg->feature_item.output_tuning_item,
+			  &m_output_tuning, 4);
+	}
+
+	if (m_auto_dmt & BIT31)
+		os_memcpy(&cfg->timer_item.auto_dormant_timer, &m_auto_dmt, 4);
+
+	os_memcpy(&cfg->driver_item, &m_driver_item, 4);
+
+	os_memcpy(&cfg->card_item.sd7_sdmode_switch_control,
+		  &m_sd7_sdmode_switch_control, 4);
+	os_memcpy(&cfg->card_item.sd_card_mode_dis, &m_sd_card_mode_dis, 4);
+	os_memcpy(&cfg->card_item.test_max_access_mode, &m_test_max_access_mode,
+		  4);
+	os_memcpy(&cfg->card_item.test_uhs2_setting2, &m_test_uhs2_setting2, 4);
+	os_memcpy(&cfg->card_item.test_driver_strength_sel,
+		  &m_test_driver_strength_sel, 4);
+	os_memcpy(&cfg->card_item.test_max_power_limit, &m_test_max_power_limit,
+		  4);
+	os_memcpy(&cfg->card_item.mmc_mode_dis, &m_mmc_mode_dis, 4);
+
+	os_memcpy(&cfg->feature_item.pcie_wake_setting, &m_pcie_wake_setting,
+		  4);
+	os_memcpy(&cfg->feature_item.hsmux_vcme_enable, &m_hsmux_vcme_enable,
+		  4);
+
+	os_memcpy(&cfg->host_item.vdd_power_source_item,
+		  &m_vdd_power_source_item, 4);
+	os_memcpy(&cfg->host_item.host_drive_strength, &m_host_drive_strength,
+		  4);
+	os_memcpy(&cfg->host_item.test_sdma_boundary, &m_test_sdma_boundary, 4);
+	os_memcpy(&cfg->host_item.test_dma_mode_setting,
+		  &m_test_dma_mode_setting, 4);
+	os_memcpy(&cfg->host_item.test_ocb_ctrl, &m_test_ocb_ctrl, 4);
+	os_memcpy(&cfg->host_item.bios_l1_substate, &m_bios_l1_substate, 4);
+
+	os_memcpy(&cfg->feature_item.auto_detect_refclk_counter_range_ctl,
+		  &m_auto_detect_refclk_counter_range_ctl, 4);
+	os_memcpy(&cfg->feature_item.refclk_stable_detection_counter1,
+		  &m_refclk_stable_detection_counter1, 4);
+	os_memcpy(&cfg->feature_item.refclk_stable_detection_counter2,
+		  &m_refclk_stable_detection_counter2, 4);
+	os_memcpy(&cfg->feature_item.refclk_stable_detection_counter3,
+		  &m_refclk_stable_detection_counter3, 4);
+	os_memcpy(&cfg->feature_item.l1_enter_exit_logic_ctl,
+		  &m_l1_enter_exit_logic_ctl, 4);
+	os_memcpy(&cfg->feature_item.pcie_phy_amplitude_adjust,
+		  &m_pcie_phy_amplitude_adjust, 4);
+	os_memcpy(&cfg->feature_item.output_tuning_item, &m_output_tuning_item,
+		  4);
+	os_memcpy(&cfg->feature_item.test_main_ldo_setting,
+		  &m_test_main_ldo_setting, 4);
+
+	os_memcpy(&cfg->timeout_item.power_wait_time, &m_power_wait_time, 4);
+	os_memcpy(&cfg->timeout_item.test_write_data_timeout,
+		  &m_test_write_data_timeout, 4);
+	os_memcpy(&cfg->timeout_item.test_read_data_timeout,
+		  &m_test_read_data_timeout, 4);
+	os_memcpy(&cfg->timeout_item.test_non_data_timeout,
+		  &m_test_non_data_timeout, 4);
+	os_memcpy(&cfg->timeout_item.test_r1b_data_timeout,
+		  &m_test_r1b_data_timeout, 4);
+	os_memcpy(&cfg->timeout_item.test_card_init_timeout,
+		  &m_test_card_init_timeout, 4);
+
+#if BHT_LINUX_ENABLE_RTD3
+	os_memcpy(&cfg->feature_item.psd_mode, &m_psd_mode, 4);
+#else
+	cfg->feature_item.psd_mode.enable_rtd3 = 0;
+
+	/* software control */
+	cfg->feature_item.psd_mode.rtd3_ctrl_mode = 1;
+#endif
+
+}
+
+/* currently don't implement */
+void os_set_sdio_val(void *p, u8 val, bool need_set_did)
+{
+}
+
+void os_rtd3_req_wait_wake(void *pdx)
+{
+
+}
diff --git a/drivers/scsi/bht/linux_os/linux_api.h b/drivers/scsi/bht/linux_os/linux_api.h
new file mode 100644
index 000000000000..960f9cc4dd5d
--- /dev/null
+++ b/drivers/scsi/bht/linux_os/linux_api.h
@@ -0,0 +1,90 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (c) 2014 BHT Inc.
+ *
+ * File Name: linux_api.h
+ *
+ * Abstract: Include apis for Linux
+ *
+ * Version: 1.00
+ *
+ * Author: Peter.Guo
+ *
+ * Environment:	Linux
+ *
+ * History:
+ *
+ * 5/20/2015		Creation	Peter.Guo
+ */
+
+#include <linux/module.h>
+#include <linux/init.h>
+#include <linux/pm.h>
+#include <linux/vmalloc.h>
+
+#include "../include/basic.h"
+#define TASK_STATUS_IDLE 0
+#define TASK_STATUS_OCCUR 1
+
+typedef struct completion linux_completion_t;
+
+typedef struct {
+	spinlock_t lock;
+	/* add for list */
+	struct list_head list_hd;
+	atomic_t cnt;
+} linux_list_t;
+
+typedef struct {
+	struct task_struct *pthread;
+	bool pending_lock;
+	bool freeze;
+	linux_completion_t break_pending;
+} thread_t;
+
+typedef void (*timer_cb_t)(PVOID, PVOID);
+
+typedef struct {
+	void *timer;
+	timer_cb_t timer_callback;
+} linux_timer_t;
+
+typedef struct {
+	wait_queue_head_t evt_control;
+	/* Command control thread - command in flag */
+	atomic_t evt_comming;
+	unsigned long evt_flag;
+	spinlock_t lock;
+} t_linux_event;
+
+typedef struct {
+	u8 status;
+	u32 id;
+	u8 shared_task_cnt;
+} win_task_t;
+
+typedef struct {
+	win_task_t tasks[10];
+	u32 task_cnt;
+} task_mgr_t;
+
+typedef struct {
+	struct timer_list timer;
+	thread_t thread;
+
+	task_mgr_t task_mgr;
+	t_linux_event event;
+	spinlock_t lock;
+	dma_desc_buf_t dma_info;
+	struct Scsi_Host *scsi_host;
+	byte *virt_buff;
+	/*
+	 * If os_get_sg_list called successful, set this flag to 1.
+	 * and need call dma_unmap_sg when transfer done
+	 */
+	bool dma_mapped;
+	int rt_pm_cnt;
+	bool thread_terminate_stop;
+} t_linux_os_struct;
+
+void os_free_sg_list(void *p, scsi_srb *Srb);
diff --git a/drivers/scsi/bht/linux_os/linux_base.c b/drivers/scsi/bht/linux_os/linux_base.c
new file mode 100644
index 000000000000..a651141b7608
--- /dev/null
+++ b/drivers/scsi/bht/linux_os/linux_base.c
@@ -0,0 +1,985 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (c) 2014 BHT Inc.
+ *
+ * File Name: linux_base.c
+ *
+ * Abstract: Driver Entry  for Linux
+ *
+ * Version: 1.00
+ *
+ * Author: Peter.Guo
+ *
+ * Environment:	Linux
+ *
+ * History:
+ *
+ * 5/20/2015		Creation	Peter.Guo
+ */
+
+#include <linux/module.h>
+#include <linux/init.h>
+#include "../include/basic.h"
+#include "../include/debug.h"
+#include "../include/reqapi.h"
+#include "../include/hostapi.h"
+#include "../include/hostvenapi.h"
+
+#include "linux_scsi.h"
+#if BHT_LINUX_ENABLE_RTD3
+#include <linux/pm_runtime.h>
+#endif
+
+#define VENDOR_O2MICRO 0x1217
+#define BHT_SD_MAX_DEV	8
+#define BHT_USE_PCI_MSI 1
+#define SRB_MIN_REQ	64
+
+#define INPUT_TUNING_PASS_WINDOW	0x44
+
+extern u32 g_dbg_module;
+extern u32 g_dbg_feature;
+extern u32 g_dbg_ctrl;
+
+extern uint m_sd_3v3_clk_driver_strength;
+extern uint m_sd_3v3_cmddata_driver_strength;
+extern uint m_sd_1v8_clk_driver_strength;
+extern uint m_sd_1v8_cmddata_driver_strength;
+extern uint m_ram_ema;
+extern uint m_vdd1_vdd2_source;
+extern uint m_vdd18_debounce_time;
+extern uint m_ssc_enable;
+extern uint m_cnfg_drv;
+extern uint m_cnfg_trm_code_tx;
+extern uint m_cnfg_trm_code_rx;
+extern uint m_cnfg_rint_code;
+
+struct kmem_cache *bht_srb_ext_cachep;
+mempool_t *bht_sd_mem_pool;
+
+typedef struct {
+	int used;
+	bht_dev_ext_t data;
+} bht_sd_slot_t;
+
+static bht_sd_slot_t bht_slot[BHT_SD_MAX_DEV];
+
+static bht_sd_slot_t *bht_slot_getfree(void)
+{
+	int i = 0;
+
+	for (i = 0; i < BHT_SD_MAX_DEV; i++) {
+		if (bht_slot[i].used == 0) {
+			os_memset(&bht_slot[i].data, 0, sizeof(bht_dev_ext_t));
+			DbgInfo(MODULE_OS_ENTRY, FEATURE_DRIVER_INIT,
+				NOT_TO_RAM, "Get Slot=%p i=%d\n", &bht_slot[i],
+				i);
+			return &bht_slot[i];
+		}
+	}
+	return NULL;
+}
+
+static void bht_global_init(void)
+{
+	int i = 0;
+
+	for (i = 0; i < BHT_SD_MAX_DEV; i++) {
+		os_memset(&bht_slot[i].data, 0, sizeof(bht_dev_ext_t));
+		bht_slot[i].used = 0;
+	}
+
+	DbgRamInit();
+#if DBG || _DEBUG
+	g_dbg_module = DBG_MODULE_CONTROL;
+	g_dbg_feature = DBG_FEATURE_CONTROL;
+	g_dbg_ctrl = DBG_CTRL_CONTROL;
+
+	DbgErr("Dbg Module=0x%08X feature=0x%08X control=0x%08X\n",
+	       g_dbg_module, g_dbg_feature, g_dbg_ctrl);
+#else
+	g_dbg_module = 0;
+	g_dbg_feature = 0;
+	g_dbg_ctrl = 0;
+#endif
+	cfgmng_init();
+}
+
+static void bht_global_uninit(void)
+{
+	int i;
+
+	DbgInfo(MODULE_OS_ENTRY, FEATURE_DRIVER_INIT, NOT_TO_RAM,
+		"bht sd free slots\n");
+	for (i = 0; i < BHT_SD_MAX_DEV; i++) {
+		os_memset(&bht_slot[i].data, 0, sizeof(bht_dev_ext_t));
+		bht_slot[i].used = 0;
+	}
+
+	DbgRamFree();
+}
+
+struct pci_device_id bht_id_table[] = {
+	{
+	 /* SDS0 */
+	 .vendor = VENDOR_O2MICRO,
+	 .device = 0x8420,
+	 .subvendor = PCI_ANY_ID,
+	 .subdevice = PCI_ANY_ID,
+	  },
+
+	{
+	 /* SDS1 */
+	 .vendor = VENDOR_O2MICRO,
+	 .device = 0x8421,
+	 .subvendor = PCI_ANY_ID,
+	 .subdevice = PCI_ANY_ID,
+	  },
+
+	{
+	 /* Fujin2A Fjin2B */
+	 .vendor = VENDOR_O2MICRO,
+	 .device = 0x8520,
+	 .subvendor = PCI_ANY_ID,
+	 .subdevice = PCI_ANY_ID,
+	  },
+
+	{
+	 /* Searbird */
+	 .vendor = VENDOR_O2MICRO,
+	 .device = 0x8620,
+	 .subvendor = PCI_ANY_ID,
+	 .subdevice = PCI_ANY_ID,
+	  },
+
+	{
+	 /* SeaBird */
+	 .vendor = VENDOR_O2MICRO,
+	 .device = 0x8621,
+	 .subvendor = PCI_ANY_ID,
+	 .subdevice = PCI_ANY_ID,
+	  },
+	{
+	 .vendor = VENDOR_O2MICRO,
+	 /* 0x8720 to 0x8723 is SeaEagle2 */
+	 .device = 0x8720,
+	 .subvendor = PCI_ANY_ID,
+	 .subdevice = PCI_ANY_ID,
+	  },
+
+	{
+	 .vendor = VENDOR_O2MICRO,
+	 .device = 0x8721,
+	 .subvendor = PCI_ANY_ID,
+	 .subdevice = PCI_ANY_ID,
+	  },
+	{
+	 .vendor = VENDOR_O2MICRO,
+	 .device = 0x8722,
+	 .subvendor = PCI_ANY_ID,
+	 .subdevice = PCI_ANY_ID,
+	  },
+	{
+	 .vendor = VENDOR_O2MICRO,
+	 .device = 0x8723,
+	 .subvendor = PCI_ANY_ID,
+	 .subdevice = PCI_ANY_ID,
+	  },
+	{
+	 /* 0x8750,0x8751 and 0x8740 is SandStorm2 */
+	 .vendor = VENDOR_O2MICRO,
+	 .device = 0x8750,
+	 .subvendor = PCI_ANY_ID,
+	 .subdevice = PCI_ANY_ID,
+	  },
+	{
+	 .vendor = VENDOR_O2MICRO,
+	 .device = 0x8751,
+	 .subvendor = PCI_ANY_ID,
+	 .subdevice = PCI_ANY_ID,
+	  },
+	{
+	 .vendor = VENDOR_O2MICRO,
+	 .device = 0x8740,
+	 .subvendor = PCI_ANY_ID,
+	 .subdevice = PCI_ANY_ID,
+	  },
+	{
+	 /* gg8 */
+	 .vendor = VENDOR_O2MICRO,
+	 .device = 0x9860,
+	 .subvendor = PCI_ANY_ID,
+	 .subdevice = PCI_ANY_ID,
+	  },
+	{
+	 .vendor = VENDOR_O2MICRO,
+	 .device = 0x9861,
+	 .subvendor = PCI_ANY_ID,
+	 .subdevice = PCI_ANY_ID,
+	  },
+	{
+	 .vendor = VENDOR_O2MICRO,
+	 .device = 0x9862,
+	 .subvendor = PCI_ANY_ID,
+	 .subdevice = PCI_ANY_ID,
+	  },
+	{
+	 .vendor = VENDOR_O2MICRO,
+	 .device = 0x9863,
+	 .subvendor = PCI_ANY_ID,
+	 .subdevice = PCI_ANY_ID,
+	  },
+	{ 0, 0 },
+};
+
+MODULE_DEVICE_TABLE(pci, bht_id_table);
+
+/* ----------BIOS GUIDE setting part---------- */
+
+void bht_bios_setting(bht_dev_ext_t *pdx)
+{
+	sd_host_t *host = &pdx->host;
+	cfg_item_t *cfg = pdx->cfg;
+	u32 regaddr;
+	u32 regval;
+
+	DbgInfo(MODULE_OS_ENTRYAPI, FEATURE_RW_TRACE, NOT_TO_RAM,
+		"Enter %s chip type = 0x%x\n", __func__, host->chip_type);
+
+	switch (host->chip_type) {
+	case CHIP_GG8:
+		regval = pci_readl(host, 0x300);
+		regval &= ~(0xff);
+		regval |= 0x33;
+		pci_writel(host, 0x300, regval);
+		break;
+	case CHIP_SEAEAGLE2:
+		/* we need set this to enable hs400 function */
+		if (cfg->card_item.emmc_mode.enable_force_hs400)
+			pci_orl(host, 0x3f8, BIT13);
+		else
+			pci_andl(host, 0x3f8, ~BIT13);
+		break;
+	case CHIP_SDS2_SD0:
+	case CHIP_SDS2_SD1:
+		/* pcie & pm #2, should be the first operation after detect host type */
+		pci_writel(host, 0x438, m_ram_ema);
+
+		/* uhsi #1 */
+		pci_orl(host, 0x3e4, 0x80000000);
+		/* uhsi #3 */
+		regaddr = (host->chip_type == CHIP_SDS2_SD0) ? 0x300 : 0x380;
+		pci_writel(host, regaddr, INPUT_TUNING_PASS_WINDOW);
+
+		/* ushi #4 */
+		regval = pci_readl(host, 0x3f8);
+		regval &= ~(0x03u << 19);
+		regval |= (m_vdd18_debounce_time << 19);
+		pci_orl(host, 0x3f8, regval);
+
+		/* uhsi #6 */
+		regaddr = host->chip_type == CHIP_SDS2_SD0 ? 0x304 : 0x384;
+		regval = pci_readl(host, regaddr);
+		regval &= 0xffff8881;
+		regval |= ((m_sd_3v3_clk_driver_strength & 0x07) << 12 |
+			   (m_sd_3v3_cmddata_driver_strength & 0x07) << 8 |
+			   (m_sd_1v8_clk_driver_strength & 0x07) << 4 |
+			   (m_sd_1v8_cmddata_driver_strength & 0x07) << 1 | 1);
+		pci_writel(host, regaddr, regval);
+
+		/* ushii #1  */
+		regval = pci_readl(host, 0x3fc);
+		regval &= ~0x7f000000;
+		regval |= ((m_cnfg_drv & 0x7f) << 24);
+		pci_writel(host, 0x3fc, regval);
+
+		regval = pci_readl(host, 0x400);
+		regval &= ~(0xfff);
+		regval |= ((m_cnfg_trm_code_tx & 0x0f) << 8);
+		regval |= ((m_cnfg_trm_code_rx & 0x0f) << 4);
+		regval |= (m_cnfg_rint_code & 0x0f);
+		pci_writel(host, 0x400, regval);
+
+		/* uhsii 2 */
+		switch (m_vdd1_vdd2_source) {
+		case 0:
+			regval = pci_readl(host, 0x508);
+			/* bit[25:24] = 2'b00 */
+			regval &= ~(0x3 << 24);
+			/* bit[9:8] = 2'b00 */
+			regval &= ~(0x3 << 8);
+			regval &= ~(0xf << 2);
+			/* bit[5:2]=4'b0101 */
+			regval |= 0x14;
+			break;
+		case 1:
+			regval = pci_readl(host, 0x508);
+			/* bit[25:24] = 2'b11 */
+			regval |= (0x3 << 24);
+			/* bit[9:8] = 2'b11 */
+			regval |= (0x3 << 8);
+			/* bit[5:2]=4'b1111 */
+			regval |= (0xf << 2);
+			break;
+		case 2:
+			regval = pci_readl(host, 0x508);
+			/* bit[25:24] = 2'b00 */
+			regval &= ~(0x3 << 24);
+			/* bit[25:24] = 2'b10 */
+			regval |= (0x2 << 24);
+			/* bit[9:8] = 2'b00 */
+			regval &= ~(0x3 << 8);
+			/* bit[9:8] = 2'b10 */
+			regval |= (0x2 << 8);
+			regval &= ~(0xf << 2);
+			/* bit[5:2]=4'b1010 */
+			regval |= 0x28;
+			break;
+		default:
+			break;
+		}
+		pci_writel(host, 0x508, regval);
+
+		/* clock & generator #1 */
+		if (m_ssc_enable != 0) {
+			pci_writel(host, 0x420, 0xa0005e1e);
+			pci_writel(host, 0x424, 0x61180000);
+		} else {
+			pci_writel(host, 0x420, 0xa000561e);
+			pci_writel(host, 0x424, 0x21180000);
+		}
+		/* clock & generator #2 */
+		pci_writel(host, 0x428, 0x01f0f0fa);
+		pci_writel(host, 0x42c, 0x01f0f0fa);
+		break;
+	default:
+		break;
+	}
+
+}
+
+#if BHT_LINUX_ENABLE_RTD3
+
+static void bht_sd_runtime_pm_allow(bht_dev_ext_t *pdx, struct device *dev)
+{
+	if (pdx->pm_state.rtd3_en == FALSE)
+		return;
+
+	pm_runtime_put_noidle(dev);
+	pm_runtime_allow(dev);
+	pm_runtime_set_autosuspend_delay(dev,
+					 pdx->cfg->feature_item.psd_mode.disk_idle_time_s * 1000);
+	pm_runtime_use_autosuspend(dev);
+	pm_suspend_ignore_children(dev, 1);
+}
+
+static void bht_sd_runtime_pm_forbid(bht_dev_ext_t *pdx, struct device *dev)
+{
+
+	if (pdx->pm_state.rtd3_en == FALSE)
+		return;
+
+	pm_runtime_forbid(dev);
+	pm_runtime_get_noresume(dev);
+}
+
+static int bht_sd_runtime_suspend(struct device *dev)
+{
+	struct pci_dev *pdev = container_of(dev, struct pci_dev, dev);
+	int ret = 0;
+	bht_sd_slot_t *slot = pci_get_drvdata(pdev);
+	bht_dev_ext_t *pdx = 0;
+
+	DbgInfo(MODULE_OS_ENTRY, FEATURE_PM_TRACE, NOT_TO_RAM,
+		"BHT sd rt supspend begin\n");
+
+	if (slot == NULL || slot->used == FALSE)
+		goto exit;
+
+	pdx = &slot->data;
+	pdx->pm_state.rtd3_entered = TRUE;
+	req_enter_d3(pdx);
+
+exit:
+	DbgInfo(MODULE_OS_ENTRY, FEATURE_PM_TRACE, NOT_TO_RAM,
+		"BHT sd rt supspend exit\n");
+	return ret;
+}
+
+static int bht_sd_runtime_resume(struct device *dev)
+{
+	struct pci_dev *pdev = container_of(dev, struct pci_dev, dev);
+	int ret = 0;
+	bht_sd_slot_t *slot = pci_get_drvdata(pdev);
+	bht_dev_ext_t *pdx = 0;
+
+	DbgInfo(MODULE_OS_ENTRY, FEATURE_PM_TRACE, NOT_TO_RAM,
+		"BHT sd rt resume begin\n");
+
+	if (slot == NULL || slot->used == FALSE)
+		goto exit;
+
+	pdx = &slot->data;
+	req_enter_d0_sync(pdx);
+
+exit:
+	DbgInfo(MODULE_OS_ENTRY, FEATURE_PM_TRACE, NOT_TO_RAM,
+		"BHT sd rt resume exit\n");
+	return ret;
+}
+
+static int bht_sd_runtime_idle(struct device *dev)
+{
+	return 0;
+}
+
+#endif
+
+static irqreturn_t bht_sd_irq(int irq, void *dev_id)
+{
+	irqreturn_t irqret = IRQ_NONE;
+	bht_dev_ext_t *pdx = (bht_dev_ext_t *) dev_id;
+	bool ret = FALSE;
+
+	ret = sdhci_irq(pdx);
+
+	if (pdx->host.pci_dev.use_msi)
+		irqret |= IRQ_HANDLED;
+	else {
+		if (ret)
+			irqret |= IRQ_HANDLED;
+	}
+
+	return irqret;
+}
+
+#ifdef CONFIG_PM
+static int bht_sd_suspend(struct device *device)
+{
+	struct pci_dev *pdev = to_pci_dev(device);
+	bht_sd_slot_t *slot = pci_get_drvdata(pdev);
+	bht_dev_ext_t *pdx = &slot->data;
+
+	DbgInfo(MODULE_OS_ENTRY, FEATURE_PM_TRACE, NOT_TO_RAM,
+		"BHT sd suspend begin\n");
+
+	if (slot->used == 0)
+		goto exit;
+
+	pdx->pm_state.s3s4_entered = TRUE;
+	req_pre_enter_d3(pdx);
+	req_enter_d3(pdx);
+
+exit:
+	DbgInfo(MODULE_OS_ENTRY, FEATURE_PM_TRACE, NOT_TO_RAM,
+		"BHT sd suspend end\n");
+	return 0;
+}
+
+static int bht_sd_resume(struct device *device)
+{
+	struct pci_dev *pdev = to_pci_dev(device);
+	bht_sd_slot_t *slot = pci_get_drvdata(pdev);
+	bht_dev_ext_t *pdx = &slot->data;
+
+	DbgInfo(MODULE_OS_ENTRY, FEATURE_PM_TRACE, NOT_TO_RAM,
+		"BHT sd resume begin\n");
+
+	if (slot->used == 0)
+		goto exit;
+
+	req_enter_d0(pdx);
+
+exit:
+	DbgInfo(MODULE_OS_ENTRY, FEATURE_PM_TRACE, NOT_TO_RAM,
+		"BHT sd resume end\n");
+	return 0;
+}
+
+#else
+#define bht_sd_suspend	NULL
+#define bht_sd_resume	NULL
+#endif
+
+/*
+ * pci dev interrupt init
+ */
+static int bht_pci_init_irq(struct pci_dev *pdev, bht_dev_ext_t *pdx)
+{
+	int ret = -1;
+
+	pdx->host.pci_dev.use_msi = 0;
+
+	/* Firstly try MSI interrupt if enabled */
+#if defined(BHT_USE_PCI_MSI) && defined(CONFIG_PCI_MSI)
+	if (pci_find_capability(pdev, PCI_CAP_ID_MSI)) {
+		int err;
+		/* PCI device support MSI interrupt mode. */
+		err = pci_enable_msi(pdev);
+		if (!err) {
+			pdx->host.pci_dev.irq = pdev->irq;
+			pdx->host.pci_dev.use_msi = 1;
+			DbgInfo(MODULE_OS_ENTRY, FEATURE_DRIVER_INIT,
+				NOT_TO_RAM, "Use Msi irq irq=%d\n", pdev->irq);
+		} else {
+			DbgErr("MSI init failed %d\n", err);
+		}
+
+		if (request_irq(pdev->irq, bht_sd_irq, IRQF_SHARED,
+				(const char *)"bht-sd", (void *)pdx)) {
+			DbgErr("request msi irq %d for bht-sd failed",
+			       pdev->irq);
+			pci_disable_msi(pdev);
+			pdx->host.pci_dev.use_msi = 0;
+		}
+		ret = 0;
+		goto exit;
+	}
+#endif
+
+	pdx->host.pci_dev.irq = pdev->irq;
+	pdx->host.pci_dev.use_msi = 0;
+	if (request_irq(pdev->irq, bht_sd_irq, IRQF_SHARED,
+			(const char *)"bht-sd", (void *)pdx)) {
+		DbgErr("request irq %d for bht-sd failed", pdev->irq);
+		ret = -1;
+		goto exit;
+	}
+
+	ret = 0;
+
+exit:
+	return ret;
+
+}
+
+/*
+ * pci device basci info init
+ */
+static int bht_pci_init(struct pci_dev *pdev, bht_dev_ext_t *pdx)
+{
+	int ret = -1;
+	u32 bus_address;
+
+	pdx->host.pci_dev.pci_dev = pdev;
+	ret = pci_enable_device(pdev);
+	if (ret) {
+		DbgErr("pci enable device failed\n");
+		return ret;
+	}
+
+	pci_set_master(pdev);
+
+	bus_address = pci_resource_start(pdev, 0);
+	if (pci_request_regions(pdev, "bht-sd") < 0) {
+		DbgErr("o2sd request_region failed(%d)\n", 0);
+		ret = -1;
+		goto exit;
+	}
+	/* BAR 0 and BAR1 */
+	bus_address = pci_resource_start(pdev, 0);
+	pdx->host.pci_dev.membase =
+	    (void *)ioremap(bus_address, pci_resource_len(pdev, 0));
+	bus_address = pci_resource_start(pdev, 1);
+	pdx->host.pci_dev.membase2 =
+	    (void *)ioremap(bus_address, pci_resource_len(pdev, 1));
+
+	DbgInfo(MODULE_OS_ENTRY, FEATURE_DRIVER_INIT, NOT_TO_RAM,
+		"membase1=%p membase2=%p\n", pdx->host.pci_dev.membase,
+		pdx->host.pci_dev.membase2);
+	pdx->host.vendor_id = pdev->vendor;
+	pdx->host.device_id = pdev->device;
+	pdx->host.revision_id = pdev->revision;
+
+	ret = 0;
+exit:
+	if (ret != 0)
+		pci_disable_device(pdev);
+	return ret;
+
+}
+
+/*
+ * pci dev dma resource init
+ */
+static bool bht_sd_dma_init(bht_dev_ext_t *pdx)
+{
+	bool ret = FALSE;
+	struct pci_dev *pdev = pdx->host.pci_dev.pci_dev;
+
+#if	CONFIG_X86_64
+
+#else
+
+	/* Set to 32Bit DMA currently */
+	cfg_dma_addr_range_dec(pdx->cfg, 0);
+#endif
+
+	if (pdx->cfg->host_item.test_dma_mode_setting.enable_dma_64bit_address) {
+		if (dma_set_mask(&pdev->dev, DMA_BIT_MASK(64))
+		    || dma_set_coherent_mask(&pdev->dev, DMA_BIT_MASK(64)))
+			DbgErr("dma_set_mask 64bit failed\n");
+		else
+			goto next;
+	}
+
+	if (dma_set_mask(&pdev->dev, DMA_BIT_MASK(32))
+	    || dma_set_coherent_mask(&pdev->dev, DMA_BIT_MASK(32)))
+		DbgErr("dma_set_mask 32bit failed\n");
+next:
+
+	if (pdx->signature != BHT_PDX_SIGNATURE) {
+		u32 max_req_numb = 0;
+		u32 dma_mode = 0;
+		u32 buf_size = 0x10;
+		u32 node_size = 0;
+
+		max_req_numb =
+		    pdx->cfg->host_item.test_tag_queue_capability.max_srb;
+		dma_mode = pdx->cfg->host_item.test_dma_mode_setting.dma_mode;
+
+		if (cfg_dma_need_sdma_like_buffer(dma_mode) == TRUE)
+			node_size = MAX_SDMA_LIKE_MODE_NODE_BUF_SIZE;
+		else
+			node_size = MAX_NODE_BUF_SIZE;
+
+		buf_size = (max_req_numb + TQ_RESERVED_NODE_SIZE) * node_size;
+
+		while (1) {
+			/* preseved for ADMA2 API DMA buffer */
+			buf_size += MIN_DMA_API_BUF_SIZE;
+
+			/* less than minimum buf size  will failed. */
+			if (buf_size <
+			    (MIN_DMA_API_BUF_SIZE + MAX_NODE_BUF_SIZE)) {
+				DbgErr
+				    ("dma buffer less than min(0x%x),so Failed\n",
+				     (MIN_DMA_API_BUF_SIZE +
+				      MAX_NODE_BUF_SIZE));
+				break;
+			}
+			DbgInfo(MODULE_OS_ENTRY, FEATURE_DRIVER_INIT,
+				NOT_TO_RAM, "os alloc dma buf len %x\n",
+				buf_size);
+			ret =
+			    os_alloc_dma_buffer(pdx, NULL, buf_size,
+						&pdx->dma_buff);
+			if (ret == TRUE)
+				break;
+			/* small requirement size */
+			buf_size = buf_size / 2;
+		}
+	}
+
+	return ret;
+
+}
+
+/*
+ * Release pci layer resource
+ */
+static void bht_sd_pci_release(bht_dev_ext_t *pdx)
+{
+	struct pci_dev *pdev = pdx->host.pci_dev.pci_dev;
+
+	free_irq(pdx->host.pci_dev.irq, pdx);
+	if (pdx->host.pci_dev.use_msi)
+		pci_disable_msi(pdev);
+	os_free_dma_buffer(pdx, &pdx->dma_buff);
+	pci_release_regions(pdev);
+	pci_disable_device(pdev);
+}
+
+/*
+ * Update Linux Cfg Setting
+ */
+static void bht_linux_cfg_update(bht_dev_ext_t *pdx)
+{
+	u32 dma_mode = pdx->cfg->host_item.test_dma_mode_setting.dma_mode;
+
+	switch (dma_mode) {
+	case CFG_TRANS_MODE_SDMA:
+	case CFG_TRANS_MODE_ADMA2_SDMA_LIKE:
+	case CFG_TRANS_MODE_PIO:
+	case CFG_TRANS_MODE_ADMA_MIX_SDMA_LIKE:
+		/* don't support tagqueue */
+		pdx->cfg->host_item.test_tag_queue_capability.max_srb = 2;
+		pdx->cfg->host_item.test_tag_queue_capability.enable_srb_merge =
+		    0;
+		break;
+	case CFG_TRANS_MODE_ADMA2:
+	case CFG_TRANS_MODE_ADMA3:
+		break;
+		/* Linux don't support adma3_sdma like mode */
+	case CFG_TRANS_MODE_ADMA3_SDMA_LIKE:
+		pdx->cfg->host_item.test_dma_mode_setting.dma_mode =
+		    CFG_TRANS_MODE_ADMA3;
+		break;
+	default:
+		break;
+	}
+	/* This function is add for degrade frequency for HS400 */
+	if ((*(u32 *) (&pdx->cfg->card_item.emmc_mode)) & BIT13)
+		pdx->cfg->dmdn_tbl[4] = 0x23040000;
+
+	bht_bios_setting(pdx);
+}
+
+/*
+ * pci device remove init
+ */
+static int bht_sd_probe(struct pci_dev *pdev, const struct pci_device_id *pid)
+{
+	bht_sd_slot_t *slot = bht_slot_getfree();
+	bht_dev_ext_t *pdx = &slot->data;
+	int ret = -1;
+
+	DbgInfo(MODULE_OS_ENTRY, FEATURE_DRIVER_INIT, NOT_TO_RAM,
+		"BHT sd probe begin\n");
+	if (slot == NULL) {
+		DbgErr("all slot is used\n");
+		goto exit;
+	}
+
+	ret = bht_pci_init(pdev, &slot->data);
+	if (ret)
+		goto exit;
+
+	pdx->host.pdx = pdx;
+	hostven_chip_type_check(&pdx->host);
+	/* Get the configuration pointer for the specified chip */
+	pdx->cfg = cfgmng_get((void *)pdx, pdx->host.chip_type, FALSE);
+	pdx->host.cfg = pdx->cfg;
+	/*
+	 * Linux Adjust the input parameter
+	 */
+	bht_linux_cfg_update(pdx);
+	os_memset(&pdx->testcase, 0, sizeof(testcase_t));
+	pdx->testcase.test_type = 0;
+
+	if (bht_sd_dma_init(pdx) == FALSE) {
+		ret = -1;
+		DbgErr("DMA Init failed\n");
+		pci_release_regions(pdev);
+		pci_disable_device(pdev);
+		goto exit;
+	}
+
+	req_global_init(pdx);
+	ret = bht_pci_init_irq(pdev, pdx);
+	if (ret) {
+		ret = -1;
+		DbgErr("Irq Init failed\n");
+		os_free_dma_buffer(pdx, &pdx->dma_buff);
+		pci_release_regions(pdev);
+		pci_disable_device(pdev);
+		goto exit;
+	}
+
+	if (pdx->card.card_present)
+		os_set_event(&pdx->os, EVENT_CARD_CHG);
+
+	ret = 0;
+
+exit:
+	if (ret == 0) {
+		slot->used = 1;
+		pci_set_drvdata(pdev, slot);
+#if BHT_LINUX_ENABLE_RTD3
+		bht_sd_runtime_pm_allow(pdx, &pdev->dev);
+#endif
+	}
+
+	DbgInfo(MODULE_OS_ENTRY, FEATURE_DRIVER_INIT, NOT_TO_RAM,
+		"BHT sd probe end ret=%d\n", ret);
+	return ret;
+
+}
+
+/*
+ * pci device remove interface
+ * Thomas change for direct remove
+ */
+void bht_sd_remove(struct pci_dev *pdev)
+{
+	bht_sd_slot_t *slot = pci_get_drvdata(pdev);
+	bht_dev_ext_t *pdx = &slot->data;
+
+	DbgInfo(MODULE_OS_ENTRY, FEATURE_DRIVER_INIT, NOT_TO_RAM,
+		"BHT sd remove begin\n");
+
+	if (slot->used == FALSE)
+		goto exit;
+
+#if BHT_LINUX_ENABLE_RTD3
+	bht_sd_runtime_pm_forbid(pdx, &pdev->dev);
+#endif
+	bht_scsi_uinit(pdx);
+
+	/*
+	 * Thomas comment because it cause AER 0xe6 and block the remove.
+	 *
+	 * if(os_stop_thread(&pdx->os, &pdx->os.thread) == FALSE)
+	 * {
+	 *      DbgErr("stop thread timeout\n");
+	 *      os_kill_thread(&pdx->os, &pdx->os.thread);
+	 * }
+	 *
+	 */
+
+	req_global_uninit(pdx);
+	bht_sd_pci_release(pdx);
+	os_memset(slot, 0, sizeof(bht_sd_slot_t));
+	pci_set_drvdata(pdev, NULL);
+
+exit:
+	DbgInfo(MODULE_OS_ENTRY, FEATURE_DRIVER_INIT, NOT_TO_RAM,
+		"BHT sd remove end\n");
+
+}
+
+/*
+ * pci_dev shutdown interface
+ */
+static void bht_sd_shutdown(struct pci_dev *pdev)
+{
+	bht_sd_slot_t *slot = pci_get_drvdata(pdev);
+	bht_dev_ext_t *pdx = &slot->data;
+
+	if (slot->used == FALSE)
+		return;
+
+	if (os_stop_thread(&pdx->os, &pdx->os.thread) == FALSE) {
+		DbgErr("stop thread timeout\n");
+		os_kill_thread(&pdx->os, &pdx->os.thread);
+	}
+	req_global_uninit(pdx);
+	bht_sd_pci_release(pdx);
+	pci_set_drvdata(pdev, NULL);
+	os_memset(slot, 0, sizeof(bht_sd_slot_t));
+}
+
+static const struct dev_pm_ops bht_sd_pm_ops = {
+	.suspend = bht_sd_suspend,
+	.resume = bht_sd_resume,
+	.freeze = bht_sd_suspend,
+	.thaw = bht_sd_resume,
+	.poweroff = bht_sd_suspend,
+	.restore = bht_sd_resume,
+#if	BHT_LINUX_ENABLE_RTD3
+	SET_RUNTIME_PM_OPS(bht_sd_runtime_suspend,
+			   bht_sd_runtime_resume, bht_sd_runtime_idle)
+#endif
+};
+
+static struct pci_driver bht_sd_pci_driver = {
+	.name = "bht-sd",
+	.id_table = bht_id_table,
+	.probe = bht_sd_probe,
+	.remove = bht_sd_remove,
+	.shutdown = bht_sd_shutdown,
+	.driver = {
+		   .pm = &bht_sd_pm_ops },
+};
+
+/*
+ * Uninit linux global resource
+ */
+static void bht_linux_global_uninit(void)
+{
+	if (bht_sd_mem_pool)
+		mempool_destroy(bht_sd_mem_pool);
+
+	if (bht_srb_ext_cachep)
+		kmem_cache_destroy(bht_srb_ext_cachep);
+
+	bht_srb_ext_cachep = NULL;
+	bht_sd_mem_pool = NULL;
+}
+
+/*
+ * init linux global resource
+ */
+static int bht_linux_global_init(void)
+{
+	int ret = 0;
+
+	bht_srb_ext_cachep = NULL;
+	bht_sd_mem_pool = NULL;
+
+	bht_srb_ext_cachep =
+	    kmem_cache_create("bht-sd-srbext", sizeof(srb_ext_t), 0,
+			      SLAB_HWCACHE_ALIGN, NULL);
+
+	if (bht_srb_ext_cachep == NULL) {
+		ret = -1;
+		DbgErr("Allocate Memory cache failed\n");
+		goto exit;
+	}
+
+	bht_sd_mem_pool =
+	    mempool_create(LINUX_SCSI_MAX_QUEUE_DPETH * 2, mempool_alloc_slab,
+			   mempool_free_slab, bht_srb_ext_cachep);
+exit:
+	if (bht_sd_mem_pool == NULL) {
+		DbgErr("Allocate Memory Pool failed\n");
+		bht_linux_global_uninit();
+		ret = -1;
+	}
+
+	return ret;
+
+}
+
+/*
+ * bht_sd_init - First called function when driver load/insert
+ */
+static int __init bht_sd_init(void)
+{
+	int ret = 0;
+
+	ret = bht_linux_global_init();
+	if (ret)
+		goto exit;
+
+	bht_global_init();
+
+	ret = pci_register_driver(&bht_sd_pci_driver);
+
+exit:
+	if (ret != 0) {
+		bht_linux_global_uninit();
+		DbgErr("Register bht pci driver failed\n");
+		bht_global_uninit();
+	}
+
+	return ret;
+}
+
+/*
+ * bht_sd_exit - First called when dirver unload/remove
+ */
+static void __exit bht_sd_exit(void)
+{
+	pci_unregister_driver(&bht_sd_pci_driver);
+	bht_linux_global_uninit();
+	bht_global_uninit();
+}
+
+/*
+ * Driver parameter and Information
+ */
+
+/* set first call function name when driver insert/load. */
+module_init(bht_sd_init);
+/* set first call function name when driver remove/unload. */
+module_exit(bht_sd_exit);
+MODULE_DESCRIPTION("BayHub SD Card reader device driver");
+MODULE_AUTHOR("BayHub Inc.");
+#if BHT_LINUX_ENABLE_RTD3
+MODULE_LICENSE("GPL");
+#else
+MODULE_LICENSE("GPL");
+#endif
+
+MODULE_VERSION("v1008_00_00");
diff --git a/drivers/scsi/bht/linux_os/linux_scsi.c b/drivers/scsi/bht/linux_os/linux_scsi.c
new file mode 100644
index 000000000000..64b34cc7ad56
--- /dev/null
+++ b/drivers/scsi/bht/linux_os/linux_scsi.c
@@ -0,0 +1,1076 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (c) 2015 BHT Inc.
+ *
+ * File Name: linux_scsi.c
+ *
+ * Abstract: SCSI function
+ *
+ * Version: 1.00
+ *
+ * Author: Peter.Guo
+ *
+ * Environment:	Linux
+ *
+ * History:
+ *
+ * 5/20/2015		Creation	Peter.Guo
+ */
+
+#include <linux/version.h>
+#include <linux/module.h>
+#include <linux/init.h>
+#include <linux/pm.h>
+#include <linux/mempool.h>
+
+#include "../include/basic.h"
+#include "../include/reqapi.h"
+#include "../include/funcapi.h"
+#include "../include/tqapi.h"
+#include "../include/cardapi.h"
+#include "../include/hostapi.h"
+#include "../include/debug.h"
+#include "../include/util.h"
+#include "linux_scsi.h"
+#include "../tagqueue/tq_trans_api.h"
+#include "../include/cmdhandler.h"
+
+extern struct scsi_host_template bht_scsi_template;
+
+static srb_ext_t *bht_scsi_alloc_srb_ext(bht_dev_ext_t *pdx,
+					 struct scsi_cmnd *srb)
+{
+	/* todo use cache to improve performance */
+	srb_ext_t *srb_ext = mempool_alloc(bht_sd_mem_pool, GFP_ATOMIC);
+
+	if (srb_ext == NULL) {
+		DbgErr("alloc srbext is null\n");
+
+		goto exit;
+	}
+	memset(srb_ext, 0, sizeof(srb_ext_t));
+	srb_ext->psrb = srb;
+exit:
+	return srb_ext;
+}
+
+static void bht_scsi_free_srb_ext(bht_dev_ext_t *pdx, srb_ext_t *srb_ext)
+{
+	if (srb_ext != NULL)
+		mempool_free(srb_ext, bht_sd_mem_pool);
+}
+
+/*
+ *	The function to register and Init scsi host
+ */
+bool bht_scsi_init(bht_dev_ext_t *pdx, struct device *dev)
+{
+	bool ret = FALSE;
+	int error = 0;
+
+	DbgInfo(MODULE_OS_ENTRY, FEATURE_FUNC_TRACE, NOT_TO_RAM,
+		"BHT scsi init begin\n");
+
+	if (pdx->scsi_init_flag == 1) {
+		DbgInfo(MODULE_OS_ENTRY, FEATURE_FUNC_TRACE, NOT_TO_RAM,
+			"BHT scsi initialized, and return\n");
+		return TRUE;
+	}
+
+	bht_scsi_template.can_queue = bht_scsi_template.cmd_per_lun =
+	    os_min(pdx->cfg->host_item.test_tag_queue_capability.max_srb,
+		   LINUX_SCSI_MAX_QUEUE_DPETH);
+	pdx->os.scsi_host =
+	    scsi_host_alloc(&bht_scsi_template, sizeof(unsigned long));
+	if (!pdx->os.scsi_host) {
+		DbgErr("Unable to register controller with SCSI subsystem\n");
+		goto exit;
+	}
+
+	pdx->dev = dev;
+	pdx->os.scsi_host->hostdata[0] = (unsigned long)pdx;
+	pdx->os.scsi_host->irq = pdx->host.pci_dev.irq;
+	pdx->os.scsi_host->base = (unsigned long)pdx->host.pci_dev.membase;
+	pdx->os.scsi_host->max_id = 1;
+	pdx->os.scsi_host->max_lun = 1;
+#if LINUX_VERSION_CODE > KERNEL_VERSION(3, 13, 0)
+	pdx->os.scsi_host->no_write_same = 1;
+#endif
+#if LINUX_VERSION_CODE < KERNEL_VERSION(5, 0, 0)
+	pdx->os.scsi_host->use_clustering = 1;
+#endif
+	pdx->os.scsi_host->max_sectors = bht_scsi_template.max_sectors;
+
+	error = scsi_add_host(pdx->os.scsi_host, dev);
+	if (error) {
+		DbgErr("scsi add host failed\n");
+		return FALSE;
+	}
+	scsi_scan_host(pdx->os.scsi_host);
+	pdx->scsi_init_flag = 1;
+	ret = TRUE;
+
+exit:
+	DbgInfo(MODULE_OS_ENTRY, FEATURE_FUNC_TRACE, NOT_TO_RAM,
+		"BHT scsi init end\n");
+	return ret;
+}
+
+/*
+ *	The function to remove scsi host
+ */
+void bht_scsi_uinit(bht_dev_ext_t *pdx)
+{
+	DbgInfo(MODULE_OS_ENTRY, FEATURE_FUNC_TRACE, NOT_TO_RAM,
+		"BHT scsi uinit begin\n");
+	if (pdx->scsi_init_flag == 0) {
+		DbgInfo(MODULE_OS_ENTRY, FEATURE_FUNC_TRACE, NOT_TO_RAM,
+			"BHT scsi uinit excuted,and return\n");
+		return;
+	}
+	if ((pdx != NULL) && (&pdx->os != NULL) && (pdx->os.scsi_host != NULL)) {
+		scsi_remove_host(pdx->os.scsi_host);
+		scsi_host_put(pdx->os.scsi_host);
+		pdx->scsi_init_flag = 0;
+	}
+	DbgInfo(MODULE_OS_ENTRY, FEATURE_FUNC_TRACE, NOT_TO_RAM,
+		"BHT scsi uinit end\n");
+}
+
+/*
+ *	This function is used to save the sense code and fill sense buffer
+ */
+static void bht_scsi_set_sensecode(bht_dev_ext_t *pdx, struct scsi_cmnd *srb,
+				   byte sense_key, byte sense_code)
+{
+	PSENSE_DATA senseBuffer = (PSENSE_DATA) srb->sense_buffer;
+
+	pdx->scsi.sense_key = sense_key;
+	pdx->scsi.sense_code = sense_code;
+
+	if (senseBuffer != NULL && sense_key != 0) {
+		senseBuffer->ErrorCode = 0x70;
+		senseBuffer->AdditionalSenseLength = 0xb;
+		senseBuffer->SenseKey = pdx->scsi.sense_key;
+		senseBuffer->AdditionalSenseCode = pdx->scsi.sense_code;
+		senseBuffer->AdditionalSenseCodeQualifier = 0;
+		DbgInfo(MODULE_OS_ENTRYAPI, FEATURE_SCSICMD_TRACE, NOT_TO_RAM,
+			"%s sense=%d code=%d\n", __func__, sense_key,
+			sense_code);
+	}
+
+}
+
+/*
+ *	Handle Scsi command Test unit ready
+ */
+static void bht_scsi_test_unit_ready(bht_dev_ext_t *pdx, struct scsi_cmnd *srb)
+{
+	if (req_card_ready(pdx)) {
+		srb->result = GOOD;
+	} else {
+		srb->result = CHECK_CONDITION;
+		bht_scsi_set_sensecode(pdx, srb, SCSI_SENSE_NOT_READY,
+				       SCSI_ADSENSE_NO_MEDIA_IN_DEVICE);
+	}
+	DbgInfo(MODULE_OS_ENTRYAPI, FEATURE_SCSICMD_TRACE, NOT_TO_RAM,
+		" %s,  SrbResult:%x\n", __func__, srb->result);
+}
+
+/*
+ *	Handle SCSI Command Request Sense
+ */
+static void bht_scsi_request_sense(bht_dev_ext_t *pdx, struct scsi_cmnd *srb)
+{
+
+	PSENSE_DATA senseBuffer = (PSENSE_DATA) srb->sense_buffer;
+
+	DbgInfo(MODULE_OS_ENTRYAPI, FEATURE_SCSICMD_TRACE, NOT_TO_RAM,
+		"Enter %s\n", __func__);
+	if (senseBuffer == NULL) {
+		srb->result = CHECK_CONDITION;
+	} else {
+		srb->result = GOOD;
+		senseBuffer->ErrorCode = 0x70;
+		senseBuffer->AdditionalSenseLength = 0xb;
+		senseBuffer->SenseKey = pdx->scsi.sense_key;
+		senseBuffer->AdditionalSenseCode = pdx->scsi.sense_code;
+		senseBuffer->AdditionalSenseCodeQualifier = 0;
+		bht_scsi_set_sensecode(pdx, srb, 0, 0);
+	}
+
+	scsi_sg_copy_from_buffer(srb, (byte *) senseBuffer,
+				 os_min(srb->sdb.length, sizeof(SENSE_DATA)));
+	DbgInfo(MODULE_OS_ENTRYAPI, FEATURE_SCSICMD_TRACE, NOT_TO_RAM,
+		"Exit %s, SrbResult=%d\n", __func__, srb->result);
+}
+
+/*
+ *	Handle Mode Sense scsi command
+ */
+static void bht_scsi_exec_modesense(bht_dev_ext_t *pdx, struct scsi_cmnd *srb)
+{
+	MODE_PAGE_HEADER hdr;
+	MODE_PAGE_8 pg_8;
+	MODEPAGE19 pg_9;
+	byte pmdata[512];
+	byte mode_code;
+	sd_card_t *card = &pdx->card;
+
+	DbgInfo(MODULE_OS_ENTRYAPI, FEATURE_SCSICMD_TRACE, NOT_TO_RAM,
+		"Enter %s\n", __func__);
+	memset(pmdata, 0, 512);
+
+	hdr.DataLength = 3;
+	hdr.MediumType = 0x00;
+	hdr.Reserved = 0;
+
+	if (card->write_protected)
+		hdr.Reserved |= 0x80;
+
+	hdr.BlockDescLength = 0;
+	pg_8.PageCode = 0x08;
+	pg_8.PageSavable = 1;
+	pg_8.PageLength = 0x12;
+
+	pg_8.WriteCacheEnable = 1;
+	pg_8.DisablePrefetchTransfer[0] = 0xFF;
+	pg_8.DisablePrefetchTransfer[1] = 0xFF;
+	pg_8.MaximumPrefetch[0] = 0xFF;
+	pg_8.MaximumPrefetch[1] = 0xFF;
+	pg_8.MaximumPrefetchCeiling[0] = 0xFF;
+	pg_8.MaximumPrefetchCeiling[1] = 0xFF;
+	pg_8.NumberofCacheSegments = 0x20;
+
+	pg_9.PageCode = 0x19;
+	pg_9.PageSavable = 1;
+	pg_9.PageLength = 0x04;
+	pg_9.ProtocolIdentifier = 0x0A;
+	pg_9.SynchronousTransferTimeout[0] = 0x00;
+	pg_9.SynchronousTransferTimeout[1] = 0x01;
+
+	mode_code = srb->cmnd[2];
+
+	switch (mode_code) {
+	case 0x08:
+		hdr.DataLength += sizeof(MODE_PAGE_8);
+		memcpy(pmdata, &hdr, sizeof(MODE_PAGE_HEADER));
+		memcpy(pmdata + sizeof(MODE_PAGE_HEADER), &pg_8,
+		       sizeof(MODE_PAGE_8));
+		break;
+	case 0x19:
+		hdr.DataLength += sizeof(MODEPAGE19);
+		memcpy(pmdata, &hdr, sizeof(MODE_PAGE_HEADER));
+		memcpy(pmdata + sizeof(MODE_PAGE_HEADER), &pg_9,
+		       sizeof(MODEPAGE19));
+		break;
+	case 0x3F:
+		hdr.DataLength += (sizeof(MODEPAGE19) + sizeof(MODE_PAGE_8));
+		memcpy(pmdata, &hdr, sizeof(MODE_PAGE_HEADER));
+		memcpy(pmdata + sizeof(MODE_PAGE_HEADER), &pg_8,
+		       sizeof(MODE_PAGE_8));
+		memcpy(pmdata + sizeof(MODE_PAGE_HEADER) + sizeof(MODE_PAGE_8),
+		       &pg_9, sizeof(MODEPAGE19));
+		break;
+	default:
+		break;
+	}
+
+	srb->result = GOOD;
+	scsi_sg_copy_from_buffer(srb, pmdata, os_min(srb->sdb.length, 512));
+	DbgInfo(MODULE_OS_ENTRYAPI, FEATURE_SCSICMD_TRACE, NOT_TO_RAM,
+		"Exit %s\n", __func__);
+}
+
+/*
+ *	Handle SCSI Command Allow Removalabe
+ */
+static void bht_scsi_allow_removal(bht_dev_ext_t *pdx, struct scsi_cmnd *srb)
+{
+	byte prevent = srb->cmnd[4] & 0x3;
+
+	DbgInfo(MODULE_OS_ENTRYAPI, FEATURE_SCSICMD_TRACE, NOT_TO_RAM,
+		"Enter %s prevent=%d\n", __func__, prevent);
+	if (req_card_ready(pdx) == FALSE) {
+		srb->result = CHECK_CONDITION;
+
+		bht_scsi_set_sensecode(pdx, srb, SCSI_SENSE_NOT_READY,
+				       SCSI_ADSENSE_NO_MEDIA_IN_DEVICE);
+	} else {
+		srb->result = GOOD;
+		if (prevent == 0x01 || prevent == 0x11)
+			pdx->scsi.prevent_eject = 1;
+		else
+			pdx->scsi.prevent_eject = 0;
+	}
+	DbgInfo(MODULE_OS_ENTRYAPI, FEATURE_SCSICMD_TRACE, NOT_TO_RAM,
+		"Exit %s\n", __func__);
+}
+
+static bool bht_scsi_error_handle(bht_dev_ext_t *pdx, struct scsi_cmnd *srb,
+				  e_req_result result)
+{
+	bool ret = TRUE;
+
+	if (result == REQ_RESULT_PENDING) {
+	} else if (result == REQ_RESULT_QUEUE_BUSY) {
+	} else if (result == REQ_RESULT_NO_CARD) {
+		srb->result = CHECK_CONDITION;
+		bht_scsi_set_sensecode(pdx, srb, SCSI_SENSE_NOT_READY,
+				       SCSI_ADSENSE_NO_MEDIA_IN_DEVICE);
+	} else if (result == REQ_RESULT_PROTECTED) {
+		srb->result = CHECK_CONDITION;
+		bht_scsi_set_sensecode(pdx, srb, SCSI_SENSE_DATA_PROTECT,
+				       SCSI_ADSENSE_WRITE_PROTECT);
+	} else {
+		srb->result = CHECK_CONDITION;
+		bht_scsi_set_sensecode(pdx, srb, SCSI_SENSE_ILLEGAL_REQUEST,
+				       SCSI_ADSENSE_ILLEGAL_BLOCK);
+	}
+
+	DbgInfo(MODULE_OS_ENTRYAPI, FEATURE_SCSICMD_TRACE, NOT_TO_RAM,
+		" %s, SrbResult:%x\n", __func__, srb->result);
+	return ret;
+}
+
+/*
+ *	Fill Capacity Data
+ */
+static void bht_scsi_get_capacity(bht_dev_ext_t *pdx, u32 secnt,
+				  struct scsi_cmnd *srb)
+{
+	READ_CAPACITY_DATA capacity;
+	PREAD_CAPACITY_DATA pcapacity = &capacity;
+
+	DbgInfo(MODULE_OS_ENTRYAPI, FEATURE_SCSICMD_TRACE, NOT_TO_RAM,
+		"Enter %s\n", __func__);
+
+	memset(pcapacity, 0, sizeof(READ_CAPACITY_DATA));
+	/* Big Endian for Capacity data */
+	pcapacity->LogicalBlockAddress = swapu32((secnt > 0) ? (secnt - 1) : 0);
+	/* Big Endian for Capacity data */
+	pcapacity->BytesPerBlock = swapu32(SD_BLOCK_LEN);
+	srb->result = GOOD;
+	scsi_sg_copy_from_buffer(srb, pcapacity,
+				 os_min(srb->sdb.length,
+					sizeof(READ_CAPACITY_DATA)));
+	DbgInfo(MODULE_OS_ENTRYAPI, FEATURE_SCSICMD_TRACE, NOT_TO_RAM,
+		"Exit %s, capacity:%x\n", __func__,
+		pcapacity->LogicalBlockAddress);
+}
+
+/*
+ *	Fill Inquriy Data function
+ */
+static void bht_scsi_get_inquiry(bht_dev_ext_t *pdx, e_card_type card_type,
+				 struct scsi_cmnd *srb)
+{
+	_INQUIRYDATA inqdata;
+	_INQUIRYDATA *pinqdata = &inqdata;
+
+	DbgInfo(MODULE_OS_ENTRYAPI, FEATURE_SCSICMD_TRACE, NOT_TO_RAM,
+		"Enter %s\n", __func__);
+
+	os_memset(pinqdata, 0, sizeof(_INQUIRYDATA));
+	/* TYPE_DISK; */
+	pinqdata->DeviceType = 0x00;
+
+	pinqdata->Versions = 0x00;
+	pinqdata->ResponseDataFormat = 0x02;
+	pinqdata->AdditionalLength = sizeof(_INQUIRYDATA) - 4;
+	strncpy((char *)(pinqdata->VendorId), "BHT-SD ", 8);
+	switch (card_type) {
+	case CARD_SDIO:
+		strncpy((char *)(pinqdata->ProductId), "SDIO ", 5);
+		break;
+	case CARD_SD:
+	case CARD_UHS2:
+		strncpy((char *)(pinqdata->ProductId), "SD ", 3);
+		break;
+	case CARD_EMMC:
+	case CARD_MMC:
+		strncpy((char *)(pinqdata->ProductId), "MMC ", 4);
+		break;
+	case CARD_TEST:
+		strncpy((char *)(pinqdata->ProductId), "TestCR ", 6);
+		break;
+	default:
+		strncpy((char *)(pinqdata->ProductId), "CR              ", 16);
+		break;
+	}
+	strncpy((char *)(pinqdata->ProductRevisionLevel), "104a", 4);
+	srb->result = GOOD;
+	scsi_sg_copy_from_buffer(srb, pinqdata,
+				 os_min(srb->sdb.length, sizeof(_INQUIRYDATA)));
+	DbgInfo(MODULE_OS_ENTRYAPI, FEATURE_SCSICMD_TRACE, NOT_TO_RAM,
+		"Exit %s\n", __func__);
+}
+
+/*
+ *	Callback for basci scsi command
+ */
+static void bht_scsi_srb_basic_cmd_done(void *p, void *srb_ext)
+{
+	srb_ext_t *p_srb_ext = srb_ext;
+	bht_dev_ext_t *pdx = p;
+	struct scsi_cmnd *srb = p_srb_ext->psrb;
+	sd_card_t *card = &pdx->card;
+
+	DbgInfo(MODULE_OS_ENTRYAPI, FEATURE_SCSICMD_TRACE, NOT_TO_RAM,
+		"Enter %s\n", __func__);
+	if (srb == NULL) {
+		pdx->p_srb_ext = NULL;
+		goto exit;
+	}
+	if (p_srb_ext->req.result != REQ_RESULT_OK) {
+		srb->result = CHECK_CONDITION;
+		bht_scsi_set_sensecode(pdx, srb, SCSI_SENSE_NOT_READY,
+				       SCSI_ADSENSE_NO_MEDIA_IN_DEVICE);
+		goto end;
+	}
+
+	switch (srb->cmnd[0]) {
+	case INQUIRY:
+		{
+			bht_scsi_get_inquiry(pdx, card->card_type, srb);
+			break;
+		}
+	case READ_CAPACITY:
+		{
+			bht_scsi_get_capacity(pdx, (u32) card->sec_count, srb);
+			break;
+		}
+	case START_STOP:
+		{
+			srb->result = GOOD;
+			break;
+		}
+	default:
+		break;
+	}
+
+end:
+	bht_scsi_free_srb_ext(pdx, srb_ext);
+	pdx->p_srb_ext = NULL;
+
+	scsi_done(srb);
+exit:
+	DbgInfo(MODULE_OS_ENTRYAPI, FEATURE_SCSICMD_TRACE, NOT_TO_RAM,
+		"Exit %s\n", __func__);
+}
+
+/*
+ *	handle start stop scsi command
+ *	return true means done while return false means pending
+ */
+static bool bht_scsi_load_unload(bht_dev_ext_t *pdx, struct scsi_cmnd *srb,
+				 bool *busy)
+{
+	bool ret = TRUE;
+	byte load = srb->cmnd[4] & 0x01;
+	byte loej = srb->cmnd[4] & 0x02;
+	e_req_result result = REQ_RESULT_OK;
+	srb_ext_t *srb_ext = NULL;
+
+	DbgInfo(MODULE_OS_ENTRYAPI, FEATURE_SCSICMD_TRACE, NOT_TO_RAM,
+		"Enter %s load=%d loej=%d\n", __func__, load, loej);
+
+	if (loej == 0) {
+		srb->result = GOOD;
+		goto exit;
+	}
+
+	if (load) {
+		/*
+		 * For Load command we don't need use thread
+		 * because card access module can Init card
+		 */
+
+		pdx->scsi.scsi_eject = 0;
+		srb->result = GOOD;
+
+		if (req_card_ready(pdx) == FALSE) {
+			srb->result = CHECK_CONDITION;
+			DbgErr("Scsi load failed\n");
+			bht_scsi_set_sensecode(pdx, srb, SCSI_SENSE_NOT_READY,
+					       SCSI_ADSENSE_NO_MEDIA_IN_DEVICE);
+		}
+		goto exit;
+	} else {
+		/* already ejected */
+		if (pdx->scsi.scsi_eject) {
+			srb->result = GOOD;
+			goto exit;
+		}
+		/* eject is not allowed */
+		else if (pdx->scsi.prevent_eject) {
+			srb->result = CHECK_CONDITION;
+			bht_scsi_set_sensecode(pdx, srb,
+					       SCSI_SENSE_ILLEGAL_REQUEST,
+					       SCSI_ADSENSE_ILLEGAL_COMMAND);
+			goto exit;
+		}
+	}
+
+	/* below code is for unload operation       */
+	srb_ext = bht_scsi_alloc_srb_ext(pdx, srb);
+	if (srb_ext == NULL) {
+		result = REQ_RESULT_ABORT;
+		goto exit;
+	}
+	srb_ext->req.data_dir = DATA_DIR_NONE;
+	srb_ext->req.srb_buff = NULL;
+	srb_ext->req.srb_sg_len = 0;
+	srb_ext->req.gen_req_t.code = GEN_IO_CODE_EJECT;
+	srb_ext->req.gen_req_t.arg1 = load;
+	srb_ext->req.srb_done_cb = bht_scsi_srb_basic_cmd_done;
+	result = req_eject(pdx, srb_ext);
+
+	if (result == REQ_RESULT_OK) {
+		pdx->scsi.scsi_eject = 1;
+		srb->result = GOOD;
+	} else {
+		bht_scsi_error_handle(pdx, srb, result);
+		/* cmd handle by thread case */
+		if (result == REQ_RESULT_PENDING)
+			pdx->scsi.scsi_eject = 1;
+	}
+
+exit:
+	if (result == REQ_RESULT_PENDING) {
+		*busy = TRUE;
+		ret = FALSE;
+	} else {
+		if (result == REQ_RESULT_QUEUE_BUSY)
+			*busy = TRUE;
+		bht_scsi_free_srb_ext(pdx, srb_ext);
+	}
+	DbgInfo(MODULE_OS_ENTRYAPI, FEATURE_SCSICMD_TRACE, NOT_TO_RAM,
+		"Enter %s, ret:%x\n", __func__, ret);
+	return ret;
+}
+
+/*
+ *	Handle Inquriy scsi command
+ *	return true means done while return false means pending
+ */
+static bool bht_scsi_exec_inquiry(bht_dev_ext_t *pdx, struct scsi_cmnd *srb,
+				  bool *busy)
+{
+
+	e_req_result result = REQ_RESULT_NO_CARD;
+	sd_card_t *card = &pdx->card;
+	srb_ext_t *srb_ext = NULL;
+	bool ret = TRUE;
+
+	DbgInfo(MODULE_OS_ENTRYAPI, FEATURE_SCSICMD_TRACE, NOT_TO_RAM,
+		"Enter %s\n", __func__);
+
+	srb_ext = bht_scsi_alloc_srb_ext(pdx, srb);
+	if (srb_ext == NULL) {
+		result = REQ_RESULT_ABORT;
+		goto exit;
+	}
+	srb_ext->req.data_dir = DATA_DIR_IN;
+	/* the callback will handle the data itself */
+	srb_ext->req.srb_buff = NULL;
+	srb_ext->req.gen_req_t.code = GEN_IO_CODE_INIT_CARD;
+	srb_ext->req.srb_done_cb = bht_scsi_srb_basic_cmd_done;
+	result = req_chk_card_info(pdx, srb_ext);
+
+	if (result == REQ_RESULT_OK) {
+		bht_scsi_get_inquiry(pdx, card->card_type, srb);
+	} else {
+		if (result == REQ_RESULT_QUEUE_BUSY)
+			*busy = TRUE;
+		bht_scsi_error_handle(pdx, srb, result);
+	}
+exit:
+	if (result == REQ_RESULT_PENDING)
+		ret = FALSE;
+	else
+		bht_scsi_free_srb_ext(pdx, srb_ext);
+
+	DbgInfo(MODULE_OS_ENTRYAPI, FEATURE_SCSICMD_TRACE, NOT_TO_RAM,
+		"Exit %s, ret:%x\n", __func__, ret);
+	return ret;
+}
+
+/*
+ *	Handle GetCapacity scsi command
+ *	return true means done while return false means pending
+ */
+static bool bht_scsi_exec_capacity(bht_dev_ext_t *pdx, struct scsi_cmnd *srb,
+				   bool *busy)
+{
+	e_req_result result = REQ_RESULT_NO_CARD;
+	sd_card_t *card = &pdx->card;
+	srb_ext_t *srb_ext;
+
+	bool ret = TRUE;
+
+	DbgInfo(MODULE_OS_ENTRYAPI, FEATURE_SCSICMD_TRACE, NOT_TO_RAM,
+		"Enter %s\n", __func__);
+
+	srb_ext = bht_scsi_alloc_srb_ext(pdx, srb);
+	if (srb_ext == NULL) {
+		result = REQ_RESULT_ABORT;
+		goto exit;
+	}
+	srb_ext->req.data_dir = DATA_DIR_IN;
+	/* the callback will handle the data itself */
+	srb_ext->req.srb_buff = NULL;
+	srb_ext->req.srb_sg_len = 0;
+	srb_ext->req.gen_req_t.code = GEN_IO_CODE_INIT_CARD;
+	srb_ext->req.srb_done_cb = bht_scsi_srb_basic_cmd_done;
+
+	result = req_chk_card_info(pdx, srb_ext);
+
+	if (result == REQ_RESULT_OK) {
+		bht_scsi_get_capacity(pdx, (u32) (card->sec_count), srb);
+	} else {
+		if (result == REQ_RESULT_QUEUE_BUSY)
+			*busy = TRUE;
+		bht_scsi_error_handle(pdx, srb, result);
+	}
+exit:
+	if (result == REQ_RESULT_PENDING)
+		ret = FALSE;
+	else
+		bht_scsi_free_srb_ext(pdx, srb_ext);
+
+	DbgInfo(MODULE_OS_ENTRYAPI, FEATURE_SCSICMD_TRACE, NOT_TO_RAM,
+		"Exit %s, ret:%x\n", __func__, ret);
+	return ret;
+}
+
+/*
+ *	Helper function to get rw parameter
+ */
+static void bht_scsi_get_rw_parameter(byte *cdb, u32 *pStartBlock,
+				      u32 *pBlockCount)
+{
+	byte array[4];
+
+	array[0] = cdb[5];
+	array[1] = cdb[4];
+	array[2] = cdb[3];
+	array[3] = cdb[2];
+	*pStartBlock = *((u32 *) &array);
+
+	array[0] = cdb[8];
+	array[1] = cdb[7];
+	array[2] = 0;
+	array[3] = 0;
+	*pBlockCount = *((u32 *) &array);
+
+	DbgInfo(MODULE_OS_ENTRYAPI, FEATURE_RW_TRACE, NOT_TO_RAM,
+		"%s, StartBlock:%x, BlockCount:%x\n", __func__,
+		*pStartBlock, *pBlockCount);
+}
+
+/*
+ *	Call back for Tagged io and scsi rw
+ */
+static void bht_scsi_srb_tagio_done(void *p, void *srb_ext)
+{
+	srb_ext_t *p_srb_ext = srb_ext;
+	srb_ext_t *p_srb_ext_1 = p_srb_ext;
+	srb_ext_t *p_srb_ext_2 = NULL;
+	bht_dev_ext_t *pdx = p;
+	struct scsi_cmnd *srb = p_srb_ext->psrb;
+
+	DbgInfo(MODULE_OS_ENTRYAPI, FEATURE_RW_TRACE, NOT_TO_RAM, "Enter %s\n",
+		__func__);
+	if (srb == NULL) {
+		pdx->p_srb_ext = NULL;
+		DbgErr("tagio complete called with srb is null\n");
+		goto exit;
+	}
+
+	srb->result = CHECK_CONDITION;
+
+	switch (p_srb_ext->req.result) {
+	case REQ_RESULT_OK:
+		{
+			if (p_srb_ext->prev != NULL) {
+				p_srb_ext_1 = p_srb_ext->prev;
+				p_srb_ext_2 = p_srb_ext;
+				DbgInfo(MODULE_OS_ENTRYAPI, FEATURE_RW_TRACE,
+					NOT_TO_RAM,
+					"p_srb_ext_2: dir=%d, sec_cnt=%d, sec_addr=0x%x, p_srb_ext_1=%p\n",
+					p_srb_ext_2->req.data_dir,
+					p_srb_ext_2->req.tag_req_t.sec_cnt,
+					p_srb_ext_2->req.tag_req_t.sec_addr,
+					p_srb_ext_2->prev);
+			} else if (p_srb_ext->req.data_dir == DATA_DIR_IN
+				   && p_srb_ext->req.tag_req_t.sec_cnt > 1
+				   && (p_srb_ext->req.tag_req_t.sec_addr +
+				       p_srb_ext->req.tag_req_t.sec_cnt ==
+				       pdx->card.sec_count)) {
+				p_srb_ext_1 = p_srb_ext;
+				p_srb_ext_2 = bht_scsi_alloc_srb_ext(pdx, srb);
+				if (p_srb_ext_2 == NULL) {
+					DbgErr
+					    ("Failed when alloc srb_ext_2 for read latest block\n");
+				} else {
+					p_srb_ext_2->prev = p_srb_ext_1;
+					p_srb_ext_1->next = p_srb_ext_2;
+					p_srb_ext_2->req.data_dir = DATA_DIR_IN;
+					p_srb_ext_2->req.tag_req_t.sec_cnt = 1;
+					p_srb_ext_2->req.tag_req_t.sec_addr =
+					    pdx->card.sec_count - 1;
+					p_srb_ext_2->req.tag_req_t.use_cmd = 0;
+					p_srb_ext_2->req.srb_done_cb =
+					    bht_scsi_srb_tagio_done;
+					p_srb_ext_2->req.srb_buff =
+					    (PVOID) ((unsigned long long)
+						     p_srb_ext->req.srb_buff +
+						     (p_srb_ext->req.tag_req_t.sec_cnt -
+						      1) * SD_BLOCK_LEN);
+				}
+			}
+			if (FALSE ==
+			    cfg_dma_need_sdma_like_buffer(pdx->cfg->host_item.test_dma_mode_setting.dma_mode)) {
+				if (p_srb_ext_2 == NULL
+				    || p_srb_ext_2 == p_srb_ext)
+					os_free_sg_list(pdx, srb);
+				else {
+					if (p_srb_ext_1->req.srb_sg_list[p_srb_ext_1->req.srb_sg_len -
+							    1].Length >=
+					    SD_BLOCK_LEN) {
+						p_srb_ext_2->req.srb_sg_len = 1;
+						p_srb_ext_2->req.srb_sg_list[0].Address =
+						    p_srb_ext_1->req.srb_sg_list
+						    [p_srb_ext_1->req.srb_sg_len - 1].Address +
+						    p_srb_ext_1->req.srb_sg_list
+						    [p_srb_ext_1->req.srb_sg_len - 1].Length -
+						    SD_BLOCK_LEN;
+						p_srb_ext_2->req.srb_sg_list[0].Length =
+						    SD_BLOCK_LEN;
+					} else {
+						DbgErr
+						    ("sg list latest record size is %d, less than SD block size\n",
+						     p_srb_ext_1->req.srb_sg_list
+						     [p_srb_ext_1->req.srb_sg_len
+						      - 1].Length);
+						bht_scsi_free_srb_ext(pdx,
+								      p_srb_ext_2);
+						p_srb_ext_1->next = NULL;
+						p_srb_ext_2 = NULL;
+					}
+				}
+			} else {
+				if (p_srb_ext->req.data_dir == DATA_DIR_IN) {
+					if (p_srb_ext_2 == NULL
+					    || p_srb_ext_2 == p_srb_ext)
+						scsi_sg_copy_from_buffer(srb,
+									 p_srb_ext->req.srb_buff,
+									 srb->sdb.length);
+				}
+			}
+			srb->result = GOOD;
+			break;
+		}
+	case REQ_RESULT_NO_CARD:
+	case REQ_RESULT_ABORT:
+		{
+			bht_scsi_set_sensecode(pdx, srb, SCSI_SENSE_NOT_READY,
+					       SCSI_ADSENSE_NO_MEDIA_IN_DEVICE);
+			break;
+		}
+	case REQ_RESULT_PROTECTED:
+		{
+			bht_scsi_set_sensecode(pdx, srb,
+					       SCSI_SENSE_DATA_PROTECT,
+					       SCSI_ADSENSE_WRITE_PROTECT);
+			break;
+		}
+		/* RW error case */
+	default:
+		{
+			bht_scsi_set_sensecode(pdx, srb,
+					       SCSI_SENSE_UNIT_ATTENTION, 0);
+			break;
+		}
+
+	}
+
+	/* tag queue is empty we need to set device to free status */
+	if (tq_is_empty(pdx)) {
+		func_autotimer_start(pdx);
+		if (pdx->host.feature.hw_led_fix == 0)
+			host_led_ctl(&pdx->host, FALSE);
+	}
+
+	if (p_srb_ext_2 == NULL || p_srb_ext_2 == p_srb_ext) {
+		DbgInfo(MODULE_OS_ENTRYAPI, FEATURE_RW_TRACE, NOT_TO_RAM,
+			"scsi io done for srb(%p)\n", srb);
+		bht_scsi_free_srb_ext(pdx, p_srb_ext_2);
+		bht_scsi_free_srb_ext(pdx, p_srb_ext_1);
+		pdx->p_srb_ext = NULL;
+
+		scsi_done(srb);
+	} else {
+		int result = req_tag_io_add(pdx, p_srb_ext_2);
+
+		if (result != REQ_RESULT_OK)
+			bht_scsi_error_handle(pdx, srb, result);
+
+		if (result == REQ_RESULT_PENDING) {
+			DbgInfo(MODULE_OS_ENTRYAPI, FEATURE_RW_TRACE,
+				NOT_TO_RAM,
+				"add srb_ext_2(%p) of srb(%p) to tag io queue\n",
+				p_srb_ext_2, srb);
+		} else {
+			DbgErr("Failed to add srb_ext_2 %p to tag io queue\n",
+			       p_srb_ext_2);
+			bht_scsi_free_srb_ext(pdx, p_srb_ext_1);
+			pdx->p_srb_ext = NULL;
+
+			scsi_done(srb);
+		}
+	}
+
+#ifdef DBG_PERFORMANCE
+	calc_io_end(&pdx->tick);
+#endif
+
+exit:
+	DbgInfo(MODULE_OS_ENTRYAPI, FEATURE_RW_TRACE, NOT_TO_RAM, "Exit %s\n",
+		__func__);
+}
+
+/*
+ *	Handle Read10 and Write10 scsi command
+ *	return true means done while return false means pending
+ */
+static bool bht_scsi_exec_rw(bht_dev_ext_t *pdx, struct scsi_cmnd *srb,
+			     bool bWrite, bool *busy)
+{
+	e_req_result result = REQ_RESULT_NO_CARD;
+	srb_ext_t *srb_ext;
+	bool ret = TRUE;
+
+	DbgInfo(MODULE_OS_ENTRYAPI, FEATURE_RW_TRACE, NOT_TO_RAM, "Enter %s\n",
+		__func__);
+	srb_ext = bht_scsi_alloc_srb_ext(pdx, srb);
+	if (srb_ext == NULL) {
+		result = REQ_RESULT_ABORT;
+		goto exit;
+	}
+	srb_ext->psrb = srb;
+	srb_ext->req.data_dir = bWrite ? DATA_DIR_OUT : DATA_DIR_IN;
+	srb_ext->req.srb_buff = pdx->os.virt_buff;
+	if (FALSE ==
+	    cfg_dma_need_sdma_like_buffer(pdx->cfg->host_item.test_dma_mode_setting.dma_mode))
+		srb_ext->req.srb_sg_len =
+		    os_get_sg_list(pdx, srb, srb_ext->req.srb_sg_list);
+	else {
+		if (bWrite)
+			scsi_sg_copy_to_buffer(srb, srb_ext->req.srb_buff,
+					       srb->sdb.length);
+		srb_ext->req.srb_sg_len = 0;
+	}
+	srb_ext->req.srb_done_cb = bht_scsi_srb_tagio_done;
+	srb_ext->req.tag_req_t.use_cmd = 0;
+
+	/*
+	 * Get Scsi parameter for RW
+	 */
+	bht_scsi_get_rw_parameter(srb->cmnd,
+				  &srb_ext->req.tag_req_t.sec_addr,
+				  &srb_ext->req.tag_req_t.sec_cnt);
+	calc_req_start(&pdx->tick, srb_ext->req.tag_req_t.sec_cnt, bWrite);
+
+	/* Workaround for GG8 chip DDR200 write operation: timing issue */
+	if (bWrite && pdx->host.chip_type == CHIP_GG8
+	    && pdx->card.info.sw_cur_setting.sd_access_mode ==
+	    SD_FNC_AM_DDR200) {
+		DbgInfo(MODULE_OS_ENTRYAPI, FEATURE_RW_TRACE, NOT_TO_RAM,
+			"Enter GG8 DDR200 workaround patch\n");
+		if (tq_judge_request_continuous
+		    (card_is_low_capacity(&pdx->card), pdx->last_req.data_dir,
+		     pdx->last_req.sec_addr, pdx->last_req.sec_cnt,
+		     srb_ext->req.data_dir,
+		     srb_ext->req.tag_req_t.sec_addr) == FALSE) {
+			DbgInfo(MODULE_OS_ENTRYAPI, FEATURE_RW_TRACE,
+				NOT_TO_RAM,
+				"Set flag to add NOP descriptor table\n");
+			srb_ext->req.gg8_ddr200_workaround = 1;
+		} else
+			srb_ext->req.gg8_ddr200_workaround = 0;
+
+	} else
+		srb_ext->req.gg8_ddr200_workaround = 0;
+
+	pdx->last_req.data_dir = srb_ext->req.data_dir;
+	pdx->last_req.sec_addr = srb_ext->req.tag_req_t.sec_addr;
+	pdx->last_req.sec_cnt = srb_ext->req.tag_req_t.sec_cnt;
+
+	result = req_tag_io_add(pdx, srb_ext);
+
+exit:
+	if (result != REQ_RESULT_OK)
+		bht_scsi_error_handle(pdx, srb, result);
+
+	if (result == REQ_RESULT_PENDING)
+		ret = FALSE;
+	else {
+		if (result == REQ_RESULT_QUEUE_BUSY)
+			*busy = TRUE;
+		bht_scsi_free_srb_ext(pdx, srb_ext);
+	}
+	DbgInfo(MODULE_OS_ENTRYAPI, FEATURE_RW_TRACE, NOT_TO_RAM,
+		"Exit %s, ret:%x\n", __func__, ret);
+	return ret;
+}
+
+/*
+ *	The Entry to handle SCSI command
+ */
+static int bht_scsi_queuecommand_lck(struct scsi_cmnd *srb)
+{
+	bht_dev_ext_t *pdx = (bht_dev_ext_t *) (srb->device->host->hostdata[0]);
+	bool cmd_done = TRUE;
+	bool dev_busy = FALSE;
+
+	DbgInfo(MODULE_OS_ENTRYAPI, FEATURE_RW_TRACE, NOT_TO_RAM, "Enter %s\n",
+		__func__);
+
+	if (pdx->signature != BHT_PDX_SIGNATURE) {
+		DbgErr("bht scsi queuecommand pdx signature is wrong\n");
+		return SCSI_MLQUEUE_HOST_BUSY;
+	}
+
+	if (srb->cmnd == NULL) {
+		DbgErr
+		    ("bhtscsi_queuecommand srb->cmnd is NULL, cmd_len is %d ,srb %p\n",
+		     srb->cmd_len, srb);
+		return SCSI_RETURN_NOT_HANDLED;
+	}
+
+	srb->result = 0;
+	func_thermal_update_time(pdx);
+
+	switch (srb->cmnd[0]) {
+	case TEST_UNIT_READY:
+		{
+			bht_scsi_test_unit_ready(pdx, srb);
+			break;
+		}
+	case REQUEST_SENSE:
+		{
+			bht_scsi_request_sense(pdx, srb);
+			break;
+		}
+	case INQUIRY:
+		{
+			cmd_done = bht_scsi_exec_inquiry(pdx, srb, &dev_busy);
+			break;
+		}
+	case READ_CAPACITY:
+		{
+			cmd_done = bht_scsi_exec_capacity(pdx, srb, &dev_busy);
+			break;
+		}
+	case READ_10:
+		{
+			cmd_done = bht_scsi_exec_rw(pdx, srb, FALSE, &dev_busy);
+			break;
+		}
+	case WRITE_10:
+		{
+			cmd_done = bht_scsi_exec_rw(pdx, srb, TRUE, &dev_busy);
+			break;
+		}
+	case MODE_SENSE:
+		{
+			bht_scsi_exec_modesense(pdx, srb);
+			break;
+		}
+	case VERIFY:
+	case SEND_DIAGNOSTIC:
+	case SYNCHRONIZE_CACHE:
+		{
+			srb->result = GOOD;
+
+			scsi_done(srb);
+			break;
+		}
+	case START_STOP:
+		{
+			cmd_done = bht_scsi_load_unload(pdx, srb, &dev_busy);
+			break;
+		}
+
+	case ALLOW_MEDIUM_REMOVAL:
+		{
+			bht_scsi_allow_removal(pdx, srb);
+			break;
+		}
+
+	default:
+		{
+			srb->result = CHECK_CONDITION;
+			bht_scsi_set_sensecode(pdx, srb,
+					       SCSI_SENSE_ILLEGAL_REQUEST,
+					       SCSI_ADSENSE_ILLEGAL_COMMAND);
+			break;
+		}
+	}
+
+	if (cmd_done && dev_busy == FALSE)
+		scsi_done(srb);
+	else if (dev_busy)
+		return SCSI_MLQUEUE_DEVICE_BUSY;
+	return 0;
+
+}
+
+static enum scsi_timeout_action bht_scsi_eh_timeout(struct scsi_cmnd *srb)
+{
+#if LINUX_VERSION_CODE >= KERNEL_VERSION(4, 18, 0)
+	enum scsi_timeout_action retval = SCSI_EH_DONE;
+#else
+	enum blk_eh_timer_return retval = BLK_EH_NOT_HANDLED;
+#endif
+
+	bht_dev_ext_t *pdx = (bht_dev_ext_t *) (srb->device->host->hostdata[0]);
+
+	/* todo It is may not safer for busreset is at high IRQL; and one event to slove this */
+	DbgErr("SCSI eh_timeout Enter\n");
+	if (os_pending_thread(pdx, TRUE) == FALSE)
+		DbgErr("bus rest pending thread failed\n");
+	func_autotimer_stop(pdx);
+	card_power_off(&pdx->card, TRUE);
+	host_init(&pdx->host);
+	req_cancel_all_io(pdx);
+	os_pending_thread(pdx, FALSE);
+	DbgErr("SCSI eh_timeout Exit\n");
+
+	return retval;
+}
+
+static DEF_SCSI_QCMD(bht_scsi_queuecommand)
+/*
+ * this defines our 'SCSI host'
+ */
+struct scsi_host_template bht_scsi_template = {
+	.name = "BHT SD Card Reader",
+	.module = THIS_MODULE,
+	.proc_name = "bht_scsi_host",
+	.queuecommand = bht_scsi_queuecommand,
+	.eh_timed_out = bht_scsi_eh_timeout,
+	.can_queue = 1,
+	.this_id = -1,
+	.sg_tablesize = SG_ALL,
+	.max_sectors = CFG_MAX_TRANSFER_LENGTH / SD_BLOCK_LEN,
+	.cmd_per_lun = 1,
+
+#if LINUX_VERSION_CODE < KERNEL_VERSION(5, 0, 0)
+	.use_clustering = TRUE,
+#endif
+
+	.emulated = FALSE,
+};
diff --git a/drivers/scsi/bht/linux_os/linux_scsi.h b/drivers/scsi/bht/linux_os/linux_scsi.h
new file mode 100644
index 000000000000..0b4d2a8bd5db
--- /dev/null
+++ b/drivers/scsi/bht/linux_os/linux_scsi.h
@@ -0,0 +1,239 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (c) 2015 BHT Inc.
+ *
+ * File Name: linux_scsi.h
+ *
+ * Abstract: SCSI function
+ *
+ * Version: 1.00
+ *
+ * Author: Peter.Guo
+ *
+ * Environment:	Linux
+ *
+ * History:
+ *
+ * 5/20/2015		Creation	Peter.Guo
+ */
+
+#ifndef _BHT_SCSI_H
+#define _BHT_SCSI_H
+
+#define LINUX_SCSI_MAX_QUEUE_DPETH	32
+
+bool bht_scsi_init(bht_dev_ext_t *pdx, struct device *dev);
+void bht_scsi_uinit(bht_dev_ext_t *pdx);
+
+typedef struct {
+	byte ErrorCode;
+	byte Reserved;
+	byte SenseKey;
+	byte Infomation[4];
+	byte AdditionalSenseLength;
+	byte CommandSpecInfo[4];
+	byte AdditionalSenseCode;
+	byte AdditionalSenseCodeQualifier;
+	byte FieldReplaceable;
+	byte SenseKeySpec[3];
+} SENSE_DATA, *PSENSE_DATA;
+
+typedef struct {
+	byte DeviceType:5;
+	byte DeviceTypeQualifier:3;
+	byte DeviceTypeModifier:7;
+	byte RemovableMedia:1;
+	byte Versions;
+	byte ResponseDataFormat:4;
+	byte HiSupport:1;
+	byte NormACA:1;
+	byte ReservedBit:1;
+	byte AERC:1;
+	byte AdditionalLength;
+	byte Reserved[2];
+	byte SoftReset:1;
+	byte CommandQueue:1;
+	byte Reserved2:1;
+	byte LinkedCommands:1;
+	byte Synchronous:1;
+	byte Wide16Bit:1;
+	byte Wide32Bit:1;
+	byte RelativeAddressing:1;
+	byte VendorId[8];
+	byte ProductId[16];
+	byte ProductRevisionLevel[4];
+	byte VendorSpecific[20];
+	byte IUS:1;
+	byte QAS:1;
+	byte Clocking:2;
+	byte Reserved3_first_byte:4;
+	byte Reserved3[39];
+} _INQUIRYDATA;
+
+typedef struct {
+	u32 LogicalBlockAddress;
+	u32 BytesPerBlock;
+} READ_CAPACITY_DATA, *PREAD_CAPACITY_DATA;
+
+typedef struct {
+	byte DataLength;
+	byte MediumType;
+	byte Reserved;
+	byte BlockDescLength;
+} MODE_PAGE_HEADER;
+
+typedef struct {
+	u8 PageCode;
+	u8 PageLength;
+	u16 TracksPerZone;
+	u16 AltSectorsPerZone;
+	u16 AltTracksPerZone;
+	u16 AltTracksPerVolume;
+	u16 SectorsPerTrack;
+	u16 BytesPerSector;
+	u16 Interleave;
+	u16 TrackSkew;
+	u16 CylinderSkew;
+	u8 flags;
+	u8 reserved[3];
+} MODE_PAGE3;
+/*
+ * Sense Data Format - Page 4
+ */
+typedef struct {
+	u8 PageCode;
+	u8 PageLength;
+	u16 CylindersHigh;
+	u8 CylindersLow;
+	u8 Heads;
+	u16 WritePrecompHigh;
+	u8 WritePrecompLow;
+	u16 ReducedWriteCurrentHigh;
+	u8 ReducedWriteCurrentLow;
+	u16 StepRate;
+	u16 LandingZoneHigh;
+	u8 LandingZoneLow;
+	u8 flags;
+	u8 RotationalOffset;
+	u8 Reserved;
+	u16 MediumRotationRate;
+	u8 Reserved2[2];
+} MODE_PAGE4;
+
+typedef struct {
+	u8 PageCode;
+	u8 PageLength;
+	u8 Flags;
+	u8 RetensionPriority;
+	u8 DisablePrefetchTransfer[2];
+	u8 MinimumPrefetch[2];
+	u8 MaximumPrefetch[2];
+	u8 MaximumPrefetchCeiling[2];
+	u8 temp[7];
+} MODE_PAGE8;
+
+typedef struct {
+	byte PageCode:6;
+	byte Reserved:1;
+	byte PageSavable:1;
+	byte PageLength;
+
+	byte ReadDisableCache:1;
+	byte MultiplicationFactor:1;
+	byte WriteCacheEnable:1;
+	byte Reserved2:5;
+	byte WriteRetensionPriority:4;
+	byte ReadRetensionPriority:4;
+	byte DisablePrefetchTransfer[2];
+	byte MinimumPrefetch[2];
+	byte MaximumPrefetch[2];
+	byte MaximumPrefetchCeiling[2];
+	byte FSW_LBCSS_RDA;
+	byte NumberofCacheSegments;
+	byte CacheSegmentSize[2];
+	byte Reserved16;
+	byte NonCacheSegmentSize[3];
+} MODE_PAGE_8;
+
+typedef struct {
+	byte PageCode:6;
+	byte Reserved:1;
+	byte PageSavable:1;
+	byte PageLength;
+
+	byte Reserved2;
+	byte ProtocolIdentifier;
+	byte SynchronousTransferTimeout[2];
+	byte Reserved6[2];
+} MODEPAGE19;
+
+typedef struct {
+	MODE_PAGE_HEADER hdr;
+	union {
+		MODEPAGE19 pg_9;
+		MODE_PAGE_8 pg_8;
+		MODE_PAGE8 pg8;
+		MODE_PAGE3 pg3;
+		MODE_PAGE4 pg4;
+	} pdata;
+} MODE_PAGE_DATA;
+
+/* Sense codes */
+#define SCSI_SENSE_NO_SENSE         0x00
+#define SCSI_SENSE_RECOVERED_ERROR  0x01
+#define SCSI_SENSE_NOT_READY        0x02
+#define SCSI_SENSE_MEDIUM_ERROR     0x03
+#define SCSI_SENSE_HARDWARE_ERROR   0x04
+#define SCSI_SENSE_ILLEGAL_REQUEST  0x05
+#define SCSI_SENSE_UNIT_ATTENTION   0x06
+#define SCSI_SENSE_DATA_PROTECT     0x07
+#define SCSI_SENSE_BLANK_CHECK      0x08
+#define SCSI_SENSE_UNIQUE           0x09
+#define SCSI_SENSE_COPY_ABORTED     0x0A
+#define SCSI_SENSE_ABORTED_COMMAND  0x0B
+#define SCSI_SENSE_EQUAL            0x0C
+#define SCSI_SENSE_VOL_OVERFLOW     0x0D
+#define SCSI_SENSE_MISCOMPARE       0x0E
+#define SCSI_SENSE_RESERVED         0x0F
+
+/* Additional Sense codes */
+#define SCSI_ADSENSE_NO_SENSE                              0x00
+#define SCSI_ADSENSE_NO_SEEK_COMPLETE                      0x02
+#define SCSI_ADSENSE_LUN_NOT_READY                         0x04
+#define SCSI_ADSENSE_LUN_COMMUNICATION                     0x08
+#define SCSI_ADSENSE_WRITE_ERROR                           0x0C
+#define SCSI_ADSENSE_TRACK_ERROR                           0x14
+#define SCSI_ADSENSE_SEEK_ERROR                            0x15
+#define SCSI_ADSENSE_REC_DATA_NOECC                        0x17
+#define SCSI_ADSENSE_REC_DATA_ECC                          0x18
+#define SCSI_ADSENSE_PARAMETER_LIST_LENGTH                 0x1A
+#define SCSI_ADSENSE_ILLEGAL_COMMAND                       0x20
+#define SCSI_ADSENSE_ILLEGAL_BLOCK                         0x21
+#define SCSI_ADSENSE_INVALID_CDB                           0x24
+#define SCSI_ADSENSE_INVALID_LUN                           0x25
+#define SCSI_ADSENSE_INVALID_FIELD_PARAMETER_LIST          0x26
+#define SCSI_ADSENSE_WRITE_PROTECT                         0x27
+#define SCSI_ADSENSE_MEDIUM_CHANGED                        0x28
+#define SCSI_ADSENSE_BUS_RESET                             0x29
+#define SCSI_ADSENSE_PARAMETERS_CHANGED                    0x2A
+#define SCSI_ADSENSE_INSUFFICIENT_TIME_FOR_OPERATION       0x2E
+#define SCSI_ADSENSE_INVALID_MEDIA                         0x30
+#define SCSI_ADSENSE_NO_MEDIA_IN_DEVICE                    0x3a
+#define SCSI_ADSENSE_POSITION_ERROR                        0x3b
+#define SCSI_ADSENSE_OPERATING_CONDITIONS_CHANGED          0x3f
+#define SCSI_ADSENSE_OPERATOR_REQUEST                      0x5a
+#define SCSI_ADSENSE_FAILURE_PREDICTION_THRESHOLD_EXCEEDED 0x5d
+#define SCSI_ADSENSE_ILLEGAL_MODE_FOR_THIS_TRACK           0x64
+#define SCSI_ADSENSE_COPY_PROTECTION_FAILURE               0x6f
+#define SCSI_ADSENSE_POWER_CALIBRATION_ERROR               0x73
+#define SCSI_ADSENSE_VENDOR_UNIQUE                         0x80
+#define SCSI_ADSENSE_MUSIC_AREA                            0xA0
+#define SCSI_ADSENSE_DATA_AREA                             0xA1
+#define SCSI_ADSENSE_VOLUME_OVERFLOW                       0xA7
+
+/* for legacy apps : */
+
+extern struct kmem_cache *bht_srb_ext_cachep;
+extern mempool_t *bht_sd_mem_pool;
+
+#endif
-- 
2.34.1

