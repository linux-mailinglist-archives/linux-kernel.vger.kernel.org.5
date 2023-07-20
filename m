Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D070175AB1F
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jul 2023 11:41:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231136AbjGTJlq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jul 2023 05:41:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230229AbjGTJlN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jul 2023 05:41:13 -0400
Received: from EUR01-HE1-obe.outbound.protection.outlook.com (mail-he1eur01on2042.outbound.protection.outlook.com [40.107.13.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1221B3AA7
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jul 2023 02:37:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VdnNCjV4D54LBPKjgHJbK3dpQzETJ0NRnya+bPYMhFTLZyWs4Tq9TkHg8h0wSAFlPCngzk6aCQdRJHZJ1UlqRe1ygLB8S5t/Q00G94XanNtEyvITbgVcwnRa7c/VKi4wN7r98C279LFQWH4chc/9V4S8vUKb8aVTztjSMZ4TVwsL5okMKdb1A267sezZ5OReg7Lm7I09gyAKnb8QsrQzGEliD7C6peW/JmRfsO05Mr5iA8LYNq4R5K9Uf/vJhHfWYQvgC56UZEKFUm0e2QJMThJ7OCqFHFd7rz1BagURUJyXVZy+JW/+Xaq4Umy+m9VB2yju7eirQ4Zy5fzRNsVJew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UFLJJaYmUcuamnm0HuIOJj3+EI9yddl12xmxM+3c4MY=;
 b=fDLSGe9rLYoRsWP0wDDPanUrgNgimWqzg1q+bbjNjn/u5ndJ5kjgPXGU7AjJFU1gFCzuh36C150DdV1YNA3gGXypfDzIpDUkhCXvAhN9dt4QiTfHcD99QfhNWAisonDwOLDkzilHkm3LMUM4carEm1ZRh7MkrFLcn+4bRfYr0eZXvVsyMpsLDuLikgjjP4f5bvL9r5C+8scn4eNWVL7muaSwVwA3sd+FK7Vuk1NET/YUqEm+AEQgSLAM03JmTD78KwIW+7FU6+bzzU2EsNEImr9JCLafwJoVmtQ9usfNMPx/1HBk2MCYuFt72HeNE0coUar/t/3H/fH56e9iu+nGvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UFLJJaYmUcuamnm0HuIOJj3+EI9yddl12xmxM+3c4MY=;
 b=WKnyODEdGedak5O4aWRza+KPjFKvy6NoSTyuktPE7p0Em0KDTSuAs6/ptvu03x16WMe4d5jcPQTceXzLZCl1rbVdndDYKDRQ8jjN+WbVdmpAGChQq1wLUd2Zs2kUgZdzb1R4PNL04qW2zuA00FkeKpCVD1pN0BkBrykVqhYsgx4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by AS8PR04MB8388.eurprd04.prod.outlook.com (2603:10a6:20b:3f8::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.35; Thu, 20 Jul
 2023 09:37:12 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::c874:7c87:c13b:64f8]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::c874:7c87:c13b:64f8%5]) with mapi id 15.20.6609.024; Thu, 20 Jul 2023
 09:37:12 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     shawnguo@kernel.org, s.hauer@pengutronix.de
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        aisheng.dong@nxp.com, alexander.stein@ew.tq-group.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Ranjani Vaidyanathan <ranjani.vaidyanathan@nxp.com>,
        Peng Fan <peng.fan@nxp.com>
Subject: [PATCH 8/8] firmware: imx: scu-irq: support identifying SCU wakeup source from sysfs
Date:   Thu, 20 Jul 2023 17:41:28 +0800
Message-Id: <20230720094128.536388-9-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20230720094128.536388-1-peng.fan@oss.nxp.com>
References: <20230720094128.536388-1-peng.fan@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR03CA0110.apcprd03.prod.outlook.com
 (2603:1096:4:91::14) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9417:EE_|AS8PR04MB8388:EE_
X-MS-Office365-Filtering-Correlation-Id: 896a9427-3e62-4136-cba5-08db8904e586
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VUFacwTeO66WOViD9rwJuolBQSNkXxSGnOom+SSfXb7vRrAtVL1GVC7z4wfYAiW7mRJEPtE5q4RcptWC+MAMXB+M/ch/7oVUUXU0lQtvvwy0QsH2Ig+fzo+wk3C1XEFjwgUPQjFcPbds9Pmqx1+1T5xv7TMcvyviBgW8C28R8pL3KyUOWaUvF+8ocY7NFxZd65B0hfVcNjeGrj1T2CtmCUWuDpfy7cHY8i7vVfpA75N1aJlBOuZ8XRXp+Ky/pVFmqwd7979RRzqkw48DSgi9rSdW8CTzO71JDsXNw679vWszUh5xUOXnM6p1EBWwXiJW5JeA3JEWn8Bt8225NzgJDgi1uXKtKW9DGinsQN9Afdc4KbUjr82IKdYQHAfUAivHjVpzRUXVEw3QQ+IsnccEA/RE22MVWMXmypnB+7FVVW1cHaKo3RajAudHuuIy5SVA9S8QUJgwg2z2eNpBImW/hoFAzoaxu8WsmVaFaCqId88s2L5FbCAkcuZNS6HZiao7jiRWxi+MBjSW8GG+u/U459c28lRgxGy4Wh5qXIOWJfdAFXZ66DU0xbxEwS5RBPS4Hfx2h7oydjwDSplEiHpGBACd0EBZIwrf9NQnwuTiyluPOUSfp6IOKZeJMcPle8EY
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(39860400002)(396003)(346002)(376002)(136003)(451199021)(186003)(2616005)(6512007)(1076003)(6506007)(26005)(83380400001)(316002)(41300700001)(66476007)(66556008)(66946007)(5660300002)(8676002)(8936002)(2906002)(4326008)(6486002)(54906003)(52116002)(6666004)(478600001)(38100700002)(38350700002)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?VQM0kylK1FLNfT6WvK4EzgotbKqLZ1abJmnRKtBZb+U1VhmZ8D6T2dJdHUY+?=
 =?us-ascii?Q?3EUVpTS6/1BY24FMc9KjpYNZ2xxc8VYpLVec3lGvPcCdTm4SXsVHNVxluTsF?=
 =?us-ascii?Q?PmdVHHyaunYWg8CUsEapLVxl64Oynr6ZIIavJ73jz+/BgmG5jqeu5/cgucW6?=
 =?us-ascii?Q?n3j156t0gINEjUSKuW7gkDRi820ZJ4hUwLllqHlTexgidpXlmI9OnxJtJuiI?=
 =?us-ascii?Q?GcwTEj+91a8bpdCwBwf4tobHDufTJ+qkwk2cmZYv2ZGER0EjU++1u+SO4lF2?=
 =?us-ascii?Q?5oSF85c+fPngy8amsAWr4hHjmhTp5pNZYkujPJHS5INp5ZfwCclSeFZ2F/XI?=
 =?us-ascii?Q?ZiCUNPiqL2XLkkWDpYZTMgwdRpRpLZ6uvm8AsTnqMICZQa9aQPDiljuvuT+V?=
 =?us-ascii?Q?N1wPSN6O/nrQVo/P5hhXUP0WiLUC2ScXlTjoWzFT03CDNXmdFlqXjg6WW3Ct?=
 =?us-ascii?Q?zpm5B3AjAC1Ikbc28dgdgGdErs8DdAnN5LWcXA4vg/hrdvlx1UILOX/trYIV?=
 =?us-ascii?Q?3u+7rRCTOqNR+GIs7tZfmf0O74bjQXZ2PvFjLPAg3hNck77uNs9LuQQeBdZC?=
 =?us-ascii?Q?wBQhiu90vKmwgvF3xwTq3DJPB7lH3JmE4XFnQ0AOQ6dNW9yeWDuCnfWy6eEZ?=
 =?us-ascii?Q?43ud2WemQXJXDkQ4ItYwcBQV9OgEE4uO3YnrX7eNW+a5oeyZvZwMd4nWAhcM?=
 =?us-ascii?Q?3TQqLcZT7kvO9aAZOFL6hUjugzRm7+ODTOv8x6wWiSXoi4fjkRqnnrSpKvRr?=
 =?us-ascii?Q?8BnK6ajYRsYJAUlkHyiKlOwLgcgJ+TlscR1TZST6WMBhfS8TPZJyv9hCQde0?=
 =?us-ascii?Q?/WexpbYhNSlJjFE93HEhFyJt6NjyP0OKmL8MKqnA40CxcX6YOZCXDqJ6bPEc?=
 =?us-ascii?Q?VYyZRrTQZbbrY3iio5owAoQJbsV1FA9gfGHhnyyGU7JcY/KIW8+O2KfKIH8l?=
 =?us-ascii?Q?Jm7gJ1qMuqhGTYNOuMJmPT11l7ZUBdSvoMRXkqEITqSSA98awbZEPLu23e5G?=
 =?us-ascii?Q?LfSng5i/rs5Z0w25IzfDZf6y2DLGD5gOY0RX+kvKjX+T+hqlEOCE5WezaLgU?=
 =?us-ascii?Q?K7HY/slhbf2TbsOPk1PcGlwb5TaWmVt/C6xsmgf7HZvVwQpod9v727WkNDWM?=
 =?us-ascii?Q?9cTEOBfa2yIUN+LCtsz2Fi7Nla40cXXwtz0zBD0Q1Xdr0DmxULTXoJdpUz+3?=
 =?us-ascii?Q?dLQSWkhhl6wp3MXuRW6Kb382AZTvv+VvTojTx0Cqck1YhUcoXRXWbd0rCyYz?=
 =?us-ascii?Q?QmISisQmXUH0ypuSV9KHDV4r/AMyjXOwtpXGDWoxd90vPynCrYXMw9DpuyXl?=
 =?us-ascii?Q?IjNp4p/C9HytHDEnbJpSX1f/egvI5rMTYnk1LEXuC6nc41LT6Anb6ZpMdCL5?=
 =?us-ascii?Q?V41oxkSacdpXAhj4YeNIaYStax/WlV4UoKX4iqCvhI/+cbTrbLgGPtRCh7A7?=
 =?us-ascii?Q?tWvaUSUY5z+9893zrec6+HJFYbFt6lRVE3o2HxKVC8jTtfWk1AfZBz6+SUcL?=
 =?us-ascii?Q?X/gU23g3uwlBJD9YWcKAMLQJTfbGVcBGhQeo3xAiW7FATAN3lvuHS6uUG7zi?=
 =?us-ascii?Q?BxGx7W7uSONlhlIqjFUveR5JBtV+j3oqnyxlUXqD?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 896a9427-3e62-4136-cba5-08db8904e586
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jul 2023 09:37:12.8545
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JZ6nND8H4vvSU+XCaG0hFQLIX4BgMnKm1FrSG8mlctqK+J7lvKXtGbxXYH+RUrdcyKcaa+XoX2B2NdBcr5zzYA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8388
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ranjani Vaidyanathan <ranjani.vaidyanathan@nxp.com>

Record SCU wakeup interrupt in /sys/power/pm_wakeup_irq
The user can further identify the exact wakeup source by using the
following interface:
cat /sys/firmware/scu_wakeup_source/wakeup_src

The above will print the wake groups and the irqs that could have
contributed to waking up the kernel. For example if ON/OFF button was the
wakeup source:
cat /sys/firmware/scu_wakeup_source/wakeup_src
Wakeup source group = 3, irq = 0x1

The user can refer to the SCFW API documentation to identify all the
wake groups and irqs.

Signed-off-by: Ranjani Vaidyanathan <ranjani.vaidyanathan@nxp.com>
Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/firmware/imx/imx-scu-irq.c | 64 ++++++++++++++++++++++++++++--
 1 file changed, 61 insertions(+), 3 deletions(-)

diff --git a/drivers/firmware/imx/imx-scu-irq.c b/drivers/firmware/imx/imx-scu-irq.c
index 8d902db1daf2..30accbfdc8e1 100644
--- a/drivers/firmware/imx/imx-scu-irq.c
+++ b/drivers/firmware/imx/imx-scu-irq.c
@@ -11,6 +11,8 @@
 #include <linux/firmware/imx/sci.h>
 #include <linux/mailbox_client.h>
 #include <linux/suspend.h>
+#include <linux/sysfs.h>
+#include <linux/kobject.h>
 
 #define IMX_SC_IRQ_FUNC_ENABLE	1
 #define IMX_SC_IRQ_FUNC_STATUS	2
@@ -40,6 +42,20 @@ struct imx_sc_msg_irq_enable {
 	u8 enable;
 } __packed;
 
+struct scu_wakeup {
+	u32 mask;
+	u32 wakeup_src;
+	bool valid;
+};
+
+/* Sysfs functions */
+struct kobject *wakeup_obj;
+static ssize_t wakeup_source_show(struct kobject *kobj, struct kobj_attribute *attr, char *buf);
+static struct kobj_attribute wakeup_source_attr =
+		__ATTR(wakeup_src, 0660, wakeup_source_show, NULL);
+
+static struct scu_wakeup scu_irq_wakeup[IMX_SC_IRQ_NUM_GROUP];
+
 static struct imx_sc_ipc *imx_sc_irq_ipc_handle;
 static struct work_struct imx_sc_irq_work;
 static BLOCKING_NOTIFIER_HEAD(imx_scu_irq_notifier_chain);
@@ -71,16 +87,24 @@ static void imx_scu_irq_work_handler(struct work_struct *work)
 	u8 i;
 
 	for (i = 0; i < IMX_SC_IRQ_NUM_GROUP; i++) {
+		if (scu_irq_wakeup[i].mask) {
+			scu_irq_wakeup[i].valid = false;
+			scu_irq_wakeup[i].wakeup_src = 0;
+		}
 		ret = imx_scu_irq_get_status(i, &irq_status);
 		if (ret) {
-			pr_err("get irq group %d status failed, ret %d\n",
-			       i, ret);
+			pr_err("get irq group %d status failed, ret %d\n", i, ret);
 			return;
 		}
 
 		if (!irq_status)
 			continue;
-
+		if (scu_irq_wakeup[i].mask & irq_status) {
+			scu_irq_wakeup[i].valid = true;
+			scu_irq_wakeup[i].wakeup_src = irq_status & scu_irq_wakeup[i].mask;
+		} else {
+			scu_irq_wakeup[i].wakeup_src = irq_status;
+		}
 		pm_system_wakeup();
 		imx_scu_irq_notifier_call_chain(irq_status, &i);
 	}
@@ -135,6 +159,11 @@ int imx_scu_irq_group_enable(u8 group, u32 mask, u8 enable)
 		pr_err("enable irq failed, group %d, mask %d, ret %d\n",
 			group, mask, ret);
 
+	if (enable)
+		scu_irq_wakeup[group].mask |= mask;
+	else
+		scu_irq_wakeup[group].mask &= ~mask;
+
 	return ret;
 }
 EXPORT_SYMBOL(imx_scu_irq_group_enable);
@@ -144,6 +173,26 @@ static void imx_scu_irq_callback(struct mbox_client *c, void *msg)
 	schedule_work(&imx_sc_irq_work);
 }
 
+static ssize_t wakeup_source_show(struct kobject *kobj,
+					struct kobj_attribute *attr, char *buf)
+{
+	int i, size;
+
+	for (i = 0; i < IMX_SC_IRQ_NUM_GROUP; i++) {
+		if (!scu_irq_wakeup[i].wakeup_src)
+			continue;
+
+		if (scu_irq_wakeup[i].valid)
+			size = sprintf(buf, "Wakeup source group = %d, irq = 0x%x\n",
+				       i, scu_irq_wakeup[i].wakeup_src);
+		else
+			size = sprintf(buf, "Spurious SCU wakeup, group = %d, irq = 0x%x\n",
+				       i, scu_irq_wakeup[i].wakeup_src);
+	}
+
+	return strlen(buf);
+}
+
 int imx_scu_enable_general_irq_channel(struct device *dev)
 {
 	struct of_phandle_args spec;
@@ -183,6 +232,15 @@ int imx_scu_enable_general_irq_channel(struct device *dev)
 
 	mu_resource_id = IMX_SC_R_MU_0A + i;
 
+	/* Create directory under /sysfs/firmware */
+	wakeup_obj = kobject_create_and_add("scu_wakeup_source", firmware_kobj);
+
+	if (sysfs_create_file(wakeup_obj, &wakeup_source_attr.attr)) {
+		pr_err("Cannot create sysfs file......\n");
+		kobject_put(wakeup_obj);
+		sysfs_remove_file(firmware_kobj, &wakeup_source_attr.attr);
+	}
+
 	return ret;
 }
 EXPORT_SYMBOL(imx_scu_enable_general_irq_channel);
-- 
2.37.1

