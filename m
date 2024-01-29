Return-Path: <linux-kernel+bounces-42497-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C61D840231
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 10:52:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C005C1F21F6C
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 09:52:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 712FC55E61;
	Mon, 29 Jan 2024 09:52:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="rLU1E9DN"
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1618556B7F;
	Mon, 29 Jan 2024 09:52:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706521938; cv=none; b=A58VIW69PN1B5lEBjod4iQPypWHy3knyFTbnpq1E95OtWZATi3e9C+lXqEQMvA1hdvVX4GtweXcLMA7qlWvLlkKbUze3lcF6i8qs4Dk21wDwwOY6S6GC5QTugLo5tZJDsjw8lzuSWeIgg5ogiEB+30gkvklMGpp9oLl7ZDsgkrk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706521938; c=relaxed/simple;
	bh=uFYfbyBb3QB9Kx+vf+lWm5+OWTDCsLCkrIZBgV2+gBs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PnSLDpHMHM4X/E61V4tgIsvetjfzi792lFpLu+h9o0pk/FP5RMOsksfygRWPT6FmriKUO6BiNdW3XPzGmq44y6BD3E4EjnfvcPE9rUw2SNWCC6FEaYCNuR3/0ArE1iUgdnYvdBaIbT745//aQpFUGckb0bjp2mFlT11l23eJ7OA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=rLU1E9DN; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 40T7TJIj020798;
	Mon, 29 Jan 2024 09:52:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pp1; bh=BpnskzCIPRxO+mdwfNMQkpA+FvWqoUu/O55FlHsnW8U=;
 b=rLU1E9DNXGpb73+2BAfRWUh4NM+b+R3bzKbw+Q/jTov1zrY6nxPVQztUflXrrgBqbiQP
 5hE9NaMYYou55ay1ZupPqWYRxzUkxAkb4AVIoVpS73YZ0SyDo9tnuFMCiKHGXgckho/C
 7hD6TchINtjlUHKmNwmFgAtIZSTRRwQBo0F9ubCTXGCXYVW1/OxuxNkWpDNulPX4TbZN
 ZHoiuO5mCkp8kIlq6Pz6xfzSCRPg6MNY4EgPaKnQ01meQhwarB6ZdiyvyqPTKswvKP+z
 zkDuNwxT3zaJRSuFdPYnAUeJwleg3fhAGr8ChmjYOq+QpM3ZnIGTTWKFRf7rU4BnRqPO CQ== 
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3vwudu72km-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 29 Jan 2024 09:52:06 +0000
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 40T8mdYA007979;
	Mon, 29 Jan 2024 09:52:05 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3vwdnkqa2j-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 29 Jan 2024 09:52:05 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 40T9q1vZ6816416
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 29 Jan 2024 09:52:02 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1C4DC2006C;
	Mon, 29 Jan 2024 09:52:01 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 95DF22007E;
	Mon, 29 Jan 2024 09:52:00 +0000 (GMT)
Received: from osiris (unknown [9.171.85.65])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Mon, 29 Jan 2024 09:52:00 +0000 (GMT)
Date: Mon, 29 Jan 2024 10:51:59 +0100
From: Heiko Carstens <hca@linux.ibm.com>
To: Alexander Gordeev <agordeev@linux.ibm.com>
Cc: Frederic Weisbecker <frederic@kernel.org>, Ingo Molnar <mingo@kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Vasily Gorbik <gor@linux.ibm.com>, linux-kernel@vger.kernel.org,
        linux-s390@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH 3/5] s390/vtime: remove unused
 __ARCH_HAS_VTIME_TASK_SWITCH leftover
Message-ID: <20240129095159.6722-B-hca@linux.ibm.com>
References: <cover.1706470223.git.agordeev@linux.ibm.com>
 <b3623605ba5c1d386d8f59e17c930ca2c3cca07c.1706470223.git.agordeev@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b3623605ba5c1d386d8f59e17c930ca2c3cca07c.1706470223.git.agordeev@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: jU2BpukHz2ZYmllku1UtAbzokScQaOop
X-Proofpoint-ORIG-GUID: jU2BpukHz2ZYmllku1UtAbzokScQaOop
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-29_05,2024-01-25_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011 bulkscore=0
 impostorscore=0 malwarescore=0 phishscore=0 spamscore=0 priorityscore=1501
 mlxscore=0 lowpriorityscore=0 suspectscore=0 adultscore=0 mlxlogscore=540
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2401290070

On Sun, Jan 28, 2024 at 08:58:52PM +0100, Alexander Gordeev wrote:
> __ARCH_HAS_VTIME_TASK_SWITCH macro is not used anymore.
> 
> Signed-off-by: Alexander Gordeev <agordeev@linux.ibm.com>
> ---
>  arch/s390/include/asm/vtime.h | 2 --
>  1 file changed, 2 deletions(-)

Acked-by: Heiko Carstens <hca@linux.ibm.com>

