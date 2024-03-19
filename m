Return-Path: <linux-kernel+bounces-107640-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EFB287FF7E
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 15:24:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A0FC91F23E09
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 14:24:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31D6D81AC3;
	Tue, 19 Mar 2024 14:23:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen-com.20230601.gappssmtp.com header.i=@soleen-com.20230601.gappssmtp.com header.b="Siec59tb"
Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7651681AB7
	for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2024 14:23:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710858232; cv=none; b=Lr3lflSFLQ+WxzRO4BSxs/KAjXvjbje5MZd0vSUHJA6Z107lwZBte2uffpUUkWNFrlyClvkGHtQfzfma/dgOasJsoIRIcR3YmerH8vDyM6lBS0yv7C9/lUjXLl0iNSh9wnCDTuQJhT7JTQfvrvdJl+Nja9u37yPY+9vCV6bT5aI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710858232; c=relaxed/simple;
	bh=KOJVzrxFdyYhLw2yhlitO00HOeoEaCgOCkC77HSldlM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=T/Oiip/ZcfRiwreXb3n4bEtJuRGzy8+9QH7IJpuNT8raZQrZJteyFjlke10D1nRph8lJsrwEzbVVLMvnlcVyceCDoVDaIrugELmLy6BmR2vQ2jNwdwsXFI43n9QlY3gCyE4AzN/aBQqbPVKGxphhKCgjDbMo1gtzAvRE7BrxwlA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=soleen.com; spf=pass smtp.mailfrom=soleen.com; dkim=pass (2048-bit key) header.d=soleen-com.20230601.gappssmtp.com header.i=@soleen-com.20230601.gappssmtp.com header.b=Siec59tb; arc=none smtp.client-ip=209.85.160.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-430ad286ab8so24336581cf.1
        for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2024 07:23:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen-com.20230601.gappssmtp.com; s=20230601; t=1710858229; x=1711463029; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0jo5XV6mn0FIvuqG3IAFW3tUxkVMyLg5UBql45gg1w4=;
        b=Siec59tb8kFlm1qAOdujWbAU0vFKRIza/IiPelj+zqhbi4RyvkGH+Lal4+EuQR7orj
         lBahE7Ftv2ivrcizq8C/kQGlpyYPdS1rJvcdqeoY9r/8ZYajdGSkyaBPo27O83pX+PWq
         azllSOm9td3/3lABXtIX11gwLz5Kb8dzPnrCpjUmX5GJcknvo7CnusY036tfShzwMnW8
         mBszwZA5972rF5ZVMGuQZ0P1Qsjec2Fz6AOpL5fe8cxjfwMDvHjmoQSFlIVWCrKnTWYh
         wklzXNEcoDD4bnIZQnbp3HKkk+wJh8yloWUG++QytO6vyJhItk+v4s92KCY1h/N1UH9j
         xKNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710858229; x=1711463029;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0jo5XV6mn0FIvuqG3IAFW3tUxkVMyLg5UBql45gg1w4=;
        b=ZvJVykBfk2R5VrnOl3YJsQXEugPwvlHJsqXpHwOWUW4XtQmulk9a4+L7Q8VnVNW9kC
         s7C2ZTRNKfvJRcq3Gcw5dyZjhtc0zEYAClECAmNc4s0RgEWL9mhOW+z9Ejgr67uN4UMj
         qtSi/Jb2GtFzo1JIUHu4Zx1CD136dG/S/bd/B+xsROfFDOOVP+gE3nuoorZdzGzZWbT3
         znFERXRbNtQCgwacU0OEdhKOMFW6PFwjBHo+h/jn6IHAHVa5rrgqrUTKXsGe+6lPnIS6
         TeHJtru7LS8EDtDjya6nYgtbuB1ZHlPrOzmlvYR727NgKO1ljqo1yQZKd+r39eWvccDJ
         vgBg==
X-Forwarded-Encrypted: i=1; AJvYcCXSWoS6KbN0+S8wHYX3uMnroi+reyhbj/Of4WyRbBUjz9BQeE73XqSU4UidR1bia5CMZ+rAVujaQisWWVQLnwvRmvQE+tsJdxh+G/iF
X-Gm-Message-State: AOJu0YzFgvlLNAvkvlzExkBwyz9hA7y4ID33cjmfjvy3V9RKhuHyiAzS
	yTUPAiCx7G5VO/BDNahj349qiPvPTO1cKQ7z7mU2t6wjKwQQ/ZQ/W6Z+HQ+suXpXFkO1l9a2Ja0
	cqbm/t+Do9dqgOz60v7n1l/U+lvt5ZvOcxsBVSQ==
X-Google-Smtp-Source: AGHT+IGYBrtWZkZbtgvRzNPVu1B+8JDnsX07phI5PUGbd+e0ih3lWeVmaZ4LMbeEje3pQV2LuO9GQYfJpojQAFjApa0=
X-Received: by 2002:ac8:59d0:0:b0:430:b97c:6a36 with SMTP id
 f16-20020ac859d0000000b00430b97c6a36mr14589850qtf.0.1710858229337; Tue, 19
 Mar 2024 07:23:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240314145457.1106299-1-pasha.tatashin@soleen.com> <20240318134055.c2f6b29bb6eb73ec93bf7079@linux-foundation.org>
In-Reply-To: <20240318134055.c2f6b29bb6eb73ec93bf7079@linux-foundation.org>
From: Pasha Tatashin <pasha.tatashin@soleen.com>
Date: Tue, 19 Mar 2024 10:23:12 -0400
Message-ID: <CA+CK2bABRCpUkb849wP=aNnBfiofJTqLiV_0yEnhRLcFq3yJVg@mail.gmail.com>
Subject: Re: [PATCH v2] vmstat: Keep count of the maximum page reached by the
 kernel stack
To: Andrew Morton <akpm@linux-foundation.org>
Cc: jpoimboe@kernel.org, kent.overstreet@linux.dev, peterz@infradead.org, 
	nphamcs@gmail.com, cerasuolodomenico@gmail.com, surenb@google.com, 
	lizhijian@fujitsu.com, willy@infradead.org, shakeel.butt@linux.dev, 
	vbabka@suse.cz, ziy@nvidia.com, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 18, 2024 at 4:40=E2=80=AFPM Andrew Morton <akpm@linux-foundatio=
n.org> wrote:
>
> On Thu, 14 Mar 2024 14:54:57 +0000 Pasha Tatashin <pasha.tatashin@soleen.=
com> wrote:
>
> > CONFIG_DEBUG_STACK_USAGE provides a mechanism to determine the minimum
> > amount of memory left in a stack. Every time a new low-memory record is
> > reached, a message is printed to the console.
> >
> > However, this doesn't reveal how many pages within each stack were
> > actually used. Introduce a mechanism that keeps count the number of
> > times each of the stack's pages were reached:
> >
> >       $ grep kstack /proc/vmstat
> >       kstack_page_1 19974
> >       kstack_page_2 94
> >       kstack_page_3 0
> >       kstack_page_4 0
> >
> > In the above example, out of 20,068 threads that exited on this
> > machine, only 94 reached the second page of their stack, and none
> > touched pages three or four.
> >
> > In fleet environments with millions of machines, this data can help
> > optimize kernel stack sizes.
>
> We really should have somewhere to document vmstat things.

We really should have a documentation for both procfs and sysfs
versions of these files:

$ wc -l /proc/vmstat
177 /proc/vmstat

$ wc -l /sys/devices/system/node/node0/vmstat
61 /sys/devices/system/node/node0/vmstat

Some of the counters are shared between the two (where procfs contains
machine global view), and some such as vm_event are only part of
/proc/vmstat. All of that requires a documentation somewhere under
Documentation/mm/vmstat.rst. We must explain that this is not a stable
API, as these counters depend on the kernel internal implementation.
However, there are so many of them, that it will take some effort to
do the initial explanation of all of them.

> > --- a/include/linux/vm_event_item.h
> > +++ b/include/linux/vm_event_item.h
> > @@ -153,10 +153,39 @@ enum vm_event_item { PGPGIN, PGPGOUT, PSWPIN, PSW=
POUT,
> >               VMA_LOCK_ABORT,
> >               VMA_LOCK_RETRY,
> >               VMA_LOCK_MISS,
> > +#endif
> > +#ifdef CONFIG_DEBUG_STACK_USAGE
> > +             KSTACK_PAGE_1,
> > +             KSTACK_PAGE_2,
> > +#if THREAD_SIZE >=3D (4 * PAGE_SIZE)
> > +             KSTACK_PAGE_3,
> > +             KSTACK_PAGE_4,
> > +#endif
> > +#if THREAD_SIZE > (4 * PAGE_SIZE)
> > +             KSTACK_PAGE_REST,
> > +#endif
> >  #endif
> >               NR_VM_EVENT_ITEMS
> >  };
>
> This seems a rather cumbersome way to produce a kind of histogram.  I
> wonder if there should be a separate pseudo file for this.

If you would like, the #if for stack size can be removed, I added them
not to print kstack_page_3 and kstack_page_4 on order 1 stacks where
there are only two-pages. This series shows the frequency of reaching
each of these pages by the existing threads.

> And there may be a call for extending this.  For example I can forsee
> people wanting to know "hey, which process did that", in which case

Which process did that (to some extent) would be what is printed out
by: CONFIG_DEBUG_STACK_USAGE when it finds the new record size stack.
Other than that, we could use tracing to find the callers that cause
these deep stacks.

However, the information provided by this patch can help to figure out
if tracing is needed or not. For example, if it is known that the
third or forth pages are extremely rarely used, say 0.00001% of time,
they could have a special API for deep stack, and save half of the
stack  memory in the fleet.

Thank you,
Pasha

