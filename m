Return-Path: <linux-kernel+bounces-108882-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 08FB8881154
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 12:50:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9D8A11F22B1C
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 11:50:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85880524C6;
	Wed, 20 Mar 2024 11:48:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="YO5MQE8o"
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAA2B44C9B;
	Wed, 20 Mar 2024 11:48:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710935288; cv=none; b=dxPEmDf6UIvlMt8L46bz7jXLf4UM1qN3GpNbH0ZGCbnqVN5D0CGtDE6hzZxYMPsPmhwxIjx95YJZcvgW6OFw0NGjXiCqiF/Karsw4V/3LZfNfJ7+9uc71byPhLpwGzlYQ4SpSBmnG3ULhnsbh5fnIJTfqWB68HsEBEX3aSTjI64=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710935288; c=relaxed/simple;
	bh=57Mrrkk3rM2Df+4ziayoSxodkT877KLcdgNO8v2SrB4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nQzlfecOojWAE1UrbZCpZQ8rUzWjrq8mrkn4QL+Py4Q0nJQ88xaQFBVAwLYHlAUSWO30E7SGfIMUwyt0hIJklI//A+8m8YyPqKvJ6avr4zWliPAudyIVq88qyuEM4tkoMf3H8fqtp/bM/6JM8RZXtOzkElqdO8lZoNAlFSQgR7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=YO5MQE8o; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353722.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 42KB5xAJ003848;
	Wed, 20 Mar 2024 11:47:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=62boGgRRQsdV4YqKuJqULLNt1uhiyvxQYfY5SnmWoE4=;
 b=YO5MQE8oaRzxI2+NgMQwH4hNqUsHWBdsrcj7LbnQVFb9YPz97lButulNix4IaotR6xNy
 QknG/FEs5a6NoQXA0czngIa/IZdTGE0nwYoLGcEHynPFXUZuG6hUMkEZWuaEJHUUrg9g
 j2oSaOyB/N5K9xPkbG33fxpXy7XSTHSsoaUift+878rzq0D3KDZal1JwtdGQS4XN7ppe
 LRIlen31JvfBZYat2D83qmfqxC72oP5vPJbTNTkuVwwEK/xBzkiMY26WPD8rSyQHI+Yb
 XTIZsPLK58OwtMzpfomfoxxDcK5iW4V2dNOZYX+CMkBZB7OnbeHkVrJzL9doYg1O2poK aQ== 
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3wyx9kg4q7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 20 Mar 2024 11:47:53 +0000
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 42KAfaDd015792;
	Wed, 20 Mar 2024 11:47:52 GMT
Received: from smtprelay03.dal12v.mail.ibm.com ([172.16.1.5])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3wwp50671a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 20 Mar 2024 11:47:52 +0000
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com [10.241.53.100])
	by smtprelay03.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 42KBlngX25690662
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 20 Mar 2024 11:47:51 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9DE4E58061;
	Wed, 20 Mar 2024 11:47:49 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id EAEDF58058;
	Wed, 20 Mar 2024 11:47:48 +0000 (GMT)
Received: from sbct-3.pok.ibm.com (unknown [9.47.158.153])
	by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 20 Mar 2024 11:47:48 +0000 (GMT)
From: Stefan Berger <stefanb@linux.ibm.com>
To: keyrings@vger.kernel.org, linux-crypto@vger.kernel.org,
        herbert@gondor.apana.org.au, davem@davemloft.net
Cc: linux-kernel@vger.kernel.org, saulo.alessandre@tse.jus.br, lukas@wunner.de,
        bbhushan2@marvell.com, jarkko@kernel.org,
        Stefan Berger <stefanb@linux.ibm.com>
Subject: [PATCH v7 06/13] crypto: ecc - Implement vli_mmod_fast_521 for NIST p521
Date: Wed, 20 Mar 2024 07:47:18 -0400
Message-ID: <20240320114725.1644921-7-stefanb@linux.ibm.com>
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
X-Proofpoint-GUID: KXhApP8c3vnR4MHpfkj2w9FgaTHgiqVf
X-Proofpoint-ORIG-GUID: KXhApP8c3vnR4MHpfkj2w9FgaTHgiqVf
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-20_08,2024-03-18_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 impostorscore=0
 lowpriorityscore=0 suspectscore=0 bulkscore=0 priorityscore=1501
 adultscore=0 phishscore=0 mlxlogscore=763 spamscore=0 malwarescore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2403140000 definitions=main-2403200093

Implement vli_mmod_fast_521 following the description for how to calculate
the modulus for NIST P521 in the NIST publication "Recommendations for
Discrete Logarithm-Based Cryptography: Elliptic Curve Domain Parameters"
section G.1.4.

NIST p521 requires 9 64bit digits, so increase the ECC_MAX_DIGITS so that
the vli digit array provides enough elements to fit the larger integers
required by this curve.

Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
Tested-by: Lukas Wunner <lukas@wunner.de>
---
 crypto/ecc.c                  | 25 +++++++++++++++++++++++++
 include/crypto/internal/ecc.h |  3 ++-
 2 files changed, 27 insertions(+), 1 deletion(-)

diff --git a/crypto/ecc.c b/crypto/ecc.c
index 415a2f4e7291..99d41887c005 100644
--- a/crypto/ecc.c
+++ b/crypto/ecc.c
@@ -902,6 +902,28 @@ static void vli_mmod_fast_384(u64 *result, const u64 *product,
 #undef AND64H
 #undef AND64L
 
+/*
+ * Computes result = product % curve_prime
+ * from "Recommendations for Discrete Logarithm-Based Cryptography:
+ *       Elliptic Curve Domain Parameters" section G.1.4
+ */
+static void vli_mmod_fast_521(u64 *result, const u64 *product,
+			      const u64 *curve_prime, u64 *tmp)
+{
+	const unsigned int ndigits = ECC_CURVE_NIST_P521_DIGITS;
+	size_t i;
+
+	/* Initialize result with lowest 521 bits from product */
+	vli_set(result, product, ndigits);
+	result[8] &= 0x1ff;
+
+	for (i = 0; i < ndigits; i++)
+		tmp[i] = (product[8 + i] >> 9) | (product[9 + i] << 55);
+	tmp[8] &= 0x1ff;
+
+	vli_mod_add(result, result, tmp, curve_prime, ndigits);
+}
+
 /* Computes result = product % curve_prime for different curve_primes.
  *
  * Note that curve_primes are distinguished just by heuristic check and
@@ -941,6 +963,9 @@ static bool vli_mmod_fast(u64 *result, u64 *product,
 	case ECC_CURVE_NIST_P384_DIGITS:
 		vli_mmod_fast_384(result, product, curve_prime, tmp);
 		break;
+	case ECC_CURVE_NIST_P521_DIGITS:
+		vli_mmod_fast_521(result, product, curve_prime, tmp);
+		break;
 	default:
 		pr_err_ratelimited("ecc: unsupported digits size!\n");
 		return false;
diff --git a/include/crypto/internal/ecc.h b/include/crypto/internal/ecc.h
index ab722a8986b7..4e2f5f938e91 100644
--- a/include/crypto/internal/ecc.h
+++ b/include/crypto/internal/ecc.h
@@ -33,7 +33,8 @@
 #define ECC_CURVE_NIST_P192_DIGITS  3
 #define ECC_CURVE_NIST_P256_DIGITS  4
 #define ECC_CURVE_NIST_P384_DIGITS  6
-#define ECC_MAX_DIGITS              (512 / 64) /* due to ecrdsa */
+#define ECC_CURVE_NIST_P521_DIGITS  9
+#define ECC_MAX_DIGITS              DIV_ROUND_UP(521, 64) /* NIST P521 */
 
 #define ECC_DIGITS_TO_BYTES_SHIFT 3
 
-- 
2.43.0


