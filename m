Return-Path: <linux-kernel+bounces-16439-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 95BF0823E98
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 10:26:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A8D3C1C23907
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 09:26:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9E382031C;
	Thu,  4 Jan 2024 09:26:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="aL0mf8Do"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-vk1-f178.google.com (mail-vk1-f178.google.com [209.85.221.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC28320B0D
	for <linux-kernel@vger.kernel.org>; Thu,  4 Jan 2024 09:26:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-vk1-f178.google.com with SMTP id 71dfb90a1353d-4b731a13d76so96891e0c.1
        for <linux-kernel@vger.kernel.org>; Thu, 04 Jan 2024 01:26:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1704360378; x=1704965178; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=JGeZ8w8hYuhNSoX/scf5I633EqoYMFGVRc1Mgn4PFeU=;
        b=aL0mf8DocOo8DiTLd1kU3TzjxwJgscizrbdUy+eDnVra7DUKgRZiHvcOYpS3q8HA2S
         ajcKcPmjlUn6BJtS04JJ5LHqutXquysOgNyEK5RJt4I3VeqO7MUMVDnMmFM0H9U39nR3
         qid3IpBf8dDI8juwcZy51YuHmc0H+4GNQvFxVVnj1muUan7KnvlJQ1xIREOMxKga5Yyl
         IEK6VmYx1hp3jxdw44Tl4sQjGIGfi+9q4n72lKFXwEseGgTpx05divGaEq2+9jOT74kf
         JRA24g+vpRcVAu9hmonk9836ozFcEyA7j/j0XU7KPrJpKal4cRHLi+13MfvOYVFIPc8f
         rfrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704360378; x=1704965178;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JGeZ8w8hYuhNSoX/scf5I633EqoYMFGVRc1Mgn4PFeU=;
        b=NEjDbZucRRXUwM0u6NVZY8rAA4p9gvuM2U7tFTWo/WYUdIS3oE7Md5r/HdPNCu6P3b
         tNNejL9J5mFGamh0+A7O+OhwxOVx9DyX13UdOp+lOsDflBCpuz2pHilmFc7S5CHyDUHe
         vxGUs/W/5E7sUfAytBFDseI2C+qpb1MeDqULQZK1MttByOCBuqZcGtwiNPhdcJo+Rnij
         4PM5JUk/+0rRJHmKFr4Lj1/D3sf/HuQtQDrEeCbJM1hEGSBLEr01Lrc7JK647vycxT9J
         vkRGiJIYye/qQVebSGYmtNMMAytaCk+ahfygmD7aq5znBZH2IcM5Z2pmm9Zi7vZsjg4t
         SOOw==
X-Gm-Message-State: AOJu0YwH0HdhG9LrYtUcah/0Yyq/nuSiIqNQTYSBKe7/SsZfVGJYVCEC
	K/V51LO3uRFzxUv5rdzB4qQoE7usMllIxtnqyK6C4YO0Ia3b
X-Google-Smtp-Source: AGHT+IGpmpV004FLzbQaPdXQqyI6lDoA20N0jgFhbKP/sfmLQ9yB4AyspNgLN3JiX7lkWl+zSjEVsZ8iJz2R9kD/zfk=
X-Received: by 2002:a05:6122:45aa:b0:4b6:d5f1:7c8a with SMTP id
 de42-20020a05612245aa00b004b6d5f17c8amr245659vkb.4.1704360378266; Thu, 04 Jan
 2024 01:26:18 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1700502145.git.andreyknvl@google.com> <1d1ad5692ee43d4fc2b3fd9d221331d30b36123f.1700502145.git.andreyknvl@google.com>
 <ZZZx5TpqioairIMP@localhost.localdomain>
In-Reply-To: <ZZZx5TpqioairIMP@localhost.localdomain>
From: Marco Elver <elver@google.com>
Date: Thu, 4 Jan 2024 10:25:40 +0100
Message-ID: <CANpmjNMWyVOvni-w-2Lx6WyEUnP+G_cLVELJv_-B4W1fMrQpnw@mail.gmail.com>
Subject: Re: [PATCH v4 17/22] lib/stackdepot: allow users to evict stack traces
To: Oscar Salvador <osalvador@suse.de>
Cc: andrey.konovalov@linux.dev, Andrew Morton <akpm@linux-foundation.org>, 
	Andrey Konovalov <andreyknvl@gmail.com>, Alexander Potapenko <glider@google.com>, 
	Dmitry Vyukov <dvyukov@google.com>, Vlastimil Babka <vbabka@suse.cz>, kasan-dev@googlegroups.com, 
	Evgenii Stepanov <eugenis@google.com>, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	Andrey Konovalov <andreyknvl@google.com>
Content-Type: text/plain; charset="UTF-8"

On Thu, 4 Jan 2024 at 09:52, Oscar Salvador <osalvador@suse.de> wrote:
>
> On Mon, Nov 20, 2023 at 06:47:15PM +0100, andrey.konovalov@linux.dev wrote:
> > From: Andrey Konovalov <andreyknvl@google.com>
> >
> > Add stack_depot_put, a function that decrements the reference counter
> > on a stack record and removes it from the stack depot once the counter
> > reaches 0.
> >
> > Internally, when removing a stack record, the function unlinks it from
> > the hash table bucket and returns to the freelist.
> >
> > With this change, the users of stack depot can call stack_depot_put
> > when keeping a stack trace in the stack depot is not needed anymore.
> > This allows avoiding polluting the stack depot with irrelevant stack
> > traces and thus have more space to store the relevant ones before the
> > stack depot reaches its capacity.
> >
> > Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
>
> I yet have to review the final bits of this series, but I'd like to
> comment on something below
>
>
> > +void stack_depot_put(depot_stack_handle_t handle)
> > +{
> > +     struct stack_record *stack;
> > +     unsigned long flags;
> > +
> > +     if (!handle || stack_depot_disabled)
> > +             return;
> > +
> > +     write_lock_irqsave(&pool_rwlock, flags);
> > +
> > +     stack = depot_fetch_stack(handle);
> > +     if (WARN_ON(!stack))
> > +             goto out;
> > +
> > +     if (refcount_dec_and_test(&stack->count)) {
> > +             /* Unlink stack from the hash table. */
> > +             list_del(&stack->list);
> > +
> > +             /* Free stack. */
> > +             depot_free_stack(stack);
>
> It would be great if stack_depot_put would also accept a boolean,
> which would determine whether we want to erase the stack or not.

I think a boolean makes the interface more confusing for everyone
else. At that point stack_depot_put merely decrements the refcount and
becomes a wrapper around refcount_dec, right?

I think you want to expose the stack_record struct anyway for your
series, so why not simply avoid calling stack_depot_put and decrement
the refcount with your own helper (there needs to be a new stackdepot
function to return a stack_record under the pool_rwlock held as
reader).

Also, you need to ensure noone else calls stack_depot_put on the stack
traces you want to keep. If there is a risk someone else may call
stack_depot_put on them, it obviously won't work (I think the only
option then is to introduce a way to pin stacks).


> For the feature I'm working on page_ower [1], I need to keep track
> of how many times we allocated/freed from a certain path, which may
> expose a potential leak, and I was using the refcount to do that,
> but I don't want the record to be erased, because this new
> functionality won't be exclusive with the existing one.
>
> e.g:  you can check /sys/kernel/debug/page_owner AND
> /sys/kernel/debug/page_owner_stacks
>
> So, while the new functionaliy won't care if a record has been erased,
> the old one will, so information will be lost.
>
> [1] https://patchwork.kernel.org/project/linux-mm/cover/20231120084300.4368-1-osalvador@suse.de/
>
>
>
> --
> Oscar Salvador
> SUSE Labs

