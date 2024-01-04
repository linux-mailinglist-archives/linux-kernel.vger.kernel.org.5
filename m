Return-Path: <linux-kernel+bounces-16518-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F0EE823F9B
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 11:43:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4301CB217E8
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 10:42:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3DB220DD2;
	Thu,  4 Jan 2024 10:42:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hW9rsOHq"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-vk1-f172.google.com (mail-vk1-f172.google.com [209.85.221.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAA8D20DCE
	for <linux-kernel@vger.kernel.org>; Thu,  4 Jan 2024 10:42:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-vk1-f172.google.com with SMTP id 71dfb90a1353d-4b73e952ef2so87195e0c.2
        for <linux-kernel@vger.kernel.org>; Thu, 04 Jan 2024 02:42:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1704364970; x=1704969770; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=LolWQ4Jrb+Z7IGxXTLsLvRDIA9OucvvsNX3g5Br+h1s=;
        b=hW9rsOHqD3lAiRGYn/qKxn9ZjQOAPvrzJJk1UMLBY1+VOUBS53IWoiBTYePAsskBYj
         Zk77AA3IEG0tWN5TTE/XVdlDvMdKMAQ1OK16ptifpMefWRFXQ6c3iQejPD53jRN7+6II
         0RFPVw+8MTZZEh4oF1lenUcw0Din+iYgpg+cGZ5pkgTQUVJJt6GLjoEQfbZUVubjAkRw
         PnzVYhYUROfR37axLxWv0+TJ6VolM/eLkdPSPE3W4rgtwi/H8CUa6LbE0E6PHTRkEjvi
         LDfKNl0YLNENIfsO/zb+rRnRpKT8LuaN9W+gXdNuRwGmHfmn4u5SRjZ1PdCZuJUOBEfs
         iOxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704364970; x=1704969770;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LolWQ4Jrb+Z7IGxXTLsLvRDIA9OucvvsNX3g5Br+h1s=;
        b=b9RTGxumhGPDcMRNnU9SMH86jb4e6rPPvEnHuS1Ye35khSe320Rn1EXOQYuHVe9zJK
         FF9277fY2PQmC21VBPhqyRLIDnfwyymQwNDE2tDBhraDxVB/BSTvXGNfZcP3myveE8Pj
         LymmfR/xis2g4MwElS+GsXxEx9hA7119HX8imJan0Gqas6k2jEHisgkRGdliPlXw40i/
         KmLmC4GG3HOGzpPIXaZzV6U11+rTZAcV1t2XM1Vi6zxtCI18nxMvwAZdiAEkt1hoadY0
         LBjq6eY9Epm27xVkDxBSaw7nkcUiSMq37+ZmJZRAL9Op3CQRMwwwpa/XWC0KjBUUOkXC
         7zTQ==
X-Gm-Message-State: AOJu0YzoECIFVDMoI9uLWp0JBulsL7ujZwu6z3Rg0wxvqBrU84O0oVb2
	3ZqVueihwvSJo1LkPbtSZN7a8bT4FESQvrhWfuJXpZlPMYoX
X-Google-Smtp-Source: AGHT+IHRbgq83scPnGoNOMQVhsBQFaBLOBRHtuOw/QohbmSJuWeKgX3B38tkPgZeXgthkyBiNqZdN0GvPubaSh3kUww=
X-Received: by 2002:a05:6122:3181:b0:4b6:e60e:e080 with SMTP id
 ch1-20020a056122318100b004b6e60ee080mr162069vkb.30.1704364969684; Thu, 04 Jan
 2024 02:42:49 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1700502145.git.andreyknvl@google.com> <1d1ad5692ee43d4fc2b3fd9d221331d30b36123f.1700502145.git.andreyknvl@google.com>
 <ZZZx5TpqioairIMP@localhost.localdomain> <CANpmjNMWyVOvni-w-2Lx6WyEUnP+G_cLVELJv_-B4W1fMrQpnw@mail.gmail.com>
 <ZZaGHbaerKfli0Wu@localhost.localdomain>
In-Reply-To: <ZZaGHbaerKfli0Wu@localhost.localdomain>
From: Marco Elver <elver@google.com>
Date: Thu, 4 Jan 2024 11:42:11 +0100
Message-ID: <CANpmjNMgpcpTCqepjQa=M7USYmCRYnRFRQdXfz0iZdPaBNK=6w@mail.gmail.com>
Subject: Re: [PATCH v4 17/22] lib/stackdepot: allow users to evict stack traces
To: Oscar Salvador <osalvador@suse.de>
Cc: andrey.konovalov@linux.dev, Andrew Morton <akpm@linux-foundation.org>, 
	Andrey Konovalov <andreyknvl@gmail.com>, Alexander Potapenko <glider@google.com>, 
	Dmitry Vyukov <dvyukov@google.com>, Vlastimil Babka <vbabka@suse.cz>, kasan-dev@googlegroups.com, 
	Evgenii Stepanov <eugenis@google.com>, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	Andrey Konovalov <andreyknvl@google.com>
Content-Type: text/plain; charset="UTF-8"

On Thu, 4 Jan 2024 at 11:18, Oscar Salvador <osalvador@suse.de> wrote:
>
> On Thu, Jan 04, 2024 at 10:25:40AM +0100, Marco Elver wrote:
> > I think a boolean makes the interface more confusing for everyone
> > else. At that point stack_depot_put merely decrements the refcount and
> > becomes a wrapper around refcount_dec, right?
>
> Thanks Marco for the feedback.
>
> Fair enough.
>
> > I think you want to expose the stack_record struct anyway for your
> > series, so why not simply avoid calling stack_depot_put and decrement
> > the refcount with your own helper (there needs to be a new stackdepot
> > function to return a stack_record under the pool_rwlock held as
> > reader).
>
> Yeah, that was something I was experimenting with my last version.
> See [0], I moved the "stack_record" struct into the header so page_owner
> can make sense of it. I guess that's fine right?

Not exposing the internals would be better, but at this point I think
your usecase looks like it's doing something that is somewhat out of
the bounds of the stackdepot API. I also don't see that it makes sense
to add more helpers to the stackdepot API to deal with such special
cases.

As such, I'd reason that it's ok to expose the struct for this special usecase.

> If so, I'd do as you mentioned, just decrementing it with my own helper
> so no calls to stack_depot_put will be needed.
>
> Regarding the locking, I yet have to check the patch that implements
> the read/write lock, but given that page_owner won't be evicting
> anything, do I still have to fiddle with the locks?

You need to grab the lock as a reader to fetch the stack_record and
return it. All that should be hidden behind whatever function you'll
introduce to return the stack_record (stack_depot_find()?).

> > Also, you need to ensure noone else calls stack_depot_put on the stack
> > traces you want to keep. If there is a risk someone else may call
> > stack_depot_put on them, it obviously won't work (I think the only
> > option then is to introduce a way to pin stacks).
>
> Well, since page_owner won't call stack_depot_put, I don't see
> how someone else would be able to interfere there, so I think
> I am safe there.
>
> [0] https://patchwork.kernel.org/project/linux-mm/patch/20231120084300.4368-3-osalvador@suse.de/
>
> --
> Oscar Salvador
> SUSE Labs

