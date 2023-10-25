Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4AB4C7D76BC
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Oct 2023 23:26:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231238AbjJYV0f convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 25 Oct 2023 17:26:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230139AbjJYV0b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Oct 2023 17:26:31 -0400
Received: from mail-oi1-f195.google.com (mail-oi1-f195.google.com [209.85.167.195])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90EA3133;
        Wed, 25 Oct 2023 14:26:28 -0700 (PDT)
Received: by mail-oi1-f195.google.com with SMTP id 5614622812f47-3b2ea7cc821so119242b6e.1;
        Wed, 25 Oct 2023 14:26:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698269188; x=1698873988;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bycYRpKutA54sAg5Um6zIBBwK+58+5So40ro8xEesqM=;
        b=gkHQFJxF5J9kz4MX0HTKDO7JlI6hOxo8kiVovhTBD6m05XAjr/KnEKi/cBASlhEUR6
         Rl63LhgTC9cH/EjqdGy+9qlSeKTB7tp3/NQ+22Kkqz9H/mM4wL+uzXj9L2NaGqmbXd8u
         X/IdHdNigbkwlDz8FuCcxUahrA1q1bSgy0ghnVQ4E//QNapUODA2MHJ22YDLn1fzBuMr
         uTIHaWjU8El1m0Ld+OpKeCLm4PTGeDOMkjG3EvFg8FHbRoUP0OJkFvVOInu5dsBiE5TD
         ANw7YdkVjqd/8SqgofhphmJPRcIzw9TFq9pgulOVzdtgys7K+vWzgRv0APeOz/bpqhdf
         /ulQ==
X-Gm-Message-State: AOJu0YwX/t8894hTn+lO3o75njVKvKGzxvdgj6l3Ro0UBZtpqPbrylKZ
        Pr1/WPWOAUrJDzmeCy2uPnzNMq7zf8gJ7r6V
X-Google-Smtp-Source: AGHT+IGtpup1YTQe8ThkrlvYEjVGJ9NcjSzvhKax9Qr2HcYNHn2BseflXWwgsa2Q87iy+J3wTAOR8g==
X-Received: by 2002:a05:6808:210e:b0:3ae:1b21:fab1 with SMTP id r14-20020a056808210e00b003ae1b21fab1mr21401936oiw.31.1698269187812;
        Wed, 25 Oct 2023 14:26:27 -0700 (PDT)
Received: from mail-oi1-f176.google.com (mail-oi1-f176.google.com. [209.85.167.176])
        by smtp.gmail.com with ESMTPSA id k4-20020a544404000000b003ae53e64549sm2555000oiw.31.2023.10.25.14.26.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 25 Oct 2023 14:26:27 -0700 (PDT)
Received: by mail-oi1-f176.google.com with SMTP id 5614622812f47-3b2e44c7941so110947b6e.2;
        Wed, 25 Oct 2023 14:26:27 -0700 (PDT)
X-Received: by 2002:a05:6808:910:b0:3ab:843f:76fd with SMTP id
 w16-20020a056808091000b003ab843f76fdmr17679850oih.19.1698269187452; Wed, 25
 Oct 2023 14:26:27 -0700 (PDT)
MIME-Version: 1.0
References: <20231009130126.697995596@linuxfoundation.org> <ZSRVgj5AqJbDXqZU@duo.ucw.cz>
 <ZSRe78MAQwbBdyFP@duo.ucw.cz> <ZSUy+zA0+Chm6dFb@duo.ucw.cz>
 <ZSU+GHl1q7T/TBp5@duo.ucw.cz> <ZSWg1fv3gOyV5t+h@shikoro> <2023101057-runny-pellet-8952@gregkh>
 <ZTgZa1ic1iFbdaTM@duo.ucw.cz> <CAMuHMdXQApuOPfU1zNKcHKN5=fCuLBSDiLtF06U7e4Tx0+noyA@mail.gmail.com>
 <CAMuHMdVrdmBgopnPnJK_ij52wz2WVBdYRHur2KfosFnT945ULw@mail.gmail.com>
 <CAMuHMdWZvTGrFgx_o3g3usOwkDvD2rw5QH9_ibo=OKdw17sAzg@mail.gmail.com>
 <CAMuHMdXvpiGQ7jqAG69Zo=10wV-E0bioC9AYUHwwhRGmLXygWA@mail.gmail.com>
 <7d7a5a15-3349-adce-02cd-82b6cb4bebde@roeck-us.net> <CAMuHMdXbPZ0uz0NnE1xhUD=QtaAq+TinSW-PrWPMpGe4h=7Spg@mail.gmail.com>
In-Reply-To: <CAMuHMdXbPZ0uz0NnE1xhUD=QtaAq+TinSW-PrWPMpGe4h=7Spg@mail.gmail.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Wed, 25 Oct 2023 23:26:15 +0200
X-Gmail-Original-Message-ID: <CAMuHMdXNjopzEFCFBxxuYNCFMmj4SvMQ2PmZ4hZDHLGZGUHf=w@mail.gmail.com>
Message-ID: <CAMuHMdXNjopzEFCFBxxuYNCFMmj4SvMQ2PmZ4hZDHLGZGUHf=w@mail.gmail.com>
Subject: Re: renesas_sdhi problems in 5.10-stable was Re: [PATCH 5.10 000/226]
 5.10.198-rc1 review
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Pavel Machek <pavel@denx.de>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        niklas.soderlund+renesas@ragnatech.se,
        yoshihiro.shimoda.uh@renesas.com, biju.das.jz@bp.renesas.com,
        Chris.Paterson2@renesas.com, stable@vger.kernel.org,
        patches@lists.linux.dev, linux-kernel@vger.kernel.org,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, jonathanh@nvidia.com,
        f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
        srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org,
        Linux MMC List <linux-mmc@vger.kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 25, 2023 at 9:53 PM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> On Wed, Oct 25, 2023 at 8:39 PM Guenter Roeck <linux@roeck-us.net> wrote:
> > On 10/25/23 10:05, Geert Uytterhoeven wrote:
> > > On Wed, Oct 25, 2023 at 2:35 PM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> > >> On Wed, Oct 25, 2023 at 12:53 PM Geert Uytterhoeven
> > >> <geert@linux-m68k.org> wrote:
> > >>> On Wed, Oct 25, 2023 at 12:47 PM Geert Uytterhoeven
> > >>> <geert@linux-m68k.org> wrote:
> > >>>> On Tue, Oct 24, 2023 at 9:22 PM Pavel Machek <pavel@denx.de> wrote:
> > >>>>> But we still have failures on Renesas with 5.10.199-rc2:
> > >>>>>
> > >>>>> https://gitlab.com/cip-project/cip-testing/linux-stable-rc-ci/-/pipelines/1047368849
> > >>>>>
> > >>>>> And they still happed during MMC init:
> > >>>>>
> > >>>>>      2.638013] renesas_sdhi_internal_dmac ee100000.mmc: Got CD GPIO
> > >>>>> [    2.638846] INFO: trying to register non-static key.
> > >>>>> [    2.644192] ledtrig-cpu: registered to indicate activity on CPUs
> > >>>>> [    2.649066] The code is fine but needs lockdep annotation, or maybe
> > >>>>> [    2.649069] you didn't initialize this object before use?
> > >>>>> [    2.649071] turning off the locking correctness validator.
> > >>>>> [    2.649080] CPU: 0 PID: 0 Comm: swapper/0 Not tainted 5.10.199-rc2-arm64-renesas-ge31b6513c43d #1
> > >>>>> [    2.649082] Hardware name: HopeRun HiHope RZ/G2M with sub board (DT)
> > >>>>> [    2.649086] Call trace:
> > >>>>> [    2.655106] SMCCC: SOC_ID: ARCH_SOC_ID not implemented, skipping ....
> > >>>>> [    2.661354]  dump_backtrace+0x0/0x194
> > >>>>> [    2.661361]  show_stack+0x14/0x20
> > >>>>> [    2.667430] usbcore: registered new interface driver usbhid
> > >>>>> [    2.672230]  dump_stack+0xe8/0x130
> > >>>>> [    2.672238]  register_lock_class+0x480/0x514
> > >>>>> [    2.672244]  __lock_acquire+0x74/0x20ec
> > >>>>> [    2.681113] usbhid: USB HID core driver
> > >>>>> [    2.687450]  lock_acquire+0x218/0x350
> > >>>>> [    2.687456]  _raw_spin_lock+0x58/0x80
> > >>>>> [    2.687464]  tmio_mmc_irq+0x410/0x9ac
> > >>>>> [    2.688556] renesas_sdhi_internal_dmac ee160000.mmc: mmc0 base at 0x00000000ee160000, max clock rate 200 MHz
> > >>>>> [    2.744936]  __handle_irq_event_percpu+0xbc/0x340
> > >>>>> [    2.749635]  handle_irq_event+0x60/0x100
> > >>>>> [    2.753553]  handle_fasteoi_irq+0xa0/0x1ec
> > >>>>> [    2.757644]  __handle_domain_irq+0x7c/0xdc
> > >>>>> [    2.761736]  efi_header_end+0x4c/0xd0
> > >>>>> [    2.765393]  el1_irq+0xcc/0x180
> > >>>>> [    2.768530]  arch_cpu_idle+0x14/0x2c
> > >>>>> [    2.772100]  default_idle_call+0x58/0xe4
> > >>>>> [    2.776019]  do_idle+0x244/0x2c0
> > >>>>> [    2.779242]  cpu_startup_entry+0x20/0x6c
> > >>>>> [    2.783160]  rest_init+0x164/0x28c
> > >>>>> [    2.786561]  arch_call_rest_init+0xc/0x14
> > >>>>> [    2.790565]  start_kernel+0x4c4/0x4f8
> > >>>>> [    2.794233] Unable to handle kernel NULL pointer dereference at virtual address 0000000000000014
> > >>>>> [    2.803011] Mem abort info:
> > >>>>>
> > >>>>> from https://lava.ciplatform.org/scheduler/job/1025535
> > >>>>> from
> > >>>>> https://gitlab.com/cip-project/cip-testing/linux-stable-rc-ci/-/jobs/5360973735 .
> > >>>>>
> > >>>>> Is there something else missing?
> > >>>>
> > >>>> I don't have a HopeRun HiHope RZ/G2M, but both v5.10.198 and v5.10.199
> > >>>> seem to work fine on Salvator-XS with R-Car H3 ES2.0 and Salvator-X
> > >>>> with R-Car M3-W ES1.0, using a config based on latest renesas_defconfig.
> > >>>
> > >>> Sorry, I looked at the wrong log on R-Car M3-W.
> > >>> I do see the issue with v5.10.198, but not with v5.10.199.
> > >>
> > >> It seems to be an intermittent issue. Investigating...
> > >
> > > After spending too much time on bisecting, the bad guy turns out to
> > > be commit 6d3745bbc3341d3b ("mmc: renesas_sdhi: register irqs before
> > > registering controller") in v5.10.198.
> > >
> > > Adding debug information shows the lock is mmc_host.lock.
> > >
> > > It is definitely initialized:
> > >
> > >      renesas_sdhi_probe()
> > >      {
> > >          ...
> > >          tmio_mmc_host_alloc()
> > >              mmc_alloc_host
> > >                  spin_lock_init(&host->lock);

Initializing mmc_host.lock.

> > >          ...
> > >          devm_request_irq()
> > >          -> tmio_mmc_irq
> > >              tmio_mmc_cmd_irq()
> > >                  spin_lock(&host->lock);

Locking tmio_mmc_host.lock, but ...

> > >          ...
> > >      }
> > >
> > > That leaves us with a missing lockdep annotation?
> >
> > Is it possible that the lock initialization is overwritten ?
> > I seem to recall a recent case where this happens.
> >
> > Also, there is
> >         spin_lock_init(&_host->lock);
> > in tmio_mmc_host_probe(), and tmio_mmc_host_probe() is called after
> > devm_request_irq().
>
> Unless I am missing something, that is initializing tmio_mmc_host.lock,
> which is a different lock than mmc_host.lock?

... tmio_mmc_host.lock is initialized only here.

Now the question remains why this is not triggered in mainline.
More investigation to do tomorrow...

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
