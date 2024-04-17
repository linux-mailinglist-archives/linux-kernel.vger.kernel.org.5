Return-Path: <linux-kernel+bounces-148899-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D57A8A88BD
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 18:22:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8EF28B21303
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 16:22:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25E7B14A635;
	Wed, 17 Apr 2024 16:21:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="iBsn0Rpi"
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C760C14884F;
	Wed, 17 Apr 2024 16:21:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713370898; cv=none; b=hUlp6yDtJmztiIyqMTmBIAQUJG6sEyiImmy9AIh0kIrBqRQT+j8RFbHzoO2KJm/UpEQq0+n3ZOAW5irvm0k8nXct4F14pIuIsTqbPD0ThELpQ3kEac0tXEYR8Its2cRndNcoKoEt6Eydy8Q42Z1ssdg7xUPA2Y0fgz+StmjiMSU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713370898; c=relaxed/simple;
	bh=uIeutVfj9uNTNjLgw8SiwHTztSjpOl7WKNWdTe9gLug=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=a0/0ZRbK9TTAvPpd2ULbQxIF1m0YByWqru7bN2qeDFyKxZMhQxymS1AJKM/5FmhrrNk6FAmq3nmANM4tWutmWBYkeqX1XLgOo+dfe5Ha21DpQiK7ZAZb58MweifYhXLfHIF3/Cf5h6ObHC0tcOE8zjtkxFnhNexiiNSIF4aCd/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=iBsn0Rpi; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353723.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 43HFu4PL016709;
	Wed, 17 Apr 2024 16:21:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=6HzX/d/NuBrwKGs8q64KDf3+lhUrvFYzLSz/MEW2Fds=;
 b=iBsn0RpiGEmQ9rwZtYtE3MDsZxjRm9KvjNb8jsJntNhpBqeL20zxWJ13hM1IvXvDmjpA
 AN7cbeUgD+ftmSpfNlewVVgwPtzNxKiOi+NfITk0Vui+6h9HQyzGltMf5XJ5fLzfZ7lr
 Nn4Sy7ClMh/bl/cbIHLdAxdfZmQUZX6/YmeFG8Wskc3pgCebrMHeh6l/RIY0zA0Vj1mF
 Jm+o+jpnw81VeirrHgvDDItqahmrq7uGQxhLNHNNwW5Yjv7vy/x9MZC9ddoMdt1Wg1Zl
 m9c8v44ytJ6YBrhq/gZwdriTckHo9CHCTiY4WHnwOYXZ74MKbDLNMEKnGC0WdMgmH/Ro WA== 
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3xjhga02b6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 17 Apr 2024 16:21:23 +0000
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 43HDAuEe011118;
	Wed, 17 Apr 2024 16:21:23 GMT
Received: from smtprelay02.dal12v.mail.ibm.com ([172.16.1.4])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 3xg732n3fe-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 17 Apr 2024 16:21:23 +0000
Received: from smtpav06.wdc07v.mail.ibm.com (smtpav06.wdc07v.mail.ibm.com [10.39.53.233])
	by smtprelay02.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 43HGLK1C45679228
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 17 Apr 2024 16:21:22 GMT
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8052B58064;
	Wed, 17 Apr 2024 16:21:20 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9B67F5803F;
	Wed, 17 Apr 2024 16:21:19 +0000 (GMT)
Received: from sbct-3.bos2.lab (unknown [9.47.158.153])
	by smtpav06.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 17 Apr 2024 16:21:19 +0000 (GMT)
From: Stefan Berger <stefanb@linux.ibm.com>
To: linux-crypto@vger.kernel.org, herbert@gondor.apana.org.au,
        davem@davemloft.net
Cc: linux-kernel@vger.kernel.org, jarkko@kernel.org, ardb@kernel.org,
        salvatore.benedetto@intel.com, git@jvdsn.com,
        Stefan Berger <stefanb@linux.ibm.com>
Subject: [PATCH v2 0/2] crypto: ecdh & ecc: Fix private key byte ordering issues
Date: Wed, 17 Apr 2024 12:21:15 -0400
Message-ID: <20240417162117.2752326-1-stefanb@linux.ibm.com>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: Mb7lbE9kuHixiyzlE53nQ9N3046sN-LP
X-Proofpoint-GUID: Mb7lbE9kuHixiyzlE53nQ9N3046sN-LP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-17_13,2024-04-16_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 phishscore=0 malwarescore=0 suspectscore=0 priorityscore=1501 bulkscore=0
 clxscore=1015 spamscore=0 mlxlogscore=931 mlxscore=0 adultscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2404010000 definitions=main-2404170113

The 1st patch fixes a byte ordering issue where ctx->private_key is
currently passed to ecc_is_key_valid but the key is in reverse byte order.
To solve this issue it introduces the variable 'priv' that is already used
throughout the ecc and ecdh code bases for a private key in proper byte
order and calls the function with 'priv'.

The 2nd patch gets rid of the 'priv' variable wherever it is used to hold
a private key (byte-swapped initialized from ctx->private_key) in proper
byte order and uses ctx->private_key directly that is now initialized in
proper byte order.

Regards,
  Stefan

v2:
  - Added missing zeroizing of priv variable (1/2)
  - Improved patch description (2/2)


Stefan Berger (2):
  crypto: ecdh - Pass private key in proper byte order to check valid
    key
  crypto: ecdh & ecc - Initialize ctx->private_key in proper byte order

 crypto/ecc.c                  | 29 ++++++++++-------------------
 crypto/ecdh.c                 |  9 ++++++---
 include/crypto/internal/ecc.h |  3 ++-
 3 files changed, 18 insertions(+), 23 deletions(-)

-- 
2.43.0


