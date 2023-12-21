Return-Path: <linux-kernel+bounces-8319-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 62C7381B595
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 13:15:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 92B1D1C235EE
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 12:15:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 005F86E59A;
	Thu, 21 Dec 2023 12:15:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="XIppQUEf"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0F786A02A;
	Thu, 21 Dec 2023 12:15:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3BLC5C9d011325;
	Thu, 21 Dec 2023 12:14:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pp1; bh=WZOSdZ1fWVmBniRZaqNNU9+365ekrwzEre4sZEIZQFY=;
 b=XIppQUEfRY1LtrKBhUVMo3bV6Tzft1sy5cmdjqQ0cXYNzq4dQSw/ni5Kya4tKNtkoXRv
 ILbnFG1UsMSul8QykzoQv1Fj/GaTzKxwJl1wVD0QGW33DcgCLb5q1sIyNTh+3Xa8hxPF
 bM6D48RMG+N3kjPo+EHPoDIleXUKxKV+i92o4xz/ihbZZY9vXPQCZO/XOTr+kk0b5n6i
 Pf4mrIwNMU9FTb3FLY4luj3Ib0YkkgrUDOAGlpo/8AIz7mlJ2A0JVGlP4cZ8uJgF0fx7
 E/KFLj7FIYf9ee2FNOo5GNuYsJrus8wHusasPj5KAje2VKwQK32ePGoJf4TlOz9gec2z SA== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3v4j3fykrf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 21 Dec 2023 12:14:26 +0000
Received: from m0360072.ppops.net (m0360072.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3BLBKEuH001091;
	Thu, 21 Dec 2023 12:14:25 GMT
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3v4j3fykqc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 21 Dec 2023 12:14:25 +0000
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 3BLB80DO012308;
	Thu, 21 Dec 2023 12:14:24 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 3v1rx24abt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 21 Dec 2023 12:14:24 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 3BLCELCW19333772
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 21 Dec 2023 12:14:21 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8CFC520043;
	Thu, 21 Dec 2023 12:14:21 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1D09B2004B;
	Thu, 21 Dec 2023 12:14:20 +0000 (GMT)
Received: from li-008a6a4c-3549-11b2-a85c-c5cc2836eea2.ibm.com (unknown [9.171.57.36])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Thu, 21 Dec 2023 12:14:20 +0000 (GMT)
Date: Thu, 21 Dec 2023 13:14:17 +0100
From: Alexander Gordeev <agordeev@linux.ibm.com>
To: Ilya Leoshkevich <iii@linux.ibm.com>
Cc: Alexander Potapenko <glider@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Christoph Lameter <cl@linux.com>, David Rientjes <rientjes@google.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>, Marco Elver <elver@google.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Pekka Enberg <penberg@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Vasily Gorbik <gor@linux.ibm.com>, Vlastimil Babka <vbabka@suse.cz>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Hyeonggon Yoo <42.hyeyoo@gmail.com>, kasan-dev@googlegroups.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-s390@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
        Mark Rutland <mark.rutland@arm.com>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Sven Schnelle <svens@linux.ibm.com>
Subject: Re: [PATCH v3 28/34] s390/mm: Define KMSAN metadata for vmalloc and
 modules
Message-ID: <ZYQsGbr7HlQjlJRs@li-008a6a4c-3549-11b2-a85c-c5cc2836eea2.ibm.com>
References: <20231213233605.661251-1-iii@linux.ibm.com>
 <20231213233605.661251-29-iii@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231213233605.661251-29-iii@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: gQs6F1yHCC4oP4FjDomkOokf6MZGQMPK
X-Proofpoint-ORIG-GUID: Ga5RPJKS0qpjMpHhRYad4Qum2jq5TvYL
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-21_05,2023-12-20_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 spamscore=0
 priorityscore=1501 mlxlogscore=999 lowpriorityscore=0 bulkscore=0
 suspectscore=0 malwarescore=0 impostorscore=0 clxscore=1011 mlxscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2312210091

On Thu, Dec 14, 2023 at 12:24:48AM +0100, Ilya Leoshkevich wrote:
> The pages for the KMSAN metadata associated with most kernel mappings
> are taken from memblock by the common code. However, vmalloc and module
> metadata needs to be defined by the architectures.
> 
> Be a little bit more careful than x86: allocate exactly MODULES_LEN
> for the module shadow and origins, and then take 2/3 of vmalloc for
> the vmalloc shadow and origins. This ensures that users passing small
> vmalloc= values on the command line do not cause module metadata
> collisions.
> 
> Reviewed-by: Alexander Potapenko <glider@google.com>
> Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
> ---
>  arch/s390/boot/startup.c        |  8 ++++++++
>  arch/s390/include/asm/pgtable.h | 10 ++++++++++
>  2 files changed, 18 insertions(+)
> 
> diff --git a/arch/s390/boot/startup.c b/arch/s390/boot/startup.c
> index 8104e0e3d188..e37e7ffda430 100644
> --- a/arch/s390/boot/startup.c
> +++ b/arch/s390/boot/startup.c
> @@ -253,9 +253,17 @@ static unsigned long setup_kernel_memory_layout(void)
>  	MODULES_END = round_down(__abs_lowcore, _SEGMENT_SIZE);
>  	MODULES_VADDR = MODULES_END - MODULES_LEN;
>  	VMALLOC_END = MODULES_VADDR;
> +#ifdef CONFIG_KMSAN
> +	VMALLOC_END -= MODULES_LEN * 2;
> +#endif
>  
>  	/* allow vmalloc area to occupy up to about 1/2 of the rest virtual space left */
>  	vmalloc_size = min(vmalloc_size, round_down(VMALLOC_END / 2, _REGION3_SIZE));

Since commit 2a65c6e1ad06 ("s390/boot: always align vmalloc area on segment boundary")
vmalloc_size is aligned on _SEGMENT_SIZE boundary.

> +#ifdef CONFIG_KMSAN
> +	/* take 2/3 of vmalloc area for KMSAN shadow and origins */
> +	vmalloc_size = round_down(vmalloc_size / 3, _REGION3_SIZE);

And thus, the alignment here should be _SEGMENT_SIZE as well.

> +	VMALLOC_END -= vmalloc_size * 2;
> +#endif
>  	VMALLOC_START = VMALLOC_END - vmalloc_size;
>  
>  	/* split remaining virtual space between 1:1 mapping & vmemmap array */

...

With the above fixup:
Acked-by: Alexander Gordeev <agordeev@linux.ibm.com>

Thanks!

