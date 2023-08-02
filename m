Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7DA9576C282
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Aug 2023 03:54:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231597AbjHBByi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Aug 2023 21:54:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230452AbjHBByh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Aug 2023 21:54:37 -0400
Received: from mail-vs1-xe29.google.com (mail-vs1-xe29.google.com [IPv6:2607:f8b0:4864:20::e29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5EBD212A
        for <linux-kernel@vger.kernel.org>; Tue,  1 Aug 2023 18:54:35 -0700 (PDT)
Received: by mail-vs1-xe29.google.com with SMTP id ada2fe7eead31-44779e3e394so1583338137.0
        for <linux-kernel@vger.kernel.org>; Tue, 01 Aug 2023 18:54:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1690941275; x=1691546075;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Il+U9n5lkmGrYzbgPyJy+8Iv+Ld+DI3VHeIjDoz9VUM=;
        b=vSL0H8DTXB0Kmux8lwHUA0+W91duPqgibPyWwXQ6YMB+vb1l4P2S5ewfEHHHnR4WIN
         4DdmLWqkZyUM2yUIa/LA/VGeYSRLQTUtw1HTiMhy+PE9fkfpGO8Nm7rdXYatSGDhEkQs
         imK3HsRUgwVo2eeH+4FjzpfgZzjFzX6kjXTYqGVXAG+DPHsvM5t1n4ujqIUXcznjO4+z
         /ssmOzh6Bp2DD//7d2bf/zApW8dDuKVx+4cYL7TXCRDXXFe2gMeo+n37VFRXZ0uXspqg
         w867U2wDo3tVKXXNxVyumM7zKmroWlSSMHsghwAIiYCqwlP1DCLmqmIgjg8/MARKAcF8
         jhPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690941275; x=1691546075;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Il+U9n5lkmGrYzbgPyJy+8Iv+Ld+DI3VHeIjDoz9VUM=;
        b=FjbSaDFu1Yd4fGP8eETvy3VrnxxqXd2hSPyOEGuvoAHYT83y1LIQnzKaGNE6a0hpv6
         4822SLCTaKJOTURHyVUPUj/T9Tedzue5BwF8mL7cVcr6zUmpOfAjUNEBsxXwOtCvrcmv
         mCBxLtqkhrQO8OYK6zr6ZyMlOlT9Y5RsLBS2Pe+bt2Dr/8D+B70dleT+YytwL46GbpZ6
         BmuGI1szlTlDjV/C+SeP5sjsxk6K+zq4Mn0kd6iUBv0T5lojtwmXdztLC5VfvH0yl+xR
         19AjlnhnbSW29XvvY75GAmgBkkf0+1HHu9UwlEi0L6aEr3+4De64x55rjROYXbaQf5Ay
         FqWA==
X-Gm-Message-State: ABy/qLbnI3SpDHelCyhVRaadYGiFgZbRufy00v/56KfYO9LGYhEncJMs
        Kjk1+Xjqrxfz+QcEygchnAoWOQafaRK+EmBRvoGUrw==
X-Google-Smtp-Source: APBJJlHVwke1xKedtBlG6j6nnQKNFJJs08fE/jID+0Q0nxx/66rdtlH74xRK3FUg7aXspTtHo+zeGBv+Kznh+Q3Z30Q=
X-Received: by 2002:a67:eb92:0:b0:443:6052:43a7 with SMTP id
 e18-20020a67eb92000000b00443605243a7mr3785649vso.32.1690941274911; Tue, 01
 Aug 2023 18:54:34 -0700 (PDT)
MIME-Version: 1.0
References: <20230801091922.799813980@linuxfoundation.org>
In-Reply-To: <20230801091922.799813980@linuxfoundation.org>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Wed, 2 Aug 2023 07:24:23 +0530
Message-ID: <CA+G9fYsqEE6P8vKKvWgFDjpgT64FebUssPNS48n6qfUriu6Z1w@mail.gmail.com>
Subject: Re: [PATCH 6.1 000/228] 6.1.43-rc1 review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     stable@vger.kernel.org, patches@lists.linux.dev,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
        patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
        jonathanh@nvidia.com, f.fainelli@gmail.com,
        sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
        conor@kernel.org,
        =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Andy Shevchenko <andy@kernel.org>,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 1 Aug 2023 at 15:00, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.1.43 release.
> There are 228 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Thu, 03 Aug 2023 09:18:38 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.1.43-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.1.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

Following patch caused build regression on stable-rc 6.1 and 5.15,

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

--
Linaro LKFT
https://lkft.linaro.org
