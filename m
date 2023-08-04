Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25A167705AF
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Aug 2023 18:16:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229883AbjHDQQK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Aug 2023 12:16:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229711AbjHDQQI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Aug 2023 12:16:08 -0400
Received: from mail-qv1-xf32.google.com (mail-qv1-xf32.google.com [IPv6:2607:f8b0:4864:20::f32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4B0B46B1
        for <linux-kernel@vger.kernel.org>; Fri,  4 Aug 2023 09:16:06 -0700 (PDT)
Received: by mail-qv1-xf32.google.com with SMTP id 6a1803df08f44-63cf69f3c22so14419146d6.3
        for <linux-kernel@vger.kernel.org>; Fri, 04 Aug 2023 09:16:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1691165766; x=1691770566;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=25RqaLOVYFfPy9s/EZCIR1SBifhYM46rMdPj4bA+or8=;
        b=xEw45MZnEqdJ293zZ92EP/3OWo4q7OequDcJDIIN9FkZuaVqfsPtMn9pRV2MNBpvwT
         CG5mNkBxAZt+iyzUazrWY3HB6oGDnZ14U9JpZci/06YGqtgwCrBHiGyz8zAH/G7u0Wwx
         mAVrEMW0IAQGNHC/+7poXSAflvfPM3IFOgGtpB765hXaqwmle+lxRiWrX8ginIYTW17b
         wS6k1fJ46sGDTRGzClYccdhTIp/teyPZZAa9BZ5yEysfDvErBjiVpvgvKl50m4swvCIM
         mNh+SDoyUsVvJn4WpQHTe96I3xrJLSunv0eLjbx8HSkrFCo2c9Oa8kkkGenhWFaQjRb/
         W1hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691165766; x=1691770566;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=25RqaLOVYFfPy9s/EZCIR1SBifhYM46rMdPj4bA+or8=;
        b=VBU7ukB9hJIVesQPcU2iCKtgLfLM6ZP02CdMyHMUr9WJ/jAVRol1vZCZ40UfaNTOBs
         KtwkzSenVEaIn6RIUPvqpkg4ss52l/x3Qn4L8wst5h3ufBq8gw3afrZ4zONzdbXEC39A
         pZDDEMZIiDEcyaO/c3lYf4207qlxcQ4BVs6V9jjMt2Hf47nhBciB4iFU223GFdQXd6/p
         DgKcqaMF1I6SMzwmH0KeTGYQzW70s/Aqedff7tbmMfIHofj9vraNNhLVVRmzkt9DrMyy
         3hDeyln/Nv/tCEZCPxBFyfFpZdTtT8umbfqEGvSDN9/ifuIHPEqgXuH8n28+ioZNN2fF
         pLPA==
X-Gm-Message-State: AOJu0YxiocLq3dup0E98Pef8zHLUxAOh1v0O0Bol+QPMqKI/1vLAG0u3
        A4giLavsa2mjk/vC6aKeqqBGISorfZUETPfOgukgNA==
X-Google-Smtp-Source: AGHT+IHxsFGUtaXN8q7zeA5C+xhBK+BWU+T3q6tUpLZSxFyzPk4Ytg+bEKJmDZn+VB7W8WZB8mo1hnhZ4iwhiZOvZSU=
X-Received: by 2002:a05:6214:448d:b0:637:849d:b2bc with SMTP id
 on13-20020a056214448d00b00637849db2bcmr1901680qvb.64.1691165765772; Fri, 04
 Aug 2023 09:16:05 -0700 (PDT)
MIME-Version: 1.0
References: <20230804125609.2054719-1-kernel@xen0n.name> <CAAhV-H5g-jmeQMhicrqhpStV9n0Z-EZ1dZAsuT2hmOaHki4ucg@mail.gmail.com>
 <CAKwvOdmt+p3KM23hz2BfheoWgEa0G9QKnAFYUP+EL2Ta5LXUUg@mail.gmail.com> <b1617fe221f137b49b9a2ba9c864e6b85f89de81.camel@xry111.site>
In-Reply-To: <b1617fe221f137b49b9a2ba9c864e6b85f89de81.camel@xry111.site>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Fri, 4 Aug 2023 09:15:54 -0700
Message-ID: <CAKwvOdnk8ofgW+4D8HnFBqgoi49vkLHqsAMCtM=SpuKyJHVkaQ@mail.gmail.com>
Subject: Re: [PATCH] LoongArch: Drop -ffreestanding from CFLAGS
To:     Xi Ruoyao <xry111@xry111.site>
Cc:     Huacai Chen <chenhuacai@kernel.org>,
        WANG Xuerui <kernel@xen0n.name>,
        Nathan Chancellor <nathan@kernel.org>,
        loongarch@lists.linux.dev, llvm@lists.linux.dev,
        linux-kernel@vger.kernel.org, WANG Xuerui <git@xen0n.name>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 4, 2023 at 8:56=E2=80=AFAM Xi Ruoyao <xry111@xry111.site> wrote=
:
>
> On Fri, 2023-08-04 at 08:46 -0700, Nick Desaulniers wrote:
> > > Not all processors support unaligned access, so we need the
> > > alternative mechanism to select memset/memcpy/memmove implementations=
.
> > > If remove -ffreestanding, the builtin implementation cannot be used o=
n
> > > all hardware.
> >
> > That sounds like a compiler bug in that compiler's implementation of
> > string.h builtins then; it should default to the safest implementation
> > (aligned accesses) until instructed otherwise.  Have you filed a bug
> > against your compiler vendor for which compiler you observe that
> > behavior from?
>
> AFAIK there is no such bug in GCC.
>
> But GCC indeed has a bug about builtin expansion: it generates really
> stupid code for __builtin_memcpy and friends.  See
> https://gcc.gnu.org/PR109465.  The bug is fixed for GCC 14, but GCC 14
> won't be released soon.

Perhaps -fno-builtin-* flags may be of help here, and more precise an
incision than the blunt -ffreestanding.

>
> > At the very least, there should be a comment above the addition of
> > -ffreestanding justifying why it's being used, probably with a link to
> > the above bug report.
> >
> > I would expect either -mcpu or perhaps some other -m flag to guide the
> > compiler when it is safe to emit memcpy (and friends) in terms of
> > unaligned access or not.
>
> It's controlled by -m{no-,}strict-align.  LoongArch kernel defaults to -
> mstrict-align, with this the compiler should not generate unaligned
> access.  -mno-strict-align is hidden behind CONFIG_EXPERT (FWIW I
> personally dislike the decision to hide it).

If GCC generates unaligned accesses in its implementation of
__builtin_memcpy when -mstrict-align is set, then that is a bug in GCC
and should be reported.

Clang users should not have to pay for such mistakes.

>
> --
> Xi Ruoyao <xry111@xry111.site>
> School of Aerospace Science and Technology, Xidian University



--=20
Thanks,
~Nick Desaulniers
