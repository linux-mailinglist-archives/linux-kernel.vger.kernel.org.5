Return-Path: <linux-kernel+bounces-131591-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 40BAA8989CD
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 16:20:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F07BF28BA42
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 14:19:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9084A129E66;
	Thu,  4 Apr 2024 14:19:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Xk+S9dw+"
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 330CC823D0;
	Thu,  4 Apr 2024 14:19:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712240389; cv=none; b=IGA3QEFmA//ILjbktITyORDvCKayCZFYvVeiSFkUEoK2OkNZhIft2qgxRC1RIuuwzNL/59/kUDb8uiH1O3ZgbyviZigSCU5QabBNnEcsLjH3sixC+pScz3fJfAXA7OGYealvPuK5fNettBu+JMCJBCNmZhHOlioYVrITVUP/9jc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712240389; c=relaxed/simple;
	bh=7n10ky3Ncdz6Lw03XqsMc0gUi5tPtH8zOClFhAgRNDA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SBMzwEg8DuKh7X6yXg6p8+HW0yNKJe+A/htkJOM5/R/XjJ2POdnvcjT9iZjojh1kf8D/DjhSM375dTaBIwOgLA8phK3IyNUmawjA1CjVgGkdf6DJR8DI7rMvSUowborOE5ckUS7AuJicTWDfe+TOjD0b1arm5cnRdSUIdQVxaxk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Xk+S9dw+; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353728.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 434EHB1j015894;
	Thu, 4 Apr 2024 14:19:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=RaKwIs0VmiY7LXrvkCeRa3Sg2tsbMlNxX8BZdybEUJU=;
 b=Xk+S9dw+etWO2vu9S/obXQIGRw+mhbYjEqwyormYkGH7kFMJw1bPmXI9S2eGNLlEfXEL
 0q7vot4fe8S/HjjO/fo5q5+SKsTuesN5xnH4ND3cC/uB0DUUxG6kEZc3BCBkR9X6IwbF
 315lN2PdlQyxv9WIHsIwHxuFU7ZAx/DZkzrybWp5pRlgD3DDALodUFJgz3gv0+XkuSbX
 PBZUj4Og9ZV9+BuM5erd2J4ih4wEzpkN6RKIbD0n8jUfW/KtmWdAQE2xtCtgGugUbG8R
 0l2I1BIDQi8Q6ir4c0OWKc2TVC8sV+XLIgeKeCqths8NMbr9daP6/1Mcm4C1KuYfjEmQ fQ== 
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3x9wu1g04m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 04 Apr 2024 14:19:35 +0000
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 434Dcuuo007713;
	Thu, 4 Apr 2024 14:19:34 GMT
Received: from smtprelay05.wdc07v.mail.ibm.com ([172.16.1.72])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 3x9epwmjef-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 04 Apr 2024 14:19:34 +0000
Received: from smtpav06.wdc07v.mail.ibm.com (smtpav06.wdc07v.mail.ibm.com [10.39.53.233])
	by smtprelay05.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 434EJVRN28770824
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 4 Apr 2024 14:19:34 GMT
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E3DB858062;
	Thu,  4 Apr 2024 14:19:31 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 107CA58056;
	Thu,  4 Apr 2024 14:19:31 +0000 (GMT)
Received: from sbct-3.pok.ibm.com (unknown [9.47.158.153])
	by smtpav06.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Thu,  4 Apr 2024 14:19:30 +0000 (GMT)
From: Stefan Berger <stefanb@linux.ibm.com>
To: keyrings@vger.kernel.org, linux-crypto@vger.kernel.org,
        herbert@gondor.apana.org.au, davem@davemloft.net
Cc: linux-kernel@vger.kernel.org, saulo.alessandre@tse.jus.br, lukas@wunner.de,
        bbhushan2@marvell.com, jarkko@kernel.org,
        Stefan Berger <stefanb@linux.ibm.com>
Subject: [PATCH v8 01/13] crypto: ecc - Use ECC_CURVE_NIST_P192/256/384_DIGITS where possible
Date: Thu,  4 Apr 2024 10:18:44 -0400
Message-ID: <20240404141856.2399142-2-stefanb@linux.ibm.com>
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
X-Proofpoint-ORIG-GUID: a8oYxE7yFiZSQH7FlexhcJqp5SRSRGYH
X-Proofpoint-GUID: a8oYxE7yFiZSQH7FlexhcJqp5SRSRGYH
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-04_10,2024-04-04_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 mlxscore=0
 clxscore=1015 mlxlogscore=999 adultscore=0 spamscore=0 suspectscore=0
 impostorscore=0 bulkscore=0 priorityscore=1501 lowpriorityscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2404010000 definitions=main-2404040098

Replace hard-coded numbers with ECC_CURVE_NIST_P192/256/384_DIGITS where
possible.

Tested-by: Lukas Wunner <lukas@wunner.de>
Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>
Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
---
 crypto/ecc.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/crypto/ecc.c b/crypto/ecc.c
index 3581027e9f92..01aa70e97e55 100644
--- a/crypto/ecc.c
+++ b/crypto/ecc.c
@@ -689,7 +689,7 @@ static void vli_mmod_barrett(u64 *result, u64 *product, const u64 *mod,
 static void vli_mmod_fast_192(u64 *result, const u64 *product,
 			      const u64 *curve_prime, u64 *tmp)
 {
-	const unsigned int ndigits = 3;
+	const unsigned int ndigits = ECC_CURVE_NIST_P192_DIGITS;
 	int carry;
 
 	vli_set(result, product, ndigits);
@@ -717,7 +717,7 @@ static void vli_mmod_fast_256(u64 *result, const u64 *product,
 			      const u64 *curve_prime, u64 *tmp)
 {
 	int carry;
-	const unsigned int ndigits = 4;
+	const unsigned int ndigits = ECC_CURVE_NIST_P256_DIGITS;
 
 	/* t */
 	vli_set(result, product, ndigits);
@@ -800,7 +800,7 @@ static void vli_mmod_fast_384(u64 *result, const u64 *product,
 				const u64 *curve_prime, u64 *tmp)
 {
 	int carry;
-	const unsigned int ndigits = 6;
+	const unsigned int ndigits = ECC_CURVE_NIST_P384_DIGITS;
 
 	/* t */
 	vli_set(result, product, ndigits);
@@ -932,13 +932,13 @@ static bool vli_mmod_fast(u64 *result, u64 *product,
 	}
 
 	switch (ndigits) {
-	case 3:
+	case ECC_CURVE_NIST_P192_DIGITS:
 		vli_mmod_fast_192(result, product, curve_prime, tmp);
 		break;
-	case 4:
+	case ECC_CURVE_NIST_P256_DIGITS:
 		vli_mmod_fast_256(result, product, curve_prime, tmp);
 		break;
-	case 6:
+	case ECC_CURVE_NIST_P384_DIGITS:
 		vli_mmod_fast_384(result, product, curve_prime, tmp);
 		break;
 	default:
-- 
2.43.0


