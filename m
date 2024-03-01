Return-Path: <linux-kernel+bounces-87833-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E775686D99E
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 03:22:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 81A27283C68
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 02:22:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 775BC3D3B3;
	Fri,  1 Mar 2024 02:20:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="aCJGGgGh"
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 935CE3B1B7;
	Fri,  1 Mar 2024 02:20:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709259625; cv=none; b=K/IAI6xGQcboZwHj1Sy3q7CLYatswj57cJ0880+vJE48GuJZtT7F343eBKzrW4bXxkYOiuHnaxeZ4mSiGWlMuARwCCr4jMB2bhe0TBMgL8QiYQDaxvgLNgJ7UVXpLPnktTvJWY1+SUr+PnvX1KIbCpCH/y0Llxd4KQRDJ+WP5/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709259625; c=relaxed/simple;
	bh=CLARtP2DQJAVQ0De+jgJ+swpoDvVcBFDP0cS0U0AByc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mLZY9BQNvLXhhQo7aQT69gMBPv5GO98OOXSp/3tdlM/O9ou5C7qI4kV+ibsJZeYJYhdwW8Sw1B9XiqDzlqMm+v2z1lsVIeaXIEmPJBjrF+MFa+/RyAHrM24mVzdhxGdHdTawqqXiXUQqnJoyjsnUOD1PhS9tm41rLdufkITS1y0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=aCJGGgGh; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 4211p8XZ026967;
	Fri, 1 Mar 2024 02:20:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=WscJRectOOpbFSdEkRLSkxTx5f/ng+ZZJOEX2Ey0I9k=;
 b=aCJGGgGhomFIRs5vnjZajZrs2GiZpNtdE0rdX5URuLzetGIEhf0I1HgRwCJ5KvFlyT2c
 f3fEUGlJ+YzmhqE78aGRoxbYlCyprCTs77lvFQExx2UY1nIouMwaKPI5YcESwJ3o/9MZ
 GV8WIQ7Lwk2rRnpG+BRoM4QOoIsY7et6yRT81Sw2dGWeR7w6nRow+FDEiMVeGQEi+wxw
 V0v4AxFzTL+nLfc4ef9RAwZtWQIhX2HJ+gcxMVUd2KSfJApRtAi5+7nx6xNN/W+uohjk
 iTVhAnD3wE+0lAwFmXbRVSG2vwjfYI6Eshx9taqy7/4MR9vh4S9KzXIYNRMhSbxuWUxZ Rg== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3wk57h1dqj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 01 Mar 2024 02:20:20 +0000
Received: from m0356517.ppops.net (m0356517.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 4211xX2N017290;
	Fri, 1 Mar 2024 02:20:20 GMT
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3wk57h1dpf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 01 Mar 2024 02:20:20 +0000
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 41TNwnoF008827;
	Fri, 1 Mar 2024 02:20:19 GMT
Received: from smtprelay02.dal12v.mail.ibm.com ([172.16.1.4])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 3wftsu1w70-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 01 Mar 2024 02:20:19 +0000
Received: from smtpav05.dal12v.mail.ibm.com (smtpav05.dal12v.mail.ibm.com [10.241.53.104])
	by smtprelay02.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 4212KGVb44564750
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 1 Mar 2024 02:20:18 GMT
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9360A58056;
	Fri,  1 Mar 2024 02:20:16 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 12ED25805D;
	Fri,  1 Mar 2024 02:20:16 +0000 (GMT)
Received: from sbct-3.pok.ibm.com (unknown [9.47.158.153])
	by smtpav05.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Fri,  1 Mar 2024 02:20:15 +0000 (GMT)
From: Stefan Berger <stefanb@linux.ibm.com>
To: keyrings@vger.kernel.org, linux-crypto@vger.kernel.org,
        herbert@gondor.apana.org.au, davem@davemloft.net
Cc: linux-kernel@vger.kernel.org, saulo.alessandre@tse.jus.br, lukas@wunner.de,
        Stefan Berger <stefanb@linux.ibm.com>,
        David Howells <dhowells@redhat.com>
Subject: [PATCH v4 12/12] crypto: x509 - Add OID for NIST P521 and extend parser for it
Date: Thu, 29 Feb 2024 21:20:07 -0500
Message-ID: <20240301022007.344948-13-stefanb@linux.ibm.com>
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
X-Proofpoint-GUID: mRs7XMb-K63HGuk60utCdVeXCnhE_hbV
X-Proofpoint-ORIG-GUID: bJt5Y1aNDD82emL5h9ejwVh6ZmBYPFfg
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-29_08,2024-02-29_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 lowpriorityscore=0 mlxscore=0 adultscore=0 spamscore=0 phishscore=0
 priorityscore=1501 impostorscore=0 mlxlogscore=977 clxscore=1015
 bulkscore=0 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2403010018

Enable the x509 parser to accept NIST P521 certificates and add the
OID for ansip521r1, which is the identifier for NIST P521.

Cc: David Howells <dhowells@redhat.com>
Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
---
 crypto/asymmetric_keys/x509_cert_parser.c | 3 +++
 include/linux/oid_registry.h              | 1 +
 2 files changed, 4 insertions(+)

diff --git a/crypto/asymmetric_keys/x509_cert_parser.c b/crypto/asymmetric_keys/x509_cert_parser.c
index 487204d39426..99f809b7910b 100644
--- a/crypto/asymmetric_keys/x509_cert_parser.c
+++ b/crypto/asymmetric_keys/x509_cert_parser.c
@@ -538,6 +538,9 @@ int x509_extract_key_data(void *context, size_t hdrlen,
 		case OID_id_ansip384r1:
 			ctx->cert->pub->pkey_algo = "ecdsa-nist-p384";
 			break;
+		case OID_id_ansip521r1:
+			ctx->cert->pub->pkey_algo = "ecdsa-nist-p521";
+			break;
 		default:
 			return -ENOPKG;
 		}
diff --git a/include/linux/oid_registry.h b/include/linux/oid_registry.h
index 3921fbed0b28..af16d96fbbf2 100644
--- a/include/linux/oid_registry.h
+++ b/include/linux/oid_registry.h
@@ -65,6 +65,7 @@ enum OID {
 	OID_Scram,			/* 1.3.6.1.5.5.14 */
 	OID_certAuthInfoAccess,		/* 1.3.6.1.5.5.7.1.1 */
 	OID_id_ansip384r1,		/* 1.3.132.0.34 */
+	OID_id_ansip521r1,		/* 1.3.132.0.35 */
 	OID_sha256,			/* 2.16.840.1.101.3.4.2.1 */
 	OID_sha384,			/* 2.16.840.1.101.3.4.2.2 */
 	OID_sha512,			/* 2.16.840.1.101.3.4.2.3 */
-- 
2.43.0


