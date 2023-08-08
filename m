Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 750E5773CC1
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Aug 2023 18:09:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231970AbjHHQJa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Aug 2023 12:09:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229568AbjHHQH2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Aug 2023 12:07:28 -0400
Received: from EUR01-DB5-obe.outbound.protection.outlook.com (mail-db5eur01on0622.outbound.protection.outlook.com [IPv6:2a01:111:f400:fe02::622])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14BFE7690;
        Tue,  8 Aug 2023 08:46:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MXUEbKouBw9UT4vfDS/5tUvjXq9Z3ZL0vGRf4ws4WmOfd70s4uB9c8n62v7GvWM8gsBtd3X4j0py/ZsfPOwTyr+7pkFmaYB7bnx9Z5yv5ZSRh5GqIpKpM8nDcVgYqtketF5tUqg7hnrC/1kxaeUcI88D5ZAIScQ/7V77R/4s9F4juZSjiFjqPYZ+KztBygu6qWgUktaMKZnBNV0XMBuXFRCAQ7Fu6WUGbNa7RvJPOB79RRi0FZ26uZAirZoOMMfxoFEkBv6o9MAFQt4p/jmo9rNGest9MdvAZDrXpUeSiScXqVJjj4pgPpZRr6LgJpj5ln4QW0va9Z9YeT7WhVBNMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wFt99/533NR+5IM98nSqXOIdz9Q9mOkGosQOX/Wx1U4=;
 b=Isd+vM0sETBs9l/Rhk39WPY6oyt+9uY/gncTY2Lm4y2fNAXUS1U5PF/K2yxgSmsInm0uio2kF9eFf32Fz5oG/AezFiRHUpIHIr5X5GjTmYmx4Y4z+unhqejH8M8Qt85cNTEikXkRuaytnEtrGKaj4NKKCm+Ay5pGpMnia2eqCYiQivD8dvbaH0WNjBwCLtEnYavwfg1LhO3tU8T+DR4FHUMTd3x4zt/pHyQdErHbazx/j78UFCLFfoye6iiCzbSRC/MLqxXuwR/nJ6StViOfuBXi7AJx8rLaHzQGcQRSG2IkwPa+y4GnJdewTLqMEoDbOXBUv1dxzSPTBhvXWIwUNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wFt99/533NR+5IM98nSqXOIdz9Q9mOkGosQOX/Wx1U4=;
 b=FYoCSJDuGSHMD57qMSlplzkWTRfSCMLdUD1wXNi7YLZyVe7eMeR1IKRLPDCYTUCNfMrx6AIbXmk6cWC/O/P2bHFz60c27MHzzB96TT51s8IuoNS4vqWNSVScVYUDkMf2n4qz1s1VkFMNJqrP9O5LpuWfc8KlNQUMwgWsOPZTsLU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from AM9PR04MB8954.eurprd04.prod.outlook.com (2603:10a6:20b:409::7)
 by DU2PR04MB8696.eurprd04.prod.outlook.com (2603:10a6:10:2df::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.27; Tue, 8 Aug
 2023 14:14:44 +0000
Received: from AM9PR04MB8954.eurprd04.prod.outlook.com
 ([fe80::2545:6d13:5905:bf50]) by AM9PR04MB8954.eurprd04.prod.outlook.com
 ([fe80::2545:6d13:5905:bf50%4]) with mapi id 15.20.6652.022; Tue, 8 Aug 2023
 14:14:44 +0000
From:   "Radu Pirea (NXP OSS)" <radu-nicolae.pirea@oss.nxp.com>
To:     davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, sd@queasysnail.net
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Radu Pirea (NXP OSS)" <radu-nicolae.pirea@oss.nxp.com>
Subject: [PATCH] net: macsec: use TX SCI as MAC address
Date:   Tue,  8 Aug 2023 17:14:29 +0300
Message-Id: <20230808141429.220830-1-radu-nicolae.pirea@oss.nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM0PR04CA0130.eurprd04.prod.outlook.com
 (2603:10a6:208:55::35) To AM9PR04MB8954.eurprd04.prod.outlook.com
 (2603:10a6:20b:409::7)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR04MB8954:EE_|DU2PR04MB8696:EE_
X-MS-Office365-Filtering-Correlation-Id: e1728e0b-a35c-46bf-867a-08db9819d088
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wo9Yd19cUo+sQcIp+ACPfIH2Gjvwc5GrxkKsew+b6DavvkXYV3dNk/bqRuQZJ1nkmYhow8e0XsCt/sPOSJIykEFTxi3W5z1L8AaxEeOrtuX08IyV+pzVWWWnqsahTlS4Ib54nRDCYWhNVo3CWBCH0D49n4usZ7FH7pahyt2B3KdB9yXdMD7Yx9knfI8tBI2TXiD+m4ZZc/7CWHptLQU3/u2XIsyirw1OL0/AHabCrlXHcl8O0PzA3g0PdxwQ2N37YPM+7NfSei729aNcunBD61Jtyd5/9xNZmaAqEr80xbDChN0EFf2M8703WcwLZQnwjuy0i5F4DpUkK+nMU1KcnqgqKuv3rSE1JLitf2XVqe7L0TlMsTbWUK/yeqWrkP2ivgJ9aEfLtwNVq4ThN17FmpJqmKgOWvDTyGrPGCdmgKUtrogEd3mqB7VEpItNeW3DZSPFO/elUS3ZTtuaxf6uQt2EZKyKFuJCSvvCz/xKgjUrL3WOah0JgvD3lfKdJqDOe9ZFPzXjeOWplOVMuxqxRFmSsbMHzH0tX4y+4l+903qr7GUKlppug3zYdt1726AeqRHkYNQKMJ5aZgK8blRu+PhwjxebitD/xWsuA4IA7BeBl9O63TXYL4Elj8iHYiQY
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8954.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(396003)(376002)(366004)(39860400002)(136003)(451199021)(1800799003)(186006)(8936002)(83380400001)(2906002)(41300700001)(5660300002)(8676002)(86362001)(38350700002)(38100700002)(52116002)(478600001)(6512007)(6666004)(26005)(1076003)(6506007)(316002)(4326008)(66946007)(66476007)(66556008)(6486002)(2616005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?tfWbHk3vlIn3yQNFsyXAaWPx3OITdPQo+/rfyuVkS/lpOHpm/BgSDRbAJckJ?=
 =?us-ascii?Q?cuBViIsTO/pwUdBHF4geJkYuEKYvAmIETFAR9R3hJzJHslN1432wv85qwLx/?=
 =?us-ascii?Q?e611e6jPpEO0BHWSP6H2Ix+L6+Wtiv3cI3rvcRhSNst/1Ze/GF9DTGqJacLi?=
 =?us-ascii?Q?nPTQegrCP+xkECCvHFzeL7NSrXl7AkB8ER5U1PnI5fQ2qWuyycTW8dAak/f5?=
 =?us-ascii?Q?bin0/kXliyVi94+UsbGzhxQHf6kr72fm+TCpqe7cYmoG/tzr09bGgii0YRQT?=
 =?us-ascii?Q?j4uT4+ogrG3x7pGSum2JKnkOqE7dfikabERpwbMPLfN+G0wMVicp+PKX5pN5?=
 =?us-ascii?Q?/trgXutcGnLt312kr6Pnmg5qypPC/4cyr8c0YG893gN7LGg+hd2bvc9PpplT?=
 =?us-ascii?Q?vuUcsJ/E7zICUI+XMqNaYDvg4cJ+or1cuHXM6BJqJ3EF5cje7KtXmyfqtF2V?=
 =?us-ascii?Q?cIhunNc8SWVBBYt4hCAtAqiXGgRN0HPBIfVFrfOVXtKEs9d4i/PPmoTG9AU3?=
 =?us-ascii?Q?LD2UVQm3cr9Cv4PII6Yw/z4tqGIQRCOnF8lFGsdZ20hMS3dgASVNiqCP0Aly?=
 =?us-ascii?Q?AsCzvlWYS4J2h6zOCbfKdHslWgbfybggYLoBqcnLHGUoqQJtK37CwgATNjcT?=
 =?us-ascii?Q?P1KqWPOJ5qoiFdN4ioEz0qYuolEaCzOSuOV/Aslz4wfQlfuDVYAtiCEsnhUD?=
 =?us-ascii?Q?lNN593Z20yAjZ1R0znjuHe6353FuauzL+QbFgfRML3eZerylcv+z/Hx+l6+X?=
 =?us-ascii?Q?xQxa6SZr4I4dewPOwhFwCLRajt6fzA7WQpcV7TDZCyYRf4w9yGoYVPf8DJ0h?=
 =?us-ascii?Q?TlZkXcbVTq+kC0oPtVThihJKVqg1kP8nTI6eiV6EqtF1jToo9rX+psiAYZrx?=
 =?us-ascii?Q?Q3F5euAnlhG1IJCRfjUoLp15ZTfOntUhQyJ5CJZuiAoSsGdKlahtvzJaCAQW?=
 =?us-ascii?Q?n1WFCPgYMuZZv1P6ofTgP3yhWwCISownvvqzRAoFQRd/BUuIp+voRi45voow?=
 =?us-ascii?Q?P7jkqDcnJ8alf5nF95RYS+Itjp0IVLfF1pqPK0B9dLmxH/2t07oma1Y5WXJ/?=
 =?us-ascii?Q?y7RzVd6vFbHvM/ZygtQKgbQq1CbbSoj1mZIirPyYBt0zsE5c3k1GW3D4I9yT?=
 =?us-ascii?Q?bRtlg+sRAQHXt7AkwpkqkouQuMFltyIbwgnHlQx4Ym4+ucBYSqaqcS6CK3cq?=
 =?us-ascii?Q?tLIi2O0DARp9PKXs3L71R9/91VXSCgaGQQ9ZnjjJ/ip27lHxghP8Qx5HyvUx?=
 =?us-ascii?Q?eg9HpX+D8kNLNxIk3DaYvxipt+yY0QYAdaTpx/YdDYk+8tscmfSIAhxYGdW3?=
 =?us-ascii?Q?HNtXUn4bLn8vDKFG44py8deR5RLaGV5eddjjVXtGC5hDqqmw1GQH7Nv9wDCz?=
 =?us-ascii?Q?H20d5NVPHixeJaDtR+GOnk403rjkqJ3yY3Ers08rLKk4Wf4LZz954/2cYNVx?=
 =?us-ascii?Q?CKrreF7RZSD8yCznwykb6zBkExMvkkzheskSSyDhadR9MNwVEpPDQsebbbgV?=
 =?us-ascii?Q?l11t9VkdGJ5vhXTTaujtc5tF/uc350yNGYjBmAgxDbC11KLIVMHYZU+i0yqF?=
 =?us-ascii?Q?7P9PS36aePJlVzudTwqq/ARdeCRt7drCWmZQoGGZ5sa5R7jVcILtW1mkVBHe?=
 =?us-ascii?Q?QQ=3D=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e1728e0b-a35c-46bf-867a-08db9819d088
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8954.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Aug 2023 14:14:44.5918
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5aBpLgLoGHU7HaMnq26qWxX5EN8mgIntuSOkTshi0BlbdyZGkJeav/83xAnYwfKsOvcGXeOMGQB34GhIaCPsDQZZmfspIcX6aMZ0T9KNIxc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB8696
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FORGED_SPF_HELO,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,
        T_SPF_PERMERROR autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

According to IEEE 802.1AE the SCI comprises the MAC address and the port
identifier.
If a new MACsec interface is created with a specific TX SCI, use that
SCI to set the MAC address of the new interface.

Signed-off-by: Radu Pirea (NXP OSS) <radu-nicolae.pirea@oss.nxp.com>
---
 drivers/net/macsec.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/net/macsec.c b/drivers/net/macsec.c
index 984dfa5d6c11..6db69daf880d 100644
--- a/drivers/net/macsec.c
+++ b/drivers/net/macsec.c
@@ -4103,12 +4103,14 @@ static int macsec_newlink(struct net *net, struct net_device *dev,
 	/* need to be already registered so that ->init has run and
 	 * the MAC addr is set
 	 */
-	if (data && data[IFLA_MACSEC_SCI])
+	if (data && data[IFLA_MACSEC_SCI]) {
 		sci = nla_get_sci(data[IFLA_MACSEC_SCI]);
-	else if (data && data[IFLA_MACSEC_PORT])
+		eth_hw_addr_set(dev, (u8 *)&sci);
+	} else if (data && data[IFLA_MACSEC_PORT]) {
 		sci = dev_to_sci(dev, nla_get_be16(data[IFLA_MACSEC_PORT]));
-	else
+	} else {
 		sci = dev_to_sci(dev, MACSEC_PORT_ES);
+	}
 
 	if (rx_handler && sci_exists(real_dev, sci)) {
 		err = -EBUSY;
-- 
2.34.1

