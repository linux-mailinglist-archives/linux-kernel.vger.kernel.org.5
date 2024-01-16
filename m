Return-Path: <linux-kernel+bounces-27674-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AD5C82F3F6
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 19:18:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B8A55288030
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 18:18:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21EF31CD30;
	Tue, 16 Jan 2024 18:18:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="l/iX0Vg9"
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CA711CABF;
	Tue, 16 Jan 2024 18:18:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705429089; cv=none; b=Tr2gDRWtPuM5Tw7lwBefZ7uWBGaGax++fMtPBfxpqLmMVEnolFqaYeoMtdBCANTkB/KDahGd51RzdtJU1nTu/xSgRa0z1m9Y3BCtJQe35TRH5Ep84ep0r2h9TUdjdYZNfS172kuvFvz4tX0XbrmkF7DyHm4c8E5EiEJlC46g/64=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705429089; c=relaxed/simple;
	bh=MvQmB2IMDc7Vh2/9kaptGsNwcEch9wqkuF0Mqgu0h+I=;
	h=Received:DKIM-Signature:Received:Received:Received:Received:
	 Received:Received:Received:Received:Received:From:To:Cc:Subject:
	 Date:Message-Id:X-Mailer:In-Reply-To:References:X-TM-AS-GCONF:
	 X-Proofpoint-GUID:X-Proofpoint-ORIG-GUID:Content-Transfer-Encoding:
	 X-Proofpoint-UnRewURL:MIME-Version:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details; b=lYibvvlJFb1O7DKBzp+/8D7IbJj8VwRfAxNpD5wEE37OFSmaAWyaPizq0n9qEQE9HGPjYdKjxqjJFzjeZrEHNl4S7AROyDVW8bqAfb7B5WK2sboJFaZ52o24DYRtvXQGaTVLy4miLEcdHVA6q+fttnKgGCxSPGHUOfGkwUoRWVs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=l/iX0Vg9; arc=none smtp.client-ip=148.163.158.5
Received: from pps.filterd (m0353724.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 40GHhFqC029160;
	Tue, 16 Jan 2024 18:17:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : content-transfer-encoding
 : mime-version; s=pp1; bh=S61zGNt9lhuRFn3m1JKAzkGpI1+L/U9CxI82WFShVGE=;
 b=l/iX0Vg9cPLZ3+8BNx9ZWqQ4zcXQg3Anusg7ZuvlG4eQjvJm+vm6JS/fbwC7f3COm+mU
 +Nuc3Lehv8tOm5c4/wPOaZEkEYqgDs19PGTeYb7Ragg4aOY1+LhuopkrKCLKVM/mVsbq
 6cWuftzgQTwYZ19grlj76j6VNKVHbhGMzUqbXkz2bBnXw4kRDKFofGuBkZUaky5JyJmf
 SN9Qsv/rqgji+GH6XlyvMRdR3qPrt7L5WaluAGGY8FYCVycpLkXNPEP3xcO1LPSpXmGX
 qqcr3882DytBUWX/qW3ufXJ+YzAmLeK6EYEoOBviBL/z2EDe3KChwn0Abnq2AUR2sIUE wg== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3vnxep0uw7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 16 Jan 2024 18:17:59 +0000
Received: from m0353724.ppops.net (m0353724.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 40GI73Ha009028;
	Tue, 16 Jan 2024 18:17:58 GMT
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3vnxep0uvv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 16 Jan 2024 18:17:58 +0000
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 40GGNRaQ003699;
	Tue, 16 Jan 2024 18:17:57 GMT
Received: from smtprelay01.wdc07v.mail.ibm.com ([172.16.1.68])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 3vm4usrgts-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 16 Jan 2024 18:17:57 +0000
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com [10.241.53.100])
	by smtprelay01.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 40GIHvCb23528112
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 16 Jan 2024 18:17:57 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id EF4AB58059;
	Tue, 16 Jan 2024 18:17:56 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B9A5F58058;
	Tue, 16 Jan 2024 18:17:56 +0000 (GMT)
Received: from gfwa153.aus.stglabs.ibm.com (unknown [9.3.84.127])
	by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 16 Jan 2024 18:17:56 +0000 (GMT)
From: Ninad Palsule <ninad@linux.ibm.com>
To: peterhuewe@gmx.de, jarkko@kernel.org, jgg@ziepe.ca,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Joel Stanley <joel@jms.id.au>, ninad@linux.ibm.com
Subject: [PATCH v2 1/1] tpm: tis-i2c: Add more compatible strings
Date: Tue, 16 Jan 2024 12:17:54 -0600
Message-Id: <20240116181754.3905754-2-ninad@linux.ibm.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240116181754.3905754-1-ninad@linux.ibm.com>
References: <20240116181754.3905754-1-ninad@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: MmkZSc9XmIm8x7CrqKrHDGTEpws2-wj6
X-Proofpoint-ORIG-GUID: ypOieaIy5xkWKufNSewsNLV4uqTCEhOB
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-16_10,2024-01-16_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999 bulkscore=0
 adultscore=0 malwarescore=0 impostorscore=0 phishscore=0 mlxscore=0
 suspectscore=0 clxscore=1015 spamscore=0 priorityscore=1501
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2401160144

From: Joel Stanley <joel@jms.id.au>

Add a generic compatibility string for I2C based TPM 2.0 device.

Signed-off-by: Joel Stanley <joel@jms.id.au>
Signed-off-by: Ninad Palsule <ninad@linux.ibm.com>
---
This patch is based out of following patchset:
https://lore.kernel.org/r/20220928043957.2636877-4-joel@jms.id.au
This patchset has 3 patches. The binding document related patches are
already merged using following patchset:
https://lore.kernel.org/all/3f56f0a2bb90697a23e83583a21684b75dc7eea2.1701093036.git.lukas@wunner.de/

v2:
  - Removed NPCT75x compatibility string based on review comment by
    Conor.
---
 drivers/char/tpm/tpm_tis_i2c.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/char/tpm/tpm_tis_i2c.c b/drivers/char/tpm/tpm_tis_i2c.c
index a897402cc36a..d63ef81fb1f1 100644
--- a/drivers/char/tpm/tpm_tis_i2c.c
+++ b/drivers/char/tpm/tpm_tis_i2c.c
@@ -383,6 +383,7 @@ MODULE_DEVICE_TABLE(i2c, tpm_tis_i2c_id);
 #ifdef CONFIG_OF
 static const struct of_device_id of_tis_i2c_match[] = {
 	{ .compatible = "infineon,slb9673", },
+	{ .compatible = "tcg,tpm-tis-i2c", },
 	{}
 };
 MODULE_DEVICE_TABLE(of, of_tis_i2c_match);
-- 
2.39.2


