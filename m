Return-Path: <linux-kernel+bounces-87828-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BD61386D998
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 03:22:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3E0C4281166
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 02:22:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D28313D0B8;
	Fri,  1 Mar 2024 02:20:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="o14O78aB"
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B98C13A8D0;
	Fri,  1 Mar 2024 02:20:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709259623; cv=none; b=PYacv4adNJ2mHyJ0oMdxF2eLu7EE/HxhaJjYtHD6xHTirj4wgQG8Iigv570DWFawtaHwBgEeDDL9VHfufTzV+Xdm3zmIiTm1PY25ZNnRKmD+awDbaJWI73hJzjN9TeDH7qixlzOl4M4xeWlPkTPIZfge3Q1lO9btm5DQFBWmCVc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709259623; c=relaxed/simple;
	bh=gdZL027JjgWBp4yAX1JueovH7hZQ/1sj/DZJp44K3S4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=URe3UcSx8aWJw0tnVEuVcNicd2Nr7WomCFi+m7+DLbaStDHPqouyWZR5xr9L0KdZSMwlbAcGSAh7PQnL7cYL1XWSZNSvNZ+00Q82BfsUkfDYx8fZIlbaa9wVoaqoC0kcRK3Kjj+wafllPtkGOod77OQ8nCN4ANfHsBIGJNkSICo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=o14O78aB; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 4212HpRh028427;
	Fri, 1 Mar 2024 02:20:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=6GJQ+POFkVJMen9g30DeKpSnoS+4aRChTobEoFY4Y9Y=;
 b=o14O78aBpPcDd27QXExR04lp3LSIEZ5iKDhGEBOMJL3b8oU2RsKQMCYgwpe9cnChRBlm
 veb1ipzOMqMfjLdQeQ7J0ttuiGV8ke1YJ90UoC5JIWyE1sy0jIVSKkgiDCai7BW9AQkT
 uE79rD5xZcmAw3Lo0EgyDAIHt8TeUF0kI94lsUzlOTii3lY5f2ALEH+5HnnWQTxfihvI
 7dihUvHkZiRzK/rFzJWodKyTR7m3o4Qp0RFPCit6MKvk0+5k8xTbBclWsAl+Zdl6DxJ6
 WcgZIPEv2GOEQVmRUUFKnmfKzoGV6qmadlZlUELrjsC0ydHSTBl34L9B5qUxSxWAY+vG 9A== 
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3wk63t81j4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 01 Mar 2024 02:20:15 +0000
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 41TNMBgw024122;
	Fri, 1 Mar 2024 02:20:14 GMT
Received: from smtprelay07.dal12v.mail.ibm.com ([172.16.1.9])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 3wfw0ks93e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 01 Mar 2024 02:20:14 +0000
Received: from smtpav05.dal12v.mail.ibm.com (smtpav05.dal12v.mail.ibm.com [10.241.53.104])
	by smtprelay07.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 4212KCTc50856668
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 1 Mar 2024 02:20:14 GMT
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 691705805D;
	Fri,  1 Mar 2024 02:20:12 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E78DB5806A;
	Fri,  1 Mar 2024 02:20:11 +0000 (GMT)
Received: from sbct-3.pok.ibm.com (unknown [9.47.158.153])
	by smtpav05.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Fri,  1 Mar 2024 02:20:11 +0000 (GMT)
From: Stefan Berger <stefanb@linux.ibm.com>
To: keyrings@vger.kernel.org, linux-crypto@vger.kernel.org,
        herbert@gondor.apana.org.au, davem@davemloft.net
Cc: linux-kernel@vger.kernel.org, saulo.alessandre@tse.jus.br, lukas@wunner.de,
        Stefan Berger <stefanb@linux.ibm.com>
Subject: [PATCH v4 05/12] crypto: ecc - Add nbits field to ecc_curve structure
Date: Thu, 29 Feb 2024 21:20:00 -0500
Message-ID: <20240301022007.344948-6-stefanb@linux.ibm.com>
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
X-Proofpoint-GUID: lbfE8AGIA8HsfRveQwKVX843oZn5nxiE
X-Proofpoint-ORIG-GUID: lbfE8AGIA8HsfRveQwKVX843oZn5nxiE
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-29_08,2024-02-29_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 suspectscore=0
 adultscore=0 lowpriorityscore=0 mlxscore=0 spamscore=0 clxscore=1015
 impostorscore=0 priorityscore=1501 bulkscore=0 mlxlogscore=999
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2403010018

Add the number of bits a curve has to the ecc_curve definition and set it
on all cruve definitions.

Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
---
 crypto/ecc_curve_defs.h    | 4 ++++
 crypto/ecrdsa_defs.h       | 5 +++++
 include/crypto/ecc_curve.h | 3 +++
 3 files changed, 12 insertions(+)

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
index 70964781eb68..337a44956926 100644
--- a/include/crypto/ecc_curve.h
+++ b/include/crypto/ecc_curve.h
@@ -23,6 +23,8 @@ struct ecc_point {
  * struct ecc_curve - definition of elliptic curve
  *
  * @name:	Short name of the curve.
+ * @nbits:      Curves that do not use all bits in their ndigits must specify
+ *              their number of bits here, otherwise can leave at 0.
  * @g:		Generator point of the curve.
  * @p:		Prime number, if Barrett's reduction is used for this curve
  *		pre-calculated value 'mu' is appended to the @p after ndigits.
@@ -34,6 +36,7 @@ struct ecc_point {
  */
 struct ecc_curve {
 	char *name;
+	unsigned int nbits;
 	struct ecc_point g;
 	u64 *p;
 	u64 *n;
-- 
2.43.0


