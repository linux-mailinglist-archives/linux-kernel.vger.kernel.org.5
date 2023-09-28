Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83A5D7B11A9
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Sep 2023 06:43:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230182AbjI1Em6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Sep 2023 00:42:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229460AbjI1Emx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Sep 2023 00:42:53 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A31A19F
        for <linux-kernel@vger.kernel.org>; Wed, 27 Sep 2023 21:42:51 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id a640c23a62f3a-9a64619d8fbso1613542166b.0
        for <linux-kernel@vger.kernel.org>; Wed, 27 Sep 2023 21:42:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1695876170; x=1696480970; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mtW2DaDex4/qq5KYNshzbiXk1ZKdWPIH7i0eyiB1QPA=;
        b=i6y1Vu0sfJHLPXfDGY7n6wdXFNbO7UmkAyHcECjLix6U9u/lEnkbRJsaDQqVDc9da2
         1JlcNfxTwVnct1seNlZ2w1MSd+ZpvW7VT4pXGlnUZ+7bDWQmcPZTfC3+5+syXO3lnXeC
         wzaa5BLaAkBuozg+9J5eWe3RIv9Q16nr933238SEFy++aJ2Ga/FgMabys9HN3vnU3E/j
         aal5HLei0ANKgQxpaQqM6BXC8i4qyFIZ3Bl7EfR4HR6C9iX+r6E4lyb266zTYkiNsEVy
         IcsGyNcv9lGKIxhaIXGV/p+KyOyISTFLZgZRlDirJ1lpWnF0meK8JoFXF9wRdB/tjYSg
         0afg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695876170; x=1696480970;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mtW2DaDex4/qq5KYNshzbiXk1ZKdWPIH7i0eyiB1QPA=;
        b=O6cZLXoRpK2gWLOqH2p7/cBD7D5Cw7lyMzmMcA9rQr3877OhEOqGogBR5j60Gbri3y
         cL2DYFjCNW1sfOYedTOipSc//S7+1Ky3qgIJSM2tp3gjm42/TFcILpmQ/66VNXw+nSgn
         XHnHQJWK9upsXVzRisu20F8t0y+VqaRHZolCIj4jb+WgvlKd17CiSvzGSEBe4U4TTcSg
         ZNVE55P0V/P+VUe6UqRfW2YQtpjsMyGTtBzS21ciVW4O1OKrJonTXk5ovnlDsZO0kYpy
         aguFIh9t/Iv1MdsgxmgpbjF/zoQuTrukfHSWINUShZbViPr4VkvkCzidJpKwnnyeftgy
         ShOQ==
X-Gm-Message-State: AOJu0Yw3L7KanBRXORMIE5Z64tvf6A8PdOVYySpZpV5m79QeyZHgTcgF
        99FM/5df7qZCZh2JvlU115loH6MdQXNVAtS2P4rmBA==
X-Google-Smtp-Source: AGHT+IHPBAmhx+er6QkuJRIUAhKqf0BCJK7e+59Jegd3S5xW+6aqnkbAfNHzBG5wu6mzEd52bNAKmrbIN7pJkCOCyI0=
X-Received: by 2002:a17:907:78d4:b0:9ae:588e:cdde with SMTP id
 kv20-20020a17090778d400b009ae588ecddemr163330ejc.11.1695876169938; Wed, 27
 Sep 2023 21:42:49 -0700 (PDT)
MIME-Version: 1.0
References: <20230922175344.work.987-kees@kernel.org>
In-Reply-To: <20230922175344.work.987-kees@kernel.org>
From:   Justin Stitt <justinstitt@google.com>
Date:   Thu, 28 Sep 2023 13:42:39 +0900
Message-ID: <CAFhGd8oz9zTVacJMEWv4-hpNeXbPLYQ6fnb2z_2Y++rWyVSUow@mail.gmail.com>
Subject: Re: [PATCH] hte: Annotate struct hte_device with __counted_by
To:     Kees Cook <keescook@chromium.org>
Cc:     Dipen Patel <dipenp@nvidia.com>, timestamp@lists.linux.dev,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev, linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 23, 2023 at 2:54=E2=80=AFAM Kees Cook <keescook@chromium.org> w=
rote:
>
> Prepare for the coming implementation by GCC and Clang of the __counted_b=
y
> attribute. Flexible array members annotated with __counted_by can have
> their accesses bounds-checked at run-time checking via CONFIG_UBSAN_BOUND=
S
> (for array indexing) and CONFIG_FORTIFY_SOURCE (for strcpy/memcpy-family
> functions).
>
> As found with Coccinelle[1], add __counted_by for struct hte_device.
>
> [1] https://github.com/kees/kernel-tools/blob/trunk/coccinelle/examples/c=
ounted_by.cocci
>
> Cc: Dipen Patel <dipenp@nvidia.com>
> Cc: timestamp@lists.linux.dev
> Signed-off-by: Kees Cook <keescook@chromium.org>

Yep, this flexible array member is counted by @nlines which
is evident throughout hte.c:

        gdev =3D kzalloc(struct_size(gdev, ei, chip->nlines), GFP_KERNEL);
        ...
        gdev->nlines =3D chip->nlines;
        ...
        for (i =3D 0; i < chip->nlines; i++) {
          gdev->ei[i].gdev =3D gdev;
        ...


Reviewed-by: Justin Stitt <justinstitt@google.com>

> ---
>  drivers/hte/hte.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/hte/hte.c b/drivers/hte/hte.c
> index 598a716b7364..1fd8d2d4528b 100644
> --- a/drivers/hte/hte.c
> +++ b/drivers/hte/hte.c
> @@ -88,7 +88,7 @@ struct hte_device {
>         struct list_head list;
>         struct hte_chip *chip;
>         struct module *owner;
> -       struct hte_ts_info ei[];
> +       struct hte_ts_info ei[] __counted_by(nlines);
>  };
>
>  #ifdef CONFIG_DEBUG_FS
> --
> 2.34.1
>
>
