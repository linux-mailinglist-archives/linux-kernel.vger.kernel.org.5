Return-Path: <linux-kernel+bounces-131593-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 455998989D3
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 16:20:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B43E4B27868
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 14:20:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E65412AAD5;
	Thu,  4 Apr 2024 14:19:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="kWaQUfPD"
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15057129A74;
	Thu,  4 Apr 2024 14:19:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712240391; cv=none; b=sD2CADrJjHXLYz6VwzC4WlJFrs4K1b9EaPKxSLbTEBNuIZ7cz13PXGEX8vszz6/RNp9JjjGqCbX69WwjNyhSvyM86SZo35zaIWS9AXYeUQ35XhT46EPZ9WJlprXgPPkNnZgTiBG4xaa1of1DkCOK4GfNcn6Xmy0GoCvX9A4TzDE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712240391; c=relaxed/simple;
	bh=DHCxdePl0cuKgx3nHSSa81lOVRC9rALifRT7WcPhNqU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MOwCf5FVVxGcK6H7X+pxVy2XG21PeGQ5uzNUUUFDcfM3NuwkBsrVBnkJFVDQfD8RrwtoeFKGomqi2wX2ondJ/2VT4auwbUkUTdXm1ZcL2Wy6VmXZxwnCvHDCHFNEeM8+uMje/CKe76U6W+uWD4l0rlyZysfzBlB2SBbUZvvlXLs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=kWaQUfPD; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 434DbrMu008413;
	Thu, 4 Apr 2024 14:19:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=wCnlG756d7rHHKb+Pr5nLg3yqADN9zUXiZW7gnzmm9I=;
 b=kWaQUfPDF5tXu23akdWFa3/hzutSmGbK6G8q+p66qz9fsZOXVPnPAu4uzRH0D9AfKKhw
 VIsr7MvsUn95qi1msb3lL4kTJrsGlPQr8l2pzAqGru9Y9qIT/J9zMklrt5kPQWk9yPGi
 5QkDNJqYOVGCI5IaM+dIq/Jle740gPw2/KzMK5pz1TFBFxHU58BN4RfaevuS4j5YFqlP
 ld8Otd12iXboCmTjPBygWIhcIc0/PZ4/QQhaCBaOwU6vRHiN2pDqup6CsHPvmsjMVgSc
 v6uVVxGR5svNXvq9mImUhDVzGhzECYM+ZqjrdGWxBG3wORi5XpaEzQBGCjd//2tpwgtU WQ== 
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3x9w8e83bq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 04 Apr 2024 14:19:43 +0000
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 434DkPT7008696;
	Thu, 4 Apr 2024 14:19:42 GMT
Received: from smtprelay01.wdc07v.mail.ibm.com ([172.16.1.68])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3x9epw4k61-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 04 Apr 2024 14:19:42 +0000
Received: from smtpav06.wdc07v.mail.ibm.com (smtpav06.wdc07v.mail.ibm.com [10.39.53.233])
	by smtprelay01.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 434EJepg44171718
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 4 Apr 2024 14:19:42 GMT
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1401758064;
	Thu,  4 Apr 2024 14:19:40 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2C55358062;
	Thu,  4 Apr 2024 14:19:39 +0000 (GMT)
Received: from sbct-3.pok.ibm.com (unknown [9.47.158.153])
	by smtpav06.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Thu,  4 Apr 2024 14:19:39 +0000 (GMT)
From: Stefan Berger <stefanb@linux.ibm.com>
To: keyrings@vger.kernel.org, linux-crypto@vger.kernel.org,
        herbert@gondor.apana.org.au, davem@davemloft.net
Cc: linux-kernel@vger.kernel.org, saulo.alessandre@tse.jus.br, lukas@wunner.de,
        bbhushan2@marvell.com, jarkko@kernel.org,
        Stefan Berger <stefanb@linux.ibm.com>
Subject: [PATCH v8 09/13] crypto: ecdsa - Replace ndigits with nbits where precision is needed
Date: Thu,  4 Apr 2024 10:18:52 -0400
Message-ID: <20240404141856.2399142-10-stefanb@linux.ibm.com>
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
X-Proofpoint-ORIG-GUID: v7e3EBOwXOtOKej8LR70bnFaRdZjKRmq
X-Proofpoint-GUID: v7e3EBOwXOtOKej8LR70bnFaRdZjKRmq
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-04_10,2024-04-04_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 mlxlogscore=999 adultscore=0 clxscore=1015 bulkscore=0 mlxscore=0
 lowpriorityscore=0 spamscore=0 suspectscore=0 impostorscore=0
 priorityscore=1501 phishscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2404010000 definitions=main-2404040098

Replace the usage of ndigits with nbits where precise space calculations
are needed, such as in ecdsa_max_size where the length of a coordinate is
determined.

Tested-by: Lukas Wunner <lukas@wunner.de>
Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>
Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
---
 crypto/ecdsa.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/crypto/ecdsa.c b/crypto/ecdsa.c
index 9b84ab503276..75d3eea885db 100644
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


