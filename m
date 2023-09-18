Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 065117A4E9A
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Sep 2023 18:20:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229872AbjIRQT4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Sep 2023 12:19:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230194AbjIRQTg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Sep 2023 12:19:36 -0400
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AC566EAD
        for <linux-kernel@vger.kernel.org>; Mon, 18 Sep 2023 09:11:49 -0700 (PDT)
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com [209.85.221.71])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id EEB763F69B
        for <linux-kernel@vger.kernel.org>; Mon, 18 Sep 2023 15:41:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1695051714;
        bh=y+XPAVKGm/EwbYadfbcJ41BWcgF5THbmIe2v8KFzKkU=;
        h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
         To:Cc:Content-Type;
        b=J8Mth4ycrURNdnosIoE+t5IITso60GtmPtjBSSN3HXaC5quTwoyCYzWTSSd4rJlqk
         /B8xe12bRRQJDJm6PKIaOlYHc5oZ9CBsejMkgWtgGoLHt0xEt8+dTu5lRk/N21QTwd
         x0kFtDa0CVTib3DAf1RO/v0TSWt1r/t/UefAsbjfKsoV0zJgKvVfQujaqTBejXO+IN
         QfhOxM1LIyMA2g+f019SJyLB3dbYmV2jkdub03lndSU/Ap20PX1aPfgGog+lyr70db
         2EJ2Vd/Ekb57aK1CvrseEg3ozXNUUU4Q69478hOp80ENnVocoMoT9Q3uR3/XX0k6gV
         EIzoLAYrZ+DJw==
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-31fe836e5d8so2604133f8f.0
        for <linux-kernel@vger.kernel.org>; Mon, 18 Sep 2023 08:41:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695051710; x=1695656510;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=y+XPAVKGm/EwbYadfbcJ41BWcgF5THbmIe2v8KFzKkU=;
        b=Q3w7iv8xpIUnC470TvPucPFOWWqluuafWXiXqfKioDoMSX2yoNPNBvQKfV+W098mes
         Dj7492uDiIJONsrT2XUW78XQz2Ky4NxyFFLPR3zYhCTArovyH0Thl/I5qyocJwpkBoRU
         CSTG+KRkb3PUUoHC2+Ho7ftCfpVo0K6fkayWK+O4qyuvxrz+4gjB34XmTgWjtrJjZON3
         6eFCuFCm/Igc4DP/851aDxcItFlOGNcTSG0qKTj0p2yhGN5F0rWSHLVb8P+O9fmvX3/5
         xDSwlrDtkPKlM7gH+H046W+GcaZOPOvuj2+KErKf2GFOM0bfvCV2ev4SUEjliIERc01q
         dijw==
X-Gm-Message-State: AOJu0YwH1G9Yh3E/X7n9h41JXuRg6jwwdWuKuUp9s/XPUrF79BQb5O8t
        IVFXURidBVo3mr8uC2kxRd5ckhyGwjuyguYudQ43fPlOBsJWy2KHvmT8zUyVu/qtkCmmm+pgOm2
        J08vrUuv642MOevUsxhX6LnCA9vvIsB1rStiF0G06HwwqAcPnIPvoxud1vtfSW4TnveSJ
X-Received: by 2002:a05:6000:1704:b0:320:bb1:5a76 with SMTP id n4-20020a056000170400b003200bb15a76mr4585921wrc.56.1695051710175;
        Mon, 18 Sep 2023 08:41:50 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGsVJclT5l6JKHYSqhCL8Kigvic3R79GQqfIjbGeGq5mErkfPpOMV0tORq18sC+8oRLK+d1kBjJLTWEX8mt+XM=
X-Received: by 2002:a05:6000:1704:b0:320:bb1:5a76 with SMTP id
 n4-20020a056000170400b003200bb15a76mr4585897wrc.56.1695051709855; Mon, 18 Sep
 2023 08:41:49 -0700 (PDT)
MIME-Version: 1.0
References: <20230909161851.223627-1-kernel@jfarr.cc> <CVGFE6FRWFHR.DVG9NUQID4EA@suppilovahvero>
 <CAEg-Je9GF5S+QcsspM_CzDSxzCN8h2eRp7BbctC1x7-rH8j68g@mail.gmail.com> <CVGVGJIQPIZ2.WN97L6BV5S97@suppilovahvero>
In-Reply-To: <CVGVGJIQPIZ2.WN97L6BV5S97@suppilovahvero>
From:   Dimitri John Ledkov <dimitri.ledkov@canonical.com>
Date:   Mon, 18 Sep 2023 16:41:13 +0100
Message-ID: <CADWks+bRm9LnujBo1SiATDfC1sCNU0vvCy_r=YBpYLXcQrbQeA@mail.gmail.com>
Subject: Re: [systemd-devel] [PATCH 0/1] x86/kexec: UKI support
To:     Jarkko Sakkinen <jarkko@kernel.org>
Cc:     Neal Gompa <ngompa13@gmail.com>,
        systemd-devel@lists.freedesktop.org, x86@kernel.org,
        kexec@lists.infradead.org, linux-kernel@vger.kernel.org,
        dhowells@redhat.com, keyrings@vger.kernel.org, bhelgaas@google.com,
        Jan Hendrik Farr <kernel@jfarr.cc>, tglx@linutronix.de,
        akpm@linux-foundation.org, bluca@debian.org
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

On Tue, 12 Sept 2023 at 11:38, Jarkko Sakkinen <jarkko@kernel.org> wrote:
>
> On Tue Sep 12, 2023 at 2:20 AM EEST, Neal Gompa wrote: > On Mon, Sep 11, =
2023 at 7:15=E2=80=AFPM Jarkko Sakkinen <jarkko@kernel.org> wrote:
> > > On Sat Sep 9, 2023 at 7:18 PM EEST, Jan Hendrik Farr wrote:
> > > > Hello,
> > > >
> > > > this patch implements UKI support for kexec_file_load. It will requ=
ire support
> > > > in the kexec-tools userspace utility. For testing purposes the foll=
owing can be used:
> > > > https://github.com/Cydox/kexec-test/
> > > >
> > > > There has been discussion on this topic in an issue on GitHub that =
is linked below
> > > > for reference.
> > > >
> > > >
> > > > Some links:
> > > > - Related discussion: https://github.com/systemd/systemd/issues/285=
38
> > > > - Documentation of UKIs: https://uapi-group.org/specifications/spec=
s/unified_kernel_image/
> > > >
> > > > Jan Hendrik Farr (1):
> > > >   x86/kexec: UKI support
> > > >
> > > >  arch/x86/include/asm/kexec-uki.h       |   7 ++
> > > >  arch/x86/include/asm/parse_pefile.h    |  32 +++++++
> > > >  arch/x86/kernel/Makefile               |   2 +
> > > >  arch/x86/kernel/kexec-uki.c            | 113 +++++++++++++++++++++=
++++
> > > >  arch/x86/kernel/machine_kexec_64.c     |   2 +
> > > >  arch/x86/kernel/parse_pefile.c         | 110 +++++++++++++++++++++=
+++
> > > >  crypto/asymmetric_keys/mscode_parser.c |   2 +-
> > > >  crypto/asymmetric_keys/verify_pefile.c | 110 +++------------------=
---
> > > >  crypto/asymmetric_keys/verify_pefile.h |  16 ----
> > > >  9 files changed, 278 insertions(+), 116 deletions(-)
> > > >  create mode 100644 arch/x86/include/asm/kexec-uki.h
> > > >  create mode 100644 arch/x86/include/asm/parse_pefile.h
> > > >  create mode 100644 arch/x86/kernel/kexec-uki.c
> > > >  create mode 100644 arch/x86/kernel/parse_pefile.c
> > > >
> > > > --
> > > > 2.40.1
> > >
> > > What the heck is UKI?
> >
> > Unified Kernel Images. More details available here:
> > https://uapi-group.org/specifications/specs/unified_kernel_image/
> >
> > It's a way of creating initramfs-style images as fully generic,
> > reproducible images that can be built server-side.
>
> You can build today a kernel with these compiled in:
>
> 1. EFI stub
> 2. initeramfs
> 3. cmdline
>
> Why another way (and label 'UKI') for a pre-existing feature?
>

In Ubuntu, we have considered to use the existing kernel features
before going off to use UKI. Here are some of the reasons why we
didn't opt to use the kernel builtin things:
1) we wanted to have ability to have TPM measured kernel commandline
performed before kernel is being executed, which is what sd-stub
provides us
2) we wanted to have ability to update / regenerate initrd, without
rebuilding kernel. Thus whenever userspace in the initrd needs
updating, we can generate new initrd for existing kernel build, create
new kernel.efi, whilst using existing .linux / vmlinuz build. I don't
believe it is currently trivial to relink vmlinuz with builtin initrd.
3) licensing wise it was not clear if initrd has to be GPLv2
compatible when linked inside vmlinuz, or if it can contain GPLv3 /
LGPLv3 userspace code - with UKI it is believed unambigiously true,
because vmlinuz boots by itself standalone and is compiled separately
of the UKI.
4) we wanted to have ability to override cmdline via kernel args
without secureboot, and use stock cmdline args under secureboot, to
allow debugging & production behaviour from a single signed kernel.efi
(that was custom development, and could be done in the stock vmlinuz
too).
5) obvious mention, the intention here is to have TPM PCR measurements
and Secureboot signature for vmlinuz and initrd and cmdline and dtb.
There is otherwise no support for standalone signed initrd, cmdline,
dtb today. Nor does vendoring it into vmlinuz achieves this to the
same extent (and ease of predicting for sealing / resealing purposes).
6) in Ubuntu kernel.efi also has sbat section for targeted revocations
(discussed separately elsewhere)

Overall, it is mostly about flexibility to be able to reuse the same
initrd against multiple kernel builds, or update use multiple initrd
against the same kernel build. This is imho the biggest issue with
using initrd built-into the vmlinuz itself.
Resource wise, the initrd passed in via kernel.efi can be freed, as
far as I understand. I don't know if the one built-into the vmlinuz is
freeable.

Improving design to do something else instead of UKI would be
welcomed. Or for example improving the zimg linus upstream format to
be a partial or a valid UKI would help as well. For example, building
the kernel built-in initrd as a .initrd section that is replacable
would be nice, or allowing to preload zimg with .dtb or .cmdline
sections would help, and appropriately improve the linux efi stab to
do measurements and loading of .dtb / .initrd from itself would be
nice. Because then all the benefits / requirements described above
could be made available out of the box and be trivially updatable. The
biggest one being splitting out things into sections that can be
updated with objcopy.

> BR, Jarkko

--=20
okurrr,

Dimitri
