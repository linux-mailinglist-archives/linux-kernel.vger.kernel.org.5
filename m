Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 162E87FEDF1
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 12:31:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345392AbjK3Lbb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 06:31:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345297AbjK3LbC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 06:31:02 -0500
Received: from mail-yw1-x112d.google.com (mail-yw1-x112d.google.com [IPv6:2607:f8b0:4864:20::112d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3A3C10F5
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 03:31:07 -0800 (PST)
Received: by mail-yw1-x112d.google.com with SMTP id 00721157ae682-5cc3dd21b0cso8421997b3.3
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 03:31:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1701343867; x=1701948667; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ds7ABFYrMMycv745Smb8RwddOGN4IRIdlcfUsv1PeZg=;
        b=uJLEf+HZUTpkUYhyMEKBjM1Z8TCvMmvF+arIHSiMSEwCJArUOzcrABTy/0jSXaWi8d
         wrPmJNMyPSaRJ8QdpRNzXVtmP3j/l8HZdqIIJ6vA8T9h7A7d3Otv0eJ2xL2OLEJGvp5/
         nmwc14Ok0rHEMkSLsn5i77lB0oQ7BHuPnaAU3VQGZ+FDSlDH5UnvBjMzbexAJtKAIGh5
         hxodA9wIoWRYWF4VYNIQJ0SSh+OEg23wnxxEQaW8LqoeNWs7WqoEJHU3KbDsqBvys+6j
         j1J1JhzigWQoP2N5lDcGcc3i6ZPG2DLJ2FepuWIf86LgboovAX8QOX779spqesaqq2O4
         v2mQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701343867; x=1701948667;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ds7ABFYrMMycv745Smb8RwddOGN4IRIdlcfUsv1PeZg=;
        b=LqitI8Fk8iouH7l+bs58CLdeFBEIArSiPbGGVAPXkttqgqeKPod85b1kvGc2Nb5drz
         HBacSARtFBdDX1ttDqbJWu2GTRvl8qgpjFJeVf2hl0y5ROyFUdgGNEh3bmpfD7TW5oi6
         qVS1usjI3HUh0ABSG+HD/xzzbE8LWMjb+wWQhCZThDLBmWQsoXpT0pK4nADIg9QS0KVE
         EZBmlEV5sq+gxIpE865fJ6hfe3xHTiLsPjDfbEihG1izit8HgYYGV3lhiJ3DbKlocva1
         uTP1PrifxYiFb/CKMA/LQmBStpgc9oZ5lom1WosIFXzhumhw0wQMsysFKYOzS0VEcUiz
         D/XA==
X-Gm-Message-State: AOJu0Yyr6wS44W7Vr31+sI/dDX87XxrVofjza5olMauFb+KaSKI1/wsc
        hYFg+hrk2VcTrriofnkGh8LEKI67EoJIay9g5jTc1w==
X-Google-Smtp-Source: AGHT+IGAESo71TcDtp4PhAumypPzLOYsMlreSo9KOtjEUiXzZQ5yHW7O4gv5AvPrsbQWkUO+3HKTXPu2yghcVpnpeDA=
X-Received: by 2002:a0d:ca93:0:b0:5c5:a04c:5eb2 with SMTP id
 m141-20020a0dca93000000b005c5a04c5eb2mr23685462ywd.33.1701343866889; Thu, 30
 Nov 2023 03:31:06 -0800 (PST)
MIME-Version: 1.0
References: <20231123-topic-amlogic-upstream-isp-pmdomain-v2-0-61f2fcf709e5@linaro.org>
 <20231123-topic-amlogic-upstream-isp-pmdomain-v2-2-61f2fcf709e5@linaro.org>
In-Reply-To: <20231123-topic-amlogic-upstream-isp-pmdomain-v2-2-61f2fcf709e5@linaro.org>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Thu, 30 Nov 2023 12:30:31 +0100
Message-ID: <CAPDyKFq7-sGF+obKXOYHaox=Ak29HuJ1=ZMfGiBHrMOQqiiH4A@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] pmdomain: amlogic: meson-ee-pwrc: add support for
 G12A ISP power domain
To:     Neil Armstrong <neil.armstrong@linaro.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Daniel Scally <dan.scally@ideasonboard.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 23 Nov 2023 at 17:17, Neil Armstrong <neil.armstrong@linaro.org> wrote:
>
> Add entries for the ISP power domain found in the Amlogic G12B SoC
>
> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>

Applied for next, thanks!

Kind regards
Uffe


> ---
>  drivers/pmdomain/amlogic/meson-ee-pwrc.c | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
>
> diff --git a/drivers/pmdomain/amlogic/meson-ee-pwrc.c b/drivers/pmdomain/amlogic/meson-ee-pwrc.c
> index 0dd71cd814c5..fcec6eb610e4 100644
> --- a/drivers/pmdomain/amlogic/meson-ee-pwrc.c
> +++ b/drivers/pmdomain/amlogic/meson-ee-pwrc.c
> @@ -47,6 +47,8 @@
>
>  #define G12A_HHI_NANOQ_MEM_PD_REG0     (0x43 << 2)
>  #define G12A_HHI_NANOQ_MEM_PD_REG1     (0x44 << 2)
> +#define G12A_HHI_ISP_MEM_PD_REG0       (0x45 << 2)
> +#define G12A_HHI_ISP_MEM_PD_REG1       (0x46 << 2)
>
>  struct meson_ee_pwrc;
>  struct meson_ee_pwrc_domain;
> @@ -115,6 +117,13 @@ static struct meson_ee_pwrc_top_domain g12a_pwrc_nna = {
>         .iso_mask = BIT(16) | BIT(17),
>  };
>
> +static struct meson_ee_pwrc_top_domain g12a_pwrc_isp = {
> +       .sleep_reg = GX_AO_RTI_GEN_PWR_SLEEP0,
> +       .sleep_mask = BIT(18) | BIT(19),
> +       .iso_reg = GX_AO_RTI_GEN_PWR_ISO0,
> +       .iso_mask = BIT(18) | BIT(19),
> +};
> +
>  /* Memory PD Domains */
>
>  #define VPU_MEMPD(__reg)                                       \
> @@ -231,6 +240,11 @@ static struct meson_ee_pwrc_mem_domain g12a_pwrc_mem_nna[] = {
>         { G12A_HHI_NANOQ_MEM_PD_REG1, GENMASK(31, 0) },
>  };
>
> +static struct meson_ee_pwrc_mem_domain g12a_pwrc_mem_isp[] = {
> +       { G12A_HHI_ISP_MEM_PD_REG0, GENMASK(31, 0) },
> +       { G12A_HHI_ISP_MEM_PD_REG1, GENMASK(31, 0) },
> +};
> +
>  #define VPU_PD(__name, __top_pd, __mem, __is_pwr_off, __resets, __clks)        \
>         {                                                               \
>                 .name = __name,                                         \
> @@ -269,6 +283,8 @@ static struct meson_ee_pwrc_domain_desc g12a_pwrc_domains[] = {
>         [PWRC_G12A_ETH_ID] = MEM_PD("ETH", meson_pwrc_mem_eth),
>         [PWRC_G12A_NNA_ID] = TOP_PD("NNA", &g12a_pwrc_nna, g12a_pwrc_mem_nna,
>                                     pwrc_ee_is_powered_off),
> +       [PWRC_G12A_ISP_ID] = TOP_PD("ISP", &g12a_pwrc_isp, g12a_pwrc_mem_isp,
> +                                   pwrc_ee_is_powered_off),
>  };
>
>  static struct meson_ee_pwrc_domain_desc gxbb_pwrc_domains[] = {
>
> --
> 2.34.1
>
