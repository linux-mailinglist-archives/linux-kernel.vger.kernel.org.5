Return-Path: <linux-kernel+bounces-29950-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CA7FA8315B6
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 10:26:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 585151F26AC2
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 09:26:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E44D31F94C;
	Thu, 18 Jan 2024 09:26:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="I/+GY3U8"
Received: from EUR02-VI1-obe.outbound.protection.outlook.com (mail-vi1eur02on2075.outbound.protection.outlook.com [40.107.241.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A140E1F61A;
	Thu, 18 Jan 2024 09:26:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.241.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705569986; cv=fail; b=EIwZkCabSM8/KBZkbN/UTfSjbdMRHNkhOEk8Sb2HRMk1JxAjAe1pC6SMSmbxsgwhO6w3ufpL1CcGiDEqmom7S45iQeUeKhO0WyNtb8dDktxGScVCR2KMirH5Q0LZ2nb9dbfTM1aNR7YxIE5g2A17ef4rDT7ejvujP9gyGxA6iqo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705569986; c=relaxed/simple;
	bh=HV2OYZoAQuVwoPaY/aFacpMi6JUAvzuniR9Zun6gdnY=;
	h=ARC-Message-Signature:ARC-Authentication-Results:DKIM-Signature:
	 Received:Received:From:To:Cc:Subject:Date:Message-Id:X-Mailer:
	 Content-Transfer-Encoding:Content-Type:X-ClientProxiedBy:
	 MIME-Version:X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:
	 X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped; b=L2Hp12hV2poh+hGCz83rZ8yzvqt3iWvTJLs4pcFntHEGJ/pclZGzSA6zOFshkdkE19u7qJtn9AhyY/SV+HpBVYZfrN5yfzQS+mqGvYNLYlRQhBwLONoeNpb87g3rTKNtT7hNAjqzizs5TRECoFxA4Nwtj8qP9MOYg/Sk/9/szU4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=I/+GY3U8; arc=fail smtp.client-ip=40.107.241.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CUsUJjhUAb0sTZzYuGepQw0up6A2XcpZLH4RciJ82T9GTCuQAe2mODKs7WkqyUTph/6SyJnOpZExs3/ZYftVvYKk8Bw7B1qZcSzNUdRlFEdeQPtTCaWPBU1+cW2vilARsWG63zvyw0v5Qt5JdkPqdl7i0E9IPRdQxPxd6UBRS4nBwzpfLInKYGCMeUR0wOJawAdYOC8YXIlD5GHIrXuQn/xsSYFSjPkMtsSc2hF6YfmyQycW4/xGJDyUETmBo1GV0+0kB4pH6JLBvN2RSohgJxIiyWU6oY9Jno72/tKijFh+dgcODx++IUAku96xYoqe1ef0Ye/NmEyR63HO29Zz8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9/78O/Nxskh+s/21jMgZg1nRMLGhBlacJQgfjiUl8Fo=;
 b=ixvE3SV64u2gCir7kCzdxrxpdQFvbbqNL2wrOGZJPAm4qZYIopgOUEf8KymeYU5zfLu4kiFm8ZWrnj1p95ZliKu6ql9EPWLjUNdKPa/VsNxp4QyZKw2OosnohuaPRHx7gW/yABI3RZvN3qqwA4r+Qk0yCEPeNIfgj59cQjZn+i6DVOlIF9iss1BkkvjyGK4Kieer+g5815MLbnpxJl2xgArnQNowmbf9f0PoEwdgTezYIKp+gwXkJ/sNxLyZbmAhacnet5hu30vM3ys1pl7aVsb/tPHSXcDAOnyk5kc2LvMEuSy6aZszFPQYCr2HcIiML9UiMdTOvPB+s/HDNPZu5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9/78O/Nxskh+s/21jMgZg1nRMLGhBlacJQgfjiUl8Fo=;
 b=I/+GY3U8G5gMMyehGrczoM9RbYKGqj9GMS0d5utO++zQX2U2ZO4ISWSyb0O8WJhpd9jltpojtxZaQTN9zPF8heehV+KrtliVqUM1INgRqNRCCoNB0W6KOrALlp/T8i5ytVei05M+1Na/twZGi6THldoLheS4XvhNNDQRnZoNnck=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM0PR04MB6004.eurprd04.prod.outlook.com (2603:10a6:208:11a::11)
 by PAXPR04MB8318.eurprd04.prod.outlook.com (2603:10a6:102:1c0::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.24; Thu, 18 Jan
 2024 09:26:21 +0000
Received: from AM0PR04MB6004.eurprd04.prod.outlook.com
 ([fe80::72db:548e:8011:b12f]) by AM0PR04MB6004.eurprd04.prod.outlook.com
 ([fe80::72db:548e:8011:b12f%5]) with mapi id 15.20.7202.020; Thu, 18 Jan 2024
 09:26:20 +0000
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
Subject: [PATCH v2] crypto: caam: fix asynchronous hash
Date: Thu, 18 Jan 2024 14:55:57 +0530
Message-Id: <20240118092557.1891120-1-gaurav.jain@nxp.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2P153CA0015.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:140::21) To AM0PR04MB6004.eurprd04.prod.outlook.com
 (2603:10a6:208:11a::11)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM0PR04MB6004:EE_|PAXPR04MB8318:EE_
X-MS-Office365-Filtering-Correlation-Id: 3bf15599-6933-4e91-7b85-08dc18078808
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	8ceySESdu0g1yKUH9xTOoFo65VWgRBk8znChz78VoWHkDcMTk0zyRFQ7WaVd6umq2xqmbHVE6cmkrEsclhFM/rWzf4GxzepQ8j6c+ztZ+hbg8NxOwLXZA6VZ32MEZAkaTpqZCsMRTE988H1S8kirjzJTvpCwdmQD3raAzQt9wn1Abwfe3VNKWZKl0gRs1WteMiGhSHNSTSb+VvQr/EuyH4Rl5qkIIrBXnDx6af97KWmhQvXpYKpHX2dRe4+FXLOSwqTcVwePtf7qkrCs+qaG+P7A8c5COxpVFA1/9f7lH/bhWsihpBFhNVnMuJ4hPNbRXSDJAkFW9kNCkBxrrb9TPsgPuIgPuZPHsqOkd05lKt1O1ogXMDTyFb5DRfKTSo1otf1D300x0Pw9OkR1eUXIteWDYcN4LCWIL9quTcZt7FS6jAG/Aykv5KbQeRkEdrHBORnODQTZicBCx/NUWaq0b0D858MgTHS7gl0QEX6QT2NG4GZElX0NsVFC1oJF6VecMJVYxDe0yGOwFNSGLmlUUJpGx8kTBx67mRZj7iknVyHrKzas6UdeAzHhx8Qi2U9Tml4kBPMHmdOS2CR4RPypo1aeQ0eHFdP01pWtCDdFg1Fgd26dME5No0DoY/FO803H
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB6004.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(376002)(136003)(366004)(346002)(39860400002)(230922051799003)(64100799003)(451199024)(186009)(1800799012)(2616005)(52116002)(6666004)(6506007)(6512007)(26005)(1076003)(8676002)(8936002)(316002)(6636002)(66946007)(66476007)(4326008)(54906003)(86362001)(110136005)(5660300002)(44832011)(6486002)(478600001)(66556008)(38100700002)(83380400001)(38350700005)(41300700001)(2906002)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ikAfnhuXgm6zfkl2qxZkMKz4yoIds+j/ZRyAjBqG3l/LOhx11FLjTXdS1yTS?=
 =?us-ascii?Q?lMs+n+uhfnrNqNSMpf4C3Tka2S1Gtn+zOwh6sDrAYzKRUMFC0UDpL3DFAXhT?=
 =?us-ascii?Q?dIwHLxIgHkI6SRJ0cfBsNJB7N9H5xoDMeSsHJ0uQgM71Fay2W8JzkVqbSRnp?=
 =?us-ascii?Q?UXl+XJeg+8A2LQp2uyd93W+6BibJvWwgLWgGee/dFD+V5WIJh0W2RWLzLvxn?=
 =?us-ascii?Q?HPXuP0j7yO5tT5rKtFJNs3iEkT392Bvl1xIoThv9Njs6kkm6yJ0viOrc9g5Q?=
 =?us-ascii?Q?bkpfj2fzRFtk36DBCB0mLqRZYW3ACAiKSaXlAGhcguH4xD+leJoRzKctzrMV?=
 =?us-ascii?Q?KTBtrECYjnPaPdRlTa8EmiJP/KTQXZ7+lscgZFMkIeXrzbLpHYYOUWM08YaX?=
 =?us-ascii?Q?I5D3jqCBzltdQvtTEZIF61VUevL8FyPdnx4l1uZT9UZoHk/8x0Ee08fECgAv?=
 =?us-ascii?Q?vQqySYxRJXHc/k4uj0lHbLUVbnq7gXenIq6sj15davhvjc1hKyX5ctOulUwt?=
 =?us-ascii?Q?KLadmRhN67Aj25Fei8N+80qHpapLUN3yMDA0dWAS1uukAq/+bBlDbQxaQbIq?=
 =?us-ascii?Q?CWCvwOfzQVcq6RqXEXTUHXZG8Cw76/twzcCTDzj9lqicphywC65tLCbmcAdZ?=
 =?us-ascii?Q?4TTW4d6wZ50JcIjJUDA/FLFs2KC1Fr0lkdsldU9QQNtv99htgVuXOdEAgxUd?=
 =?us-ascii?Q?ZrJcpC+cpbpB5jIal2hYanGB3eAKKqB0ZfAtIpfWkvcp1xcnBkHtfvbyIIyY?=
 =?us-ascii?Q?CyY+mZxMR6nsG7LEdWLJ5WcyjCeOq5dRlyBYrmRn1OTM/yEDqniR912q1Ry3?=
 =?us-ascii?Q?FM8xN1HOHLiRs38Ih46Bu0Lx2RlYxmLDLfKYULgqtiEMAdl/U7bk1yaQiLPC?=
 =?us-ascii?Q?n53TDb+gdFWj1bzBSfe2+zebdGLhv3CvREk9MPgFkCrPOqk+A7O//0HCIhX6?=
 =?us-ascii?Q?oJqwHW4Mx2UPKTh4hvu6RLbEIfyKMSilmdOLHHZ7p1SescwyGlMy1fZgXvIt?=
 =?us-ascii?Q?HwvlTcqj+DLSIcgkAX0Tkc3FXT2X1zA9Ns2HB4bA71wp0JjjvxbeguVxRsda?=
 =?us-ascii?Q?KkWRDIA4lbK//H1VUwQ1Vnjuch3X57rsMHkCL8ZTEiipBCgZ8gz0WTPlu6MR?=
 =?us-ascii?Q?K3DntjqtG74ZqNWMJ3TFwAbu7wVw0Prm7VwnBQRjOe1r3XFQc/ZUvf6yKRWf?=
 =?us-ascii?Q?bJMjyyy4n1V7GNhC7akIIvbQaMkSQW44f4WZSYw9j1qOAUWHj4vGVrKHJWVA?=
 =?us-ascii?Q?uchezAMF91bUTind2rgP1tb+HvAKekVOyLdKnn2krPFWMlofP0kZwBEBONJ9?=
 =?us-ascii?Q?+MKanYHC4owLK0LAZmEh/mxQ7Rqlvn/eyE7MxpNdA9xrl9FDGXYUNwi5W71E?=
 =?us-ascii?Q?FxGbs4uiOilolB7DYg8nhgcXfVRvdiLZaLkp1yWrYxbDgI8cvUBxidR/sxQ3?=
 =?us-ascii?Q?SJLIFUKhmlKlTgtiVk6RBNtKKRomHVrDMh/FR3VsSzbY2LHM5VRbQiaB5TpF?=
 =?us-ascii?Q?V/ZYqHc4iOZhdN76gf2KRRrFrAdWt4W/3/IiA4A4LVxAfYfwf3VGp5Ffjdc9?=
 =?us-ascii?Q?IL5qj5ToG0qLpd9RPGVSqiAgevHoFlCAKSQZFeDj?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3bf15599-6933-4e91-7b85-08dc18078808
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB6004.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jan 2024 09:26:20.7968
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: n/XIcqV1YYEoOq5OeNCwJnuu8Aj9M4AwH8wV0XCl+88S+sUe9waqjb98sJvJH/4P3Mbv3xLEedKI8qXQuSO9Vw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8318

ahash_alg->setkey is updated to ahash_nosetkey in ahash.c
so checking setkey() function to determine hmac algorithm is not valid.

to fix this added is_hmac variable in structure caam_hash_alg to determine
whether the algorithm is hmac or not.

Fixes: 2f1f34c1bf7b ("crypto: ahash - optimize performance when wrapping shash")
Signed-off-by: Gaurav Jain <gaurav.jain@nxp.com>
---
changes in v2:
	- remove if condition based on crypto_hash_alg_has_setkey() funcion.
	- added is_hmac variable in caam_hash_alg and updated the if
	  condition for checking hmac algorithm.

 drivers/crypto/caam/caamalg_qi2.c | 7 +++++--
 drivers/crypto/caam/caamhash.c    | 7 +++++--
 2 files changed, 10 insertions(+), 4 deletions(-)

diff --git a/drivers/crypto/caam/caamalg_qi2.c b/drivers/crypto/caam/caamalg_qi2.c
index a148ff1f0872..a4f6884416a0 100644
--- a/drivers/crypto/caam/caamalg_qi2.c
+++ b/drivers/crypto/caam/caamalg_qi2.c
@@ -4545,6 +4545,7 @@ struct caam_hash_alg {
 	struct list_head entry;
 	struct device *dev;
 	int alg_type;
+	bool is_hmac;
 	struct ahash_alg ahash_alg;
 };
 
@@ -4571,7 +4572,7 @@ static int caam_hash_cra_init(struct crypto_tfm *tfm)
 
 	ctx->dev = caam_hash->dev;
 
-	if (alg->setkey) {
+	if (caam_hash->is_hmac) {
 		ctx->adata.key_dma = dma_map_single_attrs(ctx->dev, ctx->key,
 							  ARRAY_SIZE(ctx->key),
 							  DMA_TO_DEVICE,
@@ -4611,7 +4612,7 @@ static int caam_hash_cra_init(struct crypto_tfm *tfm)
 	 * For keyed hash algorithms shared descriptors
 	 * will be created later in setkey() callback
 	 */
-	return alg->setkey ? 0 : ahash_set_sh_desc(ahash);
+	return caam_hash->is_hmac ? 0 : ahash_set_sh_desc(ahash);
 }
 
 static void caam_hash_cra_exit(struct crypto_tfm *tfm)
@@ -4646,12 +4647,14 @@ static struct caam_hash_alg *caam_hash_alloc(struct device *dev,
 			 template->hmac_name);
 		snprintf(alg->cra_driver_name, CRYPTO_MAX_ALG_NAME, "%s",
 			 template->hmac_driver_name);
+		t_alg->is_hmac = true;
 	} else {
 		snprintf(alg->cra_name, CRYPTO_MAX_ALG_NAME, "%s",
 			 template->name);
 		snprintf(alg->cra_driver_name, CRYPTO_MAX_ALG_NAME, "%s",
 			 template->driver_name);
 		t_alg->ahash_alg.setkey = NULL;
+		t_alg->is_hmac = false;
 	}
 	alg->cra_module = THIS_MODULE;
 	alg->cra_init = caam_hash_cra_init;
diff --git a/drivers/crypto/caam/caamhash.c b/drivers/crypto/caam/caamhash.c
index 290c8500c247..fdd724228c2f 100644
--- a/drivers/crypto/caam/caamhash.c
+++ b/drivers/crypto/caam/caamhash.c
@@ -1753,6 +1753,7 @@ static struct caam_hash_template driver_hash[] = {
 struct caam_hash_alg {
 	struct list_head entry;
 	int alg_type;
+	bool is_hmac;
 	struct ahash_engine_alg ahash_alg;
 };
 
@@ -1804,7 +1805,7 @@ static int caam_hash_cra_init(struct crypto_tfm *tfm)
 	} else {
 		if (priv->era >= 6) {
 			ctx->dir = DMA_BIDIRECTIONAL;
-			ctx->key_dir = alg->setkey ? DMA_TO_DEVICE : DMA_NONE;
+			ctx->key_dir = caam_hash->is_hmac ? DMA_TO_DEVICE : DMA_NONE;
 		} else {
 			ctx->dir = DMA_TO_DEVICE;
 			ctx->key_dir = DMA_NONE;
@@ -1862,7 +1863,7 @@ static int caam_hash_cra_init(struct crypto_tfm *tfm)
 	 * For keyed hash algorithms shared descriptors
 	 * will be created later in setkey() callback
 	 */
-	return alg->setkey ? 0 : ahash_set_sh_desc(ahash);
+	return caam_hash->is_hmac ? 0 : ahash_set_sh_desc(ahash);
 }
 
 static void caam_hash_cra_exit(struct crypto_tfm *tfm)
@@ -1915,12 +1916,14 @@ caam_hash_alloc(struct caam_hash_template *template,
 			 template->hmac_name);
 		snprintf(alg->cra_driver_name, CRYPTO_MAX_ALG_NAME, "%s",
 			 template->hmac_driver_name);
+		t_alg->is_hmac = true;
 	} else {
 		snprintf(alg->cra_name, CRYPTO_MAX_ALG_NAME, "%s",
 			 template->name);
 		snprintf(alg->cra_driver_name, CRYPTO_MAX_ALG_NAME, "%s",
 			 template->driver_name);
 		halg->setkey = NULL;
+		t_alg->is_hmac = false;
 	}
 	alg->cra_module = THIS_MODULE;
 	alg->cra_init = caam_hash_cra_init;
-- 
2.25.1


