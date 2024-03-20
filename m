Return-Path: <linux-kernel+bounces-108877-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C0CA5881142
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 12:49:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 61FA11F22D03
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 11:49:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DC8F4206C;
	Wed, 20 Mar 2024 11:48:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="fLHjshW1"
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9A6C3FB95;
	Wed, 20 Mar 2024 11:48:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710935284; cv=none; b=gpmenWc3f05PpgFI6kXA8IB9QOjTjz3hwpfyy8Asx2eJ7PKHtW8VewwEnm1oah+3leXufNbwWp+Tk6HMX9crkbbMRKPe4Mv1VgsetvSvood2WQB9aNiNoAW09yOqIQzQkmL+KHUGHlJrBKSMR7kQBuDn4pP8IfeoiOSiSZl22Tc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710935284; c=relaxed/simple;
	bh=ECD6UYt8ly+hvwCPWZOIZbTGsBNVn9SePrs7rpx9N8E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ijMq1to9aCrGPMTEmFV9qeqnFCUyD063LQXAZNIEwpt93pdNcDkeK8jrPaMyPf0Vfdui3DqWh+TQEg9YN9u5uXas0jU4SWB7GTVpFeYdH0d/lP7b5XwxKF/xrKtqKAwYiU3suOawTtVYj/pr75qwq6s8oZjU1fjTsL34NOx1bTM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=fLHjshW1; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353728.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 42KBTJjK003623;
	Wed, 20 Mar 2024 11:47:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=XSXyAIueAHJ1lWNywrbbM71EPIyVuF7P/7ioWN+Hylo=;
 b=fLHjshW1fLz0xZzgvCSwVDzKlJ2H8reLdMo2axrqTu4yc8wvAQxUb0DnCqpvBh16WmRE
 +yWgbFQMzT/UmuayQzkqwQWZmSrIQk2QfIhFV1lg5DulHiLhTViqwFkxXboMX6MxDY35
 cSbnZZwISPgXzTNcslktj6X2tjwuKs350dyq9eP40oMEW2yceekA4KFr0Y5Cr5sOM4jO
 gdVeoTlCtIC6iR5RGnQ2xBIRqwBDUVCcO8UY8bkqw4wa5EOP/RyIN8kq1olq4j30l69O
 DogUDI14U0Y5inTAedmMeoh6AYEi/CilsT2vv9OmflOm7ZHsD49xbcSGsS1CvrrCwMzE 1g== 
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3wyxst026n-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 20 Mar 2024 11:47:56 +0000
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 42KA8uWZ010083;
	Wed, 20 Mar 2024 11:47:54 GMT
Received: from smtprelay05.dal12v.mail.ibm.com ([172.16.1.7])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3wxvav314t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 20 Mar 2024 11:47:54 +0000
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com [10.241.53.100])
	by smtprelay05.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 42KBlqVb26870506
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 20 Mar 2024 11:47:54 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2EE9B58061;
	Wed, 20 Mar 2024 11:47:52 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 615CA58057;
	Wed, 20 Mar 2024 11:47:51 +0000 (GMT)
Received: from sbct-3.pok.ibm.com (unknown [9.47.158.153])
	by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 20 Mar 2024 11:47:51 +0000 (GMT)
From: Stefan Berger <stefanb@linux.ibm.com>
To: keyrings@vger.kernel.org, linux-crypto@vger.kernel.org,
        herbert@gondor.apana.org.au, davem@davemloft.net
Cc: linux-kernel@vger.kernel.org, saulo.alessandre@tse.jus.br, lukas@wunner.de,
        bbhushan2@marvell.com, jarkko@kernel.org,
        Stefan Berger <stefanb@linux.ibm.com>
Subject: [PATCH v7 09/13] crypto: ecdsa - Replace ndigits with nbits where precision is needed
Date: Wed, 20 Mar 2024 07:47:21 -0400
Message-ID: <20240320114725.1644921-10-stefanb@linux.ibm.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240320114725.1644921-1-stefanb@linux.ibm.com>
References: <20240320114725.1644921-1-stefanb@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: cpEFCd5-Ul1kema4TV_rNOq5FbYVLyqi
X-Proofpoint-GUID: cpEFCd5-Ul1kema4TV_rNOq5FbYVLyqi
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-20_08,2024-03-18_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 lowpriorityscore=0
 mlxlogscore=999 adultscore=0 spamscore=0 clxscore=1015 impostorscore=0
 malwarescore=0 bulkscore=0 phishscore=0 suspectscore=0 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2403140000
 definitions=main-2403200093

Replace the usage of ndigits with nbits where precise space calculations
are needed, such as in ecdsa_max_size where the length of a coordinate is
determined.

Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
Tested-by: Lukas Wunner <lukas@wunner.de>
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


