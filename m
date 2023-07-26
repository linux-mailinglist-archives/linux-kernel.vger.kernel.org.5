Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE6FD76357C
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jul 2023 13:42:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234360AbjGZLmN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jul 2023 07:42:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234254AbjGZLlz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jul 2023 07:41:55 -0400
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2125.outbound.protection.outlook.com [40.107.255.125])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D90F26B8;
        Wed, 26 Jul 2023 04:41:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nLdpz1Wz36KR1epl+rGGc5l04shDmh49FGdwYeDC92CNmEVD5jIXrysopbhLTj3hvm2MLuup5NFhismTVUflADAN1ku7KYpJuzOeelvbOTbi8666ijLgtkUyuld/M/gbFKx68BqeNZe/fiEBtq4yTtzsgq1AhIslQFuD2K77nZlYAbnR+TISHgO9YQvFclz3bXObTF1nTEZkOYVsdSe69aXb5D0wWrzNrnON1aDX+uip2pWW4q2O8XqxzD/ANVNngMxxBlnykv7Bk/2BerkeIWDYmEynOQC7aueqmYw73DZNgSZJYBWSx/IX0G1oYhCk2j+jJkTvozT574YVBRK3IQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=J0uFL5XUt8ZImrKit8Hy+PaneKQiyRiLkdanJSVwsQU=;
 b=QX82j3ixJbNEKEFUCg2hTQK+PX2NF8PZWjhxl0+mYLT2uMM5NfeAzZZp3g7cy+ekRt9s+gwovKrG3JJCcHuhL44ZDen7s7JxamBJ9JBPddQn3ktKAoAyZCziL6LdsGuH3KDOHNZVm3keDAVznwdahOk4VOV2N+omIftg45sKu1lA1LECkA3tK8QI2B6LoVWQnCR+PEk042w9umLRZu2qNTUtMTPeLSKRtrsFPm7F6YtOwNn1A3/rvbeD2CXrg8y9+Xlgm09etH9LrK2QPKhohiG83v6pIurBXLGMkyySN/NZP29LfmYYTK6NEpnSkvxx3GZMt9bxm38kJPCnSqOBxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J0uFL5XUt8ZImrKit8Hy+PaneKQiyRiLkdanJSVwsQU=;
 b=cPf1eL2FUbopWfV2DE+6oQyTiYL9Jk6jYmkfL8Q+0fC2Yqlw1uKGthXHAdL0VYMabNrAOzoS72yduoUFRp7S2tLv0VjvdjFwjm7EO7Foeq5mtKfKnn9eWWIPH/CxvarcakfkMgqTQe/Ev+3tGtIGZOiLznDUUh6HT80/WZ1/9A9C3tyYlJjhHy5Emse7LLJWyKXo2Th03E2sljiRd6yohIgYVkGYM/oqJnV+4DSieTrfBODDFzIHK8cxUv+UE2Ysixd53/OFazIJrGyQ5NbGoP3/4JB6/2OJdU73ANcUP+XmnV0BrXF5xJ23NxQ6NRP47+NvgCEO8kdRnYHiqP1l4w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by SI2PR06MB4203.apcprd06.prod.outlook.com (2603:1096:4:e8::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6609.31; Wed, 26 Jul 2023 11:39:08 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::732f:ea1d:45a1:1e0b]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::732f:ea1d:45a1:1e0b%3]) with mapi id 15.20.6631.026; Wed, 26 Jul 2023
 11:39:07 +0000
From:   Yangtao Li <frank.li@vivo.com>
To:     Alan Stern <stern@rowland.harvard.edu>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Yangtao Li <frank.li@vivo.com>, linux-usb@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 27/30] usb: uhci-platform: Use devm_platform_get_and_ioremap_resource()
Date:   Wed, 26 Jul 2023 19:38:13 +0800
Message-Id: <20230726113816.888-27-frank.li@vivo.com>
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
X-MS-Office365-Filtering-Correlation-Id: cba60e26-4326-4dcf-c803-08db8dccec1e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6z9I9Yvza1x+mOfIBCqE7lPDkHRVi8Q54kLOsbFRpVop7l5cpzHduQE7UkPWz66mpYhpNzUfOEJ0S6XiXFTSyMNu2WaJwxXUkhIKy4M+XCiDbfd3Xk1A2S8DkwBRKYzj9DmxrtyCmVxl4/e/Gts1I19bQQlxpZvq3wDuEnftAUyA4MrUesxdzQSR1sYInJaoXshgOz8kfcAVnn55albJdcIuxwbzdmSMRQrVerI0kv7uqnPTHNtfJ6lWPPiOrmIZ4BnB6CNd2NB6yduBpfjYOF2j2mf3Ax0f9CKTAem6oKBPpMW8o88gbFbyKSL0hIFsmgMYNO6H/aeGa8izCkuFSY4d7zoMw5L/bjZVUfzGhSbq6+12bZ801gLpw59FxRNkRZocUa2/yPEZ+0PLazeyRMhcF15CxFZ85Mz4JYwDLO8rEa4T51/gjXsBfxxsybjUUE4qGhnNeHnyUCyAUHruoF0Q+oo2/k4fw7hld/PmxkysNzKylOk0YCN6t+9DiaZoowDjqMK/nAKZUqjSyMcpfH1ic3J08sI/B/O3tzG7MU78upTthxett6ul34Gtorr83n+K9a36V10q3r5czgIdi5NstzKVOKUFgbGSHgKlIuMIRhOUwYFwIE2McGZi1N5U
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(39860400002)(396003)(346002)(376002)(136003)(451199021)(86362001)(38100700002)(38350700002)(66556008)(478600001)(4326008)(316002)(110136005)(6512007)(8936002)(5660300002)(8676002)(6666004)(6486002)(2906002)(1076003)(186003)(52116002)(4744005)(26005)(6506007)(83380400001)(66946007)(41300700001)(36756003)(66476007)(2616005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?mQMJJjJedODhHKUG1jQpB23sa3mh20SGYo9hTB30SseneCDHmtID1RUl4Dpb?=
 =?us-ascii?Q?xhPXhzNFAwy1AaEXJDe+ZI6wkMGe5Oyxi+P1LEBnmZiaMKMGtnBsSx9bTZkm?=
 =?us-ascii?Q?CrfztrdAPWm13d6o9flYjUJs7nSiW0DD90+kdA+u2TPM/TkgEc3da3x1TVaN?=
 =?us-ascii?Q?V/4sw6mHuPfdciinD+TpXy3CfGKgCiqEqvhJeGlw3YdZ+yXPUhOc/RlGFmct?=
 =?us-ascii?Q?F8twxqwT6ymxIfWmuij5SsZphAlHJw1xbNPSRAsIrJQ0m/hZugATRt33a3cT?=
 =?us-ascii?Q?mMXtm0NID8BnotosZiOo3Mqplou+aDh0GvKQqqC5UIHnSqPjwigeP0+radGd?=
 =?us-ascii?Q?E5k/tMs+VMVfQzvvRNidzlDC+rXWvw9qkVBFLEXA9NyagqMEG4RmH9lqueYQ?=
 =?us-ascii?Q?NTCqmlrVuJe8keQnVRKSDahoXlh/o9Yc3cgrCSAfoiTmoSOz2/Af49dU9kb8?=
 =?us-ascii?Q?OiIS0EeVYqt8r7xRXwaKIdnX7QHzVIJNJbPIs33h9KJNW/fhbfRVv+l/Ko0a?=
 =?us-ascii?Q?nr4JkkTfZaR48Noyd0thI/cvF2Q8ptNTWvzg3GJQGofwYo865VjfGYvIec0e?=
 =?us-ascii?Q?Xs/MSoJS7pqttfSf3oS0a+1v8W/GgT98aQGZ4IU5gIf262+C65yNGxk5vXzU?=
 =?us-ascii?Q?/4DXZftB2CwtdJdHT3c3NRiHPZgnCV95y3cEg4ERouzF4qcfejygN+Fh5cDR?=
 =?us-ascii?Q?wcUNOSzbR+ZE37Wyjd/oDwKVjZDVwGnv2xKjaDmQoSeyyS9mb93xUczTAeoH?=
 =?us-ascii?Q?I2wdaiwVoZhdGRc8ToiKO3bFYBEM12mb0/uQE/+PcdW7cJx6vp/dsaaDpAM2?=
 =?us-ascii?Q?MaSGgjT3buLxFjLcmthlID+aQbeHGeiAcwIqO6AOb+A/MNXWfAdBJpnGVPxI?=
 =?us-ascii?Q?wgfyz4Q7o5RtgbY/ehW4136JHz999MLty1D2gn6579XUyahrFWZsoIu8T3Xr?=
 =?us-ascii?Q?xGLbkhhqLlJn+pqP9mGVqTK5cgcKFNYb2ClYp7ZJ8VyhjxbS9gcYPuWo5nw+?=
 =?us-ascii?Q?tib2EgCNOtabiu6V5cgFt5087IhBuNtWdhqGzQQ6hOXcs+2u/rLXjPzxzoBN?=
 =?us-ascii?Q?owD+HSn/ruzDoAIU8LDn3X11Fap0xrklOVovhQFp3rnRXrRNzjPKi+Ak8FQ/?=
 =?us-ascii?Q?rCHy3UywWwPZhTvHOmwGbO2/qyj3c8aFkKX7/2rnpdSKInHl7U1p5YUPxz7Y?=
 =?us-ascii?Q?hFsYxUijA1K7auZdm8QgqWZx+iEHtIbILgq4EbthYAWdmtK0FuGZnQUg+S32?=
 =?us-ascii?Q?RUsw+I/bxwFdUVifRKpfHm41a01z/CCMfzIix54sGlPmE86V1IzibEMXhlNF?=
 =?us-ascii?Q?6my7xv+FPEPruDvu99mv+V5kbTyAcCuIxZYO5PevwDpXsVE8smnCcTwcMBbr?=
 =?us-ascii?Q?dm5oxnZQN7T6KLfeoi4UhZUdfKg2FcjbLUy+hrpkC9miX806TDMGu99OG+vf?=
 =?us-ascii?Q?WdK/MRBUmWoYPIQRGqQ4GB7QJBsJvHM0/Lhvsh2+xyZAqQS0rt8QPwv77/LI?=
 =?us-ascii?Q?5OSuB7CyXMypeHfFLWYyoTrJofRB277BVZleHz6mWXoa4zQc5bdr1PzzQfTS?=
 =?us-ascii?Q?jbrAryD65pFVWcwYtxjdcbZPeIE0aPAT9C2fUpbK?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cba60e26-4326-4dcf-c803-08db8dccec1e
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jul 2023 11:39:07.9438
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Y7XSUccD5h4LHnq4dYEsY+jI9SNw2zsr0xUg44Ai9JRuUhLUkAOuMCI/5mI6S56xUQ+mOJ4HorUCuI/1kDqJIQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SI2PR06MB4203
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
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
 drivers/usb/host/uhci-platform.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/usb/host/uhci-platform.c b/drivers/usb/host/uhci-platform.c
index 71ca532fc086..3dec5dd3a0d5 100644
--- a/drivers/usb/host/uhci-platform.c
+++ b/drivers/usb/host/uhci-platform.c
@@ -91,8 +91,7 @@ static int uhci_hcd_platform_probe(struct platform_device *pdev)
 
 	uhci = hcd_to_uhci(hcd);
 
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	hcd->regs = devm_ioremap_resource(&pdev->dev, res);
+	hcd->regs = devm_platform_get_and_ioremap_resource(pdev, 0, &res);
 	if (IS_ERR(hcd->regs)) {
 		ret = PTR_ERR(hcd->regs);
 		goto err_rmr;
-- 
2.39.0

