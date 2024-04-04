Return-Path: <linux-kernel+bounces-131600-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 30C168989EA
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 16:21:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DA982290828
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 14:21:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 292EC12FF71;
	Thu,  4 Apr 2024 14:19:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="bl78vdjr"
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 907DB823D0;
	Thu,  4 Apr 2024 14:19:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712240395; cv=none; b=DeQ+jt9ZD0rzNC5whKO/e1GJHaldKfFy9ThUutDc4UiBELrgMfE2j5en+W9MtMd+7dXMilkTJHGExyw0FMTNnSssCz2pFTGouL6PirgPu3XgYaRO2vOhpacSPr5kVr7IRqx8rpSAQ+Q5L5qnEzDUO46nFgulBEqvFBpUk974Wf8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712240395; c=relaxed/simple;
	bh=ceOhMkXhhjE2VCnPdJ81KDPB9U6dw0diKMwCZXELyuM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cEx2AjbO30KQo//D+bYROGX//Mg6q3SseyKAPunUr2Tli+bJpQvSwfw/zYq6+qqap02o+mi29TWFe8eNDfn6eyoImKIh78m3pvIYNTJPq4vwdy3+J4Ft3ewLbZs/FT6akQ/e+E4w638hzEq4wYuCr3/d0tn75SO2IZBlLh+lLEg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=bl78vdjr; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 434EIQdP017844;
	Thu, 4 Apr 2024 14:19:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=6GmRgFSpVAAz5Vk6vzVz2u5+FVPlc9BlaNO7ZWRAV20=;
 b=bl78vdjrHMEf0AmT9Yi0ElPhDKoyjLpGVNTffXDHfpXoUl8g2BXh9ZqF96nb37jJVOTu
 ZVMkJAaKs30QfmJ2I3SLW9eH/DIP3kS4zp33lwTai5Nmlt58q23xOmMd+AONBWS4yPqe
 NjXyTlc0N84DfK/L05SZmtpQOgWc4m2Ac42gJmHAe5RLLUlRXM/igZJzcyj2E8Ut57Rm
 NIKTbu49h97UV3m+49ttCBhZl7KmbjwUWbnD8C+1A1rWGRxBOZEEyfXHOGT+L6ltUNv8
 KcmxQqZ5swrdkH9uAS7OIaZGKvL7KFeZuWND0geRPGACG5HedThOx87yxAs4pNerQyYr wQ== 
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3x9wuk8035-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 04 Apr 2024 14:19:38 +0000
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 434Dj628003615;
	Thu, 4 Apr 2024 14:19:37 GMT
Received: from smtprelay03.dal12v.mail.ibm.com ([172.16.1.5])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 3x9epyck0n-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 04 Apr 2024 14:19:37 +0000
Received: from smtpav06.wdc07v.mail.ibm.com (smtpav06.wdc07v.mail.ibm.com [10.39.53.233])
	by smtprelay03.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 434EJZiV47514098
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 4 Apr 2024 14:19:37 GMT
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E9FBE58068;
	Thu,  4 Apr 2024 14:19:34 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1800558055;
	Thu,  4 Apr 2024 14:19:34 +0000 (GMT)
Received: from sbct-3.pok.ibm.com (unknown [9.47.158.153])
	by smtpav06.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Thu,  4 Apr 2024 14:19:33 +0000 (GMT)
From: Stefan Berger <stefanb@linux.ibm.com>
To: keyrings@vger.kernel.org, linux-crypto@vger.kernel.org,
        herbert@gondor.apana.org.au, davem@davemloft.net
Cc: linux-kernel@vger.kernel.org, saulo.alessandre@tse.jus.br, lukas@wunner.de,
        bbhushan2@marvell.com, jarkko@kernel.org,
        Stefan Berger <stefanb@linux.ibm.com>
Subject: [PATCH v8 04/13] crypto: ecdsa - Extend res.x mod n calculation for NIST P521
Date: Thu,  4 Apr 2024 10:18:47 -0400
Message-ID: <20240404141856.2399142-5-stefanb@linux.ibm.com>
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
X-Proofpoint-ORIG-GUID: l8siRQ3oaC6t8nyqGw2sW9YHg6oziiP8
X-Proofpoint-GUID: l8siRQ3oaC6t8nyqGw2sW9YHg6oziiP8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-04_10,2024-04-04_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999
 impostorscore=0 bulkscore=0 clxscore=1015 suspectscore=0
 priorityscore=1501 phishscore=0 lowpriorityscore=0 adultscore=0 mlxscore=0
 spamscore=0 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2404010000 definitions=main-2404040098

res.x has been calculated by ecc_point_mult_shamir, which uses
'mod curve_prime' on res.x and therefore p > res.x with 'p' being the
curve_prime. Further, it is true that for the NIST curves p > n with 'n'
being the 'curve_order' and therefore the following may be true as well:
p > res.x >= n.

If res.x >= n then res.x mod n can be calculated by iteratively sub-
tracting n from res.x until res.x < n. For NIST P192/256/384 this can be
done in a single subtraction. This can also be done in a single
subtraction for NIST P521.

The mathematical reason why a single subtraction is sufficient is due to
the values of 'p' and 'n' of the NIST curves where the following holds
true:

   note: max(res.x) = p - 1

   max(res.x) - n < n
       p - 1  - n < n
       p - 1      < 2n  => holds true for the NIST curves

Tested-by: Lukas Wunner <lukas@wunner.de>
Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>
Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
---
 crypto/ecdsa.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/crypto/ecdsa.c b/crypto/ecdsa.c
index 9462a4d640a7..9b84ab503276 100644
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


