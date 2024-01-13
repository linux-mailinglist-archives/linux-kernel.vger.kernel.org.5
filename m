Return-Path: <linux-kernel+bounces-25229-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F1FE82CAB9
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Jan 2024 10:13:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C33101C22390
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Jan 2024 09:13:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DCACA3F;
	Sat, 13 Jan 2024 09:13:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="L0od8ezP"
Received: from mail-ua1-f48.google.com (mail-ua1-f48.google.com [209.85.222.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04D0D7E9
	for <linux-kernel@vger.kernel.org>; Sat, 13 Jan 2024 09:12:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ua1-f48.google.com with SMTP id a1e0cc1a2514c-7cc9da9995bso2301259241.3
        for <linux-kernel@vger.kernel.org>; Sat, 13 Jan 2024 01:12:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1705137177; x=1705741977; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Yo3t4e6P0WumxGPjlAvUPSxdP7muYs1O7d3R9moE3Qk=;
        b=L0od8ezPtEo8KAfaAqNNIh872tuq9ZJbcjp0uBzzTsib6XOOK0wI/fNuUa8m4Rb2XQ
         h4dvQBlXiXHXHyRsh11lJT7iTs7s8GEPs2W6l26UailS+n2zcQsVwsojl01qSZnZi6F3
         OKQWnwf7GB9ahH2kPvpajfqn/Do8pncYXrEF/a2dHEndK/B2dQyWLaXmTiyzJyypsYQY
         EgduWljuaBivFNTutZEDpoc/IjLvQXM0IBbY6Iqn7ryFOuVqb6gqYydUd/TE92c4UoSN
         Ii/D/YMbeIk5uPyHJClKPQ4ipRHNOPiWMSFSqLC9gga63WeO82C5THjJmOCbxXoMZs2x
         +k4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705137177; x=1705741977;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Yo3t4e6P0WumxGPjlAvUPSxdP7muYs1O7d3R9moE3Qk=;
        b=GhmAzRFMFWoA9/4C30zc/DK1CDsffNLO4QLKuTZInwhVjWArdUKHBhYOmV4PNwOOWB
         g//7p5qb0laVXG49lLkS7lhfHEg0/jpIjFR3t04xNAEdWf9IK0yuWwQwpG6LVf9m5l4W
         l6NNV0zNXZz2NWG6KUuQzI36p/FyaVW+3shGn4EJyrw0d1W0Acp+PwSvztV6B9iUm4jj
         SEdG6dVZc2J9ENnzF1YIOMItn/2az0Ne8Ge7rp81tnI2nzQKEUw6sYXp2lCmPD09GDxV
         wF4Tf82BgQWePo4j+5w6R1QPSpBALv0QC0WW75YibqeCoMU4IidjOYRXlVP7duUubLpm
         ouFQ==
X-Gm-Message-State: AOJu0Yzl7Vhg6pBadw96s0BLAW5V3tXKT3xEhaUGd96qhFfBpa/n0v/9
	l3ENbIQoRg2DtxMA4XzR7XveveM1itWzR6ml6kJulT1VzT2Z
X-Google-Smtp-Source: AGHT+IHSgAFEp2sE1hMPV6V+JEol7zUdOE9aW8AkTxTmDJqxn4ST6KW1lHetqmPDJVflJV3u79WMJPFmz/9Is98I7t0=
X-Received: by 2002:a67:ea53:0:b0:468:e16:1cf9 with SMTP id
 r19-20020a67ea53000000b004680e161cf9mr1822608vso.60.1705137177555; Sat, 13
 Jan 2024 01:12:57 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1700502145.git.andreyknvl@google.com> <9f81ffcc4bb422ebb6326a65a770bf1918634cbb.1700502145.git.andreyknvl@google.com>
 <ZZUlgs69iTTlG8Lh@localhost.localdomain> <87sf34lrn3.fsf@linux.intel.com>
 <CANpmjNNdWwGsD3JRcEqpq_ywwDFoxsBjz6n=6vL5YksNsPyqHw@mail.gmail.com>
 <ZZ_gssjTCyoWjjhP@tassilo> <ZaA8oQG-stLAVTbM@elver.google.com>
 <CA+fCnZeS=OrqSK4QVUVdS6PwzGrpg8CBj8i2Uq=VMgMcNg1FYw@mail.gmail.com>
 <CANpmjNOoidtyeQ76274SWtTYR4zZPdr1DnxhLaagHGXcKwPOhA@mail.gmail.com>
 <ZaG56XTDwPfkqkJb@elver.google.com> <ZaHmQU5DouedI9kS@tassilo>
In-Reply-To: <ZaHmQU5DouedI9kS@tassilo>
From: Marco Elver <elver@google.com>
Date: Sat, 13 Jan 2024 10:12:21 +0100
Message-ID: <CANpmjNO-q4pjS4z=W8xVLHTs72FNq+TR+-=QBmkP=HOQy6UHmg@mail.gmail.com>
Subject: Re: [PATCH v4 12/22] lib/stackdepot: use read/write lock
To: Andi Kleen <ak@linux.intel.com>
Cc: Andrey Konovalov <andreyknvl@gmail.com>, Oscar Salvador <osalvador@suse.de>, andrey.konovalov@linux.dev, 
	Andrew Morton <akpm@linux-foundation.org>, Alexander Potapenko <glider@google.com>, 
	Dmitry Vyukov <dvyukov@google.com>, Vlastimil Babka <vbabka@suse.cz>, kasan-dev@googlegroups.com, 
	Evgenii Stepanov <eugenis@google.com>, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	Andrey Konovalov <andreyknvl@google.com>
Content-Type: text/plain; charset="UTF-8"

On Sat, 13 Jan 2024 at 02:24, Andi Kleen <ak@linux.intel.com> wrote:
>
> On Fri, Jan 12, 2024 at 11:15:05PM +0100, Marco Elver wrote:
> > +             /*
> > +              * Stack traces of size 0 are never saved, and we can simply use
> > +              * the size field as an indicator if this is a new unused stack
> > +              * record in the freelist.
> > +              */
> > +             stack->size = 0;
>
> I would use WRITE_ONCE here too, at least for TSan.

This is written with the pool_lock held.

> > +             return NULL;
> > +
> > +     /*
> > +      * We maintain the invariant that the elements in front are least
> > +      * recently used, and are therefore more likely to be associated with an
> > +      * RCU grace period in the past. Consequently it is sufficient to only
> > +      * check the first entry.
> > +      */
> > +     stack = list_first_entry(&free_stacks, struct stack_record, free_list);
> > +     if (stack->size && !poll_state_synchronize_rcu(stack->rcu_state))
>
> READ_ONCE (also for TSan, and might be safer long term in case the
> compiler considers some fancy code transformation)

And this is also only read with the pool_lock held, so it's impossible
that there'd be a data race due to size. (And if there is a data race,
I'd want KCSAN to tell us because that'd be a bug then.)
depot_pop_free() can't be used w/o the lock because it's manipulating
the freelist.
To be sure, I'm adding a lockdep_assert_held() to depot_pop_free().

> > +             return NULL;
> >
> > +             stack = depot_pop_free();
> > +             if (WARN_ON(!stack))
>
> Won't you get nesting problems here if this triggers due to the print?
> I assume the nmi safe printk won't consider it like an NMI.
>
> >       counters[DEPOT_COUNTER_FREELIST_SIZE]++;
> >       counters[DEPOT_COUNTER_FREES]++;
> >       counters[DEPOT_COUNTER_INUSE]--;
> > +
> > +     printk_deferred_exit();
>
> Ah this handles the WARN_ON? Should be ok then.

Yes, the pool_lock critical sections are surrounded by printk_deferred.

Thanks,
-- Marco

