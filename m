Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A0B3783001
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Aug 2023 20:10:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237104AbjHUSKd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Aug 2023 14:10:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237094AbjHUSK3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Aug 2023 14:10:29 -0400
Received: from mail-oa1-x2e.google.com (mail-oa1-x2e.google.com [IPv6:2001:4860:4864:20::2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F7DD114
        for <linux-kernel@vger.kernel.org>; Mon, 21 Aug 2023 11:10:28 -0700 (PDT)
Received: by mail-oa1-x2e.google.com with SMTP id 586e51a60fabf-1c0fa9dd74fso2399641fac.3
        for <linux-kernel@vger.kernel.org>; Mon, 21 Aug 2023 11:10:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1692641427; x=1693246227;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dF6rxD+ZkHyNq/ltHpWvUanV1plOfqlbq7nLdiifj/c=;
        b=UsZjS99KVCX6avIBGy32ovoxhZYlwbMG6sxkQdHFe5+1fGSl0JDE8OHZwLKzH2Aa+z
         /kvZrnHUH76NceJsqbQmIpVRr3srALaBS9Eq5iAfAVV+6ZH9YQh75qYv26lK1du8dxbs
         uwSJNn6HftiHIDfv/m/PBVZm+d7Y/RPhxN+JMkJvyhEZKryFT5YjOJLFAaThMgi7nZJb
         /EbBBENjwJ+xg5dLS28lVmTlDHSgLcrnn66PqQ+y3Z0XcmXB7kTOvdq4GP8kHoVL0Xa9
         AC87EMaUilGmyDKUJ1r7MZBdrYd3PlUDh+GMpTGgiPsjgY4ReWqfZIhtXA3acBGhIwf3
         PITQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692641427; x=1693246227;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dF6rxD+ZkHyNq/ltHpWvUanV1plOfqlbq7nLdiifj/c=;
        b=kOQSOJ2PHK0Z686BGBeb17Z26uDhs5TYUh9Lcqn5HZk+3/YyxCc//DWRAIQCzcR7hE
         ZJ6sC1xYysw4hF1QcsLnyA7S16D95R4aLrJ34uxt071/yPWKJFawuIG508wSGks/RtyU
         ate5G5qFehBNNuGNwEMaE4MjFoJYrLLx4IRc+ad8yRWBPsOX0cf3AM2+po24yMkmfYhW
         LTa2reRNhNhyq+FgeNiwB18erIFZesFVHpgbeIk0y3RLIzxrttDRrbhwQC/bStQb3ReJ
         oqx1awnOalpLCiCatCRv7CTB520vjpTp2F4W0nDD8Hw15bbe4OXV+GWRlrbo20t+/PF5
         wd4g==
X-Gm-Message-State: AOJu0YxhOT3kd8MlBz9Hlkt79mymxLEhqgc2l+cQROqaCjhBPKtMuPZ4
        PMoGqsf5wSAofnofdHwsGwnDZ+weS4jdQCVLpuIhPA==
X-Google-Smtp-Source: AGHT+IEkF8SKAy0eWsCodQOtnaef5xNdxImXVaiIDx8VyX01r+4IxF35/Fqn16U/grcbCUgCEWldlnHFINGB53bX7M0=
X-Received: by 2002:a05:6870:b30a:b0:1b0:653a:af92 with SMTP id
 a10-20020a056870b30a00b001b0653aaf92mr10954978oao.8.1692641427159; Mon, 21
 Aug 2023 11:10:27 -0700 (PDT)
MIME-Version: 1.0
References: <CA+G9fYvFD-kE0+EGWkwcnR1DXRxh7p7OwQThJ6KWxYWVROJ4+A@mail.gmail.com>
 <CAKwvOd=h4aFisiY0w0awKkxk+i-aJM5+QbExYnboqzojLigx1Q@mail.gmail.com>
 <CA+G9fYtRMde7Ksswa8pY8sFgnWVN-snRHfz4YRM04HSQ4LFBZQ@mail.gmail.com> <CA+G9fYuRy_yJ0Fa1hxt4iPZvgw+qvdvXmqWtFV-rDME+pCdXiA@mail.gmail.com>
In-Reply-To: <CA+G9fYuRy_yJ0Fa1hxt4iPZvgw+qvdvXmqWtFV-rDME+pCdXiA@mail.gmail.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Mon, 21 Aug 2023 11:10:16 -0700
Message-ID: <CAKwvOd=B3na1Dsg7ATqRa7rwD030SVd6tR6G555Y6Q7t-8yLaw@mail.gmail.com>
Subject: Re: landlock: fs_test: fs_test.c:4524:9: error: initializer element
 is not a compile-time constant
To:     Naresh Kamboju <naresh.kamboju@linaro.org>
Cc:     clang-built-linux <llvm@lists.linux.dev>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>, linux-fsdevel@vger.kernel.org,
        lkft-triage@lists.linaro.org, Shuah Khan <shuah@kernel.org>,
        Anders Roxell <anders.roxell@linaro.org>,
        =?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>,
        Richard Weinberger <richard@nod.at>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-14.3 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_SBL_CSS,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 21, 2023 at 7:20=E2=80=AFAM Naresh Kamboju
<naresh.kamboju@linaro.org> wrote:
>
> On Fri, 18 Aug 2023 at 10:48, Naresh Kamboju <naresh.kamboju@linaro.org> =
wrote:
> >
> > On Thu, 17 Aug 2023 at 21:24, Nick Desaulniers <ndesaulniers@google.com=
> wrote:
> > >
> > > On Thu, Aug 17, 2023 at 3:51=E2=80=AFAM Naresh Kamboju
> > > <naresh.kamboju@linaro.org> wrote:
> > > >
> > > > While building selftests landlock following warnings / errors notic=
ed on the
> > > > Linux next with clang-17.
> > > >
> > > > Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>
> > > >
> > > > Build errors:
> > > > ------------
> > > > landlock/fs_test
> > > > fs_test.c:4524:9: error: initializer element is not a compile-time =
constant
> > >
> > > Hi Naresh,
> > > Can you tell me more about your specific version of clang-17?
> >
> >     compiler:
> >         name: clang,
> >         version: 17.0.0,
> >         version_full: Debian clang version 17.0.0
> > (++20230725053429+d0b54bb50e51-1~exp1~20230725173444.1)

Ok, decoding that we have 2023-07-25...

> >
> > >
> > > I believe a fix of mine to clang should address this. It landed in
> > > clang-18, and was backported to clang-17 recently.
> > > https://github.com/llvm/llvm-project-release-prs/commit/0b2d5b967d983=
75793897295d651f58f6fbd3034

And the backport (that sha above) landed 2023-08-03 so that checks
out.  So yes, the initial report was missing the fix that landed more
recently.

> > >
> > > I suspect your clang-17 might need a rebuild.  Thanks for the report.
> >
> > I will rebuild / re-test and confirm soon.
>
> LKFT team re-built containers and I have re-tested the builds
> and reported build issues has been fixed.
>
> Thank you !

Awesome, thanks for the report and retesting to confirm.

>
> Best regards
> Naresh Kamboju



--=20
Thanks,
~Nick Desaulniers
