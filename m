Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74A077E0125
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Nov 2023 11:31:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233210AbjKCHF2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Nov 2023 03:05:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229912AbjKCHF0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Nov 2023 03:05:26 -0400
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2050.outbound.protection.outlook.com [40.107.7.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E087BDC;
        Fri,  3 Nov 2023 00:05:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ig8MRQiWqa1r4qcExAXr2SijGKrY2bKbi2IPOESFNpk4eX49LfdhE49ZZV/rGxCOt6me3BTuPb7t4kFbxn5oD5C5uZ34cAEuqQXP7gjNAJJs1cJLAkkskf+KFTMO1sC2ctot62/HtXhZAnCW0uLoHOMBFYN2LuAgNBNdT9M1xGYG1PdW1bl2qRO3hqniZ9k+btT0rZ3Q4KhZPHIkdZSG+DIRLWg/TFKcVlCPjJssiVn9E9VcpH3CeMjkGtGSN2abpuw5DotIDkkwHQJvOUA3SQRnIUkxtw93KDHNB/uho7xxlwE12kDsDJ76pOq2CLF15NqoESjtdiZS4PFE8NQpbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2HCrqdYBKW9VFCePIwmfL4iIGazuqhbdv+gTITYsBqA=;
 b=TDDghr3OfQnV2darOw92/o3bXV+zMswkz3jYAZBgp3hhwtA0TGApa9Z/xzcJpTN8X919hi6VDVeeAI6RdHW4ocC9xsOVt1o+zyuUJG/C5MBkIyUcP/KS0WoccfgybHUnGqcpeVpjZNBG45hHt5tWSAx+fVwUb9oe8ekponEqzdjSNRIUqRuv6zbjcLgJ0K7nQR6k+7CBjYEb7SGLNYipYZ2Zqxr10gOC3Xx7cdD3IFRRyNcPRrUsvtlN9mn3kujQMzVk6o4l3hlvmYFQCZauNkUdnzg6OHy6/eYQiCR4QOdbnnCMse8dEx5aGUbnjzA2Wuw2PoRzYG0S5G9uFkT+FQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2HCrqdYBKW9VFCePIwmfL4iIGazuqhbdv+gTITYsBqA=;
 b=qbs2ifBbpYR7jWPFfUY9RTJcJ6oJnqIRFXyeIUfxpwnFxVrbIkTcCFYDdfVfbwsV58LJPrZaJ1kadzVhX+dLbm0HIaa4sOMtUuaS45AJA/2sHVO6GJaW5P1U6hmoR4ojlBTdpdx7Nj3xYpZ6nWdn9BEPVnSRcl4Fxxlz+Q6EAAw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB6341.eurprd04.prod.outlook.com (2603:10a6:20b:d8::14)
 by AM0PR04MB6803.eurprd04.prod.outlook.com (2603:10a6:208:187::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.19; Fri, 3 Nov
 2023 07:05:17 +0000
Received: from AM6PR04MB6341.eurprd04.prod.outlook.com
 ([fe80::17b0:7827:464b:8e99]) by AM6PR04MB6341.eurprd04.prod.outlook.com
 ([fe80::17b0:7827:464b:8e99%6]) with mapi id 15.20.6954.019; Fri, 3 Nov 2023
 07:05:17 +0000
From:   Ming Qian <ming.qian@nxp.com>
To:     mchehab@kernel.org, hverkuil-cisco@xs4all.nl
Cc:     shawnguo@kernel.org, robh+dt@kernel.org, s.hauer@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        xiahong.bao@nxp.com, eagle.zhou@nxp.com, tao.jiang_2@nxp.com,
        ming.qian@oss.nxp.com, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH] media: amphion: Fix VPU core alias name
Date:   Fri,  3 Nov 2023 15:04:47 +0800
Message-Id: <20231103070447.31716-1-ming.qian@nxp.com>
X-Mailer: git-send-email 2.38.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0042.apcprd02.prod.outlook.com
 (2603:1096:4:1f6::17) To AM6PR04MB6341.eurprd04.prod.outlook.com
 (2603:10a6:20b:d8::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR04MB6341:EE_|AM0PR04MB6803:EE_
X-MS-Office365-Filtering-Correlation-Id: 190a3dbd-e390-4c9e-fc90-08dbdc3b3be3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PYQ5H4qa+4pqQ9jLhNuhND1IwMALz4VuXgR5gErEwVXTKkUfX7+LTXT/CUgzEcazgPgJqE94Lyw3PJc7DpVqS9cW62QB5HmhpQfJZa4qkcmijurX2R+vIjEogtFOA2IOaogm1V0ba8ZXWh+VweU2ctjU2JNw2GvkOT/aAO93z2V07yvqWC5C4e6S6TnXFJyFHbXyscZ6YChLDX3MvDsi6qYHVPvhNdntAYzYXnS50iiW3MItZ3EvJn3ox7v2KIQ0Jl7qcJ+fZGetVi/I5R3ReFm1JXMKhHmVNBgFGMu4eymbMEASSxG9WQscQtZcXvtsMzMoqzwypuLPphsW6QA2CEuSb9/WQdzTwvjm22FMoui1URO2PptrbDY9kIFOI9RmIaBkdAgdHmAsw9fHtkC+peHkkjtkpVgvlP35UZDNwI3PB3vhj/fwhfbgMerkILmci54xCFnbJJbHF7bhdSAUYqj7GQ5R0r2snk3U+sXgZIf7F+yfrGLiU41cXEAtvDFZhnHd4EboEI9iAM699N4gvDDTnwbVSEUwxaejjgjS82vtsNP+Vkes2e194FqjiTVsHT06JMShUjb7o2jPWngD8OfcfWibYP0fYCt8ZX+EXb1ckbvD/Q6K9kVr+e2aK9bq
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB6341.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(396003)(136003)(376002)(39860400002)(366004)(230922051799003)(64100799003)(451199024)(186009)(1800799009)(38350700005)(4326008)(83380400001)(8676002)(8936002)(26005)(7416002)(38100700002)(36756003)(2906002)(86362001)(5660300002)(41300700001)(44832011)(6666004)(6512007)(6486002)(6506007)(52116002)(478600001)(1076003)(66476007)(316002)(66556008)(2616005)(66946007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Vmw+7lBC8CpNPB8qUrCq7H0gYPS6oOqgOTYacvd97E88K4ESEhjIyKieGXaq?=
 =?us-ascii?Q?2tGBR4MRxW1tlzc4Z+k+gf3MRzh1ORWSUKjRdf69qvdNyww6zv1DXIsVuge3?=
 =?us-ascii?Q?MEVCtmZzCETgtRYnUKs/cvTkMT0v9USZ/MWR6NE3lux7p8KtPEOdRq+lOiS9?=
 =?us-ascii?Q?5TG/MdhVrCb5SmxdFCB0dRYFcttQ15POgckjKgBY4HaXIzQ8imbq9xgK6U2S?=
 =?us-ascii?Q?vzaMSmSCu8cf1DrAVMvwOCVp2euJLgguHzJwZwyIRJWG8lL2/OTe5Yhkg0GG?=
 =?us-ascii?Q?C8wSXpJ5oV0G0MbFVN0m4mQG3CzNeTlig+PszHy5+2P31Hb+6CeNrv8xf/Ve?=
 =?us-ascii?Q?EaY04gA3gb+KXt4bcJcbHQxPrF1/4u2P33XOGfhxesDD4x8qfy5C/pCFl0vr?=
 =?us-ascii?Q?pE3A7Tk0B8olf/CO5RibvHnhmUr/bx7aDmXgPEwmyDl1Yzco7swR+SohMZ4D?=
 =?us-ascii?Q?cvlxmUCu0+pN1Y8v241CvNeBPlnPIDSFxCx9x3S1tSWnhIPnlL2RzsEmmwZb?=
 =?us-ascii?Q?K22p3kbPYsqqh5l43VOhKgDaMdBBDCMUmsy0CtOkmCBikp1n5QPLVbazpciN?=
 =?us-ascii?Q?e3VPROqwSKNGpPXj7PCmfDjBvI+qyjGoxQQSxIAN0GkBJAFL98EsXaLz3hZ+?=
 =?us-ascii?Q?m9A1HfLQ//GcXxk4pRRmtdjYgSxjhciMsyAJ45C7DvpRVbZSCyoD5k89snmy?=
 =?us-ascii?Q?cCUf536aZV75brT2UPIAXNhIIPmm07qRFVoJsQo64gozMlLORoo6IwODksDc?=
 =?us-ascii?Q?d0dojssHtJrM1Uyo/yz9Q5nslpW6zUKy2/X0UjxzoXCRf7A2kZe1JLJxBf2K?=
 =?us-ascii?Q?0qXlmHvwklFqcDt4KCrVBEfvCxujMOyF7njRFYIMqZKH43CBvuOCMslna6am?=
 =?us-ascii?Q?Tz142s9qL7AsColhbwzYP+LD5dNkXMuLO+bK6JHdb6s9/9RH2/XwrhBNh1iw?=
 =?us-ascii?Q?6YLclzlfKCx/C88o/feXVFK84hDyTenL2+gmnHDQnjDPmqlyE57aw+t+CeZm?=
 =?us-ascii?Q?KjyJHUhHgX7V1AdVtv7Bn7hZwlcrkRGiW0sAKzn8PQZ79THlKro/TYeOC3El?=
 =?us-ascii?Q?FLiPjIhfsNIKBkts31FHVelEip5lzesYOIXfQIlOFgAbqRmQMhZ7JQsmsa7E?=
 =?us-ascii?Q?OHrj/MjMsXRe7371NALfupQUV7rOyLa1+5qal1xbi2XLWPGF6YaBFRbopvfR?=
 =?us-ascii?Q?jRkYF/p2q+LNnVESvt+j84fNjXmpjqY9+0Ag0zae/SbQXhDkfy5bljq1IHtc?=
 =?us-ascii?Q?u1IhEeTdumgvKtl+K7EBW4velRydBAEX+kSrbuEGCY7H/vtz1zyd9YVQxR9p?=
 =?us-ascii?Q?Bmd9n8FxJeazePuQdwsjHPAZOdNCmyIfSRp7/VvF1gmhXlvWyj9VIW0/sKWd?=
 =?us-ascii?Q?4v/g2x7Wkj0xL0r44/PyPZCCpjrbg5U3sXdYXcvmL7fC6pCYK7RFLp16Cp3o?=
 =?us-ascii?Q?APdgNqGwIUWX7fgv5uH4jdOCSRhC5O+PDQU6py/oU/yOe5epRzQi/PZQmRlE?=
 =?us-ascii?Q?9SzN8e0t8KQkR0bqzPSYoMeOh0mHdgzv2chGtLwT9XBR44TM9ZWvslkJZJry?=
 =?us-ascii?Q?P+3oOX4WSbejJGN5ZgXIGH+JqnEsAEHZOJhQk6f1?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 190a3dbd-e390-4c9e-fc90-08dbdc3b3be3
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB6341.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Nov 2023 07:05:17.0264
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: azlx1Nt02ZlplGMUFW+MEfv1+bwtjt3HLkdd4xrB26ZvzcE+euNraIf7UVY0ZJVlYjbxifBh8WqymG4OI0n51A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB6803
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Alias names use dashes instead of underscores, fix this. The dts has
been fixed in the following commits:
commit fb8f715e5c53 ("arm64: dts: imx8qm: Fix VPU core alias name")
commit f6038de293f2 ("arm64: dts: imx8qm: Fix VPU core alias name")

Fixes: 9f599f351e86 ("media: amphion: add vpu core driver")
Signed-off-by: Ming Qian <ming.qian@nxp.com>
---
 drivers/media/platform/amphion/vpu_core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/media/platform/amphion/vpu_core.c b/drivers/media/platform/amphion/vpu_core.c
index 1af6fc9460d4..3a2030d02e45 100644
--- a/drivers/media/platform/amphion/vpu_core.c
+++ b/drivers/media/platform/amphion/vpu_core.c
@@ -642,7 +642,7 @@ static int vpu_core_probe(struct platform_device *pdev)
 		return -ENODEV;
 
 	core->type = core->res->type;
-	core->id = of_alias_get_id(dev->of_node, "vpu_core");
+	core->id = of_alias_get_id(dev->of_node, "vpu-core");
 	if (core->id < 0) {
 		dev_err(dev, "can't get vpu core id\n");
 		return core->id;
-- 
2.38.1

