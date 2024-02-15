Return-Path: <linux-kernel+bounces-67809-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BFDC857158
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 00:16:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id ABF7BB245DC
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 23:16:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 715091487DE;
	Thu, 15 Feb 2024 23:14:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Kg34Uy9J"
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00ED81474C4;
	Thu, 15 Feb 2024 23:14:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708038879; cv=none; b=qLAjBmL/AK8AM4r7l0SZva9OJnXnzgCjEZahkalm5TdwGeDIbVKD/VBfgPWU8U7ajzKgp5LWWgGkjXQvfDoku0dh2MlqhVD0MPt0dRBh/Qke9lX4F6sDAD8jyCrTSWiXTJaEuO/zS5i94MgjyEHjGlCyq53aI9ysg/p3B9JVcvc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708038879; c=relaxed/simple;
	bh=+wrKDJnCE2zkQQ/ejXAW3OkteKB8kBUl4MJe6OLpHRw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=X4JKi00hp/Sai44027UU4M/hH3c2dlmQNcpmQv80D2V4lBwkG12ql6t4ThIiNr6ih7FVmT2qmptJ7mrSb5L/T1XGRHGSTA8mGo6hZ6u6UyPvlfpiFrA0Rqmfv6GhTPTDg+KC+I3hXqOUp8gvLp75rTXx7l/Bk4VBDJ5+cpDI1Ak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Kg34Uy9J; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 41FMl39w018886;
	Thu, 15 Feb 2024 23:14:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=fvkw34qL4rk0HGg2B+0ywRlkEipg9FXOfBEaoEyELT4=;
 b=Kg34Uy9Joo0QI1QdShFbxf+ZAfdDkXCtNEZMfNsj0+TsaGxWKLuNEBSp4oLfwtUA4SUF
 ebKzw5hJkcPorEWBaq06tl6hv+T9H6f93fBDrU22v8IxavQFO/twE4NBPmsKbMYpTf1t
 oabgRhUXvV10T1jIvDP8llvcfGJ8SSRJaRmNhDxEbfO6VD0VbBhpdHMMpCiAYnbbtZT6
 9OpTwE8JV5Q9dZL4AXgSFkx82YcOhuNa1gvt5davYoh4YxNAsxMMxCfecIbFHklDssSY
 i8i+tNqvh5gBYItvbDjoDnPGoh79vyeUUZVAS48LGVWmlV6h0xYfHrcXoKf/fDhWIplF iw== 
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3w9ugch28s-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 15 Feb 2024 23:14:32 +0000
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 41FLB5H4010083;
	Thu, 15 Feb 2024 23:14:31 GMT
Received: from smtprelay05.dal12v.mail.ibm.com ([172.16.1.7])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 3w6npm7h4u-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 15 Feb 2024 23:14:31 +0000
Received: from smtpav04.wdc07v.mail.ibm.com (smtpav04.wdc07v.mail.ibm.com [10.39.53.231])
	by smtprelay05.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 41FNEStd20709930
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 15 Feb 2024 23:14:31 GMT
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id AB69E58054;
	Thu, 15 Feb 2024 23:14:28 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id F1C6058050;
	Thu, 15 Feb 2024 23:14:27 +0000 (GMT)
Received: from sbct-3.pok.ibm.com (unknown [9.47.158.153])
	by smtpav04.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 15 Feb 2024 23:14:27 +0000 (GMT)
From: Stefan Berger <stefanb@linux.ibm.com>
To: keyrings@vger.kernel.org, linux-crypto@vger.kernel.org,
        herbert@gondor.apana.org.au, davem@davemloft.net
Cc: linux-kernel@vger.kernel.org, saulo.alessandre@tse.jus.br,
        Stefan Berger <stefanb@linux.ibm.com>
Subject: [PATCH v2 10/14] crypto: ecc - Implement ecc_digits_to_bytes to convert digits to byte array
Date: Thu, 15 Feb 2024 18:14:09 -0500
Message-ID: <20240215231414.3857320-11-stefanb@linux.ibm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240215231414.3857320-1-stefanb@linux.ibm.com>
References: <20240215231414.3857320-1-stefanb@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: cTTdaRoLdlx0xsX8gtPrGlw2PQ6VnaQg
X-Proofpoint-GUID: cTTdaRoLdlx0xsX8gtPrGlw2PQ6VnaQg
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-15_22,2024-02-14_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 suspectscore=0
 spamscore=0 mlxscore=0 clxscore=1015 impostorscore=0 phishscore=0
 priorityscore=1501 adultscore=0 bulkscore=0 mlxlogscore=999
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2402150181

Implement ecc_digits_to_bytes to convert an array of digits into an
nbytes-sized byte array.

Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
---
 include/crypto/internal/ecc.h | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/include/crypto/internal/ecc.h b/include/crypto/internal/ecc.h
index b8ca5023b3b5..6229aa3f3218 100644
--- a/include/crypto/internal/ecc.h
+++ b/include/crypto/internal/ecc.h
@@ -75,6 +75,24 @@ static inline void ecc_digits_from_bytes(const u8 *in, unsigned int nbytes,
 	ecc_swap_digits(tmp, out, ndigits);
 }
 
+/**
+ * ecc_digits_to_bytes() - Copy digits into a byte array of size nbytes
+ * @in:      Input digits array
+ * @ndigits: Number of digits in input digits array
+ * @out:     Output byte array
+ * @nbytes:  Number of bytes to copy into byte array
+ */
+static inline void ecc_digits_to_bytes(const u64 *in, unsigned int ndigits,
+				       u8 *out, unsigned int nbytes)
+{
+	unsigned int sz = ndigits << ECC_DIGITS_TO_BYTES_SHIFT;
+	u8 tmp[ECC_MAX_DIGITS << ECC_DIGITS_TO_BYTES_SHIFT];
+	unsigned int o = sz - nbytes;
+
+	ecc_swap_digits(in, (u64 *)tmp, ndigits);
+	memcpy(out, &tmp[o], nbytes);
+}
+
 /**
  * ecc_is_key_valid() - Validate a given ECDH private key
  *
-- 
2.43.0


