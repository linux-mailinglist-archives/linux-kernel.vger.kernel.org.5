Return-Path: <linux-kernel+bounces-129719-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 61ACE896EDD
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 14:29:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0191C1F22CBE
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 12:29:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E10861465B1;
	Wed,  3 Apr 2024 12:29:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="fdyadUTy"
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FDFE146013;
	Wed,  3 Apr 2024 12:29:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712147346; cv=none; b=n6ZvurfNCyaFvOU1KohDsrj4a6YnBwUTRCXMaQN8vvcKt8f749cxYjZY5EboNeegEkGTRTnVEU3i/nbwWdbnjUV2zodQnz/gHyinFgkCOoduW/lLXcAMReyESRAScqlu3Z9BfzpLTVi1vnd1M96LGdkHPdw6yUiltkjJVUKaPp0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712147346; c=relaxed/simple;
	bh=VYP5AfDYQp0NK8K5iNdKQhalyg3zSz4h0eFw0F5dHwk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=t7DF8oMbITU7JH+ne5i/jX8+bv3KDB/ZRrOhpVNVHSCtVg/0Fzs+d7gkM4mMgBoiTHocXVbij04fzBJNpAGaYB9LByr5HpkbcLprvF8tB2RdB8dGQNpQwpnzSTDJLP11rgZxEMZYFoonXWPXINzpOBiATErpL2Jd0jqOx/j7fHU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=fdyadUTy; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353723.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 433CPCSU001136;
	Wed, 3 Apr 2024 12:28:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=TPpX4kKUFWucYvXeHgkqlM2X+uAoSB9I5PnQiABOut0=;
 b=fdyadUTyMCPrwq+uN/jRXFNq1VpZueJkwhyqEMZrUxpzVkoMzx9vKEKsvzgRvAVVgXf+
 rx4kyYIe17fLsNUj1RP/r7mriCkutDJhnpmE5YENmNsTFiqDVP8lqfKqsJB/3+QWdFwj
 5FQRtJ19fma0oaR0rIcqSVR066mCmKe9lwtt/SpOY2IFE1plzVeGmdm2jT7oSImE6JlY
 DXv1W2om+w/4QnKJBvRPOq7MmkrmP0Rl7QK53OyB8jBXI/BxUjU5Thk9rp+ODAKpK/D/
 vVtOltqRD5j07h8MkYcfZy9CYqgXsxLGZj7qRmn/Ce6u109GK++n2A8St2NNNkFxT2N9 hg== 
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3x973d8090-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 03 Apr 2024 12:28:57 +0000
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 433AiltO008425;
	Wed, 3 Apr 2024 12:28:57 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 3x6w2u5ga6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 03 Apr 2024 12:28:57 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 433CSphQ30212548
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 3 Apr 2024 12:28:53 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id BA34C20043;
	Wed,  3 Apr 2024 12:28:51 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 832F32004D;
	Wed,  3 Apr 2024 12:28:51 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed,  3 Apr 2024 12:28:51 +0000 (GMT)
From: Niklas Schnelle <schnelle@linux.ibm.com>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: linux-m68k@lists.linux-m68k.org, Arnd Bergmann <arnd@kernel.org>,
        Heiko Carstens <hca@linux.ibm.com>, linux-kernel@vger.kernel.org,
        Niklas Schnelle <schnelle@linux.ibm.com>
Subject: [PATCH 1/1] m68k: Let GENERIC_IOMAP depend on HAS_IOPORT
Date: Wed,  3 Apr 2024 14:28:51 +0200
Message-Id: <20240403122851.38808-2-schnelle@linux.ibm.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240403122851.38808-1-schnelle@linux.ibm.com>
References: <20240403122851.38808-1-schnelle@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: HxqR5Wr5sTTxCpiEUZ1vFr6rDICM7dJi
X-Proofpoint-ORIG-GUID: HxqR5Wr5sTTxCpiEUZ1vFr6rDICM7dJi
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-03_10,2024-04-03_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 mlxlogscore=581 mlxscore=0 adultscore=0 clxscore=1011 suspectscore=0
 spamscore=0 bulkscore=0 priorityscore=1501 phishscore=0 malwarescore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2403210000 definitions=main-2404030086

In a future patch HAS_IOPORT=n will disable inb()/outb() and friends at
compile time. With that choosing dynamically between I/O port and MMIO
access via GNERIC_IOMAP will not work. So only select GENERIC_IOMAP when
HAS_IOPORT is selected.

Co-developed-by: Arnd Bergmann <arnd@kernel.org>
Signed-off-by: Arnd Bergmann <arnd@kernel.org>
Signed-off-by: Niklas Schnelle <schnelle@linux.ibm.com>
---
 arch/m68k/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/m68k/Kconfig b/arch/m68k/Kconfig
index 6ffa29585194..6ef282f329ee 100644
--- a/arch/m68k/Kconfig
+++ b/arch/m68k/Kconfig
@@ -18,7 +18,7 @@ config M68K
 	select DMA_DIRECT_REMAP if M68K_NONCOHERENT_DMA && !COLDFIRE
 	select GENERIC_ATOMIC64
 	select GENERIC_CPU_DEVICES
-	select GENERIC_IOMAP
+	select GENERIC_IOMAP if HAS_IOPORT
 	select GENERIC_IRQ_SHOW
 	select GENERIC_LIB_ASHLDI3
 	select GENERIC_LIB_ASHRDI3
-- 
2.40.1


