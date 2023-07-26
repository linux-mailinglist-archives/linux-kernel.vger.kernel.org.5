Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5268762B35
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jul 2023 08:15:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231324AbjGZGPZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jul 2023 02:15:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231815AbjGZGPL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jul 2023 02:15:11 -0400
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 499FA11A
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jul 2023 23:15:01 -0700 (PDT)
Received: by mail-lj1-x235.google.com with SMTP id 38308e7fff4ca-2b701e41cd3so92624981fa.3
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jul 2023 23:15:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=timesys-com.20221208.gappssmtp.com; s=20221208; t=1690352099; x=1690956899;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0A3+e5jMcK3kCR/jFtoYg9fS2BZt61xXvykipeK7BQ8=;
        b=sxyvSu3wcgyD7VnJco1Gq+4hYK876dooXo/sd2xojq/OZaRTST42OZQ4AqAN3Yo09M
         fbFjnYlXDetjGZo+vfaHHmQ+z+AYcrRfLjDnt/zz8wWKs3ho7+iMBxysF8tWzfn/7fn8
         ipwMH2UR0Oji1wHg4JwYTE+se+reU4vLodLR3pl2od8AZh1Hq6bDxXGs7PIswVbriTb8
         MGdiIVPxPxJr3dRw1ffRxyZ35dSgc666ItrlyP9fnpDiUYoKNysLwRUIalo3QxFeYzJD
         TYHk9zxNUvLDmy/spYlTKEvt4CRzNOq7A9k8+5oETnaQxGUS43RlzWbpirRFtqOnyfJk
         cygQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690352099; x=1690956899;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0A3+e5jMcK3kCR/jFtoYg9fS2BZt61xXvykipeK7BQ8=;
        b=EXo5ttRJ70pZHXPqHdlt0WBQrfChMZoH4liBnRNVEMn4Mtb48Z/WKkMyH/te2FPV4e
         ExteD7qXiRrtgQOM45DPpUCpM4rg3xJGGl5KOX+OjWEGDl/PaMxyBRaOu+5K559txUsO
         zrrPX3EUmTRbWsSmTWWo2taenNqjKINvkORWuMmKY3dd93pyRAMlwFR5dqSG15byR2NE
         2qZ0uhetuSZLm2BYTrHZRBKgvD75jZ5h11k9oviSW0oH+Pp6jMOsiFr7fW93fiwoUncg
         VJatWBJfWtLRBc0bwBB1QWfREnMLwuHurnNMY2kt/cncWV5oQzXf2Vi9ZoxSGAn5B291
         cvNg==
X-Gm-Message-State: ABy/qLZRcrTAvv7YUtJhksoqzS7nB2hdRCyjwNviZ76lOg8NSnVlp7X0
        4zG7Ga7HjNmYfSSiLD4zq/QkBeIor2JwZegLoItk1Q==
X-Google-Smtp-Source: APBJJlEr/81QkgSFo+LtWzNCoWPkjYol6bC6cBxul11M+kgHjYAMYvmZGJYDhQ6kkoVyXqjNN+mqemqUz20PtKTI8sU=
X-Received: by 2002:a2e:3c09:0:b0:2b6:e625:ba55 with SMTP id
 j9-20020a2e3c09000000b002b6e625ba55mr669897lja.41.1690352099417; Tue, 25 Jul
 2023 23:14:59 -0700 (PDT)
MIME-Version: 1.0
References: <20230726040041.26267-1-frank.li@vivo.com> <20230726040041.26267-49-frank.li@vivo.com>
In-Reply-To: <20230726040041.26267-49-frank.li@vivo.com>
From:   Angelo Dureghello <angelo.dureghello@timesys.com>
Date:   Wed, 26 Jul 2023 08:14:06 +0200
Message-ID: <CALJHbkDoBoqQ8BpJnqYhPyat=_A6gUHw6BZRnhT=sy4XSx265g@mail.gmail.com>
Subject: Re: [PATCH v2 49/61] mmc: sdhci-esdhc-mcf: Convert to platform remove
 callback returning void
To:     Yangtao Li <frank.li@vivo.com>
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Yangtao,

Acked-by: Angelo Dureghello <angelo.dureghello@timesys.com>


On Wed, Jul 26, 2023 at 6:02=E2=80=AFAM Yangtao Li <frank.li@vivo.com> wrot=
e:
>
> The .remove() callback for a platform driver returns an int which makes
> many driver authors wrongly assume it's possible to do error handling by
> returning an error code. However the value returned is (mostly) ignored
> and this typically results in resource leaks. To improve here there is a
> quest to make the remove callback return void. In the first step of this
> quest all drivers are converted to .remove_new() which already returns
> void.
>
> Trivially convert this driver from always returning zero in the remove
> callback to the void returning variant.
>
> Cc: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>
> Signed-off-by: Yangtao Li <frank.li@vivo.com>
> Acked-by: Angelo Dureghello <angelo.dureghello@timesys.com>
> ---
>  drivers/mmc/host/sdhci-esdhc-mcf.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/mmc/host/sdhci-esdhc-mcf.c b/drivers/mmc/host/sdhci-=
esdhc-mcf.c
> index 05926bf5ecf9..a07f8333cd6b 100644
> --- a/drivers/mmc/host/sdhci-esdhc-mcf.c
> +++ b/drivers/mmc/host/sdhci-esdhc-mcf.c
> @@ -489,7 +489,7 @@ static int sdhci_esdhc_mcf_probe(struct platform_devi=
ce *pdev)
>         return err;
>  }
>
> -static int sdhci_esdhc_mcf_remove(struct platform_device *pdev)
> +static void sdhci_esdhc_mcf_remove(struct platform_device *pdev)
>  {
>         struct sdhci_host *host =3D platform_get_drvdata(pdev);
>         struct sdhci_pltfm_host *pltfm_host =3D sdhci_priv(host);
> @@ -502,8 +502,6 @@ static int sdhci_esdhc_mcf_remove(struct platform_dev=
ice *pdev)
>         clk_disable_unprepare(mcf_data->clk_per);
>
>         sdhci_pltfm_free(pdev);
> -
> -       return 0;
>  }
>
>  static struct platform_driver sdhci_esdhc_mcf_driver =3D {
> @@ -512,7 +510,7 @@ static struct platform_driver sdhci_esdhc_mcf_driver =
=3D {
>                 .probe_type =3D PROBE_PREFER_ASYNCHRONOUS,
>         },
>         .probe =3D sdhci_esdhc_mcf_probe,
> -       .remove =3D sdhci_esdhc_mcf_remove,
> +       .remove_new =3D sdhci_esdhc_mcf_remove,
>  };
>
>  module_platform_driver(sdhci_esdhc_mcf_driver);
> --
> 2.39.0
>


--=20
Angelo Dureghello
Timesys
e. angelo.dureghello@timesys.com
