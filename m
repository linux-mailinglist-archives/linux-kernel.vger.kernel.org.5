Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C4FA80C653
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Dec 2023 11:24:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234917AbjLKKYV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Dec 2023 05:24:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229654AbjLKKYT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Dec 2023 05:24:19 -0500
Received: from mail-yw1-x112f.google.com (mail-yw1-x112f.google.com [IPv6:2607:f8b0:4864:20::112f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C359791;
        Mon, 11 Dec 2023 02:24:25 -0800 (PST)
Received: by mail-yw1-x112f.google.com with SMTP id 00721157ae682-5d7692542beso41161077b3.3;
        Mon, 11 Dec 2023 02:24:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702290265; x=1702895065; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HxjdC9gG0FASpcYRfeHrDm90rNJUB49UE6RBV0eXfa8=;
        b=mBdve7xWbRlPWlYMo43wviUIdttIA6OBkqiuM5sHVu6+jn53FTmB3UmP+AWHopRHZC
         a7z5Vq/IHDotZA1U9YLjWPm4d2eJRDO3gGoW8aSX2TYkMdTA+MCZ0kmc96F0UBR4Y+dQ
         gEF6HMMHXiiRywJTO4pJrrPHtPkYuYUvIuXL10o/jicHp6uZPnoxksdBAHyXAORnfu5y
         2WtAwCAa+D2oYp+UUEH7V1X6W0vBkmu/tZ35uEtMPtIhCjoGyfLFLt/KYsE251q2GVdC
         UTUQ8JBz3hDzYm52oBptbs7jTy2PTVjxrV62uIR927ca6oghr2EYRweIIKE9cfZWxNG1
         bb2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702290265; x=1702895065;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HxjdC9gG0FASpcYRfeHrDm90rNJUB49UE6RBV0eXfa8=;
        b=slJJIFKzxWik3fbJ6P6yN/b/aBfnkJ5fpMiuyDIoB0rGN+jBAREzW767PFIVgRzngE
         bjJonFCKPvSMtqHjzriW4bvWuV2Q2Z81gQt47JY14feTq2AtMbZfm637AQc8cVzJy6NH
         uJhF/fKYGWsakZBbYx7RYBnDIjZmVy0LUdeaiDCTBK3w5W7EwS6pALhWv9tE2dekTjMi
         NOzpoOI6kLgfONLrkSngDvELbWgpp3dfg4xNaaCAjotwxkURbECC6gn0GpQgM3IcXpwP
         yfs/I0ysbx5cFft9N8Fnl/Dblbu1LvJqzgnJaQFOe7fD7GcpT48oYYzse9RrRPLMj68P
         Scng==
X-Gm-Message-State: AOJu0YygGw1MZhnoiCWO43CcY6mds8kVaXyby10ZGPECSIDf95QVn8xn
        53HGe9TySGPPsH0svBl6G0Ox/tJLesM3Ni0rhEQ=
X-Google-Smtp-Source: AGHT+IGmF7rCGzSyqKfqD2TRI9vyoiPLZLomxHRnO/Mazk7erhr/oeot7BOADdKT5S1gzsmsdTlRbMDAuhmPh48JXnE=
X-Received: by 2002:a0d:d007:0:b0:5d7:1940:53d9 with SMTP id
 s7-20020a0dd007000000b005d7194053d9mr3123865ywd.81.1702290264941; Mon, 11 Dec
 2023 02:24:24 -0800 (PST)
MIME-Version: 1.0
References: <CAFSh4UwYYAOb0YpC=WAL6SD+8jTLuSkhgrgjh8JmogUb10V=zw@mail.gmail.com>
 <ZXMGqjm1466fQ3g2@archie.me>
In-Reply-To: <ZXMGqjm1466fQ3g2@archie.me>
From:   Tom Cook <tom.k.cook@gmail.com>
Date:   Mon, 11 Dec 2023 10:24:14 +0000
Message-ID: <CAFSh4Uz4jMhR8jV2xjcDg4i05neJMsBewtgcxmG_csETzYdq3A@mail.gmail.com>
Subject: Re: Building signed debs
To:     Bagas Sanjaya <bagasdotme@gmail.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Kernel Build System <linux-kbuild@vger.kernel.org>,
        Linux Crypto API <linux-crypto@vger.kernel.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        Nick Terrell <terrelln@fb.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 8, 2023 at 12:06=E2=80=AFPM Bagas Sanjaya <bagasdotme@gmail.com=
> wrote:
> On Fri, Dec 08, 2023 at 11:14:35AM +0000, Tom Cook wrote:
> > Unsetting CONFIG_MODULE_COMPRESS_ZSTD is a workaround (ie disable
> > module compression).
> >
>
> Seriously? Unrelated option becomes a workaround?

"Workaround" as in "With this options set, `make deb-pkg` crashes out with =
the
reported error, while with this option unset it produces a deb package
of a signed
kernel and modules."  This looks like a defect in the build system to me an=
d the
workaround allows me to build a package in the meantime.

> > Is there a way to build a .deb of a signed kernel with compressed modul=
es?
> >
> > Thanks for any help,
> > Tom
> >
> >   INSTALL debian/linux-libc-dev/usr/include
> >   SIGN    debian/linux-image/lib/modules/6.6.0-local/kernel/arch/x86/ev=
ents/amd/amd-uncore.ko
> >   SIGN    debian/linux-image/lib/modules/6.6.0-local/kernel/arch/x86/ev=
ents/intel/intel-cstate.ko
> > At main.c:298:
> > - SSL error:FFFFFFFF80000002:system library::No such file or
> > directory: ../crypto/bio/bss_file.c:67
>
> Above means that you don't have a valid certificate/keypair set in
> CONFIG_MODULE_SIG_KEY. If you keep the option value on `certs/signing_key=
.pem`
> (which is the default), the key should be automatically generated
> (with your observation, only if `certs/x509.genkey` doesn't already exist=
).
> After building the kernel with `make all`, you should check if the certif=
icate
> pointed in CONFIG_MODULE_SIG_KEY is present or not. If it isn't the case,
> you have to generate the certificate yourself. For more information, see
> Documentation/admin-guide/module.signing.rst in the kernel sources.

Sorry for being unclear - I'm not building with `make all`, I'm
building with `make deb-pkg`.
If I had to guess, I'd say the .deb depends on the uncompressed modules
rather than the dependency depending on whether module compression is turne=
d
on or not, but it's only a guess.

Regards,
Tom
