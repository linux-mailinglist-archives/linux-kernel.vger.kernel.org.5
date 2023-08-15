Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0F3377CBCC
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Aug 2023 13:33:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236694AbjHOLdT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Aug 2023 07:33:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236696AbjHOLcs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Aug 2023 07:32:48 -0400
Received: from mail-yw1-x1136.google.com (mail-yw1-x1136.google.com [IPv6:2607:f8b0:4864:20::1136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D58D310E5
        for <linux-kernel@vger.kernel.org>; Tue, 15 Aug 2023 04:32:46 -0700 (PDT)
Received: by mail-yw1-x1136.google.com with SMTP id 00721157ae682-584034c706dso58496837b3.1
        for <linux-kernel@vger.kernel.org>; Tue, 15 Aug 2023 04:32:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1692099166; x=1692703966;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=z0cIlhyjWne1murlHvTIDv20f0nQNybjsStT8wYuMbs=;
        b=KK53EMS9OFUuzcG6+Y9jWCR9UJjdavAseGfBF7l9MTIsU0CtgHyY74O5WDPu6uDVyd
         /3flAUEvsDmfBZsCIl2KD+tOhCuWVLJcp49luN1tyrfPd5hIl/6wvaakgcp+ZRrGC5oj
         4udoYkc3clEbtXpW6s91SWOotVQp3z6ezoxk3TV+KW4Eo3Ywr120hGvcr3tj2jaXdhQP
         h31YzroHZBT0mdj6/Jz/iKwk5HJZG9V6upvk2q35ZtJ8qERLLc6YfHi3AdqnR+lVzoY9
         18t3sNb8m/T2TZ7szDAE8qKJYEezJqwKNdtW4HF3Ogx3QBol2PHlLSAh4gqsZJ3E356o
         CsZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692099166; x=1692703966;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=z0cIlhyjWne1murlHvTIDv20f0nQNybjsStT8wYuMbs=;
        b=BqLUyyGI2qiDb+vDSSaRI2FNvyWnV3RnfHA7SBwFexO4WQ3g/JxKZCwkkeWDQDLmWh
         hISzxagcc9jXquXA0g+/1/fYrCOPcsvwzlXtdg/oEmTQrQ/Jb3Y/5VOgOii05Ca0pEgF
         wGfR6zheJREttWGxEof63n3XOGWeBWgsTg2ZKUTuYCqJwTSG344Tk/ILaZTmx4OoisEf
         r4HLKdabDF21b39jDVIWLpnV3suGriGtdoXnPC2o3TNe2JyDAbvIFZQnNgLH1CDen7Mn
         AzV8ZfiXGUeqj2a/j6I3bOPtnD63fb+wGIRZ98WN4GmGPESAjkvKsZPazkoqpqiy+/c2
         Ok2Q==
X-Gm-Message-State: AOJu0YxSwcACEe7TV1UoYPFVncJta+D0YFPHX8zyEfaTzjb2UJAZkZPw
        UJTXF0woaPeJSqexm8xhrTbv3VaQX46e5QbsI5ghm0/k+/tS2NqN
X-Google-Smtp-Source: AGHT+IF+Uq4L1vZ2KYOj/7hnmB0axq1IhUvwed2+zIGTzDRSd6D0RQexOAD/BAlRCgknTqGst3bcTKnrGouhUHLTuVM=
X-Received: by 2002:a25:209:0:b0:d4b:4a1f:6e13 with SMTP id
 9-20020a250209000000b00d4b4a1f6e13mr12714722ybc.33.1692099165951; Tue, 15 Aug
 2023 04:32:45 -0700 (PDT)
MIME-Version: 1.0
References: <20230727070051.17778-1-frank.li@vivo.com> <20230727070051.17778-62-frank.li@vivo.com>
 <90febfa5-b520-05f5-53ca-af0e1f3fc7c4@intel.com> <643e844b-2640-e2c8-d8a7-1cd91d453ccc@intel.com>
In-Reply-To: <643e844b-2640-e2c8-d8a7-1cd91d453ccc@intel.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 15 Aug 2023 13:32:09 +0200
Message-ID: <CAPDyKFpjPhgrn8E7WEmJeLeUVSb2es9bZRBV6WDVvMk6UR+QUA@mail.gmail.com>
Subject: Re: [PATCH v3 62/62] mmc: f-sdh30: fix order of function calls in sdhci_f_sdh30_remove
To:     Adrian Hunter <adrian.hunter@intel.com>,
        Yangtao Li <frank.li@vivo.com>
Cc:     Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
        =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 3 Aug 2023 at 07:46, Adrian Hunter <adrian.hunter@intel.com> wrote:
>
> On 27/07/23 16:55, Adrian Hunter wrote:
> > On 27/07/23 10:00, Yangtao Li wrote:
> >> The order of function calls in sdhci_f_sdh30_remove is wrong,
> >> let's call sdhci_pltfm_unregister first.
> >>
> >> Cc: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>
> >> Fixes: 5def5c1c15bf ("mmc: sdhci-f-sdh30: Replace with sdhci_pltfm")
> >> Signed-off-by: Yangtao Li <frank.li@vivo.com>
> >> ---
> >>  drivers/mmc/host/sdhci_f_sdh30.c | 4 ++--
> >>  1 file changed, 2 insertions(+), 2 deletions(-)
> >>
> >> diff --git a/drivers/mmc/host/sdhci_f_sdh30.c b/drivers/mmc/host/sdhci=
_f_sdh30.c
> >> index 840084ee72e6..964fa18a61a4 100644
> >> --- a/drivers/mmc/host/sdhci_f_sdh30.c
> >> +++ b/drivers/mmc/host/sdhci_f_sdh30.c
> >> @@ -211,11 +211,11 @@ static void sdhci_f_sdh30_remove(struct platform=
_device *pdev)
> >>      struct sdhci_host *host =3D platform_get_drvdata(pdev);
> >>      struct f_sdhost_priv *priv =3D sdhci_f_sdhost_priv(host);
> >>
> >> +    sdhci_pltfm_unregister(pdev);
> >
> > That also frees priv
> >
> >> +
> >>      reset_control_assert(priv->rst);
> >>      clk_disable_unprepare(priv->clk);
> >>      clk_disable_unprepare(priv->clk_iface);
> >> -
> >> -    sdhci_pltfm_unregister(pdev);
> >>  }
> >>
> >>  #ifdef CONFIG_OF
> >
>
> So it needs to end up looking something like below, right?
>
> diff --git a/drivers/mmc/host/sdhci_f_sdh30.c b/drivers/mmc/host/sdhci_f_=
sdh30.c
> index 840084ee72e6..47ae853f51aa 100644
> --- a/drivers/mmc/host/sdhci_f_sdh30.c
> +++ b/drivers/mmc/host/sdhci_f_sdh30.c
> @@ -210,12 +210,15 @@ static void sdhci_f_sdh30_remove(struct platform_de=
vice *pdev)
>  {
>         struct sdhci_host *host =3D platform_get_drvdata(pdev);
>         struct f_sdhost_priv *priv =3D sdhci_f_sdhost_priv(host);
> -
> -       reset_control_assert(priv->rst);
> -       clk_disable_unprepare(priv->clk);
> -       clk_disable_unprepare(priv->clk_iface);
> +       struct clk *clk_iface =3D priv->clk_iface;
> +       struct reset_control *rst =3D priv->rst;
> +       struct clk *clk =3D priv->clk;
>
>         sdhci_pltfm_unregister(pdev);
> +
> +       reset_control_assert(rst);
> +       clk_disable_unprepare(clk);
> +       clk_disable_unprepare(clk_iface);
>  }

I have amended the patch according to the above. Added Adrian's ack,
rebased it on top of the fixes branch, added a stable tag and applied
it for fixes.

Thanks to both of you!

Kind regards
Uffe
