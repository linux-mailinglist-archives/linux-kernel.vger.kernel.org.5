Return-Path: <linux-kernel+bounces-5422-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id F374E818A8C
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 15:55:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 29698B23083
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 14:55:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04FE31DA46;
	Tue, 19 Dec 2023 14:54:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="QO/l9Yq5"
X-Original-To: linux-kernel@vger.kernel.org
Received: from EUR01-HE1-obe.outbound.protection.outlook.com (mail-he1eur01on2075.outbound.protection.outlook.com [40.107.13.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57AF420311;
	Tue, 19 Dec 2023 14:54:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VXPx9zmDrSnHhR2iQYavOZfvuGLIgnCDWIp942PUBYE1eKivc5epliZhjJ1iNVvZzNYUvAM05zvn3bmQ4R5ddP5Yk6AZWCh4wwL28KAns7hfe8WE5P/Rn5DkO96Rnp8m+2YdARJXFg3W3McNDlE+NR3HnuBy3pPAaO/Z+hXY32Kw++Fl34DNTtQ6JVTCANa91LtF/9f89dPar3DykEi1FTsnZoauV/OLQ9DbiuFMLjd+UDaIMwwdCt544kiJ3rvdHA+4zSoyokE490d3Ry8P4LblLwK4zkHDFGw6S6GUofTzXb+/wDTIjwGzOARjAtYnBLTGg8sJsniSkHx9XdQtRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bkU+6PbNom7DP0ZhvnqCPXaXH0cvYDHhVscLq43y4mY=;
 b=VN53uDEe19J8OsqjBDvWaugOorJkSbw1iZd4guvlUaUAkUnrgov4IMAllI7VE6/+gZdI1wcVi4B86fYyqIF3rHIs7zKQnFusaCn7K7aXPdPlzoDIjliuBy+2acedZ5xvMxqf5pg0mYcz2wkedn+wHt/V0+AQtBoLM6318lrddYRceV1o1yRerdth9//rxEsGQ2oAZZG6YcwU3YOgbhvj1I4vdOHo33tWG4PJ3SkDNSMtJifdV+jIJvkmSZ2bV29YfsEB+f9ydCJACQB9RSInPWvbCulDu+MZ8dvv+0EOS6vv29DdT0Zh3GXicwP3KNFtCjIMFlt8P1FD+Oj5+KVLmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bkU+6PbNom7DP0ZhvnqCPXaXH0cvYDHhVscLq43y4mY=;
 b=QO/l9Yq5bSBCGeBHaKp4G1SL+6cLUaVL2VKiYVd7iW7hnzmpLGqvJ6iogc8NLj78mdeOITRqw/aFOt8fUYtHt1ASe9VhuM7k7A5AgCdOVYRpPcljjNJTMo6xHZaEwaHMf8ytpHR5tDlmejMTOnDjk12NPtSE9JdI+zBTmATcxGE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from AM9PR04MB8954.eurprd04.prod.outlook.com (2603:10a6:20b:409::7)
 by AS8PR04MB9142.eurprd04.prod.outlook.com (2603:10a6:20b:449::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.36; Tue, 19 Dec
 2023 14:54:25 +0000
Received: from AM9PR04MB8954.eurprd04.prod.outlook.com
 ([fe80::d618:e9c8:189a:892c]) by AM9PR04MB8954.eurprd04.prod.outlook.com
 ([fe80::d618:e9c8:189a:892c%6]) with mapi id 15.20.7091.034; Tue, 19 Dec 2023
 14:54:25 +0000
From: "Radu Pirea (NXP OSS)" <radu-nicolae.pirea@oss.nxp.com>
To: sd@queasysnail.net,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	andrew@lunn.ch,
	hkallweit1@gmail.com,
	linux@armlinux.org.uk,
	richardcochran@gmail.com
Cc: linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	sebastian.tobuschat@oss.nxp.com,
	andrei.botila@oss.nxp.com,
	"Radu Pirea (NXP OSS)" <radu-nicolae.pirea@oss.nxp.com>
Subject: [PATCH net-next v9 3/9] net: macsec: move sci_to_cpu to macsec header
Date: Tue, 19 Dec 2023 16:53:27 +0200
Message-Id: <20231219145333.240323-4-radu-nicolae.pirea@oss.nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231219145333.240323-1-radu-nicolae.pirea@oss.nxp.com>
References: <20231219145333.240323-1-radu-nicolae.pirea@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM0PR01CA0104.eurprd01.prod.exchangelabs.com
 (2603:10a6:208:10e::45) To AM9PR04MB8954.eurprd04.prod.outlook.com
 (2603:10a6:20b:409::7)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR04MB8954:EE_|AS8PR04MB9142:EE_
X-MS-Office365-Filtering-Correlation-Id: bb6c9fbc-2f9a-4efe-a5d2-08dc00a264d3
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	h5U8OVtqOiUhx2UTGOILcUKmnnZGh4CmVO4/79wqHZXjsis81lt/3vZN1efCWF32l/rgPSMK6xxWlpa3WIirYOyadYIyXYpracFcMxxZFoib8EazVWTy32FJnc9gXO5aY763pdul1whjllJPRj0Cvt6z45Ll28NnBVfzvX//2e2FYRwf4O2fpn4GOlOb+aQ8m90tkylr74GICYjSkMTCUVWKloSbo00Bafzj9OiGDaNOMV86lu3ABw5JD3JHUJT9W9yD2atwBkE6xOSPxe5TYdAox9vH2+cwYuim4EbhOuxx6g8a4EC+pkXHewHD2octYmOc7P6dX1Wpb3ywFnOq76K40m0KdIOv0jX109CAnuyAsVSsVBFx2zrI29a4qFYCXUhJIoroZGQzGilwzeFMU2iUL4nTmwxlRYiCVb+hkmLkQK5mMsFBngBJvKHlCqh2T0eio2zxDzBMUHTRjzyTJWYj8wmnHZ4aNtSWF1+uFFtbmjMCrIrUx6XsPsBjFcVfqpmASrqyEL5YdkvKebM7+KNi3WHidKMQ3AQln98YVh5FN3qsLBvTNgn3XrOfowjWxMC2fpJwvOiwLtryfxmBg0tuiqi3Wa756d4YvQZixdtKQrM0O0jLNrauafgIdBGK
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8954.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(366004)(376002)(346002)(136003)(396003)(230922051799003)(1800799012)(451199024)(186009)(64100799003)(26005)(52116002)(2616005)(1076003)(38100700002)(83380400001)(66946007)(316002)(7416002)(5660300002)(41300700001)(8936002)(478600001)(2906002)(66476007)(6486002)(66556008)(6506007)(6512007)(4326008)(8676002)(86362001)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?nPAIzSpGRte5LTfkLOWAqP9YVNakj3ZMox5X61IBj3YQvuI/zxgI5vUm+vgP?=
 =?us-ascii?Q?whnvSk+js2Jgw0SSgV1eiFz2pGfshFdOUasoT/BRTjVMSGCwnjzaRkcRFBPp?=
 =?us-ascii?Q?0uIgCJxygX2EL8q3oGq7D0Qwgh0LDaUbSYJmS+tDaDGmOHD+zMhXKZOnrc3+?=
 =?us-ascii?Q?vJ3b+YIOmEoGphDNYrWuAXOSx/8QQbZkpuvVb5Yg9xSI2d7GTg9VEQAd+JtH?=
 =?us-ascii?Q?JK+KZbW9z9n27dPcNazZ3MA58m8XGO5Y9Y84TCw4/PHgKZdhTiofbJlr4Ijd?=
 =?us-ascii?Q?UsvINjCIAiuLlNjGGlx7843Ml9O5yn9rhEhEErZocS4GXAP3WyXPGBAU+2P4?=
 =?us-ascii?Q?ggKLprVQLVb5VOyKegnr15lwMpZ8pNffCC51VaIsc678j2zLpKCpt8eooZVL?=
 =?us-ascii?Q?KWFk70GutD/pdKnTgz5U0A4VJxBXyo+gc3fU48JXk7toWTs2pOOYjZzRkXN5?=
 =?us-ascii?Q?weBzNZA40J3LMse4+W0vBHKFQ0m9XnJJXmsEGQnZhiXHzS2fB3ovKht02hXN?=
 =?us-ascii?Q?qbiOijg60/KFHaIDutJV6BdqQBSxSCJV5pXZVQgQMFLj1iqO9ue76QH0HJ8y?=
 =?us-ascii?Q?OQMKYceTZpCsgGjQ7cpoL9Xn+9jpO07eyS5zBZ09Isd6BYFj921Ngexdk+PN?=
 =?us-ascii?Q?ikBrzZPTE4VV/kGdBPU/SNGm+U8ZLaeqygVs6IUE0CuAyMZarVTQk08KVuTf?=
 =?us-ascii?Q?KOupH+Hj8sMnTdQY+IiGM1GAySaG3QS0OuVybxUKLV4PbBUTSUFkHtM5QYVi?=
 =?us-ascii?Q?ca/eOQqFYLucsn3wrxdf3MiDAxkDkbH5YQWgOa5jGLy3HE1vwmmrJeAXNWmA?=
 =?us-ascii?Q?KtsJ7gbaiWK3LM9GRHIT8b9P364TrE5lMOf/n1EkUgmzCFDJYxe4gMcvyApz?=
 =?us-ascii?Q?tutDLZjrMCCrWZzH9f2V7M/pjbYfeadUfslea2ArJbMoTx97b176ny5NSQLB?=
 =?us-ascii?Q?NqEQ17lW5HO1qLe3Xt9/vhWerrBNuZ+akAdylKeWbUFoE7TAXmxinyC4dx9u?=
 =?us-ascii?Q?+UtKwFpB5EcG9h5evEI5u4O+AOgh/QfiLrg5t92OcPWC+iGiAAN48STGWdhu?=
 =?us-ascii?Q?gc8zLOuSnANenKZ6dfUM9wi2OruIFuZeSQt5mn8vPnnnqdPPtRb6y7g4lgez?=
 =?us-ascii?Q?ZB8o2JvFAdjha+HnNmDLNGujdJJBrhDzewF2MeeuMJDHFQ3rIYwm55f4LuP1?=
 =?us-ascii?Q?v/i/WCCO/ze9UKVObQoa9x0/fPqaO1hApqRrWrp6loq7qfn/Tx8eg9sdY1xK?=
 =?us-ascii?Q?yh7toT6tLMV8nUuFwmyHmvHKyKS+xBrRrYQEAl4pNEhW8BziFiGeo+e0flIb?=
 =?us-ascii?Q?c9h58CHt1OkQW+LLKuxrE7Urh8RC2Gc3mTN8zgOwZ0SBWf3OyilI57/ekdh3?=
 =?us-ascii?Q?y3aLt+pMRllAQHfpcvnt3jBSNKCs9C4RO2vmdxNrvswsWujBlz/1wdw+ULL+?=
 =?us-ascii?Q?6yJRvjJUZNCSvzHvio1Ey3fj1be3cACZVhFTtom4eZJnyjRxZUpiZcfADBHv?=
 =?us-ascii?Q?Nn/rHCpxEsWw/ENyyOGT85CKoV/TK7SJ7zLyyMrESMRoIn7wH2BDE5eat32l?=
 =?us-ascii?Q?ajcupVIbdIt3u8IAINk1F88m75fAayDhQ7tx8JDDffxF+rpZV5M/+X5FZw9W?=
 =?us-ascii?Q?Hw=3D=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bb6c9fbc-2f9a-4efe-a5d2-08dc00a264d3
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8954.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Dec 2023 14:54:25.8168
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: H82XZRiLjymWryvkaRzI2JdwF0fotXNHL1E4BQYPeVMmF1WQyYtO9NvK3QXeuDGjf8PDSyk65LknAkuu+V7AlPqV3fpEF6fBuvUTOAIo+kE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB9142

Move sci_to_cpu to the MACsec header to use it in drivers.

Signed-off-by: Radu Pirea (NXP OSS) <radu-nicolae.pirea@oss.nxp.com>
---
Changes in v4-v9:
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
index ebf9bc54036a..a5665e9623f2 100644
--- a/include/net/macsec.h
+++ b/include/net/macsec.h
@@ -325,4 +325,9 @@ static inline void *macsec_netdev_priv(const struct net_device *dev)
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


