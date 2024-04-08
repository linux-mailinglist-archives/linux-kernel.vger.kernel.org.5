Return-Path: <linux-kernel+bounces-135285-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AC0889BE65
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 13:50:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4657E2808BD
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 11:50:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B90E6A014;
	Mon,  8 Apr 2024 11:50:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="ad7xvLFh"
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96EAE6A004;
	Mon,  8 Apr 2024 11:50:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712577003; cv=none; b=iWerfz1Qv+aciD1GEMszC7cXdiJqn9FnX6MRla5ABWqMd2uelBkwUtPqVz0YsP6Q/EYY+CF4H3kPUeKlDLUcgFdHfdOAdnLHNhjJJvxyQl8k0M3wMeHkAnNShxfkRgpDh8lNtGdP56TvNHsACGrjrkzEI8VAYMo9ZLLzB6lbuuQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712577003; c=relaxed/simple;
	bh=2C+83G7Qg8cx//dOdpr8x7fJsrvBGPsl4sgTNc7EWB4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Hhwxm8JfcVXhpxtKx6sRiBuCpu/OJ3nnRaWwvEBCpb19t/7WyZGXxss0vhQfQW6lK9Xbp3VJS4U5PCgrxcZA8+yOLpgwZ0k3ARpkmwDksFDSVTyRu6bqyas40dPltzorUupKG+MhBzOH3TJVz/JAelPWRNYyo69j8nEWU4bCjEA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=ad7xvLFh; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 438BH2Ya007723;
	Mon, 8 Apr 2024 11:49:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pp1; bh=fBUkqDZ3IYqMXS9EkDuIUyapeXTdHgsmX/aKQ2vj1Pg=;
 b=ad7xvLFhTBX4QK4B33OfW5R0gyzsacionM3U3z5IZvjL9FWYQa2OG5OYVk85EzwgI1oE
 BCSNJiquK+WwCUda4ScjVXb12pd8+dG+Jdjorquz43RBus2EVDJR2Es7VxM7locSF8kd
 +A0xziJENq5JL+sw5FmIow79zmdAyfzapl15M9cWqS7c1Hbv0LwZ7qYuj/9NjpS5tswe
 qIShKD7FetRxBzyCkQ4mwqM8xCrI6g3cvqB8c3gKpoWYVjhR+4i7swQ4EQx319ph+XXU
 uX0EJPuQYYRPJjh1z8VK/U7OVDGn1gtQZ+cLDO+kqEvBBUFWEJMPl2gHE1p5Km2FQDdY Rg== 
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3xceue843k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 08 Apr 2024 11:49:57 +0000
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 438B6MhR019082;
	Mon, 8 Apr 2024 11:48:42 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3xbh4001am-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 08 Apr 2024 11:48:42 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 438BmaFA18219474
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 8 Apr 2024 11:48:38 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8FD652004F;
	Mon,  8 Apr 2024 11:48:36 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0296F2004E;
	Mon,  8 Apr 2024 11:48:36 +0000 (GMT)
Received: from osiris (unknown [9.171.19.167])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Mon,  8 Apr 2024 11:48:35 +0000 (GMT)
Date: Mon, 8 Apr 2024 13:48:34 +0200
From: Heiko Carstens <hca@linux.ibm.com>
To: Thorsten Blum <thorsten.blum@toblux.com>
Cc: Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Ilya Leoshkevich <iii@linux.ibm.com>, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] s390/smp: Use min() to fix Coccinelle warning
Message-ID: <20240408114834.9447-B-hca@linux.ibm.com>
References: <20240408105124.2162-2-thorsten.blum@toblux.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240408105124.2162-2-thorsten.blum@toblux.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: rQoebr9-ZHQAPjHPh-UDyFccSYBUn8Ho
X-Proofpoint-ORIG-GUID: rQoebr9-ZHQAPjHPh-UDyFccSYBUn8Ho
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-08_10,2024-04-05_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 mlxlogscore=749 clxscore=1011 phishscore=0 suspectscore=0 bulkscore=0
 adultscore=0 spamscore=0 lowpriorityscore=0 malwarescore=0 impostorscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2404010000 definitions=main-2404080090

On Mon, Apr 08, 2024 at 12:51:25PM +0200, Thorsten Blum wrote:
> Fixes the following Coccinelle/coccicheck warning reported by
> minmax.cocci:
> 
> 	WARNING opportunity for min()
> 
> Signed-off-by: Thorsten Blum <thorsten.blum@toblux.com>
> ---
>  arch/s390/kernel/smp.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/s390/kernel/smp.c b/arch/s390/kernel/smp.c
> index 0324649aae0a..d69cf2475744 100644
> --- a/arch/s390/kernel/smp.c
> +++ b/arch/s390/kernel/smp.c
> @@ -1205,7 +1205,7 @@ static int __init s390_smp_init(void)
>  
>  	rc = cpuhp_setup_state(CPUHP_AP_ONLINE_DYN, "s390/smp:online",
>  			       smp_cpu_online, smp_cpu_pre_down);
> -	rc = rc <= 0 ? rc : 0;
> +	rc = min(rc, 0);

No. This decreases readability. Please do not send such patches just
because Coccinelle reports something.

