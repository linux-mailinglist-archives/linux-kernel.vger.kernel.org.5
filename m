Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB5CC760A4C
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jul 2023 08:25:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232142AbjGYGZg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jul 2023 02:25:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230372AbjGYGZ1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jul 2023 02:25:27 -0400
Received: from mail-vs1-xe35.google.com (mail-vs1-xe35.google.com [IPv6:2607:f8b0:4864:20::e35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF12319B0
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jul 2023 23:25:15 -0700 (PDT)
Received: by mail-vs1-xe35.google.com with SMTP id ada2fe7eead31-440ad406bc8so1313181137.3
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jul 2023 23:25:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690266315; x=1690871115;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oEUYA8z3zr7f9Yzq/3gIgIrlPEAwowWK06gnE/zw7M0=;
        b=i7EKm2oYOzfgf70PdZ5PGua72PfIJcNqQ/14LQ/t6WvuZ/RiPPwFdkK63u0swQVFlP
         H0pjPdnOka7zmPj/acw+gWe9LXo/rvZNUDlSka/Rfi7+5ZWTjC3ZemvkNyIfERKBm5Er
         h5anUVpJSJfeCAi4UR3vCwElFwdOMkbnp6tyv9bGfZocLR61D+pG0mavMCrNxTGSzJQF
         Ox8sOXH/DGXs9RUGmhXLShHWv9TvueyjPMDNXFx7dHLu6HjFxwUTIdQbeY71keZo6I7A
         7gyjMzsN2OhA9hHqUIakB9jkwpOnjeOQM1qb9fob00qIIqPTbccECGHt/BexdumTucvS
         yrKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690266315; x=1690871115;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oEUYA8z3zr7f9Yzq/3gIgIrlPEAwowWK06gnE/zw7M0=;
        b=kF5mXJUmGJSUNfkHB0O2Gjf4BMlU8h8AnLXVfVw5pY81nYVBxs2oKqL1djIFjYyuyH
         WctC1fL/qQ3PSraBwnk6yRRKDXUO44eMOiTHmJNv3OooAgZNVI1QDtuENKXta0ckIguz
         XYL2e8lLG3oHWoFG7X4CYEmi2tYARtf7Fya4uJwh7PTxkiaFIGOND04PiSdt4kPx6rz+
         2tjRzob7VSjdwMsD9m4UJpmg8cLO+ma237v6zU2L7aCZoQoAmLkJOgTgeJFHlmYLRQVO
         eaN/+VIkFw8ZEUhBtgPDd2k7Om36iihsoiXAE0h26zpobJ+XangyKha5GIoFs3IU4E+5
         gnzA==
X-Gm-Message-State: ABy/qLYCYKKDyd2rcQ/kTTzkPE7h8/4tjXgVtbPgFOHcxzEzfWIj1r/o
        obWjR+VrrqDy742OEgwLbSiYjx6pwnMMQKDMzTs=
X-Google-Smtp-Source: APBJJlHJX/cbANhDpAwmzq/zB7fKISef8BsNSx7J2O7kTpMFv7YZqNJyI4jgDUIifS+KHaEBaapX/DMRnPc4DiDDEOo=
X-Received: by 2002:a67:ec94:0:b0:446:eb8e:8940 with SMTP id
 h20-20020a67ec94000000b00446eb8e8940mr2881382vsp.16.1690266314724; Mon, 24
 Jul 2023 23:25:14 -0700 (PDT)
MIME-Version: 1.0
References: <20230724132736.124106-1-luxu.kernel@bytedance.com>
 <e75d0e92-1e6e-43c2-1935-00f22df5579d@codethink.co.uk> <20230724-anatomist-evade-ef89a12a491a@wendy>
In-Reply-To: <20230724-anatomist-evade-ef89a12a491a@wendy>
From:   Xu Lu <luxujoy@gmail.com>
Date:   Tue, 25 Jul 2023 14:25:03 +0800
Message-ID: <CAEuiHnxkc3uO0==bo1R19SiS7DmuOQ5DMc2wjLbPxFhY4urYOA@mail.gmail.com>
Subject: Re: [PATCH] riscv: Fix local irq restore when flags indicates irq disabled
To:     Conor Dooley <conor.dooley@microchip.com>
Cc:     Ben Dooks <ben.dooks@codethink.co.uk>, paul.walmsley@sifive.com,
        palmer@dabbelt.com, aou@eecs.berkeley.edu,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        luxu.kernel@bytedance.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 24, 2023 at 10:03=E2=80=AFPM Conor Dooley
<conor.dooley@microchip.com> wrote:
>
> On Mon, Jul 24, 2023 at 02:42:50PM +0100, Ben Dooks wrote:
> > On 24/07/2023 14:27, luxu.kernel wrote:
> > > When arch_local_irq_restore() is called with flags indicating irqs
> > > disabled, we need to clear SR_IE bit in CSR_STATUS, whereas current
> > > implementation based on csr_set() function only sets SR_IE bit of
> > > CSR_STATUS when SR_IE bit of flags is high and does nothing when
> > > SR_IE bit of flags is low.
> > >
> > > This commit supplies csr clear operation when calling irq restore
> > > function with flags indicating irq disabled.
> > >
> > > Signed-off-by: luxu.kernel <luxu.kernel@bytedance.com>
> >
> > real-names are required for signoff
>
> And the From: address needs to match the signof, here the From: address
> is a gmail one.
>
> > > ---
> > >   arch/riscv/include/asm/irqflags.h | 5 ++++-
> > >   1 file changed, 4 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/arch/riscv/include/asm/irqflags.h b/arch/riscv/include/a=
sm/irqflags.h
> > > index 08d4d6a5b7e9..7c31fc3c3559 100644
> > > --- a/arch/riscv/include/asm/irqflags.h
> > > +++ b/arch/riscv/include/asm/irqflags.h
> > > @@ -49,7 +49,10 @@ static inline int arch_irqs_disabled(void)
> > >   /* set interrupt enabled status */
> > >   static inline void arch_local_irq_restore(unsigned long flags)
> > >   {
> > > -   csr_set(CSR_STATUS, flags & SR_IE);
> > > +   if (flags & SR_IE)
> > > +           csr_set(CSR_STATUS, SR_IE);
> > > +   else
> > > +           csr_clear(CSR_STATUS, SR_IE);
> > >   }
> > >   #endif /* _ASM_RISCV_IRQFLAGS_H */
> >
> > I think this is correct, I wonder how long this has been going on
> > without anyone noticing?
>
> Code has been like this since 6d60b6ee0c97 ("RISC-V: Device, timer,
> IRQs, and the SBI"), committed on Tue Sep 26 15:26:47 2017 -0700.

Thanks for your reply. I will resend the patch with real name and
correct mailbox.
