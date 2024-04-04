Return-Path: <linux-kernel+bounces-131601-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BDBBA8989EC
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 16:21:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 34AC71F301EB
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 14:21:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 860521304B7;
	Thu,  4 Apr 2024 14:19:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="jyyxvUG9"
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB24D12BF11;
	Thu,  4 Apr 2024 14:19:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712240395; cv=none; b=kTOiFYGGEyYZSxNCMbOPVj7K9+ukcAqJWZra2ud4k98cBTM59+LrPHotoIWUm1hqM64O48NtZfaXp8JYkF5Nv4Bn4X9op3zASgp6IWug8LS5abIPZZscLoKkuxww4RrMRcZsVtXIZResneskKX/8sHQKIIGyu0+kpmR619uqTdQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712240395; c=relaxed/simple;
	bh=apHbbRlq56z3MyubKKXRpCg232E9xxWWZMd2mdFo5gM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rasvhcqEFrq+uSzUv3/T1/lIQIdGB2e4k8mEoQxjVh6jYgU9FSA/jT0bK8UScXnY0oO0FbIokFmlfP+NgV+Axq2MscJxOClCZaiEMKxNo140Oem4qbjhaFpxqKaYA/CY/imMVdLaCynf/7jvdto7qL6Hl2GqGH2kc9PHqOld0t4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=jyyxvUG9; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 434EHQ50027934;
	Thu, 4 Apr 2024 14:19:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=pKdvhKA3l3vS8gdx5SxqUMSPFlneWjJ5VDAwNvwJhp8=;
 b=jyyxvUG94JDTMkNRE87KvJbzBu7o2ukm7XVNEcHdiA7hiXKus11B2fXKbpNVKqLTttDv
 vaSpehLFNVcTf+p4UJndf6CjhV9APWMP1G76a4q066GxAOLwMektTFdWDAM6wj0QDqjR
 IHWKPCtj8uRIpddfbUz8tGd4IskdoI+1OCfcdA9p8pM0jzEQGq9A7i8G2o2dM36iwzLr
 obDapgQm33HD+d0/56K3vKNheXYEMOWkjKgHRbk1XTXE8h7Wy6vJicYZtFo/Las0nUFP
 ZXTgQ1AK1LJL/s1XsKQNrUupGvo+RJzQzwnjoyrnQY6/lGuNR4YtbGbSN8MgMktV8sSh 2g== 
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3x9wd6r2g0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 04 Apr 2024 14:19:39 +0000
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 434DVb6j008662;
	Thu, 4 Apr 2024 14:19:39 GMT
Received: from smtprelay04.dal12v.mail.ibm.com ([172.16.1.6])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3x9epw4k5f-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 04 Apr 2024 14:19:39 +0000
Received: from smtpav06.wdc07v.mail.ibm.com (smtpav06.wdc07v.mail.ibm.com [10.39.53.233])
	by smtprelay04.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 434EJa4s54526220
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 4 Apr 2024 14:19:38 GMT
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id EC04358062;
	Thu,  4 Apr 2024 14:19:35 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 19A515806B;
	Thu,  4 Apr 2024 14:19:35 +0000 (GMT)
Received: from sbct-3.pok.ibm.com (unknown [9.47.158.153])
	by smtpav06.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Thu,  4 Apr 2024 14:19:34 +0000 (GMT)
From: Stefan Berger <stefanb@linux.ibm.com>
To: keyrings@vger.kernel.org, linux-crypto@vger.kernel.org,
        herbert@gondor.apana.org.au, davem@davemloft.net
Cc: linux-kernel@vger.kernel.org, saulo.alessandre@tse.jus.br, lukas@wunner.de,
        bbhushan2@marvell.com, jarkko@kernel.org,
        Stefan Berger <stefanb@linux.ibm.com>
Subject: [PATCH v8 05/13] crypto: ecc - Add nbits field to ecc_curve structure
Date: Thu,  4 Apr 2024 10:18:48 -0400
Message-ID: <20240404141856.2399142-6-stefanb@linux.ibm.com>
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
X-Proofpoint-ORIG-GUID: j3TdihF9Iy_j4C9S4j5I1eDgjrBGMBkR
X-Proofpoint-GUID: j3TdihF9Iy_j4C9S4j5I1eDgjrBGMBkR
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-04_10,2024-04-04_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 spamscore=0
 priorityscore=1501 lowpriorityscore=0 phishscore=0 impostorscore=0
 mlxlogscore=999 bulkscore=0 mlxscore=0 adultscore=0 suspectscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2404010000 definitions=main-2404040098

Add the number of bits a curve has to the ecc_curve definition to be able
to derive the number of bytes a curve requires for its coordinates from it.
It also allows one to identify a curve by its particular size. Set the
number of bits on all curve definitions.

Tested-by: Lukas Wunner <lukas@wunner.de>
Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>
Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
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
index 70964781eb68..7d90c5e82266 100644
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
+	u32 nbits;
 	struct ecc_point g;
 	u64 *p;
 	u64 *n;
-- 
2.43.0


