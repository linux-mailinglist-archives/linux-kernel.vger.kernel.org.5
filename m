Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51A9B757507
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 09:09:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231648AbjGRHJF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 03:09:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230372AbjGRHJD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 03:09:03 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 004621B6;
        Tue, 18 Jul 2023 00:08:52 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id a640c23a62f3a-98e39784a85so1373753366b.1;
        Tue, 18 Jul 2023 00:08:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689664131; x=1692256131;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=k1Uig7jO8o8o2fjtKY5og6vwJR6VWV4OAjykjIq0WYM=;
        b=Hd4FKoAolT/mh4wz5aTN9L74io6gtEf5lkqbWVg5QZs3At5wC5LbDFZDNPTgsnA7iY
         zBXvch4MtgO2RotrYEVRD5SkZvGMLsls4f6yOJEsAIdi6QVSU6cd8HnM8sHRsnIN+3/h
         03VzFb+JWvvL//A5JN/DdYpBVk82rH8gwcs4pke/OVDe7h5UFlIDerd7vlTP9Q37ti3G
         Kqzcxjmltrgrm3++ab+X+99pYG8p3DxlCDIoUtVTrEIUBSXD442Pd+ftCY3bQdaFkhy+
         Em8HHNNIk/L9gSGZsFN1UMUEon81OqVaFYtiesQIFBEd0PKiqLXrSeqxyYuIxJyui3kU
         Is6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689664131; x=1692256131;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=k1Uig7jO8o8o2fjtKY5og6vwJR6VWV4OAjykjIq0WYM=;
        b=a2wIW0eQ8Q8fDPtNuSo2zzk8JSvenkx0hkDqIixhEIbk9pF9rVBlT3CSb9vmNEVUJr
         zc3Xxnz82ZBz1SnMSxR6yW1lpadhbglF0YbZdAftIFZdCdiCEeHHybeXXoQOc+WJZrw0
         1h9UyZVa0aQSNoOIZZSj/mYiZb0ldNQKiFQpEfB+77IUA1JcPgjF4ELx0e66fSlkBf7O
         qH0yQfUlIqwzNdDRKmwoGw5fYi3hrKih+zqkdkXEl0F87h+IdgW5QzcnFKced1YDgWjb
         ZRn/fSePNH4pWH5cdbpZ2edwYs6vwwNY2n7tAfOtqBEpw4im9NZ2zVuss+/TxGJIfud4
         YhwA==
X-Gm-Message-State: ABy/qLaQIkCqy93RIcHwP+h269YHOW4lZcUv4KbBePGkHTFaMMjCYWwj
        slo1yqi3BeBXuKfX3pxo08U=
X-Google-Smtp-Source: APBJJlEYXRhXxe3hzaaxA194Dwv+2aqOpvsuyeDTCOnMLh2vlCfXbDAeWU4SBPTkFXuEa+tLrxcYHA==
X-Received: by 2002:a17:907:d91:b0:993:b230:936b with SMTP id go17-20020a1709070d9100b00993b230936bmr13324429ejc.6.1689664131134;
        Tue, 18 Jul 2023 00:08:51 -0700 (PDT)
Received: from orome (p200300e41f4b7100f22f74fffe1f3a53.dip0.t-ipconnect.de. [2003:e4:1f4b:7100:f22f:74ff:fe1f:3a53])
        by smtp.gmail.com with ESMTPSA id m23-20020aa7c2d7000000b0051def9be785sm739097edp.85.2023.07.18.00.08.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Jul 2023 00:08:50 -0700 (PDT)
Date:   Tue, 18 Jul 2023 09:08:48 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Billy Tsai <billy_tsai@aspeedtech.com>
Cc:     jdelvare@suse.com, linux@roeck-us.net, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, joel@jms.id.au, andrew@aj.id.au,
        u.kleine-koenig@pengutronix.de, corbet@lwn.net,
        p.zabel@pengutronix.de, linux-hwmon@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        linux-pwm@vger.kernel.org, linux-doc@vger.kernel.org,
        patrick@stwcx.xyz
Subject: Re: [v6 3/4] pwm: Add Aspeed ast2600 PWM support
Message-ID: <ZLY6gD1zXQ7ydq8c@orome>
References: <20230608021839.12769-1-billy_tsai@aspeedtech.com>
 <20230608021839.12769-4-billy_tsai@aspeedtech.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="8BvSCPl3bohrvJz8"
Content-Disposition: inline
In-Reply-To: <20230608021839.12769-4-billy_tsai@aspeedtech.com>
User-Agent: Mutt/2.2.10 (2023-03-25)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--8BvSCPl3bohrvJz8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jun 08, 2023 at 10:18:38AM +0800, Billy Tsai wrote:
[...]
> diff --git a/drivers/pwm/pwm-aspeed-ast2600.c b/drivers/pwm/pwm-aspeed-ast2600.c
[...]
> +/* PWM Control Register */
> +#define PWM_ASPEED_CTRL				(0x00)
[...]
> +#define PWM_ASPEED_DUTY_CYCLE			(0x04)

Guenther already mentioned this, but these parentheses are unnecessary.

> +struct aspeed_pwm_data {
> +	struct pwm_chip chip;
> +	struct clk *clk;
> +	void __iomem *base;
> +	struct reset_control *reset;
> +	unsigned long clk_source;

The name is a bit unfortunate. Looking at the code this represent the
rate of the parent clock, so something like clk_rate would be more
appropriate.

> +};
> +
> +static inline struct aspeed_pwm_data *
> +aspeed_pwm_chip_to_data(struct pwm_chip *chip)
> +{
> +	return container_of(chip, struct aspeed_pwm_data, chip);
> +}
> +
> +static int aspeed_pwm_get_state(struct pwm_chip *chip, struct pwm_device *pwm,
> +				struct pwm_state *state)
> +{
> +	struct device *dev = chip->dev;

You seem to use this exactly once, in a debug message, so having the
extra local variable seems a bit overkill. No strong objection, though.

> +	struct aspeed_pwm_data *priv = aspeed_pwm_chip_to_data(chip);
> +	bool polarity,	pin_en, clk_en;

A tab seems to have snuck in here.

> +	u32 duty_pt, val;
> +	u64 div_h, div_l, duty_cycle_period, dividend;
> +
> +	val = readl(priv->base + PWM_ASPEED_CTRL);
> +	polarity = FIELD_GET(PWM_ASPEED_CTRL_INVERSE, val);
> +	pin_en = FIELD_GET(PWM_ASPEED_CTRL_PIN_ENABLE, val);
> +	clk_en = FIELD_GET(PWM_ASPEED_CTRL_CLK_ENABLE, val);
> +	div_h = FIELD_GET(PWM_ASPEED_CTRL_CLK_DIV_H, val);
> +	div_l = FIELD_GET(PWM_ASPEED_CTRL_CLK_DIV_L, val);
> +	val = readl(priv->base + PWM_ASPEED_DUTY_CYCLE);
> +	duty_pt = FIELD_GET(PWM_ASPEED_DUTY_CYCLE_FALLING_POINT, val);
> +	duty_cycle_period = FIELD_GET(PWM_ASPEED_DUTY_CYCLE_PERIOD, val);
> +
> +	/*
> +	 * This multiplication doesn't overflow, the upper bound is
> +	 * 1000000000 * 256 * 256 << 15 = 0x1dcd650000000000
> +	 */
> +	dividend = (u64)NSEC_PER_SEC * (div_l + 1) * (duty_cycle_period + 1)
> +		       << div_h;
> +	state->period = DIV_ROUND_UP_ULL(dividend, priv->clk_source);
> +
> +	if (clk_en && duty_pt) {
> +		dividend = (u64)NSEC_PER_SEC * (div_l + 1) * duty_pt
> +				 << div_h;
> +		state->duty_cycle =
> +			DIV_ROUND_UP_ULL(dividend, priv->clk_source);
> +	} else {
> +		state->duty_cycle = clk_en ? state->period : 0;
> +	}
> +	state->polarity = polarity ? PWM_POLARITY_INVERSED : PWM_POLARITY_NORMAL;
> +	state->enabled = pin_en;
> +	dev_dbg(dev, "get period: %lldns, duty_cycle: %lldns", state->period,
> +		state->duty_cycle);

How likely are you to ever use this again? And how useful will that be?
We've got debugfs support that will show this information and more.

> +	return 0;
> +}
> +
> +static int aspeed_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
> +			    const struct pwm_state *state)
> +{
> +	struct device *dev = chip->dev;
> +	struct aspeed_pwm_data *priv = aspeed_pwm_chip_to_data(chip);
> +	u32 duty_pt;
> +	u64 div_h, div_l, divisor, expect_period;
> +	bool clk_en;
> +
> +	expect_period = min(div64_u64(ULLONG_MAX, (u64)priv->clk_source),
> +			    state->period);
> +	dev_dbg(dev, "expect period: %lldns, duty_cycle: %lldns", expect_period,
> +		state->duty_cycle);
> +	/*
> +	 * Pick the smallest value for div_h so that div_l can be the biggest
> +	 * which results in a finer resolution near the target period value.
> +	 */
> +	divisor = (u64)NSEC_PER_SEC * (PWM_ASPEED_FIXED_PERIOD + 1) *
> +		  (FIELD_MAX(PWM_ASPEED_CTRL_CLK_DIV_L) + 1);
> +	div_h = order_base_2(DIV64_U64_ROUND_UP(priv->clk_source * expect_period, divisor));
> +	if (div_h > 0xf)
> +		div_h = 0xf;
> +
> +	divisor = ((u64)NSEC_PER_SEC * (PWM_ASPEED_FIXED_PERIOD + 1)) << div_h;
> +	div_l = div64_u64(priv->clk_source * expect_period, divisor);
> +
> +	if (div_l == 0)
> +		return -ERANGE;
> +
> +	div_l -= 1;
> +
> +	if (div_l > 255)
> +		div_l = 255;
> +
> +	dev_dbg(dev, "clk source: %ld div_h %lld, div_l : %lld\n",
> +		priv->clk_source, div_h, div_l);
> +	/* duty_pt = duty_cycle * (PERIOD + 1) / period */
> +	duty_pt = div64_u64(state->duty_cycle * priv->clk_source,
> +			    (u64)NSEC_PER_SEC * (div_l + 1) << div_h);
> +	dev_dbg(dev, "duty_cycle = %lld, duty_pt = %d\n", state->duty_cycle,
> +		duty_pt);
> +
> +	/*
> +	 * Fixed DUTY_CYCLE_PERIOD to its max value to get a
> +	 * fine-grained resolution for duty_cycle at the expense of a
> +	 * coarser period resolution.
> +	 */
> +	writel((readl(priv->base + PWM_ASPEED_DUTY_CYCLE) &
> +		~(PWM_ASPEED_DUTY_CYCLE_PERIOD)) |
> +		       FIELD_PREP(PWM_ASPEED_DUTY_CYCLE_PERIOD,
> +				  PWM_ASPEED_FIXED_PERIOD),
> +	       priv->base + PWM_ASPEED_DUTY_CYCLE);

This is completely unreadable. Use a temporary variable to split this
up.

> +
> +	if (duty_pt == 0) {
> +		/* emit inactive level and assert the duty counter reset */
> +		clk_en = 0;
> +	} else {
> +		clk_en = 1;
> +		if (duty_pt >= (PWM_ASPEED_FIXED_PERIOD + 1))
> +			duty_pt = 0;
> +		writel((readl(priv->base + PWM_ASPEED_DUTY_CYCLE) &
> +			~(PWM_ASPEED_DUTY_CYCLE_RISING_POINT |
> +			  PWM_ASPEED_DUTY_CYCLE_FALLING_POINT)) |
> +			       FIELD_PREP(PWM_ASPEED_DUTY_CYCLE_FALLING_POINT,
> +					  duty_pt),
> +		       priv->base + PWM_ASPEED_DUTY_CYCLE);

Same here ...

> +	}
> +
> +	writel((readl(priv->base + PWM_ASPEED_CTRL) &
> +		~(PWM_ASPEED_CTRL_CLK_DIV_H | PWM_ASPEED_CTRL_CLK_DIV_L |
> +		  PWM_ASPEED_CTRL_PIN_ENABLE | PWM_ASPEED_CTRL_CLK_ENABLE |
> +		  PWM_ASPEED_CTRL_INVERSE)) |
> +		       FIELD_PREP(PWM_ASPEED_CTRL_CLK_DIV_H, div_h) |
> +		       FIELD_PREP(PWM_ASPEED_CTRL_CLK_DIV_L, div_l) |
> +		       FIELD_PREP(PWM_ASPEED_CTRL_PIN_ENABLE, state->enabled) |
> +		       FIELD_PREP(PWM_ASPEED_CTRL_CLK_ENABLE, clk_en) |
> +		       FIELD_PREP(PWM_ASPEED_CTRL_INVERSE, state->polarity),
> +	       priv->base + PWM_ASPEED_CTRL);

... and here.

> +
> +	return 0;
> +}
> +
> +static const struct pwm_ops aspeed_pwm_ops = {
> +	.apply = aspeed_pwm_apply,
> +	.get_state = aspeed_pwm_get_state,
> +	.owner = THIS_MODULE,
> +};
> +
> +static void aspeed_pwm_reset_assert(void *data)
> +{
> +	struct reset_control *rst = data;
> +
> +	reset_control_assert(rst);
> +}
> +
> +static void aspeed_pwm_chip_remove(void *data)
> +{
> +	struct pwm_chip *chip = data;
> +
> +	pwmchip_remove(chip);
> +}

Erm... no.

> +static int aspeed_pwm_probe(struct platform_device *pdev)
> +{
> +	struct device *dev = &pdev->dev;
> +	int ret;
> +	struct aspeed_pwm_data *priv;
> +
> +	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
> +	if (!priv)
> +		return -ENOMEM;
> +
> +	priv->base = devm_platform_ioremap_resource(pdev, 0);
> +	if (IS_ERR(priv->base))
> +		return PTR_ERR(priv->base);
> +
> +	priv->clk = devm_clk_get_enabled(dev, NULL);
> +	if (IS_ERR(priv->clk))
> +		return dev_err_probe(dev, PTR_ERR(priv->clk),
> +				     "Couldn't get clock\n");
> +	priv->clk_source = clk_get_rate(priv->clk);
> +	priv->reset = devm_reset_control_get_shared(dev, NULL);
> +	if (IS_ERR(priv->reset))
> +		return dev_err_probe(dev, PTR_ERR(priv->reset),
> +				     "Couldn't get reset control\n");
> +
> +	ret = reset_control_deassert(priv->reset);
> +	if (ret)
> +		return dev_err_probe(dev, ret,
> +				     "Couldn't deassert reset control\n");
> +
> +	ret = devm_add_action_or_reset(dev, aspeed_pwm_reset_assert,
> +				       priv->reset);
> +	if (ret)
> +		return ret;

So now you need that extra callback that you defined earlier plus these
four lines of code in order to ...

> +
> +	priv->chip.dev = dev;
> +	priv->chip.ops = &aspeed_pwm_ops;
> +	priv->chip.npwm = 1;
> +
> +	ret = pwmchip_add(&priv->chip);
> +	if (ret < 0)
> +		return dev_err_probe(dev, ret, "Failed to add PWM chip\n");

... avoid calling reset_control_assert() once here? These device-
managed functions are meant to help simplify things, but there's nothing
complicated about it in this driver, so don't do it.

> +	ret = devm_add_action_or_reset(dev, aspeed_pwm_chip_remove,
> +				       &priv->chip);
> +	if (ret)
> +		return ret;

Why not just use the driver's .remove() callback? There's nothing here
that would fail afterwards, so this will effectively get called only
during driver removal, so might as well use the idiomatic infrastructure
that exists for this.

> +	return 0;
> +}
> +
> +static const struct of_device_id of_pwm_match_table[] = {

That's a suboptimal name. Use a driver-specific prefix.

> +	{
> +		.compatible = "aspeed,ast2600-pwm",
> +	},
> +	{},
> +};
> +MODULE_DEVICE_TABLE(of, of_pwm_match_table);
> +
> +static struct platform_driver aspeed_pwm_driver = {
> +	.probe = aspeed_pwm_probe,
> +	.driver	= {

There's another tab that doesn't belong here.

Thierry

--8BvSCPl3bohrvJz8
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmS2On4ACgkQ3SOs138+
s6GJaw/8CzusA4x0sby9uB5Ea+EzLgDiEtF7y4iwNQWdPC0akeKfZz5YZVYCerMw
yCCmkfgc9uRDxdXkhGxs756gbkAW96a7owoa2yD0jX06uC90wJ/jix1AUsgTdwom
z4C0fJybVLJ9UsMF86RILvtYLd1PsZebu4qMCO9Glbb6SZl/K0+Ah0eYOjWVS0y1
28ab1vPh0/Pm1fsVp9+/sY9Z0MDcSNijwA4F+iO5m/v917YNpMf/KtGKUPW6gxn7
Nku6NmWsqcvcK2a+gMU9vg7kpkcaz/z4rfCB9dH2QcaXtiV1XmFMHo5337wg+Hef
+GXG9J9e9XnTZlmjio1FINjD8+9FZxdpsYRFQ7Zo08aCW5bVltHNKyBgdzEe6gqJ
rUoNfjLQyKRXJp67MgZM1MMKPidizAQaQx/ZDmamkZrraOWgDeJzbRXed6Ff5JoK
PfEqg0yhY4RKRGVcE1ZIGbdY6M9i/MYlSsmtYnAcaj0DShMA44fE3TRQ3NxAhkKT
ds71L308FJOtI9XB7kbS8+ci4rK3BGILny6AlSjqblVWDo0TL/B5XfjTeiHTCCtx
NlOXka3ZKhDLvfCqc4TWpUOsBLvHoAC6MRRS8ivkd524fHj8Uimj4+jLbF1gfpmn
npeVgr7S0+aENuP6KipOo4WWJR0UgDBneDA7LmsFBidtEWrkb9c=
=4IaU
-----END PGP SIGNATURE-----

--8BvSCPl3bohrvJz8--
