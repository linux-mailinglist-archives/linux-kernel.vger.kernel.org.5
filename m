Return-Path: <linux-kernel+bounces-42498-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3ECA7840234
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 10:52:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 38F871C2228D
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 09:52:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C29E855E58;
	Mon, 29 Jan 2024 09:52:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="j0jzkhSf"
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD37856454;
	Mon, 29 Jan 2024 09:52:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706521950; cv=none; b=DDjfu5Yf6I9rylXTfXt6T/lMpyCNzv/x0zpULbUwoqQo2PvPR5p5qvGggdHix4ktLi8E7oLhkvHqXfwNwMaLV1QXvzkkBPi0OkpD3Vr8pcXYvv80JMpQBpc/fEUM+z00hm15i+za4m9zmwN0edgG41NS4FgYHokOIUn6Dea/WIo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706521950; c=relaxed/simple;
	bh=NNMnV6/XqYVObcJDjjFSIR8ZJrxTx8TNX1urQYZaPuQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EODXFSKoQef2XHKYb2uBjHRJKHa+WQQy90aEMDZ3n0kyIUPBtEoFLXjTPJYi95i538Lvs69YFFsm0l+yZOQBac9XCsB2MI5j9iKE/C1kc/3oYHl0jdN6YsgqXly7h2AyO9UhsNoaE1AsSFJKD4tswapstrFVNPCRRJH9h2fO8Ok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=j0jzkhSf; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353728.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 40T9oqJi031833;
	Mon, 29 Jan 2024 09:52:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pp1; bh=Ap8EPVjZkAWdncWJ2w24sLlk1zfoL/4eaEKlszJB7MY=;
 b=j0jzkhSfd70tYJQgEb3EzbTHO/+pjx9yqvxlGLZ3GoCbmJN+UbMofZ6GMTaKS29RHv5j
 ASuCRdNtgXvU/ahIRpcBJ/JP+lk5hflJCFszNgTP2jb/DE9Gp7N0IGfdwWp+9A+KG5i4
 /R4CdsYUxBKtniTEJNl+NnCUdT5jemDqRqcLhkRv1tGEH0H9GZmEjYspMnyZGcgHLW4+
 W+eqvM+BTep1Shcxl2cIknPDbp6Qa640iynxXZ5jvy95rrbM7Dfy2R+1V2CcZFk/zhHx
 6NOe0F+gZ2CyIjd8KQ87ZXaVJb5zpc05+frZ7oeWHq00H/hbsFdVd8uDBndk2BIWoHW3 Gw== 
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3vw20acq1v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 29 Jan 2024 09:52:17 +0000
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 40T923eL007964;
	Mon, 29 Jan 2024 09:51:51 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3vwdnkqa1u-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 29 Jan 2024 09:51:51 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 40T9pkcg32309508
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 29 Jan 2024 09:51:48 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id AD0F520043;
	Mon, 29 Jan 2024 09:51:46 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3D7DC2004D;
	Mon, 29 Jan 2024 09:51:46 +0000 (GMT)
Received: from osiris (unknown [9.171.85.65])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Mon, 29 Jan 2024 09:51:46 +0000 (GMT)
Date: Mon, 29 Jan 2024 10:51:44 +0100
From: Heiko Carstens <hca@linux.ibm.com>
To: Alexander Gordeev <agordeev@linux.ibm.com>
Cc: Frederic Weisbecker <frederic@kernel.org>, Ingo Molnar <mingo@kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Vasily Gorbik <gor@linux.ibm.com>, linux-kernel@vger.kernel.org,
        linux-s390@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH 4/5] s390/irq,nmi: do not include <linux/vtime.h> header
Message-ID: <20240129095144.6722-A-hca@linux.ibm.com>
References: <cover.1706470223.git.agordeev@linux.ibm.com>
 <966148629217b56139f40c38ffbb45ca229bd489.1706470223.git.agordeev@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <966148629217b56139f40c38ffbb45ca229bd489.1706470223.git.agordeev@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: Ddu0zDMunve_4609_7EK0mJRNnHf44_K
X-Proofpoint-ORIG-GUID: Ddu0zDMunve_4609_7EK0mJRNnHf44_K
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-29_06,2024-01-25_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=37 lowpriorityscore=0
 bulkscore=0 adultscore=0 clxscore=1015 spamscore=37 mlxlogscore=23
 phishscore=0 suspectscore=0 impostorscore=0 priorityscore=1501 mlxscore=37
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2401290071

On Sun, Jan 28, 2024 at 08:58:53PM +0100, Alexander Gordeev wrote:
> update_timer_sys() and update_timer_mcck() are inlines used for
> CPU time accounting from the interrupt and machine-check handlers.
> These routines are specific to s390 architecture, but declared
> via <linux/vtime.h> header, which in turn inludes <asm/vtime.h>.
> Avoid the extra loop and include <asm/vtime.h> header directly.
> 
> Signed-off-by: Alexander Gordeev <agordeev@linux.ibm.com>
> ---
>  arch/s390/kernel/irq.c | 1 +
>  arch/s390/kernel/nmi.c | 1 +
>  2 files changed, 2 insertions(+)
..
> +++ b/arch/s390/kernel/irq.c
> +#include <asm/vtime.h>
..
> +++ b/arch/s390/kernel/nmi.c
> +#include <asm/vtime.h>

It is confusing when the patch subject is "do not include.." and all
what this patch is doing is to add two includes. I see what this is
doing: getting rid of the implicit include of asm/vtime.h most likely
via linux/hardirq.h, but that's not very obvious.

Anyway:
Acked-by: Heiko Carstens <hca@linux.ibm.com>

