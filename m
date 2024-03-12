Return-Path: <linux-kernel+bounces-100668-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 76540879B8D
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 19:38:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 16F03B23E20
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 18:38:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1488B1428F1;
	Tue, 12 Mar 2024 18:37:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="toUFl8vp"
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B14B61419B0;
	Tue, 12 Mar 2024 18:37:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710268662; cv=none; b=HWUgew6W4qo2JVJ8H5Wzmk+4dcJqNmkp5dUt6isczkqNEakCiwD7Bcuuus2eZeQ4q5TLIetusVTWQQBDX8TR1zLAlUC6DbMrJcwU4qIteoaSPSB9pjz46gjIwh1PntpHQ/No9+JujGdai6JrcDMo+plJi7Ms+7jI3VSVKpYlUYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710268662; c=relaxed/simple;
	bh=HJNTECjcP7hVlkLM/J0+a6D2Csmbnoycbxs7pGxdvio=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jhx2FKqk8NECxy8R5EyUPZABP2G7LlDFWLG5NZnwMTOpEL/YGcUanH5m8D9RNvcSFbw5OhG8IS4gr/EEq43zVDHC3O1j4AiNdrwsiy59UnpJkTJcAOPFYpAAVeQvcsJm28JmG6IbmwfvGkJRszq+LvW9KaC2QUSx3ICq4ykSacM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.vnet.ibm.com; spf=none smtp.mailfrom=linux.vnet.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=toUFl8vp; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.vnet.ibm.com
Received: from pps.filterd (m0353723.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 42CINLdl013201;
	Tue, 12 Mar 2024 18:36:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=3ZUne4qzvAvhXom987zL4TkiYNBeRkZHjcNCLQNmfp0=;
 b=toUFl8vpaQezniPFk24G1yg44Trt1J7zF/Q8V70ItCDSuG1Da5yWacVMEPSYSVLjF5tW
 DS7yxb/aIyQDmVqxfdLdkHY8nnG4QhUFPi9xobVYMxlTxNhBxnOInMQM0CucXixWNBdZ
 jbEwWHsSclkXrINu6KfHscgDuDk3pUpgnZ3PYDAcVBBmCnLcoden+8tQzVw1q+mrNY1L
 dEGSTbC+ADKSIMqSsZyoBZbl5ABsQcQLybn0W0RFtbnj0kuuvtWqOnvSlmPQGvMPLnIu
 YMzVU01lIOrSf+iiFuyyw2J9VeE/9mU3y8gH0R6WkmCsQapmQaeaIGqsmJ/MM1y2T1iz ng== 
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3wtv9d86k2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 12 Mar 2024 18:36:28 +0000
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 42CGNFJJ013580;
	Tue, 12 Mar 2024 18:36:27 GMT
Received: from smtprelay03.wdc07v.mail.ibm.com ([172.16.1.70])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 3ws4ak8gtt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 12 Mar 2024 18:36:27 +0000
Received: from smtpav06.wdc07v.mail.ibm.com (smtpav06.wdc07v.mail.ibm.com [10.39.53.233])
	by smtprelay03.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 42CIaPG337421544
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 12 Mar 2024 18:36:27 GMT
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 17C015806F;
	Tue, 12 Mar 2024 18:36:25 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 28ECB58062;
	Tue, 12 Mar 2024 18:36:24 +0000 (GMT)
Received: from sbct-3.pok.ibm.com (unknown [9.47.158.153])
	by smtpav06.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 12 Mar 2024 18:36:24 +0000 (GMT)
From: Stefan Berger <stefanb@linux.vnet.ibm.com>
To: keyrings@vger.kernel.org, linux-crypto@vger.kernel.org,
        herbert@gondor.apana.org.au, davem@davemloft.net
Cc: linux-kernel@vger.kernel.org, saulo.alessandre@tse.jus.br, lukas@wunner.de,
        bbhushan2@marvell.com, jarkko@kernel.org,
        Stefan Berger <stefanb@linux.ibm.com>
Subject: [PATCH v6 04/13] crypto: ecdsa - Extend res.x mod n calculation for NIST P521
Date: Tue, 12 Mar 2024 14:36:09 -0400
Message-ID: <20240312183618.1211745-5-stefanb@linux.vnet.ibm.com>
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
X-Proofpoint-GUID: N_q-3bDQ9lwe16RmS8dULQFM40qakM-R
X-Proofpoint-ORIG-GUID: N_q-3bDQ9lwe16RmS8dULQFM40qakM-R
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-12_11,2024-03-12_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 impostorscore=0 clxscore=1015 spamscore=0 mlxlogscore=999 bulkscore=0
 lowpriorityscore=0 mlxscore=0 phishscore=0 malwarescore=0 suspectscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2403120139

From: Stefan Berger <stefanb@linux.ibm.com>

res.x has been calculated by ecc_point_mult_shamir, which uses
'mod curve_prime'. The curve_prime 'p' is typically larger than the
curve_order 'n' and therefore it is possible that p > res.x >= n.

If res.x >= n then res.x mod n can be calculated by iteratively sub-
tracting n from res.x until n > res.x. For NIST P192/256/384 this can be
done in a single subtraction. This can also be done in a single
subtraction for NIST P521.

The mathematical reason why a single subtraction is sufficient is
due to the values of 'p' and 'n' of the NIST curves where the following
holds true:

   note: max(res.x) = p - 1

   max(res.x) - n < n
       p - 1  - n < n
       p - 1      < 2n  => true for the NIST curves

Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
Tested-by: Lukas Wunner <lukas@wunner.de>
---
 crypto/ecdsa.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/crypto/ecdsa.c b/crypto/ecdsa.c
index 64e1e69d53ba..1814f009f971 100644
--- a/crypto/ecdsa.c
+++ b/crypto/ecdsa.c
@@ -122,7 +122,7 @@ static int _ecdsa_verify(struct ecc_ctx *ctx, const u64 *hash, const u64 *r, con
 
 	/* res.x = res.x mod n (if res.x > order) */
 	if (unlikely(vli_cmp(res.x, curve->n, ndigits) == 1))
-		/* faster alternative for NIST p384, p256 & p192 */
+		/* faster alternative for NIST p521, p384, p256 & p192 */
 		vli_sub(res.x, res.x, curve->n, ndigits);
 
 	if (!vli_cmp(res.x, r, ndigits))
-- 
2.43.0


