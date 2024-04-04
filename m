Return-Path: <linux-kernel+bounces-131594-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BAE58989D8
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 16:20:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ECD991F2F535
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 14:20:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC3EB12BF01;
	Thu,  4 Apr 2024 14:19:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="YGcaopXX"
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B16D12A166;
	Thu,  4 Apr 2024 14:19:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712240393; cv=none; b=XDNVgPMIT7cSIBovvX4hqEuo/YJWBmFKTDFsHVmNVMMM4hTTl6nyFlfeYix2G1vuJ9l0DWHlpOwyibvd1Q70ADgrvtHRcPiQWVTzjA0kaEMJ3RNXU4E/7p1bEvpk5TdCjwBpRj4YFJQQ1u+2gzTeEzuvWdt8e4ZrWBOlcJVbf+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712240393; c=relaxed/simple;
	bh=TRi3BII+ZRu/YP7ZbFz7/8DkYuYBPkpqZaGQTndvgMQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lbiEbJ44YNAcNA6NlzHuSeyEdYRs5LiYwYYfRFBlDd/srBBW8tvv97JZCWCaG6wK0njzEA3Aryk/gs7LZRIj1VuupI5c+ABEohWfVu7hqgdYWMZQ4rO5mzgS0R1c5f7AbEXC+OISJgpoj/FtVciavD4Pa4hCpAscYwFoYNAV2Iw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=YGcaopXX; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353728.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 434EHQhV016070;
	Thu, 4 Apr 2024 14:19:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=Gi1ggMDjIqyzhW3+hn0BOegvADYDVS7ArH93Dp9yfkA=;
 b=YGcaopXXRY1rB1qnTP5pafuRL1bvo0bZmb06+iY4HiKUWSukRTf0dL8tErK05THcerhZ
 iHQlR8kXU2j8x6adfHhxTXqK6/ZT/TVD2fTnheP33hwj5DgZEnMUas0fb23q+0OLcTZ+
 5SgsShazFHgHwNZBYfsBqcBRB2vioC8/13aKm+vFZ0letPMwrcL2Xj1YA2OnzCRdSJw9
 1PaDdO3jCf/rEAwfFsSXxvSMqypZUn4gp0uft7dPR/fUiX+VcudmZvhE2dbiyU2UWg7G
 uPajJXPcrmQ0U3AKS3RvYDe9D7a7ch5+DOcjPgNshIjU5vDpr5DMisj94WJV7o5ip5oU hQ== 
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3x9wu1g04t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 04 Apr 2024 14:19:40 +0000
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 434DgbX3031066;
	Thu, 4 Apr 2024 14:19:39 GMT
Received: from smtprelay05.dal12v.mail.ibm.com ([172.16.1.7])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 3x9epxmk9p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 04 Apr 2024 14:19:39 +0000
Received: from smtpav06.wdc07v.mail.ibm.com (smtpav06.wdc07v.mail.ibm.com [10.39.53.233])
	by smtprelay05.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 434EJblR42729868
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 4 Apr 2024 14:19:39 GMT
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id EEE735803F;
	Thu,  4 Apr 2024 14:19:36 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1B6335806D;
	Thu,  4 Apr 2024 14:19:36 +0000 (GMT)
Received: from sbct-3.pok.ibm.com (unknown [9.47.158.153])
	by smtpav06.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Thu,  4 Apr 2024 14:19:36 +0000 (GMT)
From: Stefan Berger <stefanb@linux.ibm.com>
To: keyrings@vger.kernel.org, linux-crypto@vger.kernel.org,
        herbert@gondor.apana.org.au, davem@davemloft.net
Cc: linux-kernel@vger.kernel.org, saulo.alessandre@tse.jus.br, lukas@wunner.de,
        bbhushan2@marvell.com, jarkko@kernel.org,
        Stefan Berger <stefanb@linux.ibm.com>
Subject: [PATCH v8 06/13] crypto: ecc - Implement vli_mmod_fast_521 for NIST p521
Date: Thu,  4 Apr 2024 10:18:49 -0400
Message-ID: <20240404141856.2399142-7-stefanb@linux.ibm.com>
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
X-Proofpoint-ORIG-GUID: hugQJAKfoHe5uCzo0wYBPoHycYrnfYWM
X-Proofpoint-GUID: hugQJAKfoHe5uCzo0wYBPoHycYrnfYWM
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-04_10,2024-04-04_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 mlxscore=0
 clxscore=1015 mlxlogscore=782 adultscore=0 spamscore=0 suspectscore=0
 impostorscore=0 bulkscore=0 priorityscore=1501 lowpriorityscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2404010000 definitions=main-2404040098

Implement vli_mmod_fast_521 following the description for how to calculate
the modulus for NIST P521 in the NIST publication "Recommendations for
Discrete Logarithm-Based Cryptography: Elliptic Curve Domain Parameters"
section G.1.4.

NIST p521 requires 9 64bit digits, so increase the ECC_MAX_DIGITS so that
the vli digit array provides enough elements to fit the larger integers
required by this curve.

Tested-by: Lukas Wunner <lukas@wunner.de>
Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>
Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
---
 crypto/ecc.c                  | 25 +++++++++++++++++++++++++
 include/crypto/internal/ecc.h |  3 ++-
 2 files changed, 27 insertions(+), 1 deletion(-)

diff --git a/crypto/ecc.c b/crypto/ecc.c
index 01aa70e97e55..90a8c7ea9095 100644
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


