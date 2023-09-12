Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16E4E79CC5D
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 11:50:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233265AbjILJuH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 05:50:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232931AbjILJuB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 05:50:01 -0400
Received: from AUS01-SY4-obe.outbound.protection.outlook.com (mail-sy4aus01olkn2188.outbound.protection.outlook.com [40.92.62.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA99B10F9;
        Tue, 12 Sep 2023 02:49:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QFhT9AegLLtiEQDThGhQFkoo2n/5MHazMK7aMf85dSVMLAI1Ut8NxiDuDZbu3Q+eWfnXLNW6ghFyfJQUzdFCERZc/L1pwvY7+XFknHr4miiJf0iTHri8iCxHUb9KnGMf3Nv2Fg/INYKPN5uv58pAjSzoe0Wv3JxUj9YVJD6gq2CWOwqjVty3Y1le8m860XXE9PuaQ9SdhwH7vFSytg4tz7/CghjCaGwJ2YQxZUJHsA/OpAVnFNpu4Qxy6tpjm/I74GvmXrQEsQFouaGjH+9KpHzFWaknGF1AwslYxD+kBIMJHzr8g5KkofX8CIddJ9+/nuMZwpWOMwjqcxxEfECNUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=p6GM24XSiJWLbY2WDpV0DErZ2kE+zYwpeBDXyZpl4HQ=;
 b=d0vuSPJNXKWhkG8ObNv3cLkiJvsGCL1LCd8BX+TTci/WOwx9o3xdihbVw1PJ2RTTVQ/aM191YX6D19kEesajIBgpENQatTbytcp5EU5OsepMGkAwl9RNB/NDlbI9F4UiuzF/C/+/Yew/YEPguS4TsV0EB4fuq6+SmRIxZAsXcL1Ufqbt0fLECBeHxAfDtQyrqR94li/MS8G+DFyTOLRaSLYIy8dsRug2hiJThpIkDG62De7pWDnp7uxAlyOel+zqxt7UxJdfjzwAgoWLR0UQzNwvA8CaUE6cFRXPGqJFNlw0QysNkQe7aGT2CZyu2u7H2ueGC77WiABt72Uvufbjaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p6GM24XSiJWLbY2WDpV0DErZ2kE+zYwpeBDXyZpl4HQ=;
 b=d0KskQjW4GDgGzxme/FF3orN5Ia9Sx3bC2CT6BV5uAEnCESNgUaHEGK5/lIfuVmtKUdmZsdSe07gjbQpP95p7f4cnm/K7HvAqFKiqM+yL4Fg334xZrvUMCkq8+I4CJafJxbF0Sj2c2wzOP8bXzKpA4ab97bf0/TbNEev/7A76dci0IncN2MBFSQZa+J6f2vbs3SJRMeIZvUkMzajDJnbI/tKTl6+CI/iGTEjWPRvd+ohfnTQI1byxAphUvGc9dUYlfPd8WVws/1rsdK42zAJ75T8Y6VO/AFo/k6rc19NP2s2N6Gsl70hTLtEeS1mf2dnWgAJ5G8B50dV2cESSx4P3g==
Received: from ME3P282MB2703.AUSP282.PROD.OUTLOOK.COM (2603:10c6:220:16b::5)
 by SY4P282MB2981.AUSP282.PROD.OUTLOOK.COM (2603:10c6:10:15c::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6768.35; Tue, 12 Sep
 2023 09:49:48 +0000
Received: from ME3P282MB2703.AUSP282.PROD.OUTLOOK.COM
 ([fe80::68b4:6263:97f:9a45]) by ME3P282MB2703.AUSP282.PROD.OUTLOOK.COM
 ([fe80::68b4:6263:97f:9a45%3]) with mapi id 15.20.6768.036; Tue, 12 Sep 2023
 09:49:48 +0000
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
Subject: [net-next v4 4/5] net: wwan: t7xx: Adds sysfs attribute of modem event
Date:   Tue, 12 Sep 2023 17:48:44 +0800
Message-ID: <ME3P282MB27032EB049D5135D68ADE09FBBF1A@ME3P282MB2703.AUSP282.PROD.OUTLOOK.COM>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230912094845.11233-1-songjinjian@hotmail.com>
References: <20230912094845.11233-1-songjinjian@hotmail.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN:  [ggug/LKLf5lizIaW4an3zaN0VwkXRSr+]
X-ClientProxiedBy: SI2PR01CA0048.apcprd01.prod.exchangelabs.com
 (2603:1096:4:193::17) To ME3P282MB2703.AUSP282.PROD.OUTLOOK.COM
 (2603:10c6:220:16b::5)
X-Microsoft-Original-Message-ID: <20230912094845.11233-5-songjinjian@hotmail.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: ME3P282MB2703:EE_|SY4P282MB2981:EE_
X-MS-Office365-Filtering-Correlation-Id: 3e3ea742-ac44-4d32-ee90-08dbb37599ec
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ThJ3mY8kXEP6IGT92Qzk3IaCaz10oy8kEWCDWkZnPqxyAdxbeDp+Blpdp88D6LPDg01wmlxDkx7o+8yeHeqNvKTANoEkFxCCiKYeQH9Vl2M0QRY8hTyB7ij/wmFvmF7jKCbq3FJmraA1iL++gKSdPBPO/oXJi0tvaiHVbaZ5USI4JvHohUvk8JUtjcCfRhnLBTjxWRByvUuE9u5qmNDRrsXb6dp2Xc2ylqwqLiwKDOASDjg46HxgVMCkISp3TBzcTq++Fp661ZgSjQx6EUtpfavQJylUmPfTZKFbuAczjbtbTYhFLamkQa098qn/Q6Hu6pmmwCzVUvlvo46YLMmjvqcBzo1Ag29nt2jDaeKpt4Ebcx34eRQyht9WCPS21UkGac5R95ihVGgOFaPhsklQYZSf2EA+A/EuZdmTTRMhT6jNC7V6lcUM+2C88m8Thnt7v0Rp4yZFszTPL/MSAXWFfFsZaHyrGfwOxnSmwo3BT3VfURmY5NWyhYzmoDYsh2T3G3qEtapej/skE1NavcdpjNySL5Ju9Wp1DaS5P8BPMH0EIrQTU5Nhq1ButLD26Ba0HZxFYX13ZR2y3I+rvCnrJUQUpmno5JpSGDuaxU2TcfA=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?+DOOj+rych/Vi1pjTDMTBiQ7fooBhclk7viiCBWPmos9AHcre1avlHY1QkMd?=
 =?us-ascii?Q?TghIcbHKk62orIcl5DmbVILok8ylV1M63+MZXkjuxKO/ry+1lffYeBCnfVYk?=
 =?us-ascii?Q?ZXIgTK1nAhSZicC4QoVIgz2EL1SsmusVQFs59IE2OoAgJL9Zgy7BTbhalncF?=
 =?us-ascii?Q?aSpJKyHRoCMtWkFSlhxb5Z8eauarvSKtYl6rlW9t75+C2T7gS4bAC6pV1C9U?=
 =?us-ascii?Q?t0UYX7fKgjox5GgS2EgqlUhqqRatktF9optxmxpdNXn3QxuMtX+t163RwxmM?=
 =?us-ascii?Q?Qpl1E+u3BBJ7U+VHiGhBfSBCiGEgGqeUdOHy/0ukxiwSxVIAdxXPKP3N/b8D?=
 =?us-ascii?Q?lxL9BgfkymRVrYoeeOB2ajXa7cwOrRSg5pSRKmJJUDYTnhJMD8KB6DHB6DKv?=
 =?us-ascii?Q?2twpDytJpXO9zWnfSYFzNQLoJ7S28vlaa/eapxQuuoILc1ienKc/SyqA1+Hw?=
 =?us-ascii?Q?dQPWpk3oKYQn4ArfY42qp6qbzddgLByKCAW/2TyaL+JU9I6CMkLSjCj6GGue?=
 =?us-ascii?Q?G9sBr6+gZgw7oZYS+eCYhGDLlRIXiO4Fq5C962cvk7x2K9tqOsBVHFzrdUEm?=
 =?us-ascii?Q?RwLiAmZQmsUBLRvyt1Txqy5lqqMwEmlwBxk2rXMrpisrry09ovAZCaoXECM7?=
 =?us-ascii?Q?HTgZycnCTPeLWX8jNQBgjRaY9vTd6TEjvtKv0ilJkL78FJ4DHHJq+DOuDA8R?=
 =?us-ascii?Q?F2pLu3+YTYTr6opAB3Wuu7UnZ0oyGogTZVdHyH8smoJ18OVPzijAY8NdrlUY?=
 =?us-ascii?Q?TNgOpDaaCw/ZHAe0fEfzuZxng+ncMCVIJy5WgW5Cc8TvwT0q3KvyW65V+3/M?=
 =?us-ascii?Q?EKQJXf1zmaFL6o5oaTG1I6F/bS/A337wXur1SBn4Ud9vktNg95fvmZPHjtp3?=
 =?us-ascii?Q?ySK/7bdRd138PIXvdanIQhP/gNFmHklPhyf9lLxI9/pRWGphjyndXhmqM8Aj?=
 =?us-ascii?Q?hGKldyhi+CJ/oUdpGruXqRtIvflp8e//xQnyF+aqXjWY77kINCbixRxuJUe9?=
 =?us-ascii?Q?Xvh5weO3tllRmrXuRsQchhMwH4nNgEGt3jCzEVN/WWtKbKT3sx6rvt08XMm+?=
 =?us-ascii?Q?uBLB8bWuN3erSPdkrMRlDYBvNWk6Z8D5hTYNTD4P471OpgpFYI07DWIMzY0a?=
 =?us-ascii?Q?onJi7cIba2tTYCodD0PL9bvSEhluDtWxbW4huh5xRZvgDgR+JsoHBTPj2itE?=
 =?us-ascii?Q?m9Uv0Ar6OKdwe+NwTkrI+wYunTEFr/PStRKbNRv4K03+hx54ue6fpbVhlIU?=
 =?us-ascii?Q?=3D?=
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-746f3.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 3e3ea742-ac44-4d32-ee90-08dbb37599ec
X-MS-Exchange-CrossTenant-AuthSource: ME3P282MB2703.AUSP282.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Sep 2023 09:49:48.1364
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SY4P282MB2981
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jinjian Song <jinjian.song@fibocom.com>

Adds support for t7xx wwan device firmware flashing & coredump collection
using devlink.

Provides sysfs attribute on user space to query the event from modem
about flashing/coredump/reset.

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
 * rename struct name from devlink to flash_dump
---
 drivers/net/wwan/t7xx/t7xx_modem_ops.c       |  1 +
 drivers/net/wwan/t7xx/t7xx_pci.c             | 62 ++++++++++++++++++++
 drivers/net/wwan/t7xx/t7xx_pci.h             | 17 ++++++
 drivers/net/wwan/t7xx/t7xx_port_flash_dump.c | 14 +++++
 drivers/net/wwan/t7xx/t7xx_port_flash_dump.h |  1 +
 drivers/net/wwan/t7xx/t7xx_state_monitor.c   |  7 +++
 6 files changed, 102 insertions(+)

diff --git a/drivers/net/wwan/t7xx/t7xx_modem_ops.c b/drivers/net/wwan/t7xx/t7xx_modem_ops.c
index cbd65aa48721..4de75874f1b5 100644
--- a/drivers/net/wwan/t7xx/t7xx_modem_ops.c
+++ b/drivers/net/wwan/t7xx/t7xx_modem_ops.c
@@ -192,6 +192,7 @@ static irqreturn_t t7xx_rgu_isr_thread(int irq, void *data)
 {
 	struct t7xx_pci_dev *t7xx_dev = data;
 
+	atomic_set(&t7xx_dev->event, T7XX_RESET);
 	msleep(RGU_RESET_DELAY_MS);
 	t7xx_reset_device_via_pmic(t7xx_dev);
 	return IRQ_HANDLED;
diff --git a/drivers/net/wwan/t7xx/t7xx_pci.c b/drivers/net/wwan/t7xx/t7xx_pci.c
index 845d1555f134..e5579e04f82d 100644
--- a/drivers/net/wwan/t7xx/t7xx_pci.c
+++ b/drivers/net/wwan/t7xx/t7xx_pci.c
@@ -2,6 +2,7 @@
 /*
  * Copyright (c) 2021, MediaTek Inc.
  * Copyright (c) 2021-2022, Intel Corporation.
+ * Copyright (c) 2023, Fibocom Wireless Inc.
  *
  * Authors:
  *  Haijun Liu <haijun.liu@mediatek.com>
@@ -14,6 +15,7 @@
  *  Chiranjeevi Rapolu <chiranjeevi.rapolu@intel.com>
  *  Eliot Lee <eliot.lee@intel.com>
  *  Moises Veleta <moises.veleta@intel.com>
+ *  Jinjian Song <jinjian.song@fibocom.com>
  */
 
 #include <linux/atomic.h>
@@ -60,6 +62,57 @@ enum t7xx_pm_state {
 	MTK_PM_RESUMED,
 };
 
+static ssize_t t7xx_event_show(struct device *dev, struct device_attribute *attr,
+			       char *buf)
+{
+	enum t7xx_event event = T7XX_UNKNOWN;
+	struct pci_dev *pdev;
+	struct t7xx_pci_dev *t7xx_dev;
+
+	pdev = to_pci_dev(dev);
+	t7xx_dev = pci_get_drvdata(pdev);
+	if (!t7xx_dev)
+		return -ENODEV;
+
+	event = atomic_read(&t7xx_dev->event);
+	if (event == T7XX_READY) {
+		return sprintf(buf, "T7XX_MODEM_READY\n");
+	} else if (event == T7XX_RESET) {
+		return sprintf(buf, "T7XX_RESET\n");
+	} else if (event == T7XX_FASTBOOT_DL_MODE) {
+		return sprintf(buf, "T7XX_MODEM_FASTBOOT_DL_MODE\n");
+	} else if (event == T7XX_FLASH_SUCCESS) {
+		return sprintf(buf, "T7XX_FLASHING_SUCCESS\n");
+	} else if (event == T7XX_FLASH_FAILURE) {
+		return sprintf(buf, "T7XX_FLASHING_FAILURE\n");
+	} else if (event == T7XX_FASTBOOT_DUMP_MODE) {
+		return sprintf(buf, "T7XX_MODEM_FASTBOOT_DUMP_MODE\n");
+	} else if (event == T7XX_MRDUMP_READY) {
+		return sprintf(buf, "T7XX_MRDUMP_READY size:%zu\n",
+			       t7xx_dev->flash_dump->regions[T7XX_MRDUMP_INDEX].info->dump_size);
+	} else if (event == T7XX_LKDUMP_READY) {
+		return sprintf(buf, "T7XX_LKDUMP_READY size:%zu\n",
+			       t7xx_dev->flash_dump->regions[T7XX_LKDUMP_INDEX].info->dump_size);
+	} else if (event == T7XX_MRDUMP_DISCARD) {
+		return sprintf(buf, "T7XX_MRDUMP_DISCARDED\n");
+	} else if (event == T7XX_LKDUMP_DISCARD) {
+		return sprintf(buf, "T7XX_LKDUMP_DISCARDED\n");
+	}
+
+	return sprintf(buf, "T7XX_UNKNOWN\n");
+}
+
+static DEVICE_ATTR_RO(t7xx_event);
+
+static struct attribute *t7xx_event_attr[] = {
+	&dev_attr_t7xx_event.attr,
+	NULL
+};
+
+static const struct attribute_group t7xx_event_attribute_group = {
+	.attrs = t7xx_event_attr,
+};
+
 static void t7xx_dev_set_sleep_capability(struct t7xx_pci_dev *t7xx_dev, bool enable)
 {
 	void __iomem *ctrl_reg = IREG_BASE(t7xx_dev) + T7XX_PCIE_MISC_CTRL;
@@ -734,8 +787,17 @@ static int t7xx_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 
 	t7xx_pcie_mac_interrupts_dis(t7xx_dev);
 
+	ret = sysfs_create_group(&t7xx_dev->pdev->dev.kobj,
+				 &t7xx_event_attribute_group);
+	if (ret) {
+		t7xx_md_exit(t7xx_dev);
+		goto err_devlink_unregister;
+	}
+
 	ret = t7xx_interrupt_init(t7xx_dev);
 	if (ret) {
+		sysfs_remove_group(&t7xx_dev->pdev->dev.kobj,
+				   &t7xx_event_attribute_group);
 		t7xx_md_exit(t7xx_dev);
 		goto err_devlink_unregister;
 	}
diff --git a/drivers/net/wwan/t7xx/t7xx_pci.h b/drivers/net/wwan/t7xx/t7xx_pci.h
index 28f22a2dc493..b7c78a9530f3 100644
--- a/drivers/net/wwan/t7xx/t7xx_pci.h
+++ b/drivers/net/wwan/t7xx/t7xx_pci.h
@@ -2,6 +2,7 @@
  *
  * Copyright (c) 2021, MediaTek Inc.
  * Copyright (c) 2021-2022, Intel Corporation.
+ * Copyright (c) 2023, Fibocom Wireless Inc.
  *
  * Authors:
  *  Haijun Liu <haijun.liu@mediatek.com>
@@ -12,6 +13,7 @@
  *  Amir Hanania <amir.hanania@intel.com>
  *  Chiranjeevi Rapolu <chiranjeevi.rapolu@intel.com>
  *  Moises Veleta <moises.veleta@intel.com>
+ *  Jinjian Song <jinjian.song@fibocom.com>
  */
 
 #ifndef __T7XX_PCI_H__
@@ -84,6 +86,7 @@ struct t7xx_pci_dev {
 	struct dentry		*debugfs_dir;
 #endif
 	struct t7xx_flash_dump	*flash_dump;
+	atomic_t		event;
 };
 
 enum t7xx_pm_id {
@@ -115,6 +118,20 @@ struct md_pm_entity {
 	void			*entity_param;
 };
 
+enum t7xx_event {
+	T7XX_UNKNOWN,
+	T7XX_READY,
+	T7XX_RESET,
+	T7XX_FASTBOOT_DL_MODE,
+	T7XX_FLASH_SUCCESS,
+	T7XX_FLASH_FAILURE,
+	T7XX_FASTBOOT_DUMP_MODE,
+	T7XX_MRDUMP_READY,
+	T7XX_LKDUMP_READY,
+	T7XX_MRDUMP_DISCARD,
+	T7XX_LKDUMP_DISCARD,
+};
+
 void t7xx_pci_disable_sleep(struct t7xx_pci_dev *t7xx_dev);
 void t7xx_pci_enable_sleep(struct t7xx_pci_dev *t7xx_dev);
 int t7xx_pci_sleep_disable_complete(struct t7xx_pci_dev *t7xx_dev);
diff --git a/drivers/net/wwan/t7xx/t7xx_port_flash_dump.c b/drivers/net/wwan/t7xx/t7xx_port_flash_dump.c
index b8ef3b7d7430..0a0f2847aa3f 100644
--- a/drivers/net/wwan/t7xx/t7xx_port_flash_dump.c
+++ b/drivers/net/wwan/t7xx/t7xx_port_flash_dump.c
@@ -201,11 +201,14 @@ static int t7xx_flash_dump_fb_get_core(struct t7xx_port *port)
 			continue;
 		} else if (!strcmp(mcmd, T7XX_FB_RESP_MRDUMP_DONE)) {
 			dev_dbg(port->dev, "%s! size:%zd\n", T7XX_FB_RESP_MRDUMP_DONE, offset_dlen);
+			flash_dump->regions[T7XX_MRDUMP_INDEX].info->dump_size = offset_dlen;
+			atomic_set(&port->t7xx_dev->event, T7XX_MRDUMP_READY);
 			clear_bit(T7XX_MRDUMP_STATUS, &flash_dump->status);
 			return 0;
 		}
 		dev_err(port->dev, "getcore protocol error (read len %05d, response %s)\n",
 			clen, mcmd);
+		atomic_set(&port->t7xx_dev->event, T7XX_MRDUMP_DISCARD);
 		ret = -EPROTO;
 		goto free_mem;
 	}
@@ -248,6 +251,7 @@ static int t7xx_flash_dump_fb_dump_log(struct t7xx_port *port)
 	if (datasize > lkdump_region->info->size) {
 		dev_err(port->dev, "lkdump size is more than %dKB. Discarded!\n",
 			T7XX_LKDUMP_SIZE / 1024);
+		atomic_set(&port->t7xx_dev->event, T7XX_LKDUMP_DISCARD);
 		ret = -EFBIG;
 		goto err_clear_bit;
 	}
@@ -272,6 +276,8 @@ static int t7xx_flash_dump_fb_dump_log(struct t7xx_port *port)
 	}
 
 	dev_dbg(port->dev, "LKDUMP DONE! size:%zd\n", offset);
+	lkdump_region->info->dump_size = offset;
+	atomic_set(&port->t7xx_dev->event, T7XX_LKDUMP_READY);
 	clear_bit(T7XX_LKDUMP_STATUS, &flash_dump->status);
 	return t7xx_flash_dump_fb_handle_response(port, NULL);
 
@@ -361,6 +367,10 @@ static int t7xx_devlink_flash_update(struct devlink *devlink,
 	clear_bit(T7XX_FLASH_STATUS, &flash_dump->status);
 
 err_out:
+	if (ret)
+		atomic_set(&port->t7xx_dev->event, T7XX_FLASH_FAILURE);
+	else
+		atomic_set(&port->t7xx_dev->event, T7XX_FLASH_SUCCESS);
 	return ret;
 }
 
@@ -411,9 +421,13 @@ static int t7xx_devlink_reload_up(struct devlink *devlink,
 				  u32 *actions_performed,
 				  struct netlink_ext_ack *extack)
 {
+	struct t7xx_flash_dump *flash_dump = devlink_priv(devlink);
+
 	*actions_performed = BIT(action);
 	switch (action) {
 	case DEVLINK_RELOAD_ACTION_DRIVER_REINIT:
+		atomic_set(&flash_dump->t7xx_dev->event, T7XX_RESET);
+		return 0;
 	case DEVLINK_RELOAD_ACTION_FW_ACTIVATE:
 		return 0;
 	default:
diff --git a/drivers/net/wwan/t7xx/t7xx_port_flash_dump.h b/drivers/net/wwan/t7xx/t7xx_port_flash_dump.h
index 90758baa7854..057bb36216ca 100644
--- a/drivers/net/wwan/t7xx/t7xx_port_flash_dump.h
+++ b/drivers/net/wwan/t7xx/t7xx_port_flash_dump.h
@@ -57,6 +57,7 @@ enum t7xx_regions {
 struct t7xx_dump_region_info {
 	const char *name;
 	size_t size;
+	size_t dump_size;
 };
 
 struct t7xx_dump_region {
diff --git a/drivers/net/wwan/t7xx/t7xx_state_monitor.c b/drivers/net/wwan/t7xx/t7xx_state_monitor.c
index 86cdb0d572d4..ab35342a2d16 100644
--- a/drivers/net/wwan/t7xx/t7xx_state_monitor.c
+++ b/drivers/net/wwan/t7xx/t7xx_state_monitor.c
@@ -249,6 +249,12 @@ static void t7xx_lk_stage_event_handling(struct t7xx_fsm_ctl *ctl, unsigned int
 
 		port->port_conf->ops->enable_chl(port);
 		t7xx_cldma_start(md_ctrl);
+
+		if (lk_event == LK_EVENT_CREATE_POST_DL_PORT)
+			atomic_set(&md->t7xx_dev->event, T7XX_FASTBOOT_DL_MODE);
+		else
+			atomic_set(&md->t7xx_dev->event, T7XX_FASTBOOT_DUMP_MODE);
+
 		break;
 
 	default:
@@ -332,6 +338,7 @@ static void fsm_routine_ready(struct t7xx_fsm_ctl *ctl)
 
 	ctl->curr_state = FSM_STATE_READY;
 	t7xx_fsm_broadcast_ready_state(ctl);
+	atomic_set(&md->t7xx_dev->event, T7XX_READY);
 	t7xx_md_event_notify(md, FSM_READY);
 }
 
-- 
2.34.1

