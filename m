Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25D08752E81
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jul 2023 03:23:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232513AbjGNBXI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jul 2023 21:23:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231282AbjGNBXD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jul 2023 21:23:03 -0400
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2100.outbound.protection.outlook.com [40.107.215.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8ED042D57;
        Thu, 13 Jul 2023 18:22:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ya8JCFhUTfxXD8ZCPttccxEucdNxHeVfEatLAeQIRlrlqDdokI2+l1kkqO66xgL0ZwsE4TKkTxHxgwFiuuQmdAmaYdpuQQZDxtJ4pkNX7ff8WSc1I8MpqmbKKpCndpj2uRAPUyduE8Bo0a84vQCXtie/l2so6j3Mx00CHsU636dbu0tfmgVfYxqSit40hOnu3tnnVp6P8zcE5Idn7C4MpYhn2yJ6F53hojbOsqFcvVDEL5/xVxTQ7/7RrWewtgIBKyEckcJ43WJoRTSG8v5XsJJPrsKQHygsijdkaI1bUQCiZ0CBqbcrxwV6n/fkKesVWAMOoz3gy8YeDw1dafjOhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Q/m9bRD3YAbAWoCnvtHtIkgQHAON3iapVh0xCMWw4Dc=;
 b=Up0/guRVRgLl4+ntbsI7HcnKki21NjRxS24lrkNCfBqfgGkx7fGBs6udG9Mw8fMxYRaYJXTKmWfeFExlQMvTnNDQ4yJwNvLeA+cSkhKSHg3WrcZFVugnpsvDL3Bb+Qy2X+xiBAOKQPlXk8lwb9dwqnwXsla2bnW/FKkHHZeUzQ2ZD0RsRCiK91nMWYKJZKBXIYkj6PgytDp0SU8fxrg2C4e60Sg8E2uny4pRTnmt8nXLe9lQaxfzTv+2O/nZFNVFXidvg2HZe1T8j9I/KpU+/QFQZUp1QUlOZ1FjU4gLFIJw/OsMIxz3v4NaBhsO6dy33/7+JbHLRjJ7aa+b2x7Ebg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q/m9bRD3YAbAWoCnvtHtIkgQHAON3iapVh0xCMWw4Dc=;
 b=R9NRI/lWwXXThNgLuNRmVJvRo2dlJvAtHElMNRva9PONYXnxLOgYf7KfQKBLtkPgDvrwkTZlxztalO/OYp/keNhTqNzJfGDXdXAeyMtL8ftjza+vzS5xAkp7bOxwZWFh6cDS5twy2RYHBfJnEwcaLIozCjpS7j24yj5aqG8BaNxlgeG0YGycEC8VjWUoxXpRGib5V3bkrN8Cbf8+sOXg88dCYOdrQ/JeW9uolepO2r/AtmcQwKc8UDQm1JtvIu3kkW0ZWaancMqiUbKD2eQ24hqb4HctPXX3tOOLxfeiT5JTjr+QVuj4ezwo9B+FmbnMpZH3tqbHtiQbuYXdP75bbA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SG2PR06MB5288.apcprd06.prod.outlook.com (2603:1096:4:1dc::9) by
 JH0PR06MB6655.apcprd06.prod.outlook.com (2603:1096:990:3d::13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6588.24; Fri, 14 Jul 2023 01:22:55 +0000
Received: from SG2PR06MB5288.apcprd06.prod.outlook.com
 ([fe80::f9b8:80b5:844e:f49a]) by SG2PR06MB5288.apcprd06.prod.outlook.com
 ([fe80::f9b8:80b5:844e:f49a%6]) with mapi id 15.20.6565.037; Fri, 14 Jul 2023
 01:22:55 +0000
From:   Minjie Du <duminjie@vivo.com>
To:     dkirjanov@suse.de, Horatiu Vultur <horatiu.vultur@microchip.com>,
        UNGLinuxDriver@microchip.com (maintainer:MICROCHIP LAN966X ETHERNET
        DRIVER), "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Richard Cochran <richardcochran@gmail.com>,
        netdev@vger.kernel.org (open list:MICROCHIP LAN966X ETHERNET DRIVER),
        linux-kernel@vger.kernel.org (open list)
Cc:     opensource.kernel@vivo.com, Minjie Du <duminjie@vivo.com>
Subject: [PATCH v2] net: lan966x: fix parameter check in two functions
Date:   Fri, 14 Jul 2023 09:22:19 +0800
Message-Id: <20230714012220.891-1-duminjie@vivo.com>
X-Mailer: git-send-email 2.39.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0065.apcprd02.prod.outlook.com
 (2603:1096:4:54::29) To SG2PR06MB5288.apcprd06.prod.outlook.com
 (2603:1096:4:1dc::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SG2PR06MB5288:EE_|JH0PR06MB6655:EE_
X-MS-Office365-Filtering-Correlation-Id: cb75d3a4-0e69-409a-f53a-08db8408d9b7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: L8+CEbWhzJU+da2PgMY0aV8HJhf71Z6dLMhrCM8wCO9EauvP1Kwnxlsdx4KL4CEHekCFrMm6pllMyIfnhHQpENOwUz52AUAYyzwLFIt34N0BEMGWKw1DK1rYcHPN3EQowetoJo2EkSnBNDrFwPVEM9k0tZ2Jg6OEuNZ66ifedestYrmMw89uQUMeciCWPgtWu9jue7+hOaUZZ9LeAGHs7lfRoE1YpvZaI2QKpuouT945j8x9URgPFa8NRYfefWIVH5NC1aQJIpZSM/2sIssrMstmbJXpa3tBs1ztzid68IzTmSQacxJLg4Tupmt/SKrR9MVa0+ubmMhG5ON7ifb3XiX+3INeHpGy7c8bWFP4MA93fPes9IcHiCWXp5RK1Nkzgp9SY3T3bXkUC7C3U2bNnBBTGFPTzNdV/4XN8mXgRnEX9zHo1417d4AVImIxjCAvbCqqujgRm5ldmx5wLyisZj38meIv03/bNeCoZOFhicHxnf2UjgLavKOMmcOPxCzw/IT9aqGQ+qFiP3vvK0bjXfBXkrzd39rURvxFSmTQKUD2vexXIURb2GchC3rqnVpL0Aq5cEgJ3IPtUbN76Wy0ia0314jyLiemDNwMhdNgxianOmW4jm67PKrfoz0/251X3zhBjAZJlTkhfhzZf7oTSQILs4DOTbQTyFHUALZj6PUSjWj9K3OnQ2qM7ekQqkwT
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SG2PR06MB5288.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(376002)(346002)(136003)(39860400002)(366004)(451199021)(52116002)(478600001)(6486002)(6666004)(110136005)(2616005)(83380400001)(86362001)(36756003)(2906002)(316002)(26005)(1076003)(186003)(6506007)(107886003)(6512007)(66476007)(38350700002)(38100700002)(921005)(66946007)(8936002)(41300700001)(66556008)(4326008)(5660300002)(7416002)(8676002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?po30seB0PmFDzjq0onr1kJ6F91A9IpgXLH0Rz9iSEIIyG1UCrswmI0BLj8+8?=
 =?us-ascii?Q?UOuIWcWyM66rkrBfND/NLb1xW0TKWFYVTRIdSelTH76xKfbMKe4/fnwP8vmv?=
 =?us-ascii?Q?Yft7Yjh5gu6ZZl/uqccVPXWAcIZemHEqB9GJKthBQTbA/ZnfTalQrYTNhac0?=
 =?us-ascii?Q?QHjbvaAg3B04WCqX35iswXdhd59wAG1YExKqabI0HNZy5SzuEdiqNP2NcVPj?=
 =?us-ascii?Q?60LmiaoiWI8HsUncLFs6Ja6UIN70kqFnz32Rvok9V+x5ujMdwMgcYyDmRDgP?=
 =?us-ascii?Q?5A9Ym5Y17SsYYX/OJsNAEny9cZQTW3KS7GA2t/6kjq+BI0lnNgseLCiWYoBZ?=
 =?us-ascii?Q?kfpqmmE7pJdyWHKbb7JGorT3UvOQwiSJLszMj7j98GgG1ekn7/z1jigzNoX8?=
 =?us-ascii?Q?msTuovffLm1ShA9mu1KaVXX+yh95KGXoW0/TNPhjNTYJ1mSu9jg7eqjtmMj/?=
 =?us-ascii?Q?vBP+sWcoXAoauB3Z43Z6qvCm7z7TJsk16vQZETciunMDFpxNySrfGrYAXNFu?=
 =?us-ascii?Q?tG7Jb6gwGomGbtFguaBTzA3pH6vGNeOvA9kGsFAXutFZLRU4DAFR2QNJQez/?=
 =?us-ascii?Q?tObKHP/dDVA15rjoqAJKDJjZTKzFuFyjR0T4ksw3mxnMSTqdehHNgYiLB77S?=
 =?us-ascii?Q?xVcl3+g2CA5pdzwM+94xFAUgxaxgRw6XFNGgLVf3JdyJbVc3afqUnA0wESiR?=
 =?us-ascii?Q?+H+FBuiIdrdhcfGymZcmmnX93BsMq5VErEQU6pe4PY8ghajAIHzDC4bvi9/E?=
 =?us-ascii?Q?xb61dQ+3ske0MrTu4zR4BBYuhXhz2Fch7jO1Xa/dGSf6FpEeTzQ2KSV7D74t?=
 =?us-ascii?Q?G/x1VO++gMkB1fRinQmlQOdt9mu4++9dWkiVoPVikVYPBGvA82o1rYnuUVFd?=
 =?us-ascii?Q?kVYU/q0xpN3b9G4CP4x0u2QT1oki1xqxBi/bzeb0tkE4LtM6mydB9q0i/X0M?=
 =?us-ascii?Q?hI0PXWo29bA/XEu/1Wt0y0e5SefXOTsusKg5QyXOvd+rlwwhlEs9gLo8TZVd?=
 =?us-ascii?Q?SnLzhC0z/47yDD9Rt0yg3w7kuMMzEqQckAKMph60s4PHsu47N13rjDNiqwvS?=
 =?us-ascii?Q?tS8lWsw+HlXQVwtNJX6t5UrthsOpjQyeNI4KEZFWFIPGsgYSPeuS1IUuqJNE?=
 =?us-ascii?Q?Dl722bMyP4KtO9at0bg4KBeKHOfCW32OJkPNRzw0zjUwUyIzMdosJEA5jcvY?=
 =?us-ascii?Q?ERXP7evbpgZ1Zp3h8mYgCQgf1f4WecmNzgS82vRiTC7UOTWgabEAh7m2ZNRA?=
 =?us-ascii?Q?1qcCJvkfMQ4pts/HMs1q8PnBcS1ZdDUv6vW76wQhx39CfOEYXlkJh/wgSkCF?=
 =?us-ascii?Q?OI66y6X/Z9XHM+EFHW8qG3JFsgGJaRRn4rZjdY0jFjDdsBmOgfZBkl8+P7JD?=
 =?us-ascii?Q?aBmt9MK1Bodtb90H4OGwS/pnj+F4p0hvvwXgYXN9sXHz3mGZKZ0P8ZBcCkJD?=
 =?us-ascii?Q?VY+UystBzLAsl+v73SguEmtOae7jR03zAau2ywPacdbRR9eWj3y8EhWuYJf2?=
 =?us-ascii?Q?/gEhLMbROANHLS9ewssQNKy9WgjdBDWR7x0ElnAxO5xpoB0+GpIO7EfJTfaA?=
 =?us-ascii?Q?4/XYxtIWZEHQBNLba2bZgBDPVoXWWiHdrwuPTWzh?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cb75d3a4-0e69-409a-f53a-08db8408d9b7
X-MS-Exchange-CrossTenant-AuthSource: SG2PR06MB5288.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jul 2023 01:22:55.2042
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sfUnAVoeYmffKgqzvidy5X084cpOTstLjJHZ0oNDyu7VlUGOVyV7L3WLW4Zcn6c02FNeheoh4o2SYSxaWz6Nxg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: JH0PR06MB6655
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Make IS_ERR_OR_NULL() judge the vcap_get_rule() function return.
in lan966x_ptp_add_trap() and lan966x_ptp_del_trap().

Fixes: 72df3489fb10 ("net: lan966x: Add ptp trap rules")
Signed-off-by: Minjie Du <duminjie@vivo.com>
---
 drivers/net/ethernet/microchip/lan966x/lan966x_ptp.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/microchip/lan966x/lan966x_ptp.c b/drivers/net/ethernet/microchip/lan966x/lan966x_ptp.c
index 266a21a2d..59dd14247 100644
--- a/drivers/net/ethernet/microchip/lan966x/lan966x_ptp.c
+++ b/drivers/net/ethernet/microchip/lan966x/lan966x_ptp.c
@@ -59,7 +59,7 @@ static int lan966x_ptp_add_trap(struct lan966x_port *port,
 	int err;
 
 	vrule = vcap_get_rule(lan966x->vcap_ctrl, rule_id);
-	if (vrule) {
+	if (!IS_ERR_OR_NULL(vrule)) {
 		u32 value, mask;
 
 		/* Just modify the ingress port mask and exit */
@@ -106,7 +106,7 @@ static int lan966x_ptp_del_trap(struct lan966x_port *port,
 	int err;
 
 	vrule = vcap_get_rule(lan966x->vcap_ctrl, rule_id);
-	if (!vrule)
+	if (IS_ERR_OR_NULL(vrule))
 		return -EEXIST;
 
 	vcap_rule_get_key_u32(vrule, VCAP_KF_IF_IGR_PORT_MASK, &value, &mask);
-- 
2.39.0

