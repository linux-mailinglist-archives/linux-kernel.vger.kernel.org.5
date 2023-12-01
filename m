Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5EBB800D36
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Dec 2023 15:34:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379173AbjLAOe3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Dec 2023 09:34:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379161AbjLAOe0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Dec 2023 09:34:26 -0500
Received: from mail-oi1-x235.google.com (mail-oi1-x235.google.com [IPv6:2607:f8b0:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9C2310F4
        for <linux-kernel@vger.kernel.org>; Fri,  1 Dec 2023 06:34:31 -0800 (PST)
Received: by mail-oi1-x235.google.com with SMTP id 5614622812f47-3b843fea0dfso329557b6e.3
        for <linux-kernel@vger.kernel.org>; Fri, 01 Dec 2023 06:34:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1701441271; x=1702046071; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fln7JZ3gmS5L0otpWNEVUCaXcYxV9vulN7piRIGYzVQ=;
        b=WP/3yrzwIRguyqCqLf5jCa9eFR2me4nTFrvT2SHfOjNyX3yXgnM7eGjmqCQT+Z8nDH
         EX0Vf268SQPPDdXXFY1T8/9Ac6hoJ7S/47i6VRsOIWomlOur5wq2Hu3Syk4aoWwFZOZR
         hDU0mx771UDd0e/5n2GdVfQuibdK7zx2ZvuG17R/WdRgZc6hcjj1Mq+ZBWz1RdhUgXBy
         40va/WsFokJ0/nartux6RNVNeQHankTIAEiQMA6xhbnqeuIiV8Nh9KNgJ885AHX/2WpM
         NolPGTa5jtNEOI6YABpzplx+nipAWLS9m4E5NF8W0OItNskLBcIsIKRvt2P70qgofc8J
         9TUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701441271; x=1702046071;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fln7JZ3gmS5L0otpWNEVUCaXcYxV9vulN7piRIGYzVQ=;
        b=FOgUF/m7msEcSTWVpGfQXZ32uKTzG4DTvIMB+Wm5OHQsPE6zqwgO4rzhKrqe0pQUIJ
         06hl6t/PZ29JzKXZFzyHd3AC6Bfs0i5GAITnC8ayhtbcij+kscYo6Sbt8iBAgSUe2pN1
         HAroAVH56G3DKpUcnUUbWsVfkM+2syACQEcNQlH/gSsnwMkWu2qXGqtucv/q46AkYaeX
         iCdUr9+H3hMohmlAtskAp2gRLV6d5kBgZESlId8bZYw8kgh+BJ038sbA8MX7jqSeHA/8
         3EyTlhojVzq7mdHspwFHRlbAMKjkq4a6oA5K3IOjsgCYbRheNtKK1TygP2+xc2pUvI6k
         MdIQ==
X-Gm-Message-State: AOJu0Yw4PNYcbE6xgR3kCc3WubzBT1yDgt/Zc4UMHZgJ4VO3++aqmDnL
        PBQGjoxZ1zSJNVNhzfWuz54N3g==
X-Google-Smtp-Source: AGHT+IGlS0ZJiPjHS08tYhuYYizp/NnBi/oTgvFplF5P7lsUqNoJ5XZsvgT8CEP84o377lqBaJlDIw==
X-Received: by 2002:a05:6808:ec6:b0:3b7:73c:ce5f with SMTP id q6-20020a0568080ec600b003b7073cce5fmr3469254oiv.41.1701441271073;
        Fri, 01 Dec 2023 06:34:31 -0800 (PST)
Received: from [192.168.17.16] ([138.84.45.78])
        by smtp.gmail.com with ESMTPSA id k15-20020a54468f000000b003a3860b375esm555786oic.34.2023.12.01.06.34.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 01 Dec 2023 06:34:30 -0800 (PST)
Message-ID: <4cf40ef6-058f-4472-88c9-3dc735175c85@linaro.org>
Date:   Fri, 1 Dec 2023 08:34:26 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5.15 00/69] 5.15.141-rc1 review
To:     Francis Laniel <flaniel@linux.microsoft.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, patches@lists.linux.dev,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
        srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org,
        allen.lkml@gmail.com, Guenter Roeck <linux@roeck-us.net>
References: <20231130162133.035359406@linuxfoundation.org>
 <CAEUSe78tYPTFuauB7cxZzvAeMhzB_25Q8DqLUfF7Nro9WsUhNw@mail.gmail.com>
 <2023120134-sabotage-handset-0b0d@gregkh> <4879383.31r3eYUQgx@pwmachine>
 <2023120155-mascot-scope-7bc6@gregkh>
Content-Language: en-US
From:   =?UTF-8?Q?Daniel_D=C3=ADaz?= <daniel.diaz@linaro.org>
In-Reply-To: <2023120155-mascot-scope-7bc6@gregkh>
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

On 01/12/23 3:44 a. m., Greg Kroah-Hartman wrote:
> Please take some time with a cross-compiler on the above listed
> architectures and configurations to verify your changes do not break
> anything again.

It failed in more architectures than we initially reported. FWIW, this error can be easily reproduced this way:

   tuxmake --runtime podman --target-arch arm     --toolchain gcc-8  --kconfig imx_v4_v5_defconfig
   tuxmake --runtime podman --target-arch arm64   --toolchain gcc-12 --kconfig allmodconfig
   tuxmake --runtime podman --target-arch i386    --toolchain gcc-12 --kconfig defconfig
   tuxmake --runtime podman --target-arch x86_64  --toolchain gcc-12 --kconfig defconfig
   tuxmake --runtime podman --target-arch mips    --toolchain gcc-12 --kconfig allmodconfig
   tuxmake --runtime podman --target-arch parisc  --toolchain gcc-11 --kconfig allmodconfig
   tuxmake --runtime podman --target-arch powerpc --toolchain gcc-12 --kconfig defconfig
   tuxmake --runtime podman --target-arch riscv   --toolchain gcc-12 --kconfig allmodconfig
   tuxmake --runtime podman --target-arch sh      --toolchain gcc-11 --kconfig defconfig
   tuxmake --runtime podman --target-arch sparc   --toolchain gcc-11 --kconfig sparc64_defconfig


Greetings!

Daniel Díaz
daniel.diaz@linaro.org

