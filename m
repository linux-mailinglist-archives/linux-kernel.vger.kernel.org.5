Return-Path: <linux-kernel+bounces-79122-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E2BB1861DD9
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 21:43:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 807871F2321D
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 20:43:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D8BE14DFF4;
	Fri, 23 Feb 2024 20:42:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="K+TP2FLo"
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A72514CADB;
	Fri, 23 Feb 2024 20:42:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708720939; cv=none; b=hJiBLi0ceY3lGWSwHtVPNnzDgvO/HcRYnQ/jvYl7puDCr3t2Nc4PCDR1IL0nOinYNJ9JXvdDI8IgALj6wd0cFR2SxKpYfvqoTSofHGkt37YexIbNJec416c7zYYYG8SzG9VLPHNrqHp59ZpN/q6f3ud6qEvq9oP161tm3BT7tp8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708720939; c=relaxed/simple;
	bh=VyGpzJ2Apfi7OJFpsrTnANVwRfTsjtwbsJB32LdWs/w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=D3YWwQuMuwXslBzuOGc1RgR+z7ewASIiDNR+sWV8Wv/2TTqQGPWADog7AAGXYg0cWapTBpvfGygE+uZt8D/swAFRbPbi+A/evqjZs43BXDbVvGMOfcE/q8ri4STUjsGU6f+uX62D5V+FV//RuDXKeV8ZuhE17yHePjs6AA9cCoE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=K+TP2FLo; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353724.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 41NJuJPw012664;
	Fri, 23 Feb 2024 20:42:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=ndbKGG5Drn/6JPqaWaRGmEPsgAKjD1PPC3m5kAjaLlo=;
 b=K+TP2FLos9OOKPjyzA5ZMqUQBJBgPhRZURGfkcXwZu6y2zFt1PyvnPcL4rI9r3zzVpIi
 s2bJSpNpkZpGRyHJTTJXSfuwME3NfIJIhVZclf5S527crkScL8eKTnm9Iax+pmNyPig8
 nzudl1N2u9nCXiqUApcTf4Rbf2lR2oJ+6pEAYr59a2RRlUPAwG+s+FIeAxlJKC5omAKD
 RdMRp5md6TbnQAVGMgAjdN9ybPCIW9kILHQ7CihQDD+9z5kU3HXHCgCM6NUpOdoEw0qi
 xhkUKQWqCqcGJmWj8S5jcnJGofI3+21WRcotD4XDOBQbTjVSipVYeTP0YtOCZBYA3AZ3 GA== 
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3wf0nnjgk3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 23 Feb 2024 20:42:12 +0000
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 41NJWTo7017307;
	Fri, 23 Feb 2024 20:42:11 GMT
Received: from smtprelay07.dal12v.mail.ibm.com ([172.16.1.9])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3wb8mmywdr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 23 Feb 2024 20:42:11 +0000
Received: from smtpav02.wdc07v.mail.ibm.com (smtpav02.wdc07v.mail.ibm.com [10.39.53.229])
	by smtprelay07.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 41NKg83U51642954
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 23 Feb 2024 20:42:10 GMT
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7115A5805E;
	Fri, 23 Feb 2024 20:42:08 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A7CA558060;
	Fri, 23 Feb 2024 20:42:07 +0000 (GMT)
Received: from sbct-3.pok.ibm.com (unknown [9.47.158.153])
	by smtpav02.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 23 Feb 2024 20:42:07 +0000 (GMT)
From: Stefan Berger <stefanb@linux.ibm.com>
To: keyrings@vger.kernel.org, linux-crypto@vger.kernel.org,
        herbert@gondor.apana.org.au, davem@davemloft.net
Cc: linux-kernel@vger.kernel.org, saulo.alessandre@tse.jus.br,
        Stefan Berger <stefanb@linux.ibm.com>
Subject: [PATCH v3 07/10] crypto: ecc - Use ecc_get_curve_nbits to get number of bits for NIST P521
Date: Fri, 23 Feb 2024 15:41:46 -0500
Message-ID: <20240223204149.4055630-8-stefanb@linux.ibm.com>
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
X-Proofpoint-ORIG-GUID: tjMsVDQT70F_h3rPq5ywxj7Ev8xIila9
X-Proofpoint-GUID: tjMsVDQT70F_h3rPq5ywxj7Ev8xIila9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-23_06,2024-02-23_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 malwarescore=0
 bulkscore=0 impostorscore=0 adultscore=0 clxscore=1015 suspectscore=0
 mlxlogscore=999 lowpriorityscore=0 phishscore=0 priorityscore=1501
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2402230152

In ecc_point_mult query for the number of bits when using NIST P521 and
add '2'. The change is required specifically for NIST P521 to pass
mathematical tests on the public key.

Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
---
 crypto/ecc.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/crypto/ecc.c b/crypto/ecc.c
index ea7b28b5e00e..89ad45cf2404 100644
--- a/crypto/ecc.c
+++ b/crypto/ecc.c
@@ -1326,7 +1326,10 @@ static void ecc_point_mult(struct ecc_point *result,
 	carry = vli_add(sk[0], scalar, curve->n, ndigits);
 	vli_add(sk[1], sk[0], curve->n, ndigits);
 	scalar = sk[!carry];
-	num_bits = sizeof(u64) * ndigits * 8 + 1;
+	if (ndigits == 9 && !strcmp(curve->name, "nist_521"))
+		num_bits = ecc_curve_get_nbits(curve) + 2;
+	else
+		num_bits = sizeof(u64) * ndigits * 8 + 1;
 
 	vli_set(rx[1], point->x, ndigits);
 	vli_set(ry[1], point->y, ndigits);
-- 
2.43.0


