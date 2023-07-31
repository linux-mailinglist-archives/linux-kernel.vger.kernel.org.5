Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 930FF76A272
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jul 2023 23:08:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231215AbjGaVIV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 17:08:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230195AbjGaVIT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 17:08:19 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 868AB12B
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jul 2023 14:08:15 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id 98e67ed59e1d1-268541d2947so2771441a91.3
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jul 2023 14:08:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690837695; x=1691442495;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=IRIxzkj/mYkqmKG6xRHKL20yhyzoztjP/DiaXxaQUwI=;
        b=knWBLO2AQOj9qzOHTgm9wJ7q7hdFRfoRMP3hLqTefy1ffrpd+gauB6gby/WwkIDbLy
         vYhJIAZhDgBI3IlAei+VlGC3/uhdMZ2lwHs2SU+C1SaCttK76IWvNol7ICb6yJNQ7eFZ
         UvBHIuUjP+BdP6/H31vpIxQOYTT0cjs4kv2rQ/KvVcUFJeVeYIH7ZDmWVOcckjNQ6bJt
         XXpNoucitz1/Pm/CKGAAYuZUv1lSRx3uEHBjM46AeANGFeKTgUwrkaXgpZ3P6KODfNPF
         nQX3Ki+au+nTPSL0SbBadvlmN3b5fiyK28jHxLREi/9shRYPzLGbE+FfHT1Et6y8VXT9
         eCrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690837695; x=1691442495;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IRIxzkj/mYkqmKG6xRHKL20yhyzoztjP/DiaXxaQUwI=;
        b=RjFGzB4BdBYmuvMTEPKdUkRKxRBskuaWQAgxfXLh+Nm8OTm120j1d72ovvo++BnPcX
         hUvCXl79xDQgZLm6/M+TMFUAToe+Q5FE+3Vp9YD7deSZxXuHcHPOxOkexcP7HhhplIJQ
         xg9ihulirfLzUAhLT3cP3M0S3fSBSfo8G85vFeyM1kq5PozKFMivfd+AGuv8yV/o5Qs3
         thQmZJ+lCz7rL1vTG+X7wkn0Bpj7dT54Oosz9nRdWA017WgXgzNG4CdbisWZZhbMjFtv
         LH2wDhJbqKVTX/qeaAvXwZ488HeWAcQ7Lw3U2fpIZAd7zq6L4FjNgYDFEczOd9n+adfM
         DmxQ==
X-Gm-Message-State: ABy/qLaqzlaPIiPRfyzzTlYGVjBl0dLtwb+6dauRikjdV1bFX5Mym6sk
        LamI2EjRZnRd/zhI9LjNwQGn4nVZD8ca3nrGta1h7hX2mjM=
X-Google-Smtp-Source: APBJJlEIhII9e/oCHP7R4mP1dRJJ3sLRcKSn4WIB4nz60mB7jDXICUu0bVjtGozY5aLYGJ3BF0LGVU0tqurEl36Z4Ec=
X-Received: by 2002:a17:90b:4c0a:b0:268:1745:b61 with SMTP id
 na10-20020a17090b4c0a00b0026817450b61mr8871077pjb.34.1690837694838; Mon, 31
 Jul 2023 14:08:14 -0700 (PDT)
MIME-Version: 1.0
References: <b39c62d29a431b023e98959578ba87e96af0e030.camel@gmx.de>
 <20230728141852.GA21718@willie-the-truck> <8c56256399e2e6c41bc574749d6170d5529f24fc.camel@gmx.de>
 <20230731104340.GA24767@willie-the-truck> <20230731115207.GB24767@willie-the-truck>
In-Reply-To: <20230731115207.GB24767@willie-the-truck>
From:   Lorenzo Stoakes <lstoakes@gmail.com>
Date:   Mon, 31 Jul 2023 22:08:03 +0100
Message-ID: <CAA5enKaUYehLZGL3abv4rsS7caoUG-pN9wF3R+qek-DGNZufbA@mail.gmail.com>
Subject: Re: arm64: perf test 26 rpi4 oops
To:     Will Deacon <will@kernel.org>
Cc:     Mike Galbraith <efault@gmx.de>,
        lkml <linux-kernel@vger.kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        wangkefeng.wang@huawei.com, catalin.marinas@arm.com,
        ardb@kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 31 Jul 2023 at 12:52, Will Deacon <will@kernel.org> wrote:
>
> On Mon, Jul 31, 2023 at 11:43:40AM +0100, Will Deacon wrote:
> > [+Lorenzo, Kefeng and others]
> >
> > On Sun, Jul 30, 2023 at 06:09:15PM +0200, Mike Galbraith wrote:
> > > On Fri, 2023-07-28 at 15:18 +0100, Will Deacon wrote:
> > > >
> > > > Looking at this quickly with Mark, the most likely explanation is that
> > > > a bogus kernel address is being passed as the source pointer to
> > > > copy_to_user().
> > >
> > > 'start' in read_kcore_iter() is bogus a LOT when running perf test 26,
> > > and that back to at least 5.15.  Seems removal of bogon-proofing gave a
> > > toothless old bug teeth, but seemingly only to perf test 26.  Rummaging
> > > around with crash vmlinux /proc/kcore seems to be bogon free anyway.
> > >
> > > Someone should perhaps take a peek at perf.  Bogons aside, it also
> > > doesn't seem to care deeply about kernel response.  Whether the kernel
> > > oops or I bat 945 bogons aside, it says 'OK'.  That seems a tad odd.
> >
> > Aha, so I think I triggered the issue you're seeing under QEMU (log
> > below). perf (unhelpfully) doesn't have stable test numbers, so it's
> > test 21 in my case. However, it only explodes if I run it as root, since
> > /proc/kcore is 0400 on my system.
> >
> > The easiest way to trigger the problem is simply:
> >
> > # objdump -d /proc/kcore
> >
> > Looking at the history, I wonder whether this is because of a combination
> > of:
> >
> > e025ab842ec3 ("mm: remove kern_addr_valid() completely")
> >
> > which removed the kern_addr_valid() check on the basis that kcore used
> > copy_from_kernel_nofault() anyway, and:
> >
> > 2e1c0170771e ("fs/proc/kcore: avoid bounce buffer for ktext data")
> >
> > which replaced the copy_from_kernel_nofault() with _copy_to_user().
> >
> > So with both of those applied, we're missing the address check on arm64.
>
> Digging into this a little more, the fault occurs because kcore is
> treating everything from '_text' to '_end' as KCORE_TEXT and expects it
> to be mapped linearly. However, there's plenty of stuff we _don't_ map
> in that range on arm64 (e.g. .head.text, the pKVM hypervisor, the entry
> trampoline) so kcore is broken.
>
> One hack is to limit KCORE_TEXT to actually point at the kernel text
> (see below), but this is a user-visible change in behaviour for things
> like .data so I think it would be better to restore the old behaviour
> of handling the faults.
>
> Lorenzo?

FYI there is a parallel discussion at
https://lore.kernel.org/all/ZHc2fm+9daF6cgCE@krava/ :)

[sorry lei isn't playing ball so will have to reply from gmail,
apologies if this breaks formatting]

It'd be a real pity to have to revert that behaviour, as using a
bounce buffer is such a hack and means you have to iterate through a
page at a time...
Either that or a change such that for KCORE_TEXT specifically we
reinstate the bounce buffer and use copy_from_kernel_nofault().

It definitely is a bug in kcore to have ranges of memory that are not
mapped marked as readable. What kind of behaviour changes do you
anticipate exactly with your prospective change re: .data? The
fallthroughs?

kcore as a whole needs some love and attention I think.

An alternative is to implement some version of
copy_from_kernel_nofault() in the iterator code.

However TL;DR - I think we probably do need a semi-revert and to just
make the ktext do a bounce buffer thing. I definitely want to keep the
use of iterators so I would really not want to revert anything else.


>
> Will
>
> --->8
>
> diff --git a/fs/proc/kcore.c b/fs/proc/kcore.c
> index 9cb32e1a78a0..3696a209c1ec 100644
> --- a/fs/proc/kcore.c
> +++ b/fs/proc/kcore.c
> @@ -635,7 +635,7 @@ static struct kcore_list kcore_text;
>   */
>  static void __init proc_kcore_text_init(void)
>  {
> -       kclist_add(&kcore_text, _text, _end - _text, KCORE_TEXT);
> +       kclist_add(&kcore_text, _stext, _etext - _stext, KCORE_TEXT);
>  }
>  #else
>  static void __init proc_kcore_text_init(void)
>


--
Lorenzo Stoakes
https://ljs.io
