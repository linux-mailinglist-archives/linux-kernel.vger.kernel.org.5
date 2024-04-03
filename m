Return-Path: <linux-kernel+bounces-129718-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3319D896EDC
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 14:29:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 92C992854D8
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 12:29:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D4BD146595;
	Wed,  3 Apr 2024 12:29:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="igzjwMx4"
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDD581420C4;
	Wed,  3 Apr 2024 12:29:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712147345; cv=none; b=YdRGWa3nXw84gIMuTdSI8cwyGmyxWznaYMW+g4RDNFrElzkRKpVlgP/y03UhO4HMDXZGpeny0WgRTYVRJeyIcycmjXPBjxlQR43+hxo1kN2G7W7CcpKB2L8JQRdu8tfWluQS8fVaVos8GwGibZWN4Vw2TK1kUI1jd7qCLzHixQM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712147345; c=relaxed/simple;
	bh=8P0Yy92SBJKmTVd4CB3+k1ILeKB9IgFSxHcHZxm4kM0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=bX6jTILMMZ82R3HV4SI4XPjCyzrX6PR/rPXzJy1nFHiARmsLxcrlCTeAWu2DeBnxW/OTLnYajAwzkg6ipURu3Z25gZLrC9UWe3T5nfx5iD4v3RYw51DWrO398WqeGiZthwOEP949MH5iwCEf/UCDA3Hiv4QL44wd7m+AoxHt6s4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=igzjwMx4; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 433C65xt019444;
	Wed, 3 Apr 2024 12:28:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : content-transfer-encoding : mime-version; s=pp1;
 bh=XlzuvTxCdxozJGmbeAyRK+yGABkfLYKAzGal0s+e6D8=;
 b=igzjwMx4KgakBWL/Vbpyzm1sRj7NOBOp8CzzeZsbpLgDBYKdptfdpXcXh8gOpK/R3E5W
 q6CC16JN3OxXsWrrAOm9TjupX8KsZekJ/YUAAbPrQhnRH5soXQFnHqpoeIbISxwYxX6H
 W2IVSOrrI2rYLHL0gxoz+NRtniod3olLm09d0G/D1Im+vhR7UET0cUmOmZuU/KyIM6nw
 PWoFc2rKbBngPjr9tsSbwpRSCYCbYavZaBfU681wfqd5uI5+02vLudCL7GCGzr8wANIg
 tc288aegtjHJ5pJAGyLD853szXwaEzZJYafGvIS0i+pcsn4wgF/v1HRjQYG5CZK1C4uO cQ== 
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3x96j2g32r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 03 Apr 2024 12:28:57 +0000
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 433AXIqo029582;
	Wed, 3 Apr 2024 12:28:57 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 3x6ys34rgk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 03 Apr 2024 12:28:56 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 433CSpRu54985184
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 3 Apr 2024 12:28:53 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7AB062004B;
	Wed,  3 Apr 2024 12:28:51 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4CA3020040;
	Wed,  3 Apr 2024 12:28:51 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed,  3 Apr 2024 12:28:51 +0000 (GMT)
From: Niklas Schnelle <schnelle@linux.ibm.com>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: linux-m68k@lists.linux-m68k.org, Arnd Bergmann <arnd@kernel.org>,
        Heiko Carstens <hca@linux.ibm.com>, linux-kernel@vger.kernel.org,
        Niklas Schnelle <schnelle@linux.ibm.com>
Subject: [PATCH 0/1] m68k: Handle HAS_IOPORT dependencies
Date: Wed,  3 Apr 2024 14:28:50 +0200
Message-Id: <20240403122851.38808-1-schnelle@linux.ibm.com>
X-Mailer: git-send-email 2.40.1
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: zY30Y5qQH5LOIgFf8ZVFQRqsSbEYAHYc
X-Proofpoint-ORIG-GUID: zY30Y5qQH5LOIgFf8ZVFQRqsSbEYAHYc
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-03_10,2024-04-03_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 adultscore=0
 mlxscore=0 lowpriorityscore=0 malwarescore=0 suspectscore=0
 impostorscore=0 spamscore=0 phishscore=0 priorityscore=1501 clxscore=1015
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2403210000 definitions=main-2404030086

Hi Geert,

This is a follow up in my ongoing effort of making inb()/outb() and
similar I/O port accessors compile-time optional. Previously I sent this
as a treewide series titled "treewide: Remove I/O port accessors for
HAS_IOPORT=n" with the latest being its 5th version[0]. With a significant
subset of patches merged I've changed over to per-subsystem series. These
series are stand alone and should be merged via the relevant tree such
that with all subsystems complete we can follow this up with the final
patch that will make the I/O port accessors compile-time optional.

The current state of the full series with changes to the remaining
subsystems and the aforementioned final patch can be found for your
convenience on my git.kernel.org tree in the has_ioport_v6 branch[1] with
signed tags. As for compile-time vs runtime see Linus' reply to my first
attempt[2].

Thanks,
Niklas

[0] https://lore.kernel.org/all/20230522105049.1467313-1-schnelle@linux.ibm.com/
[1] https://git.kernel.org/pub/scm/linux/kernel/git/niks/linux.git/log/?h=has_ioport_v6
[2] https://lore.kernel.org/lkml/CAHk-=wg80je=K7madF4e7WrRNp37e3qh6y10Svhdc7O8SZ_-8g@mail.gmail.com/

Niklas Schnelle (1):
  m68k: Let GENERIC_IOMAP depend on HAS_IOPORT

 arch/m68k/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

-- 
2.40.1


