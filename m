Return-Path: <linux-kernel+bounces-108878-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 68DFC881147
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 12:49:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 173A61F2302A
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 11:49:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F57347F48;
	Wed, 20 Mar 2024 11:48:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="qYJlKsJQ"
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A54D3FE20;
	Wed, 20 Mar 2024 11:48:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710935285; cv=none; b=hhNSHS4o9Wdf5s8bru9cQLj9OXy+Fp5kcQw4GzJnwG2oPU1iXdGuO5SiNA909xYe8LVY1O4CMBGURX8xrSz13tCYfkCIJdVH6JLWJqr5Sj3XQdBcbh3DqgCoFQ4aA/lPFbYtJv4MhV/itL3sIAPefKsX9g+6C4ANZrDZaLYQW1Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710935285; c=relaxed/simple;
	bh=7WqSylbIzOjh21fPLC7Si2XXorC24cDxT/Kun4cDdE0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RFGHXfipXqnmmemIVHBMrhBehGB8mQkSv4d3BvDvdqFmLcg4zwP8Mh2wRLnKB+xKb3sVZ8cgTWtJR5BAhAUMDPHw0a4yk6uzuboSlT2vczyKgIwPU0agpsB9zZXizVvQspqtAu+E4mToDp//a00Whtr+NL0jyt5edk20D/ifzpc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=qYJlKsJQ; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353727.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 42K92K2R000765;
	Wed, 20 Mar 2024 11:47:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=fqBVxCI9drzgI4JARsB4lrXIflRkdUMYH0t/R3+EjIY=;
 b=qYJlKsJQekA2vLb0Rv5dAyuUxKRAjt15CVexH21mlysiFzZvxAUmVMbzLqePj/MGDnKT
 4Y3gMevKBm3w+BoA37rawtfRKA5jSt9NJpBOsl3ckjnelNC7Q1A9endYfswo+Dh6UaFV
 73oRqs64f9s/OEFN7ITC5br24KS/stRTsxpmGugm0w2sQl5gEhCMbZ2Uwfl0Ktt/aPJb
 22BxaJ8MRPhwYANKohCuqeRfVG4G6Q4PsJpvbXKTrlH/tbY03MNjpkCRzTla4ZT0i6I9
 Nxp+ZWu/1SGPFgfIbdpA58HPydI7lDJjqB1UuzAJ0gYsGlpvLEbbhCR+EQgPOSsg7xM3 5A== 
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3wyvte0bky-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 20 Mar 2024 11:47:54 +0000
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 42KA8uWY010083;
	Wed, 20 Mar 2024 11:47:53 GMT
Received: from smtprelay02.dal12v.mail.ibm.com ([172.16.1.4])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3wxvav314r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 20 Mar 2024 11:47:53 +0000
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com [10.241.53.100])
	by smtprelay02.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 42KBlo5N25363084
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 20 Mar 2024 11:47:52 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 695B858063;
	Wed, 20 Mar 2024 11:47:50 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B67F758058;
	Wed, 20 Mar 2024 11:47:49 +0000 (GMT)
Received: from sbct-3.pok.ibm.com (unknown [9.47.158.153])
	by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 20 Mar 2024 11:47:49 +0000 (GMT)
From: Stefan Berger <stefanb@linux.ibm.com>
To: keyrings@vger.kernel.org, linux-crypto@vger.kernel.org,
        herbert@gondor.apana.org.au, davem@davemloft.net
Cc: linux-kernel@vger.kernel.org, saulo.alessandre@tse.jus.br, lukas@wunner.de,
        bbhushan2@marvell.com, jarkko@kernel.org,
        Stefan Berger <stefanb@linux.ibm.com>
Subject: [PATCH v7 07/13] crypto: ecc - Add special case for NIST P521 in ecc_point_mult
Date: Wed, 20 Mar 2024 07:47:19 -0400
Message-ID: <20240320114725.1644921-8-stefanb@linux.ibm.com>
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
X-Proofpoint-ORIG-GUID: e4D1qK_SgN5z2ArxzC5VTMfcX8m5yvbR
X-Proofpoint-GUID: e4D1qK_SgN5z2ArxzC5VTMfcX8m5yvbR
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-20_08,2024-03-18_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 spamscore=0
 bulkscore=0 mlxlogscore=999 clxscore=1015 impostorscore=0
 lowpriorityscore=0 mlxscore=0 suspectscore=0 malwarescore=0
 priorityscore=1501 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2403140000 definitions=main-2403200093

In ecc_point_mult use the number of bits of the NIST P521 curve + 2. The
change is required specifically for NIST P521 to pass mathematical tests
on the public key.

Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
Tested-by: Lukas Wunner <lukas@wunner.de>
Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>
---
 crypto/ecc.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/crypto/ecc.c b/crypto/ecc.c
index 99d41887c005..ead40b5ebb46 100644
--- a/crypto/ecc.c
+++ b/crypto/ecc.c
@@ -1320,7 +1320,10 @@ static void ecc_point_mult(struct ecc_point *result,
 	carry = vli_add(sk[0], scalar, curve->n, ndigits);
 	vli_add(sk[1], sk[0], curve->n, ndigits);
 	scalar = sk[!carry];
-	num_bits = sizeof(u64) * ndigits * 8 + 1;
+	if (curve->nbits == 521)	/* NIST P521 */
+		num_bits = curve->nbits + 2;
+	else
+		num_bits = sizeof(u64) * ndigits * 8 + 1;
 
 	vli_set(rx[1], point->x, ndigits);
 	vli_set(ry[1], point->y, ndigits);
-- 
2.43.0


