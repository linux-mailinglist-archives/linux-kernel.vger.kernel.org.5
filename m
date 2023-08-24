Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B9B5787A77
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Aug 2023 23:32:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243724AbjHXVbn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Aug 2023 17:31:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243710AbjHXVbb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Aug 2023 17:31:31 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC3261BCC;
        Thu, 24 Aug 2023 14:31:29 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id d9443c01a7336-1bf092a16c9so3222505ad.0;
        Thu, 24 Aug 2023 14:31:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692912689; x=1693517489;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lD2UxJTw52TBSwPWN6MLeKLgI7VghjB0rNkN3PbaHmI=;
        b=WGnq5aXUpYElmM2ncQpZ9o0YKDl/jqxhsMQQk9T/KJTvEjiU0lmVV+OjQWf08xGhMR
         o1yIWLZMEyHW+LM0OQTHwZx8li2WEcTeHWY3v/uckE3nesaC4O79R7Xn5torjz7RpNEZ
         iV+yNWpLZFnU3M49CWzxNrYGszbnJ/ZOxPVT6Ib9FTQKz72F/wFaJXfn4PZEGJzXhuFJ
         IavH3nsjWycfQa7YaVQ40DHbSyldncspvcdnC43AyhfrGcNX4T4AKEuZG8/O1GHd4c/R
         /lJiq663jBCEEmctL075XuhdOS7M5VMOpB68LImORlExAps9+EsJ9ReR/f19vZ75XRYP
         diyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692912689; x=1693517489;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lD2UxJTw52TBSwPWN6MLeKLgI7VghjB0rNkN3PbaHmI=;
        b=WEdehQ5mo6aGqPGT1x1gniGWih4fb8SBQMueN4rJIFnTE76FVznZS8XxMsNiZDEZiD
         L8lHtYS8HsbrtG0Wz8RDvSazT9I+FH0lHmCTFam7A9MHYx8m7C7bkEbHvCJ9MoMg+OHO
         y3Ql97ToSa5yc1c/K3yZmSjm5el88u5zOjk5PFkqdUVZZulfmT8GbjKCW47omPFQQw86
         EgbGGDQrFUWnI/jjHUG1COx4xqO0ZT5Xpei0kaf45EUx+UyvW7NMw1riGIuWyc2l25vs
         gNm6kZFs6agprJaMXLnuD8qdqI4yIeajMnKSQJZuQtmStvjJO0TvqRWYqdZZdGII0il/
         PFQQ==
X-Gm-Message-State: AOJu0YzpzScS5PdvC7vZ06zleiFi3GIkYGp1jTMO0onaVcvtTZDWFJIY
        719uSJnahFmTmt32ZHVr8tg=
X-Google-Smtp-Source: AGHT+IFoWoPTDimXdiSwrkZPPcvaXy2B1DamlMoRGf2HxNCjZ2fujAtaFMd6o805zLN8t2ZqdPVuHg==
X-Received: by 2002:a17:902:f54f:b0:1bc:7c69:925a with SMTP id h15-20020a170902f54f00b001bc7c69925amr20037842plf.33.1692912689146;
        Thu, 24 Aug 2023 14:31:29 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id e6-20020a17090301c600b001bb28b9a40dsm120738plh.11.2023.08.24.14.31.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 24 Aug 2023 14:31:28 -0700 (PDT)
Message-ID: <dfab0ed3-2a7b-dee4-76a2-2619c8900f69@gmail.com>
Date:   Thu, 24 Aug 2023 14:31:07 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 6.1 00/15] 6.1.48-rc1 review
Content-Language: en-US
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org
Cc:     patches@lists.linux.dev, linux-kernel@vger.kernel.org,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
        conor@kernel.org
References: <20230824141447.155846739@linuxfoundation.org>
From:   Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20230824141447.155846739@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/24/23 07:14, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.1.48 release.
> There are 15 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sat, 26 Aug 2023 14:14:28 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.1.48-rc1.gz
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

I was not testing system wide suspend resume until recently and am 
seeing various issues with drivers that implement resume_noirq, but only 
on a specific platform, see below. I will see about bisecting that at 
some point.

[   15.856930] Disabling non-boot CPUs ...
[   15.862349] CPU1 killed.
[   15.865684] Enabling non-boot CPUs ...
[   15.870067] CPU1 is up
[   15.872627] brcm-gisb-arb 47c400000.gisb-arb: PM: calling 
brcmstb_gisb_arb_resume_noirq+0x0/0x60 @ 1147, parent: rdb
[   15.883177] brcm-gisb-arb 47c400000.gisb-arb: PM: 
brcmstb_gisb_arb_resume_noirq+0x0/0x60 returned 0 after 2 usecs
[   15.893893] bcmgenet 47d580000.ethernet: PM: calling 
bcmgenet_resume_noirq+0x0/0xc0 @ 1147, parent: rdb
[   15.903611] bcmgenet 47d580000.ethernet: PM: 
bcmgenet_resume_noirq+0x0/0xc0 returned 0 after 303 usecs
[   36.902964] rcu: INFO: rcu_sched self-detected stall on CPU
[   36.908533] rcu:     0-....: (20991 ticks this GP) 
idle=0b1c/1/0x40000002 softirq=1785/1785 fqs=5251
[   36.917402]  (t=21008 jiffies g=1237 q=1 ncpus=2)
[   36.922104] CPU: 0 PID: 1147 Comm: rtcwake Not tainted 
6.1.45-g02e3f13ba3f3 #2
[   36.929321] Hardware name: Broadcom STB (Flattened Device Tree)
[   36.935234] PC is at _raw_spin_unlock_irqrestore+0x24/0x28
[   36.940719] LR is at resume_irqs+0x9c/0x138
[   36.944899] pc : [<c0d61f80>]    lr : [<c028c9e0>]    psr: 00030113
[   36.951159] sp : d1165e28  ip : c391f200  fp : c2204d00
[   36.956376] r10: c235e344  r9 : 40030113  r8 : c391f26c
[   36.961593] r7 : 00000000  r6 : c22489c0  r5 : 00000030  r4 : c391f200
[   36.968113] r3 : 0000000e  r2 : 00000500  r1 : 40030113  r0 : c391f26c
[   36.974634] Flags: nzcv  IRQs on  FIQs on  Mode SVC_32  ISA ARM 
Segment user
[   36.981763] Control: 30c5383d  Table: 036d12c0  DAC: fffffffd
[   36.987511]  _raw_spin_unlock_irqrestore from resume_irqs+0x9c/0x138
[   36.993865]  resume_irqs from dpm_resume_noirq+0x14/0x1c
[   36.999178]  dpm_resume_noirq from suspend_devices_and_enter+0x23c/0x890
[   37.005884]  suspend_devices_and_enter from pm_suspend+0x39c/0x414
[   37.012063]  pm_suspend from state_store+0x74/0xd4
[   37.016852]  state_store from kernfs_fop_write_iter+0x10c/0x1c4
[   37.022779]  kernfs_fop_write_iter from vfs_write+0x24c/0x354
[   37.028532]  vfs_write from ksys_write+0x60/0xd8
[   37.033148]  ksys_write from ret_fast_syscall+0x0/0x4c
[   37.038285] Exception stack(0xd1165fa8 to 0xd1165ff0)
[   37.043330] 5fa0:                   00000004 004ab3e8 00000004 
004ab3e8 00000004 00000000
[   37.051502] 5fc0: 00000004 004ab3e8 004aa180 00000004 b6ef6b2c 
0ee6b280 004aa180 0049703b
[   37.059673] 5fe0: 0000006c be89fb30 b6e21150 b6e7abbc

-- 
Florian

