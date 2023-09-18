Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8EA7B7A48B4
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Sep 2023 13:46:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241270AbjIRLpj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Sep 2023 07:45:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241663AbjIRLpO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Sep 2023 07:45:14 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B80C135
        for <linux-kernel@vger.kernel.org>; Mon, 18 Sep 2023 04:44:43 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id 5b1f17b1804b1-403012f276dso47525305e9.0
        for <linux-kernel@vger.kernel.org>; Mon, 18 Sep 2023 04:44:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1695037482; x=1695642282; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=J9LKagSYj3VXzo23cIw2NyLGMGWC6MKJWv7lMBAhis8=;
        b=cRHLWRadnfIrI0N89LBji4xx7I96USj2BfVmnpTqe0pnCAR1gVXGr0Dmx5f7AarLp4
         ys3sUFu46qAo3KhPq1tZBBOXpcXChBD77HcH2+ASL1uUvR/gkLFRGDTap5WzsewQ6Ww4
         /kQCmbcFFr9KGtMxaTbwJR1/paPxnllbUZi620HtdnwpWuma1lzO4qSaBlAIrISf8B/z
         X55Y1/Omyc+ECp61TUsfBinDVxltOVuIvaCs53spEANVYSbRZ2IuUIy/Kw04APFKpxvO
         I5NL4N7x7dcnpIykxNM1W0kpWBU4wD0QDbNKJcZc6DRrOMRM616nk6n/vdLmft7PO8B3
         ImOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695037482; x=1695642282;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=J9LKagSYj3VXzo23cIw2NyLGMGWC6MKJWv7lMBAhis8=;
        b=oFUbVl5/guWds2u/xHR09QEfy247cmQi6gJtnneytt/kxoxGGawmS43PIuDSB36Loy
         WP31JVfQlOqn6K7Jnk38vbSb1TBqCfmSkk0xFzSGJDYLx7k1qE3w0l8ouYiwzE3ZgvOo
         a0aSanzyHZUAtSIbqZc/aC9gCBbCvfOD4Qk/3xYZRSZnv8gLb6WkIOwUOjXRaiIDSjfy
         nayGik3vHDNHP7pQnUCjbmNUghhVyXj7mygNnkfGF6XGdVfAyh8kgRmfK8XobKJ5AA2k
         tzLw2SItPnJKg4XYHaCR9P50u2serzSK1ZwGDYHeiF1xeKSwOUm4Ol1sbcOUgzSH9qg/
         Ta3Q==
X-Gm-Message-State: AOJu0YxPmsirV250/uV70pSYCH6kiLdHWktMEML7Uz0kiGokYcsxI77E
        ifEMWY0V4Owp4lnwuDWmqjNThKkue4jYyD3RftrbXbm67ST8egnwj1w=
X-Google-Smtp-Source: AGHT+IEgIJY3ySAfU6d0W3ZbtC04cP1HmCyhVGGvQRhnmTyHV3/lGO845QQXBc/CQN03glLBcEyiNSq8CtH2STiedvo=
X-Received: by 2002:a05:600c:3645:b0:402:ea83:45cf with SMTP id
 y5-20020a05600c364500b00402ea8345cfmr8109170wmq.2.1695037481494; Mon, 18 Sep
 2023 04:44:41 -0700 (PDT)
MIME-Version: 1.0
References: <ed59c1b9-6c5c-4774-a871-a24564f3a270@alu.unizg.hr>
 <CANn89iJv8VRPwQBAE=5-oKHGMs9JVCvCiCBwL+3QW9sJDxo5cQ@mail.gmail.com>
 <3e306b0a-24b8-60d4-c516-1db738d79e92@alu.unizg.hr> <CANn89iKyLdvSF11aHvg-Ytr+HbnHb4QXMie2N5GpZhxSHx-XtA@mail.gmail.com>
In-Reply-To: <CANn89iKyLdvSF11aHvg-Ytr+HbnHb4QXMie2N5GpZhxSHx-XtA@mail.gmail.com>
From:   Marco Elver <elver@google.com>
Date:   Mon, 18 Sep 2023 13:44:02 +0200
Message-ID: <CANpmjNNYGax0BfjA98ViGsM4rVrcaNx_SKdetgt+-SzFqB-7zg@mail.gmail.com>
Subject: Re: BUG: KCSAN: data-race in rtl8169_poll
To:     Eric Dumazet <edumazet@google.com>
Cc:     Mirsad Todorovac <mirsad.todorovac@alu.unizg.hr>,
        nic_swsd@realtek.com, Heiner Kallweit <hkallweit1@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 18 Sept 2023 at 12:39, Eric Dumazet <edumazet@google.com> wrote:
>
> On Mon, Sep 18, 2023 at 11:43=E2=80=AFAM Mirsad Todorovac
> <mirsad.todorovac@alu.unizg.hr> wrote:
> >
> > On 9/18/23 09:41, Eric Dumazet wrote:
> > > On Mon, Sep 18, 2023 at 8:15=E2=80=AFAM Mirsad Todorovac
> > > <mirsad.todorovac@alu.unizg.hr> wrote:
> > >>
> > >> Hi all,
> > >>
> > >> In the vanilla torvalds tree kernel on Ubuntu 22.04, commit 6.6.0-rc=
1-kcsan-00269-ge789286468a9,
> > >> KCSAN discovered a data-race in rtl8169_poll():
> > >>
> > >> [ 9591.740976] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > >> [ 9591.740990] BUG: KCSAN: data-race in rtl8169_poll (drivers/net/et=
hernet/realtek/r8169_main.c:4430 drivers/net/ethernet/realtek/r8169_main.c:=
4583) r8169
> > >>
> > >> [ 9591.741060] race at unknown origin, with read to 0xffff8881097731=
30 of 4 bytes by interrupt on cpu 21:
> > >> [ 9591.741073] rtl8169_poll (drivers/net/ethernet/realtek/r8169_main=
.c:4430 drivers/net/ethernet/realtek/r8169_main.c:4583) r8169
> > >> [ 9591.741135] __napi_poll (net/core/dev.c:6527)
> > >> [ 9591.741149] net_rx_action (net/core/dev.c:6596 net/core/dev.c:672=
7)
> > >> [ 9591.741161] __do_softirq (kernel/softirq.c:553)
> > >> [ 9591.741175] __irq_exit_rcu (kernel/softirq.c:427 kernel/softirq.c=
:632)
> > >> [ 9591.741185] irq_exit_rcu (kernel/softirq.c:647)
> > >> [ 9591.741194] common_interrupt (arch/x86/kernel/irq.c:247 (discrimi=
nator 14))
> > >> [ 9591.741206] asm_common_interrupt (./arch/x86/include/asm/idtentry=
.h:636)
> > >> [ 9591.741217] cpuidle_enter_state (drivers/cpuidle/cpuidle.c:291)
> > >> [ 9591.741227] cpuidle_enter (drivers/cpuidle/cpuidle.c:390)
> > >> [ 9591.741237] call_cpuidle (kernel/sched/idle.c:135)
> > >> [ 9591.741249] do_idle (kernel/sched/idle.c:219 kernel/sched/idle.c:=
282)
> > >> [ 9591.741259] cpu_startup_entry (kernel/sched/idle.c:378 (discrimin=
ator 1))
> > >> [ 9591.741268] start_secondary (arch/x86/kernel/smpboot.c:210 arch/x=
86/kernel/smpboot.c:294)
> > >> [ 9591.741281] secondary_startup_64_no_verify (arch/x86/kernel/head_=
64.S:433)
> > >>
> > >> [ 9591.741300] value changed: 0x80003fff -> 0x34044510
> > >>
> > >> [ 9591.741314] Reported by Kernel Concurrency Sanitizer on:
> > >> [ 9591.741322] CPU: 21 PID: 0 Comm: swapper/21 Tainted: G           =
  L     6.6.0-rc1-kcsan-00269-ge789286468a9-dirty #4
> > >> [ 9591.741334] Hardware name: ASRock X670E PG Lightning/X670E PG Lig=
htning, BIOS 1.21 04/26/2023
> > >> [ 9591.741343] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > >>
> > >> (The taint is not from the proprietary module, but triggered from th=
e previous reported and unfixed bug.)
> > >>
> > >> Apparently, it is this code:
> > >>
> > >> static int rtl8169_poll(struct napi_struct *napi, int budget)
> > >> {
> > >>          struct rtl8169_private *tp =3D container_of(napi, struct rt=
l8169_private, napi);
> > >>          struct net_device *dev =3D tp->dev;
> > >>          int work_done;
> > >>
> > >>          rtl_tx(dev, tp, budget);
> > >>
> > >> =E2=86=92       work_done =3D rtl_rx(dev, tp, budget);
> > >>
> > >>          if (work_done < budget && napi_complete_done(napi, work_don=
e))
> > >>                  rtl_irq_enable(tp);
> > >>
> > >>          return work_done;
> > >> }
> > >>
> > >> and
> > >>
> > >> static int rtl_rx(struct net_device *dev, struct rtl8169_private *tp=
, int budget)
> > >> {
> > >>          struct device *d =3D tp_to_dev(tp);
> > >>          int count;
> > >>
> > >>          for (count =3D 0; count < budget; count++, tp->cur_rx++) {
> > >>                  unsigned int pkt_size, entry =3D tp->cur_rx % NUM_R=
X_DESC;
> > >>                  struct RxDesc *desc =3D tp->RxDescArray + entry;
> > >>                  struct sk_buff *skb;
> > >>                  const void *rx_buf;
> > >>                  dma_addr_t addr;
> > >>                  u32 status;
> > >>
> > >> =E2=86=92               status =3D le32_to_cpu(desc->opts1);
> > >>                  if (status & DescOwn)
> > >>                          break;
> > >>
> > >>                  /* This barrier is needed to keep us from reading
> > >>                   * any other fields out of the Rx descriptor until
> > >>                   * we know the status of DescOwn
> > >>                   */
> > >>                  dma_rmb();
> > >>
> > >>                  if (unlikely(status & RxRES)) {
> > >> .
> > >> .
> > >> .
> > >>
> > >> The reason isn't obvious, so it might be interesting if this is a va=
lid report and whether it caused spurious corruption
> > >> of the network data on Realtek 8169 compatible cards ...
> > >>
> > >
> > > I think this is pretty much expected.
> > >
> > > Driver reads a piece of memory that the hardware can modify.
> > >
> > > Adding data_race() annotations could avoid these false positives.
> > >
> > >> Hope this helps.
> > >>
> > >> Best regards,
> > >> Mirsad Todorovac
> >
> > Well, another approach was this quick fix that eliminated all those rtl=
8169_poll() KCSAN warnings.
> >
> > If READ_ONCE(desc->opts1) fixed it, then maybe there is more to this th=
an meets the eye?
> >
> > -------------------------------------------------
> >   drivers/net/ethernet/realtek/r8169_main.c | 2 +-
> >   1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/net/ethernet/realtek/r8169_main.c b/drivers/net/et=
hernet/realtek/r8169_main.c
> > index 6351a2dc13bc..051551ee2a15 100644
> > --- a/drivers/net/ethernet/realtek/r8169_main.c
> > +++ b/drivers/net/ethernet/realtek/r8169_main.c
> > @@ -4427,7 +4427,7 @@ static int rtl_rx(struct net_device *dev, struct =
rtl8169_private *tp, int budget
> >                  dma_addr_t addr;
> >                  u32 status;
> >
> > -               status =3D le32_to_cpu(desc->opts1);
> > +               status =3D le32_to_cpu(READ_ONCE(desc->opts1));
> >                  if (status & DescOwn)
> >                          break;
> >
>
> This is also working, but in this case we already have barriers (
> dma_rmb() here)
> to synchronize host side and hardware (when flipping DescOwn) bit.

READ_ONCE() does not imply any (strong) barriers (it does imply
address-dependency barriers, i.e. ordering dependent reads/writes, but
if that can be relied upon if the concurrent writer is a device and
not CPU I don't know).

So in this case pairing READ_ONCE() with dma_rmb() is perfectly
reasonable: writes to desc->opts1 can happen concurrently, and the
READ_ONCE() ensures the compiler doesn't mess up that access; later
reads must be ordered by dma_rmb().

The data race here is a consequence of a concurrent write with the
read of desc->opts1. The dma_rmb() does not prevent that from
happening, and therefore we still have to mark the racing access.
