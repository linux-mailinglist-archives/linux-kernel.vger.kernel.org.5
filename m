Return-Path: <linux-kernel+bounces-79121-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C8C6861DD6
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 21:43:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 36334288DFD
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 20:43:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1356914DFCF;
	Fri, 23 Feb 2024 20:42:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="ImoeRBpk"
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C06DE14CAA6;
	Fri, 23 Feb 2024 20:42:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708720938; cv=none; b=PWzbKNpUfJZYl3SFDQG/xeOGhZutGyBP+6eEXQsrtAx/eIzN3UJ+e5i60JN8KPGdjDW9o67Qv83Q6Rw5xGcpgLiu0Zq0UWqC8/WBDDXLIvJyeTSS6+Wcv805fkuOmMSfQD7+c8qpHJptLVQZAlOvQi3DRLznESiogHpUSmvqaNo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708720938; c=relaxed/simple;
	bh=Q3P/xX5ulSDqYkwQhOykf8ynjRUvhz+oYuiqRNE6Y9A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=prvJVL+vui/2aBNdVeuJwAWF3SVTXoDqN2AqQbzlbb5EeXl2qbVQP3VhFKzwdYqgDPZGVlPT+/b55IMZZsT3/T1QLS9HAJKOYibFWsaztOOZ5oPH4ofV77ik16ur08nQVCfDHhZUszUAlHe7d1gqT+8ncsTVBFnTiZeolp65h3Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=ImoeRBpk; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353723.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 41NK1Wmq010645;
	Fri, 23 Feb 2024 20:42:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=ih8H+9rSJovCi3/ukRlt9OvwFu3iw9Ty9KcWfNmJnpw=;
 b=ImoeRBpk3e4kRjFUSIQ7jUEFigyDL87ySKOCJ9rzCaZCGStF827yVlhlBg/7XyE/aUfm
 q/WO1s5iKtupE5CzOP3mBp9651urmM/CQO/6gAPYus5BHUWnWTLxncCNwPyL7OeG8yt/
 QdkgF5KtlW8I6/S2V+cRLK0PQ2TEy5bsMdP6/82/xKkBsOS1yED5ZBO6xoNjw3QnUu7D
 fp7yrsV2tXDCMeMuLvibeVqI0q8sZYBOJeAx/mroY+JqF02JK5P0d5HECGpWZIsJpVGg
 nYUIZnQmj5YpZffOlq8pkz+NO91Sd/Je2FbjMQ4gygGYiFsKE0mOnOPLibaNBY2ZZVku Yg== 
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3wf1rssdhh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 23 Feb 2024 20:42:10 +0000
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 41NIUiBA003671;
	Fri, 23 Feb 2024 20:42:09 GMT
Received: from smtprelay05.dal12v.mail.ibm.com ([172.16.1.7])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 3wb74u8bc8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 23 Feb 2024 20:42:09 +0000
Received: from smtpav02.wdc07v.mail.ibm.com (smtpav02.wdc07v.mail.ibm.com [10.39.53.229])
	by smtprelay05.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 41NKg65J22545048
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 23 Feb 2024 20:42:09 GMT
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9C54758059;
	Fri, 23 Feb 2024 20:42:06 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id DAA7A58058;
	Fri, 23 Feb 2024 20:42:05 +0000 (GMT)
Received: from sbct-3.pok.ibm.com (unknown [9.47.158.153])
	by smtpav02.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 23 Feb 2024 20:42:05 +0000 (GMT)
From: Stefan Berger <stefanb@linux.ibm.com>
To: keyrings@vger.kernel.org, linux-crypto@vger.kernel.org,
        herbert@gondor.apana.org.au, davem@davemloft.net
Cc: linux-kernel@vger.kernel.org, saulo.alessandre@tse.jus.br,
        Stefan Berger <stefanb@linux.ibm.com>
Subject: [PATCH v3 05/10] crypto: ecc - Add nbits field to ecc_curve structure
Date: Fri, 23 Feb 2024 15:41:44 -0500
Message-ID: <20240223204149.4055630-6-stefanb@linux.ibm.com>
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
X-Proofpoint-GUID: QVYOUD45-EKmdIUN3ldLtCStONgxabdI
X-Proofpoint-ORIG-GUID: QVYOUD45-EKmdIUN3ldLtCStONgxabdI
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-23_06,2024-02-23_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 clxscore=1015
 lowpriorityscore=0 malwarescore=0 suspectscore=0 bulkscore=0 adultscore=0
 impostorscore=0 spamscore=0 phishscore=0 mlxlogscore=999
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2402230152

Add the number of bits a curve has to the ecc_curve definition. This field
only needs to be set for curves that don't fill up all bytes in their
digits, such as NIST P521 which has only 9 bits in the most significant
digit. This field will be used to determine the number of bytes a curve
requires for its key coordinates for example.

Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
---
 include/crypto/ecc_curve.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/include/crypto/ecc_curve.h b/include/crypto/ecc_curve.h
index 70964781eb68..337a44956926 100644
--- a/include/crypto/ecc_curve.h
+++ b/include/crypto/ecc_curve.h
@@ -23,6 +23,8 @@ struct ecc_point {
  * struct ecc_curve - definition of elliptic curve
  *
  * @name:	Short name of the curve.
+ * @nbits:      Curves that do not use all bits in their ndigits must specify
+ *              their number of bits here, otherwise can leave at 0.
  * @g:		Generator point of the curve.
  * @p:		Prime number, if Barrett's reduction is used for this curve
  *		pre-calculated value 'mu' is appended to the @p after ndigits.
@@ -34,6 +36,7 @@ struct ecc_point {
  */
 struct ecc_curve {
 	char *name;
+	unsigned int nbits;
 	struct ecc_point g;
 	u64 *p;
 	u64 *n;
-- 
2.43.0


