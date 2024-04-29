Return-Path: <linux-kernel+bounces-162458-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 046078B5B89
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 16:39:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 284551C21446
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 14:39:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F23B7E563;
	Mon, 29 Apr 2024 14:39:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="HkNXZUHO"
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 390777D414;
	Mon, 29 Apr 2024 14:39:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714401545; cv=none; b=DeAHKoCjsN9IQIQUn5DvffyDQWURlJS/CGSOUtshRIc6UkMMABIrFw8P1XUkwVEjgVu/FXCbMeCoSu+HAb4MdhVjhc/7XpUUateLJ0ojdNP54+LyKde+oyUr36kQ0rcGqDETPYCn/t3QgvMhwDHGI2wz/lLY5y/98Thkk8pF6T4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714401545; c=relaxed/simple;
	bh=yqDFAGwQ/4bW2IO8SlK51MnqLhjG3NHRDDa/q7krM2E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DtTygBah01Hy8aHEcC+ShL4mcz45M+Fb8p/Oe1G4ALHJdYDKQMu3v3NsAaa81tC2XSoaEwq+eH9hSlfBpz7xEc/xoeegJE2ZvNDz7qlRVzkpOPPq/V5cVvMWuU7PaFiwzjfVm/fY7XlSox6LKWyEr9h5P0nYvYKno/lFKwItRTE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=HkNXZUHO; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353727.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 43TEcSUw021640;
	Mon, 29 Apr 2024 14:39:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=Nm10ZvH55y6cuJAEAuMj5wG2OTMU7DW8ViD8a6hS5+I=;
 b=HkNXZUHOH+Z5r5RGGuQ5ZKbwOVnEMfGQTmUSxkmRrs+/DE73+EUv79e3xxpgmtD51D0z
 KQViWYLqkn5NCPESx6crCXooEXdBkLgtWr7BCd3sGT6FLPK8Tn1YolvF17omAskGkFBa
 3u7FGvAbxmejGa4ZAVzlc2b8Wdo8wEkKCOg7bM9T23KaD1LLtqTMQq4Wg/+mT3SCtEvT
 odiptBIgCRyZhNMKrE/DzCjEP/T9lvFdNvsxJW2BpBU362crt+m2in57eiNIp4YC2y8o
 c9XmEFuycJdy9suDQep/cODV/F1qpN13oBYIbp3SzXQJzYET9u2y46HlsQMIfM9T6wyn zA== 
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3xtdfhr03d-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 29 Apr 2024 14:39:03 +0000
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 43TCFa0x022258;
	Mon, 29 Apr 2024 14:34:15 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3xsd6mfn9a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 29 Apr 2024 14:34:15 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 43TEYApu31130300
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 29 Apr 2024 14:34:12 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0CC212004D;
	Mon, 29 Apr 2024 14:34:10 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id CAC862004E;
	Mon, 29 Apr 2024 14:34:09 +0000 (GMT)
Received: from p-imbrenda.boeblingen.de.ibm.com (unknown [9.152.224.66])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 29 Apr 2024 14:34:09 +0000 (GMT)
From: Claudio Imbrenda <imbrenda@linux.ibm.com>
To: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Cc: hca@linux.ibm.com, gor@linux.ibm.com, agordeev@linux.ibm.com,
        svens@linux.ibm.com, gerald.schaefer@linux.ibm.com,
        borntraeger@de.ibm.com
Subject: [PATCH v4 2/2] s390/pgtable: add missing hardware bits for puds, pmds
Date: Mon, 29 Apr 2024 16:34:09 +0200
Message-ID: <20240429143409.49892-3-imbrenda@linux.ibm.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240429143409.49892-1-imbrenda@linux.ibm.com>
References: <20240429143409.49892-1-imbrenda@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 2Zna0nsdeuffqy67UB6gS6eGYhzy0dGB
X-Proofpoint-GUID: 2Zna0nsdeuffqy67UB6gS6eGYhzy0dGB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-04-29_12,2024-04-29_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 malwarescore=0
 bulkscore=0 adultscore=0 clxscore=1015 phishscore=0 impostorscore=0
 lowpriorityscore=0 spamscore=0 suspectscore=0 priorityscore=1501
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2404010000 definitions=main-2404290092

Add the table type and ACCF validity bits to _SEGMENT_ENTRY_BITS and
_SEGMENT_ENTRY_HARDWARE_BITS{,_LARGE}.

For completeness, introduce _REGION3_ENTRY_HARDWARE_BITS_LARGE and
_REGION3_ENTRY_HARDWARE_BITS, containing the hardware bits used for
large puds and normal puds.

Signed-off-by: Claudio Imbrenda <imbrenda@linux.ibm.com>
Reviewed-by: Heiko Carstens <hca@linux.ibm.com>
---
 arch/s390/include/asm/pgtable.h | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/arch/s390/include/asm/pgtable.h b/arch/s390/include/asm/pgtable.h
index 3da2995fd196..c8947ee36f1a 100644
--- a/arch/s390/include/asm/pgtable.h
+++ b/arch/s390/include/asm/pgtable.h
@@ -262,6 +262,8 @@ static inline int is_module_addr(void *addr)
 #define _REGION3_ENTRY		(_REGION_ENTRY_TYPE_R3 | _REGION_ENTRY_LENGTH)
 #define _REGION3_ENTRY_EMPTY	(_REGION_ENTRY_TYPE_R3 | _REGION_ENTRY_INVALID)
 
+#define _REGION3_ENTRY_HARDWARE_BITS		0xfffffffffffff6ffUL
+#define _REGION3_ENTRY_HARDWARE_BITS_LARGE	0xffffffff8001073cUL
 #define _REGION3_ENTRY_ORIGIN_LARGE ~0x7fffffffUL /* large page address	     */
 #define _REGION3_ENTRY_DIRTY	0x2000	/* SW region dirty bit */
 #define _REGION3_ENTRY_YOUNG	0x1000	/* SW region young bit */
@@ -278,9 +280,9 @@ static inline int is_module_addr(void *addr)
 #define _REGION_ENTRY_BITS	 0xfffffffffffff22fUL
 
 /* Bits in the segment table entry */
-#define _SEGMENT_ENTRY_BITS			0xfffffffffffffe33UL
-#define _SEGMENT_ENTRY_HARDWARE_BITS		0xfffffffffffffe30UL
-#define _SEGMENT_ENTRY_HARDWARE_BITS_LARGE	0xfffffffffff00730UL
+#define _SEGMENT_ENTRY_BITS			0xfffffffffffffe3fUL
+#define _SEGMENT_ENTRY_HARDWARE_BITS		0xfffffffffffffe3cUL
+#define _SEGMENT_ENTRY_HARDWARE_BITS_LARGE	0xfffffffffff1073cUL
 #define _SEGMENT_ENTRY_ORIGIN_LARGE ~0xfffffUL /* large page address	    */
 #define _SEGMENT_ENTRY_ORIGIN	~0x7ffUL/* page table origin		    */
 #define _SEGMENT_ENTRY_PROTECT	0x200	/* segment protection bit	    */
-- 
2.44.0


