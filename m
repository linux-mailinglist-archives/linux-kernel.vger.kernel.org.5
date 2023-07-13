Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37B2E752DD5
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jul 2023 01:13:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234438AbjGMXNq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jul 2023 19:13:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234360AbjGMXNo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jul 2023 19:13:44 -0400
Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCB3F1999
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jul 2023 16:13:42 -0700 (PDT)
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-5703cb4bcb4so12746927b3.3
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jul 2023 16:13:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689290022; x=1691882022;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3mqbZMhCcMI47K7fuDkBMr77Ep54ClOpGczfiF6HS+k=;
        b=gSvMtWyvy5PYZPKZ2/IezF+ungnEvKn03df7nA6LPS0Ue5kYbgAiuWJFc80ovMxjSJ
         NxlE/0R+n8pYNk1q/wLXfkIcImpM+GOHNWzRNHymreyK7CS3UdxQ5H/d2pp8HayDxOk7
         3VVz1y+gMlnrPfq/hjZIBu5t9LoZ0uQnuWN4AeuCmoP1xvoQEQQ/xhy02Og2upFNzb1b
         Pc4OXUZa3vnwp7m7bZm/ePgwX8ELxQHpqRK9ZD/ys2vx0feaDVGkGvXOMB/oC8SyUslw
         vZJvCk+XMQy+FJKsgxnm/9ZFHAJYU3WWYm6Za4wCmvqQ2kz83qLVsOycE4B8ya3fKpVm
         naDg==
X-Gm-Message-State: ABy/qLZ5AZuzZIuGzU3zU74G8czpnAsE/oiUQrnIx944sHNSSPAzugeN
        eBgJdDc/8seAUnqnK2XgPV6v+6yxGzZExg==
X-Google-Smtp-Source: APBJJlG7nD+tkWR6SG8d1TUZr52gRpmOd4cHd/y6LJFQ9pAvYHiXnsqDshQqlbYKcssdKU0LvIeavw==
X-Received: by 2002:a81:7741:0:b0:56f:f15a:a471 with SMTP id s62-20020a817741000000b0056ff15aa471mr2669934ywc.51.1689290021666;
        Thu, 13 Jul 2023 16:13:41 -0700 (PDT)
Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com. [209.85.128.181])
        by smtp.gmail.com with ESMTPSA id a186-20020a0dd8c3000000b0058069aecc5bsm941837ywe.98.2023.07.13.16.13.41
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Jul 2023 16:13:41 -0700 (PDT)
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-5701810884aso12841297b3.0
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jul 2023 16:13:41 -0700 (PDT)
X-Received: by 2002:a81:83c1:0:b0:578:5e60:dcc9 with SMTP id
 t184-20020a8183c1000000b005785e60dcc9mr3158775ywf.10.1689290020983; Thu, 13
 Jul 2023 16:13:40 -0700 (PDT)
MIME-Version: 1.0
References: <20230711154449.1378385-1-eesposit@redhat.com> <ZK/9MlTh435FP5Ji@gambale.home>
In-Reply-To: <ZK/9MlTh435FP5Ji@gambale.home>
From:   Luca Boccassi <bluca@debian.org>
Date:   Fri, 14 Jul 2023 00:13:29 +0100
X-Gmail-Original-Message-ID: <CAMw=ZnRQ0qNg0hT27DWvfZ1DH3dLdu0U7zYN8HvJDx7NPVy_pQ@mail.gmail.com>
Message-ID: <CAMw=ZnRQ0qNg0hT27DWvfZ1DH3dLdu0U7zYN8HvJDx7NPVy_pQ@mail.gmail.com>
Subject: Re: [RFC PATCH v2] x86/boot: add .sbat section to the bzImage
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     Emanuele Giuseppe Esposito <eesposit@redhat.com>, x86@kernel.org,
        Thomas Gleixner <tglx@linutronix.de>, lennart@poettering.net,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Alexander Potapenko <glider@google.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 13 Jul 2023 at 14:33, Ard Biesheuvel <ardb@kernel.org> wrote:
>
> Hello Emanuele,
>
> Please cc the linux-efi@ mailing list and myself on EFI related patches.
>
> First of all, I think the tone of the discussion is way out of hand on
> both sides of the debate. Please keep it civil and courteous.

I appreciate the attempt, but sorry, it's not cool to try and
both-side things here. The original submission was not aggressive,
insulting or in any way out of line, it's clearly marked as an RFC and
the FIRST LINE was:

"*Important*: this is just an RFC, as I am not expert in this area and
I don't know what's the best way to achieve this."

which is as friendly and humble as one can be. And yet, not one, not
two, but three maintainers have decided that the best way to respond
to something like that is to spew bile, toxicity and aggressivity,
which was completely and utterly uncalled for. So, if you want to call
someone out (you should), please direct that towards your fellow
maintainers, who in theory should be setting a good example and
productively directing the discourse, but instead, once again, have
only succeeded in ensuring that the lkml lives up to its fame of being
an open sewer.

> On Tue, Jul 11, 2023 at 11:44:49AM -0400, Emanuele Giuseppe Esposito wrote:
> > *Important*: this is just an RFC, as I am not expert in this area and
> > I don't know what's the best way to achieve this.
> >
> > v2:
> > * add standard "sbat,1,SBAT Version,..." header string
> >
> > The aim of this patch is to add a .sbat section to the linux binary
> > (https://github.com/rhboot/shim/blob/main/SBAT.md).
> > We mainly need SBAT in UKIs (Unified Kernel Images), as we might want
> > to revoke authorizations to specific signed PEs that were initially
> > considered as trusted. The reason might be for example a security issue
> > related to a specific linux release.
> >
> > A .sbat is simply a section containing a string with the component name
> > and a version number. This version number is compared with the value in
> > OVMF_VARS, and if it's less than the variable, the binary is not trusted,
> > even if it is correctly signed.
> >
>
> Most people will not known what OVMF_VARS is or a PE.
>
> Also, 'version number' is a bit vague, better to stick with existing
> terminology that makes this more self explanatory: the component that
> authenticates the kernel image keeps a revocation counter, and refuses
> to load authentic images whose revocation index is lower than the
> revocation counter. This approach removes the need for revoking
> individual image hashes or having to rotate the signing keys when a
> vulnerability is discovered.
>
> The argument that we need this in the upstream kernel seems to be
> predicated on the assumption that there is one universal signing
> authority and revocation domain, but this is not necessarily true. Even
> if the distros appear to have decided that it is a reasonable choice to
> deploy the MicroSoft signed shim and the associated components on other
> systems than Windows-crippled x86 PCs, this is not universally true, and
> UEFI secure boot can be (and is) deployed in sane ways as well.

There is no other solution for the current revision of the spec (and
I'm pretty sure this aspect won't change in future ones either), for
'public' signing it's just Shim and the 3party CA. Of course for
individual/internal/scoped deployment there is self signing, but
that's out of scope of any of this and it couldn't be otherwise, and
that's ok. But it's not some obscure corner case: the default for
every generalist distro that boots on uefi machines is by using Shim.
If there's any use case that matters, it's this one. But even that's
not the main reason it's a good idea to store the generation id here.

> Therefore, I don't think it makes sense for the upstream kernel source
> to carry a revocation index. It is ultimately up to the owner of the
> signing key to decide which value gets signed along with the image, and
> this is fundamentally part of the configure/build/release workflow.  No
> distro builds and signs the upstream sources unmodified, so each signed
> release is a fork anyway, making a upstream revocation index almost
> meaningless. Also, while backporting revocation index bumps to -stable
> should not result in any issues, I don't think the associated
> bookkeeping belongs in the hands of the stable tree maintainers.

The reason it's a good idea to store it here is because otherwise
there would need to be another external "registry" that matches 1:1,
and that is maintained identical everywhere, perfectly in sync,
forever, and any 'new' distro and/or distro maintainer would have to
discover and use that registry, and would be completely oblivious to
it otherwise.

It would be much more work for those actually doing the work, and it
wouldn't make any meaningful differences to those who don't care about
the use case. AFAIK nobody has suggested that it's kernel maintainers
who need to worry about the generation id and do the bookkeeping, if
they don't care. I mean I'm pretty sure every help is welcome, but
that should be it.

The 'owner of the signing key' is not good enough, because there are
many of those - as you know, the kernel is signed by each distro. But
the key here is that the revocation is _global_ (again: global means
it applies to everyone using shim signed by 3rd party CA), so each
distro storing their own id defeats the purpose of that. There is
space in the spec for distro-specific revocations, but that's intended
for distro-specific _additions_, like for example a lot of the
mok/lockdown used to be - thankfully most of that is upstream now, so
it mostly applies to grub these days, which is the most
downstream-patched component in the stack from the point of view of
the boot chain.
