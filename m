Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E81E7635A4
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jul 2023 13:52:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232789AbjGZLwZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jul 2023 07:52:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232435AbjGZLwY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jul 2023 07:52:24 -0400
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2124.outbound.protection.outlook.com [40.107.255.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB897E7;
        Wed, 26 Jul 2023 04:52:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mVTNfskbXGbeo+jrwAOM3aNL7xe2WJxP4wBP33zVYYCrKF6X7SrGPJ7K8eXmUfn/JwaNLKoFNsjNgO0EreI0rCRVUA7jfb1M+6n7UcvfT/0pnOZr4YbYQQnyA4lZ+FBIzILRwtpqn2DmKHHTy0Z4R6+BCA85+5JH3VYZJWHtfcApua2fOjIQm2Rg7UAR9NO9gxroOi9k8xnr6nKiMEhwjyAzwDziqDLF/Se8fkg/4a2QisAgnLR7ePMztK5keJGVAbPtO3Kk3JGaUwP1hYrolyuCJfmuOqPLTg6M6iAG3Pfua+vWmZDDXLGEl6eFgUphksMUOsxHpf6alhsoE1NH5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gPIfR+C/5OvNI7ixKpo7QSJI2PTeA+Ef3zQfAccD1YI=;
 b=OpfNN7HdNEhUgEuWV/9cI3bzyBlu3E4sFrwAG95zZAgBO8yRpHv2UrvAs2Ro1Zv6+QIJ0Ddx7I6ROITPRnVXC918z4ruW3Rj1PaJJ22jMCY5R+mZpp3IdIukftRl2DdXgIS+qV3tUrOgqT638NRUnookmjhemmnVvz1GNCUE7dZztqV7RijcAtB67pmKB7Zk4A/kmfNKUkz1YE95CRoLnlLq0rNuLPHBgH2BgYdbEc4YOi5mvAhoc5Bu1puaQSDX8VN7OI36NWQLczC9GUEg4i1zZLdArMPUsrl/wXlZml+89Y0qGQa6cfpEqbgbSC/FuwHq9YrDgoWtFbFiDHZm8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gPIfR+C/5OvNI7ixKpo7QSJI2PTeA+Ef3zQfAccD1YI=;
 b=KGUEhQoWVi/EmeXtqDEPosth7Dp8XoH1q5hVjL2eV+J6TPAS1mhPLKbzjqcyFoOGgB0faF6QmtdSrMOPy66xtZKYyIXGJd1zFvpXkRuBqhbrDtPOW2ObA6VMuu7AOHec5dkSPefX3nTAlGU1ynrBbalaPRWlX5bHTxPfiYGkaHmiW2A924psoTqOUkfuE2qQUGeRmpeO85nmPYKeS0lgpNh3UEr8pBonnBAx1T2MykG9akVFnjV+vJ/xvHp7m8ld7mvzlHhI2DHADIysjMGLOjIbuEpmchTJh/VB88UBLVWTebL8lclMldNoDDQmab+oRw7rY9WNrNkTCdLsx5NhSQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from PS1PR0601MB3737.apcprd06.prod.outlook.com
 (2603:1096:300:78::18) by TY0PR06MB4984.apcprd06.prod.outlook.com
 (2603:1096:400:1ac::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.31; Wed, 26 Jul
 2023 11:52:19 +0000
Received: from PS1PR0601MB3737.apcprd06.prod.outlook.com
 ([fe80::74f9:2f8c:e5b8:a573]) by PS1PR0601MB3737.apcprd06.prod.outlook.com
 ([fe80::74f9:2f8c:e5b8:a573%6]) with mapi id 15.20.6631.026; Wed, 26 Jul 2023
 11:52:19 +0000
From:   Wang Ming <machel@vivo.com>
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Michal Simek <michal.simek@amd.com>,
        linux-media@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc:     opensource.kernel@vivo.com, Wang Ming <machel@vivo.com>
Subject: [PATCH v2] media: platform: Use dev_err_probe instead of dev_err
Date:   Wed, 26 Jul 2023 19:51:58 +0800
Message-Id: <20230726115208.5463-1-machel@vivo.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2P153CA0018.APCP153.PROD.OUTLOOK.COM (2603:1096::28) To
 PS1PR0601MB3737.apcprd06.prod.outlook.com (2603:1096:300:78::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PS1PR0601MB3737:EE_|TY0PR06MB4984:EE_
X-MS-Office365-Filtering-Correlation-Id: 800a45f4-6f17-4700-28f1-08db8dcec3ec
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zyL3QrTmVEJ4nJHjCegLUhsymWlC8yK4OJI+uGVz8mCLXKOtP3QM+3DDt4fgGlQbnHTjIZ6h6YSm9EXv2yuVWNw3Q7SDN+f7xgsce6YUZt0bWj5t6XtGVv4qJlplh8isS5LoKCLfWXe22DZrIOogK8v0YQ86uDxHUqv/kKVhRHi/78Yjgqk8sTgj6UNS/IHP+zCgQOeD6FuFb33Qo4/sJulQmFG6tmqJrubyPxXskQh54OEM/VqQIt1JfQchomKEZcQnlr7z1fK9yQABEHqsTSOVXbWFjdkwF1CCThXnI5wj4QWGiRdpZN3c2QV7pqT3tttOOAC8fcUICMswtJLqh4dUfPPe9bPoxIWQsqCQiv2RNuBXO2+Ceo2fLfI6s8dzwtkOTOoZhnfOUQVQ0hv1Ef/472VF5QnrAU8pDO8T3NwjI10Fim5q/f0+zjMaQZJEIUEX0tQey6DzHiBxPYhPclrI3zKVTKhCmPNQGoUpgYenCSAVjrbuptxWeIpTMLETo5FGKeVhO2iOdHg8BgqLQV+Xw6oodvzYmdmub+CLoOCIKoI4paOfffcP2+gSyguHB67NIp4LLgz73z54SbGJGmT3T9JCptrDMcJRO6e4VCGZlqo9A6l7JvxmQF/vW/PF
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PS1PR0601MB3737.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(366004)(376002)(346002)(136003)(396003)(451199021)(6512007)(2906002)(6666004)(8676002)(4326008)(66946007)(6486002)(66476007)(66556008)(36756003)(41300700001)(316002)(110136005)(83380400001)(38350700002)(38100700002)(6506007)(52116002)(1076003)(5660300002)(107886003)(86362001)(2616005)(26005)(186003)(478600001)(8936002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?nNs1UkIJ+lI4KTT7tXg31WaAtkreUjJLfr7RchVp1om1/LrJ3DHWwpjmrRPk?=
 =?us-ascii?Q?3yGmIItKRs2X0/eaiuX4lBPoOT9mwSUjLQLyund8GUjXSSifeqnK0w2Xbhi3?=
 =?us-ascii?Q?LnWt480Re62ayVLB5vdjqZNe26s+UbaNZNnTjREScI75BHvkdynGCY6HEyrM?=
 =?us-ascii?Q?aaIKJrz/mZgF3rKQa8UcvEvPaw7dfxK7AqKfdsPioD+jl5LUtz3vCb3wJSS9?=
 =?us-ascii?Q?JhUX13LstJFeuo5k2A/1PVorLhQ18InVmMxTvrWVMH1IcajDA4xaKD6+jdQq?=
 =?us-ascii?Q?4EfYZ8feudp+HYYa56kswCDAHhm3xDmJ9M2TYtg8nvyWVjj1fexO/xMb0tjG?=
 =?us-ascii?Q?WooKbjtRTnxKj1i1dMDjGvhYBR7prkyrtX+9ZzsA/+MtcTRiuhEb2k0mOkOZ?=
 =?us-ascii?Q?W+0Pm0DX+r1vij1NJ0i5Q4OxGPWRQ1QbjazSGyoZUGHw0Yr0ZuvVjsVWBnc+?=
 =?us-ascii?Q?5640rwfcf6sAnApiww1PdblOtjfe2HD3saJAhLVUqQ6Q7mcY86MKSr195ZPf?=
 =?us-ascii?Q?wC64wXLVXo0KmCfGzBs7MvI15hCZXMb4KUOG3t5ZiFxxiyfARq63UJ+9PblW?=
 =?us-ascii?Q?UaTLsCAQy8VzH0GuB06sI2W6j8D4QEojwG4jQE1lp8BBh1PuEvxUJbBVkM7N?=
 =?us-ascii?Q?jQB2bZZD5tTJ21L91Aj1/6BCTR/TTVmC+ZaH6wUWDytZaJjZEPoq76SdfaW6?=
 =?us-ascii?Q?cWjHIZ8fsirPClBE1niwilX1FaLeChVcOrZMwDzTyN4wWTC4LCSWyOXfCFoR?=
 =?us-ascii?Q?OTprqpHLcA7miKfIhEGMLRzeaorO42lcmiNKIA3g2jfeDRBcXqy0xEnPqi63?=
 =?us-ascii?Q?XwY2bNa+Za67MLwt2/Zh2e56IcWz5nt4rEVT4UNbkSWCjr6Xkiu3lHoTpjkL?=
 =?us-ascii?Q?f6TdKDdaWWjU+1vPEE95af8Z/Fsyz34CM14cetJ1esbUTF4mmvquoxSV1KGx?=
 =?us-ascii?Q?ToMUCw8rrKpCzJhmlMPxCUfZ9zZP6AO58Ct/pntrPxo+0sqgTbTD04ffGN/Z?=
 =?us-ascii?Q?ux/3Sn+EQejtWiFQ96VGvCTpbdyOVXP70FcgxmNJm5L54tY38A6ohQ8ddsmE?=
 =?us-ascii?Q?8nEwVknpAOqMjpw2ULHm/Q2dUkI33p6HwmMK/AlBEOC82BPGMu2JXUFPJHc9?=
 =?us-ascii?Q?lImT3Hs8KLwFXh6juz2oKUnabsmp8lL8CSS2yR0vyVVPp1TeXU10x2WvAjsl?=
 =?us-ascii?Q?rWzYzWxHi2qQWTqZLficzdPaUIlTgsHagyoDEIqSMfyYCms/6nbnSHlBINd0?=
 =?us-ascii?Q?pW87XyPM+oO9GiDHJeQY1Ib2SgDWuWHITRTkdG7J7849I2t7+YbJTR3PLoHT?=
 =?us-ascii?Q?63LyH1Ecdkq+aMgTXxbwP4VB/hKyeXhssnx6GFsOwZt4sFw3ic3wUS32E0ey?=
 =?us-ascii?Q?97DKwGKkuXZhESzvt0LQNdiLSF1HE/2+8NE+SMsXJ3l3W0I/42N65XPAND8u?=
 =?us-ascii?Q?JM8vT4IfwDlH5f01F0O5qf3B/5eCJ30CsQUucd802iFlccB0RuCn484OGC4g?=
 =?us-ascii?Q?dYFcR+dISBL1IGL+ZnGiXOsnp9zHzuw8RbTV2yPuqXgta1RayN4KzYwOpB4X?=
 =?us-ascii?Q?HjXLLgot3ogM/jgtcJ668vKwe3GK2mCkY0HoXv+b?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 800a45f4-6f17-4700-28f1-08db8dcec3ec
X-MS-Exchange-CrossTenant-AuthSource: PS1PR0601MB3737.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jul 2023 11:52:19.5042
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: chsKmEitRqSFWTx4sAMje+989Vs1pIl7iT1s4l7YUn4V+UouER5PbgIEEM/ffKYk4FSbM+e7ZUU9x9DxTWwpsQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY0PR06MB4984
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It is possible that dma_request_chan will return EPROBE_DEFER,
which means that dma->xdev->dev is not ready yet. In this case,
dev_err(dma->xdev->dev), there will be no output. This patch
fixes the bug.

Signed-off-by: Wang Ming <machel@vivo.com>
---
 drivers/media/platform/xilinx/xilinx-dma.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/media/platform/xilinx/xilinx-dma.c b/drivers/media/platform/xilinx/xilinx-dma.c
index 80d6f5b072ea..16ad39bef6c6 100644
--- a/drivers/media/platform/xilinx/xilinx-dma.c
+++ b/drivers/media/platform/xilinx/xilinx-dma.c
@@ -708,9 +708,8 @@ int xvip_dma_init(struct xvip_composite_device *xdev, struct xvip_dma *dma,
 	snprintf(name, sizeof(name), "port%u", port);
 	dma->dma = dma_request_chan(dma->xdev->dev, name);
 	if (IS_ERR(dma->dma)) {
-		ret = PTR_ERR(dma->dma);
-		if (ret != -EPROBE_DEFER)
-			dev_err(dma->xdev->dev, "no VDMA channel found\n");
+		ret = dev_err_probe(dma->xdev->dev, PTR_ERR(dma->dma),
+			"no VDMA channel found\n");
 		goto error;
 	}
 
-- 
2.25.1

