Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A237C76CC9A
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Aug 2023 14:25:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233821AbjHBMZe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Aug 2023 08:25:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233782AbjHBMZc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Aug 2023 08:25:32 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E90E426A8
        for <linux-kernel@vger.kernel.org>; Wed,  2 Aug 2023 05:25:29 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id 98e67ed59e1d1-26830595676so4764497a91.2
        for <linux-kernel@vger.kernel.org>; Wed, 02 Aug 2023 05:25:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1690979129; x=1691583929;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xGDC2y4/GIKVyQuDTwjWu7bIkr4WAVPjV1MNJFYZAjA=;
        b=nOrlb/8WnlhynD/pHfW0h8qOPk7RMA24QDem/0k7GCeTk/ljDpmBN8So1cycaItDz9
         uOxh06BSqHjejpoSDX1cl6Gs55wYBgUlOUFA+Ma6RJOhjSwE6q+uAlzuWfvCYOhk2E58
         u1hLVhzsXzFNbWWgFz4Zl+fQaiInZ8ZUnS3S7JSJ1INckJsgj3hIcgzORAF4DUv0fGSL
         LGeiEeqYyfrnKenp41WH6BJalcWhBF3ROEJujqpUx6AONi36hp+S0uCN6/gyCCj5nXb/
         YfCnqVepvLEFluA3el4BN+rPxuksWUg5gjh2pZ/MlmK6GX/cuezGRzu1z795CFA4ooef
         9tyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690979129; x=1691583929;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xGDC2y4/GIKVyQuDTwjWu7bIkr4WAVPjV1MNJFYZAjA=;
        b=ffLyjSb/WsO9e9r5oL2MQhgfmwekKcCtVIfIgg8u9wKkMBvcq+dBaC3IxYG7SEVGO8
         mUuP/ZdiQ+2E7LHqdgAOfM6zUgitgiVZJS2MNdOsICxxw/fevfdbkMSq/I4zbz7XKDeW
         KlUmIuz+H0EY+G37E+NMLzuSXh8XwT2Gw5CX1o38MsQQJSPTzSpT2V0S2By1yV/Jlx1n
         tHKFKxerPCR3IJTOXRKi0tRG7WlPOnMscccUquH6E2RYi6KPcv54cpJe6ZOXUTWXbIf8
         hYl8EBTHyfDvNdzRP9X5yM+wwMpa12u9cCzRrrfm4F+qlJJxUpDW0HgCb94qm4k2Jv4w
         sxSA==
X-Gm-Message-State: ABy/qLaKoVZS4TM+c8rR4/p17AQ3gpQpPAEV4Crs3MwDm9d/rBkWKq1S
        Z+W1Pza2HXwNWOJSN8rhQYXXMaemmELJgv68U61UoQ==
X-Google-Smtp-Source: APBJJlH5Cwhcg/8nWFbj+FX9DBv3vahHDq1M42mj6hRfUzLh/NvzrUJjro6gAeiu1hCV1zqKA17KOHwD54Hn9AKnikU=
X-Received: by 2002:a17:90b:2551:b0:268:5620:cfc7 with SMTP id
 nw17-20020a17090b255100b002685620cfc7mr14458070pjb.30.1690979129249; Wed, 02
 Aug 2023 05:25:29 -0700 (PDT)
MIME-Version: 1.0
References: <20230719113542.2293295-1-apatel@ventanamicro.com>
 <20230719113542.2293295-5-apatel@ventanamicro.com> <ZMItuhqTCJCirg4s@sunil-laptop>
In-Reply-To: <ZMItuhqTCJCirg4s@sunil-laptop>
From:   Anup Patel <apatel@ventanamicro.com>
Date:   Wed, 2 Aug 2023 17:55:17 +0530
Message-ID: <CAK9=C2V_Pf2JAKRvufU9J2OmFkaAO3MuonDBvZDKTJGNb=vBOw@mail.gmail.com>
Subject: Re: [PATCH v6 04/14] irqchip/sifive-plic: Use platform driver probing
 for PLIC
To:     Sunil V L <sunilvl@ventanamicro.com>
Cc:     Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Conor Dooley <conor+dt@kernel.org>,
        Atish Patra <atishp@atishpatra.org>,
        Andrew Jones <ajones@ventanamicro.com>,
        Saravana Kannan <saravanak@google.com>,
        Anup Patel <anup@brainfault.org>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sunil,

On Thu, Jul 27, 2023 at 2:11=E2=80=AFPM Sunil V L <sunilvl@ventanamicro.com=
> wrote:
>
> Hi Anup,
>
> On Wed, Jul 19, 2023 at 05:05:32PM +0530, Anup Patel wrote:
> > The PLIC driver does not require very early initialization so let us
> > replace use of IRQCHIP_DECLARE() with IRQCHIP_PLATFORM_DRIVER_xyz()
> > so that PLIC is probed through platform driver probing.
> >
> > Signed-off-by: Anup Patel <apatel@ventanamicro.com>
> > ---
> >  drivers/irqchip/irq-sifive-plic.c | 12 ++++++++----
> >  1 file changed, 8 insertions(+), 4 deletions(-)
> >
> > diff --git a/drivers/irqchip/irq-sifive-plic.c b/drivers/irqchip/irq-si=
five-plic.c
> > index 56b0544b1f27..dc02f0761ced 100644
> > --- a/drivers/irqchip/irq-sifive-plic.c
> > +++ b/drivers/irqchip/irq-sifive-plic.c
> > @@ -569,8 +569,10 @@ static int __init plic_init(struct device_node *no=
de,
> >       return __plic_init(node, parent, 0);
> >  }
> >
> > -IRQCHIP_DECLARE(sifive_plic, "sifive,plic-1.0.0", plic_init);
> > -IRQCHIP_DECLARE(riscv_plic0, "riscv,plic0", plic_init); /* for legacy =
systems */
> > +IRQCHIP_PLATFORM_DRIVER_BEGIN(sifive_plic)
> > +IRQCHIP_MATCH("sifive,plic-1.0.0", plic_init)
> > +IRQCHIP_MATCH("riscv,plic0", plic_init) /* for legacy systems */
> > +IRQCHIP_PLATFORM_DRIVER_END(sifive_plic)
> >
> Few observations..
>
> 1) IRQCHIP_PLATFORM_DRIVER_xyz work only for DT. Can we have more generic
> platform driver probe similar to APLIC driver?

Okay, I will convert it into generic platform driver which
will work for ACPI as well.

>
> 2) With platform driver model, there is a crash some times.
>
> [    0.198665] CPU: 4 PID: 32 Comm: cpuhp/4 Not tainted
> 6.5.0-rc3-00038-g782440711cdb #42
> [    0.198944] Hardware name: riscv-virtio,qemu (DT)
> [    0.199125] epc : plic_starting_cpu+0x60/0xa6
> [    0.199545]  ra : plic_starting_cpu+0x58/0xa6
> [    0.199676] epc : ffffffff8047396e ra : ffffffff80473966 sp :
> ff20000000173d80
> [    0.199899]  gp : ffffffff81501740 tp : ff600000019bde00 t0 :
> ffffffff81200800
> [    0.200112]  t1 : 0000000000000000 t2 : 0000000000001000 s0 :
> ff20000000173db0
> [    0.200324]  s1 : ff6000007ef91eb0 a0 : ff600000019690b0 a1 :
> 0000000200000020
> [    0.200502]  a2 : 0000000000000000 a3 : 0000000000000000 a4 :
> 0000000000000000
> [    0.200678]  a5 : 0000000000000000 a6 : ff6000000184a108 a7 :
> ff6000000184a100
> [    0.200855]  s2 : 000000000000000b s3 : ffffffff8153a550 s4 :
> 0000000000000004
> [    0.201032]  s5 : 0000000000000001 s6 : 0000000000000002 s7 :
> ffffffff8047390e
> [    0.201210]  s8 : ffffffff80033f8a s9 : ffffffff80033f64 s10:
> 0000000000000000
> [    0.201392]  s11: 0000000000000000 t3 : 0000000000000000 t4 :
> ffffffff81486c20
> [    0.201567]  t5 : 0000000000000002 t6 : 0000000000000002
> [    0.201702] status: 0000000200000100 badaddr: 0000000000000000 cause:
> 000000000000000f
> [    0.201962] [<ffffffff8047396e>] plic_starting_cpu+0x60/0xa6
> [    0.202184] [<ffffffff8001069e>] cpuhp_invoke_callback+0xb4/0x164
> [    0.202346] [<ffffffff80010972>] cpuhp_thread_fun+0x8a/0x11c
> [    0.202493] [<ffffffff80033f62>] smpboot_thread_fn+0xe4/0x1be
> [    0.202639] [<ffffffff8003042a>] kthread+0xc4/0xe0
> [    0.202759] [<ffffffff8000355e>] ret_from_fork+0xa/0x1c
> [    0.203038] Code: 89bd 854a 3097 ffbf 80e7 51e0 000f 0140 4781 6498
> (c31c) 2703

The cpuhp setup needed to change since as platform driver the
PLIC is probed after all CPUs are brought-up. I will fix this in
the next revision.

>
> 3) Looks like an existing issue but I get below warning also.
>
> [    0.207677] list_add double add: new=3Dffffffff814a0798,
> prev=3Dffffffff814a0798, next=3Dffffffff814be638.
> [    0.208243] WARNING: CPU: 4 PID: 1 at lib/list_debug.c:33
> __list_add_valid+0x46/0xac
> [    0.208677] Modules linked in:
> [    0.208780] CPU: 4 PID: 1 Comm: swapper/0 Not tainted
> 6.5.0-rc3-00038-g782440711cdb #28
> [    0.208862] Hardware name: riscv-virtio,qemu (DT)
> [    0.208926] epc : __list_add_valid+0x46/0xac
> [    0.208961]  ra : __list_add_valid+0x46/0xac
> [    0.208983] epc : ffffffff803cb356 ra : ffffffff803cb356 sp :
> ff200000000439f0
> [    0.208994]  gp : ffffffff81501740 tp : ff600000018f0000 t0 :
> 2000000000000000
> [    0.209005]  t1 : 000000000000006c t2 : 206464615f747369 s0 :
> ff20000000043a00
> [    0.209015]  s1 : ffffffff814a0798 a0 : 0000000000000058 a1 :
> ffffffff81486828
> [    0.209025]  a2 : 0000000000000000 a3 : fffffffffffffffe a4 :
> 0000000000000000
> [    0.209034]  a5 : 0000000000000000 a6 : 0000000000000068 a7 :
> 0000000000000038
> [    0.209044]  s2 : ffffffff814be5f8 s3 : ffffffff814a0798 s4 :
> ffffffff814be638
> [    0.209053]  s5 : ff6000007fff75c0 s6 : 0000000000000060 s7 :
> ffffffff80c20eb0
> [    0.209063]  s8 : 0000000000000008 s9 : 0000000000000004 s10:
> ffffffff80c20eb0
> [    0.209072]  s11: ffffffff81038e80 t3 : ffffffff815159d7 t4 :
> ffffffff815159d7
> [    0.209081]  t5 : ffffffff815159d8 t6 : ff200000000437f8
> [    0.209090] status: 0000000200000120 badaddr: 0000000000000000 cause:
> 0000000000000003
> [    0.209167] [<ffffffff803cb356>] __list_add_valid+0x46/0xac
> [    0.209219] [<ffffffff805812d4>] register_syscore_ops+0x3e/0x70
> [    0.209245] [<ffffffff80a1fd0c>] __plic_init.isra.0+0x3e0/0x4e2
> [    0.209267] [<ffffffff80a1fe3a>] plic_init+0x12/0x1a
> [    0.209281] [<ffffffff80470c10>] platform_irqchip_probe+0x82/0xb4
> [    0.209292] [<ffffffff80582aa8>] platform_probe+0x4e/0xa6
> [    0.209301] [<ffffffff805805a4>] really_probe+0x86/0x242
> [    0.209308] [<ffffffff805807bc>] __driver_probe_device+0x5c/0xda
> [    0.209316] [<ffffffff80580866>] driver_probe_device+0x2c/0xb2
> [    0.209324] [<ffffffff805809e6>] __driver_attach+0x6c/0x11a
> [    0.209331] [<ffffffff8057e73a>] bus_for_each_dev+0x60/0xae
> [    0.209343] [<ffffffff8057fff6>] driver_attach+0x1a/0x22
> [    0.209352] [<ffffffff8057f956>] bus_add_driver+0xd0/0x1ba
> [    0.209362] [<ffffffff80581634>] driver_register+0x3e/0xd8
> [    0.209370] [<ffffffff805827c0>] __platform_driver_register+0x1c/0x24
> [    0.209378] [<ffffffff80a1f902>] sifive_plic_driver_init+0x1a/0x22
> [    0.209389] [<ffffffff8000212c>] do_one_initcall+0x58/0x19c
> [    0.209399] [<ffffffff80a01056>] kernel_init_freeable+0x20c/0x276
> [    0.209410] [<ffffffff808d6686>] kernel_init+0x1e/0x10a
> [    0.209421] [<ffffffff8000355e>] ret_from_fork+0xa/0x1c
> [    0.209477] ---[ end trace 0000000000000000 ]---

This is a bug in current PLIC driver where it unconditionally
registers syscore ops which breaks on multi-socket systems
having multiple PLICs. I will add a separate patch in the
next revision to fix this issue.

Regards,
Anup
