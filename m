Return-Path: <linux-kernel+bounces-67817-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BCBB857168
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 00:18:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F0BA2281664
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 23:18:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2418314AD11;
	Thu, 15 Feb 2024 23:14:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="mt4LEgG/"
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7AE3145347;
	Thu, 15 Feb 2024 23:14:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708038884; cv=none; b=UizmpQtsnlkKhks1CEUVHc8FFIA5rliQp9p9MkSuywzy/haKgCQtRvRZtVi6e8JEtd/Qw7MpTOCtcV6UIipn89LN+6PlgXww+J4kdvD0cH7UfkzBKLsQ2B+eQLmUKQqOpIhW7u1PHiSKMHVes/X05gzov5x90yNmBQNDJ6q2ZxE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708038884; c=relaxed/simple;
	bh=MJtbtakGRx/ECuD1utzjsbGjrmdKesauv5SvppvQjL8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DdPKr2KNF3cI1/ml1Hvhnvh/RB6M/+mFUzfcQ35X9e/RtWV61Z3iLxG+Y4rSKOqtMGCQwRW1MN++8fkBq8HxvklZJQ6jCnBjZbStwD/3SpJaKFcw3Z7nvD02iF7foozhyslaqrzPLKsnwjHg3rTjHAkQ5cEModT6UdOmfomo9RE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=mt4LEgG/; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353723.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 41FLFagF007912;
	Thu, 15 Feb 2024 23:14:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=dArPa5/gW/FG93KPR96YEJvHNQv0WSEXUvrhkMfIgv0=;
 b=mt4LEgG/oLQRGdK6SH3OucwrZIcJ+M+E4uveRjSsGTptgzgc8qfOhYH6OAzGZhPHlfj4
 G8V1vneyEUn9gl0rqRCrQgSEQ3bdeHuhwLHr6JsjuJaPNMhsFH0VDN4W3jNFJQ/upuIf
 ILYbwQB8C01ODxObwuDA3lmvoQZhA0/hhZKtwO/R5pVsEkeDIwXnSSjBFp8kCcFxRhTI
 8OKNYHuZ/JRkZMRa/qPWPYJ6Fguv5i1cdPM4BbLrNUi/8cQy/oD2IPyNmLJ2s32uEpOR
 ifhC/4KNx75t8gmaLaIyXZpHmbHCd0sqMUVaUmxZGr6Gd0wh708irUkfc/ndAXmiFQyJ BA== 
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3w9q8n7j5y-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 15 Feb 2024 23:14:34 +0000
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 41FLA9VI009886;
	Thu, 15 Feb 2024 23:14:34 GMT
Received: from smtprelay01.wdc07v.mail.ibm.com ([172.16.1.68])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 3w6p637dvc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 15 Feb 2024 23:14:33 +0000
Received: from smtpav04.wdc07v.mail.ibm.com (smtpav04.wdc07v.mail.ibm.com [10.39.53.231])
	by smtprelay01.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 41FNEVws58065340
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 15 Feb 2024 23:14:33 GMT
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3008758052;
	Thu, 15 Feb 2024 23:14:31 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7FC3358050;
	Thu, 15 Feb 2024 23:14:30 +0000 (GMT)
Received: from sbct-3.pok.ibm.com (unknown [9.47.158.153])
	by smtpav04.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 15 Feb 2024 23:14:30 +0000 (GMT)
From: Stefan Berger <stefanb@linux.ibm.com>
To: keyrings@vger.kernel.org, linux-crypto@vger.kernel.org,
        herbert@gondor.apana.org.au, davem@davemloft.net
Cc: linux-kernel@vger.kernel.org, saulo.alessandre@tse.jus.br,
        Stefan Berger <stefanb@linux.ibm.com>
Subject: [PATCH v2 13/14] crypto: ecdh - Use functions to copy digits from and to byte array
Date: Thu, 15 Feb 2024 18:14:12 -0500
Message-ID: <20240215231414.3857320-14-stefanb@linux.ibm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240215231414.3857320-1-stefanb@linux.ibm.com>
References: <20240215231414.3857320-1-stefanb@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: D_J4uA7UYiN8AlODo15ZK1sxJL__kLi0
X-Proofpoint-ORIG-GUID: D_J4uA7UYiN8AlODo15ZK1sxJL__kLi0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-15_22,2024-02-14_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 mlxlogscore=999
 impostorscore=0 adultscore=0 suspectscore=0 bulkscore=0 spamscore=0
 lowpriorityscore=0 malwarescore=0 priorityscore=1501 mlxscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2402150181

All curves supported so far provide full 64bit digit arrays to convert
coordinates from and to. For NIST P521 only 8 digits and 2 bytes will be
given per coordinate so that conversion from 9 digits does not work since
some bytes are missing. Therefore, regard the input (output)
arrays as byte arrays that need to be converted to digits (from digits).
Use ecc_digits_from_bytes to convert a byte array to digits and
ecc_digits_to_bytes to convert digits to a byte array.

crypt_ecdh_shared_secret creates 'rand_z' from 'nbytes' of random bytes.
Also convert this array to fill a byte array with 'nbytes' of random bytes
and create the rand_z digits from the byte array. The most significant
digit of rand_z needs to be adjusted to mask out unnecessary bits beyond
the 521 bits of NIST P521. Therefore, apply the appropriate mask to the
most significant digit keeping only the 9 most significant bits.

Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
---
 crypto/ecc.c                  | 27 +++++++++++++++------------
 crypto/ecdh.c                 | 26 +++++++++++++++-----------
 include/crypto/internal/ecc.h | 10 +++++++---
 3 files changed, 37 insertions(+), 26 deletions(-)

diff --git a/crypto/ecc.c b/crypto/ecc.c
index f643719450b8..ced77eb6e533 100644
--- a/crypto/ecc.c
+++ b/crypto/ecc.c
@@ -1542,7 +1542,8 @@ int ecc_gen_privkey(unsigned int curve_id, unsigned int ndigits, u64 *privkey)
 EXPORT_SYMBOL(ecc_gen_privkey);
 
 int ecc_make_pub_key(unsigned int curve_id, unsigned int ndigits,
-		     const u64 *private_key, u64 *public_key)
+		     const u64 *private_key, u8 *public_key,
+		     unsigned int nbytes)
 {
 	int ret = 0;
 	struct ecc_point *pk;
@@ -1570,8 +1571,8 @@ int ecc_make_pub_key(unsigned int curve_id, unsigned int ndigits,
 		goto err_free_point;
 	}
 
-	ecc_swap_digits(pk->x, public_key, ndigits);
-	ecc_swap_digits(pk->y, &public_key[ndigits], ndigits);
+	ecc_digits_to_bytes(pk->x, ndigits, public_key, nbytes);
+	ecc_digits_to_bytes(pk->y, ndigits, &public_key[nbytes], nbytes);
 
 err_free_point:
 	ecc_free_point(pk);
@@ -1641,14 +1642,14 @@ int ecc_is_pubkey_valid_full(const struct ecc_curve *curve,
 EXPORT_SYMBOL(ecc_is_pubkey_valid_full);
 
 int crypto_ecdh_shared_secret(unsigned int curve_id, unsigned int ndigits,
-			      const u64 *private_key, const u64 *public_key,
-			      u64 *secret)
+			      const u64 *private_key, const u8 *public_key,
+			      unsigned int nbytes, u8 *secret, u64 msd_mask)
 {
 	int ret = 0;
 	struct ecc_point *product, *pk;
 	u64 priv[ECC_MAX_DIGITS];
 	u64 rand_z[ECC_MAX_DIGITS];
-	unsigned int nbytes;
+	u8 tmp[ECC_MAX_DIGITS << ECC_DIGITS_TO_BYTES_SHIFT];
 	const struct ecc_curve *curve = ecc_get_curve(curve_id);
 
 	if (!private_key || !public_key || !curve ||
@@ -1657,9 +1658,10 @@ int crypto_ecdh_shared_secret(unsigned int curve_id, unsigned int ndigits,
 		goto out;
 	}
 
-	nbytes = ndigits << ECC_DIGITS_TO_BYTES_SHIFT;
-
-	get_random_bytes(rand_z, nbytes);
+	get_random_bytes(tmp, nbytes);
+	ecc_digits_from_bytes(tmp, nbytes, rand_z, ndigits);
+	if (msd_mask)
+		rand_z[ndigits - 1] &= msd_mask;
 
 	pk = ecc_alloc_point(ndigits);
 	if (!pk) {
@@ -1667,8 +1669,9 @@ int crypto_ecdh_shared_secret(unsigned int curve_id, unsigned int ndigits,
 		goto out;
 	}
 
-	ecc_swap_digits(public_key, pk->x, ndigits);
-	ecc_swap_digits(&public_key[ndigits], pk->y, ndigits);
+	ecc_digits_from_bytes(public_key, nbytes, pk->x, ndigits);
+	ecc_digits_from_bytes(&public_key[nbytes], nbytes, pk->y, ndigits);
+
 	ret = ecc_is_pubkey_valid_partial(curve, pk);
 	if (ret)
 		goto err_alloc_product;
@@ -1688,7 +1691,7 @@ int crypto_ecdh_shared_secret(unsigned int curve_id, unsigned int ndigits,
 		goto err_validity;
 	}
 
-	ecc_swap_digits(product->x, secret, ndigits);
+	ecc_digits_to_bytes(product->x, ndigits, secret, nbytes);
 
 err_validity:
 	memzero_explicit(priv, sizeof(priv));
diff --git a/crypto/ecdh.c b/crypto/ecdh.c
index f187365db7b6..e64133428552 100644
--- a/crypto/ecdh.c
+++ b/crypto/ecdh.c
@@ -15,6 +15,8 @@
 struct ecdh_ctx {
 	unsigned int curve_id;
 	unsigned int ndigits;
+	unsigned int nbytes;
+	u64 msd_mask;
 	u64 private_key[ECC_MAX_DIGITS];
 };
 
@@ -28,7 +30,6 @@ static int ecdh_set_secret(struct crypto_kpp *tfm, const void *buf,
 {
 	struct ecdh_ctx *ctx = ecdh_get_ctx(tfm);
 	u64 priv[ECC_MAX_DIGITS];
-	unsigned int nbytes;
 	struct ecdh params;
 
 	if (crypto_ecdh_decode_key(buf, len, &params) < 0 ||
@@ -39,10 +40,8 @@ static int ecdh_set_secret(struct crypto_kpp *tfm, const void *buf,
 		return ecc_gen_privkey(ctx->curve_id, ctx->ndigits,
 				       ctx->private_key);
 
-	nbytes = ctx->ndigits << ECC_DIGITS_TO_BYTES_SHIFT;
-
-	memcpy(ctx->private_key, params.key, nbytes);
-	ecc_swap_digits(ctx->private_key, priv, ctx->ndigits);
+	ecc_digits_from_bytes(params.key, ctx->nbytes, priv, ctx->ndigits);
+	ecc_swap_digits(priv, ctx->private_key, ctx->ndigits);
 
 	if (ecc_is_key_valid(ctx->curve_id, ctx->ndigits,
 			     priv, params.key_size) < 0) {
@@ -56,13 +55,13 @@ static int ecdh_compute_value(struct kpp_request *req)
 {
 	struct crypto_kpp *tfm = crypto_kpp_reqtfm(req);
 	struct ecdh_ctx *ctx = ecdh_get_ctx(tfm);
-	u64 *public_key;
-	u64 *shared_secret = NULL;
+	unsigned int nbytes = ctx->nbytes;
+	u8 *public_key;
+	u8 *shared_secret = NULL;
 	void *buf;
-	size_t copied, nbytes, public_key_sz;
+	size_t copied, public_key_sz;
 	int ret = -ENOMEM;
 
-	nbytes = ctx->ndigits << ECC_DIGITS_TO_BYTES_SHIFT;
 	/* Public part is a point thus it has both coordinates */
 	public_key_sz = 2 * nbytes;
 
@@ -91,12 +90,14 @@ static int ecdh_compute_value(struct kpp_request *req)
 
 		ret = crypto_ecdh_shared_secret(ctx->curve_id, ctx->ndigits,
 						ctx->private_key, public_key,
-						shared_secret);
+						nbytes, shared_secret,
+						ctx->msd_mask);
 
 		buf = shared_secret;
 	} else {
 		ret = ecc_make_pub_key(ctx->curve_id, ctx->ndigits,
-				       ctx->private_key, public_key);
+				       ctx->private_key, public_key,
+				       nbytes);
 		buf = public_key;
 		nbytes = public_key_sz;
 	}
@@ -134,6 +135,7 @@ static int ecdh_nist_p192_init_tfm(struct crypto_kpp *tfm)
 
 	ctx->curve_id = ECC_CURVE_NIST_P192;
 	ctx->ndigits = ECC_CURVE_NIST_P192_DIGITS;
+	ctx->nbytes = ctx->ndigits << ECC_DIGITS_TO_BYTES_SHIFT;
 
 	return 0;
 }
@@ -159,6 +161,7 @@ static int ecdh_nist_p256_init_tfm(struct crypto_kpp *tfm)
 
 	ctx->curve_id = ECC_CURVE_NIST_P256;
 	ctx->ndigits = ECC_CURVE_NIST_P256_DIGITS;
+	ctx->nbytes = ctx->ndigits << ECC_DIGITS_TO_BYTES_SHIFT;
 
 	return 0;
 }
@@ -184,6 +187,7 @@ static int ecdh_nist_p384_init_tfm(struct crypto_kpp *tfm)
 
 	ctx->curve_id = ECC_CURVE_NIST_P384;
 	ctx->ndigits = ECC_CURVE_NIST_P384_DIGITS;
+	ctx->nbytes = ctx->ndigits << ECC_DIGITS_TO_BYTES_SHIFT;
 
 	return 0;
 }
diff --git a/include/crypto/internal/ecc.h b/include/crypto/internal/ecc.h
index 5d485d3221d3..328a82bd35c8 100644
--- a/include/crypto/internal/ecc.h
+++ b/include/crypto/internal/ecc.h
@@ -138,12 +138,14 @@ int ecc_gen_privkey(unsigned int curve_id, unsigned int ndigits, u64 *privkey);
  * @ndigits:		curve's number of digits
  * @private_key:	pregenerated private key for the given curve
  * @public_key:		buffer for storing the generated public key
+ * @nbytes:		number of bytes per coordinate of public key
  *
  * Returns 0 if the public key was generated successfully, a negative value
  * if an error occurred.
  */
 int ecc_make_pub_key(const unsigned int curve_id, unsigned int ndigits,
-		     const u64 *private_key, u64 *public_key);
+		     const u64 *private_key, u8 *public_key,
+		     unsigned int nbytes);
 
 /**
  * crypto_ecdh_shared_secret() - Compute a shared secret
@@ -152,7 +154,9 @@ int ecc_make_pub_key(const unsigned int curve_id, unsigned int ndigits,
  * @ndigits:		curve's number of digits
  * @private_key:	private key of part A
  * @public_key:		public key of counterpart B
+ * @nbytes:		number of bytes per coordinate of public key
  * @secret:		buffer for storing the calculated shared secret
+ * @msd_mask:		optional mask to apply to the most significant digit
  *
  * Note: It is recommended that you hash the result of crypto_ecdh_shared_secret
  * before using it for symmetric encryption or HMAC.
@@ -161,8 +165,8 @@ int ecc_make_pub_key(const unsigned int curve_id, unsigned int ndigits,
  * if an error occurred.
  */
 int crypto_ecdh_shared_secret(unsigned int curve_id, unsigned int ndigits,
-			      const u64 *private_key, const u64 *public_key,
-			      u64 *secret);
+			      const u64 *private_key, const u8 *public_key,
+			      unsigned int nbytes, u8 *secret, u64 msd_mask);
 
 /**
  * ecc_is_pubkey_valid_partial() - Partial public key validation
-- 
2.43.0


