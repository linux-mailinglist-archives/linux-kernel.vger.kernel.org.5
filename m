Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ACC727ED7FD
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Nov 2023 00:09:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229807AbjKOXJt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Nov 2023 18:09:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229592AbjKOXJr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Nov 2023 18:09:47 -0500
Received: from mail-qk1-x730.google.com (mail-qk1-x730.google.com [IPv6:2607:f8b0:4864:20::730])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C092A18A;
        Wed, 15 Nov 2023 15:09:43 -0800 (PST)
Received: by mail-qk1-x730.google.com with SMTP id af79cd13be357-778a20df8c3so8213585a.3;
        Wed, 15 Nov 2023 15:09:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700089783; x=1700694583; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=GEhgXm3pCMAcrpujNss809I3BLCwCALa+FWiZj75FX4=;
        b=U73lvRrX+4UazomnJdmGurXuh9ejJBplWHK7wLnl6gVaOtcv8RplSrjA0Pja4qTt7d
         lcOU6jfUYDiaHGhbQBsmLOdWyHRMObn6KfZSjSnRWBi9nIUosRQF3HP3I+uuzXvHCutJ
         yJzeu1qv1FzZ0cAi3kLXaENSMP4Mthwc5vPixtkkO38Bxar7hLhJYJgdr8qBfckJkBW+
         EyXdlvQS1r70e7M6spE1BgaEwMK2IOX7i6s6vxQMzQftju/mWyin6aNSn4buPbg6LiHr
         SB2ezmvXiswmo1SrDK/N0n+oiEmvHQHbw8WaRXKwzcMpbrMuTTDCXbR1ZUYHgunOfhAP
         Bh8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700089783; x=1700694583;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GEhgXm3pCMAcrpujNss809I3BLCwCALa+FWiZj75FX4=;
        b=jSnjDLmPNVgxoXJlDsWox03bTJFl6R0E6ta29R9hniqTvyJBYwByejfVnMcHBW2kOb
         Mmad8lVy2pkEBBKyizd/4Xy8RyhZZ+gQoKa1HOlpg3j7g9U0pUGQAAj4LGPgL9vOC9QG
         7NXVs+49YTivLYj1xLHXZnDf58CD/UVs3//IfsktLmmV+/2qWPUxjZ5zdgrYHj9Yk7QK
         iJLlJjvkQmCrdygVi/WPmOTjEmwLy0sbGFT6NhO+4smoyVTbFAxRmAowwFBSVjJoZc+4
         iAEO9e6PsQz+W/7hUK7YznA9u7Q2I7Y3R6FzAfnY6qxz1MSdLmFSfQRzj4+e2EwA1HZC
         fB9w==
X-Gm-Message-State: AOJu0YxbqfFKad2WaaHU+RrdU2BQrQDDDyjxewWfT2Ulgmka+TT6HdA+
        am+GWVelpJ4SLdvfel4xJsc=
X-Google-Smtp-Source: AGHT+IEAS1NnzwEEMb4x8DQfQwSn941Jb7gA8KqsaXlGZY+LFrKmU9zIgBl2NseseqQJYzDKboZm4A==
X-Received: by 2002:a05:620a:2941:b0:775:6785:3051 with SMTP id n1-20020a05620a294100b0077567853051mr8747477qkp.50.1700089782766;
        Wed, 15 Nov 2023 15:09:42 -0800 (PST)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id qd6-20020a05620a658600b007758b25ac3bsm3836011qkn.82.2023.11.15.15.09.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Nov 2023 15:09:42 -0800 (PST)
Message-ID: <96156352-0c64-4835-959e-1188c8fa5944@gmail.com>
Date:   Wed, 15 Nov 2023 15:09:39 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5.10 000/191] 5.10.201-rc1 review
Content-Language: en-US
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org
Cc:     patches@lists.linux.dev, linux-kernel@vger.kernel.org,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
        conor@kernel.org
References: <20231115204644.490636297@linuxfoundation.org>
From:   Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20231115204644.490636297@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/15/23 12:44, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.10.201 release.
> There are 191 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Fri, 17 Nov 2023 20:46:03 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.10.201-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.10.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h

This was caught up in the previous -rc cycle:

/local/stbopt_p/toolchains_303/stbgcc-12.3-0.2/bin/../lib/gcc/arm-unknown-linux-musleabihf/12.3.0/../../../../arm-unknown-linux-musleabihf/bin/ld: 
/local/users/fainelli/buildroot/output/arm/build/linux-custom/tools/perf/perf-in.o: 
in function `evlist__add_aux_dummy':
/local/users/fainelli/buildroot/output/arm/build/linux-custom/tools/perf/util/evlist.c:269: 
undefined reference to `evlist__dummy_event'
collect2: error: ld returned 1 exit status
make[4]: *** [Makefile.perf:655: 
/local/users/fainelli/buildroot/output/arm/build/linux-custom/tools/perf/perf] 
Error 1
make[3]: *** [Makefile.perf:229: sub-make] Error 2
make[2]: *** [Makefile:70: all] Error 2

perf fails to build because of 8911e3d6564efbb253208ba031b42fa3e672b3b0 
("perf evlist: Add evlist__add_dummy_on_all_cpus()").
-- 
Florian

