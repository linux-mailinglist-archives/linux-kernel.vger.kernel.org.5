Return-Path: <linux-kernel+bounces-108876-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C16B881141
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 12:48:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BC8B61C2288D
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 11:48:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3ED2841E22;
	Wed, 20 Mar 2024 11:48:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="RXQZBAkU"
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C51843FB3F;
	Wed, 20 Mar 2024 11:48:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710935284; cv=none; b=IgDrsACUwLtVLJzS2uqnsAbNORXu67ICghIKtYPCSc+FyCf4oIe5fcafmjDWNFWn/qZ9Qgv+/7daHd8tFbuPcc3AyHuqWXmvXRhUFCf/LEUL7khXbIcXtqZfN7q4PlUboO/pV53JVzUuK3XXnuv8M+0ZM7e3i75u0bxd7VeV3/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710935284; c=relaxed/simple;
	bh=0LJAbvCt4Qe8ibvb9FfoDYCrZXlHL0jJfNNPGsH/M7Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=niKhjK1QQ/01xkBY74QNUQOPN/MNhi/m/0xgT8dO0DHsK6NBZkH5tnNVSK+53nGmt8IICd8r8+cONeU9xvzUmvpByMiH3anCpoqn5TzdRd4E7DPlrrCrg+jb3LTxLKVDHytAKiWuOaNMk61fHEVTsNuwW8pQhwXvmkxgEVMjkGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=RXQZBAkU; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 42KBhddq018278;
	Wed, 20 Mar 2024 11:47:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=uA2p9mSk0L1ZpsS7jxFDbrW8SRhpWN+F0J8POcJbgVA=;
 b=RXQZBAkU6g/ymvBsdTaUC0/iI8+pnN9PPr4bHUg/6Xcp0YzAziVosHE3W5u1R/Y8d42v
 HdqRksvt1n2X+F/UXIJMYvDu0jFphcC4c98plWle0cFDi6S11CmWteSbKTDdahYw0bPZ
 5k/+UBg/WbwWuWEti8tyGQ8jrwi/77KxYIbZxSdML9AFg8Crg+r5K203di0oCtksDrJr
 1KYBHNhYlU5hF+Di1016t+Zk8HMgzIwoZradwoubVoH/DgBxt4lnzmDxjqQh8gJK8KH1
 TziLE5LrA2cVTuInsm3zO9iQo9tSxEn9FsTbXkZiy4NNFhVYb0i7Jj6NvO16ZUBnw7ih cg== 
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3wyy5f00c9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 20 Mar 2024 11:47:51 +0000
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 42KA1GuD002799;
	Wed, 20 Mar 2024 11:47:50 GMT
Received: from smtprelay01.wdc07v.mail.ibm.com ([172.16.1.68])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 3wwrf2nk32-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 20 Mar 2024 11:47:50 +0000
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com [10.241.53.100])
	by smtprelay01.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 42KBllSM46334510
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 20 Mar 2024 11:47:49 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 58BC858067;
	Wed, 20 Mar 2024 11:47:47 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B330F58057;
	Wed, 20 Mar 2024 11:47:46 +0000 (GMT)
Received: from sbct-3.pok.ibm.com (unknown [9.47.158.153])
	by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 20 Mar 2024 11:47:46 +0000 (GMT)
From: Stefan Berger <stefanb@linux.ibm.com>
To: keyrings@vger.kernel.org, linux-crypto@vger.kernel.org,
        herbert@gondor.apana.org.au, davem@davemloft.net
Cc: linux-kernel@vger.kernel.org, saulo.alessandre@tse.jus.br, lukas@wunner.de,
        bbhushan2@marvell.com, jarkko@kernel.org,
        Stefan Berger <stefanb@linux.ibm.com>
Subject: [PATCH v7 03/13] crypto: ecdsa - Adjust tests on length of key parameters
Date: Wed, 20 Mar 2024 07:47:15 -0400
Message-ID: <20240320114725.1644921-4-stefanb@linux.ibm.com>
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
X-Proofpoint-GUID: L9mTeHBF4o9MMywG9kEw2TfNMrGcYHdr
X-Proofpoint-ORIG-GUID: L9mTeHBF4o9MMywG9kEw2TfNMrGcYHdr
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-20_08,2024-03-18_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 lowpriorityscore=0 mlxlogscore=999 malwarescore=0 bulkscore=0 phishscore=0
 mlxscore=0 clxscore=1015 adultscore=0 suspectscore=0 impostorscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2403140000 definitions=main-2403200093

In preparation for support of NIST P521, adjust the basic tests on the
length of the provided key parameters to only ensure that the length of the
x plus y coordinates parameter array is not an odd number and that each
coordinate fits into an array of 'ndigits' digits. Mathematical tests on
the key's parameters are then done in ecc_is_pubkey_valid_full rejecting
invalid keys.

The change is necessary since NIST P521 keys do not have keys with
coordinates that each require 'full' digits (= all bits in u64 used).
NIST P521 only requires 2 bytes (9 bits) in the most significant digit
unlike NIST P192/256/384 that each require multiple 'full' digits.

Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
Tested-by: Lukas Wunner <lukas@wunner.de>
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


