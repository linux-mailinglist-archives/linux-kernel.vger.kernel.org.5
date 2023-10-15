Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87EF27C98E5
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Oct 2023 14:02:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229692AbjJOMCI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 15 Oct 2023 08:02:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229561AbjJOMCG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Oct 2023 08:02:06 -0400
Received: from mail-vk1-xa2a.google.com (mail-vk1-xa2a.google.com [IPv6:2607:f8b0:4864:20::a2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5540A3
        for <linux-kernel@vger.kernel.org>; Sun, 15 Oct 2023 05:02:04 -0700 (PDT)
Received: by mail-vk1-xa2a.google.com with SMTP id 71dfb90a1353d-49d45964fcaso3181368e0c.1
        for <linux-kernel@vger.kernel.org>; Sun, 15 Oct 2023 05:02:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697371324; x=1697976124; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UYfDz5FVywyCMJeJQvPysG9FXrewpHN4XcnzSXxJVXA=;
        b=lw5PkKSink17NjNd/oCfr21LQjcIlCTAFocF1zlkZnYurlquzx9qD69qZFGPkx7lRj
         1ngHO7YDZpGA8Ll3KTrh/ZNctcLPJLZBoZm2FvLb52A7i+8iXkrhSoYScyiPPhnbeUal
         Oc8KCMgLhF4HfI2MT40fTZ5ie0W0cPK0B5wdK5Jv8xHDmmoBb7mBFBED3aCh7RWCvE8k
         ssbyjwlxHiBBCBjpJWrcn51s29jB9m04C9Fk1G5CjB1MV3RNStlOsy5Zk8fGVAUi+Xtb
         lqGr3TVHEnVmrl2gg9MUnpUbK3zctsdxPSaUTF351WosWZYPOL45O78ymJt3zADM7qO3
         uNOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697371324; x=1697976124;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UYfDz5FVywyCMJeJQvPysG9FXrewpHN4XcnzSXxJVXA=;
        b=p0BGCxmWVXkQ/ArBnKXaPIc/x14DJeT6zdO1JaJfZSuG150ViPSxZuvLHH7e2Kyet4
         iYWQZCE5xrEp4fciOBFbvEyX79LQnmRJkQpXV6c0EQHwHR9856+FvOS5kJz3SAiDJNpl
         h5Qo9ID5spHm4jpSBkOGxl6Mk5TEC0XYw6rCli+wZrYXTlgh7Z6mEDBjwyzm1yuPTVxx
         +FwUcCTxTW7m1ddCeBgINYnOZBD2bUtsECs4tHgxZGM1oK8cyN9GUgf//KXzGEZwCulu
         CbCUZoXGL8iPwwddVAf5kfbj3eB2wPU6TjC1KNwreIN/njr2n8BkyJDYMWkITVW/bl2v
         z6Fg==
X-Gm-Message-State: AOJu0Yx/YEe0FvixGV1BnTRs0mzQuDjvc87qMPDR50nLO0UcCw+6Fq27
        mtMWnQ+AdZ1wGhGT8gMOSD9kk2YdHo15ZaI0klUYpK81vNhMKg==
X-Google-Smtp-Source: AGHT+IEoFz67UHXX7Ubxpg1Dn39NVryW0ssrCxPN2DNXtCTbj/L17zAkp8928nvgp8BYtbeOmRxAzqr6xu2Ya1+gMPw=
X-Received: by 2002:a05:6122:4e14:b0:48d:11d1:9feb with SMTP id
 ge20-20020a0561224e1400b0048d11d19febmr2550797vkb.8.1697371323818; Sun, 15
 Oct 2023 05:02:03 -0700 (PDT)
MIME-Version: 1.0
References: <CAA85sZtpYOiDkax_epshYq78vtgGRCo9xdf1uTnharDB4Dugkw@mail.gmail.com>
 <20231015033750.1747-1-hdanton@sina.com>
In-Reply-To: <20231015033750.1747-1-hdanton@sina.com>
From:   Ian Kumlien <ian.kumlien@gmail.com>
Date:   Sun, 15 Oct 2023 14:01:52 +0200
Message-ID: <CAA85sZs+Ey4Nw=HS9s_KdEcdT4Tji8rWg-+M1RrfOzeLTt7qHg@mail.gmail.com>
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

On Sun, Oct 15, 2023 at 5:38=E2=80=AFAM Hillf Danton <hdanton@sina.com> wro=
te:
>
> On Sun, 15 Oct 2023 00:11:41 +0200 Ian Kumlien <ian.kumlien@gmail.com>
> > So, this keeps happening - it's happened for quite some time now...
> > I can't really reproduce it but it starts with a network adapter
> > freezing and ends with RCU errors
> > and watchdog reboot... :/
> >
> > cat bug.txt | ./scripts/decode_stacktrace.sh vmlinux
> > [185433.169006] ------------[ cut here ]------------
> > [185433.169018] NETDEV WATCHDOG: eno3 (ixgbe): transmit queue 2 timed o=
ut 9736 ms
> > [185433.169094] WARNING: CPU: 3 PID: 0 at net/sched/sch_generic.c:525
> > dev_watchdog (net/sched/sch_generic.c:525 (discriminator 3))
>
> Watchdog reported eno3 tx hang.
> ...
> >
> > And in the IPMI console:
> > [185433.169621] ixgbe 0000:07:00.0 eno3: Reset adapter
> > [185444.166717] rcu: INFO: rcu_preempt self-detected stall on CPU
> > [185444.172665] rcu: 0-...!: (20999 ticks this GP)
> > idle=3D8d84/1/0x4000000000000000 softirq=3D1976223/1976223 fqs=3D2
> > [185444.182681] rcu: (t=3D21015 jiffies g=3D6787421 q=3D738 ncpus=3D12)
> > [185444.188523] rcu: rcu_preempt kthread timer wakeup didn't happen
> > for 21009 jiffies! g6787421 f0x0 RCU_GP_WAIT_FQS(5) ->state=3D0x402
> > [185444.200361] rcu: Possible timer handling issue on cpu=3D8 timer-sof=
tirq=3D1196063
>
> Timer on CPU8 is suspected to cause RCU stall.
>
> > [185444.207761] rcu: rcu_preempt kthread starved for 21032 jiffies!
> > g6787421 f0x0 RCU_GP_WAIT_FQS(5) ->state=3D0x402 ->cpu=3D8
> > [185444.218639] rcu: Unless rcu_preempt kthread gets sufficient CPU
> > time, OOM is now expected behavior.
> > [185444.227946] rcu: RCU grace-period kthread stack dump:
> > [185444.233347] rcu: Stack dump where RCU GP kthread last ran:
> > [185507.243156] rcu: INFO: rcu_preempt self-detected stall on CPU
> > [185507.249098] rcu: 0-....: (84002 ticks this GP)
> > idle=3D8d84/1/0x4000000000000000 softirq=3D1976223/1976223 fqs=3D1559
> > [185507.259375] rcu: (t=3D84094 jiffies g=3D6787421 q=3D1213 ncpus=3D12=
)
> > [185570.265595] rcu: INFO: rcu_preempt self-detected stall on CPU
> > [185570.271532] rcu: 0-....: (147002 ticks this GP)
> > idle=3D8d84/1/0x4000000000000000 softirq=3D1976223/1976223 fqs=3D13844
> > [185570.282016] rcu: (t=3D147117 jiffies g=3D6787421 q=3D1273 ncpus=3D1=
2)
> > [185570.288049] rcu: rcu_preempt kthread timer wakeup didn't happen
> > for 13787 jiffies! g6787421 f0x0 RCU_GP_WAIT_FQS(5) ->state=3D0x402
> > [185570.299914] rcu: Possible timer handling issue on cpu=3D9 timer-sof=
tirq=3D1211534
>
> Ditto on CPU9.
>
> No answer yet to why rcu stall was reported without any info about the ti=
mers
> on CPU8/9.

Well... I can't really give you anymore information, all i can say is
that it leads to complete deadlock and eventual reboot by the hardware
watchdog...
