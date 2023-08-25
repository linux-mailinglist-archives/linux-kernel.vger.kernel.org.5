Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F16F7882EF
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Aug 2023 11:03:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244103AbjHYJC1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Aug 2023 05:02:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241549AbjHYJBm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Aug 2023 05:01:42 -0400
Received: from mail-ua1-x932.google.com (mail-ua1-x932.google.com [IPv6:2607:f8b0:4864:20::932])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFBA21BCD
        for <linux-kernel@vger.kernel.org>; Fri, 25 Aug 2023 02:01:40 -0700 (PDT)
Received: by mail-ua1-x932.google.com with SMTP id a1e0cc1a2514c-79df1303d01so255013241.0
        for <linux-kernel@vger.kernel.org>; Fri, 25 Aug 2023 02:01:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1692954100; x=1693558900;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=5jNuKDvps1sCglmF+du8pTIMXdA0xOQsyQ7wJHt387U=;
        b=dRh1yZm5f1GtDEAbEEFlfLZv71IsDsgFV5YA4nNBbJZNV/fVusCF98/XSOm+wzvUjR
         ofKDEA7/EhgJtKxjEzFhNli5eBgOts8x1fmk4wVSwOtLQI3BUUKXUgQLA7mN10bAk8Q5
         rXJtch37IrkLvP0g4+tg6bBEmE1/EAZ0yncK9qBy4IyafOMeVmFBLg3RJbuGLLChpTNX
         xv5BBSKgwD0r/4XHBLet9l0rke885nf7vcbAzsZK0NvJr/Yz/UeANYSqZbn/7FzWmbEJ
         H5Jgpezf5xGNhH6++Do6DnyZeCwc7OE/KaQp0ADE3B60HfS+AZJJTid6LwE2pFdyv9ut
         HXnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692954100; x=1693558900;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5jNuKDvps1sCglmF+du8pTIMXdA0xOQsyQ7wJHt387U=;
        b=FiU4PY9HE+VAxN3FZ6d+Ffr982neGkBhy39qELJG+OjBglPqxEoC0YLC3FVkOlaSvo
         Yifntl3t6h+7RNr1MPPAe4scm0ZNwBjiJknvoZGe4JfyuB/8COn6BL+FefrU+0izRI7B
         A51qmOsfv+kaPybdPcNXTUUnN0tU3N2W4+CWJff3FeLKTxJ8HcpfmDlLZwc2EE1dXJqs
         OsUVQV0VYNEH6yo0gffbvLbDuAnMHYB2z1RgsxzQfDGGi/d13f8spewexlmJzClPuSoh
         8NJjQRL+GgAQh5HvV+rj05Xqh5bkN98QjKcjQsTWdGtsH3KxYkX+RAEwcv7iJyUO9qUK
         R6uw==
X-Gm-Message-State: AOJu0Yy/APZqIMCphJuT1+tEJy+4sk2wNBMp9HcJYjABtnP9uOT3RAtB
        EXVCuZDuY5DTCgWkCNEg2r27EhAL3DdV2v3/Pc1rkA==
X-Google-Smtp-Source: AGHT+IEJcfxsajOw74cjTxoMx2fHBxxKcjfQHizvKpxsbPs4XlMbrQOO4qXPBTRhrTUQWN0KTliv//ujTUEwqUGRxZ4=
X-Received: by 2002:a67:f74e:0:b0:44e:92dc:7f12 with SMTP id
 w14-20020a67f74e000000b0044e92dc7f12mr5671775vso.30.1692954099757; Fri, 25
 Aug 2023 02:01:39 -0700 (PDT)
MIME-Version: 1.0
References: <20230824170617.074557800@linuxfoundation.org>
In-Reply-To: <20230824170617.074557800@linuxfoundation.org>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Fri, 25 Aug 2023 14:31:28 +0530
Message-ID: <CA+G9fYtVDzeAKWLmLOuBWcKzK62+qWYAvpUyp4TqTGKfHKFb+A@mail.gmail.com>
Subject: Re: [PATCH 5.10 000/135] 5.10.192-rc1 review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     stable@vger.kernel.org, patches@lists.linux.dev,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
        patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
        jonathanh@nvidia.com, f.fainelli@gmail.com,
        sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
        conor@kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 24 Aug 2023 at 22:47, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 5.10.192 release.
> There are 135 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Sat, 26 Aug 2023 17:05:50 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.10.192-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.10.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h


The same test regressions found on stable-rc linux.5.10.y as reported
on stable-rc linux.6.1.y and linux.5.15.y branch. LTP syscalls chown02
and fchown02 fails on arm64 Rpi4 device with the NFS rootfile system.

Test log:
--------
chown02.c:46: TPASS: chown(testfile1, 0, 0) passed
chown02.c:46: TPASS: chown(testfile2, 0, 0) passed
chown02.c:58: TFAIL: testfile2: wrong mode permissions 0100700, expected 0102700

fchown02.c:57: TPASS: fchown(3, 0, 0) passed
fchown02.c:57: TPASS: fchown(4, 0, 0) passed
fchown02.c:67: TFAIL: testfile2: wrong mode permissions 0100700,
expected 0102700

NOTE:
Do we need a backport for this patch ?

  nfsd: use vfs setgid helper
    commit 2d8ae8c417db284f598dffb178cc01e7db0f1821 upstream.

## Build
* kernel: 5.10.191-rc1
* git: https://gitlab.com/Linaro/lkft/mirrors/stable/linux-stable-rc
* git branch: linux-5.10.y
* git commit: da59b7b5c515edab9a57efd37b031b5b97e6c1cc
* git describe: v5.10.190-136-gda59b7b5c515
* test details:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-5.10.y/build/v5.10.190-136-gda59b7b5c515

## Test Regressions (compared to v5.10.191)
* bcm2711-rpi-4-b, ltp-syscalls
  - chown02
  - fchown02

* bcm2711-rpi-4-b-clang, ltp-syscalls
  - chown02
  - fchown02

--
Linaro LKFT
https://lkft.linaro.org
