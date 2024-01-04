Return-Path: <linux-kernel+bounces-16593-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3696F8240C0
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 12:35:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C4E9A1F2239A
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 11:35:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6996221362;
	Thu,  4 Jan 2024 11:34:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="QtvPnqN9"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 349B621113;
	Thu,  4 Jan 2024 11:34:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 404AHvBh020357;
	Thu, 4 Jan 2024 11:34:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pp1; bh=DaA85JZ3rfzvuiZT2nU5IqFu1BqiLfSbMwxD/EB8i9Q=;
 b=QtvPnqN97N2k9foVZDhNtmrMCiDh7vZfB6hiFUM5ej2zaAvoM+sROVyv5NyHqzzOg5n6
 RgSHCzptstyh3CJ/WWyw6m7AYL/F82+Qtzmx0roLaWwQIfTcmIXw2wcsy5/BgJOKFnMs
 sPE3aaWlq0RTr7xFhuRQMnX5bih59Vg4qmM9NBcPjmnAcwDk283/BdX/HxPq3jL4Lp63
 GFpvdj037rJweGJ0Wre17ufeeVGDwg9GHVqVIbVSPuKasR8zriF2S7rZz7Ad/dX2o8f6
 u98Yv0CD/Lu7URpDfBB+Fvmn1aQTWWyDRcSQJjdHukhi1gacyi7PgDoI/kL1234Gao4v eg== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3vdm4p87u7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 04 Jan 2024 11:34:20 +0000
Received: from m0356516.ppops.net (m0356516.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 404BQTXx032285;
	Thu, 4 Jan 2024 11:34:19 GMT
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3vdm4p87tp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 04 Jan 2024 11:34:19 +0000
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 404AUHJA019397;
	Thu, 4 Jan 2024 11:34:18 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3vc30sr1yw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 04 Jan 2024 11:34:18 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 404BYFI428508726
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 4 Jan 2024 11:34:15 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1912520040;
	Thu,  4 Jan 2024 11:34:15 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 347CD20043;
	Thu,  4 Jan 2024 11:34:14 +0000 (GMT)
Received: from osiris (unknown [9.171.1.64])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Thu,  4 Jan 2024 11:34:14 +0000 (GMT)
Date: Thu, 4 Jan 2024 12:34:12 +0100
From: Heiko Carstens <hca@linux.ibm.com>
To: Alexander Gordeev <agordeev@linux.ibm.com>
Cc: Ilya Leoshkevich <iii@linux.ibm.com>,
        Alexander Potapenko <glider@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Christoph Lameter <cl@linux.com>, David Rientjes <rientjes@google.com>,
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
Message-ID: <20240104113412.7040-A-hca@linux.ibm.com>
References: <20231213233605.661251-1-iii@linux.ibm.com>
 <20231213233605.661251-29-iii@linux.ibm.com>
 <20240102150531.6306-F-hca@linux.ibm.com>
 <ZZaCfsuuODGkdUHV@li-008a6a4c-3549-11b2-a85c-c5cc2836eea2.ibm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZZaCfsuuODGkdUHV@li-008a6a4c-3549-11b2-a85c-c5cc2836eea2.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: A-r5ni_NxO1svHGVXf-nj62fil3Gwpze
X-Proofpoint-ORIG-GUID: OVn0-Bn5itLqAoOpBhaSOLkGr5KeaBNy
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-04_07,2024-01-03_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 clxscore=1015
 impostorscore=0 bulkscore=0 mlxscore=0 mlxlogscore=678 malwarescore=0
 spamscore=0 priorityscore=1501 adultscore=0 phishscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2401040088

On Thu, Jan 04, 2024 at 11:03:42AM +0100, Alexander Gordeev wrote:
> On Tue, Jan 02, 2024 at 04:05:31PM +0100, Heiko Carstens wrote:
> Hi Heiko,
> ...
> > > @@ -253,9 +253,17 @@ static unsigned long setup_kernel_memory_layout(void)
> > >  	MODULES_END = round_down(__abs_lowcore, _SEGMENT_SIZE);
> > >  	MODULES_VADDR = MODULES_END - MODULES_LEN;
> > >  	VMALLOC_END = MODULES_VADDR;
> > > +#ifdef CONFIG_KMSAN
> > > +	VMALLOC_END -= MODULES_LEN * 2;
> > > +#endif
> > >  
> > >  	/* allow vmalloc area to occupy up to about 1/2 of the rest virtual space left */
> > >  	vmalloc_size = min(vmalloc_size, round_down(VMALLOC_END / 2, _REGION3_SIZE));
> > > +#ifdef CONFIG_KMSAN
> > > +	/* take 2/3 of vmalloc area for KMSAN shadow and origins */
> > > +	vmalloc_size = round_down(vmalloc_size / 3, _REGION3_SIZE);
> > > +	VMALLOC_END -= vmalloc_size * 2;
> > > +#endif
> > 
> > Please use
> > 
> > 	if (IS_ENABLED(CONFIG_KMSAN))
> > 
> > above, since this way we get more compile time checks.
> 
> This way we will get a mixture of CONFIG_KASAN and CONFIG_KMSAN
> #ifdef vs IS_ENABLED() checks within one function. I guess, we
> would rather address it with a separate cleanup?

I don't think so, since you can't convert the CONFIG_KASAN ifdef to
IS_ENABLED() here: it won't compile.

But IS_ENABLED(CONFIG_KMSAN) should work. I highly prefer IS_ENABLED() over
ifdef since it allows for better compile time checks, and you won't be
surprised by code that doesn't compile if you just change a config option.
We've seen that way too often.

