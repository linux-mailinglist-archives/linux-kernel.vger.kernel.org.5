Return-Path: <linux-kernel+bounces-27196-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D4BF82EC0F
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 10:47:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D4949B23E27
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 09:47:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5DC812B8C;
	Tue, 16 Jan 2024 09:44:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="CeSxxNMp"
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2089.outbound.protection.outlook.com [40.107.22.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D33D4134D7;
	Tue, 16 Jan 2024 09:44:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PrC56yTD6pbnbKRp8Edv5mEPhVaGo0tHnPqbXkx1ePg112cOejfQmGq3Jr+7vxfICOu4mSaFQj6BheL9V4qESqY9BFKOH9EM4YxmXOTUR3tAzEzSjUZwh6wWbNMBkBYrp1hI3EIk0/CwYEOuIeTHlIwpt7RjqdMo0TUVFBjfkTZgtwhHng2VO1NmQzyaRi9/Gpwiz3tWQps4amkS8F3VW48gVHFyomjAS/SklcTpV98239PZNhDjby/QtO8F9axuhck0SqSc1CYJVjYjHDSJyd2pLXuDIuH5fVZrXT0uigwqhJKVU/l2SjMlx3dMYMYbpmvWsFR3OfDnunFmVYmPqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=atlg8dxnphJL9TCY0wetHzfuFq0SbE3ZSHivqTkOpEs=;
 b=MoCp/joI1lcQ+PvwJ3/vI/cfLDpRSp9JH3/IN9cpYy1L2+saq1EkhhnqNdBKgp08Y9WRTkyCAx8Fyw9xRs+09xVKy60oi9WbJ4Gmm1QtDQO/xuLvhFy1A7t3/MWZPMDP/C6L56sh9OinsW/x/6pkj+E8DnyGfMTQcxcSOF530SmofAs755D/SPNXUk5ewkDzWx7rf4omraQYJ4niJfouLrT7xJ1jDWv2jaQHHDss27C38cIBcYgPxKiolNbaxknAEETUG8TnWKAaVGlwj6zBcltLjCsdrJk3txsjwXZzLVfsUZFMrsckV8qId41P1AN6qRwh8apTSaVczDSTD0H9pA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=atlg8dxnphJL9TCY0wetHzfuFq0SbE3ZSHivqTkOpEs=;
 b=CeSxxNMpH82SdCmPRc5lp0GMj9rHqZD4k4zfPOxq/agsagSPWH/czYuc5J3GQQG+R/MH3A2OP/7pPONHu/jo2Jx4p811f/vZVMuWvaJzmRLpOZguzzq2wDaLPE3gtQIpwZoRrWQPIuxZV+jGhtv5A9BnBAUC5usk++lwB7jLZW8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM0PR04MB6004.eurprd04.prod.outlook.com (2603:10a6:208:11a::11)
 by AM9PR04MB8337.eurprd04.prod.outlook.com (2603:10a6:20b:3e8::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.29; Tue, 16 Jan
 2024 09:44:28 +0000
Received: from AM0PR04MB6004.eurprd04.prod.outlook.com
 ([fe80::72db:548e:8011:b12f]) by AM0PR04MB6004.eurprd04.prod.outlook.com
 ([fe80::72db:548e:8011:b12f%4]) with mapi id 15.20.7181.026; Tue, 16 Jan 2024
 09:44:28 +0000
From: Gaurav Jain <gaurav.jain@nxp.com>
To: Herbert Xu <herbert@gondor.apana.org.au>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Biggers <ebiggers@google.com>,
	Horia Geanta <horia.geanta@nxp.com>,
	Pankaj Gupta <pankaj.gupta@nxp.com>,
	Varun Sethi <V.Sethi@nxp.com>,
	Meenakshi Aggarwal <meenakshi.aggarwal@nxp.com>,
	Aisheng Dong <aisheng.dong@nxp.com>
Cc: Silvano Di Ninno <silvano.dininno@nxp.com>,
	linux-crypto@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-imx@nxp.com,
	Gaurav Jain <gaurav.jain@nxp.com>
Subject: [PATCH] crypto: caam/hash - fix asynchronous hash
Date: Tue, 16 Jan 2024 15:14:05 +0530
Message-Id: <20240116094405.744466-1-gaurav.jain@nxp.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0021.apcprd02.prod.outlook.com
 (2603:1096:4:1f4::14) To AM0PR04MB6004.eurprd04.prod.outlook.com
 (2603:10a6:208:11a::11)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM0PR04MB6004:EE_|AM9PR04MB8337:EE_
X-MS-Office365-Filtering-Correlation-Id: db7e6c08-eabe-4a4c-9bae-08dc1677bb4a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	jWqdXcRIxZJwQagwpydcWm8PWU3PRJA2Oap6h3qGB4/YnyOQB4Og27WxE/k0tN+1SHygd7MNqtGmMR52zKaH1n/G5Ud61fth2grBKIVkkE9tUkNZNzV0J6G5JJg2nw4iFLYjrvmPxw0K8EhkNQaGeTIVkgiXwiEaI+TZokXU+u1F3MUzEmP+qow0px19KftQxrHg33b4Fk5Ln7r0EcFMY1uYmObskfZxDV7OUOL29J8jiuJ+H5SL0GFQ1l+P2UWZPxz0YQL62f/WsUWHH+LN45abaFXcGtM7cOp7RMM9U5zzk+UVjD+vJkGxxTjdbdYWihcOlI3p1leuims3sx0jkhjT7/9/OPdGaOktYMIKoPefEwkFFUcizKuMVE1MAVl91efFOFccDfnUKqCEDrD3xCRHL5XQwv20QFUlwfa8TAUAckgcU4UdWA3CWMh8Ds4clU/9yPYD+PGHHhuqth3Z08BIFOF9YHg9azI7KrOsSFjMQ7951tlsd+c1M5cJjnuv+Zj9RjRQeALU7TkXXJYO55mSh9vuXDk1N+WC/lEwuYlk9DBVnCyvjHxQBMzroNEUCEcNSMFT+VZ2d1IhRct14JmXc5igaTqqZpK2JXgMcFQrLifsfY1ljpb8dT5rUn/r
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB6004.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(376002)(39860400002)(366004)(136003)(346002)(230922051799003)(186009)(451199024)(64100799003)(1800799012)(41300700001)(38100700002)(83380400001)(38350700005)(36756003)(86362001)(44832011)(110136005)(66946007)(316002)(54906003)(66476007)(66556008)(6636002)(8936002)(2906002)(4326008)(8676002)(5660300002)(2616005)(1076003)(26005)(6486002)(478600001)(52116002)(6512007)(6666004)(6506007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?AFZpKaINR7bduMezTGwOpFeQYhsSxfDBHwFMSTI/e5qYzf8wPOlczWVZlR/A?=
 =?us-ascii?Q?lrIiPheUqJG7gF7pPOHR40l+g0j18euVz3lCmsfL43t8PtbCGMGsIyXn0Hng?=
 =?us-ascii?Q?n3jGSTT0F5ujTsa6JIs4mGZUadGbAkkewpElpvx5Bmfxt8hI4SS4Po8fN4ci?=
 =?us-ascii?Q?t7nffw/q5apBavHpVocSgDmVxVBahMJ7c55hclFCc1SlWXIaecNxt1ACeU3s?=
 =?us-ascii?Q?/D5Lhq+RVxgq9n78YdKw5O8K6nu0TtDZ1eIVAdLX23/Lm2N3iXi/yLizNtY7?=
 =?us-ascii?Q?pvbnBa2a4b33ad0IGWoVRUICWo1+Bh0LAuK8Ndt3cnR/vq3J82bYc7dIU388?=
 =?us-ascii?Q?RuRpY+Rny0nc+OmFuAwsz4DMh9wFPOJVyHc68N6Oo4pUUkJNxPpxZH8tnpdb?=
 =?us-ascii?Q?Fooace5+P0I/7MmgNwf+m2VcFU8NkUzwd4sV2VeDVzmfaJ9RWy6poxcLYoki?=
 =?us-ascii?Q?VrY9HHbcmLNjdfjBZpbixCcFS8xSpu2SNwqSPyRWgVPOXPRZ3C82P3+qYN07?=
 =?us-ascii?Q?TNC5bh+9gFDLXR4g+aednx/EkvSfGsuTjfTIvXi7UdXaEnqlySkv8a35HQUX?=
 =?us-ascii?Q?kIBBI1p+mmUQSlyyemRhOfRnDR++TvbWbzDuMty6O5tJKg8sBhmp4zGzRwjD?=
 =?us-ascii?Q?MQDHlz7pAggqmaBGjRMdPeWkNF2staCdRymRCnQA5iJJXxkvGCJZHz14Rv8c?=
 =?us-ascii?Q?TB2MtEAYdAupynsVocoqFO4PmdPbDtDJy1PCtghi0f4uee+LU34EtT0Hadxr?=
 =?us-ascii?Q?1F3JxRR7ZKkYst0Nvg9I2F/xjgG/VNXIYQbofuQi5Gpdr8l35Bp7YsZsJyeP?=
 =?us-ascii?Q?UKNkyBgHEsFPgH+lhuTZh/5v24hNJUD8I8eEprbwae6wgFEuvN6CUDmLA0jD?=
 =?us-ascii?Q?/TOFKM1TumDTSn8VvaChqpq8c/9JzJLexKMbeAKEqwa2c9G578+1mTjWSP6S?=
 =?us-ascii?Q?i1FTxSfDOehhCXIoNx5C0i0mM4UXf3ud8eut51bHtJxKoLzmzlZzqCoodL9C?=
 =?us-ascii?Q?WyIh5Pa9QkAot3o3d2++DGhDpLuHvJYtaqvcXqJxoEIs0GSOidekOaHSC5g6?=
 =?us-ascii?Q?pk+Msb6/epxh9VcT68OqZo4ofPqx3N17bWSImo8bKlOsybA/fry74PCZQ9mg?=
 =?us-ascii?Q?0sKvPWYBZMYrXVuN9IrW7TFJSeYE3ctjfXhey4I1vg6kRfae5gzJ/535KoPL?=
 =?us-ascii?Q?CIzPLCw780siwe02I+kxNCbEwwt6hYOXpmGrLoxdOz2uWHPlf4jvdO/2PmLM?=
 =?us-ascii?Q?kjiUgVpmE9aHb9b6NbnZpkGKWZQfSF9tlqvORpVrevfw1hwuRpuo2C7GyTyE?=
 =?us-ascii?Q?GLi7Cm3YHfEJIptc5zgMtGVM+hDfunP2ZJi1ebDQL+6sDnhfCTyigHS5L1bP?=
 =?us-ascii?Q?LA67fsavmy+/QuLx706SNVXIBHNsRegQCwFuQGbMSGgJeAsNtAZODEa8UMVC?=
 =?us-ascii?Q?dSq9BH3K2cfAp8/MvTMGnFAEcxNGt2lvd4vrtoK84BxMTOdpuun3AxNAPZWJ?=
 =?us-ascii?Q?iPnKzESRAXT18r54ahyYhtNA4YDaIYdgy50FugMbXUTpp81aNjgRjv7QMurH?=
 =?us-ascii?Q?WsLlKdkzfo3fv9WwNMVVBLjoEWWZ9t51d3xSIZ3y?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: db7e6c08-eabe-4a4c-9bae-08dc1677bb4a
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB6004.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jan 2024 09:44:28.0733
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gIrFBVEBXdqgSmQ5nxqJekxw1BAmeAacBmm6mqgqL/Y3T1R3rmdct4VI21Z3MhNKnMYqiyh20s46flOJhWNNHg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8337

ahash_alg->setkey is updated to ahash_nosetkey in ahash.c
so updating the handling of setkey in caam driver.

Fixes: 2f1f34c1bf7b ("crypto: ahash - optimize performance when wrapping shash")
Signed-off-by: Gaurav Jain <gaurav.jain@nxp.com>
---
 drivers/crypto/caam/caamalg_qi2.c | 4 ++--
 drivers/crypto/caam/caamhash.c    | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/crypto/caam/caamalg_qi2.c b/drivers/crypto/caam/caamalg_qi2.c
index a148ff1f0872..93a400e286b4 100644
--- a/drivers/crypto/caam/caamalg_qi2.c
+++ b/drivers/crypto/caam/caamalg_qi2.c
@@ -4571,7 +4571,7 @@ static int caam_hash_cra_init(struct crypto_tfm *tfm)
 
 	ctx->dev = caam_hash->dev;
 
-	if (alg->setkey) {
+	if (crypto_hash_alg_has_setkey(halg)) {
 		ctx->adata.key_dma = dma_map_single_attrs(ctx->dev, ctx->key,
 							  ARRAY_SIZE(ctx->key),
 							  DMA_TO_DEVICE,
@@ -4611,7 +4611,7 @@ static int caam_hash_cra_init(struct crypto_tfm *tfm)
 	 * For keyed hash algorithms shared descriptors
 	 * will be created later in setkey() callback
 	 */
-	return alg->setkey ? 0 : ahash_set_sh_desc(ahash);
+	return crypto_hash_alg_has_setkey(halg) ? 0 : ahash_set_sh_desc(ahash);
 }
 
 static void caam_hash_cra_exit(struct crypto_tfm *tfm)
diff --git a/drivers/crypto/caam/caamhash.c b/drivers/crypto/caam/caamhash.c
index 290c8500c247..4d50356b593c 100644
--- a/drivers/crypto/caam/caamhash.c
+++ b/drivers/crypto/caam/caamhash.c
@@ -1804,7 +1804,7 @@ static int caam_hash_cra_init(struct crypto_tfm *tfm)
 	} else {
 		if (priv->era >= 6) {
 			ctx->dir = DMA_BIDIRECTIONAL;
-			ctx->key_dir = alg->setkey ? DMA_TO_DEVICE : DMA_NONE;
+			ctx->key_dir = crypto_hash_alg_has_setkey(halg) ? DMA_TO_DEVICE : DMA_NONE;
 		} else {
 			ctx->dir = DMA_TO_DEVICE;
 			ctx->key_dir = DMA_NONE;
@@ -1862,7 +1862,7 @@ static int caam_hash_cra_init(struct crypto_tfm *tfm)
 	 * For keyed hash algorithms shared descriptors
 	 * will be created later in setkey() callback
 	 */
-	return alg->setkey ? 0 : ahash_set_sh_desc(ahash);
+	return crypto_hash_alg_has_setkey(halg) ? 0 : ahash_set_sh_desc(ahash);
 }
 
 static void caam_hash_cra_exit(struct crypto_tfm *tfm)
-- 
2.25.1


