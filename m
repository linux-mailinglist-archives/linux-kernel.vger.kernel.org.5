Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC01F7A1A09
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Sep 2023 11:11:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233311AbjIOJLe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Sep 2023 05:11:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233462AbjIOJLL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Sep 2023 05:11:11 -0400
Received: from mail-vk1-xa30.google.com (mail-vk1-xa30.google.com [IPv6:2607:f8b0:4864:20::a30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA37A1FD0;
        Fri, 15 Sep 2023 02:10:38 -0700 (PDT)
Received: by mail-vk1-xa30.google.com with SMTP id 71dfb90a1353d-4935f87ca26so825794e0c.3;
        Fri, 15 Sep 2023 02:10:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1694769038; x=1695373838; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gJnx3mkmeAUY7F7tJ/KOS3Ct0lvpI7xMMW+QXJ8wpEw=;
        b=hM8Il7sM2KaSg4VfKDRnmvT4vob1EE8SFFHOgpBAm5tZIZyCYGX0JsmUmUVjjdRTgN
         jLvyS8ztTDWlWwilCrb+r3orLi/pvrgU+TWzYGvVEFP3ILGerpSMa5qeZTvS1IVfDHcU
         WBzBP4fJV+LESVndMrihBR4y6EIcvXi65x5SkG1lnFmLT14hxwVl++JmjC4SjJn4PSfz
         mRjMNkypXXmTv8oTAXBzyE3I6cGV0IaCkKaDAe+4e8UlMkOojc7O80NqOQbAzSNsn7e6
         EeaYxmxi1TIx2C+BLFlT/CTwSFFjrDZ58tsYgJJ2kveKXZqvSdvq7rowanRZ5BvP/xyH
         5XrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694769038; x=1695373838;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gJnx3mkmeAUY7F7tJ/KOS3Ct0lvpI7xMMW+QXJ8wpEw=;
        b=q5efweLK0snmrZArkFS6VKTb/NP4co5EQmIJAuH5jf6LoCsOHCDiwVVVo2RAtfCegT
         yDc4BCCJ7kkFMPhdFLH6AAw98DJkFqzrGlD75AieqMsMp4HyOWfPhEkJ39XGyWFIgjFJ
         mY9k+rLL6NvrgPb0ybeTANoH4J+dPlZjLL1ARN684f0oenTYHyuSF1GldovrLQTXp1DN
         dOFAwZ0cEY3ruqITD3/0lZ57cTTEpwoskucVO9C0hIKvwC1u3vPrkbJE+QQ+yWhIW/DI
         4aESFoGA2CyP2DxE9khf7Ce6tVP+wQT6qcbWMwe81X1WpZ6C0Womuxn5Li7xZRFsKoOf
         t3Ow==
X-Gm-Message-State: AOJu0YyKjUhugC46tW6XoeBr0iGFCHfVcZeeyIZPttAh2HTCDrIxm+pk
        THZ2qegHt/p+uczTg8pkuDStEsxfiOgzv2WcvXw=
X-Google-Smtp-Source: AGHT+IGgHtby0Q8edMJxzP9oy0I89jpIG8Wq55oA1wjN17+ida/bzOnHMygNtlXP79OQXCK4LJe0QwrZ2R1RXxMUZ0k=
X-Received: by 2002:a1f:4b81:0:b0:495:bd33:d1f8 with SMTP id
 y123-20020a1f4b81000000b00495bd33d1f8mr1029076vka.13.1694769037794; Fri, 15
 Sep 2023 02:10:37 -0700 (PDT)
MIME-Version: 1.0
References: <2a3a9d595579b7cea416c12bf9abcfa2227243bb.1694768174.git.geert+renesas@glider.be>
In-Reply-To: <2a3a9d595579b7cea416c12bf9abcfa2227243bb.1694768174.git.geert+renesas@glider.be>
From:   "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date:   Fri, 15 Sep 2023 10:09:26 +0100
Message-ID: <CA+V-a8vxaspX+VsaJ=ps+R325bDqPvrJ_OwcT=CSe2Vtkf56vw@mail.gmail.com>
Subject: Re: [PATCH] soc: renesas: Kconfig: Remove blank line before
 ARCH_R9A07G043 help text
To:     Geert Uytterhoeven <geert+renesas@glider.be>
Cc:     Magnus Damm <magnus.damm@gmail.com>,
        Palmer Dabbelt <palmer@rivosinc.com>,
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

Hi Geert,

Thank you for fixing it.

On Fri, Sep 15, 2023 at 10:06=E2=80=AFAM Geert Uytterhoeven
<geert+renesas@glider.be> wrote:
>
> There should not be a blank line before the "help" keyword in the
> ARCH_R9A07G043 configuration section.
>
> Fixes: c6a906cce61a8015 ("soc: renesas: Kconfig: For ARCH_R9A07G043 selec=
t the required configs if dependencies are met")
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---
> To be queued in renesas-devel for v6.7.
>
>  drivers/soc/renesas/Kconfig | 1 -
>  1 file changed, 1 deletion(-)
>
Reviewed-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

Cheers,
Prabhakar

> diff --git a/drivers/soc/renesas/Kconfig b/drivers/soc/renesas/Kconfig
> index bb1bb004b6a44b01..dd3f074d7b09b9bb 100644
> --- a/drivers/soc/renesas/Kconfig
> +++ b/drivers/soc/renesas/Kconfig
> @@ -343,7 +343,6 @@ config ARCH_R9A07G043
>         select DMA_GLOBAL_POOL
>         select ERRATA_ANDES if RISCV_SBI
>         select ERRATA_ANDES_CMO if ERRATA_ANDES
> -
>         help
>           This enables support for the Renesas RZ/Five SoC.
>
> --
> 2.34.1
>
