Return-Path: <linux-kernel+bounces-131603-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 448A78989F5
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 16:23:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ADED91F30D26
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 14:23:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D242A1332BC;
	Thu,  4 Apr 2024 14:19:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="VV/e7LOW"
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D0E3130E2F;
	Thu,  4 Apr 2024 14:19:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712240399; cv=none; b=iOF11rn1RMemCV13E/sPoGLPlOpiokn+ngtU0/xrgA7Az2wrr18p4X7WfGktwyNWE2FyHdqOoZ5JyCbGaF8ljYGnt8hM0R9OD+3e12T/4BSyLpB9kzYlrsZHpMLmdShwbQLinUKWrmduB4gINXssB8mB+laqKmgGSfeuufVo430=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712240399; c=relaxed/simple;
	bh=JD9gwPcSFrOpuw601Vg9upMDLw7GWpMiNc7NTi7AvBA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tKtODZEY4RkPFrHf+DU/Lv1sOefc2rebTqM1aFxYFpZcpnbXnEaQs2srB1rSP+2Db+MJM0t6riUuwCHQgDzCq8HtOBtvfq+JLcRdZ49s886x7vZRpOvhyIzXbBj02OMSO2KuqUg02VEwZzMjU0fRQ2StKaOdhcA4uCgpz+jmk6M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=VV/e7LOW; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353722.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 434E2U1W017603;
	Thu, 4 Apr 2024 14:19:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=D7EFgWWbV/Bd3kDJEyD8H665TYfjNzFMZsdZvDtm7h4=;
 b=VV/e7LOWP22FrZI7ZIMSpMJ804kLKyzovKnJcnjMwPKGMUmSGNTpH0zo2GSUhO5ai+Wc
 j/5oXnPgXKjIBybhSobAESlSJWztN0QXtuDOMEgvKDKIPKlC18fuInnSDxKbNeiKEX7W
 9l/L6lJ8ArLKdIvHLijUSCC64+6z6PpFllxGW9HZkmgwNFNiSTLvWdpeocsIU5cjdlqV
 T6xJwe4QfBCz6SHNa5aQwFlWqgJYXg5lzU4jIz+tZUUYm3H0QP57fA+EcZzjFLa9l1eS
 3bUhbOnlrZLQodg2oGqMm/x3sSsAE9eaxf4hmnI5e0NU6ikAP6LtTpfT5eMPiwrxs7cz MQ== 
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3x9wg60208-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 04 Apr 2024 14:19:46 +0000
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 434DedGi009109;
	Thu, 4 Apr 2024 14:19:45 GMT
Received: from smtprelay04.wdc07v.mail.ibm.com ([172.16.1.71])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3x9epxvjvd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 04 Apr 2024 14:19:45 +0000
Received: from smtpav06.wdc07v.mail.ibm.com (smtpav06.wdc07v.mail.ibm.com [10.39.53.233])
	by smtprelay04.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 434EJhEf22741588
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 4 Apr 2024 14:19:45 GMT
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 23B2958055;
	Thu,  4 Apr 2024 14:19:43 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 44D2A58056;
	Thu,  4 Apr 2024 14:19:42 +0000 (GMT)
Received: from sbct-3.pok.ibm.com (unknown [9.47.158.153])
	by smtpav06.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Thu,  4 Apr 2024 14:19:42 +0000 (GMT)
From: Stefan Berger <stefanb@linux.ibm.com>
To: keyrings@vger.kernel.org, linux-crypto@vger.kernel.org,
        herbert@gondor.apana.org.au, davem@davemloft.net
Cc: linux-kernel@vger.kernel.org, saulo.alessandre@tse.jus.br, lukas@wunner.de,
        bbhushan2@marvell.com, jarkko@kernel.org,
        Stefan Berger <stefanb@linux.ibm.com>
Subject: [PATCH v8 12/13] crypto: asymmetric_keys - Adjust signature size calculation for NIST P521
Date: Thu,  4 Apr 2024 10:18:55 -0400
Message-ID: <20240404141856.2399142-13-stefanb@linux.ibm.com>
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
X-Proofpoint-GUID: DMVUlUISDf_eCzlVAwWBk_Y5gOi9K4qI
X-Proofpoint-ORIG-GUID: DMVUlUISDf_eCzlVAwWBk_Y5gOi9K4qI
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-04_10,2024-04-04_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 spamscore=0
 mlxscore=0 suspectscore=0 clxscore=1015 lowpriorityscore=0 mlxlogscore=999
 phishscore=0 impostorscore=0 priorityscore=1501 malwarescore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2404010000
 definitions=main-2404040098

Adjust the calculation of the maximum signature size for support of
NIST P521. While existing curves may prepend a 0 byte to their coordinates
(to make the number positive), NIST P521 will not do this since only the
first bit in the most significant byte is used.

If the encoding of the x & y coordinates requires at least 128 bytes then
an additional byte is needed for the encoding of the length. Take this into
account when calculating the maximum signature size.

Reviewed-by: Lukas Wunner <lukas@wunner.de>
Tested-by: Lukas Wunner <lukas@wunner.de>
Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>
Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
---
 crypto/asymmetric_keys/public_key.c | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/crypto/asymmetric_keys/public_key.c b/crypto/asymmetric_keys/public_key.c
index e314fd57e6f8..3474fb34ded9 100644
--- a/crypto/asymmetric_keys/public_key.c
+++ b/crypto/asymmetric_keys/public_key.c
@@ -234,6 +234,7 @@ static int software_key_query(const struct kernel_pkey_params *params,
 	info->key_size = len * 8;
 
 	if (strncmp(pkey->pkey_algo, "ecdsa", 5) == 0) {
+		int slen = len;
 		/*
 		 * ECDSA key sizes are much smaller than RSA, and thus could
 		 * operate on (hashed) inputs that are larger than key size.
@@ -247,8 +248,19 @@ static int software_key_query(const struct kernel_pkey_params *params,
 		 * Verify takes ECDSA-Sig (described in RFC 5480) as input,
 		 * which is actually 2 'key_size'-bit integers encoded in
 		 * ASN.1.  Account for the ASN.1 encoding overhead here.
+		 *
+		 * NIST P192/256/384 may prepend a '0' to a coordinate to
+		 * indicate a positive integer. NIST P521 never needs it.
 		 */
-		info->max_sig_size = 2 * (len + 3) + 2;
+		if (strcmp(pkey->pkey_algo, "ecdsa-nist-p521") != 0)
+			slen += 1;
+		/* Length of encoding the x & y coordinates */
+		slen = 2 * (slen + 2);
+		/*
+		 * If coordinate encoding takes at least 128 bytes then an
+		 * additional byte for length encoding is needed.
+		 */
+		info->max_sig_size = 1 + (slen >= 128) + 1 + slen;
 	} else {
 		info->max_data_size = len;
 		info->max_sig_size = len;
-- 
2.43.0


