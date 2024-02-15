Return-Path: <linux-kernel+bounces-67805-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 14E3885714A
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 00:15:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BA6491F22E10
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 23:15:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BEAE1474B2;
	Thu, 15 Feb 2024 23:14:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="qV+4Hr+E"
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B047145B0C;
	Thu, 15 Feb 2024 23:14:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708038876; cv=none; b=YKnBVZWdq5yUIvjitH9lr8NB2BYl8kDVPG9+a/wB0h1YqdLzn2Tn6ZZ5e0co9UZk3SWaLgpcvlH14iV8vO6CXIrAsOfouvyLivWq8RL53RMVZaHZpnR5IeVb1AdF5oDpsdRqEA1Ga5X/WhYgFhwdECBIMd8t9yf7laIi8yMZbCo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708038876; c=relaxed/simple;
	bh=QZBk3pnFefPDh4cDeQB1N0Rf1cYuyeJKwTH++kOetoE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MRG+L2caRojelfO6DvzI9YS0YiV61UhxP1hhtcNM/I3rMPE/MoJfnFTB5Qp6NAyGcOfssgEAhvDvhVaZct8qi2Ss4q0g1KbLUb8TbsTuuJ33MQd7IuO9fKx2tLShyhGfj29oLal0JshweN4MNnolgQdTPt5A5I3uNpgFSKiAaXI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=qV+4Hr+E; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 41FLtvNE015749;
	Thu, 15 Feb 2024 23:14:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=vCotrLlllJbV3W12rV0W2qDDfKes5T/PPwflmMS/7oU=;
 b=qV+4Hr+EXLpo4MNh6lzcqjUNjSKGzDFh2/kSNjNadmhVx5HaZofs0+H8YrwGKh9d3sYo
 IbljQYlYZ9YnI2hKP4j6sB/mFiaPJva+HuoCovqBXsyNmTKt4cBFYY1bs9PxWQDuZgc1
 eeIKIoSzeaePFzdlyEkOxCdZCqcLlQMZIQxA5X/XdMelAHNwsxf4PQ38Uv7I2vddoERT
 jIu7EhPsDkPFAWiR1H5w9/VEg2i5W+fWL3H0w8sUOb3lfqpdD8I+5bRmMt9DYHfKIPQH
 PDhHaTc4GbyWjYQ3x7VhjhAbuUd441RtoklTSY8U9Xv4/PhkhrY5cbpRvufGzM2HYmPh Zw== 
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3w9rmnx127-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 15 Feb 2024 23:14:27 +0000
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 41FMu1VD016479;
	Thu, 15 Feb 2024 23:14:26 GMT
Received: from smtprelay06.wdc07v.mail.ibm.com ([172.16.1.73])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3w6mymytf0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 15 Feb 2024 23:14:26 +0000
Received: from smtpav04.wdc07v.mail.ibm.com (smtpav04.wdc07v.mail.ibm.com [10.39.53.231])
	by smtprelay06.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 41FNENvl20054588
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 15 Feb 2024 23:14:25 GMT
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 99DB15805E;
	Thu, 15 Feb 2024 23:14:23 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E8F5D58061;
	Thu, 15 Feb 2024 23:14:22 +0000 (GMT)
Received: from sbct-3.pok.ibm.com (unknown [9.47.158.153])
	by smtpav04.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 15 Feb 2024 23:14:22 +0000 (GMT)
From: Stefan Berger <stefanb@linux.ibm.com>
To: keyrings@vger.kernel.org, linux-crypto@vger.kernel.org,
        herbert@gondor.apana.org.au, davem@davemloft.net
Cc: linux-kernel@vger.kernel.org, saulo.alessandre@tse.jus.br,
        Stefan Berger <stefanb@linux.ibm.com>
Subject: [PATCH v2 04/14] crypto: ecc - Implement vli_mmod_fast_521 for NIST p521
Date: Thu, 15 Feb 2024 18:14:03 -0500
Message-ID: <20240215231414.3857320-5-stefanb@linux.ibm.com>
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
X-Proofpoint-GUID: r1KrhpsjBVgajI9yNUGFCL9s1Ou8qys_
X-Proofpoint-ORIG-GUID: r1KrhpsjBVgajI9yNUGFCL9s1Ou8qys_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-15_22,2024-02-14_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 adultscore=0
 phishscore=0 mlxlogscore=751 spamscore=0 priorityscore=1501 suspectscore=0
 impostorscore=0 malwarescore=0 clxscore=1015 bulkscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2402150181

Implement vli_mmod_fast_521 following the description for how to calculate
the modulus for NIST P521 in the NIST publication "Recommendations for
Discrete Logarithm-Based Cryptography: Elliptic Curve Domain Parameters"
section G.1.4.

NIST p521 requires 9 64bit digits, so increase the ECC_MAX_DIGITS so that
arrays fit the larger numbers.

Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
---
 crypto/ecc.c                  | 31 +++++++++++++++++++++++++++++++
 include/crypto/internal/ecc.h |  2 +-
 2 files changed, 32 insertions(+), 1 deletion(-)

diff --git a/crypto/ecc.c b/crypto/ecc.c
index f53fb4d6af99..ea7b28b5e00e 100644
--- a/crypto/ecc.c
+++ b/crypto/ecc.c
@@ -902,6 +902,31 @@ static void vli_mmod_fast_384(u64 *result, const u64 *product,
 #undef AND64H
 #undef AND64L
 
+/* Computes result = product % curve_prime
+ * from "Recommendations for Discrete Logarithm-Based Cryptography:
+ *       Elliptic Curve Domain Parameters" G.1.4
+ */
+static void vli_mmod_fast_521(u64 *result, const u64 *product,
+				const u64 *curve_prime, u64 *tmp)
+{
+	const unsigned int ndigits = 9;
+	size_t i;
+
+	for (i = 0; i < ndigits; i++)
+		tmp[i] = product[i];
+	tmp[8] &= 0x1ff;
+
+	vli_set(result, tmp, ndigits);
+
+
+	for (i = 0; i < ndigits; i++)
+		tmp[i] = (product[8 + i] >> 9) | (product[9 + i] << 55);
+	tmp[8] &= 0x1ff;
+
+	vli_mod_add(result, result, tmp, curve_prime, ndigits);
+}
+
+
 /* Computes result = product % curve_prime for different curve_primes.
  *
  * Note that curve_primes are distinguished just by heuristic check and
@@ -941,6 +966,12 @@ static bool vli_mmod_fast(u64 *result, u64 *product,
 	case 6:
 		vli_mmod_fast_384(result, product, curve_prime, tmp);
 		break;
+	case 9:
+		if (!strcmp(curve->name, "nist_521")) {
+			vli_mmod_fast_521(result, product, curve_prime, tmp);
+			break;
+		}
+		fallthrough;
 	default:
 		pr_err_ratelimited("ecc: unsupported digits size!\n");
 		return false;
diff --git a/include/crypto/internal/ecc.h b/include/crypto/internal/ecc.h
index bee3329af7de..b8ca5023b3b5 100644
--- a/include/crypto/internal/ecc.h
+++ b/include/crypto/internal/ecc.h
@@ -33,7 +33,7 @@
 #define ECC_CURVE_NIST_P192_DIGITS  3
 #define ECC_CURVE_NIST_P256_DIGITS  4
 #define ECC_CURVE_NIST_P384_DIGITS  6
-#define ECC_MAX_DIGITS              (512 / 64) /* due to ecrdsa */
+#define ECC_MAX_DIGITS              (576 / 64) /* due to NIST P521 */
 
 #define ECC_DIGITS_TO_BYTES_SHIFT 3
 
-- 
2.43.0


