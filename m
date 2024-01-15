Return-Path: <linux-kernel+bounces-25646-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3537A82D406
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 06:58:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 950D6B20EB3
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 05:58:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F5304409;
	Mon, 15 Jan 2024 05:57:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="Arp2SdIW"
Received: from EUR02-VI1-obe.outbound.protection.outlook.com (mail-vi1eur02on2041.outbound.protection.outlook.com [40.107.241.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54E4D23CC;
	Mon, 15 Jan 2024 05:57:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=l9cIO9ygUmHKDUbZCypR+Y5ZZJ1mDdzjIY3VzORmW4Nu4AVJNHA8+zFJvJtU+V5osbXn6GTkd6daKVMnZZuC9Fh5gLtD97YsoQ4ws7b5m9wcFuKWlrUfK6i+jRX006Aqy0OUYiyrIbh4s/h6C1AXPw3vCnKRHts84J8VT+k5APCCgnWT/Y7el2jzPs4MkcLlO67fpeEIzzLhlS6XgCZRYpR2PsVKXbLRtKxmhDa4e5DlBRHfw4mNgo94J/Jik7C+mwbSsUK/XrgGIkho0zyMAZaVBdkeUqxzeT+igvBSpAWbDR47OnXNE5boYsrLrcKPwZqFrQhm0+0s0koGhUvAFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7prCgq7aW3drmzWtI44fBPWT40AfPUsY7EKGytfDK8s=;
 b=fuhq64Hwj5HwRtSDFPPgAxEiKZh9nHsrXJMIO+tfbQoW+8eqfR9F+Wlk0B8sTUtbsHlhHBk38xe4NWGo2cFXdTKIgTrQeAMdu4vBLCD/TCDT4KwZII+ar3OMcsF1It8l6vUmENT4QTKbjJvqCcqKweH9OCAaMtm2xQqOL3G1hQZNRUIA7X5nKrNd98rC+tbS+0MbxLjg45nfg2YksEmaMmQ6lpmy2wSwkGE7kYU5QP+85tSbetzc/aTRBpRyB2VyLxuPxxSE2bwy1PFilZnQwGI/Zh8ISTRDmyCJTUWOjxIREPBN62jXKIOwGCxg8vDXaER85L8y685Ck97XhsAsXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7prCgq7aW3drmzWtI44fBPWT40AfPUsY7EKGytfDK8s=;
 b=Arp2SdIWJeZOmFyvJ05PhO7zMhoiYat5nOekeUs2TK5TBfwP5PrQgRQgL33FFxoJBeno63eg+mXLiFrD+VzMMiqJO/4w+awfRp8u2+ZyK2WKcqkIbs5r/LbM0MRACdYce/syCKFtqZcWnv2cOWpdl7Fy+DYYkG5jJUwXFWtcgJA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by PA4PR04MB9269.eurprd04.prod.outlook.com (2603:10a6:102:2a4::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.23; Mon, 15 Jan
 2024 05:57:53 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::c499:8cef:9bb1:ced6]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::c499:8cef:9bb1:ced6%3]) with mapi id 15.20.7181.022; Mon, 15 Jan 2024
 05:57:53 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To: sudeep.holla@arm.com,
	cristian.marussi@arm.com,
	mturquette@baylibre.com,
	sboyd@kernel.org
Cc: linux-arm-kernel@lists.infradead.org,
	linux-clk@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Peng Fan <peng.fan@nxp.com>
Subject: [PATCH V3 2/2] clk: scmi: support state_ctrl_forbidden
Date: Mon, 15 Jan 2024 14:02:03 +0800
Message-Id: <20240115060203.813168-2-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20240115060203.813168-1-peng.fan@oss.nxp.com>
References: <20240115060203.813168-1-peng.fan@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0035.apcprd02.prod.outlook.com
 (2603:1096:4:1f6::8) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9417:EE_|PA4PR04MB9269:EE_
X-MS-Office365-Filtering-Correlation-Id: 077c68ee-c01a-494f-f7ec-08dc158ee9d6
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	Sm6+pqItSI1ACOVeMRqrH8TzUxlhTAWNsuaQ7meBI9NEv6VQMkwE4678kxWDHPN5yVfJxZizUD2De5HL4/SnNH7km3+mW5qGHhSeWnbOFGX6bumBn+MS/uFsnC/8/N/awTDSLHpULDe+nVs534eRkqWUUeCUMKJb8FhzA9W+sLf1ONkjXPy7fbVzVQAmW2FylNDDubT/NDiBe5dtW0Px45y7qfnyaRGjGyhgf9ekTevguUp4nocAa95EO06F4yi/IRxvT3YeujZKM6re3Aa8YKy5u+Xtv3le/gvUUiAGUNHfwKB0KMGnGNxIzsp7hFZ8Tg43CVR30i7ufHFFpQWoTgzrw3/uT0lLGUxJB0BfKPIX30z2OwpxGJZoFO+ui2CdcURigI4Em9cfAwcbLck1oepBMldGattQ6DphvHulYlU0oTdu2ulzqECIZaBL6WHMPxzHtEbhgJ9s//M2lp25ZRhLDMtvb3K+yesTCa43QZ2zsoblzHGOuBf2kWcdPWFBvfAWyorQHcE04JBkavKQunHOI2MBi/qh/4gY9JOmvbphQ6PvZ+y/7bw0P73MCZ29DUWhrvwc3kMjEO/n5LhKs4VG1VNlfOYWL9sM1egYDsLY1fBo9YTF5GUDwfiNhbK0Ovi86wvn8JtsW4MeJPon1g==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(396003)(346002)(136003)(39860400002)(366004)(230922051799003)(186009)(451199024)(64100799003)(1800799012)(38350700005)(2616005)(1076003)(26005)(86362001)(83380400001)(38100700002)(52116002)(6512007)(6666004)(66946007)(66556008)(66476007)(316002)(5660300002)(8676002)(4326008)(8936002)(2906002)(6506007)(6486002)(41300700001)(478600001)(21443003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?/qtRrWsvpxbaeM3VgD8RFoO3N1lix1J5JIMFku0+eWxpRSupeawCKrUQi7sm?=
 =?us-ascii?Q?H1SYx9zFeD5d9lDRC00diA5DENQLzKnO1qGK4ppOUM4HM4Z0UdRiZ2b0VFqU?=
 =?us-ascii?Q?shIvUEX+yB3frHwPIS9w5lIzCvtd7ORC98HoRLv69QN0Fhpho5+WaQTpfBSS?=
 =?us-ascii?Q?gzEr3lA1m5R5S2Y1c7i8rnQ23VisrkRGu6aEQaLve2FKD5peXHdYZqsPRktr?=
 =?us-ascii?Q?lBDpXJdXwaniH+ZVK3HCnjSlYQJgBGIXBXfLmRwiUe4jGjMVgkggQqViUNer?=
 =?us-ascii?Q?kIh+eMXa0QxeqQLQTHaHqIo45xrOmFtsGl3yHHNoVYLkY/AktpNOVX47qBvK?=
 =?us-ascii?Q?OsnFMuBcbUNKdeP5y/DjW90q2KmpcVPIMbKA42A+jodnf+9mXwCfweXMelA8?=
 =?us-ascii?Q?VG8dmoxBp5xMwo7yf74vlIVyuvdvSXFNCX2Fq4+0F9lXFTx6jg2DbYc98Gq8?=
 =?us-ascii?Q?0ULaYvczypRv8je1owGEhkpNdhERiCzCFnKiA8ID0z0DtoDBfzMUXvX5oi1v?=
 =?us-ascii?Q?P3pL4iq9Vq9uAEpV4kQpxKV+sElqu2lJj/p3hsFMhFDJG7vANf8zRN5UVC2T?=
 =?us-ascii?Q?UWPzO1+XrQffMlVtT2KXZZHI66ir81HkXYIKMv0mifCrsVYue3bkHrI5mxn3?=
 =?us-ascii?Q?qUmh2FbPIsK/ZIkXn7ODj11wE9uAZSYT6Jol78E6Wd45VbYguQDY4IdkRnVq?=
 =?us-ascii?Q?ePmmIb0X91jWZ0Iyy3ibPomSscTvOuMUt+2tWdgl2l9T6aQAsnYqZRod/xgj?=
 =?us-ascii?Q?QN62djMnLxQxXAFl9rFJC/qB40KNgHORZCVCsikIArmg6+FYkXigwMh9GYxv?=
 =?us-ascii?Q?vPadr4zM/0sloJtPWFvQYoRTSubYlcJ7KhTFoayWjye1bvpvctvKJvNYq9nI?=
 =?us-ascii?Q?TtobPoIKaq2+qG8xNJ9xUq/UyDo+lexFGLGoh/GJ+o6YEaGMm8J96A0AGXM7?=
 =?us-ascii?Q?Unr5/6B5iwtM1UQ4rxAO/aALB8oY2tw+IEYksQI4Ozxfo8MRxWRLe063WhIb?=
 =?us-ascii?Q?I8j2G/htJ7baIHOEf1NIbhGrhZmi/1GmFIO+KzEykBn1L2Z6e9AoGi/L8UI7?=
 =?us-ascii?Q?SWa0m4Om0YxOMID75B299i+2MxL/jElrp4TDOPTQ7r4lV1fEqhFBQh64OQ1I?=
 =?us-ascii?Q?e2x+ADPR3AO7gdLXGzStwehtq2TGoqxfBWcVQzteRZzgtOr4IgH+s3GQGxXf?=
 =?us-ascii?Q?enq7uC7UzkHhZ8HWyQloGsxRfGtZwut0p/4VXQunWSjLYLnGhHClZZf09sPJ?=
 =?us-ascii?Q?T/8SEA6iJyiqizCXrC3hb1gteL98fHUli0E/NRpCxGEXidAd/CSgG0deXcyS?=
 =?us-ascii?Q?dSDANDYUtyXxSy+WwZV9EGOa8vw3NmzaQ8psZ/jSwuwald3koszyf0aWnZlw?=
 =?us-ascii?Q?VjP7Bcy2S7p8Uxx2niirXOZhUssh01EepR1I5iilpsZKJPcN2SYZaab1d5zX?=
 =?us-ascii?Q?MbPG1KpirKlj4U4IXmFRNEztcqJBSnkv+FbcdtXkXYTJ9bbsqWfoELdzNKbK?=
 =?us-ascii?Q?fUV49YRyzz79jJm9+Q3qdN+foJghfa5J3jiX0hPaLubgDAaulDRkdzB5Xkn0?=
 =?us-ascii?Q?NkHKrO3TUfBC3ebX2+lndEkuOg36uw8iRglUEaLC?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 077c68ee-c01a-494f-f7ec-08dc158ee9d6
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jan 2024 05:57:53.4526
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8Ug0yr1CM5EWMxHzNvyNu1qaqHWC6fygN6ndDBzbSbUdp5utR3Nom8/fOIeQoJ9HaSPqq/WmQAMKe2iOO11VTg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB9269

From: Peng Fan <peng.fan@nxp.com>

Some clocks may exported to linux, while those clocks are not allowed
to configure by Linux. For example:

SYS_CLK1-----
             \
	     --MUX--->MMC1_CLK
             /
SYS_CLK2-----

MMC1 needs set parent, so SYS_CLK1 and SYS_CLK2 are exported to Linux,
then the clk propagation will touch SYS_CLK1 or SYS_CLK2.
So we need bypass the failure for SYS_CLK1 or SYS_CLK2 when enable
the clock of MMC1.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---

V3:
 Add check in atomic enable

V2:
 New. Take Cristian's suggestion

 drivers/clk/clk-scmi.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/drivers/clk/clk-scmi.c b/drivers/clk/clk-scmi.c
index 8cbe24789c24..5327e0547741 100644
--- a/drivers/clk/clk-scmi.c
+++ b/drivers/clk/clk-scmi.c
@@ -119,8 +119,13 @@ static int scmi_clk_determine_rate(struct clk_hw *hw, struct clk_rate_request *r
 static int scmi_clk_enable(struct clk_hw *hw)
 {
 	struct scmi_clk *clk = to_scmi_clk(hw);
+	int ret;
+
+	ret = scmi_proto_clk_ops->enable(clk->ph, clk->id, NOT_ATOMIC);
+	if (ret == -EACCES && clk->info->state_ctrl_forbidden)
+		return 0;
 
-	return scmi_proto_clk_ops->enable(clk->ph, clk->id, NOT_ATOMIC);
+	return ret;
 }
 
 static void scmi_clk_disable(struct clk_hw *hw)
@@ -133,8 +138,13 @@ static void scmi_clk_disable(struct clk_hw *hw)
 static int scmi_clk_atomic_enable(struct clk_hw *hw)
 {
 	struct scmi_clk *clk = to_scmi_clk(hw);
+	int ret;
+
+	ret = scmi_proto_clk_ops->enable(clk->ph, clk->id, ATOMIC);
+	if (ret == -EACCES && clk->info->state_ctrl_forbidden)
+		return 0;
 
-	return scmi_proto_clk_ops->enable(clk->ph, clk->id, ATOMIC);
+	return ret;
 }
 
 static void scmi_clk_atomic_disable(struct clk_hw *hw)
-- 
2.37.1


