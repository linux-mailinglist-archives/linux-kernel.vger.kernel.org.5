Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA86D78BA20
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Aug 2023 23:18:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232535AbjH1VSD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Aug 2023 17:18:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233928AbjH1VRy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Aug 2023 17:17:54 -0400
Received: from mail-yb1-xb32.google.com (mail-yb1-xb32.google.com [IPv6:2607:f8b0:4864:20::b32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA65DB0
        for <linux-kernel@vger.kernel.org>; Mon, 28 Aug 2023 14:17:50 -0700 (PDT)
Received: by mail-yb1-xb32.google.com with SMTP id 3f1490d57ef6-d743a5fe05aso3530518276.2
        for <linux-kernel@vger.kernel.org>; Mon, 28 Aug 2023 14:17:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1693257470; x=1693862270;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=f9jALwD1uC0KtZuXZX1O2xVbYTySSiswScnBQLCQmTo=;
        b=K5Zn7C+O448FoDa8PZHhHq8JGr5KXolv2AB028Bh6OnwwEKKwBX7IEm9yOM9JR5u3C
         +r4Ti0gIU2ZizmHKLRjfQufO/rjxvo+9De3ECSc4LyU+qz+VFw7PoaT+YigSI5DDQUP7
         Q80z91JVTZoxwgawuDHPNKjfEhTS7RX4Q9H3HAn60vLj/TsE/N4kCfc1niBaezit9Tc/
         S2FyCPdheFXAo55+binnR0XiJ8zBbFSr9dxa9AFRJXJpE4zVNSeg1/b22xi4WngkyBBq
         yXLBLR0l9s8rSlqY0XXyI1kwsvcucd+ERUdEcoVsnR+/9EX2SZ1cm6hVoBV8KD6gH9EJ
         MjMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693257470; x=1693862270;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=f9jALwD1uC0KtZuXZX1O2xVbYTySSiswScnBQLCQmTo=;
        b=UVp7x1YJSNTxk+6SfaEyACj31Js4Z/6Ni3BXebcA+kqBKWVmZV/rLA8SIhilfaiQ26
         uKF25C0+y1VZwk2wknHW1xNDgOltZji/0McMg6iNFa25uYYaNwWOVaeqK+Cj5Kdtm426
         /mLDB65YpmwDjKjWZouvHPz8u0Q057GRE1IOH9JjPROF/CiRbP6VlOIherWVHyGjY0uA
         tcDjfhKlrKwrj796F3kGJZ5gAeFN/8sMqkWOyIRa2wqb9KYBk5kE8KtEzob0vcucryGm
         r8rpFrE+DIlFwxxWubOVegpklNjt3XwBV/bNi03a+OtzZOZ7xJYDmzvqA1+Zatz8Uqn+
         I8xQ==
X-Gm-Message-State: AOJu0Yw8vKU8UE//0ZTIXfAaXD1/1FD4isP9f0wXi78HPnQ59wKIaI0q
        ASF2dbKte21Au16W7tMEchkxE55FGJcwuGQ79g2CIg==
X-Google-Smtp-Source: AGHT+IH9oHl7cpRrmmvDKkhNTbIIP6NDeJaMY0rL9fLLzj8f5lI0//oQDArcdmDO0LIUmt7XwHj0KTfOVpZsFlOgLCk=
X-Received: by 2002:a25:68d2:0:b0:d77:f613:30ec with SMTP id
 d201-20020a2568d2000000b00d77f61330ecmr13226979ybc.54.1693257470001; Mon, 28
 Aug 2023 14:17:50 -0700 (PDT)
MIME-Version: 1.0
References: <1693250307-8910-1-git-send-email-quic_srichara@quicinc.com> <1693250307-8910-3-git-send-email-quic_srichara@quicinc.com>
In-Reply-To: <1693250307-8910-3-git-send-email-quic_srichara@quicinc.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Tue, 29 Aug 2023 00:17:39 +0300
Message-ID: <CAA8EJppX4SJo8GtvR5D251mnAT42YzH7ju2bE+qxSc7GtmKXCQ@mail.gmail.com>
Subject: Re: [PATCH 2/7] thermal/drivers/qcom: Add new feat for soc without rpm
To:     Sricharan Ramabadhran <quic_srichara@quicinc.com>
Cc:     agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        srinivas.kandagatla@linaro.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        thara.gopinath@gmail.com, rafael@kernel.org,
        daniel.lezcano@linaro.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 28 Aug 2023 at 22:20, Sricharan Ramabadhran
<quic_srichara@quicinc.com> wrote:
>
> Some of the tsens IP like the one in IPQ5018 does not have a
> RPM in the soc. Hence the early init to enable tsens would not

Tsens IP doesn't have RPM. Please rephrase this.

> be done. So add a flag for that in feat and skip enable checks.
>
> Signed-off-by: Sricharan Ramabadhran <quic_srichara@quicinc.com>
> ---
>  drivers/thermal/qcom/tsens.c | 2 +-
>  drivers/thermal/qcom/tsens.h | 3 +++
>  2 files changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/thermal/qcom/tsens.c b/drivers/thermal/qcom/tsens.c
> index 98c356acfe98..f39495b61952 100644
> --- a/drivers/thermal/qcom/tsens.c
> +++ b/drivers/thermal/qcom/tsens.c
> @@ -974,7 +974,7 @@ int __init init_common(struct tsens_priv *priv)
>         ret = regmap_field_read(priv->rf[TSENS_EN], &enabled);
>         if (ret)
>                 goto err_put_device;
> -       if (!enabled) {
> +       if (!enabled && !(priv->feat->no_early_init)) {
>                 dev_err(dev, "%s: device not enabled\n", __func__);
>                 ret = -ENODEV;
>                 goto err_put_device;
> diff --git a/drivers/thermal/qcom/tsens.h b/drivers/thermal/qcom/tsens.h
> index 2805de1c6827..fb73e3dd0de9 100644
> --- a/drivers/thermal/qcom/tsens.h
> +++ b/drivers/thermal/qcom/tsens.h
> @@ -505,6 +505,8 @@ enum regfield_ids {
>   * @srot_split: does the IP neatly splits the register space into SROT and TM,
>   *              with SROT only being available to secure boot firmware?
>   * @has_watchdog: does this IP support watchdog functionality?
> + * @no_early_init: does this IP reside in a soc that does not have rpm to
> + *                 do pre-init.
>   * @max_sensors: maximum sensors supported by this version of the IP
>   * @trip_min_temp: minimum trip temperature supported by this version of the IP
>   * @trip_max_temp: maximum trip temperature supported by this version of the IP
> @@ -516,6 +518,7 @@ struct tsens_features {
>         unsigned int adc:1;
>         unsigned int srot_split:1;
>         unsigned int has_watchdog:1;
> +       unsigned int no_early_init:1;

s/no_early_init/ignore_enable/

>         unsigned int max_sensors;
>         int trip_min_temp;
>         int trip_max_temp;
> --
> 2.34.1
>


-- 
With best wishes
Dmitry
