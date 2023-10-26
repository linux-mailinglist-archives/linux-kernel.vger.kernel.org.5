Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C1067D8245
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Oct 2023 14:08:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344872AbjJZMIj convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 26 Oct 2023 08:08:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229642AbjJZMIh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Oct 2023 08:08:37 -0400
Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E4A21A6;
        Thu, 26 Oct 2023 05:08:35 -0700 (PDT)
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-5a7a80a96dbso17192987b3.0;
        Thu, 26 Oct 2023 05:08:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698322114; x=1698926914;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3KKbxpaRdKQQQLvpY2x+Hdf2Y5BAYNzBsK+Et59KcX8=;
        b=ADxCBZjkuPmbALPFjGI0cRx5TBP6YQYRzuMWM8y3VNYdibuyVDxwu/dZruIXPN0JlL
         MDqmSV+lzBsKEKJQgmcVqrBfRbgsi36IroW3865gzKvSl1mYnLfbwduO+e/XyI04mHxT
         Lig7rPWmRU8nphSuyqGl//Zb/tL8+x5aIv8OdogZKYLODd1AvE3z1cfFM2Sp3BkIVeYF
         C3j3EFhm2N9w/dt0znjgvv5ygj2drJNwapnUaGlR2Y9ziAmbcb3HZ1AQSrKtydoaV8/8
         mDbRofo+V0wF2o94fxMYphPxMc0h9XT+oWixewvyRROzG7WAct2Gejw3VSd4fdetzDHA
         BgXQ==
X-Gm-Message-State: AOJu0Yx1q4SuiDSOBfV+4DdCpbTGFTeDsFjuxad9ILP1980lfTfzeKfT
        zFJbbb1206JmxdTdf7+TDWV/bB/Srk6FbQ==
X-Google-Smtp-Source: AGHT+IGKOtB5Vdi4SScA8sBNSp1erZ9WAmvPnQ2C3ohONPE3QNZ6GzYGBtj5vdT5/zgcz9CsqJT+kg==
X-Received: by 2002:a0d:e682:0:b0:5a7:dac8:2fa with SMTP id p124-20020a0de682000000b005a7dac802famr4070833ywe.24.1698322114027;
        Thu, 26 Oct 2023 05:08:34 -0700 (PDT)
Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com. [209.85.128.172])
        by smtp.gmail.com with ESMTPSA id f5-20020a0ddc05000000b005a7bf2aff15sm5976139ywe.95.2023.10.26.05.08.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 26 Oct 2023 05:08:33 -0700 (PDT)
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-59e88a28b98so7109127b3.1;
        Thu, 26 Oct 2023 05:08:33 -0700 (PDT)
X-Received: by 2002:a81:eb04:0:b0:5a7:a896:3f54 with SMTP id
 n4-20020a81eb04000000b005a7a8963f54mr3275652ywm.26.1698322113544; Thu, 26 Oct
 2023 05:08:33 -0700 (PDT)
MIME-Version: 1.0
References: <20231009130126.697995596@linuxfoundation.org> <ZSRVgj5AqJbDXqZU@duo.ucw.cz>
 <ZSRe78MAQwbBdyFP@duo.ucw.cz> <ZSUy+zA0+Chm6dFb@duo.ucw.cz>
 <ZSU+GHl1q7T/TBp5@duo.ucw.cz> <ZSWg1fv3gOyV5t+h@shikoro> <2023101057-runny-pellet-8952@gregkh>
 <ZTgZa1ic1iFbdaTM@duo.ucw.cz> <CAMuHMdXQApuOPfU1zNKcHKN5=fCuLBSDiLtF06U7e4Tx0+noyA@mail.gmail.com>
 <CAMuHMdVrdmBgopnPnJK_ij52wz2WVBdYRHur2KfosFnT945ULw@mail.gmail.com>
 <CAMuHMdWZvTGrFgx_o3g3usOwkDvD2rw5QH9_ibo=OKdw17sAzg@mail.gmail.com>
 <CAMuHMdXvpiGQ7jqAG69Zo=10wV-E0bioC9AYUHwwhRGmLXygWA@mail.gmail.com>
 <7d7a5a15-3349-adce-02cd-82b6cb4bebde@roeck-us.net> <CAMuHMdXbPZ0uz0NnE1xhUD=QtaAq+TinSW-PrWPMpGe4h=7Spg@mail.gmail.com>
 <CAMuHMdXNjopzEFCFBxxuYNCFMmj4SvMQ2PmZ4hZDHLGZGUHf=w@mail.gmail.com>
In-Reply-To: <CAMuHMdXNjopzEFCFBxxuYNCFMmj4SvMQ2PmZ4hZDHLGZGUHf=w@mail.gmail.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Thu, 26 Oct 2023 14:08:20 +0200
X-Gmail-Original-Message-ID: <CAMuHMdU7-5R4NkwMdbLxovBY4=ePtPDs2SYXjWeGc_Yz3JcjPg@mail.gmail.com>
Message-ID: <CAMuHMdU7-5R4NkwMdbLxovBY4=ePtPDs2SYXjWeGc_Yz3JcjPg@mail.gmail.com>
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
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 25, 2023 at 11:26 PM Geert Uytterhoeven
<geert@linux-m68k.org> wrote:
> On Wed, Oct 25, 2023 at 9:53 PM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> > On Wed, Oct 25, 2023 at 8:39 PM Guenter Roeck <linux@roeck-us.net> wrote:
> > > On 10/25/23 10:05, Geert Uytterhoeven wrote:
> > > > On Wed, Oct 25, 2023 at 2:35 PM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> > > >> On Wed, Oct 25, 2023 at 12:53 PM Geert Uytterhoeven
> > > >> <geert@linux-m68k.org> wrote:
> > > >>> On Wed, Oct 25, 2023 at 12:47 PM Geert Uytterhoeven
> > > >>> <geert@linux-m68k.org> wrote:
> > > >>>> On Tue, Oct 24, 2023 at 9:22 PM Pavel Machek <pavel@denx.de> wrote:
> > > >>>>> But we still have failures on Renesas with 5.10.199-rc2:
> > > >>>>>
> > > >>>>> https://gitlab.com/cip-project/cip-testing/linux-stable-rc-ci/-/pipelines/1047368849
> > > >>>>>
> > > >>>>> And they still happed during MMC init:
> > > >>>>>
> > > >>>>>      2.638013] renesas_sdhi_internal_dmac ee100000.mmc: Got CD GPIO
> > > >>>>> [    2.638846] INFO: trying to register non-static key.
> > > >>>>> [    2.644192] ledtrig-cpu: registered to indicate activity on CPUs
> > > >>>>> [    2.649066] The code is fine but needs lockdep annotation, or maybe
> > > >>>>> [    2.649069] you didn't initialize this object before use?
> > > >>>>> [    2.649071] turning off the locking correctness validator.
> > > >>>>> [    2.649080] CPU: 0 PID: 0 Comm: swapper/0 Not tainted 5.10.199-rc2-arm64-renesas-ge31b6513c43d #1
> > > >>>>> [    2.649082] Hardware name: HopeRun HiHope RZ/G2M with sub board (DT)
> > > >>>>> [    2.649086] Call trace:
> > > >>>>> [    2.655106] SMCCC: SOC_ID: ARCH_SOC_ID not implemented, skipping ....
> > > >>>>> [    2.661354]  dump_backtrace+0x0/0x194
> > > >>>>> [    2.661361]  show_stack+0x14/0x20
> > > >>>>> [    2.667430] usbcore: registered new interface driver usbhid
> > > >>>>> [    2.672230]  dump_stack+0xe8/0x130
> > > >>>>> [    2.672238]  register_lock_class+0x480/0x514
> > > >>>>> [    2.672244]  __lock_acquire+0x74/0x20ec
> > > >>>>> [    2.681113] usbhid: USB HID core driver
> > > >>>>> [    2.687450]  lock_acquire+0x218/0x350
> > > >>>>> [    2.687456]  _raw_spin_lock+0x58/0x80
> > > >>>>> [    2.687464]  tmio_mmc_irq+0x410/0x9ac
> > > >>>>> [    2.688556] renesas_sdhi_internal_dmac ee160000.mmc: mmc0 base at 0x00000000ee160000, max clock rate 200 MHz
> > > >>>>> [    2.744936]  __handle_irq_event_percpu+0xbc/0x340
> > > >>>>> [    2.749635]  handle_irq_event+0x60/0x100
> > > >>>>> [    2.753553]  handle_fasteoi_irq+0xa0/0x1ec
> > > >>>>> [    2.757644]  __handle_domain_irq+0x7c/0xdc
> > > >>>>> [    2.761736]  efi_header_end+0x4c/0xd0
> > > >>>>> [    2.765393]  el1_irq+0xcc/0x180
> > > >>>>> [    2.768530]  arch_cpu_idle+0x14/0x2c
> > > >>>>> [    2.772100]  default_idle_call+0x58/0xe4
> > > >>>>> [    2.776019]  do_idle+0x244/0x2c0
> > > >>>>> [    2.779242]  cpu_startup_entry+0x20/0x6c
> > > >>>>> [    2.783160]  rest_init+0x164/0x28c
> > > >>>>> [    2.786561]  arch_call_rest_init+0xc/0x14
> > > >>>>> [    2.790565]  start_kernel+0x4c4/0x4f8
> > > >>>>> [    2.794233] Unable to handle kernel NULL pointer dereference at virtual address 0000000000000014
> > > >>>>> [    2.803011] Mem abort info:
> > > >>>>>
> > > >>>>> from https://lava.ciplatform.org/scheduler/job/1025535
> > > >>>>> from
> > > >>>>> https://gitlab.com/cip-project/cip-testing/linux-stable-rc-ci/-/jobs/5360973735 .
> > > >>>>>
> > > >>>>> Is there something else missing?
> > > >>
> > > >> It seems to be an intermittent issue. Investigating...
> > > >
> > > > After spending too much time on bisecting, the bad guy turns out to
> > > > be commit 6d3745bbc3341d3b ("mmc: renesas_sdhi: register irqs before
> > > > registering controller") in v5.10.198.
> > > >
> > > > Adding debug information shows the lock is mmc_host.lock.
> > > >
> > > > It is definitely initialized:
> > > >
> > > >      renesas_sdhi_probe()
> > > >      {
> > > >          ...
> > > >          tmio_mmc_host_alloc()
> > > >              mmc_alloc_host
> > > >                  spin_lock_init(&host->lock);
>
> Initializing mmc_host.lock.
>
> > > >          ...
> > > >          devm_request_irq()
> > > >          -> tmio_mmc_irq
> > > >              tmio_mmc_cmd_irq()
> > > >                  spin_lock(&host->lock);
>
> Locking tmio_mmc_host.lock, but ...
>
> > > >          ...
> > > >      }
> > > >
> > > > That leaves us with a missing lockdep annotation?
> > >
> > > Is it possible that the lock initialization is overwritten ?
> > > I seem to recall a recent case where this happens.
> > >
> > > Also, there is
> > >         spin_lock_init(&_host->lock);
> > > in tmio_mmc_host_probe(), and tmio_mmc_host_probe() is called after
> > > devm_request_irq().
> >
> > Unless I am missing something, that is initializing tmio_mmc_host.lock,
> > which is a different lock than mmc_host.lock?
>
> ... tmio_mmc_host.lock is initialized only here.
>
> Now the question remains why this is not triggered in mainline.
> More investigation to do tomorrow...

| --- a/drivers/mmc/host/renesas_sdhi_core.c
| +++ b/drivers/mmc/host/renesas_sdhi_core.c
| @@ -1011,6 +1011,8 @@ int renesas_sdhi_probe(struct platform_device *pdev,
|                         renesas_sdhi_start_signal_voltage_switch;
|                 host->sdcard_irq_setbit_mask = TMIO_STAT_ALWAYS_SET_27;
|                 host->reset = renesas_sdhi_reset;

host->sdcard_irq_mask_all is not initialized in this branch

| +       } else {
| +               host->sdcard_irq_mask_all = TMIO_MASK_ALL;
|         }

|         /* Orginally registers were 16 bit apart, could be 32 or 64
nowadays */
| @@ -1098,9 +1100,7 @@ int renesas_sdhi_probe(struct platform_device *pdev,
|                 host->ops.hs400_complete = renesas_sdhi_hs400_complete;
|         }

| -       ret = tmio_mmc_host_probe(host);
| -       if (ret < 0)
| -               goto edisclk;
| +       sd_ctrl_write32_as_16_and_16(host, CTL_IRQ_MASK,
host->sdcard_irq_mask_all);

Fails to disable interrupts for real as host->sdcard_irq_mask_all is
still zero.

|         num_irqs = platform_irq_count(pdev);
|         if (num_irqs < 0) {
| @@ -1127,6 +1127,10 @@ int renesas_sdhi_probe(struct platform_device *pdev,
|                         goto eirq;
|         }

| +       ret = tmio_mmc_host_probe(host);

Initializes host->sdcard_irq_mask_all when needed and disables
interrupts:

        if (!_host->sdcard_irq_mask_all)
                _host->sdcard_irq_mask_all = TMIO_MASK_ALL;
        tmio_mmc_disable_mmc_irqs(_host, _host->sdcard_irq_mask_all);

If the interrupt came in before, we have an issue.

| +       if (ret < 0)
| +               goto edisclk;
| +
|         dev_info(&pdev->dev, "%s base at %pa, max clock rate %u MHz\n",
|                  mmc_hostname(host->mmc), &res->start,
host->mmc->f_max / 1000000);

The solution is to backport commit 9f12cac1bb88e329 ("mmc: renesas_sdhi:
use custom mask for TMIO_MASK_ALL") in v5.13.
As this doesn't backport cleanly, I'll submit a (tested) patch.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
