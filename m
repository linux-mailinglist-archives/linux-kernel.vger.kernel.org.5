Return-Path: <linux-kernel+bounces-108875-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 581B588113C
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 12:48:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D959DB22151
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 11:48:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86FD14086C;
	Wed, 20 Mar 2024 11:48:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="ZKDO+tvO"
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A8A03FB2A;
	Wed, 20 Mar 2024 11:48:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710935283; cv=none; b=UITRhWrJOEGzWZCmmQzg7SFOAFlC2L8Mq8SgyosZr5yFt8wZqSP4CIkFnIjuG3MclQ7y2qhWHZZAEMuRj8BphwlkTKNzqJ2TS1h6Is1FT879l0QVJ2LUE5O00D69licqPmwtPr3rQbKdINJ8s1O1DKJ6T1zZn3iYwsQzXlw8K4w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710935283; c=relaxed/simple;
	bh=V9V6RxHqIHB7eTCn/aN6QFGxYMmrY0tl3nkMuYuOj60=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PLxQOtMOJIEU2aaeGCgtNGjqu/+hgvVdxbqrycGU04QGAePrQ/2gHKuVNHHDtSivRIvbLafLFCu5LuaZ0Mj5ezJPYbDVrT/gPDC63B5on6JC0CubIEVe4Yedlkgx74qdm0yybyZMFBz72V+FE6ktOxmE42rRTNgvi965hCXVoZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=ZKDO+tvO; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 42KBgXNp016477;
	Wed, 20 Mar 2024 11:47:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=uuiB08ZBj43SZsOFWh9a6LBYhx9AA7TaPdTndLtQZFE=;
 b=ZKDO+tvOgH4GwK3mlkCTVuMjS4qLLiYfdY06MQ4fcVnndwfdYnWDmhM/c90YX+xof2Yh
 CAobS6Er7yvvMHnTRqRpigvO3nRP7hKZec1s5K2f0UNuBzsOHfmudtnMXO7Uj8wKgoFb
 pbU9MYs0lMYrxIi9q5wjPLrbBBxPxGZ4q7WrJYThaECVVW5oo/LDuFrZaL+3DtaXFO0Z
 qlr57iLYCNz/yj/0EdRk9Y4WY1G/BL/A6wE0UqFedaSirnOl8BOzz5GV9yzdjgw0d7/a
 WmK2kLCViYZrBK4oluihWtmQkdAQxFo4ZEbDVtKJ6SxJD0RM9y5dGVYRpiTAP7dHc/Zg xg== 
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3wyy5f00cg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 20 Mar 2024 11:47:56 +0000
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 42KA0UZX002765;
	Wed, 20 Mar 2024 11:47:55 GMT
Received: from smtprelay05.dal12v.mail.ibm.com ([172.16.1.7])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 3wwrf2nk3f-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 20 Mar 2024 11:47:55 +0000
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com [10.241.53.100])
	by smtprelay05.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 42KBlrA624314568
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 20 Mar 2024 11:47:55 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E02B158065;
	Wed, 20 Mar 2024 11:47:52 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4A69D58057;
	Wed, 20 Mar 2024 11:47:52 +0000 (GMT)
Received: from sbct-3.pok.ibm.com (unknown [9.47.158.153])
	by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 20 Mar 2024 11:47:52 +0000 (GMT)
From: Stefan Berger <stefanb@linux.ibm.com>
To: keyrings@vger.kernel.org, linux-crypto@vger.kernel.org,
        herbert@gondor.apana.org.au, davem@davemloft.net
Cc: linux-kernel@vger.kernel.org, saulo.alessandre@tse.jus.br, lukas@wunner.de,
        bbhushan2@marvell.com, jarkko@kernel.org,
        Stefan Berger <stefanb@linux.ibm.com>
Subject: [PATCH v7 10/13] crypto: ecdsa - Rename keylen to bufsize where necessary
Date: Wed, 20 Mar 2024 07:47:22 -0400
Message-ID: <20240320114725.1644921-11-stefanb@linux.ibm.com>
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
X-Proofpoint-GUID: 6F-oKayDrPVVZb2dBBWYQVMRT-FP4yGk
X-Proofpoint-ORIG-GUID: 6F-oKayDrPVVZb2dBBWYQVMRT-FP4yGk
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-20_08,2024-03-18_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 lowpriorityscore=0 mlxlogscore=999 malwarescore=0 bulkscore=0 phishscore=0
 mlxscore=0 clxscore=1015 adultscore=0 suspectscore=0 impostorscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2403140000 definitions=main-2403200093

In cases where 'keylen' was referring to the size of the buffer used by
a curve's digits, it does not reflect the purpose of the variable anymore
once NIST P521 is used. What it refers to then is the size of the buffer,
which may be a few bytes larger than the size a coordinate of a key.
Therefore, rename keylen to bufsize where appropriate.

Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
Tested-by: Lukas Wunner <lukas@wunner.de>
---
 crypto/ecdsa.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/crypto/ecdsa.c b/crypto/ecdsa.c
index 4daefb40c37a..4e847b59622a 100644
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


