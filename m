Return-Path: <linux-kernel+bounces-94653-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 229EE8742B6
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 23:25:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B61AD1F23FF4
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 22:25:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CCED1BDCE;
	Wed,  6 Mar 2024 22:25:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="qBdc/fx+"
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 084D71B809;
	Wed,  6 Mar 2024 22:25:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709763913; cv=none; b=JV3I+myOqIOTDyRfMcBBpQRRKHCgecVThCgLrflrgfsCWNaqoMTD+YXt+CqpBaCaiAO3I8kN4K7wgTvtJh4i5UIM1EGgatsaSwGhJD6qp//kYoYu6qct5FPQQZ3zEpK0sySNMemr6sWKoGN6I+VzZp8CtxtPaaK5xF2/nKNH1Hs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709763913; c=relaxed/simple;
	bh=9O4Q6AopkEImG7xOhuAvLXHunxmfl4a9lwCGOZmu+ms=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jnHhshDWujdqjkwFNmMdixsyS4+xiqBqMRe1rXEBMwUSt+Vm4TX9KMDuQ0I1nlZmq8x+8/CLjNwfDtP7qMrSJ2kWjMB976yKJS4kSstYrNX6Vt6g+qI1eCXXhwqHYpSn53aku6311K2hrMaESWKLE49Eaf1KHuuPUs6m7f8x/CM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=qBdc/fx+; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 426LvON4000444;
	Wed, 6 Mar 2024 22:25:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=OCSv8QXvUSPZx8ChqztdULxoVFVwLzW7z8k5sb6QxP0=;
 b=qBdc/fx+7A/q8xbKNDtBaEDSb53Qt11sOeXVUdyeG5wutfF9N6ejKpTE3bw8ggmps7lE
 2PIFY3AeRbT0RXXob9uuAVUMuFJaiojTUVoJzIu2QE3Os+/vAC+Nas4U59/IV6WMcODR
 wLXccGTOU+qaN3TMVBfPuP7TBt/EvRpjJ2LqTtAFNzDcd2IUjmcuTowzrBs+fJYJp0TP
 NuuJ9nTKjMJ8wyeYwR8w4a2Z/XZV3H8wIkcZkhCbAPTJvEiP0VCSNWvef80IWribMIAx
 NiQkx3PntbLwxXEJefsIc3TozllPAGHOXuICeXkkCFMM6uzlB4msGSNVMkLJm6PFAvvH Rg== 
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3wq0utrfx8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 06 Mar 2024 22:25:04 +0000
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 426LbgGw026183;
	Wed, 6 Mar 2024 22:23:09 GMT
Received: from smtprelay03.wdc07v.mail.ibm.com ([172.16.1.70])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3wmfep1nq4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 06 Mar 2024 22:23:09 +0000
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com [10.241.53.100])
	by smtprelay03.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 426MN7Sn39649610
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 6 Mar 2024 22:23:09 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 15DA758064;
	Wed,  6 Mar 2024 22:23:07 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8D4E858063;
	Wed,  6 Mar 2024 22:23:06 +0000 (GMT)
Received: from sbct-3.pok.ibm.com (unknown [9.47.158.153])
	by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Wed,  6 Mar 2024 22:23:06 +0000 (GMT)
From: Stefan Berger <stefanb@linux.ibm.com>
To: keyrings@vger.kernel.org, linux-crypto@vger.kernel.org,
        herbert@gondor.apana.org.au, davem@davemloft.net
Cc: linux-kernel@vger.kernel.org, saulo.alessandre@tse.jus.br, lukas@wunner.de,
        Stefan Berger <stefanb@linux.ibm.com>
Subject: [PATCH v5 08/12] crypto: ecdsa - Replace ndigits with nbits where precision is needed
Date: Wed,  6 Mar 2024 17:22:53 -0500
Message-ID: <20240306222257.979304-9-stefanb@linux.ibm.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240306222257.979304-1-stefanb@linux.ibm.com>
References: <20240306222257.979304-1-stefanb@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: YhasPFFJUYkMhmw6WVQezt3A1-VldAAq
X-Proofpoint-ORIG-GUID: YhasPFFJUYkMhmw6WVQezt3A1-VldAAq
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-06_12,2024-03-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 priorityscore=1501 mlxscore=0 mlxlogscore=999 bulkscore=0
 lowpriorityscore=0 adultscore=0 malwarescore=0 spamscore=0 clxscore=1015
 phishscore=0 suspectscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2311290000 definitions=main-2403060181

Replace the usage of ndigits with nbits where more precise space
calculations are needed, such as in ecdsa_max_size where the length of a
coordinate is determined.

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


