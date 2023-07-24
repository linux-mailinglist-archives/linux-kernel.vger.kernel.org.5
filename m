Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 947A475E989
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jul 2023 04:10:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230337AbjGXCKB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Jul 2023 22:10:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233054AbjGXCJO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Jul 2023 22:09:14 -0400
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on20628.outbound.protection.outlook.com [IPv6:2a01:111:f400:7e1a::628])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0997819AD
        for <linux-kernel@vger.kernel.org>; Sun, 23 Jul 2023 19:04:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Z3poGsxo05UgSA+zWOdVLDTdnlkMN5Wdxu/7YKHcgjITxToO5VoVo52LSbp/yVgTUr8DJiMVU/KW1WZ4n8zPTGiepj7Ho4pyCwACwvCqFSJFRY33enQlJ4gP+24w53b6+CLsf4WC5psvbN2SQ1UGhwdI2BnZRPeqJy6w/ogNF12p4/qoW/S0R9QQqEOxZEa8RHGuwFhpB86/ffiq9WxIhEDH9ZiHnf9w50bqfBslXUeQSbxN3Z4esQ0ulWjHN+pYaD5Xj3B56lj/w0syGzf6E+7eFRZZN4YI0kXj9Zkgy6ygHNS1f5lZoY/DtCETHiqaXWo/WXZLbxD7TfP3tuhL6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DF948BRl8NffqmzXY2ZKiRJwHdKM7ujns57fiU8YtXw=;
 b=l3GSbpQbbAnFZ2tkZPlfMt8zZo6BM3xedWPIItHDlWuEUOcDOYgSdIQjsQH+0Tg1oBvojjPjBxhP51SZ4eyfEJlQHEIMaVHJr8E6119zbEvMjakIhP0odgGntUrJj8Km9tVUDd1kpYKDDWM9NJiqaRg4EykQfkG7UKRJ6U+S5tKt/RrRZ61KNlU/fOdk/4wcjCuXjQdHfxUedtq9KhfW33/xHwqd8tkwARzkz5Mz4EJjfVjQOOu/LQj7mWihxhUboMVk3sv5H0P1wL528ii4tgpMR/48a2pNan2XZpC/23e/IS8/gCDX2MBRUzLMHjRvrFlobl/nXfemm23P1JFSSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DF948BRl8NffqmzXY2ZKiRJwHdKM7ujns57fiU8YtXw=;
 b=iDAPwUPZxS/vrTAg6Q2wydAXRjs6hix4BFkVpAsr0GImvRKzmKRVWzhRFW5IyRyONvb73McMYkiISICPdjYGp0gwxVgNR/Ki58olbP7YMbhl1/dGXS48hw3of9W3wOVlWLhBpkljzv1Jz23Z6Q8yuXGFX9jbKfrEYNhnWTaWFvo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by PAXPR04MB8797.eurprd04.prod.outlook.com (2603:10a6:102:20c::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.31; Mon, 24 Jul
 2023 01:42:34 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::5d6a:ec53:f2a8:5b97]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::5d6a:ec53:f2a8:5b97%6]) with mapi id 15.20.6609.032; Mon, 24 Jul 2023
 01:42:34 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     shawnguo@kernel.org, s.hauer@pengutronix.de
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        aisheng.dong@nxp.com, alexander.stein@ew.tq-group.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Peng Fan <peng.fan@nxp.com>
Subject: [PATCH V3 2/8] firmware: imx: scu: increase RPC timeout
Date:   Mon, 24 Jul 2023 09:47:03 +0800
Message-Id: <20230724014711.2048958-3-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20230724014711.2048958-1-peng.fan@oss.nxp.com>
References: <20230724014711.2048958-1-peng.fan@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR02CA0021.apcprd02.prod.outlook.com
 (2603:1096:4:195::10) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9417:EE_|PAXPR04MB8797:EE_
X-MS-Office365-Filtering-Correlation-Id: 37872346-64dc-4005-05fa-08db8be740d2
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hJ2r76ZfAEJ4GPjB8Jxl64xP/ZH+m2T4oI3zT6npIOQw4V8zSh289yaQErvKbQ7CmF4ViGVA0nuYLoOMhp5o9JBftD+nqmjQST9mmnTtnQb/CZI5YBFNn9reEBceFetsFuFY3GpwLEp9RXymWIZp/wzv2R0wniJK/ffl9LLrSfOXSWQAAhzQ9s0SerLv/Xw8b8B3MGHMV1/1jKb3shFwmMZZncEFKlqDu5fWIXm8EwT1FerjAQy/TGe7hqD7AH1KcQmlUvSCvAQQP8etDthNEjPnontvw1j4VbCBPyHAvD74QJRyVolD6SaN4wAX0fsZ1RY+WSNaQtDVqXVKtkU/UhwOoTSPnnKAAVMRlBQRRu6NuvyNoFQhbCS61tjq2WPQhZCZlLjAGUcM4wjSZ88YpLArxxDrMNaTKud4nFSeNApKAmYeL8tV3LTJAlZtncF/RSz6Oj/4NJCFN1Aq85rT5XZh0t35lmHOHfJl8vm0WLviZDTlO0x8GRavgC7uo9QiwPhvv5f5KKxXekPAypf/t4BpphYsRGCfZbXxEPDqGM28Av4p7cUWMTeiDmmYDkBSb1P80v8AQTIiEnqfeanGWTpKUe9sqAAhLdBAkSCZpn714mKtnEDhYurZeHs8yoZi
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(136003)(39860400002)(396003)(346002)(376002)(451199021)(83380400001)(38350700002)(38100700002)(86362001)(4744005)(478600001)(2906002)(1076003)(186003)(26005)(6506007)(6666004)(6512007)(6486002)(52116002)(8936002)(5660300002)(8676002)(316002)(41300700001)(66946007)(66476007)(66556008)(4326008)(2616005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?U3x5mZADaeTO0uTOFVf2QRdUkb9v06S0a3rcUzcU7MzBdM9f6ig3FONSP9qk?=
 =?us-ascii?Q?2JvZIOy5ciByaIOX0Yzk59BkFQVg1t50Xm4jEZTwlsKHDfcikme+44mWcAwA?=
 =?us-ascii?Q?QKEls36Xsh5udgOHNypTWtj3AhFYjjWENgWV+/H43+R7IYcFKvzCDN1Nahxs?=
 =?us-ascii?Q?l1C4URliR8NrDl8U1IagSdw0ECTBWSLCocew9Oa3j/kMPeNC4cVALBsxAIs7?=
 =?us-ascii?Q?0t5KDo7XhwUuB7+CARQL0S9IyYHrYCQqUZmDXXXSS0H90HNdnO/iEP48U44C?=
 =?us-ascii?Q?yYOY7RA4HYAqoXweSTnA8iJczwhlBkIhnJMo6dku7ep+THYFTWL5JxrURyJh?=
 =?us-ascii?Q?T3G393E2o31VDkE4xaX9mvOIQkBmPfle+Buf9OCJ/raY/vz1xih+Kaqwj+CP?=
 =?us-ascii?Q?eY2wcjmmTZGLmne4mo8kvGnUQEEzJlt68RlA4oDF7TMQLcseWXeH0c40Hg/y?=
 =?us-ascii?Q?FsHJqqvC9doW2QrzvCL11ShdAmxERSf0DygfHnhwE4+RiHvc5xRhe/lrHDLR?=
 =?us-ascii?Q?NdowIgh8WEqFmoHtL0qILjLxEibV8npTymVJ62eLEmGuVBWYOCg53QKx6Jtq?=
 =?us-ascii?Q?Zw9hilYexNnGqmOoHhz13Lu5BcfAJD6IvQqEeuyC/YuYqLuaMej0i/LCUV8r?=
 =?us-ascii?Q?ThzFpKsz6wvuPCt2Znw3zlEQ7/P2+Km0okmIC3BX7ffrlUL4vpQQ0QMfJFpf?=
 =?us-ascii?Q?t7Bz90H+nnuPGFZc8iblr9c9ro3zytweKCACht2UUZQkKiFeYP6MXc25Hcli?=
 =?us-ascii?Q?Gs09ZLxBsPmHptVCyJasKlqd8BzhGuJ0yQ+Ebo9qzEYl64ClJJA4H9sn+NXZ?=
 =?us-ascii?Q?cPcbLNw6F/EBi/vcgY6eKBOpUsBtL4NPx1KR0FQ5knaKKtUC6zLJGjADIDl7?=
 =?us-ascii?Q?apggvoECO7CTGzBGwNqCJvN1jAhz+a7McTPqNEo3WYNry+ltq2AM1c4FKwDM?=
 =?us-ascii?Q?SK1bgNotJpLLhZ0mZNDq+tNWZa8ldSk+E/h+Ydjz+Ap6PEo2+hpSh3RcHGrt?=
 =?us-ascii?Q?jaDPPc3DK8jIU9DyFRzOfeh2bN7P6vzyH58x/NwyafNNEC96FhX0I2ttPhDx?=
 =?us-ascii?Q?Jk37LplgKf1Ij3VJl9QSnh4ji+WKb3RW3AJW0PHzjBbg1J40M6A7lrM4uSYd?=
 =?us-ascii?Q?ji6ARxnulJflqcaqozWkUGeH/RmKo9zl9GfL9ZdxheqjRdgOp18dPePcSqJ3?=
 =?us-ascii?Q?FQByT3fHQJBTRLLz+yycDm2Qzrs3D5u44j2DhiB76p/pFx1zzV0ByDRLynWX?=
 =?us-ascii?Q?JbDH3jDQzIzTLYN0edwmbXxI0VhnanuwYDQqxJg+EprDvxr0MsczPkLqASkT?=
 =?us-ascii?Q?0iZzwvbvRW+m7oTcWP8tM/2G89mOgtLilpEcsRURU2K2z4hJ8/kwtQQmZFqo?=
 =?us-ascii?Q?HB8PgBay8XV7f5lwZpCsrveYKYRmTZq/HqxCPDbR0trXT8Q0lD/TxUvKeS7p?=
 =?us-ascii?Q?gzkf3LyUa1xYT/46wHCbjfLP3m5UhxhzSeGSPz5fFUCWCGjjFKFY9VbO6EpV?=
 =?us-ascii?Q?BpfT1f0i1hN1h5nx0ra6joEdO3POJe9uvgi9svZlsRerp2cm+2i8sS6QcJi2?=
 =?us-ascii?Q?cjydXK0iLq0Pq2SyyS2KzAfskuPeLuJgGLN1mmSc?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 37872346-64dc-4005-05fa-08db8be740d2
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jul 2023 01:42:34.7376
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KBA836j7+LZVEbdpvAoVRO3WG4U1mV9MvPX7exUnz2x6sHJgdmKaIHp+1QZqoQYXyHuCHeWrLzLQcVZAVOyTjw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8797
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FORGED_SPF_HELO,SPF_HELO_PASS,T_SCC_BODY_TEXT_LINE,
        T_SPF_PERMERROR autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dong Aisheng <aisheng.dong@nxp.com>

When system loading is high, we can met some command timeout
issue occasionaly, so increase the timeout to a more safe value.

Signed-off-by: Dong Aisheng <aisheng.dong@nxp.com>
Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/firmware/imx/imx-scu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/firmware/imx/imx-scu.c b/drivers/firmware/imx/imx-scu.c
index 2d24359420d8..14ff9d3504bf 100644
--- a/drivers/firmware/imx/imx-scu.c
+++ b/drivers/firmware/imx/imx-scu.c
@@ -20,7 +20,7 @@
 #include <linux/platform_device.h>
 
 #define SCU_MU_CHAN_NUM		8
-#define MAX_RX_TIMEOUT		(msecs_to_jiffies(30))
+#define MAX_RX_TIMEOUT		(msecs_to_jiffies(3000))
 
 struct imx_sc_chan {
 	struct imx_sc_ipc *sc_ipc;
-- 
2.37.1

