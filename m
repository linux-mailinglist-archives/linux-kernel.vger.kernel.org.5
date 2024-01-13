Return-Path: <linux-kernel+bounces-25236-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 89D4582CACE
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Jan 2024 10:31:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EF096284013
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Jan 2024 09:31:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8A3C1EEFA;
	Sat, 13 Jan 2024 09:31:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="kKBmfDYG"
Received: from mail-vk1-f174.google.com (mail-vk1-f174.google.com [209.85.221.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A194A7FF
	for <linux-kernel@vger.kernel.org>; Sat, 13 Jan 2024 09:30:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-vk1-f174.google.com with SMTP id 71dfb90a1353d-4b72e63821eso4603076e0c.1
        for <linux-kernel@vger.kernel.org>; Sat, 13 Jan 2024 01:30:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1705138258; x=1705743058; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=bs8F5F/gFkaaibZRS33VN3FkQujN/mSOo0oKKTFy/VY=;
        b=kKBmfDYGWsiCc27z9hGDRNnpX1GS9S8cU0RSn8+MTR6HL80MR93N8ylCQLV6u7/2AP
         VnT3Y++4pn/5myHw7IW7xsZFNpUomLUVoWD1zuPfmv/P2WQhAQeH9klAqIjetQ3wo2V4
         s/fCAilan23WgwyBGN8DxxzAdIPiNSpm/GAYTH0dlvsqXAS9D1MBL0xAm4QSh9aAKIgc
         z8tg8OeD+7yIPH5p0Pgxhj4SvaO33uRIuzihrA16CFOmnGB07ldHSATAr59uoSKgXzFc
         Qr+YZ2+YYb4wRsrmYoTJRKtNirwEn9FQhmZmng23cNUJQLyO1/TuxhDNB1Ax55sEqwiw
         C6Vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705138258; x=1705743058;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bs8F5F/gFkaaibZRS33VN3FkQujN/mSOo0oKKTFy/VY=;
        b=FPlPjIZQ/UB87Kg9zXj5sUygXHiMCXrE9/yPPU2bLB1IhrZbGUz0WgB8BHq5WWm+Vk
         BEWfF/MUuW0JbYEFgb0gnzwyP0EPme6cQ7n7BYY0/2KWB2QZGVzOMAsCYPR+W7L6Sh5p
         v8I/bTpekZVB1YFKaj6ENKnbJdKa70i0pmOSeqzKjFiOeXxsoxs3yuiiLbqzTOIzxVZf
         fEnHf8mbVrVcVUf38/ArlDwDxPeGeZtdbpdfOTouQnf2PzeVa0521DiiSD85LHvIiM/O
         aukMc7b7ItMEb+8ETp475GUUgDW4CtseY8X0ibVJumnOKXqcPfjyMKF8vqAPIq9xbKO+
         gpHA==
X-Gm-Message-State: AOJu0YxdCorpJ+AegOgYQ1r5LS0FAfOlXZL+W3VPnqg62VQ8oT+8NMXX
	d993rh+oq2VaHZsFD71bg8cUPZNdOdncTrqGdLxL8CSMJevq
X-Google-Smtp-Source: AGHT+IFPdydKjFHw/lmE/QvAI4JOCWoyGQqyQHAkhsUH/dPv2bg6jZzPY5fYHRsoo9XW0oA30S+EGhEeeglIFFaDOog=
X-Received: by 2002:ac5:c98c:0:b0:4b6:e3b6:41ea with SMTP id
 e12-20020ac5c98c000000b004b6e3b641eamr1766273vkm.4.1705138258316; Sat, 13 Jan
 2024 01:30:58 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <ZZUlgs69iTTlG8Lh@localhost.localdomain> <87sf34lrn3.fsf@linux.intel.com>
 <CANpmjNNdWwGsD3JRcEqpq_ywwDFoxsBjz6n=6vL5YksNsPyqHw@mail.gmail.com>
 <ZZ_gssjTCyoWjjhP@tassilo> <ZaA8oQG-stLAVTbM@elver.google.com>
 <CA+fCnZeS=OrqSK4QVUVdS6PwzGrpg8CBj8i2Uq=VMgMcNg1FYw@mail.gmail.com>
 <CANpmjNOoidtyeQ76274SWtTYR4zZPdr1DnxhLaagHGXcKwPOhA@mail.gmail.com>
 <ZaG56XTDwPfkqkJb@elver.google.com> <ZaHmQU5DouedI9kS@tassilo>
 <CANpmjNO-q4pjS4z=W8xVLHTs72FNq+TR+-=QBmkP=HOQy6UHmg@mail.gmail.com>
 <ZaJVqF-_fJ_O3pJK@tassilo> <CANpmjNOz7tBMK-HoyZNVR2KcgxEBY1Qym=DRa9gHLFkaNHLmVw@mail.gmail.com>
In-Reply-To: <CANpmjNOz7tBMK-HoyZNVR2KcgxEBY1Qym=DRa9gHLFkaNHLmVw@mail.gmail.com>
From: Marco Elver <elver@google.com>
Date: Sat, 13 Jan 2024 10:30:22 +0100
Message-ID: <CANpmjNNi=JqTsfZAWDg-e4ee2v3rXmHCg7UL7ZvN92yr2Y2vUg@mail.gmail.com>
Subject: Re: [PATCH v4 12/22] lib/stackdepot: use read/write lock
To: Andi Kleen <ak@linux.intel.com>
Cc: Andrey Konovalov <andreyknvl@gmail.com>, Oscar Salvador <osalvador@suse.de>, andrey.konovalov@linux.dev, 
	Andrew Morton <akpm@linux-foundation.org>, Alexander Potapenko <glider@google.com>, 
	Dmitry Vyukov <dvyukov@google.com>, Vlastimil Babka <vbabka@suse.cz>, kasan-dev@googlegroups.com, 
	Evgenii Stepanov <eugenis@google.com>, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	Andrey Konovalov <andreyknvl@google.com>
Content-Type: text/plain; charset="UTF-8"

On Sat, 13 Jan 2024 at 10:23, Marco Elver <elver@google.com> wrote:
>
> On Sat, 13 Jan 2024 at 10:19, Andi Kleen <ak@linux.intel.com> wrote:
> >
> > On Sat, Jan 13, 2024 at 10:12:21AM +0100, Marco Elver wrote:
> > > On Sat, 13 Jan 2024 at 02:24, Andi Kleen <ak@linux.intel.com> wrote:
> > > >
> > > > On Fri, Jan 12, 2024 at 11:15:05PM +0100, Marco Elver wrote:
> > > > > +             /*
> > > > > +              * Stack traces of size 0 are never saved, and we can simply use
> > > > > +              * the size field as an indicator if this is a new unused stack
> > > > > +              * record in the freelist.
> > > > > +              */
> > > > > +             stack->size = 0;
> > > >
> > > > I would use WRITE_ONCE here too, at least for TSan.
> > >
> > > This is written with the pool_lock held.
> >
> > ...which doesn't help because the readers don't take it?
>
> This function is only refilling the freelist. Readers don't see it yet
> because it's in none of the hash table buckets. The freelist is only
> ever accessed under the lock.
>
> Once an entry is allocated from the freelist, its size is overwritten
> with something non-zero (since it then contains a stack trace). Those
> updates are released into the right hash table bucket with
> list_add_rcu() (which implies a release).
>
> Am I missing something else?

FWIW, the current version (draft) of this can be found here:
https://git.kernel.org/pub/scm/linux/kernel/git/melver/linux.git/log/?h=kasan/dev
I'll send the 2 patches next week - they should apply cleanly on
current mainline.

Thanks,
-- Marco

