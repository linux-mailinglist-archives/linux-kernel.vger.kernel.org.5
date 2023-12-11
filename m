Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23D2680C49D
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Dec 2023 10:31:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229908AbjLKJbU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Dec 2023 04:31:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229521AbjLKJbT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Dec 2023 04:31:19 -0500
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCDECB3;
        Mon, 11 Dec 2023 01:31:24 -0800 (PST)
Received: by mail-lj1-x22d.google.com with SMTP id 38308e7fff4ca-2c9f4bb2e5eso57376971fa.1;
        Mon, 11 Dec 2023 01:31:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702287083; x=1702891883; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bJe20/B6V+1jA/nSiEGTI9TatZJ/dlgC/IshXSznt1k=;
        b=DQkLaLJkD7Ex8oJ6wG0A2SxJgSrP3q0wpHNRu56Evzs2Y09MLLq9R6njYRbZMhPYu8
         75WOEaZ18/CO2Dkkf0NjW/gMYrB+XN0vCnXwlYXb/Y90s5+SWR4agqPy54HKJ23d8yia
         2sKiEZCYcpjwKea6m2ivPmf0dqcX1MtMITStzPJCJNyhOihXxR28ZCaKYwd7TXqu5sof
         dRHkeZ4hfUw0HgEgzmCx7MI4Pl8fXR4RutrhkPeI8JvIP/FzZ0KLans5NBEfGitFAwZX
         kVWAFj4TS8oYTaQuFS5S8lUKM+pittOV9cT2D/rEzlCby2m0lTBT4KAXl8/l4AQM7Pqy
         ZcMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702287083; x=1702891883;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bJe20/B6V+1jA/nSiEGTI9TatZJ/dlgC/IshXSznt1k=;
        b=VpLAM/MUCeSoI66NUiqfyhL2wDzSEg2uh+ozXrXGN8/jOvUdFYJ/DoRjv4I7KoZadz
         oOiIUtaFQ1j6bq8os8AKHXtKoHGDZkQfsMXRP6IBhzaQeD60Qn5jKqZ7C/kZ1tZeGsQP
         GSLvnnl58ax2v013kChnz/HCsGdywO3wNJuWZMVX9Cpjl3+EY0riE1rXtL32cb3Rtpfs
         je+JUZd/O+/JSVS9R2TY4RpatRBzYVuBVIHXnvANxs8FpaFvqo2R595Ym9wxZ29yhOVW
         +2B3rc8OvjTsN2nyTaKJ5fTszD19fl2zW2UvTCQPzXaw/WBf1nNltOhWnyNTL7mXso9+
         kSTQ==
X-Gm-Message-State: AOJu0Yy+0XKQVtvqGOHNPna3owcKgHMfSoNRwasve/uHYPb3g9/NGudb
        uBRx9uRPQUjpJEZRSseieMTssbp+JiCN0/d5gYU=
X-Google-Smtp-Source: AGHT+IGs39bCZR/J9n/341WQqL87l74iYPcz4l7EGywr8Hox9WXsoI1JGYf+LpYEvAbBya6DsiE1yELvbtVHng+G+uQ=
X-Received: by 2002:a05:651c:19a4:b0:2cc:1db0:4a6f with SMTP id
 bx36-20020a05651c19a400b002cc1db04a6fmr839578ljb.32.1702287082654; Mon, 11
 Dec 2023 01:31:22 -0800 (PST)
MIME-Version: 1.0
References: <20231207192406.3809579-1-nphamcs@gmail.com> <CAF8kJuPEKWbr_1a-OzqrYKSPmuty==KhC2vbTPAmm9xcJHo4cg@mail.gmail.com>
 <CAKEwX=Oj0Rur8i9Oo7y2Py7svx-g11sEj3GKQfMVL62x=4hvdA@mail.gmail.com> <CAF8kJuNpnqTM5x1QmQ7h-FaRWVnHBdNGvGvB3txohSOmZhYA-Q@mail.gmail.com>
In-Reply-To: <CAF8kJuNpnqTM5x1QmQ7h-FaRWVnHBdNGvGvB3txohSOmZhYA-Q@mail.gmail.com>
From:   Kairui Song <ryncsn@gmail.com>
Date:   Mon, 11 Dec 2023 17:31:05 +0800
Message-ID: <CAMgjq7AjO=Z4Wa3DYaOJdWA+8aNQ1JHZQYKYOm5-SvvgPPOGKg@mail.gmail.com>
Subject: Re: [PATCH v6] zswap: memcontrol: implement zswap writeback disabling
To:     Chris Li <chrisl@kernel.org>
Cc:     Nhat Pham <nphamcs@gmail.com>, akpm@linux-foundation.org,
        tj@kernel.org, lizefan.x@bytedance.com, hannes@cmpxchg.org,
        cerasuolodomenico@gmail.com, yosryahmed@google.com,
        sjenning@redhat.com, ddstreet@ieee.org, vitaly.wool@konsulko.com,
        mhocko@kernel.org, roman.gushchin@linux.dev, shakeelb@google.com,
        muchun.song@linux.dev, hughd@google.com, corbet@lwn.net,
        konrad.wilk@oracle.com, senozhatsky@chromium.org, rppt@kernel.org,
        linux-mm@kvack.org, kernel-team@meta.com,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        david@ixit.cz, Minchan Kim <minchan@google.com>,
        Zhongkun He <hezhongkun.hzk@bytedance.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Chris Li <chrisl@kernel.org> =E4=BA=8E2023=E5=B9=B412=E6=9C=889=E6=97=A5=E5=
=91=A8=E5=85=AD 07:56=E5=86=99=E9=81=93=EF=BC=9A
>
> Hi Nhat,
>
> On Thu, Dec 7, 2023 at 5:03=E2=80=AFPM Nhat Pham <nphamcs@gmail.com> wrot=
e:
> >
> > On Thu, Dec 7, 2023 at 4:19=E2=80=AFPM Chris Li <chrisl@kernel.org> wro=
te:
> > >
> > > Hi Nhat,
> > >
> > >
> > > On Thu, Dec 7, 2023 at 11:24=E2=80=AFAM Nhat Pham <nphamcs@gmail.com>=
 wrote:
> > > >
> > > > During our experiment with zswap, we sometimes observe swap IOs due=
 to
> > > > occasional zswap store failures and writebacks-to-swap. These swapp=
ing
> > > > IOs prevent many users who cannot tolerate swapping from adopting z=
swap
> > > > to save memory and improve performance where possible.
> > > >
> > > > This patch adds the option to disable this behavior entirely: do no=
t
> > > > writeback to backing swapping device when a zswap store attempt fai=
l,
> > > > and do not write pages in the zswap pool back to the backing swap
> > > > device (both when the pool is full, and when the new zswap shrinker=
 is
> > > > called).
> > > >
> > > > This new behavior can be opted-in/out on a per-cgroup basis via a n=
ew
> > > > cgroup file. By default, writebacks to swap device is enabled, whic=
h is
> > > > the previous behavior. Initially, writeback is enabled for the root
> > > > cgroup, and a newly created cgroup will inherit the current setting=
 of
> > > > its parent.
> > > >
> > > > Note that this is subtly different from setting memory.swap.max to =
0, as
> > > > it still allows for pages to be stored in the zswap pool (which its=
elf
> > > > consumes swap space in its current form).
> > > >
> > > > This patch should be applied on top of the zswap shrinker series:
> > > >
> > > > https://lore.kernel.org/linux-mm/20231130194023.4102148-1-nphamcs@g=
mail.com/
> > > >
> > > > as it also disables the zswap shrinker, a major source of zswap
> > > > writebacks.
> > >
> > > I am wondering about the status of "memory.swap.tiers" proof of conce=
pt patch?
> > > Are we still on board to have this two patch merge together somehow s=
o
> > > we can have
> > > "memory.swap.tiers" =3D=3D "all" and "memory.swap.tiers" =3D=3D "zswa=
p" cover the
> > > memory.zswap.writeback =3D=3D 1 and memory.zswap.writeback =3D=3D 0 c=
ase?
> > >
> > > Thanks
> > >
> > > Chris
> > >
> >
> > Hi Chris,
> >
> > I briefly summarized my recent discussion with Johannes here:
> >
> > https://lore.kernel.org/all/CAKEwX=3DNwGGRAtXoNPfq63YnNLBCF0ZDOdLVRsvzU=
mYhK4jxzHA@mail.gmail.com/
>
> Sorry I am traveling in a different time zone so not able to get to
> that email sooner. That email is only sent out less than one day
> before the V6 patch right?
>
> >
> > TL;DR is we acknowledge the potential usefulness of swap.tiers
> > interface, but the use case is not quite there yet, so it does not
>
> I disagree about no use case. No use case for Meta !=3D no usage case
> for the rest of the linux kernel community. That mindset really needs
> to shift to do Linux kernel development. Respect other's usage cases.
> It is not just Meta's Linux kernel. It is everybody's Linux kernel.
>
> I can give you three usage cases right now:
> 1) Google producting kernel uses SSD only swap, it is currently on
> pilot. This is not expressible by the memory.zswap.writeback. You can
> set the memory.zswap.max =3D 0 and memory.zswap.writeback =3D 1, then SSD
> backed swapfile. But the whole thing feels very clunky, especially
> what you really want is SSD only swap, you need to do all this zswap
> config dance. Google has an internal memory.swapfile feature
> implemented per cgroup swap file type by "zswap only", "real swap file
> only", "both", "none" (the exact keyword might be different). running
> in the production for almost 10 years. The need for more than zswap
> type of per cgroup control is really there.
>
> 2) As indicated by this discussion, Tencent has a usage case for SSD
> and hard disk swap as overflow.
> https://lore.kernel.org/linux-mm/20231119194740.94101-9-ryncsn@gmail.com/
> +Kairui

Yes, we are not using zswap. We are using ZRAM for swap since we have
many different varieties of workload instances, with a very flexible
storage setup. Some of them don't have the ability to set up a
swapfile. So we built a pack of kernel infrastructures based on ZRAM,
which so far worked pretty well.

The concern from some teams is that ZRAM (or zswap) can't always free
up memory so they may lead to higher risk of OOM compared to a
physical swap device, and they do have suitable devices for doing swap
on some of their machines. So a secondary swap support is very helpful
in case of memory usage peak.

Besides this, another requirement is that different containers may
have different priority, some containers can tolerate high swap
overhead while some cannot, so swap tiering is useful for us in many
ways.

And thanks to cloud infrastructure the disk setup could change from
time to time depending on workload requirements, so our requirement is
to support ZRAM (always) + SSD (optional) + HDD (also optional) as
swap backends, while not making things too complex to maintain.

Currently we have implemented a cgroup based ZRAM compression
algorithm control, per-cgroup ZRAM accounting and limit, and a
experimental kernel worker to migrate cold swap entry from high
priority device to low priority device at very small scale (lack of
basic mechanics to do this at large scale, however due to the low IOPS
of slow device and cold pages are rarely accessed, this wasn't too
much of a problem so far but kind of ugly). The rest of swapping (eg.
secondary swap when ZRAM if full) will depend on the kernel's native
ability.

So far it works, not in the best form, need more patches to make it
work better (eg. the swapin/readahead patch I sent previously). Some
of our design may also need to change in the long term, and we also
want a well built interface and kernel mechanics to manage multi tier
swaps, I'm very willing to talk and collaborate on this.
