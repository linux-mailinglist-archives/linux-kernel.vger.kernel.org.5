Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8CF527D74C9
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Oct 2023 21:51:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229817AbjJYTva (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Oct 2023 15:51:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229629AbjJYTv2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Oct 2023 15:51:28 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C86A793;
        Wed, 25 Oct 2023 12:51:25 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id d9443c01a7336-1cacde97002so442295ad.2;
        Wed, 25 Oct 2023 12:51:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698263485; x=1698868285; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=h4skl6LAxzxt7vvn+d14s3SbonWxrdRSyIZcTgX8V9s=;
        b=kXx2K1U9xRqKtov252hQytTGgjjXSc+KiPJiA/5oySFcGvZcoD8LhQCSzWHQ+Iyw1z
         T6hSm+19Cgm03h238Ep6yLc1KSXNc16MqOPQ1i7YOoPs+iL5y4lAfl4M+Tvt7f/9DT9h
         jmf/xDIWtj2WtXsC+aNs2hQ3jAA6TfP5NMOLNWaZ7SHPSV0R3ay+/SO4N2huPTXTTgN1
         ZM3KFX0lEyX6dngNcWM/KCPs53aTam/2k/yckkuA6p8O5GkSUtnjzrjWLk6wIV9FajvS
         sLf4xt0lCDMSvcU36qzRQU4ioFPOeDEjsZzyzz09UChIuhlAcU/cslgL2QjpLlQBVcPc
         uh4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698263485; x=1698868285;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=h4skl6LAxzxt7vvn+d14s3SbonWxrdRSyIZcTgX8V9s=;
        b=rBkr8z7gDFRX7TtRH57gQatlu3LSryPcB35WCr72fh8x+rA4PlCbBEBExTDQ/LFRM1
         CSDuBJ1YMdB/wD1PLDe2aQU7e/zOwmNH9jNa1NPUb0FNXr6BpQ6B+vM+UhWypkigJSes
         rQ6p27jRnL8KO63Y8pvo/mLo1lrjainq3mrun2pHK+moBkmbB1RzDoGTvZZFbPTjq32N
         MphYrzVoCnQLNCFZFROxmW+0TRmDAzd5NFiTAkKfuaGdWZnQ4ESuwQNFUnQDd4o8ncpb
         Lw01vooqz28jOspDGK7ubmLo3dWvFMLqN+8z3cCW88FU+X0Hc9SOmqmo3d6GazMd3jq2
         96JQ==
X-Gm-Message-State: AOJu0YxLHdvosZr/qxi6S0fJwJHiR9v6xX4z4gxOkHD3TK6R1r6wk4EX
        k5hHZFldMky9+u2eo7E6KCo=
X-Google-Smtp-Source: AGHT+IEeGv7fktEXpQ/O/MesYIOBZcw6uM5pcpXwIZxBVFgZ+J989QZQ6+nQqAFQLQaccsuE5j0a0w==
X-Received: by 2002:a17:902:e54e:b0:1ca:2cd0:2410 with SMTP id n14-20020a170902e54e00b001ca2cd02410mr17925448plf.53.1698263485168;
        Wed, 25 Oct 2023 12:51:25 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id v8-20020a170902b7c800b001c41e1e9ca7sm9468064plz.215.2023.10.25.12.51.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Oct 2023 12:51:24 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Wed, 25 Oct 2023 12:51:23 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Tomer Maimon <tmaimon77@gmail.com>
Cc:     jdelvare@suse.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, avifishman70@gmail.com,
        tali.perry1@gmail.com, joel@jms.id.au, andrew@codeconstruct.com.au,
        venture@google.com, yuenn@google.com, benjaminfair@google.com,
        j.neuschaefer@gmx.net, openbmc@lists.ozlabs.org,
        linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v2 2/2] hwmon: npcm750-pwm-fan: Add NPCM8xx support
Message-ID: <3c2a48d0-454a-4d40-ae8d-ff346d55d99d@roeck-us.net>
References: <20231018181925.1826042-1-tmaimon77@gmail.com>
 <20231018181925.1826042-3-tmaimon77@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231018181925.1826042-3-tmaimon77@gmail.com>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 18, 2023 at 09:19:25PM +0300, Tomer Maimon wrote:
> Adding Pulse Width Modulation (PWM) and fan tacho NPCM8xx support to
> NPCM PWM and fan tacho driver.
> NPCM8xx uses a different number of PWM devices.
> 
> As part of adding NPCM8XX support:
> - Add NPCM8xx specific compatible string.
> - Add data to handle architecture-specific PWM and fan tacho parameters.
> 
> Signed-off-by: Tomer Maimon <tmaimon77@gmail.com>
> ---
>  drivers/hwmon/npcm750-pwm-fan.c | 161 +++++++++++++++++++++++++++-----
>  1 file changed, 136 insertions(+), 25 deletions(-)
> 
> diff --git a/drivers/hwmon/npcm750-pwm-fan.c b/drivers/hwmon/npcm750-pwm-fan.c
> index 10ed3f4335d4..324de4482e71 100644
> --- a/drivers/hwmon/npcm750-pwm-fan.c
> +++ b/drivers/hwmon/npcm750-pwm-fan.c
> @@ -45,11 +45,6 @@
>  #define NPCM7XX_PWM_CTRL_CH2_EN_BIT		BIT(12)
>  #define NPCM7XX_PWM_CTRL_CH3_EN_BIT		BIT(16)
>  
> -/* Define the maximum PWM channel number */
> -#define NPCM7XX_PWM_MAX_CHN_NUM			8
> -#define NPCM7XX_PWM_MAX_CHN_NUM_IN_A_MODULE	4
> -#define NPCM7XX_PWM_MAX_MODULES                 2
> -
>  /* Define the Counter Register, value = 100 for match 100% */
>  #define NPCM7XX_PWM_COUNTER_DEFAULT_NUM		255
>  #define NPCM7XX_PWM_CMR_DEFAULT_NUM		255
> @@ -138,11 +133,9 @@
>  #define NPCM7XX_FAN_TCPCFG_CPASEL	BIT(0)
>  
>  /* FAN General Definition */
> -/* Define the maximum FAN channel number */
> -#define NPCM7XX_FAN_MAX_MODULE			8
> +/* Define the PWM and FAN in a module */
> +#define NPCM7XX_PWM_MAX_CHN_NUM_IN_A_MODULE	4
>  #define NPCM7XX_FAN_MAX_CHN_NUM_IN_A_MODULE	2
> -#define NPCM7XX_FAN_MAX_CHN_NUM			16
> -
>  /*
>   * Get Fan Tach Timeout (base on clock 214843.75Hz, 1 cnt = 4.654us)
>   * Timeout 94ms ~= 0x5000
> @@ -171,6 +164,15 @@
>  #define FAN_PREPARE_TO_GET_FIRST_CAPTURE	0x01
>  #define FAN_ENOUGH_SAMPLE			0x02
>  
> +struct npcm_hwmon_info {
> +	u32 pwm_max_modules;
> +	u32 pwm_max_ch;
> +	u32 fan_max_modules;
> +	u32 fan_max_ch;
> +	const struct hwmon_chip_info *hinfo;
> +	const char *name;
> +};
> +
>  struct npcm7xx_fan_dev {
>  	u8 fan_st_flg;
>  	u8 fan_pls_per_rev;
> @@ -195,15 +197,16 @@ struct npcm7xx_pwm_fan_data {
>  	unsigned long fan_clk_freq;
>  	struct clk *pwm_clk;
>  	struct clk *fan_clk;
> -	struct mutex pwm_lock[NPCM7XX_PWM_MAX_MODULES];
> -	spinlock_t fan_lock[NPCM7XX_FAN_MAX_MODULE];
> -	int fan_irq[NPCM7XX_FAN_MAX_MODULE];
> -	bool pwm_present[NPCM7XX_PWM_MAX_CHN_NUM];
> -	bool fan_present[NPCM7XX_FAN_MAX_CHN_NUM];

I do not see the point of making this dynamic.
Sure, there is an additional pwm channel on NPCM8xx,
so just add another entry and handle (enable/disable)
the additional channel with the is_visible function.
As written there is a lot of churn, and I am sure the code is
much larger than it was just to save a single pwm entry.

> +	struct mutex *pwm_lock;
> +	spinlock_t *fan_lock;
> +	int *fan_irq;
> +	bool *pwm_present;
> +	bool *fan_present;
>  	u32 input_clk_freq;
>  	struct timer_list fan_timer;
> -	struct npcm7xx_fan_dev fan_dev[NPCM7XX_FAN_MAX_CHN_NUM];
> -	struct npcm7xx_cooling_device *cdev[NPCM7XX_PWM_MAX_CHN_NUM];
> +	struct npcm7xx_fan_dev *fan_dev;
> +	struct npcm7xx_cooling_device **cdev;
> +	const struct npcm_hwmon_info *info;
>  	u8 fan_select;
>  };
>  
> @@ -333,7 +336,7 @@ static void npcm7xx_fan_polling(struct timer_list *t)
>  	 * Polling two module per one round,
>  	 * FAN01 & FAN89 / FAN23 & FAN1011 / FAN45 & FAN1213 / FAN67 & FAN1415
>  	 */
> -	for (i = data->fan_select; i < NPCM7XX_FAN_MAX_MODULE;
> +	for (i = data->fan_select; i < data->info->fan_max_modules;
>  	      i = i + 4) {
>  		/* clear the flag and reset the counter (TCNT) */
>  		iowrite8(NPCM7XX_FAN_TICLR_CLEAR_ALL,
> @@ -659,6 +662,40 @@ static const struct hwmon_channel_info * const npcm7xx_info[] = {
>  	NULL
>  };
>  
> +static const struct hwmon_channel_info * const npcm8xx_info[] = {
> +	HWMON_CHANNEL_INFO(pwm,
> +			   HWMON_PWM_INPUT,
> +			   HWMON_PWM_INPUT,
> +			   HWMON_PWM_INPUT,
> +			   HWMON_PWM_INPUT,
> +			   HWMON_PWM_INPUT,
> +			   HWMON_PWM_INPUT,
> +			   HWMON_PWM_INPUT,
> +			   HWMON_PWM_INPUT,
> +			   HWMON_PWM_INPUT,
> +			   HWMON_PWM_INPUT,
> +			   HWMON_PWM_INPUT,
> +			   HWMON_PWM_INPUT),
> +	HWMON_CHANNEL_INFO(fan,
> +			   HWMON_F_INPUT,
> +			   HWMON_F_INPUT,
> +			   HWMON_F_INPUT,
> +			   HWMON_F_INPUT,
> +			   HWMON_F_INPUT,
> +			   HWMON_F_INPUT,
> +			   HWMON_F_INPUT,
> +			   HWMON_F_INPUT,
> +			   HWMON_F_INPUT,
> +			   HWMON_F_INPUT,
> +			   HWMON_F_INPUT,
> +			   HWMON_F_INPUT,
> +			   HWMON_F_INPUT,
> +			   HWMON_F_INPUT,
> +			   HWMON_F_INPUT,
> +			   HWMON_F_INPUT),
> +	NULL
> +};

This should be handled with the is_visible() function, not with separate
data structures.

> +
>  static const struct hwmon_ops npcm7xx_hwmon_ops = {
>  	.is_visible = npcm7xx_is_visible,
>  	.read = npcm7xx_read,
> @@ -670,6 +707,29 @@ static const struct hwmon_chip_info npcm7xx_chip_info = {
>  	.info = npcm7xx_info,
>  };
>  
> +static const struct hwmon_chip_info npcm8xx_chip_info = {
> +	.ops = &npcm7xx_hwmon_ops,
> +	.info = npcm8xx_info,
> +};
> +
> +static const struct npcm_hwmon_info npxm7xx_hwmon_info = {
> +	.pwm_max_modules = 2,
> +	.pwm_max_ch = NPCM7XX_PWM_MAX_CHN_NUM_IN_A_MODULE * 2,
> +	.fan_max_modules = 8,
> +	.fan_max_ch = NPCM7XX_FAN_MAX_CHN_NUM_IN_A_MODULE * 8,
> +	.hinfo = &npcm7xx_chip_info,
> +	.name = "npcm7xx_pwm_fan",
> +};
> +
> +static const struct npcm_hwmon_info npxm8xx_hwmon_info = {
> +	.pwm_max_modules = 3,
> +	.pwm_max_ch = NPCM7XX_PWM_MAX_CHN_NUM_IN_A_MODULE * 3,
> +	.fan_max_modules = 8,
> +	.fan_max_ch = NPCM7XX_FAN_MAX_CHN_NUM_IN_A_MODULE * 8,

fan_max_modules and fan_max_ch do not change across chips, and
pwm_max_ch is always NPCM7XX_PWM_MAX_CHN_NUM_IN_A_MODULE times
the number of channels. This can all be dropped. Again, the only
real difference is the number of pwm channels, and that can be
handled in the _is_visible() function.

> +	.hinfo = &npcm8xx_chip_info,
> +	.name = "npcm8xx_pwm_fan",
> +};
> +
>  static u32 npcm7xx_pwm_init(struct npcm7xx_pwm_fan_data *data)
>  {
>  	int m, ch;
> @@ -693,7 +753,7 @@ static u32 npcm7xx_pwm_init(struct npcm7xx_pwm_fan_data *data)
>  	/* Setting PWM Prescale Register value register to both modules */
>  	prescale_val |= (prescale_val << NPCM7XX_PWM_PRESCALE_SHIFT_CH01);
>  
> -	for (m = 0; m < NPCM7XX_PWM_MAX_MODULES  ; m++) {
> +	for (m = 0; m < data->info->pwm_max_modules  ; m++) {
>  		iowrite32(prescale_val, NPCM7XX_PWM_REG_PR(data->pwm_base, m));
>  		iowrite32(NPCM7XX_PWM_PRESCALE2_DEFAULT,
>  			  NPCM7XX_PWM_REG_CSR(data->pwm_base, m));
> @@ -716,7 +776,7 @@ static void npcm7xx_fan_init(struct npcm7xx_pwm_fan_data *data)
>  	int i;
>  	u32 apb_clk_freq;
>  
> -	for (md = 0; md < NPCM7XX_FAN_MAX_MODULE; md++) {
> +	for (md = 0; md < data->info->fan_max_modules; md++) {
>  		/* stop FAN0~7 clock */
>  		iowrite8(NPCM7XX_FAN_TCKC_CLKX_NONE,
>  			 NPCM7XX_FAN_REG_TCKC(data->fan_base, md));
> @@ -905,6 +965,49 @@ static int npcm7xx_en_pwm_fan(struct device *dev,
>  	return 0;
>  }
>  
> +static int npcm_pwm_fan_alloc_data(struct device *dev,
> +				   struct npcm7xx_pwm_fan_data *data)
> +{
> +	data->pwm_lock = devm_kcalloc(dev, data->info->pwm_max_modules,
> +				      sizeof(*data->pwm_lock), GFP_KERNEL);
> +	if (!data->pwm_lock)
> +		return -ENOMEM;
> +
> +	data->fan_lock = devm_kcalloc(dev, data->info->fan_max_modules,
> +				      sizeof(*data->fan_lock), GFP_KERNEL);
> +	if (!data->fan_lock)
> +		return -ENOMEM;
> +
> +	data->fan_irq = devm_kcalloc(dev, data->info->fan_max_modules,
> +				     sizeof(*data->fan_irq), GFP_KERNEL);
> +	if (!data->fan_irq)
> +		return -ENOMEM;
> +
> +	data->pwm_present = devm_kcalloc(dev, data->info->pwm_max_ch,
> +					 sizeof(*data->pwm_present),
> +					 GFP_KERNEL);
> +	if (!data->pwm_present)
> +		return -ENOMEM;
> +
> +	data->fan_present = devm_kcalloc(dev, data->info->fan_max_ch,
> +					 sizeof(*data->fan_present),
> +					 GFP_KERNEL);
> +	if (!data->fan_present)
> +		return -ENOMEM;
> +
> +	data->fan_dev = devm_kcalloc(dev, data->info->fan_max_ch,
> +				     sizeof(*data->fan_dev), GFP_KERNEL);
> +	if (!data->fan_dev)
> +		return -ENOMEM;
> +
> +	data->cdev = devm_kcalloc(dev, data->info->pwm_max_ch,
> +				  sizeof(*data->cdev), GFP_KERNEL);
> +	if (!data->cdev)
> +		return -ENOMEM;
> +
> +	return 0;
> +}
> +
>  static int npcm7xx_pwm_fan_probe(struct platform_device *pdev)
>  {
>  	struct device *dev = &pdev->dev;
> @@ -923,6 +1026,13 @@ static int npcm7xx_pwm_fan_probe(struct platform_device *pdev)
>  	if (!data)
>  		return -ENOMEM;
>  
> +	data->info = device_get_match_data(dev);
> +	if (!data->info)
> +		return -EINVAL;
> +
> +	if (npcm_pwm_fan_alloc_data(dev, data))
> +		return -ENOMEM;
> +
>  	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "pwm");
>  	if (!res) {
>  		dev_err(dev, "pwm resource not found\n");
> @@ -960,10 +1070,10 @@ static int npcm7xx_pwm_fan_probe(struct platform_device *pdev)
>  	output_freq = npcm7xx_pwm_init(data);
>  	npcm7xx_fan_init(data);
>  
> -	for (cnt = 0; cnt < NPCM7XX_PWM_MAX_MODULES  ; cnt++)
> +	for (cnt = 0; cnt < data->info->pwm_max_modules  ; cnt++)
>  		mutex_init(&data->pwm_lock[cnt]);
>  
> -	for (i = 0; i < NPCM7XX_FAN_MAX_MODULE; i++) {
> +	for (i = 0; i < data->info->fan_max_modules; i++) {
>  		spin_lock_init(&data->fan_lock[i]);
>  
>  		data->fan_irq[i] = platform_get_irq(pdev, i);
> @@ -988,15 +1098,15 @@ static int npcm7xx_pwm_fan_probe(struct platform_device *pdev)
>  		}
>  	}
>  
> -	hwmon = devm_hwmon_device_register_with_info(dev, "npcm7xx_pwm_fan",
> -						     data, &npcm7xx_chip_info,
> +	hwmon = devm_hwmon_device_register_with_info(dev, data->info->name,
> +						     data, data->info->hinfo,
>  						     NULL);
>  	if (IS_ERR(hwmon)) {
>  		dev_err(dev, "unable to register hwmon device\n");
>  		return PTR_ERR(hwmon);
>  	}
>  
> -	for (i = 0; i < NPCM7XX_FAN_MAX_CHN_NUM; i++) {
> +	for (i = 0; i < data->info->fan_max_ch; i++) {
>  		if (data->fan_present[i]) {
>  			/* fan timer initialization */
>  			data->fan_timer.expires = jiffies +
> @@ -1015,7 +1125,8 @@ static int npcm7xx_pwm_fan_probe(struct platform_device *pdev)
>  }
>  
>  static const struct of_device_id of_pwm_fan_match_table[] = {
> -	{ .compatible = "nuvoton,npcm750-pwm-fan", },
> +	{ .compatible = "nuvoton,npcm750-pwm-fan", .data = &npxm7xx_hwmon_info},
> +	{ .compatible = "nuvoton,npcm845-pwm-fan", .data = &npxm8xx_hwmon_info},
>  	{},
>  };
>  MODULE_DEVICE_TABLE(of, of_pwm_fan_match_table);
