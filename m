Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EAE8679E957
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Sep 2023 15:32:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236693AbjIMNcc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Sep 2023 09:32:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230414AbjIMNc2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Sep 2023 09:32:28 -0400
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2057.outbound.protection.outlook.com [40.107.7.57])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A95619B1;
        Wed, 13 Sep 2023 06:32:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VEdya08FVJY8iFHgvBlHwxaO0+rMlOLSfgSCmQ/qBqRmSWhl7YZ5Q2ADWp+Pg+c1s1epOIGTEaQCjbEVxZ502BzY8oCyaSFEh928ELDOPzRiCsMtVlNbkB3xbBPDaMnjTv+F2xUQnVcYTD5Tr9mXQ5/ejEa0SCM8JUY9FL3OQ23t2p46ThQXfNdnghtcAqFT1K+EuXsXyM/ZJ6bgnFZO2rIZLmiI78RG1L3r7tPaCjTf1EY0xt0/Hnwt6Fg1Tb73Kz5T1YB1Iti1F0BMnmn/adBSQ6PKDMaPEI6IFv5sm6RkqpDl/OChEUFYXD3KmoTgJGfGnlDeRmjaZvjf8BDjZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=V/QVSMU//ln76QfWoNai3w+YiPU+zOvJ6qePJsE16GY=;
 b=iD34C3fOSpmuNfia60JZcVJe2TeMIX0bVSlEEAlAahbQTdfLiyzTcPIEXMhxwBgtpN3GoySe3schFJR7y0XpZTZ704X/pYRAj5yzpbnoWuXqquWQ5nSsiV/+9wI5kb9rBeYSk/YtU94qO10VCS9/2WYSM1hWHIydA0by4o10JAeJXRFuWm4v2GZLFFXDar/sIPyRtKn6wZuux2oYZjcKXAMG9e2qptIGVA8I1nyauxV0ki7tDRtYiCbjbKkaY3nm/YOePs5tSnXYrw+PjRd/ZJttm3jwqqJlT8heAGpCpEt5MzrmFyCL6sknFwGCS5jWt9VroY+F6saBjGPZmdeNdg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V/QVSMU//ln76QfWoNai3w+YiPU+zOvJ6qePJsE16GY=;
 b=c9st6lR0IDDauqnQYOAM6JK7x5EVgMjDn1iTc72QqnxxJf0ROxXsjHVB3FSPUS6Qg58sYuzfKau+FYCmqrKXu3g2iGDvXG40RpLizQmEe76Q1RTJRZJevU8mWEq8/GfOMv6FbZaTaf0LmWVVzaxguFw8AmHMz+NLHYEMzUiZh3g=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from AM9PR04MB8954.eurprd04.prod.outlook.com (2603:10a6:20b:409::7)
 by AM8PR04MB7235.eurprd04.prod.outlook.com (2603:10a6:20b:1d1::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.19; Wed, 13 Sep
 2023 13:32:21 +0000
Received: from AM9PR04MB8954.eurprd04.prod.outlook.com
 ([fe80::e109:7026:7d76:5617]) by AM9PR04MB8954.eurprd04.prod.outlook.com
 ([fe80::e109:7026:7d76:5617%7]) with mapi id 15.20.6792.019; Wed, 13 Sep 2023
 13:32:21 +0000
From:   "Radu Pirea (NXP OSS)" <radu-nicolae.pirea@oss.nxp.com>
To:     andrew@lunn.ch, hkallweit1@gmail.com, linux@armlinux.org.uk,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, richardcochran@gmail.com, sd@queasysnail.net,
        sebastian.tobuschat@nxp.com
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Radu Pirea (NXP OSS)" <radu-nicolae.pirea@oss.nxp.com>
Subject: [RFC net-next v4 1/7] net: macsec: move sci_to_cpu to macsec header
Date:   Wed, 13 Sep 2023 16:31:59 +0300
Message-Id: <20230913133205.3749628-2-radu-nicolae.pirea@oss.nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230913133205.3749628-1-radu-nicolae.pirea@oss.nxp.com>
References: <20230913133205.3749628-1-radu-nicolae.pirea@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: WA2P291CA0007.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d0:1e::10) To AM9PR04MB8954.eurprd04.prod.outlook.com
 (2603:10a6:20b:409::7)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR04MB8954:EE_|AM8PR04MB7235:EE_
X-MS-Office365-Filtering-Correlation-Id: a6be29dd-7be2-43bd-fb8d-08dbb45ddbae
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1I0p6SWwMTifcHe+bRVhYsas2+IfoA9pp2yLv55TAejqRvLEgeNFURO3qS2d7zWX8sZuOHwjNDvk7m42Ck1Gb7z0XWDl2RBzJ0asfU40+voWKKXiZX7oQhGPye3zk275cysu4vGy/YOWTn/47G6NorKWAjrndFoR+20S/6BrBRYD4OYWcRoXrFlrEMAe2qKsoKs9jeYQUJpiQD7Q4BA6UKTKYDKc959ahVX6dKGL71vb8+Da1SBAJd6tvOrnY1f5OnmGp75aI0tACz51shpR9k9fmY6UX9sTRHs6BXQ96tUJqjEj7KiIDBcQfuGr6V19INu0YBfDR7QROXh0objzvxJJlEe14BVhTJ3XBYrvCLbX5pGwr971cA8nLHZHrIoybIDkAKkjALLBaA0z5uJR8f/PrUjzzcz84tjh3C5C9hNoMx04AgKmt8RkgZt+OtycZAtz9HeTf8/uda0JYG9bOieTMtyIk4PxdQCiT24F2P0ohvfiMCJlEkAnsP9n9+5b3pGa/i1CfWEanD+FRP9waLHZI50985suT8nqNN+Adnaskg3xxKwDvv19VF08EHhodCEiEhvAP8ie7FJWRypuZyPI2j6lS+8hglkuoeNti5TtTt0sAGAe0rnFjkvpML0J3tdkgR1i6qtwXDyurryybg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8954.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(376002)(39860400002)(396003)(136003)(366004)(186009)(451199024)(1800799009)(26005)(4326008)(8936002)(8676002)(52116002)(6666004)(1076003)(38100700002)(921005)(2616005)(478600001)(83380400001)(5660300002)(66476007)(66556008)(66946007)(41300700001)(6506007)(6486002)(316002)(6512007)(7416002)(2906002)(86362001)(38350700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?TCOPvhINPMehukBfF20ASmGfAusXZDGLpbx9h1qbJLwLxrn3pkWpUl01XCc3?=
 =?us-ascii?Q?rc1DUBnfhPZvMuBTK/Wc0n2KkW5L6nrpXpTWp5gmuQOFDOX9aH6Ll5T+FpM2?=
 =?us-ascii?Q?MUicfmxdqbz5t+QMrMMMCFIoQdiRSt6U8qyzOWCs2sGeI6tInDXwWr39AM29?=
 =?us-ascii?Q?5FL8qzt13p1f/fraFQRkNmlcE8YJZE9SzpV5bHNUHWP5CzagUcFWKT8pGHCp?=
 =?us-ascii?Q?N9WTnJNx73DsZ+HUi23ii0I+nSJBXjlTA5oOTywhZJeu8USiNtlecykebJAt?=
 =?us-ascii?Q?MlbXkegux0BWYyjqVuV/Rz0AUTNBWsDLWMNk0voP9wkdCAPnkv0w1SkBYxSs?=
 =?us-ascii?Q?yiJW6Cv7AReIlIhYhOwYKgBfqSe2qQNoGkEpXttHZYnpkSFpKw2xsI3bM3Jn?=
 =?us-ascii?Q?WrLGWKjw5HrglEv6X5VAnT7JKqcwMSo3F05x5Pz9EgLrPG9EG0inc+2nIJuS?=
 =?us-ascii?Q?CU32VSRfl9S9vl8+hGMANrSF+hY7R+ChGOK62M7tLq1JvnWUfpDpxVskMNmj?=
 =?us-ascii?Q?OcJXhQhfjG+MOOA8C5LEXFxLzDoaHZPntgt+ftAMmrTfIPeFMi1rRr3SQ7/K?=
 =?us-ascii?Q?dXRfaZbdTLqDSPAIC9bMt+7fdYlpaYdbg909BYY0OuEh8gbxrEEr3mVdFZyl?=
 =?us-ascii?Q?hF4dDnHvUrkqxGuTvooB1UPOxe6OgW/AKKal5lSkD5axCoiJ7O6uy1tEdDHR?=
 =?us-ascii?Q?jWrBQYeW4U/9ZmXtFVbFXNzJrcF/XrstWOQ+qv32Xey12kG5hktXxHcmT/kp?=
 =?us-ascii?Q?dw5U4x6QhtqV+BUl3U5gA+3b3pD3gPXQeedh+0GmSiHsN7xMwE5d2RqtZAtK?=
 =?us-ascii?Q?0AOMVQYJoA/elBAF3DyoknK9cDOJyORAW/JUd8NOE7ifygbPWp6ItmRSj8xu?=
 =?us-ascii?Q?R74XugeJjBG57nlM0ckoZAzOvu5Vh0FXAxONcB0Ii/d6VrBAV8DUjaJJue+3?=
 =?us-ascii?Q?FeI9ZCcwAUjRaLyDu0uAw+MoxG7dvi2SL2wPBBETyJXShkQfSNABsFy5TG7i?=
 =?us-ascii?Q?2SSU4KOoaIIkbzvdl3sugxPBQpk59+4LUJHmzyLeoXDxT0o1El894Wi4rk5x?=
 =?us-ascii?Q?YkLMG3gFMaoSxOZok/WdJ12+C/UEWZl1Vtp/ELr8+E4iwTzuWeNaq6xb0bZ3?=
 =?us-ascii?Q?fzuzBfVlqvQxKhfvWtdO9hO7oCgnLaRLSQey8FjHiPEkDjnHruBg0iJ1AIEX?=
 =?us-ascii?Q?aE4HZc3XbM+TF011phDtrG57r56k/eGv3CSWLzz11CadUF/qbrQ3GXQCyCgw?=
 =?us-ascii?Q?kX5MMbCRMphXGwZF3+8pNYaeKAVGwozH8/aa+w/nlGSmT5uaS5MMmDqGkekj?=
 =?us-ascii?Q?ViscPItPqAsKLbLEoyN/7jHgQVXKec4mIrtpYjuuKjq5axi5ZSzuCgWOwjl7?=
 =?us-ascii?Q?bPbFiTo/qV9q+4uuEtdlvyEyZeMKwN+0AC304yW1uBSjEfE0KeLzAIM6twrf?=
 =?us-ascii?Q?JVb09ZEAj7Ml83jQSvUaz/+eItbD6OwcYe0oCyzJMu3/UCNQePtIzQacOCCa?=
 =?us-ascii?Q?OAEEFS3V+t/2l11oICpv09BH0k39D2MG4TUDeXjT+L1yscIF6d7Hb3kJPWzi?=
 =?us-ascii?Q?CDUFzV3FvRlAEexQg7hh19AFemr0Q2wcPcQuThgpkow104QcVrEMgN26aOQ+?=
 =?us-ascii?Q?tA=3D=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a6be29dd-7be2-43bd-fb8d-08dbb45ddbae
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8954.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Sep 2023 13:32:21.5723
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3MGjXmPi2SI+6033vCeQtgFb19/fWZ2xpmqfYc2wwYFSupG7QHvepsbcoyTAajfHH0v0f0DbhJfXRxTRhGsDbaLEbTkLGIVkf9jAZpc6eTU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7235
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move sci_to_cpu to the MACsec header to use it in drivers.

Signed-off-by: Radu Pirea (NXP OSS) <radu-nicolae.pirea@oss.nxp.com>
---
Changes in v4:
- none

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

