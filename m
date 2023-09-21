Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3BF667AA269
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Sep 2023 23:18:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232665AbjIUVQj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Sep 2023 17:16:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233228AbjIUVP2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Sep 2023 17:15:28 -0400
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on0614.outbound.protection.outlook.com [IPv6:2a01:111:f400:fe0e::614])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D75061713;
        Thu, 21 Sep 2023 10:06:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NXvsGFIDhJiTgxsX0PpE8J/lhq1tyHC41fb19oDJjj4qm2zFfyMuUNBNTDYa0GKfQSK/Ydd0PExXjMlIZxceIQ8Me8Q7tvzs6tHgTqmLLG72PSwG2KIWAxWh2ivJnDlGqwl+v9sa4ip/ErwXuWU2FWtooHm9OYRKG8QqobRhm/C97c5dHl4v1f9V0jSUPqqOyBFVau+Am3doenfWiZiGPY1arAo8y2NAIPPaONz6uLyd9JFly0GSG9Q4uCeEKcjtwTpl2WvGcjMnIUj3ECv93pfmyPk8+zjeBYmHo2kCwoubo+kkojLmU5YiRoTMxQa6iWYwnNhzgQiWlEXERNidXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=44kUePCEurOOgwMYy/g7ZeaiQvugDdzWMXCOBAU9FXc=;
 b=gzFSPMxTYrIHUzLhKDOO9nHDJV2idBfSIEl0LmMH1ans48GpQMZ7bEIbDY92HHGoVGldGvCJhy9Po3F/HMZtcpX0/zH5toG0aoBrSb7G/uPmskiqz/rbFysZeIvFUkwGBJyL3oWJlMXEVQxs/bHeyeU6fQDMTtkrpcxQtTtW+nSrtT8H5Nq4OLCSF5mEdmWEOV5uYAQb1OgBND+iSerQ9W0LkKDrncbjXwOEMM+7LxY++Li+BsDtHPSf5N3DSeJaQnAefJ6HcDAufNSTYdY6ItXA3pdFj4dgVxyG1I+k98fmmU0OGcB1YrGNnR9N2dFqypqyknhghbjE5/+d6IoHQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=44kUePCEurOOgwMYy/g7ZeaiQvugDdzWMXCOBAU9FXc=;
 b=KhD1rXPWKK+Ru+lheGKutFuCSmkgvKPy/d4OtGol7qgt/y6xTzYGTSZyOAkf8Kkv2Kt8gvq5TNnfU8gIFP0qXcvLSRwnEDrQcfECrNgGX/4aw8WPT4Kb+86lrV8ZPH0qlhmRvdEwH5Ep05OOrfsgGOdni7OwgX3zIKl/fwLm1HQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM0PR04MB6004.eurprd04.prod.outlook.com (2603:10a6:208:11a::11)
 by DB9PR04MB9776.eurprd04.prod.outlook.com (2603:10a6:10:4f0::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.20; Thu, 21 Sep
 2023 12:43:01 +0000
Received: from AM0PR04MB6004.eurprd04.prod.outlook.com
 ([fe80::86b7:e0cc:dd24:12c0]) by AM0PR04MB6004.eurprd04.prod.outlook.com
 ([fe80::86b7:e0cc:dd24:12c0%7]) with mapi id 15.20.6813.017; Thu, 21 Sep 2023
 12:43:01 +0000
From:   Gaurav Jain <gaurav.jain@nxp.com>
To:     Horia Geanta <horia.geanta@nxp.com>,
        Pankaj Gupta <pankaj.gupta@nxp.com>,
        Varun Sethi <V.Sethi@nxp.com>,
        Meenakshi Aggarwal <meenakshi.aggarwal@nxp.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S . Miller" <davem@davemloft.net>,
        Aisheng Dong <aisheng.dong@nxp.com>
Cc:     Silvano Di Ninno <silvano.dininno@nxp.com>,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-imx@nxp.com, Gaurav Jain <gaurav.jain@nxp.com>
Subject: [PATCH] crypto: caam/jr - fix Chacha20 + Poly1305 self test failure
Date:   Thu, 21 Sep 2023 18:12:37 +0530
Message-Id: <20230921124237.2364827-1-gaurav.jain@nxp.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR01CA0176.apcprd01.prod.exchangelabs.com
 (2603:1096:4:28::32) To AM0PR04MB6004.eurprd04.prod.outlook.com
 (2603:10a6:208:11a::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM0PR04MB6004:EE_|DB9PR04MB9776:EE_
X-MS-Office365-Filtering-Correlation-Id: dc573aea-51c0-4f49-264d-08dbbaa049e0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CdHgm64dgOns7JEY14Sbpn7OjUzCciwH/Q+DkU2sZLrNDpCpHxcdWYjTCkYVJGMMrLTYEfAo/BbbVPQCm2pU0wpfksS4MYUAA37m0oVM49jlkr16aLgGT6KI+HzdNNINUYXdPIalfGHOSD44xvRZdKmIZ5eZJxM1rKKBBS04lHuR2HZ95jCPa9AuxtkZI8o0SyOFZ+PAr3itko997Emu+57KjRHIouFB/Csr6XtayaRL3z4JYGFtViXk0s6/xPa/KjcM0DNX31de0HxR0OhvzFSh0N5JtEO67fANKWi12+wWXJzVAKJPrlSLmwe2Phxcid2w3Hi2RgJdDPDap0QocF9e3aJGVAFsYRGESVgHAQsBW7ALj6vBC5xBzajPYU/qXF5WgBJOHJhB4lvPDI8+812zsbp5NzhO5OGWXDbzJKjIcwMBdq0NRVxEZXWkvdWCV4ubCfFdIPjfRMItDOVcnEXqb9HA6l/hnMYC6/Z8XSuFHWH/1gIa8Ong/Jir4TJwAtr86PIlPXhAY/mVvusjgI1QyNguS1z2nna985NTTKXmD155fYNq3UrZ9tW7mF23xrLQE93wP/Y0eCQ5iGYBE4k22Z3kxUs6vI5NKIs0DD9aAYAnwosr0l6oGEtEg06B
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB6004.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(39860400002)(136003)(346002)(366004)(376002)(1800799009)(186009)(451199024)(52116002)(6512007)(6486002)(6506007)(6666004)(83380400001)(38100700002)(86362001)(38350700002)(36756003)(2616005)(1076003)(26005)(4744005)(110136005)(66476007)(6636002)(54906003)(316002)(66556008)(66946007)(41300700001)(2906002)(44832011)(5660300002)(8936002)(8676002)(4326008)(478600001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?pxGTBpdEb9uwCgiKKmXtgcx2Cx5oS8NqQp8uEX0jWDsKKgUN42HymCmjxuBG?=
 =?us-ascii?Q?ZBvd5S90DVUOwndCOFaYgWY0yNqcY0IPzrLxmq6Sixfu+Qz0Vfg9StGdD8Mk?=
 =?us-ascii?Q?xvUaKfI/L6Hw9ZYvbhU0X161A2xcT9MHWkGDKST6Xx73JoSZHqWkwEVHaoXI?=
 =?us-ascii?Q?A0ghS8Jl/wNWM2iYl+Eb3K/+Cy3k0Trqn9e+NLLq/st43JyUi+uOc/voz4WD?=
 =?us-ascii?Q?/FrqI7vdZCmktf5rxHjdBtTSvg+JZ/r0DvcOw3qbbHPZLfhlX5+/3noHG+AS?=
 =?us-ascii?Q?S/diyIWv9v7lVNb0Br6fYg741pHbFuvf2oXY/0/L+k4pgv1LKAbCjsiwUy+J?=
 =?us-ascii?Q?B27TJHirfFPaSVBvTj+WuXI0NKukfz+VThdpZLYN/dYxrKsKMmIlbM/JzA51?=
 =?us-ascii?Q?+nFbM5Fff3VXEYC/KYbMr8p9kA1Yg4t0QwgZtkkfMXBwG7bmugDzs0GYzMHj?=
 =?us-ascii?Q?I/U1vK7T9uU6rcD7ETBKsYT1V3jQU4dIIseE6i0A/xX7sCvGbOpdaazNNcx8?=
 =?us-ascii?Q?tthdd6GpSu0a0nSk8UFVymZUfuMwAHowPCMqMkHueM1NyNX/z79LR66618AX?=
 =?us-ascii?Q?LRhjLINX17tXFm31xwuTOJRQROQXoFfk344XFlXCibqZHfHXzlFjqTJ1aQEl?=
 =?us-ascii?Q?AkLOIBGCCrWe/ZGHsbpVCczrpW5O3R7G47KdkMe2qxx654/Of9Kw9dsluMzH?=
 =?us-ascii?Q?BsaIPUuLVeHFeoPUYIE0sRTMUErycAfz9a8Db9uqcsQRiQ5uemDFXUe/ZCOj?=
 =?us-ascii?Q?ZmOxzrZyoaiEtv4l4+wEBrtJILCF3E91+4eZGasssi+IrknmO6L3l8gsEnlx?=
 =?us-ascii?Q?4qNCmN1djmsUJ0d5+E716/VxASe1fvh0fWRkwwGtUKQCPH3s44U00P2V/J55?=
 =?us-ascii?Q?d+e7ZQz/MX2CAcreJ48bXEQiNg9CJVVAKgHJ+oV00NjTQq8C5W7BYH9UO7X3?=
 =?us-ascii?Q?oDL9To95vQ8y0QK2i8Yxt4KWFsSuE2iWLXjgXjjaubtfAlZHuKLDesHLys89?=
 =?us-ascii?Q?UVru4oIJXDiyPikfCPnCeTMDEwGvUx8cz6i9RIIPZFT9QFvRlqUDrAgZ1R2D?=
 =?us-ascii?Q?6ichxdTf2ZqjcVzt2/Mb5wIG5yFQPTBuHEBKfuXcc9xibX7EC7bAhcWP7S4b?=
 =?us-ascii?Q?RddqycQ4yQ29tqRKCXhXDE4Vm3eX4wrYbH5H7wmg+WaqhpEUKfbtKGCidXwX?=
 =?us-ascii?Q?OsGnhgcXaszyYsx47utfGYRpchyzHJaG5wudm1pjwBjkfmd18nLQIKjgmOc/?=
 =?us-ascii?Q?+lCm+y8jrYTIxr2xr1SNzFBk1Ypqnpu5VBXYoNbBB1QoX3lUboCorHGsO+Kb?=
 =?us-ascii?Q?IyjAizvZ4jKBoOFMLduHNx6VGGZ1RcLIAq2KZFh4KzPW1xV0EIyXtFoHA8Vc?=
 =?us-ascii?Q?WY3ERmvZWUjGV0DnvB+z0dkyR7xSINl3t0WlaqPVp3hPJKbILVC/bAG1/XT7?=
 =?us-ascii?Q?1adNANtcAvbJ1gDhQoPVwBkfEkaj2w9IVgrl3ItSxYxhTlcqOOMuDf1g3F2I?=
 =?us-ascii?Q?qTy4Z+Z5cqwSbf913+rP8G++23fNi915bCMPwtXFV/FQ7gCOnijcVJH20+A5?=
 =?us-ascii?Q?wYKqEKJhNhNNzS2TDg0g4W1h/mRe7MvPBTvBC8QH?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dc573aea-51c0-4f49-264d-08dbbaa049e0
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB6004.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Sep 2023 12:43:01.2249
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lBHjn0K46FW4BlUJfgD6ZcfY9lbsi7I9mIs7mzf2L8lJmJdKSWudoFWSZ4y/HZVCm068x8+qdOdXoc3Q8BtKAQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB9776
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,T_SPF_PERMERROR,URIBL_BLOCKED
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

key buffer is not copied in chachapoly_setkey function,
results in wrong output for encryption/decryption operation.

fix this by memcpy the key in caam_ctx key arrary

Fixes: d6bbd4eea243 ("crypto: caam/jr - add support for Chacha20 + Poly1305")
Signed-off-by: Gaurav Jain <gaurav.jain@nxp.com>
---
 drivers/crypto/caam/caamalg.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/crypto/caam/caamalg.c b/drivers/crypto/caam/caamalg.c
index eba2d750c3b0..066f08a3a040 100644
--- a/drivers/crypto/caam/caamalg.c
+++ b/drivers/crypto/caam/caamalg.c
@@ -575,7 +575,8 @@ static int chachapoly_setkey(struct crypto_aead *aead, const u8 *key,
 	if (keylen != CHACHA_KEY_SIZE + saltlen)
 		return -EINVAL;
 
-	ctx->cdata.key_virt = key;
+	memcpy(ctx->key, key, keylen);
+	ctx->cdata.key_virt = ctx->key;
 	ctx->cdata.keylen = keylen - saltlen;
 
 	return chachapoly_set_sh_desc(aead);
-- 
2.25.1

