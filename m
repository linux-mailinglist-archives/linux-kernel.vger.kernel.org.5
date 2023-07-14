Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88F66753869
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jul 2023 12:40:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235721AbjGNKkr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jul 2023 06:40:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235895AbjGNKkn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jul 2023 06:40:43 -0400
Received: from mail-qv1-f44.google.com (mail-qv1-f44.google.com [209.85.219.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FEA630DB
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jul 2023 03:40:38 -0700 (PDT)
Received: by mail-qv1-f44.google.com with SMTP id 6a1803df08f44-6355e774d0aso10368466d6.1
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jul 2023 03:40:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689331237; x=1691923237;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5UC365/CyZoOAWG8aZxLkN/5TET0TXNeh3hqd0gtJpE=;
        b=eOF2/zrMfROWGgWuv66dZzzzY3TK/jqkI2z3qTgoWW5iT2783scHY7lPQ8bVXAoddJ
         CbaBaeO6+fFm4mHKQxyTyXKU7m0JiyB2RF2mwj0Z719tFrffq5FF3ksnmTs8QTAe6gEy
         gkOizUIw7Z4hs6qvOW1ArPSdq5WSyuznIwbPZk9D/1LvXH6OOuG7szdQ1JTZBeQvmo1K
         drv5N/rn/nzuHTnwi0LQ36N4YHWhL21KF7dsivSujAQCrJqY5zvitjnjbhMCwQ1IUK+c
         iPMpSa/urYdFFO3wEwNMvVb+PCgEiKAdxNV9C09ASsp6uJYJwYT6iAn9M8T576s9YlfY
         Ch6g==
X-Gm-Message-State: ABy/qLa0IPCiiNT+jmlV+FynAagdTRL1l5Z0LUEL1xQrH7+k4rN5kJKf
        PNRGvzFCjwjPwWxF7ItEsKPHl4cjuMRt/A==
X-Google-Smtp-Source: APBJJlGeV+pIYP6fkHxQxGadeSFoXKXVQDT7kXbstWx8Hg+Xre0OnoGrNMMBWKBpu1Dtw9swMgL3QQ==
X-Received: by 2002:a0c:fecf:0:b0:636:1859:9558 with SMTP id z15-20020a0cfecf000000b0063618599558mr3636785qvs.50.1689331236789;
        Fri, 14 Jul 2023 03:40:36 -0700 (PDT)
Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com. [209.85.222.174])
        by smtp.gmail.com with ESMTPSA id k14-20020a0cf58e000000b0062ff179a538sm3874903qvm.123.2023.07.14.03.40.35
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 14 Jul 2023 03:40:35 -0700 (PDT)
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-7656652da3cso163038685a.1
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jul 2023 03:40:35 -0700 (PDT)
X-Received: by 2002:a37:2c81:0:b0:766:fe28:35a3 with SMTP id
 s123-20020a372c81000000b00766fe2835a3mr4537754qkh.32.1689331234853; Fri, 14
 Jul 2023 03:40:34 -0700 (PDT)
MIME-Version: 1.0
References: <20230711154449.1378385-1-eesposit@redhat.com> <ZK/9MlTh435FP5Ji@gambale.home>
 <CAMw=ZnRQ0qNg0hT27DWvfZ1DH3dLdu0U7zYN8HvJDx7NPVy_pQ@mail.gmail.com> <CAMj1kXEAmsLM0kXLyjRX5bK3b0EzRCGBkUq2DdXknLhwDc7Krg@mail.gmail.com>
In-Reply-To: <CAMj1kXEAmsLM0kXLyjRX5bK3b0EzRCGBkUq2DdXknLhwDc7Krg@mail.gmail.com>
From:   Luca Boccassi <bluca@debian.org>
Date:   Fri, 14 Jul 2023 11:40:22 +0100
X-Gmail-Original-Message-ID: <CAMw=ZnRLKMBtCs5wqpRq7vss6Mfqy8JeLD0ULZSV+GOG+0Ga4Q@mail.gmail.com>
Message-ID: <CAMw=ZnRLKMBtCs5wqpRq7vss6Mfqy8JeLD0ULZSV+GOG+0Ga4Q@mail.gmail.com>
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

On Fri, 14 Jul 2023 at 10:34, Ard Biesheuvel <ardb@kernel.org> wrote:
>
> On Fri, 14 Jul 2023 at 01:13, Luca Boccassi <bluca@debian.org> wrote:
> >
> > On Thu, 13 Jul 2023 at 14:33, Ard Biesheuvel <ardb@kernel.org> wrote:
> > >
> > > Hello Emanuele,
> > >
> > > Please cc the linux-efi@ mailing list and myself on EFI related patches.
> > >
> > > First of all, I think the tone of the discussion is way out of hand on
> > > both sides of the debate. Please keep it civil and courteous.
> >
> > I appreciate the attempt, but sorry, it's not cool to try and
> > both-side things here. The original submission was not aggressive,
> > insulting or in any way out of line, it's clearly marked as an RFC and
> > the FIRST LINE was:
> >
> > "*Important*: this is just an RFC, as I am not expert in this area and
> > I don't know what's the best way to achieve this."
> >
> > which is as friendly and humble as one can be. And yet, not one, not
> > two, but three maintainers have decided that the best way to respond
> > to something like that is to spew bile, toxicity and aggressivity,
> > which was completely and utterly uncalled for.
>
> I completely agree.
>
> > So, if you want to call
> > someone out (you should), please direct that towards your fellow
> > maintainers, who in theory should be setting a good example and
> > productively directing the discourse, but instead, once again, have
> > only succeeded in ensuring that the lkml lives up to its fame of being
> > an open sewer.
> >
>
> While I understand your frustration, the tone of your replies is not
> helping either, so I am directing this to you as well. Let's be the
> adults in the room, shall we?

I fully accept that I have been unfriendly to some maintainers, and
I'll try to do better.

> > > On Tue, Jul 11, 2023 at 11:44:49AM -0400, Emanuele Giuseppe Esposito wrote:
> > > > *Important*: this is just an RFC, as I am not expert in this area and
> > > > I don't know what's the best way to achieve this.
> > > >
> > > > v2:
> > > > * add standard "sbat,1,SBAT Version,..." header string
> > > >
> > > > The aim of this patch is to add a .sbat section to the linux binary
> > > > (https://github.com/rhboot/shim/blob/main/SBAT.md).
> > > > We mainly need SBAT in UKIs (Unified Kernel Images), as we might want
> > > > to revoke authorizations to specific signed PEs that were initially
> > > > considered as trusted. The reason might be for example a security issue
> > > > related to a specific linux release.
> > > >
> > > > A .sbat is simply a section containing a string with the component name
> > > > and a version number. This version number is compared with the value in
> > > > OVMF_VARS, and if it's less than the variable, the binary is not trusted,
> > > > even if it is correctly signed.
> > > >
> > >
> > > Most people will not known what OVMF_VARS is or a PE.
> > >
> > > Also, 'version number' is a bit vague, better to stick with existing
> > > terminology that makes this more self explanatory: the component that
> > > authenticates the kernel image keeps a revocation counter, and refuses
> > > to load authentic images whose revocation index is lower than the
> > > revocation counter. This approach removes the need for revoking
> > > individual image hashes or having to rotate the signing keys when a
> > > vulnerability is discovered.
> > >
> > > The argument that we need this in the upstream kernel seems to be
> > > predicated on the assumption that there is one universal signing
> > > authority and revocation domain, but this is not necessarily true. Even
> > > if the distros appear to have decided that it is a reasonable choice to
> > > deploy the MicroSoft signed shim and the associated components on other
> > > systems than Windows-crippled x86 PCs, this is not universally true, and
> > > UEFI secure boot can be (and is) deployed in sane ways as well.
> >
> > There is no other solution for the current revision of the spec (and
> > I'm pretty sure this aspect won't change in future ones either), for
> > 'public' signing it's just Shim and the 3party CA. Of course for
> > individual/internal/scoped deployment there is self signing, but
> > that's out of scope of any of this and it couldn't be otherwise, and
> > that's ok. But it's not some obscure corner case: the default for
> > every generalist distro that boots on uefi machines is by using Shim.
> > If there's any use case that matters, it's this one. But even that's
> > not the main reason it's a good idea to store the generation id here.
> >
> > > Therefore, I don't think it makes sense for the upstream kernel source
> > > to carry a revocation index. It is ultimately up to the owner of the
> > > signing key to decide which value gets signed along with the image, and
> > > this is fundamentally part of the configure/build/release workflow.  No
> > > distro builds and signs the upstream sources unmodified, so each signed
> > > release is a fork anyway, making a upstream revocation index almost
> > > meaningless. Also, while backporting revocation index bumps to -stable
> > > should not result in any issues, I don't think the associated
> > > bookkeeping belongs in the hands of the stable tree maintainers.
> >
> > The reason it's a good idea to store it here is because otherwise
> > there would need to be another external "registry" that matches 1:1,
> > and that is maintained identical everywhere, perfectly in sync,
> > forever, and any 'new' distro and/or distro maintainer would have to
> > discover and use that registry, and would be completely oblivious to
> > it otherwise.
> >
>
> But why does there need to be a single, shared upstream 'generation
> id' in the first place? The upstream is just a bunch of source files
> that can be built in a million different ways, including for different
> architectures that can all boot via EFI.
>
> To me, being able to revoke a signed release by means of a revocation
> counter makes perfect sense. What doesn't make sense is the need for
> two or more counters to describe the same entity.

For coordination. There used to be significant downstream delta, but
AFAIK nowadays the vast, vast majority of code is all upstream (I mean
specifically for things relevant to the shim+3rd party CA secure boot
flow here, like EFI stub/lockdown/mok/etc), so the reasonable
assumption is that in most cases everyone will have to revoke exactly
the same generations, so that's what it's being optimized for. And
remember that the revocation is one, unique and global and applies to
everybody, so everybody needs to use the same generation id - this is
not optional, so it requires coordination, and having an out-of-band
coordination mechanism that associates a bunch of kernel versions to a
bunch of generation ids, that everyone needs to find, agree on, and
keep an eye on, makes things significantly harder.

The other side of the coin is that, for those that don't participate
in such use cases (again, shim+3rd party CA), it's all a no-op. AFAIK
the only hard requirement that would be asked for kernel maintainers
is to every now and then review and merge a patch acked by the usual
suspects that says something like:

-SBAT_GENERATION_ID = 123
+SBAT_GENERATION_ID = 124

and they can otherwise be completely oblivious to any of this, and it
shouldn't affect them or their use cases in any way.

So on one side of the scale there's saving significant time and effort
to pretty much all distribution kernel maintainers, and on the other
side there's reviewing a one-liner every now and then for upstream
maintainers. Unless there is something I am missing, it seems like a
good tradeoff, no? Given that distribution kernel maintainers' time is
a finite resource, any time spent maintaining an out-of-band mechanism
for this - and let's be clear, they _will_ have to in order to
participate in shim+3rd party CA - is time not spent working on more
interesting and useful maintenance tasks for the betterment of the
kernel as a whole.

> > It would be much more work for those actually doing the work, and it
> > wouldn't make any meaningful differences to those who don't care about
> > the use case. AFAIK nobody has suggested that it's kernel maintainers
> > who need to worry about the generation id and do the bookkeeping, if
> > they don't care. I mean I'm pretty sure every help is welcome, but
> > that should be it.
> >
> > The 'owner of the signing key' is not good enough, because there are
> > many of those - as you know, the kernel is signed by each distro. But
> > the key here is that the revocation is _global_ (again: global means
> > it applies to everyone using shim signed by 3rd party CA), so each
> > distro storing their own id defeats the purpose of that.
>
> But this kernel is never signed by the key that signs shim. Each
> distro has its own set of keys to sign releases of their kernel forks.
> So what is the relevance of shim being signed by the MS 3rd party UEFI
> CA certificate here?
>
> In fact, it would make me *much* happier if shim was not mentioned at
> all, and someone could explain why this facility has value if you are
> not using shim in the first place. I'd much prefer to, e.g., have a
> Debian top-level cert in KEK, so it could store its per-release
> signing keys in db, and revoke those (if needed) via dbx. Could SBAT
> play a role in such a context as well?
>
> shim and its GRUB integration have been an endless source of problems
> with EFI boot on non-x86 architectures, so arguing that something is
> needed by shim is not very convincing to me, and generally implies
> that the distros should be owning it instead.

Revoking via DBX does not scale in practice, because revoking by hash
is a non-starter, and revoking certificates is such an horrendous pain
in the backside that de-facto the only reason somebody would go
through that is in case the private keys are lost/stolen, or they
expire. The MSFT db/KEK certs are about to expire, and they'll need
rotating soon-ish. The amount of resources and effort and time this
requires is simply astonishing. I am just observing from the sidelines
and even that gives me fatigue. Nobody will want to do that yearly.

Also, even assuming having distro certs in KEK and rotate them yearly
was possible, there is no way to have that and have it work by default
on consumer PCs. The P0 goal for generalist distributions is that the
user plugs in a USB stick, boots the machine and everything works, out
of the box, without having to mess with bios settings or any of that.
This cannot possibly be achieved if first you have to enroll new
certificates in KEK, because it means you need to go into setup mode
by hand and enroll your own PK, which you need to have prepared
off-box, because OEMs are not going to add 20 random distros KEKs at
factory. Especially if they get revoked yearly or more often due to
bugs, it would essentially require new firmware updates to be pushed,
which wouldn't be installed on machines sitting on a shelf, even
assuming OEMs actually ship firmware updates for old products.

So the value prop of shim+3rd party CA is that you get something that
"just works" out of the box, that doesn't put speedbumps in front of
users. And as it turns out, we need a better revocation mechanism than
what is available to make it all work sensibly and securely, hence why
the people involved in this space have been working on SBAT for the
past couple of years.

Of course one can always self-enroll, and then none of this matters.
This is not aimed at that use case.

Now there's an argument for having the UEFI spec itself mandate a
better, generation-based revocation mechanism, other than what DBX
currently provides. This is being thought about, but we need a
solution that works today and with hardware that has been sold in the
past decade or so and will be sold until such a hypothetical new spec
version is available and implemented and on the market, because the
bad guys won't be waiting patiently for that.
