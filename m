Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4FD1E76A36A
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jul 2023 23:54:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231590AbjGaVy1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 17:54:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230266AbjGaVy0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 17:54:26 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11FB1118
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jul 2023 14:54:25 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id 98e67ed59e1d1-26830595676so3594677a91.2
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jul 2023 14:54:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690840464; x=1691445264;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=j47xDzapVv4+9mNh0KQtNiNLPRXurnTBapBDIjsG/s8=;
        b=Z3BP2y5LsmWSUYyUcDTbcIDnGH3IBZ1Op2h0y7oAWMnWy2KMVcTdOEyclvKGthBOMf
         Mvumtdv82SYwP3OV9RMXRHAoKKuMGOOcLFydBKxEG5x0ye1VfkoS1lT2cKKUJSo1Y4FU
         0YL0AvVxS9Tyb8Y89WfEdDsOIluNgg+ArMVeTlOwolL6JSMh/KUenE66uemTflJzijf5
         0CFqA2ESDT2+bHT2y7wXloj1yv7glAsNaZCzha7Gg9p7puGi+t/CePK8vl/YX4YgtC8S
         iKDWwCghAIgdSH26L6JhmjHOhBh6Cw7UOVaf6xfKc5v+IRvLP3z8zasFeJVFTvWdiMbR
         6Nrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690840464; x=1691445264;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=j47xDzapVv4+9mNh0KQtNiNLPRXurnTBapBDIjsG/s8=;
        b=FScQr0QGBWlL8GnWN1ZDyH4lQ5JcNbnsOZAZAXw6OFZZMgoS9ZBviRcP9bEkbJ9W5z
         tdRRYBLcXUKp7PtYGsK5UaqJX/94xrsDQUhPS2kS10NsAn+U8qGgHB9ZhaOazCdvcZHF
         DLxSEdI7nIF1jcmbBw1WturWU1fGdfE7gM0ON6INC30/TbdLQcAW888VPx58AQH5rZJI
         3skqIXYVCZAunvrmaT6uLstqDsbBADRVHQagfopsxQLm0GJF/Ur5qLga6OD++lXedA/Q
         NByIrEFwVe3Onc90DQltHi1FQbAquO7BcRtBDbSbZ4VUKtePaXGiyfv7/riiuglKzeSw
         A5nA==
X-Gm-Message-State: ABy/qLarVWMraRE4Y5eNPvzjQoptsi46ZKV4JahWk9oYb0XwuDi7+7VN
        +Kf8dgU9N3RbhrhuucXLPiR14TmqGp2cCP/6jzd4M4o6nGk=
X-Google-Smtp-Source: APBJJlHrmWSjYznHp7oMY1HeGiL3GpxaF7D3vj1fKzeHh9bmWRVkkum94oOPve2In0fgmZTl8YoWbNaibAxZgzHuOo8=
X-Received: by 2002:a17:90a:5a82:b0:262:ec13:d3a with SMTP id
 n2-20020a17090a5a8200b00262ec130d3amr11433628pji.28.1690840464252; Mon, 31
 Jul 2023 14:54:24 -0700 (PDT)
MIME-Version: 1.0
References: <b39c62d29a431b023e98959578ba87e96af0e030.camel@gmx.de>
 <20230728141852.GA21718@willie-the-truck> <8c56256399e2e6c41bc574749d6170d5529f24fc.camel@gmx.de>
 <20230731104340.GA24767@willie-the-truck> <20230731115207.GB24767@willie-the-truck>
 <CAA5enKaUYehLZGL3abv4rsS7caoUG-pN9wF3R+qek-DGNZufbA@mail.gmail.com>
In-Reply-To: <CAA5enKaUYehLZGL3abv4rsS7caoUG-pN9wF3R+qek-DGNZufbA@mail.gmail.com>
From:   Lorenzo Stoakes <lstoakes@gmail.com>
Date:   Mon, 31 Jul 2023 22:54:12 +0100
Message-ID: <CAA5enKYaZ-daLeL3amr2QrQjtUdK=P8B+VbJdea7cB77QWY-eQ@mail.gmail.com>
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

On Mon, 31 Jul 2023 at 22:08, Lorenzo Stoakes <lstoakes@gmail.com> wrote:
>
> On Mon, 31 Jul 2023 at 12:52, Will Deacon <will@kernel.org> wrote:
> >
> > On Mon, Jul 31, 2023 at 11:43:40AM +0100, Will Deacon wrote:
> > > [+Lorenzo, Kefeng and others]
> > >
> > > On Sun, Jul 30, 2023 at 06:09:15PM +0200, Mike Galbraith wrote:
> > > > On Fri, 2023-07-28 at 15:18 +0100, Will Deacon wrote:
> > > > >
> > > > > Looking at this quickly with Mark, the most likely explanation is that
> > > > > a bogus kernel address is being passed as the source pointer to
> > > > > copy_to_user().
> > > >
> > > > 'start' in read_kcore_iter() is bogus a LOT when running perf test 26,
> > > > and that back to at least 5.15.  Seems removal of bogon-proofing gave a
> > > > toothless old bug teeth, but seemingly only to perf test 26.  Rummaging
> > > > around with crash vmlinux /proc/kcore seems to be bogon free anyway.
> > > >
> > > > Someone should perhaps take a peek at perf.  Bogons aside, it also
> > > > doesn't seem to care deeply about kernel response.  Whether the kernel
> > > > oops or I bat 945 bogons aside, it says 'OK'.  That seems a tad odd.
> > >
> > > Aha, so I think I triggered the issue you're seeing under QEMU (log
> > > below). perf (unhelpfully) doesn't have stable test numbers, so it's
> > > test 21 in my case. However, it only explodes if I run it as root, since
> > > /proc/kcore is 0400 on my system.
> > >
> > > The easiest way to trigger the problem is simply:
> > >
> > > # objdump -d /proc/kcore
> > >
> > > Looking at the history, I wonder whether this is because of a combination
> > > of:
> > >
> > > e025ab842ec3 ("mm: remove kern_addr_valid() completely")
> > >
> > > which removed the kern_addr_valid() check on the basis that kcore used
> > > copy_from_kernel_nofault() anyway, and:
> > >
> > > 2e1c0170771e ("fs/proc/kcore: avoid bounce buffer for ktext data")
> > >
> > > which replaced the copy_from_kernel_nofault() with _copy_to_user().
> > >
> > > So with both of those applied, we're missing the address check on arm64.
> >
> > Digging into this a little more, the fault occurs because kcore is
> > treating everything from '_text' to '_end' as KCORE_TEXT and expects it
> > to be mapped linearly. However, there's plenty of stuff we _don't_ map
> > in that range on arm64 (e.g. .head.text, the pKVM hypervisor, the entry
> > trampoline) so kcore is broken.
> >
> > One hack is to limit KCORE_TEXT to actually point at the kernel text
> > (see below), but this is a user-visible change in behaviour for things
> > like .data so I think it would be better to restore the old behaviour
> > of handling the faults.
> >
> > Lorenzo?
>
> FYI there is a parallel discussion at
> https://lore.kernel.org/all/ZHc2fm+9daF6cgCE@krava/ :)
>
> [sorry lei isn't playing ball so will have to reply from gmail,
> apologies if this breaks formatting]
>
> It'd be a real pity to have to revert that behaviour, as using a
> bounce buffer is such a hack and means you have to iterate through a
> page at a time...
> Either that or a change such that for KCORE_TEXT specifically we
> reinstate the bounce buffer and use copy_from_kernel_nofault().
>
> It definitely is a bug in kcore to have ranges of memory that are not
> mapped marked as readable. What kind of behaviour changes do you
> anticipate exactly with your prospective change re: .data? The
> fallthroughs?
>
> kcore as a whole needs some love and attention I think.
>
> An alternative is to implement some version of
> copy_from_kernel_nofault() in the iterator code.
>
> However TL;DR - I think we probably do need a semi-revert and to just
> make the ktext do a bounce buffer thing. I definitely want to keep the
> use of iterators so I would really not want to revert anything else.
>
>
> >
> > Will
> >
> > --->8
> >
> > diff --git a/fs/proc/kcore.c b/fs/proc/kcore.c
> > index 9cb32e1a78a0..3696a209c1ec 100644
> > --- a/fs/proc/kcore.c
> > +++ b/fs/proc/kcore.c
> > @@ -635,7 +635,7 @@ static struct kcore_list kcore_text;
> >   */
> >  static void __init proc_kcore_text_init(void)
> >  {
> > -       kclist_add(&kcore_text, _text, _end - _text, KCORE_TEXT);
> > +       kclist_add(&kcore_text, _stext, _etext - _stext, KCORE_TEXT);
> >  }
> >  #else
> >  static void __init proc_kcore_text_init(void)
> >
>
>

Posted a fix at:-

https://lore.kernel.org/all/20230731215021.70911-1-lstoakes@gmail.com/

Please give that a go and indicate whether that resolves the issue.
This is in effect a partial revert in order to use the
copy_from_kernel_nofault() function to avoid faults on reading
unmapped regions, and sadly necessitates the use of a bounce buffer.

Hopefully this should be something resembling the smallest change we
can do to resolve the problem.
