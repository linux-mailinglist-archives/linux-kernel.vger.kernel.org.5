Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16AB679BFB3
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 02:19:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349456AbjIKVdi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Sep 2023 17:33:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237170AbjIKMIN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Sep 2023 08:08:13 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1D10F2
        for <linux-kernel@vger.kernel.org>; Mon, 11 Sep 2023 05:08:09 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B538C433CA
        for <linux-kernel@vger.kernel.org>; Mon, 11 Sep 2023 12:08:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694434089;
        bh=gVdwM3yRUzwEw/ysYzJcqZPAy48ZFx0ZSuDJ7ZTr9IM=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=rQ8yM+Q1mEnrVgZvz4KR8hpYJdoEq4/QlWdi59DqXHJOw+VFqSl4rrug1PPxAT5rJ
         ptFMPmyAk7QWRHcWRG+84an2dsaUD8Y10SFpznc41EpaLAulrtCvEcRI6zRexiB6nE
         vnjj+MtcLtKgOE9f2/l84yYDYVgGP96ITPwOFfV5iOEAFd6r0f/YJahaI+wbOfzsNG
         2zn+GJKKTSEL7m39GCU1rTbzkLxIpJhNim3rFNHzZ05kdc4iJ7IvMsfNeb4G50wS+X
         Bah1IzDlKctq82axRjYSxBJK/wwM+tLhTpvB8IF5KmmUu4RN8JPpnnL1bIIQRjwhrB
         YaHQ7tWYtTdkg==
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-502934c88b7so6869591e87.2
        for <linux-kernel@vger.kernel.org>; Mon, 11 Sep 2023 05:08:09 -0700 (PDT)
X-Gm-Message-State: AOJu0YyhKgXQs1cqkr91IeqfBnNL6gbkJZl25zff9a1mTDFZOEbo7C6p
        ZqiPaC828rh4MnrlXZ8f9Nl8ArYq0xlx0OKcBsU=
X-Google-Smtp-Source: AGHT+IFaP30bFOHKfjYIwIEaNW+kvYy1DhQAfHBkcbsABQ55xTPFuNxzrUBlI9lhrzJ5kohiOGBOVb0RTMBv+WW1piE=
X-Received: by 2002:a05:6512:45a:b0:500:c180:59ca with SMTP id
 y26-20020a056512045a00b00500c18059camr6997803lfk.41.1694434087504; Mon, 11
 Sep 2023 05:08:07 -0700 (PDT)
MIME-Version: 1.0
References: <20230615121016.3731983-1-chenhuacai@loongson.cn>
 <CAAhV-H49AyrG-sH2SXLNg_cX-Wv8vS4Qno_2N4v6ccGGciv-+A@mail.gmail.com>
 <ZJ9kWqhRCWkLcYyv@bombadil.infradead.org> <CAAhV-H7qk8wSFt=ZMUSUt4cAmH+-5AsGqszXNW9w+u6Y8vDN+A@mail.gmail.com>
 <CAAhV-H7RgkZJ2hfmNmJXKqcYeE1q11V4-2Ni0j-FLJ0b5fc=Sg@mail.gmail.com>
In-Reply-To: <CAAhV-H7RgkZJ2hfmNmJXKqcYeE1q11V4-2Ni0j-FLJ0b5fc=Sg@mail.gmail.com>
From:   Huacai Chen <chenhuacai@kernel.org>
Date:   Mon, 11 Sep 2023 20:07:55 +0800
X-Gmail-Original-Message-ID: <CAAhV-H5pwHQTQ6wGXC2NELHmC4JM8rQUViR3RJj8hQLBygb00w@mail.gmail.com>
Message-ID: <CAAhV-H5pwHQTQ6wGXC2NELHmC4JM8rQUViR3RJj8hQLBygb00w@mail.gmail.com>
Subject: Re: [PATCH] kthread: Rename user_mode_thread() to kmuser_thread()
To:     Luis Chamberlain <mcgrof@kernel.org>,
        Eric Biederman <ebiederm@xmission.com>
Cc:     Huacai Chen <chenhuacai@loongson.cn>,
        Andrew Morton <akpm@linux-foundation.org>,
        Kees Cook <keescook@chromium.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, all,

Friendly ping again?


Huacai

On Sun, Jul 23, 2023 at 10:13=E2=80=AFPM Huacai Chen <chenhuacai@kernel.org=
> wrote:
>
> Hi, Eric,
>
> On Tue, Jul 18, 2023 at 8:43=E2=80=AFPM Huacai Chen <chenhuacai@kernel.or=
g> wrote:
> >
> > Hi, Luis,
> >
> > On Sat, Jul 1, 2023 at 7:25=E2=80=AFAM Luis Chamberlain <mcgrof@kernel.=
org> wrote:
> > >
> > > On Sun, Jun 25, 2023 at 04:55:33PM +0800, Huacai Chen wrote:
> > > > Friendly ping?
> > >
> > > You want to cc the folks who Nacked your patch. Until then, this
> > > probably can't go further.
> > Thank you very much. Eric and Andrew are already in the CC list, so
> > add Thomas now.
> >
> > My brain is a little old-fashioned so I insisted that "a thread
> > without mm_struct should be a kernel thread" in the previous patch.
> > Unfortunately this makes Eric and Thomas unhappy, I'm very sorry for
> > that.
> >
> > During the discussion of the previous patch I know I made some
> > mistakes about some basic concepts, but I also found the name
> > "user_mode_thread()" is somewhat confusing. I think rename it to
> > kmuser_thread() is better, because:
> > 1, it identify init and umh as user threads;
> > 2, it points out that init and umh are special user threads that run
> > in kernel mode before loading a user program.
> >
> > Sorry for my rudeness again.
> Excuse me, but could you please tell me what your opinion is. In my
> opinion a typical user thread is created by
> pthread_create()/sys_clone(), it is better to distinguish typical user
> threads from init and umh.
>
> Huacai
> >
> > Huacai
> > >
> > >   Luis
