Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61267763535
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jul 2023 13:39:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234120AbjGZLi4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jul 2023 07:38:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234104AbjGZLio (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jul 2023 07:38:44 -0400
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2126.outbound.protection.outlook.com [40.107.215.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4652AA;
        Wed, 26 Jul 2023 04:38:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bBdjcfEW1snCx8me8+U3e57bkQwx/P2qMXqRNV+Y9FqdoCTdsL8ZgpcOKkDWB4fOPgXyY1eYcsvid0i6MRTPWdICWapV/iZh/yZ7rU9rQYTVTaAgimyIJ0WttgCHflt2cB0TKBjBV+rttz9UtdgDykGM3yEA3Nmj1w2xONyuBpvHIAQk+gIcoAFYfqA7uNwn0AT84NhWQnlN0v5bAAD5ELQZqmaDRsbZHLzj2Mb9FqD4rxGqM9HD09FoN0KPdsovbPys+y7CYqCsDps12KQ2ZEEd6iJSBwvOSQp2ATBihC+WeMmYkecFQhHuSCPlvfx0jZR5HYO9haDguDmAp/I5aQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=T0dsl2E/izh1uN6RWG69frHSuDanI0GtNcxWA0K8Ov0=;
 b=bBXUAen3SZHENNO3t0S5r97ElJ6vT9Bx+bQ3ydht3G48BP+rv3lBmc9jCtUaYn3e4zxj9D0D/Rbdl3bJ+QWchI5UXRVGrNddym6h2lOi1NFj7IDj2Lyzt1OwW5YSGux8mR0aGE+RsHd0ljOueOJsCZAn6UifXXRXXBpqy81Dm3SqTb5F0IKIgTtryEfiPQhQsBW+t68DFy7c13ge2VVB22O7wlrcgiLgPEcH+DsuZOZdIjN8xxe8dr1rJTz00GzujZBpH3DGlIcDuMjpc2n11Lnzcd/1jv2G/FZUjLdao0VTkMUbUtAW4x+NQokKQPwIxXPNgJpNMKwGscZTqAdgqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T0dsl2E/izh1uN6RWG69frHSuDanI0GtNcxWA0K8Ov0=;
 b=RtsXLhThw7RU4IV2iKnY5UUJR98azjWGKSiNf00gK6p1dKb3ULZqKAeizGKpU6ldMRv4QhTKwV2flPvNgGVMyRgjq3PW9jglvLHWZKlbvuu0jLySwqWgM5rr4IVHBVUSitghJ57Z4OacLWJjHKoc3vCJSivCtrssnFtQPekXLs4Hz2avoklUBikqcetvxcARwL7OEMjxYc9OsATEB50EweomJFt1KZLzGsUV/SfcESmnBiQUsRJEV6Mm8RQuUC75I2t8GdfBwM9+MM2dU4Ucn0ZdmL9w21QwiSpWnD5rhO9NrxxatLCjnAVEpissoPF2VoliLi+Ere3YLQKQuNyRVg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by KL1PR06MB6210.apcprd06.prod.outlook.com (2603:1096:820:d9::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.31; Wed, 26 Jul
 2023 11:38:27 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::732f:ea1d:45a1:1e0b]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::732f:ea1d:45a1:1e0b%3]) with mapi id 15.20.6631.026; Wed, 26 Jul 2023
 11:38:27 +0000
From:   Yangtao Li <frank.li@vivo.com>
To:     Avi Fishman <avifishman70@gmail.com>,
        Tomer Maimon <tmaimon77@gmail.com>,
        Tali Perry <tali.perry1@gmail.com>,
        Patrick Venture <venture@google.com>,
        Nancy Yuen <yuenn@google.com>,
        Benjamin Fair <benjaminfair@google.com>,
        Alan Stern <stern@rowland.harvard.edu>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Yangtao Li <frank.li@vivo.com>, openbmc@lists.ozlabs.org,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 01/30] usb: ehci-npcm7xx: fix typo in npcm7xx_ehci_hcd_drv_probe()
Date:   Wed, 26 Jul 2023 19:37:47 +0800
Message-Id: <20230726113816.888-1-frank.li@vivo.com>
X-Mailer: git-send-email 2.39.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2P153CA0033.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:190::21) To SEZPR06MB5269.apcprd06.prod.outlook.com
 (2603:1096:101:78::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB5269:EE_|KL1PR06MB6210:EE_
X-MS-Office365-Filtering-Correlation-Id: 4d274978-6f7e-4a9e-93d2-08db8dccd3a1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Uy15++iRILH3+7GEjlkJajjQYpmK7Cc16fD6pK0DYPjAWJ8gsguGVeWvf1S1/J+XtLn+vEgl/NLluBLzBlOt6CCtdcj5w/dX/mec7A8QmZoDNdIsuwhU0feJi/qU3DHzJF7kA8XXtXtDYiECC39i7gsrQpcoqYKJKCJIrUPtUHqEp02w3DA5ZIHZp1mFWhENQj3+fHPpBCWcBi67YsuI4ugB+S5+CKJzjCA1K06i7+mWpfzVFiO/FrFYLIGxO6A6bAXqsv62i53g72WJlu0yGmQ6CMVFoD4XJVXGy3URpE/qEEEUc9AL3T7f3WqpHPPz9RozyT8GSWS2cPlFS4AYrKyrIiDGwsWm7l1b1OG9nr8BB5ty1S8qkGtqWUk1crIxpazR/BnEBauVO+KSXNzHR3pPw9lkIWczSqB/bevCXts6kmSy4hYs4TJ45ugzVWUZoV9XGuArTrQ54+xFEjg+qo0gcOiqsTVOhMFma51wdsBGpPwfhCx0+B4qLMlCWC6FlA8IycmWhaPs9M1qikjGNPy6IhEGbiDWbX8OJQ27Qfv0ge+x/Lek+LP7+5wtYOmvmv39F/liLlYdOehD0ZCMi5MuW2+lDsb1+9n/AnrXbI2lXE76UtSdk5FL6XTzfKyO
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(346002)(366004)(376002)(136003)(39860400002)(451199021)(6506007)(7416002)(8676002)(5660300002)(8936002)(41300700001)(316002)(4744005)(478600001)(52116002)(110136005)(2906002)(6666004)(6486002)(186003)(1076003)(6512007)(26005)(2616005)(66556008)(4326008)(66476007)(66946007)(38100700002)(83380400001)(38350700002)(36756003)(86362001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?GBh1n2jWKJFi1Cb4TwVMz9meBQiKRfFY+A4mbrsgYXTp1Ul2k+XH3dGDrjVZ?=
 =?us-ascii?Q?aORWnb+ubTlRGz0USOLKUQDc6oj6wyQT98t572JWNrCG354dIFdPb+wwzgXw?=
 =?us-ascii?Q?J9sSf1u1HJQlRisK96S8SjXYLCyYuQ7RrXXBezEKBReSo4qNsEuMJIhkdmag?=
 =?us-ascii?Q?TN/NZNZmJhtUx3zAvx1nbeU9ZopcKNQAHmTKUxqNoSDMjAfQBccieSqWLNMX?=
 =?us-ascii?Q?bgBtZC77QyORqK/qpzWeEu4WUqPGnymLO9FPRfR0Rbpqz8zNwu70TZCmBCTB?=
 =?us-ascii?Q?Bn9YV2Qf+PViWdb3SDVXLSbs1LY3YaQ+Mjvs54iEUsi//rNxPMADXFJFVDWW?=
 =?us-ascii?Q?thYptjpwHjP7n16yuWy7L4w+qbElNtaDBkM6FW0ipDBCjXttvj3NqPeq5oZ2?=
 =?us-ascii?Q?b7peES5AjoHgRgxsiV15PH4B1hmAetz9JKsli1XmUATKdxRbIvbxFRcydlGR?=
 =?us-ascii?Q?5YVNF0TTTw4XCdDefgYqrrxigvPRN6qzm4d4469kYI2cd1SI6DBwmzLdi8bh?=
 =?us-ascii?Q?+E4+PdYgXCGr9rhiw8J4Yg8dqfdovKxKx4kkRDjnifJtKOjPd9YZehpxoMmp?=
 =?us-ascii?Q?dt9fWTkcCbfoQRoMHy0aAzshsi3kzqn9R9ht2eefRORFaLGJQ4+QVAnAGa+0?=
 =?us-ascii?Q?wy5Ogd6Ql6lH367mJAT7Cc+O7na1eb22ACBS6KmpK8beQY5UBbB6Q80l5K9p?=
 =?us-ascii?Q?/5+5iF96F0GMfkt5PGUBzdn09k5ymiBfsgn1jwrG74vq2I1flRIGi6hfI5iv?=
 =?us-ascii?Q?Hn42utF85ittB7tiomx+DzXKF9m83IO30s/B0CPnn+tPw3M+Dl6VjdukIOv7?=
 =?us-ascii?Q?Puyaco/4ZyNqfDi6inxrEDKgkszUHpoZsvBlIGLiVFp9kfTerQhcOtTBXaq0?=
 =?us-ascii?Q?UiEk/qywQO/8C3qOcS+I9iX3BfofJS6jn9FT/TpTg4pr7xays2CXFqSAWbey?=
 =?us-ascii?Q?o/AWJiulLWdnGkkQksAm99hu8Hik0oDkLels8WMF6yu6ewAoIij27XkMMJ5q?=
 =?us-ascii?Q?H6/m4r8bPhChgCXq+sLRymx6gIpGymtJjIE+dLuuqLX5DxnAXcYoI7YIy+iM?=
 =?us-ascii?Q?Y2kSMD0LQeELY0fWDxq0RQ2F5O7gBAvoARvPj76FOmsCc2jt6edchvyfWYWR?=
 =?us-ascii?Q?+TIExIQyHxNPP0uDDSyooMFTkCHGNZ//WrXAv7LIjRH8vbHjBPliR3T3foFT?=
 =?us-ascii?Q?Ehgdz9Nt8aU45JSNtWXRfMEEzwXitbT41CrlBd1Dn3hUVd9FwiHidxbEa1/X?=
 =?us-ascii?Q?bCvnF0fup+Y6OIohJZgvL5qER6mQi4mYfrDh90rzXLxpUC02n6dg/sL3u6Aa?=
 =?us-ascii?Q?/b87uqr+4lmbj8l3ApdKN96cJSDEmcIGu3wHDrv0cCiGCZBkIGwQakzUiWNL?=
 =?us-ascii?Q?JHUXoq33+pzjvy42uSbLZ/NcacBjH0zgJnJboTw/lDePh+Gt/w2L62QN4WHr?=
 =?us-ascii?Q?t/yEd5HLOJla9+h6Qv+wDBa5zDC0ReuJbntCPQp8oCe+E3tuuHq//P2ZkhVl?=
 =?us-ascii?Q?4wfTLp8Fl+2BWQrB/jBB+86L7X2mYKl11bu+DY50sEPqH7NQVT3QfWGtPCds?=
 =?us-ascii?Q?tegQFbW0SBPWBiTHNtZj8aeyoaBR9eHiviRt4tw/?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d274978-6f7e-4a9e-93d2-08db8dccd3a1
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jul 2023 11:38:26.9107
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: P33udgjRDjO14E2Ad6eGh/l5rUpXWOrnC2Y59B0scyXhUysBPvHBbN3kiIJY962Ft8RKnVEj70fIySrGqniNkQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR06MB6210
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replace tab with space.

Signed-off-by: Yangtao Li <frank.li@vivo.com>
---
 drivers/usb/host/ehci-npcm7xx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/usb/host/ehci-npcm7xx.c b/drivers/usb/host/ehci-npcm7xx.c
index ad79ce63afcf..0b3b3bd689cf 100644
--- a/drivers/usb/host/ehci-npcm7xx.c
+++ b/drivers/usb/host/ehci-npcm7xx.c
@@ -53,7 +53,7 @@ static int npcm7xx_ehci_hcd_drv_probe(struct platform_device *pdev)
 	int irq;
 	int retval;
 
-	dev_dbg(&pdev->dev,	"initializing npcm7xx ehci USB Controller\n");
+	dev_dbg(&pdev->dev, "initializing npcm7xx ehci USB Controller\n");
 
 	if (usb_disabled())
 		return -ENODEV;
-- 
2.39.0

