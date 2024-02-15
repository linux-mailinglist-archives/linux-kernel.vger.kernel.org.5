Return-Path: <linux-kernel+bounces-67810-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A725185715A
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 00:17:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 422181F21118
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 23:17:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52185148FE1;
	Thu, 15 Feb 2024 23:14:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="GCabvGSt"
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1A87145340;
	Thu, 15 Feb 2024 23:14:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708038880; cv=none; b=kGK1r+GVAyYd4Dz/dju6K8s7Wpgb9OI1VlT/WPv4xxYhaZalYDfdhM4RpADglvlwGD4acI5V7lfcHi9eoIktgTqu5y6sn4Bo+4SXAGMjI/NFiJL56EK2hVLsuX4NG0eemeilPYVlqoYCdVSOUvUt4pIxWjy+HJPH/NRig0RRIK0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708038880; c=relaxed/simple;
	bh=4gmnt0N+ElRQcbrv32rTMnC0LI2f7oMrwo91K3z9nhY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qL9SIb8ALREVdkfcq3GOTHqXgnBJxA0A699Q1quzsO+8Zt2CQVSTdr/ezVh9FkYy4TaHPjXSd6RRXhnNWxLQSeTeOcN8rT4IyFjk8rGJr+2l20tWYmNIPrnTIQzkaK1ps0GX/6BcRTmR5cRiRhwN7upBazKb2U42xw1lDZQ4D8c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=GCabvGSt; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353727.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 41FMQV7h004908;
	Thu, 15 Feb 2024 23:14:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=MinIzDKfCKQy6B0slQpidM9BwLl++KcE0MImdVgZ1ZI=;
 b=GCabvGStxnUyUHLASCWPT6P/DZIgj/VmgpLR0keqS0hw34z561dq4Jtre994N66OGewv
 V2IU7n10rA9XpcfS+4Ehq/3R1JEzj1N/iTrASkkOTUrzgm9IULkEY6iMayNHXMTVPAlI
 wqObly0L8ByU7Yd/g3I+o+MONb/OY8KVRSkZ3N616N0UGKCdVsOC/IXh8xKiksafWK8q
 Br1szEzwjFPR8iAV6a54xZuAH2wBmEptjz8FbZMrmT5qvtC1OtZb6X/4k/TqKrFZrDIp
 AmOfCT6VZYvr8L5Nmo1AFCKqXeO71EhwDErGVO0NZs9IQaJo8g738Y1szs1PIa0wrvlI 4g== 
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3w9u52a565-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 15 Feb 2024 23:14:33 +0000
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 41FLuPM4004258;
	Thu, 15 Feb 2024 23:14:32 GMT
Received: from smtprelay06.dal12v.mail.ibm.com ([172.16.1.8])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3w6kv0r3pn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 15 Feb 2024 23:14:32 +0000
Received: from smtpav04.wdc07v.mail.ibm.com (smtpav04.wdc07v.mail.ibm.com [10.39.53.231])
	by smtprelay06.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 41FNETLn6357966
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 15 Feb 2024 23:14:31 GMT
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7FBB158061;
	Thu, 15 Feb 2024 23:14:29 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id CF3E158050;
	Thu, 15 Feb 2024 23:14:28 +0000 (GMT)
Received: from sbct-3.pok.ibm.com (unknown [9.47.158.153])
	by smtpav04.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 15 Feb 2024 23:14:28 +0000 (GMT)
From: Stefan Berger <stefanb@linux.ibm.com>
To: keyrings@vger.kernel.org, linux-crypto@vger.kernel.org,
        herbert@gondor.apana.org.au, davem@davemloft.net
Cc: linux-kernel@vger.kernel.org, saulo.alessandre@tse.jus.br,
        Stefan Berger <stefanb@linux.ibm.com>
Subject: [PATCH v2 11/14] crypto: Add nbits field to ecc_curve structure
Date: Thu, 15 Feb 2024 18:14:10 -0500
Message-ID: <20240215231414.3857320-12-stefanb@linux.ibm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240215231414.3857320-1-stefanb@linux.ibm.com>
References: <20240215231414.3857320-1-stefanb@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: CsLwuN1bCkc0LPLu-6Og_En6AG20EVR2
X-Proofpoint-GUID: CsLwuN1bCkc0LPLu-6Og_En6AG20EVR2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-15_22,2024-02-14_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 bulkscore=0
 mlxlogscore=945 impostorscore=0 mlxscore=0 clxscore=1015 malwarescore=0
 priorityscore=1501 lowpriorityscore=0 phishscore=0 adultscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2402150181

Add the number of bits a curve has to the ecc_curve definition. This field
only needs to be set for curves that don't fill up all bytes in their
digits, such as NIST P521 which has only 9 bits in the most significant
digit. This field will be used to determine the number of bytes a curve
requires for its key coordinates for example.

Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
---
 crypto/ecc_curve_defs.h    | 1 +
 include/crypto/ecc_curve.h | 3 +++
 2 files changed, 4 insertions(+)

diff --git a/crypto/ecc_curve_defs.h b/crypto/ecc_curve_defs.h
index 93a47a5d460a..09a221657c31 100644
--- a/crypto/ecc_curve_defs.h
+++ b/crypto/ecc_curve_defs.h
@@ -119,6 +119,7 @@ static u64 nist_p521_b[] = { 0xef451fd46b503f00ull, 0x3573df883d2c34f1ull,
 				0x051ull };
 static struct ecc_curve nist_p521 = {
 	.name = "nist_521",
+	.nbits = 521,
 	.g = {
 		.x = nist_p521_g_x,
 		.y = nist_p521_g_y,
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


