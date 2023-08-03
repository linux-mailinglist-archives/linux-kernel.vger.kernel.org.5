Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8DEB376EDEE
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Aug 2023 17:21:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235056AbjHCPVj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Aug 2023 11:21:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232404AbjHCPVh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Aug 2023 11:21:37 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25E041734
        for <linux-kernel@vger.kernel.org>; Thu,  3 Aug 2023 08:21:10 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id d9443c01a7336-1bbf0f36ce4so7611335ad.0
        for <linux-kernel@vger.kernel.org>; Thu, 03 Aug 2023 08:21:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1691076069; x=1691680869;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kHMLZFWHP4GSNpR79JtI8BrtGsCZ/YdpbJ6vEHW5Cqk=;
        b=j0okR7Fs8lVyMVctOaIoaw6mtP82u97YDeY6hQKkHRlYYdwwOPp1zfY0aEaLhvzT8S
         yHUuGum8HruKQXCdWqcBCZO4rs7DNNzBfEa/PYfVQGOSXxRjy5uSnzX3Jr6xpl980kRt
         HeJ4iv2gp3xsJ7p8sD4ThOlAbRMZ/MTyozb0DbQrd+FGvbuTLBrMehm/mrNdiKZOd2Hm
         8T++RZSFxGrWCSSiF0oCnIh8qaYis1BJ3VktbhTrDXA/2IfsGA/4AL+QZssxHsklgcYP
         tjNGnh7wDV1q2/vGros9xW4zRLEPOTXXYz5UzccTFZMG+pkWAl8ivhK+QTZyFYHD+cWI
         9QKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691076069; x=1691680869;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kHMLZFWHP4GSNpR79JtI8BrtGsCZ/YdpbJ6vEHW5Cqk=;
        b=LFPXcUmwAhOEYRH70+ZOjE+6X7UZq1o3XZFc+kLuYTgm0Z+MnwDo8GCckUO4N7mP12
         nv0ru1o8SXd/s80PjNxsYTfV7v3yPyTUk+omEfTDRJXnRT9gjmB9lYzG1RbbVIykX8Md
         Dphspy6c6xXP3lx9J4BmRTKT+GWMHGzO/MGsL17KP8t7vmCxKtGbPWShvuhHGZAJdFFr
         s0GnTk7bGvp5FPPKF/IOLQWum2KlMfeo5D0egtOmXf1M0DQ1hRU+FlXIrHl7KuxMPySJ
         HlGXLNKIfkHbmD6loiI3+1fc+/+jSuG49xig/AqSGek6cfv0bSd7DWBwbWWUFbm9zZwu
         rcEA==
X-Gm-Message-State: ABy/qLaiq0OnMHg2JeWdPpITewSXUpZyYYS5NiL466LRp9an4BWaPuTv
        BxMabFtNv+FJQ/rSVFQAYIh/BB4Djw5jO2ZY2IUxigiXbrJKgbFBmTjwQhpykeYSEg==
X-Google-Smtp-Source: APBJJlFiySFGocXSADBXguYYyEKkxDN7ynIC7VKd86S/kjKPkvXKr753AS8x+xBTAP8ioj+8F1+9/vUOJxVXcB04k4w=
X-Received: by 2002:a17:902:c246:b0:1b8:59f0:c748 with SMTP id
 6-20020a170902c24600b001b859f0c748mr17350585plg.2.1691076069560; Thu, 03 Aug
 2023 08:21:09 -0700 (PDT)
MIME-Version: 1.0
References: <20230803132818.2092166-1-luxu.kernel@bytedance.com> <20230803-curtly-sandbox-9ff8c7aafb85@spud>
In-Reply-To: <20230803-curtly-sandbox-9ff8c7aafb85@spud>
From:   =?UTF-8?B?5pet6Lev?= <luxu.kernel@bytedance.com>
Date:   Thu, 3 Aug 2023 23:20:53 +0800
Message-ID: <CAPYmKFsbGMRY7S6WguDHkkY1futTS7+piKf83Pb+aktO2yLXpw@mail.gmail.com>
Subject: Re: [External] Re: [PATCH RESEND] riscv: Fix local irq restore when
 flags indicates irq disabled
To:     Conor Dooley <conor@kernel.org>
Cc:     paul.walmsley@sifive.com, palmer@dabbelt.com,
        aou@eecs.berkeley.edu, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 3, 2023 at 10:36=E2=80=AFPM Conor Dooley <conor@kernel.org> wro=
te:
>
> Hey,
>
> On Thu, Aug 03, 2023 at 09:28:18PM +0800, Xu Lu wrote:
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
>
> There's no changelog or explanation, so what is the reason for the
> resend?
>
> Cheers,
> Conor.

Sorry for disturbing you.

I haven't received any response since the patch was sent last week. I
think maintainers are busy and thus I want to have a ping. This patch
was resent because I found it is said that resending patch is one of
the methods to ping maintainers in this kernel doc:
https://www.kernel.org/doc/html/latest/process/submitting-patches.html.

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
> >  }
> >
> >  #endif /* _ASM_RISCV_IRQFLAGS_H */
> > --
> > 2.20.1
> >
> >
> > _______________________________________________
> > linux-riscv mailing list
> > linux-riscv@lists.infradead.org
> > http://lists.infradead.org/mailman/listinfo/linux-riscv
