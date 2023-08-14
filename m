Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B05E077B78D
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Aug 2023 13:26:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234488AbjHNL0F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 07:26:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233736AbjHNLZe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 07:25:34 -0400
Received: from mail-yw1-x112b.google.com (mail-yw1-x112b.google.com [IPv6:2607:f8b0:4864:20::112b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFE59E61
        for <linux-kernel@vger.kernel.org>; Mon, 14 Aug 2023 04:25:32 -0700 (PDT)
Received: by mail-yw1-x112b.google.com with SMTP id 00721157ae682-58c4e337357so2043737b3.0
        for <linux-kernel@vger.kernel.org>; Mon, 14 Aug 2023 04:25:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1692012332; x=1692617132;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=KS7KVcgftVL37t1n9Che7EJW3j0iqYnMxaJ13obaF6g=;
        b=pGZf4oMW7KC/g9GiLfwbb7+ZOWIZRij69MhybRVywOgC7Ni84ZUKWxbJZ4K1lwHBKW
         wUBBrLoHl0RB/t9AgOQ/IpvjGHh8orLDgkhjrWvDIw0JYqo6ilxSo5UVrVK3Kk5ZCI8q
         rV5R4DziiIAq+HgsTvv7gQdWnofFck99BSICcWnPSizyjgH0WSIudWNomIy/fEcgx8lS
         CF1h+9FDMrAv9vJ4nmq3AvWQ7DRKgUj1UZnirx7L9+lYxqkipu08SvxK0tw42uni+8GW
         3Y1fpOT6eobDpkq7KInwApKGjoj9btgJmThWI/yIF1M99vr9v6XhCsmhnq900gcMQxhO
         AcUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692012332; x=1692617132;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KS7KVcgftVL37t1n9Che7EJW3j0iqYnMxaJ13obaF6g=;
        b=Yl34WgR5uHcxQ8hxpYjmdUDvW5ItT+Q7/neSpgYSF/t7vgvAQWaak3mUP88ccDcHzK
         xpLjmt6eLm8OSQig6imwwzIoFvRQlMc9ji44qH1YAbjv2ZHy/ECTsumLFrKdt4/HLy+h
         rjwUO6plMika6UA6LBlNCWoKVdFUWbo5cbKADkb6O7vBRxMb/ksfFs2iaemb15ucyaYC
         cHKwFHWa2UPYEIBPIP/OK47N8hBc5+mY57lqEiyy2PcBwy+RtNkPnISKaTV8HKAAmufX
         pjT82Lh4Y0n0Alj8rjHMXpqfgNIiyv/m9MM8h8KxkkB3+QMKNjWkgyXUvWT9rPZocG7h
         zGlA==
X-Gm-Message-State: AOJu0Ywr9jzktV+caQUkyrP2kpi8CbrN2A2lP3+gT3yy88sB57D7B8hW
        /KYaNNEtj5iYxM89zS5JknOu40p6B52OFLuWNPOF78Majnv/3UcZiCI=
X-Google-Smtp-Source: AGHT+IES5ORseNqi8LIzHc7ycAD1U+yCVVZUaRHk5zU+z/Eghzgj0E95t8Xr6/jAR11PIgqVILcctQWrS2XEADPK17o=
X-Received: by 2002:a81:a542:0:b0:583:c917:7ff0 with SMTP id
 v2-20020a81a542000000b00583c9177ff0mr8563710ywg.51.1692012332124; Mon, 14 Aug
 2023 04:25:32 -0700 (PDT)
MIME-Version: 1.0
References: <20230814104127.1929-1-peng.fan@oss.nxp.com> <20230814104127.1929-8-peng.fan@oss.nxp.com>
In-Reply-To: <20230814104127.1929-8-peng.fan@oss.nxp.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Mon, 14 Aug 2023 13:24:56 +0200
Message-ID: <CAPDyKFqaA2q=jEYDwAE58vERcHC_rtNYpYf8TbvU80a29oFy3w@mail.gmail.com>
Subject: Re: [PATCH V4 7/8] genpd: imx: scu-pd: add multi states support
To:     "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Cc:     shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, linux-imx@nxp.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, Peng Fan <peng.fan@nxp.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 14 Aug 2023 at 12:37, Peng Fan (OSS) <peng.fan@oss.nxp.com> wrote:
>
> From: Peng Fan <peng.fan@nxp.com>
>
> Add multi states support, this is to support devices could run in LP mode
> when runtime suspend, and OFF mode when system suspend.

For my understanding, is there a functional problem to support OFF at
runtime suspend too?

>
> Signed-off-by: Peng Fan <peng.fan@nxp.com>
> ---
>  drivers/genpd/imx/scu-pd.c | 48 ++++++++++++++++++++++++++++++++++++--
>  1 file changed, 46 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/genpd/imx/scu-pd.c b/drivers/genpd/imx/scu-pd.c
> index 2f693b67ddb4..30da101119eb 100644
> --- a/drivers/genpd/imx/scu-pd.c
> +++ b/drivers/genpd/imx/scu-pd.c
> @@ -65,6 +65,12 @@
>  #include <linux/pm_domain.h>
>  #include <linux/slab.h>
>
> +enum {
> +       PD_STATE_LP,
> +       PD_STATE_OFF,
> +       PD_STATE_MAX
> +};
> +
>  /* SCU Power Mode Protocol definition */
>  struct imx_sc_msg_req_set_resource_power_mode {
>         struct imx_sc_rpc_msg hdr;
> @@ -368,7 +374,8 @@ static int imx_sc_pd_power(struct generic_pm_domain *domain, bool power_on)
>         hdr->size = 2;
>
>         msg.resource = pd->rsrc;
> -       msg.mode = power_on ? IMX_SC_PM_PW_MODE_ON : IMX_SC_PM_PW_MODE_LP;
> +       msg.mode = power_on ? IMX_SC_PM_PW_MODE_ON : pd->pd.state_idx ?
> +                  IMX_SC_PM_PW_MODE_OFF : IMX_SC_PM_PW_MODE_LP;
>
>         /* keep uart console power on for no_console_suspend */
>         if (imx_con_rsrc == pd->rsrc && !console_suspend_enabled && !power_on)
> @@ -412,11 +419,33 @@ static struct generic_pm_domain *imx_scu_pd_xlate(struct of_phandle_args *spec,
>         return domain;
>  }
>
> +static bool imx_sc_pd_suspend_ok(struct device *dev)
> +{
> +       /* Always true */
> +       return true;
> +}
> +
> +static bool imx_sc_pd_power_down_ok(struct dev_pm_domain *pd)
> +{
> +       struct generic_pm_domain *genpd = pd_to_genpd(pd);
> +
> +       /* For runtime suspend, choose LP mode */
> +       genpd->state_idx = 0;
> +
> +       return true;
> +}

I am wondering if we couldn't use the simple_qos_governor here
instead. In principle it looks like we want a QoS latency constraint
to be set during runtime, to prevent the OFF state.

During system wide suspend, the deepest state is always selected by genpd.

> +
> +struct dev_power_governor imx_sc_pd_qos_governor = {
> +       .suspend_ok = imx_sc_pd_suspend_ok,
> +       .power_down_ok = imx_sc_pd_power_down_ok,
> +};
> +
>  static struct imx_sc_pm_domain *
>  imx_scu_add_pm_domain(struct device *dev, int idx,
>                       const struct imx_sc_pd_range *pd_ranges)
>  {
>         struct imx_sc_pm_domain *sc_pd;
> +       struct genpd_power_state *states;
>         bool is_off;
>         int mode, ret;
>
> @@ -427,9 +456,22 @@ imx_scu_add_pm_domain(struct device *dev, int idx,
>         if (!sc_pd)
>                 return ERR_PTR(-ENOMEM);
>
> +       states = devm_kcalloc(dev, PD_STATE_MAX, sizeof(*states), GFP_KERNEL);
> +       if (!states) {
> +               devm_kfree(dev, sc_pd);
> +               return ERR_PTR(-ENOMEM);
> +       }
> +
>         sc_pd->rsrc = pd_ranges->rsrc + idx;
>         sc_pd->pd.power_off = imx_sc_pd_power_off;
>         sc_pd->pd.power_on = imx_sc_pd_power_on;
> +       states[PD_STATE_LP].power_off_latency_ns = 25000;
> +       states[PD_STATE_LP].power_on_latency_ns =  25000;
> +       states[PD_STATE_OFF].power_off_latency_ns = 2500000;
> +       states[PD_STATE_OFF].power_on_latency_ns =  2500000;

We should probably describe these in DT instead? The
domain-idle-states bindings allows us to do this. See
Documentation/devicetree/bindings/power/domain-idle-state.yaml.

Then we have of_genpd_parse_idle_states(), a helper that parses the values.

> +
> +       sc_pd->pd.states = states;
> +       sc_pd->pd.state_count = PD_STATE_MAX;
>
>         if (pd_ranges->postfix)
>                 snprintf(sc_pd->name, sizeof(sc_pd->name),
> @@ -455,14 +497,16 @@ imx_scu_add_pm_domain(struct device *dev, int idx,
>                          sc_pd->name, sc_pd->rsrc);
>
>                 devm_kfree(dev, sc_pd);
> +               devm_kfree(dev, states);
>                 return NULL;
>         }
>
> -       ret = pm_genpd_init(&sc_pd->pd, NULL, is_off);
> +       ret = pm_genpd_init(&sc_pd->pd, &imx_sc_pd_qos_governor, is_off);
>         if (ret) {
>                 dev_warn(dev, "failed to init pd %s rsrc id %d",
>                          sc_pd->name, sc_pd->rsrc);
>                 devm_kfree(dev, sc_pd);
> +               devm_kfree(dev, states);
>                 return NULL;
>         }
>
> --
> 2.37.1
>

Kind regards
Uffe
