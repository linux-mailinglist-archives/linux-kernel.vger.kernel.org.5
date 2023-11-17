Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C17437EF386
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Nov 2023 14:10:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346029AbjKQNKx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Nov 2023 08:10:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231292AbjKQNKv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Nov 2023 08:10:51 -0500
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE138D55
        for <linux-kernel@vger.kernel.org>; Fri, 17 Nov 2023 05:10:47 -0800 (PST)
Received: by mail-pf1-x42e.google.com with SMTP id d2e1a72fcca58-6bb4abb8100so1811686b3a.2
        for <linux-kernel@vger.kernel.org>; Fri, 17 Nov 2023 05:10:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20230601.gappssmtp.com; s=20230601; t=1700226647; x=1700831447; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LKUefcBQ+EC714qLkuUiemu7uqNkdjRTt9mSK5vZdm4=;
        b=pEisnRAiQxKlwszHPUIFw9wYMNMvstfy3NgRZzltfBgQGbro872DcP/qLQzxIx11ra
         CE8xaMxdx8dAatc917mhZXeszwOhzWfgtqUvi8VnxIWZqYS8vFO3ojLM1/FarNqmz3s4
         Tn1Atdeg3xpGqJVcHCYm6cEQEdXM0UdZRGFqj76OtfLFJQ+EXAkvKnh5CRD9yn9PMRcR
         sjTwetcfkl51/huIv2Khe46fMzfD1thAnnoGXmfUz6WMYXOAd4hYvQRhiciGWT3IeKq5
         G3tbAwHZHpfP27JAEG3liyQLrB6LsrQmK8W1k4MT4boe6yxeQspkE+rz/LvoP8FwyjOm
         QsJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700226647; x=1700831447;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LKUefcBQ+EC714qLkuUiemu7uqNkdjRTt9mSK5vZdm4=;
        b=mbxo1vTKX5uRTwQ3R5Oz+zpWK2D8kw3iALRYHKOgmgU2pMykJZpctA5PWg3qpMY2EA
         L7Tq6Tl5M+XwOiUeRTCR6ZeeHz3NaymSzcUQbyRBXonQ1/waxcSZh5iZkgVt6hG4y1qg
         9456N27fXkvuyQghhXzALX2CKvoWcPPpAJ/CuO+Ay2R/6Ug+kETqcRcFPBFBBNs00gnq
         reroBg/vzeuPlGXZbmU5D1X0RdDHM6B/oYoPc5fEZBuQZDSdCOJXucR7F20AT7c/WsVR
         +6yieZ0rvczPDlPTlnyNnYN4kgztJVFmnzugRJmk7VuJq7V2mmeccFZqLINmHzTAX5v+
         rRZQ==
X-Gm-Message-State: AOJu0YyIAZuWh4ZElUk/+GTnCsTtQcUe6DkhA95dLazH+C4DfUFLp8TE
        B40PoHYCyitFQ7YSSZTX7kyUuXhP7up4Uh6bHxYWTA==
X-Google-Smtp-Source: AGHT+IHkg0ZKJ4yedCIcxWQHHEubuHsTtpsWiqkyZpXCgKHU9OBeXbOYTtFhOxXyPH/P1PauHAoacm075bpURMWJLoo=
X-Received: by 2002:a05:6a20:3c91:b0:187:eb60:d6de with SMTP id
 b17-20020a056a203c9100b00187eb60d6demr3743444pzj.27.1700226647148; Fri, 17
 Nov 2023 05:10:47 -0800 (PST)
MIME-Version: 1.0
References: <20231020072140.900967-1-apatel@ventanamicro.com>
 <20231020072140.900967-8-apatel@ventanamicro.com> <2023102120-unleveled-composed-45a2@gregkh>
In-Reply-To: <2023102120-unleveled-composed-45a2@gregkh>
From:   Anup Patel <anup@brainfault.org>
Date:   Fri, 17 Nov 2023 18:40:35 +0530
Message-ID: <CAAhSdy00LaD0OLJ1ANtyAm41cCLfRX7SPM=A=4WrG_6bB=9xng@mail.gmail.com>
Subject: Re: [PATCH v3 7/9] tty/serial: Add RISC-V SBI debug console based earlycon
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Anup Patel <apatel@ventanamicro.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Atish Patra <atishp@atishpatra.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Jiri Slaby <jirislaby@kernel.org>,
        Conor Dooley <conor@kernel.org>,
        Andrew Jones <ajones@ventanamicro.com>, kvm@vger.kernel.org,
        kvm-riscv@lists.infradead.org, linux-riscv@lists.infradead.org,
        linux-serial@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 21, 2023 at 10:16=E2=80=AFPM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> On Fri, Oct 20, 2023 at 12:51:38PM +0530, Anup Patel wrote:
> > We extend the existing RISC-V SBI earlycon support to use the new
> > RISC-V SBI debug console extension.
> >
> > Signed-off-by: Anup Patel <apatel@ventanamicro.com>
> > Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
> > ---
> >  drivers/tty/serial/Kconfig              |  2 +-
> >  drivers/tty/serial/earlycon-riscv-sbi.c | 32 +++++++++++++++++++++----
> >  2 files changed, 29 insertions(+), 5 deletions(-)
> >
> > diff --git a/drivers/tty/serial/Kconfig b/drivers/tty/serial/Kconfig
> > index bdc568a4ab66..cec46091a716 100644
> > --- a/drivers/tty/serial/Kconfig
> > +++ b/drivers/tty/serial/Kconfig
> > @@ -87,7 +87,7 @@ config SERIAL_EARLYCON_SEMIHOST
> >
> >  config SERIAL_EARLYCON_RISCV_SBI
> >       bool "Early console using RISC-V SBI"
> > -     depends on RISCV_SBI_V01
> > +     depends on RISCV_SBI
> >       select SERIAL_CORE
> >       select SERIAL_CORE_CONSOLE
> >       select SERIAL_EARLYCON
> > diff --git a/drivers/tty/serial/earlycon-riscv-sbi.c b/drivers/tty/seri=
al/earlycon-riscv-sbi.c
> > index 27afb0b74ea7..c21cdef254e7 100644
> > --- a/drivers/tty/serial/earlycon-riscv-sbi.c
> > +++ b/drivers/tty/serial/earlycon-riscv-sbi.c
> > @@ -15,17 +15,41 @@ static void sbi_putc(struct uart_port *port, unsign=
ed char c)
> >       sbi_console_putchar(c);
> >  }
> >
> > -static void sbi_console_write(struct console *con,
> > -                           const char *s, unsigned n)
> > +static void sbi_0_1_console_write(struct console *con,
> > +                               const char *s, unsigned int n)
> >  {
> >       struct earlycon_device *dev =3D con->data;
> >       uart_console_write(&dev->port, s, n, sbi_putc);
> >  }
> >
> > +static void sbi_dbcn_console_write(struct console *con,
> > +                                const char *s, unsigned int n)
> > +{
> > +     phys_addr_t pa =3D __pa(s);
> > +
> > +     if (IS_ENABLED(CONFIG_32BIT))
> > +             sbi_ecall(SBI_EXT_DBCN, SBI_EXT_DBCN_CONSOLE_WRITE,
> > +                       n, lower_32_bits(pa), upper_32_bits(pa), 0, 0, =
0);
> > +     else
> > +             sbi_ecall(SBI_EXT_DBCN, SBI_EXT_DBCN_CONSOLE_WRITE,
> > +                       n, pa, 0, 0, 0, 0);
>
> This is still a bit hard to follow, and I guarantee it will be a pain to
> maintain over time, trying to keep both calls in sync, right?
>
> Why not fix up sbi_ecall() to get this correct instead?  It should be
> handling phys_addr_t values, not forcing you to do odd bit masking every
> single time you call it, right?  That would make things much easier
> overall, and this patch simpler, as well as the next one.

On RV32 systems, the physical address can be 34bits wide hence
the on RV32 we have to pass physical address as two parameters
whereas on RV64 entier physical address can be passed as single
parameter.

>
> Oh wait, sbi_ecall() is crazy, and just a pass-through, so that's not
> going to work, you need a wrapper function for this mess to do that bit
> twiddeling for you instead of forcing you to do it each time, I guess
> that's what you are trying to do here, but ick, is it correct?

Yes, it is better to have a wrapper function to hide the differences
of RV32 and RV64 systems. I will update.

>
> thanks,
>
> greg k-h
>
> --
> kvm-riscv mailing list
> kvm-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/kvm-riscv

Regards,
Anup
