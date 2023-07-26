Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 933F1763560
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jul 2023 13:41:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234280AbjGZLlg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jul 2023 07:41:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234171AbjGZLlW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jul 2023 07:41:22 -0400
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2070b.outbound.protection.outlook.com [IPv6:2a01:111:f403:704b::70b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FBBA3A86;
        Wed, 26 Jul 2023 04:40:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nh3sVxPUlb9BFMduxPs5IkBQiOTqocjuwrjzpkaB1727zSXBKxkBteNbC51zxMG4A/KBhLZ7wXnFxxPkbfhPVp0ucgR0tAv/+9zI1VpNXoOh0Zl2OEZk3JwCORz1HZoP5m04Gk6WO4yT6guMu8oXXFcJ6ru28I3P6gYHx4N18nHsJAS15gR1W84WVRgiTfXL/DDXJF3pjT3hiz6oad5sOE01c4mo9e/fyBnCmM2kh3bU1tAhuMoUHL0dkF+rJyCoqHWEHWPXenA1UQ6JJ6KJvxkj9hqBYm6hU18hxSrworN1+UtGBYGtPoTOUDZ+qbDp9C8Q4h9wZvXBms17tbhTBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LcG6i6r0FRHt9CMt0fmlfb2u81GeCT9OKloj93/aD10=;
 b=W418qm0yfB1c0kz6Z0cA6QsgBVuXz9xtgFMHZ4AoUREBx36phMLFIONszz4WOI4rFLRiYDQBBASZqSeTuQUhEb8uUx0kragf2Ptr0jvuXeQbcfODvXbzKg6urF3qjdr1ShH5l8rNYFvqvaachHH5ar89EVZR+lLarTAsOni0NsQ2CX62tYmWOU3sTr4bnBASAlg//7bK+btsHmOZalT4KgS65ZIMO58v/L35hG6mOXgkmdYaJB3e2OSCXkflZGKfN/wh9FjKKiTWMUVjHn7i35XVWtLIXwUPBOUZNAXw/z1XptcxrmspgtMuxcepYXKWjdRx5z2dE7TkjXYuJOBWMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LcG6i6r0FRHt9CMt0fmlfb2u81GeCT9OKloj93/aD10=;
 b=enlWFFabOL4RMLMgR1G+chrog2l8t1p7PPJjOMlXZLLx/GdVGl2krwrLJppltjkqlHJIBkbc66rpM9Yb+M8p1jH1RSAi3PsizXD3+9gjQDqRQlzL1zArCTVpjBtuZ/i4ghmKvBQK/1bAOccaGNnPb52lGq+/DnaHnemD8qUfQX+zWsX5DvY+a1DPB41BjC+GLOD4mLWI6rGHn+9YnkuBi3ypoVeaEwzipQcyiMgsfxQp5OO9F1ASCjGXAShP3FTpVY4uVGGWkDJJEiqx2wQVzsNS/n4nlFbrT+rGmm2UxGmrfulWi5RTSdaQ49ZeRSEnz05ZskkKMUSEyDkJmBFKaA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by SI2PR06MB4203.apcprd06.prod.outlook.com (2603:1096:4:e8::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6609.31; Wed, 26 Jul 2023 11:39:01 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::732f:ea1d:45a1:1e0b]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::732f:ea1d:45a1:1e0b%3]) with mapi id 15.20.6631.026; Wed, 26 Jul 2023
 11:39:01 +0000
From:   Yangtao Li <frank.li@vivo.com>
To:     Alan Stern <stern@rowland.harvard.edu>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Yangtao Li <frank.li@vivo.com>, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 23/30] usb: ohci-pxa27x: Use devm_platform_get_and_ioremap_resource()
Date:   Wed, 26 Jul 2023 19:38:09 +0800
Message-Id: <20230726113816.888-23-frank.li@vivo.com>
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
X-MS-Office365-Filtering-Correlation-Id: edd65ab7-7353-471c-857d-08db8dcce860
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: n7XIJlwVfEE/PVHmRlgDX4UV4dCFHrcIAy/A2vA34aGeyjAFZ5d98Ew95rWo7dM/BeZQ143iCWhdEaZwQR4X0ujFCz/Sb+6pkbyaTNr0WKkin67QY4R0+BluF3+0WV82WacBjKBPY00oai6j+AocsTTM7MCh6XnixaE7X5YFG3QzJYe6SSaVfx01mz5YRBMi338a+fO19q/0EtvfXbtysuV2Kp8lWjqhpl9RFUkFAeOwD806pdT9uSuDMQ1NGFknLOk7Tp0HDcj+0s9v2OmEZTpjm8fWqIm8HVHO7VVcjdYYYZ/jmqef3vd0itxA+cfk63g0hnJM5kp/vslgjqKwOncJDYDsPl6WylJ8hEAdfBH5W1pyhsqadZ12jnAQcu/WGwPV1rdwMsXGAfTqJnDN7XLiojgvvcinNbPeuUkGd+Ei56BnNmK6Tw7Xddbr8PQqACPyGi56+0IKC+Be5nyGhOoNx9vSDd93pFMgNBInH1cD42GrHJQMc+0h1/d8N8tTCDU3s4DT+rz6b6z5wRQiC5EgkjcwEdWj14/SDuHi7xrjSpvrHWcv4od89fO1Y1MjQQi7JN2WJEeT/m/N+WzTQFSbOI2vk27QwCo/p9S2Gv95JRdRBMZ4f7AdJNOJzMol
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(39860400002)(396003)(346002)(376002)(136003)(451199021)(86362001)(38100700002)(38350700002)(66556008)(478600001)(4326008)(316002)(110136005)(6512007)(8936002)(5660300002)(8676002)(6486002)(2906002)(1076003)(186003)(52116002)(4744005)(26005)(6506007)(83380400001)(66946007)(41300700001)(36756003)(66476007)(2616005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?5mZ312JP9AgAmli2cZGUhBYYhZZ5cLntBFN+bLA35INwbojeEBwQczjJRvKC?=
 =?us-ascii?Q?vQtUfVtycQXL+ys+DMqSbHvWowEzlTiGrmZtGRyS92OCH0FMEL6XOGCwyJRL?=
 =?us-ascii?Q?rjxjYDON1FXoTLBItcAMMSwPITl0VNjs7crpgr+fgTl9ONRCGdwxDxr1y7Ke?=
 =?us-ascii?Q?fN3JQ4rPQw2rU1TeQFL1o+ajS2X1DCagP5KwYFKPki2YxWLI8uf4NBQGzPKN?=
 =?us-ascii?Q?2coYxB8u1aAxd7S+yZrfx9J3WMywxzAaSz/ix7p8gEq7pjOBxtr0XDEcOTCs?=
 =?us-ascii?Q?0sPWl8/XTx6c7AGriUgH6je2Iaoc28sC0zc9jGU+9r6vNAuRSjSXpyrTmd47?=
 =?us-ascii?Q?fhKiAn2AWwzp/QiCF0LwpNyNn4p848v6nvqkeN9PwqBt8Pe3SIl7CezSDbdI?=
 =?us-ascii?Q?/x6fNHAMx6cRrs+tn/F53jkWtzdgK38T8IWKeEKhgeV2Fmgbbb2CwCpTlxz8?=
 =?us-ascii?Q?KiT+1c4F3p1vi8EnKGtXWXgR7qiFteOjUF50m6ZtQQ+lQrzo5UZRBfeV10JZ?=
 =?us-ascii?Q?A50wIr4N1PC/WJgQcUoq/MZ3GxpssX2zBKICKwLxgOTR+whpYqrzjIJUF4EN?=
 =?us-ascii?Q?ZEw01Scj56RoEgS9iveie2/MPzWat3czKP32gQe8T4RbiCKMAqul+BppAzlH?=
 =?us-ascii?Q?lZQUCEbnv7+fwdW+JjILb9lLeQXX+1sQxAduYd7NvAeO1GTvGsJ7HHVGSxk4?=
 =?us-ascii?Q?pgCCwwTuPhF+GrcicaJ7+m/Hv3zgKOoQVFSFvJ6RZxgzCSjISYenKATebgvZ?=
 =?us-ascii?Q?holE1r/RCpckBM9kqqJMLEaZYjEz8ckuQwFPIUzMcZ6EVXojvCnuk3wXRy9g?=
 =?us-ascii?Q?uzIBiUQtVP/qOMXz96VpLAJ1XLHIr3dfEekv8r6qFe//Dc0pkH5TFUvEHm7K?=
 =?us-ascii?Q?uVnSOf+hC3V2I8H6ax1hJaKGFDW98PfJcz4pXcnk021qiuzypTep+eEUkbiH?=
 =?us-ascii?Q?Zh0S5wmIvrrpcpYmy9R+Eq9wIASbBpOe0VAvgiwBU1OeKwvXPkgl1Ko1ijq2?=
 =?us-ascii?Q?JpRb2sd4Elrtr69F/leh0Qb4CKRcH6t2Hvwu3BuQdDXE0VG4mwx5mfOefHcK?=
 =?us-ascii?Q?/egs18j+jLtGJLiMdH5UXkPH72uLtraR725vbpHX0DlB+3gZ1MqsnPd9dUoz?=
 =?us-ascii?Q?1L9eo1+dCfhpgQUYgac+JGpjleaaqXmz9snTurjxOM4+C1fzknU0uOwne9od?=
 =?us-ascii?Q?gkYQVHJKm6QjC71Zo0ooVCGTDqJjVjye2SF7zf0+yW/59p3Oa2vn5TbxHC5L?=
 =?us-ascii?Q?jrP+VNkOsz1lESePGMrVMy9h+Es3bJt05WkuhsAyZgcGluazfImiAE1oT2BM?=
 =?us-ascii?Q?maZS7uyDdV1J1xCqEOlqEsVaYetwYzYyt4vv09hZiTClJfD3OSOKa6f2DXva?=
 =?us-ascii?Q?2oEnxmjeMru51XkGm2OLqDWJ04/f5thXdzgGvpUz9zLGIzqH3lpIMEFKA0OC?=
 =?us-ascii?Q?+HyXXk2nDia2pJPyHZKk0igg6nxVNj0mm+piYO66uu+5yoGdS8GZQVN35AxF?=
 =?us-ascii?Q?6Aa+J8QoMcQks3mRpqxpsZYxQb5o3ujrn0FkjqJFnbI0lH9RSX4a1FBPRTWv?=
 =?us-ascii?Q?HkFVEDxYMDTdw0C2aw72M/Bi6KvxQ0ifNIXesu7S?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: edd65ab7-7353-471c-857d-08db8dcce860
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jul 2023 11:39:01.6463
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WTSP/ZFOyk5GZ1+PDh1Ma83f1+d1NcNY1wWRvcHJMxQ42hzvmrZTZgXGuS3Q0+mrUHHOL7A4zszQ0iJNTdhJwQ==
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
 drivers/usb/host/ohci-pxa27x.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/usb/host/ohci-pxa27x.c b/drivers/usb/host/ohci-pxa27x.c
index 7410442f720f..357d9aee38a3 100644
--- a/drivers/usb/host/ohci-pxa27x.c
+++ b/drivers/usb/host/ohci-pxa27x.c
@@ -435,8 +435,7 @@ static int ohci_hcd_pxa27x_probe(struct platform_device *pdev)
 	if (!hcd)
 		return -ENOMEM;
 
-	r = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	hcd->regs = devm_ioremap_resource(&pdev->dev, r);
+	hcd->regs = devm_platform_get_and_ioremap_resource(pdev, 0, &r);
 	if (IS_ERR(hcd->regs)) {
 		retval = PTR_ERR(hcd->regs);
 		goto err;
-- 
2.39.0

