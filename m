Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A32777DDEE
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Aug 2023 11:54:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243642AbjHPJxh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Aug 2023 05:53:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243618AbjHPJxE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Aug 2023 05:53:04 -0400
Received: from mail-yw1-x112e.google.com (mail-yw1-x112e.google.com [IPv6:2607:f8b0:4864:20::112e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 343D92D5A
        for <linux-kernel@vger.kernel.org>; Wed, 16 Aug 2023 02:52:47 -0700 (PDT)
Received: by mail-yw1-x112e.google.com with SMTP id 00721157ae682-58c68c79befso8925697b3.3
        for <linux-kernel@vger.kernel.org>; Wed, 16 Aug 2023 02:52:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1692179566; x=1692784366;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=/5so/M+AhEEk4mX4pqGb1Pa0ON/8pUQD4BvXmodkCBo=;
        b=XXivQr6n3Q1n02LmLFKvNhwy2ZFWWELsv6C48KCsw5fEHWPfYbexf3ffuIMEiinrek
         Y/X4tSzo9RTA+oD8AqmTQOgsypEgRI1IACIl6th69I5MJnHnpAM6DJzjnF0Vig6V1aXF
         nimlSnBQhrbLHZ2s9/9qQ+2wRcLW3iV6LeAAslAB2Vc7ZsHptr65tDb80MtKJEO+fhEx
         gmg5PQSqhuOoGgiKl3qCz6PKhZdX7xOEDfa2ZXLqY1AHRLRId8sQV3wxRBiLjFaqpwWS
         ydo7f/yZ0IdSZQaupZFLJMlf5LsvhRp4oFEi2n5u8qeurZCj9ighow94U2DidWpU4CAJ
         imVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692179566; x=1692784366;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/5so/M+AhEEk4mX4pqGb1Pa0ON/8pUQD4BvXmodkCBo=;
        b=hYzP6YZreEwJ99wjuwBIsVBONbugthWWyoOIZv/6Yly0J9Y6NneLawB4o9U0ju8cfp
         KjOnuZ6tEedid3iNw5M2UMLa2ZHvlg8pOcFpb/55nAJB4QKllp6vlOrS9+H3BYdzi1x7
         VR4eKBI95+Y9FK2pEMzGnQnD2HFRXKOq4kfKgAH0cFpUL3U7Ypd4ejIygHQ23Nl1HHSq
         JJ9fNgI8cgKWwrMUa1PJkGJy/z8kvkxlgCvedjs8+IunyEYs+UWSW7B/y2m9Y9WQG+aM
         DiBAy0gI805XGE1bQ6pEUF8+Z1zNEK5Gm27Y9Fi10/OVe9Uqdl6QMCfYhuONKejgU6va
         VMTw==
X-Gm-Message-State: AOJu0YxiHXKFn+tb5Fkhnba204ffL0VOPFq8L7lLSao4gOJa/wPscR4u
        qzBh9fKDJYwZgQzAyF9lQDBGwwgBj25svBAdgrBHvA==
X-Google-Smtp-Source: AGHT+IHA9n2w/op4DAH5GzrBpdtTvK2/1xJVANiOu/xelGO0k7TIr+ajFJb7Jsxolv8ybqVetV/we8lj15rls0+GD54=
X-Received: by 2002:a81:6057:0:b0:583:d1fa:1fc4 with SMTP id
 u84-20020a816057000000b00583d1fa1fc4mr1108904ywb.26.1692179566441; Wed, 16
 Aug 2023 02:52:46 -0700 (PDT)
MIME-Version: 1.0
References: <20230811214853.8623-1-giulio.benetti@benettiengineering.com>
In-Reply-To: <20230811214853.8623-1-giulio.benetti@benettiengineering.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Wed, 16 Aug 2023 11:52:10 +0200
Message-ID: <CAPDyKForXMxANUrvOUfEtiRsXYPJ8MbfPBdJB6zu49QfeJfS8A@mail.gmail.com>
Subject: Re: [PATCH] mmc: sdhci-esdhc-imx: improve ESDHC_FLAG_ERR010450
To:     Giulio Benetti <giulio.benetti@benettiengineering.com>
Cc:     Haibo Chen <haibo.chen@nxp.com>, Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Jim Reinhart <jimr@tekvox.com>,
        James Autry <jautry@tekvox.com>,
        Matthew Maron <matthewm@tekvox.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 11 Aug 2023 at 23:49, Giulio Benetti
<giulio.benetti@benettiengineering.com> wrote:
>
> Errata ERR010450 only shows up if voltage is 1.8V, but if the device is
> supplied by 3v3 the errata can be ignored. So let's check for if quirk
> SDHCI_QUIRK2_NO_1_8_V is defined or not before limiting the frequency.
>
> Sponsored by: Tekvox Inc.

Didn't know we have this kind of tag. Can you point me to the
documentation of it?

> Cc: Jim Reinhart <jimr@tekvox.com>
> Cc: James Autry <jautry@tekvox.com>
> Cc: Matthew Maron <matthewm@tekvox.com>
> Signed-off-by: Giulio Benetti <giulio.benetti@benettiengineering.com>

Kind regards
Uffe

> ---
>  drivers/mmc/host/sdhci-esdhc-imx.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/mmc/host/sdhci-esdhc-imx.c b/drivers/mmc/host/sdhci-esdhc-imx.c
> index eebf94604a7f..cddecc1e1ac2 100644
> --- a/drivers/mmc/host/sdhci-esdhc-imx.c
> +++ b/drivers/mmc/host/sdhci-esdhc-imx.c
> @@ -171,8 +171,8 @@
>  #define ESDHC_FLAG_HS400               BIT(9)
>  /*
>   * The IP has errata ERR010450
> - * uSDHC: Due to the I/O timing limit, for SDR mode, SD card clock can't
> - * exceed 150MHz, for DDR mode, SD card clock can't exceed 45MHz.
> + * uSDHC: At 1.8V due to the I/O timing limit, for SDR mode, SD card
> + * clock can't exceed 150MHz, for DDR mode, SD card clock can't exceed 45MHz.
>   */
>  #define ESDHC_FLAG_ERR010450           BIT(10)
>  /* The IP supports HS400ES mode */
> @@ -961,7 +961,8 @@ static inline void esdhc_pltfm_set_clock(struct sdhci_host *host,
>                 | ESDHC_CLOCK_MASK);
>         sdhci_writel(host, temp, ESDHC_SYSTEM_CONTROL);
>
> -       if (imx_data->socdata->flags & ESDHC_FLAG_ERR010450) {
> +       if ((imx_data->socdata->flags & ESDHC_FLAG_ERR010450) &&
> +           (!(host->quirks2 & SDHCI_QUIRK2_NO_1_8_V))) {
>                 unsigned int max_clock;
>
>                 max_clock = imx_data->is_ddr ? 45000000 : 150000000;
> --
> 2.34.1
>
