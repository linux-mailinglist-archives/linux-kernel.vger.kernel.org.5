Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DDF637F2B19
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Nov 2023 11:59:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233685AbjKUK7C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Nov 2023 05:59:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231439AbjKUK7A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Nov 2023 05:59:00 -0500
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90B2083;
        Tue, 21 Nov 2023 02:58:56 -0800 (PST)
Received: by mail-lj1-x236.google.com with SMTP id 38308e7fff4ca-2c8769edd9fso35176851fa.0;
        Tue, 21 Nov 2023 02:58:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700564335; x=1701169135; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :reply-to:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=CCTVl3tUjQOvHObHzjbVxbNLOTFELDSW5iqT75QPHdA=;
        b=MZ4sKoiS8IkAswmR6yLuMVKZ9eYtKdrAFMQgQ/UaP9KelooCvfcWh0f7n3hoxMduUk
         ZsjvlEWOstfl7OsV1J1hfA16A3ukwGduMspaVpyp+jqazfFnPJ8JP+nGmz3ot69ZS9vm
         8bLZvw4WqwMHf6a031SuB9B3gI9iJy7NZ17IkRKnwvzY7ClV4DNfAptj2mgXrObOKCpm
         K1QvGWDT0UzrV2a3FFOQ/fs1VTDrj01fBb+9IgVJXi7YiSD0XBzGLBPDfjiWlfczW7wy
         qvOqzqUjNs8Z6mfrOiX4WSwef4m6CMeuBPaVzEmPSdDnPxGCUe51H75b4x/Uup5m4qN8
         kubw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700564335; x=1701169135;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :reply-to:in-reply-to:references:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=CCTVl3tUjQOvHObHzjbVxbNLOTFELDSW5iqT75QPHdA=;
        b=EldVdOzvl8GStiBtL8LMku68Qeiqi4GfL5MsJOrHe/YiGnzcpd+JvN9DTpzf8jqFjP
         YEMTocBDWBy8eIYmsJT46ZFSBSnDYwYYElBvEYRq0XES2EyX9XIessoLFIG2hyQ0PMDA
         qaTZ1iH84RrRcPOUvQOOm84mLgFA1+iun18lHUya3WzUCvB9QfwwJKqVVvNBRA3CcK9F
         bSQhT9g6CvJp9qBRkg0OCh70R5D12xHCoVuhReYLGHxT+IlB9cWGM+YjwV/KnwPJLjU0
         fXCwNqBhtbC6K+83nzLKKulYsEncZunKClZUGjaCiYzmdAN0j6iydvNhI9z/MqLeMbXw
         YyOw==
X-Gm-Message-State: AOJu0YzEZkszCAmD57s7QhsqhFrysbf6fUIiwM42r4upyiO7GJAxIdy/
        IqyRCURX6pSgeNvRfkeyeZcSWk6P+3+MjTaDYbM=
X-Google-Smtp-Source: AGHT+IGmo1HpOU/EHoxZuU2TPsFSxyO1Siz8LBA8opwt+bBm4TaevsOx0CoZ1Nke4igOByX5NlDQGKXd1jqMKLbZMgs=
X-Received: by 2002:a2e:1f11:0:b0:2c5:f54:2477 with SMTP id
 f17-20020a2e1f11000000b002c50f542477mr6787045ljf.40.1700564334353; Tue, 21
 Nov 2023 02:58:54 -0800 (PST)
MIME-Version: 1.0
References: <20231117-maintainers-v1-1-85f2a7422ed9@google.com>
In-Reply-To: <20231117-maintainers-v1-1-85f2a7422ed9@google.com>
Reply-To: sedat.dilek@gmail.com
From:   Sedat Dilek <sedat.dilek@gmail.com>
Date:   Tue, 21 Nov 2023 11:58:17 +0100
Message-ID: <CA+icZUXFGp-yoWUHhbowz6YJyoULCgtjSZ-fTpRg8YvVD9V5gg@mail.gmail.com>
Subject: Re: [PATCH] MAINTAINERS: refresh LLVM support
To:     ndesaulniers@google.com
Cc:     Kees Cook <keescook@chromium.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Bill Wendling <morbo@google.com>,
        Justin Stitt <justinstitt@google.com>,
        Tom Rix <trix@redhat.com>,
        Sami Tolvanen <samitolvanen@google.com>,
        Miguel Ojeda <ojeda@kernel.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Nicolas Schier <nicolas@fjasle.eu>, llvm@lists.linux.dev,
        linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 17, 2023 at 8:24=E2=80=AFPM <ndesaulniers@google.com> wrote:
>
> As discussed at the ClangBuiltLinux '23 meetup (co-located with Linux Plu=
mbers
> Conf '23), I'll be taking a step back from kernel work to focus on my gro=
wing
> family and helping Google figure out its libc story. So I think it's time=
 to
> formally hand over the reigns to my co-maintainer Nathan.
>

Hi Nick,

WoW (C)lang(B)uilt(L)inux baby coming soon - your best patch well done!
(  "Catherine Beatrix Luana" might be a good first-name (my
Suggested-by when it's female) ).

> I identify first and foremost as a Linux kernel developer, and an LLVM de=
v
> second. May it be a cold day in hell when that changes.

Of course, I can understand these 3+ years of working on both sides -
Linux kernel and LLVM toolchain - might be very time-consuming and
hopefully with positive stress.
Best luck and more for the new challenges!
...and thanks Google jumped into it.

Thanks for inviting and participating in the First Meetup of
ClangBuiltLinux in Zurich - February 2020.
I see your slogan "Share Knowledge Aggressively" as a life motto :-).

Thanks and more.

Best regards,
-Sedat-
