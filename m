Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36618772BF6
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Aug 2023 19:03:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230344AbjHGRCy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 13:02:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229924AbjHGRCu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 13:02:50 -0400
Received: from mail-qk1-x731.google.com (mail-qk1-x731.google.com [IPv6:2607:f8b0:4864:20::731])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 330B8BD
        for <linux-kernel@vger.kernel.org>; Mon,  7 Aug 2023 10:02:49 -0700 (PDT)
Received: by mail-qk1-x731.google.com with SMTP id af79cd13be357-76c845dc5beso283571985a.1
        for <linux-kernel@vger.kernel.org>; Mon, 07 Aug 2023 10:02:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1691427768; x=1692032568;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pPzNa0UKe3qZKRzfGQZ1UEAX4I6z+lfQbRMixCND1rQ=;
        b=4UaMPnbDEf30m1BGqzkma+HXL2WmhTgypGhqrEsiswwpaWLDyhObVXkR1g+/SnYsU2
         xJ/i2xbhGJZXLGFwVyeQFY1iv0qRvB8/QDLGfWuftmY7IUhLw145TCPvDmWEexj8J1TQ
         ffIhTXGSDZfKpb5ARJCC9ANqLfE8aoo5v+qLffOUKx8xgGJ/L8ZlMoXUCn3OHSWgAnzR
         mt2qhHSTHEtN62CPl3YRQSA6ytVhDSh5GDzboxXR2M1H/22ZJAaRaJI+zK4XIz1Uho5z
         gszTGDaiHOJNvFb+cV9a8USQsYIAWWjdI6vF1kTS2BENHcNeQtnm9YhOSWjQH78jW1fk
         c32A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691427768; x=1692032568;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pPzNa0UKe3qZKRzfGQZ1UEAX4I6z+lfQbRMixCND1rQ=;
        b=GSlRC3v2gP/WxH/+EPTVAa/0/KGrZY+mZ/oaNKavNC+lBPQEt+wYNidPkZsBMKkhDu
         o7ttldEWLwvcXiNilXbpucxFsOJ04e8qP9gSNRLUtFK0hFanLrAyhEr8TDhCf0dNoxwx
         LuxB6JbfzX1t8Jpg/YlihscPsVIjDeEbpdac46UXTH3eIf83eMzSMExDR0eeBTNsYn0T
         //SYL4WXed5xLSsG6P9yQ5ioZrvagzbujTfdvJCpira77SN5oevg1LA8XfwBCwRBRMpW
         RrBMQoMjnKDj2uvNnchvSh12QK87EDr7dBV6Tbzwh2if6ceNJ2QRpJI/Er5hmagQ3OjB
         ehCQ==
X-Gm-Message-State: AOJu0Yzhw4/XgtaTB8GQTv/9Uafy4dDF7d/OaEg2e2ysfPZHue8lsR8t
        uyBjRgxOsgad/fpb0sIcYjSAgNX7VIsQOGamn5sTokBXmzhtixhhOD9CYQ==
X-Google-Smtp-Source: AGHT+IGfpiEjSoBiZNgXb9Gb35xtnJJw1TmzrzA2s+pmXNQMoTRjyei5j+ERFA0wB2V967+Rcx7x0WxRFtZth24fEz8=
X-Received: by 2002:ad4:4149:0:b0:63c:fbe9:6837 with SMTP id
 z9-20020ad44149000000b0063cfbe96837mr6996168qvp.11.1691427768106; Mon, 07 Aug
 2023 10:02:48 -0700 (PDT)
MIME-Version: 1.0
References: <20230807-missing_proto-v1-1-7f566b7ba5ca@google.com> <20230807165526.GA2744968@dev-arch.thelio-3990X>
In-Reply-To: <20230807165526.GA2744968@dev-arch.thelio-3990X>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Mon, 7 Aug 2023 10:02:37 -0700
Message-ID: <CAKwvOd=8kxkD9p+WW-F047ShN=r32SLYYfpgZhyDw3BXTDd-KA@mail.gmail.com>
Subject: Re: [PATCH] Makefile.extrawarn: enable -Wmissing-variable-declarations
 for W=1
To:     Nathan Chancellor <nathan@kernel.org>
Cc:     Masahiro Yamada <masahiroy@kernel.org>,
        Nicolas Schier <nicolas@fjasle.eu>, Tom Rix <trix@redhat.com>,
        linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 7, 2023 at 9:55=E2=80=AFAM Nathan Chancellor <nathan@kernel.org=
> wrote:
>
> On Mon, Aug 07, 2023 at 09:50:32AM -0700, Nick Desaulniers wrote:
> > I noticed Tom was sending patches where smatch was recommending
> > annotating functions as static when no previous declaration existed.
> > Surely the compiler could make such recommendations as well, I thought.
> >
> > Looks like -Wmissing-variable-declarations can make such
> > recommendations.
> >
> > GCC just added support for this warning (gcc 14.1.0 will ship with
> > support), and all versions of clang relevant to building the kernel
> > support this flag.
> >
> > Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>
>
> Any idea how many instances of this there are? At least x86_64 defconfig
> fails immediately with:

$ make LLVM=3D1 -j128 W=3D1 allnoconfig 2>log.txt
$ grep -r Wmissing-variable-declarations log.txt | sort -u | wc -l
140
Though that's not perfectly filtered due to overlapping output due to -j 12=
8.

>
>   In file included from scripts/mod/devicetable-offsets.c:3:
>   In file included from include/linux/mod_devicetable.h:14:
>   In file included from include/linux/uuid.h:11:
>   In file included from include/linux/string.h:20:
>   In file included from arch/x86/include/asm/string.h:5:
>   In file included from arch/x86/include/asm/string_64.h:6:
>   In file included from include/linux/jump_label.h:112:
>   In file included from arch/x86/include/asm/jump_label.h:7:
>   arch/x86/include/asm/asm.h:208:24: error: no previous extern declaratio=
n for non-static variable 'current_stack_pointer' [-Werror,-Wmissing-variab=
le-declarations]
>     208 | register unsigned long current_stack_pointer asm(_ASM_SP);
>         |                        ^
>   arch/x86/include/asm/asm.h:208:10: note: declare 'static' if the variab=
le is not intended to be used outside of this translation unit
>     208 | register unsigned long current_stack_pointer asm(_ASM_SP);
>         |          ^

Hmm...I wonder if clang and gcc should ignore variables with register
storage for this warning.

>   1 error generated.
>
> > ---
> >  scripts/Makefile.extrawarn | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/scripts/Makefile.extrawarn b/scripts/Makefile.extrawarn
> > index 40cd13eca82e..617739eb84e2 100644
> > --- a/scripts/Makefile.extrawarn
> > +++ b/scripts/Makefile.extrawarn
> > @@ -32,6 +32,7 @@ KBUILD_CFLAGS +=3D $(call cc-option, -Wunused-but-set=
-variable)
> >  KBUILD_CFLAGS +=3D $(call cc-option, -Wunused-const-variable)
> >  KBUILD_CFLAGS +=3D $(call cc-option, -Wpacked-not-aligned)
> >  KBUILD_CFLAGS +=3D $(call cc-option, -Wstringop-truncation)
> > +KBUILD_CFLAGS +=3D $(call cc-option, -Wmissing-varibale-declarations)
>                                                 ^ variable
> >  # The following turn off the warnings enabled by -Wextra
> >  KBUILD_CFLAGS +=3D -Wno-missing-field-initializers
> >  KBUILD_CFLAGS +=3D -Wno-sign-compare
> >
> > ---
> > base-commit: 52a93d39b17dc7eb98b6aa3edb93943248e03b2f
> > change-id: 20230807-missing_proto-0cb90ec6454c
> >
> > Best regards,
> > --
> > Nick Desaulniers <ndesaulniers@google.com>
> >



--=20
Thanks,
~Nick Desaulniers
