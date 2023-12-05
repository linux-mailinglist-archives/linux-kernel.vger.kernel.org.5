Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EBEEA80607F
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 22:14:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345683AbjLEVO2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Dec 2023 16:14:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229710AbjLEVO0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Dec 2023 16:14:26 -0500
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24957A5
        for <linux-kernel@vger.kernel.org>; Tue,  5 Dec 2023 13:14:33 -0800 (PST)
Received: by mail-wm1-x335.google.com with SMTP id 5b1f17b1804b1-40c0873cf84so35295665e9.1
        for <linux-kernel@vger.kernel.org>; Tue, 05 Dec 2023 13:14:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1701810871; x=1702415671; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xb9GJhgKgkRI3jsH9IhBCRgWeg/UhW5Tj812rINOCFM=;
        b=zlEqBF2VeXS1olvBg3qECJrst42Yf6eVHN92M8T5L+9tyfvFA0RcEIuol/wPMzAZbM
         t33JpTEiV5OIllwwc8iEuHeRqlsFsql3yIUgQtCbP6RWi9GiaGgiJ3foWnGfgIn/O1yK
         R3DJiXbHlCF7y/01Mg4CA/QgWPBPFfai5Qs5+eK8nzsC2tPPzZqPruBlrkuoJCDo50gF
         LuWbwm9ZKKP6zOpRiPKCC7TRSa3+E9D5xn8Gho68KlcqEVdyD+0TVDJpdDWXwchlf+2m
         m8Ku5UUTZtA4Oe41F4873DTlbid2Tk569yA38bt9nK270FOHt6dGg7NfAyM58EdIj7+c
         dm9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701810871; x=1702415671;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xb9GJhgKgkRI3jsH9IhBCRgWeg/UhW5Tj812rINOCFM=;
        b=QID3SrtFYXfoxFiDh/K1JnK1x5RifgDE+eOBbNlnLdVzjiejTlDkv9NGtRO3NPO1J2
         hMkLDe9tSD/FSPVGCNmONmt0vOEKwrkUo8yRDcnIQw3UCgbAU+mT7x1zUAbby1Lcan9O
         dnDaSHw5KL4XfiVPTokaYCahzareCZ9nyBNU1ql39+UGRyiruMLz2dFs5KpzBDe41uYA
         wKKFQbRGMuK1Lmvc4XfgTz+pdzy1hw1xnDzYpoQT07OgUPcccu9iZAluO9wxDh3lW7+p
         TgynhfsIAOE4A04Cl+1WunXCWtFBv6kiEOMey1c6Ur4kn3/koUAZSaw8UOdTCf6/7jpT
         EjgA==
X-Gm-Message-State: AOJu0YxNeqbw4ShWwsp+KyqJSSFB1uFuZX3/KPQ+Ekwd6hO3ZO4ZxtDW
        F7HlkeWuGhLGuDPlfnRVkRWwAd1iti35kJOwGnRlIg==
X-Google-Smtp-Source: AGHT+IFtwZSJqg8gvuxWPu2/HOAjM4Hs0ORK9NX8PQalweoM2W2+Tz3HLyv4QgDmB4awRlvW031nTSk916w+pJBzDzY=
X-Received: by 2002:a5d:51c2:0:b0:333:2fd2:51f0 with SMTP id
 n2-20020a5d51c2000000b003332fd251f0mr4397193wrv.105.1701810871355; Tue, 05
 Dec 2023 13:14:31 -0800 (PST)
MIME-Version: 1.0
References: <20231205-libstringheader-v1-1-7f9c573053a7@gmail.com> <20231205130449.8e330a26ecbed1f7b5ad5d7a@linux-foundation.org>
In-Reply-To: <20231205130449.8e330a26ecbed1f7b5ad5d7a@linux-foundation.org>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Tue, 5 Dec 2023 13:14:16 -0800
Message-ID: <CAKwvOdn+VTM+LY6ALcgaZTL57JpiKt5rBPMSPNXsgS3MCENhDQ@mail.gmail.com>
Subject: Re: [PATCH] lib/string: shrink lib/string.i via IWYU
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     tanzirh@google.com, Kees Cook <keescook@chromium.org>,
        Andy Shevchenko <andy@kernel.org>,
        linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org,
        Nick DeSaulniers <nnn@google.com>, llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 5, 2023 at 1:04=E2=80=AFPM Andrew Morton <akpm@linux-foundation=
.org> wrote:
>
> On Tue, 05 Dec 2023 20:58:53 +0000 tanzirh@google.com wrote:
>
> > This diff uses an open source tool include-what-you-use (IWYU) to modif=
y
> > the include list changing indirect includes to direct includes.
> > IWYU is implemented using the IWYUScripts github repository which is a =
tool that is
> > currently undergoing development. These changes seek to improve build t=
imes.
> >
> > This change to lib/string.c resulted in a preprocessed size of
> > lib/string.i from 26371 lines to 5232 lines (-80%).
> >
> > If there are any problems with the output of the tool please raise an
> > issue on the github.
> >
> > Link: https://github.com/ClangBuiltLinux/IWYUScripts
>
> Issue:
>
> > --- a/lib/string.c
> > +++ b/lib/string.c
> > @@ -16,16 +16,16 @@
> >
> >  #define __NO_FORTIFY
> >  #include <linux/types.h>
> > +#include <asm/bitsperlong.h>

Thanks for the quick feedback.  For additional context, Tanzir is my
intern working on getting IWYU working on the kernel.  Welcome Tanzir
to LKML!

>
> The preferred way to import bit-fiddling stuff is to include
> <linux/bits.h>.  Under the hood this may include asm/bitsperlong.h.  Or
> it may not, depending on Kconfig settings (particularly architecture).
>

Just triple checking my understanding; it looks like
include/linux/bits.h unconditionally includes asm/bitsperlong.h (which
is implemented per arch) most of which seem to include
asm-generic/bitsperlong.h.

include/linux/bits.h also defines a few macros (BIT_MASK, BIT_WORD,
BITS_PER_BYTE, GENMASK, etc).  If lib/string.c is not using any of
those, why can't we go straight to #including asm/bitsperlong.h?  That
should resolve to the arch specific impl which may include
asm-generic/bitsperlong.h?
--=20
Thanks,
~Nick Desaulniers
