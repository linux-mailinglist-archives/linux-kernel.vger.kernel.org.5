Return-Path: <linux-kernel+bounces-24065-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4338F82B652
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 22:01:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B068D2887FE
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 21:01:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22D6958116;
	Thu, 11 Jan 2024 21:00:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VNSkD8+C"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAFE656759
	for <linux-kernel@vger.kernel.org>; Thu, 11 Jan 2024 21:00:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1705006848;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=B1KRmTouWwdRM/wgrsmvNieq1pQ0u5jKrKUYCCVf2lg=;
	b=VNSkD8+CYEuaAJ+eg40rMUKKyfzCM1wJVKMCs3TjZ/MC6HFVtAYZtz+LhutRGFKP/qZLFF
	ocByWCdA/FBvr7YMQ3lpzbfJFtacxQjZbtizD/UZ6GP8zdE1T69aDW2yhd1s5rCm/3DEk6
	3eWnzIFjJul20k6edcbbULUDfSzEgRg=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-344-HZzuTzLRMgy5rySGvgxZLg-1; Thu, 11 Jan 2024 16:00:46 -0500
X-MC-Unique: HZzuTzLRMgy5rySGvgxZLg-1
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-3368698f0caso3284488f8f.1
        for <linux-kernel@vger.kernel.org>; Thu, 11 Jan 2024 13:00:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705006846; x=1705611646;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :references:cc:to:content-language:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=B1KRmTouWwdRM/wgrsmvNieq1pQ0u5jKrKUYCCVf2lg=;
        b=VOB2rFD//ldQ+txFdNlHguTikjwyvREtAOGveDmLwqdtqAHi2Df9HcdhUaSeQI+43V
         yAUbfG+m62mqrLBw58E0e2tvN1cK7rf0mrXTAcEqafdFN3Mfh7T/IHj4RVp9Kafb+C6V
         E4ghDgYoCECSo0cHSScfd+BE6cM7ENMUAvTYruNaRuBLQ+eSWvJ3j1d1GDWp9J/PZmCQ
         IQdviqd3roDWfOxTkGk16DKczuVdNxlmDHXwd/ktIjc88tGcMARZr5NF4C9+WSEDzTSN
         +VQq4PkwYgdyXJA6ZM9atpCY2Sg/GexrpV7HyU8jJxM8l8JKMzAgaLM2d7evDGfbsEw2
         s57A==
X-Gm-Message-State: AOJu0YwIGJ8XvpTVqop2NFYoekzJvGZ1ioOyjnZzkJIghX4BoN9yqUJF
	r5akS9x7hG0EUimmwMpi2BLWyeE8I58RZr1DYXfdmSAv7HgedGFAgCXwJ/p9znUN+WgTwugty3s
	gaNpyN8u54Ug8VjBr65h0+2vQqbZRJoXi
X-Received: by 2002:a05:6000:120d:b0:336:6d00:8bf8 with SMTP id e13-20020a056000120d00b003366d008bf8mr92883wrx.286.1705006845723;
        Thu, 11 Jan 2024 13:00:45 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEY6CZLsgY2+Bg/7GJy8PEu0K14eULTl1vOA8KzX2YvqU4YX6SOpQxA97yODUSrN+GusVcpdw==
X-Received: by 2002:a05:6000:120d:b0:336:6d00:8bf8 with SMTP id e13-20020a056000120d00b003366d008bf8mr92877wrx.286.1705006845349;
        Thu, 11 Jan 2024 13:00:45 -0800 (PST)
Received: from ?IPV6:2003:cb:c747:f900:6099:1901:b863:450f? (p200300cbc747f90060991901b863450f.dip0.t-ipconnect.de. [2003:cb:c747:f900:6099:1901:b863:450f])
        by smtp.gmail.com with ESMTPSA id h18-20020adf9cd2000000b00336a1f6ce7csm2034704wre.19.2024.01.11.13.00.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 11 Jan 2024 13:00:44 -0800 (PST)
Message-ID: <bf9dbc58-35c4-4a35-b194-6d8d9e7e4923@redhat.com>
Date: Thu, 11 Jan 2024 22:00:43 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [syzbot] [mm?] kernel BUG in move_pages
Content-Language: en-US
To: Suren Baghdasaryan <surenb@google.com>
Cc: syzbot <syzbot+705209281e36404998f6@syzkaller.appspotmail.com>,
 Peter Xu <peterx@redhat.com>, aarcange@redhat.com,
 akpm@linux-foundation.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 syzkaller-bugs@googlegroups.com
References: <00000000000011d709060eadffd3@google.com>
 <CAJuCfpG-8w_KQ8bWvSr=GrXM+Jx3YKn5DqTFJU2MaMojML_a-A@mail.gmail.com>
 <CAJuCfpFfKYn+G1+puQ0KxzWCnbfFT51tKwV8MnrP7YZcJAORwg@mail.gmail.com>
 <CAJuCfpHTAAPEjMLrcxyG8zW7HA47EinB8CQfKGmBw7gGxqQ=vA@mail.gmail.com>
 <5ed23cf3-eedd-44aa-a498-d2a9ab046535@redhat.com>
 <CAJuCfpG5T71Sc46pB2eGpV7TreMZX2VZ-kDfaNmtn+etP0q9JA@mail.gmail.com>
From: David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <CAJuCfpG5T71Sc46pB2eGpV7TreMZX2VZ-kDfaNmtn+etP0q9JA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 11.01.24 21:20, Suren Baghdasaryan wrote:
> On Thu, Jan 11, 2024 at 6:58 PM David Hildenbrand <david@redhat.com> wrote:
>>
>> On 11.01.24 19:34, Suren Baghdasaryan wrote:
>>> On Thu, Jan 11, 2024 at 8:44 AM Suren Baghdasaryan <surenb@google.com> wrote:
>>>>
>>>> On Thu, Jan 11, 2024 at 8:40 AM Suren Baghdasaryan <surenb@google.com> wrote:
>>>>>
>>>>> On Thu, Jan 11, 2024 at 8:25 AM syzbot
>>>>> <syzbot+705209281e36404998f6@syzkaller.appspotmail.com> wrote:
>>>>>>
>>>>>> Hello,
>>>>>>
>>>>>> syzbot found the following issue on:
>>>>>>
>>>>>> HEAD commit:    e2425464bc87 Add linux-next specific files for 20240105
>>>>>> git tree:       linux-next
>>>>>> console+strace: https://syzkaller.appspot.com/x/log.txt?x=14941cdee80000
>>>>>> kernel config:  https://syzkaller.appspot.com/x/.config?x=4056b9349f3da8c9
>>>>>> dashboard link: https://syzkaller.appspot.com/bug?extid=705209281e36404998f6
>>>>>> compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
>>>>>> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=125d0a09e80000
>>>>>> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=15bc7331e80000
>>>>>>
>>>>>> Downloadable assets:
>>>>>> disk image: https://storage.googleapis.com/syzbot-assets/2f738185e2cf/disk-e2425464.raw.xz
>>>>>> vmlinux: https://storage.googleapis.com/syzbot-assets/b248fcf4ea46/vmlinux-e2425464.xz
>>>>>> kernel image: https://storage.googleapis.com/syzbot-assets/a9945c8223f4/bzImage-e2425464.xz
>>>>>>
>>>>>> The issue was bisected to:
>>>>>>
>>>>>> commit adef440691bab824e39c1b17382322d195e1fab0
>>>>>> Author: Andrea Arcangeli <aarcange@redhat.com>
>>>>>> Date:   Wed Dec 6 10:36:56 2023 +0000
>>>>>>
>>>>>>       userfaultfd: UFFDIO_MOVE uABI
>>>>>>
>>>>>> bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=11cb6ea9e80000
>>>>>> final oops:     https://syzkaller.appspot.com/x/report.txt?x=13cb6ea9e80000
>>>>>> console output: https://syzkaller.appspot.com/x/log.txt?x=15cb6ea9e80000
>>>>>>
>>>>>> IMPORTANT: if you fix the issue, please add the following tag to the commit:
>>>>>> Reported-by: syzbot+705209281e36404998f6@syzkaller.appspotmail.com
>>>>>> Fixes: adef440691ba ("userfaultfd: UFFDIO_MOVE uABI")
>>>>>>
>>>>>>    do_one_initcall+0x128/0x680 init/main.c:1237
>>>>>>    do_initcall_level init/main.c:1299 [inline]
>>>>>>    do_initcalls init/main.c:1315 [inline]
>>>>>>    do_basic_setup init/main.c:1334 [inline]
>>>>>>    kernel_init_freeable+0x692/0xc30 init/main.c:1552
>>>>>>    kernel_init+0x1c/0x2a0 init/main.c:1442
>>>>>>    ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147
>>>>>>    ret_from_fork_asm+0x11/0x20 arch/x86/entry/entry_64.S:242
>>>>>> ------------[ cut here ]------------
>>>>>> kernel BUG at include/linux/page-flags.h:1035!
>>>>>> invalid opcode: 0000 [#1] PREEMPT SMP KASAN
>>>>>> CPU: 0 PID: 5068 Comm: syz-executor191 Not tainted 6.7.0-rc8-next-20240105-syzkaller #0
>>>>>> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 11/17/2023
>>>>>> RIP: 0010:PageAnonExclusive include/linux/page-flags.h:1035 [inline]
>>>>>
>>>>>   From a quick look, I think the new ioctl is being used against a
>>>>> file-backed page and that's why PageAnonExclusive() throws this error.
>>>>> I'll confirm if this is indeed the case and will add checks for that
>>>>> case. Thanks!
>>>>
>>>> Hmm. Looking at the reproducer it does not look like a file-backed
>>>> memory... Anyways, I'm on it.
>>>
>>> Looks like the test is trying to move the huge_zero_page. Wonder how
>>> we should handle this. Just fail or do something else? Adding David
>>> and Peter for feedback.
>>
>> You'll need some special-casing to handle that. But it should be fairly
>> easy.
> 
> Ok, so should we treat zeropage the same as PAE and map destination
> PTE/PMD to zeropage while clearing source PTE/PMD?

Likely yes. So it's transparent for user space what we are moving. (this 
sounds like an easy case to not require a prior write access just to 
move it)

-- 
Cheers,

David / dhildenb


