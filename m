Return-Path: <linux-kernel+bounces-87822-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D9CDE86D981
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 03:20:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6DA1D283D03
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 02:20:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 070E13AC01;
	Fri,  1 Mar 2024 02:20:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="lfROeEDr"
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88AFF3A8C6;
	Fri,  1 Mar 2024 02:20:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709259622; cv=none; b=sR7LM/g272jicsB4V2HhHhyV/rid+vwBl/yhIF79WSR+xmcXlRdfdwhD8UdFRe7E25xjdTXzGOMOoaXnXaYBeey/55+H9gRwpy7Sj3aCbgec/p1K7zRMYw+NEB0ag8v614bUVZeqyhdO0kVlOMiwAYSiJ+bl6kulBUUjo+lCTDc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709259622; c=relaxed/simple;
	bh=F9JCCoeaCU/lTB7xcWQoFQ8Dpn+YW0NgKZAPTBFE/TU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=q01xuteF5yKpudbgHaoH/3T7ngRLpmFyuzAncVibeuuPhqRHJkxWRk6nyYC5DbIAfbHbuGBTaqPzAnX/DuDLr5f+gtOuuTv+lFT0os6i5Qnwjav64UCa+cwPiA99KHJvKk6gGyDlxUC815ZxSDXOq3eiUUSULv8cYzDuikABhBo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=lfROeEDr; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353722.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 4211vUC3023350;
	Fri, 1 Mar 2024 02:20:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=7qL62/qeeizBEmA5iVXsHGLyOkGG+/bWbPU+VDhGC8I=;
 b=lfROeEDr0w6Kh8Sxlv68FH+2YtkeAjWXEEybKFINJGk+vK7qzVWG2CySP9VztFsWW9qk
 5D2wZctslw7mf6ixVx0LZgRzkZy1hoCzBehP6A3/PpmU7wvsOPz9SgEMtTcfsT7IGCVW
 ZGFgKS6zwMVZLFMCSqP+vrgf7bQdyIIMqfTS0PEwcEvIVTTEWZTKuH2HbUcckHV8Y7qA
 otDABdMk+T48SO3hpRTcf46ycVwIvLjQOA+C67zpHTzKpDljLGQbomBywuxTsNecGFL8
 BkjXTTpp8gyHf5qlU+8i3SoVwfox1uv2T4VjqhVcTZp7/aMEzeGBP6k0WVZmSbJ/FS94 dA== 
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3wk5tergfs-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 01 Mar 2024 02:20:13 +0000
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 42108KKF008802;
	Fri, 1 Mar 2024 02:20:13 GMT
Received: from smtprelay05.dal12v.mail.ibm.com ([172.16.1.7])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 3wftsu1w68-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 01 Mar 2024 02:20:13 +0000
Received: from smtpav05.dal12v.mail.ibm.com (smtpav05.dal12v.mail.ibm.com [10.241.53.104])
	by smtprelay05.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 4212KAUg38797610
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 1 Mar 2024 02:20:12 GMT
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A8F7F58068;
	Fri,  1 Mar 2024 02:20:10 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2A1C158056;
	Fri,  1 Mar 2024 02:20:10 +0000 (GMT)
Received: from sbct-3.pok.ibm.com (unknown [9.47.158.153])
	by smtpav05.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Fri,  1 Mar 2024 02:20:10 +0000 (GMT)
From: Stefan Berger <stefanb@linux.ibm.com>
To: keyrings@vger.kernel.org, linux-crypto@vger.kernel.org,
        herbert@gondor.apana.org.au, davem@davemloft.net
Cc: linux-kernel@vger.kernel.org, saulo.alessandre@tse.jus.br, lukas@wunner.de,
        Stefan Berger <stefanb@linux.ibm.com>
Subject: [PATCH v4 02/12] crypto: ecdsa - Adjust tests on length of key parameters
Date: Thu, 29 Feb 2024 21:19:57 -0500
Message-ID: <20240301022007.344948-3-stefanb@linux.ibm.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240301022007.344948-1-stefanb@linux.ibm.com>
References: <20240301022007.344948-1-stefanb@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: sdDmLsLBbv_gBUesRd9wLXb6qvtA1_eC
X-Proofpoint-ORIG-GUID: sdDmLsLBbv_gBUesRd9wLXb6qvtA1_eC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-29_08,2024-02-29_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 phishscore=0
 mlxlogscore=999 priorityscore=1501 malwarescore=0 suspectscore=0
 mlxscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2403010018

In preparation for support of NIST P521, adjust the basic tests on the
length of the provided key parameters to only ensure that the length of the
x plus y coordinates parameter array is not an odd number and that each
coordinate fits into an array of 'ndigits' digits. Mathematical tests on
the key's parameters are then done in ecc_is_pubkey_valid_full rejecting
invalid keys.

The change is necessary since NIST P521 keys do not have keys with
coordinates that each fully require 'full' digits (= u64), unlike
NIST P192/256/384 that all require multiple 'full' digits.

Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
---
 crypto/ecdsa.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/crypto/ecdsa.c b/crypto/ecdsa.c
index 6653dec17327..64e1e69d53ba 100644
--- a/crypto/ecdsa.c
+++ b/crypto/ecdsa.c
@@ -230,7 +230,7 @@ static int ecdsa_set_pub_key(struct crypto_akcipher *tfm, const void *key, unsig
 	if (ret < 0)
 		return ret;
 
-	if (keylen < 1 || (((keylen - 1) >> 1) % sizeof(u64)) != 0)
+	if (keylen < 1 || ((keylen - 1) & 1) != 0)
 		return -EINVAL;
 	/* we only accept uncompressed format indicated by '4' */
 	if (d[0] != 4)
-- 
2.43.0


