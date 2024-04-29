Return-Path: <linux-kernel+bounces-161794-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DB3CC8B515D
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 08:24:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AFA16B20B43
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 06:24:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6547C10A3F;
	Mon, 29 Apr 2024 06:24:44 +0000 (UTC)
Received: from CHN02-SH0-obe.outbound.protection.partner.outlook.cn (mail-sh0chn02on2115.outbound.protection.partner.outlook.cn [139.219.146.115])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D30610A11;
	Mon, 29 Apr 2024 06:24:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=139.219.146.115
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714371883; cv=fail; b=s9Az/xMFGKCwzkGLJ3zF2EY6vkEoGZM9GqumMjk/su8nAGqoKpz+Z6g+kd+rDyC2QCgxnItw5Tn+HuEeG84UN3Qc/ueUR8Po7pytb24VPAw99Y27xwOSEPlnVgwk20u7QAvTA1xXMmmr5BZE1m+817jXj4iF1pxL31oyCg2BoX4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714371883; c=relaxed/simple;
	bh=maZhgDeKqbNUXkXdpo3ZLGQ2Mee0FReMMahW4cVzHwY=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=dKpMmgZnX2Mv3qiaEYFQ3ARCOznVQMhOySCstghtR/M6rs5NacPpEKnPfAsVOhkADdn/dL+2DnYJTWE+0d2ycKXZtc9lQkjnq0DEbS7m4gp0yJ5S612ZK5ir6TzSXkMByMvMNDWacD0Vs/xnAkUiStIRl/sVcKnmAClKY4jYE6Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com; spf=pass smtp.mailfrom=starfivetech.com; arc=fail smtp.client-ip=139.219.146.115
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KrL0eLw9xvDbg7+GrltKGmxec7pHfLrGR5sDjSMHFr39w5TkkNYrzpzRXwMn4D/35XXKTpZE4mrecBSnvxXsoohMCpXFtliWLexN3zYqBU+xVQf1oDE32TnuCfMorErEzZpXYnP4vL9wd0pePvvVLokhxJcPrW5s/7xV0Aw58RLi9W62/rswv6f9Wxi7ijfDJQoTnOHRBj6Cmm3SkcDytwBdCNR2t0QDMcvD8dsTbkPo8EOj1aD+hKhV2XfV+g/XkfRWavuFzwgtFgHEEEUqTI7jJ32vzbNNv6+mSPQ60sTuirzfMAUyD5E7I6OTYwqVQJDUSSUfrgqFJixRrN9IYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=P9WRIevlXzXGfV9fREZSLXfmxGzgQXE2xWcgpZ64jc0=;
 b=c9wel4YJyeERx6Bu/DRE5RGNPiOepQk/WyIUai8h5xIHjJqgcSGVwQJMWoML+2rz7TCecHACET/f29wVTBP/wG/JLsYizdCE57KwQe6060Wgjlfjs/921CrQxN6EJNXpET92IZzXLL4fYQ8LeszhawYugwRe4nDiCCl49+5mlW8O1dpVz27Ds+VFkawFdPXRdjRhvhxm5WCMI0ZfYtrEgqofTtCKsxSIVmpkrRgGrtBLlRLWPF11DjZF/UINvHHc6z1aYHBeWB6kvfXsLKLJX3htLAyKagRKAvNJmNaUydi07+HhARzcpImA8EzK76dvvOeNZ6j2d30kNoEJe8AY7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
Received: from NT0PR01MB1182.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c510:10::10) by NT0PR01MB1278.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c510:12::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.44; Mon, 29 Apr
 2024 06:07:59 +0000
Received: from NT0PR01MB1182.CHNPR01.prod.partner.outlook.cn
 ([fe80::3dc9:e0c9:9a09:3bb7]) by
 NT0PR01MB1182.CHNPR01.prod.partner.outlook.cn ([fe80::3dc9:e0c9:9a09:3bb7%4])
 with mapi id 15.20.7472.044; Mon, 29 Apr 2024 06:07:59 +0000
From: Jia Jie Ho <jiajie.ho@starfivetech.com>
To: Herbert Xu <herbert@gondor.apana.org.au>,
	"David S . Miller" <davem@davemloft.net>,
	linux-crypto@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH -next 4/4] crypto: starfive: Use fallback for unaligned dma access
Date: Mon, 29 Apr 2024 14:06:40 +0800
Message-Id: <20240429060640.2451685-5-jiajie.ho@starfivetech.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240429060640.2451685-1-jiajie.ho@starfivetech.com>
References: <20240429060640.2451685-1-jiajie.ho@starfivetech.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: ZQ0PR01CA0034.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:2::12) To NT0PR01MB1182.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c510:10::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: NT0PR01MB1182:EE_|NT0PR01MB1278:EE_
X-MS-Office365-Filtering-Correlation-Id: 072da6fa-cfa0-47a0-46d8-08dc6812b888
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	QqDa0avpmy2y2BitlJePYIX/h5kv0gBJ5UPCO+D0HzapfbmcKOVUs5iBN3aQapSHlR0LtP38PDDSA4EhVISiufZ5XSP514Aykr1Eb8w2Mm0cuXyiE95pdydiISlUJgEcWKckF1amNuI4j2TgBuk4HS3L87Flyo5CH14EqXHSXI7j0MIPdQeaTmoWSDyn0hQmsdbeiiX3wqaG3ypDcLq9nAq3G4OzTu3Hh+NoQpkbiaZKRphePPb8d+xxIzqZZMH2u0y3uwJwc9JwIDHN9pHZYV0uDyqFa+6bueVIT/gYHrN6rMKD9X5QydXdkUo+A2KBxWG+yY6XK2m0bMemCENM/V8YpvmlAudpR/TTSX3QaZkrg8mg5DvO2LyE0M135DS6EP1IQJu6Zm05ejbG1uY+ut9o0mfq5sOVxwCJZI0f0QLGNvUgltbjh9JBJ9f63LHEbuH9VhTlNvNYWd3Gn/UI9bo0vq3KgLcMESddVEIeLhE+/bMn/isNuwPwS2CWIQQPmL457AIThh15fep5rTJBiNjOAek74NC5w1XieTQdvha/Q3UHRlcRj9jAcgd5cnIosqclVdoo325dxYpXhOFZcIrIgHBRrKFUxtLh6VBjOxL2YguGQ/SSzOp4YSu28qlu
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:NT0PR01MB1182.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230031)(41320700004)(1800799015)(52116005)(366007)(38350700005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?YQd5OHhDFwTJKC8E6FQmS6DyResCLqwDq6wHeGDPH+RKMjuEhxEFndzcxTWl?=
 =?us-ascii?Q?z2HeDQTNzfvuObVbNWDTKh6Yx1Hf5Gkpzv3LW0x8yvIjBnPO9Lk0+D9+oJkD?=
 =?us-ascii?Q?XzzxG9SVIUqNdQhT3EHQ8JBtlcaMBI+F1S4NLiLxaPfHC/JXKF4QjhbPnS/m?=
 =?us-ascii?Q?locFl1ffjs7shdeUQHYdSY+8b/x6LbWo6WgvPT4QkUUf19RE8mYwIz2hxT5y?=
 =?us-ascii?Q?ubFdaK8/loA0fSFcDyyH0j3WreF4FGDhrYWgRJQF8U3D+OHp3KfAzDz5++Ix?=
 =?us-ascii?Q?4AOA8ZcKpz66llW9KKlwQQheHbW2bQbLZqFLNn8N6w1jM1vc7BtdqINJ0S7t?=
 =?us-ascii?Q?PmKMINlFu/nVGk6ftQPEe02N88KsQNonBz24HoWMx9KhlDr2PEpA19zWWCUr?=
 =?us-ascii?Q?LghNqEhUMzEwWMMmfkEMWGHDqHchotJuTYJ2lDEyT6LTnj9WzduZz1HVRb2x?=
 =?us-ascii?Q?kxu3rBW/wDGvApVCrakAvFj/QPq/wfP7p+At86HxaVFBHW/dg5lF8mNPHeaB?=
 =?us-ascii?Q?9/+opnqqQbDIeUE5N0JMxyu4a96/r0XhFck6SPZjevJjgIS7N4Owa6/MHUg9?=
 =?us-ascii?Q?/Qy4SbP1xhJ1+SytBofGtxUNnNDKWeaFwJA7OvZZdPfpiHgIHg6Wux4caZ2T?=
 =?us-ascii?Q?o0kkPT5zrQ5FiS61BPs+nqd4aowOMDMObYljHAtoFGkVD50doVnmwuiQX6xy?=
 =?us-ascii?Q?2FZs1n1DLBUz/+78cCycsOO6+7fcqbbu1NeyEv7VcmgPdQVDUF6KG/eTfEtr?=
 =?us-ascii?Q?SP0T2ki7l+TxGr0lOMe2z0+KR4QsiBUnKZo1kSc6K1czLHhEmL94vNDS1Ql5?=
 =?us-ascii?Q?7YW30+qtogxJ2Cz2bBu075YARKffqr/XYaVTBrKdicDVN6ebpPU95C9nYodp?=
 =?us-ascii?Q?oI0homfJJeJBsuq9CLpk8uQaKcga0Q0tFuPr6MA/uPLZ2ANdT6plbjimbSG5?=
 =?us-ascii?Q?5Bkal1xCZLBxsdW0WcbzRH0yV/FLXtpXqGBSQM4G+zPwRZNPXFfKnbRqAdLb?=
 =?us-ascii?Q?RKl7jOPzMJMdACmFihVy9yPwNAKbSizUWwrT0+i6bTfcGrKTD7b2PuLdd+Dm?=
 =?us-ascii?Q?zOrdkNQKGQWin1wInYUksFp8jRvtzoDdQ9t7NiXW18ucqaiJsxAy0uod2JfO?=
 =?us-ascii?Q?6PF6GbNZZMMPcXfiW2G//4i1IS3/ixfbBoNUL2vEqZB4gtV0ah1imYPi4E22?=
 =?us-ascii?Q?LRan/v6Tun0wwhBJib4kKm+OM/MFTxs51wLQpic5i0akcXVcFMt8ijeM0Nrp?=
 =?us-ascii?Q?OV5xA4wQl0v81A0l6s7bG2pnpKnv8OaQQzg+CZC0Go+dJHuwL8YqFnvuPg3s?=
 =?us-ascii?Q?TzztbFOM6VTtguWnTdAS+r53tfHsTv3TG1KesOVAb6pMZVe3jDbmKCboeOsB?=
 =?us-ascii?Q?f2iLio/0tIbBBEFFUvJMDosVJ0cNWRLDOMHhnjB4W7umhz+HuOmuOGSZtYGH?=
 =?us-ascii?Q?uD5hRAKVANH3at55lt8/jtJKUKqu7YCwr8kFaYOwYDgqBvLOuuRTvJcAvmgy?=
 =?us-ascii?Q?qTu3OOKWWKCDQ6cS+9akxa/X4DzNfvGHEYVj9YkiSK6XHVu8qpxGzWp4OUEe?=
 =?us-ascii?Q?K/KaVgb3WeC4bqnBt5e+tEg8df0B3MqfsbmTxt8K01LnM4kY0BwMgj53CL45?=
 =?us-ascii?Q?Pw=3D=3D?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 072da6fa-cfa0-47a0-46d8-08dc6812b888
X-MS-Exchange-CrossTenant-AuthSource: NT0PR01MB1182.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Apr 2024 06:07:59.6339
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 35JYr+PWgf8HkU8kkR8wEeuYOCp523Gublx2OpatcKQkDHROKzvQ3+P8nGvT/zDZgQEFMXg3qHnIS0ojcPc+O7e8X92z7RoL+TeJoU10S+I=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: NT0PR01MB1278

Dma address mapping fails on unaligned scatterlist offset. Use sw
fallback for these cases.

Signed-off-by: Jia Jie Ho <jiajie.ho@starfivetech.com>
---
 drivers/crypto/starfive/jh7110-aes.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/drivers/crypto/starfive/jh7110-aes.c b/drivers/crypto/starfive/jh7110-aes.c
index 9d6e2f936f03..86a1a1fa9f8f 100644
--- a/drivers/crypto/starfive/jh7110-aes.c
+++ b/drivers/crypto/starfive/jh7110-aes.c
@@ -314,7 +314,7 @@ static int starfive_aes_read_authtag(struct starfive_cryp_ctx *ctx)
 					 cryp->total_in, cryp->authsize, 1);
 	} else {
 		if (crypto_memneq(cryp->tag_in, cryp->tag_out, cryp->authsize))
-			return dev_err_probe(cryp->dev, -EBADMSG, "Failed tag verification\n");
+			return -EBADMSG;
 	}
 
 	return 0;
@@ -753,14 +753,16 @@ static bool starfive_aes_check_unaligned(struct starfive_cryp_dev *cryp,
 	int i;
 
 	for_each_sg(src, tsg, sg_nents(src), i)
-		if (!IS_ALIGNED(tsg->length, AES_BLOCK_SIZE) &&
-		    !sg_is_last(tsg))
+		if (!IS_ALIGNED(tsg->offset, sizeof(u32)) ||
+		    (!IS_ALIGNED(tsg->length, AES_BLOCK_SIZE) &&
+		     !sg_is_last(tsg)))
 			return true;
 
 	if (src != dst)
 		for_each_sg(dst, tsg, sg_nents(dst), i)
-			if (!IS_ALIGNED(tsg->length, AES_BLOCK_SIZE) &&
-			    !sg_is_last(tsg))
+			if (!IS_ALIGNED(tsg->offset, sizeof(u32)) ||
+			    (!IS_ALIGNED(tsg->length, AES_BLOCK_SIZE) &&
+			     !sg_is_last(tsg)))
 				return true;
 
 	return false;
-- 
2.40.1


