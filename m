Return-Path: <linux-kernel+bounces-4088-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 265548177D0
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 17:46:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 159671C22CC1
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 16:46:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AEF44FF73;
	Mon, 18 Dec 2023 16:46:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=windriver.com header.i=@windriver.com header.b="YhNPpKbo"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31FC21D148;
	Mon, 18 Dec 2023 16:46:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=windriver.com
Received: from pps.filterd (m0250812.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 3BIAfBSh016067;
	Mon, 18 Dec 2023 16:46:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=from:to:cc:subject:date:message-id:in-reply-to:references
	:content-transfer-encoding:content-type:mime-version; s=
	PPS06212021; bh=39POwTHDWFIQgyJN7m+/38nDh93tEsnS+h6DyCprqoE=; b=
	YhNPpKboLa53TDqSnl2BQg/gzQUQFAffFWRydr46gt7sdpoQv+g9/Jyet0GqDif3
	v4SSNS4iX7G4LA0AvqXSt3RIE98NiB1EuOGoEEeqUkaKg4Zo6owXgxvCg0J2vdm2
	B9F/6Qf39r41x12qbGE3AbWoimb+V2kqeqiUJLErhTUxQ6gpl/2r39YYTG+lXwSC
	QkRhh11uvKXW7zOd4jaaAnnQD49+psltPLQwrdHQRUkWlgqKiZYs3KUDCRkX+ccr
	mM6FmW3Oy/tbZzFgmiMHPzamZhTmRqkTNJQ6IQyXBnVQId3UbfIl1KE+ZlJ+782H
	VWqd8V/zgVS0qKHfoGlung==
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2101.outbound.protection.outlook.com [104.47.70.101])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 3v12v5t6q0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 18 Dec 2023 16:46:20 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=O5fli0ICkLY8+nMuKKNWnmcbg98XcDlv8kQIijm4V8Y9pT3Ad0ryPlMY+ZPbxgpb0tMOFpZpGCSw/RyXCkul9dPCjJ7VQggxbPo+/HXXK88c3zfpg3o7GkCmqJvi1VJQm0BZv4fXlOOzrjQ72rbQDo1+41dhkDJGCBP4Z4PiFu+Wlcb84ndwAwzCLIjhyh8MQg0M9qqMSppcsaUBagfKjQJ4m4VwcyQZ6A2t0S0V73UNzHTasVZBoUvVbyMLMmMFtpYusmIdQt14uB7eJbxzU9Ecr0V4sqjq9wOpeJeVJHz4743c8zJOfok/RszlmERz4wnnsqZeg1JH8/ia9god5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=39POwTHDWFIQgyJN7m+/38nDh93tEsnS+h6DyCprqoE=;
 b=cHzieq+O/9AQvEDCIKEkpG1nh9dfFVYE5qk13XTXcB+wcopPoz2UiCiL3stpLlRVs+/sNNRX5g1euQlklbNZQJ4kN0Rd9KiS68QR8r3HH3bzxjW2riSTUmBLwxEbG9TWeBuEpwTzrObS1K1WbtLKhDgNHSKQlRNqQrhcxKBkBEY0wPbtCys77Tu33/rxHSvkxg25/V8ojlpPAtIgCnpdnIC5BfWV6CmfwhIdRLApOZ2M7TPQRwQl2TRB20sehq2m7dm6tv0KBc8b1vwtL3TvWtXlsPF+9vuoX9Q0ML8MjkQXGNu2cG2/7VXcQM7LRIsdpj2d47Kl5dngob5IcfokrA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from DM4PR11MB5327.namprd11.prod.outlook.com (2603:10b6:5:392::22)
 by SA3PR11MB7978.namprd11.prod.outlook.com (2603:10b6:806:2fa::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.38; Mon, 18 Dec
 2023 16:46:18 +0000
Received: from DM4PR11MB5327.namprd11.prod.outlook.com
 ([fe80::7c2e:5b95:fdc2:30e]) by DM4PR11MB5327.namprd11.prod.outlook.com
 ([fe80::7c2e:5b95:fdc2:30e%3]) with mapi id 15.20.7091.034; Mon, 18 Dec 2023
 16:46:18 +0000
From: ovidiu.panait@windriver.com
To: linux-crypto@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, herbert@gondor.apana.org.au,
        davem@davemloft.net, Ovidiu Panait <ovidiu.panait@windriver.com>,
        Jesper Nilsson <jesper.nilsson@axis.com>,
        Lars Persson <lars.persson@axis.com>, linux-arm-kernel@axis.com
Subject: [PATCH 3/7] crypto: artpec6 - Use helper to set reqsize
Date: Mon, 18 Dec 2023 18:46:45 +0200
Message-Id: <20231218164649.2492465-3-ovidiu.panait@windriver.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231218164649.2492465-1-ovidiu.panait@windriver.com>
References: <20231218164649.2492465-1-ovidiu.panait@windriver.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: VI1PR0102CA0020.eurprd01.prod.exchangelabs.com
 (2603:10a6:802::33) To DM4PR11MB5327.namprd11.prod.outlook.com
 (2603:10b6:5:392::22)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB5327:EE_|SA3PR11MB7978:EE_
X-MS-Office365-Filtering-Correlation-Id: 9fec1952-9dce-4bb6-4090-08dbffe8db6a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	2PvYGuR2UIjWKqCquMQkDMaFVlMNq7RmFPI+h7gzDwbAHdmFokza5teoI+sPt75X43RCaHL5r+Nnxgtf7HqN6++iRDg8/XtnSo4wufG90xHncmMmaEE7Nw8C49pLD3RIghq5SDMwyHLnMOJ8p756bPY7YI9ewhHQthOpX1Lv+c0iyLSuM84qXw9td623W29UpdXxmUzxxUQClDeSWzvfIAy9zH+GZ53CnOkYmwpJuAealuxfwUMAInr2nPFm2ac8gS0lzZIOfqYSFN+L1Ru21T1ugr8LSga1vwwu8LHspNG6zr+VKYRPoQiuFMs6GTFmLnp67OdLn0/EyE+IbmhP5ZB6xgT0dBCAoUlF3F0hdpD7/mlS1JYQqCvLFokd8kIlppWhaFZygPmMmLkRzRruDknzIvj8gTEl0pUXxyvwfP/afBbkh8FFHiIXb9CpzyRVGIvzPW0z62DshXD356dO3BjpvK++ZYt7LNY42LJomKRHyYIyP1/axWkffvv/gcOi7MLuiqXW6Jaa8DDX7lyaNbQoXGeMg2u5X8RYcCCJaXS0Xno8Lb53J+3QFSFp3+EGrTR+TRVPLIQ0sDd/f+c/14sUYHyOr+8zkvqyBvFDcSKaBudTtSJpviqsTGAN4A1e
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB5327.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(136003)(366004)(396003)(346002)(39850400004)(230922051799003)(64100799003)(451199024)(186009)(1800799012)(83380400001)(86362001)(41300700001)(38100700002)(478600001)(6486002)(8936002)(8676002)(2616005)(4326008)(66946007)(66556008)(5660300002)(66476007)(54906003)(6916009)(316002)(1076003)(2906002)(26005)(6506007)(6666004)(9686003)(6512007)(52116002)(36756003)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?XetJLqFudVCDufCsyeOthhQQuiFRKfGwD+0xQSRLI54xj0cfMOxM0G2RvgD1?=
 =?us-ascii?Q?IN/+AAl/rQg+Y3pyw8RzpBv+irh7YOXr9LYA/E6sor6urh6IpR4em9Fkf1e9?=
 =?us-ascii?Q?oPJHnq2xp13i99MdWHWZYh45U17aWt+QF/kE1GREAwdl59YbV0+1E2QieeqQ?=
 =?us-ascii?Q?O9lIli0vcDtTBzaDMnv5O8TPVXqNStY2lRAMr8PyxjJQTFyOUCkanYfwR9a8?=
 =?us-ascii?Q?KW8Ur3SnPvOz4Wp3K3x6t8Ua1gJBhp+r+Y6uufTc9KffyMsvlbUgMgApmmkM?=
 =?us-ascii?Q?UWruSdMb8CZ1IB3ae42L90VtBNsgws4HYTPqqDGX3FtX/DdXT8esi7jj+0+L?=
 =?us-ascii?Q?yfwySKG7lmPjaDWH9PtBBCKRVm1jUCYJOl79q8+YdOmqRn9Z4EcehKFvSLSt?=
 =?us-ascii?Q?Xn4snO+Rc9lVXc6pKYhIKZ41W9KoHMugudOkqbtjpxh70RwpjJ3RbAaWtm2q?=
 =?us-ascii?Q?piSxIPz8oUjzRtsisov8x4843G9cD6t3hQBGb8LICP3hZikJziWChbEMiedM?=
 =?us-ascii?Q?osKg7AQUrLa/E2VCBsSUDTPQTdk1rxdNdnaU1hDJ+D/xwVJaNKiBjgWqN9ui?=
 =?us-ascii?Q?GKEQ/lyuAtTYSjcAREU6e/TIV35azGlzQr55KLLQFF8Kt4SkkvNKmi0t6lRF?=
 =?us-ascii?Q?Qb4vHJHIrIL4UhQwkntlGvE2FJpPZ4yKSRQl4BVGl6se9z8YR4yj34ckWTl5?=
 =?us-ascii?Q?GGa6HZ00y/NWOyLRPewqw8eMhKwSGo6/v4YVkuAplOP8XUg0WQGwNxZ5tKuh?=
 =?us-ascii?Q?ZoOHfPfwaghi3wb7Ia6ObM2i4EftMzHfMtkA6DIPJZWCk7wq9ahDsaXO2Dh9?=
 =?us-ascii?Q?/cCNTUVGVLrzZ7KCxhtGBH3QgroI0kz0WQ/Rz0fzRBVeIogN0t6SQiO524yu?=
 =?us-ascii?Q?eOxdr9hcPphxCXvH6lnC0W7Yjbqh/PssQtRkjhKMmgXuQbzHqZ58kbr262Ys?=
 =?us-ascii?Q?OM7fdxk43J2EDtXFoyYbPj0kS+XMdPbxLRjNDU0s3ubl3AvHKjRU/2cYGteQ?=
 =?us-ascii?Q?sDIyG/LMUTF5YPwPJJLxEHkvTOloHLv/sixy41MwhqqDYAFO0alopN7Z1OWy?=
 =?us-ascii?Q?8PKm0OI0OHvv04ZGN+BSOJr7R9pQ4E1o5luF6XIgHWjkeL03q/W6Zzo6sifv?=
 =?us-ascii?Q?fXmuo4vk7V2C9C5ZEVcTWamNzLk+VVDkk07KxQs90WuX7XDgBMRDwlqa9gEF?=
 =?us-ascii?Q?CBX/XYUi87alPHMl5nChhr0dx4tOionHoh3ZL/hUbm6CCr3UNoZyMcb7Jbmc?=
 =?us-ascii?Q?+p4kRsqQsfivbBQe9Cdrtut6trynGFe4FsdA+3K9vAayX0GiHznYAZPeYck5?=
 =?us-ascii?Q?rlH5vDaTOtS4yaSbPpdUR1Vwp7mFM7TuVKBcNC1rfvsZjesxri68qYwDMbz3?=
 =?us-ascii?Q?ELeNwOTzUzN+sUp0/7k+QVZ9bz8+UO+BLn9Q4ww4UdiSzulgAMkUImaD1YZj?=
 =?us-ascii?Q?pYtDioQexQjInshMv5NIS5U3tPpqboLHfxxtL34AwteacnE++j1MZte7RIO5?=
 =?us-ascii?Q?h4ssQETsv+ixfIk9L4VbxZaP99686/XRA1S+u5bjoIrvLei9R4XYjptsLjKC?=
 =?us-ascii?Q?Ev0qFKEld7HBWODx+UU5RlPrdBt0ibvPHiLQO6zdFrHtU4anrnBb+zv52oJJ?=
 =?us-ascii?Q?/Q=3D=3D?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9fec1952-9dce-4bb6-4090-08dbffe8db6a
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB5327.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Dec 2023 16:46:18.3011
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +9B+qDHE1d12jZ2psRvn/UGRJqQAs2Mw8KIq6HQkZvbTJgL1MjfRNBUN7GJ+RUm1ipplZm9zBdNl3p+BoqBYlOcsoj2vWYyekAsgwWXss10=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR11MB7978
X-Proofpoint-ORIG-GUID: 5n7BlBEYfw8K0zL6cSDbePqw0Mjcw3BQ
X-Proofpoint-GUID: 5n7BlBEYfw8K0zL6cSDbePqw0Mjcw3BQ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-16_25,2023-11-16_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 impostorscore=0 suspectscore=0 bulkscore=0 phishscore=0 mlxlogscore=886
 priorityscore=1501 spamscore=0 clxscore=1011 adultscore=0
 lowpriorityscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2311290000 definitions=main-2312180123

From: Ovidiu Panait <ovidiu.panait@windriver.com>

The value of reqsize must only be changed through the helper.

Signed-off-by: Ovidiu Panait <ovidiu.panait@windriver.com>
---
Cc: Jesper Nilsson <jesper.nilsson@axis.com>
Cc: Lars Persson <lars.persson@axis.com>
Cc: linux-arm-kernel@axis.com

 drivers/crypto/axis/artpec6_crypto.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/crypto/axis/artpec6_crypto.c b/drivers/crypto/axis/artpec6_crypto.c
index ef9fe13ffa59..dbc1d483f2af 100644
--- a/drivers/crypto/axis/artpec6_crypto.c
+++ b/drivers/crypto/axis/artpec6_crypto.c
@@ -1535,7 +1535,8 @@ static int artpec6_crypto_aes_ecb_init(struct crypto_skcipher *tfm)
 {
 	struct artpec6_cryptotfm_context *ctx = crypto_skcipher_ctx(tfm);
 
-	tfm->reqsize = sizeof(struct artpec6_crypto_request_context);
+	crypto_skcipher_set_reqsize(tfm,
+				    sizeof(struct artpec6_crypto_request_context));
 	ctx->crypto_type = ARTPEC6_CRYPTO_CIPHER_AES_ECB;
 
 	return 0;
@@ -1551,7 +1552,8 @@ static int artpec6_crypto_aes_ctr_init(struct crypto_skcipher *tfm)
 	if (IS_ERR(ctx->fallback))
 		return PTR_ERR(ctx->fallback);
 
-	tfm->reqsize = sizeof(struct artpec6_crypto_request_context);
+	crypto_skcipher_set_reqsize(tfm,
+				    sizeof(struct artpec6_crypto_request_context));
 	ctx->crypto_type = ARTPEC6_CRYPTO_CIPHER_AES_CTR;
 
 	return 0;
@@ -1561,7 +1563,8 @@ static int artpec6_crypto_aes_cbc_init(struct crypto_skcipher *tfm)
 {
 	struct artpec6_cryptotfm_context *ctx = crypto_skcipher_ctx(tfm);
 
-	tfm->reqsize = sizeof(struct artpec6_crypto_request_context);
+	crypto_skcipher_set_reqsize(tfm,
+				    sizeof(struct artpec6_crypto_request_context));
 	ctx->crypto_type = ARTPEC6_CRYPTO_CIPHER_AES_CBC;
 
 	return 0;
@@ -1571,7 +1574,8 @@ static int artpec6_crypto_aes_xts_init(struct crypto_skcipher *tfm)
 {
 	struct artpec6_cryptotfm_context *ctx = crypto_skcipher_ctx(tfm);
 
-	tfm->reqsize = sizeof(struct artpec6_crypto_request_context);
+	crypto_skcipher_set_reqsize(tfm,
+				    sizeof(struct artpec6_crypto_request_context));
 	ctx->crypto_type = ARTPEC6_CRYPTO_CIPHER_AES_XTS;
 
 	return 0;
-- 
2.34.1


