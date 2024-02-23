Return-Path: <linux-kernel+bounces-79117-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EB9E1861DCC
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 21:42:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 766631F23B4A
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 20:42:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51AFD149390;
	Fri, 23 Feb 2024 20:42:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="VV4iJJYi"
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 174FD1448DE;
	Fri, 23 Feb 2024 20:42:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708720934; cv=none; b=hJfh1sfe623ZdbZmVSG+2IAVtaKPEJVedD6dneHHp2E0qaSVsPE6c1aDgOFN57cAnhIY3x1u46w9qJGYtY+blNGAsH+R0VYi5EIQJC+84eVW+D7r+DNTTRFeDEOfqprw3GLBvqWAJReGbfwXUb7R44cn/lMow9YhbMfDv8nrOSk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708720934; c=relaxed/simple;
	bh=QZBk3pnFefPDh4cDeQB1N0Rf1cYuyeJKwTH++kOetoE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fcyUrxsFdVu/+8IpQFGoSaBW9IG2PB/HVMjjF5mdDrBV4jQ8GbbT2SFoCrEJppGMT+t4IXAlQvH6B/9deyw5TB6DY4esrylKwn9yHxca1LCZSbOu7JnVmCRa3rwNj4UhXeGMYpy4JzDC8EyjO+wlrAbwaUC1amF2vtUiDqTTlo8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=VV4iJJYi; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353726.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 41NKRGTa017962;
	Fri, 23 Feb 2024 20:42:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=vCotrLlllJbV3W12rV0W2qDDfKes5T/PPwflmMS/7oU=;
 b=VV4iJJYigHYVcd2Gc+TU13ey8LhJfwopB/uiXohoKfFicdtzfDaUH5Xc+oRdzkQAS3s+
 +R/mmfhbEFlBFP2z+7DtAtDFUKp/1gJzqOKODTCIWHcG1A6DbRiwvKgGe3CEmYuK0r23
 luEucUHaDYnfxUu/ZFC5mXLCRWuIDwhzK4LX+jpPlU8iYWos4GyA6qEepqM9IjcxeQkq
 Mwq8wM6qyOoz2xrYjlAXVfEMUE2x68HkFvOA8mDXIjimdZdVZovSvWg0kPhTH1IIbMzu
 o7mhGMZ1cBpebxJwSSomuv7fmQIheFlcRL2IhsQjYALv7xNc/bhqwwyfsLGClEB+ZUCg aQ== 
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3wf2dh8acw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 23 Feb 2024 20:42:09 +0000
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 41NIkUs3013463;
	Fri, 23 Feb 2024 20:42:08 GMT
Received: from smtprelay04.dal12v.mail.ibm.com ([172.16.1.6])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3wb7h109eu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 23 Feb 2024 20:42:08 +0000
Received: from smtpav02.wdc07v.mail.ibm.com (smtpav02.wdc07v.mail.ibm.com [10.39.53.229])
	by smtprelay04.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 41NKg5Vv22872702
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 23 Feb 2024 20:42:08 GMT
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B54795805E;
	Fri, 23 Feb 2024 20:42:05 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0806758058;
	Fri, 23 Feb 2024 20:42:05 +0000 (GMT)
Received: from sbct-3.pok.ibm.com (unknown [9.47.158.153])
	by smtpav02.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 23 Feb 2024 20:42:04 +0000 (GMT)
From: Stefan Berger <stefanb@linux.ibm.com>
To: keyrings@vger.kernel.org, linux-crypto@vger.kernel.org,
        herbert@gondor.apana.org.au, davem@davemloft.net
Cc: linux-kernel@vger.kernel.org, saulo.alessandre@tse.jus.br,
        Stefan Berger <stefanb@linux.ibm.com>
Subject: [PATCH v3 04/10] crypto: ecc - Implement vli_mmod_fast_521 for NIST p521
Date: Fri, 23 Feb 2024 15:41:43 -0500
Message-ID: <20240223204149.4055630-5-stefanb@linux.ibm.com>
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
X-Proofpoint-GUID: -vDKIUY31FFTXQkMs-KLD9B7flesnp-f
X-Proofpoint-ORIG-GUID: -vDKIUY31FFTXQkMs-KLD9B7flesnp-f
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-23_06,2024-02-23_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 mlxlogscore=781
 mlxscore=0 adultscore=0 suspectscore=0 phishscore=0 spamscore=0
 priorityscore=1501 malwarescore=0 impostorscore=0 bulkscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2402230152

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


