Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4280F7AD20D
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Sep 2023 09:44:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232382AbjIYHoP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Sep 2023 03:44:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231816AbjIYHoO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Sep 2023 03:44:14 -0400
Received: from mail-vk1-xa31.google.com (mail-vk1-xa31.google.com [IPv6:2607:f8b0:4864:20::a31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA12DE8;
        Mon, 25 Sep 2023 00:44:07 -0700 (PDT)
Received: by mail-vk1-xa31.google.com with SMTP id 71dfb90a1353d-4935f87ca26so1972464e0c.3;
        Mon, 25 Sep 2023 00:44:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695627847; x=1696232647; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0FZ+aw1ZzDM8z4HkChn6PWhnBinXDBdYWg9n+hHmSwU=;
        b=chJVUsKsMFgTP1V8VMRnslA8Wk2w5MnI7K9EGV9+/tL1BTurI0CbC4Z4+fs409S2Ko
         u0rQT0VLEK+tLh2D8urKn8MlCHAuDo4VnKhElFci/zvF311+HzpMrQVjbsgqkrQB9lv9
         k7Bd+4BzUwqgndMrB+Zeei8U44v+8YnAxsXc2yS6C5TkC77y7K1/DpBg8USszOXXVKWE
         RxL1apJHXS86NEYKTt3UoBAHjHO07EL7YhEDAi07ut8ReZRRlDs3IP/feZo8KZ3ArZne
         73nkVx0SIa6SB0h/NidmbqB9cC6hnU5MWuls9DJ/9SmkFqH0+7hHRLek2la+5PdbAoq4
         P6Ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695627847; x=1696232647;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0FZ+aw1ZzDM8z4HkChn6PWhnBinXDBdYWg9n+hHmSwU=;
        b=Dz4CYTLmFehWHxRRpfq787YWJnA7tBBqKujNkeLOcVTGyLucxVRKiGt28T1EBB1NUo
         1JxxZx50/JxmnlOsD0RRTdeKNneLnE0XZdIYJwcny+p4jkL3LxaOjNXtaqM5St3sClsj
         GHiRqQQKSj1O/vsM4FxsayFPxy6unrhw8rUczHoAHVuoahRRBjGE/2Qcza3TA1LII9WD
         ODgYlUC0t+f7zt0u7AsQK4p9u3NZB0EjmcfTCOMZz9Tau/ZNyCL/A993JkUu1tUx0Cg+
         c9K64nl78ViCKeur4YSZ7hXd9eD0l8PahXQKKXVhUcp7MO7oaNIfISRfnBWa9evxSroz
         JDow==
X-Gm-Message-State: AOJu0YzA53p4N7zILSctNL/6vRfy1CtW4a4mayrJYdiZas3wW8wX6xWc
        AO+a4u/119VylX4PDW/Nl19sCdxQrXWeoP6FaF9Opdv2f8ZSEg==
X-Google-Smtp-Source: AGHT+IHvVfQ9W+LMeLg2ulg3HOSURjgOBa8cyRmJHVZEIvv9cHnUlGPsxQPH0N3CIRIDv9nwIZbiBeACyeuX9vue6V0=
X-Received: by 2002:a1f:e2c3:0:b0:495:cac2:2532 with SMTP id
 z186-20020a1fe2c3000000b00495cac22532mr2588037vkg.8.1695627846734; Mon, 25
 Sep 2023 00:44:06 -0700 (PDT)
MIME-Version: 1.0
References: <3241c1386e1ba0bc288496a36365bd764e17fdae.1695368979.git.geert+renesas@glider.be>
In-Reply-To: <3241c1386e1ba0bc288496a36365bd764e17fdae.1695368979.git.geert+renesas@glider.be>
From:   "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date:   Mon, 25 Sep 2023 08:43:41 +0100
Message-ID: <CA+V-a8vK7-98aHZUBMpNpyehjG8pYf_0Vu8NmWq5bS3-eWTRKQ@mail.gmail.com>
Subject: Re: [PATCH] irqchip: renesas-rzg2l: Convert to irq_data_get_irq_chip_data()
To:     Geert Uytterhoeven <geert+renesas@glider.be>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org
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

On Fri, Sep 22, 2023 at 9:09=E2=80=AFAM Geert Uytterhoeven
<geert+renesas@glider.be> wrote:
>
> Use the existing irq_data_get_irq_chip_data() helper instead of
> open-coding the same operation.
>
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---
>  drivers/irqchip/irq-renesas-rzg2l.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
Reviewed-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

Cheers,
Prabhakar

> diff --git a/drivers/irqchip/irq-renesas-rzg2l.c b/drivers/irqchip/irq-re=
nesas-rzg2l.c
> index 4bbfa2b0a4df9b83..c0f3c09affa64511 100644
> --- a/drivers/irqchip/irq-renesas-rzg2l.c
> +++ b/drivers/irqchip/irq-renesas-rzg2l.c
> @@ -131,7 +131,7 @@ static void rzg2l_irqc_irq_enable(struct irq_data *d)
>
>         if (hw_irq >=3D IRQC_TINT_START && hw_irq < IRQC_NUM_IRQ) {
>                 struct rzg2l_irqc_priv *priv =3D irq_data_to_priv(d);
> -               unsigned long tint =3D (uintptr_t)d->chip_data;
> +               unsigned long tint =3D (uintptr_t)irq_data_get_irq_chip_d=
ata(d);
>                 u32 offset =3D hw_irq - IRQC_TINT_START;
>                 u32 tssr_offset =3D TSSR_OFFSET(offset);
>                 u8 tssr_index =3D TSSR_INDEX(offset);
> --
> 2.34.1
>
