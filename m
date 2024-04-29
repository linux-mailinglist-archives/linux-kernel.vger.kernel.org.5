Return-Path: <linux-kernel+bounces-161789-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E1A7E8B514C
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 08:23:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CE3B2B214AE
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 06:23:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11711134B0;
	Mon, 29 Apr 2024 06:22:45 +0000 (UTC)
Received: from CHN02-SH0-obe.outbound.protection.partner.outlook.cn (mail-sh0chn02on2112.outbound.protection.partner.outlook.cn [139.219.146.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 400DB10A13;
	Mon, 29 Apr 2024 06:22:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=139.219.146.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714371764; cv=fail; b=gMM31H81G9NNtlhg8mrptWbLa50qeZ2aaRky9Yf4pMnudWDM9Qt4w6mZFfqvVQXXsml7VThFDYhAN1wmII3V8vrAZ+5QPKCMaSIKuENqUDyfAhnuw4X+j/aT4jxCdtlkeP/nSe6lSBm0dAdqfPNDuB7pJgGnaM0m8ckbEmI/oe0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714371764; c=relaxed/simple;
	bh=3lv1meW2TfDjYpnPagcAQy9bvqosggUcD9dUUolqvxQ=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=rhEMac757YiRudjSoUv8dvpM0zUvct6geWjMF/XL7GYt/aN7OXExoFKKgBNBdvLTWB2Sb6UCaD8+tFsXhhDx6liqQG7cNYxnxPnA+1iFaTBl6Eb/+/HrPNqeMsqmsoG6UOTcmh3g/3lCwjLC+FLJ90JMbgr1UCrkynnz+7SPyig=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com; spf=pass smtp.mailfrom=starfivetech.com; arc=fail smtp.client-ip=139.219.146.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nm00qrmm5pF8o7RU76ATYthuGEKlB/vezFV1UetGNvtUEQqmv9jnzX8CBhd+DOxlCREiA8rIHLiPNNnGlnB0+72ywlRV3u5Bt20VnkYc6WObMH7HURAtebdeW4qtqD3HIW6rAEWIirKB4ZfyF62o1PLwAr1i4k+s0s/KWNEQAAoZ7rrS06JEGkQf/1onXSd3BjXHahjUJzIWcSdPCUPL4FkTNOsotmfHAmTH09eI22zBMfa0dyEfVPHkp5tyRMnGFMjXeDdmhN1g6JnkUqupAqPrdct51RmWniv1Kv3oXJS4w1QeRCIz/8glhjXSWcjs2IooQI137neWaJSikMhi5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cI43scDwiAiUdX2mdA+5KNwfdtkDC6CXF+8x9UL6790=;
 b=AXL+H55wtNfAWHwxL7t1lVA59edpmA+hmpriqNTE30EIbu2jDGkYCEh4dFgVUtuADyICYpIB6BVb9nZwlPicnAfCZgT1tYHtF3uFPbQyrqDMHAah92ZrPytGfOu7AEyMSr6g1pkcDF1o3fwww88xyCIhKpWQZ7GAB73ujN+A9hToP5pOe4AidWliQfstfKX2gZXBy6tRCqcZhgfwOe9ionYdbiPkSP/7KK67oo7ZnNxUh6kmV+qXXNWO6JxplNQ2D0Z5Kz5NvbQqaMV4pw3lEY6sySaupCUFRSPKy8r9v7+OT7RYqin7U+t5IeHFzEQssYGy8QWje6ObQhDvFAsgiQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
Received: from NT0PR01MB1182.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c510:10::10) by NT0PR01MB1278.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c510:12::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.44; Mon, 29 Apr
 2024 06:07:55 +0000
Received: from NT0PR01MB1182.CHNPR01.prod.partner.outlook.cn
 ([fe80::3dc9:e0c9:9a09:3bb7]) by
 NT0PR01MB1182.CHNPR01.prod.partner.outlook.cn ([fe80::3dc9:e0c9:9a09:3bb7%4])
 with mapi id 15.20.7472.044; Mon, 29 Apr 2024 06:07:55 +0000
From: Jia Jie Ho <jiajie.ho@starfivetech.com>
To: Herbert Xu <herbert@gondor.apana.org.au>,
	"David S . Miller" <davem@davemloft.net>,
	linux-crypto@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH -next 1/4] crypto: starfive - Skip dma setup for zeroed message
Date: Mon, 29 Apr 2024 14:06:37 +0800
Message-Id: <20240429060640.2451685-2-jiajie.ho@starfivetech.com>
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
X-MS-Office365-Filtering-Correlation-Id: 29a4a6d1-0827-442e-8252-08dc6812b648
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	sW98zFGE5SowrhG+A/sZ3UawRdlSV9Uib7rWi7jJvN2+wPKiY5tf2YotoBUKvlW5p757qJ/IoyZk8YlCNitBra7fcTDlZ2lQqnW66hk+Vx3hgN7Cb79ByyHUu8KZ3/PmPQAsUf1UJ2nB7BLN9U2pwc+j1BDqWZF0frqeZenZCTbSxmVBMULYr9SdpAj7652J+3/Wh8Ef7LNn9c8rCvOPvJ0swUw+vvxrb6BFqyByeQ48OlRKKosdlgbt8iHfJf1W3HlnMGuehw//eG3MtiuQRrxxcW+v/6WnfMtdcKEbtuRmFrskaQm9af+cHqT3k6dh8Dn7Jhk5E/emWD/Xi07QZFwDZc019kZ1CswHPuKr75/hUCc0RzxQj5Lrh2BRgLxBhmRCBifOZ0UeG3gYh7JDZlm1doz4ICmIy+vxs3Y5zj8a9fSfvA1iLIEBbI6FneGlNNIlF3LDX8NIUDAKzFKaJzx358PoEGdP8i6V1093+LrsOkiVQBNa7YapxTgnjB6POGa7LrjqYQPREbiccqG9AZgJa9XLmWfAEbXMB6/j/Jdxsl91shETrN8l1c1ihAvKbqfZkH8yfelYEiETlP8DYWs+cUImyyD5iENP5G39cT8tbMkvMCeIGRzdHqygsf5g
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:NT0PR01MB1182.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230031)(41320700004)(1800799015)(52116005)(366007)(38350700005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?li+Z8m9QTFS1xxaYvJqzmCW0qlTV6Bkmt3ncgReuP2Y1EFFpdEM1qr1qxsOi?=
 =?us-ascii?Q?7BukQ8FRPscEwNPUoYPsXTSDCuKBZZjxYqOdPLmQ4Ok1bUrd3HcpenbZolj+?=
 =?us-ascii?Q?BuAEibqP86eH8tK7uYpB3seERo64uScY20d/Zw4ekDUZB86LywQr3suDI0SN?=
 =?us-ascii?Q?tldrN6jocpPxHbGjXkYzliKKuxpIzYLCA7Gw5SVkWz6I27YjEQLHD5V6Ac7y?=
 =?us-ascii?Q?0kYfrCSX8SlCP6rAfioJxbdtTEPmhgHLwOQf7Q6o6RAEo3+Gjf+H4rizz7yp?=
 =?us-ascii?Q?wuhUWlP+pRmFPRddQ0waRKQH4fMUf8daRnSFd8KDq4rUWfX0ANulHM9QcKIy?=
 =?us-ascii?Q?X27EcKv93xW/w6S1GWvK5xS4H/Y17Sd8eUJDVAAb6Nu3BbBYc7WX3QdWpCnX?=
 =?us-ascii?Q?o6n+6ngSFHrQP2UtYcl51ZMTTgx0Y0/zqntw7YVMeRO18bWrrLpDiZHG2wDR?=
 =?us-ascii?Q?HGmtjNEPnkYdLb3F6uXrZn6WCfbBtB8p0Wi47rZGWAItQDYf5jPwqxGkf2qt?=
 =?us-ascii?Q?YvBIvWNqkZkIfaPkmnbHf9tTIjGQc4SqRuD9GVzSRvCfyXGVQD+A64WW/Lhy?=
 =?us-ascii?Q?Xx5lFwjkWbOgWtn35ZGELgISKGHN62A3T50leBXr1h39gvWvejkHtmLAbAC7?=
 =?us-ascii?Q?bkgeUzZ4Q6o/djPB7PKf6Cig6EpYeW/WYCGCdrFpDzrhp53xokfpckUQdyev?=
 =?us-ascii?Q?uBGxIyZ0MB1IcfNzt8vWWGHpmQN3jukDNBrqQrrqNv9aLVP0+ZPLuHc8deC0?=
 =?us-ascii?Q?SMYgNvQh7dSzd4T+HNqFXQklAiXogDcp+1/dbTTgHSvbBD1EkPhaSrE0Ovu6?=
 =?us-ascii?Q?z4Oi4wGLqYqwnp2xD9m1TbzSc6ue1ip9NwBgFsGDQ6kOIHE/uQmtEYSu83Mo?=
 =?us-ascii?Q?X5Xr/5J6MXjWPeViMu4NlcfHKcewpLrVYUaX99V1H+GkkpXC2ssUDWT9cesN?=
 =?us-ascii?Q?4n6bJPBqZD9JOtFHmvxmIQb2CC6JIuPgutE/HjPuQ0VgVAdTSwsgdwcNAkq4?=
 =?us-ascii?Q?6K4Zb8Bs9UfxhdgYQhdSAYk4DCg49R1Gu8DaScggss5S516Bw0mfWLskMxa7?=
 =?us-ascii?Q?g2Vobeo8uPStqIfzySxfT1sahIB+CN2gTcncQPaOW5CAQ5fowYtJg9DVjqvt?=
 =?us-ascii?Q?BfkZzajwEItgM3hOn7fX0xQ7LBNV1kwnrvdqhdTb3nJ8HpCCLDQnYyLJZTcP?=
 =?us-ascii?Q?ueB6VbEukoRpfUNUjxiglerJpDnfoZ9onGZTN9+y/Z+9Bd8YmhfLNz2YVQQj?=
 =?us-ascii?Q?E7vM37T19fhJkDpKPdqrhmUIarMyOjbLVRDmI/tJAtQAlP9q1WfeuNsFj3dH?=
 =?us-ascii?Q?pKSrFjst3u5BKkJTcJGB+v1XnEccOHYtLwoC2lsimDIK1wZf95v5IxJrI0iY?=
 =?us-ascii?Q?XqwLLEfdNPo7dn6e/c/AbJBa45EeN1o6WkYqhstu14+U+67PKevWlJbALiHp?=
 =?us-ascii?Q?GexPGOPxBMo6zs5VFiHri0cSL3zFf9TL6sFF+Q8XezZbM64A+elNDi7PCySa?=
 =?us-ascii?Q?aRyuaHmo9/u4lLi5XH5LyFyxcO3SI4mqpN7T0C3ifnsX6LhN0bAPjBRjDEJd?=
 =?us-ascii?Q?iOcqLps1dbGX5sQwev82pCsNPhF30nkOX5UXNi9rHEEFq3ck6usLOtEqeV8D?=
 =?us-ascii?Q?Jw=3D=3D?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 29a4a6d1-0827-442e-8252-08dc6812b648
X-MS-Exchange-CrossTenant-AuthSource: NT0PR01MB1182.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Apr 2024 06:07:55.8606
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oFF9zcZoGZ+HelztF7Dk2GgE80VoJcuJn+9/aAdDcMHm3wRYLNGvObei3nbDj/aVFTfp0V0xIZhvNv+ziOwDAQGX/BKd2FbzzqIjJ6KSgfs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: NT0PR01MB1278

Skip dma setup and mapping for AES driver if plaintext is empty.

Signed-off-by: Jia Jie Ho <jiajie.ho@starfivetech.com>
---
 drivers/crypto/starfive/jh7110-aes.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/crypto/starfive/jh7110-aes.c b/drivers/crypto/starfive/jh7110-aes.c
index 72b7d46150d5..9d6e2f936f03 100644
--- a/drivers/crypto/starfive/jh7110-aes.c
+++ b/drivers/crypto/starfive/jh7110-aes.c
@@ -590,12 +590,16 @@ static int starfive_aes_do_one_req(struct crypto_engine *engine, void *areq)
 	if (ret)
 		return ret;
 
+	if (!cryp->total_in)
+		goto finish_req;
+
 	starfive_aes_dma_init(cryp);
 
 	ret = starfive_aes_map_sg(cryp, rctx->in_sg, rctx->out_sg);
 	if (ret)
 		return ret;
 
+finish_req:
 	starfive_aes_finish_req(ctx);
 
 	return 0;
-- 
2.40.1


