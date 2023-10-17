Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A81A7CC80A
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 17:52:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344138AbjJQPwH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Oct 2023 11:52:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343979AbjJQPwF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Oct 2023 11:52:05 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE8209E
        for <linux-kernel@vger.kernel.org>; Tue, 17 Oct 2023 08:52:03 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id a640c23a62f3a-9a6190af24aso967799166b.0
        for <linux-kernel@vger.kernel.org>; Tue, 17 Oct 2023 08:52:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1697557922; x=1698162722; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=h+Szb6nB1OdOcsJ1SkkUkZWUvsgJwxEYpCHP9bITXYs=;
        b=n81K1t2oANRy3fTGZsMLI3lZ+AAxoqGV9gmhTIQHwkj2sVoVfAjUIAOeZvfE491zPO
         +KGDzkVs+b8l/jqPx3hRxs3BRytRJQD30PIYuis9jwAmpZvMQTPCNBwq3gcYxgAqofzS
         VieknTV9aPyTCTqNx/1+tnZu7LdfjwhQWa54S0Mm/2QweW2NW81kOvVgD9lgsW/pCqCh
         w28872Xkc1Nn2weN6IHPhi4cEbzmJAt6P5ilazEaQd5qUNW9rLyg+38C20zzGLzyp3um
         vlGk+QK2AGfZ/flP38c0j6ZNk9t3gzBxaNEkKtU2qU47YR/Q3ie9nSGrdxkeU0f1N847
         PUQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697557922; x=1698162722;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=h+Szb6nB1OdOcsJ1SkkUkZWUvsgJwxEYpCHP9bITXYs=;
        b=iOqWo/7Mnhg6dKz8zIJ65wP29OIowthe4wnYeaZ+Q4wJEODHuEJZldeaSaL+TSPPyT
         m1YQ70GhbSRzbSMndjNKnOc/IiQ0HMrWhhFuRy6YT/+NQy8GDmGv1K/zpcw7z9SMGPPQ
         Sv8MDqW5Ya91o8fKL9bET4+Oq/p2i+bbTPW/Gz+rmf7V8uKr67ewpAGckVF4YaKJl5Gl
         ixh9fMeazHPfnDK3GzeTLr3ZDTPPhtzJB4LonoAvI+Zyc141VbarYpdWOSEO3oA7v6UB
         deQIR+1bii8H9zben5vuxLVSH4MCiD8ciQzYo9hRw/p/qNdDuetKj/VX6l9jMG5RleR+
         ev2w==
X-Gm-Message-State: AOJu0Yzz+D2VSSBfmTLWKzH8TBrelgVh/nCTRFT39JplYh4mXCAQ/Vj4
        p/puTQ08Mdcorq7/lIqG/H9azH99PGMOq4MxyoQGVw==
X-Google-Smtp-Source: AGHT+IEdAMihCV/53OUwqI9AfwU19uoqBtkB4Xmq9GtshNSB9srOSQC8B9l1/4PLxdERSHg8dNXluf9vBjoMVcLg4HY=
X-Received: by 2002:a17:907:1c24:b0:9be:68db:b763 with SMTP id
 nc36-20020a1709071c2400b009be68dbb763mr2141954ejc.71.1697557921772; Tue, 17
 Oct 2023 08:52:01 -0700 (PDT)
MIME-Version: 1.0
References: <20231017003519.1426574-1-nphamcs@gmail.com> <CAJD7tka6XRyzYndRNEFZmi0Zj4DD2KnVzt=vMGhfF4iN2B4VKw@mail.gmail.com>
 <20231017044745.GC1042487@cmpxchg.org> <CAJD7tkbEJDczxPqp2ZcZiz1ZWYdUWZLaiovxiGWcM57md-URhA@mail.gmail.com>
 <20231017145124.GA1122010@cmpxchg.org>
In-Reply-To: <20231017145124.GA1122010@cmpxchg.org>
From:   Yosry Ahmed <yosryahmed@google.com>
Date:   Tue, 17 Oct 2023 08:51:25 -0700
Message-ID: <CAJD7tkbg+SZ=cd5Jzjy4qwSQFdcGWXjHBLxisE4pWaAA=1F4Wg@mail.gmail.com>
Subject: Re: [PATCH 0/2] minimize swapping on zswap store failure
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     Nhat Pham <nphamcs@gmail.com>, akpm@linux-foundation.org,
        cerasuolodomenico@gmail.com, sjenning@redhat.com,
        ddstreet@ieee.org, vitaly.wool@konsulko.com, hughd@google.com,
        corbet@lwn.net, konrad.wilk@oracle.com, senozhatsky@chromium.org,
        rppt@kernel.org, linux-mm@kvack.org, kernel-team@meta.com,
        linux-kernel@vger.kernel.org, david@ixit.cz,
        Wei Xu <weixugc@google.com>, Chris Li <chrisl@kernel.org>,
        Greg Thelen <gthelen@google.com>
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

On Tue, Oct 17, 2023 at 7:51=E2=80=AFAM Johannes Weiner <hannes@cmpxchg.org=
> wrote:
>
> On Mon, Oct 16, 2023 at 10:33:23PM -0700, Yosry Ahmed wrote:
> > On Mon, Oct 16, 2023 at 9:47=E2=80=AFPM Johannes Weiner <hannes@cmpxchg=
.org> wrote:
> > > On Mon, Oct 16, 2023 at 05:57:31PM -0700, Yosry Ahmed wrote:
> > > > On Mon, Oct 16, 2023 at 5:35=E2=80=AFPM Nhat Pham <nphamcs@gmail.co=
m> wrote:
> > > So I obviously agree that we still need to invest in decoupling zswap
> > > space from physical disk slots. It's insanely wasteful, especially
> > > with larger memory capacities. But while it would be a fantastic
> > > optimization, I don't see how it would be an automatic solution to th=
e
> > > problem that inspired this proposal.
> >
> > Well, in my head, I imagine such a world where we have multiple
> > separate swapping backends with cgroup knob(s) that control what
> > backends are allowed for each cgroup. A zswap-is-terminal knob is
> > hacky-ish way of doing that where the backends are only zswap and disk
> > swap.
>
> "I want compression" vs "I want disk offloading" is a more reasonable
> question to ask at the cgroup level. We've had historically a variety
> of swap configurations across the fleet. E.g. it's a lot easier to add
> another swapfile than it is to grow an existing one at runtime. In
> other cases, one storage config might have one swapfile, another
> machine model might want to spread it out over multiple disks etc.
>
> This doesn't matter much with ghost files. But with conventional
> swapfiles this requires an unnecessary awareness of the backend
> topology in order to express container policy. That's no bueno.

Oh I didn't mean that cgroups would designate specific swapfiles, but
rather swapping backends, which would be "zswap" or "disk" or both in
this case. I just imagined an interface that is more generic and
extensible rather than a specific zswap-is-terminal knob.

>
> > > > Perhaps there is a way we can do this without allocating a zswap en=
try?
> > > >
> > > > I thought before about having a special list_head that allows us to
> > > > use the lower bits of the pointers as markers, similar to the xarra=
y.
> > > > The markers can be used to place different objects on the same list=
.
> > > > We can have a list that is a mixture of struct page and struct
> > > > zswap_entry. I never pursued this idea, and I am sure someone will
> > > > scream at me for suggesting it. Maybe there is a less convoluted wa=
y
> > > > to keep the LRU ordering intact without allocating memory on the
> > > > reclaim path.
> > >
> > > That should work. Once zswap has exclusive control over the page, it
> > > is free to muck with its lru linkage. A lower bit tag on the next or
> > > prev pointer should suffice to distinguish between struct page and
> > > struct zswap_entry when pulling stuff from the list.
> >
> > Right.
> >
> > We handle incompressible memory internally in a different way, we put
> > them back on the unevictable list with an incompressible page flag.
> > This achieves a similar effect.
>
> It doesn't. We want those incompressible pages to continue aging
> alongside their compressible peers, and eventually get written back to
> disk with them.

Sorry I wasn't clear, I was talking about the case where zswap is
terminal. When zswap is not, in our approach we just skip zswap for
incompressible pages and write them directly to disk. Aging them on
the LRU is probably the better approach here.

For the case where zswap is terminal, making them unevictable incurs
less page faults, at least for shmem.
