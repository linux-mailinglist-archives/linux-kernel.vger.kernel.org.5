Return-Path: <linux-kernel+bounces-100675-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E852C879BA7
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 19:39:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9581E2884CE
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 18:39:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21E3614405D;
	Tue, 12 Mar 2024 18:37:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="iXbHyg96"
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F9DC142623;
	Tue, 12 Mar 2024 18:37:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710268678; cv=none; b=TWjWn7tlfq2Jt1Fkia/n7e2Adz9xhvTuG0NVq5nDL7Kxf72PUnd5XVGFyQt0y7ltKcTtJiQH7SLUvTUf3DsnBZepKowXgOS/AcXi2HQEcVVcT6wvGtolTbELHTlMMDXTvDSkv/eETRbhEFnKrAKrISYDQEbgphpC7PzKhAEgdzU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710268678; c=relaxed/simple;
	bh=0/0j5y0Uxmjp40sxhZacSNdDZLJSY5eKnAUkr0l0EHM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TWAZe7Mi1CT/BqK+q1OjCwJ7LzWh/1Pddi85Xl20/0jULapq/XB8+exWErjNXCwX3cykoviBMggLXY5AsylzY7R8tpHoUKLE8fJXHbbwfbLujiP9hCHmoKKdjxCjEel+pfAbMeA9ZQGAFQSC2EBVexw0EJOyQq0MI60XxjgjBOE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.vnet.ibm.com; spf=none smtp.mailfrom=linux.vnet.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=iXbHyg96; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.vnet.ibm.com
Received: from pps.filterd (m0353724.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 42CI2kLL006983;
	Tue, 12 Mar 2024 18:36:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=Zf9BYh7z5D/Q6qyMTn7djkaFsr2LTJ3S7C+L8kx5ivY=;
 b=iXbHyg96LC9tj9oAIfVrvMAWTFJf/zoaxoAXQtP3teOlRTlo+QbNOFMUDSi9/FrSNRCt
 YLRpAmIu1s5eW8kwSdyC6jbA+e/ZXQFxu2au7GBvnCdpALDV3UfBP+hUTXAcyHXvgBwn
 OQkIe4HENINmkFvdaVZ0yU8HpePw4hGMKNa3adTZ+6qp2TkCVbakym5MW31sDMoeuezC
 YKDPo6R2Sr9OW4eVX6QtlX2PQAqLKzDNwqithDm78eM5Tmz4349eIyuXvnaZN0ZIeyry
 yzsVGqhp1t9KIp1SGUcKRloS6Ra2163O/Y8qpq46UfwtB+MEbx/Pupv8HTXAhRtjPIq3 Jg== 
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3wtuyw0hcu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 12 Mar 2024 18:36:30 +0000
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 42CHZQ17018575;
	Tue, 12 Mar 2024 18:36:30 GMT
Received: from smtprelay05.wdc07v.mail.ibm.com ([172.16.1.72])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 3ws4t20d1u-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 12 Mar 2024 18:36:30 +0000
Received: from smtpav06.wdc07v.mail.ibm.com (smtpav06.wdc07v.mail.ibm.com [10.39.53.233])
	by smtprelay05.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 42CIaR1D39911744
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 12 Mar 2024 18:36:29 GMT
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 44EC658056;
	Tue, 12 Mar 2024 18:36:27 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 54FE35807A;
	Tue, 12 Mar 2024 18:36:26 +0000 (GMT)
Received: from sbct-3.pok.ibm.com (unknown [9.47.158.153])
	by smtpav06.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 12 Mar 2024 18:36:26 +0000 (GMT)
From: Stefan Berger <stefanb@linux.vnet.ibm.com>
To: keyrings@vger.kernel.org, linux-crypto@vger.kernel.org,
        herbert@gondor.apana.org.au, davem@davemloft.net
Cc: linux-kernel@vger.kernel.org, saulo.alessandre@tse.jus.br, lukas@wunner.de,
        bbhushan2@marvell.com, jarkko@kernel.org,
        Stefan Berger <stefanb@linux.ibm.com>
Subject: [PATCH v6 06/13] crypto: ecc - Implement vli_mmod_fast_521 for NIST p521
Date: Tue, 12 Mar 2024 14:36:11 -0400
Message-ID: <20240312183618.1211745-7-stefanb@linux.vnet.ibm.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240312183618.1211745-1-stefanb@linux.vnet.ibm.com>
References: <20240312183618.1211745-1-stefanb@linux.vnet.ibm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: JOALr8cJgjBAqjcCE9SHAnd3euWfW8Uy
X-Proofpoint-ORIG-GUID: JOALr8cJgjBAqjcCE9SHAnd3euWfW8Uy
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-12_11,2024-03-12_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 mlxscore=0
 clxscore=1015 malwarescore=0 mlxlogscore=784 spamscore=0 impostorscore=0
 suspectscore=0 phishscore=0 bulkscore=0 priorityscore=1501
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2403120139

From: Stefan Berger <stefanb@linux.ibm.com>

Implement vli_mmod_fast_521 following the description for how to calculate
the modulus for NIST P521 in the NIST publication "Recommendations for
Discrete Logarithm-Based Cryptography: Elliptic Curve Domain Parameters"
section G.1.4.

NIST p521 requires 9 64bit digits, so increase the ECC_MAX_DIGITS so that
arrays fit the larger numbers.

Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
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


