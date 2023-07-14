Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4469752E48
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jul 2023 02:29:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234458AbjGNA3l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jul 2023 20:29:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232532AbjGNA3i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jul 2023 20:29:38 -0400
Received: from mail-yb1-f181.google.com (mail-yb1-f181.google.com [209.85.219.181])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D09BD2D51
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jul 2023 17:29:36 -0700 (PDT)
Received: by mail-yb1-f181.google.com with SMTP id 3f1490d57ef6-bfe6ea01ff5so1229714276.3
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jul 2023 17:29:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689294576; x=1691886576;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+qw14nvwJzqP0HPM9ddRLG0layDa0DvKHJGWB8R9CtU=;
        b=X9+vi3pOmHBvjYUYxcixHwaKwD4vSY0HVUwFEUmM9tvW3qbZiV52xIQOpomTRcLRar
         vpQj+A/UwHsoLkBvZ0PgAv4dweSfEj7ziTQfmaMw9pu/YrVOAcTTatmqTEcNLWXr9mPD
         k3GYBAvKwOtwjRP0BrXljkceQLkTKfdFFop1qzE2xzzhKwYRkmKM/D6Xv5ciOVDtyy/M
         j9SbHXAKI2QaQXwxEkZ8hD7GqrwN8e1WIAGbreCpeUiUYhHIEbz+FN4XMUhsxzGwll4w
         JBq9vgTx/A7+/FsCq0y+XXpIcmVQ7hwQ1NPVlgLKLFloNQ9I4osIOXH0r6m7+kRJXTyS
         75RQ==
X-Gm-Message-State: ABy/qLafjM8uNONZLh/oW52zotzGM6372j0Zbep6IP984ch46ZcPX2HX
        R7nSAka/25S6wV8Wl3uQ28tFPA0ERKpwZQ==
X-Google-Smtp-Source: APBJJlFlQlBm+r4RtYkUGfkYjQYMK6Gf/bvXhvwzKUOqSuQ9Nc1bZHZjFWCYK46ERBunbywbXnQ9dQ==
X-Received: by 2002:a0d:c1c2:0:b0:577:bc0:2d55 with SMTP id c185-20020a0dc1c2000000b005770bc02d55mr3717640ywd.33.1689294575876;
        Thu, 13 Jul 2023 17:29:35 -0700 (PDT)
Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com. [209.85.128.182])
        by smtp.gmail.com with ESMTPSA id l186-20020a0dc9c3000000b0057725aeb4afsm2042318ywd.84.2023.07.13.17.29.35
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Jul 2023 17:29:35 -0700 (PDT)
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-5776312eaddso12687507b3.3
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jul 2023 17:29:35 -0700 (PDT)
X-Received: by 2002:a0d:c443:0:b0:576:a91d:d3ee with SMTP id
 g64-20020a0dc443000000b00576a91dd3eemr3512271ywd.42.1689294573773; Thu, 13
 Jul 2023 17:29:33 -0700 (PDT)
MIME-Version: 1.0
References: <2023071200-unopposed-unbuckled-cde8@gregkh> <CAMw=ZnTVRaqRmtz+sDj7AeAS7xivSu+56UgKbzmuW9+K6TTx1A@mail.gmail.com>
 <2023071239-progress-molasses-3b3d@gregkh> <CAMw=ZnRheXk7W_r-32bGymbHKdXc7aKUpwGAOX+k7DJkN+DiCQ@mail.gmail.com>
 <2023071229-dusk-repacking-da3a@gregkh> <CAMw=ZnSmZTBs+bJsQ_Y2CVO8K3OTuHOZDKW4cbxKpGbo4Vgs7Q@mail.gmail.com>
 <2023071226-crafty-deviator-12e2@gregkh> <CAMw=ZnRjnxWnmoFuw2prxFS55vAGQ1hpfKeHYFfG5Oa0LB_jYA@mail.gmail.com>
 <2023071233-empirical-overturn-744c@gregkh> <CAMw=ZnRRviBNi_LK9VOSUV9PNHe3jurUcLfgLpbTOsp_eE4WyA@mail.gmail.com>
 <2023071350-specked-botanist-6ba8@gregkh>
In-Reply-To: <2023071350-specked-botanist-6ba8@gregkh>
From:   Luca Boccassi <bluca@debian.org>
Date:   Fri, 14 Jul 2023 01:29:20 +0100
X-Gmail-Original-Message-ID: <CAMw=ZnQZ9ds3xsa2AZv_F13dB6rR4XzGPrBjJHSga1oU5xRezQ@mail.gmail.com>
Message-ID: <CAMw=ZnQZ9ds3xsa2AZv_F13dB6rR4XzGPrBjJHSga1oU5xRezQ@mail.gmail.com>
Subject: Re: [RFC PATCH v2] x86/boot: add .sbat section to the bzImage
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
        Borislav Petkov <bp@alien8.de>,
        Emanuele Giuseppe Esposito <eesposit@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Thomas Gleixner <tglx@linutronix.de>, lennart@poettering.net,
        Ingo Molnar <mingo@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Alexander Potapenko <glider@google.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 13 Jul 2023 at 07:09, Greg KH <gregkh@linuxfoundation.org> wrote:
>
> On Wed, Jul 12, 2023 at 10:50:45PM +0100, Luca Boccassi wrote:
> > > Who is going to be responsible for determining that this number needs to
> > > be updated?
> >
> > Most likely those who understand the problem space - largely the group
> > of people maintaining the EFI stack, with various inputs, I imagine.
> > That's how it currently works for various bootloaders.
>
> We need specifics and to have people agree to do this, otherwise, again,
> this patch is useless.

Not really, as this is about mechanism, not process.

> > > How are they going to determine this?
> >
> > Again, very coarsely: does the current generation allow a secure boot
> > bypass -> revoked, else -> no change
>
> And how are you going to do that testing?  Who is going to do that?
> Does it happen today?

Of course it happens today, it even gets fancy names - black lotus,
boot hole, etc. If you want to know how it happens, read some papers,
join a security team, or a university research group, or some other
place that works in the specific field.

> > > What is their response time?
> > >
> > > Who will they be submitting the patch to this string in order to have it
> > > change?
> >
> > A bit too soon for exact details on processes given where we are, I think.
>
> Not at all, this is a proposal for a "security flag" for the kernel,
> getting this all decided now is the only correct way to determine if
> this is actually something that can work properly.

No, the question here was about mechanism and storage. And it already
works btw, it's just the kernel that's lagging behind, as usual.

> To just go "we are going to randomly add a number that will sometimes be
> incremented in the future to determine the buggyness of the kernel
> without saying who will control this, or how it will be done" is crazy.
>
> Would other operating systems or projects accept such a change without
> this information?
>
> Would you take this patch if you were responsible for kernel releases?

I think you are still missing one tiny bit of information: it is
already used in other projects

$ sudo objcopy -O binary --only-section=.sbat
/boot/efi/EFI/Debian/grubx64.efi /dev/stdout
sbat,1,SBAT Version,sbat,1,https://github.com/rhboot/shim/blob/main/SBAT.md
grub,3,Free Software Foundation,grub,2.06,https://www.gnu.org/software/grub/
grub.debian,4,Debian,grub2,2.06-13,https://tracker.debian.org/pkg/grub2

> > > And how is any of this going to interact with stable kernel releases,
> > > long term kernel releases and end-of-life kernel releases?
> >
> > As above: does the current generation allow a secure boot bypass ->
> > revoked, else -> no change
>
> For all stable releases?

Doesn't matter how you call it, only if it's signed for the shim+3rd
party CA workflow

> > > How long will this feature have to be maintained?
> >
> > Until something else supplants EFI, I'd imagine
>
> So 40+ years, great, who is going to fund that?

Who funds EFI work?

> > > > The only thing that matters is, "if we had infinite space in DBX and
> > > > sensible ways to service it and nvram didn't wear down, would we
> > > > blocklist this component version" - if the answer is no, then nothing
> > > > happens. If the answer is yes, then the counter goes up.
> > >
> > > I suggest you all take a look at the past 10 years of kernel releases
> > > and changes (to pick a simple number) and determine what the number
> > > would be now if you were to start counting then.  Is it 10?  100?
> > > 10000?  What do you think it will be in the next 40 years?
> >
> > What do you think that would look like if it was all individual hashes
> > blocklisted in DBX instead? Because this is what we are talking about.
> > And, for the nth time, this is not about identifying individual bugs.
> > You do what, 3 releases a year? So 10 years time 3,
>
> I do a release or two a week across multiple stable kernel versions.
> For you to not notice that means that either the process is working
> really well, or that this type of function does not match how we do
> development and releases at all.

Or, third option, that's irrelevant for the case at hand.

> > then assuming
> > every single release you have made is completely and hopelessly broken
> > in different ways, but each is only discovered one at a time exactly
> > once per release, then the generation counter would be 30. That's your
> > absolutely worst case scenario. Now try to think about how hash
> > entries we'd need in DBX for the exact same worst case scenario, and
> > the reason SBAT has been implemented should become very obvious, very
> > quickly.
>
> I'm not saying "individual hashes" anymore, sure, I'll give you your one
> number, but even then, I don't see how it makes any sense at all in our
> current ecosystem of releases.
>
> So I need to see this documented very very well to even be able to
> consider it.

Well then, it's your lucky day! As it is documented, with examples and all:

https://github.com/rhboot/shim/blob/main/SBAT.example.md

the kernel is just one of many consumers of this protocol, so
obviously the documentation for it lives with the protocol owner,
which is Shim.

> > > We have a plethora of kernel changes in our history to learn from here,
> > > please do so and show how this will affect us going forward based on our
> > > past, otherwise we have no way of knowing how any of this is going to
> > > work.
> >
> > I am not aware of anything similar enough, but please do point those
> > out if you are.
>
> Audit our past history and document when the number would have changed
> please.

Sure, where do I send the invoice?
