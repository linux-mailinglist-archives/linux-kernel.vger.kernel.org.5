Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EEC1180619A
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 23:21:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346579AbjLEWVF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Dec 2023 17:21:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229591AbjLEWVC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Dec 2023 17:21:02 -0500
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1ACD137
        for <linux-kernel@vger.kernel.org>; Tue,  5 Dec 2023 14:21:08 -0800 (PST)
Received: by mail-wm1-x335.google.com with SMTP id 5b1f17b1804b1-40b2ddab817so64122565e9.3
        for <linux-kernel@vger.kernel.org>; Tue, 05 Dec 2023 14:21:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1701814867; x=1702419667; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OtdgYO2/5wzcNxCn3VtqicgQzIviRp5CjfOT6b/JWQ0=;
        b=tRlIzDb4uNTyUDRQFsBCDd/+gfoE++6balB9VVWBmuUjCJgBqdWGvBCYS2WmJHZVNH
         6Lf2Tpb03aCOEZLQwf5C7xy5VE0OAmKr4P3jRWRhJT8DSOh3fne6oM9sXjrB0QE4Sf1m
         kbIpvzl4OSyU31MSYwWPilXOdCaX3uLu/PMtFw4994vdLmaQt7fE1DK7s6//1oRNfzng
         p4z+9vR0uVQ5+2QIXGAuW08MGoTo3WTqGQvczcP100NO0tHfChR5dFWMDQzYBvwsDfK1
         5SXFf4AVcBRMeuAaMTXoz/6aOUImGXoMRFukQIIIhpZR76LjB4bHwYCwuqd63kXhakmS
         L3tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701814867; x=1702419667;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OtdgYO2/5wzcNxCn3VtqicgQzIviRp5CjfOT6b/JWQ0=;
        b=QUTMhWVDRLAjoiBsntcyZqvsjQwY2Uo6r31WW05oI36crHo6FlxMkL7kpGwqRfaaCE
         HleY4GBOh/0KKwb+cbe0r+kywp9YO1Jx2cbUXrc7+9f9+DEZVGnKjjp+ZD5zi3ECthni
         Qhw67328nPov55DpjU7/mK1NDjka6y8Jg66fR9EoKpWpeViVBw/8GSGXY2u+pBJ+alFj
         DZ6DyUmrN3lQM1qBPtOvBqdwaKWRB/wehRn1Ar8rCjzzV8UkLF5b0sy9ZO7POfFEa975
         J4O9TZXqz05dI6itp+HFypLQUtxQZ6ps85xIWFZ+PppLfoIVcd/9Rmv01IRby3LzdGv/
         veDg==
X-Gm-Message-State: AOJu0YxIRWxYkdaILFCAdrrMVXmSjhBm33/dzzobSFiLLJ8jTIid1Uto
        ocUAeG+VTd3e0zz+YKXAu+JNaJVQRLDbEFyZ4EAyLQ==
X-Google-Smtp-Source: AGHT+IEHRLg/u4MDQUXn2Q3Vi3FcZx0NgtWPXTCyQiVCGa7EFiClCbQEpu59QZ9PdQyHgzUKzF5X+LKaQB/fPM6CEJg=
X-Received: by 2002:a05:600c:4f81:b0:40c:67a:b3bc with SMTP id
 n1-20020a05600c4f8100b0040c067ab3bcmr14832wmq.71.1701814867131; Tue, 05 Dec
 2023 14:21:07 -0800 (PST)
MIME-Version: 1.0
References: <20231205-libstringheader-v1-1-7f9c573053a7@gmail.com>
 <20231205213807.GE1674809@ZenIV> <CAKwvOd=2VASkaLvjU+7kkbvhu2CimYn5KUGJBDRePyUhtrNK2Q@mail.gmail.com>
 <ZW-d1NZRIvmJlfcW@smile.fi.intel.com> <20231205221521.GH1674809@ZenIV>
In-Reply-To: <20231205221521.GH1674809@ZenIV>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Tue, 5 Dec 2023 14:20:55 -0800
Message-ID: <CAKwvOdm3PrKhGi9DuQvaYN6O-R-EtGQ=BhFm7D4ZPDqU_ZzUkA@mail.gmail.com>
Subject: Re: [PATCH] lib/string: shrink lib/string.i via IWYU
To:     Al Viro <viro@zeniv.linux.org.uk>,
        Andy Shevchenko <andy@kernel.org>
Cc:     tanzirh@google.com, Kees Cook <keescook@chromium.org>,
        linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org,
        Nick DeSaulniers <nnn@google.com>,
        Andrew Morton <akpm@linux-foundation.org>, llvm@lists.linux.dev
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

On Tue, Dec 5, 2023 at 2:15=E2=80=AFPM Al Viro <viro@zeniv.linux.org.uk> wr=
ote:
>
> On Wed, Dec 06, 2023 at 12:01:56AM +0200, Andy Shevchenko wrote:
> > On Tue, Dec 05, 2023 at 01:51:10PM -0800, Nick Desaulniers wrote:
> > > On Tue, Dec 5, 2023 at 1:38=E2=80=AFPM Al Viro <viro@zeniv.linux.org.=
uk> wrote:
> > > > On Tue, Dec 05, 2023 at 08:58:53PM +0000, tanzirh@google.com wrote:
> >
> > ...
> >
> > > > > IWYU is implemented using the IWYUScripts github repository which=
 is a tool that is
> > > > > currently undergoing development. These changes seek to improve b=
uild times.
> > > > >
> > > > > This change to lib/string.c resulted in a preprocessed size of
> > > > > lib/string.i from 26371 lines to 5232 lines (-80%).
> > > >
> > > > It also breeds includes of asm/*.h, by the look of the output, whic=
h is
> > > > not a good thing in general ;-/  E.g. #include <asm/uaccess.h> *any=
where*
> > > > outside of linux/uaccess.h is a bad idea.
> > >
> > > It's not clear to me when it's ok to #include <asm/*.h>.  Is there a
> > > convention here that I'm missing?
> >
> > The mandatory ones can be used, but not all of them.
> > In some cases you even must include asm and not linux
> > (unaligned.h, byteorder.h, maybe others...).
> >
> > As I told, it comes with experience, we lack of the
> > respective documentation (or file which is good for
> > automation checks, like with IWYU).
>
> It would certainly be nice to have such information in the tree;
> "where should I pick $SYMBOL from?" is something one needs to
> find out often enough.  To a large extent it's covered by "where
> in include/*.h do we have it defined?", but that's not all there
> is to it.  E.g. "get_user() =3D> use linux/uaccess.h".
>
> There's also stuff like "$SYMBOL should not be used outside of arch/*
> and include/*, better use $OTHER_SYMBOL", etc.

That's basically one of the tables we maintain.
https://github.com/ClangBuiltLinux/IWYUScripts/blob/main/symbol.imp

Of course, such a table is a living document; whether it resides in
tree or out of tree eventually I don't particularly care either way.
There are outstanding questions like "is it even possible to
autogenerate such a table (vs manual curation)" and "are the ones
we've coded so far correct?"  I don't expect to have all of the
answers with the initial implementation, but instead to collect
feedback from kernel devs and iterate from there.  Very helpful
responses in this thread so far; we appreciate it.

I suspect that folks that have played with IWYU in the past
encountered great difficulty since these override tables are poorly
documented, and the out of the box defaults assume more of a userspace
layout for common definitions (which our script which wraps IWYU
disables).
--=20
Thanks,
~Nick Desaulniers
