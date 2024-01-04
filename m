Return-Path: <linux-kernel+bounces-16480-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D632B823F2C
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 11:04:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5BBC01F25234
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 10:04:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19ADB20B05;
	Thu,  4 Jan 2024 10:04:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="PwamUfyZ"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D271420B00;
	Thu,  4 Jan 2024 10:04:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353728.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 4048r1Vv014717;
	Thu, 4 Jan 2024 10:03:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pp1; bh=mEC9RU/7gJsuNRS5VA9HyG1hQ3z9kUtySW0uefqhic4=;
 b=PwamUfyZQwMs7zqqv7AyyQ4T/H/ZuwF2rNasPDug3qz4BcWe4HRu5C2VzK8O2nzthgtw
 IpjAN+oFwhnI1JsI8v0VlD2eEPeVRMFs5peKPXBAIEb18WLGyIS5m2FmtBXuz8XVEM54
 RiAxrADaVI5Heg3TcSrUAcuyog3CU2Y2VzWsuXa87vQ1rd/DoH+p1uEV/qPhmGAC2MnR
 0mduIbJXj8fJIuY7CwHXivFZpfoXaVQ5xipNO5Nb2UgW/CWKHgid7soEY/ZbGE/bZEeY
 4u3h339KxfgLQqk2gVkSMVcDySTQhYIncIR1M8F9AMphMM9GYwxv0zVCBSP2UgUgUDtW 0Q== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3vdsj1a7rh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 04 Jan 2024 10:03:50 +0000
Received: from m0353728.ppops.net (m0353728.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 4048sLms018434;
	Thu, 4 Jan 2024 10:03:50 GMT
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3vdsj1a7qx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 04 Jan 2024 10:03:49 +0000
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 4048PKj3024643;
	Thu, 4 Jan 2024 10:03:48 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 3vb082g0ew-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 04 Jan 2024 10:03:48 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 404A3jJr5178108
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 4 Jan 2024 10:03:45 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9B53B2004B;
	Thu,  4 Jan 2024 10:03:45 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1D71A20040;
	Thu,  4 Jan 2024 10:03:44 +0000 (GMT)
Received: from li-008a6a4c-3549-11b2-a85c-c5cc2836eea2.ibm.com (unknown [9.171.45.37])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Thu,  4 Jan 2024 10:03:44 +0000 (GMT)
Date: Thu, 4 Jan 2024 11:03:42 +0100
From: Alexander Gordeev <agordeev@linux.ibm.com>
To: Heiko Carstens <hca@linux.ibm.com>
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
Message-ID: <ZZaCfsuuODGkdUHV@li-008a6a4c-3549-11b2-a85c-c5cc2836eea2.ibm.com>
References: <20231213233605.661251-1-iii@linux.ibm.com>
 <20231213233605.661251-29-iii@linux.ibm.com>
 <20240102150531.6306-F-hca@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240102150531.6306-F-hca@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: nbfM0juIhZleyeD13N0-vwHlSIw9D1PP
X-Proofpoint-GUID: 48fRanwL7QTj7BMTM-SFy1C7v7RSY4Cv
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-04_05,2024-01-03_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 impostorscore=0 bulkscore=0 mlxscore=0 suspectscore=0 adultscore=0
 malwarescore=0 spamscore=0 mlxlogscore=676 clxscore=1015
 lowpriorityscore=0 phishscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2311290000 definitions=main-2401040075

On Tue, Jan 02, 2024 at 04:05:31PM +0100, Heiko Carstens wrote:
Hi Heiko,
...
> > @@ -253,9 +253,17 @@ static unsigned long setup_kernel_memory_layout(void)
> >  	MODULES_END = round_down(__abs_lowcore, _SEGMENT_SIZE);
> >  	MODULES_VADDR = MODULES_END - MODULES_LEN;
> >  	VMALLOC_END = MODULES_VADDR;
> > +#ifdef CONFIG_KMSAN
> > +	VMALLOC_END -= MODULES_LEN * 2;
> > +#endif
> >  
> >  	/* allow vmalloc area to occupy up to about 1/2 of the rest virtual space left */
> >  	vmalloc_size = min(vmalloc_size, round_down(VMALLOC_END / 2, _REGION3_SIZE));
> > +#ifdef CONFIG_KMSAN
> > +	/* take 2/3 of vmalloc area for KMSAN shadow and origins */
> > +	vmalloc_size = round_down(vmalloc_size / 3, _REGION3_SIZE);
> > +	VMALLOC_END -= vmalloc_size * 2;
> > +#endif
> 
> Please use
> 
> 	if (IS_ENABLED(CONFIG_KMSAN))
> 
> above, since this way we get more compile time checks.

This way we will get a mixture of CONFIG_KASAN and CONFIG_KMSAN
#ifdef vs IS_ENABLED() checks within one function. I guess, we
would rather address it with a separate cleanup?

Thanks!

