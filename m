Return-Path: <linux-kernel+bounces-108880-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A56D188114D
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 12:50:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 34E291F233B9
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 11:50:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 876E94C63D;
	Wed, 20 Mar 2024 11:48:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="AnIOys1s"
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 641EE42067;
	Wed, 20 Mar 2024 11:48:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710935287; cv=none; b=Gr2MhpH4NCcdueZOia/YzsxEAEKjVB7E9xC79EjCQ9mXwET2oPVuqzYWvR7gvMsJxYjG9V2jkLydaZ+Bh44bcg9x6AvrWrI6ptabzCufejpauwlH73Pc91CTP3wP/n5efJL2X2kiCJU5+ObiTpxGkZtUzcrt6y5kBb4jRd9i7cY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710935287; c=relaxed/simple;
	bh=Q/dJYBPl+RHVGg3BPGoW/8o+oZzaERh4KH17Cl7ACVI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gIoR6raQXhs7oR+3XOsFeaSVztGZJxNuHbnuWg1O78xJP1PZlpHPgTv7Wr+mbSULmYirbhTgP4qLglkFDsaveHAPWiwLYxNDvSQsVN6eVHrRNLS2J5kqpsq5RDidEgMCJiTQLPXSKDGdllGfnVPfdoCqm7B2hTT84uY1ZNiovU0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=AnIOys1s; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 42KAkXVq009742;
	Wed, 20 Mar 2024 11:47:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=Z78UWI7FhfZ+fiYzHgkephBTPtzZB2xh17lmPmftxxs=;
 b=AnIOys1sKCxQxGMctOVvHgwTM/rOPBK7YZFe7QCDhBY2n01yoNLwMjFbQV9zDolFvWX0
 oSN58CN7PLVIGtpb2HE5ZLShvnQeKz+1HFBYlqXNExo7TQ3n7wJ87a/i0xHIEQ5O4Pop
 Og5n9N2GHZhqw8uY6n0ZhAnB7NxqQKgXPx4nDL4Yk/5YzgncZH6QVRTItRTp+n1ytNNf
 Xw9s3lLUpPF0wtd+8+1jMGRT3ypDuWaGFaJB+fE5QdgYeG5BKDhTs4q2JYsQPHBDNKKE
 DzwsFkOjuAaY1RUVWliv8TGRS/hC4GvSdZ6sEdbVn+25BfiVa5WRPsL/XqKLst7nLj1c Xw== 
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3wyvtjrard-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 20 Mar 2024 11:47:50 +0000
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 42KB7KMl015806;
	Wed, 20 Mar 2024 11:47:49 GMT
Received: from smtprelay07.dal12v.mail.ibm.com ([172.16.1.9])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3wwp506717-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 20 Mar 2024 11:47:49 +0000
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com [10.241.53.100])
	by smtprelay07.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 42KBlkuk37224890
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 20 Mar 2024 11:47:48 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9A75758058;
	Wed, 20 Mar 2024 11:47:46 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 09B9858057;
	Wed, 20 Mar 2024 11:47:46 +0000 (GMT)
Received: from sbct-3.pok.ibm.com (unknown [9.47.158.153])
	by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 20 Mar 2024 11:47:45 +0000 (GMT)
From: Stefan Berger <stefanb@linux.ibm.com>
To: keyrings@vger.kernel.org, linux-crypto@vger.kernel.org,
        herbert@gondor.apana.org.au, davem@davemloft.net
Cc: linux-kernel@vger.kernel.org, saulo.alessandre@tse.jus.br, lukas@wunner.de,
        bbhushan2@marvell.com, jarkko@kernel.org,
        Stefan Berger <stefanb@linux.ibm.com>
Subject: [PATCH v7 02/13] crypto: ecdsa - Convert byte arrays with key coordinates to digits
Date: Wed, 20 Mar 2024 07:47:14 -0400
Message-ID: <20240320114725.1644921-3-stefanb@linux.ibm.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240320114725.1644921-1-stefanb@linux.ibm.com>
References: <20240320114725.1644921-1-stefanb@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: _idAnHxnYgzc01b0Y7YHzGAadKFheR6d
X-Proofpoint-GUID: _idAnHxnYgzc01b0Y7YHzGAadKFheR6d
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-20_08,2024-03-18_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 phishscore=0
 impostorscore=0 adultscore=0 spamscore=0 priorityscore=1501 suspectscore=0
 mlxscore=0 lowpriorityscore=0 mlxlogscore=999 bulkscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2403140000
 definitions=main-2403200093

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
index 4f6c1a68882f..ab722a8986b7 100644
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
+	__be64 msd = 0;
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


