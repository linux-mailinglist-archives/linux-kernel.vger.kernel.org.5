Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DDE137A835C
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Sep 2023 15:27:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235913AbjITN1v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Sep 2023 09:27:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235395AbjITN1p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Sep 2023 09:27:45 -0400
Received: from mail-io1-xd29.google.com (mail-io1-xd29.google.com [IPv6:2607:f8b0:4864:20::d29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B071EB9
        for <linux-kernel@vger.kernel.org>; Wed, 20 Sep 2023 06:27:38 -0700 (PDT)
Received: by mail-io1-xd29.google.com with SMTP id ca18e2360f4ac-79275d86bc3so260610639f.0
        for <linux-kernel@vger.kernel.org>; Wed, 20 Sep 2023 06:27:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1695216458; x=1695821258; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pxmkOVmqg0w7S+b+PvaPKg1h4GhbRDe20ma+fxrU2Jk=;
        b=N3w4/QY1zlkWTN5KvqUxGbzel5i+9D6kqgvikP9+kFbexkrzilVt2I7J8mSGAaDNpI
         p9OJ0T9EBflnAWdygXdPPMityM2GjcVmWfz+YbYUWspoMaJMx4ZvA+bXjP/kpuQUFtWE
         jqHawD+tlHc/DMsMqaTwkoF3dolKXrzdA7a32PirTHG/VTo0G39OhcKq0ob/xt1ZQkDY
         EmKYmFHBKiXC+9bQ364njqBVN8sUzD5NPj5zwA+rqR9kCCE+aVcpVKutJlUgnTLycS0a
         pHfYoinGoPdCMaJ3CBkwhriOw5e7zu4/ES75OdQACJeGb5NHjUkH+3OuwHaXRbEciB2d
         xwPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695216458; x=1695821258;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pxmkOVmqg0w7S+b+PvaPKg1h4GhbRDe20ma+fxrU2Jk=;
        b=hz7eaJmblpKGxd8DkCbwAQ8fgDxTezAGkVgc+q7SFHIjGTEUARNTQ5fcV9r5OTuq/b
         XwgIIHFVpZhJEMLeZZWF204Qlf0nyWZT8ic41nL/e4KdLojFborCyR/gpea/kxiz20kr
         xTOz6IJbl96LPX86fkQbWOQzH2ejyT4nkx0yBZ2Uji7DhcHF5MiAIv2WM6MU1aW8KfIv
         jikxeZzF7wfV65pONHPpRQ6pySdHsXcVdPHPWUB/GC6LMOpsYnPkQaEcNsctqeQ94Gbs
         Af2eglW6C3C8/fpCc4M9o8nt0qYTqKnEqdxdH20f0pvGl/Ml+MXC/DTpEQuCy9fMoeLj
         fSRg==
X-Gm-Message-State: AOJu0Yz10I4eBGedlZZyBp2OoPjkM8xgesxoI+uv90d8CZLzSxesskMT
        VhhPFL8FqEhqAshITbahImuKK+WjAHiOK5dPWzokZw==
X-Google-Smtp-Source: AGHT+IFy9hxulcu2v9lQ7eQg8rvjQuk2d1N0FGGDKq1pbfB/acolKaVtBYo3s77xYrcVWoMjkIfORKp9iETOvNS12UA=
X-Received: by 2002:a5e:d60c:0:b0:787:8cf:fd08 with SMTP id
 w12-20020a5ed60c000000b0078708cffd08mr3049826iom.17.1695216457998; Wed, 20
 Sep 2023 06:27:37 -0700 (PDT)
MIME-Version: 1.0
References: <20230720173956.3674987-1-glider@google.com> <20230720173956.3674987-6-glider@google.com>
 <ZN+13iQ4oOgpKhNO@arm.com>
In-Reply-To: <ZN+13iQ4oOgpKhNO@arm.com>
From:   Alexander Potapenko <glider@google.com>
Date:   Wed, 20 Sep 2023 15:26:57 +0200
Message-ID: <CAG_fn=Wr86MxbhxajObGw+Zoa_Y8zhGb8RVwhZdQmKxj4mxdTA@mail.gmail.com>
Subject: Re: [PATCH v4 5/5] arm64: mte: add compression support to mteswap.c
To:     Catalin Marinas <catalin.marinas@arm.com>
Cc:     will@kernel.org, pcc@google.com, andreyknvl@gmail.com,
        andriy.shevchenko@linux.intel.com, linux@rasmusvillemoes.dk,
        yury.norov@gmail.com, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, eugenis@google.com,
        syednwaris@gmail.com, william.gray@linaro.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 18, 2023 at 8:18=E2=80=AFPM Catalin Marinas <catalin.marinas@ar=
m.com> wrote:
>
> On Thu, Jul 20, 2023 at 07:39:56PM +0200, Alexander Potapenko wrote:
> > Soon after booting Android, tag compression saves ~2.5x memory previous=
ly
> > spent by mteswap.c on tag allocations. With the growing uptime, the
> > savings reach 20x and even more.
>
> This sounds like a marketing claim ;). The way I read your statement is
> that the memory used for tag storage is 2.5x less with your patches and
> that's great. It means a 2.5x compression on average. How does the
> compression get so much better to 20x with more uptime?

I am currently looking at this, and I think this happens because some
userspace apps assign zero tags to userspace pages, and those tags are
effectively zero-cost, because they can be compressed into 8 bytes of
the Xarray pointer.
As the uptime grows, the share of such pages also grows.
I agree though that this is a marginal use case, and the average
compression rate is more representative.

> The number of
> tag storage allocations should be proportional to the pages swapped out
> (not equal as not all would be mapped as PROT_MTE).

We think a reasonable upper bound for PROT_MTE pages is 40%, but
currently it is probably more like 20%.


> So you can indeed
> have a lot more pages swapped out than available in RAM and the tag
> storage can take space but not sure which numbers you divided to get
> 20x.

Right now (in kernel 6.5) the amount of memory spent to store the tags
can be calculated as 128 * (number of mte_allocate_tag_storage() calls
- number of mte_free_tag_storage() calls).
In my patchset I calculate the total amount of memory
allocated/deallocated from the mte-tags-N caches and compare that with
128 * (total number of live objects in those caches).
E.g. the stats after booting up the device (~120s uptime) look as follows:

8 bytes: 14007 allocations, 256 deallocations
16 bytes: 1583 allocations, 179 deallocations
32 bytes: 1634 allocations, 205 deallocations
64 bytes: 1538 allocations, 142 deallocations
128 bytes: 10881 allocations, 1340 deallocations
uncompressed tag storage size: 3522688
compressed tag storage size: 1488792

(note 8-byte allocations contribute to uncompressed storage, but not
to compressed storage).

After running various apps, I made the device use almost 19Mb swap space:
8 bytes: 71352 allocations, 8093 deallocations
16 bytes: 5102 allocations, 2598 deallocations
32 bytes: 8206 allocations, 4536 deallocations
64 bytes: 9489 allocations, 5377 deallocations
128 bytes: 43258 allocations, 23364 deallocations
uncompressed tag storage size: 11960192
compressed tag storage size: 2967104

(Note the share of allocations compressed into 8 bytes is slowly growing)

In this case the compression ratio is 4x. I must admit I could not
reproduce the 20x compression this time, and after thinking a little I
anticipate the absolute values to be lower in that case (maybe that
was observed at some point where a lot of uncompressed data was
evicted from swap).

I therefore think I'd better make a modester claim in the docs/patch
description.



>
> Anyway, it would be nice to see the full picture of what the savings
> relative to the total RAM is. Given that the swap in this instance is
> zram, you have an upper bound of how many pages it can store. I'm just
> trying to assess whether the complexity added here is worth it.
>
> Maybe not as good as the RLE algorithm here, I was wondering whether we
> could use zswap to save the tags together with the page. I looked some
> time ago at it seemed slightly easier for zswap than zram. Another
> option is to make the swap format more generic to support metadata
> storage. Yet another option is for the zram to flag that it can compress
> the metadata together with the data (no swap format change needed; when
> decompressing the page, it populates the tags as well).
>
> --
> Catalin



--
Alexander Potapenko
Software Engineer

Google Germany GmbH
Erika-Mann-Stra=C3=9Fe, 33
80636 M=C3=BCnchen

Gesch=C3=A4ftsf=C3=BChrer: Paul Manicle, Liana Sebastian
Registergericht und -nummer: Hamburg, HRB 86891
Sitz der Gesellschaft: Hamburg
