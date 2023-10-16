Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 331D67CA622
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Oct 2023 12:57:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232370AbjJPK5O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Oct 2023 06:57:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229668AbjJPK5M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Oct 2023 06:57:12 -0400
Received: from mail-vk1-xa31.google.com (mail-vk1-xa31.google.com [IPv6:2607:f8b0:4864:20::a31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19FF583
        for <linux-kernel@vger.kernel.org>; Mon, 16 Oct 2023 03:57:11 -0700 (PDT)
Received: by mail-vk1-xa31.google.com with SMTP id 71dfb90a1353d-49d6bd3610cso1804041e0c.1
        for <linux-kernel@vger.kernel.org>; Mon, 16 Oct 2023 03:57:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697453830; x=1698058630; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+GKEx4RoNEwbCJcZsFqe13UzLKoclvdVCKQuYzrcdEk=;
        b=ZNeu9lHErRyqWr6c+qe/f+2vVUVxRIAzpLiZ2cp3oU0OwNWSoeiiK+nILfW8PXJqCn
         45375gOznjX558tGgiTJUb590lKMf4+Qa0WTWcSKvPZLbCHxFt+2Mt5tBbOETWjoD5tJ
         o1Ed81B2zrKjZCtyh+JTOg7z7Sea+M3IHOcS39ktVb0CA/M1brAcQpSf15ki8yIW8+bq
         fVPxJfRfi7CfrR9Q0qoPmE320cjpFXYe7JvnG/kUmjQJ4ahIbOKEyEj8zOdBPOVK955t
         yTeO6y2TKxz/DI/olbp+ROJv4EO29SQbjVvypJnNaJms+mpT5DNpoQRnRL6iM49BKOIg
         maOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697453830; x=1698058630;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+GKEx4RoNEwbCJcZsFqe13UzLKoclvdVCKQuYzrcdEk=;
        b=u4OIAwOlLI5e9mh92J1pYWlS7/7x9Tl++SNHMj/G1A/prhMoxud7SOi5X4jhKcgxni
         DhxFqPWKNg/D3TlDUazSb9/i4m3P5T95lQt3A4Qqv1mOs+9qjVW7OyZPwTjVh8wlmnHd
         Q9hHNt2p5q7N2aUs0c4rjHw8cV4tnr/3vKyvNcBLaMf2j9LaIaEDD2buCzigPj/eXwgQ
         2mcwrgtrSFHgSVJRxqGbYt0dn1i1ji6BvY0PU+NWibLy2HxPzipIpK8ntDSmfWKo+aU7
         5rGcDBfM8kqytXizKupUH2FC0TEXPHghBiA3pywijjw6ByGF1NKXRO6YHJAu8BcGEkOX
         CxMA==
X-Gm-Message-State: AOJu0Yz8L27FOY5Vkq9w1pNakreKMAPMp8deYS8TVTpfCXiVfIGhHXZS
        WX/FIlWbDhFympC34PTLlkpnbeAvCgqevHhRrjav6gG2lz8L3Q==
X-Google-Smtp-Source: AGHT+IFztilV0Dko4c+RpuY7OUFu9k+hSYvRJE9pPp3ONMQC0dH5dlw2C5AVI4c+G6AvHItr1DwruHBNFNibB1UDzY8=
X-Received: by 2002:a1f:2c93:0:b0:4a8:4218:804b with SMTP id
 s141-20020a1f2c93000000b004a84218804bmr1519757vks.12.1697453830057; Mon, 16
 Oct 2023 03:57:10 -0700 (PDT)
MIME-Version: 1.0
References: <CAA85sZtpYOiDkax_epshYq78vtgGRCo9xdf1uTnharDB4Dugkw@mail.gmail.com>
 <20231015033750.1747-1-hdanton@sina.com> <CAA85sZs+Ey4Nw=HS9s_KdEcdT4Tji8rWg-+M1RrfOzeLTt7qHg@mail.gmail.com>
In-Reply-To: <CAA85sZs+Ey4Nw=HS9s_KdEcdT4Tji8rWg-+M1RrfOzeLTt7qHg@mail.gmail.com>
From:   Ian Kumlien <ian.kumlien@gmail.com>
Date:   Mon, 16 Oct 2023 12:56:58 +0200
Message-ID: <CAA85sZt+N7oNkH9PmGy65f7fbi4BNmv45D9FxCNv4w_A6AVBng@mail.gmail.com>
Subject: Re: [bug] 6.5.7 - ixbe freezes and causes RCU deadlock?
To:     Hillf Danton <hdanton@sina.com>
Cc:     linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

And again, no oops visible this time

135476.059611] ixgbe 0000:07:00.0 eno3: Reset adapter
[135483.747803] rcu: INFO: rcu_preempt self-detected stall on CPU
[135483.753749] rcu:    3-....: (20999 ticks this GP)
idle=3Dddf4/1/0x4000000000000000 softirq=3D997198/997198 fqs=3D3594
[135483.763852] rcu:    (t=3D21015 jiffies g=3D4687825 q=3D371 ncpus=3D12)
[135483.769694] rcu: rcu_preempt kthread timer wakeup didn't happen
for 6637 jiffies! g4687825 f0x0 RCU_GP_WAIT_FQS(5) ->state=3D0x402
[135483.781436] rcu:    Possible timer handling issue on cpu=3D8
timer-softirq=3D960866
[135483.788752] rcu: rcu_preempt kthread starved for 6660 jiffies!
g4687825 f0x0 RCU_GP_WAIT_FQS(5) ->state=3D0x402 ->cpu=3D8
[135483.799540] rcu:    Unless rcu_preempt kthread gets sufficient CPU
time, OOM is now expected behavior.
[135483.808849] rcu: RCU grace-period kthread stack dump:
[135483.814249] rcu: Stack dump where RCU GP kthread last ran:
[135546.819253] rcu: INFO: rcu_preempt self-detected stall on CPU
[135546.825177] rcu:    3-....: (83999 ticks this GP)
idle=3Dddf4/1/0x4000000000000000 softirq=3D997198/997198 fqs=3D3594
[135546.835276] rcu:    (t=3D84088 jiffies g=3D4687825 q=3D802 ncpus=3D12)
[135546.841114] rcu: rcu_preempt kthread starved for 69713 jiffies!
g4687825 f0x0 RCU_GP_WAIT_FQS(5) ->state=3D0x0 ->cpu=3D8
[135546.851835] rcu:    Unless rcu_preempt kthread gets sufficient CPU
time, OOM is now expected behavior.
[135546.861177] rcu: RCU grace-period kthread stack dump:
[135546.866576] rcu: Stack dump where RCU GP kthread last ran:


On Sun, Oct 15, 2023 at 2:01=E2=80=AFPM Ian Kumlien <ian.kumlien@gmail.com>=
 wrote:
>
> On Sun, Oct 15, 2023 at 5:38=E2=80=AFAM Hillf Danton <hdanton@sina.com> w=
rote:
> >
> > On Sun, 15 Oct 2023 00:11:41 +0200 Ian Kumlien <ian.kumlien@gmail.com>
> > > So, this keeps happening - it's happened for quite some time now...
> > > I can't really reproduce it but it starts with a network adapter
> > > freezing and ends with RCU errors
> > > and watchdog reboot... :/
> > >
> > > cat bug.txt | ./scripts/decode_stacktrace.sh vmlinux
> > > [185433.169006] ------------[ cut here ]------------
> > > [185433.169018] NETDEV WATCHDOG: eno3 (ixgbe): transmit queue 2 timed=
 out 9736 ms
> > > [185433.169094] WARNING: CPU: 3 PID: 0 at net/sched/sch_generic.c:525
> > > dev_watchdog (net/sched/sch_generic.c:525 (discriminator 3))
> >
> > Watchdog reported eno3 tx hang.
> > ...
> > >
> > > And in the IPMI console:
> > > [185433.169621] ixgbe 0000:07:00.0 eno3: Reset adapter
> > > [185444.166717] rcu: INFO: rcu_preempt self-detected stall on CPU
> > > [185444.172665] rcu: 0-...!: (20999 ticks this GP)
> > > idle=3D8d84/1/0x4000000000000000 softirq=3D1976223/1976223 fqs=3D2
> > > [185444.182681] rcu: (t=3D21015 jiffies g=3D6787421 q=3D738 ncpus=3D1=
2)
> > > [185444.188523] rcu: rcu_preempt kthread timer wakeup didn't happen
> > > for 21009 jiffies! g6787421 f0x0 RCU_GP_WAIT_FQS(5) ->state=3D0x402
> > > [185444.200361] rcu: Possible timer handling issue on cpu=3D8 timer-s=
oftirq=3D1196063
> >
> > Timer on CPU8 is suspected to cause RCU stall.
> >
> > > [185444.207761] rcu: rcu_preempt kthread starved for 21032 jiffies!
> > > g6787421 f0x0 RCU_GP_WAIT_FQS(5) ->state=3D0x402 ->cpu=3D8
> > > [185444.218639] rcu: Unless rcu_preempt kthread gets sufficient CPU
> > > time, OOM is now expected behavior.
> > > [185444.227946] rcu: RCU grace-period kthread stack dump:
> > > [185444.233347] rcu: Stack dump where RCU GP kthread last ran:
> > > [185507.243156] rcu: INFO: rcu_preempt self-detected stall on CPU
> > > [185507.249098] rcu: 0-....: (84002 ticks this GP)
> > > idle=3D8d84/1/0x4000000000000000 softirq=3D1976223/1976223 fqs=3D1559
> > > [185507.259375] rcu: (t=3D84094 jiffies g=3D6787421 q=3D1213 ncpus=3D=
12)
> > > [185570.265595] rcu: INFO: rcu_preempt self-detected stall on CPU
> > > [185570.271532] rcu: 0-....: (147002 ticks this GP)
> > > idle=3D8d84/1/0x4000000000000000 softirq=3D1976223/1976223 fqs=3D1384=
4
> > > [185570.282016] rcu: (t=3D147117 jiffies g=3D6787421 q=3D1273 ncpus=
=3D12)
> > > [185570.288049] rcu: rcu_preempt kthread timer wakeup didn't happen
> > > for 13787 jiffies! g6787421 f0x0 RCU_GP_WAIT_FQS(5) ->state=3D0x402
> > > [185570.299914] rcu: Possible timer handling issue on cpu=3D9 timer-s=
oftirq=3D1211534
> >
> > Ditto on CPU9.
> >
> > No answer yet to why rcu stall was reported without any info about the =
timers
> > on CPU8/9.
>
> Well... I can't really give you anymore information, all i can say is
> that it leads to complete deadlock and eventual reboot by the hardware
> watchdog...
