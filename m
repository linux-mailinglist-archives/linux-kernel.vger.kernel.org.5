Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F8CC7A8BFC
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Sep 2023 20:47:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229456AbjITSrS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Sep 2023 14:47:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229527AbjITSrO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Sep 2023 14:47:14 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 889D9C9;
        Wed, 20 Sep 2023 11:47:08 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id 98e67ed59e1d1-27666e94ad7so57418a91.0;
        Wed, 20 Sep 2023 11:47:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695235628; x=1695840428; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3yrlLXemaze0zUk7aEqlSu9qwgFgGgN5jqPSauw6eXE=;
        b=aXjvsv81Tv+kwyQeTGX9n9qI99PnzR+kzgc8xqlsAR9FhZj8mnbYB9zXkTGwRaWC4e
         1WRgbHjAhreYykXezzotMo9yVaH2yYkPYCGSJhkpNfEYsaz7NFM+IBQWptPsqlRvEhIS
         zvPv+R+vulObbfOEHMRXtHJYJkZsSEbtZUaQRpDYv9oYIMxapnlQ2sYxLle2Vbj0T+Md
         tbucDkWtd0vMPurw5TXDLBBSZRxnO9wanvP+RDkFVhYVbVtO3ZPIuvdGb6fUYu1UOGWr
         MS5/dMMjTzwf6rNS09rgf5zfsQNjrgeq/6sieN5bzhYctAj5MGU3gTFUC2L7tN770Ivf
         b9bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695235628; x=1695840428;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3yrlLXemaze0zUk7aEqlSu9qwgFgGgN5jqPSauw6eXE=;
        b=ROV0Dyyg67FqHdaksxjXe5L28x+AkcQL2YqWI7CZ17wztVeFKyAIf28VmgVceq77xj
         dSYOIK8doMJvQpZK+SW6Agum86aQVW8UJ0XsxDI9fkgYn52bN0aXB8sgWoXILGHQ/6NM
         T0FbfDVrFTICdegzG0s5zUPyu/fmQFEnSjplFU9fneOUHRVXMlxsbZfPhxW4aJgFlCGq
         +I9bosWiLFNJeuC/vkXB8UfO2EmMyEATT8pHPqozdUDdXiUQrIa2R6oVIV7vmDhA1baF
         FZ6KP0yBbiUan4rcBt3u1Lqj4tJVjFJ9b91QG2BYPN1ABJtGCS+akC8ubQFVRdVWDTrl
         bRxg==
X-Gm-Message-State: AOJu0YwjVwJI3R2QKQDG5EaZKO0EZmyQb9OpSDuiZzJ+AQuKQ98DIxQY
        WKnzQw9a4x0Ueu8STqyuGWU=
X-Google-Smtp-Source: AGHT+IGXLrsFJfrfO1epzwQbZ8Ie658wxSTSzCzi2zcM+foiCp6f2+QCgjLb2J9GxP9Cv48tV4RIAA==
X-Received: by 2002:a17:90b:4f8b:b0:276:696b:1dd9 with SMTP id qe11-20020a17090b4f8b00b00276696b1dd9mr8563967pjb.15.1695235627869;
        Wed, 20 Sep 2023 11:47:07 -0700 (PDT)
Received: from [10.67.49.139] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id u7-20020a17090ae00700b00262fc3d911esm1646917pjy.28.2023.09.20.11.47.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 Sep 2023 11:47:07 -0700 (PDT)
Message-ID: <c333a61e-242e-0b06-e5bd-2a1249b1483e@gmail.com>
Date:   Wed, 20 Sep 2023 11:47:05 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH 5.10 00/83] 5.10.196-rc1 review
Content-Language: en-US
To:     Ian Rogers <rogers.email@gmail.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Namhyung Kim <namhyung@kernel.org>,
        patches@lists.linux.dev, linux-kernel@vger.kernel.org,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
        conor@kernel.org
References: <20230920112826.634178162@linuxfoundation.org>
 <dcb9997a-2e8a-5eb2-7a34-f8af418d4bf1@gmail.com>
 <CABbpPsz0Brmfw3zg2Y_r54Hx2mN1Ly=AtghKNE9chmtSP_-Y6A@mail.gmail.com>
From:   Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <CABbpPsz0Brmfw3zg2Y_r54Hx2mN1Ly=AtghKNE9chmtSP_-Y6A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,WEIRD_PORT autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/20/23 11:42, Ian Rogers wrote:
> On Wed, 20 Sept 2023 at 11:13, Florian Fainelli <f.fainelli@gmail.com 
> <mailto:f.fainelli@gmail.com>> wrote:
> 
>     On 9/20/23 04:30, Greg Kroah-Hartman wrote:
>      > This is the start of the stable review cycle for the 5.10.196
>     release.
>      > There are 83 patches in this series, all will be posted as a response
>      > to this one.  If anyone has any issues with these being applied,
>     please
>      > let me know.
>      >
>      > Responses should be made by Fri, 22 Sep 2023 11:28:09 +0000.
>      > Anything received after that time might be too late.
>      >
>      > The whole patch series can be found in one patch at:
>      >
>     https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.10.196-rc1.gz <https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.10.196-rc1.gz>
>      > or in the git tree and branch at:
>      >     
>       git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git <http://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git> linux-5.10.y
>      > and the diffstat can be found below.
>      >
>      > thanks,
>      >
>      > greg k-h
> 
>     perf fails to build on ARM, ARM64 and MIPS with:
> 
>     fixdep: error opening depfile:
>     /local/users/fainelli/buildroot/output/bmips/build/linux-custom/tools/perf/pmu-events/.pmu-events.o.d:
>     No such file or directory
>     make[5]: *** [pmu-events/Build:33:
>     /local/users/fainelli/buildroot/output/bmips/build/linux-custom/tools/perf/pmu-events/pmu-events.o]
>     Error 2
>     make[4]: *** [Makefile.perf:653:
>     /local/users/fainelli/buildroot/output/bmips/build/linux-custom/tools/perf/pmu-events/pmu-events-in.o]
>     Error 2
>     make[3]: *** [Makefile.perf:229: sub-make] Error 2
>     make[2]: *** [Makefile:70: all] Error 2
>     make[1]: *** [package/pkg-generic.mk:294 <http://pkg-generic.mk:294>:
>     /local/users/fainelli/buildroot/output/bmips/build/linux-tools/.stamp_built]
>     Error 2
>     make: *** [Makefile:27: _all] Error 2
> 
>     this is caused by 653fc524e350b62479529140dc9abef05abbcc29 ("perf
>     build:
>     Update build rule for generated files"). Reverting that commit plus
>     5804de1f2324ddcfe3f0b6ad58fcfe4d344e0471 ("perf jevents: Switch
>     build to
>     use jevents.py") gets us going again.
> 
> 
> Given the perf tool is backward compatible, does doing backports make sense?

For bugfixes certainly this does not appear to be one though?
-- 
Florian

