Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B47E07A9A3A
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Sep 2023 20:37:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229674AbjIUShf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Sep 2023 14:37:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230174AbjIUSgx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Sep 2023 14:36:53 -0400
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED3BABF102
        for <linux-kernel@vger.kernel.org>; Thu, 21 Sep 2023 11:15:39 -0700 (PDT)
Received: by mail-pg1-x534.google.com with SMTP id 41be03b00d2f7-565e54cb93aso742022a12.3
        for <linux-kernel@vger.kernel.org>; Thu, 21 Sep 2023 11:15:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1695320135; x=1695924935; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=f0A4cf8xaLph2RFxNW2e2zC/ozNHYMpBHiQTWSZDrd4=;
        b=vaFQWQFRQboyjd93z/IzIwa/6PU31P5R3m5s7Z1kwEFA4hxn/od74AXugheRKPem2I
         fd6jpPF/u3bScW1WDBiCL/4ChgA/2c3rg6obpTKm0Hn8vs6RgZ1QcO0+xdNCeN8Nh/G0
         2UDf0PNvXdLgSQxSZmm9xsvwKrhZxSPqJr8mLEKP+/HaetlNEaItDApkrENV3CPu7ohX
         CeU4fo2J6qQvo/9UzZoPdST8+KK13A+sP8JXYd5e8qHZH10G5Qvo3+XfDbMlHV6CzSjW
         FD3RAEHr0O2vX+7kAdxZfLzergBrio3tfmZGwzP4XkQe/cE3ID6hQ/uS1EG02jjY0BXC
         MZSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695320135; x=1695924935;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=f0A4cf8xaLph2RFxNW2e2zC/ozNHYMpBHiQTWSZDrd4=;
        b=Vnw48Oi+KKSdaQxhwoLc/BQPVxPLecW4N2XhRijWJ+TeSaCcOwSxgsyi0ERwnRyhMr
         vveRdKUNKHOeJcaLLSO7Q1e/aqTQf8/d0p6K4GHzDFLhX9+2yIsNLQ9Wcd5ZbSOINFBo
         5kHJ4KToyYwjySAfnV5asinvsJcgmYpeDkm8OBJb5K7qZsJnDLPmPhu7vanbiCHDmjv7
         l9JMBBXvtPElMAH5b98uBlorvBA6R9HAvH17NoFRidT3TBgAJXbW9XBB9uJQfKEPlv4h
         EQkDd1y7TmhwhSmpZOc4nrcnsj6eOzWwI4HdyWOeuUCJgPAaITBTabmufIPl5BE6ha9x
         tiwQ==
X-Gm-Message-State: AOJu0YzMVNLxIsZ9t6+j4JZCsCL22s8D0VTnyY9e2w1aKaGUD/i+rXNU
        3jMeWjh21pWyCK5H8o8JBPBJeNdc+OiSrlTwc10G1lvhoHUnXMyH/mGkXA==
X-Google-Smtp-Source: AGHT+IF6qOrjEY9if7ZapsXGGL1X2pv/FF05y7VvQhm8TwsXueJgwhY8SQCZZx9F8vyaLZqpsJvBOnpMrRr0N4EDD4o=
X-Received: by 2002:a1f:c6c1:0:b0:495:ec90:997e with SMTP id
 w184-20020a1fc6c1000000b00495ec90997emr5200602vkf.7.1695298135191; Thu, 21
 Sep 2023 05:08:55 -0700 (PDT)
MIME-Version: 1.0
References: <20230920112858.471730572@linuxfoundation.org>
In-Reply-To: <20230920112858.471730572@linuxfoundation.org>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Thu, 21 Sep 2023 14:08:44 +0200
Message-ID: <CA+G9fYsM0Lr8TNQJxsZFDZwcH-rEzkVV+y+x5FX18oH5wm5dRg@mail.gmail.com>
Subject: Re: [PATCH 5.4 000/367] 5.4.257-rc1 review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     stable@vger.kernel.org, patches@lists.linux.dev,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
        patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
        jonathanh@nvidia.com, f.fainelli@gmail.com,
        sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
        conor@kernel.org, Sui Jingfeng <suijingfeng@loongson.cn>,
        Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        dri-devel@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DATE_IN_PAST_06_12,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 20 Sept 2023 at 14:25, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 5.4.257 release.
> There are 367 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Fri, 22 Sep 2023 11:28:09 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.4.257-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.4.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

Following build warnings noticed while building arm64 with allmodconfig
on stable-rc 5.4 with gcc-8 and gcc-12 toolchains.

Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>

drivers/gpu/drm/mediatek/mtk_drm_gem.c: In function 'mtk_drm_gem_prime_vmap':
drivers/gpu/drm/mediatek/mtk_drm_gem.c:273:10: warning: returning
'int' from a function with return type 'void *' makes pointer from
integer without a cast [-Wint-conversion]
   return -ENOMEM;
          ^

Links:
 - https://storage.tuxsuite.com/public/linaro/lkft/builds/2VfG47LmPH9MUEuIcMVftu6NsFy/


Following commit is causing this build warning.

drm/mediatek: Fix potential memory leak if vmap() fail
[ Upstream commit 379091e0f6d179d1a084c65de90fa44583b14a70 ]

--
Linaro LKFT
https://lkft.linaro.org
