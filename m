Return-Path: <linux-kernel+bounces-148901-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 528CA8A88C0
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 18:22:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 843B61C21948
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 16:22:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EA9B15B962;
	Wed, 17 Apr 2024 16:21:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="RJ8gPIyE"
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C75C814884C;
	Wed, 17 Apr 2024 16:21:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713370899; cv=none; b=uy9cmlAZQwuXlO2ozF5h0Eu8o2JTcjZyKtbGA6z2X1sICSfrDG5Kw8no75VzJlAykzbYrGEg1kBw4uJHj3phl+C/RU7yN4DNxvvnxeZOWcGSjgssjR+3zSbcHFZZegCzAafja8MEpyVmWWQdC1x64Vq+ye7oUE2TMNjcRsSsHgg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713370899; c=relaxed/simple;
	bh=rIy3fBL1Eo7Rt6qdgBj5rgeNIHRd2/egOEHfHz92pJo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tpoE+6s5UDUQ9EtsNZgauj8hkj5KTBk3LrxK1mBijN1HqnggcU55PfAREXRfF35/zTUmvO64666AIP7S18SyxSAiFrKJzJPDmiDtTIjwE9klSUxJ89I9vFp72eyfmbaAI/7n5VZck0iPLwg72qfaWDn+J4YEQ+8urIT5TxR76Ak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=RJ8gPIyE; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353724.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 43HFu6t1019469;
	Wed, 17 Apr 2024 16:21:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=jGqQmOA71to5nKaBrbelF7N2fwFSV3CaInxG4B+nG+I=;
 b=RJ8gPIyE0+sRSrn5Vz9XFoj3WNnHuPzRp9gq8iss8VQlD6/e+8zJ/CHZAzxBwso2U9/7
 swVE8OvVb2jZfV8FFy2wrGGafIWF3jZ77NMKqG/sA6zwaJtg29MwjhXrTeh8QcabXNVD
 R1Usl/UvyX9VVdKjqwMeuuESDshw+emOYgjdeoMEHXsrfIyGduTaTdvI/Q1pzQWxFBux
 cke7jyWaKdI1kt6UJMf9lTkUny6C39IASUHo8F0ZPgS/nPhshZPPPBlAG6vJZD+a1ubm
 tco9fwjh3rBNpbGx3Its46d5Azi+jlPExJY3faCOAk7vGUfFBUbjzzy29jlTvBO+46UH /A== 
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3xjhg3g2d3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 17 Apr 2024 16:21:24 +0000
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 43HDAoYZ011110;
	Wed, 17 Apr 2024 16:21:24 GMT
Received: from smtprelay03.dal12v.mail.ibm.com ([172.16.1.5])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 3xg732n3fm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 17 Apr 2024 16:21:24 +0000
Received: from smtpav06.wdc07v.mail.ibm.com (smtpav06.wdc07v.mail.ibm.com [10.39.53.233])
	by smtprelay03.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 43HGLLmv25035454
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 17 Apr 2024 16:21:24 GMT
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 826315803F;
	Wed, 17 Apr 2024 16:21:21 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A69FD58056;
	Wed, 17 Apr 2024 16:21:20 +0000 (GMT)
Received: from sbct-3.bos2.lab (unknown [9.47.158.153])
	by smtpav06.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 17 Apr 2024 16:21:20 +0000 (GMT)
From: Stefan Berger <stefanb@linux.ibm.com>
To: linux-crypto@vger.kernel.org, herbert@gondor.apana.org.au,
        davem@davemloft.net
Cc: linux-kernel@vger.kernel.org, jarkko@kernel.org, ardb@kernel.org,
        salvatore.benedetto@intel.com, git@jvdsn.com,
        Stefan Berger <stefanb@linux.ibm.com>
Subject: [PATCH v2 1/2] crypto: ecdh - Pass private key in proper byte order to check valid key
Date: Wed, 17 Apr 2024 12:21:16 -0400
Message-ID: <20240417162117.2752326-2-stefanb@linux.ibm.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240417162117.2752326-1-stefanb@linux.ibm.com>
References: <20240417162117.2752326-1-stefanb@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: CvN5zoxWixQPeOTPFhABapZPuf9QIzM6
X-Proofpoint-ORIG-GUID: CvN5zoxWixQPeOTPFhABapZPuf9QIzM6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-17_13,2024-04-16_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 impostorscore=0
 mlxscore=0 spamscore=0 adultscore=0 lowpriorityscore=0 bulkscore=0
 priorityscore=1501 mlxlogscore=999 phishscore=0 malwarescore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2404010000 definitions=main-2404170113

ecc_is_key_valid expects a key with the most significant digit in the last
entry of the digit array. Currently ecdh_set_secret passes a reversed key
to ecc_is_key_valid that then passes the rather simple test checking
whether the private key is in range [2, n-3]. For all current ecdh-
supported curves (NIST P192/256/384) the 'n' parameter is a rather large
number, therefore easily passing this test.

Throughout the ecdh and ecc codebase the variable 'priv' is used for a
private_key holding the bytes in proper byte order. Therefore, introduce
priv in ecdh_set_secret and copy the bytes from ctx->private_key into
priv in proper byte order by using ecc_swap_digits. Pass priv to
ecc_is_valid_key.

Cc: Ard Biesheuvel <ardb@kernel.org>
Cc: Salvatore Benedetto <salvatore.benedetto@intel.com>
Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
---
 crypto/ecdh.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/crypto/ecdh.c b/crypto/ecdh.c
index 3049f147e011..c02c9a2b9682 100644
--- a/crypto/ecdh.c
+++ b/crypto/ecdh.c
@@ -27,7 +27,9 @@ static int ecdh_set_secret(struct crypto_kpp *tfm, const void *buf,
 			   unsigned int len)
 {
 	struct ecdh_ctx *ctx = ecdh_get_ctx(tfm);
+	u64 priv[ECC_MAX_DIGITS];
 	struct ecdh params;
+	int ret = 0;
 
 	if (crypto_ecdh_decode_key(buf, len, &params) < 0 ||
 	    params.key_size > sizeof(u64) * ctx->ndigits)
@@ -40,13 +42,16 @@ static int ecdh_set_secret(struct crypto_kpp *tfm, const void *buf,
 				       ctx->private_key);
 
 	memcpy(ctx->private_key, params.key, params.key_size);
+	ecc_swap_digits(ctx->private_key, priv, ctx->ndigits);
 
 	if (ecc_is_key_valid(ctx->curve_id, ctx->ndigits,
-			     ctx->private_key, params.key_size) < 0) {
+			     priv, params.key_size) < 0) {
 		memzero_explicit(ctx->private_key, params.key_size);
-		return -EINVAL;
+		ret = -EINVAL;
 	}
-	return 0;
+	memzero_explicit(priv, sizeof(priv));
+
+	return ret;
 }
 
 static int ecdh_compute_value(struct kpp_request *req)
-- 
2.43.0


