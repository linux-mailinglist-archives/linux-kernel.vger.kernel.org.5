Return-Path: <linux-kernel+bounces-160760-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C2EFE8B4271
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Apr 2024 00:59:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DC9841C21A50
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 22:59:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D34B53C087;
	Fri, 26 Apr 2024 22:58:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="H9Z5yh5K"
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FFE53BBC5;
	Fri, 26 Apr 2024 22:58:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714172339; cv=none; b=PZ0200aq0T1M0I1FSB5CP+J3uF3fYFmCS3yFH3V2xCgwI3QdpglLWXJSJYUZ5Vk5/akqV5ZBtSimR/gBYGiZuwUU/u4NxRrhZMud1MM6dkIdOt+c4fynASquJRLKyM3TNzIkp07Ln++iVG7/8b4TL+pqDVheopKi7pMnTwCUh+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714172339; c=relaxed/simple;
	bh=2VvdgYGJW+J6G/InU4atjUaWGbpVPNUcFdofJqvbrsw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=FbEE0VCVnGkCJfpMobNzq4nVlvQvrHtDNE1R9X8mPT7iPaZvHuzOzHlSpc3f3DT9Dr6juvO/LAMxQ3LdDcOsZdHtHmCScgbCy8BkXYC7FPW5XJOya89fG1k/Bb91lT/1Oy6rVdjGO+eRTeW6h5A8pJlMLn5KtN1Gzps/Q2okTjY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=H9Z5yh5K; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353726.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 43QMeYta022643;
	Fri, 26 Apr 2024 22:58:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=hfr3SWAqYo+sSiXwwtPj7k1z5GcUrNj2b6ZD4IV+j/k=;
 b=H9Z5yh5K3AXI6v7Vs+HbUnHukYm7SmHEs4a5MyybdAkyk80Gk1fdcttHJyTNJ5axcvjR
 WHSPUk+32GQ2COmghqAoMQ/HfxX1WeoMWSI0uBFFnYz1M0nkl6CG4ncRbz3XpxmF62iI
 SLeJbUvG0uVLUXTN9i4sA8cdfdxqGqqN2PiiGB4XIJdCP6r07Pdivq/ni2qnsKJuuRZR
 VUhJQ7YVWdRfOYkAFamBNVSpVg4oUYeVtk6H4SCzTc/4SnGkkJtCrOhHnrPXNt2rvR6N
 zWgpLI2EMWa5V6b/lWd/wy6TSTaKE/j0AnoDYGwyAgE0BS1z5cwqx2BJ22oll3s/NtQp ug== 
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3xrn0fg1kg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 26 Apr 2024 22:58:48 +0000
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 43QLMXfO005328;
	Fri, 26 Apr 2024 22:56:04 GMT
Received: from smtprelay03.dal12v.mail.ibm.com ([172.16.1.5])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 3xmx3d10vp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 26 Apr 2024 22:56:04 +0000
Received: from smtpav05.wdc07v.mail.ibm.com (smtpav05.wdc07v.mail.ibm.com [10.39.53.232])
	by smtprelay03.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 43QMu2kV11272924
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 26 Apr 2024 22:56:04 GMT
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 234B058059;
	Fri, 26 Apr 2024 22:56:02 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6747658043;
	Fri, 26 Apr 2024 22:56:01 +0000 (GMT)
Received: from sbct-3.bos2.lab (unknown [9.47.158.153])
	by smtpav05.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 26 Apr 2024 22:56:01 +0000 (GMT)
From: Stefan Berger <stefanb@linux.ibm.com>
To: keyrings@vger.kernel.org, linux-crypto@vger.kernel.org,
        herbert@gondor.apana.org.au, davem@davemloft.net
Cc: linux-kernel@vger.kernel.org, lukas@wunner.de, jarkko@kernel.org,
        Stefan Berger <stefanb@linux.ibm.com>
Subject: [PATCH] crypto: ecc - Protect ecc_digits_from_bytes from reading too many bytes
Date: Fri, 26 Apr 2024 18:55:53 -0400
Message-ID: <20240426225553.3038070-1-stefanb@linux.ibm.com>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: K5i04VXHYMgKYT3Bmddfj1En5_l8n3IG
X-Proofpoint-ORIG-GUID: K5i04VXHYMgKYT3Bmddfj1En5_l8n3IG
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-04-26_20,2024-04-26_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0
 lowpriorityscore=0 mlxlogscore=999 adultscore=0 priorityscore=1501
 impostorscore=0 spamscore=0 mlxscore=0 clxscore=1011 suspectscore=0
 phishscore=0 malwarescore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2404010000 definitions=main-2404260162

Protect ecc_digits_from_bytes from reading too many bytes from the input
byte array in case an insufficient number of bytes is provided to fill the
output digit array of ndigits. Therefore, initialize the most significant
digits with 0 to avoid trying to read too many bytes later on.

If too many bytes are provided on the input byte array the extra bytes
are ignored since the input variable 'ndigits' limits the number of digits
that will be filled.

Fixes: d67c96fb97b5 ("crypto: ecdsa - Convert byte arrays with key coordinates to digits")
Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
---
 include/crypto/internal/ecc.h | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/include/crypto/internal/ecc.h b/include/crypto/internal/ecc.h
index 7ca1f463d1ec..56215f14ff96 100644
--- a/include/crypto/internal/ecc.h
+++ b/include/crypto/internal/ecc.h
@@ -67,9 +67,16 @@ static inline void ecc_swap_digits(const void *in, u64 *out, unsigned int ndigit
 static inline void ecc_digits_from_bytes(const u8 *in, unsigned int nbytes,
 					 u64 *out, unsigned int ndigits)
 {
+	int diff = ndigits - DIV_ROUND_UP(nbytes, sizeof(u64));
 	unsigned int o = nbytes & 7;
 	__be64 msd = 0;
 
+	/* diff > 0: not enough input bytes: set most significant digits to 0 */
+	while (diff > 0) {
+		out[--ndigits] = 0;
+		diff--;
+	}
+
 	if (o) {
 		memcpy((u8 *)&msd + sizeof(msd) - o, in, o);
 		out[--ndigits] = be64_to_cpu(msd);
-- 
2.43.0


