Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7BCC6762B0D
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jul 2023 08:01:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231691AbjGZGBW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jul 2023 02:01:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231363AbjGZGBT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jul 2023 02:01:19 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69B241995;
        Tue, 25 Jul 2023 23:01:16 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id 2adb3069b0e04-4fb7dc16ff0so9771443e87.2;
        Tue, 25 Jul 2023 23:01:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690351275; x=1690956075;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BB2KiD16F4B9f2EcUD7svg5Q/8nSF6hZT15LE5/I12M=;
        b=eP2MDhwj1xO9wnSUWZvFz4SSQ4sZj7qWu5e9dhwCA8wboeqkBTEcc5ROqo42Xf2bff
         jRhzG5xRaY80pDcDiITNZEC0rUbXBMeqUxZlnTcu8Xb3wmTGgzY4L+SVM3qAaBH4gMr6
         IjF8PF/W5W7Jg0Ey0IxJeIomAD8OIHunN9ARXlzcEhqRW5lVNJ5DvnFDOqCwbNCx46Yx
         cUzpuqImbrSbweajWYcXvjLeXwb/hqUv3DX+WCs5yRkrBijC6irTrBoPhBUiUpTVHU/t
         62tVO6ZZTfQcR3jOh5TIAuyD46eqKNGmnlQxpGDYcwsAODPTL5S1f9jGTk4yu1OXG5GF
         f7Nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690351275; x=1690956075;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BB2KiD16F4B9f2EcUD7svg5Q/8nSF6hZT15LE5/I12M=;
        b=CmRv6YDa2ydxSz6zqfqwsF7Og1xTCHhmL312cxy8ZRFHmGvMnr+FTzVxW5buP26yRX
         zzia+mWynHYF2+JTK6iRL2bEfRLR1HsLAPCjCnkzi15kTYtPvRDHvq8JooUnntF/Psr0
         0PjIf+E2X91cFgTAeOF3fqIMufQ7/uA0Kx4W2PVTMFN4CXk3lvmtSOQsb5OnusqAcogE
         bOO8HkIC/59qaTd6CZjSi0xZaBBHaJaTeudzO7AWt2aOmWufDg6hmpKXLG3mojJTtitd
         6U3g49LGcbTXiJ6biWZZ4whs2WxeqlfxbCNfp++ue98i9fzJ/k0w0kr2EPhznc5Yt6SH
         9rjg==
X-Gm-Message-State: ABy/qLZfGidCrFtn5FUVsfgSe4kc5Sy4rM4kNjzZaoqoI2Tz6OQjQDbo
        8eMqJUXMVG3Qk9oEzWc/O5xStrjeVVMz5pqP5BA=
X-Google-Smtp-Source: APBJJlFeaRr5a0PGXS9xda9uQsoRiE04z6h2okopysyqd43SdJRtTiGsMnKOuOWoSmsdm2qtQDsiGIgJYzBJjzyZ20I=
X-Received: by 2002:a05:6512:32aa:b0:4f9:5580:1894 with SMTP id
 q10-20020a05651232aa00b004f955801894mr622530lfe.15.1690351274403; Tue, 25 Jul
 2023 23:01:14 -0700 (PDT)
MIME-Version: 1.0
References: <20230726040041.26267-1-frank.li@vivo.com> <20230726040041.26267-36-frank.li@vivo.com>
In-Reply-To: <20230726040041.26267-36-frank.li@vivo.com>
From:   Chunyan Zhang <zhang.lyra@gmail.com>
Date:   Wed, 26 Jul 2023 14:00:37 +0800
Message-ID: <CAAfSe-tGktZs_yeprSw7o=Vi00sbjvwf1od2wEeX3-E0gog9_g@mail.gmail.com>
Subject: Re: [PATCH v2 36/61] mmc: sdhci-sprd: Convert to platform remove
 callback returning void
To:     Yangtao Li <frank.li@vivo.com>
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Orson Zhai <orsonzhai@gmail.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 26 Jul 2023 at 12:02, Yangtao Li <frank.li@vivo.com> wrote:
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

Acked-by: Chunyan Zhang <zhang.lyra@gmail.com>

Thanks,
Chunyan

> ---
>  drivers/mmc/host/sdhci-sprd.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/mmc/host/sdhci-sprd.c b/drivers/mmc/host/sdhci-sprd.=
c
> index 7f4ee2e12735..379cb3892757 100644
> --- a/drivers/mmc/host/sdhci-sprd.c
> +++ b/drivers/mmc/host/sdhci-sprd.c
> @@ -720,7 +720,7 @@ static int sdhci_sprd_probe(struct platform_device *p=
dev)
>         return ret;
>  }
>
> -static int sdhci_sprd_remove(struct platform_device *pdev)
> +static void sdhci_sprd_remove(struct platform_device *pdev)
>  {
>         struct sdhci_host *host =3D platform_get_drvdata(pdev);
>         struct sdhci_sprd_host *sprd_host =3D TO_SPRD_HOST(host);
> @@ -732,8 +732,6 @@ static int sdhci_sprd_remove(struct platform_device *=
pdev)
>         clk_disable_unprepare(sprd_host->clk_2x_enable);
>
>         sdhci_pltfm_free(pdev);
> -
> -       return 0;
>  }
>
>  static const struct of_device_id sdhci_sprd_of_match[] =3D {
> @@ -800,7 +798,7 @@ static const struct dev_pm_ops sdhci_sprd_pm_ops =3D =
{
>
>  static struct platform_driver sdhci_sprd_driver =3D {
>         .probe =3D sdhci_sprd_probe,
> -       .remove =3D sdhci_sprd_remove,
> +       .remove_new =3D sdhci_sprd_remove,
>         .driver =3D {
>                 .name =3D "sdhci_sprd_r11",
>                 .probe_type =3D PROBE_PREFER_ASYNCHRONOUS,
> --
> 2.39.0
>
