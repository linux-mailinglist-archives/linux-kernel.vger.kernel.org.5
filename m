Return-Path: <linux-kernel+bounces-26482-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CB7C82E1D7
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 21:35:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 00A63B21DD7
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 20:35:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F6FA1AABE;
	Mon, 15 Jan 2024 20:35:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="G76hveRv"
Received: from mail-vs1-f50.google.com (mail-vs1-f50.google.com [209.85.217.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4482F1AAA5
	for <linux-kernel@vger.kernel.org>; Mon, 15 Jan 2024 20:35:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-vs1-f50.google.com with SMTP id ada2fe7eead31-469531dd926so330817137.2
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jan 2024 12:35:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1705350913; x=1705955713; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=vMS0J/7CyXgLKOAf0V+IWQO6ynhdDfGM83qwFs2ZDn0=;
        b=G76hveRvX0AzVKGahtaVXGRdK3o6kP6AQgF/iHLF5ly5ULvRl5gRur/MfIP7mdizaZ
         rG8XBuqX5iNwYsRAFY8uF4npo+5xsjRvpaHZ3X76G2xXm5LzciJrtbs292zzobPJceUo
         mcs1tCjXklfcrkHViNBtL03pZHrjnWNUFBZEG3cOMB9h8fJrRQ+xhZOGXvTEOGxCz1Pc
         FDHhMRECHSs2nZvY2UPCOfdTLapdrJrwidWbmkLcm5rw/2HHwsvZ84APUxki7mYW3qT7
         UZHW0aJIgljLfj5L7RZk/YDIOcKy6OoKJDVECmgCsPfNE6KkGEhnPk4Kfm/1GRniZE/y
         /6JA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705350913; x=1705955713;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vMS0J/7CyXgLKOAf0V+IWQO6ynhdDfGM83qwFs2ZDn0=;
        b=kYlhughCizorocDpZguMK0RfjJc86T8dzS8ccOr2A83o2ISi4aTKEGngKw7N4xuL8Z
         eFavZh1Lh/Bv3Mz509iFvepwE1IXCHifrflDZQjT3DU5gpcMgdPZpoN4/WOySSpxW7Ey
         PKmvds21eyq2O7D+b2G2J54yAU2XgfnOKVL6clRMtdInYVCSBKBN3lnzompeLHOtoFVU
         /m7XywMx0twYLiFqvPGvD6VPGbpIWuaSZX0QTY7L7wAYRHXGf0HwkYsqppvPeGrPQiON
         156g2L5571jSXSqVy2IdLn6s45w1cuP1vHGtyI1sskxe1U76vC20u0feAMNFoo/16kxh
         yjvg==
X-Gm-Message-State: AOJu0YzSmhVZUcl1PQAjQi1VD9lYGdOMbF5hMp9M0v05q6b4Ogk38IKW
	1r5ky/H1a/KUPdPOphExx2exyKVawJDGr+i0DhIo9WLw83rjtchBzdN81LPjdA==
X-Google-Smtp-Source: AGHT+IGUa0qgnZPret07daFtiwbn3OW5/NvVga8dBqeZHddyjGHQ4zzvPkyxT1yyJjqP7HMhOHZVVrKV/FTCklvQ4oM=
X-Received: by 2002:a05:6102:48c:b0:468:dca:dd58 with SMTP id
 n12-20020a056102048c00b004680dcadd58mr3124255vsa.17.1705350912977; Mon, 15
 Jan 2024 12:35:12 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <1697202267-23600-1-git-send-email-quic_charante@quicinc.com> <20240115184430.2710652-1-glider@google.com>
In-Reply-To: <20240115184430.2710652-1-glider@google.com>
From: Marco Elver <elver@google.com>
Date: Mon, 15 Jan 2024 21:34:35 +0100
Message-ID: <CANpmjNMP802yN0i6puHHKX5E1PZ_6_h1x9nkGHCXZ4DVabxy7A@mail.gmail.com>
Subject: Re: [PATCH] mm/sparsemem: fix race in accessing memory_section->usage
To: Alexander Potapenko <glider@google.com>
Cc: quic_charante@quicinc.com, akpm@linux-foundation.org, 
	aneesh.kumar@linux.ibm.com, dan.j.williams@intel.com, david@redhat.com, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, mgorman@techsingularity.net, 
	osalvador@suse.de, vbabka@suse.cz, "Paul E. McKenney" <paulmck@kernel.org>, 
	Dmitry Vyukov <dvyukov@google.com>, kasan-dev@googlegroups.com, 
	Ilya Leoshkevich <iii@linux.ibm.com>, Nicholas Miehlbradt <nicholas@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"

On Mon, 15 Jan 2024 at 19:44, Alexander Potapenko <glider@google.com> wrote:
>
> Cc: "Paul E. McKenney" <paulmck@kernel.org>
> Cc: Marco Elver <elver@google.com>
> Cc: Dmitry Vyukov <dvyukov@google.com>
> Cc: kasan-dev@googlegroups.com
> Cc: Ilya Leoshkevich <iii@linux.ibm.com>
> Cc: Nicholas Miehlbradt <nicholas@linux.ibm.com>
>
> Hi folks,
>
> (adding KMSAN reviewers and IBM people who are currently porting KMSAN to other
> architectures, plus Paul for his opinion on refactoring RCU)
>
> this patch broke x86 KMSAN in a subtle way.
>
> For every memory access in the code instrumented by KMSAN we call
> kmsan_get_metadata() to obtain the metadata for the memory being accessed. For
> virtual memory the metadata pointers are stored in the corresponding `struct
> page`, therefore we need to call virt_to_page() to get them.
>
> According to the comment in arch/x86/include/asm/page.h, virt_to_page(kaddr)
> returns a valid pointer iff virt_addr_valid(kaddr) is true, so KMSAN needs to
> call virt_addr_valid() as well.
>
> To avoid recursion, kmsan_get_metadata() must not call instrumented code,
> therefore ./arch/x86/include/asm/kmsan.h forks parts of arch/x86/mm/physaddr.c
> to check whether a virtual address is valid or not.
>
> But the introduction of rcu_read_lock() to pfn_valid() added instrumented RCU
> API calls to virt_to_page_or_null(), which is called by kmsan_get_metadata(),
> so there is an infinite recursion now. I do not think it is correct to stop that
> recursion by doing kmsan_enter_runtime()/kmsan_exit_runtime() in
> kmsan_get_metadata(): that would prevent instrumented functions called from
> within the runtime from tracking the shadow values, which might introduce false
> positives.
>
> I am currently looking into inlining __rcu_read_lock()/__rcu_read_unlock(), into
> KMSAN code to prevent it from being instrumented, but that might require factoring
> out parts of kernel/rcu/tree_plugin.h into a non-private header. Do you think this
> is feasible?

__rcu_read_lock/unlock() is only outlined in PREEMPT_RCU. Not sure that helps.

Otherwise, there is rcu_read_lock_sched_notrace() which does the bare
minimum and is static inline.

Does that help?

> Another option is to cut some edges in the code calling virt_to_page(). First,
> my observation is that virt_addr_valid() is quite rare in the kernel code, i.e.
> not all cases of calling virt_to_page() are covered with it. Second, every
> memory access to KMSAN metadata residing in virt_to_page(kaddr)->shadow always
> accompanies an access to `kaddr` itself, so if there is a race on a PFN then
> the access to `kaddr` will probably also trigger a fault. Third, KMSAN metadata
> accesses are inherently non-atomic, and even if we ensure pfn_valid() is
> returning a consistent value for a single memory access, calling it twice may
> already return different results.
>
> Considering the above, how bad would it be to drop synchronization for KMSAN's
> version of pfn_valid() called from kmsan_virt_addr_valid()?

