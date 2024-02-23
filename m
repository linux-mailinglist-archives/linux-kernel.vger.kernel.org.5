Return-Path: <linux-kernel+bounces-79120-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A2AEF861DD5
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 21:43:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5CC27289B2E
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 20:43:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9D2214DFCD;
	Fri, 23 Feb 2024 20:42:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="bfTpEKZn"
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF8FD14CAA3;
	Fri, 23 Feb 2024 20:42:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708720938; cv=none; b=BoVMlsJdEmqYhHECn5Xwspwztl39+XWCr/uWrsWb6ZLDVBbvjTfPlxjdL/+jLRFEjm2JsFl65yhxj058jUIsZGvupkJ7/JkEl0zaPKFs5sQmUwZmQAiUz2JEKmbHY1+lXQ4JFtL/z9PsMLV5Od7nSfx5zJtwtTI8z7OyatqHM00=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708720938; c=relaxed/simple;
	bh=HwbpDfxL64YiFAOSlLxKSw+TVKmROIZpdn9Bh3nZcEY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YqIwBlH1RkGfNb4rAAowHL6euJ+QxwIdWu1O+DmIY9jLJPqWNcrcoLkhN/cx0GaEMLqCBC2spWq39DPBh1Y8qGpnD0fD8h9CC5qT4TBc2C5A9bMGM/2CSir++vrkb3vvUkE/SYwkzAsLmr4OI6CKHe3uv1fNjZSVF5cOk5XmqzQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=bfTpEKZn; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 41NKcUid002052;
	Fri, 23 Feb 2024 20:42:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=whs1Bs95HbsNoZ3VlGO9cXovHbfpSwz5zirMGg1rhio=;
 b=bfTpEKZnpri3NqdvuUantLAZqMwtFea3evTxxGo6zILmR/iI6XSfB2EjqxqIyHgXA3+r
 YL1rxy0Vcbau8nbeePBgqcX6UZ9SEv4Fk8bOh+lWNWtOqnNyCaLMerFEt2G70UwSjlq2
 lTeYZ6ZNUL3Jc5JytQyI0lAsbpj5/hUrTm92YXWpcUSAtxZ3RN90JgH6xAWeiHuUHdP9
 BTqmMgc2nqJj+X4AZg7F0UQ8tAv0VIimH1viH/0P1wzy/r+veQl/t3NcaYMfPf7+8rMx
 1IOLCueNj0XPOzCLMpo00uM2rFBZptjoGSMojnvbZxZSChLXjvzjxwuYxBCDTRTbAF/M Pg== 
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3wf2jtg244-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 23 Feb 2024 20:42:11 +0000
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 41NJC4sh003606;
	Fri, 23 Feb 2024 20:42:10 GMT
Received: from smtprelay06.dal12v.mail.ibm.com ([172.16.1.8])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 3wb74u8bcd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 23 Feb 2024 20:42:10 +0000
Received: from smtpav02.wdc07v.mail.ibm.com (smtpav02.wdc07v.mail.ibm.com [10.39.53.229])
	by smtprelay06.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 41NKg7f817826368
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 23 Feb 2024 20:42:10 GMT
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 827765805D;
	Fri, 23 Feb 2024 20:42:07 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C173058058;
	Fri, 23 Feb 2024 20:42:06 +0000 (GMT)
Received: from sbct-3.pok.ibm.com (unknown [9.47.158.153])
	by smtpav02.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 23 Feb 2024 20:42:06 +0000 (GMT)
From: Stefan Berger <stefanb@linux.ibm.com>
To: keyrings@vger.kernel.org, linux-crypto@vger.kernel.org,
        herbert@gondor.apana.org.au, davem@davemloft.net
Cc: linux-kernel@vger.kernel.org, saulo.alessandre@tse.jus.br,
        Stefan Berger <stefanb@linux.ibm.com>
Subject: [PATCH v3 06/10] crypte: ecc - Implement ecc_curve_get_nbits to get number of bits
Date: Fri, 23 Feb 2024 15:41:45 -0500
Message-ID: <20240223204149.4055630-7-stefanb@linux.ibm.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240223204149.4055630-1-stefanb@linux.ibm.com>
References: <20240223204149.4055630-1-stefanb@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: aR4fLJ2DNL4EC9IAtyQkzs_qz2YwYo_D
X-Proofpoint-GUID: aR4fLJ2DNL4EC9IAtyQkzs_qz2YwYo_D
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-23_06,2024-02-23_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 suspectscore=0 adultscore=0 mlxlogscore=999 lowpriorityscore=0
 malwarescore=0 spamscore=0 mlxscore=0 phishscore=0 bulkscore=0
 priorityscore=1501 clxscore=1015 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2311290000 definitions=main-2402230152

If curve->nbits is set then return this number, otherwise use
the curve->ndigits to calculate the number of bits.

Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
---
 include/crypto/internal/ecc.h | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/include/crypto/internal/ecc.h b/include/crypto/internal/ecc.h
index b8ca5023b3b5..2d321b47d0f7 100644
--- a/include/crypto/internal/ecc.h
+++ b/include/crypto/internal/ecc.h
@@ -75,6 +75,17 @@ static inline void ecc_digits_from_bytes(const u8 *in, unsigned int nbytes,
 	ecc_swap_digits(tmp, out, ndigits);
 }
 
+/**
+ * ecc_curve_get_nbits() - Get the number of bits of the curve
+ * @curve:    The curve
+ */
+static inline unsigned int ecc_curve_get_nbits(const struct ecc_curve *curve)
+{
+	if (curve->nbits)
+		return curve->nbits;
+	return curve->g.ndigits << ECC_DIGITS_TO_BYTES_SHIFT * 8;
+}
+
 /**
  * ecc_is_key_valid() - Validate a given ECDH private key
  *
-- 
2.43.0


