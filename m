Return-Path: <linux-kernel+bounces-131599-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 88C858989E8
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 16:21:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1D4A8B284B1
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 14:21:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7C0D12F5AA;
	Thu,  4 Apr 2024 14:19:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="O/YGg5YK"
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CD5412AAD2;
	Thu,  4 Apr 2024 14:19:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712240394; cv=none; b=Njnml9bcVmwa/j5J4PqVPuvb5QtKNcxatggzM7wOCLwCWUi7ewVOvKlUVw+bx8SzbZOjDdQO54diRPmblRNeJcElipgHC3WnSIhXzrm3+oWQcoDtLT0RvaV1QF5FNPaps2FzzrGwDlX6I1uAsdIPlJx+3M6ui4mgVzfHq4g4+JE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712240394; c=relaxed/simple;
	bh=nK7cCbPq8DA6iAPFzC0F28VLsLquDliD7w2jqmVOA1U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kfA0YGR7RyeVNPA7aLX1jcJlxLxgQFdjEJrDORhlyGb1d7uFF1KZd9k58EIUrVdlU5YqBoOqjv1hTeQrPArkYq5606EXFk02pZ41iRNBsQ0ylclu0UL5rqDkhFIgE23V1XfdbHHI4aEmhQcpBvO3lJYt59TnUwFEDHHW7oSTrg0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=O/YGg5YK; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353724.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 434E8g1o017068;
	Thu, 4 Apr 2024 14:19:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=0abSue5z1MayrDczs4yHfSAdPl7hwHIilOzT+f+ye7A=;
 b=O/YGg5YKE54j32NrhWua8cGJiQw2yPN42iYK9svBf4HlQJPXefbi+fC7pwLYuqnH6mYp
 5PETt+iuMc1X7ZIQmNwzzJ/oJdizukPO8SkdyrbKEv/xf9uRq/dNHfz8KpyyYhpOgK0M
 7Jn7dq5CZ7IHT56WR43X2q7cDc0mMT4OSTxYqUfyKEmDcddz76OWFpCwYabEvKL1xCr0
 HQ2ixL6wnk580wNk8msG1lxUeFzPdcXMwEQP/Ddvk1hGfokSffvKWfLXEOS4Ws65PBE+
 MpK6nYZB3Z0ynopqWPw3ROSZ5MBg+Gu+IkMSfK3QIGnZ3Gw73Of83fgAZgoCnWmYt4WR Cw== 
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3x9wq2010a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 04 Apr 2024 14:19:41 +0000
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 434DbRZh009103;
	Thu, 4 Apr 2024 14:19:41 GMT
Received: from smtprelay06.dal12v.mail.ibm.com ([172.16.1.8])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3x9epxvjuv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 04 Apr 2024 14:19:41 +0000
Received: from smtpav06.wdc07v.mail.ibm.com (smtpav06.wdc07v.mail.ibm.com [10.39.53.233])
	by smtprelay06.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 434EJcJH32899772
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 4 Apr 2024 14:19:40 GMT
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 05D5758055;
	Thu,  4 Apr 2024 14:19:38 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1E50958060;
	Thu,  4 Apr 2024 14:19:37 +0000 (GMT)
Received: from sbct-3.pok.ibm.com (unknown [9.47.158.153])
	by smtpav06.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Thu,  4 Apr 2024 14:19:37 +0000 (GMT)
From: Stefan Berger <stefanb@linux.ibm.com>
To: keyrings@vger.kernel.org, linux-crypto@vger.kernel.org,
        herbert@gondor.apana.org.au, davem@davemloft.net
Cc: linux-kernel@vger.kernel.org, saulo.alessandre@tse.jus.br, lukas@wunner.de,
        bbhushan2@marvell.com, jarkko@kernel.org,
        Stefan Berger <stefanb@linux.ibm.com>
Subject: [PATCH v8 07/13] crypto: ecc - Add special case for NIST P521 in ecc_point_mult
Date: Thu,  4 Apr 2024 10:18:50 -0400
Message-ID: <20240404141856.2399142-8-stefanb@linux.ibm.com>
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
X-Proofpoint-ORIG-GUID: TiSuERCaut_CDO71WJhYF06XnjAOdCpC
X-Proofpoint-GUID: TiSuERCaut_CDO71WJhYF06XnjAOdCpC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-04_10,2024-04-04_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 suspectscore=0 mlxlogscore=999 lowpriorityscore=0 bulkscore=0
 clxscore=1015 priorityscore=1501 phishscore=0 malwarescore=0 mlxscore=0
 spamscore=0 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2404010000 definitions=main-2404040098

In ecc_point_mult use the number of bits of the NIST P521 curve + 2. The
change is required specifically for NIST P521 to pass mathematical tests
on the public key.

Tested-by: Lukas Wunner <lukas@wunner.de>
Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>
Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
---
 crypto/ecc.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/crypto/ecc.c b/crypto/ecc.c
index 90a8c7ea9095..fe2ae2d4185c 100644
--- a/crypto/ecc.c
+++ b/crypto/ecc.c
@@ -1320,7 +1320,10 @@ static void ecc_point_mult(struct ecc_point *result,
 	carry = vli_add(sk[0], scalar, curve->n, ndigits);
 	vli_add(sk[1], sk[0], curve->n, ndigits);
 	scalar = sk[!carry];
-	num_bits = sizeof(u64) * ndigits * 8 + 1;
+	if (curve->nbits == 521)	/* NIST P521 */
+		num_bits = curve->nbits + 2;
+	else
+		num_bits = sizeof(u64) * ndigits * 8 + 1;
 
 	vli_set(rx[1], point->x, ndigits);
 	vli_set(ry[1], point->y, ndigits);
-- 
2.43.0


