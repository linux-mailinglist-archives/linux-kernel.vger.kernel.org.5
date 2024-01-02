Return-Path: <linux-kernel+bounces-14520-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 54B97821E38
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 16:02:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CD4D21F22B1C
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 15:02:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF9D112E5E;
	Tue,  2 Jan 2024 15:02:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="llleeLZ1"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F00312E60;
	Tue,  2 Jan 2024 15:02:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353724.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 402Em3pb016145;
	Tue, 2 Jan 2024 15:01:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pp1; bh=5DfTXPVd/eM6V5PQwyJZ3YoyiYCR8XXYxNPU2tae1Gc=;
 b=llleeLZ1ol24GiW0XrAG7Le+6pmHGHMQalKuApVuZL2WIy3jo7ljmy4hSE5e6tp+tZCI
 K7vlZFeuiv/E2XmsdfxAtzSKVINYWDfieCmkYkctRCNpabzr8+KUB2nXusJwdly7neN5
 DNcOW+UTBpzWVsNnqIEaKs6c+2ubgK1P6dhBA8MeGloaMYN1rkRDWjy7SiLytVhZg7dr
 kiohKNQcV/E2v2ncOXMdqzzU/jcx3YS7/IL4HqvoW719XvhLL4njoj2FH+7frvcgGe8w
 aqSd5B4bEN+IyyWlW9shHwpg5pYi8PvXItMzqx1RVihM7lXWpI0URdLT+YWSkEX0GMUz XA== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3vcmjmgd3s-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 02 Jan 2024 15:01:48 +0000
Received: from m0353724.ppops.net (m0353724.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 402EnT7r021329;
	Tue, 2 Jan 2024 15:01:46 GMT
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3vcmjmgd2v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 02 Jan 2024 15:01:45 +0000
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 402F0adP017991;
	Tue, 2 Jan 2024 15:01:44 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 3vayrkd6r0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 02 Jan 2024 15:01:44 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 402F1f3350790732
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 2 Jan 2024 15:01:41 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 889F62004D;
	Tue,  2 Jan 2024 15:01:41 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3725820043;
	Tue,  2 Jan 2024 15:01:40 +0000 (GMT)
Received: from osiris (unknown [9.171.22.30])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Tue,  2 Jan 2024 15:01:40 +0000 (GMT)
Date: Tue, 2 Jan 2024 16:01:38 +0100
From: Heiko Carstens <hca@linux.ibm.com>
To: Ilya Leoshkevich <iii@linux.ibm.com>
Cc: Alexander Gordeev <agordeev@linux.ibm.com>,
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
Subject: Re: [PATCH v3 27/34] s390/irqflags: Do not instrument
 arch_local_irq_*() with KMSAN
Message-ID: <20240102150138.6306-E-hca@linux.ibm.com>
References: <20231213233605.661251-1-iii@linux.ibm.com>
 <20231213233605.661251-28-iii@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231213233605.661251-28-iii@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: fwlCQf0fqngEyUEwz2n1oINtNGsURlEU
X-Proofpoint-ORIG-GUID: 0BosCkKzyYZnSHJAxdZslg6QZCVj4M3P
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-02_04,2024-01-02_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015
 priorityscore=1501 malwarescore=0 mlxscore=0 impostorscore=0
 mlxlogscore=968 suspectscore=0 spamscore=0 bulkscore=0 lowpriorityscore=0
 adultscore=0 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2401020115

On Thu, Dec 14, 2023 at 12:24:47AM +0100, Ilya Leoshkevich wrote:
> KMSAN generates the following false positives on s390x:
> 
> [    6.063666] DEBUG_LOCKS_WARN_ON(lockdep_hardirqs_enabled())
> [         ...]
> [    6.577050] Call Trace:
> [    6.619637]  [<000000000690d2de>] check_flags+0x1fe/0x210
> [    6.665411] ([<000000000690d2da>] check_flags+0x1fa/0x210)
> [    6.707478]  [<00000000006cec1a>] lock_acquire+0x2ca/0xce0
> [    6.749959]  [<00000000069820ea>] _raw_spin_lock_irqsave+0xea/0x190
> [    6.794912]  [<00000000041fc988>] __stack_depot_save+0x218/0x5b0
> [    6.838420]  [<000000000197affe>] __msan_poison_alloca+0xfe/0x1a0
> [    6.882985]  [<0000000007c5827c>] start_kernel+0x70c/0xd50
> [    6.927454]  [<0000000000100036>] startup_continue+0x36/0x40
> 
> Between trace_hardirqs_on() and `stosm __mask, 3` lockdep thinks that
> interrupts are on, but on the CPU they are still off. KMSAN
> instrumentation takes spinlocks, giving lockdep a chance to see and
> complain about this discrepancy.
> 
> KMSAN instrumentation is inserted in order to poison the __mask
> variable. Disable instrumentation in the respective functions. They are
> very small and it's easy to see that no important metadata updates are
> lost because of this.
> 
> Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
> ---
>  arch/s390/include/asm/irqflags.h | 18 +++++++++++++++---
>  drivers/s390/char/sclp.c         |  2 +-
>  2 files changed, 16 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/s390/include/asm/irqflags.h b/arch/s390/include/asm/irqflags.h
> index 02427b205c11..7353a88b2ae2 100644
> --- a/arch/s390/include/asm/irqflags.h
> +++ b/arch/s390/include/asm/irqflags.h
> @@ -37,12 +37,19 @@ static __always_inline void __arch_local_irq_ssm(unsigned long flags)
>  	asm volatile("ssm   %0" : : "Q" (flags) : "memory");
>  }
>  
> -static __always_inline unsigned long arch_local_save_flags(void)
> +#ifdef CONFIG_KMSAN
> +#define ARCH_LOCAL_IRQ_ATTRIBUTES \
> +	noinline notrace __no_sanitize_memory __maybe_unused
> +#else
> +#define ARCH_LOCAL_IRQ_ATTRIBUTES __always_inline
> +#endif
> +
> +static ARCH_LOCAL_IRQ_ATTRIBUTES unsigned long arch_local_save_flags(void)
>  {

Please change this to lower case and long single lines, so it matches the
more common patterns:

#ifdef CONFIG_KMSAN
#define __arch_local_irq_attributes noinline notrace __no_sanitize_memory __maybe_unused
#else
#define __arch_local_irq_attributes __always_inline
#endif

static __arch_local_irq_attributes unsigned long arch_local_save_flags(void)

...

