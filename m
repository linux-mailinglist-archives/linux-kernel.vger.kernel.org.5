Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1BC7B7A4757
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Sep 2023 12:41:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241013AbjIRKk7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Sep 2023 06:40:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241155AbjIRKk3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Sep 2023 06:40:29 -0400
Received: from mail-qt1-x82a.google.com (mail-qt1-x82a.google.com [IPv6:2607:f8b0:4864:20::82a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AAA1194
        for <linux-kernel@vger.kernel.org>; Mon, 18 Sep 2023 03:39:38 -0700 (PDT)
Received: by mail-qt1-x82a.google.com with SMTP id d75a77b69052e-415155b2796so398871cf.1
        for <linux-kernel@vger.kernel.org>; Mon, 18 Sep 2023 03:39:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1695033577; x=1695638377; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YgFgssEN+TCvZv6rBHJfrb2AD2oY/VPxRnqnudH7dNk=;
        b=tKstzlNm5au+FOHU3GQef63WO5DFQqBFINadRSwAxppuayd0f9O2T8dO8VenNrRwFZ
         vloPtPZEAj759WNddFMQLkIF97rytsJ4xrUuTS16m17cJ+OCsW0dJcSGPZNiQeMpNocI
         9uC4UivMdMKNHGahOdpkAC+h1HkVujHv96oSTzMwNVqi4cdHzjL1yDcFbvrMUb6U18Z6
         +8ASWipxjEkGQ58Y2pTedf35V3CUuR+560dy+jJDQymvffkmM6PJkhX2gAM8F1tpRNX2
         68BIdLWJjAbl6W25hOgQQ4gW7CES8vbvnfQiZZR3TslK3uf91nLPN+m0q30rMtySnIOM
         30+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695033577; x=1695638377;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YgFgssEN+TCvZv6rBHJfrb2AD2oY/VPxRnqnudH7dNk=;
        b=WH0uI/mssozAzefMQ3v4x9DNiM2wFv1CFGCvPDAFv2oMwvhTZ3FAG0Q6kUQxfn8oKI
         /vd8GjL53/bbeUm4BzCwFB8Q6V3eTH9fsDZKUtfDgR3hMNpNkHnoVfCoCk7Au/c0jErE
         FiXT3KwPaibiFLUqLqqBmo/8a6l1XFrVPsVBs0NGidMl2O7Cwtkf67X7hiZYrsplzvcb
         flC0fCXQ7OacQpbRiGjAKT2j6vTIe48VsUFa0eT+vwpfpRVS4AA0oqC60WtafNuauSD+
         FIl9mzCQ1FBbt8SdvWVwktAHQOBBanhx56f+ai1G7liFDqS/mUd3R8p+2fMtgvhhaEQQ
         +lUQ==
X-Gm-Message-State: AOJu0YzJ/JZ4EztYV/KTogsfCO0MDVSQ/yO1fON4YqOTR89nnv2xL31o
        Q4vXbPSbGVzXoWtzpYGqAruYtH+InlnhADHMMwkSRQ==
X-Google-Smtp-Source: AGHT+IFf03L42G84fm0N48JpqVHj9I4gsFxC8WzU21B9esoRqn0gNLgBqz3kaHaC5kxNyPqlKpiP7Xi9yXysfv4dzyo=
X-Received: by 2002:a05:622a:1747:b0:403:f5b8:2bd2 with SMTP id
 l7-20020a05622a174700b00403f5b82bd2mr372604qtk.9.1695033576987; Mon, 18 Sep
 2023 03:39:36 -0700 (PDT)
MIME-Version: 1.0
References: <ed59c1b9-6c5c-4774-a871-a24564f3a270@alu.unizg.hr>
 <CANn89iJv8VRPwQBAE=5-oKHGMs9JVCvCiCBwL+3QW9sJDxo5cQ@mail.gmail.com> <3e306b0a-24b8-60d4-c516-1db738d79e92@alu.unizg.hr>
In-Reply-To: <3e306b0a-24b8-60d4-c516-1db738d79e92@alu.unizg.hr>
From:   Eric Dumazet <edumazet@google.com>
Date:   Mon, 18 Sep 2023 12:39:22 +0200
Message-ID: <CANn89iKyLdvSF11aHvg-Ytr+HbnHb4QXMie2N5GpZhxSHx-XtA@mail.gmail.com>
Subject: Re: BUG: KCSAN: data-race in rtl8169_poll
To:     Mirsad Todorovac <mirsad.todorovac@alu.unizg.hr>,
        Marco Elver <elver@google.com>
Cc:     nic_swsd@realtek.com, Heiner Kallweit <hkallweit1@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 18, 2023 at 11:43=E2=80=AFAM Mirsad Todorovac
<mirsad.todorovac@alu.unizg.hr> wrote:
>
> On 9/18/23 09:41, Eric Dumazet wrote:
> > On Mon, Sep 18, 2023 at 8:15=E2=80=AFAM Mirsad Todorovac
> > <mirsad.todorovac@alu.unizg.hr> wrote:
> >>
> >> Hi all,
> >>
> >> In the vanilla torvalds tree kernel on Ubuntu 22.04, commit 6.6.0-rc1-=
kcsan-00269-ge789286468a9,
> >> KCSAN discovered a data-race in rtl8169_poll():
> >>
> >> [ 9591.740976] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >> [ 9591.740990] BUG: KCSAN: data-race in rtl8169_poll (drivers/net/ethe=
rnet/realtek/r8169_main.c:4430 drivers/net/ethernet/realtek/r8169_main.c:45=
83) r8169
> >>
> >> [ 9591.741060] race at unknown origin, with read to 0xffff888109773130=
 of 4 bytes by interrupt on cpu 21:
> >> [ 9591.741073] rtl8169_poll (drivers/net/ethernet/realtek/r8169_main.c=
:4430 drivers/net/ethernet/realtek/r8169_main.c:4583) r8169
> >> [ 9591.741135] __napi_poll (net/core/dev.c:6527)
> >> [ 9591.741149] net_rx_action (net/core/dev.c:6596 net/core/dev.c:6727)
> >> [ 9591.741161] __do_softirq (kernel/softirq.c:553)
> >> [ 9591.741175] __irq_exit_rcu (kernel/softirq.c:427 kernel/softirq.c:6=
32)
> >> [ 9591.741185] irq_exit_rcu (kernel/softirq.c:647)
> >> [ 9591.741194] common_interrupt (arch/x86/kernel/irq.c:247 (discrimina=
tor 14))
> >> [ 9591.741206] asm_common_interrupt (./arch/x86/include/asm/idtentry.h=
:636)
> >> [ 9591.741217] cpuidle_enter_state (drivers/cpuidle/cpuidle.c:291)
> >> [ 9591.741227] cpuidle_enter (drivers/cpuidle/cpuidle.c:390)
> >> [ 9591.741237] call_cpuidle (kernel/sched/idle.c:135)
> >> [ 9591.741249] do_idle (kernel/sched/idle.c:219 kernel/sched/idle.c:28=
2)
> >> [ 9591.741259] cpu_startup_entry (kernel/sched/idle.c:378 (discriminat=
or 1))
> >> [ 9591.741268] start_secondary (arch/x86/kernel/smpboot.c:210 arch/x86=
/kernel/smpboot.c:294)
> >> [ 9591.741281] secondary_startup_64_no_verify (arch/x86/kernel/head_64=
.S:433)
> >>
> >> [ 9591.741300] value changed: 0x80003fff -> 0x34044510
> >>
> >> [ 9591.741314] Reported by Kernel Concurrency Sanitizer on:
> >> [ 9591.741322] CPU: 21 PID: 0 Comm: swapper/21 Tainted: G             =
L     6.6.0-rc1-kcsan-00269-ge789286468a9-dirty #4
> >> [ 9591.741334] Hardware name: ASRock X670E PG Lightning/X670E PG Light=
ning, BIOS 1.21 04/26/2023
> >> [ 9591.741343] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >>
> >> (The taint is not from the proprietary module, but triggered from the =
previous reported and unfixed bug.)
> >>
> >> Apparently, it is this code:
> >>
> >> static int rtl8169_poll(struct napi_struct *napi, int budget)
> >> {
> >>          struct rtl8169_private *tp =3D container_of(napi, struct rtl8=
169_private, napi);
> >>          struct net_device *dev =3D tp->dev;
> >>          int work_done;
> >>
> >>          rtl_tx(dev, tp, budget);
> >>
> >> =E2=86=92       work_done =3D rtl_rx(dev, tp, budget);
> >>
> >>          if (work_done < budget && napi_complete_done(napi, work_done)=
)
> >>                  rtl_irq_enable(tp);
> >>
> >>          return work_done;
> >> }
> >>
> >> and
> >>
> >> static int rtl_rx(struct net_device *dev, struct rtl8169_private *tp, =
int budget)
> >> {
> >>          struct device *d =3D tp_to_dev(tp);
> >>          int count;
> >>
> >>          for (count =3D 0; count < budget; count++, tp->cur_rx++) {
> >>                  unsigned int pkt_size, entry =3D tp->cur_rx % NUM_RX_=
DESC;
> >>                  struct RxDesc *desc =3D tp->RxDescArray + entry;
> >>                  struct sk_buff *skb;
> >>                  const void *rx_buf;
> >>                  dma_addr_t addr;
> >>                  u32 status;
> >>
> >> =E2=86=92               status =3D le32_to_cpu(desc->opts1);
> >>                  if (status & DescOwn)
> >>                          break;
> >>
> >>                  /* This barrier is needed to keep us from reading
> >>                   * any other fields out of the Rx descriptor until
> >>                   * we know the status of DescOwn
> >>                   */
> >>                  dma_rmb();
> >>
> >>                  if (unlikely(status & RxRES)) {
> >> .
> >> .
> >> .
> >>
> >> The reason isn't obvious, so it might be interesting if this is a vali=
d report and whether it caused spurious corruption
> >> of the network data on Realtek 8169 compatible cards ...
> >>
> >
> > I think this is pretty much expected.
> >
> > Driver reads a piece of memory that the hardware can modify.
> >
> > Adding data_race() annotations could avoid these false positives.
> >
> >> Hope this helps.
> >>
> >> Best regards,
> >> Mirsad Todorovac
>
> Well, another approach was this quick fix that eliminated all those rtl81=
69_poll() KCSAN warnings.
>
> If READ_ONCE(desc->opts1) fixed it, then maybe there is more to this than=
 meets the eye?
>
> -------------------------------------------------
>   drivers/net/ethernet/realtek/r8169_main.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/net/ethernet/realtek/r8169_main.c b/drivers/net/ethe=
rnet/realtek/r8169_main.c
> index 6351a2dc13bc..051551ee2a15 100644
> --- a/drivers/net/ethernet/realtek/r8169_main.c
> +++ b/drivers/net/ethernet/realtek/r8169_main.c
> @@ -4427,7 +4427,7 @@ static int rtl_rx(struct net_device *dev, struct rt=
l8169_private *tp, int budget
>                  dma_addr_t addr;
>                  u32 status;
>
> -               status =3D le32_to_cpu(desc->opts1);
> +               status =3D le32_to_cpu(READ_ONCE(desc->opts1));
>                  if (status & DescOwn)
>                          break;
>

This is also working, but in this case we already have barriers (
dma_rmb() here)
to synchronize host side and hardware (when flipping DescOwn) bit.

tools/memory-model/Documentation/access-marking.txt is saying that
data_race() would be ok.

It also says that in theory, if we want to both restrict compiler
optimizations and disable
KCSAN diagnostics, we would need data_race(READ_ONCE(a))

Let us ask Marco Elver what would be the most sensical annotation(s) here.
