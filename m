Return-Path: <linux-kernel+bounces-58773-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id ED98984EB8A
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 23:19:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7909B1F2D9AF
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 22:19:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0034C5026E;
	Thu,  8 Feb 2024 22:19:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="ZBmt/h+e"
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E8C74F616;
	Thu,  8 Feb 2024 22:19:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707430751; cv=none; b=K6nJnMPdSdgeW1ydvdqw9nChzekZSLCYyDn5gD0NdCoJAPiZgL1tUyrinftPbbLw+BiXReK8nqT7vNOfUhKZg9DwOMnXz7aUH0v6DTbvPqDe+cKNPqdsdNmbHljoRRRjWrIWB68/A1Jb7b5Z3f0J42LajF0ObaTMDTrVLaKr2Zk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707430751; c=relaxed/simple;
	bh=TN9d7gd1khCPLJFVzxme0+JoazPZfiMchPZBEuWJqTo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aNWAfwNjjTJlekQa010HDWFR1/bNIUf8EfNdT+VjdJfPwvzqEIGiHbBtLJn+ugiQ3LfPhYdtJrundgLwHeVTBT/7a6xC8YapqhxXr6O8jolRrHpSQuTuakjlee1SgED3xJHdnavADovw4Ipfy+pVVpURKZEDqhgFsx90lnCRhYQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=ZBmt/h+e; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353724.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 418LrRH8032198;
	Thu, 8 Feb 2024 22:19:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=Y7Z7GqNdHEjyYnoMRq15Yo0bfkuuqUW48vkUpLbPAv4=;
 b=ZBmt/h+eivpfnAbD6BKpRkMao1htvLoDtPNJIyWsHOIVt3GJGSsqbVEDPqJWz9hdnkSJ
 rSI97WxZNpzYYtvrAILY4z+OmfvSQvv5+2ouzY0Bb0HRqWkHIOv/2eDLFF38tfe16cRv
 IZIL0qlHLZ83kU5vtu73xqri/MNLtSKdwEIDujIoi1EUVHgzI1MOuQOwaTQcRvCRfrrs
 kcRANzY92gMZ5cTFE2mrFUmnPChdI+cD5lJuf9om1i6M+PPMlIw5ypLdGdOmFw1ZLeek
 hK4vZw6VU7LDW4Z+wq7fEFZy4oor6IxX7mvgiT7R9oNk2UBtkkTmSo4BrOH0Qj8zWPM3 SA== 
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3w578ygfuv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 08 Feb 2024 22:19:02 +0000
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 418KXoGC005458;
	Thu, 8 Feb 2024 22:19:01 GMT
Received: from smtprelay02.wdc07v.mail.ibm.com ([172.16.1.69])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3w21akycmb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 08 Feb 2024 22:19:01 +0000
Received: from smtpav03.dal12v.mail.ibm.com (smtpav03.dal12v.mail.ibm.com [10.241.53.102])
	by smtprelay02.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 418MJ0bu21889698
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 8 Feb 2024 22:19:01 GMT
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B0D0958056;
	Thu,  8 Feb 2024 22:19:00 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 487CB58061;
	Thu,  8 Feb 2024 22:19:00 +0000 (GMT)
Received: from sbct-3.pok.ibm.com (unknown [9.47.158.153])
	by smtpav03.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Thu,  8 Feb 2024 22:19:00 +0000 (GMT)
From: Stefan Berger <stefanb@linux.ibm.com>
To: keyrings@vger.kernel.org, linux-crypto@vger.kernel.org,
        herbert@gondor.apana.org.au, davem@davemloft.net
Cc: linux-kernel@vger.kernel.org, saulo.alessandre@tse.jus.br,
        Stefan Berger <stefanb@linux.ibm.com>
Subject: [PATCH 01/14] crypto: ecdsa - Convert byte arrays with key coordinates to digits
Date: Thu,  8 Feb 2024 17:18:27 -0500
Message-ID: <20240208221840.3665874-2-stefanb@linux.ibm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240208221840.3665874-1-stefanb@linux.ibm.com>
References: <20240208221840.3665874-1-stefanb@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: Gncay1xXkbPwqQF2VrYJrD7H_p_FhFyU
X-Proofpoint-ORIG-GUID: Gncay1xXkbPwqQF2VrYJrD7H_p_FhFyU
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-08_11,2024-02-08_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 suspectscore=0
 bulkscore=0 adultscore=0 clxscore=1015 priorityscore=1501
 lowpriorityscore=0 impostorscore=0 mlxscore=0 spamscore=0 malwarescore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2402080124

For NIST P192/256/384 the public key's x and y parameters could be copied
directly from a given array since both parameters each filled 'ndigits'
of digits (a 'digit' is a u64). For support of NIST P521 the key parameters
first have to be copied right-aligned into a temporary byte array and can
then be copied into the final digit array using ecc_swap_digits.

Implement ecc_digits_from_array to convert a byte array into an array of
digits and use this function in ecdsa_set_pub_key where an input byte array
needs to be converted into digits.

Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
---
 crypto/ecdsa.c                | 15 ++++++++++-----
 include/crypto/internal/ecc.h | 19 +++++++++++++++++++
 2 files changed, 29 insertions(+), 5 deletions(-)

diff --git a/crypto/ecdsa.c b/crypto/ecdsa.c
index fbd76498aba8..c3748ddc9964 100644
--- a/crypto/ecdsa.c
+++ b/crypto/ecdsa.c
@@ -222,9 +222,8 @@ static int ecdsa_ecc_ctx_reset(struct ecc_ctx *ctx)
 static int ecdsa_set_pub_key(struct crypto_akcipher *tfm, const void *key, unsigned int keylen)
 {
 	struct ecc_ctx *ctx = akcipher_tfm_ctx(tfm);
+	unsigned int digitlen, ndigits, nbytes;
 	const unsigned char *d = key;
-	const u64 *digits = (const u64 *)&d[1];
-	unsigned int ndigits;
 	int ret;
 
 	ret = ecdsa_ecc_ctx_reset(ctx);
@@ -238,12 +237,18 @@ static int ecdsa_set_pub_key(struct crypto_akcipher *tfm, const void *key, unsig
 		return -EINVAL;
 
 	keylen--;
-	ndigits = (keylen >> 1) / sizeof(u64);
+	digitlen = keylen >> 1;
+
+	ndigits = digitlen / sizeof(u64);
 	if (ndigits != ctx->curve->g.ndigits)
 		return -EINVAL;
 
-	ecc_swap_digits(digits, ctx->pub_key.x, ndigits);
-	ecc_swap_digits(&digits[ndigits], ctx->pub_key.y, ndigits);
+	nbytes = ndigits * sizeof(u64);
+	d++;
+
+	ecc_digits_from_array(d, digitlen, ctx->pub_key.x, ndigits);
+	ecc_digits_from_array(&d[digitlen], digitlen, ctx->pub_key.y, ndigits);
+
 	ret = ecc_is_pubkey_valid_full(ctx->curve, &ctx->pub_key);
 
 	ctx->pub_key_set = ret == 0;
diff --git a/include/crypto/internal/ecc.h b/include/crypto/internal/ecc.h
index 4f6c1a68882f..ee6886547fd1 100644
--- a/include/crypto/internal/ecc.h
+++ b/include/crypto/internal/ecc.h
@@ -56,6 +56,25 @@ static inline void ecc_swap_digits(const void *in, u64 *out, unsigned int ndigit
 		out[i] = get_unaligned_be64(&src[ndigits - 1 - i]);
 }
 
+/**
+ * ecc_digits_from_array() - Create ndigits from a byte array of nbytes
+ * @in:       Input byte array
+ * @nbytes    Size of input byte array
+ * @out       Output digits array
+ * @ndigits:  Number of digits to create from byte array
+ */
+static inline void ecc_digits_from_array(const u8 *in, unsigned int nbytes,
+					 u64 *out, unsigned int ndigits)
+{
+	unsigned int sz = ndigits * sizeof(u64);
+	u8 tmp[ECC_MAX_DIGITS * sizeof(u64)];
+	unsigned int o = sz - nbytes;
+
+	memset(tmp, 0, o);
+	memcpy(&tmp[o], in, nbytes);
+	ecc_swap_digits(tmp, out, ndigits);
+}
+
 /**
  * ecc_is_key_valid() - Validate a given ECDH private key
  *
-- 
2.43.0


