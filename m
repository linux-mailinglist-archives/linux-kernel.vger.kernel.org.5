Return-Path: <linux-kernel+bounces-80239-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BB71F862C69
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Feb 2024 18:52:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 32D9EB21553
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Feb 2024 17:52:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61D4D18EB0;
	Sun, 25 Feb 2024 17:52:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="DkTpxScZ"
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C9ED18641;
	Sun, 25 Feb 2024 17:52:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708883535; cv=none; b=US37/zeoDTs+buZXDHgoa5EviRHKJWCRVwk+5EAjfs0RYqszN8KADRsK7p/q3/nVIuwwvJdrAftofWwa6Q3IlAmHIXQYRNre2ikT/Im2aKbHHi+zHB43koFeR3V0MnkHp3VgRof1z/p9RKbfGF4075SOUyfCk+L1UDL5On47DaY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708883535; c=relaxed/simple;
	bh=DprT2EmKP7xzuk3iXRz7q9pQHdysT2wdx1/bw0FVk7E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=COMHWzInYNUDiKP//SyGhqeUVkuonu4DyyE7wnPZo9TC5rBzx85sH+YD1TFjhCp2Gkvoh+uhcoOFKmyTFODGW72AQJJuzvy5JnBNKUHX92UAgSaX7LdYZ8tEZJNzhKCPcfcG26YBBgTGo79VpiAWUibLgWtBVvH8bTQHM0rfc4g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=DkTpxScZ; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 41PAU7KW018594;
	Sun, 25 Feb 2024 17:52:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=pp1; bh=sh/Pt35h1I42Kj5tCDDQbqe5oBCkhBYlGZsAwyHfnM8=;
 b=DkTpxScZi6+IuQP98qE6OdAx4VovM2ZvtPRmN2sqUltSWW+gDoInsip6l0SVUr1MZezt
 KXqb8bsPtGyN6T5Y+xxYECCPjYT5QAiEiFKmwxh0DGbDemxlIVtn/nTl+0nhEBLBXCXI
 cd/cEB/6emakyp1nguYQakrjikju/tEiOeFQ5drjBSPKv0Os6BI/uIyDh2zT5xxLN4+1
 c94IVjRPQbLodruNd6XjLlkJBBhLNn7H5pVx2x6+8y2qrAIwjLD++vEsHbEC0VMNa6iC
 Ino29YSlcAIZZupPMxGc4WJP0SeOs07YxGIKWVMMFWc+NPGh3C73PZQ4OD4egn8r1D0z 0A== 
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3wg0bgpm29-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 25 Feb 2024 17:52:05 +0000
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 41PGdsdu024154;
	Sun, 25 Feb 2024 17:52:04 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 3wfw0jup3q-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 25 Feb 2024 17:52:04 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 41PHpwgu59441616
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 25 Feb 2024 17:52:01 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D1C622004B;
	Sun, 25 Feb 2024 17:51:58 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 453A820040;
	Sun, 25 Feb 2024 17:51:58 +0000 (GMT)
Received: from osiris (unknown [9.171.48.174])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Sun, 25 Feb 2024 17:51:58 +0000 (GMT)
Date: Sun, 25 Feb 2024 18:51:56 +0100
From: Heiko Carstens <hca@linux.ibm.com>
To: Naresh Kamboju <naresh.kamboju@linaro.org>
Cc: open list <linux-kernel@vger.kernel.org>, linux-s390@vger.kernel.org,
        lkft-triage@lists.linaro.org, Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Arnd Bergmann <arnd@arndb.de>, Sven Schnelle <svens@linux.ibm.com>,
        Andreas Krebbel <krebbel@linux.ibm.com>,
        Nathan Chancellor <nathan@kernel.org>
Subject: Re: s390: s390x-linux-gnu-ld: Unexpected GOT/PLT entries detected!
Message-ID: <20240225175156.11025-A-hca@linux.ibm.com>
References: <CA+G9fYvWp8TY-fMEvc3UhoVtoR_eM5VsfHj3+n+kexcfJJ+Cvw@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+G9fYvWp8TY-fMEvc3UhoVtoR_eM5VsfHj3+n+kexcfJJ+Cvw@mail.gmail.com>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: LQXSFwhnYikiqOg8cJgSoU2rjG1vsRao
X-Proofpoint-GUID: LQXSFwhnYikiqOg8cJgSoU2rjG1vsRao
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-25_20,2024-02-23_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 priorityscore=1501 mlxscore=0 adultscore=0 clxscore=1011
 lowpriorityscore=0 malwarescore=0 spamscore=0 mlxlogscore=999 phishscore=0
 impostorscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2311290000 definitions=main-2402250142

On Fri, Feb 23, 2024 at 03:11:50PM +0530, Naresh Kamboju wrote:
> [ Please ignore this email if it is already reported ]
> 
> The s390 gcc-8 builds failed on Linux next tag next-20240215..next-20240223.
> First build failures noticed on tag next-20240215 for both gcc-13 and gcc-8.
> But from the next tag next-20240216 gcc-13 passed but gcc-8 failed.
> 
> s390:
>     - defconfig-fe40093d - gcc-8 - Failed
>     - tinyconfig - gcc-8 - Failed
>     - allnoconfig - gcc-8 - Failed
..
> Build log:
> ---------
> s390x-linux-gnu-ld: Unexpected GOT/PLT entries detected!
> make[3]: *** [/builds/linux/arch/s390/boot/Makefile:87:
> arch/s390/boot/vmlinux.syms] Error 1
> make[3]: Target 'arch/s390/boot/bzImage' not remade because of errors.
..
> Steps to reproduce:
>  $ tuxmake --runtime podman --target-arch s390 --toolchain gcc-8
> --kconfig tinyconfig
> 
> Links:
>  - https://qa-reports.linaro.org/lkft/linux-next-master/build/next-20240223/testrun/22812529/suite/build/test/gcc-8-defconfig-fe40093d/details/
>  - https://storage.tuxsuite.com/public/linaro/lkft/builds/2cl8pys1B3Vc4oOB2yXcaYkfnKw/

Thanks should hopefully be fixed with the patch below, which should be
part of the next linux-next release.

https://git.kernel.org/pub/scm/linux/kernel/git/s390/linux.git/commit/?h=features&id=a795e5d2347def129734a7f247ac70339d50d8c2

From a795e5d2347def129734a7f247ac70339d50d8c2 Mon Sep 17 00:00:00 2001
From: Heiko Carstens <hca@linux.ibm.com>
Date: Sun, 25 Feb 2024 17:39:12 +0100
Subject: [PATCH] s390: vmlinux.lds.S: fix .got.plt assertion

Naresh reported this build error on linux-next:

s390x-linux-gnu-ld: Unexpected GOT/PLT entries detected!
make[3]: *** [/builds/linux/arch/s390/boot/Makefile:87:
arch/s390/boot/vmlinux.syms] Error 1
make[3]: Target 'arch/s390/boot/bzImage' not remade because of errors.

The reason for the build error is an incorrect/incomplete assertion which
checks the size of the .got.plt section. Similar to x86 the size is either
zero or 24 bytes (three entries).

See commit 262b5cae67a6 ("x86/boot/compressed: Move .got.plt entries out of
the .got section") for more details. The three reserved/additional entries
for s390 are described in chapter 3.2.2 of the s390x ABI [1] (thanks to
Andreas Krebbel for pointing this out!).

[1] https://github.com/IBM/s390x-abi/releases/download/v1.6.1/lzsabi_s390x.pdf

Reported-by: Naresh Kamboju <naresh.kamboju@linaro.org>
Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>
Closes: https://lore.kernel.org/all/CA+G9fYvWp8TY-fMEvc3UhoVtoR_eM5VsfHj3+n+kexcfJJ+Cvw@mail.gmail.com
Fixes: 30226853d6ec ("s390: vmlinux.lds.S: explicitly handle '.got' and '.plt' sections")
Signed-off-by: Heiko Carstens <hca@linux.ibm.com>
---
 arch/s390/boot/vmlinux.lds.S   | 11 ++++++++---
 arch/s390/kernel/vmlinux.lds.S | 11 ++++++++---
 2 files changed, 16 insertions(+), 6 deletions(-)

diff --git a/arch/s390/boot/vmlinux.lds.S b/arch/s390/boot/vmlinux.lds.S
index e3208893ba6b..3d7ea585ab99 100644
--- a/arch/s390/boot/vmlinux.lds.S
+++ b/arch/s390/boot/vmlinux.lds.S
@@ -144,13 +144,18 @@ SECTIONS
 	ELF_DETAILS
 
 	/*
-	 * Sections that should stay zero sized, which is safer to
-	 * explicitly check instead of blindly discarding.
+	 * Make sure that the .got.plt is either completely empty or it
+	 * contains only the three reserved double words.
 	 */
 	.got.plt : {
 		*(.got.plt)
 	}
-	ASSERT(SIZEOF(.got.plt) == 0, "Unexpected GOT/PLT entries detected!")
+	ASSERT(SIZEOF(.got.plt) == 0 || SIZEOF(.got.plt) == 0x18, "Unexpected GOT/PLT entries detected!")
+
+	/*
+	 * Sections that should stay zero sized, which is safer to
+	 * explicitly check instead of blindly discarding.
+	 */
 	.plt : {
 		*(.plt) *(.plt.*) *(.iplt) *(.igot .igot.plt)
 	}
diff --git a/arch/s390/kernel/vmlinux.lds.S b/arch/s390/kernel/vmlinux.lds.S
index 404883b1b023..9c59715d1745 100644
--- a/arch/s390/kernel/vmlinux.lds.S
+++ b/arch/s390/kernel/vmlinux.lds.S
@@ -266,13 +266,18 @@ SECTIONS
 	ELF_DETAILS
 
 	/*
-	 * Sections that should stay zero sized, which is safer to
-	 * explicitly check instead of blindly discarding.
+	 * Make sure that the .got.plt is either completely empty or it
+	 * contains only the three reserved double words.
 	 */
 	.got.plt : {
 		*(.got.plt)
 	}
-	ASSERT(SIZEOF(.got.plt) == 0, "Unexpected GOT/PLT entries detected!")
+	ASSERT(SIZEOF(.got.plt) == 0 || SIZEOF(.got.plt) == 0x18, "Unexpected GOT/PLT entries detected!")
+
+	/*
+	 * Sections that should stay zero sized, which is safer to
+	 * explicitly check instead of blindly discarding.
+	 */
 	.plt : {
 		*(.plt) *(.plt.*) *(.iplt) *(.igot .igot.plt)
 	}
-- 
2.43.2


