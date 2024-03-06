Return-Path: <linux-kernel+bounces-94648-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 350EE8742A9
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 23:23:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8E89FB20F5A
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 22:23:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 517951BF40;
	Wed,  6 Mar 2024 22:23:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="s+5RI4Td"
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA9B81BC39;
	Wed,  6 Mar 2024 22:23:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709763795; cv=none; b=CqLU4Zca4kO0l4U0aMawkONb+paS76q2xPwCuGbLI+jx76FQm89c8ryUKB8ZF11e+rgrim+qXCCFqCFi0IcZ7zxfCq0eA5AhU3tZB6IeS8iJC5Jnz5LET28tu9mGpc/HIsn63J2JwqprD7IFPGap5S+YMleLog9SEDHKEGNf0pQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709763795; c=relaxed/simple;
	bh=4juA5iy9LC7a9Ju4PSxmeGVx27YTJEmpjVS0e2CY41w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Gs8ZLV3/HsjIrqtVkQZOC8J5UVynTZVJEK06oD8JyCh21KxlT11whj0FxSSw54hPz/JHnLWNIC0BEEP5siru+5gHb/Dv5Ma/7Vo6sJj1Jz6KxVtYl8ttCFQisOrMCR+sXvS5L+yrZjGwmGGK+ytMoVYfUA208ZlwFXG4fenCjn8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=s+5RI4Td; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 426LX7Vk009925;
	Wed, 6 Mar 2024 22:23:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=LTWheB0nhU3mxOa4TbhjXSmNL3kwxPJF6FsKqMVXw4A=;
 b=s+5RI4Td4uqsVzmHjZce56AV/9Xc6jaRsaftr5c+/kW5kyFKsbfkpi1HD3U/GHFLzFJu
 YN4nmkFRIYlhiuJ5LxA3qIc5R9kWvLUS5Fj3IwdS5Umgyb4hBIGzqZPeP4EgN5vHKF+m
 wZhqVwkuPrEImXqi9PI+LnC2E3O9+v8tWXkKZXxpwtT87qegF+yd/pB2ZFsooarNxrpO
 ObzZ94c/k0BAGwaiKTHezcjOUjhBHzboqRk1FEmBuM8KlLTcuuFTd5GMrFlvx03B0svv
 wbhX8ZA2vX4gksncx5fx2pXM6DRHqKXrtAET5KRsHqNflkDZil1KSPa8SjRYT3xsa3eK rA== 
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3wq0gg13e1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 06 Mar 2024 22:23:06 +0000
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 426L5AvQ006073;
	Wed, 6 Mar 2024 22:23:05 GMT
Received: from smtprelay03.dal12v.mail.ibm.com ([172.16.1.5])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 3wmeet9wvt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 06 Mar 2024 22:23:05 +0000
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com [10.241.53.100])
	by smtprelay03.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 426MN3f742991990
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 6 Mar 2024 22:23:05 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id F098858058;
	Wed,  6 Mar 2024 22:23:02 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7CAD858062;
	Wed,  6 Mar 2024 22:23:02 +0000 (GMT)
Received: from sbct-3.pok.ibm.com (unknown [9.47.158.153])
	by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Wed,  6 Mar 2024 22:23:02 +0000 (GMT)
From: Stefan Berger <stefanb@linux.ibm.com>
To: keyrings@vger.kernel.org, linux-crypto@vger.kernel.org,
        herbert@gondor.apana.org.au, davem@davemloft.net
Cc: linux-kernel@vger.kernel.org, saulo.alessandre@tse.jus.br, lukas@wunner.de,
        Stefan Berger <stefanb@linux.ibm.com>
Subject: [PATCH v5 01/12] crypto: ecdsa - Convert byte arrays with key coordinates to digits
Date: Wed,  6 Mar 2024 17:22:46 -0500
Message-ID: <20240306222257.979304-2-stefanb@linux.ibm.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240306222257.979304-1-stefanb@linux.ibm.com>
References: <20240306222257.979304-1-stefanb@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: jiHPGDjuOPMrzaOthLgjM7P0dRof4OEt
X-Proofpoint-ORIG-GUID: jiHPGDjuOPMrzaOthLgjM7P0dRof4OEt
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-06_12,2024-03-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 spamscore=0
 bulkscore=0 mlxlogscore=999 impostorscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 adultscore=0 phishscore=0 suspectscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2403060181

For NIST P192/256/384 the public key's x and y parameters could be copied
directly from a given array since both parameters filled 'ndigits' of
digits (a 'digit' is a u64). For support of NIST P521 the key parameters
need to have leading zeros prepended to the most significant digit since
only 2 bytes of the most significant digit are provided.

Therefore, implement ecc_digits_from_bytes to convert a byte array into an
array of digits and use this function in ecdsa_set_pub_key where an input
byte array needs to be converted into digits.

Suggested-by: Lukas Wunner <lukas@wunner.de>
Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
Tested-by: Lukas Wunner <lukas@wunner.de>
---
 crypto/ecdsa.c                | 14 +++++++++-----
 include/crypto/internal/ecc.h | 21 +++++++++++++++++++++
 2 files changed, 30 insertions(+), 5 deletions(-)

diff --git a/crypto/ecdsa.c b/crypto/ecdsa.c
index fbd76498aba8..6653dec17327 100644
--- a/crypto/ecdsa.c
+++ b/crypto/ecdsa.c
@@ -222,9 +222,8 @@ static int ecdsa_ecc_ctx_reset(struct ecc_ctx *ctx)
 static int ecdsa_set_pub_key(struct crypto_akcipher *tfm, const void *key, unsigned int keylen)
 {
 	struct ecc_ctx *ctx = akcipher_tfm_ctx(tfm);
+	unsigned int digitlen, ndigits;
 	const unsigned char *d = key;
-	const u64 *digits = (const u64 *)&d[1];
-	unsigned int ndigits;
 	int ret;
 
 	ret = ecdsa_ecc_ctx_reset(ctx);
@@ -238,12 +237,17 @@ static int ecdsa_set_pub_key(struct crypto_akcipher *tfm, const void *key, unsig
 		return -EINVAL;
 
 	keylen--;
-	ndigits = (keylen >> 1) / sizeof(u64);
+	digitlen = keylen >> 1;
+
+	ndigits = DIV_ROUND_UP(digitlen, sizeof(u64));
 	if (ndigits != ctx->curve->g.ndigits)
 		return -EINVAL;
 
-	ecc_swap_digits(digits, ctx->pub_key.x, ndigits);
-	ecc_swap_digits(&digits[ndigits], ctx->pub_key.y, ndigits);
+	d++;
+
+	ecc_digits_from_bytes(d, digitlen, ctx->pub_key.x, ndigits);
+	ecc_digits_from_bytes(&d[digitlen], digitlen, ctx->pub_key.y, ndigits);
+
 	ret = ecc_is_pubkey_valid_full(ctx->curve, &ctx->pub_key);
 
 	ctx->pub_key_set = ret == 0;
diff --git a/include/crypto/internal/ecc.h b/include/crypto/internal/ecc.h
index 4f6c1a68882f..4a556b41873e 100644
--- a/include/crypto/internal/ecc.h
+++ b/include/crypto/internal/ecc.h
@@ -56,6 +56,27 @@ static inline void ecc_swap_digits(const void *in, u64 *out, unsigned int ndigit
 		out[i] = get_unaligned_be64(&src[ndigits - 1 - i]);
 }
 
+/**
+ * ecc_digits_from_bytes() - Create ndigits-sized digits array from byte array
+ * @in:       Input byte array
+ * @nbytes    Size of input byte array
+ * @out       Output digits array
+ * @ndigits:  Number of digits to create from byte array
+ */
+static inline void ecc_digits_from_bytes(const u8 *in, unsigned int nbytes,
+					 u64 *out, unsigned int ndigits)
+{
+	unsigned int o = nbytes & 7;
+	u64 msd = 0;
+
+	if (o) {
+		memcpy((u8 *)&msd + sizeof(msd) - o, in, o);
+		out[--ndigits] = be64_to_cpu(msd);
+		in += o;
+	}
+	ecc_swap_digits(in, out, ndigits);
+}
+
 /**
  * ecc_is_key_valid() - Validate a given ECDH private key
  *
-- 
2.43.0


