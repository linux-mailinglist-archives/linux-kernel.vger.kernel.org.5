Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BCF027785F8
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Aug 2023 05:22:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229707AbjHKDWR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 23:22:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229568AbjHKDWO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 23:22:14 -0400
Received: from mail-vs1-xe2e.google.com (mail-vs1-xe2e.google.com [IPv6:2607:f8b0:4864:20::e2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 423C62D66
        for <linux-kernel@vger.kernel.org>; Thu, 10 Aug 2023 20:22:13 -0700 (PDT)
Received: by mail-vs1-xe2e.google.com with SMTP id ada2fe7eead31-4476f713e15so635895137.3
        for <linux-kernel@vger.kernel.org>; Thu, 10 Aug 2023 20:22:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1691724132; x=1692328932;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=KkEumRtohfNhdpoDJhISnRDZoUTmKUHTcuDpxxAC/Sg=;
        b=Eo5nhrXDsAnH1q7CsKSmGOuuVDevVflsD5wtRA8azJF2t/k6TG2IiHq8J2hQzNem+D
         yWipkJzcdPI5UI0uM5M3jBMnJJ4GzDgMIHKCoFZHGv+2TAxecoaMqYY4zmSJ0dFyhvPw
         cWi1oBa1/J16JenF5yU7gFwxGmVkLi6PlDO7nnUOkF+Mxkc+u9WNLCe0PsdTxP8Ft70y
         7ksHt0DbT9R1vl2m1AURytAIF+KEMCSC5iGnXQ+09B/z7l0+S8YeUWnkGvrbTFG2/uSo
         8N0PZv6Ekp0ZdPwKVsTEjpp56aCr1nSjZugxapRQkdeiZBXUnOM9mR09xAT3FQ071f1H
         D7Lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691724132; x=1692328932;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KkEumRtohfNhdpoDJhISnRDZoUTmKUHTcuDpxxAC/Sg=;
        b=Gud/hrAqIlYjWZvIhzH59X7vGOotq/QsdHNo6NO94voUjThsxmd9nV0KnTatqxNYHv
         O4jcZLy+jAJ+NcVHX4hS9va91VhZ+T29zreddi7vumpF4Z1KL7RkWmwUgRXRWbN4qc8u
         bhRtwd3EGnEuyqJzmpqHb4EO20th5HtflxAgztQIfowreOLhZbv3pI34W6tLKItw3tfJ
         dy5Jzg/9m8qElw5lNgYRsX4f9q11jz1/N48OkrFSisR9r1hLw3rCDiTREZML43H9rCZO
         jKmh8CB1mKTaG3x5HhFRcI4RPenSPB+wIQiB96zAhAusOJJDBYs0fdY23A1LxtvE10cK
         Gf3g==
X-Gm-Message-State: AOJu0Yy8YE3MPcOBR3U1NT0Q71Pf3UbCb/L7q/AcA1xV2/Rxy+2uXerS
        hVpzbYHMixu3xjvVkfkjpyHoB3xnRL41XZidCtbu5Q==
X-Google-Smtp-Source: AGHT+IGU2fdD5KxBGFfmZ5YbVmA1pRJtMv3ZrL5R8YMkBxBVSZmyFFNwjjWgXkEN553/+Et76M4Xg8624ZbdFTF4TIY=
X-Received: by 2002:a05:6102:3d4:b0:447:4b52:5c8 with SMTP id
 n20-20020a05610203d400b004474b5205c8mr576067vsq.26.1691724132286; Thu, 10 Aug
 2023 20:22:12 -0700 (PDT)
MIME-Version: 1.0
References: <20230809103636.615294317@linuxfoundation.org>
In-Reply-To: <20230809103636.615294317@linuxfoundation.org>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Fri, 11 Aug 2023 08:52:01 +0530
Message-ID: <CA+G9fYvQdQqTqCgbS4sit_Y2AtKtDiWMOkGZjoeSEFhc=M_jKw@mail.gmail.com>
Subject: Re: [PATCH 6.1 000/127] 6.1.45-rc1 review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        clang-built-linux <llvm@lists.linux.dev>
Cc:     stable@vger.kernel.org, patches@lists.linux.dev,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
        patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
        jonathanh@nvidia.com, f.fainelli@gmail.com,
        sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
        conor@kernel.org, Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Sven Volkinsfeld <thyrc@gmx.net>,
        Daniel Kolesa <daniel@octaforge.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 9 Aug 2023 at 16:21, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.1.45 release.
> There are 127 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Fri, 11 Aug 2023 10:36:10 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.1.45-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.1.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h


While building Linux stable rc 6.1 x86_64 with clang-17 failed due to
following warnings / errors.

Regressions found on x86_64:

  - build/clang-nightly-lkftconfig-kselftest
  - build/clang-nightly-x86_64_defconfig
  - build/clang-nightly-lkftconfig
  - build/clang-lkftconfig
  - build/clang-nightly-allmodconfig


Build errors:
-----
ld.lld: error: ./arch/x86/kernel/vmlinux.lds:193: at least one side of
the expression must be absolute
make[2]: *** [scripts/Makefile.vmlinux:34: vmlinux] Error 1


  Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>

upstream report:
-----
    - https://lore.kernel.org/llvm/CA+G9fYsdUeNu-gwbs0+T6XHi4hYYk=Y9725-wFhZ7gJMspLDRA@mail.gmail.com/

Proposed fix patch:
-----
  [PATCH] x86/srso: fix build breakage for LD=ld.lld
  - https://lore.kernel.org/lkml/20230809-gds-v1-1-eaac90b0cbcc@google.com/T/

This patch is yet to be backported and CC to stable.

  --
Linaro LKFT
https://lkft.linaro.org
