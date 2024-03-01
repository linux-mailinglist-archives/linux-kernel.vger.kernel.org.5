Return-Path: <linux-kernel+bounces-87824-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7296F86D989
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 03:20:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F23D41F234E8
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 02:20:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 807D73B19D;
	Fri,  1 Mar 2024 02:20:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="e5KcZ4U0"
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 042F03A8CF;
	Fri,  1 Mar 2024 02:20:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709259622; cv=none; b=gsHYAHht6o2+IGMMYMO5oq7b/+enn1QY4URpMRqIsloPrp2ZoudrToruJjkzM3py3rJdz4wi3kUC+aSk8q7Nnlm9lVpH91s9yrgkP/lu4MGzNh+aFtwaaTdeQrENoIiV2rXptp4VkCBIgGefTj4OnNxfOLq/8R37X4EWMbKl+F4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709259622; c=relaxed/simple;
	bh=izU+mhVuxmGZLH4923QH4fb8IcKtylcqzLPk1Cqo7hU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=U0IcJzIQ+mtv1y+iKX4Mf46bWb4LifkBn31ZTquwKBmAJTj33GHGdL8Cb8Yq2n7W3fIiSjvtwBD/iorNqFulgokYxt42MLwIQxzcQs6HsW0KB7+P560DPci20nhGvleiO8JalZSaSgJa2s6KLcavWacy0irLMCtaBVnOmkMyMOU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=e5KcZ4U0; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 4211HFDg007080;
	Fri, 1 Mar 2024 02:20:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=uQgCV7ljChfbk9Pg8e9OEwAz+CERRXkVwHVF9QYdDtk=;
 b=e5KcZ4U0BIwkpTDujm6gBTt98KUNXzJpnr1hH11vUiBZnvIlHfL1Dc01eX2xh7xnhVc/
 Q6o2Ar/SrgDjGU6L8XYEl/iwCTAVhrHL94FCnRHL8JaniEgHqK325uA0PKtQKNmWX9IZ
 YRacMNn8Gq/2JYb4DOwt0eSW1pTk6E6oww/dJ2EFKZhPfdVDAzU2PqquVmhyVjsNdnf5
 Y4dsJ1TQeYdgg47RyujGtWoh2wm6VyXRqWPzUrcvKYRCRaLkLrv2sgxQkod9cvWJiwpA
 BB/dyUBbNVOqBnHrtZdrEtT77yfa7wS69v/eopfbsDw4fFqZKNGzU14gKSMImRyFY5pw Bw== 
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3wk57h1dh7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 01 Mar 2024 02:20:15 +0000
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 41TNwnoD008827;
	Fri, 1 Mar 2024 02:20:14 GMT
Received: from smtprelay06.dal12v.mail.ibm.com ([172.16.1.8])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 3wftsu1w6e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 01 Mar 2024 02:20:14 +0000
Received: from smtpav05.dal12v.mail.ibm.com (smtpav05.dal12v.mail.ibm.com [10.241.53.104])
	by smtprelay06.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 4212KBYQ5047238
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 1 Mar 2024 02:20:13 GMT
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D079B58065;
	Fri,  1 Mar 2024 02:20:11 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5A5D15806D;
	Fri,  1 Mar 2024 02:20:11 +0000 (GMT)
Received: from sbct-3.pok.ibm.com (unknown [9.47.158.153])
	by smtpav05.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Fri,  1 Mar 2024 02:20:11 +0000 (GMT)
From: Stefan Berger <stefanb@linux.ibm.com>
To: keyrings@vger.kernel.org, linux-crypto@vger.kernel.org,
        herbert@gondor.apana.org.au, davem@davemloft.net
Cc: linux-kernel@vger.kernel.org, saulo.alessandre@tse.jus.br, lukas@wunner.de,
        Stefan Berger <stefanb@linux.ibm.com>
Subject: [PATCH v4 04/12] crypto: ecc - Implement vli_mmod_fast_521 for NIST p521
Date: Thu, 29 Feb 2024 21:19:59 -0500
Message-ID: <20240301022007.344948-5-stefanb@linux.ibm.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240301022007.344948-1-stefanb@linux.ibm.com>
References: <20240301022007.344948-1-stefanb@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: tq80GS16aRkKr-ycQLzZbf_-Qnu-JSak
X-Proofpoint-ORIG-GUID: tq80GS16aRkKr-ycQLzZbf_-Qnu-JSak
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-29_08,2024-02-29_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 lowpriorityscore=0 mlxscore=0 adultscore=0 spamscore=0 phishscore=0
 priorityscore=1501 impostorscore=0 mlxlogscore=828 clxscore=1015
 bulkscore=0 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2403010018

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
index 48a04605da7f..b63238b12204 100644
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


