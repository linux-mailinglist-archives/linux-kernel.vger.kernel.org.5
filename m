Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48D7E786EBB
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Aug 2023 14:09:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241278AbjHXMI7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Aug 2023 08:08:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236998AbjHXMIk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Aug 2023 08:08:40 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D415E7D
        for <linux-kernel@vger.kernel.org>; Thu, 24 Aug 2023 05:08:14 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id 98e67ed59e1d1-26d54d3d984so3398240a91.1
        for <linux-kernel@vger.kernel.org>; Thu, 24 Aug 2023 05:08:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1692878893; x=1693483693;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ky+vs6UbfQtID7spa60NQprP0k6Ypw8/omK+bBONcH8=;
        b=EJ3Yr97hc2BjNISUj2PECF8bgq8PDsok/vUdWh5AiXz+q90HrqUAlkDKLv+4LFSU2G
         Fw/RqWykgSGHU2OSiaZAgwH9Ojr7hVconEiZP1RDJ8S16aCVQx4Gt+OqKv2O+GClrQBw
         jDvXJEXIcMSlYSPY/kn38dXECpIh8i6B8RgeocMg3MWhW7uYJQJKJAO/RA28AnoRG8Fw
         NF64wvT4A234I3xPccGG0p7KNDb6jQ8k3lf4UngYiftHMyTlo2fcglVDVseAHhD/gw2N
         jcimjB5+9s03G4vFr5pvTKNbGq/xMhi52J+VuKiYadD2+jW6cVbWTdD87Ba6uBuIejIh
         Fklg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692878893; x=1693483693;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ky+vs6UbfQtID7spa60NQprP0k6Ypw8/omK+bBONcH8=;
        b=fhjNf6hCLHEfHaUSKiN1mvWlXUyoQVUOZ43i5kC5yaIxeETjIeJW5WK7xvkLWTLOLd
         tNRPLbU6WBzPqTTD4NLN1M78ZEBvST8cfgUcFQcsInuL1PHlO0hO0q9Fjdjlnsq/dWRW
         tvv2ELGx+FGz1P4ePTs6JEQSjhdZIZLWjjyNLiFpM3eN1FXJ5RNHAhTeDZHMJfLsrdWv
         uUZfDWA98hgGeIKdELSTJs/AKkLdjq/MSIwlpff/69NgZ+q2Myk2EAJrOoPyjfPhX6+m
         MDHiG9IMT2Woqq6hsU15rKKZosQrB5JkzH5a35NWh0kwBYlRSNQ4WUc1P4nwf+zYwKy9
         ElIw==
X-Gm-Message-State: AOJu0Yx6F5QRIiKrat3Knuis2rghOK56ZHVIPFbHeCCAy+XsMzi7q81H
        BgIWBoVzi1i+dZgD5bk6gfWXXphEjEWBOpCkvEtzMw==
X-Google-Smtp-Source: AGHT+IFaMR8PekS9ZuFU1f6lFYz9SgCJij2lDq+sitvoUYNExWt5ftewT4NgORzyLSjvq3sLN51P/q9NHvabqudaxBQ=
X-Received: by 2002:a17:90a:68c7:b0:268:2543:723 with SMTP id
 q7-20020a17090a68c700b0026825430723mr12526724pjj.5.1692878893503; Thu, 24 Aug
 2023 05:08:13 -0700 (PDT)
MIME-Version: 1.0
References: <20230725070549.89810-1-luxu.kernel@bytedance.com>
 <mhng-a0239c56-385e-40a9-8a71-45d50e28b45d@palmer-ri-x1c9> <CAPYmKFvXf7q_8QzFe4VFL1s-j0P3ZGSZ8nG1q4HmtU4rzek77Q@mail.gmail.com>
In-Reply-To: <CAPYmKFvXf7q_8QzFe4VFL1s-j0P3ZGSZ8nG1q4HmtU4rzek77Q@mail.gmail.com>
From:   Xu Lu <luxu.kernel@bytedance.com>
Date:   Thu, 24 Aug 2023 20:08:02 +0800
Message-ID: <CAPYmKFvqpe48zaLKrTz085cJcO9fwL+BtHujU4p48onR1Nodfw@mail.gmail.com>
Subject: Re: [External] Re: [PATCH] riscv: Fix local irq restore when flags
 indicates irq disabled
To:     Palmer Dabbelt <palmer@dabbelt.com>
Cc:     Paul Walmsley <paul.walmsley@sifive.com>, aou@eecs.berkeley.edu,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 9, 2023 at 2:58=E2=80=AFPM =E6=97=AD=E8=B7=AF <luxu.kernel@byte=
dance.com> wrote:
>
> On Wed, Aug 9, 2023 at 2:05=E2=80=AFPM Palmer Dabbelt <palmer@dabbelt.com=
> wrote:
> >
> > On Tue, 25 Jul 2023 00:05:49 PDT (-0700), luxu.kernel@bytedance.com wro=
te:
> > > When arch_local_irq_restore() is called with flags indicating irqs
> > > disabled, we need to clear SR_IE bit in CSR_STATUS, whereas current
> > > implementation based on csr_set() function only sets SR_IE bit of
> > > CSR_STATUS when SR_IE bit of flags is high and does nothing when
> > > SR_IE bit of flags is low.
> > >
> > > This commit supplies csr clear operation when calling irq restore
> > > function with flags indicating irq disabled.
> > >
> > > Fixes: 6d60b6ee0c97 ("RISC-V: Device, timer, IRQs, and the SBI")
> > > Signed-off-by: Xu Lu <luxu.kernel@bytedance.com>
> > > ---
> > >  arch/riscv/include/asm/irqflags.h | 5 ++++-
> > >  1 file changed, 4 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/arch/riscv/include/asm/irqflags.h b/arch/riscv/include/a=
sm/irqflags.h
> > > index 08d4d6a5b7e9..7c31fc3c3559 100644
> > > --- a/arch/riscv/include/asm/irqflags.h
> > > +++ b/arch/riscv/include/asm/irqflags.h
> > > @@ -49,7 +49,10 @@ static inline int arch_irqs_disabled(void)
> > >  /* set interrupt enabled status */
> > >  static inline void arch_local_irq_restore(unsigned long flags)
> > >  {
> > > -     csr_set(CSR_STATUS, flags & SR_IE);
> > > +     if (flags & SR_IE)
> > > +             csr_set(CSR_STATUS, SR_IE);
> > > +     else
> > > +             csr_clear(CSR_STATUS, SR_IE);
> >
> > Unless I'm missing something, the original version is correct:
> > local_irq_restore() must be paired with a local_irq_save(), so we can
> > only get here with interrupts disabled.
>
> Yes, it is correct if local_irq_save() is called when irq is enabled befo=
re.
> The flags returned will be SR_IE. And it is safe to call local_irq_restor=
e()
> with flag SR_IE in any case.
>
> However, if local_irq_save() is called when irq is disabled. The SR_IE bi=
t of
> flag returned is clear. If some code between local_irq_save() and
> local_irq_restore() reenables irq, causing the SR_IE bit of CSR_STATUS
> back to 1, then local_irq_restore() can not restore irq status back to di=
sabled.
>
> Here is an example in existing driver (may not belong to riscv arch) in
> drivers/net/wireless/realtek/rtlwifi/rtl8723ae/hw.c. The pseudo code
> behaves like:
>
> int rtl8723e_hw_init(struct ieee80211_hw *hw)
> {
>      int err;
>      unsigned long flags;
>      ...
>      local_irq_save_flags(flags);
>      local_irq_enable();
>      ...
>      local_irq_restore(flags);
>      ...
>      return err;
> }
>
>
> >
> > >  }
> > >
> > >  #endif /* _ASM_RISCV_IRQFLAGS_H */

A gentle ping.
