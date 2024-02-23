Return-Path: <linux-kernel+bounces-79119-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 199EB861DD0
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 21:42:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7CFA51F227D1
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 20:42:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95A6914C5BE;
	Fri, 23 Feb 2024 20:42:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="HpZNBIe8"
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C8DF1482E7;
	Fri, 23 Feb 2024 20:42:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708720935; cv=none; b=WrE7kSrxbQ94RD+E9CPYRYXhxemQoWTRKxzolkpm3L7iL5vkPHUP5n8T13M1F65wmqbsgUHaXXZjiD+/zlStoR+8pdOeurKmqK9inDFKlKpObsHpeBRJdt+E3Jlzc4T8zMhY3VL0FGc6XeoBuC0fpSs95iHHjKvAU4GVuFw1vE8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708720935; c=relaxed/simple;
	bh=Mw4S8Mathx6d1wOd81xYFMN9D7V8nkcT9m4+08HY+q8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IFOPsDyS0sF0azv5eXjGdUjYxQFBPykDL/XUc9wBavXOXLLS2AXty+12w+swh++x4bnZj+tLI709C0YNVaBv+oOG0IldoCD45rJvA9e1hMoQqU3xRgk4DErQOw0ZeL/VFSVWHddgZDgT68+6mX3U0wjTPHWLr8+ptofNQccdn0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=HpZNBIe8; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353728.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 41NKRFrw007935;
	Fri, 23 Feb 2024 20:42:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=2auxadmknAnWxSi7+6MCIOJLf41r1833HhtrUKpLSYg=;
 b=HpZNBIe8LyD/7O6irI7Co1828OIXEKs30vpl7S+0A3LcnvSTx0wtfXJ1klSknoRlWG1F
 oH/SwXgljmF1LRTqUrlusOLpz7iEr5LQZHZpWERcXOKlJ/1sxwLqdpsEAhacX3L9F615
 qIYRBYpq1UnawqSpz/QfUFBr3uOuNk9n79NKvIUqmztUmRZ91wUGrPZxLg1FyRTUU6X0
 eWI/nM9k6TAXuOwWb43zVkviRCtyKggyotNJZyP/L78v1fhtbZuIunlc40sNkn85AdMu
 G2JAM+VrlqOJNbFvYyAunN4kMu8+IPW8GLOEmfbjJqu6sTub4vRnE10Vq/1En2J/z9jJ 2Q== 
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3wf2djr751-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 23 Feb 2024 20:42:08 +0000
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 41NIjnlD031118;
	Fri, 23 Feb 2024 20:42:07 GMT
Received: from smtprelay03.dal12v.mail.ibm.com ([172.16.1.5])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 3wb9bmfmq8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 23 Feb 2024 20:42:07 +0000
Received: from smtpav02.wdc07v.mail.ibm.com (smtpav02.wdc07v.mail.ibm.com [10.39.53.229])
	by smtprelay03.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 41NKg4vT12583442
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 23 Feb 2024 20:42:07 GMT
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D67D75805B;
	Fri, 23 Feb 2024 20:42:04 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 29F2E58058;
	Fri, 23 Feb 2024 20:42:04 +0000 (GMT)
Received: from sbct-3.pok.ibm.com (unknown [9.47.158.153])
	by smtpav02.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 23 Feb 2024 20:42:04 +0000 (GMT)
From: Stefan Berger <stefanb@linux.ibm.com>
To: keyrings@vger.kernel.org, linux-crypto@vger.kernel.org,
        herbert@gondor.apana.org.au, davem@davemloft.net
Cc: linux-kernel@vger.kernel.org, saulo.alessandre@tse.jus.br,
        Stefan Berger <stefanb@linux.ibm.com>
Subject: [PATCH v3 03/10] crypto: ecdsa - Extend res.x mod n calculation for NIST P521
Date: Fri, 23 Feb 2024 15:41:42 -0500
Message-ID: <20240223204149.4055630-4-stefanb@linux.ibm.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240223204149.4055630-1-stefanb@linux.ibm.com>
References: <20240223204149.4055630-1-stefanb@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: fbJgiB26zu6LvYSZY5dFfj8BGQDp28WM
X-Proofpoint-ORIG-GUID: fbJgiB26zu6LvYSZY5dFfj8BGQDp28WM
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-23_06,2024-02-23_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999
 malwarescore=0 phishscore=0 adultscore=0 suspectscore=0 bulkscore=0
 mlxscore=0 impostorscore=0 priorityscore=1501 lowpriorityscore=0
 clxscore=1015 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2402230152

res.x has been calculated by ecc_point_mult_shamir, which uses
'mod curve_prime'. The curve_prime 'p' is typically larger than the
curve_order 'n' and therefore it is possible that p > res.x >= n.

If res.x >= n then res.x mod n can be calculated by iteratively sub-
tracting n from res.x until n > res.x. For NIST P192/256/384 this can be
done in a single subtraction. This can also be done in a single
subtraction for NIST P521.

The mathematical reason why a single subtraction is sufficient is
due to the values of 'p' and 'n' of the NIST curves where the following
holds true:

   note: max(res.x) = p - 1

   max(res.x) - n < n
       p - 1  - n < n
       p - 1      < 2n  => true for the NIST curves

Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
---
 crypto/ecdsa.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/crypto/ecdsa.c b/crypto/ecdsa.c
index 64e1e69d53ba..1814f009f971 100644
--- a/crypto/ecdsa.c
+++ b/crypto/ecdsa.c
@@ -122,7 +122,7 @@ static int _ecdsa_verify(struct ecc_ctx *ctx, const u64 *hash, const u64 *r, con
 
 	/* res.x = res.x mod n (if res.x > order) */
 	if (unlikely(vli_cmp(res.x, curve->n, ndigits) == 1))
-		/* faster alternative for NIST p384, p256 & p192 */
+		/* faster alternative for NIST p521, p384, p256 & p192 */
 		vli_sub(res.x, res.x, curve->n, ndigits);
 
 	if (!vli_cmp(res.x, r, ndigits))
-- 
2.43.0


