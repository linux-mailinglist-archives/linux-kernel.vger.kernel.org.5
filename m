Return-Path: <linux-kernel+bounces-58772-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A92A984EB87
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 23:19:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DB8D71C23889
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 22:19:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72EEA50245;
	Thu,  8 Feb 2024 22:19:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="cSypwtMG"
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E89A4F613;
	Thu,  8 Feb 2024 22:19:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707430750; cv=none; b=WpUUtuzfZ2k1rkeFnUPczSrRSIHytp93HtnEpJOoGG9B0Rk8CdUuXRcuz9Q0DtUKQNRebydrBtAyE47nAR4tDdOfE5/akSgATVQ4ceSgyneeIcYIkeybHAJZKKum/MkCFRfRvZCbO5nKeY4ivYs3ugf9xsdACpasDrSrL4iB5pA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707430750; c=relaxed/simple;
	bh=nAYVa9pxoqQmYy/Bk2N/qqYRm4vdYQo8iqHKLiqBZ5U=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ECkkKaaGgjg7/pz7mlqf/JmNfat2Nw7GEYWTRE/CTwJ3kJ5dDS8/fOc6lKaF4uFFpiHJ+LLemuM1evfYRyTea7TeArai3Sp3RVLnqXKvx8c8Cac1gq1Q7cb9qPZ8EnWueAtZwetDct90JU0dpjTJswL+X82zFM6neP7Qno/LWWw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=cSypwtMG; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353726.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 418LRkIL020638;
	Thu, 8 Feb 2024 22:19:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=CTNubrTEG1irrv13ovrANfb/av+GhWeRdPgIA7A8O2E=;
 b=cSypwtMGcZFgWNqbpYw/xWz3WnrLUM27EkBj/iX70jRkJhoVKN08ekrdeN7AfP37oAXP
 D1IvpP4SICgZBlBaqsgqEXQmRsfZKwehL35BTB3iUnH6cfz4Xe8RU4MCNRid6fM2to6p
 +pJYWJh96vW/PdPkn+jqe/PA5fPq8AoK72QDesTOO5rtAN2ahDhA7WfokgMv5q2RtkVd
 RzSTKVQm4l/8IvC2av2b9elOCjOzldigCgVdutwGcFTmn/Pb/kw9A5yB/WF3Bp/XUIAs
 /yhv94y3/Al4MhwJ7+sS9vsvj6D/BP5SK3JUJPgS/NCwcu25PKZToyFSqznXjIhd7qis 3A== 
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3w56vsry7d-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 08 Feb 2024 22:19:02 +0000
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 418LWPU9008487;
	Thu, 8 Feb 2024 22:19:01 GMT
Received: from smtprelay02.wdc07v.mail.ibm.com ([172.16.1.69])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 3w221kf5da-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 08 Feb 2024 22:19:01 +0000
Received: from smtpav03.dal12v.mail.ibm.com (smtpav03.dal12v.mail.ibm.com [10.241.53.102])
	by smtprelay02.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 418MJ0SQ13304408
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 8 Feb 2024 22:19:00 GMT
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 31F9158056;
	Thu,  8 Feb 2024 22:19:00 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id BCE6B5803F;
	Thu,  8 Feb 2024 22:18:59 +0000 (GMT)
Received: from sbct-3.pok.ibm.com (unknown [9.47.158.153])
	by smtpav03.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Thu,  8 Feb 2024 22:18:59 +0000 (GMT)
From: Stefan Berger <stefanb@linux.ibm.com>
To: keyrings@vger.kernel.org, linux-crypto@vger.kernel.org,
        herbert@gondor.apana.org.au, davem@davemloft.net
Cc: linux-kernel@vger.kernel.org, saulo.alessandre@tse.jus.br,
        Stefan Berger <stefanb@linux.ibm.com>
Subject: [PATCH 00/14] Add support for NIST P521 to ecdsa and ecdh
Date: Thu,  8 Feb 2024 17:18:26 -0500
Message-ID: <20240208221840.3665874-1-stefanb@linux.ibm.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: st8TvVA8tEDC7MAWsl8ybJqSngb9GJx4
X-Proofpoint-GUID: st8TvVA8tEDC7MAWsl8ybJqSngb9GJx4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-08_11,2024-02-08_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 impostorscore=0 bulkscore=0 suspectscore=0 phishscore=0 spamscore=0
 lowpriorityscore=0 adultscore=0 clxscore=1011 mlxscore=0 mlxlogscore=702
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2402080124

This series of patches adds support for NIST P521 curve to ecdsa and
ecdh. Test cases are added to both modules.

An issue with the current code in ecdsa and ecdh is that it assumes that
input arrays providing key coordinates for example are arrays of digits
(a 'digit' is a 'u64'). This works well for existing curves, such as
NIST P192/256/384, but does not work for NIST P521 where coordinates
are 8 digits + 2 bytes long. So some of the changes deal with converting
byte arrays to digits and digits to byte array.

Regards,
   Stefan

Stefan Berger (14):
  crypto: ecdsa - Convert byte arrays with key coordinates to digits
  crypto: ecdsa - Adjust tests on length of key material
  crypto: ecdsa - Adjust res.x mod n for NIST P521
  crypto: ecc - Implement vli_mmod_fast_521 for NIST p521
  crypto: ecc - For NIST P521 use vli_num_bits to get number of bits
  crypto: ecc - Add NIST P521 curve parameters
  crypto: ecdsa - Register NIST P521 and extend test suite
  x509: Add OID for NIST P521 and extend parser for it
  crypto: ecdh - Use properly formatted digits to check for valid key
  crypto: ecc - Implement ecc_digits_to_array to convert digits to byte
    array
  crypto: Add nbits field to ecc_curve structure
  crypto: ecc - Implement and use ecc_curve_get_nbytes to get curve's
    nbytes
  crypto: ecdh - Use functions to copy digits from and to array
  crypto: ecdh - Add support for NIST P521 and add test case

 crypto/asymmetric_keys/x509_cert_parser.c |   3 +
 crypto/ecc.c                              |  71 +++++--
 crypto/ecc_curve_defs.h                   |  45 +++++
 crypto/ecdh.c                             |  59 +++++-
 crypto/ecdsa.c                            |  51 ++++-
 crypto/testmgr.c                          |  14 ++
 crypto/testmgr.h                          | 225 ++++++++++++++++++++++
 include/crypto/ecc_curve.h                |   3 +
 include/crypto/ecdh.h                     |   1 +
 include/crypto/internal/ecc.h             |  61 +++++-
 include/linux/oid_registry.h              |   1 +
 11 files changed, 497 insertions(+), 37 deletions(-)

-- 
2.43.0


