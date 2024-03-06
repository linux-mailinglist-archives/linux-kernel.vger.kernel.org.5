Return-Path: <linux-kernel+bounces-94650-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B53F8742AF
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 23:23:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 51E9B28387A
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 22:23:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 378091C691;
	Wed,  6 Mar 2024 22:23:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="HHNXvmvr"
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B107D1B7EB;
	Wed,  6 Mar 2024 22:23:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709763796; cv=none; b=KaXBmR0dE1yzKhbBlivjzJoRZu5n7THpF1W5REK6wwDi95AxUBzqNyvNl84Fj+p2Aa1z0PrzIJfgwaTgVj9OZlFPmo6XPPYQtYWPYgRlS+OseCgHGZgvTRHSG4ugajiVVnTLHLTmr7BmZjVLjyC6dV1jgX9YlPRzTWWj1nhHD+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709763796; c=relaxed/simple;
	bh=SJOKD7uuQlJE55cj/xODftPJbP3Cxm3ReHzwgkTk/GM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ggZi6WtOfXqvWF1cnjLvFxOxX7yZMdTjWZMPPryXyMi6ak2Z6bBgabeaqIvdQB6P7Gf+VpQXJJZPU3007T9Toc6cDxCTKRdOazGB9JRLU2zrPX0MuUtEi7me22Bps5dW8QPUBPxAYhy+3Sympj2VTXgOVaxcZnQvjhuW4inDMTg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=HHNXvmvr; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 426M5PLJ022867;
	Wed, 6 Mar 2024 22:23:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=374Fd/2z/xSzAEhcRLBk+xIlUVzJlxEoOyGJSPYS2jU=;
 b=HHNXvmvrzrIjt7JiunsRWVKc2T03V9/1ZD89l0kTE2Gry9EwZy/FXansjHoKuId/jJYb
 tTGKWfeOpdatLCyqiIl+Yjb5K195D9iLrDUAMrGavKc2pO9oaPt+dMCva9u2sk6BT9JO
 a+3xMJCSG+OfsD7NKJ5jUd6rJgpzuLR4VfuIzJbCXPzsB7kBusKb67ug1NNQsQhrIOQ0
 eooKwjHCSMGUl2P59Inuc9u7WOFzOpd/+r1dBOiqdVnSQB5NatAPl7DDQHxMPp5NxMZq
 kjLiLwCa0wMwAwswRSZOIRJ8VzxdQKtP5zCSpSGvI61Ej5UGQPKn/C0boYF4G5DCnXvO aQ== 
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3wq0gg13g2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 06 Mar 2024 22:23:08 +0000
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 426KVN4O031530;
	Wed, 6 Mar 2024 22:23:07 GMT
Received: from smtprelay02.dal12v.mail.ibm.com ([172.16.1.4])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 3wmgnk9ang-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 06 Mar 2024 22:23:07 +0000
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com [10.241.53.100])
	by smtprelay02.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 426MN5pn18809208
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 6 Mar 2024 22:23:07 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 488C35805D;
	Wed,  6 Mar 2024 22:23:05 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C89D758061;
	Wed,  6 Mar 2024 22:23:04 +0000 (GMT)
Received: from sbct-3.pok.ibm.com (unknown [9.47.158.153])
	by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Wed,  6 Mar 2024 22:23:04 +0000 (GMT)
From: Stefan Berger <stefanb@linux.ibm.com>
To: keyrings@vger.kernel.org, linux-crypto@vger.kernel.org,
        herbert@gondor.apana.org.au, davem@davemloft.net
Cc: linux-kernel@vger.kernel.org, saulo.alessandre@tse.jus.br, lukas@wunner.de,
        Stefan Berger <stefanb@linux.ibm.com>
Subject: [PATCH v5 05/12] crypto: ecc - Implement vli_mmod_fast_521 for NIST p521
Date: Wed,  6 Mar 2024 17:22:50 -0500
Message-ID: <20240306222257.979304-6-stefanb@linux.ibm.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240306222257.979304-1-stefanb@linux.ibm.com>
References: <20240306222257.979304-1-stefanb@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 9UTvLRbA3X1OW8TdrEDs9J79hbCHS_gW
X-Proofpoint-ORIG-GUID: 9UTvLRbA3X1OW8TdrEDs9J79hbCHS_gW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-06_12,2024-03-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 spamscore=0
 bulkscore=0 mlxlogscore=856 impostorscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 adultscore=0 phishscore=0 suspectscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2403060181

Implement vli_mmod_fast_521 following the description for how to calculate
the modulus for NIST P521 in the NIST publication "Recommendations for
Discrete Logarithm-Based Cryptography: Elliptic Curve Domain Parameters"
section G.1.4.

NIST p521 requires 9 64bit digits, so increase the ECC_MAX_DIGITS so that
arrays fit the larger numbers.

Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
Tested-by: Lukas Wunner <lukas@wunner.de>
---
 crypto/ecc.c                  | 31 +++++++++++++++++++++++++++++++
 include/crypto/internal/ecc.h |  2 +-
 2 files changed, 32 insertions(+), 1 deletion(-)

diff --git a/crypto/ecc.c b/crypto/ecc.c
index f53fb4d6af99..373660e7b19d 100644
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
+		if (curve->nbits == 521) {
+			vli_mmod_fast_521(result, product, curve_prime, tmp);
+			break;
+		}
+		fallthrough;
 	default:
 		pr_err_ratelimited("ecc: unsupported digits size!\n");
 		return false;
diff --git a/include/crypto/internal/ecc.h b/include/crypto/internal/ecc.h
index 4a556b41873e..de17bcdeb53a 100644
--- a/include/crypto/internal/ecc.h
+++ b/include/crypto/internal/ecc.h
@@ -33,7 +33,7 @@
 #define ECC_CURVE_NIST_P192_DIGITS  3
 #define ECC_CURVE_NIST_P256_DIGITS  4
 #define ECC_CURVE_NIST_P384_DIGITS  6
-#define ECC_MAX_DIGITS              (512 / 64) /* due to ecrdsa */
+#define ECC_MAX_DIGITS              DIV_ROUND_UP(521, 64) /* NIST P521 */
 
 #define ECC_DIGITS_TO_BYTES_SHIFT 3
 
-- 
2.43.0


