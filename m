Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 366AB758AB6
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jul 2023 03:12:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229879AbjGSBMC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 21:12:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229715AbjGSBMA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 21:12:00 -0400
Received: from EUR02-AM0-obe.outbound.protection.outlook.com (mail-am0eur02on2071.outbound.protection.outlook.com [40.107.247.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6F081BC9;
        Tue, 18 Jul 2023 18:11:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=i6Se0zxmMZP6e6wvdF2LztD94HrlWE/NNezxCzDz6T5EHoKoD3BJrIYNVg22AIooxsDqLzrvziwDu65Q1357vCyoP8VtUCm9nnKg0nWV/Ig0IbWdrDBqxv4f12zrcIKJMVWCQp1DbRhOqkx0BEVXFUzTFDoK1/bXQmIT2OS/X4L1Z3ngEpodOMcMKZ913EWW71SvqN4xbW37cDiL/DJyJljjpFUAZcpG1mfRi1AYclarrn17yGCvTYZHV/3fBE25n9Sncihd5TJIZzqUwsbeN7R+hv/d3bO5666ewmfL5cUS5HkVdo8NIYo1AbktT5AaVbV88gqUzpt32WlbFkBYRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8YdJE14hjgBjyXhHdAsfdg8EEhwsNTnfGGnBSmKcx4Q=;
 b=PsKbicV/7jt0lV0yfug3/qiiTG8zWrvtcOOBkQrgty7Jt1x2d9DNQal8YaLY4Gg2VIAu7RLruc1hz3dBoaSzjN15y5xKcQcUg5dw5b9hgh21dgP/SxhlVsbwwq5398moEV4tZzk80096KF6qFjqMr9RQQKgGwHzutgMJ2NzVOjmbdKOWr9Og3k51Oi6s9HIvoPrLFV5izNincGchZD4jukGFG0ZRnKjGYqdhKAbabe7LYMdGGo0cEHLgubymU/9aU6ZZIf3D9OUZb0NVWi294aafwdi+ih9xBmXvwvrppZeS4ZLXXP8y6yXHr6XNPorjZ5IDSQjGWrAOlSejzmUEww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8YdJE14hjgBjyXhHdAsfdg8EEhwsNTnfGGnBSmKcx4Q=;
 b=U8WbaxZMLSVeA8dHr/iwgyV59tTxlq6TPENnc9YedW8iXpyogDajkS8sJWH3+Z/f/U6mrpWs8oExPjRuGelxuLhh6rROcAz0OIBJgtzFFDm4w8FmWfXcZrVrtxcb7Qw6ubCKVyrKt1tO33SmLHJ5WbBLkuWvljUy4LMLuDDFs74=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by DB8PR04MB6921.eurprd04.prod.outlook.com (2603:10a6:10:119::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.33; Wed, 19 Jul
 2023 01:11:53 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::c874:7c87:c13b:64f8]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::c874:7c87:c13b:64f8%5]) with mapi id 15.20.6588.031; Wed, 19 Jul 2023
 01:11:53 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     rafael@kernel.org, daniel.lezcano@linaro.org
Cc:     amitk@kernel.org, rui.zhang@intel.com, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Peng Fan <peng.fan@nxp.com>
Subject: [PATCH 1/2] thermal/core: fix potential memory leak
Date:   Wed, 19 Jul 2023 09:16:35 +0800
Message-Id: <20230719011636.2893238-1-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.37.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0034.apcprd02.prod.outlook.com
 (2603:1096:4:1f6::10) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9417:EE_|DB8PR04MB6921:EE_
X-MS-Office365-Filtering-Correlation-Id: 4db0c6ae-d3ed-49f2-cc87-08db87f52332
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VmIurcHfsbghv3WnAkp/f9RrloLIpgF//k0JLpYyG+Ko2F38nr8ju9/bSWKsJH1bCbpikF3f+8I7dIXUiMIkyO9va+7RxUb4GjV6Ypr8ERN041rJm3LQiQGDGIbQypsKQoTKSK0jGSRdTi25IZ4KqoRiTc42JHaKH9arI3OpbU1tmD/KN879MbEIwUMVN1u8HR9FonxE5l4qHov8DcuWGDiWNr9yHKiIMNZWmbz8lDvXQgiGvZIJA3ZIIDa1lHD37bIENE06LWpmCJSQXpVBqgmACpVG5FTceGcQEwhvk+1jCNKtpr9VnPrC03Rauyi5XHotOPsuk8QanrUWfq8MrRwJzk7H/N7Gk+DeVyaYgEy7CpRMB3J4aOp/Tm9ZAX+P2PSFpfqooUKw1ZI0UMAL2gzcj69Vlpf6eEvIW5EbjTjOKF7kWhy2UrHJkjVygkH7V4VzDmThIgOX50p82L8TPLXEACO0BDnRPRva2QFgy46eQE6GwXYZzuiB34OQy8W9YYn4UAovPETzOtBt9WhY+UJS+7RM4QKjhnYPNNXI9E/AlnlOQBrKVidZF2V7vUIiwaaKJQubyO0IIHHsZlvxinmuI8HIw8QUgddKW1TnV7zeJaxpvQtiBXidPIFvtP/Y
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(366004)(39860400002)(346002)(376002)(396003)(451199021)(38350700002)(26005)(6506007)(38100700002)(1076003)(186003)(2616005)(2906002)(83380400001)(5660300002)(4744005)(478600001)(6512007)(86362001)(52116002)(6666004)(316002)(41300700001)(8676002)(66946007)(8936002)(66556008)(66476007)(6486002)(4326008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?cYI7xE0SBVq0KhSWXZ3dNDb9V71blq44gAdXQUVfF6nZ3N0l6ibpOdcg1niN?=
 =?us-ascii?Q?2Tir9RhVU7GFF4LSDNMgbIjLmoeiXBIajnjsIj8Fl6GWB/ED/2iGQC+xm6Gn?=
 =?us-ascii?Q?i0T82MmBMdz95ceIivYycL23da/nBH0E3IFPcAlWuwbIrHwnKWGAtSDZad4u?=
 =?us-ascii?Q?hbsK6YkssGoddVPFNLqohC9WnFnZ0DkE3lTBcfVfCxImXeMsaEKaDUI4/PtG?=
 =?us-ascii?Q?GkbXGkp0ziMvSHTfN/cL+XpED5NIbk8Ow+Z1L7I5it1B80jwjWRmiJNYkYG4?=
 =?us-ascii?Q?+vZNJRMXXvOCNRmYGPQuhLIAw3sn+p72KQXjhC+jGvbVOjyNK73x0HjXBmQu?=
 =?us-ascii?Q?0TzmP4Mq/fsEfEFHkI1xLLeHdqMz2DMGgh3TKx813GCHFJEILLTLgHYrPuGi?=
 =?us-ascii?Q?JtJneaR2oBzdLfFZ1t481jrOHxyCVs/li5FXwPRqdj4JcZE7o3ee2S/jNIQO?=
 =?us-ascii?Q?60NY0B7pj4yE6YB/ErtcvmI3SppSaT+v2PxgU1mgYMdVeE0CqMnwdCOM7MOW?=
 =?us-ascii?Q?SQYchjh/c6uYRzGoLsZkeBx2MlLnFWTwz0nin39a4HC4KKbhZpE+qRacRuJ1?=
 =?us-ascii?Q?PTyRbRWXDGiw2Bc+4JsNl4Y3vCQk/RGWwdn3+qIO2aTZOqVWrPRhQiJr2OG1?=
 =?us-ascii?Q?JMY2BmpU1AluwgzuG4wUFWoItny6bgYBjGy41Pzjg3XC3lVAb89BstDDfyWM?=
 =?us-ascii?Q?QxoRjnRMQubolG3qOyH+aX0esfYUwmMqaQShS1ne7HVSgadHOvRy6b8CZjYq?=
 =?us-ascii?Q?AM8J6usUVxkkdA8oN3fMehapG0YW0JvKI20uiHT1I8YTrzx3klCwbp0TsHCx?=
 =?us-ascii?Q?0NHlWejmvBUEAawaa/IdVaPc/LIP3TS7YLYXRj8aoCsDvOYRhEzcULAlLO3Z?=
 =?us-ascii?Q?bk2pLllz+2Nds0oztdJAC0YLJJXFdrQoxebwZjDNZS5xTgkUclyYiH2mG54C?=
 =?us-ascii?Q?b7tpi7kUujD61JGLQEmKyVbtQM6YjaSxXeuLX7PZ8L2hzsop70PxlZMQLdct?=
 =?us-ascii?Q?ZkU5Ir6S96U0YJQsOWQ8XPmwqwOAPaykzwxTGeBDdzGHPpEGw5KAt5irkFhY?=
 =?us-ascii?Q?AYi5REsr5Bdp0Yu3/nmYJXNrlBRrAzdl/1jbXJmvwNISdBkCvsJmVfJeF9BQ?=
 =?us-ascii?Q?RI4QwN18RooLWe0+2eHRQaHgIhR++xzWggBMa3+xp6VyXIsvK97hmp/e0ma2?=
 =?us-ascii?Q?xN0Ir0V4SGFqTiw/8tkYE7owLGYyEXlA+VcR5erqkIKojn86WMsjUwbxkVHN?=
 =?us-ascii?Q?S+jFetqBK1M3KdVQ2F+2Wu8QQSJJyS6RxZWvXPZIs2rBwhF9ksYE1FsYPqzR?=
 =?us-ascii?Q?PsLiLagYVQIjeeRJWzYfRgG5uKEU6h10wVVc9AO/YoMxEcRumk53v2CPwdsn?=
 =?us-ascii?Q?uUsZSzAQ563RPzQ5x2zWNrD8KPSmZ/sABuEX/NErKAm+biDxgvq/0Nzr3fxL?=
 =?us-ascii?Q?ToZboPk/cl10w5XrovZNzAXQYQ6BahuuOhffpCEqbZagbL7oOFnOkiPtdRWw?=
 =?us-ascii?Q?apP75fVDB8wO7AXv/f45XnW8Iw/oxj8dNssjqbVp3VShXUmK84njx/2KKfFH?=
 =?us-ascii?Q?QFNAMOpRezvh57G3fY4SHnKIo2Uhbmpn/aj0B7SR?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4db0c6ae-d3ed-49f2-cc87-08db87f52332
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jul 2023 01:11:53.5780
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MS8Ufs5nv3NIsyX8l6gseIMPXpSOFbVfpnAmxXbosIpoRuPjAQD74RpDipWXMmiyabvk1tobsb2zBv3AjP8c7A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB6921
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

thermal_set_governor may allocate memory for tz->governor_data, so
need free it in failure handling path.

Addresses-Coverity: 25777220 ("Memory leak")
Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/thermal/thermal_core.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_core.c
index 842f678c1c3e..f633924406ad 100644
--- a/drivers/thermal/thermal_core.c
+++ b/drivers/thermal/thermal_core.c
@@ -1355,6 +1355,9 @@ thermal_zone_device_register_with_trips(const char *type, struct thermal_trip *t
 	return tz;
 
 unregister:
+	if (tz->governor && tz->governor->unbind_from_tz)
+		tz->governor->unbind_from_tz(tz);
+
 	device_del(&tz->device);
 release_device:
 	put_device(&tz->device);
-- 
2.37.1

