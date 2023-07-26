Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58A36763576
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jul 2023 13:42:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234339AbjGZLmF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jul 2023 07:42:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233134AbjGZLlu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jul 2023 07:41:50 -0400
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2070b.outbound.protection.outlook.com [IPv6:2a01:111:f403:704b::70b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB6B91FFF;
        Wed, 26 Jul 2023 04:41:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fKh8hMgk/XznrW57hMzuwenAfBhfeBkjdynV+72yTsNVx9sFlKuf54wYd7LYQrivXkYEv6MPhzIHzNtirj08d8jGS2xX32ZjPiTFrmcctTgGhJj542wvQTwR4cszpntusBGh8Duaogy7zCUqAAZ3mMKfW9jmIXhoFio6zkkVs43+mIaoAjWRqr7YpopbID/w/xuVKZOXB0+R4tAvvGnDnj/ORMeSCKga32CjemJCV4/MpFjbNmjFgWFYnp/ktwhEoXR9ywEf1o7ECPTIJPkjAYrA2TuRt0oIfrfWNWdK1yGYhWR6+vFwPdhIeQ8as70N+HR931eqB8l4smumtmMXAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4AkmcOQNPKw/mcHPVfZKKDIU4rPREB5KZt5XcEEbxl8=;
 b=lIa8zHM/WP7TL/KZE6Lk4cJiYiatv2Yc65IxbjmGMR6YzfP2otlGhgHSiu8WY2R4llJtETMvqJu0lbJeuC8yWMQvkNPaslWRJeIliQI1qygMl046NvGmyDBcFEXqVAy518NmYS1zVdF4hVVGMwgFJQrA2aR5h6wSnIBMJRJm7KLBAcIjffSlKL/hc7DYsPBESoc2gHOiBU9jb0/eyqvsXAlQBGsZ1ktB73iiB/sUxyZ/JMDzU/Qofm6sz62QwYeMvnjt7sNty/A0o2PC8zptXgsjek0MkhTN5DBhFO+cgnp/wezBVTDd9r8KVKcLspKzQVyJBHW8Vv0vuqez8zqxPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4AkmcOQNPKw/mcHPVfZKKDIU4rPREB5KZt5XcEEbxl8=;
 b=gSeWR5TuEeQ0a7RCx4jZ4B05J0nIBBZGBsIS5RT8sJdfkZRwnoGrfwr2q1I+qkII0tFIuDrzdCwn0LlKcr4KkYXicpccUDv455enfForZ8JEfxWsElvR3dFtBqU0tPaWpZvUMMQla+cN9Qbw9Ey619L8OSLWn8IpT9yct2TLdoVfwCEtOMdn0v98HtkLypz9w/8/8xtGq1uMzu+Mguee61mmp74EMnnqU/NmbHNCj+qsQg7PQ9WjblITf1ziEOraPh7qWWeJZIWljSuEBq8FGFdIm/sFjA5Q52DnerXba9LifrnaWnEZHId2jvJF6iOL8D58VOXhhO6Abefiba+q/A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by SI2PR06MB4203.apcprd06.prod.outlook.com (2603:1096:4:e8::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6609.31; Wed, 26 Jul 2023 11:39:06 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::732f:ea1d:45a1:1e0b]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::732f:ea1d:45a1:1e0b%3]) with mapi id 15.20.6631.026; Wed, 26 Jul 2023
 11:39:06 +0000
From:   Yangtao Li <frank.li@vivo.com>
To:     Alan Stern <stern@rowland.harvard.edu>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Yangtao Li <frank.li@vivo.com>, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 26/30] usb: ehci-mv: Use devm_platform_get_and_ioremap_resource()
Date:   Wed, 26 Jul 2023 19:38:12 +0800
Message-Id: <20230726113816.888-26-frank.li@vivo.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230726113816.888-1-frank.li@vivo.com>
References: <20230726113816.888-1-frank.li@vivo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2P153CA0033.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:190::21) To SEZPR06MB5269.apcprd06.prod.outlook.com
 (2603:1096:101:78::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB5269:EE_|SI2PR06MB4203:EE_
X-MS-Office365-Filtering-Correlation-Id: 5f4cc424-7012-4f67-0633-08db8dcceb2e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Nw1MF8541F7idI93KYv71TZXP35gOi8Op1W84EVdsePdbR9ia0zZPxs/FiovLrknvosOpGw/407s5uU41vgQO0eCGq3MksFDYZQhNjgyeyFMIdIoJLgMYey606VRnImIt87gwTtfaUsIULarcWE3twjlvuLf008Ni+ETsTbs9oFAhyy3SPewo52VIL3EWr66THTD0klDM5A4tLMwnIXOwfinhg0k4c8vhgnG8ib8lKWMYHerYKpz0/sKW7bREzvc6rD0fiIQgkwUPnSSKTSiiG27II60ONQkcNS1TZYPnYFahFYzCE1n73SeWa3fAEB+2yLGJKAdb5b3+uxrl6S/3kL45KRDLH+5597GgjVPj7WLiQK/uCoo7lojjTfACjRN9f0ln7LEvMmA19i3eIhHMtm32JVDJQt7UT4fOC7mlsmODTblC2TL5Z9u+Ggr8vc6zi6BsfnOlHhH30NT25Qs4T+BZ3Hf+HZY0YWyrh8cOG7U3Yz6Aq9o0GsZvmntDiqvXmIIgaGyxLtmYP45Io5v8U6RxcSEL5/P5iOoSMsE6W/2yRQHe8lPb0OcmA3Vd61dxSDHEjIizEHiPzrvKr1Pi043jD4/BW+4iAum+73SbJrvQiEYBeIWk6vY9+1k2s1a
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(39860400002)(396003)(346002)(376002)(136003)(451199021)(86362001)(38100700002)(38350700002)(66556008)(478600001)(4326008)(316002)(110136005)(6512007)(8936002)(5660300002)(8676002)(6666004)(6486002)(2906002)(1076003)(186003)(52116002)(4744005)(26005)(6506007)(83380400001)(66946007)(41300700001)(36756003)(66476007)(2616005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?bm8YGnRSJ4fKYO/SGxB3q2P+lG5aC9aDMd8pkuLpCssixBCxzj9SO6It0mcf?=
 =?us-ascii?Q?ymIDmvxPuVZsoHQTvR6OovFJ4bGi6aJbyt6R36Nr20xoFzV2ITEAXyaeVPag?=
 =?us-ascii?Q?zqimdxERzdnc1gw8PSSQh9aw69yTDE2PjkOnSTzB4erxBXllgO1AY5zv0hlQ?=
 =?us-ascii?Q?Mhec3j0t46bnQdUXqA6cM4D3F3K6w5ohCMbOsgpbiaa8A6tjNVicwlAkQySq?=
 =?us-ascii?Q?dfm8wLDtqAFHKyvOOzisoLJNYju4TQib3IqCVJ5Zwjr0i9hL81SrwH+sgEV+?=
 =?us-ascii?Q?ENA/FQSR8xSISVsqL1QOkUHpdrcMixTNNCF9cuYmCXHy2jfOu4qJCAOLnxuh?=
 =?us-ascii?Q?vThy7/7JqMETTxd+vxzwQiGg85VWRyBhLkJ9YjPCwbZ2Pk3B42CkeUxfi0lI?=
 =?us-ascii?Q?0TBksND2Efda+hPIbzP9WmlaW5UZD/LPfYt//jhc/3vTGa5B/L1J/C/E4LGe?=
 =?us-ascii?Q?tegHof2QdLZbQchd3ZFxpQ5060vs16eobBF7AqfjKcjJJw6OLJjuNehuQ7pK?=
 =?us-ascii?Q?obMxrgJLZAIBe6I2d7eJKHPnQ7mbC0o3cJjXFAWvQ8XH4uOzKU22mX3tr7Dq?=
 =?us-ascii?Q?n6rjdnUI0Wo6rGmG+OHP7gCcr43GK8E5YL3v6A9Of6r821qx7bIn5uiw1WIK?=
 =?us-ascii?Q?qS7d6WDI2al2tHQFvamQ6LEeq4fU65iM5RE/PrFiLaZba+HMJjcm8+b25vgg?=
 =?us-ascii?Q?fHEUgq7W+KC52DHgk221nF1IOk0MsheIRlgTgmcwVbd3iuXFd934azs8cFDj?=
 =?us-ascii?Q?WXJsZIKjhI35NpAxa5K29qT8vu8yb7Lt34Ixxeq6PJUNDRi4f8yW3c+S9vX4?=
 =?us-ascii?Q?fy0bNayFylWr1g70ju1CKR+tI3HU266WXyS7DYmmSRVKoZxlRycIX+zftuh7?=
 =?us-ascii?Q?boxqV/wDWzNJJbgbkIs2xK1d8+oLqJVYe5JXlwobK/7gkgjWTpRSQAcMKCih?=
 =?us-ascii?Q?WzGlPB3706vn8Wfoq3UFchjd+6jI4UNerFTjdxGXrp5wju+XDXhCcFbZ2E20?=
 =?us-ascii?Q?pi8+lpTHfhK8c/Ithdi0WI+yMLZpj0F7tV/0XnL7e9E3lRnEFn6mdk7Wjnov?=
 =?us-ascii?Q?o9KNFtKSwMXM1Q5xncAyPyDsnb/4LVe3gAoaJ97+Bbq6DSelUTbhuiFOAksT?=
 =?us-ascii?Q?rAmA9PNupR0U04ODKBnEyN3eRuUvmqpeg1BxldDtEpI09AtuCKUvPgAR0Pvc?=
 =?us-ascii?Q?kIHVW+wqAmp3+Mj/pKjwR2y8JAfm3HeOLmdyyBwpGOG1sLMIO6ZovDbB8n7V?=
 =?us-ascii?Q?KHRO5Es5Dt/m9PvGogYRvqMLyfKYYonkBkM7E+DQ3WxeRjnlgDwbRB3SjXTX?=
 =?us-ascii?Q?BQvqnuAk9A3iYrc2ZZ65msLBYZIyZUyhtPBtPGLMfXd5QdD1cxSQbqvDbRzB?=
 =?us-ascii?Q?uajJNurGZ+Ar4pg8za1nCA3JsVwaP5d6CPOts+8avaOejxnGzLQ2LKycESP5?=
 =?us-ascii?Q?p5Ma8sf6PN100XVqLLdg4Vd3vsOLP6dMNYfDCmrpCt1L+6XVx9d8meAEUKDV?=
 =?us-ascii?Q?r8dn0qOXT3Ng3Rk4TatcXK31BDSpp2Equdpi/k+N95WcNCVI03Dacsipoerj?=
 =?us-ascii?Q?FApFqEUuwj9a77qoQnckUH46h3GQve/ckNvFiDAp?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5f4cc424-7012-4f67-0633-08db8dcceb2e
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jul 2023 11:39:06.3509
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FisU423//DOMZbU636ATJjFbXDpH9IBatF2h75p8hqCTp3BaaBEwUoIWajH6eJGsr1vrnl1xpF4WeTCvm8tv/g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SI2PR06MB4203
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert platform_get_resource(), devm_ioremap_resource() to a single
call to devm_platform_get_and_ioremap_resource(), as this is exactly
what this function does.

Signed-off-by: Yangtao Li <frank.li@vivo.com>
---
 drivers/usb/host/ehci-mv.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/usb/host/ehci-mv.c b/drivers/usb/host/ehci-mv.c
index 9320cf0e5bc7..2f1fc7eb8b72 100644
--- a/drivers/usb/host/ehci-mv.c
+++ b/drivers/usb/host/ehci-mv.c
@@ -142,8 +142,7 @@ static int mv_ehci_probe(struct platform_device *pdev)
 		goto err_put_hcd;
 	}
 
-	r = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	ehci_mv->base = devm_ioremap_resource(&pdev->dev, r);
+	ehci_mv->base = devm_platform_get_and_ioremap_resource(pdev, 0, &r);
 	if (IS_ERR(ehci_mv->base)) {
 		retval = PTR_ERR(ehci_mv->base);
 		goto err_put_hcd;
-- 
2.39.0

