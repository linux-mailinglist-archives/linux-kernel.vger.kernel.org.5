Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1BEB67D6BE6
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Oct 2023 14:35:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343990AbjJYMfV convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 25 Oct 2023 08:35:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234732AbjJYMfT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Oct 2023 08:35:19 -0400
Received: from mail-ot1-f65.google.com (mail-ot1-f65.google.com [209.85.210.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20998181;
        Wed, 25 Oct 2023 05:35:17 -0700 (PDT)
Received: by mail-ot1-f65.google.com with SMTP id 46e09a7af769-6cd33d51852so3646156a34.2;
        Wed, 25 Oct 2023 05:35:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698237316; x=1698842116;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3EHsQZuTAFlWrpT/TkHiVwF2+NYzk80BIkUmSEmXuGE=;
        b=HUrvLUn7RdM9qVaPJmGO8lhmCOrvlinruaLEXBW2e3clA4UyJzR4F1+ZRundLteDQe
         EFZTCFs+DNVdHMl8nZZ6L6ndC0qtebHv77FDDmNyuQvALGqvTotJECVwXG98c0TA0AOp
         /XsK2OnFc2PDKeqQ7zmtEf6xbOn5MhFveUtfBo52EnZ9HYluTC3A+swdohVSP7CaSYFj
         od+kPpFH1KsGQXg93yKbEp+gGPPJ3I0hwxokZzNAaxJ7Apyo9WYThTM4LvvulNbZpq/C
         9EWNVccQoctjzUhmi9DMMUW6cUwi9eBtZnCZihY2uVtxCFmCWXWf4ZB8ab91XqfY+Woc
         5x2A==
X-Gm-Message-State: AOJu0YwScOmn+K5PsNVyA3A3uO4UA29U3I6tex5EY4fy0nog/JpcbUZ5
        tVxyjSa2libqezhv5/0CKHowDY1r8mGkb8cA
X-Google-Smtp-Source: AGHT+IHrOfWMJS5P+5UXmN2N/GTbOhcQYEc2emwCwtz1N0ln2IYO2WlPVV9ZsEACmQzATsj+PZ7QFA==
X-Received: by 2002:a05:6830:25d2:b0:6bd:bba9:2d63 with SMTP id d18-20020a05683025d200b006bdbba92d63mr18226172otu.9.1698237316298;
        Wed, 25 Oct 2023 05:35:16 -0700 (PDT)
Received: from mail-ot1-f50.google.com (mail-ot1-f50.google.com. [209.85.210.50])
        by smtp.gmail.com with ESMTPSA id g17-20020a9d6191000000b006ce2dd80f3csm2247320otk.17.2023.10.25.05.35.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 25 Oct 2023 05:35:16 -0700 (PDT)
Received: by mail-ot1-f50.google.com with SMTP id 46e09a7af769-6ce37683cf6so3503991a34.3;
        Wed, 25 Oct 2023 05:35:16 -0700 (PDT)
X-Received: by 2002:a05:6830:10c2:b0:6cd:a989:c7ea with SMTP id
 z2-20020a05683010c200b006cda989c7eamr16906112oto.16.1698237315941; Wed, 25
 Oct 2023 05:35:15 -0700 (PDT)
MIME-Version: 1.0
References: <20231009130126.697995596@linuxfoundation.org> <ZSRVgj5AqJbDXqZU@duo.ucw.cz>
 <ZSRe78MAQwbBdyFP@duo.ucw.cz> <ZSUy+zA0+Chm6dFb@duo.ucw.cz>
 <ZSU+GHl1q7T/TBp5@duo.ucw.cz> <ZSWg1fv3gOyV5t+h@shikoro> <2023101057-runny-pellet-8952@gregkh>
 <ZTgZa1ic1iFbdaTM@duo.ucw.cz> <CAMuHMdXQApuOPfU1zNKcHKN5=fCuLBSDiLtF06U7e4Tx0+noyA@mail.gmail.com>
 <CAMuHMdVrdmBgopnPnJK_ij52wz2WVBdYRHur2KfosFnT945ULw@mail.gmail.com>
In-Reply-To: <CAMuHMdVrdmBgopnPnJK_ij52wz2WVBdYRHur2KfosFnT945ULw@mail.gmail.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Wed, 25 Oct 2023 14:35:04 +0200
X-Gmail-Original-Message-ID: <CAMuHMdWZvTGrFgx_o3g3usOwkDvD2rw5QH9_ibo=OKdw17sAzg@mail.gmail.com>
Message-ID: <CAMuHMdWZvTGrFgx_o3g3usOwkDvD2rw5QH9_ibo=OKdw17sAzg@mail.gmail.com>
Subject: Re: renesas_sdhi problems in 5.10-stable was Re: [PATCH 5.10 000/226]
 5.10.198-rc1 review
To:     Pavel Machek <pavel@denx.de>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        niklas.soderlund+renesas@ragnatech.se,
        yoshihiro.shimoda.uh@renesas.com, geert+renesas@glider.be,
        biju.das.jz@bp.renesas.com, Chris.Paterson2@renesas.com,
        stable@vger.kernel.org, patches@lists.linux.dev,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
        patches@kernelci.org, lkft-triage@lists.linaro.org,
        jonathanh@nvidia.com, f.fainelli@gmail.com,
        sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
        conor@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Pavel,

On Wed, Oct 25, 2023 at 12:53 PM Geert Uytterhoeven
<geert@linux-m68k.org> wrote:
> On Wed, Oct 25, 2023 at 12:47 PM Geert Uytterhoeven
> <geert@linux-m68k.org> wrote:
> > On Tue, Oct 24, 2023 at 9:22 PM Pavel Machek <pavel@denx.de> wrote:
> > > But we still have failures on Renesas with 5.10.199-rc2:
> > >
> > > https://gitlab.com/cip-project/cip-testing/linux-stable-rc-ci/-/pipelines/1047368849
> > >
> > > And they still happed during MMC init:
> > >
> > >     2.638013] renesas_sdhi_internal_dmac ee100000.mmc: Got CD GPIO
> > > [    2.638846] INFO: trying to register non-static key.
> > > [    2.644192] ledtrig-cpu: registered to indicate activity on CPUs
> > > [    2.649066] The code is fine but needs lockdep annotation, or maybe
> > > [    2.649069] you didn't initialize this object before use?
> > > [    2.649071] turning off the locking correctness validator.
> > > [    2.649080] CPU: 0 PID: 0 Comm: swapper/0 Not tainted 5.10.199-rc2-arm64-renesas-ge31b6513c43d #1
> > > [    2.649082] Hardware name: HopeRun HiHope RZ/G2M with sub board (DT)
> > > [    2.649086] Call trace:
> > > [    2.655106] SMCCC: SOC_ID: ARCH_SOC_ID not implemented, skipping ....
> > > [    2.661354]  dump_backtrace+0x0/0x194
> > > [    2.661361]  show_stack+0x14/0x20
> > > [    2.667430] usbcore: registered new interface driver usbhid
> > > [    2.672230]  dump_stack+0xe8/0x130
> > > [    2.672238]  register_lock_class+0x480/0x514
> > > [    2.672244]  __lock_acquire+0x74/0x20ec
> > > [    2.681113] usbhid: USB HID core driver
> > > [    2.687450]  lock_acquire+0x218/0x350
> > > [    2.687456]  _raw_spin_lock+0x58/0x80
> > > [    2.687464]  tmio_mmc_irq+0x410/0x9ac
> > > [    2.688556] renesas_sdhi_internal_dmac ee160000.mmc: mmc0 base at 0x00000000ee160000, max clock rate 200 MHz
> > > [    2.744936]  __handle_irq_event_percpu+0xbc/0x340
> > > [    2.749635]  handle_irq_event+0x60/0x100
> > > [    2.753553]  handle_fasteoi_irq+0xa0/0x1ec
> > > [    2.757644]  __handle_domain_irq+0x7c/0xdc
> > > [    2.761736]  efi_header_end+0x4c/0xd0
> > > [    2.765393]  el1_irq+0xcc/0x180
> > > [    2.768530]  arch_cpu_idle+0x14/0x2c
> > > [    2.772100]  default_idle_call+0x58/0xe4
> > > [    2.776019]  do_idle+0x244/0x2c0
> > > [    2.779242]  cpu_startup_entry+0x20/0x6c
> > > [    2.783160]  rest_init+0x164/0x28c
> > > [    2.786561]  arch_call_rest_init+0xc/0x14
> > > [    2.790565]  start_kernel+0x4c4/0x4f8
> > > [    2.794233] Unable to handle kernel NULL pointer dereference at virtual address 0000000000000014
> > > [    2.803011] Mem abort info:
> > >
> > > from https://lava.ciplatform.org/scheduler/job/1025535
> > > from
> > > https://gitlab.com/cip-project/cip-testing/linux-stable-rc-ci/-/jobs/5360973735 .
> > >
> > > Is there something else missing?
> >
> > I don't have a HopeRun HiHope RZ/G2M, but both v5.10.198 and v5.10.199
> > seem to work fine on Salvator-XS with R-Car H3 ES2.0 and Salvator-X
> > with R-Car M3-W ES1.0, using a config based on latest renesas_defconfig.
>
> Sorry, I looked at the wrong log on R-Car M3-W.
> I do see the issue with v5.10.198, but not with v5.10.199.

It seems to be an intermittent issue. Investigating...

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
