Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8AB5F784B52
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Aug 2023 22:23:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230502AbjHVUXs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Aug 2023 16:23:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229516AbjHVUXr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Aug 2023 16:23:47 -0400
Received: from mail-oa1-x35.google.com (mail-oa1-x35.google.com [IPv6:2001:4860:4864:20::35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6059E50;
        Tue, 22 Aug 2023 13:23:35 -0700 (PDT)
Received: by mail-oa1-x35.google.com with SMTP id 586e51a60fabf-1c11d53221cso3180377fac.2;
        Tue, 22 Aug 2023 13:23:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692735815; x=1693340615;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jqi3CURD1i8JRUxuB5MEXSey4Yu1NRacqMjmHXpb1qA=;
        b=aSXkQr2s1RA5cBAyhs8eZgXQWhEROgEBM1yN6Ve2691jUCUqbRIqt24CHWtZdWN9nv
         oEP/l6SIlZLzCy6JFtBKllAi0H8u5IZEDwdfyasmUeldWda3Y7cIGn2ldfoRck39fcZj
         AgUxglBO88vB7pFCug3egYT7c2FKX3eCM9sENBv/VjiKm8hyr7kLRuVWHTY6+81uuJAn
         J5r2kJ+7Jygi2TPWMSajEl9XHe/31i3lggdvO37mLhWbfKX42yU8k+xC4OQxQgO/Q+ha
         Vd0ULCrP7ophvNZw4jeJvKsJcA24uVw4jtYtlPy5ENJENGu8It1W4f98spTTCTQRdv+S
         W4kA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692735815; x=1693340615;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jqi3CURD1i8JRUxuB5MEXSey4Yu1NRacqMjmHXpb1qA=;
        b=Dyx8LCYsQjSEEEcQlKu7z7tEuAwXvPL8EVuDKJ9fMPZ07BzUTEPI8/CloaxcNVCslM
         AAQxoVOVowNX+73dXnw3YAoil6cgi7txwlLVzc1/1WOnX4IToZ2w27Ve7iNWgs0HJEmk
         sni7AZCdyXLHHcFuflJce5Ma7GFqJ+il9K18T1TUboYnxwR6f6AbSnHKzUKvtzCJJriN
         Ia4+HJ2ZtwcnNZ6X6Jbo5a6WXVwpAtblE8tQCqwYOKuBrfnbjkhqArFc6TI2P3eKgGrJ
         doV+UNdksrRynXFQr/rZckts30FlrKoWM6L5sHMwRLsm6KCzZ1ZDu5qopuJ+jB/pwa3M
         gLXg==
X-Gm-Message-State: AOJu0Yz+TZ3+r3PxZatgZsOSgZ7XaX+vdsW9kZ7X7KmWJnECHpdQoFTT
        maG6LDnMqJzjjnL0j5LW7L0=
X-Google-Smtp-Source: AGHT+IG/FGtyCP48fro2CrnwocGv7TDALAy+pryH74Z/aT+ZSu5UWrreZjVZYosdOw/Z/3FYMNZ/pw==
X-Received: by 2002:a05:6870:2188:b0:19f:6711:8e0a with SMTP id l8-20020a056870218800b0019f67118e0amr13111471oae.32.1692735815183;
        Tue, 22 Aug 2023 13:23:35 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id b5-20020a0cf045000000b0063cfe9adb2csm3293671qvl.108.2023.08.22.13.23.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Aug 2023 13:23:34 -0700 (PDT)
Message-ID: <2333b38a-fe55-7972-0418-c5946dcda672@gmail.com>
Date:   Tue, 22 Aug 2023 13:23:13 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 6.1 000/194] 6.1.47-rc1 review
Content-Language: en-US
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org
Cc:     patches@lists.linux.dev, linux-kernel@vger.kernel.org,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
        conor@kernel.org
References: <20230821194122.695845670@linuxfoundation.org>
From:   Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20230821194122.695845670@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/21/23 12:39, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.1.47 release.
> There are 194 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 23 Aug 2023 19:40:45 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.1.47-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.1.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h

On ARCH_BRCMSTB using 32-bit and 64-bit ARM kernels, build tested on 
BMIPS_GENERIC:

Tested-by: Florian Fainelli <florian.fainelli@broadcom.com>
-- 
Florian

