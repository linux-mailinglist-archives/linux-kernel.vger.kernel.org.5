Return-Path: <linux-kernel+bounces-131596-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C38E8989E1
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 16:21:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B36701F2F981
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 14:21:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FC5312D203;
	Thu,  4 Apr 2024 14:19:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="GeYteJH7"
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 240E712AAC9;
	Thu,  4 Apr 2024 14:19:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712240393; cv=none; b=SJpztl7g7yOtdDPz5IaGEPQDQgKkS5Sq4PpmZJzIEUTC2CxI1hri1Xdk5Fdfmc+CR/6cH6mrJxKFBW4fmiaPDCosZlO+AyeNrlddjbaprE2juQSSyD5qGcAqebto4/giEjcwoy3X9uzpie/kLCLnEbVInrcj8K9bYqPUclIUpxE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712240393; c=relaxed/simple;
	bh=Y0k18Ihhg8n5HKmgZv2/PuiCRLc8Wu5KjwgN+CkSfLg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TmyZf44IR87uTvzlcmr+I5UEyjqpNXXqPLghN6KQQFBhdr28Y8/yDr5w/j7R5nZzSebnU0FeXVy1HJhVOp1MDOQnaDoNA8UX9OXHpHyF02aPWxkVZP14s+boFQEE2srVaZ3nRhLdb3sv37BwiOAGKSyJE/iBG3KNYZEC0HhR0Oo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=GeYteJH7; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 434EH8bM027772;
	Thu, 4 Apr 2024 14:19:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=rF9hYKinUCuEZE/CRCCID8RvGEbJNiuXYKXD4rDCE1w=;
 b=GeYteJH7bDWKkCO29cWaAGu6vuNMx83l9ro7w2JodOusIhkIFcQYDRjT+c+QPmzeOPmz
 ir9IIFhmztbLeYEwuqCP4pbyT5JJpZGES68QDi7r4tXTlUGC6ittQVaZuZsU18QoQGZC
 QiW+hJ3kBY5WT1dbpUYoYgk3fB8vFVuM4b6Pnsatdv3w8MtGPDE9KIjKP+8MwdnwEAjR
 tN63NIRAAVtmZyAGplSHzHAgEizvcGL3T7GMsMO8DGZg9Iq/7oqKHiQhrKRxKYbivNiS
 jTPe0ny0ab6ZucvHmkEsUSw38yH9M+NmFvG5BnvC6P7xkYxHUHTOgZJEIyf11sfRa50k UA== 
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3x9wd6r2g4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 04 Apr 2024 14:19:44 +0000
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 434DjcjC022281;
	Thu, 4 Apr 2024 14:19:43 GMT
Received: from smtprelay02.wdc07v.mail.ibm.com ([172.16.1.69])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3x9eq0cjwj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 04 Apr 2024 14:19:43 +0000
Received: from smtpav06.wdc07v.mail.ibm.com (smtpav06.wdc07v.mail.ibm.com [10.39.53.233])
	by smtprelay02.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 434EJfAG25232014
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 4 Apr 2024 14:19:43 GMT
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 165685806B;
	Thu,  4 Apr 2024 14:19:41 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 37AE058066;
	Thu,  4 Apr 2024 14:19:40 +0000 (GMT)
Received: from sbct-3.pok.ibm.com (unknown [9.47.158.153])
	by smtpav06.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Thu,  4 Apr 2024 14:19:40 +0000 (GMT)
From: Stefan Berger <stefanb@linux.ibm.com>
To: keyrings@vger.kernel.org, linux-crypto@vger.kernel.org,
        herbert@gondor.apana.org.au, davem@davemloft.net
Cc: linux-kernel@vger.kernel.org, saulo.alessandre@tse.jus.br, lukas@wunner.de,
        bbhushan2@marvell.com, jarkko@kernel.org,
        Stefan Berger <stefanb@linux.ibm.com>
Subject: [PATCH v8 10/13] crypto: ecdsa - Rename keylen to bufsize where necessary
Date: Thu,  4 Apr 2024 10:18:53 -0400
Message-ID: <20240404141856.2399142-11-stefanb@linux.ibm.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240404141856.2399142-1-stefanb@linux.ibm.com>
References: <20240404141856.2399142-1-stefanb@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: JLcxv_FGBoKLwLh58Xkg4YHIuLNgn-xI
X-Proofpoint-GUID: JLcxv_FGBoKLwLh58Xkg4YHIuLNgn-xI
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-04_10,2024-04-04_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 spamscore=0
 priorityscore=1501 lowpriorityscore=0 phishscore=0 impostorscore=0
 mlxlogscore=999 bulkscore=0 mlxscore=0 adultscore=0 suspectscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2404010000 definitions=main-2404040098

In cases where 'keylen' was referring to the size of the buffer used by
a curve's digits, it does not reflect the purpose of the variable anymore
once NIST P521 is used. What it refers to then is the size of the buffer,
which may be a few bytes larger than the size a coordinate of a key.
Therefore, rename keylen to bufsize where appropriate.

Tested-by: Lukas Wunner <lukas@wunner.de>
Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>
Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
---
 crypto/ecdsa.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/crypto/ecdsa.c b/crypto/ecdsa.c
index 75d3eea885db..c7923f30661b 100644
--- a/crypto/ecdsa.c
+++ b/crypto/ecdsa.c
@@ -35,8 +35,8 @@ struct ecdsa_signature_ctx {
 static int ecdsa_get_signature_rs(u64 *dest, size_t hdrlen, unsigned char tag,
 				  const void *value, size_t vlen, unsigned int ndigits)
 {
-	size_t keylen = ndigits * sizeof(u64);
-	ssize_t diff = vlen - keylen;
+	size_t bufsize = ndigits * sizeof(u64);
+	ssize_t diff = vlen - bufsize;
 	const char *d = value;
 	u8 rs[ECC_MAX_BYTES];
 
@@ -58,7 +58,7 @@ static int ecdsa_get_signature_rs(u64 *dest, size_t hdrlen, unsigned char tag,
 		if (diff)
 			return -EINVAL;
 	}
-	if (-diff >= keylen)
+	if (-diff >= bufsize)
 		return -EINVAL;
 
 	if (diff) {
@@ -138,7 +138,7 @@ static int ecdsa_verify(struct akcipher_request *req)
 {
 	struct crypto_akcipher *tfm = crypto_akcipher_reqtfm(req);
 	struct ecc_ctx *ctx = akcipher_tfm_ctx(tfm);
-	size_t keylen = ctx->curve->g.ndigits * sizeof(u64);
+	size_t bufsize = ctx->curve->g.ndigits * sizeof(u64);
 	struct ecdsa_signature_ctx sig_ctx = {
 		.curve = ctx->curve,
 	};
@@ -165,14 +165,14 @@ static int ecdsa_verify(struct akcipher_request *req)
 		goto error;
 
 	/* if the hash is shorter then we will add leading zeros to fit to ndigits */
-	diff = keylen - req->dst_len;
+	diff = bufsize - req->dst_len;
 	if (diff >= 0) {
 		if (diff)
 			memset(rawhash, 0, diff);
 		memcpy(&rawhash[diff], buffer + req->src_len, req->dst_len);
 	} else if (diff < 0) {
 		/* given hash is longer, we take the left-most bytes */
-		memcpy(&rawhash, buffer + req->src_len, keylen);
+		memcpy(&rawhash, buffer + req->src_len, bufsize);
 	}
 
 	ecc_swap_digits((u64 *)rawhash, hash, ctx->curve->g.ndigits);
-- 
2.43.0


