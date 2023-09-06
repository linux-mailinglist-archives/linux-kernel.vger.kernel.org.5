Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08F7C794105
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Sep 2023 18:02:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242904AbjIFQCy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Sep 2023 12:02:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242850AbjIFQCu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Sep 2023 12:02:50 -0400
Received: from EUR01-HE1-obe.outbound.protection.outlook.com (mail-he1eur01on2075.outbound.protection.outlook.com [40.107.13.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15D771986;
        Wed,  6 Sep 2023 09:02:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ajaDaY0TaR4AfHwRYXLBYmXLb/aLr4uHoUJ4MyyNYZ+pobjoVxM/7+3lvQJvnH9EuppSxrWLvYLyABFUieGRHQapOR2a9BkpPkSEgUkWEtWAlH4qnEVwwWN6Ddwz7iYzekGYxY6qjsR+jAj5MHNkAF52HjbByc/vwthikBvLEOUynmliVKUuFl7sTftFv2dm2IdNTC20Z8Ib0hJEsMYTI5E0rVCzKj0mGy+dZXNDkxEyVxJWyQ8R6CQ9JHQYL3TNih76zMJ/uYUBLLuYKGfIYZVLUKAfXBKE5ZnIr45N2kCWpY13Y5Q9elfk7sT5bCqSse96RUjv8Kdxo5A9lJB/JQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ClUwUPQiPQPiTzj3nMyuxisg182Y43wXi95FO4ApJ/E=;
 b=fTWUdU6LGBqnjsCmHYzKi4R1KwfzkJCYARY4owjXvDgcnd07H+wh/R8Iz6E43DWeumWKPY++mPN3/8q/M3FGziGDZp/DXZH0qsnTA/bEVDjQSNs1QosSZM4kcfqE22B8gORelAMcxmKaD/tqQRVmwU4LX3WEXLvSXYw1D7WftvlNjQ/Wd9Giaxr/p/NLlRca19d7rO1/4vxwltS2o8qgYpXFLq3p8AmSN2VCDKuybnh7YgtoxJQmeTKZvoDK8sADmCQ000QSDTv8bey7JJzFq3yMKA7oMsg9VtjrS7fKoNWImeXprpjO5qaigk4cWTYXiSiVeVfRIsRCT9O1R74DBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ClUwUPQiPQPiTzj3nMyuxisg182Y43wXi95FO4ApJ/E=;
 b=EwVYHYY6GGwhLJGhkv94eBszDQClbbClXEAQRUfenBccKaUfwdA/2ehrt1YMRqXKs8MI5AwvCsRFoWjVB0nfWmYpEX835rsEA+NLi0hD3GYY7gbB2JhRg0VDNs7PnTHuvjszrndLJJ9S+GFZHqCoX3g5xd89Jn0elZ2iHsisyK4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8958.eurprd04.prod.outlook.com (2603:10a6:102:20d::11)
 by AS1PR04MB9429.eurprd04.prod.outlook.com (2603:10a6:20b:4db::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.34; Wed, 6 Sep
 2023 16:02:30 +0000
Received: from PAXPR04MB8958.eurprd04.prod.outlook.com
 ([fe80::d7c:390a:4105:65ee]) by PAXPR04MB8958.eurprd04.prod.outlook.com
 ([fe80::d7c:390a:4105:65ee%6]) with mapi id 15.20.6745.030; Wed, 6 Sep 2023
 16:02:30 +0000
From:   "Radu Pirea (NXP OSS)" <radu-nicolae.pirea@oss.nxp.com>
To:     andrew@lunn.ch, hkallweit1@gmail.com, linux@armlinux.org.uk,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, richardcochran@gmail.com, sd@queasysnail.net,
        sebastian.tobuschat@nxp.com
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Radu Pirea (NXP OSS)" <radu-nicolae.pirea@oss.nxp.com>
Subject: [RFC net-next v3 1/6] net: macsec: move sci_to_cpu to macsec header
Date:   Wed,  6 Sep 2023 19:01:29 +0300
Message-Id: <20230906160134.311993-2-radu-nicolae.pirea@oss.nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230906160134.311993-1-radu-nicolae.pirea@oss.nxp.com>
References: <20230906160134.311993-1-radu-nicolae.pirea@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM0P190CA0007.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:208:190::17) To PAXPR04MB8958.eurprd04.prod.outlook.com
 (2603:10a6:102:20d::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8958:EE_|AS1PR04MB9429:EE_
X-MS-Office365-Filtering-Correlation-Id: c093c9f0-31c3-4044-f0ec-08dbaef2ab34
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JUpnXTLgUXR7TQAAQnCNoif6ZJuwHbBVri1mJKoUXDg5J5TBjP6AF+Ex+D0KMzeSJjAcTTxf7Ru8RmyL9An3wGYUsycB7/6Uu3asaGF/pluxHkejrTH0f046HdEcsRgAeil/CqPrQXo6nhg/YoMutkYHht0X5eIrQGNFK8VWW4YXemLW+/FcloWEZG5d0iLw9pHFopFVG9KlWCeD6kHiwHOmmhXFNTHxWy24OGb84osN41p1JhizX7SFujjtgBjimaJbW6rHVaZUks5B/slP+BJlvkwFbdgLuJLopgUjKBC67cdnWkwyGvs6AcKXk3d7+cemCjoHRKm7uJMGvFe5+0dRz0YfHC6QPBZAoPSIt0mGU3d/Fp1GUvJkp3vpVdp6a0s/v0njYdnZdlu47QkIEohvFZDgP6xkB+azn7emEHiQQAUMtwYpkAfdIIpxNDzr+GKwlOG29cCVjkS/pItqc94wp5OZtdc0SWJNgp7GnK+v/EwU5Bd37GU/h1KVNVjs3B/t6xyre+p5RfozAM+sHyG3b97S9a0rGNK8kamC56+sgkvyGzlbhbF4+N9tQRDcZY+mtayYddfqQ3WPYkmkq4k6hDx+Gq1LqUMHHp/fmYikX84H6hXhDffQcOSU5itDXU/cohH/NS0asdu6YBjVxA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8958.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(366004)(396003)(346002)(39860400002)(136003)(186009)(1800799009)(451199024)(41300700001)(7416002)(921005)(38350700002)(86362001)(2616005)(478600001)(83380400001)(26005)(6512007)(1076003)(6486002)(6506007)(52116002)(38100700002)(66476007)(66556008)(66946007)(316002)(2906002)(8936002)(5660300002)(4326008)(8676002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?pCJCGQf0hsURkpHNMlZC+WWKHx93LsyiF6jT4iLFGmZVNw7dSXKF7KIHrrs6?=
 =?us-ascii?Q?QSU1mhMWDYfGUJnKhcNa7y0Xsp3b+aZtXAJDqJnlmrZMA8/5Gz44n9HyeJNk?=
 =?us-ascii?Q?ZJ8bLX6KwGVV3Nt28a1mO8cVtHBPVDR8cHi3PS0zx81G6Bvmo4nQW+kEFBWJ?=
 =?us-ascii?Q?No6ttYp0zMLKElERYL7/+GMY4PV1i7ee6iT3qLnflwHB4RFHP2U4BkzKQDuF?=
 =?us-ascii?Q?b8kQgppxUTg2AU08CAFKBwyJnwgcE46fnOEf4BXIGDQRosa9NFzkuuBY0rlY?=
 =?us-ascii?Q?NpXduVOKfMIZe68oEPeahloV3LyUAjmOCjg8sCrSAtBC3m2kVEWT2zG3/FDH?=
 =?us-ascii?Q?OBq0lBXoBG2lnGdZuAoBq1xS/E/JVUQ7nOB38F/a0SZ7IN3spfgfVu+wGQqV?=
 =?us-ascii?Q?DW92p8Dk0RLf0G5/DjJ8Ee0PRg+qTFycNh+zpcAWcDpDwuUfU8Q+1ktZ3/bB?=
 =?us-ascii?Q?b/uB6neqxruUZqlYD4sa58kZeVq0P14RM05a/TTsPXdroedMfQ4InL6ANaXp?=
 =?us-ascii?Q?20hmB1QNuCZzO42JlYcY3wMwFD7/CxZjR6ZyAKVMjTQ94SQCK9SzEHzq+Ocf?=
 =?us-ascii?Q?OXYZIqNT55J95vP/ZQdl6ub3Qz7sLur/DqUuwA1dqAGNtiOrmP7s+5sJOfZT?=
 =?us-ascii?Q?O4Yt1sEkBpgehIZ5ajKf9qFd47mx8CSDQBV8GLP/3vnwPiT3+wYZpnM8zn9l?=
 =?us-ascii?Q?l1RueFhJumC1rR4Gpiu79mHxeJ0IHY5dW2mGhmiOVfAEA0z/HvOvIpp02svd?=
 =?us-ascii?Q?B1IE482zfLl+qKS+KIXhoPxmEWHzBh5VswvYs+CvT7V/j2NAbskOiJEkSFrj?=
 =?us-ascii?Q?H0rrOdfXqfZkEf56l33vHo/fLnZ0ovhYEF0LdIt6RBgga7jyVRa+zO7oh4L6?=
 =?us-ascii?Q?VZSy4/lUFNxKKVhyVsF2OjShC4qdjNlNf8O+N/bsaSUXPfzYDF/y861UNQ7J?=
 =?us-ascii?Q?HIHwacQNWaEd+4VEUGO1cU50/6gTfY/vILyNZ1vbazTaMgsm5L4Pub2+0i4D?=
 =?us-ascii?Q?nz+Sx6n/RHwqhSBWZqSRqgYRq8hCwHwciPpR6NRc1RA+7/PZWbB8oWJybg6Y?=
 =?us-ascii?Q?p5WxKFVNm7EnCPDkwbo77B2KJAEXIXvtIY5/QlyEj5+Rve1TrBTZMaoLppR2?=
 =?us-ascii?Q?qO5H2Q3xZ5OibcX0VCOSXSBpf/FH2ZhY7U/9cCurxlxM7BQELJ8WRJN3h070?=
 =?us-ascii?Q?BsRwjqdNRtU6zC0ftfDH53TdTcXu+6oaEdFUz59j/mmfku7LM9q9iNnklsVk?=
 =?us-ascii?Q?k+xiQvMlmmof+NRJMO+vW2jTOePZCFPqxf8d0aYZPe3rOEENA1zmKXocfqkk?=
 =?us-ascii?Q?pGdSAmAk5X3KyR/+gMcd9KG9kXw/YIFYRMu2yDVPpPsiXIgVmpRdqELk1bWk?=
 =?us-ascii?Q?PwZ75enRmii1v6c20aO+rq1Z0KabzK7cDcMC3nFDxa67p1KtXTJIh0odDK7H?=
 =?us-ascii?Q?//7CyI3QaU/fQbDX6nvWM3tB9yOVqgD4O/tgW53ShfC4327TESz6PWJHjg6Y?=
 =?us-ascii?Q?7peceNIXTNSo5/T6TDZgTI7lPlAFNxo2WOYYnJMphq59eN52YWdS/Duy4qQA?=
 =?us-ascii?Q?d/XIwxo1JDY+bWuZsOcIYRK95KAZY2RLQrqUFahbeawalozqcE/p2I7amau0?=
 =?us-ascii?Q?gA=3D=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c093c9f0-31c3-4044-f0ec-08dbaef2ab34
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8958.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Sep 2023 16:02:28.8373
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AlvhRc0hQ/aUXM7nGgBdmb6thUnmxvd/hdct4Rr4fLxyiNyN4KW9cdMw13hzMP22WT8SFEo/cecY1QTfSfeTlVZe7R7M6L7dBmVR8rrnjzs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS1PR04MB9429
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move sci_to_cpu to the MACsec header to use it in drivers.

Signed-off-by: Radu Pirea (NXP OSS) <radu-nicolae.pirea@oss.nxp.com>
---

Changes in v3:
- patch added in v3

 drivers/net/netdevsim/macsec.c | 5 -----
 include/net/macsec.h           | 5 +++++
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/net/netdevsim/macsec.c b/drivers/net/netdevsim/macsec.c
index 0d5f50430dd3..aa007b1e4b78 100644
--- a/drivers/net/netdevsim/macsec.c
+++ b/drivers/net/netdevsim/macsec.c
@@ -3,11 +3,6 @@
 #include <net/macsec.h>
 #include "netdevsim.h"
 
-static inline u64 sci_to_cpu(sci_t sci)
-{
-	return be64_to_cpu((__force __be64)sci);
-}
-
 static int nsim_macsec_find_secy(struct netdevsim *ns, sci_t sci)
 {
 	int i;
diff --git a/include/net/macsec.h b/include/net/macsec.h
index 75a6f4863c83..75216efe4818 100644
--- a/include/net/macsec.h
+++ b/include/net/macsec.h
@@ -324,4 +324,9 @@ static inline void *macsec_netdev_priv(const struct net_device *dev)
 	return netdev_priv(dev);
 }
 
+static inline u64 sci_to_cpu(sci_t sci)
+{
+	return be64_to_cpu((__force __be64)sci);
+}
+
 #endif /* _NET_MACSEC_H_ */
-- 
2.34.1

