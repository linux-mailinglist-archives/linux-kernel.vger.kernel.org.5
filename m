Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02B5E7DDD61
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Nov 2023 08:44:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231795AbjKAHn5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Nov 2023 03:43:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231947AbjKAHny (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Nov 2023 03:43:54 -0400
Received: from mail-vk1-xa2a.google.com (mail-vk1-xa2a.google.com [IPv6:2607:f8b0:4864:20::a2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4A25C2
        for <linux-kernel@vger.kernel.org>; Wed,  1 Nov 2023 00:43:48 -0700 (PDT)
Received: by mail-vk1-xa2a.google.com with SMTP id 71dfb90a1353d-49618e09f16so2582474e0c.2
        for <linux-kernel@vger.kernel.org>; Wed, 01 Nov 2023 00:43:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1698824627; x=1699429427; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=o326kRv6U2+ln56Jt/MYDAHMNlJTSIjb+AyTX5/qVok=;
        b=FqqhvICAdxrR/bAQIKWieBRNAozNHoaFoy7N9KP9mUH/mntPjeE3ae8CiuYiqwDbmM
         XP4RaTzsMWiOShCPpW5lAubg/7wmzd7XZ4lIenY6SaINmMIE9LUwmxCS4jKsIXsRNETY
         ++W6HCOiE+ySXu+/a2bFfXljPWFaKI99zXw2aPovybAyxiw7aXeK0Plife/DvSSz/7gE
         WDPT/1TYVqJFUDk7y8lfceMbIZ+tAlBVyTcDDzOlNBCjyOR7w0bYkF9NijxMc65TVeGe
         jkJH144cDN4/gdLsq3W/VVFFjdt6jCcWxpna+K1Cx+g3EXEG6LvZj74Mqtdkbkz+C/vk
         F9+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698824627; x=1699429427;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=o326kRv6U2+ln56Jt/MYDAHMNlJTSIjb+AyTX5/qVok=;
        b=kr2ajK5xVsnAaR6ZhWzKU1pLUEr7MmqkpGozPoHBunO8Ij3Czsx9XaOnhlzUAPqTyx
         eRXfheJKRZRnmvBxVTUbLp691clYSPj/DwuZYnJMYqeEYeyaTdaXhMbrkOyUkqjJ3J+B
         uz4RPHby3HCoPmocIgKfuyZ9FIIiTKDmX0FyNnNXOfvAaLYS9/K/YWb2Y5O756DvVD1c
         nm1s962OQZhHKEHc5Twc3EvifXu5evEM7A+/B9Ay3bOVAv6wtAELFlnrMYDDX/xmYduF
         j4DHJT7WhApxjko7ZKtmFihmIfHX4lh13+f8YAHbbAl1g/eJ0y5mKR3WZJJEHYqMafaR
         2iQw==
X-Gm-Message-State: AOJu0YxJ0dcGxUrrFB85GA/tscQfk9FFlu6KXVVQVcc9TXoFviSRU0S2
        juR0jZd0GmCbQRJDJN5bfLJn4X/u3hjMeoVVBvHjPQ==
X-Google-Smtp-Source: AGHT+IFn3LGbnhJgUHon1Qrj2iYMBd9vIZpHUDasLkNig6UIZDiIb8D4aXIR1PweykwfXhCvN8gmudyh11ujhfzYAYM=
X-Received: by 2002:a1f:ab0b:0:b0:4a4:680:bfad with SMTP id
 u11-20020a1fab0b000000b004a40680bfadmr13344693vke.7.1698824627486; Wed, 01
 Nov 2023 00:43:47 -0700 (PDT)
MIME-Version: 1.0
References: <20231031165901.318222981@linuxfoundation.org> <38fbd463-1160-0212-b9d2-6efeaaa6548e@w6rz.net>
In-Reply-To: <38fbd463-1160-0212-b9d2-6efeaaa6548e@w6rz.net>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Wed, 1 Nov 2023 13:13:35 +0530
Message-ID: <CA+G9fYtSAX+aPUvUShSvb=LOAsQBEMfxRVAi0CJ-PD+SiQLPwg@mail.gmail.com>
Subject: Re: [PATCH 6.5 000/112] 6.5.10-rc1 review
To:     Ron Economos <re@w6rz.net>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, patches@lists.linux.dev,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
        patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
        jonathanh@nvidia.com, f.fainelli@gmail.com,
        sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
        conor@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 1 Nov 2023 at 04:21, Ron Economos <re@w6rz.net> wrote:
>
> On 10/31/23 10:00 AM, Greg Kroah-Hartman wrote:
> > This is the start of the stable review cycle for the 6.5.10 release.
> > There are 112 patches in this series, all will be posted as a response
> > to this one.  If anyone has any issues with these being applied, please
> > let me know.
> >
> > Responses should be made by Thu, 02 Nov 2023 16:58:38 +0000.
> > Anything received after that time might be too late.
> >
> > The whole patch series can be found in one patch at:
> >       https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-=
6.5.10-rc1.gz
> > or in the git tree and branch at:
> >       git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-6.5.y
> > and the diffstat can be found below.
> >
> > thanks,
> >
> > greg k-h
>
> The build fails on RISC-V.
>
> arch/riscv/mm/hugetlbpage.c: In function =E2=80=98set_huge_pte_at=E2=80=
=99:
> arch/riscv/mm/hugetlbpage.c:188:13: error: =E2=80=98sz=E2=80=99 undeclare=
d (first use in
> this function); did you mean =E2=80=98s8=E2=80=99?
>    188 |         if (sz >=3D PGDIR_SIZE)
>        |             ^~
>        |             s8
> arch/riscv/mm/hugetlbpage.c:188:13: note: each undeclared identifier is
> reported only once for each function it appears in
>
> Caused by commit 16b6f77970f7a690c61de142511c9ac488d83e04
>
> riscv: fix set_huge_pte_at() for NAPOT mappings when a swap entry is set

The above build error was also noticed in our CI system.

> This patch requires mainline commit 62ba41d2761206664a1fdc998051324457da2=
dd6
>
> mm: riscv: fix an unsafe pte read in huge_pte_alloc()
>

Following riscv builds failed as other reported.
riscv:
  * build/clang-nightly-defconfig
  * build/clang-17-lkftconfig
  * build/clang-17-defconfig
  * build/gcc-13-defconfig
  * build/gcc-13-lkftconfig
  * build/gcc-8-defconfig

Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>

--
Linaro LKFT
https://lkft.linaro.org
