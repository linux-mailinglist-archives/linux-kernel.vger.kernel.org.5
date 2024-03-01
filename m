Return-Path: <linux-kernel+bounces-87826-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ADBEE86D98E
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 03:21:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 69523281757
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 02:21:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 150883B78B;
	Fri,  1 Mar 2024 02:20:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="LHOk6LWR"
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F2E73A8CA;
	Fri,  1 Mar 2024 02:20:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709259623; cv=none; b=tG7SdHhtgK662qkuS+9Dgu/rxWhd8tXH8tQTc8RL9hWIl5YQ9it59mJFguQ+9PjhDXCoqOuLnEI3bEeiZGNJpdA/eYBIl7HCFmMRHr8YpWG6TcPFBwF5L0rnLdfvCSBFehCjj+70f5t/D2etd6iRZpAYJotjHNdeQDy+tN6Fb3w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709259623; c=relaxed/simple;
	bh=OQYsXMHfGUAo+fgcBXpX5tzkjfHQI2L/enzJKf9t+JM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TFlwIyC8+IHnLmSHKR5QfhzB5u6KHFwnZ0Ot/Cq3Eqj7ANqIzjGXSyMVHQFf7obFyWHywQf684WlqqzuvGPxIEYinuHBYsERJC0ULSAXx3iVVKmDrVZgg9ZgExg06S9yfNmKB+aZc2J2OwyAzLLnfMAeqD3RcXhL6q2feaEPIb8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=LHOk6LWR; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353724.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 4212HcDd017810;
	Fri, 1 Mar 2024 02:20:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=27VVBnEU1E8thdxFnYmmqecPL6rgHzlExygOikrUXI0=;
 b=LHOk6LWROyWLTDmb+tyQbe7VOlG0iAAm1o/go2ZyKj/yZCH/rPoVictK12zbps2sLprz
 +4ZTVU1tZa4O9U5GMHjLQYW9VrbZCF4lGbdjFLVLzUUs5zv4HwQJ60aIZD8JcBdXH4or
 GSQQsc+Osjsqvf4ueo9Bwz5PXEhsVXtsa6IQmxiz4MA6ir1BelIG/r5MEDKqBjDgaKtZ
 xBjwZtoGah/6zCj45tjDj9NgFdBekgojdLTYmD4RVGRrTcCSYyXlH1SXpS1R5p7skGFQ
 IhnouWlTG2kjBeXarXNZUhYlrIm+6UZEWH5QwSGB65Lse6JmWkVFhuxtWCwVHULGyLs5 ng== 
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3wk63rg1wr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 01 Mar 2024 02:20:17 +0000
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 41TNofni012328;
	Fri, 1 Mar 2024 02:20:16 GMT
Received: from smtprelay03.dal12v.mail.ibm.com ([172.16.1.5])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 3wfwg2s516-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 01 Mar 2024 02:20:16 +0000
Received: from smtpav05.dal12v.mail.ibm.com (smtpav05.dal12v.mail.ibm.com [10.241.53.104])
	by smtprelay03.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 4212KEk440829434
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 1 Mar 2024 02:20:16 GMT
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3BF015806A;
	Fri,  1 Mar 2024 02:20:14 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B15E158068;
	Fri,  1 Mar 2024 02:20:13 +0000 (GMT)
Received: from sbct-3.pok.ibm.com (unknown [9.47.158.153])
	by smtpav05.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Fri,  1 Mar 2024 02:20:13 +0000 (GMT)
From: Stefan Berger <stefanb@linux.ibm.com>
To: keyrings@vger.kernel.org, linux-crypto@vger.kernel.org,
        herbert@gondor.apana.org.au, davem@davemloft.net
Cc: linux-kernel@vger.kernel.org, saulo.alessandre@tse.jus.br, lukas@wunner.de,
        Stefan Berger <stefanb@linux.ibm.com>
Subject: [PATCH v4 08/12] crypto: ecdsa - Replace ndigits with nbits where precision is needed
Date: Thu, 29 Feb 2024 21:20:03 -0500
Message-ID: <20240301022007.344948-9-stefanb@linux.ibm.com>
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
X-Proofpoint-GUID: fLuyKHa3H_VNKPiPdDDJtbv0Jtbqd8i4
X-Proofpoint-ORIG-GUID: fLuyKHa3H_VNKPiPdDDJtbv0Jtbqd8i4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-29_08,2024-02-29_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0
 priorityscore=1501 spamscore=0 clxscore=1015 malwarescore=0
 impostorscore=0 mlxscore=0 suspectscore=0 lowpriorityscore=0
 mlxlogscore=999 phishscore=0 adultscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2403010018

Replace the usage of ndigits with nbits where more precise space
calculations are needed, such as in ecdsa_max_size where the length of a
coordinate is determined.

Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
---
 crypto/ecdsa.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/crypto/ecdsa.c b/crypto/ecdsa.c
index 1814f009f971..4daefb40c37a 100644
--- a/crypto/ecdsa.c
+++ b/crypto/ecdsa.c
@@ -266,7 +266,7 @@ static unsigned int ecdsa_max_size(struct crypto_akcipher *tfm)
 {
 	struct ecc_ctx *ctx = akcipher_tfm_ctx(tfm);
 
-	return ctx->pub_key.ndigits << ECC_DIGITS_TO_BYTES_SHIFT;
+	return DIV_ROUND_UP(ctx->curve->nbits, 8);
 }
 
 static int ecdsa_nist_p384_init_tfm(struct crypto_akcipher *tfm)
-- 
2.43.0


