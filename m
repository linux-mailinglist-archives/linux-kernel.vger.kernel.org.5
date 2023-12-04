Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28B4E803F57
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Dec 2023 21:32:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345534AbjLDUcc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 15:32:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229741AbjLDUca (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 15:32:30 -0500
Received: from mail-vk1-xa31.google.com (mail-vk1-xa31.google.com [IPv6:2607:f8b0:4864:20::a31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9441D7
        for <linux-kernel@vger.kernel.org>; Mon,  4 Dec 2023 12:32:36 -0800 (PST)
Received: by mail-vk1-xa31.google.com with SMTP id 71dfb90a1353d-4b2da1fa27aso467833e0c.3
        for <linux-kernel@vger.kernel.org>; Mon, 04 Dec 2023 12:32:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701721956; x=1702326756; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KU+uMIFFgAmEpiU6c77Vf2nx1gSzq3cfvabr3WepOyQ=;
        b=eQaI5NeGZTQTJXLS5boGt4fSswWK83Eb+P3m09f+FOoDqL5/SN0WMiXqjUNO+VQZXb
         BNaw2CcpLnS+iFEk76N4imZas7r3Zq5Eg/wQWio2O33tmwxAVZjOuQeHPD3IhWBC3P3D
         KmjrJuAN0SIQglRn7hJateXyeRcYYaJfGzf2SPcYTX4KJY3mb4C3g+eb43d+R9V98FJz
         8W/xlWlypIjYC9cHsA2pr38tHirwxtqza3ClemCmiX0VeoLJbEyvTqQQRm1WqSUjELgM
         gZegaSAbleUNWyEGgXl5wZf5lpvGRidwLRdlvBOemb7ypRGN3AbaieUN79SwZbWGE+4r
         DOUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701721956; x=1702326756;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KU+uMIFFgAmEpiU6c77Vf2nx1gSzq3cfvabr3WepOyQ=;
        b=SA5nSa9YcCR9HxfHS97V0KkNf++Bo6pE7wXfZW49+I8Qm+RjW6WascZiWIuFITGQFB
         DwtCmOdq6U3ieuJ6FDI4c0Rz8CwvY4E4BEAOzlqcTwvK8sqbn1fQsGWJ7rgD6HIWpRNU
         h0Bes4xMdP1Dzzlnh0hqfky3p4OscpATIbSUQ+w8ZrcOhu5P8o+xcdL75BhvocDkFip5
         Qo8ccOx9Y5zox7wumtpGV8fM0D3CiyKJnq5WgRQin6ltxHXaEV8NNoUn5UfRYarUEbyc
         RZ2yQJecqlHHaav5bG/OuiNqQQwUWslzH/dkjWyIPovacVTmNHu6gk97TWwL0Z+rM2Y3
         DMsg==
X-Gm-Message-State: AOJu0YxftERazhsqHc3trYU27RrnvDL74fubNfZfbJKGgi28aV48GnpX
        sIjkaVrhbL8rTYCwIcmzYws/Rj32YaxaGcjkn/s=
X-Google-Smtp-Source: AGHT+IGu0ngoxmxpANdg+qQKpT1lSXw3q29D5jHvOa6rqcTSWK4y8t6Y9zeQBCTCz8XSpMtwt41gbfNNdHaMja0WthQ=
X-Received: by 2002:a1f:c502:0:b0:4b2:87d3:4936 with SMTP id
 v2-20020a1fc502000000b004b287d34936mr3023418vkf.6.1701721955821; Mon, 04 Dec
 2023 12:32:35 -0800 (PST)
MIME-Version: 1.0
References: <20231127-module_linking_freeing-v4-0-a2ca1d7027d0@rivosinc.com> <20231127-module_linking_freeing-v4-2-a2ca1d7027d0@rivosinc.com>
In-Reply-To: <20231127-module_linking_freeing-v4-2-a2ca1d7027d0@rivosinc.com>
From:   "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date:   Mon, 4 Dec 2023 20:32:10 +0000
Message-ID: <CA+V-a8thghtOuzSQ1gW9-_KCswtTpYyN09QbrYDMTnW79TOCNw@mail.gmail.com>
Subject: Re: [PATCH v4 2/2] riscv: Correct type casting in module loading
To:     Charlie Jenkins <charlie@rivosinc.com>
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>, Ron Economos <re@w6rz.net>,
        Samuel Holland <samuel.holland@sifive.com>,
        Andreas Schwab <schwab@linux-m68k.org>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 27, 2023 at 10:08=E2=80=AFPM Charlie Jenkins <charlie@rivosinc.=
com> wrote:
>
> Use __le16 with le16_to_cpu.
>
> Fixes: 8fd6c5142395 ("riscv: Add remaining module relocations")
> Signed-off-by: Charlie Jenkins <charlie@rivosinc.com>
> Reviewed-by: Samuel Holland <samuel.holland@sifive.com>
> Tested-by: Samuel Holland <samuel.holland@sifive.com>
> ---
>  arch/riscv/kernel/module.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
Tested-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com> #On
RZ/Five SMARC EVK

Cheers,
Prabhakar

> diff --git a/arch/riscv/kernel/module.c b/arch/riscv/kernel/module.c
> index 53593fe58cd8..aac019ed63b1 100644
> --- a/arch/riscv/kernel/module.c
> +++ b/arch/riscv/kernel/module.c
> @@ -55,7 +55,7 @@ static bool riscv_insn_valid_32bit_offset(ptrdiff_t val=
)
>
>  static int riscv_insn_rmw(void *location, u32 keep, u32 set)
>  {
> -       u16 *parcel =3D location;
> +       __le16 *parcel =3D location;
>         u32 insn =3D (u32)le16_to_cpu(parcel[0]) | (u32)le16_to_cpu(parce=
l[1]) << 16;
>
>         insn &=3D keep;
> @@ -68,7 +68,7 @@ static int riscv_insn_rmw(void *location, u32 keep, u32=
 set)
>
>  static int riscv_insn_rvc_rmw(void *location, u16 keep, u16 set)
>  {
> -       u16 *parcel =3D location;
> +       __le16 *parcel =3D location;
>         u16 insn =3D le16_to_cpu(*parcel);
>
>         insn &=3D keep;
>
> --
> 2.42.0
>
>
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv
