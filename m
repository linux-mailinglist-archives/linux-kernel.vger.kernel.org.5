Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71CF375D887
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Jul 2023 03:11:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230440AbjGVBLe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jul 2023 21:11:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230031AbjGVBLc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jul 2023 21:11:32 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9A1C35B7
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jul 2023 18:11:31 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id 4fb4d7f45d1cf-51ff0e3d8c1so3316107a12.0
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jul 2023 18:11:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=futuring-girl-com.20221208.gappssmtp.com; s=20221208; t=1689988290; x=1690593090;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=S9g1F7Rjzr2GZN8Ylj8q5DiTwW6elW6eTIsGjXA2qwE=;
        b=W8/NBX/fQk0h61WHQnhGIAgLwxvdqoRs3ZGolIFAs7huJYmCG3Iw1BdplW0SfZRZvK
         X2VUA8rMbK7Pdpqfu2LacqRT0GpbM04s+hPyY4fe3mSe71/6gpopP5yHOPzh7rRU1UxN
         8FI7pBKQY3/4DTwcERKvwdF8zXO14pw203s4yWdJ3EVa+NEajEJbYkgylxfqrYUu3AJL
         vhv7euns8rAKnbv8WWWSPrfAu01BvjsdeBmz4yzn7DZ9ENY7aezn0eu6BazK0aZcZALf
         CGRNs0YuDn2kZrsZBCuJfYG8HuYrXPSqMh/CD/VttskHxDPMRTaFWskVfEWgFphC+Oh7
         XB7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689988290; x=1690593090;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=S9g1F7Rjzr2GZN8Ylj8q5DiTwW6elW6eTIsGjXA2qwE=;
        b=GuLHSfQAf5Zb1EXNq4Tl0lTp+PSQp+l7IhOayWofbienIURiFOb5cU0yCZVmtY7bIM
         Q4GFPdclAfrWUZWyA86MxDm00Ia+ww6d0pPmuhllupclkFZORutd/lxJIfZs6tVcscGs
         S5GhQixEpORJQ8LQr6WbNi2kqBBqUHGoABDfxtmgymYxJCLDreduaFEleL/Se3i/ivKF
         m8kkECgsCByCTJ2QJI4uqAe9d6kunPaEsReOKIxMXAMmL6cJuXEWr87PO48IONEyqgA+
         dcfbWOm4png/zSJlKk5xgUmJinz9V4ch/lP1yH51x1pQTX+CD5eC3JAmiGMW8kQSDhMe
         mlqg==
X-Gm-Message-State: ABy/qLbKpCUqhBoLdwxrpGSHLwtf/g+NL/u14IL0RpEZHUV0XWcfk7um
        r0Z9egRkxxkwpjwkKzUtzEnAoxaDvSPHk3dJsnJFWJrEJC2FbkQ8+dhouA==
X-Google-Smtp-Source: APBJJlFdl7Gy2NFxaQ2Q/BDDG/bXCL3RIEVl+F0rKOtgsdGsjzDfzRw+9jUuvXM2lGmD/gbLwv8GunuG5RXybCoArSE=
X-Received: by 2002:a05:6402:2da:b0:51d:a488:3b3d with SMTP id
 b26-20020a05640202da00b0051da4883b3dmr2472593edx.35.1689988290037; Fri, 21
 Jul 2023 18:11:30 -0700 (PDT)
MIME-Version: 1.0
References: <20230721160520.865493356@linuxfoundation.org>
In-Reply-To: <20230721160520.865493356@linuxfoundation.org>
From:   Takeshi Ogasawara <takeshi.ogasawara@futuring-girl.com>
Date:   Sat, 22 Jul 2023 10:11:19 +0900
Message-ID: <CAKL4bV7r_Of1U7dfiMBN1dkj9Mf0ry0yoCs7Dxu-xyQ-hsdnng@mail.gmail.com>
Subject: Re: [PATCH 6.1 000/223] 6.1.40-rc1 review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     stable@vger.kernel.org, patches@lists.linux.dev,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
        patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
        jonathanh@nvidia.com, f.fainelli@gmail.com,
        sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
        conor@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg

On Sat, Jul 22, 2023 at 4:17=E2=80=AFAM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.1.40 release.
> There are 223 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Sun, 23 Jul 2023 16:04:33 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-=
6.1.40-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-6.1.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

6.1.40-rc1 tested.

Build successfully completed.
Boot successfully completed.
No dmesg regressions.
Video output normal.
Sound output normal.

Lenovo ThinkPad X1 Carbon Gen10(Intel i7-1260P(x86_64) arch linux)

Thanks

Tested-by: Takeshi Ogasawara <takeshi.ogasawara@futuring-girl.com>
