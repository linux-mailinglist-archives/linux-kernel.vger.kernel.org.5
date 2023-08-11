Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F1808779335
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Aug 2023 17:33:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235419AbjHKPdw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Aug 2023 11:33:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236611AbjHKPdr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Aug 2023 11:33:47 -0400
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2052.outbound.protection.outlook.com [40.107.8.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74E1918B;
        Fri, 11 Aug 2023 08:33:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZvhijqLxK1KhMbh7r6FMlaajJvtvEXWxrRcjqAtZtb5wOFUY04GVkWQNKCNG3mcB6KzXn19Rc2D++TXqB3NwvI5zNUZn7wTlyvCYx9KdDdtEBB+XHF3fBao8gkuGvdmm25l77blUZz6RCvd5WQAI7ydRB4nXb7k+VpDMmnDbVVAGceKNXHptQwm28d2I4nBfbQ4uxc4ifWeOnt97S7tWXw+oUiHO3/GdLXyuoaMfEFTevjG6tauvhnFH2nDlC+5YfD7JdLk/p8GEt/mbIrS9NmATsCIEEMGBy0cz7Y/umCDN183iJMZL34wRM32iDNa8t/DJ7S99LmG98b2rs6hJSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RYa2xM4TxeSkKtX5adKGa2y8nKbY2M5gzlQqxqnhoX0=;
 b=XB5YfLzh2ZFOlq3OmBizADAWu9Meyi+0Zt9n95nI/T//dWNACD+LH9PVUUSdwxmP2X1Mf9xDxe3NACfQdL1pAsbV0z4Smd8YecZNjDFRyiN4SSa2zMwI4XcsCmKJjnnHaxFsM9aBZjBjra1RqrTBdO7ObxDZAcyfRIkWhjZaplHJg1PJjVD4a/RnQjLh3uEuHMj5qCO9/eSwgQiNU/AP9wtFQxfT4nNpBK6HaeTpwa7bKsoIDcZlllukQkLo9KB/QpoojshguH944IwEBTMU/48tuDHLmn8yYqQUdBVF5c66MM8TNt0+s2r7ut7vYi8vkZwgPDWo1OaSukKermtkCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RYa2xM4TxeSkKtX5adKGa2y8nKbY2M5gzlQqxqnhoX0=;
 b=VAbC1g9dcb/FFMpR0TNMFh9ezfmhTeQ9AHTgjDZn/schcK9nDkCX2wSbPz6ZY5dol9A/dpQnCsTTy50v+nyK6J+iWK88prF0cSh6RUy9/EpfAVhKLdJjRZup8voB/BNzem/sT+vTqyXFk9Es3INk8O2USmepKdHIi8br99UBbBo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from AM9PR04MB8954.eurprd04.prod.outlook.com (2603:10a6:20b:409::7)
 by PR3PR04MB7338.eurprd04.prod.outlook.com (2603:10a6:102:80::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.30; Fri, 11 Aug
 2023 15:33:44 +0000
Received: from AM9PR04MB8954.eurprd04.prod.outlook.com
 ([fe80::2545:6d13:5905:bf50]) by AM9PR04MB8954.eurprd04.prod.outlook.com
 ([fe80::2545:6d13:5905:bf50%4]) with mapi id 15.20.6652.029; Fri, 11 Aug 2023
 15:33:44 +0000
From:   "Radu Pirea (NXP OSS)" <radu-nicolae.pirea@oss.nxp.com>
To:     andrew@lunn.ch, hkallweit1@gmail.com, linux@armlinux.org.uk,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, richardcochran@gmail.com, sd@queasysnail.net
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Radu Pirea (NXP OSS)" <radu-nicolae.pirea@oss.nxp.com>
Subject: [RFC net-next v1 2/5] net: phy: remove MACSEC guard
Date:   Fri, 11 Aug 2023 18:32:46 +0300
Message-Id: <20230811153249.283984-3-radu-nicolae.pirea@oss.nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230811153249.283984-1-radu-nicolae.pirea@oss.nxp.com>
References: <20230811153249.283984-1-radu-nicolae.pirea@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM8P190CA0006.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:20b:219::11) To AM9PR04MB8954.eurprd04.prod.outlook.com
 (2603:10a6:20b:409::7)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR04MB8954:EE_|PR3PR04MB7338:EE_
X-MS-Office365-Filtering-Correlation-Id: 4fffd171-6f10-4bce-68c4-08db9a805914
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: UCt8dSDY3YBxeAe+MiXWyRVMC10RRVDClnFa+0E+K7fCrOU9dJmDdiAuJBzEhBVAt8xuUpKuM1WxV0MV3fbmm1nAY3S3lJvxJmtUSYPZnyn20DpykOWz6RSLVZwivlMXk+tA5jsSZ61sip51jwFR3whrJSXDxpnBSTT6UVeL3D7fS9z0nTYHsMORUSG27+ez8+Q0tD8lAnjR4AipHjrBFLqynjHNq/CBYhvU8qct3iEMQMNHfpzaj9k7/fjPESXsoxgwKQxcJy1qXNwhm1ZXgbPoX6YujNFuZHVej3iKVQ+nT6vj2pAvOPRYWJG67GpAIpELmp40pwHxFgqwLpU9pvdwwkPCqiUZalEtPvCI9i16dvuQBhHsw0OVjVpQKvp1cBEfGTZ+lSyIo/i6xSgNWqSBfkO7H7D5wxHmiAgp7PqMBy6zCI/OL4j7+A58kteuQkCJKlZ7c5rvvH7PvKXCi0ragtfWpcx0FOr9tBM+aqUiKwPlc10GR5tEc6fJaCdSVhdKv/UB12eCd45kcCyhJne4BA144zM4jZFRGvOrJryvAl4nDdhVMVsiLFxkCNESY3wj2xR/a1UlugdcYu4oPfbhyi/Styw3KInRnQ9odbcQVwtHytpTHLmnIBtQHrtf
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8954.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(136003)(39860400002)(366004)(396003)(346002)(186006)(451199021)(1800799006)(2906002)(6486002)(52116002)(38100700002)(2616005)(83380400001)(6512007)(26005)(1076003)(38350700002)(6506007)(478600001)(316002)(4326008)(66946007)(41300700001)(8676002)(8936002)(5660300002)(66556008)(4744005)(66476007)(7416002)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ePksBCJt5CjICNPRbq1O+YLo603HUdf08xpgiF0qjQUmtOEJ5V/MVlftKNV1?=
 =?us-ascii?Q?UP0QvPUsDXe89DU7uqAxmdDX2Z39z9DbsrNjuzkJs6ycTpgf0X7PWNPLwaKr?=
 =?us-ascii?Q?38UYkWSJXmnMiI5ARWrGAhhpQepTFC9VJkd6xcLKeuv9zz3YwyF4Dc7gPLA+?=
 =?us-ascii?Q?Qn+sE7MiAE51qpBNhTIOBDdsFVV3tbUp1QHeQZ+hQxOJNtjEt6scxcZwv/Am?=
 =?us-ascii?Q?CxhrtUrA/Dp8ikd2lme0V4n4v+ereo4hLUw+bJ5OzlLmy79LOYNzOks+wmWK?=
 =?us-ascii?Q?JmAnOcqTtMqIRKoaZLX9DzitpBwFxHmDIGyK5HqT1u7L5aAL+naaXPW56oqO?=
 =?us-ascii?Q?RrUsY4YppxDxBeAPfrCDdzRqOTWJ8fuGtCx/ijfi1PlcaUyMdTUYTTFpF8R/?=
 =?us-ascii?Q?Vhf9BLZ6YcShzmSd8GVE5adbXFt1UGhzUkdxaL6uP9/i6hQvV4WxMLgmSE1B?=
 =?us-ascii?Q?8nBfw7uZ0K2+cne+EpOJCncVoiECrcaZMsswrXXiE1Vclx+LWOgVxeETqCYA?=
 =?us-ascii?Q?VlDNkWMOGoFWDHsgczy4Y7L2x5n5e9hwx8aOiEvmHrYvPYVH5iMMGLKKNtv8?=
 =?us-ascii?Q?hEjp0YbqSEV/f1YGXcHzN/+sGM7/E150LV3N2KCH8PdLI0YFb14CQdVmdXQU?=
 =?us-ascii?Q?bj2wKKqe+9Gm76mWb1Mq5ti0LLEO16Zg8soaLa/Q4CW12RlYYsU71zBaoLcN?=
 =?us-ascii?Q?lgXjh23N6MZ5jdvnKW1CK38EU+dhgJt++3aBFd9CcoqLSS1MmWfoQM5ylql4?=
 =?us-ascii?Q?woTdmuP0EhDLO0F1CY37CadefoApESZQxmG42ELWsPWLwqKQ8EJRj3qKbe3n?=
 =?us-ascii?Q?hmQSbY4x2yEOcm6ZvvmqiczW2I3U9JDLt6McNXTjnsTRMMgYAAuDiM0lInZQ?=
 =?us-ascii?Q?OlPrTToY4w0rcvtRwmVC5ltV3o3nZvoxPEST/2cFQi/w7PNSz9mxlGopi1aO?=
 =?us-ascii?Q?i1TKiSgXv9EMW3C34UAF4oEX+BdpmLidKbcHLODkkAvjxwbySD7wOqz4YVJ8?=
 =?us-ascii?Q?fbQQVCGerox5iq1ad9kYToUiGJuFgcQ7LiwoWQbDodixli/XJ2qpykPkGY13?=
 =?us-ascii?Q?Dq+Z6r3RHhAI8015S3aW+7sdzLgQP6clK006fAcssbk2c63EwKLesYcRDRWU?=
 =?us-ascii?Q?vfU3ygnQvtQq+ld2a+UGx3NEvR7xdvMTTKiOYvWoJAY73WIEv1W2fztHppw6?=
 =?us-ascii?Q?q6OkrXXHxchWH5jHR1Ib7DibceqM1QvrP4979XRvszJ4XKXjs3tkPVFpybz0?=
 =?us-ascii?Q?dkrsD1zMUElxhMoWKFyKiey6VtBC1JOGEMDkLQQoLQxuGXcdFcdjUd6I6Bam?=
 =?us-ascii?Q?V9HGrr8Q7jyF2yekHtybyQJcnBOUZie4cpQJNSKTXE0W7FyW/XpbaPTyhwRn?=
 =?us-ascii?Q?30lduURPbToRnV7ZCXT3pmXiAwFgT+rRX/qrYP1HzW+tXRTALt3HhyLx+4ml?=
 =?us-ascii?Q?m0eqQLjJm3q5P0Tn0lCcwpJmdaUCbnNFu2GWjTg08tPOa4IkSsxp22WZnnFr?=
 =?us-ascii?Q?O2X/LiO8DJQ7broxdMIcsCknuTZFGwCFdxbud4Op44V7kB7+q5od4gKFVkPH?=
 =?us-ascii?Q?llyYshHMd3NNvy5BxC9y/+C4W1GfzethfrI2L9CGWyDOfLuirdqwjrPhZkDz?=
 =?us-ascii?Q?1A=3D=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4fffd171-6f10-4bce-68c4-08db9a805914
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8954.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Aug 2023 15:33:44.5893
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VJ5wYRLY8O1EppdmXEWrB9Jdc5ejGuCo2CRVK4RUwaoOWO90E25bocp1Qo9LDQzsldv5d6jWFxCy35XNwt7I5oGBKhHf/EyneekqVOySzbA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR04MB7338
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Allow the phy driver to build the MACSEC support even if
CONFIG_MACSEC=N.

Signed-off-by: Radu Pirea (NXP OSS) <radu-nicolae.pirea@oss.nxp.com>
---
 include/linux/phy.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/include/linux/phy.h b/include/linux/phy.h
index 3c1ceedd1b77..813a99449f77 100644
--- a/include/linux/phy.h
+++ b/include/linux/phy.h
@@ -753,10 +753,8 @@ struct phy_device {
 	void (*phy_link_change)(struct phy_device *phydev, bool up);
 	void (*adjust_link)(struct net_device *dev);
 
-#if IS_ENABLED(CONFIG_MACSEC)
 	/* MACsec management functions */
 	const struct macsec_ops *macsec_ops;
-#endif
 };
 
 /* Generic phy_device::dev_flags */
-- 
2.34.1

