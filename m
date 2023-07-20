Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B45875A517
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jul 2023 06:29:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229587AbjGTE3O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jul 2023 00:29:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229535AbjGTE3M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jul 2023 00:29:12 -0400
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2058.outbound.protection.outlook.com [40.107.215.58])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D31C1FDF
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jul 2023 21:28:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PI75qzp/QpepnoYhb6Jz13ASnqMfKul7u3ntEE+Xysk6G4iM7HZyqQ0fteKq19M91oj1wTiiyGi+ZJd2w12JZMfWV7Gm+VWtrgSnz9LV9fngyAwLbpzui5D6rgcoHYUUnAi5S4QH6k15OFUVAlAhqGnUZmQGs5jsIYV51aCwjPCdl9/q/HPJy54EMUakhmk6VSv3GZ/H6DTjBiB+7RR8f9XPjJ/Ys1qqENPoGauaSIpmqvv6fL5lyAeCyGvESVYqzFa8X94LQ8XfDW6xChjcxUHqDh6zLrUt7M6lWkoOyWyB54zjNrdyjOOvqydQpkQk22Zj5SfXAmEXPujCNm3IUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OcHFj9Cc+X3TnjF1wwXfiJfxHRaE9Hp3aakq/LLqnqU=;
 b=mApmafHa8spfy2olaaM6QWZCzmJiZyLUd95JL2OSZOlTUhcgStS77mPw2o9p/3ZE/GHJPfC2Q4bD42c63gj2OaJFULaWLQINxI8Z1l4v8jnr3loWn6vSV+ggUE3yvbSnHNNFZZtTZ0ZEiRjqECtYH/Uh3d4BrJCj6Tgq/rKMUlbHNDaIW5HfQ50E1gGZpvdomadawt4gVXGRtCg9kxj/6Jlv2PrWxydWUItEcUoUNucZo1OMbVQmr/cbQzurKxZ+ONU31L9hD13eJTqSIX2SMIwnq6fXRp9TRd91CUKWaNrJeVT0lTMjOWWSvoe6fGBB52HMKcSBLMgAmDhPCbbwBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=gigadevice.com; dmarc=pass action=none
 header.from=gigadevice.com; dkim=pass header.d=gigadevice.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gigadevicecn.onmicrosoft.com; s=selector2-gigadevicecn-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OcHFj9Cc+X3TnjF1wwXfiJfxHRaE9Hp3aakq/LLqnqU=;
 b=yZx1rFVaSzchhzhSV3zybHATi5vWT9at3ZO+R0LWnBdCLHognHskPIZfBw9GJmRAhp5s1yUEF+kFlO3F9E+5+G75WMS08HZIyjUl3y5zfkeIQ4kOgCkl2HfY6LFTqPVsFUFAJ4z/yie9c0Zt4ToPUm/Li/4tMaYKKKdjefVFZ9k=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=gigadevice.com;
Received: from TY0PR06MB5658.apcprd06.prod.outlook.com (2603:1096:400:276::12)
 by SEYPR06MB6010.apcprd06.prod.outlook.com (2603:1096:101:dc::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.25; Thu, 20 Jul
 2023 04:28:49 +0000
Received: from TY0PR06MB5658.apcprd06.prod.outlook.com
 ([fe80::4204:f5d6:9066:5585]) by TY0PR06MB5658.apcprd06.prod.outlook.com
 ([fe80::4204:f5d6:9066:5585%4]) with mapi id 15.20.6588.034; Thu, 20 Jul 2023
 04:28:48 +0000
From:   Victor Lim <vlim@gigadevice.com>
To:     tudor.ambarus@linaro.org, pratyush@kernel.org,
        miquel.raynal@bootlin.com, richard@nod.at, vigneshr@ti.com,
        akumarma@amd.com
Cc:     michael@walle.cc, linux-mtd@lists.infradead.org,
        linux-kernel@vger.kernel.org, vikhyat.goyal@amd.com,
        Victor Lim <vlim@gigadevice.com>
Subject: [PATCH V1 1/1] linux: drivers: mtd: spi-nor: gigadevice.c
Date:   Wed, 19 Jul 2023 21:28:34 -0700
Message-Id: <20230720042834.12296-1-vlim@gigadevice.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR13CA0181.namprd13.prod.outlook.com
 (2603:10b6:a03:2c3::6) To TY0PR06MB5658.apcprd06.prod.outlook.com
 (2603:1096:400:276::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY0PR06MB5658:EE_|SEYPR06MB6010:EE_
X-MS-Office365-Filtering-Correlation-Id: bc12f791-dfdb-4a80-3a9e-08db88d9d034
X-LD-Processed: f84ba339-959c-4ab1-9b67-1e43414f945e,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: imvCUY6IGsu5+Us8YaokZk49WEN/zWibkWOJYNW43Ew4dLP7/eBtigB5wi+GlNxiTaWN0jp+XvWVhn3/fQYFQZOx48mi9E1F3ZE2/vXBboWC9wmSWLoMoUtV0mMi6P8SdI3cxMRzrVUeluZS4UJZvlHiHJitcHO83a1ke0F8FWcQ/fQGaWvNS6HGdhn9YAMQOMFG2N8Vv0klmFBfV4panSCJ8BeBPei7Wo0rIxug1u6bvBZj6w5WumXX8OBxyapl4XlICF6XqzHQsp1jmb9Q16ZYpQlLf/f2zIuF3cvIIWasEEzG1OidOB6lCQbpEF2AsqxT7j7qs6VGxAn9G/BEtF28VOSIDboBzm4Oz51vZD5pqmQBXIEnoXKLQe/XvXKJhFXHutz90pACQxgRyDOwkyNpLVLpxn9UHrJnh8ljcsuqR9B+Rc1NYW8DUrSAZ1n5Hn4Hg0YiPZyQCbNSihOQiV93HIvtVeGNwPKd3QZQNKQ+1sPQrRa1E4AP9qcHSmAbO9wyupmtoPC7oFIJBRpd0OLtnA2lPZ83lLG0pP549toxEZWq8UM40x9vbYhYchlV
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY0PR06MB5658.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(346002)(396003)(136003)(366004)(39860400002)(451199021)(2906002)(83380400001)(2616005)(86362001)(36756003)(38100700002)(4326008)(316002)(66946007)(66556008)(66476007)(107886003)(1076003)(186003)(6506007)(41300700001)(478600001)(6666004)(6512007)(6486002)(52116002)(8936002)(8676002)(7416002)(5660300002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?IkXKOG/57m/8zzLaegxJxyN7f8nOZwPtq2tn8sJb9uL1GUmiyo5lQ7y5gvFE?=
 =?us-ascii?Q?rZu6iTaGstvpLJe2z0P9xNu/7lhuD6g6bubAwF4JHpAPnP6IAM9a+lHi0bDG?=
 =?us-ascii?Q?bfW0RfMB/rCEHaPH/MBMuVDfFTnS/Q1nyEsb+jQTiV0ARbkf5VY2GpwFBZ2p?=
 =?us-ascii?Q?LrPuBa0hkf1XttApGysdZ5OUalXlNbooxKoOgOxeDcvYRpB2JBX4BVRycoPT?=
 =?us-ascii?Q?ArbiBkYCseZVhx+B3dfSRWYNtuFsurYSIa/Y7ZyS+A9+mDdfxOj4hHQFJFvA?=
 =?us-ascii?Q?Xngt/s89DdXZeJtIjpqsbFp+MR8OMRcaFZauSARygyKgJgpFm8oZFgdGRKwH?=
 =?us-ascii?Q?tuO4YSCnFhgV5DCZPRWthsde3hPG705HwV3O6OqGIKL4QBYwHwuiIXIQwyBi?=
 =?us-ascii?Q?uJwJAmiAO9J+jZDEkqReIuHGtiJ4Gtou7pBr/Bg3P2heoojcF8wJgYVLAG9L?=
 =?us-ascii?Q?gbbCmeaNVemDWhrmFw0NUkgKLoFSfDoKtvY07Udj8XFMi14FD867p816qAdP?=
 =?us-ascii?Q?6DLYlh/jenkRWtB0man4whkrAJKU0P1OzOy484rxaluOqnzJtQJPcEcRk1s+?=
 =?us-ascii?Q?OdbT+7gLNaefvP4IQ6ZmsAe4Bfi0RAfCg03D+BkKYUBuzpumaj4CI6R8GRT+?=
 =?us-ascii?Q?qnk7MQ/d9a26K2vVmVyOvY5k7xyejtSLUMG8JpYqmf5xyFBeKBVRwC/9ah2z?=
 =?us-ascii?Q?iOtwn/n7z2F/jDIhQ8uBD3Qqm8++1dpciAGFKv7vL6yxk4u/L1DL4QhCvtcf?=
 =?us-ascii?Q?wJF1pdDX5EONdyE1K+w5c6tqlzn7yQpW6Y8+Qjn3CxOf1myih0C5bpRYrhcp?=
 =?us-ascii?Q?P5cr4TqmjYZwriAjwJd+aZG7TQ2xGGrIrxkP+UFCTyqu6eYOnr8+bwsqxfPl?=
 =?us-ascii?Q?iZwhc8pPg5IXzLp4dZV1c380+g5aPumeX+TK94sp2QY2+DfLziKtrmiY/cus?=
 =?us-ascii?Q?JMPOIBnpsLJiKBTbyDXqleka3NFFoNp4kNgZSdGnPKCAYRbQFDd32JGmnATF?=
 =?us-ascii?Q?tJpvh4kr3WL2vyAxhT9Ri3HmOrlJCQuW/zN8I7212a21dTxaUyOVlBOzxqrJ?=
 =?us-ascii?Q?8lz0/s8kCLOdzgry3B3B0NRl/mr3CsVKSm++mNbUnFu8Uiyb/pRE14lOVLt4?=
 =?us-ascii?Q?LtTuL1BxQiETkLBVoIHs6rXhkIMX5ojRErsewfyR4hWX0N0Htn1fxHTfRkMc?=
 =?us-ascii?Q?Pyr+n+D9Z3CvdCtfR45yJW1tAHb/QGRDKgXL5IBSnPQNI+//if1cOaWCxZOQ?=
 =?us-ascii?Q?GlnUDRNGLAivgcZdh5cRXEhJXpvZJXKqM68+3xARE2K/VNjLMYagWGZ6Spsd?=
 =?us-ascii?Q?9IcrRNJ2M6EdvyYYKTSiYsTWFFxFlW5gTxYZnwG/PDjcQ0tX/eJW/5V2QCne?=
 =?us-ascii?Q?07gfknaEePyo+Qz8aUdnnB6CLRQinglSZKjN1WThYug7tUJZiIT85l37Cfhr?=
 =?us-ascii?Q?d/ZRiZwcMqj5DPrqD6RwMIfDNTPj8VsRDRFvh7UVy2oihekTa1c2aKvAqwlW?=
 =?us-ascii?Q?BNtxDwRn0FRc+TohywZNo+lk/dMHlIq0qADHCow0EWdkM5sV6W/eWbkoHha7?=
 =?us-ascii?Q?B95hoJvFcDIf4xD4ojOUlRrdwfDa+jYVVOUV6tCGkHZjP3csLGM526fZ604Z?=
 =?us-ascii?Q?OaBGSqtQ7oj2ycGr5KQkCiOFPJiNe3XsKXSE/mbUim8A?=
X-OriginatorOrg: gigadevice.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bc12f791-dfdb-4a80-3a9e-08db88d9d034
X-MS-Exchange-CrossTenant-AuthSource: TY0PR06MB5658.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jul 2023 04:28:48.8785
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f84ba339-959c-4ab1-9b67-1e43414f945e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: G5jrU0C/l5LMfnsl6s3/KHGDL0XT8l0U+sF2SlA5Xu21Ec7iFG/IieIQng6S5LHp5QXEyxomfwIChWVzM0eOHw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR06MB6010
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UPPERCASE_50_75 autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adding gigedevice new part numbers

Signed-off-by: Victor Lim <vlim@gigadevice.com>
---
 drivers/mtd/spi-nor/gigadevice.c | 79 ++++++++++++++++++++++++++++++++
 1 file changed, 79 insertions(+)

diff --git a/drivers/mtd/spi-nor/gigadevice.c b/drivers/mtd/spi-nor/gigadevice.c
index d57ddaf1525b..285fa42f2d97 100644
--- a/drivers/mtd/spi-nor/gigadevice.c
+++ b/drivers/mtd/spi-nor/gigadevice.c
@@ -67,6 +67,85 @@ static const struct flash_info gigadevice_nor_parts[] = {
 		FLAGS(SPI_NOR_HAS_LOCK | SPI_NOR_HAS_TB | SPI_NOR_TB_SR_BIT6)
 		FIXUP_FLAGS(SPI_NOR_4B_OPCODES)
 		.fixups = &gd25q256_fixups },
+/* adding these parts */
+	{ "gd25lx256e",  INFO(0xc86819, 0, 64 * 1024, 512,
+			      SECT_4K | USE_FSR | SPI_NOR_OCTAL_READ |
+			      SPI_NOR_4B_OPCODES | SPI_NOR_OCTAL_DTR_READ |
+			      SPI_NOR_OCTAL_DTR_PP |
+			      SPI_NOR_IO_MODE_EN_VOLATILE)
+		.fixups = &gd25lx256e_fixups },
+	{"gd25b512", INFO(0xc8471A, 0, 64 * 1024, 1024,	SECT_4K |
+	SPI_NOR_QUAD_READ | SPI_NOR_HAS_LOCK | SPI_NOR_4B_OPCODES)},
+	{"gd55b01g", INFO(0xc8471B, 0, 64 * 1024, 2048,	SECT_4K |
+	SPI_NOR_QUAD_READ | SPI_NOR_HAS_LOCK | SPI_NOR_4B_OPCODES)},
+	{"gd55b02g", INFO(0xc8471C, 0, 64 * 1024, 4096,	SECT_4K |
+	SPI_NOR_QUAD_READ | SPI_NOR_HAS_LOCK | SPI_NOR_4B_OPCODES)},
+	{"gd25f64", INFO(0xc84317, 0, 64 * 1024, 128,	SECT_4K |
+	SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ | SPI_NOR_HAS_LOCK)},
+	{"gd25f128", INFO(0xc84318, 0, 64 * 1024, 256,	SECT_4K	|
+	SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ | SPI_NOR_HAS_LOCK)},
+	{"gd25f256", INFO(0xc84319, 0, 64 * 1024, 512,	SECT_4K |
+	SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ | SPI_NOR_HAS_LOCK | SPI_NOR_4B_OPCODES)},
+	{"gd55f512", INFO(0xc8431A, 0, 64 * 1024, 1024,	SECT_4K |
+	SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ | SPI_NOR_HAS_LOCK | SPI_NOR_4B_OPCODES)},
+	{"gd25t512", INFO(0xc8461A, 0, 64 * 1024, 1024,	SECT_4K |
+	SPI_NOR_QUAD_READ | SPI_NOR_HAS_LOCK | SPI_NOR_4B_OPCODES)},
+	{"gd55t01g", INFO(0xc8461B, 0, 64 * 1024, 2048,	SECT_4K |
+	SPI_NOR_QUAD_READ | SPI_NOR_HAS_LOCK | SPI_NOR_4B_OPCODES)},
+	{"gd55t02ge", INFO(0xc8461C, 0, 64 * 1024, 4096,	SECT_4K |
+	SPI_NOR_QUAD_READ | SPI_NOR_HAS_LOCK | SPI_NOR_4B_OPCODES)},
+	{"gd25x512", INFO(0xc8481A, 0, 64 * 1024, 1024,	SECT_4K |
+	SPI_NOR_OCTAL_READ | SPI_NOR_4B_OPCODES)},
+	{"gd55x01g", INFO(0xc8481B, 0, 64 * 1024, 2048,	SECT_4K |
+	SPI_NOR_OCTAL_READ | SPI_NOR_4B_OPCODES)},
+	{"gd55x02g", INFO(0xc8481C, 0, 64 * 1024, 4096,	SECT_4K |
+	SPI_NOR_OCTAL_READ | SPI_NOR_4B_OPCODES)},
+	{"gd25lb16", INFO(0xc86015, 0, 64 * 1024, 32,	SECT_4K |
+	SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ | SPI_NOR_HAS_LOCK)},
+	{"gd25lb32", INFO(0xc86016, 0, 64 * 1024, 64,	SECT_4K |
+	SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ | SPI_NOR_HAS_LOCK)	},
+	{"gd25lb64", INFO(0xc86017, 0, 64 * 1024, 128,	SECT_4K |
+	SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ | SPI_NOR_HAS_LOCK)	},
+	{"gd25lb128", INFO(0xc86018, 0, 64 * 1024, 256,	SECT_4K |
+	SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ | SPI_NOR_HAS_LOCK)},
+	{"gd25lb256", INFO(0xc86019, 0, 64 * 1024, 512,	SECT_4K |
+	SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ | SPI_NOR_HAS_LOCK | SPI_NOR_4B_OPCODES)},
+	{"gd25lb256", INFO(0xc86719, 0, 64 * 1024, 512,	SECT_4K |
+	SPI_NOR_QUAD_READ | SPI_NOR_HAS_LOCK | SPI_NOR_4B_OPCODES)},
+	{"gd25lb512", INFO(0xc8671A, 0, 64 * 1024, 1024,	SECT_4K |
+	SPI_NOR_QUAD_READ | SPI_NOR_HAS_LOCK | SPI_NOR_4B_OPCODES)},
+	{"gd55lb01g", INFO(0xc8671B, 0, 64 * 1024, 2048,	SECT_4K |
+	SPI_NOR_QUAD_READ | SPI_NOR_HAS_LOCK | SPI_NOR_4B_OPCODES)},
+	{"gd55lb02g", INFO(0xc8671C, 0, 64 * 1024, 4096,	SECT_4K |
+	SPI_NOR_QUAD_READ | SPI_NOR_HAS_LOCK | SPI_NOR_4B_OPCODES)},
+	{"gd25lf80", INFO(0xc86314, 0, 64 * 1024, 16,	SECT_4K |
+	SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ | SPI_NOR_HAS_LOCK)},
+	{"gd25lf16", INFO(0xc86315, 0, 64 * 1024, 32,	SECT_4K |
+	SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ | SPI_NOR_HAS_LOCK)},
+	{"gd25lf32", INFO(0xc86316, 0, 64 * 1024, 64,	SECT_4K |
+	SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ | SPI_NOR_HAS_LOCK)	},
+	{"gd25lf64", INFO(0xc86317, 0, 64 * 1024, 128,	SECT_4K |
+	SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ | SPI_NOR_HAS_LOCK)	},
+	{"gd25lf128", INFO(0xc86318, 0, 64 * 1024, 256,	SECT_4K |
+	SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ | SPI_NOR_HAS_LOCK)	},
+	{"gd25lf255", INFO(0xc86319, 0, 64 * 1024, 512,	SECT_4K |
+	SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ | SPI_NOR_HAS_LOCK | SPI_NOR_4B_OPCODES)},
+	{"gd25lf511", INFO(0xc8631A, 0, 64 * 1024, 1024,	SECT_4K |
+	SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ | SPI_NOR_HAS_LOCK | SPI_NOR_4B_OPCODES)},
+	{"gd25lt256e", INFO(0xc86619, 0, 64 * 1024, 512,	SECT_4K |
+	SPI_NOR_QUAD_READ | SPI_NOR_HAS_LOCK | SPI_NOR_4B_OPCODES)},
+	{"gd25lt512", INFO(0xc8661A, 0, 64 * 1024, 1024,	SECT_4K |
+	SPI_NOR_QUAD_READ | SPI_NOR_HAS_LOCK | SPI_NOR_4B_OPCODES)},
+	{"gd55lt01g", INFO(0xc8661B, 0, 64 * 1024, 2048,	SECT_4K |
+	SPI_NOR_QUAD_READ | SPI_NOR_HAS_LOCK | SPI_NOR_4B_OPCODES)},
+	{"gd55lt02g", INFO(0xc8661C, 0, 64 * 1024, 4096,	SECT_4K |
+	SPI_NOR_QUAD_READ | SPI_NOR_HAS_LOCK | SPI_NOR_4B_OPCODES)},
+	{"gd25lx512", INFO(0xc8681A, 0, 64 * 1024, 1024,	SECT_4K |
+	SPI_NOR_OCTAL_READ | SPI_NOR_4B_OPCODES)},
+	{"gd55lx01g", INFO(0xc8681B, 0, 64 * 1024, 2048,	SECT_4K |
+	SPI_NOR_OCTAL_READ | SPI_NOR_4B_OPCODES)},
+	{"gd55lx02g", INFO(0xc8681C, 0, 64 * 1024, 4096,	SECT_4K |
+	SPI_NOR_OCTAL_READ | SPI_NOR_4B_OPCODES)},
 };
 
 const struct spi_nor_manufacturer spi_nor_gigadevice = {
-- 
2.34.1

