Return-Path: <linux-kernel+bounces-79124-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B9473861DE5
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 21:44:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DC22B1C23C7E
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 20:44:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBD2714EFE1;
	Fri, 23 Feb 2024 20:42:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="fPlJfTsW"
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E17B14CAD9;
	Fri, 23 Feb 2024 20:42:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708720940; cv=none; b=QlPvldJLzRQjfq8gmJS0U7pD0M/eVaN6jERJ1tZYxIwqVSFr6yP6v5Geila8F1Y/cj68gooDmksxC7JTa49RKjEUe77+ACl1FSdZYAb7Tb83OeM7bWPQfPcjz2FqcdfcuNynLHhWfGALk1puebzL0KPwSJAFrcXrIJ3SkEaidnU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708720940; c=relaxed/simple;
	bh=taB+XqKf8h2LSk7z7gsleggcIXvSW5Uib1xR5BFlhhg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FdmECbNUt8SH7BHepHBNbWg0G6b6/++90YSgYBttgnZOq6A1SfuTawoeFTM39UO/j8UcUvfq272iznTTph6xMKzASzw6NDvJdeuAM1UC6ApRhvfZLuj3wy2qjCpS+mrTqxv/zkMl+F6L30HnJopvPLg/b6a5XO4eR/EV806oUls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=fPlJfTsW; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 41NKcQeg001943;
	Fri, 23 Feb 2024 20:42:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=2oTUnf1K/62zFEYxWi574mF/SmQDk6vWwss6m5cqGBg=;
 b=fPlJfTsWmqZAjsCXjtgMd22OtUqwOIxrUvx1DuRHWjFyPwtIJTp7xO/zIzZcBp0ga/cE
 Q2emTbUd9Y0cZO1nMieOfcKCWMZw+dEPf1Mxb032gAIRmZ3js+BWbphb1MrUQ2xegcN3
 x6/KsMvtz7AzoxuX7myF2BYB9mrkQPujO2Xlcw2E4k78jjVKMTD+nXr2ftA9e0QPA81J
 Brqtqeqh4wel4NEo1oOlSjke49sr/Sa9iy4yl+6Yzh/fFjA3SnOO7vWs6ixU2Vvqy3ID
 jG6GfBar3S1QatbQuIIoLJsQD8vpH+9iBbhInxWZIpEhVk3c1lvORtRNOdDLdObhNjIm RA== 
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3wf2jtg24n-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 23 Feb 2024 20:42:12 +0000
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 41NJlf5u009577;
	Fri, 23 Feb 2024 20:42:11 GMT
Received: from smtprelay01.wdc07v.mail.ibm.com ([172.16.1.68])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3wb84q01u8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 23 Feb 2024 20:42:11 +0000
Received: from smtpav02.wdc07v.mail.ibm.com (smtpav02.wdc07v.mail.ibm.com [10.39.53.229])
	by smtprelay01.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 41NKg9ah46268768
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 23 Feb 2024 20:42:11 GMT
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4765F58059;
	Fri, 23 Feb 2024 20:42:09 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8EC055805F;
	Fri, 23 Feb 2024 20:42:08 +0000 (GMT)
Received: from sbct-3.pok.ibm.com (unknown [9.47.158.153])
	by smtpav02.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 23 Feb 2024 20:42:08 +0000 (GMT)
From: Stefan Berger <stefanb@linux.ibm.com>
To: keyrings@vger.kernel.org, linux-crypto@vger.kernel.org,
        herbert@gondor.apana.org.au, davem@davemloft.net
Cc: linux-kernel@vger.kernel.org, saulo.alessandre@tse.jus.br,
        Stefan Berger <stefanb@linux.ibm.com>
Subject: [PATCH v3 08/10] crypto: ecc - Add NIST P521 curve parameters
Date: Fri, 23 Feb 2024 15:41:47 -0500
Message-ID: <20240223204149.4055630-9-stefanb@linux.ibm.com>
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
X-Proofpoint-ORIG-GUID: cB-bcTrsYE3cISoBtd9pwuzu_v78bHu_
X-Proofpoint-GUID: cB-bcTrsYE3cISoBtd9pwuzu_v78bHu_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-23_06,2024-02-23_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 suspectscore=0 adultscore=0 mlxlogscore=993 lowpriorityscore=0
 malwarescore=0 spamscore=0 mlxscore=0 phishscore=0 bulkscore=0
 priorityscore=1501 clxscore=1015 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2311290000 definitions=main-2402230152

Add the parameters for the NIST P521 curve and define a new curve ID
for it. Make the curve available in ecc_get_curve.

Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
---
 crypto/ecc.c            |  2 ++
 crypto/ecc_curve_defs.h | 45 +++++++++++++++++++++++++++++++++++++++++
 include/crypto/ecdh.h   |  1 +
 3 files changed, 48 insertions(+)

diff --git a/crypto/ecc.c b/crypto/ecc.c
index 89ad45cf2404..164898ad1961 100644
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
index 9719934c9428..09a221657c31 100644
--- a/crypto/ecc_curve_defs.h
+++ b/crypto/ecc_curve_defs.h
@@ -86,6 +86,51 @@ static struct ecc_curve nist_p384 = {
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


