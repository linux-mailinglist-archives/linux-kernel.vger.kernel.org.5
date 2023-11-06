Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 826907E28E6
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Nov 2023 16:42:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232178AbjKFPmB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Nov 2023 10:42:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231929AbjKFPl7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Nov 2023 10:41:59 -0500
Received: from mail-yb1-xb33.google.com (mail-yb1-xb33.google.com [IPv6:2607:f8b0:4864:20::b33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77E9210A
        for <linux-kernel@vger.kernel.org>; Mon,  6 Nov 2023 07:41:55 -0800 (PST)
Received: by mail-yb1-xb33.google.com with SMTP id 3f1490d57ef6-d9c66e70ebdso4677311276.2
        for <linux-kernel@vger.kernel.org>; Mon, 06 Nov 2023 07:41:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1699285314; x=1699890114; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=zFsHwFdMSzfDdOBIFA7K/yvGX5wUXDR0ViZVLr0N5ZA=;
        b=kttzcWpkkXww/BzeeF5piE/WVes8GdD+tqp7vBoO8rX89HaITuppjuBHXFrrXR7iKh
         uh+mn0xFsYvdyCFy/j6F+pR8tr5MwKNINBRJlniQb0r2PTEARWFD6kkWTMs92A7pUCkK
         dCHvUxo+sL0wLGxBMODwK+Lb/QvyaGKSVDzwbOrHJG8mtW0U9eLrDDYWb5fzLUUhGC2W
         zm7C5wMhlII0R39zHARw0ZqANk5zlTFa5+ALk6pfwSz6rliocAjs1AEcRCetLPplr3Ab
         xbzYqj4zqxXCc5Zj10pj7HxFfhrV+Iea/5UdDOdBFSdEHBcPb1hX5nI7Bk4C5+4xlXv6
         fCOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699285314; x=1699890114;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zFsHwFdMSzfDdOBIFA7K/yvGX5wUXDR0ViZVLr0N5ZA=;
        b=BBORLX8OK4wCBnR6UgcaeksEWtv4VWbdotRymAxEwNOZ+iShkWA2aw6enZghgk5TBu
         FPK+SVLXfXm33NtfDv0lk0i8ls5ATZ2LHPNtZ38GNxewO25KFDRYEK8SQw9bUsLx2yb6
         3DZqocA0VpFzwJ4iZIs4hvJg7Ob59s8PIHWzj4eCTelW7klSViavpPsbL4AeASjobiFW
         EvEGrJide1mFWswc0OjyJj4fgWCNaNP6ot3+TibKe0pXWVJN6ezGiSxQ1A9ToAKOIA9w
         VCOseGrADI/oItXIk3eWbIXrGB3sRcTUDsU0ifHR7AzTZOsCxWep8sDES95MfcQOFHpD
         zOhQ==
X-Gm-Message-State: AOJu0YyMYNg6xghU9Fp1ny+omLFBPZ/suiiypnZhXakr0NDUd+IFM3bN
        /fZDTnprVTmdR6wCwuAM4RjN4CI10jd6XJENyhCIAw==
X-Google-Smtp-Source: AGHT+IHmhUsFkec8OZHbmuEZ9wd5vJ5jAvEIPZHTTWsHd5XJUJcgV7Pj+uVgyv4ObOEueBpZ5AIPAIZYScr68U+5ZeQ=
X-Received: by 2002:a25:9805:0:b0:da0:c5eb:a6c6 with SMTP id
 a5-20020a259805000000b00da0c5eba6c6mr26313363ybo.32.1699285314491; Mon, 06
 Nov 2023 07:41:54 -0800 (PST)
MIME-Version: 1.0
References: <cover.1698661048.git.viresh.kumar@linaro.org> <36de122e568dcba371d3581e5f936243b405a874.1698661048.git.viresh.kumar@linaro.org>
In-Reply-To: <36de122e568dcba371d3581e5f936243b405a874.1698661048.git.viresh.kumar@linaro.org>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Mon, 6 Nov 2023 16:41:18 +0100
Message-ID: <CAPDyKFpsfzdarSz5h_XuyLbfXKCWPQdV5M+mOb_Q6GhhgzCXAA@mail.gmail.com>
Subject: Re: [PATCH V2 1/3] OPP: Level zero is valid
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>, linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Stephan Gerhold <stephan.gerhold@kernkonzept.com>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 30 Oct 2023 at 11:24, Viresh Kumar <viresh.kumar@linaro.org> wrote:
>
> The level zero can be used by some OPPs to drop performance state vote
> for the device. It is perfectly fine to allow the same.
>
> _set_opp_level() considers it as an invalid value currently and returns
> early.
>
> In order to support this properly, initialize the level field with
> U32_MAX, which denotes unused level field.
>
> Reported-by: Stephan Gerhold <stephan.gerhold@kernkonzept.com>
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>

Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>

Kind regards
Uffe


> ---
>  drivers/opp/core.c     | 24 ++++++++++++++++++++----
>  drivers/opp/of.c       |  8 +++++++-
>  include/linux/pm_opp.h |  5 ++++-
>  3 files changed, 31 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/opp/core.c b/drivers/opp/core.c
> index 84f345c69ea5..f2e2aa07b431 100644
> --- a/drivers/opp/core.c
> +++ b/drivers/opp/core.c
> @@ -201,7 +201,7 @@ EXPORT_SYMBOL_GPL(dev_pm_opp_get_freq_indexed);
>   * @opp:       opp for which level value has to be returned for
>   *
>   * Return: level read from device tree corresponding to the opp, else
> - * return 0.
> + * return U32_MAX.
>   */
>  unsigned int dev_pm_opp_get_level(struct dev_pm_opp *opp)
>  {
> @@ -221,7 +221,7 @@ EXPORT_SYMBOL_GPL(dev_pm_opp_get_level);
>   * @index:     index of the required opp
>   *
>   * Return: performance state read from device tree corresponding to the
> - * required opp, else return 0.
> + * required opp, else return U32_MAX.
>   */
>  unsigned int dev_pm_opp_get_required_pstate(struct dev_pm_opp *opp,
>                                             unsigned int index)
> @@ -808,6 +808,14 @@ struct dev_pm_opp *dev_pm_opp_find_level_ceil(struct device *dev,
>         struct dev_pm_opp *opp;
>
>         opp = _find_key_ceil(dev, &temp, 0, true, _read_level, NULL);
> +
> +       /* False match */
> +       if (temp == OPP_LEVEL_UNSET) {
> +               dev_err(dev, "%s: OPP levels aren't available\n", __func__);
> +               dev_pm_opp_put(opp);
> +               return ERR_PTR(-ENODEV);
> +       }
> +
>         *level = temp;
>         return opp;
>  }
> @@ -1049,12 +1057,18 @@ static int _set_opp_bw(const struct opp_table *opp_table,
>  static int _set_performance_state(struct device *dev, struct device *pd_dev,
>                                   struct dev_pm_opp *opp, int i)
>  {
> -       unsigned int pstate = likely(opp) ? opp->required_opps[i]->level: 0;
> +       unsigned int pstate = 0;
>         int ret;
>
>         if (!pd_dev)
>                 return 0;
>
> +       if (likely(opp)) {
> +               pstate = opp->required_opps[i]->level;
> +               if (pstate == OPP_LEVEL_UNSET)
> +                       return 0;
> +       }
> +
>         ret = dev_pm_domain_set_performance_state(pd_dev, pstate);
>         if (ret) {
>                 dev_err(dev, "Failed to set performance state of %s: %d (%d)\n",
> @@ -1135,7 +1149,7 @@ static int _set_opp_level(struct device *dev, struct opp_table *opp_table,
>         int ret = 0;
>
>         if (opp) {
> -               if (!opp->level)
> +               if (opp->level == OPP_LEVEL_UNSET)
>                         return 0;
>
>                 level = opp->level;
> @@ -1867,6 +1881,8 @@ struct dev_pm_opp *_opp_allocate(struct opp_table *opp_table)
>
>         INIT_LIST_HEAD(&opp->node);
>
> +       opp->level = OPP_LEVEL_UNSET;
> +
>         return opp;
>  }
>
> diff --git a/drivers/opp/of.c b/drivers/opp/of.c
> index 81fa27599d58..85fad7ca0007 100644
> --- a/drivers/opp/of.c
> +++ b/drivers/opp/of.c
> @@ -1393,8 +1393,14 @@ int of_get_required_opp_performance_state(struct device_node *np, int index)
>
>         opp = _find_opp_of_np(opp_table, required_np);
>         if (opp) {
> -               pstate = opp->level;
> +               if (opp->level == OPP_LEVEL_UNSET) {
> +                       pr_err("%s: OPP levels aren't available for %pOF\n",
> +                              __func__, np);
> +               } else {
> +                       pstate = opp->level;
> +               }
>                 dev_pm_opp_put(opp);
> +
>         }
>
>         dev_pm_opp_put_opp_table(opp_table);
> diff --git a/include/linux/pm_opp.h b/include/linux/pm_opp.h
> index ccd97bcef269..af53101a1383 100644
> --- a/include/linux/pm_opp.h
> +++ b/include/linux/pm_opp.h
> @@ -92,9 +92,12 @@ struct dev_pm_opp_config {
>         struct device ***virt_devs;
>  };
>
> +#define OPP_LEVEL_UNSET                        U32_MAX
> +
>  /**
>   * struct dev_pm_opp_data - The data to use to initialize an OPP.
> - * @level: The performance level for the OPP.
> + * @level: The performance level for the OPP. Set level to OPP_LEVEL_UNSET if
> + * level field isn't used.
>   * @freq: The clock rate in Hz for the OPP.
>   * @u_volt: The voltage in uV for the OPP.
>   */
> --
> 2.31.1.272.g89b43f80a514
>
