Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0CB27F6532
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Nov 2023 18:19:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345611AbjKWRT1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Nov 2023 12:19:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230094AbjKWRTN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Nov 2023 12:19:13 -0500
Received: from mail-yw1-x1134.google.com (mail-yw1-x1134.google.com [IPv6:2607:f8b0:4864:20::1134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6C72D53
        for <linux-kernel@vger.kernel.org>; Thu, 23 Nov 2023 09:19:17 -0800 (PST)
Received: by mail-yw1-x1134.google.com with SMTP id 00721157ae682-5cc636d8a21so9534237b3.2
        for <linux-kernel@vger.kernel.org>; Thu, 23 Nov 2023 09:19:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1700759957; x=1701364757; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ZWk/RgHbKOlFY39aGIpjm5vZs/TIaAEJUzezOamB9tA=;
        b=lgPEgfotXMvzK8cXSTLkl0svVRTVi/N2fmGN8N79B3nF4j50ZyNhAAxX2ryP9x/MtQ
         v6gn9RCMR+hbA++nj3XzDwaVj7vI9qLrT+Qq/4JimW4u09V6+sDF0qVsk59LB7P/3emP
         9e5yR1WePuJLUiqVD0fqMbE4oMpsA8W88XxvdsrS2cMelUZT0IvEY+ayajr7AlS6j4SB
         +TZRUSOfO0xPAvxdK+vdDWUTtJN0D0yYZOnAuypa1bqPvXzzitD1A/2yvO/sR+WcGf8Q
         LGh2CX5/7MBomZOvWVx3LQHnH3DVLVuTymicPoCTPhm5f8+PzRNILyWSW6H+TXNdmVs+
         k1QQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700759957; x=1701364757;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZWk/RgHbKOlFY39aGIpjm5vZs/TIaAEJUzezOamB9tA=;
        b=TfP3sklf4OfMeVqt6FjYVuB5r4nyIor3nV/TP7ori3sNPIEQ42ESA6Alsu+bl39f3K
         WpN/pDmtmWtH6ruhvMVFUZfjvrRbT1kVUwUTl6IXreAruP8k6itnkxkUr18/6KC4hGm6
         fNBACb3eBUCbCHv6MjG56Li5qzfrAyG2E+cR55kGKUR018KkIlTH1sAjOIJ8WdzvAzPu
         G+tGeA3JOD4HqP7FvZKUmiQ4YNKfbPKZettBjSLL2KNIPJsiG4GSkfxuADsk8+xLw/wO
         sXAREqASVYgQaf1mSWV0+NJpbzhaa17I2wuTlCZzIg6iEHeZFyxz4kSwuHfEm6dDMrj1
         g3XQ==
X-Gm-Message-State: AOJu0YwC148eWADRc9rrTYtp6lBtI5lfzp0ORMGC0hYDjrTjO3Ju2iLf
        B9XvTHK9IhDdfd8lnpfjHeuzghCzUYtXHb9GReA11A==
X-Google-Smtp-Source: AGHT+IFwyFMR/NrdcChscDcLqQ70TVmEfxpocrRkYan5zonKuyVIeZHKpaW0fvUM00WVfJdfUBy1f7OPfUyE579mt2A=
X-Received: by 2002:a0d:f986:0:b0:5c5:d898:e476 with SMTP id
 j128-20020a0df986000000b005c5d898e476mr17348ywf.33.1700759956922; Thu, 23 Nov
 2023 09:19:16 -0800 (PST)
MIME-Version: 1.0
References: <20231122060215.2074799-1-vigneshr@ti.com>
In-Reply-To: <20231122060215.2074799-1-vigneshr@ti.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Thu, 23 Nov 2023 18:18:41 +0100
Message-ID: <CAPDyKFrsXSwyU-VsPEt1tYCPWk99XaNZ7kJGGWPEDEYBWaPktg@mail.gmail.com>
Subject: Re: [PATCH v2] mmc: sdhci_am654: Drop lookup for deprecated ti,otap-del-sel
To:     Vignesh Raghavendra <vigneshr@ti.com>
Cc:     Adrian Hunter <adrian.hunter@intel.com>, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 22 Nov 2023 at 07:05, Vignesh Raghavendra <vigneshr@ti.com> wrote:
>
> ti,otap-del-sel has been deprecated since v5.7 and there are no users of
> this property and no documentation in the DT bindings either.
> Drop the fallback code looking for this property, this makes
> sdhci_am654_get_otap_delay() much easier to read as all the TAP values
> can be handled via a single iterator loop.
>
> Signed-off-by: Vignesh Raghavendra <vigneshr@ti.com>
> Acked-by: Adrian Hunter <adrian.hunter@intel.com>

Applied for next, thanks!

Kind regards
Uffe


> ---
>
> v2:
> * Drop legacy_otapdly as pointed out by Adrian
>
> v1: https://lore.kernel.org/r/20231110072535.2695134-1-vigneshr@ti.com
>
>  drivers/mmc/host/sdhci_am654.c | 37 ++++++----------------------------
>  1 file changed, 6 insertions(+), 31 deletions(-)
>
> diff --git a/drivers/mmc/host/sdhci_am654.c b/drivers/mmc/host/sdhci_am654.c
> index 967bd2dfcda1..d659c59422e1 100644
> --- a/drivers/mmc/host/sdhci_am654.c
> +++ b/drivers/mmc/host/sdhci_am654.c
> @@ -141,7 +141,6 @@ static const struct timing_data td[] = {
>
>  struct sdhci_am654_data {
>         struct regmap *base;
> -       bool legacy_otapdly;
>         int otap_del_sel[ARRAY_SIZE(td)];
>         int itap_del_sel[ARRAY_SIZE(td)];
>         int clkbuf_sel;
> @@ -272,11 +271,7 @@ static void sdhci_am654_set_clock(struct sdhci_host *host, unsigned int clock)
>         sdhci_set_clock(host, clock);
>
>         /* Setup DLL Output TAP delay */
> -       if (sdhci_am654->legacy_otapdly)
> -               otap_del_sel = sdhci_am654->otap_del_sel[0];
> -       else
> -               otap_del_sel = sdhci_am654->otap_del_sel[timing];
> -
> +       otap_del_sel = sdhci_am654->otap_del_sel[timing];
>         otap_del_ena = (timing > MMC_TIMING_UHS_SDR25) ? 1 : 0;
>
>         mask = OTAPDLYENA_MASK | OTAPDLYSEL_MASK;
> @@ -314,10 +309,7 @@ static void sdhci_j721e_4bit_set_clock(struct sdhci_host *host,
>         u32 mask, val;
>
>         /* Setup DLL Output TAP delay */
> -       if (sdhci_am654->legacy_otapdly)
> -               otap_del_sel = sdhci_am654->otap_del_sel[0];
> -       else
> -               otap_del_sel = sdhci_am654->otap_del_sel[timing];
> +       otap_del_sel = sdhci_am654->otap_del_sel[timing];
>
>         mask = OTAPDLYENA_MASK | OTAPDLYSEL_MASK;
>         val = (0x1 << OTAPDLYENA_SHIFT) |
> @@ -577,32 +569,15 @@ static int sdhci_am654_get_otap_delay(struct sdhci_host *host,
>         int i;
>         int ret;
>
> -       ret = device_property_read_u32(dev, td[MMC_TIMING_LEGACY].otap_binding,
> -                                &sdhci_am654->otap_del_sel[MMC_TIMING_LEGACY]);
> -       if (ret) {
> -               /*
> -                * ti,otap-del-sel-legacy is mandatory, look for old binding
> -                * if not found.
> -                */
> -               ret = device_property_read_u32(dev, "ti,otap-del-sel",
> -                                              &sdhci_am654->otap_del_sel[0]);
> -               if (ret) {
> -                       dev_err(dev, "Couldn't find otap-del-sel\n");
> -
> -                       return ret;
> -               }
> -
> -               dev_info(dev, "Using legacy binding ti,otap-del-sel\n");
> -               sdhci_am654->legacy_otapdly = true;
> -
> -               return 0;
> -       }
> -
>         for (i = MMC_TIMING_LEGACY; i <= MMC_TIMING_MMC_HS400; i++) {
>
>                 ret = device_property_read_u32(dev, td[i].otap_binding,
>                                                &sdhci_am654->otap_del_sel[i]);
>                 if (ret) {
> +                       if (i == MMC_TIMING_LEGACY) {
> +                               dev_err(dev, "Couldn't find mandatory ti,otap-del-sel-legacy\n");
> +                               return ret;
> +                       }
>                         dev_dbg(dev, "Couldn't find %s\n",
>                                 td[i].otap_binding);
>                         /*
> --
> 2.42.0
>
