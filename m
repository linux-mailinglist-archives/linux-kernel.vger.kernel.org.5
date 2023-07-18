Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62EEC7585E4
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 21:59:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230036AbjGRT70 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 15:59:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229504AbjGRT7Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 15:59:25 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82B639D;
        Tue, 18 Jul 2023 12:59:24 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id a640c23a62f3a-9926623e367so859470266b.0;
        Tue, 18 Jul 2023 12:59:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689710363; x=1692302363;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wzQFRU62tvGxu9U/FBj8A0EPoudlBBKB+Wz+vTeB68g=;
        b=YZlwfJC/Zjx+iv7hXUbIzloFGOoaRIrUVGZmOGpt9pSsqg4zT+AN2nHfnC6gqcwLUM
         3o6mU3xkfwjpyfebd9VztdJD1KzMBkN+x2wszybwo85IhWW/KSiuKPLdR+6erZjXPZx3
         M4ywC0iUuIEtcXKXll6P4kmMQF9aGGfqErNejEChTbLCjaZf/riqwSbOjrcqMy3sfQkn
         Ly3WMEC5bWFpweiVHiQUz0dFR7///nKOmercGj2/z7UtAVBCBTiVLuo6mM6fsX+MBBp+
         P9vvgAjLjvnxOIpe8+Y2FfMi7v90RWiyHy443CofGPJiPvorGSaPlvIEYzfOVuFDSl7W
         EZTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689710363; x=1692302363;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wzQFRU62tvGxu9U/FBj8A0EPoudlBBKB+Wz+vTeB68g=;
        b=IoOh48+YDTxcAaNidnqrQuBACm0p8WQr0E5NPNyBsIzh2zAX97IvWhw+Csz8prSIbV
         YZbI2bxbZzbKYq5WpSdRUwkgzp2bipP37Vc+I26O/UbzAnyVfhQM5sLJSQcgnERcuZmp
         ctA2tYp+UWr0quNr2k0+JoOklgNomB7KvGvb2VWIiFuIEnk+r4KB4DIVnuGofIJZxsF9
         DYaOk6brVjQYJe1DxBO6QaXZfF//R657DHOWyIwKl3jqVxvMY91JFJxXZSS1zmxK4903
         ds/oQIom/gJulqL9yITh6mchGLUgKXHSh0+mkJzFS/sQLLETMjqGeQamQckCK2WJl1WH
         gEeA==
X-Gm-Message-State: ABy/qLbOTCREnmoO18n03NOC1MDzjJqYZ6Y1DkUcRD2CYSnjzaSl/KXu
        dt0vxyfRfCis4zoggQpl3q9kMWGs/lpmfnW6yHw=
X-Google-Smtp-Source: APBJJlGFOtqJOO+QnjWhDDW2Vd4wvZXcxFdwjI9ufX7q5kFJu/XJLs4i34BPHU0jJJ48Umu2yknYlNFBilgM/T08SM8=
X-Received: by 2002:a17:906:1059:b0:992:48b7:99e3 with SMTP id
 j25-20020a170906105900b0099248b799e3mr533275ejj.63.1689710362897; Tue, 18 Jul
 2023 12:59:22 -0700 (PDT)
MIME-Version: 1.0
References: <20230718192453.543549-1-fabrizio.castro.jz@renesas.com> <20230718192453.543549-3-fabrizio.castro.jz@renesas.com>
In-Reply-To: <20230718192453.543549-3-fabrizio.castro.jz@renesas.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Tue, 18 Jul 2023 22:58:46 +0300
Message-ID: <CAHp75Vc9DG69pbCACB9o6=1pFDHYUkzwi6siXNOywQ-_Uzb4vA@mail.gmail.com>
Subject: Re: [PATCH v2 2/4] spi: rzv2m-csi: Improve data types, casting and alignment
To:     Fabrizio Castro <fabrizio.castro.jz@renesas.com>
Cc:     Mark Brown <broonie@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        Biju Das <biju.das@bp.renesas.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        linux-renesas-soc@vger.kernel.org
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

On Tue, Jul 18, 2023 at 10:25=E2=80=AFPM Fabrizio Castro
<fabrizio.castro.jz@renesas.com> wrote:
>
> "unsigned int" is more appropriate than "int" for the members
> of "struct rzv2m_csi_priv".
> Using void* rather than u8* for txbuf and rxbuf allows for
> the removal of some type casting.
> Remove the unnecessary casting of "data" to "struct rzv2m_csi_priv*"
> in function "rzv2m_csi_irq_handler".
> Also, members "bytes_per_word" and "errors" introduce gaps
> in the structure.
> Adjust "struct rzv2m_csi_priv" and its members usage accordingly.

Hmm... A bit of fancy indentation. Why is each sentence separated?

...

>         wait_queue_head_t wait;
> -       u8 errors;
> +       u32 errors;
>         u32 status;

As far as I understand Geert he wanted something like

  u32 status;
  u8 errors;

...

> -               u16 *buf =3D (u16 *)csi->txbuf;
> +               const u16 *buf =3D csi->txbuf;

> -               u8 *buf =3D (u8 *)csi->txbuf;
> +               const u8 *buf =3D csi->txbuf;

> -               u16 *buf =3D (u16 *)csi->rxbuf;
> +               u16 *buf =3D csi->rxbuf;

> -               u8 *buf =3D (u8 *)csi->rxbuf;
> +               u8 *buf =3D csi->rxbuf;

Yep, these look much better now.

--=20
With Best Regards,
Andy Shevchenko
