Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4CB2778B96A
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Aug 2023 22:16:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234170AbjH1UPr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Aug 2023 16:15:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233693AbjH1UO5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Aug 2023 16:14:57 -0400
Received: from mail-qv1-xf32.google.com (mail-qv1-xf32.google.com [IPv6:2607:f8b0:4864:20::f32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0D81F4
        for <linux-kernel@vger.kernel.org>; Mon, 28 Aug 2023 13:14:54 -0700 (PDT)
Received: by mail-qv1-xf32.google.com with SMTP id 6a1803df08f44-64a0176b1easo21396656d6.3
        for <linux-kernel@vger.kernel.org>; Mon, 28 Aug 2023 13:14:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1693253694; x=1693858494;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tMDd65fdCHl2xtT/3to1El4/4exfLPs4G2IChT81xSs=;
        b=4DGdPA1sH8CBwQvIK6eIJACZD5O8uvd+EQnkfVuGBNin/s61pTTZGlxATmdX31PKk+
         M4effxZ4z/hh7rLAIuRqrRO87iOSMS5g/iFj1WxC5DIpAs9ESrwwetYXfLwZXOGKOj1n
         le11o9hZoJoypLeph3ta2vZz242piVec5/VDySRnMB4gIq0bwIkpaWW0Cq6ZHdueYnD/
         WrTDtGSVMqN6ZYZ+9yv83y9MuHpjrY6++6DOp9BHkNNQ3y7xUYyRMjM9ht8s3nhb/s9v
         LD8OZktGRlNLnfFg0vXTnJNZJ52VUs27had+g7l1Yyt3UxgK7+NR0XhfL55HNscNdN4P
         +iXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693253694; x=1693858494;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tMDd65fdCHl2xtT/3to1El4/4exfLPs4G2IChT81xSs=;
        b=DKhTgOfZHm3QqG+rTHcPGaVnpKydGbGnYNwFKr58Vca+nOngQcyQt4vJkcvHUs6KPO
         ZRs55wyYQaGfZK3Qc5h2Vyz7C2GfMqO8dzzyQ++MExCKB2aNa1QSFwFNlwyO2UUO4GQS
         6Awlxqq3b8HwrjY0VJtpuvvnpPkDH/es2UXfNrfY3WAew5oEJpDsERkrkjAQ0hwjQOih
         m8Qs8bSyKN9hOUApGVpbUl8ps3umTv/bjOtDZeZqhwhxvBvlsgKkYCUtIGDNvAqFaP0G
         /+RQ5acz4mC+Vn+v5TubHLRp9YSbFSH0XJJDsft5/BQTckoEzMijr4aU6w741O4Xkp6F
         t6rw==
X-Gm-Message-State: AOJu0YzLnbGzm3yIO7JGxaooQuBoRNIyZOOgkDh0bx/M4RH8ZC0/3xI+
        zyZLGhsOBL/ej/Ot6aL2F7sm9fZ2FaborcJL3WCL+w==
X-Google-Smtp-Source: AGHT+IFXdJyIqaL9v7tZnBYt0jxTjNV9JWHvz0fn6Zev3OQsd+Un77YdKGhViaW3TUslEp0ARZvuWQJzFhDhPb38330=
X-Received: by 2002:a05:6214:1fc9:b0:63d:eef:c3f6 with SMTP id
 jh9-20020a0562141fc900b0063d0eefc3f6mr26933551qvb.38.1693253693738; Mon, 28
 Aug 2023 13:14:53 -0700 (PDT)
MIME-Version: 1.0
References: <ZOkGCSNr0VN2VIJJ@p100> <CAHk-=wjZwSymfuGvf7TX3UQLU1OMN1FZMnEA-Hja0ruqyhMK4A@mail.gmail.com>
 <CAHk-=whVvD05T0yD5DQj803uETLD6qDq-Vx-SiLPcrL=eO77LQ@mail.gmail.com>
 <cc5f4f5701674b96b0009b6b9b257cc8@AcuMS.aculab.com> <CAHk-=wieUuOd-aUz0dma6TnZ+TLVk5-ytJiwbMqLpjcvdzzvQg@mail.gmail.com>
In-Reply-To: <CAHk-=wieUuOd-aUz0dma6TnZ+TLVk5-ytJiwbMqLpjcvdzzvQg@mail.gmail.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Mon, 28 Aug 2023 13:14:42 -0700
Message-ID: <CAKwvOdmUptr9_HsU3fz3pa=Y0-SqgHcKk7SJV7hmeBGaw1C3Aw@mail.gmail.com>
Subject: Re: [PATCH] lib/clz_ctz.c: Fix __clzdi2() and __ctzdi2() for 32-bit kernels
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     David Laight <David.Laight@aculab.com>,
        Helge Deller <deller@gmx.de>,
        Nathan Chancellor <nathan@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-parisc@vger.kernel.org" <linux-parisc@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Chanho Min <chanho.min@lge.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
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

On Mon, Aug 28, 2023 at 9:30=E2=80=AFAM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> On Mon, 28 Aug 2023 at 03:53, David Laight <David.Laight@aculab.com> wrot=
e:
> >
> > From: Linus Torvalds
> > >
> > > We use this:
> > >
> > >   static __always_inline unsigned long variable__ffs(unsigned long wo=
rd)
> > >   {
> > >         asm("rep; bsf %1,%0"
> > >                 : "=3Dr" (word)
> > >                 : "rm" (word));
> > >         return word;
> > >   }
> > >
> > > for the definition, and it looks like clang royally just screws up
> > > here. Yes, "m" is _allowed_ in that input set, but it damn well
> > > shouldn't be used for something that is already in a register, since
> > > "r" is also allowed, and is the first choice.
> >
> > Why don't we just remove the "m" option?
>
> For this particular case, it would probably be the right thing to do.
> It's sad, though, because gcc handles this correctly, and always has.
>
> And in this particular case, it probably matters not at all.
>
> In many other cases where we have 'rm', we may actually be in the
> situation that having 'rm' (or other cases like "g" that also allows
> immediates) helps because register pressure can be a thing.
>
> It's mostly a thing on 32-bit x86 where you have a lot fewer
> registers, and there we've literally run into situations where we have
> had internal compiler errors because of complex inline asm statements
> running out of registers.
>
> With a simple "one input, one output" case, that just isn't an issue,
> so to work around a clang misfeature we could do it - if somebody
> finds a case where it actually matters (as opposed to "damn, when
> looking at the generted code for a function that we never actually use
> on x86, I noticed that code generation is horrendous").
>
>              Linus

Yes; it's a compiler bug, and we will fix it. Then the fix will be an
incentive for folks that care to move to a newer toolchain.
--=20
Thanks,
~Nick Desaulniers
