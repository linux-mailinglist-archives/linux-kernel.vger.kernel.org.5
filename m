Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B2DBD80DC7E
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Dec 2023 22:06:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345026AbjLKVEA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Dec 2023 16:04:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344987AbjLKVD6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Dec 2023 16:03:58 -0500
Received: from mail-ot1-x32c.google.com (mail-ot1-x32c.google.com [IPv6:2607:f8b0:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 122F39F
        for <linux-kernel@vger.kernel.org>; Mon, 11 Dec 2023 13:04:05 -0800 (PST)
Received: by mail-ot1-x32c.google.com with SMTP id 46e09a7af769-6d9fdbcec6eso1864513a34.1
        for <linux-kernel@vger.kernel.org>; Mon, 11 Dec 2023 13:04:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1702328644; x=1702933444; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ktj8wEOwOJtT93Qoj4w+8XeXXw7nxK8KClGQi33+6EU=;
        b=deSrDb4wasIy0ihHwmvOmuqYt/4MRKHVa7cSgO20yR+fvtyYGAybuKURWrXspqfk+o
         sEtOaMdl0svOaN/RK7Tr44nh7uxbWXLne0P0GgeaPVuT1N/LEQox85ofj4P3AMBN6yRF
         A4PdCBl23PTHCP43lk870mNyJxSSr4J9me2cjuVtCMLUU6mGm2vhNAhIFuKz1RDwc1Fs
         u6vol/ICt5OZ3YHO6N6N22/jQfAHyLsTzIRyRe/cN48ovLNZPbba9gA0/y/kqe3nazz7
         RMGobtzUAmKaxBAp/sbKDpXXXmdU8MRMcuYsSSlwrBT6XsjRIgIjrLHSAlRoWVjtrZr3
         V6YQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702328644; x=1702933444;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ktj8wEOwOJtT93Qoj4w+8XeXXw7nxK8KClGQi33+6EU=;
        b=MbxkI95QulX2yATgRb5VtG0iIB5VtgwGSE9LJDmTH9dwdAFgyUtchow0/n6VV6Wr91
         aS5IosKjxRzpXssXVn8yN35GB93phqTk2Sc3nMFSM/SqmbUNtgNsH+XXp6bYra7J53CH
         3XMiS/yff64Zh4mES0iT986D9tF5oGYZBBAJ+6f7rWqG0QQvNA1NZnFMOoZQrSrzm6Nu
         DNJBkI0UG539RbShOD0R0K7axB+JGzae06lybiD8CMLnHSpGV8IH4EH5Bq+KPaB5HaDD
         lk8Lk1FmlQ1wvSi5D1mdRbDok7OOYLjchyRtI1y2+BzaX8C44NVfLkiz+eMSH8oTut/Q
         bQzQ==
X-Gm-Message-State: AOJu0YzReMwEkLXtvChxXec3H3K63crCf43zu7U7exhPlFTl6paY2Bj1
        XVoSfkjYrX7y8s5t081Rz/1Mxw==
X-Google-Smtp-Source: AGHT+IEA9OP/kzB0+/sAZLOnwZ2cQXl9KeyBl3FnZnFIQVntp6ST40h5Ka1h/rFzYDa1Ou71de42hw==
X-Received: by 2002:a9d:6a82:0:b0:6d7:f97d:14c with SMTP id l2-20020a9d6a82000000b006d7f97d014cmr4316698otq.28.1702328644365;
        Mon, 11 Dec 2023 13:04:04 -0800 (PST)
Received: from [192.168.17.16] ([138.84.62.113])
        by smtp.gmail.com with ESMTPSA id n25-20020a0568301e9900b006d9a0bf775asm1850375otr.7.2023.12.11.13.04.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Dec 2023 13:04:04 -0800 (PST)
Message-ID: <ff65c696-1fde-4e4c-b964-356e81495cab@linaro.org>
Date:   Mon, 11 Dec 2023 15:04:00 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4.19 00/55] 4.19.302-rc1 review
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
References: <20231211182012.263036284@linuxfoundation.org>
From:   =?UTF-8?Q?Daniel_D=C3=ADaz?= <daniel.diaz@linaro.org>
In-Reply-To: <20231211182012.263036284@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

On 11/12/23 12:21 p. m., Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.19.302 release.
> There are 55 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 13 Dec 2023 18:19:59 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.19.302-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.19.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h

Same problem here as with 4.14. Here's a list of failures:

## Test Regressions (compared to v4.19.301)
* arm, build
   - clang-17-axm55xx_defconfig
   - clang-17-defconfig
   - clang-17-multi_v5_defconfig-aa80e505
   - clang-17-mxs_defconfig
   - clang-17-nhk8815_defconfig
   - clang-17-u8500_defconfig
   - gcc-12-axm55xx_defconfig
   - gcc-12-bcm2835_defconfig
   - gcc-12-defconfig
   - gcc-12-lkftconfig
   - gcc-12-lkftconfig-debug
   - gcc-12-lkftconfig-debug-kmemleak
   - gcc-12-lkftconfig-kasan
   - gcc-12-lkftconfig-kselftest-kernel
   - gcc-12-lkftconfig-kunit
   - gcc-12-lkftconfig-libgpiod
   - gcc-12-lkftconfig-rcutorture
   - gcc-12-multi_v5_defconfig-aa80e505
   - gcc-12-mxs_defconfig
   - gcc-12-nhk8815_defconfig
   - gcc-12-u8500_defconfig
   - gcc-8-axm55xx_defconfig
   - gcc-8-bcm2835_defconfig
   - gcc-8-defconfig
   - gcc-8-multi_v5_defconfig-aa80e505
   - gcc-8-mxs_defconfig
   - gcc-8-nhk8815_defconfig
   - gcc-8-u8500_defconfig

* arm64, build
   - clang-17-defconfig
   - clang-17-defconfig-40bc7ee5
   - clang-17-lkftconfig
   - clang-lkftconfig
   - gcc-12-defconfig
   - gcc-12-defconfig-40bc7ee5
   - gcc-12-lkftconfig
   - gcc-12-lkftconfig-64k_page_size
   - gcc-12-lkftconfig-armv8_features
   - gcc-12-lkftconfig-debug
   - gcc-12-lkftconfig-debug-kmemleak
   - gcc-12-lkftconfig-devicetree
   - gcc-12-lkftconfig-kasan
   - gcc-12-lkftconfig-kselftest-kernel
   - gcc-12-lkftconfig-kunit
   - gcc-12-lkftconfig-libgpiod
   - gcc-12-lkftconfig-rcutorture
   - gcc-8-defconfig
   - gcc-8-defconfig-40bc7ee5


Failure:

-----8<-----
   /builds/linux/drivers/tty/serial/amba-pl011.c: In function 'pl011_dma_tx_refill':
   /builds/linux/drivers/tty/serial/amba-pl011.c:644:20: error: 'DMA_MAPPING_ERROR' undeclared (first use in this function); did you mean 'DMA_TRANS_NOERROR'?
     if (dmatx->dma == DMA_MAPPING_ERROR) {
                       ^~~~~~~~~~~~~~~~~
                       DMA_TRANS_NOERROR
   /builds/linux/drivers/tty/serial/amba-pl011.c:644:20: note: each undeclared identifier is reported only once for each function it appears in
   make[4]: *** [/builds/linux/scripts/Makefile.build:303: drivers/tty/serial/amba-pl011.o] Error 1
   make[4]: Target '__build' not remade because of errors.
----->8-----

Bisection points to the same commit:

   commit 6afe0d46b25850f794626c70aac55cc7f9b774e2
   Author: Arnd Bergmann <arnd@arndb.de>
   Date:   Wed Nov 22 18:15:03 2023 +0100

       ARM: PL011: Fix DMA support
       
       commit 58ac1b3799799069d53f5bf95c093f2fe8dd3cc5 upstream.


A revert helps the build pass.

Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>

Greetings!

Daniel Díaz
daniel.diaz@linaro.org

