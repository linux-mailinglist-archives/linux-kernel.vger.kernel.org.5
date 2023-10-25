Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7EDA57D7377
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Oct 2023 20:40:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234889AbjJYSkY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Oct 2023 14:40:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235068AbjJYSkK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Oct 2023 14:40:10 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18E3C1B5;
        Wed, 25 Oct 2023 11:39:42 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id d9443c01a7336-1c9d407bb15so40865ad.0;
        Wed, 25 Oct 2023 11:39:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698259181; x=1698863981; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id:sender
         :from:to:cc:subject:date:message-id:reply-to;
        bh=i/57dGnw0hmLxzIRIxELl5cyuqqUZrzWlBe94Hmzyj0=;
        b=cGOWcMPMZINR93HyzJzqCQtxG6tAfy+8Wnm3tJyafC2M2BhLp4FhKiouPD79TVBPE+
         Vx5fKIsl1fwiZVGQ3sWu75s+YV+jI3KimFQrhGjGYYQ0LhPPIIIkApW+CWHNuGuGcHgp
         cP0sKoWZCKn5a81Jckzv72D3KKiZwsXhmHNDha6L0nhyjkPFLMT8GEXOSLHIuAIhvAJY
         jrb32jow3buVMpnppVglhmcgoSqCqPhM10nJsoqVOH4RYxHT3RflL8Hm8GLImm4ZFoFD
         y3eob0rsM6SKXJCbBmzH4F7X20uk5sg8rcFrMD+/mKlg7tk+ZFIhvHWgc2DFVhqrcwdo
         Ay/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698259181; x=1698863981;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=i/57dGnw0hmLxzIRIxELl5cyuqqUZrzWlBe94Hmzyj0=;
        b=uirKhd5l0t0Yf7quNPJ/6+8IV+k346SB9UQHVfaxC+HpIlOYk8toneL2u1vW8V2ILV
         jdekYRfR3hLV+ak1n/HTIi8MFYlNM11YuEVaobwe1rxIINZBntokeX3kS3RRRBWTg8nW
         DT3+O0qsSPAQCPYXbm6T3X/pkhokuida19hMajoHKBJZXOGGhz7xa7QyLeOsMxLIs/lJ
         DO5eMnv+BCxru/fYxjDg1BtTxkX+b8uO3hZyEBSJ3m+3IpBshrqY/ICv3spTHNCvkdls
         DY33cD5WFlLZWrBPJniUj3VUBD0Rq7ecdDejrdA6le3jL0fkmhZDqq0+7oG73uFabgeH
         F8Sw==
X-Gm-Message-State: AOJu0YxcKtEdYIIl4HdaTo1bAtttbxHaI52YKFZXxTJgD7LlHOFZkiVZ
        HDM/2yPtZD+qbeS+dVnAEkc=
X-Google-Smtp-Source: AGHT+IG5PZSWXf32QS0E0WGqyYs7y7kFSNQwbVY5c7KQnX5kmQa9FPVz/Cl4mvPS6BWs8P1EvoOwLA==
X-Received: by 2002:a17:902:bf4b:b0:1c9:b338:8073 with SMTP id u11-20020a170902bf4b00b001c9b3388073mr14245811pls.15.1698259181123;
        Wed, 25 Oct 2023 11:39:41 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id q9-20020a170902dac900b001b9c960ffeasm9482408plx.47.2023.10.25.11.39.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 25 Oct 2023 11:39:40 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <7d7a5a15-3349-adce-02cd-82b6cb4bebde@roeck-us.net>
Date:   Wed, 25 Oct 2023 11:39:38 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Content-Language: en-US
To:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Pavel Machek <pavel@denx.de>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        niklas.soderlund+renesas@ragnatech.se,
        yoshihiro.shimoda.uh@renesas.com, biju.das.jz@bp.renesas.com,
        Chris.Paterson2@renesas.com, stable@vger.kernel.org,
        patches@lists.linux.dev, linux-kernel@vger.kernel.org,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, jonathanh@nvidia.com,
        f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
        srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org,
        linux-reneas-soc@vger.kernel.org,
        Linux MMC List <linux-mmc@vger.kernel.org>
References: <20231009130126.697995596@linuxfoundation.org>
 <ZSRVgj5AqJbDXqZU@duo.ucw.cz> <ZSRe78MAQwbBdyFP@duo.ucw.cz>
 <ZSUy+zA0+Chm6dFb@duo.ucw.cz> <ZSU+GHl1q7T/TBp5@duo.ucw.cz>
 <ZSWg1fv3gOyV5t+h@shikoro> <2023101057-runny-pellet-8952@gregkh>
 <ZTgZa1ic1iFbdaTM@duo.ucw.cz>
 <CAMuHMdXQApuOPfU1zNKcHKN5=fCuLBSDiLtF06U7e4Tx0+noyA@mail.gmail.com>
 <CAMuHMdVrdmBgopnPnJK_ij52wz2WVBdYRHur2KfosFnT945ULw@mail.gmail.com>
 <CAMuHMdWZvTGrFgx_o3g3usOwkDvD2rw5QH9_ibo=OKdw17sAzg@mail.gmail.com>
 <CAMuHMdXvpiGQ7jqAG69Zo=10wV-E0bioC9AYUHwwhRGmLXygWA@mail.gmail.com>
From:   Guenter Roeck <linux@roeck-us.net>
Subject: Re: renesas_sdhi problems in 5.10-stable was Re: [PATCH 5.10 000/226]
 5.10.198-rc1 review
In-Reply-To: <CAMuHMdXvpiGQ7jqAG69Zo=10wV-E0bioC9AYUHwwhRGmLXygWA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/25/23 10:05, Geert Uytterhoeven wrote:
> On Wed, Oct 25, 2023 at 2:35 PM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
>> On Wed, Oct 25, 2023 at 12:53 PM Geert Uytterhoeven
>> <geert@linux-m68k.org> wrote:
>>> On Wed, Oct 25, 2023 at 12:47 PM Geert Uytterhoeven
>>> <geert@linux-m68k.org> wrote:
>>>> On Tue, Oct 24, 2023 at 9:22 PM Pavel Machek <pavel@denx.de> wrote:
>>>>> But we still have failures on Renesas with 5.10.199-rc2:
>>>>>
>>>>> https://gitlab.com/cip-project/cip-testing/linux-stable-rc-ci/-/pipelines/1047368849
>>>>>
>>>>> And they still happed during MMC init:
>>>>>
>>>>>      2.638013] renesas_sdhi_internal_dmac ee100000.mmc: Got CD GPIO
>>>>> [    2.638846] INFO: trying to register non-static key.
>>>>> [    2.644192] ledtrig-cpu: registered to indicate activity on CPUs
>>>>> [    2.649066] The code is fine but needs lockdep annotation, or maybe
>>>>> [    2.649069] you didn't initialize this object before use?
>>>>> [    2.649071] turning off the locking correctness validator.
>>>>> [    2.649080] CPU: 0 PID: 0 Comm: swapper/0 Not tainted 5.10.199-rc2-arm64-renesas-ge31b6513c43d #1
>>>>> [    2.649082] Hardware name: HopeRun HiHope RZ/G2M with sub board (DT)
>>>>> [    2.649086] Call trace:
>>>>> [    2.655106] SMCCC: SOC_ID: ARCH_SOC_ID not implemented, skipping ....
>>>>> [    2.661354]  dump_backtrace+0x0/0x194
>>>>> [    2.661361]  show_stack+0x14/0x20
>>>>> [    2.667430] usbcore: registered new interface driver usbhid
>>>>> [    2.672230]  dump_stack+0xe8/0x130
>>>>> [    2.672238]  register_lock_class+0x480/0x514
>>>>> [    2.672244]  __lock_acquire+0x74/0x20ec
>>>>> [    2.681113] usbhid: USB HID core driver
>>>>> [    2.687450]  lock_acquire+0x218/0x350
>>>>> [    2.687456]  _raw_spin_lock+0x58/0x80
>>>>> [    2.687464]  tmio_mmc_irq+0x410/0x9ac
>>>>> [    2.688556] renesas_sdhi_internal_dmac ee160000.mmc: mmc0 base at 0x00000000ee160000, max clock rate 200 MHz
>>>>> [    2.744936]  __handle_irq_event_percpu+0xbc/0x340
>>>>> [    2.749635]  handle_irq_event+0x60/0x100
>>>>> [    2.753553]  handle_fasteoi_irq+0xa0/0x1ec
>>>>> [    2.757644]  __handle_domain_irq+0x7c/0xdc
>>>>> [    2.761736]  efi_header_end+0x4c/0xd0
>>>>> [    2.765393]  el1_irq+0xcc/0x180
>>>>> [    2.768530]  arch_cpu_idle+0x14/0x2c
>>>>> [    2.772100]  default_idle_call+0x58/0xe4
>>>>> [    2.776019]  do_idle+0x244/0x2c0
>>>>> [    2.779242]  cpu_startup_entry+0x20/0x6c
>>>>> [    2.783160]  rest_init+0x164/0x28c
>>>>> [    2.786561]  arch_call_rest_init+0xc/0x14
>>>>> [    2.790565]  start_kernel+0x4c4/0x4f8
>>>>> [    2.794233] Unable to handle kernel NULL pointer dereference at virtual address 0000000000000014
>>>>> [    2.803011] Mem abort info:
>>>>>
>>>>> from https://lava.ciplatform.org/scheduler/job/1025535
>>>>> from
>>>>> https://gitlab.com/cip-project/cip-testing/linux-stable-rc-ci/-/jobs/5360973735 .
>>>>>
>>>>> Is there something else missing?
>>>>
>>>> I don't have a HopeRun HiHope RZ/G2M, but both v5.10.198 and v5.10.199
>>>> seem to work fine on Salvator-XS with R-Car H3 ES2.0 and Salvator-X
>>>> with R-Car M3-W ES1.0, using a config based on latest renesas_defconfig.
>>>
>>> Sorry, I looked at the wrong log on R-Car M3-W.
>>> I do see the issue with v5.10.198, but not with v5.10.199.
>>
>> It seems to be an intermittent issue. Investigating...
> 
> After spending too much time on bisecting, the bad guy turns out to
> be commit 6d3745bbc3341d3b ("mmc: renesas_sdhi: register irqs before
> registering controller") in v5.10.198.
> 
> Adding debug information shows the lock is mmc_host.lock.
> 
> It is definitely initialized:
> 
>      renesas_sdhi_probe()
>      {
>          ...
>          tmio_mmc_host_alloc()
>              mmc_alloc_host
>                  spin_lock_init(&host->lock);
>          ...
>          devm_request_irq()
>          -> tmio_mmc_irq
>              tmio_mmc_cmd_irq()
>                  spin_lock(&host->lock);
>          ...
>      }
> 
> That leaves us with a missing lockdep annotation?
> 

Is it possible that the lock initialization is overwritten ?
I seem to recall a recent case where this happens.

Also, there is
	spin_lock_init(&_host->lock);
in tmio_mmc_host_probe(), and tmio_mmc_host_probe() is called after
devm_request_irq().

Also, how would lockdep annotation help with "Unable to handle
kernel NULL pointer dereference at virtual address 0000000000000014"
in the log above ?

Guenter

