Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8243770517
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Aug 2023 17:46:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231907AbjHDPqd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Aug 2023 11:46:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230311AbjHDPqb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Aug 2023 11:46:31 -0400
Received: from mail-qv1-xf2f.google.com (mail-qv1-xf2f.google.com [IPv6:2607:f8b0:4864:20::f2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A56501734
        for <linux-kernel@vger.kernel.org>; Fri,  4 Aug 2023 08:46:30 -0700 (PDT)
Received: by mail-qv1-xf2f.google.com with SMTP id 6a1803df08f44-63d10da0f26so13755816d6.3
        for <linux-kernel@vger.kernel.org>; Fri, 04 Aug 2023 08:46:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1691163990; x=1691768790;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Lbb2VkUYpcvrjAbuA8UFz73QM1aapinYdQ8PfffEqdw=;
        b=uSw8srlvkdNUYJYtc5TNkofuuRG9NlvWsa9z1FxvyZgYol80KHdrxc49/RmliZ/fzc
         W62Zh23a8h9A5Q0U05CYcZlliurch5SLeO+NXbcUxc5Snxe44CHOT6pBpKqbjCQ5tJtu
         m9x21PVKgCsS8RkvCKOUgc2DDgcdAbsfSxqeCLcGA9Chi5toZU2Pq72NgECAMBtyTp0/
         EvoBi8TVPPuKrA0RnO0NW6ui2xNhaT15TPafkWO048bdvP9IwJ2EdIlPNR0oKJfBKuZ+
         326P99bNO/E4ZNzmMhORxtwrEzvIcGTMMa/n/K+eISL7k3poBMBIMrfxtcQw793EssFM
         NbTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691163990; x=1691768790;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Lbb2VkUYpcvrjAbuA8UFz73QM1aapinYdQ8PfffEqdw=;
        b=WA9YwEdn714n6bHVnyUSEL9xsTnCO4QwI5VPm9zi6uTUV/3wUkf+6y9x+PVTRcy0L1
         w0vvDTN3gxvedeDUV/dSvY5FOSW3iuW0Z49rGfMUkWUzJ7wyGKGY8d9K6aeiFs4rLAwy
         XB9094INs8Q9Xd5pYWF6Vf1n71TlKWhQzGceYFfDrsq/DGISjxzPeBQxytxP0XTZF/pG
         93M+tFcPV/ScsJsYUYvfcnXZZo194Z9asDE6aQwzEakpujYcyj6arzEOU5Lk9yrvflpz
         Oe8pFwTG4f46k7BIn6uBarciQg888L7xuYpOEURNBE6qDSeRddgIPp3sDylLx+uO/1/6
         SB+w==
X-Gm-Message-State: AOJu0YxBDXLJ+ysNFTuIvnD9mp1LrpD420dq+qZu0dLgmsc4q2Ouxrnx
        XPsFSbCKTpOq9NJkU5D2FbKR99qZE0S68oLxZa87Hw==
X-Google-Smtp-Source: AGHT+IEu1uNcPnRW/G5hBNtOR5DUb/bVDRNMeccdfr2Wm9PDbUnpDbM+4Azra3rGP6+r18EkGk6+83/9IQfnQ1iFGYg=
X-Received: by 2002:a0c:cb09:0:b0:63d:6fb:c8da with SMTP id
 o9-20020a0ccb09000000b0063d06fbc8damr1804085qvk.14.1691163989483; Fri, 04 Aug
 2023 08:46:29 -0700 (PDT)
MIME-Version: 1.0
References: <20230804125609.2054719-1-kernel@xen0n.name> <CAAhV-H5g-jmeQMhicrqhpStV9n0Z-EZ1dZAsuT2hmOaHki4ucg@mail.gmail.com>
In-Reply-To: <CAAhV-H5g-jmeQMhicrqhpStV9n0Z-EZ1dZAsuT2hmOaHki4ucg@mail.gmail.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Fri, 4 Aug 2023 08:46:18 -0700
Message-ID: <CAKwvOdmt+p3KM23hz2BfheoWgEa0G9QKnAFYUP+EL2Ta5LXUUg@mail.gmail.com>
Subject: Re: [PATCH] LoongArch: Drop -ffreestanding from CFLAGS
To:     Huacai Chen <chenhuacai@kernel.org>
Cc:     WANG Xuerui <kernel@xen0n.name>,
        Nathan Chancellor <nathan@kernel.org>,
        loongarch@lists.linux.dev, llvm@lists.linux.dev,
        linux-kernel@vger.kernel.org, WANG Xuerui <git@xen0n.name>
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

On Fri, Aug 4, 2023 at 8:26=E2=80=AFAM Huacai Chen <chenhuacai@kernel.org> =
wrote:
>
> Hi, Xuerui,
>
> On Fri, Aug 4, 2023 at 8:56=E2=80=AFPM WANG Xuerui <kernel@xen0n.name> wr=
ote:
> >
> > From: WANG Xuerui <git@xen0n.name>
> >
> > As explained by Nick in the original issue: the kernel usually does a
> > good job of providing library helpers that have similar semantics as
> > their ordinary userspace libc equivalents, but -ffreestanding disables
> > such libcall optimization and other related features in the compiler,
> > which can lead to unexpected things such as CONFIG_FORTIFY_SOURCE not
> > working (!).
> >
> > As it turns out to be the case, removing the flag does not impact the
> > LoongArch kernel's normal operation at all; so just remove it to
> > restore expected libcall semantics globally on this architecture.
> >
> Not all processors support unaligned access, so we need the
> alternative mechanism to select memset/memcpy/memmove implementations.
> If remove -ffreestanding, the builtin implementation cannot be used on
> all hardware.

That sounds like a compiler bug in that compiler's implementation of
string.h builtins then; it should default to the safest implementation
(aligned accesses) until instructed otherwise.  Have you filed a bug
against your compiler vendor for which compiler you observe that
behavior from?

At the very least, there should be a comment above the addition of
-ffreestanding justifying why it's being used, probably with a link to
the above bug report.

I would expect either -mcpu or perhaps some other -m flag to guide the
compiler when it is safe to emit memcpy (and friends) in terms of
unaligned access or not.

>
> Huacai
>
> > Closes: https://github.com/ClangBuiltLinux/linux/issues/1897
> > Reported-by: Nathan Chancellor <nathan@kernel.org>
> > Suggested-by: Nick Desaulniers <ndesaulniers@google.com>
> > Signed-off-by: WANG Xuerui <git@xen0n.name>
> > ---
> >  arch/loongarch/Makefile | 1 -
> >  1 file changed, 1 deletion(-)
> >
> > diff --git a/arch/loongarch/Makefile b/arch/loongarch/Makefile
> > index b1e5db51b61c..db0d7210272d 100644
> > --- a/arch/loongarch/Makefile
> > +++ b/arch/loongarch/Makefile
> > @@ -83,7 +83,6 @@ KBUILD_CFLAGS_KERNEL          +=3D -fPIE
> >  LDFLAGS_vmlinux                        +=3D -static -pie --no-dynamic-=
linker -z notext
> >  endif
> >
> > -cflags-y +=3D -ffreestanding
> >  cflags-y +=3D $(call cc-option, -mno-check-zero-division)
> >
> >  load-y         =3D 0x9000000000200000
> > --
> > 2.40.0
> >
>


--=20
Thanks,
~Nick Desaulniers
