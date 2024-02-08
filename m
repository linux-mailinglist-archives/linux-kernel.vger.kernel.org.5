Return-Path: <linux-kernel+bounces-58786-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EA0784EBAD
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 23:22:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4A86A28407B
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 22:22:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7370B53E1F;
	Thu,  8 Feb 2024 22:19:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Z/6sLODp"
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB05C51C51;
	Thu,  8 Feb 2024 22:19:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707430755; cv=none; b=RHa3Q9E5+42YSOYMCERG2EFmbx65qX3K+NczzaSNIvcNgoq4WNV8a5+VS6qMPXuNAjYABH3DXAaqnWJ83AR+Tk8p2CjNOCzKhrzLTPQpGdewLa+GcGxyRyXps7YL3R1krIVuYk4ka4OonOc/43zuHwGLEG44X2cY4kxSOZdwL/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707430755; c=relaxed/simple;
	bh=xBZ1n0gZp8EYVlO6T0SCUTSiV9bBvyRUZz/acfyupgY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bYF+CUnnx9WQCgVkEVB7yKbgE91RiGmxflYVGjFYYs+mfE2fgm89VN2KxQTUdPeV1SjjcWSvSaBs2qPWrotX+w+gENC1/otG51+YPmjUyTdC7rZszujKms8cF6PUj7MkjALSIBYVU+FLuu8q22Zmpcm1g+mJDz4a/Xdc2SANuiU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Z/6sLODp; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 418LSUhQ018549;
	Thu, 8 Feb 2024 22:19:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=ffTyu2ELv5lNxL73wl5uPavNRaJrPsOooJ4QLpeU3l4=;
 b=Z/6sLODpoA4i0TwDYApA0kJ3KoiH0cqUNgw3DCQos42xoUOjSAUxPkzW7Y+YfORfZkrH
 D3tSH0DssWi5lZidoCPR9Wr0UEDZoVUOqIH6sZKP/C2vcdAbkdl/sID1a9TLT/vBkJ1l
 hYNymEP7Sn5t/dcPg+6wuDcdWoWv2ShovfS0fgnI6PApvnI71KGDrBLz+5BGynCO75ad
 pTpOOcKpxxQx0XDiOJKQSojFyPCRqgCLPzqb7FVxZXV0NOE1btEKUEQOUZTxCcsFAK0J
 HovWM99++2kpzlQs85Fc3GaAflrRpTEbz80LFIo+pptz5Ob6fCDidKR/c9bmxNH+nuB3 oQ== 
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3w56w7s0we-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 08 Feb 2024 22:19:08 +0000
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 418L0l5U005455;
	Thu, 8 Feb 2024 22:19:07 GMT
Received: from smtprelay02.dal12v.mail.ibm.com ([172.16.1.4])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3w21akycmm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 08 Feb 2024 22:19:07 +0000
Received: from smtpav03.dal12v.mail.ibm.com (smtpav03.dal12v.mail.ibm.com [10.241.53.102])
	by smtprelay02.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 418MJ6v132178856
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 8 Feb 2024 22:19:06 GMT
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 959D958060;
	Thu,  8 Feb 2024 22:19:06 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2E13258063;
	Thu,  8 Feb 2024 22:19:06 +0000 (GMT)
Received: from sbct-3.pok.ibm.com (unknown [9.47.158.153])
	by smtpav03.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Thu,  8 Feb 2024 22:19:06 +0000 (GMT)
From: Stefan Berger <stefanb@linux.ibm.com>
To: keyrings@vger.kernel.org, linux-crypto@vger.kernel.org,
        herbert@gondor.apana.org.au, davem@davemloft.net
Cc: linux-kernel@vger.kernel.org, saulo.alessandre@tse.jus.br,
        Stefan Berger <stefanb@linux.ibm.com>
Subject: [PATCH 12/14] crypto: ecc - Implement and use ecc_curve_get_nbytes to get curve's nbytes
Date: Thu,  8 Feb 2024 17:18:38 -0500
Message-ID: <20240208221840.3665874-13-stefanb@linux.ibm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240208221840.3665874-1-stefanb@linux.ibm.com>
References: <20240208221840.3665874-1-stefanb@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: nsQsEpe2xtw309j9OHAaYO0pP5PK772U
X-Proofpoint-ORIG-GUID: nsQsEpe2xtw309j9OHAaYO0pP5PK772U
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-08_11,2024-02-08_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 adultscore=0
 spamscore=0 mlxscore=0 priorityscore=1501 impostorscore=0 mlxlogscore=998
 lowpriorityscore=0 phishscore=0 bulkscore=0 clxscore=1015 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2402080124

Implement ecc_curve_get_nbytes to get a curve's number of bytes (nbytes).
The number of bytes can be derived from the nbits field of a curve, if
set, otherwise from the ndigits field.

Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
---
 crypto/ecc.c                  |  6 ++----
 include/crypto/internal/ecc.h | 11 +++++++++++
 2 files changed, 13 insertions(+), 4 deletions(-)

diff --git a/crypto/ecc.c b/crypto/ecc.c
index 73fbbfc8d69c..f643719450b8 100644
--- a/crypto/ecc.c
+++ b/crypto/ecc.c
@@ -1478,10 +1478,8 @@ static int __ecc_is_key_valid(const struct ecc_curve *curve,
 int ecc_is_key_valid(unsigned int curve_id, unsigned int ndigits,
 		     const u64 *private_key, unsigned int private_key_len)
 {
-	int nbytes;
 	const struct ecc_curve *curve = ecc_get_curve(curve_id);
-
-	nbytes = ndigits << ECC_DIGITS_TO_BYTES_SHIFT;
+	int nbytes = ecc_curve_get_nbytes(curve);
 
 	if (private_key_len != nbytes)
 		return -EINVAL;
@@ -1506,7 +1504,7 @@ int ecc_gen_privkey(unsigned int curve_id, unsigned int ndigits, u64 *privkey)
 {
 	const struct ecc_curve *curve = ecc_get_curve(curve_id);
 	u64 priv[ECC_MAX_DIGITS];
-	unsigned int nbytes = ndigits << ECC_DIGITS_TO_BYTES_SHIFT;
+	unsigned int nbytes = ecc_curve_get_nbytes(curve);
 	unsigned int nbits = vli_num_bits(curve->n, ndigits);
 	int err;
 
diff --git a/include/crypto/internal/ecc.h b/include/crypto/internal/ecc.h
index 75ee113f58f9..ba9ca0dcb971 100644
--- a/include/crypto/internal/ecc.h
+++ b/include/crypto/internal/ecc.h
@@ -93,6 +93,17 @@ static inline void ecc_digits_to_array(const u64 *in, unsigned int ndigits,
 	memcpy(out, &tmp[o], nbytes);
 }
 
+/**
+ * ecc_curve_get_nbytes() - Get the number of bytes the curve requires
+ * @curve:   The curve
+ */
+static inline unsigned int ecc_curve_get_nbytes(const struct ecc_curve *curve)
+{
+	if (curve->nbits)
+		return DIV_ROUND_UP(curve->nbits, 8);
+	return curve->g.ndigits << ECC_DIGITS_TO_BYTES_SHIFT;
+}
+
 /**
  * ecc_is_key_valid() - Validate a given ECDH private key
  *
-- 
2.43.0


