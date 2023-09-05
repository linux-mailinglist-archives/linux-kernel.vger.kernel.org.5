Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3CB1792493
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Sep 2023 17:59:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231748AbjIEP7M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Sep 2023 11:59:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354416AbjIEL1s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Sep 2023 07:27:48 -0400
Received: from AUS01-SY4-obe.outbound.protection.outlook.com (mail-sy4aus01olkn2158.outbound.protection.outlook.com [40.92.62.158])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 560781AD;
        Tue,  5 Sep 2023 04:27:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QvvErLXdVOjrfHqvE7bZ68/M0KmSRLJ1b2IkQoxnoqDO4DV9N+z2F41Dx+UjNJNWz0gx+aObkqcspn6jCBBLec+K8BJI462w6296FM2z6McZ2vP2hpDZ0mFgvWffhYLXm/LnICrAeN9vd+mJka6421iFg5L8BF6LMGJyNiS/giMoJfTLfoMqkT8ARkvWVEiPnRG8vKOintTSgHJQdznLORH9U1L7ArbusRRL8aDCa0rz/xbuqHQj2mB9OzazLd2ZrYLJWFu827zl6N0thprNDBmbY0L4Abkgm3MOMKD0NLJfjpw3jYLRZLWtPN1fM/eRRr18cafrhLun2bML0L0VsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8JDHlaC6qRxPS3HO08K2sh3eFp1ZrjKNuJyd/BXV2EE=;
 b=LXmk5t+UbXGj5xYunIBhw/YrkwjDAuLNbSQXbzTPlUdrZBRBP346LQIDevvjyQFOS1SpE1nKQcn9RQU9DJ+6KX/o4o2wut4yvxzaHGKIuxeS4lxYZUz1webjKheuyUck7gDZoecI0sUtACyM9mWMPvgRVT+4W2SRARqjaSUPKWVjs3rvqdLQFw2XLSP4eRmlqkxaddmx8cDRnzbnYO5jlVP6e+WOl4dsYFAu1npS8m+LRFGyflNZ7S9jeYzhFCSoXdyW4Zp0joCTDkzZxucxCzTbWF+G1YnBnomx0esOiX8MXBwmeSldBFbV5bmCTuP06CRI5dSCYvk94EMEdpCbvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8JDHlaC6qRxPS3HO08K2sh3eFp1ZrjKNuJyd/BXV2EE=;
 b=u+F0IF/bcM5kCTYPOG2w8iwDoA8z8oW2X9MErwjGty6EKbQtxVzXB0ODVtR3Sy3CWnbyUym3hj9U9iwRFMmQAmK19MPP3IYF9sfXrYj6Q+EgVaplvBuW/BKQbqWToIHbHKVTNOBz952Uu6QS5MILJXt0xruwCQk/iUNGF/XRV4+YER4F9DnzmXvuRQv1CUcGDRompgzyz0tmQ0ZsknR6AEZuLbBMIj3ZCkwIlmDTQNmtsuvZjYT795Qi8QvvLvqbWOE5JlHrbspoDR19sltyhyH6+x5uks1acLsNaNfQmSnCE+v1owF3J63+h13qpBGpsZowgD214Z7POKxaBwJ7nQ==
Received: from MEYP282MB2697.AUSP282.PROD.OUTLOOK.COM (2603:10c6:220:14c::12)
 by SY6P282MB3213.AUSP282.PROD.OUTLOOK.COM (2603:10c6:10:164::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.33; Tue, 5 Sep
 2023 11:27:37 +0000
Received: from MEYP282MB2697.AUSP282.PROD.OUTLOOK.COM
 ([fe80::beb:8e33:17b1:a347]) by MEYP282MB2697.AUSP282.PROD.OUTLOOK.COM
 ([fe80::beb:8e33:17b1:a347%4]) with mapi id 15.20.6745.030; Tue, 5 Sep 2023
 11:27:37 +0000
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
Subject: [net-next v3 4/5] net: wwan: t7xx: Adds sysfs attribute of modem event
Date:   Tue,  5 Sep 2023 19:26:36 +0800
Message-ID: <MEYP282MB269732805CEF3C06C5AB0858BBE8A@MEYP282MB2697.AUSP282.PROD.OUTLOOK.COM>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230905112637.18877-1-songjinjian@hotmail.com>
References: <20230905112637.18877-1-songjinjian@hotmail.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN:  [5ZxHjbuK6Bhw1Fd2Mwzc4rBTLh4kGH6q]
X-ClientProxiedBy: SGAP274CA0006.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b6::18)
 To MEYP282MB2697.AUSP282.PROD.OUTLOOK.COM (2603:10c6:220:14c::12)
X-Microsoft-Original-Message-ID: <20230905112637.18877-5-songjinjian@hotmail.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MEYP282MB2697:EE_|SY6P282MB3213:EE_
X-MS-Office365-Filtering-Correlation-Id: ce7927cf-d06a-44ea-8221-08dbae031b41
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: W4yQGqxRDCbzIUlwcbWdRATkoYRBXMq1/U3uCAslmGsQjLRGpuebutE0mdj5ykndy+0ypyRpRZz3gbn2JBzdmPXd1UttQcjqaRKB5EerPldGbDusfMNdTR6yKx88n/+ZV/ZB0NZrLqwXESxWD0JIWQUls/ToH6sd/J0QAhdFTHZ61g4ZPJLLqg9V2k5uOvAMg7AmI3rv/WTbzAwv0IGb1vPmYxZ+ulTWIVW76XUmdIzjWGhFjg/unea96eqMxaMxiof0lyogFTAMxQkxA1EDG2piZ2kCG2i+EwwHGZO3k5yZSNEYgx8pfdQLG3lYBRceD8US5W0NN4YjEcLcuAfQS5HuKJy2B9n6HQPBX/JdOZIHuo8aWjx/Hwzk6ff6mQEVhuvQro1Bdq7z+mYMz7i+YU0Yy3GBGavwQGdy4m4JBqgTcQwoQhYjhlgzITKAHqV368MiiaNWqF80NtwAl7aQvDbKTJKGStMHcQ5pufrMm9w2o/6QhquEaGhXlKpTo4aiC+uq8rPvtzlU7my+2G6mmBu8CdTb3dsWU173TtVFO9E=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?BCA+IR4BUB3wqBITXENfYuCTKhpgy7CXZnsP/ltGwzjKcfhuQUKhW9ohrgZk?=
 =?us-ascii?Q?4yGNXEg1zvlNlywACvTA+Fj6OT66FiNBJ13I0nbibXZA+2ZTko30QnqqWqFW?=
 =?us-ascii?Q?W4uY1n2f1NUKOMqa53MmaENEBOhKyj0iLJrjHfOlivAAEt2JuKGvNeiAruLo?=
 =?us-ascii?Q?FwubBuiqjN7autR/KxI+WnIFZupdLyIgpi949BEcuDnXCt84YzrYD0ZkBt9O?=
 =?us-ascii?Q?PKWqtYA3LsoRyQEfiRodgGTPJZIubJWC6ogu4eKBb+ymHyBxHRCVlm+FQ/aF?=
 =?us-ascii?Q?FoYujQcM7Mk3UpG5EqiGSMbtu92Pa2kOmc05H/8PIlnHt5IljuFhvki7KT3C?=
 =?us-ascii?Q?5TFgbNKzvMn1bhKgj5WbzgzKWUDE2dfY1cNxUWpjFs4GZY2AXRkk5EsEP8fA?=
 =?us-ascii?Q?E9TQIeOClqJrBhPwmDP4ojvOGPBu9QVduzdWhYTiZSN9nU3ZTltVwsiT+qIx?=
 =?us-ascii?Q?RRw2hTnzpYyKpce+q0i2d9Fg2z1wSWGOcWK2nrsG+Dl5mQv9hSxA6EBHkdiW?=
 =?us-ascii?Q?wSbH52p2j+EZpiibZPbDfTIRqwKvcehv4z7fF4CECIvGLwSU8mG87x/KsykB?=
 =?us-ascii?Q?Oei6aygZPPHCQohA+jzoPHBr3svK5qyxIMnhjJJT80SgJFkUEUo3IJTB3Bql?=
 =?us-ascii?Q?rl4B5YT8OCAA7ioaZ/0rKegKmMgNn6ITDVPJVZGgF7mkGTLFbsI3j+X7H0UG?=
 =?us-ascii?Q?jOCk6uZg2nXtSszwYiNuM1k4pV3CIAySTq0QtZxBrEebmaapIFjW217SYOeo?=
 =?us-ascii?Q?pBBRDEDw9CLJCUqrzr3rwSrkO1jtumMgZeo+Ev402L3stuEVDLABlMi8AvF0?=
 =?us-ascii?Q?32DXI+8LSBQEP8bdQ3yxb5ckU3RO+mPtU7XMErH4KonivXhIrUaSxqzJpA3M?=
 =?us-ascii?Q?Af60TXZkdALSZ3T5JgPf7syhbDSQu2kWaa3sWyjBYujYnZxHXILGSRxo1UNJ?=
 =?us-ascii?Q?bo1xjLBJ+Iq0uy6LbCQHGB1JuwEe0O4EYrQ0dmxLLD+mWsb68dhbjqIn5XDR?=
 =?us-ascii?Q?Bfm363eOLLNU0DZxyN6WLcmfyz/xj6It8Tp43SRNUmDCd+JH+wEoUVOIYiax?=
 =?us-ascii?Q?nbURxGIcbdz5twDHMRZ7Nlk2EatVA/qTiE+hHrJ7EWVyNuUb5FaPmUTll8Vb?=
 =?us-ascii?Q?4s+MuIk8nsejB1gOO99Jr2B52xB/DnzZiYO5fSFM0TIB3V3LzKcC5fG7Llze?=
 =?us-ascii?Q?qjJCidRY2brnOyvBuysnwFrst+5Zq5EBywlRCzDtQz8GRmRrUy+qfjZvQV4?=
 =?us-ascii?Q?=3D?=
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-746f3.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: ce7927cf-d06a-44ea-8221-08dbae031b41
X-MS-Exchange-CrossTenant-AuthSource: MEYP282MB2697.AUSP282.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Sep 2023 11:27:37.1257
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SY6P282MB3213
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
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

