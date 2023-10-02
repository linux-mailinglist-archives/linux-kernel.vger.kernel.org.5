Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C94937B5662
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Oct 2023 17:38:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238038AbjJBPSa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Oct 2023 11:18:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237823AbjJBPS3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Oct 2023 11:18:29 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB4F3B3
        for <linux-kernel@vger.kernel.org>; Mon,  2 Oct 2023 08:18:25 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id 98e67ed59e1d1-2773af0c5dbso9336636a91.1
        for <linux-kernel@vger.kernel.org>; Mon, 02 Oct 2023 08:18:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1696259905; x=1696864705; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Xw7QdnIT6pMfMgjKXoJDij3f+XvSgPQK38vQOQ+QTs8=;
        b=klPhw9Bm8vgVDO0dWydxfcKwpHtRbEtdcRCfn8x3FWlrl3sbC+MdEkaQMKd6aebPyK
         FQBs1fmvKiKrWUKmEAc/X9kkNO9cfq5a2IDy2NcgsXiAqwA1CNYzGkokkQB5xd9h5ESR
         DA5pgj+AM6rgb+t4dbtWyh7gFKXYKCHqjvy+xFGi5UZnU9XoECWmuUuxtNDi/ntSNfJD
         JqbMPQvq3ZvlQL3lUgyUZzx9psED8LJnGKTg3p2KOnuXLETVkiBDsgJDnLuaOEfLgk9o
         R6Q+EVXlaoibexbOKsrz1bH1nKas4mJ1UBgZmU378U4Rp41MaE0xWPSA7SiP+k3+UfDB
         C7Zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696259905; x=1696864705;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Xw7QdnIT6pMfMgjKXoJDij3f+XvSgPQK38vQOQ+QTs8=;
        b=D/7iYtX1wOdKnFf53Mm+EAPwDD8aFndE9Ux62Ec2pUSQftVkxlEWk6rHUDt6kSRpst
         2Qvk3/Lkgs3WFcj5wQFKq0PWgLzD7bUNdEd4sZuxYW2y+X0ExTlBNQRBew638kaNQSHy
         Fyz0clcSYuiAZImszYCVeGvUSR4BSWQcSO0oo4iUtlH6+SvXTgT2d9vOAP1m+8gnljYq
         tVshCTDWJTXqursvKMZnVnxvSr/xg6cUwpQG04og/0terVHCeqvCBsC61gqQ9V19Fszz
         7kQarto/jJp+cFBpfLvCjpfdAaXWIMEZni4VcnQ0TLavc/UvyAVYAnVt+WSV2K7F6Laa
         CrAw==
X-Gm-Message-State: AOJu0YzwYxdvQHAg8TnUmdjfUbFuFWzTBK1k1g6cJ2quk9+Fh7/VAofY
        y/WcttfAw3R72yio2LzQvBCTBi4OulqMgf3jbCSPdA==
X-Google-Smtp-Source: AGHT+IExQzqmMZpcgxUYWYYZRO3DyThsJv/MhEoZGi6g+28XkYKxTqNm3icOqRRCLuljZY21JBxxTIp2JmHSnkkcNF0=
X-Received: by 2002:a17:90a:5ac6:b0:268:93d:b936 with SMTP id
 n64-20020a17090a5ac600b00268093db936mr8611041pji.18.1696259904904; Mon, 02
 Oct 2023 08:18:24 -0700 (PDT)
MIME-Version: 1.0
References: <20230928061207.1841513-1-apatel@ventanamicro.com>
 <20230928061207.1841513-6-apatel@ventanamicro.com> <87bkdlma6j.wl-maz@kernel.org>
In-Reply-To: <87bkdlma6j.wl-maz@kernel.org>
From:   Anup Patel <apatel@ventanamicro.com>
Date:   Mon, 2 Oct 2023 20:48:12 +0530
Message-ID: <CAK9=C2VfsSMaawuTRcrbSFGE9yYBDO1Q0oBksD-NKmrz8WynMw@mail.gmail.com>
Subject: Re: [PATCH v9 05/15] irqchip/sifive-plic: Convert PLIC driver into a
 platform driver
To:     Marc Zyngier <maz@kernel.org>
Cc:     Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Conor Dooley <conor+dt@kernel.org>,
        Atish Patra <atishp@atishpatra.org>,
        Andrew Jones <ajones@ventanamicro.com>,
        Sunil V L <sunilvl@ventanamicro.com>,
        Saravana Kannan <saravanak@google.com>,
        Anup Patel <anup@brainfault.org>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 29, 2023 at 6:02=E2=80=AFPM Marc Zyngier <maz@kernel.org> wrote=
:
>
> On Thu, 28 Sep 2023 07:11:57 +0100,
> Anup Patel <apatel@ventanamicro.com> wrote:
> >
> > The PLIC driver does not require very early initialization so let
> > us convert it into a platform driver.
>   ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> >
> > As part of the conversion, the PLIC probing undergoes the following
> > changes:
> > 1. Use dev_info(), dev_err() and dev_warn() instead of pr_info(),
> >    pr_err() and pr_warn()
> > 2. Use devm_xyz() APIs wherever applicable
> > 3. PLIC is now probed after CPUs are brought-up so we have to
> >    setup cpuhp state after context handler of all online CPUs
> >    are initialized otherwise we see crash on multi-socket systems
> >
> > Signed-off-by: Anup Patel <apatel@ventanamicro.com>
> > ---
> >  drivers/irqchip/irq-sifive-plic.c | 242 +++++++++++++++++++-----------
> >  1 file changed, 154 insertions(+), 88 deletions(-)
> >
>
> [...]
>
> > +core_initcall(plic_init);
>
> Or not. There are only two choices: either you absolutely require
> early init, and you stick with the current situation, or you don't,
> and you can rely on dependencies.
>
> I'm not prepared to have a third option.

This is not required for DT based platform driver probing so
I will use builtin_platform_driver() over here and in APLIC
as well as IMSIC platform drivers.

Regards,
Anup

>
>         M.
>
> --
> Without deviation from the norm, progress is not possible.
