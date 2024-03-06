Return-Path: <linux-kernel+bounces-94681-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A3AB87430F
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 23:59:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A6EC4B20B5A
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 22:59:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B5CE1C2B2;
	Wed,  6 Mar 2024 22:59:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="VKYrAG//"
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0034A1C684;
	Wed,  6 Mar 2024 22:59:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709765945; cv=none; b=db13v0Nxbj+ud9YZVU8D5zVFesI1GwVyxrfB4veChRlDmd0xjL1jkW7y+DzZOVGiwdmvycHoJ6ZkoBIQL87Bwdwc78EenU6nQDXpi5U8K9oypYHcDDK7m/llXDM9VheIbyWFbhtTuoxAb3bDX5OSYPkiiWr2SWK5Hsm3rF4imPw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709765945; c=relaxed/simple;
	bh=oNL4woPH2GgB/0aAHfXk2961xRNs+WQXgdtPX1mrVSo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=utRuA6WZdaa1bOjybWdTTvsFRhaHcSIj+hTEz1LIPsyJicegm1WjnL/VsAHSljmLNcjBVUJShK+jPJPjRTon8eaK09lRDGsCNKX8IzkhzWSbpw9t34/X1I2MDlrq9eXfezOKaW7Q1OrfjN79+XWobdDzgJS9iV13rZg4pocGylI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=VKYrAG//; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353728.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 426MgDw8018256;
	Wed, 6 Mar 2024 22:58:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=fZBVeTFFrn96qz5boWPG4MRz0Oeii50WF0vdP2piFhs=;
 b=VKYrAG//fcN7izxPTJi1ObzKnhA0D3uIh3cJc0cw7fstngK+WA1siR00uN+WEowtjhjC
 /UmTVEineOuKx36dqyUSXoUBRSm/n4aweD1dhIKJjjYemdp6tHTVzU64DYGjAEDH8h2Y
 pXCjGcA4YxxfgJNzF36MPrq1wX9MMhYVDXS9222fY1fEA8u5X6q74BN1+vHn66O3uZ5L
 lIbO7TPnyVEsMLwg9rHvu+fxav2MKhp0YzImGMMVr9LPlpurDyVb1E3ZJckKQ6SW/Zwe
 1t3QugfDSAikwQa6YcmYcteZVxunGHfqr86D3zjh35KBpzGVep/owl8q7S/Iu5ephDnK Pg== 
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3wq1gugb0f-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 06 Mar 2024 22:58:57 +0000
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 426MIwG9026216;
	Wed, 6 Mar 2024 22:23:10 GMT
Received: from smtprelay02.dal12v.mail.ibm.com ([172.16.1.4])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3wmfep1nq3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 06 Mar 2024 22:23:10 +0000
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com [10.241.53.100])
	by smtprelay02.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 426MN7Mo13631748
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 6 Mar 2024 22:23:09 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id DFCA358061;
	Wed,  6 Mar 2024 22:23:05 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6208858068;
	Wed,  6 Mar 2024 22:23:05 +0000 (GMT)
Received: from sbct-3.pok.ibm.com (unknown [9.47.158.153])
	by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Wed,  6 Mar 2024 22:23:05 +0000 (GMT)
From: Stefan Berger <stefanb@linux.ibm.com>
To: keyrings@vger.kernel.org, linux-crypto@vger.kernel.org,
        herbert@gondor.apana.org.au, davem@davemloft.net
Cc: linux-kernel@vger.kernel.org, saulo.alessandre@tse.jus.br, lukas@wunner.de,
        Stefan Berger <stefanb@linux.ibm.com>
Subject: [PATCH v5 06/12] crypto: ecc - Add special case for NIST P521 in ecc_point_mult
Date: Wed,  6 Mar 2024 17:22:51 -0500
Message-ID: <20240306222257.979304-7-stefanb@linux.ibm.com>
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
X-Proofpoint-GUID: 5Wi3TuOfounAn6vNDh3bvOoo3h3hx1YA
X-Proofpoint-ORIG-GUID: 5Wi3TuOfounAn6vNDh3bvOoo3h3hx1YA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-06_12,2024-03-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 phishscore=0 suspectscore=0 spamscore=0 adultscore=0 mlxscore=0
 mlxlogscore=999 impostorscore=0 clxscore=1015 malwarescore=0
 lowpriorityscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2311290000 definitions=main-2403060185

In ecc_point_mult use the number of bits of the NIST P521 curve + 2. The
change is required specifically for NIST P521 to pass mathematical tests
on the public key.

Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
Tested-by: Lukas Wunner <lukas@wunner.de>
---
 crypto/ecc.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/crypto/ecc.c b/crypto/ecc.c
index 373660e7b19d..55fd390d3386 100644
--- a/crypto/ecc.c
+++ b/crypto/ecc.c
@@ -1326,7 +1326,10 @@ static void ecc_point_mult(struct ecc_point *result,
 	carry = vli_add(sk[0], scalar, curve->n, ndigits);
 	vli_add(sk[1], sk[0], curve->n, ndigits);
 	scalar = sk[!carry];
-	num_bits = sizeof(u64) * ndigits * 8 + 1;
+	if (curve->nbits == 521)
+		num_bits = curve->nbits + 2;
+	else
+		num_bits = sizeof(u64) * ndigits * 8 + 1;
 
 	vli_set(rx[1], point->x, ndigits);
 	vli_set(ry[1], point->y, ndigits);
-- 
2.43.0


