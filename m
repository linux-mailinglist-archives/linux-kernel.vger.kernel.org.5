Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9D307CBEE5
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 11:20:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234888AbjJQJUB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Oct 2023 05:20:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234834AbjJQJTf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Oct 2023 05:19:35 -0400
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F57A12E
        for <linux-kernel@vger.kernel.org>; Tue, 17 Oct 2023 02:19:26 -0700 (PDT)
Received: by mail-pg1-x52c.google.com with SMTP id 41be03b00d2f7-5859a7d6556so4076239a12.0
        for <linux-kernel@vger.kernel.org>; Tue, 17 Oct 2023 02:19:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=himax-corp-partner-google-com.20230601.gappssmtp.com; s=20230601; t=1697534365; x=1698139165; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MnIp5LzKT9a9dR7BZLN9WXLQprGFzPbI2GvnJKd8FAg=;
        b=hdmZSgM+33MOO6xiNFNFOV25wSy9OHnQpJqDTMwrXIEVM4Ub9zzdjEXCQ4B3LJyNJ7
         p9ibLw07+eC0j8RbBZkHd5ITYDFQiwQl4pEUVmzJRZqDLsa3jSXRSIdyDdICDzyKFcMV
         FWuIJdaFgKHxIZSvWfZXogaSXQMEQdmmuclmM2xQj+HdsAxKe1TMo6Hbb46V0mcnd+qn
         3dsqcyxMNQWg31Urf8ydHjXdTL45P1qk96/AQ7bsidPDebKhv+buiRjG9YMN3B3G1i0N
         E8a2jn0Jm/yKAU1UX+Am77EYOdkFEDex9q36K0RbT3l+S+F7rZYV6LtO7roscVyqerKM
         Yanw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697534365; x=1698139165;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MnIp5LzKT9a9dR7BZLN9WXLQprGFzPbI2GvnJKd8FAg=;
        b=v8cLYQL2dc6DX7ekQjwFGiGQ1gYws2NVLEa9l+j4oeIEAVCHN27vaDXSpooyUQ5p3O
         mKZjKxiT/tvGgml32DQoCBNek38HGHoLh48Dyl56GMrhA8uqoW/bkIaBML32cvRc5msw
         fbmXrsIqv1YK/Y9dDN2ccRf3pua016Sc5cOjdNG1FzFcwQJnOO//S6+FhlNviOH7CiTi
         BjPH90YQIFyVcje2YH3o7bNqI9LvN+qt/ZfdQ4MiDiuOAk2QiCMxKpt9C2s4oCDiaOQ4
         E9dLtc+ryoTL6H5W2wcvbZyq0bwGJ6vDdqQc6aUoHSFKi1nuw9D6AEGtMj4Gl+c9xHfU
         Rh9A==
X-Gm-Message-State: AOJu0Yzk6hbkKS/1B5fLFmMsRxD+o72hp0yx6rxqiE0/m858fV4nHCvQ
        mhX0d+tII0edlMIvnFiMaOEPow==
X-Google-Smtp-Source: AGHT+IFcJPK0Ndk1rm+BA+tdVKiQVtQlGRHDcwwYkm266ODUjYixW61RlpLocIk+EREOV9aBUAUz7Q==
X-Received: by 2002:a17:90a:2e83:b0:27c:f2e5:a82 with SMTP id r3-20020a17090a2e8300b0027cf2e50a82mr1528938pjd.15.1697534365248;
        Tue, 17 Oct 2023 02:19:25 -0700 (PDT)
Received: from tylor-mini-server.net ([101.9.190.154])
        by smtp.gmail.com with ESMTPSA id pl17-20020a17090b269100b00274de7c8aacsm6003963pjb.45.2023.10.17.02.19.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Oct 2023 02:19:24 -0700 (PDT)
From:   Tylor Yang <tylor_yang@himax.corp-partner.google.com>
To:     dmitry.torokhov@gmail.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        jikos@kernel.org, benjamin.tissoires@redhat.com,
        linux-input@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     poyuan_chang@himax.corp-partner.google.com,
        jingyliang@chromium.org, hbarnor@chromium.org, wuxy23@lenovo.com,
        luolm1@lenovo.com, poyu_hung@himax.corp-partner.google.com,
        Tylor Yang <tylor_yang@himax.corp-partner.google.com>
Subject: [PATCH v3 4/4] HID: touchscreen: Add initial support for Himax HID-over-SPI
Date:   Tue, 17 Oct 2023 17:19:00 +0800
Message-Id: <20231017091900.801989-5-tylor_yang@himax.corp-partner.google.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231017091900.801989-1-tylor_yang@himax.corp-partner.google.com>
References: <20231017091900.801989-1-tylor_yang@himax.corp-partner.google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The hx83102j is a TDDI IC (Touch with Display Driver). The
IC using SPI to transferring HID packet to host CPU. The IC also
report HID report descriptor for driver to register HID device.
The driver is designed as a framework for future expansion and
hx83102j is the first case. Each hx_spi_hid_hx8xxxxx modules are
mutual exclusive, it should be initiate one at a time.

This driver takes a position similar to i2c-hid, it initialize
and control the touch IC below and register HID to upper hid-core.
When touch ic report an interrupt, it receive the data from IC
and report as HID input to hid-core. Let hid-core dispatch input
to registered hid-protocol and report to related input sub-system.

This driver also provide advanced functions by hidraw interface:
- runtime firmware update
- debug functions, such as reg r/w
- self test for touch panel

Due to patch size is too big, separate into 3 part. This is part 3.

Signed-off-by: Tylor Yang <tylor_yang@himax.corp-partner.google.com>
---
 drivers/hid/Kconfig             |   2 +
 drivers/hid/Makefile            |   2 +
 drivers/hid/hx-hid/Kconfig      |  43 ++
 drivers/hid/hx-hid/Makefile     |  35 ++
 drivers/hid/hx-hid/hx_ic_core.h | 792 ++++++++++++++++++++++++++++++++
 drivers/hid/hx-hid/hx_inspect.c | 652 ++++++++++++++++++++++++++
 drivers/hid/hx-hid/hx_inspect.h | 104 +++++
 drivers/hid/hx-hid/hx_of.c      | 214 +++++++++
 drivers/hid/hx-hid/hx_plat.c    | 502 ++++++++++++++++++++
 drivers/hid/hx-hid/hx_plat.h    |  30 ++
 10 files changed, 2376 insertions(+)
 create mode 100644 drivers/hid/hx-hid/Kconfig
 create mode 100644 drivers/hid/hx-hid/Makefile
 create mode 100644 drivers/hid/hx-hid/hx_ic_core.h
 create mode 100644 drivers/hid/hx-hid/hx_inspect.c
 create mode 100644 drivers/hid/hx-hid/hx_inspect.h
 create mode 100644 drivers/hid/hx-hid/hx_of.c
 create mode 100644 drivers/hid/hx-hid/hx_plat.c
 create mode 100644 drivers/hid/hx-hid/hx_plat.h

diff --git a/drivers/hid/Kconfig b/drivers/hid/Kconfig
index 790aa908e2a7..8f7185b69925 100644
--- a/drivers/hid/Kconfig
+++ b/drivers/hid/Kconfig
@@ -1345,4 +1345,6 @@ source "drivers/hid/amd-sfh-hid/Kconfig"
 
 source "drivers/hid/surface-hid/Kconfig"
 
+source "drivers/hid/hx-hid/Kconfig"
+
 endif # HID_SUPPORT
diff --git a/drivers/hid/Makefile b/drivers/hid/Makefile
index 8a06d0f840bc..7b948a90213a 100644
--- a/drivers/hid/Makefile
+++ b/drivers/hid/Makefile
@@ -169,3 +169,5 @@ obj-$(INTEL_ISH_FIRMWARE_DOWNLOADER)	+= intel-ish-hid/
 obj-$(CONFIG_AMD_SFH_HID)       += amd-sfh-hid/
 
 obj-$(CONFIG_SURFACE_HID_CORE)  += surface-hid/
+
+obj-$(CONFIG_HX_HID)		+= hx-hid/
diff --git a/drivers/hid/hx-hid/Kconfig b/drivers/hid/hx-hid/Kconfig
new file mode 100644
index 000000000000..7638cdb2f929
--- /dev/null
+++ b/drivers/hid/hx-hid/Kconfig
@@ -0,0 +1,43 @@
+config HX_HID
+	tristate "Himax HID simulator for SPI"
+	default n
+	depends on SPI && INPUT
+	select HID
+	help
+	  Say Y here if you have Himax touch chipset,
+	  which is connected to your computer via SPI
+	  and you want to use it as a HID device.
+	  Revalent Firmware is required, whether from
+	  Firmware binary or in IC's flash memory.
+
+	  If unsure, say N.
+
+	  This support is also available as a module.
+
+config HX_HID_IC_83102J
+	bool "Himax IC_83012J for Himax HID simulator"
+	default y
+	depends on HX_HID
+	help
+	  Say Y here if you have Himax touch IC HX83102J,
+	  which is connected to your computer via SPI
+	  and you want to use it as a HID device. Please
+	  note only one type of IC can be initiated at
+	  the same time.
+
+	  If unsure, say Y.
+
+config HX_HID_HEATMAP
+	bool "Transferring HEATMAP after coordinate data"
+	default y
+	depends on HX_HID
+	help
+	  Say Y here if you need heatmap after coord
+	  data. The data can be acquired from hidraw
+	  interface. The firmware bundled need to
+	  have the ability to send heatmap to make
+	  this driver act normally. When enabled,
+	  all HX_HID_IC modules are effected.
+
+	  If unsure, say Y.
+
diff --git a/drivers/hid/hx-hid/Makefile b/drivers/hid/hx-hid/Makefile
new file mode 100644
index 000000000000..243a89282a4f
--- /dev/null
+++ b/drivers/hid/hx-hid/Makefile
@@ -0,0 +1,35 @@
+ifneq ($(filter m, $(CONFIG_HX_HID)),)
+  ccflags-y += -D__HIMAX_MOD__
+endif
+
+ifneq ($(CONFIG_HX_HID_HEATMAP),)
+	ccflags-y += -DHX_HEATMAP_EN
+endif
+
+ifneq ($(KERNELRELEASE),)
+# kbuild part of makefile
+ifneq ($(CONFIG_HX_HID_IC_83102J),)
+	hx_spi_hid_hx83102j-objs := hx_ic_83102j.o
+	hx_spi_hid_hx83102j-objs += hx_plat.o \
+		hx_ic_core.o \
+		hx_core.o \
+		hx_hid.o \
+		hx_inspect.o
+ifneq ($(CONFIG_OF),)
+	hx_spi_hid_hx83102j-objs += hx_of.o
+else ifneq ($(CONFIG_ACPI),)
+	hx_spi_hid_hx83102j-objs += hx_acpi.o
+endif
+
+	obj-$(CONFIG_HX_HID) += hx_spi_hid_hx83102j.o
+endif
+
+else
+# normal makefile
+KDIR ?= /lib/modules/`uname -r`/build
+
+default:
+	$(MAKE) -C $(KDIR) M=$$PWD
+clean:
+	@rm *.o *.mod *.mod.c .*.cmd Module.symvers *.a *.ko modules.order
+endif
diff --git a/drivers/hid/hx-hid/hx_ic_core.h b/drivers/hid/hx-hid/hx_ic_core.h
new file mode 100644
index 000000000000..5c56646906fa
--- /dev/null
+++ b/drivers/hid/hx-hid/hx_ic_core.h
@@ -0,0 +1,792 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+#ifndef __HIMAX_IC_CORE_H__
+#define __HIMAX_IC_CORE_H__
+
+#include "hx_core.h"
+#include <linux/slab.h>
+
+#define DATA_LEN_8				8
+#define DATA_LEN_4				4
+#define ADDR_LEN_4				4
+#define FLASH_RW_MAX_LEN		256
+#define FLASH_WRITE_BURST_SZ	8
+#define MAX_I2C_TRANS_SZ		128
+#define HIMAX_REG_RETRY_TIMES	5
+#define FW_BIN_16K_SZ			0x4000
+#define HIMAX_TOUCH_DATA_SIZE	128
+#define MASK_BIT_0				0x01
+#define MASK_BIT_1				0x02
+#define MASK_BIT_2				0x04
+
+#define FW_SECTOR_PER_BLOCK		8
+#define FW_PAGE_PER_SECTOR		64
+#define FW_PAGE_SZ			128
+#define HX256B					0x100
+#define HX1K					0x400
+#define HX4K					0x1000
+#define HX_32K_SZ				0x8000
+#define HX_40K_SZ				0xA000
+#define HX_48K_SZ				0xC000
+#define HX64K					0x10000
+#define HX124K					0x1f000
+#define HX4000K					0x1000000
+
+#define HX_NORMAL_MODE			1
+#define HX_SORTING_MODE			2
+#define HX_CHANGE_MODE_FAIL		(-1)
+#define HX_RW_REG_FAIL			(-1)
+#define HX_DRIVER_MAX_IC_NUM	12
+
+/* CORE_INIT */
+/* CORE_IC */
+/* CORE_FW */
+/* CORE_FLASH */
+/* CORE_SRAM */
+/* CORE_DRIVER */
+
+void himax_mcu_in_cmd_struct_free(void);
+void himax_rst_gpio_set(int pinnum, u8 value);
+void himax_cable_detect_func(struct himax_ts_data *ts, bool force_renew);
+int himax_report_data_init(struct himax_ts_data *ts);
+
+enum HX_FLASH_SPEED_ENUM {
+	HX_FLASH_SPEED_25M = 0,
+	HX_FLASH_SPEED_12p5M = 0x01,
+	HX_FLASH_SPEED_8p3M = 0x02,
+	HX_FLASH_SPEED_6p25M = 0x03,
+};
+
+/* CORE_IC */
+	#define ic_adr_ahb_addr_byte_0           0x00
+	#define ic_adr_ahb_rdata_byte_0          0x08
+	#define ic_adr_ahb_access_direction      0x0c
+	#define ic_adr_conti                     0x13
+	#define ic_adr_incr4                     0x0D
+	#define ic_adr_i2c_psw_lb                0x31
+	#define ic_adr_i2c_psw_ub                0x32
+	#define ic_cmd_ahb_access_direction_read 0x00
+	#define ic_cmd_conti                     0x31
+	#define ic_cmd_incr4                     0x10
+	#define ic_cmd_i2c_psw_lb                0x27
+	#define ic_cmd_i2c_psw_ub                0x95
+	#define ic_adr_tcon_on_rst               0x80020020
+	#define ic_addr_adc_on_rst               0x80020094
+	#define ic_adr_psl                       0x900000A0
+	#define ic_adr_cs_central_state          0x900000A8
+	#define ic_cmd_rst                       0x00000000
+	#define ic_adr_osc_en                    0x900880A8
+	#define ic_adr_osc_pw                    0x900880E0
+/* CORE_IC */
+
+/* CORE_FW */
+	#define fw_addr_system_reset                0x90000018
+	#define fw_addr_ctrl_fw                     0x9000005c
+	#define fw_addr_flag_reset_event            0x900000e4
+	#define fw_addr_hsen_enable                 0x10007F14
+	#define fw_usb_detect_addr                  0x10007F38
+	#define fw_addr_program_reload_from         0x00000000
+	#define fw_addr_program_reload_to           0x08000000
+	#define fw_addr_program_reload_page_write   0x0000fb00
+	#define fw_addr_raw_out_sel                 0x800204b4
+	#define fw_addr_reload_status               0x80050000
+	#define fw_addr_reload_crc32_result         0x80050018
+	#define fw_addr_reload_addr_from            0x80050020
+	#define fw_addr_reload_addr_cmd_beat        0x80050028
+	#define fw_data_system_reset                0x00000055
+	#define fw_data_safe_mode_release_pw_active 0x00000053
+	#define fw_data_safe_mode_release_pw_reset  0x00000000
+	#define fw_data_clear                       0x00000000
+	#define fw_data_fw_stop                     0x000000A5
+	#define fw_data_program_reload_start        0x0A3C3000
+	#define fw_data_program_reload_compare      0x04663000
+	#define fw_data_program_reload_break        0x15E75678
+	#define fw_addr_selftest_addr_en            0x10007F18
+	#define fw_addr_selftest_result_addr        0x10007f24
+	#define fw_data_selftest_request            0x00006AA6
+	#define fw_addr_criteria_addr               0x10007f1c
+	#define fw_data_criteria_aa_top             0x64
+	#define fw_data_criteria_aa_bot             0x00
+	#define fw_data_criteria_key_top            0x64
+	#define fw_data_criteria_key_bot            0x00
+	#define fw_data_criteria_avg_top            0x64
+	#define fw_data_criteria_avg_bot            0x00
+	#define fw_addr_set_frame_addr              0x10007294
+	#define fw_data_set_frame                   0x0000000A
+	#define fw_data_selftest_ack_hb             0xa6
+	#define fw_data_selftest_ack_lb             0x6a
+	#define fw_data_selftest_pass               0xaa
+	#define fw_data_normal_cmd                  0x00
+	#define fw_data_normal_status               0x99
+	#define fw_data_sorting_cmd                 0xaa
+	#define fw_data_sorting_status              0xcc
+	#define fw_data_idle_dis_pwd                0x17
+	#define fw_data_idle_en_pwd                 0x1f
+	#define fw_addr_sorting_mode_en             0x10007f04
+	#define fw_addr_fw_mode_status              0x10007088
+	#define fw_addr_icid_addr                   0x900000d0
+	#define fw_addr_fw_ver_addr                 0x10007004
+	#define fw_addr_fw_cfg_addr                 0x10007084
+	#define fw_addr_fw_vendor_addr              0x10007000
+	#define fw_addr_cus_info                    0x10007008
+	#define fw_addr_proj_info                   0x10007014
+	#define fw_addr_fw_state_addr               0x900000f8
+	#define fw_addr_fw_dbg_msg_addr             0x10007f40
+	#define fw_addr_chk_fw_status               0x900000a8
+	#define fw_addr_chk_dd_status               0x900000E8
+	#define fw_addr_dd_handshak_addr            0x900000fc
+	#define fw_addr_dd_data_addr                0x10007f80
+	#define fw_addr_clr_fw_record_dd_sts        0x10007FCC
+	#define fw_addr_ap_notify_fw_sus            0x10007FD0
+	#define fw_data_ap_notify_fw_sus_en         0xA55AA55A
+	#define fw_data_ap_notify_fw_sus_dis        0x00000000
+	#define fw_data_dd_request                  0xaa
+	#define fw_data_dd_ack                      0xbb
+	#define fw_data_rawdata_ready_hb            0xa3
+	#define fw_data_rawdata_ready_lb            0x3a
+	#define fw_addr_ahb_addr                    0x11
+	#define fw_data_ahb_dis                     0x00
+	#define fw_data_ahb_en                      0x01
+	#define fw_addr_event_addr                  0x30
+	#define fw_func_handshaking_pwd             0xA55AA55A
+	#define fw_func_handshaking_end             0x77887788
+	#define fw_addr_ulpm_33                     0x33
+	#define fw_addr_ulpm_34                     0x34
+	#define fw_data_ulpm_11                     0x11
+	#define fw_data_ulpm_22                     0x22
+	#define fw_data_ulpm_33                     0x33
+	#define fw_data_ulpm_aa                     0xAA
+	#define fw_addr_ctrl_mpap_ovl               0x100073EC
+	#define fw_data_ctrl_mpap_ovl_on            0x107380
+/* CORE_FW */
+
+/* CORE_FLASH */
+	#define flash_addr_ctrl_base           0x80000000
+	#define flash_addr_spi200_trans_fmt    (flash_addr_ctrl_base + 0x10)
+	#define flash_addr_spi200_trans_ctrl   (flash_addr_ctrl_base + 0x20)
+	#define flash_addr_spi200_cmd          (flash_addr_ctrl_base + 0x24)
+	#define flash_addr_spi200_addr         (flash_addr_ctrl_base + 0x28)
+	#define flash_addr_spi200_data         (flash_addr_ctrl_base + 0x2c)
+	#define flash_addr_spi200_fifo_rst   (flash_addr_ctrl_base + 0x30)
+	#define flash_addr_spi200_rst_status   (flash_addr_ctrl_base + 0x34)
+	#define flash_addr_spi200_flash_speed  (flash_addr_ctrl_base + 0x40)
+	#define flash_addr_spi200_bt_num       (flash_addr_ctrl_base + 0xe8)
+	#define flash_data_spi200_txfifo_rst   0x00000004
+	#define flash_data_spi200_rxfifo_rst   0x00000002
+	#define flash_data_spi200_trans_fmt    0x00020780
+	#define flash_data_spi200_trans_ctrl_1 0x42000003
+	#define flash_data_spi200_trans_ctrl_2 0x47000000
+	#define flash_data_spi200_trans_ctrl_3 0x67000000
+	#define flash_data_spi200_trans_ctrl_4 0x610ff000
+	#define flash_data_spi200_trans_ctrl_5 0x694002ff
+	#define flash_data_spi200_trans_ctrl_6 0x42000000
+	#define flash_data_spi200_trans_ctrl_7 0x6940020f
+	#define flash_data_spi200_cmd_1        0x00000005
+	#define flash_data_spi200_cmd_2        0x00000006
+	#define flash_data_spi200_cmd_3        0x000000C7
+	#define flash_data_spi200_cmd_4        0x000000D8
+	#define flash_data_spi200_cmd_5        0x00000020
+	#define flash_data_spi200_cmd_6        0x00000002
+	#define flash_data_spi200_cmd_7        0x0000003b
+	#define flash_data_spi200_cmd_8        0x00000003
+	#define flash_data_spi200_addr         0x00000000
+	#define flash_clk_setup_addr           0x80000040
+/* CORE_FLASH */
+
+/* CORE_SRAM */
+	#define sram_adr_mkey         0x100070E8
+	#define sram_adr_rawdata_addr 0x10000000
+	#define sram_adr_rawdata_end  0x00000000
+	#define	sram_passwrd_start    0x5AA5
+	#define	sram_passwrd_end      0xA55A
+/* CORE_SRAM */
+
+/* CORE_DRIVER */
+	#define driver_addr_fw_define_flash_reload              0x10007f00
+	#define driver_addr_fw_define_2nd_flash_reload          0x100072c0
+	#define driver_data_fw_define_flash_reload_dis          0x0000a55a
+	#define driver_data_fw_define_flash_reload_en           0x00000000
+	#define driver_addr_fw_define_int_is_edge               0x10007088
+	#define driver_addr_fw_define_rxnum_txnum               0x100070f4
+	#define driver_data_fw_define_rxnum_txnum_maxpt_sorting 0x00000008
+	#define driver_data_fw_define_rxnum_txnum_maxpt_normal  0x00000014
+	#define driver_addr_fw_define_maxpt_xyrvs               0x100070f8
+	#define driver_addr_fw_define_x_y_res                   0x100070fc
+	#define driver_data_df_rx                               36
+	#define driver_data_df_tx                               18
+	#define driver_data_df_pt                               10
+/* CORE_DRIVER */
+
+	#define zf_data_dis_flash_reload 0x00009AA9
+	#define zf_addr_system_reset     0x90000018
+	#define zf_data_system_reset     0x00000055
+	#define zf_data_sram_start_addr  0x08000000
+	#define zf_data_cfg_info         0x10007000
+	#define zf_data_fw_cfg_1         0x10007084
+	#define zf_data_fw_cfg_2         0x10007264
+	#define zf_data_fw_cfg_3         0x10007300
+	#define zf_data_adc_cfg_1        0x10006A00
+	#define zf_data_adc_cfg_2        0x10007B28
+	#define zf_data_adc_cfg_3        0x10007AF0
+	#define zf_data_map_table        0x10007500
+	#define zf_addr_sts_chk          0x900000A8
+	#define zf_data_activ_sts        0x05
+	#define zf_addr_activ_relod      0x90000048
+	#define zf_data_activ_in         0xEC
+
+	#define ovl_section_num      3
+	#define ovl_gesture_request  0x11
+	#define ovl_gesture_reply    0x22
+	#define ovl_border_request   0x55
+	#define ovl_border_reply     0x66
+	#define ovl_sorting_request  0x99
+	#define ovl_sorting_reply    0xAA
+	#define ovl_fault            0xFF
+
+	#define ovl_alg_request  0x11111111
+	#define ovl_alg_reply    0x22222222
+	#define ovl_alg_fault    0xFF
+
+struct zf_info {
+	u8 sram_addr[4];
+	int write_size;
+	u32 fw_addr;
+	u32 cfg_addr;
+};
+
+/* New Version 1K*/
+enum bin_desc_map_table {
+	TP_CONFIG_TABLE = 0x00000A00,
+	FW_CID = 0x10000000,
+	FW_VER = 0x10000100,
+	CFG_VER = 0x10000600,
+	HID_TABLE = 0x30000100,
+	FW_BIN_DESC = 0x10000000
+};
+
+enum data_type {
+	HX_REG = 0xA5,
+	HX_DATA
+};
+
+struct hx_reg_t {
+	union {
+		u32 word;
+		u16 half[2];
+		u8 byte[4];
+	} data;
+	u32 len;
+	u32 data_type;
+};
+
+struct data_pack_t {
+	union {
+		u32 *word;
+		u16 *half;
+		u8 *byte;
+		void *ptr;
+	} data;
+	/* length in byte unit */
+	u32 len;
+	u32 data_type;
+};
+
+#define BYTE_REG(_reg, _data) \
+	{ \
+		_reg.data.byte[0] = (_data) & 0xFF; \
+		_reg.len = 1; \
+		_reg.data_type = HX_REG; \
+	}
+#define HALF_REG(_reg, _data) \
+	{ \
+		_reg.data.half[0] = cpu_to_le16((_data) & 0xFFFF); \
+		_reg.len = 2; \
+		_reg.data_type = HX_REG; \
+	}
+#define WORD_REG(_reg, _data) \
+	{ \
+		_reg.data.word = cpu_to_le32(_data); \
+		_reg.len = 4; \
+		_reg.data_type = HX_REG; \
+	}
+
+// set val to already defined reg/data
+#define VAL_SET(_var, _val) \
+	({ \
+		bool _ret = true; \
+		do { \
+			if (_var.data_type == HX_DATA) { \
+				memset(_var.data.byte, 0, _var.len); \
+				do { \
+					switch (_var.len) { \
+					case 1: \
+						_var.data.byte[0] = (_val) & 0xFF; \
+						break; \
+					case 2: \
+						_var.data.half[0] = cpu_to_le16((_val) & 0xFFFF); \
+						break; \
+					case 3: \
+						_var.data.half[0] = cpu_to_le16((_val) & 0xFFFF); \
+						_var.data.byte[2] = ((_val) >> 16) & 0xFF; \
+						break; \
+					case 4: \
+						_var.data.word[0] =\
+						cpu_to_le32((_val) & 0xFFFFFFFF); \
+						break; \
+					default: \
+						_ret = false; \
+						break; \
+					};\
+				} while (0); \
+			} else { \
+				_ret = false; \
+			} \
+		} while (0); \
+		_ret; \
+	})
+
+// set ptr/array to already defined reg/data
+#define PTR_SET(_var, _ptr, _len) \
+	({ \
+		bool _ret = true; \
+		do { \
+			if ((_len) > (_var).len) { \
+				_ret = false; \
+				break; \
+			} \
+			memcpy((_var).data.byte, _ptr, (_len)); \
+			(_var).len = (_len); \
+		} while (0); \
+		_ret; \
+	})
+
+#define DEF_WORD_DATA(_data_name) \
+	u8 _data_name##_array[4] = {0}; \
+	struct data_pack_t _data_name = { \
+		.data.byte = _data_name##_array, \
+		.len = 4, \
+		.data_type = HX_DATA \
+	}
+
+#define ARRAY_DATA(_data, _byte_len) { \
+		_data.data.byte = (uint8_t *)_data, \
+		_data.len = _byte_len, \
+		.data_type = HX_DATA \
+	}
+
+#define REG_GET_VAL(_reg) \
+	({ \
+		u32 _val = 0; \
+		do { \
+			switch (_reg.len) { \
+			case 1: \
+				_val = _reg.data.byte[0]; \
+				break; \
+			case 2: \
+				_val = le16_to_cpu(_reg.data.half[0]); \
+				break; \
+			case 3: \
+				_val = le16_to_cpu(_reg.data.half[0]) | (_reg.data.byte[2] << 16); \
+				break; \
+			case 4: \
+				_val = le32_to_cpu(_reg.data.word); \
+				break; \
+			} \
+		} while (0); \
+		_val; \
+	})
+#define FLASH_VER_GET_VAL(_reg) REG_GET_VAL(g_core_regs.flash_ver_info._reg)
+#define IC_GET_VAL(_reg) REG_GET_VAL(g_core_regs.ic_op._reg)
+#define FW_GET_VAL(_reg) REG_GET_VAL(g_core_regs.fw_op._reg)
+#define FLASH_GET_VAL(_reg) REG_GET_VAL(g_core_regs.flash_op._reg)
+#define SRAM_GET_VAL(_reg) REG_GET_VAL(g_core_regs.sram_op._reg)
+#define DRV_GET_VAL(_reg) REG_GET_VAL(g_core_regs.driver_op._reg)
+#define ZF_GET_VAL(_reg) REG_GET_VAL(g_core_regs.zf_op._reg)
+#define REG_GET_ARRAY(_reg) \
+	({ \
+		_reg.data.byte; \
+	})
+#define FLASH_VER_GET_ARRAY(_reg) REG_GET_ARRAY(g_core_regs.flash_ver_info._reg)
+#define IC_GET_ARRAY(_reg) REG_GET_ARRAY(g_core_regs.ic_op._reg)
+#define FW_GET_ARRAY(_reg) REG_GET_ARRAY(g_core_regs.fw_op._reg)
+#define FLASH_GET_ARRAY(_reg) REG_GET_ARRAY(g_core_regs.flash_op._reg)
+#define SRAM_GET_ARRAY(_reg) REG_GET_ARRAY(g_core_regs.sram_op._reg)
+#define DRV_GET_ARRAY(_reg) REG_GET_ARRAY(g_core_regs.driver_op._reg)
+#define ZF_GET_ARRAY(_reg) REG_GET_ARRAY(g_core_regs.zf_op._reg)
+#define REG_GET_SZ(_reg) \
+	({ \
+		_reg.len; \
+	})
+#define FLASH_VER_GET_SZ(_reg) REG_GET_SZ(g_core_regs.flash_ver_info._reg)
+#define IC_GET_SZ(_reg) REG_GET_SZ(g_core_regs.ic_op._reg)
+#define FW_GET_SZ(_reg) REG_GET_SZ(g_core_regs.fw_op._reg)
+#define FLASH_GET_SZ(_reg) REG_GET_SZ(g_core_regs.flash_op._reg)
+#define SRAM_GET_SZ(_reg) REG_GET_SZ(g_core_regs.sram_op._reg)
+#define DRV_GET_SZ(_reg) REG_GET_SZ(g_core_regs.driver_op._reg)
+#define ZF_GET_SZ(_reg) REG_GET_SZ(g_core_regs.zf_op._reg)
+
+struct ic_operation {
+	struct hx_reg_t addr_ahb_addr_byte_0;
+	struct hx_reg_t addr_ahb_rdata_byte_0;
+	struct hx_reg_t addr_ahb_access_direction;
+	struct hx_reg_t addr_conti;
+	struct hx_reg_t addr_incr4;
+	struct hx_reg_t adr_i2c_psw_lb;
+	struct hx_reg_t adr_i2c_psw_ub;
+	struct hx_reg_t data_ahb_access_direction_read;
+	struct hx_reg_t data_conti;
+	struct hx_reg_t data_incr4;
+	struct hx_reg_t data_i2c_psw_lb;
+	struct hx_reg_t data_i2c_psw_ub;
+	struct hx_reg_t addr_tcon_on_rst;
+	struct hx_reg_t addr_adc_on_rst;
+	struct hx_reg_t addr_psl;
+	struct hx_reg_t addr_cs_central_state;
+	struct hx_reg_t data_rst;
+	struct hx_reg_t adr_osc_en;
+	struct hx_reg_t adr_osc_pw;
+};
+
+struct fw_operation {
+	struct hx_reg_t addr_system_reset;
+	struct hx_reg_t addr_ctrl_fw_isr;
+	struct hx_reg_t addr_flag_reset_event;
+	struct hx_reg_t addr_hsen_enable;
+	struct hx_reg_t addr_program_reload_from;
+	struct hx_reg_t addr_program_reload_to;
+	struct hx_reg_t addr_program_reload_page_write;
+	struct hx_reg_t addr_raw_out_sel;
+	struct hx_reg_t addr_reload_status;
+	struct hx_reg_t addr_reload_crc32_result;
+	struct hx_reg_t addr_reload_addr_from;
+	struct hx_reg_t addr_reload_addr_cmd_beat;
+	struct hx_reg_t addr_selftest_addr_en;
+	struct hx_reg_t addr_criteria_addr;
+	struct hx_reg_t addr_set_frame_addr;
+	struct hx_reg_t addr_selftest_result_addr;
+	struct hx_reg_t addr_sorting_mode_en;
+	struct hx_reg_t addr_fw_mode_status;
+	struct hx_reg_t addr_icid_addr;
+	struct hx_reg_t addr_fw_ver_addr;
+	struct hx_reg_t addr_fw_cfg_addr;
+	struct hx_reg_t addr_fw_vendor_addr;
+	struct hx_reg_t addr_cus_info;
+	struct hx_reg_t addr_proj_info;
+	struct hx_reg_t addr_fw_state_addr;
+	struct hx_reg_t addr_fw_dbg_msg_addr;
+	struct hx_reg_t addr_chk_fw_status;
+	struct hx_reg_t addr_dd_handshak_addr;
+	struct hx_reg_t addr_dd_data_addr;
+	struct hx_reg_t addr_clr_fw_record_dd_sts;
+	struct hx_reg_t addr_ap_notify_fw_sus;
+	struct hx_reg_t data_ap_notify_fw_sus_en;
+	struct hx_reg_t data_ap_notify_fw_sus_dis;
+	struct hx_reg_t data_system_reset;
+	struct hx_reg_t data_safe_mode_release_pw_active;
+	struct hx_reg_t data_safe_mode_release_pw_reset;
+	struct hx_reg_t data_clear;
+	struct hx_reg_t data_fw_stop;
+	struct hx_reg_t data_program_reload_start;
+	struct hx_reg_t data_program_reload_compare;
+	struct hx_reg_t data_program_reload_break;
+	struct hx_reg_t data_selftest_request;
+	struct hx_reg_t data_criteria_aa_top;
+	struct hx_reg_t data_criteria_aa_bot;
+	struct hx_reg_t data_criteria_key_top;
+	struct hx_reg_t data_criteria_key_bot;
+	struct hx_reg_t data_criteria_avg_top;
+	struct hx_reg_t data_criteria_avg_bot;
+	struct hx_reg_t data_set_frame;
+	struct hx_reg_t data_selftest_ack_hb;
+	struct hx_reg_t data_selftest_ack_lb;
+	struct hx_reg_t data_selftest_pass;
+	struct hx_reg_t data_normal_cmd;
+	struct hx_reg_t data_normal_status;
+	struct hx_reg_t data_sorting_cmd;
+	struct hx_reg_t data_sorting_status;
+	struct hx_reg_t data_dd_request;
+	struct hx_reg_t data_dd_ack;
+	struct hx_reg_t data_idle_dis_pwd;
+	struct hx_reg_t data_idle_en_pwd;
+	struct hx_reg_t data_rawdata_ready_hb;
+	struct hx_reg_t data_rawdata_ready_lb;
+	struct hx_reg_t addr_ahb_addr;
+	struct hx_reg_t data_ahb_dis;
+	struct hx_reg_t data_ahb_en;
+	struct hx_reg_t addr_event_addr;
+	struct hx_reg_t addr_usb_detect;
+};
+
+struct flash_operation {
+	struct hx_reg_t addr_spi200_trans_fmt;
+	struct hx_reg_t addr_spi200_trans_ctrl;
+	struct hx_reg_t addr_spi200_fifo_rst;
+	struct hx_reg_t addr_spi200_rst_status;
+	struct hx_reg_t addr_spi200_flash_speed;
+	struct hx_reg_t addr_spi200_cmd;
+	struct hx_reg_t addr_spi200_addr;
+	struct hx_reg_t addr_spi200_data;
+	struct hx_reg_t addr_spi200_bt_num;
+
+	struct hx_reg_t data_spi200_txfifo_rst;
+	struct hx_reg_t data_spi200_rxfifo_rst;
+	struct hx_reg_t data_spi200_trans_fmt;
+	struct hx_reg_t data_spi200_trans_ctrl_1;
+	struct hx_reg_t data_spi200_trans_ctrl_2;
+	struct hx_reg_t data_spi200_trans_ctrl_3;
+	struct hx_reg_t data_spi200_trans_ctrl_4;
+	struct hx_reg_t data_spi200_trans_ctrl_5;
+	struct hx_reg_t data_spi200_trans_ctrl_6;
+	struct hx_reg_t data_spi200_trans_ctrl_7;
+	struct hx_reg_t data_spi200_cmd_1;
+	struct hx_reg_t data_spi200_cmd_2;
+	struct hx_reg_t data_spi200_cmd_3;
+	struct hx_reg_t data_spi200_cmd_4;
+	struct hx_reg_t data_spi200_cmd_5;
+	struct hx_reg_t data_spi200_cmd_6;
+	struct hx_reg_t data_spi200_cmd_7;
+	struct hx_reg_t data_spi200_cmd_8;
+	struct hx_reg_t data_spi200_addr;
+};
+
+struct sram_operation {
+	struct hx_reg_t addr_mkey;
+	struct hx_reg_t addr_rawdata_addr;
+	struct hx_reg_t addr_rawdata_end;
+	struct hx_reg_t passwrd_start;
+	struct hx_reg_t passwrd_end;
+};
+
+struct driver_operation {
+	struct hx_reg_t addr_fw_define_flash_reload;
+	struct hx_reg_t addr_fw_define_2nd_flash_reload;
+	struct hx_reg_t addr_fw_define_int_is_edge;
+	struct hx_reg_t addr_fw_define_rxnum_txnum;
+	struct hx_reg_t addr_fw_define_maxpt_xyrvs;
+	struct hx_reg_t addr_fw_define_x_y_res;
+	struct hx_reg_t data_df_rx;
+	struct hx_reg_t data_df_tx;
+	struct hx_reg_t data_df_pt;
+	struct hx_reg_t data_fw_define_flash_reload_dis;
+	struct hx_reg_t data_fw_define_flash_reload_en;
+	struct hx_reg_t data_fw_define_rxnum_txnum_maxpt_sorting;
+	struct hx_reg_t data_fw_define_rxnum_txnum_maxpt_normal;
+};
+
+struct zf_operation {
+	struct hx_reg_t data_dis_flash_reload;
+	struct hx_reg_t addr_system_reset;
+	struct hx_reg_t data_system_reset;
+	struct hx_reg_t data_sram_start_addr;
+	struct hx_reg_t data_sram_clean;
+	struct hx_reg_t data_cfg_info;
+	struct hx_reg_t data_fw_cfg_1;
+	struct hx_reg_t data_fw_cfg_2;
+	struct hx_reg_t data_fw_cfg_3;
+	struct hx_reg_t data_adc_cfg_1;
+	struct hx_reg_t data_adc_cfg_2;
+	struct hx_reg_t data_adc_cfg_3;
+	struct hx_reg_t data_map_table;
+	struct hx_reg_t addr_sts_chk;
+	struct hx_reg_t data_activ_sts;
+	struct hx_reg_t addr_activ_relod;
+	struct hx_reg_t data_activ_in;
+};
+
+struct flash_version_info {
+	struct hx_reg_t addr_fw_ver_major;
+	struct hx_reg_t addr_fw_ver_minor;
+	struct hx_reg_t addr_cfg_ver_major;
+	struct hx_reg_t addr_cfg_ver_minor;
+	struct hx_reg_t addr_cid_ver_major;
+	struct hx_reg_t addr_cid_ver_minor;
+	struct hx_reg_t addr_cfg_table;
+	struct hx_reg_t addr_cfg_table_t;
+	struct hx_reg_t addr_hid_table;
+	struct hx_reg_t addr_hid_desc;
+	struct hx_reg_t addr_hid_rd_desc;
+};
+
+struct himax_core_command_regs {
+	struct flash_version_info flash_ver_info;
+	struct ic_operation ic_op;
+	struct fw_operation fw_op;
+	struct flash_operation flash_op;
+	struct sram_operation sram_op;
+	struct driver_operation driver_op;
+	struct zf_operation zf_op;
+};
+
+struct himax_core_fp {
+/* CORE_IC */
+	void (*fp_burst_enable)(struct himax_ts_data *ts, u8 auto_add_4_byte);
+	int (*fp_register_read)(struct himax_ts_data *ts, u8 *addr,
+				u8 *buf, u32 len);
+	int (*fp_reg_read)(struct himax_ts_data *ts, struct hx_reg_t *addr,
+			   struct data_pack_t *data);
+	int (*fp_register_write)(struct himax_ts_data *ts, u8 *addr,
+				 u8 *val, u32 len);
+	int (*fp_reg_write)(struct himax_ts_data *ts, struct hx_reg_t *addr,
+			    struct data_pack_t *data);
+	void (*fp_interface_on)(struct himax_ts_data *ts);
+	void (*fp_sense_on)(struct himax_ts_data *ts, u8 flash_mode);
+	void (*fp_tcon_on)(struct himax_ts_data *ts);
+	bool (*fp_watch_dog_off)(struct himax_ts_data *ts);
+	bool (*fp_sense_off)(struct himax_ts_data *ts, bool check_en);
+	void (*fp_sleep_in)(struct himax_ts_data *ts);
+	bool (*fp_wait_wip)(struct himax_ts_data *ts, int timing);
+	void (*fp_init_psl)(struct himax_ts_data *ts);
+	void (*fp_resume_ic_action)(struct himax_ts_data *ts);
+	void (*fp_suspend_ic_action)(struct himax_ts_data *ts);
+	void (*fp_power_on_init)(struct himax_ts_data *ts);
+	bool (*fp_slave_tcon_reset)(struct himax_ts_data *ts);
+	bool (*fp_slave_adc_reset_slave)(struct himax_ts_data *ts);
+	bool (*fp_slave_wdt_off_slave)(struct himax_ts_data *ts);
+/* CORE_IC */
+
+/* CORE_FW */
+	void (*fp_system_reset)(struct himax_ts_data *ts);
+	int (*fp_calculate_crc_with_ap)(const unsigned char *fw_content,
+					int crc_from_fw,
+			int len);
+	u32 (*fp_check_crc)(struct himax_ts_data *ts, u8 *start_addr,
+			    int reload_length);
+	void (*fp_set_reload_cmd)(u8 *write_data,
+				  int idx,
+			u32 cmd_from,
+			u32 cmd_to,
+			u32 cmd_beat);
+	bool (*fp_program_reload)(void);
+	void (*fp_diag_register_set)(struct himax_ts_data *ts,
+				     u8 diag_command);
+	int (*fp_diag_register_get)(struct himax_ts_data *ts,
+				    u32 *diag_value);
+	void (*fp_clr_fw_reord_dd_sts)(struct himax_ts_data *ts);
+	void (*fp_ap_notify_fw_sus)(struct himax_ts_data *ts, int suspend);
+	int (*fp_chip_self_test)(struct seq_file *s, void *v);
+	void (*fp_idle_mode)(struct himax_ts_data *ts, int disable);
+	void (*fp_reload_disable)(struct himax_ts_data *ts, int disable);
+	int (*fp_read_ic_trigger_type)(struct himax_ts_data *ts);
+	void (*fp_read_FW_ver)(struct himax_ts_data *ts);
+	bool (*fp_read_event_stack)(struct himax_ts_data *ts, u8 *buf,
+				    u32 length);
+	void (*fp_return_event_stack)(struct himax_ts_data *ts);
+	bool (*fp_calculate_checksum)(struct himax_ts_data *ts, bool change_iref,
+				      u32 size);
+	void (*fp_read_FW_status)(struct himax_ts_data *ts);
+	void (*fp_irq_switch)(struct himax_ts_data *ts, int switch_on);
+	int (*fp_assign_sorting_mode)(struct himax_ts_data *ts, u8 *tmp_data);
+	int (*fp_check_sorting_mode)(struct himax_ts_data *ts, u8 *tmp_data);
+	int (*fp_get_max_dc)(void);
+	u8 (*fp_read_DD_status)(struct himax_ts_data *ts, u8 *cmd_set,
+				u8 *tmp_data);
+	int (*fp_ulpm_in)(void);
+	int (*fp_black_gest_ctrl)(bool enable);
+	int	(*fp_diff_overlay_bin)(void);
+/* CORE_FW */
+
+/* CORE_FLASH */
+	void (*fp_chip_erase)(struct himax_ts_data *ts);
+	bool (*fp_block_erase)(struct himax_ts_data *ts, int start_addr,
+			       int length);
+	bool (*fp_sector_erase)(int start_addr);
+	bool (*fp_flash_programming)(struct himax_ts_data *ts,
+				     u8 *fw_content, int fw_size);
+	void (*fp_flash_page_write)(u8 *write_addr, int length,
+				    u8 *write_data);
+	int (*fp_fts_ctpm_fw_upgrade_with_sys_fs_32k)(struct himax_ts_data *ts,
+						      unsigned char *fw, int len, bool change_iref);
+	int (*fp_fts_ctpm_fw_upgrade_with_sys_fs_60k)(struct himax_ts_data *ts,
+						      unsigned char *fw, int len, bool change_iref);
+	int (*fp_fts_ctpm_fw_upgrade_with_sys_fs_64k)(struct himax_ts_data *ts,
+						      unsigned char *fw, int len, bool change_iref);
+	int (*fp_fts_ctpm_fw_upgrade_with_sys_fs_124k)
+		(struct himax_ts_data *ts, unsigned char *fw,
+		 int len, bool change_iref);
+	int (*fp_fts_ctpm_fw_upgrade_with_sys_fs_128k)
+		(struct himax_ts_data *ts, unsigned char *fw,
+		 int len, bool change_iref);
+	int (*fp_fts_ctpm_fw_upgrade_with_sys_fs_255k)
+		(struct himax_ts_data *ts, unsigned char *fw,
+		 int len, bool change_iref);
+	void (*fp_flash_dump_func)(struct himax_ts_data *ts,
+				   u8 local_flash_command, int flash_size,
+				   u8 *flash_buffer);
+	bool (*fp_flash_lastdata_check)(struct himax_ts_data *ts, u32 size);
+	bool (*fp_bin_desc_get)(unsigned char *fw, struct himax_ts_data *ts,
+				u32 max_sz);
+	bool (*fp_ahb_squit)(void);
+	void (*fp_flash_read)(u8 *r_data, int start_addr, int length);
+	bool (*fp_sfr_rw)(u8 *addr, int length,
+			  u8 *data, u8 rw_ctrl);
+	bool (*fp_lock_flash)(void);
+	bool (*fp_unlock_flash)(void);
+	void (*fp_init_auto_func)(void);
+	int (*fp_diff_overlay_flash)(struct himax_ts_data *ts);
+/* CORE_FLASH */
+
+/* CORE_SRAM */
+	void (*fp_sram_write)(struct himax_ts_data *ts, u8 *FW_content);
+	bool (*fp_sram_verify)(struct himax_ts_data *ts, u8 *fw_file,
+			       int fw_size);
+	bool (*fp_get_DSRAM_data)(struct himax_ts_data *ts, u8 *info_data,
+				  bool dsram_flag);
+/* CORE_SRAM */
+
+/* CORE_DRIVER */
+	bool (*fp_chip_detect)(struct himax_ts_data *ts);
+	void (*fp_chip_init)(struct himax_ts_data *ts);
+	void (*fp_pin_reset)(struct himax_ts_data *ts);
+	u8 (*fp_tp_info_check)(struct himax_ts_data *ts);
+	void (*fp_touch_information)(struct himax_ts_data *ts);
+	void (*fp_calc_touch_data_size)(struct himax_ts_data *ts);
+	void (*fp_reload_config)(void);
+	int (*fp_get_touch_data_size)(void);
+	void (*fp_usb_detect_set)(struct himax_ts_data *ts,
+				  const u8 *cable_config);
+	int (*fp_hand_shaking)(void);
+	int (*fp_determin_diag_rawdata)(int diag_command);
+	int (*fp_determin_diag_storage)(int diag_command);
+	int (*fp_cal_data_len)(int raw_cnt_rmd, int HX_MAX_PT, int raw_cnt_max);
+	bool (*fp_diag_check_sum)(struct himax_ts_data *ts);
+
+	void (*fp_ic_reset)(struct himax_ts_data *ts,
+			    u8 loadconfig, u8 int_off);
+	int (*fp_ic_excp_recovery)
+			(struct himax_ts_data *ts,
+			u32 hx_excp_event,
+			u32 hx_zero_event, u32 length);
+	void (*fp_excp_ic_reset)(struct himax_ts_data *ts);
+	void (*fp_resend_cmd_func)(struct himax_ts_data *ts, bool suspended);
+/* CORE_DRIVER */
+	int (*fp_turn_on_mp_func)(struct himax_ts_data *ts, int on);
+	void (*fp_clean_sram_0f)(struct himax_ts_data *ts, u8 *addr,
+				 int write_len, int type);
+	void (*fp_write_sram_0f)(struct himax_ts_data *ts, u8 *addr,
+				 const u8 *data, u32 len);
+	int (*fp_write_sram_0f_crc)(struct himax_ts_data *ts, u8 *addr,
+				    const u8 *data, u32 len);
+	int (*fp_firmware_update_0f)(const struct firmware *fw_entry,
+				     struct himax_ts_data *ts, int type);
+	int (*fp_0f_op_file_dirly)(char *file_name, struct himax_ts_data *ts);
+	int (*fp_0f_excp_check)(void);
+	void (*fp_0f_reload_to_active)(struct himax_ts_data *ts);
+	void (*_en_hw_crc)(struct himax_ts_data *ts, int en);
+	void (*fp_read_sram_0f)(struct himax_ts_data *ts,
+				const struct firmware *fw_entry,
+				u8 *addr, int start_index, int read_len);
+	void (*fp_read_all_sram)(struct himax_ts_data *ts,
+				 u8 *addr, int read_len);
+	void (*fp_firmware_read_0f)(struct himax_ts_data *ts,
+				    const struct firmware *fw_entry, int type);
+	int (*fp_0f_overlay)(struct himax_ts_data *ts, int ovl_type, int mode);
+	void (*fp_suspend_proc)(struct himax_ts_data *ts, bool suspended);
+	void (*fp_resume_proc)(struct himax_ts_data *ts, bool suspended);
+};
+
+extern struct himax_core_command_regs g_core_regs;
+
+void himax_ic_reg_init(struct himax_core_command_regs *reg_data);
+void himax_ic_fp_init(void);
+
+#endif
diff --git a/drivers/hid/hx-hid/hx_inspect.c b/drivers/hid/hx-hid/hx_inspect.c
new file mode 100644
index 000000000000..51782e390910
--- /dev/null
+++ b/drivers/hid/hx-hid/hx_inspect.c
@@ -0,0 +1,652 @@
+// SPDX-License-Identifier: GPL-2.0
+/*  Himax Driver Code for Common IC to simulate HID
+ *
+ *  Copyright (C) 2023 Himax Corporation.
+ *
+ *  This software is licensed under the terms of the GNU General Public
+ *  License version 2,  as published by the Free Software Foundation,  and
+ *  may be copied,  distributed,  and modified under those terms.
+ *
+ *  This program is distributed in the hope that it will be useful,
+ *   but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *  GNU General Public License for more details.
+ */
+
+#include "hx_core.h"
+#include "hx_hid.h"
+#include "hx_ic_core.h"
+#include "hx_plat.h"
+#include "hx_inspect.h"
+
+#define BS_RAWDATA     8
+#define BS_NOISE       8
+#define BS_OPENSHORT   0
+#define	BS_LPWUG       1
+#define	BS_LP_IDLE     1
+#define	BS_ACT_IDLE    1
+
+#define	NOISEFRAME                      60
+#define NORMAL_IDLE_RAWDATA_NOISEFRAME  10
+#define LP_RAWDATAFRAME              1
+#define LP_NOISEFRAME                1
+#define LP_IDLE_RAWDATAFRAME         1
+#define LP_IDLE_NOISEFRAME           1
+
+#define OTHERSFRAME		2
+
+#define	UNIFMAX			500
+
+/*Himax MP Password*/
+#define	PWD_OPEN_START          0x7777
+#define	PWD_OPEN_END            0x8888
+#define	PWD_SHORT_START         0x1111
+#define	PWD_SHORT_END           0x3333
+#define	PWD_RAWDATA_START       0x0000
+#define	PWD_RAWDATA_END         0x9999
+#define	PWD_NOISE_START         0x0000
+#define	PWD_NOISE_END           0x9999
+#define	PWD_SORTING_START       0xAAAA
+#define	PWD_SORTING_END         0xCCCC
+
+#define PWD_ACT_IDLE_START      0x2222
+#define PWD_ACT_IDLE_END        0x4444
+
+#define PWD_LP_START         0x5555
+#define PWD_LP_END           0x6666
+
+#define PWD_LP_IDLE_START    0x5050
+#define PWD_LP_IDLE_END      0x6060
+
+/*Himax Data Ready Password*/
+#define	DATA_PWD       0x5AA5
+
+/*Inspection register*/
+#define addr_normal_noise_thx   0x1000708C
+#define addr_lpwug_noise_thx    0x10007090
+#define addr_noise_scale        0x10007094
+#define addr_recal_thx          0x10007090
+#define addr_palm_num           0x100070A8
+#define addr_weight_sup         0x100072C8
+#define addr_normal_weight_a    0x1000709C
+#define addr_lpwug_weight_a     0x100070A0
+#define addr_weight_b           0x10007094
+#define addr_max_dc             0x10007FC8
+#define addr_skip_frame         0x100070F4
+#define addr_neg_noise_sup      0x10007FD8
+#define data_neg_noise          0x7F0C0000
+
+/*Need to map THP_INSPECTION_ENUM*/
+static char *g_himax_inspection_mode[] = {
+	"HIMAX_OPEN",
+	"HIMAX_MICRO_OPEN",
+	"HIMAX_SHORT",
+	"HIMAX_SC",
+	"HIMAX_WEIGHT_NOISE",
+	"HIMAX_ABS_NOISE",
+	"HIMAX_RAWDATA",
+	"HIMAX_BPN_RAWDATA",
+	"HIMAX_SORTING",
+	"HIMAX_GAPTEST_RAW",
+	/*"HIMAX_GAPTEST_RAW_X",*/
+	/*"HIMAX_GAPTEST_RAW_Y",*/
+
+	"HIMAX_ACT_IDLE_NOISE",
+	"HIMAX_ACT_IDLE_RAWDATA",
+	"HIMAX_ACT_IDLE_BPN_RAWDATA",
+
+	"HIMAX_LPWUG_WEIGHT_NOISE",
+	"HIMAX_LPWUG_ABS_NOISE",
+	"HIMAX_LPWUG_RAWDATA",
+	"HIMAX_LPWUG_BPN_RAWDATA",
+
+	"HIMAX_LPWUG_IDLE_NOISE",
+	"HIMAX_LPWUG_IDLE_RAWDATA",
+	"HIMAX_LPWUG_IDLE_BPN_RAWDATA",
+
+	"HIMAX_BACK_NORMAL",
+	NULL
+};
+
+enum HX_INSPT_SETTING_IDX {
+	RAW_BS_FRAME = 0,
+	NOISE_BS_FRAME,
+	ACT_IDLE_BS_FRAME,
+	LP_BS_FRAME,
+	LP_IDLE_BS_FRAME,
+
+	NFRAME,
+	IDLE_NFRAME,
+	LP_RAW_NFRAME,
+	LP_NOISE_NFRAME,
+	LP_IDLE_RAW_NFRAME,
+	LP_IDLE_NOISE_NFRAME,
+	NFRAME_MAX,
+};
+
+static s32 g_hx_inspt_setting_val[NFRAME_MAX] = {0};
+
+static const u16 g_hx_data_type[HX_DATA_TYPE_MAX] = {
+	DATA_SORTING,
+	DATA_OPEN,
+	DATA_MICRO_OPEN,
+	DATA_SHORT,
+	DATA_RAWDATA,
+	DATA_NOISE,
+	DATA_BACK_NORMAL,
+	DATA_LP_RAWDATA,
+	DATA_LP_NOISE,
+	DATA_ACT_IDLE_RAWDATA,
+	DATA_ACT_IDLE_NOISE,
+	DATA_LP_IDLE_RAWDATA,
+	DATA_LP_IDLE_NOISE,
+};
+
+static int hx_switch_mode_inspection(struct himax_ts_data *ts, int mode)
+{
+	union hx_dword_data_t tmp_addr = {0};
+	union hx_dword_data_t tmp_data = {0};
+
+	I("Entering");
+
+	/*Stop Handshaking*/
+	tmp_addr.dword = cpu_to_le32(sram_adr_rawdata_addr);
+	g_core_fp.fp_register_write(ts, tmp_addr.byte, tmp_data.byte, 4);
+
+	/*Switch Mode*/
+	switch (mode) {
+	case HX_SORTING:
+		tmp_data.dword = cpu_to_le32(PWD_SORTING_START);
+		break;
+	case HX_OPEN:
+		tmp_data.dword = cpu_to_le32(PWD_OPEN_START);
+		break;
+	case HX_MICRO_OPEN:
+		tmp_data.dword = cpu_to_le32(PWD_OPEN_START);
+		break;
+	case HX_SHORT:
+		tmp_data.dword = cpu_to_le32(PWD_SHORT_START);
+		break;
+
+	case HX_GAPTEST_RAW:
+	case HX_RAWDATA:
+	case HX_BPN_RAWDATA:
+	case HX_SC:
+		tmp_data.dword = cpu_to_le32(PWD_RAWDATA_START);
+		break;
+
+	case HX_WT_NOISE:
+	case HX_ABS_NOISE:
+		tmp_data.dword = cpu_to_le32(PWD_NOISE_START);
+		break;
+
+	case HX_ACT_IDLE_RAWDATA:
+	case HX_ACT_IDLE_BPN_RAWDATA:
+	case HX_ACT_IDLE_NOISE:
+		tmp_data.dword = cpu_to_le32(PWD_ACT_IDLE_START);
+		break;
+
+	case HX_LP_RAWDATA:
+	case HX_LP_BPN_RAWDATA:
+	case HX_LP_ABS_NOISE:
+	case HX_LP_WT_NOISE:
+		tmp_data.dword = cpu_to_le32(PWD_LP_START);
+		break;
+	case HX_LP_IDLE_RAWDATA:
+	case HX_LP_IDLE_BPN_RAWDATA:
+	case HX_LP_IDLE_NOISE:
+		tmp_data.dword = cpu_to_le32(PWD_LP_IDLE_START);
+		break;
+
+	default:
+		I("Nothing to be done!");
+		break;
+	}
+
+	if (g_core_fp.fp_assign_sorting_mode)
+		g_core_fp.fp_assign_sorting_mode(ts, tmp_data.byte);
+	I("End of setting!");
+
+	return 0;
+}
+
+void hx_switch_data_type(struct himax_ts_data *ts, u32 type)
+{
+	u32 datatype = 0x00;
+
+	I("Expected type[%d]=%s",
+	  type, g_himax_inspection_mode[type]);
+
+	switch (type) {
+	case HX_SORTING:
+		datatype = g_hx_data_type[HX_DATA_SORTING];
+		break;
+	case HX_OPEN:
+		datatype = g_hx_data_type[HX_DATA_OPEN];
+		break;
+	case HX_MICRO_OPEN:
+		datatype = g_hx_data_type[HX_DATA_MICRO_OPEN];
+		break;
+	case HX_SHORT:
+		datatype = g_hx_data_type[HX_DATA_SHORT];
+		break;
+	case HX_RAWDATA:
+	case HX_BPN_RAWDATA:
+	case HX_SC:
+	case HX_GAPTEST_RAW:
+		datatype = g_hx_data_type[HX_DATA_RAWDATA];
+		break;
+
+	case HX_WT_NOISE:
+	case HX_ABS_NOISE:
+		datatype = g_hx_data_type[HX_DATA_NOISE];
+		break;
+	case HX_BACK_NORMAL:
+		datatype = g_hx_data_type[HX_DATA_BACK_NORMAL];
+		break;
+	case HX_ACT_IDLE_RAWDATA:
+	case HX_ACT_IDLE_BPN_RAWDATA:
+		datatype = g_hx_data_type[HX_DATA_ACT_IDLE_RAWDATA];
+		break;
+	case HX_ACT_IDLE_NOISE:
+		datatype = DATA_ACT_IDLE_NOISE;
+		break;
+
+	case HX_LP_RAWDATA:
+	case HX_LP_BPN_RAWDATA:
+		datatype = g_hx_data_type[HX_DATA_LP_RAWDATA];
+		break;
+	case HX_LP_WT_NOISE:
+	case HX_LP_ABS_NOISE:
+		datatype = g_hx_data_type[HX_DATA_LP_NOISE];
+		break;
+	case HX_LP_IDLE_RAWDATA:
+	case HX_LP_IDLE_BPN_RAWDATA:
+		datatype = g_hx_data_type[HX_DATA_LP_IDLE_RAWDATA];
+		break;
+	case HX_LP_IDLE_NOISE:
+		datatype = g_hx_data_type[HX_DATA_LP_IDLE_NOISE];
+		break;
+
+	default:
+		E("Wrong type=%d", type);
+		break;
+	}
+	g_core_fp.fp_diag_register_set(ts, datatype);
+}
+
+static void hx_bank_search_set(struct himax_ts_data *ts, u32 n_frame,
+			       u32 checktype)
+{
+	union hx_dword_data_t tmp_data = {0};
+	union hx_dword_data_t tmp_addr = {0};
+
+	/*skip frame 0x100070F4*/
+	tmp_addr.dword = cpu_to_le32(addr_skip_frame);
+	g_core_fp.fp_register_read(ts, tmp_addr.byte, tmp_data.byte, 4);
+
+	switch (checktype) {
+	case HX_ACT_IDLE_RAWDATA:
+	case HX_ACT_IDLE_BPN_RAWDATA:
+	case HX_ACT_IDLE_NOISE:
+		if (g_hx_inspt_setting_val[ACT_IDLE_BS_FRAME] > 0)
+			tmp_data.byte[0] = g_hx_inspt_setting_val[ACT_IDLE_BS_FRAME];
+		else
+			tmp_data.byte[0] = BS_ACT_IDLE;
+		break;
+	case HX_LP_RAWDATA:
+	case HX_LP_BPN_RAWDATA:
+	case HX_LP_ABS_NOISE:
+	case HX_LP_WT_NOISE:
+		if (g_hx_inspt_setting_val[LP_BS_FRAME] > 0)
+			tmp_data.byte[0] = g_hx_inspt_setting_val[LP_BS_FRAME];
+		else
+			tmp_data.byte[0] = BS_LPWUG;
+		break;
+	case HX_LP_IDLE_RAWDATA:
+	case HX_LP_IDLE_BPN_RAWDATA:
+	case HX_LP_IDLE_NOISE:
+		if (g_hx_inspt_setting_val[LP_IDLE_BS_FRAME] > 0)
+			tmp_data.byte[0] = g_hx_inspt_setting_val[LP_IDLE_BS_FRAME];
+		else
+			tmp_data.byte[0] = BS_LP_IDLE;
+		break;
+	case HX_RAWDATA:
+	case HX_BPN_RAWDATA:
+	case HX_SC:
+		if (g_hx_inspt_setting_val[RAW_BS_FRAME] > 0)
+			tmp_data.byte[0] = g_hx_inspt_setting_val[RAW_BS_FRAME];
+		else
+			tmp_data.byte[0] = BS_RAWDATA;
+		break;
+	case HX_WT_NOISE:
+	case HX_ABS_NOISE:
+		if (g_hx_inspt_setting_val[NOISE_BS_FRAME] > 0)
+			tmp_data.byte[0] = g_hx_inspt_setting_val[NOISE_BS_FRAME];
+		else
+			tmp_data.byte[0] = BS_NOISE;
+		break;
+	default:
+		tmp_data.byte[0] = BS_OPENSHORT;
+		break;
+	}
+	D("Now BankSearch Value=%d", tmp_data.byte[0]);
+
+	g_core_fp.fp_register_write(ts, tmp_addr.byte, tmp_data.byte, 4);
+}
+
+static void hx_neg_noise_sup(struct himax_ts_data *ts, u8 *data)
+{
+	union hx_dword_data_t tmp_data = {0};
+	union hx_dword_data_t tmp_addr = {0};
+
+	/*0x10007FD8 Check support negative value or not */
+	tmp_addr.dword = cpu_to_le32(addr_neg_noise_sup);
+	g_core_fp.fp_register_read(ts, tmp_addr.byte, tmp_data.byte, 4);
+
+	if ((tmp_data.byte[3] & 0x04) == 0x04) {
+		tmp_data.dword = cpu_to_le32(data_neg_noise);
+		data[2] = tmp_data.byte[2]; data[3] = tmp_data.byte[3];
+	} else {
+		I("Not support negative noise");
+	}
+}
+
+static void hx_set_N_frame(struct himax_ts_data *ts, u32 n_frame,
+			   u32 checktype)
+{
+	union hx_dword_data_t tmp_data = {0};
+	union hx_dword_data_t tmp_addr = {0};
+
+	hx_bank_search_set(ts, n_frame, checktype);
+
+	/*IIR MAX - 0x10007294*/
+	tmp_addr.dword = cpu_to_le32(fw_addr_set_frame_addr);
+	tmp_data.dword = cpu_to_le32(n_frame);
+	g_core_fp.fp_register_write(ts, tmp_addr.byte, tmp_data.byte, 4);
+
+	if (checktype == HX_WT_NOISE ||
+	    checktype == HX_ABS_NOISE ||
+		checktype == HX_LP_WT_NOISE ||
+		checktype == HX_LP_ABS_NOISE)
+		hx_neg_noise_sup(ts, tmp_data.byte);
+	I("Now N frame Value=0x%X",
+	  le32_to_cpu(tmp_data.dword));
+
+	g_core_fp.fp_register_write(ts, tmp_addr.byte, tmp_data.byte, 4);
+}
+
+static u32 hx_check_mode(struct himax_ts_data *ts, u8 checktype)
+{
+	int ret = 0;
+	union hx_dword_data_t tmp_data = {0};
+	u16 wait_pwd = {0};
+
+	switch (checktype) {
+	case HX_SORTING:
+		wait_pwd = PWD_SORTING_END;
+		break;
+	case HX_OPEN:
+		wait_pwd = PWD_OPEN_END;
+		break;
+	case HX_MICRO_OPEN:
+		wait_pwd = PWD_OPEN_END;
+		break;
+	case HX_SHORT:
+		wait_pwd = PWD_SHORT_END;
+		break;
+	case HX_RAWDATA:
+	case HX_BPN_RAWDATA:
+	case HX_SC:
+	case HX_GAPTEST_RAW:
+		wait_pwd = PWD_RAWDATA_END;
+		break;
+
+	case HX_WT_NOISE:
+	case HX_ABS_NOISE:
+		wait_pwd = PWD_NOISE_END;
+		break;
+
+	case HX_ACT_IDLE_RAWDATA:
+	case HX_ACT_IDLE_BPN_RAWDATA:
+	case HX_ACT_IDLE_NOISE:
+		wait_pwd = PWD_ACT_IDLE_END;
+		break;
+
+	case HX_LP_RAWDATA:
+	case HX_LP_BPN_RAWDATA:
+	case HX_LP_ABS_NOISE:
+	case HX_LP_WT_NOISE:
+		wait_pwd = PWD_LP_END;
+		break;
+	case HX_LP_IDLE_RAWDATA:
+	case HX_LP_IDLE_BPN_RAWDATA:
+	case HX_LP_IDLE_NOISE:
+		wait_pwd = PWD_LP_IDLE_END;
+		break;
+
+	default:
+		E("Wrong type=%d", checktype);
+		break;
+	}
+
+	if (g_core_fp.fp_check_sorting_mode) {
+		ret = g_core_fp.fp_check_sorting_mode(ts, tmp_data.byte);
+		if (ret != NO_ERR)
+			return ret;
+	}
+
+	if ((le32_to_cpu(tmp_data.dword) & 0xFFFF) == wait_pwd) {
+		I("It had been changed to [%d]=%s",
+		  checktype, g_himax_inspection_mode[checktype]);
+		return NO_ERR;
+	} else {
+		return 1;
+	}
+}
+
+static u32 hx_wait_sorting_mode(struct himax_ts_data *ts,
+				u8 checktype)
+{
+	int count = 0;
+	union hx_dword_data_t tmp_addr = {0};
+	union hx_dword_data_t tmp_data = {0};
+	u16 wait_pwd = {0};
+
+	D("start!");
+
+	switch (checktype) {
+	case HX_SORTING:
+		wait_pwd = PWD_SORTING_END;
+		break;
+	case HX_OPEN:
+		wait_pwd = PWD_OPEN_END;
+		break;
+	case HX_MICRO_OPEN:
+		wait_pwd = PWD_OPEN_END;
+		break;
+	case HX_SHORT:
+		wait_pwd = PWD_SHORT_END;
+		break;
+	case HX_RAWDATA:
+	case HX_BPN_RAWDATA:
+	case HX_SC:
+	case HX_GAPTEST_RAW:
+		wait_pwd = PWD_RAWDATA_END;
+		break;
+	case HX_WT_NOISE:
+	case HX_ABS_NOISE:
+		wait_pwd = PWD_NOISE_END;
+		break;
+	case HX_ACT_IDLE_RAWDATA:
+	case HX_ACT_IDLE_BPN_RAWDATA:
+	case HX_ACT_IDLE_NOISE:
+		wait_pwd = PWD_ACT_IDLE_END;
+		break;
+
+	case HX_LP_RAWDATA:
+	case HX_LP_BPN_RAWDATA:
+	case HX_LP_ABS_NOISE:
+	case HX_LP_WT_NOISE:
+		wait_pwd = PWD_LP_END;
+		break;
+	case HX_LP_IDLE_RAWDATA:
+	case HX_LP_IDLE_BPN_RAWDATA:
+	case HX_LP_IDLE_NOISE:
+		wait_pwd = PWD_LP_IDLE_END;
+		break;
+
+	default:
+		I("No Change Mode and now type=%d", checktype);
+		break;
+	}
+	I("NowType[%d] = %s, Expected=0x%04X",
+	  checktype, g_himax_inspection_mode[checktype],
+		 wait_pwd);
+	do {
+		D("start check_sorting_mode!");
+		if (g_core_fp.fp_check_sorting_mode)
+			g_core_fp.fp_check_sorting_mode(ts, tmp_data.byte);
+		D("end check_sorting_mode!");
+		if ((le32_to_cpu(tmp_data.dword) & 0xFFFF) == wait_pwd)
+			return HX_INSP_OK;
+
+		tmp_addr.dword = cpu_to_le32(fw_addr_chk_fw_status);
+		g_core_fp.fp_register_read(ts, tmp_addr.byte, tmp_data.byte, 4);
+		D("0x%08X : %08X", fw_addr_chk_fw_status,
+		  le32_to_cpu(tmp_data.dword));
+
+		tmp_addr.dword = cpu_to_le32(fw_addr_flag_reset_event);
+		g_core_fp.fp_register_read(ts, tmp_addr.byte, tmp_data.byte, 4);
+		D("0x%08X : %08X", fw_addr_flag_reset_event,
+		  le32_to_cpu(tmp_data.dword));
+
+		tmp_addr.dword = cpu_to_le32(fw_addr_fw_dbg_msg_addr);
+		g_core_fp.fp_register_read(ts, tmp_addr.byte, tmp_data.byte, 4);
+		D("0x%08X : %08X", fw_addr_fw_dbg_msg_addr,
+		  le32_to_cpu(tmp_data.dword));
+
+		D("Now retry %d times!", count);
+
+		count++;
+		usleep_range(50000, 50001);
+	} while (count < 10);
+
+	D("end");
+	return HX_INSP_ESWITCHMODE;
+}
+
+void hx_self_test(struct work_struct *work)
+{
+	struct himax_ts_data *ts = container_of(work, struct himax_ts_data,
+			work_self_test.work);
+	u32 checktype = ts->hid_req_cfg.self_test_type;
+	s32 n_frame = 0;
+	u32 ret_val = NO_ERR;
+	int check_sort_sts = NO_ERR;
+	int switch_mode_cnt = 0;
+
+	check_sort_sts = hx_check_mode(ts, checktype);
+	if (check_sort_sts < NO_ERR) {
+		ret_val = HX_INSP_ESWITCHMODE;
+		ts->hid_req_cfg.handshake_get = HID_SELF_TEST_ERROR;
+		goto END;
+	}
+
+	if (check_sort_sts) {
+		I("Need Change Mode, target=%s",
+		  g_himax_inspection_mode[checktype]);
+SWITCH_MODE:
+		D("start sense off!");
+		g_core_fp.fp_sense_off(ts, true);
+		D("end sense off!");
+
+		if (ts->ic_data->has_flash) {
+			g_core_fp.fp_turn_on_mp_func(ts, 1);
+			if (g_core_fp.fp_reload_disable)
+				g_core_fp.fp_reload_disable(ts, 1);
+		}
+		hx_switch_mode_inspection(ts, checktype);
+
+		switch (checktype) {
+		case HX_WT_NOISE:
+		case HX_ABS_NOISE:
+			if (g_hx_inspt_setting_val[NFRAME] > 0)
+				n_frame = g_hx_inspt_setting_val[NFRAME];
+			else
+				n_frame = NOISEFRAME;
+			break;
+		case HX_ACT_IDLE_RAWDATA:
+		case HX_ACT_IDLE_NOISE:
+		case HX_ACT_IDLE_BPN_RAWDATA:
+			if (g_hx_inspt_setting_val[IDLE_NFRAME] > 0)
+				n_frame = g_hx_inspt_setting_val[IDLE_NFRAME];
+			else
+				n_frame = NORMAL_IDLE_RAWDATA_NOISEFRAME;
+			break;
+		case HX_LP_RAWDATA:
+		case HX_LP_BPN_RAWDATA:
+			if (g_hx_inspt_setting_val[LP_RAW_NFRAME] > 0)
+				n_frame = g_hx_inspt_setting_val[LP_RAW_NFRAME];
+			else
+				n_frame = LP_RAWDATAFRAME;
+			break;
+		case HX_LP_WT_NOISE:
+		case HX_LP_ABS_NOISE:
+			if (g_hx_inspt_setting_val[LP_NOISE_NFRAME] > 0)
+				n_frame =
+					g_hx_inspt_setting_val[LP_NOISE_NFRAME];
+			else
+				n_frame = LP_NOISEFRAME;
+			break;
+		case HX_LP_IDLE_RAWDATA:
+		case HX_LP_IDLE_BPN_RAWDATA:
+			if (g_hx_inspt_setting_val[LP_IDLE_RAW_NFRAME] > 0)
+				n_frame =
+				g_hx_inspt_setting_val[LP_IDLE_RAW_NFRAME];
+			else
+				n_frame = LP_IDLE_RAWDATAFRAME;
+			break;
+		case HX_LP_IDLE_NOISE:
+			if (g_hx_inspt_setting_val[LP_IDLE_NOISE_NFRAME] > 0)
+				n_frame =
+				g_hx_inspt_setting_val[LP_IDLE_NOISE_NFRAME];
+			else
+				n_frame = LP_IDLE_NOISEFRAME;
+			break;
+		default:
+			n_frame = OTHERSFRAME;
+		}
+		hx_set_N_frame(ts, n_frame, checktype);
+		g_core_fp.fp_sense_on(ts, 1);
+	}
+
+	ret_val = hx_wait_sorting_mode(ts, checktype);
+	if (ret_val) {
+		if (ret_val == HX_INSP_ESWITCHMODE && switch_mode_cnt < 3) {
+			switch_mode_cnt++;
+			g_core_fp.fp_ic_reset(ts, false, false);
+			goto SWITCH_MODE;
+		}
+		E("himax_wait_sorting_mode FAIL");
+		ts->hid_req_cfg.handshake_get = HID_SELF_TEST_ERROR;
+		goto END;
+	}
+	hx_switch_data_type(ts, checktype);
+
+	ts->hid_req_cfg.handshake_get = HID_SELF_TEST_FINISH;
+END:
+	mutex_unlock(&ts->hid_ioctl_lock);
+}
+
+int hx_get_data(struct himax_ts_data *ts, u8 *data, s32 len)
+{
+	bool get_raw_rlst = false;
+
+	get_raw_rlst = g_core_fp.fp_get_DSRAM_data(ts, data, false);
+
+	if (get_raw_rlst)
+		return HX_INSP_OK;
+	else
+		return HX_INSP_EGETRAW;
+}
diff --git a/drivers/hid/hx-hid/hx_inspect.h b/drivers/hid/hx-hid/hx_inspect.h
new file mode 100644
index 000000000000..e601dbb81e8a
--- /dev/null
+++ b/drivers/hid/hx-hid/hx_inspect.h
@@ -0,0 +1,104 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+#ifndef __HX_INSPECT_H__
+#define __HX_INSPECT_H__
+
+#include "hx_core.h"
+#include "hx_hid.h"
+
+enum THP_INSPECTION_ENUM {
+	HX_OPEN,
+	HX_MICRO_OPEN,
+	HX_SHORT,
+	HX_SC,
+	HX_WT_NOISE,
+	HX_ABS_NOISE,
+	HX_RAWDATA,
+	HX_BPN_RAWDATA,
+	HX_SORTING,
+
+	HX_GAPTEST_RAW,
+	/*HX_GAPTEST_RAW_X,*/
+	/*HX_GAPTEST_RAW_Y,*/
+
+	HX_ACT_IDLE_NOISE,
+	HX_ACT_IDLE_RAWDATA,
+	HX_ACT_IDLE_BPN_RAWDATA,
+/*LPWUG test must put after Normal test*/
+	HX_LP_WT_NOISE,
+	HX_LP_ABS_NOISE,
+	HX_LP_RAWDATA,
+	HX_LP_BPN_RAWDATA,
+
+	HX_LP_IDLE_NOISE,
+	HX_LP_IDLE_RAWDATA,
+	HX_LP_IDLE_BPN_RAWDATA,
+
+	HX_BACK_NORMAL,/*Must put in the end*/
+};
+
+/*Himax DataType*/
+#define DATA_SORTING            0x0A
+#define DATA_OPEN               0x0B
+#define DATA_MICRO_OPEN         0x0C
+#define DATA_SHORT              0x0A
+#define DATA_RAWDATA            0x0A
+#define DATA_NOISE              0x0F
+#define DATA_BACK_NORMAL        0x00
+#define DATA_LP_RAWDATA      0x0C
+#define DATA_LP_NOISE        0x0F
+#define DATA_ACT_IDLE_RAWDATA   0x0A
+#define DATA_ACT_IDLE_NOISE     0x0F
+#define DATA_LP_IDLE_RAWDATA 0x0A
+#define DATA_LP_IDLE_NOISE   0x0F
+
+enum HX_DATA_TYPE_ENUM {
+	HX_DATA_SORTING,
+	HX_DATA_OPEN,
+	HX_DATA_MICRO_OPEN,
+	HX_DATA_SHORT,
+	HX_DATA_RAWDATA,
+	HX_DATA_NOISE,
+	HX_DATA_BACK_NORMAL,
+	HX_DATA_LP_RAWDATA,
+	HX_DATA_LP_NOISE,
+	HX_DATA_ACT_IDLE_RAWDATA,
+	HX_DATA_ACT_IDLE_NOISE,
+	HX_DATA_LP_IDLE_RAWDATA,
+	HX_DATA_LP_IDLE_NOISE,
+	HX_DATA_TYPE_MAX
+};
+
+enum HX_INSP_TEST_ERR_ENUM {
+	/* OK */
+	HX_INSP_OK = 0,
+
+	/* FAIL */
+	HX_INSP_FAIL = 1,
+
+	/* Memory allocate errors */
+	HX_INSP_MEMALLCTFAIL = 1 << 1,
+
+	/* Abnormal screen state */
+	HX_INSP_ESCREEN = 1 << 2,
+
+	/* Out of specification */
+	HX_INSP_ESPEC = 1 << 3,
+
+	/* Criteria file error*/
+	HX_INSP_EFILE = 1 << 4,
+
+	/* Switch mode error*/
+	HX_INSP_ESWITCHMODE = 1 << 5,
+
+	/* Get raw data errors */
+	HX_INSP_EGETRAW = 1 << 6,
+};
+
+void hx_self_test(struct work_struct *work);
+
+int hx_get_data(struct himax_ts_data *ts, u8 *data, s32 len);
+
+void hx_switch_data_type(struct himax_ts_data *ts, u32 type);
+
+#endif
diff --git a/drivers/hid/hx-hid/hx_of.c b/drivers/hid/hx-hid/hx_of.c
new file mode 100644
index 000000000000..9e4c9dd070e7
--- /dev/null
+++ b/drivers/hid/hx-hid/hx_of.c
@@ -0,0 +1,214 @@
+// SPDX-License-Identifier: GPL-2.0
+/*  Himax Driver Code for Common IC to simulate HID
+ *
+ *  Copyright (C) 2023 Himax Corporation.
+ *
+ *  This software is licensed under the terms of the GNU General Public
+ *  License version 2,  as published by the Free Software Foundation,  and
+ *  may be copied,  distributed,  and modified under those terms.
+ *
+ *  This program is distributed in the hope that it will be useful,
+ *   but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *  GNU General Public License for more details.
+ */
+
+#include "hx_core.h"
+
+#define UNUSED(x) ((void)(x))
+static const char default_fw_name[] = BOOT_UPGRADE_FWNAME;
+
+int himax_parse_dt(struct device_node *dt, struct himax_platform_data *pdata)
+{
+	/* pid_fw_name size = length of default_fw_name + length of "_XXXX" +
+	 * length of ".bin" + null terminator.
+	 */
+	static char pid_fw_name[ARRAY_SIZE(default_fw_name) + 5 + 4 + 1] = {0};
+	int tmp = 0;
+	const int pid_prop_args = 2;
+	u32 data = 0;
+	int id_gpios[8] = {0};
+	int counter = 0;
+	int i = 0;
+	s16 id_value = -1;
+	int dts_irq = 0;
+	int err = 0;
+	struct device_node *panel_node = NULL;
+
+	UNUSED(default_fw_name);
+	if (!dt || !pdata) {
+		E("DT: dev or pdata is NULL");
+		return -EINVAL;
+	}
+
+	dts_irq = of_irq_get(dt, 0);
+	D("DT: dts_irq = %d", dts_irq);
+	if (dts_irq <= 0) {
+		if (dts_irq == -EPROBE_DEFER)
+			E("DT: dts_irq = -EPROBE_DEFER");
+		return -EIO;
+	}
+
+	pdata->of_irq = dts_irq;
+	pdata->gpio_irq = -1;
+
+	pdata->gpio_reset = of_get_named_gpio(dt, "reset", 0);
+	if (!gpio_is_valid(pdata->gpio_reset)) {
+		I(" DT:gpio-rst value is not valid");
+		return -EIO;
+	}
+
+	I(" DT:interrupt=%d, reset=%d",
+	  pdata->of_irq, pdata->gpio_reset);
+
+	counter = of_gpio_named_count(dt, "himax,id-gpios");
+	if (counter > 0) {
+		for (i = 0 ; i < counter ; i++) {
+			id_gpios[i] = of_get_named_gpio(dt, "himax,id-gpios", i);
+			if (!gpio_is_valid(id_gpios[i])) {
+				I(" DT:gpio-id value is not valid");
+				return -EIO;
+			}
+			I(" DT:gpio-id[%d]=%d", i, id_gpios[i]);
+		}
+		id_value = 0;
+		for (i = 0 ; i < counter ; i++) {
+			gpio_direction_input(id_gpios[i]);
+			id_value |= gpio_get_value(id_gpios[i]) << i;
+		}
+		I(" DT:gpio-id value=%04X", id_value);
+		pdata->panel_id = id_value;
+	} else {
+		pdata->panel_id = -1;
+		D(" DT:gpio-id not found");
+	}
+
+	// himax,ic_det_delay unit is millisecond
+	if (of_property_read_u32(dt, "himax,ic-det-delay-ms", &data)) {
+		pdata->ic_det_delay = 0;
+		D(" DT:himax,ic-det-delay-ms not found");
+	} else {
+		pdata->ic_det_delay = data;
+		I(" DT:himax,ic-det-delay-ms=%d", pdata->ic_det_delay);
+	}
+
+	// himax,ic_resume_delay unit is millisecond
+	if (of_property_read_u32(dt, "himax,ic-resume-delay-ms", &data)) {
+		pdata->ic_resume_delay = 0;
+		D(" DT:himax,ic-resume-delay-ms not found");
+	} else {
+		pdata->ic_resume_delay = data;
+		I(" DT:himax,ic-resume-delay-ms=%d", pdata->ic_resume_delay);
+	}
+
+	if (of_property_read_bool(dt, "himax,has-flash")) {
+		pdata->is_zf = false;
+		D(" DT:himax,has-flash");
+	} else {
+		pdata->is_zf = true;
+		I(" DT:himax,has-flash not found, load firmware from file");
+	}
+
+	if (of_property_read_bool(dt, "vccd-supply")) {
+		pdata->vccd_supply = regulator_get(pdata->ts->dev, "vccd");
+		if (IS_ERR(pdata->vccd_supply)) {
+			E(" DT:failed to get vccd supply");
+			err = PTR_ERR(pdata->vccd_supply);
+			pdata->vccd_supply = NULL;
+			return err;
+		}
+		I(" DT:vccd-supply=%p", pdata->vccd_supply);
+	} else {
+		pdata->vccd_supply = NULL;
+	}
+
+	if (of_property_read_bool(dt, "vcca-supply")) {
+		pdata->vcca_supply = regulator_get(pdata->ts->dev, "vcca");
+		if (IS_ERR(pdata->vcca_supply)) {
+			E(" DT:failed to get vcca supply");
+			err = PTR_ERR(pdata->vcca_supply);
+			pdata->vcca_supply = NULL;
+			return err;
+		}
+		I(" DT:vcca-supply=%p", pdata->vcca_supply);
+	} else {
+		pdata->vcca_supply = NULL;
+	}
+
+	/*
+	 * check himax,pid first, if exist then check if it is single.
+	 * Single case: himax,pid = <0x1002>; // 0x1002 is pid value
+	 * Multiple case: himax,pid = <id_value0 00x1001>, <id_value1 0x1002>;
+	 * When id_value >= 0, check the mapping listed to use the pid value.
+	 */
+	panel_node = of_get_child_by_name(dt, "panel");
+	if (panel_node) {
+		if (of_get_property(panel_node, "himax,pid", &data)) {
+			counter = data / (sizeof(u32) * pid_prop_args);
+
+			if (!counter) {
+				// default case, no id->pid mappings
+				if (of_property_read_u32(panel_node, "himax,pid", &data)) {
+					pdata->pid = 0;
+					D(" DT:himax,pid not found");
+					goto GET_PID_END;
+				} else {
+					goto GET_PID_VALUE;
+				}
+			}
+
+			if (id_value < 0) {
+				E(" DT:himax,pid has no matched for id_value=%04X", id_value);
+				pdata->pid = 0;
+				goto GET_PID_END;
+			}
+
+			for (i = 0; i < counter; i++) {
+				if (of_property_read_u32_index(panel_node, "himax,pid",
+							       i * pid_prop_args, &tmp)) {
+					D(" DT:himax,pid parsing error!");
+					pdata->pid = 0;
+					goto GET_PID_END;
+				}
+
+				if (of_property_read_u32_index(panel_node, "himax,pid",
+							       i * pid_prop_args + 1, &data)) {
+					D(" DT:himax,pid parsing error!");
+					pdata->pid = 0;
+					goto GET_PID_END;
+				}
+
+				if (tmp == id_value) {
+					I(" DT:himax,pid mapping: id=%04X => pid=%04X, matched!",
+					  tmp, data);
+					i = counter;
+				} else {
+					I(" DT:himax,pid mapping: id=%04X => pid=%04X", tmp, data);
+				}
+			}
+
+			if (counter == i) {
+				E(" DT:himax,pid has no matched for id_value=%04X", id_value);
+				pdata->pid = 0;
+				goto GET_PID_END;
+			}
+
+GET_PID_VALUE:
+			g_fw_boot_upgrade_name = pid_fw_name;
+			pdata->pid = data;
+			snprintf(pid_fw_name, sizeof(pid_fw_name), "%s_%04X%s",
+				 BOOT_UPGRADE_FWNAME, pdata->pid, ".bin");
+			I(" DT:himax,pid=%04X, fw_name=%s",
+			  pdata->pid, pid_fw_name);
+		} else {
+			pdata->pid = 0;
+			D(" DT:himax,pid not found");
+		}
+	} else {
+		pdata->pid = 0;
+		D(" DT:panel node not found");
+	}
+GET_PID_END:
+
+	return 0;
+}
diff --git a/drivers/hid/hx-hid/hx_plat.c b/drivers/hid/hx-hid/hx_plat.c
new file mode 100644
index 000000000000..e360c070b2bf
--- /dev/null
+++ b/drivers/hid/hx-hid/hx_plat.c
@@ -0,0 +1,502 @@
+// SPDX-License-Identifier: GPL-2.0
+/*  Himax Driver Code for Common IC to simulate HID
+ *
+ *  Copyright (C) 2023 Himax Corporation.
+ *
+ *  This software is licensed under the terms of the GNU General Public
+ *  License version 2,  as published by the Free Software Foundation,  and
+ *  may be copied,  distributed,  and modified under those terms.
+ *
+ *  This program is distributed in the hope that it will be useful,
+ *   but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *  GNU General Public License for more details.
+ */
+
+#include "hx_core.h"
+#include "hx_plat.h"
+
+void himax_rst_gpio_set(int pinnum, u8 value)
+{
+	gpio_direction_output(pinnum, value);
+}
+
+int himax_gpio_power_config(struct himax_ts_data *ts,
+			    struct himax_platform_data *pdata)
+{
+	int error = 0;
+
+	if (gpio_is_valid(pdata->gpio_reset)) {
+		error = gpio_request(pdata->gpio_reset, "himax-reset");
+
+		if (error < 0) {
+			E("request reset pin failed");
+			goto err_gpio_reset_req;
+		}
+
+		error = gpio_direction_output(pdata->gpio_reset, 0);
+
+		if (error) {
+			E("unable to set direction for gpio [%d]",
+			  pdata->gpio_reset);
+			goto err_gpio_reset_dir;
+		}
+	}
+
+	if (pdata->vccd_supply) {
+		error = regulator_enable(pdata->vccd_supply);
+		if (error) {
+			E("unable to enable vccd supply");
+			goto err_vccd_supply_enable;
+		}
+	}
+
+	if (pdata->vcca_supply) {
+		error = regulator_enable(pdata->vcca_supply);
+		if (error) {
+			E("unable to enable vcca supply");
+			goto err_vcca_supply_enable;
+		}
+	}
+
+	if (gpio_is_valid(pdata->gpio_irq)) {
+		/* configure touchscreen irq gpio */
+		error = gpio_request(pdata->gpio_irq, "himax_gpio_irq");
+
+		if (error) {
+			E("unable to request gpio [%d]", pdata->gpio_irq);
+			goto err_gpio_irq_req;
+		}
+
+		error = gpio_direction_input(pdata->gpio_irq);
+		if (error) {
+			E("unable to set direction for gpio [%d]",
+			  pdata->gpio_irq);
+			goto err_gpio_irq_set_input;
+		}
+
+		ts->hx_irq = gpio_to_irq(pdata->gpio_irq);
+	} else if (pdata->of_irq) {
+		ts->hx_irq = pdata->of_irq;
+	} else {
+		E("irq not provided");
+		goto err_gpio_irq_req;
+	}
+
+	usleep_range(2000, 2001);
+
+	if (gpio_is_valid(pdata->gpio_reset)) {
+		error = gpio_direction_output(pdata->gpio_reset, 1);
+
+		if (error) {
+			E("unable to set direction for gpio [%d]",
+			  pdata->gpio_reset);
+			goto err_gpio_reset_set_high;
+		}
+	}
+
+	return error;
+
+err_gpio_reset_set_high:
+err_gpio_irq_set_input:
+	if (gpio_is_valid(pdata->gpio_irq))
+		gpio_free(pdata->gpio_irq);
+err_gpio_irq_req:
+	if (pdata->vcca_supply) {
+		regulator_disable(pdata->vcca_supply);
+		regulator_put(pdata->vcca_supply);
+		pdata->vcca_supply = NULL;
+	}
+err_vcca_supply_enable:
+	if (pdata->vccd_supply) {
+		regulator_disable(pdata->vccd_supply);
+		regulator_put(pdata->vccd_supply);
+		pdata->vccd_supply = NULL;
+	}
+err_vccd_supply_enable:
+err_gpio_reset_dir:
+	if (gpio_is_valid(pdata->gpio_reset))
+		gpio_free(pdata->gpio_reset);
+err_gpio_reset_req:
+
+	return error;
+}
+
+void himax_gpio_power_deconfig(struct himax_platform_data *pdata)
+{
+	if (gpio_is_valid(pdata->gpio_irq)) {
+		I("free gpio_irq = %d", pdata->gpio_irq);
+		gpio_free(pdata->gpio_irq);
+	}
+
+	if (gpio_is_valid(pdata->gpio_reset)) {
+		I("free gpio_reset = %d", pdata->gpio_reset);
+		gpio_free(pdata->gpio_reset);
+	}
+
+	if (pdata->vcca_supply) {
+		regulator_disable(pdata->vcca_supply);
+		regulator_put(pdata->vcca_supply);
+		pdata->vcca_supply = NULL;
+	}
+	if (pdata->vccd_supply) {
+		regulator_disable(pdata->vccd_supply);
+		regulator_put(pdata->vccd_supply);
+		pdata->vccd_supply = NULL;
+	}
+}
+
+static int himax_spi_read(struct himax_ts_data *ts, u8 *cmd,
+			  u8 cmd_len, u8 *buf, u32 len)
+{
+	struct spi_message m;
+	int result = NO_ERR;
+	int retry;
+	int error;
+	struct spi_transfer	t = {
+		.len = cmd_len + len,
+	};
+
+	t.tx_buf = ts->xfer_data;
+	t.rx_buf = ts->xfer_data;
+
+	spi_message_init(&m);
+	spi_message_add_tail(&t, &m);
+
+	for (retry = 0; retry < HIMAX_BUS_RETRY_TIMES; retry++) {
+		error = spi_sync(ts->spi, &m);
+		if (unlikely(error))
+			E("SPI read error: %d", error);
+		else
+			break;
+	}
+
+	if (retry == HIMAX_BUS_RETRY_TIMES) {
+		E("SPI read error retry over %d", HIMAX_BUS_RETRY_TIMES);
+		result = -EIO;
+		goto END;
+	} else {
+		memcpy(buf, ts->xfer_data + cmd_len, len);
+	}
+
+END:
+	return result;
+}
+
+static int himax_spi_write(struct himax_ts_data *ts, u8 *buf,
+			   u32 length)
+{
+	int status;
+	struct spi_message	m;
+	struct spi_transfer	t = {
+			.tx_buf		= buf,
+			.len		= length,
+	};
+
+	spi_message_init(&m);
+	spi_message_add_tail(&t, &m);
+
+	status = spi_sync(ts->spi, &m);
+
+	if (status == 0) {
+		status = m.status;
+		if (status == 0)
+			status = m.actual_length;
+	}
+
+	return status;
+}
+
+int himax_bus_read(struct himax_ts_data *ts, u8 cmd,
+		   u8 *buf, u32 len)
+{
+	int result = -1;
+	u8 hw_addr = 0x00;
+
+	if (len > BUS_R_DLEN) {
+		E("len[%d] is over %d", len, BUS_R_DLEN);
+		return result;
+	}
+
+	mutex_lock(&ts->rw_lock);
+
+	if (ts->select_slave_reg) {
+		hw_addr = ts->slave_read_reg;
+		I("now addr=0x%02X!", hw_addr);
+	} else {
+		hw_addr = 0xF3;
+	}
+
+	memset(ts->xfer_data, 0, BUS_R_HLEN + len);
+	ts->xfer_data[0] = hw_addr;
+	ts->xfer_data[1] = cmd;
+	ts->xfer_data[2] = 0x00;
+	result = himax_spi_read(ts, ts->xfer_data, BUS_R_HLEN, buf, len);
+
+	mutex_unlock(&ts->rw_lock);
+
+	return result;
+}
+
+int himax_bus_write(struct himax_ts_data *ts, u8 cmd,
+		    u8 *addr, u8 *data, u32 len)
+{
+	int result = -1;
+	u8 offset = 0;
+	u32 tmp_len = len;
+	u8 hw_addr = 0x00;
+
+	if (len > BUS_W_DLEN) {
+		E("len[%d] is over %d", len, BUS_W_DLEN);
+		return -EFAULT;
+	}
+
+	mutex_lock(&ts->rw_lock);
+
+	if (ts->select_slave_reg) {
+		hw_addr = ts->slave_write_reg;
+		I("now addr=0x%02X!", hw_addr);
+	} else {
+		hw_addr = 0xF2;
+	}
+
+	ts->xfer_data[0] = hw_addr;
+	ts->xfer_data[1] = cmd;
+	offset = BUS_W_HLEN;
+
+	if (addr) {
+		memcpy(ts->xfer_data + offset, addr, 4);
+		offset += 4;
+		tmp_len -= 4;
+	}
+
+	if (data)
+		memcpy(ts->xfer_data + offset, data, tmp_len);
+
+	result = himax_spi_write(ts, ts->xfer_data, len + BUS_W_HLEN);
+
+	mutex_unlock(&ts->rw_lock);
+
+	return result;
+}
+
+void himax_int_enable(struct himax_ts_data *ts, int enable)
+{
+	unsigned long irqflags = 0;
+	int irqnum = ts->hx_irq;
+
+	spin_lock_irqsave(&ts->irq_lock, irqflags);
+	D("Entering! irqnum = %d", irqnum);
+	if (enable == 1 && atomic_read(&ts->irq_state) == 0) {
+		atomic_set(&ts->irq_state, 1);
+		enable_irq(irqnum);
+		ts->irq_enabled = 1;
+	} else if (enable == 0 && atomic_read(&ts->irq_state) == 1) {
+		atomic_set(&ts->irq_state, 0);
+		disable_irq_nosync(irqnum);
+		ts->irq_enabled = 0;
+	}
+
+	I("interrupt enable = %d", enable);
+	spin_unlock_irqrestore(&ts->irq_lock, irqflags);
+}
+
+static void himax_ts_isr_func(struct himax_ts_data *ts)
+{
+	himax_ts_work(ts);
+}
+
+irqreturn_t himax_ts_thread(int irq, void *ptr)
+{
+	himax_ts_isr_func((struct himax_ts_data *)ptr);
+
+	return IRQ_HANDLED;
+}
+
+static void himax_ts_work_func(struct work_struct *work)
+{
+	struct himax_ts_data *ts = container_of(work,
+		struct himax_ts_data, work);
+
+	himax_ts_work(ts);
+}
+
+int himax_int_register_trigger(struct himax_ts_data *ts)
+{
+	int ret = 0;
+
+	if (ts->ic_data->HX_INT_IS_EDGE) {
+		I("edge triiger falling");
+		ret = request_threaded_irq(ts->hx_irq, NULL, himax_ts_thread,
+					   IRQF_TRIGGER_FALLING | IRQF_ONESHOT,
+			himax_dev_name, ts);
+	} else {
+		I("level trigger low");
+		ret = request_threaded_irq(ts->hx_irq, NULL, himax_ts_thread,
+					   IRQF_TRIGGER_LOW | IRQF_ONESHOT, himax_dev_name, ts);
+	}
+
+	return ret;
+}
+
+int himax_ts_register_interrupt(struct himax_ts_data *ts)
+{
+	int ret = 0;
+
+	ts->irq_enabled = 0;
+
+	/* Work functon */
+	if (ts->hx_irq) {/*INT mode*/
+		ts->use_irq = 1;
+		ret = himax_int_register_trigger(ts);
+
+		if (ret == 0) {
+			ts->irq_enabled = 1;
+			atomic_set(&ts->irq_state, 1);
+			I("irq enabled at number: %d",
+			  ts->hx_irq);
+		} else {
+			ts->use_irq = 0;
+			E("request_irq failed");
+		}
+	} else {
+		I("ts->hx_irq is empty, use polling mode.");
+	}
+
+	/*if use polling mode need to disable HX_ESD_RECOVERY function*/
+	if (!ts->use_irq) {
+		ts->himax_wq = create_singlethread_workqueue("himax_touch");
+		INIT_WORK(&ts->work, himax_ts_work_func);
+		hrtimer_init(&ts->timer, CLOCK_MONOTONIC, HRTIMER_MODE_REL);
+		ts->timer.function = himax_ts_timer_func;
+		hrtimer_start(&ts->timer, ktime_set(1, 0), HRTIMER_MODE_REL);
+		I("polling mode enabled");
+	}
+
+	return ret;
+}
+
+int himax_ts_unregister_interrupt(struct himax_ts_data *ts)
+{
+	int ret = 0;
+
+	I("entered.");
+
+	/* Work functon */
+	if (ts->hx_irq && ts->use_irq) {/*INT mode*/
+		free_irq(ts->hx_irq, ts);
+		I("irq disabled at qpio: %d",
+		  ts->hx_irq);
+	}
+
+	/*if use polling mode need to disable HX_ESD_RECOVERY function*/
+	if (!ts->use_irq) {
+		hrtimer_cancel(&ts->timer);
+		cancel_work_sync(&ts->work);
+		if (ts->himax_wq)
+			destroy_workqueue(ts->himax_wq);
+		I("polling mode destroyed");
+	}
+
+	return ret;
+}
+
+#if defined(CONFIG_FB)
+int fb_notifier_callback(struct notifier_block *self,
+			 unsigned long event, void *data)
+{
+	const struct fb_event *evdata = data;
+	int *blank;
+	struct himax_ts_data *ts =
+	    container_of(self, struct himax_ts_data, fb_notif);
+
+	I("entered");
+
+	if (!ts) {
+		E("ts is NULL");
+		return -ECANCELED;
+	}
+
+	if (!ts->ic_boot_done) {
+		E("IC is booting");
+		return -ECANCELED;
+	}
+
+	if (evdata && evdata->data &&
+	    event == FB_EVENT_BLANK &&
+		ts->dev) {
+		blank = evdata->data;
+
+		switch (*blank) {
+		case FB_BLANK_UNBLANK:
+			himax_resume(ts->dev);
+			break;
+
+		case FB_BLANK_POWERDOWN:
+		case FB_BLANK_HSYNC_SUSPEND:
+		case FB_BLANK_VSYNC_SUSPEND:
+		case FB_BLANK_NORMAL:
+			himax_suspend(ts->dev);
+			break;
+		}
+	}
+
+	return 0;
+}
+
+void himax_fb_register(struct work_struct *work)
+{
+	int ret = 0;
+	struct himax_ts_data *ts = container_of(work, struct himax_ts_data,
+			work_att.work);
+
+	ts->fb_notif.notifier_call = fb_notifier_callback;
+	ret = fb_register_client(&ts->fb_notif);
+
+	if (ret)
+		E("Unable to register fb_notifier: %d", ret);
+}
+#endif
+
+void hx_check_power_status(struct work_struct *work)
+{
+	struct himax_ts_data *ts = container_of(work, struct himax_ts_data,
+			work_pwr.work);
+
+	ts->latest_power_status = power_supply_is_system_supplied();
+
+	I("Update ts->latest_power_status = %X", ts->latest_power_status);
+
+	himax_cable_detect_func(ts, true);
+}
+
+int pwr_notifier_callback(struct notifier_block *self,
+			  unsigned long event, void *data)
+{
+	struct himax_ts_data *ts = container_of(self, struct himax_ts_data,
+		power_notif);
+	I("entered. event = %lX", event);
+
+	cancel_delayed_work_sync(&ts->work_pwr);
+	queue_delayed_work(ts->himax_pwr_wq, &ts->work_pwr,
+			   msecs_to_jiffies(1100));
+
+	return 0;
+}
+
+void himax_pwr_register(struct work_struct *work)
+{
+	int ret = 0;
+	struct himax_ts_data *ts = container_of(work, struct himax_ts_data,
+			work_pwr.work);
+
+	ts->power_notif.notifier_call = pwr_notifier_callback;
+	ret = power_supply_reg_notifier(&ts->power_notif);
+	if (ret) {
+		E("Unable to register power_notif: %d", ret);
+	} else {
+		INIT_DELAYED_WORK(&ts->work_pwr, hx_check_power_status);
+		queue_delayed_work(ts->himax_pwr_wq, &ts->work_pwr,
+				   msecs_to_jiffies(3000));
+	}
+}
diff --git a/drivers/hid/hx-hid/hx_plat.h b/drivers/hid/hx-hid/hx_plat.h
new file mode 100644
index 000000000000..12f473a08d3b
--- /dev/null
+++ b/drivers/hid/hx-hid/hx_plat.h
@@ -0,0 +1,30 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef __HX_PLAT_H__
+#define __HX_PLAT_H__
+
+#include "hx_core.h"
+#include <linux/notifier.h>
+#include <linux/power_supply.h>
+
+#if defined(CONFIG_FB)
+int fb_notifier_callback(struct notifier_block *self,
+			 unsigned long event, void *data);
+void himax_fb_register(struct work_struct *work);
+#endif
+
+void himax_pwr_register(struct work_struct *work);
+
+int himax_gpio_power_config(struct himax_ts_data *ts,
+			    struct himax_platform_data *pdata);
+void himax_gpio_power_deconfig(struct himax_platform_data *pdata);
+int himax_bus_read(struct himax_ts_data *ts, u8 cmd, u8 *buf,
+		   u32 len);
+int himax_bus_write(struct himax_ts_data *ts, u8 cmd, u8 *addr,
+		    u8 *data, u32 len);
+void himax_int_enable(struct himax_ts_data *ts, int enable);
+int himax_int_register_trigger(struct himax_ts_data *ts);
+int himax_int_en_set(void);
+int himax_ts_register_interrupt(struct himax_ts_data *ts);
+int himax_ts_unregister_interrupt(struct himax_ts_data *ts);
+
+#endif
-- 
2.25.1

