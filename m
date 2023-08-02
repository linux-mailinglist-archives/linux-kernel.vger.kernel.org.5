Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2373C76D4B5
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Aug 2023 19:09:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231370AbjHBRJH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Aug 2023 13:09:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229541AbjHBRJE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Aug 2023 13:09:04 -0400
Received: from mail-ot1-x32c.google.com (mail-ot1-x32c.google.com [IPv6:2607:f8b0:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 119BA1A5;
        Wed,  2 Aug 2023 10:09:04 -0700 (PDT)
Received: by mail-ot1-x32c.google.com with SMTP id 46e09a7af769-6bc9254a1baso74820a34.2;
        Wed, 02 Aug 2023 10:09:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690996143; x=1691600943;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VzgOK7S/nDkSxIWVLP6Niz2nC5TbUp6AvvmSTjYDoz0=;
        b=fPw/kdvfhtWEf4UBlljKxHTeCnXzAczix4g5kutrq7CH0rJnQKdQVspzYFHMZDDs/T
         G/JNOATOQJoDlFrS7qbXFyw97Sar/IhQAYWdjudC/9i0EmPT/+spzXX9oaLLM++MaELe
         s+HfTuVyDtdxU4dU3ngRnCLrjDPUyPH4TtLUuB9tVg0SSLVtb4EyLyRyuAbnpKBGzUol
         PxpK86twd7NPi9GzrENjM4dy5nTMYz06aj3adfEymnxYaBxlEWUj3LpiJUyMrESIKBVi
         dMM/u7xvWZQlPRKFDqFayN7aTgTy5DCS2vs0lYi/a1MgFmntRe+Fe0kJaVRT8CMYkS/J
         FNGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690996143; x=1691600943;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VzgOK7S/nDkSxIWVLP6Niz2nC5TbUp6AvvmSTjYDoz0=;
        b=Svije5ZSQ296NH9PP4qWgh9uqBwZFoXYQazDpfXdKwmLYusSSQJgIHK52GZ13B80zp
         UN7ds2Mqe/rDnwZZzjpcPLYaO9HWUEOkdU4ETdPlqPkRQAmKy/q2XGDmSo33sWuD3hsm
         /MIvSDzbwZXzo+BjePNZE94Zftf2Fsf0saS/BSWTvyPEU905k0siYVuYEaJjeWckLaV4
         W0y1D+OrAtn3a9P1HYL+dt1dGOx4kvyq3oF5cQblyYVIeXY8efw4J1ew7ix+3aWe7TVG
         4BUzZR2J9B4/c51PR/mjDu5+IEUtoqwoh34RUpBgNW/XvNwqNnwyaToKWXIrIdbnrG99
         CjhQ==
X-Gm-Message-State: ABy/qLZFQL93kWCbjhBMkmyaYccrNIDUC6OFCrGqs3kZRhHxvkxwV0fL
        PuCzdSvwxexLcgLG9eFwavsXmCENII4esNrcC5I=
X-Google-Smtp-Source: APBJJlEunU1vMsI7Ba5iPzVifoTkFdqWTVRlsIl1b3LmpG0allJXwK4ZcEhL9CUMO+GM4B+HRL4Vd9l6rafbjWpjMjs=
X-Received: by 2002:a9d:7a41:0:b0:6b9:482e:ed10 with SMTP id
 z1-20020a9d7a41000000b006b9482eed10mr18099228otm.21.1690996143376; Wed, 02
 Aug 2023 10:09:03 -0700 (PDT)
MIME-Version: 1.0
References: <20230802150712.3583252-1-elver@google.com> <CANpmjNPVO_t058c6Wcwr9TBwxeoH7Ba0ECsf6Wapn60br8EtkQ@mail.gmail.com>
In-Reply-To: <CANpmjNPVO_t058c6Wcwr9TBwxeoH7Ba0ECsf6Wapn60br8EtkQ@mail.gmail.com>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Wed, 2 Aug 2023 19:08:51 +0200
Message-ID: <CANiq72k7_Ujg31UHfivv8zyog-6Vs7YehTpk2y-qRiuT-KMmAw@mail.gmail.com>
Subject: Re: [PATCH 1/3] Compiler attributes: Introduce the __preserve_most
 function attribute
To:     Marco Elver <elver@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Kees Cook <keescook@chromium.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Marc Zyngier <maz@kernel.org>,
        Oliver Upton <oliver.upton@linux.dev>,
        James Morse <james.morse@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Zenghui Yu <yuzenghui@huawei.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Miguel Ojeda <ojeda@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Tom Rix <trix@redhat.com>,
        linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev,
        Dmitry Vyukov <dvyukov@google.com>,
        Alexander Potapenko <glider@google.com>,
        kasan-dev@googlegroups.com, linux-toolchains@vger.kernel.org,
        Mark Rutland <mark.rutland@arm.com>,
        Peter Zijlstra <peterz@infradead.org>
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

On Wed, Aug 2, 2023 at 6:51=E2=80=AFPM Marco Elver <elver@google.com> wrote=
:
>
> Mark says that there may be an issue with using this in combination
> with ftrace because arm64 tracing relies on AAPCS. Probably not just
> arm64, but also other architectures (x86?).
>
> To make this safe, I'm going to move __preserve_most to
> compiler_types.h and always pair it with notrace and some comments in
> v2.

Sounds good, thanks! The patch here was otherwise good in terms of
`compiler_attributes.h`.

I was also thinking about the implications for Rust. I guess if we
need to call them, we will go through a C helper for the moment, and
later on if we get cross-language LTO (or the LLVM IR hacks), it will
hopefully not be a performance penalty.

Cheers,
Miguel
