Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 078D57768DD
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Aug 2023 21:39:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233186AbjHITi4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Aug 2023 15:38:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229685AbjHITiy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Aug 2023 15:38:54 -0400
Received: from mail-ot1-x336.google.com (mail-ot1-x336.google.com [IPv6:2607:f8b0:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50916115;
        Wed,  9 Aug 2023 12:38:54 -0700 (PDT)
Received: by mail-ot1-x336.google.com with SMTP id 46e09a7af769-6bcd4b5ebbaso156121a34.1;
        Wed, 09 Aug 2023 12:38:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691609933; x=1692214733;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ZaTe1EqwYOzn8O80KdtH3kNt1a9FT3Yhi0ZfT/Z/G8o=;
        b=FBR/I6GSX7g5L4+DYcUjOHmmh41YZ9ahuhCPkULHJjX64s+cWRH+5yvVwwBQz1G9CW
         NvdSKm+G8tn0TUhKDJCtMQ5Ac5En//0otMlgKyn/s/4jK2L5V9PtktOx94jrbJ7fmcyv
         lhTyR4yQtv6f/+OfD23G2edsJz2U9XlPQK87jzNOzpac5sROvykiNtHPms0XErmb5C7G
         8jmr+hM32jpiPqX+2xtvrsiZmHpQ+fCR69tcfogT56c4iRdOQq53XasotC+D4O5HOJ9I
         5WyuImkQ8A3tYwhM/moCQOXzxamUTrD/gyZLLcFWM8v5Qm6XeoE/xRo3GDa+FS77D0hR
         HdCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691609933; x=1692214733;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZaTe1EqwYOzn8O80KdtH3kNt1a9FT3Yhi0ZfT/Z/G8o=;
        b=KJfwfyqRqjIfJOoPMtZfdWALyPCBDOr+4SHD4hFIvT+oFwcYO+dRod6J3b6vACJsy9
         BGrAqgtRKcckd3Rx0PoV+kdPiyvOiFg8IBApjQqirtBfcJf7hWOdX/TzLnmCGOC7igrR
         a5xCiNTEw25L9bq52SbblDqXBEOZbD7xXdI81S01Etzybj4fn1VJpFyNCZElhJ6xXA2L
         97Jk7+iXJRvsxGlRKmv1viIS+7tUnbmGwnvue37ggmwya6sgYaMheTk4ji+NMyx5y18Z
         rgKbAZ3pKv8Mg4artKhXyLs9Pql8HV6ovc9MqP4a+uzNH2ReQQ8j+J1u8TWul9js2izb
         7DHQ==
X-Gm-Message-State: AOJu0YwTxweJSHWu+nw6p3R9/u+yDF+QaGGNvwSVv09k68Dv8/Lxm3Of
        6UbZhzv6JrDg3WRE5tlaDkM=
X-Google-Smtp-Source: AGHT+IELs7Z3Qgdb0kPj7kMQLbLRGaj2RW9exSA+VyXP8PRR+A3e7h6usNjnFGoBSW1O3lymxfyFrg==
X-Received: by 2002:a05:6808:10ca:b0:3a7:71fd:57cc with SMTP id s10-20020a05680810ca00b003a771fd57ccmr433118ois.12.1691609933593;
        Wed, 09 Aug 2023 12:38:53 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id f31-20020a17090a702200b00267ee71f463sm4414336pjk.0.2023.08.09.12.38.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Aug 2023 12:38:53 -0700 (PDT)
Message-ID: <4db69d01-0325-213e-ae62-a375e064a8e4@gmail.com>
Date:   Wed, 9 Aug 2023 12:38:47 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 5.15 00/92] 5.15.126-rc1 review
Content-Language: en-US
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org
Cc:     patches@lists.linux.dev, linux-kernel@vger.kernel.org,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
        conor@kernel.org
References: <20230809103633.485906560@linuxfoundation.org>
From:   Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20230809103633.485906560@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/9/23 03:40, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.15.126 release.
> There are 92 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Fri, 11 Aug 2023 10:36:10 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.15.126-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.15.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h

SCMI with the SMC transport fails to build because of "[PATCH 5.15 
11/92] firmware: arm_scmi: Fix chan_free cleanup on SMC" where the 
specific details have been reported there. Here is the build failure FWIW:

drivers/firmware/arm_scmi/smc.c:39:6: error: duplicate member 'irq'
   int irq;
       ^~~
drivers/firmware/arm_scmi/smc.c: In function 'smc_chan_setup':
drivers/firmware/arm_scmi/smc.c:118:20: error: 'irq' undeclared (first 
use in this function); did you mean 'rq'?
    scmi_info->irq = irq;
                     ^~~
                     rq
drivers/firmware/arm_scmi/smc.c:118:20: note: each undeclared identifier 
is reported only once for each function it appears in
   CC      drivers/mmc/core/slot-gpio.o
host-make[5]: *** [scripts/Makefile.build:289: 
drivers/firmware/arm_scmi/smc.o] Error 1
host-make[5]: *** Waiting for unfinished jobs....
-- 
Florian

