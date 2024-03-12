Return-Path: <linux-kernel+bounces-100665-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 44560879B82
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 19:37:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ED3332850E0
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 18:37:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F24CB1420DE;
	Tue, 12 Mar 2024 18:37:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="ovKanYjF"
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CF9314199F;
	Tue, 12 Mar 2024 18:37:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710268661; cv=none; b=Ua0GnwgEZgcNMqU4t7rXOA/U7cqR1XMYmIdlYU9wN0leWP6q+vh47lhWyXuSDpSlGvNpLFItsHL4rIWTVAguDGqaJpg5p23pvNsHTLFVPi51AMIYs8GD7trsuREEN6JIFx8ulNsrR53S+fk352Yg1SX1muUO/GmpsG8FIWwT7+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710268661; c=relaxed/simple;
	bh=Q3nhqf0Z7dHnc4D2tVpVpCNTZs8ckLp48PrwazH2UYs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jbg2NIHRNRFeFwhyvAO96O+2kMeE1m/QdTvVSCuYk2oXiA7akwdY5AwA63yyY9ypx8hKF7W1++CtA85ODB6U8gcRNHWC6NQySWKnWddI6kMWtMVBuSDHGddSiVwsqapVqKSGZA+JFcIZCQfPjnn9IeomVYiMVu9tlHFXZYlrUSw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.vnet.ibm.com; spf=none smtp.mailfrom=linux.vnet.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=ovKanYjF; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.vnet.ibm.com
Received: from pps.filterd (m0353722.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 42CI2hiS030884;
	Tue, 12 Mar 2024 18:36:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=6gXNF8QE+IKS1nhZx6FBXS6s1Z5vP2fuMlgvOR6SKfQ=;
 b=ovKanYjFqVL9ItZi7j6DE1kZWAcP2h9G3/CXcb80p1EOPJcNlulCbA782L+rePAANT5Y
 I7tqWtVnC6484TkuM9ZEojlJ9Xj9+uv2vByUoTEUHBEnxZMMe9oCRKi1YmQEX6ma+Sxl
 hwAP7ruhrFnthDciSFRMLNf9NbYIjhq+ZsOBmbK0cAaw2EfY9n7eUmnaLceRGFtLCFSa
 AaiZNDQHp7HT1cxePmrgkhuyHJWm1pvj5U0ZDxldGISYiKmeB8dN73Z9+iwYBgKbgxS4
 X6NfwS9kYzERsediOuGp4HClGs0WSEVGsIUef9SStyj/jQzrJ99F3gPLHNylaQEDT5Ln +w== 
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3wtuywrh3h-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 12 Mar 2024 18:36:25 +0000
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 42CHhIvj015477;
	Tue, 12 Mar 2024 18:36:24 GMT
Received: from smtprelay06.dal12v.mail.ibm.com ([172.16.1.8])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3ws2fys1c3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 12 Mar 2024 18:36:24 +0000
Received: from smtpav06.wdc07v.mail.ibm.com (smtpav06.wdc07v.mail.ibm.com [10.39.53.233])
	by smtprelay06.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 42CIaLU231260944
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 12 Mar 2024 18:36:24 GMT
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C03CC58056;
	Tue, 12 Mar 2024 18:36:21 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id CA0315804E;
	Tue, 12 Mar 2024 18:36:20 +0000 (GMT)
Received: from sbct-3.pok.ibm.com (unknown [9.47.158.153])
	by smtpav06.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 12 Mar 2024 18:36:20 +0000 (GMT)
From: Stefan Berger <stefanb@linux.vnet.ibm.com>
To: keyrings@vger.kernel.org, linux-crypto@vger.kernel.org,
        herbert@gondor.apana.org.au, davem@davemloft.net
Cc: linux-kernel@vger.kernel.org, saulo.alessandre@tse.jus.br, lukas@wunner.de,
        bbhushan2@marvell.com, jarkko@kernel.org,
        Stefan Berger <stefanb@linux.ibm.com>
Subject: [PATCH v6 01/13] crypto: ecc - Use ECC_CURVE_NIST_P192/256/384_DIGITS where possible
Date: Tue, 12 Mar 2024 14:36:06 -0400
Message-ID: <20240312183618.1211745-2-stefanb@linux.vnet.ibm.com>
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
X-Proofpoint-ORIG-GUID: 4zzvrMveJsHul92aunllvAFBsJiNmjZS
X-Proofpoint-GUID: 4zzvrMveJsHul92aunllvAFBsJiNmjZS
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-12_11,2024-03-12_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 adultscore=0 malwarescore=0 impostorscore=0 lowpriorityscore=0
 phishscore=0 mlxscore=0 spamscore=0 suspectscore=0 mlxlogscore=999
 bulkscore=0 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2403120139

From: Stefan Berger <stefanb@linux.ibm.com>

Replace hard-coded numbers with ECC_CURVE_NIST_P192/256/384_DIGITS where
possible.

Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
---
 crypto/ecc.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/crypto/ecc.c b/crypto/ecc.c
index f53fb4d6af99..415a2f4e7291 100644
--- a/crypto/ecc.c
+++ b/crypto/ecc.c
@@ -689,7 +689,7 @@ static void vli_mmod_barrett(u64 *result, u64 *product, const u64 *mod,
 static void vli_mmod_fast_192(u64 *result, const u64 *product,
 			      const u64 *curve_prime, u64 *tmp)
 {
-	const unsigned int ndigits = 3;
+	const unsigned int ndigits = ECC_CURVE_NIST_P192_DIGITS;
 	int carry;
 
 	vli_set(result, product, ndigits);
@@ -717,7 +717,7 @@ static void vli_mmod_fast_256(u64 *result, const u64 *product,
 			      const u64 *curve_prime, u64 *tmp)
 {
 	int carry;
-	const unsigned int ndigits = 4;
+	const unsigned int ndigits = ECC_CURVE_NIST_P256_DIGITS;
 
 	/* t */
 	vli_set(result, product, ndigits);
@@ -800,7 +800,7 @@ static void vli_mmod_fast_384(u64 *result, const u64 *product,
 				const u64 *curve_prime, u64 *tmp)
 {
 	int carry;
-	const unsigned int ndigits = 6;
+	const unsigned int ndigits = ECC_CURVE_NIST_P384_DIGITS;
 
 	/* t */
 	vli_set(result, product, ndigits);
@@ -932,13 +932,13 @@ static bool vli_mmod_fast(u64 *result, u64 *product,
 	}
 
 	switch (ndigits) {
-	case 3:
+	case ECC_CURVE_NIST_P192_DIGITS:
 		vli_mmod_fast_192(result, product, curve_prime, tmp);
 		break;
-	case 4:
+	case ECC_CURVE_NIST_P256_DIGITS:
 		vli_mmod_fast_256(result, product, curve_prime, tmp);
 		break;
-	case 6:
+	case ECC_CURVE_NIST_P384_DIGITS:
 		vli_mmod_fast_384(result, product, curve_prime, tmp);
 		break;
 	default:
-- 
2.43.0


