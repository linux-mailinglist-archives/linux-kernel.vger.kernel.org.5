Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67BE2775356
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Aug 2023 08:58:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230526AbjHIG6r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Aug 2023 02:58:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbjHIG6q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Aug 2023 02:58:46 -0400
Received: from mail-oo1-xc34.google.com (mail-oo1-xc34.google.com [IPv6:2607:f8b0:4864:20::c34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBF7F19BC
        for <linux-kernel@vger.kernel.org>; Tue,  8 Aug 2023 23:58:23 -0700 (PDT)
Received: by mail-oo1-xc34.google.com with SMTP id 006d021491bc7-56c7f47ec42so4620482eaf.2
        for <linux-kernel@vger.kernel.org>; Tue, 08 Aug 2023 23:58:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1691564303; x=1692169103;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pefRTU+8B4m9LlJAFGQ0IQAqbtMHJMUCx10va6N3Enw=;
        b=kz805cuhiEqMxJpNJIufLksHrMhd7adoGDZy9oV1BHultXIZgvH+RyhBxZVCzVgzS1
         PwOkw442ijAM94hAao2Fq9PqJKXcrrF8D65D23NizmOYWcQtSucLZuIBFn11hHkBdYEs
         NoT956z0mGNKbS+5lX7fvo+Ohr7kdF9hmidxuC6hjaS8EobOZJQ2NPGKYPK4hN6FmOAv
         NtIsgPPQH4grl6sGObE32GxmZ3L4V/ctfsbfDKqFmWa9FavJzB+N/mdoa2F89ncCTzjj
         c4+a1ECILnbtW+vqIvkD20K9TedBOEd3flPXKSCaEXd337M5yQa5Mjb1D0jg7WKqm6ou
         WJ4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691564303; x=1692169103;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pefRTU+8B4m9LlJAFGQ0IQAqbtMHJMUCx10va6N3Enw=;
        b=RpGF2aK7tqapb7g2E8pe0qJocjyHBWreYqgFzuOXKrrDRoeTFmk2v4BaStOvAqhCNC
         /az7JMVB6ebluS5TL39oa3RcogrBZ/NFFgN+PFZCTNIYpvzG+AEP8M8B3L9iDBus7ON9
         aTipMvQu0o5n1mTh7cdIuh87y/QMzxNrboJF34qBemrCUPWxNkED+K1ruNH/FWYXss6A
         RdOsdD0VKJ7mr3E4hTp7jELScK5xv+pQaGd1SFS03PxxVs1AU4mF0EeNjLqAWCzNEsu+
         hYqObEO58RI8Mj2r0EjgOZpzqHLmb+jPT7T3B83uqyC7VlLtkuQ6hrq+S7fnhyikqrr6
         3AqQ==
X-Gm-Message-State: AOJu0YxzULCf5OycAuiee1GvkFf0wQ5PPepFxQzrZn7cO7s9+Vr2QovY
        n1I2ON0SvzUPXj9+pKSEQkRARD9+oq4qWiF4xJ+Kug==
X-Google-Smtp-Source: AGHT+IFOQzArXEOnOoN5WR9/edMYywXHyjfSlSB4WWO8aADAYXK1YC337PmXNavlPzrTL4N3WEIdVBrYJc28FICV1Mw=
X-Received: by 2002:a05:6808:1988:b0:3a3:654d:b2e5 with SMTP id
 bj8-20020a056808198800b003a3654db2e5mr2333267oib.42.1691564302996; Tue, 08
 Aug 2023 23:58:22 -0700 (PDT)
MIME-Version: 1.0
References: <20230725070549.89810-1-luxu.kernel@bytedance.com> <mhng-a0239c56-385e-40a9-8a71-45d50e28b45d@palmer-ri-x1c9>
In-Reply-To: <mhng-a0239c56-385e-40a9-8a71-45d50e28b45d@palmer-ri-x1c9>
From:   =?UTF-8?B?5pet6Lev?= <luxu.kernel@bytedance.com>
Date:   Wed, 9 Aug 2023 14:58:11 +0800
Message-ID: <CAPYmKFvXf7q_8QzFe4VFL1s-j0P3ZGSZ8nG1q4HmtU4rzek77Q@mail.gmail.com>
Subject: Re: [External] Re: [PATCH] riscv: Fix local irq restore when flags
 indicates irq disabled
To:     Palmer Dabbelt <palmer@dabbelt.com>
Cc:     Paul Walmsley <paul.walmsley@sifive.com>, aou@eecs.berkeley.edu,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 9, 2023 at 2:05=E2=80=AFPM Palmer Dabbelt <palmer@dabbelt.com> =
wrote:
>
> On Tue, 25 Jul 2023 00:05:49 PDT (-0700), luxu.kernel@bytedance.com wrote=
:
> > When arch_local_irq_restore() is called with flags indicating irqs
> > disabled, we need to clear SR_IE bit in CSR_STATUS, whereas current
> > implementation based on csr_set() function only sets SR_IE bit of
> > CSR_STATUS when SR_IE bit of flags is high and does nothing when
> > SR_IE bit of flags is low.
> >
> > This commit supplies csr clear operation when calling irq restore
> > function with flags indicating irq disabled.
> >
> > Fixes: 6d60b6ee0c97 ("RISC-V: Device, timer, IRQs, and the SBI")
> > Signed-off-by: Xu Lu <luxu.kernel@bytedance.com>
> > ---
> >  arch/riscv/include/asm/irqflags.h | 5 ++++-
> >  1 file changed, 4 insertions(+), 1 deletion(-)
> >
> > diff --git a/arch/riscv/include/asm/irqflags.h b/arch/riscv/include/asm=
/irqflags.h
> > index 08d4d6a5b7e9..7c31fc3c3559 100644
> > --- a/arch/riscv/include/asm/irqflags.h
> > +++ b/arch/riscv/include/asm/irqflags.h
> > @@ -49,7 +49,10 @@ static inline int arch_irqs_disabled(void)
> >  /* set interrupt enabled status */
> >  static inline void arch_local_irq_restore(unsigned long flags)
> >  {
> > -     csr_set(CSR_STATUS, flags & SR_IE);
> > +     if (flags & SR_IE)
> > +             csr_set(CSR_STATUS, SR_IE);
> > +     else
> > +             csr_clear(CSR_STATUS, SR_IE);
>
> Unless I'm missing something, the original version is correct:
> local_irq_restore() must be paired with a local_irq_save(), so we can
> only get here with interrupts disabled.

Yes, it is correct if local_irq_save() is called when irq is enabled before=
.
The flags returned will be SR_IE. And it is safe to call local_irq_restore(=
)
with flag SR_IE in any case.

However, if local_irq_save() is called when irq is disabled. The SR_IE bit =
of
flag returned is clear. If some code between local_irq_save() and
local_irq_restore() reenables irq, causing the SR_IE bit of CSR_STATUS
back to 1, then local_irq_restore() can not restore irq status back to disa=
bled.

Here is an example in existing driver (may not belong to riscv arch) in
drivers/net/wireless/realtek/rtlwifi/rtl8723ae/hw.c. The pseudo code
behaves like:

int rtl8723e_hw_init(struct ieee80211_hw *hw)
{
     int err;
     unsigned long flags;
     ...
     local_irq_save_flags(flags);
     local_irq_enable();
     ...
     local_irq_restore(flags);
     ...
     return err;
}


>
> >  }
> >
> >  #endif /* _ASM_RISCV_IRQFLAGS_H */
