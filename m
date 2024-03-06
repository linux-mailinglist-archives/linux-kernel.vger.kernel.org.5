Return-Path: <linux-kernel+bounces-94651-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 025B48742B0
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 23:23:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2B46F1C231AC
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 22:23:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFF431C6B6;
	Wed,  6 Mar 2024 22:23:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="jJiXBJja"
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4E551BC2F;
	Wed,  6 Mar 2024 22:23:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709763796; cv=none; b=OezvMfL5pxX4Oio/HZMnpvdrFC2nnceOGn9fhv+dkeyQGidchkxrqBKccbZtlfiVZxPMMtaHbIplLLKe56ueVOWB0tdQJcuqzeqmS7+1EIZn5rcRv9Zednc/yYYwNmhhY3dFE2VIQFfV0lAndkSVM2PpA953chQQF8u+eGQdQd0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709763796; c=relaxed/simple;
	bh=i6J+esBbWHQ/NvrG+nsDpe9tEBQDdH9rgmDRBvBf+gc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LN+11EP2mfh88VhHjRMUKszBj7vfG4kPwfbmB9mPZR1sZe9ZKLrUGa94CESFRxNuwMbo7p3V6i0fSeBXYLV3Al3Kv0aJPA1NyEYk2aJRq6P68WDfPRp/KQAsMHbJJ/MnY0bYLqZtStEX3oh5YuVCt1RuwBYZfYBVZQpVOWBhaCY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=jJiXBJja; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 426LX327009239;
	Wed, 6 Mar 2024 22:23:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=oV2gy2luQu0nOtwbYXj5/5qOjr/2zx807F7rLbJC9Y8=;
 b=jJiXBJjaUbUGWm1QR+MbPsGUUS/ezcsElaBCcp3H1Iy7BXeh9trt9IUzVzxXa1R5KOtx
 rfPrkS/nk9Fu/tpvJCCqXu9DrUlPVy5yhEh8vq69lt1/GcW+7uaWefRWBDhLSXILIyv/
 tt9PdGsmHZpNbldC5AgWgM1lCTrUbXUrauFhmOhUiX2heVi1h51KbHO+ob9r8xHPvyWx
 Dd3q93pSPa0yb93NfJ7aCEBV2WRlB3mESQD2Zpg1BubWvlI+i5JXrjQl1fzvEtL6bLss
 kS/hFAMwIRZKncuA2Q97Ug0VklnkcCvhwvVnEzWO704YSdQ1zxWX0KrtR/H1ZLc4jB9w 7g== 
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3wq0gg13gp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 06 Mar 2024 22:23:09 +0000
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 426LdOL4025366;
	Wed, 6 Mar 2024 22:23:09 GMT
Received: from smtprelay02.wdc07v.mail.ibm.com ([172.16.1.69])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3wmetysup1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 06 Mar 2024 22:23:09 +0000
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com [10.241.53.100])
	by smtprelay02.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 426MN6ql42926456
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 6 Mar 2024 22:23:08 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 767EB58059;
	Wed,  6 Mar 2024 22:23:06 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 02E1C58064;
	Wed,  6 Mar 2024 22:23:06 +0000 (GMT)
Received: from sbct-3.pok.ibm.com (unknown [9.47.158.153])
	by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Wed,  6 Mar 2024 22:23:05 +0000 (GMT)
From: Stefan Berger <stefanb@linux.ibm.com>
To: keyrings@vger.kernel.org, linux-crypto@vger.kernel.org,
        herbert@gondor.apana.org.au, davem@davemloft.net
Cc: linux-kernel@vger.kernel.org, saulo.alessandre@tse.jus.br, lukas@wunner.de,
        Stefan Berger <stefanb@linux.ibm.com>
Subject: [PATCH v5 07/12] crypto: ecc - Add NIST P521 curve parameters
Date: Wed,  6 Mar 2024 17:22:52 -0500
Message-ID: <20240306222257.979304-8-stefanb@linux.ibm.com>
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
X-Proofpoint-GUID: z9UBYG014EWh9emkJ4805BX5d7ETuGwG
X-Proofpoint-ORIG-GUID: z9UBYG014EWh9emkJ4805BX5d7ETuGwG
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-06_12,2024-03-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 spamscore=0
 bulkscore=0 mlxlogscore=999 impostorscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 adultscore=0 phishscore=0 suspectscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2403060181

Add the parameters for the NIST P521 curve and define a new curve ID
for it. Make the curve available in ecc_get_curve.

Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
Tested-by: Lukas Wunner <lukas@wunner.de>
---
 crypto/ecc.c            |  2 ++
 crypto/ecc_curve_defs.h | 45 +++++++++++++++++++++++++++++++++++++++++
 include/crypto/ecdh.h   |  1 +
 3 files changed, 48 insertions(+)

diff --git a/crypto/ecc.c b/crypto/ecc.c
index 55fd390d3386..6eb8dad23616 100644
--- a/crypto/ecc.c
+++ b/crypto/ecc.c
@@ -60,6 +60,8 @@ const struct ecc_curve *ecc_get_curve(unsigned int curve_id)
 		return &nist_p256;
 	case ECC_CURVE_NIST_P384:
 		return &nist_p384;
+	case ECC_CURVE_NIST_P521:
+		return &nist_p521;
 	default:
 		return NULL;
 	}
diff --git a/crypto/ecc_curve_defs.h b/crypto/ecc_curve_defs.h
index ab1ef3d94be5..0ecade7d02f5 100644
--- a/crypto/ecc_curve_defs.h
+++ b/crypto/ecc_curve_defs.h
@@ -89,6 +89,51 @@ static struct ecc_curve nist_p384 = {
 	.b = nist_p384_b
 };
 
+/* NIST P-521 */
+static u64 nist_p521_g_x[] = { 0xf97e7e31c2e5bd66ull, 0x3348b3c1856a429bull,
+				0xfe1dc127a2ffa8deull, 0xa14b5e77efe75928ull,
+				0xf828af606b4d3dbaull, 0x9c648139053fb521ull,
+				0x9e3ecb662395b442ull, 0x858e06b70404e9cdull,
+				0xc6ull };
+static u64 nist_p521_g_y[] = { 0x88be94769fd16650ull, 0x353c7086a272c240ull,
+				0xc550b9013fad0761ull, 0x97ee72995ef42640ull,
+				0x17afbd17273e662cull, 0x98f54449579b4468ull,
+				0x5c8a5fb42c7d1bd9ull, 0x39296a789a3bc004ull,
+				0x118ull };
+static u64 nist_p521_p[] = { 0xffffffffffffffffull, 0xffffffffffffffffull,
+				0xffffffffffffffffull, 0xffffffffffffffffull,
+				0xffffffffffffffffull, 0xffffffffffffffffull,
+				0xffffffffffffffffull, 0xffffffffffffffffull,
+				0x1ffull };
+static u64 nist_p521_n[] = { 0xbb6fb71e91386409ull, 0x3bb5c9b8899c47aeull,
+				0x7fcc0148f709a5d0ull, 0x51868783bf2f966bull,
+				0xfffffffffffffffaull, 0xffffffffffffffffull,
+				0xffffffffffffffffull, 0xffffffffffffffffull,
+				0x1ffull };
+static u64 nist_p521_a[] = { 0xfffffffffffffffcull, 0xffffffffffffffffull,
+				0xffffffffffffffffull, 0xffffffffffffffffull,
+				0xffffffffffffffffull, 0xffffffffffffffffull,
+				0xffffffffffffffffull, 0xffffffffffffffffull,
+				0x1ffull };
+static u64 nist_p521_b[] = { 0xef451fd46b503f00ull, 0x3573df883d2c34f1ull,
+				0x1652c0bd3bb1bf07ull, 0x56193951ec7e937bull,
+				0xb8b489918ef109e1ull, 0xa2da725b99b315f3ull,
+				0x929a21a0b68540eeull, 0x953eb9618e1c9a1full,
+				0x051ull };
+static struct ecc_curve nist_p521 = {
+	.name = "nist_521",
+	.nbits = 521,
+	.g = {
+		.x = nist_p521_g_x,
+		.y = nist_p521_g_y,
+		.ndigits = 9,
+	},
+	.p = nist_p521_p,
+	.n = nist_p521_n,
+	.a = nist_p521_a,
+	.b = nist_p521_b
+};
+
 /* curve25519 */
 static u64 curve25519_g_x[] = { 0x0000000000000009, 0x0000000000000000,
 				0x0000000000000000, 0x0000000000000000 };
diff --git a/include/crypto/ecdh.h b/include/crypto/ecdh.h
index a9f98078d29c..9784ecdd2fb4 100644
--- a/include/crypto/ecdh.h
+++ b/include/crypto/ecdh.h
@@ -26,6 +26,7 @@
 #define ECC_CURVE_NIST_P192	0x0001
 #define ECC_CURVE_NIST_P256	0x0002
 #define ECC_CURVE_NIST_P384	0x0003
+#define ECC_CURVE_NIST_P521	0x0004
 
 /**
  * struct ecdh - define an ECDH private key
-- 
2.43.0


