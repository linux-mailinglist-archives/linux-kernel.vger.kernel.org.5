Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E3AE7EF61F
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Nov 2023 17:23:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346061AbjKQQX6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Nov 2023 11:23:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231429AbjKQQX5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Nov 2023 11:23:57 -0500
Received: from mail-il1-x12c.google.com (mail-il1-x12c.google.com [IPv6:2607:f8b0:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 240C7C2;
        Fri, 17 Nov 2023 08:23:54 -0800 (PST)
Received: by mail-il1-x12c.google.com with SMTP id e9e14a558f8ab-35930447ae9so7624405ab.2;
        Fri, 17 Nov 2023 08:23:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700238233; x=1700843033; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8HY3OnVTgtQKIkvUFu/Wup26uztbm0Mpw/x2KgDlsNQ=;
        b=Zpw8lGYlQFPLO3Me2jFMffy+xUITaSKhhlf5cMUIK4W4/tiT+aaGn1TlMpw9iFcekP
         LRFBCPivmXZVMFMgq8qmcHDO678xX65IOYRTsMtWQMezaEGnUJUDCrtKz4ePnRvUItjg
         DvvENKT1gPNfXOn+ojCHyeaRohvdZdMIHMU7XIuzpssodtAiTNUrKoTzId+hUmIZ56WJ
         U2/P+jght3fBfCOVPDtf0qjTcl6eedAa8tXWz2Z651MAJjkUSl7ShAd1jNZU27PhaeyV
         LLNudVfnHfuVZ0fksw7lYOp76ZLqrF1q53CRnNu6wVoMkYL0BfUO06TMGkVXLh8I8xuS
         xc+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700238233; x=1700843033;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8HY3OnVTgtQKIkvUFu/Wup26uztbm0Mpw/x2KgDlsNQ=;
        b=BTn7gPUFEr7ioOeNzefhJJQNceu22pG7XNbarzcJIRMF3coNfHL/z11pZOsemsLyUU
         2oiEskFegjxY1qUisKdxJpYiuB312rL7gA0jkvTgZG6rK3t1Op0yStEf3D+ldSRRFQRD
         cNQb4MFO3DiLu9vCU8UqrOCI0mMP41YMYGnj8vyZpLzOfGZhAhKtfBPxxYcy29at/0Gr
         qpDfbWQvrwKapBjMgwwy6io9xwV/v9FA72KaZncoIHlLcRdFYF0oPit7zEcCeMZCVie8
         ndQr8g8ybK+i0ryejbhW8nCL/5YYkUG0VAao3PFIreP7ki1TNZQ149uVurIPfskkL/d7
         7oUQ==
X-Gm-Message-State: AOJu0Yzy1aNkZGf7hMixH7hNJdW9HeVYvGTPSotM16l0z5Y3MQZJ4lVY
        dB4TW45djvQG3LOWSy7Yo3me4/t3SyMLVJ7p9X0=
X-Google-Smtp-Source: AGHT+IE8umluZh8kaxX4xer4Ito39mFDkbM9a2+4ENbNdd1TaPsyCYNPf/DYD9CUEAVPm8cTq7gnKp0bcCEBpoQzxoU=
X-Received: by 2002:a05:6e02:1c89:b0:359:30de:eb42 with SMTP id
 w9-20020a056e021c8900b0035930deeb42mr27037936ill.17.1700238233347; Fri, 17
 Nov 2023 08:23:53 -0800 (PST)
MIME-Version: 1.0
References: <20231106183159.3562879-1-nphamcs@gmail.com> <CAF8kJuMsXUm9=kiL8qPNVfYPzfyq-JWYSH3KraZadjF+myW-2A@mail.gmail.com>
 <CAKEwX=MNKY0UHbxi6Zfwf0KkepYavFaZo8F6LGe5GyyE3U35Jg@mail.gmail.com>
 <CAF8kJuMx4KT9z2RPy8z+snhM6YUtK=kZ1+BdHjKua2jhwFo-XQ@mail.gmail.com>
 <CAKEwX=OpQZhDmCr-a+O0=c8LfPoO0r8y=abpQoKXWcOP+V6yYg@mail.gmail.com>
 <CAF8kJuNnM_0jDCaAueseiNA1264-MtA0QiQtfjEN1E6aY56MKQ@mail.gmail.com> <CAF8kJuN5fBBmpOzmR72B5NBmjPNCNk4DALqz=+PKBwQrjvHH2w@mail.gmail.com>
In-Reply-To: <CAF8kJuN5fBBmpOzmR72B5NBmjPNCNk4DALqz=+PKBwQrjvHH2w@mail.gmail.com>
From:   Nhat Pham <nphamcs@gmail.com>
Date:   Fri, 17 Nov 2023 11:23:42 -0500
Message-ID: <CAKEwX=P343G80Bfbf1R+FfSxty763Bo3WCo_Pu0GOuZSJjnxRw@mail.gmail.com>
Subject: Re: [PATCH v5 0/6] workload-specific and memory pressure-driven zswap writeback
To:     Chris Li <chrisl@kernel.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Domenico Cerasuolo <cerasuolodomenico@gmail.com>,
        Yosry Ahmed <yosryahmed@google.com>,
        Seth Jennings <sjenning@redhat.com>,
        Dan Streetman <ddstreet@ieee.org>,
        Vitaly Wool <vitaly.wool@konsulko.com>, mhocko@kernel.org,
        roman.gushchin@linux.dev, Shakeel Butt <shakeelb@google.com>,
        muchun.song@linux.dev, linux-mm <linux-mm@kvack.org>,
        kernel-team@meta.com, LKML <linux-kernel@vger.kernel.org>,
        cgroups@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kselftest@vger.kernel.org, shuah@kernel.org
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

On Thu, Nov 16, 2023 at 4:57=E2=80=AFPM Chris Li <chrisl@kernel.org> wrote:
>
> Hi Nhat,
>
> I want want to share the high level feedback we discussed here in the
> mailing list as well.
>
> It is my observation that each memcg LRU list can't compare the page
> time order with other memcg.
> It works great when the leaf level memcg hits the memory limit and you
> want to reclaim from that memcg.
> It works less well on the global memory pressure you need to reclaim
> from all memcg. You kind of have to
> scan each all child memcg to find out the best page to shrink from. It
> is less effective to get to the most desirable page quickly.
>
> This can benefit from a design similar to MGLRU. This idea is
> suggested by Yu Zhao, credit goes to him not me.
> In other words, the current patch is similar to the memcg page list
> pre MGLRU world. We can have a MRLRU
> like per memcg zswap shrink list.

I was gonna summarize the points myself :P But thanks for doing this.
It's your idea so you're more qualified to explain this anyway ;)

I absolutely agree that having a generation-aware cgroup-aware
NUMA-aware LRU is the future way to go. Currently, IIUC, the reclaim logic
selects cgroups in a round-robin-ish manner. It's "fair" in this perspectiv=
e,
but I also think it's not ideal. As we have discussed, the current list_lru
infrastructure only take into account intra-cgroup relative recency, not
inter-cgroup relative recency. The recently proposed time-based zswap
reclaim mechanism will provide us with a source of information, but the
overhead of using this might be too high - and it's very zswap-specific.

Maybe after this, we should improve zswap reclaim (and perhaps all
list_lru users) by adding generations to list_lru then take generations
into account in the vmscan code. This patch series could be merged
as-is, and once we make list_lru generation-aware, zswap shrinker
will automagically be improved (along with all other list_lru/shrinker
users).

I don't know enough about the current design of MGLRU to comment
too much further, but let me know if this makes sense, and if you have
objections/other ideas.

And if you have other documentations for MGLRU than its code, could
you please let me know? I'm struggling to find more details about this.


>
>
> Chris
>
> On Wed, Nov 8, 2023 at 6:10=E2=80=AFPM Chris Li <chrisl@kernel.org> wrote=
:
> >
> > On Wed, Nov 8, 2023 at 4:28=E2=80=AFPM Nhat Pham <nphamcs@gmail.com> wr=
ote:
> > >
> > > Hmm my guess is that I probably sent this out based on an outdated
> > > mm-unstable. There has since been a new zswap selftest merged
> > > to mm-unstable (written by no other than myself - oh the irony), so
> > > maybe it does not apply cleanly anymore with git am.
> >
> > $ git am -3 patches/zswap-pool-lru/0005
> > Applying: selftests: cgroup: update per-memcg zswap writeback selftest
> > Using index info to reconstruct a base tree...
> > M       tools/testing/selftests/cgroup/test_zswap.c
> > Falling back to patching base and 3-way merge...
> > Auto-merging tools/testing/selftests/cgroup/test_zswap.c
> > $ git am -3 patches/zswap-pool-lru/0006
> > Applying: zswap: shrinks zswap pool based on memory pressure
> > error: sha1 information is lacking or useless (mm/zswap.c).
> > error: could not build fake ancestor
> > Patch failed at 0001 zswap: shrinks zswap pool based on memory pressure
> > hint: Use 'git am --show-current-patch=3Ddiff' to see the failed patch
> > When you have resolved this problem, run "git am --continue".
> > If you prefer to skip this patch, run "git am --skip" instead.
> > To restore the original branch and stop patching, run "git am --abort".
> >
> > I was able to resolve the conflict on patch 6 by hand though. So I am g=
ood now.
> >
> > Thanks
> >
> > Chris
