Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B59E976C28C
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Aug 2023 03:57:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231689AbjHBB5Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Aug 2023 21:57:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231654AbjHBB5W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Aug 2023 21:57:22 -0400
Received: from mail-vk1-xa34.google.com (mail-vk1-xa34.google.com [IPv6:2607:f8b0:4864:20::a34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9158212C
        for <linux-kernel@vger.kernel.org>; Tue,  1 Aug 2023 18:57:15 -0700 (PDT)
Received: by mail-vk1-xa34.google.com with SMTP id 71dfb90a1353d-4865e927e1cso2529488e0c.2
        for <linux-kernel@vger.kernel.org>; Tue, 01 Aug 2023 18:57:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1690941435; x=1691546235;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=du9gT3nEt+eVSe4TYuA1bs7ljCbROmy1XMMZ5PJR5GA=;
        b=Rvd2+4Yywg8ZcmZi2a/qLKRqvq/9yK8B9pk6oqe5l9/Q7ugzflHiUc0ybk95JCYS2a
         E6I4Br5GJfH1OJysf8bzX6KZAXWwnUWY3YWSn/vKEKCMHVQoGwxtSOA702CKmqZPcMlP
         E27uFiGYpPNn/sfcDFalTP9qb+ef5XeFoJHELHbK3nogUsA5TzV8fmwGeDFuDZeGd3Rj
         hd/0LRP5K1O9vZezZoK8QXMT5W56tPfdwktAG4i+H+8XXT4WdjY2a4u0BHLVfImi398Y
         3Zxw/wAhMdowOpwNghl5y9uaxDtxSNxUzKUeyy343KMWryGmEg39pCqDWfZpTmM01i2X
         Xncw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690941435; x=1691546235;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=du9gT3nEt+eVSe4TYuA1bs7ljCbROmy1XMMZ5PJR5GA=;
        b=fDDaALiZcThqsOVkMxrtY/KBpOBqoFzuAeaIC7yZBUXoMi0kJiMncFknEBiDEQY8C1
         UdMLfO1ZmYy9RTNmQVRupkTr0eURpQfG7hpTlK7GxPCU3/vx8P8dg5QJvpIfmvNH+sJR
         O2nKIGQiqMjrOs0HI4ZBA0zlqJ0p3euHzo7rwdSKTTpKhO9DDQit9FinJ+399uWeNJh1
         qyrr1LAskpwQYpfYO17Pr76jZ1e/BNOae265Q8rc+udhjuICpjkvdFtKkLszZWKjq3aV
         p55WExr3/VtjVT9cAa4LrIsE3/JC2PlFx6kVy4Eq3nMID15DDgh3/wy/I79BEgD+nEYT
         R2pA==
X-Gm-Message-State: ABy/qLYViOJhHKYH6yN8Owy8ZD24MQS4bZjpdtvheIYf5Mdm1cNuEnIW
        OxchfDZmZZPVJ/5moIHwTItiJJUO8hVfLXYCPvLMEA==
X-Google-Smtp-Source: APBJJlGWKFhhmL48f26bOfdV+vak3IRD/bcJYZAXm2uQvWL+oHbaEnsw3yuZ6sZ0lfhUB2Nhbw2fFgMEIz/15MCf5W0=
X-Received: by 2002:a1f:5f90:0:b0:46e:85b8:c019 with SMTP id
 t138-20020a1f5f90000000b0046e85b8c019mr4191070vkb.1.1690941434912; Tue, 01
 Aug 2023 18:57:14 -0700 (PDT)
MIME-Version: 1.0
References: <20230801091910.165050260@linuxfoundation.org>
In-Reply-To: <20230801091910.165050260@linuxfoundation.org>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Wed, 2 Aug 2023 07:27:03 +0530
Message-ID: <CA+G9fYtCYSQ2fzmJU0t7ZCOUWjeRp9+Dn3gJ=4oRJP_CJttOcw@mail.gmail.com>
Subject: Re: [PATCH 5.15 000/155] 5.15.124-rc1 review
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
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 1 Aug 2023 at 14:52, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 5.15.124 release.
> There are 155 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Thu, 03 Aug 2023 09:18:38 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.15.124-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.15.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

Following patch caused build regression on stable-rc 5.15 and stable-rc 6.1,

Regressions found on arm:

  - build/gcc-12-orion5x_defconfig
  - build/clang-nightly-orion5x_defconfig
  - build/gcc-8-orion5x_defconfig
  - build/clang-16-orion5x_defconfig

gpio: mvebu: Make use of devm_pwmchip_add
[ Upstream commit 1945063eb59e64d2919cb14d54d081476d9e53bb ]

Build log:
------
drivers/gpio/gpio-mvebu.c: In function 'mvebu_pwm_probe':
drivers/gpio/gpio-mvebu.c:877:16: error: implicit declaration of
function 'devm_pwmchip_add'; did you mean 'pwmchip_add'?
[-Werror=implicit-function-declaration]
  877 |         return devm_pwmchip_add(dev, &mvpwm->chip);
      |                ^~~~~~~~~~~~~~~~
      |                pwmchip_add
cc1: some warnings being treated as errors

Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>

Links:
 - https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-5.15.y/build/v5.15.123-156-gb2c388dc2443/testrun/18771613/suite/build/test/gcc-12-orion5x_defconfig/details/

--
Linaro LKFT
https://lkft.linaro.org
