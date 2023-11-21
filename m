Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13B1B7F2788
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Nov 2023 09:33:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229682AbjKUIdO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Nov 2023 03:33:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230026AbjKUIdJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Nov 2023 03:33:09 -0500
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63B2710E
        for <linux-kernel@vger.kernel.org>; Tue, 21 Nov 2023 00:33:05 -0800 (PST)
Received: by mail-lj1-x22f.google.com with SMTP id 38308e7fff4ca-2c5039d4e88so68238051fa.3
        for <linux-kernel@vger.kernel.org>; Tue, 21 Nov 2023 00:33:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700555583; x=1701160383; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kktn2kCkgc4KLPqSGzjESgPBOL1CAp2D1XThTJuldgc=;
        b=AfQxNJZJllkR3Sj4yYp+nHBYJeZBXXKVfdf4X5siAuqpiZro0uF80yhekvDZH9ngdy
         UuIhdhj6y6DhT4t9nkmjqhxH8oY98rPWp0kPIJsIAF02+l4kMvtCTbsKP+VLeNtghemf
         UuYsTsbQMRDINMCYRMAFvBI15ToCgNmllHm2+bWRopInG8MWzZfDchFMKH5ZDJCLbGFo
         LG6ijL7mLUJ4AeDVq02gR8KodNDai1ftrTdC9jNY6vupfPRHTLBWMHpUwEOvit/NRE06
         6Rm/vPbQLCKcx2ODR3iLv8SmgvIonmHzsQyyaLCqHQU3cgwjQZyYMBtNN9SM2C/qFkjl
         QZ9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700555583; x=1701160383;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kktn2kCkgc4KLPqSGzjESgPBOL1CAp2D1XThTJuldgc=;
        b=o1VHHEW0mBIm4jMUr1nO4KHWhXk4+pIebv9f/QTpaeBQ/lrgOicyx39BCQfLB8Na0l
         D9EJnSbgF39/w9FLpviZb/7e+qubR+cE12HyS0pdNVhlfSG1AQIhozXDKDTxLSahIWzL
         nVlgJ7fKS1bnCFFuJm4SMeV8bdLPHhJkFZBfM7TILKs/fwkAEUxkEX2kr48TOzmiLfSb
         VfO8EFNXarLVs0bTrm/3m8jG3P9esHbBrTsiXhUz1bZQhQK5SdmgMZgAV/O49F5l2LRe
         pfvS9B5FXCq9/QSn1EZj8nJ4SK1tpC7zHKG8GF1eHoZDRgCPa8Gd4VRU96j52JGRrvvn
         vvqw==
X-Gm-Message-State: AOJu0Ywa004Owt1Q06enzZoTwdMrQr3nzgA8qb1fhUWgrIdfzHFYSVUg
        rSBKX51ZnCSJWkTZB/heUjxCbB61IXlX8Mqkxkw=
X-Google-Smtp-Source: AGHT+IF/qOJGJTO2jraPYdjK5ZA8IM2A5XciQUwXIlfRnuBEqvG83GhqFgMIBjpolAW/GjGsEzBvL/gKHJQr1rZxMSw=
X-Received: by 2002:a2e:6e05:0:b0:2c5:32b:28ea with SMTP id
 j5-20020a2e6e05000000b002c5032b28eamr6351919ljc.32.1700555583359; Tue, 21 Nov
 2023 00:33:03 -0800 (PST)
MIME-Version: 1.0
References: <20231119194740.94101-1-ryncsn@gmail.com> <20231119194740.94101-6-ryncsn@gmail.com>
 <CAF8kJuMx5HbSRogY4mVoZ1EELHbmZpOnwv5fRdOE7xvNhjZDbA@mail.gmail.com>
 <CAMgjq7Bo8=gTe2LTtwVruakvj2RLjMHkqxDC3bY0gwpEPKjzRw@mail.gmail.com> <CAF8kJuMoiGe3e98Lx0NWmb25vVx0s3SdKqR3yiiG2rQKk0ztNQ@mail.gmail.com>
In-Reply-To: <CAF8kJuMoiGe3e98Lx0NWmb25vVx0s3SdKqR3yiiG2rQKk0ztNQ@mail.gmail.com>
From:   Kairui Song <ryncsn@gmail.com>
Date:   Tue, 21 Nov 2023 16:32:45 +0800
Message-ID: <CAMgjq7Cf1jQnnvWB-DCORhGBacbbnKa4Q_G-+3Z7Nwz-Ogxxzw@mail.gmail.com>
Subject: Re: [PATCH 05/24] mm/swap: move readahead policy checking into swapin_readahead
To:     Chris Li <chrisl@kernel.org>
Cc:     linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        "Huang, Ying" <ying.huang@intel.com>,
        David Hildenbrand <david@redhat.com>,
        Hugh Dickins <hughd@google.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Matthew Wilcox <willy@infradead.org>,
        Michal Hocko <mhocko@suse.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Chris Li <chrisl@kernel.org> =E4=BA=8E2023=E5=B9=B411=E6=9C=8821=E6=97=A5=
=E5=91=A8=E4=BA=8C 15:41=E5=86=99=E9=81=93=EF=BC=9A
>
> On Mon, Nov 20, 2023 at 10:35=E2=80=AFPM Kairui Song <ryncsn@gmail.com> w=
rote:
> >
> > Chris Li <chrisl@kernel.org> =E4=BA=8E2023=E5=B9=B411=E6=9C=8821=E6=97=
=A5=E5=91=A8=E4=BA=8C 14:18=E5=86=99=E9=81=93=EF=BC=9A
> > >
> > > On Sun, Nov 19, 2023 at 11:48=E2=80=AFAM Kairui Song <ryncsn@gmail.co=
m> wrote:
> > > >
> > > > From: Kairui Song <kasong@tencent.com>
> > > >
> > > > This makes swapin_readahead a main entry for swapin pages,
> > > > prepare for optimizations in later commits.
> > > >
> > > > This also makes swapoff able to make use of readahead checking
> > > > based on entry. Swapping off a 10G ZRAM (lzo-rle) is faster:
> > > >
> > > > Before:
> > > > time swapoff /dev/zram0
> > > > real    0m12.337s
> > > > user    0m0.001s
> > > > sys     0m12.329s
> > > >
> > > > After:
> > > > time swapoff /dev/zram0
> > > > real    0m9.728s
> > > > user    0m0.001s
> > > > sys     0m9.719s
> > > >
> > > > And what's more, because now swapoff will also make use of no-reada=
head
> > > > swapin helper, this also fixed a bug for no-readahead case (eg. ZRA=
M):
> > > > when a process that swapped out some memory previously was moved to=
 a new
> > > > cgroup, and the original cgroup is dead, swapoff the swap device wi=
ll
> > > > make the swapped in pages accounted into the process doing the swap=
off
> > > > instead of the new cgroup the process was moved to.
> > > >
> > > > This can be easily reproduced by:
> > > > - Setup a ramdisk (eg. ZRAM) swap.
> > > > - Create memory cgroup A, B and C.
> > > > - Spawn process P1 in cgroup A and make it swap out some pages.
> > > > - Move process P1 to memory cgroup B.
> > > > - Destroy cgroup A.
> > > > - Do a swapoff in cgroup C.
> > > > - Swapped in pages is accounted into cgroup C.
>
> In a strange way it makes sense to charge to C.
> Swap out =3D=3D free up memory.
> Swap in =3D=3D consume memory.
> C turn off swap, effectively this behavior will consume a lot of memory.
> C gets charged, so if the C is out of memory, it will punish C.
> C will not be able to continue swap in memory. The problem gets under con=
trol.

Yes, I think charging either C or B makes sense in their own way. To
me I think current behavior is kind of counter-intuitive.

Image if there are cgroup PC1, and its child cgroup CC1, CC2. If a process
swapped out some memory in CC1 then moved to CC2, and CC1 is dying.
On swapoff the charge will be moved out of PC1...

And swapoff often happens in some unlimited admin cgroup or some
cgroup for management agents.

If PC1 has a memory limit, the process in it can breach the limit easily,
we will see a process that never left PC1 having a much higher RSS
than PC1/CC1/CC2's limit.

And if there is a limit for the management agent cgroup, the agent
will be OOM instead of OOM in PC1.

Simply moving a process between the child cgroup of the same parent
cgroup won't cause a similar issue, things get weird when swapoff is
involved.

And actually with multiple layers of swap, it's less risky to swapoff
a device since other swap devices can catch over committed memory.

Oh, and there is one more case I forgot to cover in this series:
Moving a process is indeed something not happening very frequently,
but a process run in cgroup then exit, and leave some shmem swapped
out could be a common case.
Current behavior on swapoff will move these charges out of the
original parent cgroup too.

So maybe a more ideal solution for swapoff is: simply always charge a
dying cgroup parent cgroup?

Maybe a sysctl/cmdline could be introduced to control the behavior.
