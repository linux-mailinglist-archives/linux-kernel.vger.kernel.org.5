Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C59C7A8BFF
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Sep 2023 20:47:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229547AbjITSrb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Sep 2023 14:47:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229527AbjITSr3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Sep 2023 14:47:29 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA503CA;
        Wed, 20 Sep 2023 11:47:20 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id d9443c01a7336-1bf55a81eeaso928475ad.0;
        Wed, 20 Sep 2023 11:47:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695235640; x=1695840440; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8SaVRK/lPynvBxRFJJkTvRp0hGVnM5KbkWZipq2rlvU=;
        b=c0Z+Z/Mp2KLLztydBKNKmK+3mdhs/DJQJoPytXAf1N0PXauR1KIUzZrJQ89cevpSe4
         c6zpZuwfuKPM3bjsE8aeCm1bslxSGPXCPLlR7tHFAO5xRbdFMPnl9JB9MA0T+BJHpgMm
         ItXGo7Vt/V9AD2OOpL7W/SmbnMdbTCtPq26Y20zAyqwtVdLPajsa2zlKzgBmRjlV6wvE
         GHWU8l0RG63xx/M0QuoyD/jKHH7VOjr8e/7GVRvHI1k0fvMfBmYREl63B4lA/K7r3929
         uI1Hux3gcflW8WFF8fLxGALP6C/qIwvAamPaUAhjhwha60vHYTYe7z5RKx/6x0fJ34vG
         ul1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695235640; x=1695840440;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8SaVRK/lPynvBxRFJJkTvRp0hGVnM5KbkWZipq2rlvU=;
        b=POXM+JhMIcoyMX2vZALIsc8f33R3cPtz6R1vRdmoN0L5WZQF4W60ClCPfC2o147N83
         oMTwGv38yHX6O8F8rq/RO89rjTZJXRUi9Feb3b7lfNEhiAwjxSwI8oM5aO0hDYmuP+eJ
         qpQzYDNm/T72HwgDgfb6iJRciRYJgbrYYVAp1ci7IRq+KnC/4eGv46+AyZ3o4SBvSfAW
         9NLIgul6Dp2vUhyiMwKqDuRq82uLIzMIjdWR3jMUiDkGI5NFS9HQeAshE1eWiQMpWcn6
         huPs0Q8L+QxYuic4PyIpABjWIm39LMKvkOKrhq5hhhQ45bi/09FsE0F0qfW4NIi33tSE
         jI1Q==
X-Gm-Message-State: AOJu0YwYiV/BLmh6zdv35v5YoTzyH6wN1cnWxb5es0LO2KOQk6n7CykK
        UhJwEMcrrHoknOrPY0CGkpU=
X-Google-Smtp-Source: AGHT+IHjAbtg/h7MbmZZiS0CzKY3Z8Qu5VW1pvq9abPt/lEehglQL0uhFnj0A1BpzRFtTgM2VsYhZQ==
X-Received: by 2002:a17:903:41c7:b0:1bb:d280:5e0b with SMTP id u7-20020a17090341c700b001bbd2805e0bmr4141314ple.18.1695235640001;
        Wed, 20 Sep 2023 11:47:20 -0700 (PDT)
Received: from [10.67.49.139] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id g4-20020a170902740400b001bc18e579aesm12185668pll.101.2023.09.20.11.47.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 Sep 2023 11:47:19 -0700 (PDT)
Message-ID: <6a577578-8adb-aa70-1bf8-b1a4573152cf@gmail.com>
Date:   Wed, 20 Sep 2023 11:47:17 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH 5.15 000/110] 5.15.133-rc1 review
Content-Language: en-US
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org
Cc:     patches@lists.linux.dev, linux-kernel@vger.kernel.org,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
        conor@kernel.org
References: <20230920112830.377666128@linuxfoundation.org>
From:   Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20230920112830.377666128@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/20/23 04:30, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.15.133 release.
> There are 110 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Fri, 22 Sep 2023 11:28:09 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.15.133-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.15.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h

Same thing as with 5.10 on ARM, ARM64 and MIPS:

   CC 
/local/users/fainelli/buildroot/output/bmips/build/linux-custom/tools/perf/pmu-events/pmu-events.o
fixdep: error opening depfile: 
/local/users/fainelli/buildroot/output/bmips/build/linux-custom/tools/perf/pmu-events/.pmu-events.o.d: 
No such file or directory
make[5]: *** [pmu-events/Build:33: 
/local/users/fainelli/buildroot/output/bmips/build/linux-custom/tools/perf/pmu-events/pmu-events.o] 
Error 2
make[4]: *** [Makefile.perf:668: 
/local/users/fainelli/buildroot/output/bmips/build/linux-custom/tools/perf/pmu-events/pmu-events-in.o] 
Error 2
make[3]: *** [Makefile.perf:238: sub-make] Error 2
make[2]: *** [Makefile:70: all] Error 2
make[1]: *** [package/pkg-generic.mk:294: 
/local/users/fainelli/buildroot/output/bmips/build/linux-tools/.stamp_built] 
Error 2
make: *** [Makefile:27: _all] Error 2

reverting 95466975f143df7423bbf4905348c7b6260f4d29 ("perf build: Update 
build rule for generated files") and 
12ff96780ebd93d1aacb396994e3a32b50dccecf ("perf jevents: Switch build to 
use jevents.py") gets us going again.
-- 
Florian

