Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 518907F5C9F
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Nov 2023 11:39:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344708AbjKWKjk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Nov 2023 05:39:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344448AbjKWKji (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Nov 2023 05:39:38 -0500
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27D4A1BD
        for <linux-kernel@vger.kernel.org>; Thu, 23 Nov 2023 02:39:45 -0800 (PST)
Received: by mail-pl1-x62c.google.com with SMTP id d9443c01a7336-1cf6bdf8274so13110565ad.1
        for <linux-kernel@vger.kernel.org>; Thu, 23 Nov 2023 02:39:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1700735984; x=1701340784; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FQ5cHR9g9Ex7S7K/JEODWQbh9BgcOaeTZEBwA4kKzCg=;
        b=V19SrVhhpEqFvV+Amp8RUVdhnT1zkmIZsAEd24PdNeQRX420Dntqw5VMraaikgflFM
         T38pE2KhtV3Jjjzd2m4jA71yPAdsyMya+d33Wvy+hPIjIQ5FjwgiHSTZuSjVfXbraz9O
         MFoT16P8OBNSMT2JCbeP2DaKCXt0fghEwnM59MUsR54s4KtfIwIzTcEkZbVmBKTvJB/+
         pulUz9f9NfMbmfnRLsPeZA/1uR8Kh7bSIZRtFwvX7vc1r4AVfJnYYUBA1e82IHZ4o0LR
         PXOqp8IsI3u5OQgTe/GoJlsQfDQzMKpTXOz0R7yzA+u5HDyi+VJvuUhSgE6aL/vmbJsO
         G5Ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700735984; x=1701340784;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FQ5cHR9g9Ex7S7K/JEODWQbh9BgcOaeTZEBwA4kKzCg=;
        b=TjlaMwlmagNPAz6Pcf3/F8vJVyMGtnCClIrjCQQ7cXqRfYGSDBU5XDIxQjgKhsjLzu
         nl8Qjqw0qFQGXKwqB+9olanUanZMYsUMrAi7y9alBptp0dRrRsGNqb218A8Z3VKY9DGX
         LenRzMDX8sDlDPkJjweNGuU3SaLpwpPZWEJHBLhuWkMmQrBbUNyWxtvdPvMVAq5/voX0
         /YoYO5Sp2vHm9dwrpdvfo05uOSD+dulIj+3NLupEfTYRDuKKA7zTEyXnTaTXUa49M3ty
         Ej0vRLKijJWoZ6AZMH4aFmQNiXa8pIlYQ1vVvvij6J2FekHbEhXgcWYhdAK9ZBV4Ft3Q
         EDKg==
X-Gm-Message-State: AOJu0YwLqUr15gipVONMDhSkqPG2n9Jk8M4IiBbSCX5PGIuQ0ytvus6V
        vjpVhrLovd0/NVlPMbhZc5iIA2vR0uv/PKhygg+RLg==
X-Google-Smtp-Source: AGHT+IG99YAMevSp0jGufV7mXYc4HBJFz0NMYVlrsS8HZwf7nEtTjYohwnzETeJL+MEJrNZlmD9vq5lOCr8swdpaVqw=
X-Received: by 2002:a17:90a:bf0b:b0:280:47ba:767a with SMTP id
 c11-20020a17090abf0b00b0028047ba767amr3176568pjs.16.1700735984411; Thu, 23
 Nov 2023 02:39:44 -0800 (PST)
MIME-Version: 1.0
References: <20231118033859.726692-1-apatel@ventanamicro.com>
 <20231118033859.726692-6-apatel@ventanamicro.com> <fb72e212-711e-4be9-9b92-89b2dc121476@sifive.com>
In-Reply-To: <fb72e212-711e-4be9-9b92-89b2dc121476@sifive.com>
From:   Anup Patel <apatel@ventanamicro.com>
Date:   Thu, 23 Nov 2023 16:09:32 +0530
Message-ID: <CAK9=C2W+Rb85Dm+sN=PXgN3wpbJFrvctBvC-Coi1Q_TsvthWYA@mail.gmail.com>
Subject: Re: [PATCH v4 5/5] RISC-V: Enable SBI based earlycon support
To:     Samuel Holland <samuel.holland@sifive.com>
Cc:     Conor Dooley <conor@kernel.org>,
        Andrew Jones <ajones@ventanamicro.com>,
        linux-riscv@lists.infradead.org, linux-serial@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 22, 2023 at 4:18=E2=80=AFAM Samuel Holland
<samuel.holland@sifive.com> wrote:
>
> Hi Anup,
>
> On 2023-11-17 9:38 PM, Anup Patel wrote:
> > Let us enable SBI based earlycon support in defconfigs for both RV32
> > and RV64 so that "earlycon=3Dsbi" can be used again.
> >
> > Signed-off-by: Anup Patel <apatel@ventanamicro.com>
> > Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
> > ---
> >  arch/riscv/configs/defconfig      | 1 +
> >  arch/riscv/configs/rv32_defconfig | 1 +
> >  2 files changed, 2 insertions(+)
> >
> > diff --git a/arch/riscv/configs/defconfig b/arch/riscv/configs/defconfi=
g
> > index 905881282a7c..eaf34e871e30 100644
> > --- a/arch/riscv/configs/defconfig
> > +++ b/arch/riscv/configs/defconfig
> > @@ -149,6 +149,7 @@ CONFIG_SERIAL_8250_CONSOLE=3Dy
> >  CONFIG_SERIAL_8250_DW=3Dy
> >  CONFIG_SERIAL_OF_PLATFORM=3Dy
> >  CONFIG_SERIAL_SH_SCI=3Dy
> > +CONFIG_SERIAL_EARLYCON_RISCV_SBI=3Dy
> >  CONFIG_VIRTIO_CONSOLE=3Dy
> >  CONFIG_HW_RANDOM=3Dy
> >  CONFIG_HW_RANDOM_VIRTIO=3Dy
> > diff --git a/arch/riscv/configs/rv32_defconfig b/arch/riscv/configs/rv3=
2_defconfig
> > index 89b601e253a6..5721af39afd1 100644
> > --- a/arch/riscv/configs/rv32_defconfig
> > +++ b/arch/riscv/configs/rv32_defconfig
>
> This file isn't used anymore since 72f045d19f25 ("riscv: Fixup difference=
 with
> defconfig"), so there's no need to update it. I'll send a patch deleting =
it.

Okay, I will drop the changes in rv32_defconfig.

>
> Regards,
> Samuel
>
> > @@ -66,6 +66,7 @@ CONFIG_INPUT_MOUSEDEV=3Dy
> >  CONFIG_SERIAL_8250=3Dy
> >  CONFIG_SERIAL_8250_CONSOLE=3Dy
> >  CONFIG_SERIAL_OF_PLATFORM=3Dy
> > +CONFIG_SERIAL_EARLYCON_RISCV_SBI=3Dy
> >  CONFIG_VIRTIO_CONSOLE=3Dy
> >  CONFIG_HW_RANDOM=3Dy
> >  CONFIG_HW_RANDOM_VIRTIO=3Dy
>

Regards,
Anup
