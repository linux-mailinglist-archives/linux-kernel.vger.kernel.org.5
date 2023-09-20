Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D8B77A8B56
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Sep 2023 20:13:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229711AbjITSNl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Sep 2023 14:13:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229699AbjITSNi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Sep 2023 14:13:38 -0400
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36B3B97;
        Wed, 20 Sep 2023 11:13:33 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id d2e1a72fcca58-690bfd4f3ebso56979b3a.3;
        Wed, 20 Sep 2023 11:13:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695233612; x=1695838412; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=JfTC70wEujuVMb02KLAiMmYdtpGG/mauqfpeX7AFOaE=;
        b=X2Z4yBGkxfwrdpsM8D3OY69Ul+QL45WVg1/WPpana+0GO7q8+k6l0C5GUBmUuWAWcI
         h300YZsOtn5xlWwJuqoA3hGg+pbPYYVzCrT2pcMX7P601JXNIxMFyyz5S9fztkpfanxy
         AkWAOUsPzMEEDXa+hT52vLTbBJYA3rJfUWw4afaNmBt9j1TrQDPBzNXzeyqIe5zsUq6P
         0Shq/jBDW1CeICQihjiylensAj+PCIqUhwwLUaiITv+4/kRqBvDMR4zAbwtl3VlOuFvR
         /a3trL1e0gNtmuj9ej0TrubcuWL1lLLnik1wV05sehQ8hCrPoPvrIO91WJHZz//uXuPY
         tVNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695233612; x=1695838412;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JfTC70wEujuVMb02KLAiMmYdtpGG/mauqfpeX7AFOaE=;
        b=AofTaraf/+GqlGe2AHvXwCA2C8/NxrzwS/Qf4qAVUszFLnelu6ed7Y+ydKZaLKooKS
         wXbpReG+rgWGP6pyJw3XzFDLweiSEIrMvIbT3UXlT83pOuHpUC7PMwiuJMm75RKSLvIe
         mmiT1mLhXulpAjJ5zEHeeanVRBTzRbN8sULdVXk6XQPx51n6kaiz36mwsW1q+uiN3GQq
         fPOSMd7akMhXf/EffLLjeBbvg6UXDwLaOkO1bDW5P26E0e7Osmhkptrld0u82rkLTB9K
         sTXYiTEn8NZw8mUNOwmqfRve4dHjbBAGpFVkgSEMrMAo4rOco5cvnsXq5JFvM65FndhE
         O5Sg==
X-Gm-Message-State: AOJu0Ywdpe84vaMFnwGodc2Uta5VrDlujJkvQ7UHOFpRlamqd0Di2JqA
        UaEjpp6lO7Z+CvuoDATvfcA=
X-Google-Smtp-Source: AGHT+IFdl3LgMneO+iO5MnNLX1meZYPYp5J5pSrzItpSbxObmpeDIvzHfi3EwkbtLZ8a46prLlb9Vw==
X-Received: by 2002:a05:6a21:4846:b0:15c:b7ba:9137 with SMTP id au6-20020a056a21484600b0015cb7ba9137mr3052327pzc.2.1695233612530;
        Wed, 20 Sep 2023 11:13:32 -0700 (PDT)
Received: from [10.67.49.139] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id n3-20020a63b443000000b00578b40a4903sm2535075pgu.22.2023.09.20.11.13.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 Sep 2023 11:13:31 -0700 (PDT)
Message-ID: <dcb9997a-2e8a-5eb2-7a34-f8af418d4bf1@gmail.com>
Date:   Wed, 20 Sep 2023 11:13:30 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH 5.10 00/83] 5.10.196-rc1 review
Content-Language: en-US
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <rogers.email@gmail.com>
Cc:     patches@lists.linux.dev, linux-kernel@vger.kernel.org,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
        conor@kernel.org
References: <20230920112826.634178162@linuxfoundation.org>
From:   Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20230920112826.634178162@linuxfoundation.org>
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
> This is the start of the stable review cycle for the 5.10.196 release.
> There are 83 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Fri, 22 Sep 2023 11:28:09 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.10.196-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.10.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h

perf fails to build on ARM, ARM64 and MIPS with:

fixdep: error opening depfile: 
/local/users/fainelli/buildroot/output/bmips/build/linux-custom/tools/perf/pmu-events/.pmu-events.o.d: 
No such file or directory
make[5]: *** [pmu-events/Build:33: 
/local/users/fainelli/buildroot/output/bmips/build/linux-custom/tools/perf/pmu-events/pmu-events.o] 
Error 2
make[4]: *** [Makefile.perf:653: 
/local/users/fainelli/buildroot/output/bmips/build/linux-custom/tools/perf/pmu-events/pmu-events-in.o] 
Error 2
make[3]: *** [Makefile.perf:229: sub-make] Error 2
make[2]: *** [Makefile:70: all] Error 2
make[1]: *** [package/pkg-generic.mk:294: 
/local/users/fainelli/buildroot/output/bmips/build/linux-tools/.stamp_built] 
Error 2
make: *** [Makefile:27: _all] Error 2

this is caused by 653fc524e350b62479529140dc9abef05abbcc29 ("perf build: 
Update build rule for generated files"). Reverting that commit plus 
5804de1f2324ddcfe3f0b6ad58fcfe4d344e0471 ("perf jevents: Switch build to 
use jevents.py") gets us going again.
-- 
Florian

