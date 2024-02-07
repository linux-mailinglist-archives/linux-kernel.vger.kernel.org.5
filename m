Return-Path: <linux-kernel+bounces-56601-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F211A84CC68
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 15:13:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AE9BD287AFC
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 14:13:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88FEE77F0E;
	Wed,  7 Feb 2024 14:13:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="a0A3NoJh"
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 421A877658;
	Wed,  7 Feb 2024 14:13:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707315195; cv=none; b=MbHQA+doKLZD6h33JOlREJ0I3doWSLJ1dE/nkVze7BBueDtvSWpk8crAf0MrcC7051Y0aSnd+jwY30Rg9evGqiIp3LyiOmEPKgNN64L7ra09/sku/3n7FYLoY81kmeV3XbDn4BwFBQgBGqU+EqgIPnLHD1D9vPxnFFIVTDfuiS4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707315195; c=relaxed/simple;
	bh=gwH2gW0FnuxRVKwAAt2yOec201/07KaXUQlk8qLfDZU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EqC9Q10IwgEYWvrMRS+W9jMJqy7kpPCzkl4bkSmhr1nCzumDID3bCEKWc3M9NpHU4nRwIA0XTY5jgJMTvnjimbHay+WNJKeKVUsTuFLGCrT8Ce4sP2iLLG+WVBxLTo3b/EqnZb3HMkkek/qN0YSOX2peno5Nx+o1vhVyiyCtDpc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=a0A3NoJh; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 417DPYtk019413;
	Wed, 7 Feb 2024 14:13:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pp1; bh=gwH2gW0FnuxRVKwAAt2yOec201/07KaXUQlk8qLfDZU=;
 b=a0A3NoJh1Spx+I0IuZTi7I411DRRGjhhQOoSoeugeBKDsijx9EVulSk1OFogWAoetGPy
 R8z44MwNDpSc3ePyFrgDHnrZ2Q/tFhDllVbmuVNEGIcsHS3d/Wbsmfwiv+HQXK1uBDOB
 RbDa+PPvQdc7NyVnLCTyr7OI+i5ZNRtUvIAC8JIUbNepGHHNj4Ak+4xOvYET3qiaHtNu
 Muto3nCHriEe+lPXnvOfMSfml5jRh9ImAqut/fRtW4xP6M1uALpfk8dozAhzAhwJ2TdT
 26igZiHU4+hbNoUMHZSgInqRWxA27nerpiauSTkIT6/es6c5RXhpzRVT5IJAFuaE2qhl Nw== 
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3w4a402jae-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 07 Feb 2024 14:13:04 +0000
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 417COK4X016148;
	Wed, 7 Feb 2024 14:13:02 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 3w22h25n5q-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 07 Feb 2024 14:13:02 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 417ECxtx18744014
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 7 Feb 2024 14:12:59 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3080020043;
	Wed,  7 Feb 2024 14:12:59 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id EFEA620040;
	Wed,  7 Feb 2024 14:12:58 +0000 (GMT)
Received: from li-008a6a4c-3549-11b2-a85c-c5cc2836eea2.ibm.com (unknown [9.155.204.135])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Wed,  7 Feb 2024 14:12:58 +0000 (GMT)
Date: Wed, 7 Feb 2024 15:12:57 +0100
From: Alexander Gordeev <agordeev@linux.ibm.com>
To: Frederic Weisbecker <frederic@kernel.org>
Cc: Ingo Molnar <mingo@kernel.org>, Michael Ellerman <mpe@ellerman.id.au>,
        Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH 5/5] sched/vtime: do not include <asm/vtime.h> header
Message-ID: <ZcOP6bm0ekxDUVk6@li-008a6a4c-3549-11b2-a85c-c5cc2836eea2.ibm.com>
References: <cover.1706470223.git.agordeev@linux.ibm.com>
 <2402f44309e1c9705501bdc9b798e8fe6d73f905.1706470223.git.agordeev@linux.ibm.com>
 <ZcLBAKMJ5Vbbm2Ln@localhost.localdomain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZcLBAKMJ5Vbbm2Ln@localhost.localdomain>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: ZUgQbDIIA_epP8KRIveyfx_KgUblcvVb
X-Proofpoint-GUID: ZUgQbDIIA_epP8KRIveyfx_KgUblcvVb
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-07_04,2024-01-31_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 suspectscore=0
 clxscore=1015 malwarescore=0 mlxscore=0 phishscore=0 mlxlogscore=361
 bulkscore=0 priorityscore=1501 impostorscore=0 adultscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2402070105

On Wed, Feb 07, 2024 at 12:30:08AM +0100, Frederic Weisbecker wrote:
> Reviewed-by: Frederic Weisbecker <frederic@kernel.org>

Thank you for the review, Frederic!

The Heiko comment is valid and I would add this chunk in v2:

--- a/arch/powerpc/include/asm/Kbuild
+++ b/arch/powerpc/include/asm/Kbuild
@@ -6,5 +6,4 @@ generic-y += agp.h
 generic-y += kvm_types.h
 generic-y += mcs_spinlock.h
 generic-y += qrwlock.h
-generic-y += vtime.h
 generic-y += early_ioremap.h

Would you keep your Reviewed-by?

