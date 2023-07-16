Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B00B8755022
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Jul 2023 19:41:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229956AbjGPRlZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Jul 2023 13:41:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229469AbjGPRlX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Jul 2023 13:41:23 -0400
Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE6DFE5C
        for <linux-kernel@vger.kernel.org>; Sun, 16 Jul 2023 10:41:22 -0700 (PDT)
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-57a551ce7e9so37185167b3.3
        for <linux-kernel@vger.kernel.org>; Sun, 16 Jul 2023 10:41:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689529282; x=1692121282;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GGtgNGFObVl6yAa+/bxaEQSe4TNYMP4xPyoK4h5I/8A=;
        b=airWkhHXtNymChKal29yNG+u6Oss5RpXL/LV7tlCv6A6VT3oQkY59047JkcDwZERYS
         P53772Vv+jrdJ5Vd/O+taVqbc/CfVZFjfVrj+l8Wvwa84dGdmn59Gfi0htX7XAHhT6ds
         2wkYgG3KKBPy/AN+CBDwCtB2HA2kzD1J/9M1U+IrzMF5Q5Ocl0gpudGkDcyLuEZU7IDw
         MF7gK+Z4PYFIUtsZ62qoZ5xMaAGI98UfvLLwDsFKzHY/K/G18wx3ONaOoygtdgqvBNBF
         D8fGeNlyt63PAbFsp1E/E4H6Dd43glU/MsxOP6855aFRw2EqIJvh1sAbyy81TXLlbBb3
         gpcA==
X-Gm-Message-State: ABy/qLY7PFykPWjcre8E7ss39fOhgC/LJjFxv2CjilfdXSl4gA0VtxXM
        w/ncC/6RBU2YlBIn8MPm24yluOSmC4pruQ==
X-Google-Smtp-Source: APBJJlFPxotIrOxsU6R6hDt/VeoDpwBZlYdUu0fIiX6VtS13D6PJdX7azcXpIjDVtXyYgo8pDkimvA==
X-Received: by 2002:a0d:ed83:0:b0:570:220:f815 with SMTP id w125-20020a0ded83000000b005700220f815mr10804605ywe.11.1689529281750;
        Sun, 16 Jul 2023 10:41:21 -0700 (PDT)
Received: from mail-yb1-f169.google.com (mail-yb1-f169.google.com. [209.85.219.169])
        by smtp.gmail.com with ESMTPSA id y80-20020a0dd653000000b0055a21492192sm3420767ywd.115.2023.07.16.10.41.17
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 16 Jul 2023 10:41:18 -0700 (PDT)
Received: by mail-yb1-f169.google.com with SMTP id 3f1490d57ef6-c2cf29195f8so3846005276.1
        for <linux-kernel@vger.kernel.org>; Sun, 16 Jul 2023 10:41:17 -0700 (PDT)
X-Received: by 2002:a0d:e5c6:0:b0:576:bfd7:1dac with SMTP id
 o189-20020a0de5c6000000b00576bfd71dacmr10154866ywe.24.1689529276811; Sun, 16
 Jul 2023 10:41:16 -0700 (PDT)
MIME-Version: 1.0
References: <2023071239-progress-molasses-3b3d@gregkh> <CAMw=ZnRheXk7W_r-32bGymbHKdXc7aKUpwGAOX+k7DJkN+DiCQ@mail.gmail.com>
 <2023071229-dusk-repacking-da3a@gregkh> <CAMw=ZnSmZTBs+bJsQ_Y2CVO8K3OTuHOZDKW4cbxKpGbo4Vgs7Q@mail.gmail.com>
 <2023071226-crafty-deviator-12e2@gregkh> <CAMw=ZnRjnxWnmoFuw2prxFS55vAGQ1hpfKeHYFfG5Oa0LB_jYA@mail.gmail.com>
 <2023071233-empirical-overturn-744c@gregkh> <CAMw=ZnRRviBNi_LK9VOSUV9PNHe3jurUcLfgLpbTOsp_eE4WyA@mail.gmail.com>
 <2023071350-specked-botanist-6ba8@gregkh> <CAMw=ZnQZ9ds3xsa2AZv_F13dB6rR4XzGPrBjJHSga1oU5xRezQ@mail.gmail.com>
 <2023071552-quilt-tranquil-b7bf@gregkh>
In-Reply-To: <2023071552-quilt-tranquil-b7bf@gregkh>
From:   Luca Boccassi <bluca@debian.org>
Date:   Sun, 16 Jul 2023 18:41:04 +0100
X-Gmail-Original-Message-ID: <CAMw=ZnROWgDOiAr1iikTWa7Qm81HoE17NuEdLt8hwGnkKSnoCg@mail.gmail.com>
Message-ID: <CAMw=ZnROWgDOiAr1iikTWa7Qm81HoE17NuEdLt8hwGnkKSnoCg@mail.gmail.com>
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
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 15 Jul 2023 at 07:52, Greg KH <gregkh@linuxfoundation.org> wrote:
>
> On Fri, Jul 14, 2023 at 01:29:20AM +0100, Luca Boccassi wrote:
> > On Thu, 13 Jul 2023 at 07:09, Greg KH <gregkh@linuxfoundation.org> wrote:
> > >
> > > On Wed, Jul 12, 2023 at 10:50:45PM +0100, Luca Boccassi wrote:
> > > > > Who is going to be responsible for determining that this number needs to
> > > > > be updated?
> > > >
> > > > Most likely those who understand the problem space - largely the group
> > > > of people maintaining the EFI stack, with various inputs, I imagine.
> > > > That's how it currently works for various bootloaders.
> > >
> > > We need specifics and to have people agree to do this, otherwise, again,
> > > this patch is useless.
> >
> > Not really, as this is about mechanism, not process.
>
> And this right here is why everyone is both so mad at this patch from
> our side, and so confused about patch from the developer's side.
>
> To think that "let's add a security canary to the kernel image" is
> anything other than a process issue, shows a lack of understanding about
> exactly how the kernel is released, how the existing kernel security
> response team works, and who does any of this work.  To ignore that
> means that there is no way in the world this can ever be accepted.

This _question_ was about mechanism, not process. As already
mentioned, nobody asked you to sign up for any extra work.

> > > > > What is their response time?
> > > > >
> > > > > Who will they be submitting the patch to this string in order to have it
> > > > > change?
> > > >
> > > > A bit too soon for exact details on processes given where we are, I think.
> > >
> > > Not at all, this is a proposal for a "security flag" for the kernel,
> > > getting this all decided now is the only correct way to determine if
> > > this is actually something that can work properly.
> >
> > No, the question here was about mechanism and storage. And it already
> > works btw, it's just the kernel that's lagging behind, as usual.
>
> Perhaps this is on purpose as many of us consider this type of thing
> nothing more than "security theatre" that will not work for a project
> like ours?

Yep, blacklotus and boothole were just security theatre, sounds about right.

> > > To just go "we are going to randomly add a number that will sometimes be
> > > incremented in the future to determine the buggyness of the kernel
> > > without saying who will control this, or how it will be done" is crazy.
> > >
> > > Would other operating systems or projects accept such a change without
> > > this information?
> > >
> > > Would you take this patch if you were responsible for kernel releases?
> >
> > I think you are still missing one tiny bit of information: it is
> > already used in other projects
> >
> > $ sudo objcopy -O binary --only-section=.sbat
> > /boot/efi/EFI/Debian/grubx64.efi /dev/stdout
> > sbat,1,SBAT Version,sbat,1,https://github.com/rhboot/shim/blob/main/SBAT.md
> > grub,3,Free Software Foundation,grub,2.06,https://www.gnu.org/software/grub/
> > grub.debian,4,Debian,grub2,2.06-13,https://tracker.debian.org/pkg/grub2
>
> Nice, and what describes the process that the grub team uses to set that
> number?  Where is that document and team that does this work?

At the link that was pasted dozens of times already, including in that output:

https://github.com/rhboot/shim/blob/main/SBAT.md

> And frankly, grub is nothing more than a tiny project compared to the
> kernel, with the huge majority of the world's users of Linux not even
> using grub at all.  So of course the use of grub for this might just be
> a bit different as to how Linux should be using it.

No, it's identical, because as it was already said a million times
this is about the 3rd party CA + Shim flow (which is the only flow
that works by default on consumer grade x86 machines and thus it's
what all the major distributions use), and in that flow there is
always Shim, and there is always Grub, and there is always Linux, so
the ratio is 1:1:1.
Outside of this use case, this doesn't apply and doesn't affect
anything, it's a no-op.

> > > > > How long will this feature have to be maintained?
> > > >
> > > > Until something else supplants EFI, I'd imagine
> > >
> > > So 40+ years, great, who is going to fund that?
> >
> > Who funds EFI work?
>
> UEFI the spec is funded by various companies (Intel, et-all).  So you
> are saying that these companies also need to do this development too?
> Have you got them to agree to this?  If so, great, let's get their
> signed-off-by on it please.
>
> Otherwise you all are saying "someone else will do all of this process
> work", which frankly, is totally insulting to those of us who _do_ do
> all of the process work for security issues and kernel releases.

Nobody asked you to do any process work.

> > > > > We have a plethora of kernel changes in our history to learn from here,
> > > > > please do so and show how this will affect us going forward based on our
> > > > > past, otherwise we have no way of knowing how any of this is going to
> > > > > work.
> > > >
> > > > I am not aware of anything similar enough, but please do point those
> > > > out if you are.
> > >
> > > Audit our past history and document when the number would have changed
> > > please.
> >
> > Sure, where do I send the invoice?
>
> If you are not willing to take the time to determine how this proposed
> change will affect the kernel developers and infrastructure by doing
> some modeling based on our past history, then we have no reason to even
> consider accepting this change as you are stating that you have no idea
> how it will affect us.

There's no need for that to tell you how this will affect you: it will
not. Every now and then you'll receive a one-liner patch to apply.
What's so terrible about that?
