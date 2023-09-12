Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D251179CC55
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 11:49:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232956AbjILJtw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 05:49:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232854AbjILJtv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 05:49:51 -0400
Received: from AUS01-ME3-obe.outbound.protection.outlook.com (mail-me3aus01olkn2175.outbound.protection.outlook.com [40.92.63.175])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D97C2E6C;
        Tue, 12 Sep 2023 02:49:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=a2ZMqnrJtXPa5EPv4Ihnr7FuW4cgPZzt7f2fvo7GISN9BJyQuYDTPPXPv+D7rTzVMp0ZLD2ItHD6R4+wvFk74LhEITU3nShck6OQeBZ1+nYyEmbL5rb7TUTSGZAcD3UY36ro9vC1QkF7ou7497RBr8ykR1cuV4z6YOktCJtinp3KwWrg4KQVYhU/sIEf6epvtUmQ93Vby8n7XGTMRtdQHT8pVYd8qDzq+GMn2J66LiObss0Q13peS+X0v2SI/04idncd2bdKH0kf8MhIZPRw/YjRR0dYyn7Sfh6iiBgXGEFJef0cOuc86QBxgXFRuuwgqhp10oCsVB8GobL4ooz6ew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=F0kHDrQc5x1gLsYC9lu18yg0qGADXmyvgcCdOUQTgEA=;
 b=S8GgfY9/QNbM8WSENosUwv2BTMlk5mK4A7SXwFcvMP7zyeN4IskDSfRxgULLUUIVrj0Fwi4O0oqP32JrKxue4Q/CnrDBb3triP2Ee8a2LCCFhC6Zkya7r8zrg6eIZ4AiX8SRqgRu3PfS2d90rUDGxXm6uPDM/pesDnJOTTBJDDbPJwcqfwhPxBQtAja2HbxeZwrpHMX/Kf28qrcLBJvPWT5Gg4g2U6QdObL+Cxgz8p24ic/0Eh2pSN3/+5zJ+aSPbh5kgaeQnmOC7hPxEqkNLoLHHHPo0Ywq3h7iVngjeE0bUta9C9fdzV36ZQlqkC7Gm1rqHaYao7XkVTX+KWOIOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F0kHDrQc5x1gLsYC9lu18yg0qGADXmyvgcCdOUQTgEA=;
 b=Z7cqjhkFqTvk+dhHw7IHfiDWznXYRYVM2TuGZUPrPc1yb5yrdsB+G0CA68pP296jlufcfbZnDOEBlVAWuclcDx/M5yO1a4QBmHjCC5fjb9JkvAlOSFUbRs0txl/Oo+ylnYsbvKpaWeMQcCeH8zVCWlU8iGJ9/qWoScIAbFvS3ZcPAC+NoguItVm7dfm0hmjfpDuxCnEJ0QEAi8MqG20CM35LzqmuHAUZGP00EX6pVFA0v9JCOYMX+R9H9/ADZGW4mikp4lXr35l+Fa0znk8PQo9vFAofjSP0Z24ak8xhlE9Dcanqk3nyoaUA8bRmBn9w0ya2C8zEXc2xFwB28A9MKg==
Received: from ME3P282MB2703.AUSP282.PROD.OUTLOOK.COM (2603:10c6:220:16b::5)
 by SY4P282MB2981.AUSP282.PROD.OUTLOOK.COM (2603:10c6:10:15c::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6768.35; Tue, 12 Sep
 2023 09:49:39 +0000
Received: from ME3P282MB2703.AUSP282.PROD.OUTLOOK.COM
 ([fe80::68b4:6263:97f:9a45]) by ME3P282MB2703.AUSP282.PROD.OUTLOOK.COM
 ([fe80::68b4:6263:97f:9a45%3]) with mapi id 15.20.6768.036; Tue, 12 Sep 2023
 09:49:39 +0000
From:   Jinjian Song <songjinjian@hotmail.com>
To:     davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, corbet@lwn.net, loic.poulain@linaro.org,
        ryazanov.s.a@gmail.com
Cc:     jiri@resnulli.us, johannes@sipsolutions.net,
        chandrashekar.devegowda@intel.com, linuxwwan@intel.com,
        chiranjeevi.rapolu@linux.intel.com, haijun.liu@mediatek.com,
        m.chetan.kumar@linux.intel.com, ricardo.martinez@linux.intel.com,
        netdev@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, nmarupaka@google.com,
        vsankar@lenovo.com, danielwinkler@google.com,
        Jinjian Song <jinjian.song@fibocom.com>
Subject: [net-next v4 2/5] net: wwan: t7xx: Register with devlink and implement firmware flashing
Date:   Tue, 12 Sep 2023 17:48:42 +0800
Message-ID: <ME3P282MB270385E81F0FF71C2BA64895BBF1A@ME3P282MB2703.AUSP282.PROD.OUTLOOK.COM>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230912094845.11233-1-songjinjian@hotmail.com>
References: <20230912094845.11233-1-songjinjian@hotmail.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN:  [yM78TcBkNZGmr4Ntoyn9ZQtYD46Qwmyt]
X-ClientProxiedBy: SI2PR01CA0048.apcprd01.prod.exchangelabs.com
 (2603:1096:4:193::17) To ME3P282MB2703.AUSP282.PROD.OUTLOOK.COM
 (2603:10c6:220:16b::5)
X-Microsoft-Original-Message-ID: <20230912094845.11233-3-songjinjian@hotmail.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: ME3P282MB2703:EE_|SY4P282MB2981:EE_
X-MS-Office365-Filtering-Correlation-Id: ee0fd639-05c7-48b4-8481-08dbb375946e
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: s4OjoZPdeUGNvIeEah+gzZFoLKe3L5YL6Pzmnwh07BWun2ns8hYqgTUdj8r6/7VHqkdRxiArUCUNzmr6ojoPjtp+ldrUPB59oV+NbWiZfb7fZn3YJRKcpbJFsrGxXwsrlqlATwEK2s0NO80OPny6Gj0fxj2J0S8hK/VBRwamOJXE2MLJpVdEmHfZde75JZlwP4O4pjwSBuZUG5tw7rDjBWYkqj/3utfiUQAvcpfscXjCSKNhNsiivg46jncI+Q6cB6snZiHd4ARHC30lQ+Xe1Lzzl9ea3bpWlHesSnZ1CgaBXpXx7BWtW6dA/Npshr58wpZZ4ihUUbsQ2X8Hyqd+mcc1c7aL4NrYOoHfVcOnBq5hbvQibuAWcMieVeF9174jQ73HlAhJrvTK+ysUBROLeV9PAq+Uw46mqYElHU78cpi5SSsSAr23/v0DqDN/X1AO1Vc3XIpwRtW7zuvfUJAOO8uIf7Afwc0nLW24hD7Idr087o5h6QU8sqayp6OL+cZ/R98jBSHgTOulH+0lzshoC6xbb/J5G1sf2okH9sTT3C8lUCk/9uFnVoO9t4aeRD6En+8U7RU696cm/6Ued01TgCwTma5/6buqRchNSwKtl4o=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?TtVYiaG+rXUhj3QRQWiLOivDVCe8ahcwqFYUV8heU2zJgldOp6meMBt+jXcC?=
 =?us-ascii?Q?RLBxPiiotoGzUz8vC0X3D3/VUcTvsH4IUrZwMCpH8eyVjmKvJI+cjZwaN8AF?=
 =?us-ascii?Q?sMtK0BF2EAPKHnvDS7jI+Y0PRiwgyuC4DjSTeN2TIzHKPhQCilNPcGgxpd8A?=
 =?us-ascii?Q?kJ9PwSmQW+hzll5iZRLoVJTjAf0vrFBZDrhxWR3RL6vWKqCPw6bTEldgFLED?=
 =?us-ascii?Q?YdiAOn35rt8CZwuFgVnwzACocUemoyjwPAPX8VxpZd4vq870uYOznPmPbyEz?=
 =?us-ascii?Q?EnzqvebzgifqpFzfRFRIef6cABL8zEalDijOPJaW7WOAKMJz3VwpqA6ya610?=
 =?us-ascii?Q?aSlh0KeY9WGU7sdRZk6xNJy/JXvHAmoiIr0VSFUVcBm5IeS0JFz5MNpJbIiy?=
 =?us-ascii?Q?4NzbT0n/jK6obd6bfvFfl1+WEjrLJ6AVSKd/qqv8I00KMIQoraF2OOyInl8k?=
 =?us-ascii?Q?omz+mHQo2Ab//azXNPufftUyyiz+euvgEAbF6ClLOxCXBRl1NnYUmsoMwSHh?=
 =?us-ascii?Q?zRrI2LIrJyE/3Oz3PbQ+/nFjvka3/ztQTbhgUf9j2Bq4kNISYKv7xhuNtfP0?=
 =?us-ascii?Q?lZYvgRlIN0DVwwf8f1qM8Hm2Ya+z2NWhhkDSia1P438X2eSkSUAuwaN3Ht/U?=
 =?us-ascii?Q?95jLADOLMX7DXWsvqllgGUDn8J2cACz+zjdtg1A48FFQBxVvQGnYXkQgt6+k?=
 =?us-ascii?Q?p+h8kL9aCxq+nF6Kv6YyUfJPeW0xKavu6wV+VyifpYs32aOiu0Ekv/o3Xmoj?=
 =?us-ascii?Q?qoaqtHUG8M1sjr2ZiMqEEclWBmHEVezzgqHDa5eE+6BXg4rWE6pLS/rY0ZMJ?=
 =?us-ascii?Q?MLlq37RI4HEa5jMrWJ2S4/VXEczKiwgsGGQm476Hx5XuX5E+K4PfNhHjPoFf?=
 =?us-ascii?Q?PHnkxVpMCjG8YUvOiXlCsQ14YPAbNIvthfcO2ZItnoUVhHGyV7xOukEV7q1A?=
 =?us-ascii?Q?mO6xIOZiLV/HHE1ZsTVGDDsQeW6iG1X90wJCSRzvIaIPtUboqoEV3aK0gXU5?=
 =?us-ascii?Q?PlzWWQ8efBAFZNTUrkK98eEcbpSVOR9XuejijelSgcy6pxn1weXljE+E42pE?=
 =?us-ascii?Q?wJ3PVaLCMcobWW38hhaRhEU6p8YSI2KSiwTk7KNkjuL0lCkzB3yC2fAIKkoZ?=
 =?us-ascii?Q?/QmkkRBROkNSvd4Rim8JEXEP9ugph2KI4DCd84qJdTvCFsQFbfTxFCi2aeH3?=
 =?us-ascii?Q?nBZtHW028/OIgUyFOqOERyVdRY04CJ3nH9lOrM4iyi99775MuzaBlgbnGOI?=
 =?us-ascii?Q?=3D?=
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-746f3.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: ee0fd639-05c7-48b4-8481-08dbb375946e
X-MS-Exchange-CrossTenant-AuthSource: ME3P282MB2703.AUSP282.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Sep 2023 09:49:39.1009
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SY4P282MB2981
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jinjian Song <jinjian.song@fibocom.com>

Adds support for t7xx wwan device firmware flashing using devlink.

On early detection of wwan device in fastboot mode driver sets up CLDMA0 HW
tx/rx queues for raw data transfer and then registers to devlink framework.

On user space application issuing command for firmware update the driver
sends fastboot flash command & firmware to program NAND.

In flashing procedure the fastboot command & response are exchanged between
driver and device.

Below is the devlink command usage for firmware flashing

$devlink dev flash pci/$BDF file ABC.img component ABC

Note: ABC.img is the firmware to be programmed to "ABC" partition.

Base on the v5 patch version of follow series:
'net: wwan: t7xx: fw flashing & coredump support'
(https://patchwork.kernel.org/project/netdevbpf/patch/fc8bbb0b66a5ff3a489ea9857d79b374508090ef.1674307425.git.m.chetan.kumar@linux.intel.com/)

Signed-off-by: Jinjian Song <jinjian.song@fibocom.com>
---
v4:
 * no change
v3:
 * no change
v2:
 * modify functions and struct name from devlink to flash_dump
 * delete stub funtions
 * delete devlink_flash_update_status_notify
 * delete devlink_info_get_loopbak
---
 drivers/net/wwan/Kconfig                     |   1 +
 drivers/net/wwan/t7xx/Makefile               |   4 +-
 drivers/net/wwan/t7xx/t7xx_pci.c             |  17 +-
 drivers/net/wwan/t7xx/t7xx_pci.h             |   2 +
 drivers/net/wwan/t7xx/t7xx_port.h            |   2 +
 drivers/net/wwan/t7xx/t7xx_port_ap_msg.c     |  78 ++++
 drivers/net/wwan/t7xx/t7xx_port_ap_msg.h     |  11 +
 drivers/net/wwan/t7xx/t7xx_port_flash_dump.c | 427 +++++++++++++++++++
 drivers/net/wwan/t7xx/t7xx_port_flash_dump.h |  45 ++
 drivers/net/wwan/t7xx/t7xx_port_proxy.c      |  32 ++
 drivers/net/wwan/t7xx/t7xx_port_proxy.h      |   4 +
 drivers/net/wwan/t7xx/t7xx_port_wwan.c       |  22 +-
 drivers/net/wwan/t7xx/t7xx_reg.h             |   6 +
 drivers/net/wwan/t7xx/t7xx_state_monitor.c   |  42 +-
 14 files changed, 663 insertions(+), 30 deletions(-)
 create mode 100644 drivers/net/wwan/t7xx/t7xx_port_ap_msg.c
 create mode 100644 drivers/net/wwan/t7xx/t7xx_port_ap_msg.h
 create mode 100644 drivers/net/wwan/t7xx/t7xx_port_flash_dump.c
 create mode 100644 drivers/net/wwan/t7xx/t7xx_port_flash_dump.h

diff --git a/drivers/net/wwan/Kconfig b/drivers/net/wwan/Kconfig
index 410b0245114e..dd7a9883c1ff 100644
--- a/drivers/net/wwan/Kconfig
+++ b/drivers/net/wwan/Kconfig
@@ -108,6 +108,7 @@ config IOSM
 config MTK_T7XX
 	tristate "MediaTek PCIe 5G WWAN modem T7xx device"
 	depends on PCI
+	select NET_DEVLINK
 	select RELAY if WWAN_DEBUGFS
 	help
 	  Enables MediaTek PCIe based 5G WWAN modem (T7xx series) device.
diff --git a/drivers/net/wwan/t7xx/Makefile b/drivers/net/wwan/t7xx/Makefile
index 2652cd00504e..e5785bae64d5 100644
--- a/drivers/net/wwan/t7xx/Makefile
+++ b/drivers/net/wwan/t7xx/Makefile
@@ -15,7 +15,9 @@ mtk_t7xx-y:=	t7xx_pci.o \
 		t7xx_hif_dpmaif_tx.o \
 		t7xx_hif_dpmaif_rx.o  \
 		t7xx_dpmaif.o \
-		t7xx_netdev.o
+		t7xx_netdev.o \
+		t7xx_port_flash_dump.o \
+		t7xx_port_ap_msg.o
 
 mtk_t7xx-$(CONFIG_WWAN_DEBUGFS) += \
 		t7xx_port_trace.o \
diff --git a/drivers/net/wwan/t7xx/t7xx_pci.c b/drivers/net/wwan/t7xx/t7xx_pci.c
index 91256e005b84..845d1555f134 100644
--- a/drivers/net/wwan/t7xx/t7xx_pci.c
+++ b/drivers/net/wwan/t7xx/t7xx_pci.c
@@ -39,6 +39,7 @@
 #include "t7xx_modem_ops.h"
 #include "t7xx_pci.h"
 #include "t7xx_pcie_mac.h"
+#include "t7xx_port_flash_dump.h"
 #include "t7xx_reg.h"
 #include "t7xx_state_monitor.h"
 
@@ -108,7 +109,7 @@ static int t7xx_pci_pm_init(struct t7xx_pci_dev *t7xx_dev)
 	pm_runtime_set_autosuspend_delay(&pdev->dev, PM_AUTOSUSPEND_MS);
 	pm_runtime_use_autosuspend(&pdev->dev);
 
-	return t7xx_wait_pm_config(t7xx_dev);
+	return 0;
 }
 
 void t7xx_pci_pm_init_late(struct t7xx_pci_dev *t7xx_dev)
@@ -723,22 +724,30 @@ static int t7xx_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 	t7xx_pci_infracfg_ao_calc(t7xx_dev);
 	t7xx_mhccif_init(t7xx_dev);
 
-	ret = t7xx_md_init(t7xx_dev);
+	ret = t7xx_devlink_register(t7xx_dev);
 	if (ret)
 		return ret;
 
+	ret = t7xx_md_init(t7xx_dev);
+	if (ret)
+		goto err_devlink_unregister;
+
 	t7xx_pcie_mac_interrupts_dis(t7xx_dev);
 
 	ret = t7xx_interrupt_init(t7xx_dev);
 	if (ret) {
 		t7xx_md_exit(t7xx_dev);
-		return ret;
+		goto err_devlink_unregister;
 	}
 
 	t7xx_pcie_mac_set_int(t7xx_dev, MHCCIF_INT);
 	t7xx_pcie_mac_interrupts_en(t7xx_dev);
 
 	return 0;
+
+err_devlink_unregister:
+	t7xx_devlink_unregister(t7xx_dev);
+	return ret;
 }
 
 static void t7xx_pci_remove(struct pci_dev *pdev)
@@ -757,6 +766,8 @@ static void t7xx_pci_remove(struct pci_dev *pdev)
 	}
 
 	pci_free_irq_vectors(t7xx_dev->pdev);
+
+	t7xx_devlink_unregister(t7xx_dev);
 }
 
 static const struct pci_device_id t7xx_pci_table[] = {
diff --git a/drivers/net/wwan/t7xx/t7xx_pci.h b/drivers/net/wwan/t7xx/t7xx_pci.h
index f08f1ab74469..28f22a2dc493 100644
--- a/drivers/net/wwan/t7xx/t7xx_pci.h
+++ b/drivers/net/wwan/t7xx/t7xx_pci.h
@@ -59,6 +59,7 @@ typedef irqreturn_t (*t7xx_intr_callback)(int irq, void *param);
  * @md_pm_lock: protects PCIe sleep lock
  * @sleep_disable_count: PCIe L1.2 lock counter
  * @sleep_lock_acquire: indicates that sleep has been disabled
+ * @flash_dump: devlink struct
  */
 struct t7xx_pci_dev {
 	t7xx_intr_callback	intr_handler[EXT_INT_NUM];
@@ -82,6 +83,7 @@ struct t7xx_pci_dev {
 #ifdef CONFIG_WWAN_DEBUGFS
 	struct dentry		*debugfs_dir;
 #endif
+	struct t7xx_flash_dump	*flash_dump;
 };
 
 enum t7xx_pm_id {
diff --git a/drivers/net/wwan/t7xx/t7xx_port.h b/drivers/net/wwan/t7xx/t7xx_port.h
index 09acb1ef144d..dfa7ad2a9796 100644
--- a/drivers/net/wwan/t7xx/t7xx_port.h
+++ b/drivers/net/wwan/t7xx/t7xx_port.h
@@ -42,6 +42,8 @@ enum port_ch {
 	/* to AP */
 	PORT_CH_AP_CONTROL_RX = 0x1000,
 	PORT_CH_AP_CONTROL_TX = 0x1001,
+	PORT_CH_AP_MSG_RX = 0x101E,
+	PORT_CH_AP_MSG_TX = 0x101F,
 
 	/* to MD */
 	PORT_CH_CONTROL_RX = 0x2000,
diff --git a/drivers/net/wwan/t7xx/t7xx_port_ap_msg.c b/drivers/net/wwan/t7xx/t7xx_port_ap_msg.c
new file mode 100644
index 000000000000..46f311a38fbb
--- /dev/null
+++ b/drivers/net/wwan/t7xx/t7xx_port_ap_msg.c
@@ -0,0 +1,78 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (c) 2022-2023, Intel Corporation.
+ */
+
+#include "t7xx_port.h"
+#include "t7xx_port_proxy.h"
+#include "t7xx_port_flash_dump.h"
+#include "t7xx_state_monitor.h"
+#include "t7xx_port_ap_msg.h"
+
+int t7xx_port_ap_msg_tx(struct t7xx_port *port, char *buff, size_t len)
+{
+	const struct t7xx_port_conf *port_conf;
+	size_t offset, chunk_len = 0, txq_mtu;
+	struct t7xx_fsm_ctl *ctl;
+	struct sk_buff *skb_ccci;
+	enum md_state md_state;
+	int ret;
+
+	if (!len || !port->chan_enable)
+		return -EINVAL;
+
+	port_conf = port->port_conf;
+	ctl = port->t7xx_dev->md->fsm_ctl;
+	md_state = t7xx_fsm_get_md_state(ctl);
+	if (md_state == MD_STATE_WAITING_FOR_HS1 || md_state == MD_STATE_WAITING_FOR_HS2) {
+		dev_warn(port->dev, "Cannot write to %s port when md_state=%d\n",
+			 port_conf->name, md_state);
+		return -ENODEV;
+	}
+
+	txq_mtu = t7xx_get_port_mtu(port);
+	for (offset = 0; offset < len; offset += chunk_len) {
+		chunk_len = min(len - offset, txq_mtu - sizeof(struct ccci_header));
+		skb_ccci = t7xx_port_alloc_skb(chunk_len);
+		if (!skb_ccci)
+			return -ENOMEM;
+
+		skb_put_data(skb_ccci, buff + offset, chunk_len);
+		ret = t7xx_port_send_skb(port, skb_ccci, 0, 0);
+		if (ret) {
+			dev_kfree_skb_any(skb_ccci);
+			dev_err(port->dev, "Write error on %s port, %d\n",
+				port_conf->name, ret);
+			return ret;
+		}
+	}
+
+	return len;
+}
+
+static int t7xx_port_ap_msg_init(struct t7xx_port *port)
+{
+	struct t7xx_flash_dump *flash_dump = port->t7xx_dev->flash_dump;
+
+	port->rx_length_th = T7XX_MAX_QUEUE_LENGTH;
+	flash_dump->status = T7XX_DEVLINK_IDLE;
+	flash_dump->port = port;
+
+	return 0;
+}
+
+static void t7xx_port_ap_msg_uninit(struct t7xx_port *port)
+{
+	struct t7xx_flash_dump *flash_dump = port->t7xx_dev->flash_dump;
+
+	flash_dump->mode = T7XX_NORMAL_MODE;
+	skb_queue_purge(&port->rx_skb_list);
+}
+
+struct port_ops ap_msg_port_ops = {
+	.init = &t7xx_port_ap_msg_init,
+	.recv_skb = &t7xx_port_enqueue_skb,
+	.uninit = &t7xx_port_ap_msg_uninit,
+	.enable_chl = &t7xx_port_enable_chl,
+	.disable_chl = &t7xx_port_disable_chl,
+};
diff --git a/drivers/net/wwan/t7xx/t7xx_port_ap_msg.h b/drivers/net/wwan/t7xx/t7xx_port_ap_msg.h
new file mode 100644
index 000000000000..4838d87d86cf
--- /dev/null
+++ b/drivers/net/wwan/t7xx/t7xx_port_ap_msg.h
@@ -0,0 +1,11 @@
+/* SPDX-License-Identifier: GPL-2.0-only
+ *
+ * Copyright (c) 2022-2023, Intel Corporation.
+ */
+
+#ifndef __T7XX_PORT_AP_MSG_H__
+#define __T7XX_PORT_AP_MSG_H__
+
+int t7xx_port_ap_msg_tx(struct t7xx_port *port, char *buff, size_t len);
+
+#endif /* __T7XX_PORT_AP_MSG_H__ */
diff --git a/drivers/net/wwan/t7xx/t7xx_port_flash_dump.c b/drivers/net/wwan/t7xx/t7xx_port_flash_dump.c
new file mode 100644
index 000000000000..1129ef793798
--- /dev/null
+++ b/drivers/net/wwan/t7xx/t7xx_port_flash_dump.c
@@ -0,0 +1,427 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (c) 2022-2023, Intel Corporation.
+ */
+
+#include <linux/vmalloc.h>
+
+#include "t7xx_port_proxy.h"
+#include "t7xx_port_ap_msg.h"
+#include "t7xx_port_flash_dump.h"
+
+static int t7xx_flash_dump_port_read(struct t7xx_port *port, char *buf, size_t count)
+{
+	struct sk_buff *skb;
+	int read_len;
+
+	spin_lock_irq(&port->rx_wq.lock);
+	if (skb_queue_empty(&port->rx_skb_list)) {
+		int ret = wait_event_interruptible_locked_irq(port->rx_wq,
+							      !skb_queue_empty(&port->rx_skb_list));
+		if (ret == -ERESTARTSYS) {
+			spin_unlock_irq(&port->rx_wq.lock);
+			return ret;
+		}
+	}
+	skb = skb_dequeue(&port->rx_skb_list);
+	spin_unlock_irq(&port->rx_wq.lock);
+
+	read_len = min_t(size_t, count, skb->len);
+	memcpy(buf, skb->data, read_len);
+
+	if (read_len < skb->len) {
+		skb_pull(skb, read_len);
+		skb_queue_head(&port->rx_skb_list, skb);
+	} else {
+		consume_skb(skb);
+	}
+
+	return read_len;
+}
+
+static int t7xx_flash_dump_port_write(struct t7xx_port *port, const char *buf, size_t count)
+{
+	const struct t7xx_port_conf *port_conf = port->port_conf;
+	size_t actual = count, offset = 0;
+	int txq_mtu;
+
+	txq_mtu = t7xx_get_port_mtu(port);
+	if (txq_mtu < 0)
+		return -EINVAL;
+
+	while (actual) {
+		int len = min_t(size_t, actual, txq_mtu);
+		struct sk_buff *skb;
+		int ret;
+
+		skb = __dev_alloc_skb(len, GFP_KERNEL);
+		if (!skb)
+			return -ENOMEM;
+
+		skb_put_data(skb, buf + offset, len);
+		ret = t7xx_port_send_raw_skb(port, skb);
+		if (ret) {
+			dev_err(port->dev, "write error on %s, size: %d, ret: %d\n",
+				port_conf->name, len, ret);
+			dev_kfree_skb(skb);
+			return ret;
+		}
+
+		offset += len;
+		actual -= len;
+	}
+
+	return count;
+}
+
+static int t7xx_flash_dump_fb_handle_response(struct t7xx_port *port, char *data)
+{
+	char status[T7XX_FB_RESPONSE_SIZE + 1];
+	int ret = 0, index;
+
+	for (index = 0; index < T7XX_FB_RESP_COUNT; index++) {
+		int read_bytes = t7xx_flash_dump_port_read(port, status, T7XX_FB_RESPONSE_SIZE);
+
+		if (read_bytes < 0) {
+			dev_err(port->dev, "status read interrupted\n");
+			ret = read_bytes;
+			break;
+		}
+
+		status[read_bytes] = '\0';
+		dev_dbg(port->dev, "raw response from device: %s\n", status);
+		if (!strncmp(status, T7XX_FB_RESP_INFO, strlen(T7XX_FB_RESP_INFO))) {
+			break;
+		} else if (!strncmp(status, T7XX_FB_RESP_OKAY, strlen(T7XX_FB_RESP_OKAY))) {
+			break;
+		} else if (!strncmp(status, T7XX_FB_RESP_FAIL, strlen(T7XX_FB_RESP_FAIL))) {
+			ret = -EPROTO;
+			break;
+		} else if (!strncmp(status, T7XX_FB_RESP_DATA, strlen(T7XX_FB_RESP_DATA))) {
+			if (data)
+				snprintf(data, T7XX_FB_RESPONSE_SIZE, "%s",
+					 status + strlen(T7XX_FB_RESP_DATA));
+			break;
+		}
+	}
+
+	return ret;
+}
+
+static int t7xx_flash_dump_fb_raw_command(char *cmd, struct t7xx_port *port, char *data)
+{
+	int ret, cmd_size = strlen(cmd);
+
+	if (cmd_size > T7XX_FB_COMMAND_SIZE) {
+		dev_err(port->dev, "command length %d is long\n", cmd_size);
+		return -EINVAL;
+	}
+
+	if (cmd_size != t7xx_flash_dump_port_write(port, cmd, cmd_size)) {
+		dev_err(port->dev, "raw command = %s write failed\n", cmd);
+		return -EIO;
+	}
+
+	dev_dbg(port->dev, "raw command = %s written to the device\n", cmd);
+	ret = t7xx_flash_dump_fb_handle_response(port, data);
+	if (ret)
+		dev_err(port->dev, "raw command = %s response FAILURE:%d\n", cmd, ret);
+
+	return ret;
+}
+
+static int t7xx_flash_dump_fb_download_command(struct t7xx_port *port, size_t size)
+{
+	char download_command[T7XX_FB_COMMAND_SIZE];
+
+	snprintf(download_command, sizeof(download_command), "%s:%08zx",
+		 T7XX_FB_CMD_DOWNLOAD, size);
+	return t7xx_flash_dump_fb_raw_command(download_command, port, NULL);
+}
+
+static int t7xx_flash_dump_fb_download(struct t7xx_port *port, const u8 *buf, size_t size)
+{
+	int ret;
+
+	if (!size)
+		return -EINVAL;
+
+	ret = t7xx_flash_dump_fb_download_command(port, size);
+	if (ret)
+		return ret;
+
+	ret = t7xx_flash_dump_port_write(port, buf, size);
+	if (ret < 0)
+		return ret;
+
+	return t7xx_flash_dump_fb_handle_response(port, NULL);
+}
+
+static int t7xx_flash_dump_fb_flash(struct t7xx_port *port, const char *cmd)
+{
+	char flash_command[T7XX_FB_COMMAND_SIZE];
+
+	snprintf(flash_command, sizeof(flash_command), "%s:%s", T7XX_FB_CMD_FLASH, cmd);
+	return t7xx_flash_dump_fb_raw_command(flash_command, port, NULL);
+}
+
+static int t7xx_flash_dump_fb_flash_partition(struct t7xx_port *port, const char *partition,
+					      const u8 *buf, size_t size)
+{
+	int ret;
+
+	ret = t7xx_flash_dump_fb_download(port, buf, size);
+	if (ret < 0)
+		return ret;
+
+	return t7xx_flash_dump_fb_flash(port, partition);
+}
+
+static int t7xx_devlink_flash_update(struct devlink *devlink,
+				     struct devlink_flash_update_params *params,
+				     struct netlink_ext_ack *extack)
+{
+	struct t7xx_flash_dump *flash_dump = devlink_priv(devlink);
+	const char *component = params->component;
+	const struct firmware *fw = params->fw;
+	struct t7xx_port *port;
+	int ret;
+
+	if (flash_dump->mode != T7XX_FB_DL_MODE) {
+		dev_err(&flash_dump->t7xx_dev->pdev->dev, "Modem is not in fastboot download mode!\n");
+		ret = -EPERM;
+		goto err_out;
+	}
+
+	if (flash_dump->status != T7XX_DEVLINK_IDLE) {
+		dev_err(&flash_dump->t7xx_dev->pdev->dev, "Modem is busy!\n");
+		ret = -EBUSY;
+		goto err_out;
+	}
+
+	if (!component || !fw->data) {
+		ret = -EINVAL;
+		goto err_out;
+	}
+
+	set_bit(T7XX_FLASH_STATUS, &flash_dump->status);
+	port = flash_dump->port;
+	dev_dbg(port->dev, "flash partition name:%s binary size:%zu\n", component, fw->size);
+	ret = t7xx_flash_dump_fb_flash_partition(port, component, fw->data, fw->size);
+	clear_bit(T7XX_FLASH_STATUS, &flash_dump->status);
+
+err_out:
+	return ret;
+}
+
+enum t7xx_devlink_param_id {
+	T7XX_DEVLINK_PARAM_ID_BASE = DEVLINK_PARAM_GENERIC_ID_MAX,
+	T7XX_DEVLINK_PARAM_ID_FASTBOOT,
+};
+
+static const struct devlink_param t7xx_devlink_params[] = {
+	DEVLINK_PARAM_DRIVER(T7XX_DEVLINK_PARAM_ID_FASTBOOT,
+			     "fastboot", DEVLINK_PARAM_TYPE_BOOL,
+			     BIT(DEVLINK_PARAM_CMODE_DRIVERINIT),
+			     NULL, NULL, NULL),
+};
+
+bool t7xx_devlink_param_get_fastboot(struct devlink *devlink)
+{
+	union devlink_param_value saved_value;
+
+	devl_param_driverinit_value_get(devlink, T7XX_DEVLINK_PARAM_ID_FASTBOOT,
+					&saved_value);
+	return saved_value.vbool;
+}
+
+static int t7xx_devlink_reload_down(struct devlink *devlink, bool netns_change,
+				    enum devlink_reload_action action,
+				    enum devlink_reload_limit limit,
+				    struct netlink_ext_ack *extack)
+{
+	struct t7xx_flash_dump *flash_dump = devlink_priv(devlink);
+
+	switch (action) {
+	case DEVLINK_RELOAD_ACTION_DRIVER_REINIT:
+		return 0;
+	case DEVLINK_RELOAD_ACTION_FW_ACTIVATE:
+		if (!flash_dump->mode)
+			return -EPERM;
+		return t7xx_flash_dump_fb_raw_command(T7XX_FB_CMD_REBOOT, flash_dump->port, NULL);
+	default:
+		/* Unsupported action should not get to this function */
+		return -EOPNOTSUPP;
+	}
+}
+
+static int t7xx_devlink_reload_up(struct devlink *devlink,
+				  enum devlink_reload_action action,
+				  enum devlink_reload_limit limit,
+				  u32 *actions_performed,
+				  struct netlink_ext_ack *extack)
+{
+	*actions_performed = BIT(action);
+	switch (action) {
+	case DEVLINK_RELOAD_ACTION_DRIVER_REINIT:
+	case DEVLINK_RELOAD_ACTION_FW_ACTIVATE:
+		return 0;
+	default:
+		/* Unsupported action should not get to this function */
+		return -EOPNOTSUPP;
+	}
+}
+
+static int t7xx_flash_dump_get_part_ver_fb_mode(struct t7xx_port *port, const char *cmd, char *data)
+{
+	char req_command[T7XX_FB_COMMAND_SIZE];
+
+	snprintf(req_command, sizeof(req_command), "%s:%s", T7XX_FB_CMD_GET_VER, cmd);
+	return t7xx_flash_dump_fb_raw_command(req_command, port, data);
+}
+
+static int t7xx_flash_dump_get_part_ver_norm_mode(struct t7xx_port *port, const char *cmd,
+						  char *data)
+{
+	char req_command[T7XX_FB_COMMAND_SIZE];
+	int len;
+
+	len = snprintf(req_command, sizeof(req_command), "%s:%s", T7XX_FB_CMD_GET_VER, cmd);
+	t7xx_port_ap_msg_tx(port, req_command, len);
+
+	return t7xx_flash_dump_fb_handle_response(port, data);
+}
+
+static int t7xx_devlink_info_get(struct devlink *devlink, struct devlink_info_req *req,
+				 struct netlink_ext_ack *extack)
+{
+	struct t7xx_flash_dump *flash_dump = devlink_priv(devlink);
+	char *part_name, *ver, *part_no, *data;
+	int ret, total_part, i, ver_len;
+	struct t7xx_port *port;
+
+	port = flash_dump->port;
+	port->port_conf->ops->enable_chl(port);
+
+	if (flash_dump->status != T7XX_DEVLINK_IDLE) {
+		dev_err(&flash_dump->t7xx_dev->pdev->dev, "Modem is busy!\n");
+		return -EBUSY;
+	}
+
+	data = kzalloc(T7XX_FB_RESPONSE_SIZE, GFP_KERNEL);
+	if (!data)
+		return -ENOMEM;
+
+	set_bit(T7XX_GET_INFO, &flash_dump->status);
+	if (flash_dump->mode == T7XX_FB_DL_MODE)
+		ret = t7xx_flash_dump_get_part_ver_fb_mode(port, "", data);
+	else
+		ret = t7xx_flash_dump_get_part_ver_norm_mode(port, "", data);
+
+	if (ret < 0)
+		goto err_clear_bit;
+
+	part_no = strsep(&data, ",");
+	if (kstrtoint(part_no, 16, &total_part)) {
+		dev_err(&flash_dump->t7xx_dev->pdev->dev, "kstrtoint error!\n");
+		ret = -EINVAL;
+		goto err_clear_bit;
+	}
+
+	for (i = 0; i < total_part; i++) {
+		part_name = strsep(&data, ",");
+		ver = strsep(&data, ",");
+		ver_len = strlen(ver);
+		if (ver[ver_len - 2] == 0x5C && ver[ver_len - 1] == 0x6E)
+			ver[ver_len - 4] = '\0';
+		ret = devlink_info_version_running_put_ext(req, part_name, ver,
+							   DEVLINK_INFO_VERSION_TYPE_COMPONENT);
+	}
+
+err_clear_bit:
+	clear_bit(T7XX_GET_INFO, &flash_dump->status);
+	kfree(data);
+	return ret;
+}
+
+/* Call back function for devlink ops */
+static const struct devlink_ops devlink_flash_ops = {
+	.supported_flash_update_params = DEVLINK_SUPPORT_FLASH_UPDATE_OVERWRITE_MASK,
+	.flash_update = t7xx_devlink_flash_update,
+	.reload_actions = BIT(DEVLINK_RELOAD_ACTION_DRIVER_REINIT) |
+			  BIT(DEVLINK_RELOAD_ACTION_FW_ACTIVATE),
+	.info_get = t7xx_devlink_info_get,
+	.reload_down = t7xx_devlink_reload_down,
+	.reload_up = t7xx_devlink_reload_up,
+};
+
+int t7xx_devlink_register(struct t7xx_pci_dev *t7xx_dev)
+{
+	union devlink_param_value value;
+	struct devlink *dl_ctx;
+
+	dl_ctx = devlink_alloc(&devlink_flash_ops, sizeof(struct t7xx_flash_dump),
+			       &t7xx_dev->pdev->dev);
+	if (!dl_ctx)
+		return -ENOMEM;
+
+	t7xx_dev->flash_dump = devlink_priv(dl_ctx);
+	t7xx_dev->flash_dump->ctx = dl_ctx;
+	t7xx_dev->flash_dump->t7xx_dev = t7xx_dev;
+
+	devl_lock(dl_ctx);
+	devl_params_register(dl_ctx, t7xx_devlink_params, ARRAY_SIZE(t7xx_devlink_params));
+	value.vbool = false;
+	devl_param_driverinit_value_set(dl_ctx, T7XX_DEVLINK_PARAM_ID_FASTBOOT, value);
+	devl_register(dl_ctx);
+	devl_unlock(dl_ctx);
+
+	return 0;
+}
+
+void t7xx_devlink_unregister(struct t7xx_pci_dev *t7xx_dev)
+{
+	struct devlink *dl_ctx = t7xx_dev->flash_dump->ctx;
+
+	devl_lock(dl_ctx);
+	devl_unregister(dl_ctx);
+	devl_params_unregister(dl_ctx, t7xx_devlink_params, ARRAY_SIZE(t7xx_devlink_params));
+	devl_unlock(dl_ctx);
+	devlink_free(dl_ctx);
+}
+
+/**
+ * t7xx_port_flash_dump_init - Initialize devlink to t7xx driver
+ * @port: Pointer to port structure
+ *
+ * Returns: 0 on success and error values on failure
+ */
+static int t7xx_port_flash_dump_init(struct t7xx_port *port)
+{
+	struct t7xx_flash_dump *flash_dump = port->t7xx_dev->flash_dump;
+
+	port->rx_length_th = T7XX_MAX_QUEUE_LENGTH;
+
+	flash_dump->mode = T7XX_NORMAL_MODE;
+	flash_dump->status = T7XX_DEVLINK_IDLE;
+	flash_dump->port = port;
+
+	return 0;
+}
+
+static void t7xx_port_flash_dump_uninit(struct t7xx_port *port)
+{
+	struct t7xx_flash_dump *flash_dump = port->t7xx_dev->flash_dump;
+
+	flash_dump->mode = T7XX_NORMAL_MODE;
+
+	skb_queue_purge(&port->rx_skb_list);
+}
+
+struct port_ops flash_dump_port_ops = {
+	.init = &t7xx_port_flash_dump_init,
+	.recv_skb = &t7xx_port_enqueue_skb,
+	.uninit = &t7xx_port_flash_dump_uninit,
+	.enable_chl = &t7xx_port_enable_chl,
+	.disable_chl = &t7xx_port_disable_chl,
+};
diff --git a/drivers/net/wwan/t7xx/t7xx_port_flash_dump.h b/drivers/net/wwan/t7xx/t7xx_port_flash_dump.h
new file mode 100644
index 000000000000..7614c01dcb2c
--- /dev/null
+++ b/drivers/net/wwan/t7xx/t7xx_port_flash_dump.h
@@ -0,0 +1,45 @@
+/* SPDX-License-Identifier: GPL-2.0-only
+ *
+ * Copyright (c) 2022-2023, Intel Corporation.
+ */
+
+#ifndef __T7XX_PORT_FLASH_DUMP_H__
+#define __T7XX_PORT_FLASH_DUMP_H__
+
+#include <net/devlink.h>
+#include <linux/string.h>
+
+#define T7XX_MAX_QUEUE_LENGTH 32
+#define T7XX_FB_COMMAND_SIZE  64
+#define T7XX_FB_RESPONSE_SIZE 512
+#define T7XX_FB_RESP_COUNT    30
+
+#define T7XX_FLASH_STATUS   0
+#define T7XX_GET_INFO       3
+
+#define T7XX_DEVLINK_IDLE   0
+#define T7XX_NORMAL_MODE    0
+#define T7XX_FB_DL_MODE     1
+
+#define T7XX_FB_CMD_DOWNLOAD     "download"
+#define T7XX_FB_CMD_FLASH        "flash"
+#define T7XX_FB_CMD_REBOOT       "reboot"
+#define T7XX_FB_RESP_OKAY        "OKAY"
+#define T7XX_FB_RESP_FAIL        "FAIL"
+#define T7XX_FB_RESP_DATA        "DATA"
+#define T7XX_FB_RESP_INFO        "INFO"
+#define T7XX_FB_CMD_GET_VER      "get_version"
+
+struct t7xx_flash_dump {
+	struct t7xx_pci_dev *t7xx_dev;
+	struct t7xx_port *port;
+	struct devlink *ctx;
+	unsigned long status;
+	u8 mode;
+};
+
+bool t7xx_devlink_param_get_fastboot(struct devlink *devlink);
+int t7xx_devlink_register(struct t7xx_pci_dev *t7xx_dev);
+void t7xx_devlink_unregister(struct t7xx_pci_dev *t7xx_dev);
+
+#endif /*__T7XX_PORT_FLASH_DUMP_H__*/
diff --git a/drivers/net/wwan/t7xx/t7xx_port_proxy.c b/drivers/net/wwan/t7xx/t7xx_port_proxy.c
index bdfeb10e0c51..11b88c41fc03 100644
--- a/drivers/net/wwan/t7xx/t7xx_port_proxy.c
+++ b/drivers/net/wwan/t7xx/t7xx_port_proxy.c
@@ -40,6 +40,7 @@
 #define Q_IDX_CTRL			0
 #define Q_IDX_MBIM			2
 #define Q_IDX_AT_CMD			5
+#define Q_IDX_AP_MSG			2
 
 #define INVALID_SEQ_NUM			GENMASK(15, 0)
 
@@ -97,7 +98,18 @@ static const struct t7xx_port_conf t7xx_port_conf[] = {
 		.path_id = CLDMA_ID_AP,
 		.ops = &ctl_port_ops,
 		.name = "t7xx_ap_ctrl",
+	}, {
+		.tx_ch = PORT_CH_AP_MSG_TX,
+		.rx_ch = PORT_CH_AP_MSG_RX,
+		.txq_index = Q_IDX_AP_MSG,
+		.rxq_index = Q_IDX_AP_MSG,
+		.txq_exp_index = Q_IDX_AP_MSG,
+		.rxq_exp_index = Q_IDX_AP_MSG,
+		.path_id = CLDMA_ID_AP,
+		.ops = &ap_msg_port_ops,
+		.name = "ap_msg",
 	},
+
 };
 
 static struct t7xx_port_conf t7xx_early_port_conf[] = {
@@ -109,6 +121,8 @@ static struct t7xx_port_conf t7xx_early_port_conf[] = {
 		.txq_exp_index = CLDMA_Q_IDX_DUMP,
 		.rxq_exp_index = CLDMA_Q_IDX_DUMP,
 		.path_id = CLDMA_ID_AP,
+		.ops = &flash_dump_port_ops,
+		.name = "flash_dump",
 	},
 };
 
@@ -325,6 +339,24 @@ int t7xx_port_send_skb(struct t7xx_port *port, struct sk_buff *skb, unsigned int
 	return t7xx_port_send_ccci_skb(port, skb, pkt_header, ex_msg);
 }
 
+int t7xx_port_enable_chl(struct t7xx_port *port)
+{
+	spin_lock(&port->port_update_lock);
+	port->chan_enable = true;
+	spin_unlock(&port->port_update_lock);
+
+	return 0;
+}
+
+int t7xx_port_disable_chl(struct t7xx_port *port)
+{
+	spin_lock(&port->port_update_lock);
+	port->chan_enable = false;
+	spin_unlock(&port->port_update_lock);
+
+	return 0;
+}
+
 static void t7xx_proxy_setup_ch_mapping(struct port_proxy *port_prox)
 {
 	struct t7xx_port *port;
diff --git a/drivers/net/wwan/t7xx/t7xx_port_proxy.h b/drivers/net/wwan/t7xx/t7xx_port_proxy.h
index 7f5706811445..42f1ebf402d8 100644
--- a/drivers/net/wwan/t7xx/t7xx_port_proxy.h
+++ b/drivers/net/wwan/t7xx/t7xx_port_proxy.h
@@ -93,6 +93,8 @@ struct ctrl_msg_header {
 /* Port operations mapping */
 extern struct port_ops wwan_sub_port_ops;
 extern struct port_ops ctl_port_ops;
+extern struct port_ops flash_dump_port_ops;
+extern struct port_ops ap_msg_port_ops;
 
 #ifdef CONFIG_WWAN_DEBUGFS
 extern struct port_ops t7xx_trace_port_ops;
@@ -108,5 +110,7 @@ int t7xx_port_proxy_chl_enable_disable(struct port_proxy *port_prox, unsigned in
 void t7xx_port_proxy_set_cfg(struct t7xx_modem *md, enum port_cfg_id cfg_id);
 int t7xx_port_proxy_recv_skb(struct cldma_queue *queue, struct sk_buff *skb);
 int t7xx_port_proxy_recv_skb_from_dedicated_queue(struct cldma_queue *queue, struct sk_buff *skb);
+int t7xx_port_enable_chl(struct t7xx_port *port);
+int t7xx_port_disable_chl(struct t7xx_port *port);
 
 #endif /* __T7XX_PORT_PROXY_H__ */
diff --git a/drivers/net/wwan/t7xx/t7xx_port_wwan.c b/drivers/net/wwan/t7xx/t7xx_port_wwan.c
index ddc20ddfa734..b4e2926f33f6 100644
--- a/drivers/net/wwan/t7xx/t7xx_port_wwan.c
+++ b/drivers/net/wwan/t7xx/t7xx_port_wwan.c
@@ -131,24 +131,6 @@ static int t7xx_port_wwan_recv_skb(struct t7xx_port *port, struct sk_buff *skb)
 	return 0;
 }
 
-static int t7xx_port_wwan_enable_chl(struct t7xx_port *port)
-{
-	spin_lock(&port->port_update_lock);
-	port->chan_enable = true;
-	spin_unlock(&port->port_update_lock);
-
-	return 0;
-}
-
-static int t7xx_port_wwan_disable_chl(struct t7xx_port *port)
-{
-	spin_lock(&port->port_update_lock);
-	port->chan_enable = false;
-	spin_unlock(&port->port_update_lock);
-
-	return 0;
-}
-
 static void t7xx_port_wwan_md_state_notify(struct t7xx_port *port, unsigned int state)
 {
 	const struct t7xx_port_conf *port_conf = port->port_conf;
@@ -173,7 +155,7 @@ struct port_ops wwan_sub_port_ops = {
 	.init = t7xx_port_wwan_init,
 	.recv_skb = t7xx_port_wwan_recv_skb,
 	.uninit = t7xx_port_wwan_uninit,
-	.enable_chl = t7xx_port_wwan_enable_chl,
-	.disable_chl = t7xx_port_wwan_disable_chl,
+	.enable_chl = t7xx_port_enable_chl,
+	.disable_chl = t7xx_port_disable_chl,
 	.md_state_notify = t7xx_port_wwan_md_state_notify,
 };
diff --git a/drivers/net/wwan/t7xx/t7xx_reg.h b/drivers/net/wwan/t7xx/t7xx_reg.h
index 3b665c6116fe..b106c988321a 100644
--- a/drivers/net/wwan/t7xx/t7xx_reg.h
+++ b/drivers/net/wwan/t7xx/t7xx_reg.h
@@ -101,10 +101,16 @@ enum t7xx_pm_resume_state {
 	PM_RESUME_REG_STATE_L2_EXP,
 };
 
+enum host_event_e {
+	HOST_EVENT_INIT = 0,
+	FASTBOOT_DL_NOTIFY = 0x3,
+};
+
 #define T7XX_PCIE_MISC_DEV_STATUS		0x0d1c
 #define MISC_RESET_TYPE_FLDR			BIT(27)
 #define MISC_RESET_TYPE_PLDR			BIT(26)
 #define MISC_LK_EVENT_MASK			GENMASK(11, 8)
+#define HOST_EVENT_MASK			GENMASK(31, 28)
 
 enum lk_event_id {
 	LK_EVENT_NORMAL = 0,
diff --git a/drivers/net/wwan/t7xx/t7xx_state_monitor.c b/drivers/net/wwan/t7xx/t7xx_state_monitor.c
index 9c51e332e7c5..24f79e981fd9 100644
--- a/drivers/net/wwan/t7xx/t7xx_state_monitor.c
+++ b/drivers/net/wwan/t7xx/t7xx_state_monitor.c
@@ -37,6 +37,7 @@
 #include "t7xx_modem_ops.h"
 #include "t7xx_pci.h"
 #include "t7xx_pcie_mac.h"
+#include "t7xx_port_flash_dump.h"
 #include "t7xx_port_proxy.h"
 #include "t7xx_reg.h"
 #include "t7xx_state_monitor.h"
@@ -206,11 +207,22 @@ static void fsm_routine_exception(struct t7xx_fsm_ctl *ctl, struct t7xx_fsm_comm
 		fsm_finish_command(ctl, cmd, 0);
 }
 
+static void t7xx_host_event_notify(struct t7xx_modem *md, unsigned int event_id)
+{
+	u32 value;
+
+	value = ioread32(IREG_BASE(md->t7xx_dev) + T7XX_PCIE_MISC_DEV_STATUS);
+	value &= ~HOST_EVENT_MASK;
+	value |= FIELD_PREP(HOST_EVENT_MASK, event_id);
+	iowrite32(value, IREG_BASE(md->t7xx_dev) + T7XX_PCIE_MISC_DEV_STATUS);
+}
+
 static void t7xx_lk_stage_event_handling(struct t7xx_fsm_ctl *ctl, unsigned int status)
 {
 	struct t7xx_modem *md = ctl->md;
 	struct cldma_ctrl *md_ctrl;
 	enum lk_event_id lk_event;
+	struct t7xx_port *port;
 	struct device *dev;
 
 	dev = &md->t7xx_dev->pdev->dev;
@@ -221,10 +233,19 @@ static void t7xx_lk_stage_event_handling(struct t7xx_fsm_ctl *ctl, unsigned int
 		break;
 
 	case LK_EVENT_CREATE_PD_PORT:
+	case LK_EVENT_CREATE_POST_DL_PORT:
 		md_ctrl = md->md_ctrl[CLDMA_ID_AP];
 		t7xx_cldma_hif_hw_init(md_ctrl);
 		t7xx_cldma_stop(md_ctrl);
 		t7xx_cldma_switch_cfg(md_ctrl, CLDMA_DEDICATED_Q_CFG);
+		port = ctl->md->t7xx_dev->flash_dump->port;
+		if (WARN_ON(!port))
+			return;
+
+		if (lk_event == LK_EVENT_CREATE_POST_DL_PORT)
+			md->t7xx_dev->flash_dump->mode = T7XX_FB_DL_MODE;
+
+		port->port_conf->ops->enable_chl(port);
 		t7xx_cldma_start(md_ctrl);
 		break;
 
@@ -258,7 +279,9 @@ static void fsm_routine_stopping(struct t7xx_fsm_ctl *ctl, struct t7xx_fsm_comma
 	struct cldma_ctrl *md_ctrl;
 	int err;
 
-	if (ctl->curr_state == FSM_STATE_STOPPED || ctl->curr_state == FSM_STATE_STOPPING) {
+	if (ctl->curr_state == FSM_STATE_STOPPED ||
+	    ctl->curr_state == FSM_STATE_STOPPING ||
+	    ctl->md->rgu_irq_asserted) {
 		fsm_finish_command(ctl, cmd, -EINVAL);
 		return;
 	}
@@ -270,11 +293,18 @@ static void fsm_routine_stopping(struct t7xx_fsm_ctl *ctl, struct t7xx_fsm_comma
 	t7xx_fsm_broadcast_state(ctl, MD_STATE_WAITING_TO_STOP);
 	t7xx_cldma_stop(md_ctrl);
 
-	if (!ctl->md->rgu_irq_asserted) {
-		t7xx_mhccif_h2d_swint_trigger(t7xx_dev, H2D_CH_DRM_DISABLE_AP);
-		/* Wait for the DRM disable to take effect */
-		msleep(FSM_DRM_DISABLE_DELAY_MS);
-
+	if (t7xx_devlink_param_get_fastboot(t7xx_dev->flash_dump->ctx))
+		t7xx_host_event_notify(ctl->md, FASTBOOT_DL_NOTIFY);
+
+	t7xx_mhccif_h2d_swint_trigger(t7xx_dev, H2D_CH_DRM_DISABLE_AP);
+	/* Wait for the DRM disable to take effect */
+	msleep(FSM_DRM_DISABLE_DELAY_MS);
+	if (t7xx_devlink_param_get_fastboot(t7xx_dev->flash_dump->ctx)) {
+		/* Do not try fldr because device will always wait for
+		 * MHCCIF bit 13 in fastboot download flow.
+		 */
+		t7xx_mhccif_h2d_swint_trigger(t7xx_dev, H2D_CH_DEVICE_RESET);
+	} else {
 		err = t7xx_acpi_fldr_func(t7xx_dev);
 		if (err)
 			t7xx_mhccif_h2d_swint_trigger(t7xx_dev, H2D_CH_DEVICE_RESET);
-- 
2.34.1

