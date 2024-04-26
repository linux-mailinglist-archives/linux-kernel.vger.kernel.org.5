Return-Path: <linux-kernel+bounces-159957-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A1A0F8B36C5
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 13:56:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D41E31C2194E
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 11:56:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDC9D14534D;
	Fri, 26 Apr 2024 11:56:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="UJBKf0JB"
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CB6114532B;
	Fri, 26 Apr 2024 11:56:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714132566; cv=none; b=T6pkEWUp70bZGu6x3FD9/wxTbu6ut6Q8aCCsLUTMY7xPazMVcPX4zNWWL4pGDdsE2R+BA+XWsoB4s2WMOo8Vl48X1lo5TFOsAUPMtMZOP35d2QewaRyGsGVNYQRRHwIgWDUPDwoDzz69tbSxKuZyDbihpRFLb9FIQrmRjyDUx/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714132566; c=relaxed/simple;
	bh=+EUMFgaAnHE2mRqkj9+zWiZV5V9J0wQMZlt3hdmkiTU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ft1eV3lazG85Iy8ZZgmenL7NRY3cNqd/dfzJ/V5qGAR/HY33wAdmx6m0APgyZn+pJTYZeKY1e/BrAf770rXYvzfRHiE/VEpjvhucbFqS41mWY8ETDGyuAnoXW7S+QcYAe/0VXNu6b4SCog+zPGb4PAP/fAq6wrt6Snfp+fhOz14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=UJBKf0JB; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 43QBXULo013500;
	Fri, 26 Apr 2024 11:56:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=fj9S6m73g9Hrm1xkyDOWa9yyXx6DnqKX4by4DKYV1QU=;
 b=UJBKf0JB0+u8fWq7udQkKcspGIGUf/ngPnV0DCwk+uphJm9lOuTtxJNCgDjrhWS9Jqpv
 JBFUHu2OgNijDMpAZ80yl7xTvxIkO7W7Pa8B+tA4odeN/4rj1Naibca7sty9e+Iu5hAw
 IUhOtfs0JuBSrvC8VsCdeKYweobw2sXpNo+Wc2+olPeaZRJJCoMq4yC174rhEzIAyEbE
 gXTCmfydvYWUkpzwQWu7OCF39k+B7KIz0xW4LInAjDTsAlsKzYXWxTxUtorPcvVQqysg
 SWBn3cVL4LaMe8CaeEvwkpGOP6qySaBHxgLugKTHnXEUfMknN9fVmj+ZWuWhBb3q1n/h Wg== 
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3xrbgbg1vt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 26 Apr 2024 11:56:03 +0000
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 43QA6ogn015430;
	Fri, 26 Apr 2024 11:51:02 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3xmshmqchg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 26 Apr 2024 11:51:02 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 43QBouEc55050546
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 26 Apr 2024 11:50:58 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id BD7562004D;
	Fri, 26 Apr 2024 11:50:56 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7C36520040;
	Fri, 26 Apr 2024 11:50:56 +0000 (GMT)
Received: from p-imbrenda.boeblingen.de.ibm.com (unknown [9.152.224.66])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 26 Apr 2024 11:50:56 +0000 (GMT)
From: Claudio Imbrenda <imbrenda@linux.ibm.com>
To: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Cc: hca@linux.ibm.com, gor@linux.ibm.com, agordeev@linux.ibm.com,
        svens@linux.ibm.com, gerald.schaefer@linux.ibm.com,
        borntraeger@de.ibm.com
Subject: [PATCH v2 0/2] s390/pgtable: misc small improvements
Date: Fri, 26 Apr 2024 13:50:54 +0200
Message-ID: <20240426115056.31768-1-imbrenda@linux.ibm.com>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: IE-7gLEeZpE2X5bN4haLWwEg0uIkzs6w
X-Proofpoint-GUID: IE-7gLEeZpE2X5bN4haLWwEg0uIkzs6w
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-04-26_12,2024-04-26_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 impostorscore=0
 spamscore=0 adultscore=0 suspectscore=0 malwarescore=0 phishscore=0
 priorityscore=1501 clxscore=1015 lowpriorityscore=0 mlxscore=0
 mlxlogscore=749 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2404010000 definitions=main-2404260079

This series has two small improvements for the s390 page tables. they
fix some small inconsistencies and missing things.

The first aligns the layout of large puds with that of large pmds;
there is no reason for the large pud read and write softbits to be
swapped compared to large pmds.

The second adds a few bits to _SEGMENT_ENTRY_BITS,
_SEGMENT_ENTRY_HARDWARE_BITS and _SEGMENT_ENTRY_HARDWARE_BITS_LARGE;
those bits are supposed to always be zero, the current code was working
correctly since those bits were being ignored and always left set to
zero. The patch also introduces _REGION3_ENTRY_HARDWARE_BITS and
_REGION3_ENTRY_HARDWARE_BITS_LARGE, for completeness, which are the
bitmasks of the hardware bits for normal puds and large puds.


Claudio Imbrenda (2):
  s390/pgtable: switch read and write softbits for puds
  s390/pgtable: introduce _REGION3_ENTRY_HARDWARE_BITS_LARGE

 arch/s390/include/asm/pgtable.h | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

-- 
2.44.0


