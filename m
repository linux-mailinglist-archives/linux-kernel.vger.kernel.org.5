Return-Path: <linux-kernel+bounces-94677-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5941A8742FA
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 23:48:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DA69B1F22E8E
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 22:48:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65C841C6BC;
	Wed,  6 Mar 2024 22:48:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Aps50GEY"
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC6B91BDD8;
	Wed,  6 Mar 2024 22:48:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709765299; cv=none; b=kbuWAsFefr0cqyU+gdUedWhJ4VJwDWgnxwCsjWE/A4Z36KKcbbpiDfRD2HmJrJBK8Q4W7Fho2ctYIvTCEHeC9iZaW03yKDKvKtk/oC9QtJGiFLOhl5ZShvnszLQf7lApcjW0b+RSli6IKi8IiyBBX/3U2UJsvUd0CdyngwtcDBw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709765299; c=relaxed/simple;
	bh=sAJIpa2JkBgtbU2YwuyN7qt/o7mDnLM4vY7NwiIr/pU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lU7P4nz004UvZR7TsOUN2j0cLU0vZWQlF8HIdFXTbVTPXyt2WdpInw/M1lzHDK2PA5NvRuupTeNoIjZUhPw6u/TkicnniwwkQ/tP86V+QX+wCWiNy1uaUXzL7k09iyFWPGRii8mqKdKMZDgEZrtrU+MzGvVW3rfIIQxFyG81xnE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Aps50GEY; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353726.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 426M7F4L000882;
	Wed, 6 Mar 2024 22:48:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=0PwkpoFdOQvWmaDlSuzZQaznPG32JEEmfw6gHCWHcio=;
 b=Aps50GEYx451smTrhreGyJPy4Pg00IFyfSO4inchd6tXHGsKwDCSXXOB2SUWkgNh9rh4
 /08PLy5lTShauH257wOQYPT06BWJ72dyoAauQ4j88/HagyyUbYByye6RhktNPlZlqu6Z
 ufPqOVNTBTSgPxPXHmNwtMys4hxJCQQqBjnH1bPiqhL8h+lS3KA6GdOgurTUyWDEj4pK
 aeWysSZaOO49YanDY62Ci1DLfxujKw0ppWnvKQkwplBuS5E/4B1h0DsGubUKZfY36W0r
 3HqqMBIQbh+38tsnWCayY9zCaZSmC2k7ygNCMnS0KsbwcJhU6Z3z8riPbGzxiE8oXSmy xQ== 
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3wq10h123e-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 06 Mar 2024 22:48:11 +0000
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 426MIwG7026216;
	Wed, 6 Mar 2024 22:23:07 GMT
Received: from smtprelay04.dal12v.mail.ibm.com ([172.16.1.6])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3wmfep1npq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 06 Mar 2024 22:23:07 +0000
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com [10.241.53.100])
	by smtprelay04.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 426MN4i334603342
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 6 Mar 2024 22:23:06 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B134258067;
	Wed,  6 Mar 2024 22:23:04 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3D79D58061;
	Wed,  6 Mar 2024 22:23:04 +0000 (GMT)
Received: from sbct-3.pok.ibm.com (unknown [9.47.158.153])
	by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Wed,  6 Mar 2024 22:23:04 +0000 (GMT)
From: Stefan Berger <stefanb@linux.ibm.com>
To: keyrings@vger.kernel.org, linux-crypto@vger.kernel.org,
        herbert@gondor.apana.org.au, davem@davemloft.net
Cc: linux-kernel@vger.kernel.org, saulo.alessandre@tse.jus.br, lukas@wunner.de,
        Stefan Berger <stefanb@linux.ibm.com>
Subject: [PATCH v5 04/12] crypto: ecc - Add nbits field to ecc_curve structure
Date: Wed,  6 Mar 2024 17:22:49 -0500
Message-ID: <20240306222257.979304-5-stefanb@linux.ibm.com>
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
X-Proofpoint-GUID: pumPNUnIONf9pNDZtWQQIPUqtpn6xxnW
X-Proofpoint-ORIG-GUID: pumPNUnIONf9pNDZtWQQIPUqtpn6xxnW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-06_12,2024-03-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 suspectscore=0 phishscore=0 bulkscore=0 priorityscore=1501 adultscore=0
 mlxlogscore=999 lowpriorityscore=0 malwarescore=0 mlxscore=0 clxscore=1015
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2403060183

Add the number of bits a curve has to the ecc_curve definition and set it
on all curve definitions.

Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
Tested-by: Lukas Wunner <lukas@wunner.de>
---
 crypto/ecc_curve_defs.h    | 4 ++++
 crypto/ecrdsa_defs.h       | 5 +++++
 include/crypto/ecc_curve.h | 2 ++
 3 files changed, 11 insertions(+)

diff --git a/crypto/ecc_curve_defs.h b/crypto/ecc_curve_defs.h
index 9719934c9428..ab1ef3d94be5 100644
--- a/crypto/ecc_curve_defs.h
+++ b/crypto/ecc_curve_defs.h
@@ -17,6 +17,7 @@ static u64 nist_p192_b[] = { 0xFEB8DEECC146B9B1ull, 0x0FA7E9AB72243049ull,
 				0x64210519E59C80E7ull };
 static struct ecc_curve nist_p192 = {
 	.name = "nist_192",
+	.nbits = 192,
 	.g = {
 		.x = nist_p192_g_x,
 		.y = nist_p192_g_y,
@@ -43,6 +44,7 @@ static u64 nist_p256_b[] = { 0x3BCE3C3E27D2604Bull, 0x651D06B0CC53B0F6ull,
 				0xB3EBBD55769886BCull, 0x5AC635D8AA3A93E7ull };
 static struct ecc_curve nist_p256 = {
 	.name = "nist_256",
+	.nbits = 256,
 	.g = {
 		.x = nist_p256_g_x,
 		.y = nist_p256_g_y,
@@ -75,6 +77,7 @@ static u64 nist_p384_b[] = { 0x2a85c8edd3ec2aefull, 0xc656398d8a2ed19dull,
 				0x988e056be3f82d19ull, 0xb3312fa7e23ee7e4ull };
 static struct ecc_curve nist_p384 = {
 	.name = "nist_384",
+	.nbits = 384,
 	.g = {
 		.x = nist_p384_g_x,
 		.y = nist_p384_g_y,
@@ -95,6 +98,7 @@ static u64 curve25519_a[] = { 0x000000000001DB41, 0x0000000000000000,
 				0x0000000000000000, 0x0000000000000000 };
 static const struct ecc_curve ecc_25519 = {
 	.name = "curve25519",
+	.nbits = 255,
 	.g = {
 		.x = curve25519_g_x,
 		.ndigits = 4,
diff --git a/crypto/ecrdsa_defs.h b/crypto/ecrdsa_defs.h
index 0056335b9d03..1c2c2449e331 100644
--- a/crypto/ecrdsa_defs.h
+++ b/crypto/ecrdsa_defs.h
@@ -47,6 +47,7 @@ static u64 cp256a_b[] = {
 
 static struct ecc_curve gost_cp256a = {
 	.name = "cp256a",
+	.nbits = 256,
 	.g = {
 		.x = cp256a_g_x,
 		.y = cp256a_g_y,
@@ -80,6 +81,7 @@ static u64 cp256b_b[] = {
 
 static struct ecc_curve gost_cp256b = {
 	.name = "cp256b",
+	.nbits = 256,
 	.g = {
 		.x = cp256b_g_x,
 		.y = cp256b_g_y,
@@ -117,6 +119,7 @@ static u64 cp256c_b[] = {
 
 static struct ecc_curve gost_cp256c = {
 	.name = "cp256c",
+	.nbits = 256,
 	.g = {
 		.x = cp256c_g_x,
 		.y = cp256c_g_y,
@@ -166,6 +169,7 @@ static u64 tc512a_b[] = {
 
 static struct ecc_curve gost_tc512a = {
 	.name = "tc512a",
+	.nbits = 512,
 	.g = {
 		.x = tc512a_g_x,
 		.y = tc512a_g_y,
@@ -211,6 +215,7 @@ static u64 tc512b_b[] = {
 
 static struct ecc_curve gost_tc512b = {
 	.name = "tc512b",
+	.nbits = 512,
 	.g = {
 		.x = tc512b_g_x,
 		.y = tc512b_g_y,
diff --git a/include/crypto/ecc_curve.h b/include/crypto/ecc_curve.h
index 70964781eb68..63d5754e7614 100644
--- a/include/crypto/ecc_curve.h
+++ b/include/crypto/ecc_curve.h
@@ -23,6 +23,7 @@ struct ecc_point {
  * struct ecc_curve - definition of elliptic curve
  *
  * @name:	Short name of the curve.
+ * @nbits:	The number of bits of a curve.
  * @g:		Generator point of the curve.
  * @p:		Prime number, if Barrett's reduction is used for this curve
  *		pre-calculated value 'mu' is appended to the @p after ndigits.
@@ -34,6 +35,7 @@ struct ecc_point {
  */
 struct ecc_curve {
 	char *name;
+	unsigned int nbits;
 	struct ecc_point g;
 	u64 *p;
 	u64 *n;
-- 
2.43.0


