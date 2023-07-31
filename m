Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3F60769106
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jul 2023 11:02:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229846AbjGaJCY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 05:02:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231767AbjGaJB6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 05:01:58 -0400
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2056.outbound.protection.outlook.com [40.107.6.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9AB42122
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jul 2023 02:01:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RXqYUgGYECIyQWLGdMsc9kP9I/8DHaS1BHKo2cb2MlwLGppQbaTfHXBN5tiLj32s95Efpyqzg5O5H65gIrYnnwnLl4ENh16uYFCnnjERX5SiGCd2DxpGbjTDrnu0bbOzgN+5WBqtI5nsiiLmzqc7aXfxuhh69rUDLigGPszV5aMNmTMejadFGqYDpiliBhdtjUmVELoL35jrixroGvel97LuA43eehDntMapDMjrZ49OqQo0CIA3duc/9k74Ga8O8VZbVz6AredX0Dteh22jGQzajipPq1sJOeZZdfz/DrXn6xC4kiUZtAZXPdt7oVICOZ2bI8pa731kF3pP29kt+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zbl3luSBPGo5qgtFg4TbLJItGOY4HW50Hwqedi/rJaY=;
 b=U8s42gxSnBcm4hhU5DMn4F9nv6WkMm2HhxiUuphBrW7PAI76gh5dTIdjnAhbT29hwz0MBjbtpx9d+g2Okz5G+V89h8SGqPNeFbhe6RG74VAqxw9aoa2dyzjf4P64Xq/ikKX5gZ/KQmZ6mo83AoXR6N3dV8EdQgI75Nh23zp6xa1aGzP6ROjyPCxb04Ft1Rlqin+BmcU2wIlMhCASHvJSYrZysDBCVajkaDQwN+kfOmEFBLzg02wRP1cPm0GWXH/jiHruVq7CG8//PMOw1+CgeldPmRKE5AfSpowiZRvzIoEaNbhq0JTL7ICnMf5lF0yisQZY442sk3sE7aMjs5YF9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zbl3luSBPGo5qgtFg4TbLJItGOY4HW50Hwqedi/rJaY=;
 b=GWGa6vdKPgVrPhuuA1g8063LeDrQwi/YkpFNybBPodDBKAHfkgOFCL+YGom/KmtG3L9Yrm3kOQv7rxMJi9xpwFdKcfsso0GYgSXGTOqT4KUQy5krpu/cdfbl5eInDB7aRyYcYQS2dakpo/OSH+5gxKUnrBWenez4etFjLEKIC50=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by AS8PR04MB7671.eurprd04.prod.outlook.com (2603:10a6:20b:299::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.43; Mon, 31 Jul
 2023 09:00:36 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::5d6a:ec53:f2a8:5b97]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::5d6a:ec53:f2a8:5b97%6]) with mapi id 15.20.6631.042; Mon, 31 Jul 2023
 09:00:36 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     shawnguo@kernel.org, s.hauer@pengutronix.de
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        aisheng.dong@nxp.com, alexander.stein@ew.tq-group.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Ranjani Vaidyanathan <ranjani.vaidyanathan@nxp.com>,
        Peng Fan <peng.fan@nxp.com>
Subject: [PATCH V5 9/9] firmware: imx: scu-irq: support identifying SCU wakeup source from sysfs
Date:   Mon, 31 Jul 2023 17:04:49 +0800
Message-Id: <20230731090449.2845997-10-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20230731090449.2845997-1-peng.fan@oss.nxp.com>
References: <20230731090449.2845997-1-peng.fan@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0128.apcprd02.prod.outlook.com
 (2603:1096:4:188::20) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9417:EE_|AS8PR04MB7671:EE_
X-MS-Office365-Filtering-Correlation-Id: 0cecfebd-9d46-4c96-ddd8-08db91a49ad5
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6Mnz2t20Iyw6l1e/ifKo2XtAP+NAsW0AGFmKGd1uzbP7VnNtSISZixUgRkeZ4sGS6k9h3al4Tw6m1OjlNceMRy6ZfURYK0xEbnmtJM/eMN+nimNrnFFt3WJH4rSimIeWLek3/8fohbYFY7eDkLw5XfyEhL3IFwInXYY4Ge7KFWxLPyPasp3oCqYwL2XGxw/X2So6/BMp0ekd+JNyfmgAr6QwzL0XNPP75Ezct6w/efKsDxQZSdfeMAwY2yCe0OknQjCjXwtn81SlXklDwJUOYdk0tBAeUddrZl1x2G/f/oVn43iCw2lVaaXu+AOodv84nfGmN9g46I+2JgsGAl+dSMCZAExcrxufAD5302M5Kh6Gk9omLK2Et/ECrKQ8gNOwPD5NtpH7y9UdmyNplMPCwTP2TarMYS74/2WExMjaip/Q2GHgK7xFi8SIZ3lDXYY4ZOL8muT0O/w0eoOymJ2UxVdNhMEv6qs0mAGg4HGrKMWib8diiZ+HrLiFkocjLEQ8Y6ZIX0dIRHu9ZYl67i1dvM7ZHtvHqwb2wmEB79poseVmTUcHAbT35LoceTpIVbxRjdKXlxnw2ccZHRl7/GXto45bnEFC9VsQPhvL88xh34ImJZqKUVCyY9/zwIfrtoD4
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(346002)(39860400002)(396003)(136003)(376002)(451199021)(6512007)(6486002)(52116002)(2616005)(6506007)(1076003)(26005)(83380400001)(186003)(66946007)(66556008)(54906003)(38350700002)(41300700001)(86362001)(66476007)(316002)(4326008)(5660300002)(8676002)(8936002)(38100700002)(2906002)(6666004)(478600001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?pyg/jqiFKSx9ucjktr86ff5eBiOjpAZmq/8Ef0YqXLdmPR9vWX9DmXhAAwM9?=
 =?us-ascii?Q?OqTUYctKGXEiPwV+IeLXMpHiuMFMBeau2B5DvsoY0N4ptF4Ax+hQugKI9h/G?=
 =?us-ascii?Q?ahnfHqtVVTVMAIPDVCgiM4VdIGEpVQQDJfrcxpzowC9yU0w2vbcV25jV3A4Q?=
 =?us-ascii?Q?tjq9JCeRNB49jCtP7WJI+F7WvTilgPYS6DjqtifglzM2/L8Az1qNSECisnY7?=
 =?us-ascii?Q?k0UIXU95UF9wS/k9ZJWTvH38XWONG4Dh48BjJ7TjYnULTi5+V7oRlET63Y/T?=
 =?us-ascii?Q?52oj8W5HOQMTnl2sP3Bv4NfEOaFYqGROew2578QRHOYkpbwEOwdkMhjsvD/w?=
 =?us-ascii?Q?zBqm6IgdNxhKbQhSOmQGhPRxEF+mrYRbXQHkJP6ihOr0Ex/GgYXEdv5ddoxA?=
 =?us-ascii?Q?VkJ/9zqe2xsTNQaMBjiyWwIrm5WVBbGYYHL+aUQdFOIjV3+5AnGaGxMpBqOe?=
 =?us-ascii?Q?WiBpUcJ92z8rJIt+xjmH2Ip7+/wcgB6lZn8NLiSNdOSI2CvKBZ0KoRK00pER?=
 =?us-ascii?Q?NsS57kcnAxg74IG7eerEkE4KhtcbWjAN7Mzdx5Q7fOmaHimWU3XP5MYAAZnR?=
 =?us-ascii?Q?rVRsNhFw1HBFVbZBuQ/hwPqqJNhMzHfdDHJFWj+ey9DyKgV5TKKwdgoQxCbL?=
 =?us-ascii?Q?iNU4bXTmaruBrCfAijJlIF+o7ihtDsPvmfFi88aBzlGwBaMuvEqGeeKe/5mc?=
 =?us-ascii?Q?ZQrIV/LP1RvB1RVA6iXdIqJKi0ZW1/RMJ9YrjMHdpESDeEYcjYdtdUMlvOez?=
 =?us-ascii?Q?/4iSdIPkph+ySB2K/zOMfyfCqFN81CvQAiAb7XI4RJWCFY6w9IJWLu0bkOxu?=
 =?us-ascii?Q?GkveuKFFFANudl0vEV4RzhFyHUMTKlmabZkAj3h2C4qmU7InlnYNkzedHkh5?=
 =?us-ascii?Q?AGWjndioVJXuPRVcUOxR957GwCHRKQ5vHPkZLs/GW+S831kjWyZqJ0qLvhnL?=
 =?us-ascii?Q?z9/Q5Zy4uJlHz/vTSyYqI6MVv1crDVVJaD95eHvBhYa/uk6rk7teLNFpE9eT?=
 =?us-ascii?Q?ccFLPcob/xaySGeAqgT8PcZBkW1pdorPKKQBB3SRIbowQw7w5CbT44SeLBWm?=
 =?us-ascii?Q?94EIpbEz9TCS3CLGQDipIDFhIS/3phaAxh2MtKKdiMJVRKH6DKHYm1YwftsV?=
 =?us-ascii?Q?HdCEQCXFZlkWSBmGHesxH9JJz7nbeBv9TtIU10pnMN5Cwn6FDh/nU+3Rl62V?=
 =?us-ascii?Q?AYCVnq4BEkU6/B4wbtjNKYBd+4p/naJMTxF/75OFr8FuYm3R+c5W5YT86f11?=
 =?us-ascii?Q?C7Je1ghfNPRZ2pEttabShP2fdl0+Hr+lCMEniwUk0+pt2Y9mvOrIE4gqtm7q?=
 =?us-ascii?Q?ORJDqTM2JUEnLfZrOKJjBav/sV044bjg9u8nZ61l2zrdWfIJV0IUi+nTW3tl?=
 =?us-ascii?Q?IhFaBGnh/pxtFmzmk/+QBGzF0Paa4hjg5Qwy5iyr3UIaXVd8p0dRnT1atYei?=
 =?us-ascii?Q?FBiLxCV7irA0GdgsX21ezxfdCf41qrYH631oUcs/frjjdA+d2c6rhF80Olfc?=
 =?us-ascii?Q?CO6JznxFADNJrQfNPd1TWYoUjUgC4U2JE9XT8sjF3DkKyV5hb+edL9XnFwoG?=
 =?us-ascii?Q?+jTRyy6TL1xA2yrMHnD5G5bWG/TBTnw4cdJe83y9?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0cecfebd-9d46-4c96-ddd8-08db91a49ad5
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jul 2023 09:00:36.4708
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gew43TErmXKumP285rp5Ip3WcBY0lEjNksIkOKCuQf9jOG0wIgQW7a7bFbckd2by9IHcWmHgDY0Uv9Z1j9p+uA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7671
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
 drivers/firmware/imx/imx-scu-irq.c | 66 +++++++++++++++++++++++++++---
 1 file changed, 61 insertions(+), 5 deletions(-)

diff --git a/drivers/firmware/imx/imx-scu-irq.c b/drivers/firmware/imx/imx-scu-irq.c
index 8d902db1daf2..fcbaa393897c 100644
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
+static struct kobject *wakeup_obj;
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
@@ -144,6 +173,25 @@ static void imx_scu_irq_callback(struct mbox_client *c, void *msg)
 	schedule_work(&imx_sc_irq_work);
 }
 
+static ssize_t wakeup_source_show(struct kobject *kobj, struct kobj_attribute *attr, char *buf)
+{
+	int i;
+
+	for (i = 0; i < IMX_SC_IRQ_NUM_GROUP; i++) {
+		if (!scu_irq_wakeup[i].wakeup_src)
+			continue;
+
+		if (scu_irq_wakeup[i].valid)
+			sprintf(buf, "Wakeup source group = %d, irq = 0x%x\n",
+				i, scu_irq_wakeup[i].wakeup_src);
+		else
+			sprintf(buf, "Spurious SCU wakeup, group = %d, irq = 0x%x\n",
+				i, scu_irq_wakeup[i].wakeup_src);
+	}
+
+	return strlen(buf);
+}
+
 int imx_scu_enable_general_irq_channel(struct device *dev)
 {
 	struct of_phandle_args spec;
@@ -173,8 +221,7 @@ int imx_scu_enable_general_irq_channel(struct device *dev)
 
 	INIT_WORK(&imx_sc_irq_work, imx_scu_irq_work_handler);
 
-	if (!of_parse_phandle_with_args(dev->of_node, "mboxes",
-				       "#mbox-cells", 0, &spec))
+	if (!of_parse_phandle_with_args(dev->of_node, "mboxes", "#mbox-cells", 0, &spec))
 		i = of_alias_get_id(spec.np, "mu");
 
 	/* use mu1 as general mu irq channel if failed */
@@ -183,6 +230,15 @@ int imx_scu_enable_general_irq_channel(struct device *dev)
 
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

