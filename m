Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F15F5757EF3
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 16:04:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233242AbjGROEw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 10:04:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233231AbjGROEe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 10:04:34 -0400
Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A27F211F
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jul 2023 07:03:32 -0700 (PDT)
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-579de633419so53612207b3.3
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jul 2023 07:03:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689688989; x=1692280989;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IfJdZldamVRoiem+genboss9wXHBkzaKw5u/tIWjMWQ=;
        b=W2c9O6m1MQ82BoOwTdgUg6eqB6tP4I1TnAvYuZk1HwtQq8CTfvKcYsrvyTVxI3RYkW
         RCtJaM7B0q0xMUfxJ41/dnowZWNYp9dF9favIybQfqfrPcJuUrUgfZbfBxPNbNj7AuO9
         X7S3v2Qls1WAAqY2CrNxyQZpyndrQ+tVKkTFLzIuXD8uGxA7ZMV1XmpsRRTqAxJ1ZKTC
         k+aZGJ7/f2h8ON9QdEyEQG6G+ujllspUdf544KjZmNQLtDAUPCYEGWTq9F9xiNCnw4Eu
         Oz77g/EQDbkJAfvsbwWdeSnv+5wBL2hYMFJcNpnwI2xx5Sw3wK/gBjgm2L4faAb9bomX
         kFIg==
X-Gm-Message-State: ABy/qLY3kXCPu5SiwBRe61wo1ctfIZD4msH16DY7PCw3uHNCm9+ZiddV
        /cSQbNwmmYo1+nfHBhkxTCg9pmG+l2/unw==
X-Google-Smtp-Source: APBJJlHqWbXNyx3clWoFZlM4P5wbmDZNRlqS7J4Nx9bZEMcCHyoyE/PFtueov40dxYoWgotAmOPcMQ==
X-Received: by 2002:a81:dd06:0:b0:57a:6a2c:f4dd with SMTP id e6-20020a81dd06000000b0057a6a2cf4ddmr13545607ywn.36.1689688989217;
        Tue, 18 Jul 2023 07:03:09 -0700 (PDT)
Received: from mail-yb1-f172.google.com (mail-yb1-f172.google.com. [209.85.219.172])
        by smtp.gmail.com with ESMTPSA id b68-20020a0df247000000b005771bb5a25dsm471078ywf.61.2023.07.18.07.03.08
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Jul 2023 07:03:08 -0700 (PDT)
Received: by mail-yb1-f172.google.com with SMTP id 3f1490d57ef6-bcb6dbc477eso4414255276.1
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jul 2023 07:03:08 -0700 (PDT)
X-Received: by 2002:a25:41d0:0:b0:bc6:377a:d9c7 with SMTP id
 o199-20020a2541d0000000b00bc6377ad9c7mr11296210yba.23.1689688988254; Tue, 18
 Jul 2023 07:03:08 -0700 (PDT)
MIME-Version: 1.0
References: <20230711154449.1378385-1-eesposit@redhat.com> <ZK/9MlTh435FP5Ji@gambale.home>
 <df7941b9-11ea-9abd-e070-4e9926aecdc3@redhat.com>
In-Reply-To: <df7941b9-11ea-9abd-e070-4e9926aecdc3@redhat.com>
From:   Luca Boccassi <bluca@debian.org>
Date:   Tue, 18 Jul 2023 15:02:55 +0100
X-Gmail-Original-Message-ID: <CAMw=ZnTSyeL4x1o_GVKNsZdCUe2D2H53quK-TSFhOkuONjC73A@mail.gmail.com>
Message-ID: <CAMw=ZnTSyeL4x1o_GVKNsZdCUe2D2H53quK-TSFhOkuONjC73A@mail.gmail.com>
Subject: Re: [RFC PATCH v2] x86/boot: add .sbat section to the bzImage
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     Ard Biesheuvel <ardb@kernel.org>,
        Emanuele Giuseppe Esposito <eesposit@redhat.com>,
        x86@kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        lennart@poettering.net, Ingo Molnar <mingo@redhat.com>,
        Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Alexander Potapenko <glider@google.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
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

On Tue, 18 Jul 2023 at 14:35, Paolo Bonzini <pbonzini@redhat.com> wrote:
>
> [note: while there is some overlap between the developers and Red Hat
> employees that are involved in KVM, I was not involved in this work and
> only learnt about it last Friday]
>
> On 7/13/23 15:33, Ard Biesheuvel wrote:
> >> A .sbat is simply a section containing a string with the component name
> >> and a version number. This version number is compared with the value in
> >> OVMF_VARS, and if it's less than the variable, the binary is not trusted,
> >> even if it is correctly signed.
> >>
> >
> > Also, 'version number' is a bit vague, better to stick with existing
> > terminology that makes this more self explanatory: the component that
> > authenticates the kernel image keeps a revocation counter, and refuses
> > to load authentic images whose revocation index is lower than the
> > revocation counter. This approach removes the need for revoking
> > individual image hashes or having to rotate the signing keys when a
> > vulnerability is discovered.
> >
> > The argument that we need this in the upstream kernel seems to be
> > predicated on the assumption that there is one universal signing
> > authority and revocation domain, but this is not necessarily true.
>
> I am not sure about this.  I think that a revocation index could _in
> theory_ make sense as a way to double check that you have backported all
> the relevant bugfixes.  If you backport the patch that changes the index
> from 2 to 3 but your tree has index=1, it will conflict and hopefully
> fix it or lead you to document why that is happening.
>
> But I'm saying "in theory", because I'm not sure it makes sense to apply
> the concept to an OS kernel.  A revocation index makes sense for boot
> loaders, whose purpose is to check something about the next stage and
> then get out of the way.  When using a bootloader for secure boot there
> is a limited amount of parsing and basically no user interaction.  With
> some handwaving, that makes it is possible to say things like "oh no I
> found the 234th bug in my codebase, let's bump the revocation index to 235".
>
> If you try to do this for the OS, however, Linux's "vulnerabilities are
> just bugs" mantra hits hard---more specifically the reverse: all bugs
> are potential vulnerabilities.  Sure you can hope for the best, which is
> what we do with module signing and with the (non-upstream) secure boot
> lockdown patches.  In the end, however, an unpatched code execution or
> memory write vulnerability is always a potential rootkit.  While we
> don't have _too_ many of those, there are enough that the idea of a
> revocation index becomes completely unfeasible, not too mention those
> that are fixed silently not because "that's the way Linus does it" but
> rather because we genuinely didn't think of them as security fixes.

Lockdown is upstream and has been for several years. Apart from that,
I'm not sure why there is this idea that the kernel is somehow
'special', but it is not grounded in reality. If you ask the owners of
any components, 9 times out of 10 they'll tell you their project is
absolutely unique and special and could not possibly be bundled
together with <those other things over there>, but it's just
exceptionalism.
Grub also gets plenty of bug fixes that are not classed as security
fixes, and so does Shim, and so does everything else. And they both
have plenty of user interaction, and plenty of variability. Heck, Grub
has its own complex configuration language that can take live input at
boot, _and_ reimplements most of the kernel filesystems!

But anyway, from the point of view of the 3rd party CA plus Shim
workflow, they are the same, and can be treated the same - sorry, but
the kernel is not special in any way. The only thing that matters is
if, given a bug, somebody either observed it being used as a secure
boot bypass by bad actors in the wild, or was bothered enough to write
down a self-contained, real and fully working proof of concept for
secure boot bypass. If yes, then somebody will send the one-liner to
bump the generation id, and a new sbat policy will be deployed. If no,
then most likely nobody will care, and that's fine, and I expect
that's what will happen most of the time.

> So perhaps there could be some kind of protocol that would let a new
> kernel tell the bootloader "don't boot an older kernel than me in the
> future".  It could even be an extension to the SBAT spec itself.  I
> haven't really thought much about it, tbh.  However, I'm quite positive
> that a revocation index attached to the kernel image cannot really work
> as a concept, not even if it is managed by the distro.

You are pretty much describing SBAT there. Except for the detail that
it can't be the component that can be compromised that tells you
whether it's compromised and you should trust it... A system's SBAT
policy is a single entity, managed centrally, and deployed everywhere.
