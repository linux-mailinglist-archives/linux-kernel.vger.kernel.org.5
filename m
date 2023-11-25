Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1CE187F8D8C
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Nov 2023 20:04:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232218AbjKYTEC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Nov 2023 14:04:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbjKYTEA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Nov 2023 14:04:00 -0500
Received: from mail-ot1-x329.google.com (mail-ot1-x329.google.com [IPv6:2607:f8b0:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FC28F7
        for <linux-kernel@vger.kernel.org>; Sat, 25 Nov 2023 11:04:07 -0800 (PST)
Received: by mail-ot1-x329.google.com with SMTP id 46e09a7af769-6d817ccaa6dso240444a34.2
        for <linux-kernel@vger.kernel.org>; Sat, 25 Nov 2023 11:04:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1700939046; x=1701543846; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=dVLgTfi8XS7NzCAGMfCjECNo5pKytb4Hcwd/ayxLWKo=;
        b=lvLOKyV/m6GEZ+LeXnxbYj6bdNkVb8+7qZM2Ys6RIuK+FO+0eE9s3XKFF40dViP8ho
         exskOXOvCHihC0jkuhSj7+ZyJmBoi/C6h3T8bRxFl0baFcYNCB0HG6HbK1b57trAV/qT
         ZD08NQPabWAEq9QR3pE1r4Xc8bxOR0a9ggmN34FhuTwl75tesmMbADRZXsGOfGAxJMSO
         QCS12CPVfhcMbJuEvvnEnL8VKizFeV98IZ5n93/rqP9k+ahTs78u8thczDa7wjszBdZA
         PFXDA9LAUETK38gEzmcrz19gakTZtziPbsH19l1lklJDtrwu0K9V27E/M3HlzVrgmmma
         b3sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700939046; x=1701543846;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dVLgTfi8XS7NzCAGMfCjECNo5pKytb4Hcwd/ayxLWKo=;
        b=xSxbm+zyyfIMWnLFnyFSKBE3LyFJHLr8lF+qcMP2WT+1FAuqrg/+11Ag4FnenVO9C6
         EL2+NlVXRYBWM+QyqRFhElFdKsHIyn9Fe787ynb9R/XyRwKdD9HmB2DCw/75qsQqRMjM
         ZO1KnwbFuj8RSpxdgpk2bFzUktK8x47HbDRE902F/n+dyLmCsWtEhQGg688orjIg5nu5
         tXZ8zCWpLvuFpG/OCAUszbJoGG01TdkXACGooMG5FVvUBA/B9/7VZvDtFGNR1eT2mOv9
         hUvNWtrQ2UH9z1hILdLNMjUggTYu3EvSkUkRaAuk03ctTw/a9h7/XZXMTOOldTwwdq9z
         dkIQ==
X-Gm-Message-State: AOJu0YxmdOT/H/yuIeLDI+T4y8amGdBPCJnAaLOu6UEwkPhiozNx1thE
        updxDQpwTKXbCmCdqKHEtGZqtg==
X-Google-Smtp-Source: AGHT+IHgZdgP1on4N3LC80KMS2IdPjMpvNSJF4hrYp4qKVG6WSLUKFgvqub9oOpsaT5uF79VJ4IXnQ==
X-Received: by 2002:a05:6870:209:b0:1ea:e36:70d9 with SMTP id j9-20020a056870020900b001ea0e3670d9mr7900604oad.20.1700939046155;
        Sat, 25 Nov 2023 11:04:06 -0800 (PST)
Received: from [192.168.17.16] ([138.84.62.70])
        by smtp.gmail.com with ESMTPSA id le8-20020a0568700c0800b001f4b1f5ac0bsm1412893oab.31.2023.11.25.11.04.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 25 Nov 2023 11:04:05 -0800 (PST)
Message-ID: <e819d653-8a1e-4088-a4dd-a093356da8e8@linaro.org>
Date:   Sat, 25 Nov 2023 13:04:02 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.6 000/528] 6.6.3-rc2 review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org
Cc:     patches@lists.linux.dev, linux-kernel@vger.kernel.org,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
        srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org,
        allen.lkml@gmail.com, hca@linux.ibm.com
References: <20231125163158.249616313@linuxfoundation.org>
Content-Language: en-US
From:   =?UTF-8?Q?Daniel_D=C3=ADaz?= <daniel.diaz@linaro.org>
In-Reply-To: <20231125163158.249616313@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

On 25/11/23 10:33 a. m., Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.6.3 release.
> There are 528 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Mon, 27 Nov 2023 16:30:48 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.6.3-rc2.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.6.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h

We see this build regression with System/390:

-----8<-----
   /builds/linux/arch/s390/mm/page-states.c: In function 'mark_kernel_pgd':
   /builds/linux/arch/s390/mm/page-states.c:165:45: error: request for member 'val' in something not a structure or union
     165 |         max_addr = (S390_lowcore.kernel_asce.val & _ASCE_TYPE_MASK) >> 2;
         |                                             ^
   make[5]: *** [/builds/linux/scripts/Makefile.build:243: arch/s390/mm/page-states.o] Error 1
----->8-----

That's with Clang 17, Clang nightly, GCC 8 and GCC 13, with allnoconfig, defconfig, and tinyconfig.

Bisection points to:

   commit b676da1c17c9d0c5b05c7b6ecb9ecf2d8b5e00de
   Author: Heiko Carstens <hca@linux.ibm.com>
   Date:   Tue Oct 17 21:07:03 2023 +0200

       s390/cmma: fix initial kernel address space page table walk
       
       commit 16ba44826a04834d3eeeda4b731c2ea3481062b7 upstream.


Reverting makes the build pass.

Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>

Greetings!

Daniel Díaz
daniel.diaz@linaro.org

