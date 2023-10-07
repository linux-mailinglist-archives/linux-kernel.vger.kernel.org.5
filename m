Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10A497BC57D
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Oct 2023 09:20:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343647AbjJGHU1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 Oct 2023 03:20:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343598AbjJGHUZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Oct 2023 03:20:25 -0400
Received: from mail-oi1-x22f.google.com (mail-oi1-x22f.google.com [IPv6:2607:f8b0:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67B77B9;
        Sat,  7 Oct 2023 00:20:24 -0700 (PDT)
Received: by mail-oi1-x22f.google.com with SMTP id 5614622812f47-3add37de892so1746586b6e.1;
        Sat, 07 Oct 2023 00:20:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696663223; x=1697268023; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JTMEgmUVwRtC/bCkmB63qXdkMIkbV9hSkw6kgjZCn9M=;
        b=mvRhN7j1HQSonAKRaJRR5kRDWfhpmacxwLmTt3mMXQcWl/3WmGTwvEtscplJo9qLyK
         SHbs8sfqB4SI3UsSgszUiyMzzm8TwaBQr0NMCfX8pJRBrEivgzdggsJMsQ+1Zqlqtc/x
         6KNDCz76YD5Ps327aoDngiD/AjyKjxZbjeRGfOsbRxk5I3JWNMat+Z2GJGuKdNlgtJKl
         TDNsrqYhGd2WTWgneyDjRQVMpbD3nWMvAKyBjAsuVNQLlWYkLxnvcM8i2PTqv2H1S2RF
         BCwNf59qarINpkkOIj/NHSRuccSGXlyeQEc/6uZbgaa8PFZ0ygx2N4fBuDoYWq8oAuuF
         fq3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696663223; x=1697268023;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JTMEgmUVwRtC/bCkmB63qXdkMIkbV9hSkw6kgjZCn9M=;
        b=oRPYRVvfBb2t78me8BCeTz/cBl9WQC4MKZZSNxwz54be7Pbc3dnA8Piu8LMx8NkpXV
         7v5rgTIgWLHpnLiFvLq+7FTMYdXYr7OqNGuByPhlHw03NkmIJedI600xuDVe6WweSUy9
         v2NUaOukMLks9eifeMMBDMXjDkoeASmiDhROw8Y6PHfhYyDjSa/sRgNoBHAc5FaFZRpy
         yxr0hDxzZ3HeFLsFgHn0uVVqz32VqzypeQpxsbhOXmm3L+wR1bxKyBvbc7wls7KoZXHn
         w8roOcDZndtBCpiUm38LjgTZRZymXVyOEkjPDQR5EhkaEnRN40P3W1q11XI0GlXL0pmE
         85Fg==
X-Gm-Message-State: AOJu0YyVSwwqEpscE5SzUbKmG6LRmHqa9FMKa+QbW98N73Nt3C4x+K70
        tPSnueQs3Ax3thBnhty7JT6V0TNqPvwj/cyNm6E7xsir
X-Google-Smtp-Source: AGHT+IEHAo+BA2fkEh+FGHGuBSi8fEqFOeU8PRgToOCHUWvnBGdJJUtfYUxnaswaxzHWXKvQKpt7uFQ/Ra/a8UM1orI=
X-Received: by 2002:a05:6870:b292:b0:1bf:54b9:800 with SMTP id
 c18-20020a056870b29200b001bf54b90800mr10684378oao.59.1696663223259; Sat, 07
 Oct 2023 00:20:23 -0700 (PDT)
MIME-Version: 1.0
References: <20230827023932.501102-1-sergio.paracuellos@gmail.com>
In-Reply-To: <20230827023932.501102-1-sergio.paracuellos@gmail.com>
From:   Sergio Paracuellos <sergio.paracuellos@gmail.com>
Date:   Sat, 7 Oct 2023 09:20:12 +0200
Message-ID: <CAMhs-H87Fze_7eN-odMFFSquT=aQeJjrYVsUM68_eAnzePo9gw@mail.gmail.com>
Subject: Re: [PATCH v2] clk: ralink: mtmips: quiet unused variable warning
To:     linux-clk@vger.kernel.org
Cc:     tsbogend@alpha.franken.de, sboyd@kernel.org,
        mturquette@baylibre.com, linux-kernel@vger.kernel.org,
        ndesaulniers@google.com, arnd@kernel.org, yangshiji66@outlook.com,
        kernel test robot <lkp@intel.com>
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

On Sun, Aug 27, 2023 at 4:39=E2=80=AFAM Sergio Paracuellos
<sergio.paracuellos@gmail.com> wrote:
>
> When CONFIG_OF is disabled then the matching table is not referenced and
> the following warning appears:
>
> drivers/clk/ralink/clk-mtmips.c:821:34: warning: unused variable 'mtmips_=
of_match' [-Wunused-const-variable]
> 821 |   static const struct of_device_id mtmips_of_match[] =3D {
>     |                          ^
>
> There are two match tables in the driver: one for the clock driver and th=
e
> other for the reset driver. The only difference between them is that the
> clock driver uses 'data' and does not have 'ralink,rt2880-reset' compatib=
le.
> Both just can be merged into a single one just by adding the compatible
> 'ralink,rt2880-reset' entry to 'mtmips_of_match[]', which will allow it t=
o
> be used for 'mtmips_clk_driver' (which doesn't use the data) as well as f=
or
> 'mtmips_clk_init()' (which doesn't need get called for 'ralink,rt2880-res=
et').
>
> Doing in this way ensures that 'CONFIG_OF' is not disabled anymore so the
> above warning disapears.
>
> Fixes: 6f3b15586eef ("clk: ralink: add clock and reset driver for MTMIPS =
SoCs")
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202307242310.CdOnd2py-lkp@i=
ntel.com/
> Suggested-by: Arnd Bergmann <arnd@kernel.org>
> Signed-off-by: Sergio Paracuellos <sergio.paracuellos@gmail.com>
> ---
> Changes in v2:
> - Merge two match tables into one to properly avoid this warning.
>
> PATCH in v1: https://lore.kernel.org/lkml/20230802092647.3000666-1-sergio=
.paracuellos@gmail.com/T/
>
>  drivers/clk/ralink/clk-mtmips.c | 20 +++++---------------
>  1 file changed, 5 insertions(+), 15 deletions(-)
>
> diff --git a/drivers/clk/ralink/clk-mtmips.c b/drivers/clk/ralink/clk-mtm=
ips.c
> index 1e7991439527..50a443bf79ec 100644
> --- a/drivers/clk/ralink/clk-mtmips.c
> +++ b/drivers/clk/ralink/clk-mtmips.c
> @@ -821,6 +821,10 @@ static const struct mtmips_clk_data mt76x8_clk_data =
=3D {
>  };
>
>  static const struct of_device_id mtmips_of_match[] =3D {
> +       {
> +               .compatible =3D "ralink,rt2880-reset",
> +               .data =3D NULL,
> +       },
>         {
>                 .compatible =3D "ralink,rt2880-sysc",
>                 .data =3D &rt2880_clk_data,
> @@ -1088,25 +1092,11 @@ static int mtmips_clk_probe(struct platform_devic=
e *pdev)
>         return 0;
>  }
>
> -static const struct of_device_id mtmips_clk_of_match[] =3D {
> -       { .compatible =3D "ralink,rt2880-reset" },
> -       { .compatible =3D "ralink,rt2880-sysc" },
> -       { .compatible =3D "ralink,rt3050-sysc" },
> -       { .compatible =3D "ralink,rt3052-sysc" },
> -       { .compatible =3D "ralink,rt3352-sysc" },
> -       { .compatible =3D "ralink,rt3883-sysc" },
> -       { .compatible =3D "ralink,rt5350-sysc" },
> -       { .compatible =3D "ralink,mt7620-sysc" },
> -       { .compatible =3D "ralink,mt7628-sysc" },
> -       { .compatible =3D "ralink,mt7688-sysc" },
> -       {}
> -};
> -
>  static struct platform_driver mtmips_clk_driver =3D {
>         .probe =3D mtmips_clk_probe,
>         .driver =3D {
>                 .name =3D "mtmips-clk",
> -               .of_match_table =3D mtmips_clk_of_match,
> +               .of_match_table =3D mtmips_of_match,
>         },
>  };
>
> --
> 2.25.1
>

Gentle ping for this patch.

Thanks,
    Sergio Paracuellos
