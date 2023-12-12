Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5CBA480E2DC
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 04:39:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345881AbjLLDii (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Dec 2023 22:38:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229562AbjLLDig (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Dec 2023 22:38:36 -0500
Received: from mail-ot1-x32f.google.com (mail-ot1-x32f.google.com [IPv6:2607:f8b0:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01180AC
        for <linux-kernel@vger.kernel.org>; Mon, 11 Dec 2023 19:38:42 -0800 (PST)
Received: by mail-ot1-x32f.google.com with SMTP id 46e09a7af769-6d9dadc3dc0so3860687a34.1
        for <linux-kernel@vger.kernel.org>; Mon, 11 Dec 2023 19:38:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1702352322; x=1702957122; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=GfR12TX/dwvBcAH+BhtOx1KSZ94OetGmBU0H8LS/sPA=;
        b=t7ZaQx2G0hxpGZS+hI5rz8kMJXO7zVbSfTu1n72b1WO5UfTMX7vaM2fJ5Sd9fTd8cv
         +wdy2kotuUiSBVWsgXJ+ScwxaakTNWJGGx58foV53ntMmr5HtosCL4Yr1U3fsiEtptgK
         +XX3VMKTJ8o77Y1ye7AAHPJLNhj5DQIs5pkaejyIEq2B1Zhm/O3Tj66pAWKxnUVD+c/L
         A1zsEPWI7pN8Xq+KpVHFt1l5xceu6JZC9dzr/61MnsTBTdkKBjfJAeUV2MZ2qwQJcAyR
         JTf2mq/jmiqRuZubjpGDq4r3OwTY+tdBtjM4AWUxXqKO8WQdIxIukTSsbiRTK3vt6G6G
         sSSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702352322; x=1702957122;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GfR12TX/dwvBcAH+BhtOx1KSZ94OetGmBU0H8LS/sPA=;
        b=gPv8Rh2BIPEg+4l7kZVZFw3ALVOyqdBRAQdo4i73Y2pudunsyjiCIFOtYVS+3WwI/s
         uEzkYG73QTWrx276wwIkn+Y1hmY3i+rJORjZGsLwvesFSNQnZd4KkBn4RGGpuZ3kYgz5
         jRIU/X8m4MHj7jN1lZ/BSikNh6xMDF5dU2iv9Z4hWlj0F1KEmwP/iu4qwNvgmxuVldXa
         putZNs/e2JLh9a5R4qmS8rh4wDMMinMrggyHSp+q+1uFwrUaUiGWs18NizRRCGpctfvI
         RFN2FO1h5ZT1wAGjD+eO6alC46ByRtqtttwjNGUeoUmcF6PwjepbfPJA2TFO1EoubYLD
         FWRg==
X-Gm-Message-State: AOJu0YzauhExnRAzhk4VjGdtVwSwy34UYHb5XItFMpm4hx/F1zYj6EDG
        7RKZKpqnvcZlgbsfiJBVSUEbLhqWhOZhLAZ2/xr4Q8gd
X-Google-Smtp-Source: AGHT+IHp9MhyQyyikun064nStAYIA08DlIfICK3A0xryOIlufQLKkDvyKTo5uaCMgB0OOlCdHV/vGQ==
X-Received: by 2002:a05:6830:1e83:b0:6d9:d7b0:b with SMTP id n3-20020a0568301e8300b006d9d7b0000bmr5579222otr.17.1702352322240;
        Mon, 11 Dec 2023 19:38:42 -0800 (PST)
Received: from [192.168.17.16] ([138.84.62.113])
        by smtp.gmail.com with ESMTPSA id v15-20020a05683011cf00b006ce2db9e6c4sm2008714otq.36.2023.12.11.19.38.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Dec 2023 19:38:41 -0800 (PST)
Message-ID: <a2fbbaa2-51d2-4a8c-b032-5331e72cd116@linaro.org>
Date:   Mon, 11 Dec 2023 21:38:39 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5.15 000/141] 5.15.143-rc1 review
Content-Language: en-US
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org
Cc:     patches@lists.linux.dev, linux-kernel@vger.kernel.org,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
        srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org,
        allen.lkml@gmail.com, arnd@arndb.de
References: <20231211182026.503492284@linuxfoundation.org>
From:   =?UTF-8?Q?Daniel_D=C3=ADaz?= <daniel.diaz@linaro.org>
In-Reply-To: <20231211182026.503492284@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

On 11/12/23 12:20 p. m., Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.15.143 release.
> There are 141 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 13 Dec 2023 18:19:59 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.15.143-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.15.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h

We're seeing new warnings with GCC-8 and failures with GCC-12 on x86/i386:

-----8<-----
   In file included from /builds/linux/drivers/gpu/drm/i915/gem/i915_gem_context.c:2291:
   /builds/linux/drivers/gpu/drm/i915/gem/selftests/i915_gem_context.c: In function '__igt_ctx_sseu':
   /builds/linux/drivers/gpu/drm/i915/gem/selftests/i915_gem_context.c:1284:9: error: left shift of negative value [-Werror=shift-negative-value]
       ~(~0 << (hweight32(engine->sseu.subslice_mask) / 2));
            ^~
   cc1: all warnings being treated as errors
   make[5]: *** [/builds/linux/scripts/Makefile.build:289: drivers/gpu/drm/i915/gem/i915_gem_context.o] Error 1
   /builds/linux/drivers/gpu/drm/i915/i915_perf.c: In function 'get_default_sseu_config':
   /builds/linux/drivers/gpu/drm/i915/i915_perf.c:2817:9: error: left shift of negative value [-Werror=shift-negative-value]
       ~(~0 << (hweight8(out_sseu->subslice_mask) / 2));
            ^~
   cc1: all warnings being treated as errors
   make[5]: *** [/builds/linux/scripts/Makefile.build:289: drivers/gpu/drm/i915/i915_perf.o] Error 1
----->8-----

Bisection points to:

   commit 09ebdc1b3dfacc275d5eec3f1dcf632f18bbf5a8
   Author: Arnd Bergmann <arnd@arndb.de>
   Date:   Tue Mar 8 22:56:14 2022 +0100

       Kbuild: move to -std=gnu11
       
       [ Upstream commit e8c07082a810fbb9db303a2b66b66b8d7e588b53 ]


For GCC-12 it's allmodconfig failing, for GCC-8 it's defconfig (i386_defconfig, x86_64_defconfig) just reporting new warnings.

Some reproducers:

   tuxmake --runtime podman --target-arch x86_64 --toolchain gcc-8 --kconfig x86_64_defconfig

   tuxmake --runtime podman --target-arch x86_64 --toolchain gcc-12 --kconfig allmodconfig


Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>

Greetings!

Daniel Díaz
daniel.diaz@linaro.org

