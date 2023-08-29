Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 200E278BD1E
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Aug 2023 05:02:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233762AbjH2DC1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Aug 2023 23:02:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233583AbjH2DBu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Aug 2023 23:01:50 -0400
Received: from mail-oo1-xc2f.google.com (mail-oo1-xc2f.google.com [IPv6:2607:f8b0:4864:20::c2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0519E10C
        for <linux-kernel@vger.kernel.org>; Mon, 28 Aug 2023 20:01:47 -0700 (PDT)
Received: by mail-oo1-xc2f.google.com with SMTP id 006d021491bc7-57354433a7dso1631222eaf.1
        for <linux-kernel@vger.kernel.org>; Mon, 28 Aug 2023 20:01:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1693278106; x=1693882906;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=D5rw8PU4MLe4UjShUw3LXe+vB86DdsSYaP+ghtZws/w=;
        b=Om/imUt6v85D7tXVu75ho/1nRdM1AinjiyuB9uH8IUgSOtsB1BM7L6xiVqpH1Jjq+w
         CIA8jrT4J54nkjgNhVoLR/QmlwrFb6Hy6yLAC/FLuM3LfQbKfkJqSgLD5moBlZvx2ASa
         qTfJqssKTP1f0xFRrqqE4sgvT0t3MkGWLCu2kC5NZDtj9qlgZ1q/XWCvMNqdsIMh9WQY
         YCJlzPaFd+hG4rOhFMBYcBw5Qym97e5QHYKibWIu8r+bg8rGcw59Q7ef+m59H6pDpx25
         ybvN2TljBwPjxHZacLx2f04dApyBZMnOX6YU0vmd/QjYi2v56BFLaUkS+ao5ia0P8CH8
         /zEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693278106; x=1693882906;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=D5rw8PU4MLe4UjShUw3LXe+vB86DdsSYaP+ghtZws/w=;
        b=J2eSQ8GXN8TyHK9zxy6jMD2T0McoEKah46J/yfSGWgOof9lCtuCagRUdmQvbMPyAlm
         VZESgG6RP/zMOBgPUoNQChyc0wIDC9/wo+M5wZJA4X6vh3feRNupKtu9V6j0OEPGtesl
         iauJchDAB1lp7uSsB9IHfWrZ5IcmCKY/1jO4/1PnYCL/ZzNXP20hPIfwSmEGwwz6CSJD
         /qE4Uncj7bU1+uCyR9dAViVfuBeXqx8MUM5fhncnuR5A+6/nQPW9215BiS47/haBgZSH
         zo7PlVgGzy3Yhnu3+knjUPUMtTe3sjn4P8Ph+kvKAa9ySRw9eFp/Ws6vaF8tjtObllvQ
         pMfw==
X-Gm-Message-State: AOJu0Yz10oVrppVlv8CpK7VvcGkihe5KxUHiFhR8NNzdiHd0idkcZ2Wz
        wCuY0/h0gumCLIVg0xbRpJeEfg==
X-Google-Smtp-Source: AGHT+IGUySozNNm6SNEiVWhhfJeY00gXvZg2x0BAmIH2AU8UpQrCsM3f0aY9YUY9gBPTJNSDf9g9cg==
X-Received: by 2002:a4a:6c13:0:b0:571:1fad:ebd7 with SMTP id q19-20020a4a6c13000000b005711fadebd7mr11635350ooc.7.1693278106207;
        Mon, 28 Aug 2023 20:01:46 -0700 (PDT)
Received: from [192.168.17.16] ([138.84.45.150])
        by smtp.gmail.com with ESMTPSA id b25-20020a9d6b99000000b006bee51de9f6sm4075630otq.18.2023.08.28.20.01.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Aug 2023 20:01:45 -0700 (PDT)
Message-ID: <868cd8e3-2e7e-7b98-0a6e-e5586cb6ab0d@linaro.org>
Date:   Mon, 28 Aug 2023 21:01:41 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH 4.14 00/57] 4.14.324-rc1 review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org
Cc:     patches@lists.linux.dev, linux-kernel@vger.kernel.org,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
        srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org,
        nathanl@linux.ibm.com, mpe@ellerman.id.au
References: <20230828101144.231099710@linuxfoundation.org>
Content-Language: en-US
From:   =?UTF-8?Q?Daniel_D=c3=adaz?= <daniel.diaz@linaro.org>
In-Reply-To: <20230828101144.231099710@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

On 28/08/23 4:12 a. m., Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.14.324 release.
> There are 57 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 30 Aug 2023 10:11:30 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.14.324-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.14.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h
> 
> -------------
> Pseudo-Shortlog of commits:
> 
> Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>      Linux 4.14.324-rc1
> 
[...]
> Nathan Lynch <nathanl@linux.ibm.com>
>      powerpc/rtas_flash: allow user copy to flash block cache objects
[...]

We see this build regression on PowerPC with GCC-8 and GCC-12:
-----8<-----
   /builds/linux/arch/powerpc/kernel/rtas_flash.c: In function 'rtas_flash_init':
   /builds/linux/arch/powerpc/kernel/rtas_flash.c:717:22: error: implicit declaration of function 'kmem_cache_create_usercopy'; did you mean 'kmem_cache_create'? [-Werror=implicit-function-declaration]
     flash_block_cache = kmem_cache_create_usercopy("rtas_flash_cache",
                         ^~~~~~~~~~~~~~~~~~~~~~~~~~
                         kmem_cache_create
   /builds/linux/arch/powerpc/kernel/rtas_flash.c:717:20: error: assignment to 'struct kmem_cache *' from 'int' makes pointer from integer without a cast [-Werror=int-conversion]
     flash_block_cache = kmem_cache_create_usercopy("rtas_flash_cache",
                       ^
----->8-----

That's on defconfig and cell_defconfig.

Bisection points to "powerpc/rtas_flash: allow user copy to flash block cache objects" (5190538c66e5). Reverting that patch makes the build pass again.

Tuxmake reproducer:

   #pip3 install -U tuxmake
   tuxmake --runtime podman --target-arch powerpc --toolchain gcc-8 --kconfig defconfig
   git revert 5190538c66e5e8e7cdbf694afec8291f421e6bcf
   tuxmake --runtime podman --target-arch powerpc --toolchain gcc-8 --kconfig defconfig

Greetings!

Daniel Díaz
daniel.diaz@linaro.org

