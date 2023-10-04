Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 080F67B9803
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Oct 2023 00:34:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233545AbjJDWeb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Oct 2023 18:34:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229916AbjJDWe3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Oct 2023 18:34:29 -0400
Received: from mail-yb1-xb30.google.com (mail-yb1-xb30.google.com [IPv6:2607:f8b0:4864:20::b30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC6F6BD
        for <linux-kernel@vger.kernel.org>; Wed,  4 Oct 2023 15:34:26 -0700 (PDT)
Received: by mail-yb1-xb30.google.com with SMTP id 3f1490d57ef6-d862533ea85so452561276.0
        for <linux-kernel@vger.kernel.org>; Wed, 04 Oct 2023 15:34:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1696458866; x=1697063666; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=IYj/Qo7KP0lBoxFj8EI61AxNI3abgNto7CZCna2bJrU=;
        b=AN0gAKZOHpZzcNpxJcjpKkjSis+Lgg0dCoegLNJOZC/at4qhX/NM3ZuJEB9lZvnasn
         H9sZvcLIeTAZIjbiUXmxDbWDlAPVd5ogUl3XRlX8Fz5olFb8HH5vzWAtO85tk6rxxRPZ
         ne3jTSC0fOvBNfIckxjlm72kljG4HY8fERsnSKxsT2b9tUGnx4VNPeOyLmxkn3uoHvG3
         U/3snEDoHT6ZY+NIU7WGe5Qp0rTZVkU5uiCufFv7X4hMdBI/Zag9f79oesYBIY+l+2xn
         6umQprh/gqMgGggu3b4LYwQ+oBgKYceC27PWi3gwrI9eO8sJr/Jkh774l+pN88I6szlR
         3cwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696458866; x=1697063666;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IYj/Qo7KP0lBoxFj8EI61AxNI3abgNto7CZCna2bJrU=;
        b=AduxF5QR/m5UVslQl7fZHRQOKeNFJCtQSPGioXEBumfEFk10W6SmJIDvko1waRVqyd
         WrxER9ov1MAlT1hXgmddQEzLgV64qcBE72WMYuUJI0i3ofjPtd+zjNFFz3jEdwUAOzCc
         BlnHEoWMxmo1iTHBWvr57H2agnxq6i5LI399pbpr1HimPLt7P5be4r89gkk42EQdTEu4
         nRR0aJihfM+F8K/eljgCFWjegyqtdPJby0c/MuwBnqhIBeZLRYsVnwyi3ENHgoJz8JUH
         shTCvSGKGERxN03r71u0yZHNztMZ0uidMHhPLE5qyoz6GVVVQds8i/80SgDiRcH2LGuc
         t2bg==
X-Gm-Message-State: AOJu0YyPr4SmbaG/Sb+cauCmOtd8APO25S4Ycp/8e4y/X4Jyk7UdIf8a
        YiV91NGC2yC1G5tLaIhVuFomAeAVUF0L9Y6WqXntUg==
X-Google-Smtp-Source: AGHT+IEBtL4DgfKDVI9LLPdP4pkVuwKyH9RArByw6pYAf0zeHploJdyd7Ie/uvzJ+S+VpA13WYvP3Wc2x7bJ5J6iTw8=
X-Received: by 2002:a25:7714:0:b0:d89:478a:fe9c with SMTP id
 s20-20020a257714000000b00d89478afe9cmr3677775ybc.6.1696458865894; Wed, 04 Oct
 2023 15:34:25 -0700 (PDT)
MIME-Version: 1.0
References: <20231001123853.200773-1-peng.fan@oss.nxp.com>
In-Reply-To: <20231001123853.200773-1-peng.fan@oss.nxp.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Thu, 5 Oct 2023 00:33:49 +0200
Message-ID: <CAPDyKFpbq3aH6n5p5M1e9ye8DwDr-uZqdLYbCND1N5gVL-0tXA@mail.gmail.com>
Subject: Re: [PATCH] pmdomain: imx: scu-pd: correct DMA2 channel
To:     "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Cc:     shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, linux-imx@nxp.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, Peng Fan <peng.fan@nxp.com>,
        Dong Aisheng <Aisheng.dong@nxp.com>
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

On Sun, 1 Oct 2023 at 14:34, Peng Fan (OSS) <peng.fan@oss.nxp.com> wrote:
>
> From: Peng Fan <peng.fan@nxp.com>
>
> Per "dt-bindings/firmware/imx/rsrc.h", `IMX_SC_R_DMA_2_CH0 + 5` not
> equals to IMX_SC_R_DMA_2_CH5, so there should be two entries in
> imx8qxp_scu_pd_ranges, otherwise the imx_scu_add_pm_domain may filter
> out wrong power domains.
>
> Fixes: 927b7d15dcf2 ("genpd: imx: scu-pd: enlarge PD range")
> Reported-by: Dong Aisheng <Aisheng.dong@nxp.com>
> Signed-off-by: Peng Fan <peng.fan@nxp.com>

Applied for fixes, thanks!

Kind regards
Uffe

> ---
>  drivers/pmdomain/imx/scu-pd.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/pmdomain/imx/scu-pd.c b/drivers/pmdomain/imx/scu-pd.c
> index 2f693b67ddb4..891c1d925a9d 100644
> --- a/drivers/pmdomain/imx/scu-pd.c
> +++ b/drivers/pmdomain/imx/scu-pd.c
> @@ -150,7 +150,8 @@ static const struct imx_sc_pd_range imx8qxp_scu_pd_ranges[] = {
>         { "mclk-out-1", IMX_SC_R_MCLK_OUT_1, 1, false, 0 },
>         { "dma0-ch", IMX_SC_R_DMA_0_CH0, 32, true, 0 },
>         { "dma1-ch", IMX_SC_R_DMA_1_CH0, 16, true, 0 },
> -       { "dma2-ch", IMX_SC_R_DMA_2_CH0, 32, true, 0 },
> +       { "dma2-ch-0", IMX_SC_R_DMA_2_CH0, 5, true, 0 },
> +       { "dma2-ch-1", IMX_SC_R_DMA_2_CH5, 27, true, 0 },
>         { "dma3-ch", IMX_SC_R_DMA_3_CH0, 32, true, 0 },
>         { "asrc0", IMX_SC_R_ASRC_0, 1, false, 0 },
>         { "asrc1", IMX_SC_R_ASRC_1, 1, false, 0 },
> --
> 2.37.1
>
