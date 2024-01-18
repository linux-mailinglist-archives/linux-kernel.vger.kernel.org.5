Return-Path: <linux-kernel+bounces-30050-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 25B77831871
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 12:28:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DA2B1285D4C
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 11:28:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D270241F2;
	Thu, 18 Jan 2024 11:28:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="bqVveGw8"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 156B323776
	for <linux-kernel@vger.kernel.org>; Thu, 18 Jan 2024 11:28:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705577309; cv=none; b=EQnr1sTCJUrt9IEGKcduXNabgWazLgNb+BB4qUywSKaNiYpoxf8mElql9ZYndYpJ/CHfgbkb3ou7Y6/zOwamcnBRFV/oby0Ym3k7pcMZuAC2cUFaDHquWzCr9sqt9vsOTls6l79gCmexkQ9332ZwccwQcJFe4k8x3PMmu60jTzY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705577309; c=relaxed/simple;
	bh=OAqB/Umati0NjsiD1F2G7p+0eWVP5nxHXNKe4heLHdY=;
	h=Received:DKIM-Signature:Received:Received:Received:Message-ID:
	 Date:MIME-Version:User-Agent:Subject:Content-Language:To:CC:
	 References:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 X-Originating-IP:X-ClientProxiedBy:X-QCInternal:
	 X-Proofpoint-Virus-Version:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-GUID:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details; b=Z8kTKzzlS5S2JOUmLQyvHtdgUlziFleFe+q7FXOtk2/pf/YlJTmOL0LSkKVNWUPGZicfLYDx1t75ezEW4sEXg3ZAY+aFRlVbiBssoGh9Mrho3ahM7VW7xxmYIzX+24RsvHAn/ijHnRiBlsyXRwovH6vdhdp7TwpgE6X+ccEX36s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=bqVveGw8; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 40I602gl004450;
	Thu, 18 Jan 2024 11:27:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=IoaCXp2bZnlOp0cjfLp4rHUzRkV2pKD6nav2X3Gxi60=; b=bq
	VveGw8yBE0/P537ZDzsC8MGu500Y5bu+zNNf48qRUzGWjOGj5m5hDmFJ1xCsn0LG
	ODKapGvqk9DEapRTvzNy/wqvEgWe09mzKM21KVMpf+4zxG27VSNlazkGjQt7jwkL
	sPmVH7cfzBQeNrj+fW7Y8UCenSrbSWYo3V1Aww1sQUmYUNyXXTTLA0lfJQffeN1+
	MLkPUiy7JuKQ1NLPnr7SbVv0r0CkSfH+0rdbKzVYaZYbPwiR8dlJAHeM5QTw4WmM
	4IFNyazanGxw1MUCMvV0oqUktaF8URlzuSe+WESw07vAyXqHpF/S66o2+6YivuPo
	+cIQ1H4xe05xzQCuFWLQ==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3vpx8sgsxf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 18 Jan 2024 11:27:52 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 40IBRpQX018662
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 18 Jan 2024 11:27:51 GMT
Received: from [10.216.49.108] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Thu, 18 Jan
 2024 03:27:46 -0800
Message-ID: <cd742d1d-70a3-586b-4bf5-fcfc94c75b4a@quicinc.com>
Date: Thu, 18 Jan 2024 16:57:43 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] mm, kmsan: fix infinite recursion due to RCU critical
 section
Content-Language: en-US
To: Marco Elver <elver@google.com>, Andrew Morton <akpm@linux-foundation.org>
CC: Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov
	<dvyukov@google.com>,
        Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar
	<mingo@redhat.com>,
        Borislav Petkov <bp@alien8.de>,
        Dave Hansen
	<dave.hansen@linux.intel.com>, <x86@kernel.org>,
        "H. Peter Anvin"
	<hpa@zytor.com>, <kasan-dev@googlegroups.com>,
        <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
        <syzbot+93a9e8a3dea8d6085e12@syzkaller.appspotmail.com>
References: <20240118110022.2538350-1-elver@google.com>
 <CANpmjNPx0j-x_SDu777gaV1oOFuPmHV3xFfru56UzBXHnZhYLg@mail.gmail.com>
From: Charan Teja Kalla <quic_charante@quicinc.com>
In-Reply-To: <CANpmjNPx0j-x_SDu777gaV1oOFuPmHV3xFfru56UzBXHnZhYLg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: Rh-3EVEcIoOAH_xbT10Yj9vRa3gg77-3
X-Proofpoint-GUID: Rh-3EVEcIoOAH_xbT10Yj9vRa3gg77-3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-18_06,2024-01-17_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 spamscore=0
 phishscore=0 priorityscore=1501 mlxlogscore=999 impostorscore=0 mlxscore=0
 bulkscore=0 suspectscore=0 malwarescore=0 clxscore=1011 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2311290000
 definitions=main-2401180082

May I ask if KMSAN also instruments the access to the memory managed as
ZONE_DEVICE. You know this is not the RAM and also these pages will
never be onlined thus also not be available in buddy.

Reason for the ask is that this patch is introduced because of a race
between pfn walker ends up in pfn of zone device memory.

If KMSAN never instruments this, does it look good to you to have the
KMSAN version of pfn_valid(), as being suggested by Alexander in the
other mail.

Thanks,

On 1/18/2024 4:37 PM, Marco Elver wrote:
> On Thu, 18 Jan 2024 at 12:00, Marco Elver <elver@google.com> wrote:
>>
>> Alexander Potapenko writes in [1]: "For every memory access in the code
>> instrumented by KMSAN we call kmsan_get_metadata() to obtain the
>> metadata for the memory being accessed. For virtual memory the metadata
>> pointers are stored in the corresponding `struct page`, therefore we
>> need to call virt_to_page() to get them.
>>
>> According to the comment in arch/x86/include/asm/page.h,
>> virt_to_page(kaddr) returns a valid pointer iff virt_addr_valid(kaddr)
>> is true, so KMSAN needs to call virt_addr_valid() as well.
>>
>> To avoid recursion, kmsan_get_metadata() must not call instrumented
>> code, therefore ./arch/x86/include/asm/kmsan.h forks parts of
>> arch/x86/mm/physaddr.c to check whether a virtual address is valid or
>> not.
>>
>> But the introduction of rcu_read_lock() to pfn_valid() added
>> instrumented RCU API calls to virt_to_page_or_null(), which is called by
>> kmsan_get_metadata(), so there is an infinite recursion now.  I do not
>> think it is correct to stop that recursion by doing
>> kmsan_enter_runtime()/kmsan_exit_runtime() in kmsan_get_metadata(): that
>> would prevent instrumented functions called from within the runtime from
>> tracking the shadow values, which might introduce false positives."
>>
>> Fix the issue by switching pfn_valid() to the _sched() variant of
>> rcu_read_lock/unlock(), which does not require calling into RCU. Given
>> the critical section in pfn_valid() is very small, this is a reasonable
>> trade-off (with preemptible RCU).
>>
>> KMSAN further needs to be careful to suppress calls into the scheduler,
>> which would be another source of recursion. This can be done by wrapping
>> the call to pfn_valid() into preempt_disable/enable_no_resched(). The
>> downside is that this sacrifices breaking scheduling guarantees;
>> however, a kernel compiled with KMSAN has already given up any
>> performance guarantees due to being heavily instrumented.
>>
>> Note, KMSAN code already disables tracing via Makefile, and since
>> mmzone.h is included, it is not necessary to use the notrace variant,
>> which is generally preferred in all other cases.
>>
>> Link: https://lkml.kernel.org/r/20240115184430.2710652-1-glider@google.com [1]
>> Reported-by: Alexander Potapenko <glider@google.com>
>> Reported-by: syzbot+93a9e8a3dea8d6085e12@syzkaller.appspotmail.com
>> Signed-off-by: Marco Elver <elver@google.com>
>> Cc: Charan Teja Kalla <quic_charante@quicinc.com>
> 
> This might want a:
> 
> Fixes: 5ec8e8ea8b77 ("mm/sparsemem: fix race in accessing
> memory_section->usage")
> 
> For reference which patch introduced the problem.
> 
>> ---
>>  arch/x86/include/asm/kmsan.h | 17 ++++++++++++++++-
>>  include/linux/mmzone.h       |  6 +++---
>>  2 files changed, 19 insertions(+), 4 deletions(-)
>>
>> diff --git a/arch/x86/include/asm/kmsan.h b/arch/x86/include/asm/kmsan.h
>> index 8fa6ac0e2d76..d91b37f5b4bb 100644
>> --- a/arch/x86/include/asm/kmsan.h
>> +++ b/arch/x86/include/asm/kmsan.h
>> @@ -64,6 +64,7 @@ static inline bool kmsan_virt_addr_valid(void *addr)
>>  {
>>         unsigned long x = (unsigned long)addr;
>>         unsigned long y = x - __START_KERNEL_map;
>> +       bool ret;
>>
>>         /* use the carry flag to determine if x was < __START_KERNEL_map */
>>         if (unlikely(x > y)) {
>> @@ -79,7 +80,21 @@ static inline bool kmsan_virt_addr_valid(void *addr)
>>                         return false;
>>         }
>>
>> -       return pfn_valid(x >> PAGE_SHIFT);
>> +       /*
>> +        * pfn_valid() relies on RCU, and may call into the scheduler on exiting
>> +        * the critical section. However, this would result in recursion with
>> +        * KMSAN. Therefore, disable preemption here, and re-enable preemption
>> +        * below while suppressing reschedules to avoid recursion.
>> +        *
>> +        * Note, this sacrifices occasionally breaking scheduling guarantees.
>> +        * Although, a kernel compiled with KMSAN has already given up on any
>> +        * performance guarantees due to being heavily instrumented.
>> +        */
>> +       preempt_disable();
>> +       ret = pfn_valid(x >> PAGE_SHIFT);
>> +       preempt_enable_no_resched();
>> +
>> +       return ret;
>>  }
>>
>>  #endif /* !MODULE */
>> diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
>> index 4ed33b127821..a497f189d988 100644
>> --- a/include/linux/mmzone.h
>> +++ b/include/linux/mmzone.h
>> @@ -2013,9 +2013,9 @@ static inline int pfn_valid(unsigned long pfn)
>>         if (pfn_to_section_nr(pfn) >= NR_MEM_SECTIONS)
>>                 return 0;
>>         ms = __pfn_to_section(pfn);
>> -       rcu_read_lock();
>> +       rcu_read_lock_sched();
>>         if (!valid_section(ms)) {
>> -               rcu_read_unlock();
>> +               rcu_read_unlock_sched();
>>                 return 0;
>>         }
>>         /*
>> @@ -2023,7 +2023,7 @@ static inline int pfn_valid(unsigned long pfn)
>>          * the entire section-sized span.
>>          */
>>         ret = early_section(ms) || pfn_section_valid(ms, pfn);
>> -       rcu_read_unlock();
>> +       rcu_read_unlock_sched();
>>
>>         return ret;
>>  }
>> --
>> 2.43.0.381.gb435a96ce8-goog
>>

