Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 039B37BD736
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Oct 2023 11:36:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345929AbjJIJgV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Oct 2023 05:36:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345875AbjJIJgS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Oct 2023 05:36:18 -0400
Received: from mail-qk1-x72a.google.com (mail-qk1-x72a.google.com [IPv6:2607:f8b0:4864:20::72a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBE97101
        for <linux-kernel@vger.kernel.org>; Mon,  9 Oct 2023 02:36:15 -0700 (PDT)
Received: by mail-qk1-x72a.google.com with SMTP id af79cd13be357-77409065623so246972685a.0
        for <linux-kernel@vger.kernel.org>; Mon, 09 Oct 2023 02:36:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1696844175; x=1697448975; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NbPQn5PYDTYWmHehcflWH6rr2b2zYJNRYM1EffH3dP8=;
        b=q+zQqYGHKC3VdKkSBxfAKFApTLXq+oKJxK6lXPVPlQmk877rKcPXXoNSP0uCCbw3aH
         kDKgEsptNC4JuJlwHwkZ4LXgbF60inltIh40ilxDtTwVnpQHff+gIlEggYFi1Z7SyJjQ
         O+U7UjEsOVbA/IaLWCcNTtWT9/2NvuIMScCC2qWfiBul3WiNgDP96ZaZCMaPluAGFQuZ
         nBlffRcutdlzbsvFQ2r7xg3NGG9YRjHZpAJg5mnpXY+VwWbxpphtNwyVbKfq8zp+0s1A
         oUhlnna1+TRBryGhR0DOex19FpMZgY+cQOhbl2zpMzB3d9+L+FbSNgvaYO/uYD9OxaRY
         NLeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696844175; x=1697448975;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NbPQn5PYDTYWmHehcflWH6rr2b2zYJNRYM1EffH3dP8=;
        b=Xhd4tpyfgr926XKThiNJnb+2Blh/jCQ//rD+KBHju5hlZQrzLXsy8oqr4M8Tt7Avun
         b3epYzStbosQzmmiDTM8lORNEeNuZ0vxrm71Ml6KDnxpLxKJiyUy8ru8ffnR/J2Ea/Cf
         SI9AzyOHfiL/VGztWiMzE6EnXGmqXkrs3mX9qoH1NQCpMx9hARz+Galv5tVoIRkNzq64
         1XgfBlrdVcCr21mDy9cXjV2hXWbkj6UsXwuvcHO5HWgVT2dG3urXg0H61pZSmurh3NDX
         Nij5LXEt3bi/JW3G5S92TtXgjTIAiPO0ChzafhIXY7iVBYhHrxLElEbtVSTvxpBpfHaR
         U0Aw==
X-Gm-Message-State: AOJu0Ywx5aaT6N0t7DnV8dGqPCq3laz3/FVsfdlL1Xxj/kl4YdEi/kgB
        kNotB/sSXw4ECHoMmV37wiv9EE4fhJehcloOi5qB5g==
X-Google-Smtp-Source: AGHT+IHl7GhqKVn2QASGrGlQPWIZs4lZeCDhb0GypUERFjZpZgQ73PUH9sqPw5uitx2hqKLaBTMDwKiIGXFneLYscbE=
X-Received: by 2002:ad4:5d6a:0:b0:65a:f5e9:8ecf with SMTP id
 fn10-20020ad45d6a000000b0065af5e98ecfmr19993574qvb.60.1696844174006; Mon, 09
 Oct 2023 02:36:14 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1694625260.git.andreyknvl@google.com> <bbf482643e882f9f870d80cb35342c61955ea291.1694625260.git.andreyknvl@google.com>
 <CAG_fn=VspORKG5+xdkmnULq3C64mWCb-XGDvnV9htayf5CL-PQ@mail.gmail.com>
In-Reply-To: <CAG_fn=VspORKG5+xdkmnULq3C64mWCb-XGDvnV9htayf5CL-PQ@mail.gmail.com>
From:   Alexander Potapenko <glider@google.com>
Date:   Mon, 9 Oct 2023 11:35:38 +0200
Message-ID: <CAG_fn=VSSQuR2VLEv-t+ByG7AbfDxjeR=oPvpaPkMOq4ZoEs4A@mail.gmail.com>
Subject: Re: [PATCH v2 07/19] lib/stackdepot: rework helpers for depot_alloc_stack
To:     andrey.konovalov@linux.dev
Cc:     Marco Elver <elver@google.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Vlastimil Babka <vbabka@suse.cz>, kasan-dev@googlegroups.com,
        Evgenii Stepanov <eugenis@google.com>,
        Oscar Salvador <osalvador@suse.de>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Andrey Konovalov <andreyknvl@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 9, 2023 at 10:59=E2=80=AFAM Alexander Potapenko <glider@google.=
com> wrote:
>
> On Wed, Sep 13, 2023 at 7:15=E2=80=AFPM <andrey.konovalov@linux.dev> wrot=
e:
> >
> > From: Andrey Konovalov <andreyknvl@google.com>
> >
> > Split code in depot_alloc_stack and depot_init_pool into 3 functions:
> >
> > 1. depot_keep_next_pool that keeps preallocated memory for the next poo=
l
> >    if required.
> >
> > 2. depot_update_pools that moves on to the next pool if there's no spac=
e
> >    left in the current pool, uses preallocated memory for the new curre=
nt
> >    pool if required, and calls depot_keep_next_pool otherwise.
> >
> > 3. depot_alloc_stack that calls depot_update_pools and then allocates
> >    a stack record as before.
> >
> > This makes it somewhat easier to follow the logic of depot_alloc_stack
> > and also serves as a preparation for implementing the eviction of stack
> > records from the stack depot.
> >
> > Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
> Reviewed-by: Alexander Potapenko <glider@google.com>
>
>
> > +static void depot_keep_next_pool(void **prealloc)
> >  {
> >         /*
> > -        * If the next pool is already initialized or the maximum numbe=
r of
> > +        * If the next pool is already saved or the maximum number of
> >          * pools is reached, do not use the preallocated memory.
> >          */
> >         if (!next_pool_required)
> It's not mentioned at the top of the file that next_pool_required is
> protected by pool_lock, but it is, correct?
> Can you please update the comment to reflect that?

You're adding lockdep annotations in patch 11, which are pretty
self-descriptive.
Feel free to ignore my comment above.
