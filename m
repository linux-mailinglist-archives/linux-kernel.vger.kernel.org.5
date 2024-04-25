Return-Path: <linux-kernel+bounces-158569-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ECAC58B2234
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 15:06:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2B8551C211CF
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 13:06:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EB0E149C70;
	Thu, 25 Apr 2024 13:06:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="m6Qs/Jiz"
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE8D812BF20;
	Thu, 25 Apr 2024 13:06:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714050374; cv=none; b=ECyXgwjIUXG5H3R0WR9guDNs13Iq05GjRLxvgZP9CbpuFJj0qQTZdmngjb+7wt1hFJYxmXWYcytcLwLbEZ+K475mYy0s9JlHpA2UfTCd+AM0KpN3ENo0svY//SbXVPiBgyaMC+hiTgrzOgjazD59O6bYbnCA+uEyVjW98skj8YE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714050374; c=relaxed/simple;
	bh=dP6u0h+AInAYk36Gy/1DAeeLtfkf8XUrXtl/BlzxDes=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tmTEqlBw2HUBgGj8G9XL3xosDPo+6bv3QtR1kIvk87hBZPpaKCpfeLdDxJnwADQhoy0qEGse6WQ2EfhvEv5+cMOdZtF/LLLX1wMEGRUcZCvX+rRWWLDTjJndXr1I6JoWBr8Jsf08kFtiE3+uH7QKvPhJsplTHzZ+RrEOFUHt5Vg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=m6Qs/Jiz; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353726.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 43PCvbLu009084;
	Thu, 25 Apr 2024 13:06:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=83AcW71R8Nnwha+aKlSNhfYrHMTJoGosvIKHcP6OXSc=;
 b=m6Qs/JizHsvTGVThGaU9l+2KyrdU883sc8dKSwMhFRxk0DmnswCLzj4m1GWjOWdop6vE
 NpLOoOin7g9W4Ui/roHhifYR0zGjEKQtTH5INbfq4izI1B/PFqTXttqrDYvbWtPsA8Qn
 8aA1ai1dNfeok4zmSu/8RNLzyP3i64S8I/zEZkIaED1+qbzYcKgg4SMxiVkQTNBWrfDz
 ZR5+4FMBLm/bzVWdq0YIYzjMW8uQZOC0MoV/V6Vk2oT0b+ol1tkxI78mLOdafG8eoPBZ
 7e74FkpTH/4EllAux7voAyMLyh0lwFqL871/7kzCttwOE9L+ITEH+qnGJfPhhuJPtDpV qA== 
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3xqqmqr10c-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 25 Apr 2024 13:06:11 +0000
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 43PA0C9F005328;
	Thu, 25 Apr 2024 13:06:10 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 3xmx3crkdn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 25 Apr 2024 13:06:10 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 43PD65kA53084508
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 25 Apr 2024 13:06:07 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 893B120067;
	Thu, 25 Apr 2024 13:06:05 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9682C2004B;
	Thu, 25 Apr 2024 13:06:03 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.171.50.16])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 25 Apr 2024 13:06:03 +0000 (GMT)
From: Claudio Imbrenda <imbrenda@linux.ibm.com>
To: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Cc: hca@linux.ibm.com, gor@linux.ibm.com, agordeev@linux.ibm.com,
        svens@linux.ibm.com, gerald.schaefer@linux.ibm.com,
        borntraeger@de.ibm.com
Subject: [PATCH v1 2/2] s390/pgtable: introduce _REGION3_ENTRY_HARDWARE_BITS_LARGE
Date: Thu, 25 Apr 2024 15:05:55 +0200
Message-ID: <20240425130555.73132-3-imbrenda@linux.ibm.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240425130555.73132-1-imbrenda@linux.ibm.com>
References: <20240425130555.73132-1-imbrenda@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: GJCUYhtIYAFBhrSHsVHzNYCD9IK8qAdU
X-Proofpoint-ORIG-GUID: GJCUYhtIYAFBhrSHsVHzNYCD9IK8qAdU
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-04-25_13,2024-04-25_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 malwarescore=0 impostorscore=0 mlxlogscore=999 phishscore=0 adultscore=0
 bulkscore=0 priorityscore=1501 clxscore=1015 mlxscore=0 suspectscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2404010000 definitions=main-2404250095

For completeness, introduce _REGION3_ENTRY_HARDWARE_BITS_LARGE,
containing the hardware bits used for large puds.

Signed-off-by: Claudio Imbrenda <imbrenda@linux.ibm.com>
---
 arch/s390/include/asm/pgtable.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/s390/include/asm/pgtable.h b/arch/s390/include/asm/pgtable.h
index 3da2995fd196..5c0f840eee2a 100644
--- a/arch/s390/include/asm/pgtable.h
+++ b/arch/s390/include/asm/pgtable.h
@@ -262,6 +262,7 @@ static inline int is_module_addr(void *addr)
 #define _REGION3_ENTRY		(_REGION_ENTRY_TYPE_R3 | _REGION_ENTRY_LENGTH)
 #define _REGION3_ENTRY_EMPTY	(_REGION_ENTRY_TYPE_R3 | _REGION_ENTRY_INVALID)
 
+#define _REGION3_ENTRY_HARDWARE_BITS_LARGE	0xffffffff8000073cUL
 #define _REGION3_ENTRY_ORIGIN_LARGE ~0x7fffffffUL /* large page address	     */
 #define _REGION3_ENTRY_DIRTY	0x2000	/* SW region dirty bit */
 #define _REGION3_ENTRY_YOUNG	0x1000	/* SW region young bit */
-- 
2.44.0


