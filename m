Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 449A376354E
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jul 2023 13:40:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234286AbjGZLkT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jul 2023 07:40:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234102AbjGZLjz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jul 2023 07:39:55 -0400
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on20712.outbound.protection.outlook.com [IPv6:2a01:111:f400:feae::712])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6893269A;
        Wed, 26 Jul 2023 04:39:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UICNyaPCjg6bT81+KitPtFimR4i4lbQ7cZPqGbOKRysrPDJUW520L67U4yUr+9/J6HIxAkfgfdhP6nglzyR9Qia/hGPL1fHfwveLr3WkS0LQP8+Mf3kr7QMnsCA5s5rup0+VQ8IAI3+cLqLT/2WAnPpLCNiIFxqMD/714k2MpBxSFLjlxXu+khSQqdNqfyMIa6KDQOd/JQA333W69CNbil6cdB7ZHb3hUF48QCQ1GjgmbdOeoQZSyCHHW+Hkg6ORSKNGY3+MzT4J8GRyqLlfP2XPcnm2hjZGRPWMl36xXNBtr7k8GZDFE7EVwXe1Vh9v/bRWzA6oRjMJscgeccks+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=J4oauksdotFXSxZc5S0ZaxH/Wm29D13fTOskEePvOiA=;
 b=GAR4rgP+RNAXeajNzdAz+Aj1vl8a7b1dlvqSLEA+XahTU+C3wzyBLYUNcoratrw9G0VSP2cBCjhWKjOyU3CWgwsqeG0c2wrTMu1TNymfkks81+8uOFWKIEAL07EkEkC2kgeetMdYF1PiUHbzYSFmAq2eIxTZTsAwRF9sFPlHidIgAPwEouIsJwfDCmY/tftsiGB4qPuOv35SCAL71C4KRfxu5j+QBJUgpZDWjjK3kVuDgB6NkbgRoNR4PvmKrcDa3Z+NLfFIKyr8XYEQAL/2eRdE3gMNPC0Cj98qvkf8hv3IAbZE8YMYFDUgxtfFnrk0RH4qcDFeeC6yFzRmqZuVxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J4oauksdotFXSxZc5S0ZaxH/Wm29D13fTOskEePvOiA=;
 b=Lq5KeOptWpTY/RRdCB3pW0ZLeB98FyWZdV4xoo/vKkWldHl9eDuQn+9sDyupSZPZ1NRbZhvt3gR9W7NROSXyutQT0i99Rzt67Euh3CCnMUkZCHhRT5M+MyCAqVAyMEd6Ne4gVfj2SbyIicMkj1I04CbwcW2kywoHT8/7GhF1LpfJGRH1CYmpUDO18Zu9xQMChQ//a1pYM7SHo15pG2TCKF3hJuS7KnDlagsbmyIWQMqOkjFk7qJZZUepi9vGOVxcvzHFySRHaVl14tJHnTUVvCfrCfIl80mUVcO+HMUwdRghkfDF2R3UDF+4I23VNesg2gXqSap2wtdJ57RaqwNM4A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by SI2PR06MB4203.apcprd06.prod.outlook.com (2603:1096:4:e8::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6609.31; Wed, 26 Jul 2023 11:38:54 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::732f:ea1d:45a1:1e0b]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::732f:ea1d:45a1:1e0b%3]) with mapi id 15.20.6631.026; Wed, 26 Jul 2023
 11:38:54 +0000
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
Subject: [PATCH 18/30] usb: ehci-npcm7xx: Use devm_platform_get_and_ioremap_resource()
Date:   Wed, 26 Jul 2023 19:38:04 +0800
Message-Id: <20230726113816.888-18-frank.li@vivo.com>
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
X-MS-Office365-Filtering-Correlation-Id: 76385692-75d3-4991-b120-08db8dcce428
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: O4j8SEaswPAW6dvm3pS4oDYX79xfmkKvPcFPsegPMokNzFJCdF9v8Lq5OKb5mS3Py2uSXpFO5jnlvd9kvmRKg1lWZZdn9psQlZPT8BmEKdNGZ68kqpfHXEwYJ2AikhtXEnTadjVkJZ8Hyj0HsplXTs06AJwCgQI9ZKnb7Mj4D08LohsvFK6hrYVkAsM5grYH/D0xYAFV0lkDK1vXY3BONg8+q3m4pOG/wb0dN/I9nQ99Zf+iOVzITbyBjvHaRdshA4XqveBw7Ykf+GpSgt6b3BzLYGtVAiOronu4pUa0iy49qio6eYdJogBFy+ZXG9cbLPDy9uXPp4h2/MCr9VAU3AD8ww3OepO9+rxX2AvbhnlDcShhpEaVgQFqYEAHz/lvBF6KEq4Pz50BXit6DEUC9X+6DuQGqfhe3KdmvTLpLJHNzWxKOSXLcfCnkktOX5LMRp/AipJVksjdVYJIA4Ji7DYzw2hF7BHflEARFcNXZ4kLdPt8JcZz+efBye31pfMtbdSfQlbwxCRWkzcBO1lHo0534TOc7rrqFoqglyJ0VbdrzS0GL15GyuAsJkWQ7a7vI6+sw/DE/LEozNgKfE7KprAZ2s+3DeRILEaFXz+zk8m0zGEs2cPiu9pabtN60Wpn
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(39860400002)(396003)(346002)(376002)(136003)(451199021)(86362001)(38100700002)(38350700002)(66556008)(478600001)(4326008)(316002)(110136005)(6512007)(8936002)(5660300002)(8676002)(7416002)(6666004)(6486002)(2906002)(1076003)(186003)(52116002)(4744005)(26005)(6506007)(83380400001)(66946007)(41300700001)(36756003)(66476007)(2616005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?c1Fhl2a+ciwOpdhV/OyT/OQh9IpRX29xx6KrDP857kdMclanXmKOVUj/X+HE?=
 =?us-ascii?Q?19RV3KgaFqbpSP6MJv8OJHg5P6S6w4sYVyPx/Eq3+BCBScgUZpcP6u7ABOqc?=
 =?us-ascii?Q?nx2XnuArLeoBl9/J3IUYoBK+Ab1cgRPpyz/Rk2Reh/hk9puqcZ7a0N5DiBzX?=
 =?us-ascii?Q?KLOflP0RaiOGeOzzY7nA9+giYB5TtF3n3zm0pkaziPzAIbl9JaN3HXz0+8DR?=
 =?us-ascii?Q?1VQ9e7s5CX0f2rCX2O1ArM6WbJV/dEEppfW0hO1dMlRqDWKdKNpH81CCUH/4?=
 =?us-ascii?Q?oHx4XezpehtISG/9G7z0ArSBNdh9XmCG10txsHhfxOimrCvoUIARbhoPVM7s?=
 =?us-ascii?Q?ui4Q81R6TkV96ZJsskI6ytM1c2tCyfahGHW7VshhyGF5awvtSSJLaCYcZaHy?=
 =?us-ascii?Q?DMl+cy0WOegHuWzPy+BYMqvkkLXJqzuHhCG1RN2Nw92RYvSscQEJE/IaJ+hp?=
 =?us-ascii?Q?8AMP+2Ul7qlvfjUDGo0GOm5Bek9IZSVxzYYVcBxlb+n1jlUIJ3L2JsoO4zq7?=
 =?us-ascii?Q?tX+OfNRdwiLBhxt3YIM5SguNOimpvxm6vm4pBQ9HizUSqdGJJAuiFEMkcO+G?=
 =?us-ascii?Q?7RW3OXJtHvxSaz5+SYdzbleXWryu0jGnTRjsGBcaCgslE9DCOEUnVyGd98gZ?=
 =?us-ascii?Q?zKUxoS/y5QBGKZhkMPd+FcReFcNnC6Y+lW4zePpwjUr88LQKedLrvP1T2Y2o?=
 =?us-ascii?Q?D8TtbEQgCG50wmFt18QOTOHrf8JPx60D2SHkq+jZexupaA/AS118wJkT/Iy4?=
 =?us-ascii?Q?itLIK20zlQsRqdi5UBTFC4ztvzw2eCguCort5fJl8Whj7/jFeoJ9O+2XR63L?=
 =?us-ascii?Q?dwa93Oi1PPcKH3X/fxD8sJ5olp6S3iw8WGMjR5mSxarffbfTs73wyfo47NWa?=
 =?us-ascii?Q?CosiV5JLCtWeH14LWpCSyT8LYkOGUh3BbNOX0MAJ77KCzm+9g4T3CQT0fSb9?=
 =?us-ascii?Q?yz43OOns/OBdEKWicPOibPTV2aLGwybKhU9Rxz1Pd2wRIIMvrJoVv7y4wHiB?=
 =?us-ascii?Q?tQI8zg6khnzan/cnn04pd60ETMU3VRETGsF6v3mCIcksubLXvgnnaYrBztxB?=
 =?us-ascii?Q?x7EHFDCyQ6dmEdfbflyeALY1eolQG7d0S5rj1qW9whknb/78yWnku8QzY5ou?=
 =?us-ascii?Q?HxlZlh/yBmiF2rqZYXvigw2BFJDQDaNeGBl6rakbxTcw91Kt4IXv/OoHczxJ?=
 =?us-ascii?Q?ec78zm5o51ESSj50xQr2YbQyCOoERFy2KYB48Kq6syWrwfZSOedfsfnkUjVY?=
 =?us-ascii?Q?1wyvGVm0Gkw4qslh529lNb+aECwlCZM+EWk8UiHXY06i32O4x8uVpNR1vLDY?=
 =?us-ascii?Q?JcmPkOgR8iQ0T3WRpnRowxI2V3H7zBFvf9O+/kYT5GVGbO7xo8xozuVyVlcx?=
 =?us-ascii?Q?LgaLfWrTskTvx2f/aUEl1GHgsETfpBfcpnIzTnPnlUBqDaVIr46twwTqnSpW?=
 =?us-ascii?Q?Eym6QvH7VmJpN6JeZVORVeXtU/1JATFVXYPDbl9SNBO6M6jWfQ96Qr0/Jmov?=
 =?us-ascii?Q?ssABYcSYsNdOEIlZmJoRl+VAbVgdf0x/TIfIZb1JlC7UODOAkkJ5FStzuMxn?=
 =?us-ascii?Q?Itp+SSAHvAp05z6ht2TJEm6GeS7IM4syP9nuTuvE?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 76385692-75d3-4991-b120-08db8dcce428
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jul 2023 11:38:54.5747
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HzOnfQM1FqOUJ0G6QUjoNET4ZmnLEkghizQ2mWfCUHoLIFgnN951Wuu8NjBLzk/kAqNjDbZGc968+L+DTzFa4Q==
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
 drivers/usb/host/ehci-npcm7xx.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/usb/host/ehci-npcm7xx.c b/drivers/usb/host/ehci-npcm7xx.c
index 0b3b3bd689cf..3d3317a1a0b3 100644
--- a/drivers/usb/host/ehci-npcm7xx.c
+++ b/drivers/usb/host/ehci-npcm7xx.c
@@ -79,8 +79,7 @@ static int npcm7xx_ehci_hcd_drv_probe(struct platform_device *pdev)
 		goto fail;
 	}
 
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	hcd->regs = devm_ioremap_resource(&pdev->dev, res);
+	hcd->regs = devm_platform_get_and_ioremap_resource(pdev, 0, &res);
 	if (IS_ERR(hcd->regs)) {
 		retval = PTR_ERR(hcd->regs);
 		goto err_put_hcd;
-- 
2.39.0

