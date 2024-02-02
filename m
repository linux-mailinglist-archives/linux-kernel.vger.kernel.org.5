Return-Path: <linux-kernel+bounces-49849-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E5C5984706F
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 13:36:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 246811C220DA
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 12:36:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44E6946A1;
	Fri,  2 Feb 2024 12:36:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="el8s2P6G"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80D01440D;
	Fri,  2 Feb 2024 12:36:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706877391; cv=none; b=N3+R/LakMHl7EI2YcVD48Xlvyjqwf5uO4nTC6dsVUWwITPQRq0CnENg06AMoWDT2swLTqmdfs1/IdoXgm4DZSVBTZZcnbxzjpFIbP/1B5MafnG6rtPvbSG+TYVXNnhL4pe9SefkE3tRVHQCLBl3O/gKy6AjmpPDH8bldjKHtloI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706877391; c=relaxed/simple;
	bh=q/KO4jm+YDiH8ZcInHTyOHmbDAWtJsTjVCRKGNBJj3o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=c42mehfs/WiKonOhAIMMYRtPoWPKPnZD9hpdqhRjmvMXEdFQtHdjwZleONXPkda7LZS1TxVS+VSDzqfzVvCsrhh4Oxnxlfe9GTclTsn7J6bk+YB/VPHfuTG5B0XE5BtFurFvdB+ZOoeEivGwTymW/s/6T/rr3zYk+TURcvrIqns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=el8s2P6G; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 413BDC433F1;
	Fri,  2 Feb 2024 12:36:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706877390;
	bh=q/KO4jm+YDiH8ZcInHTyOHmbDAWtJsTjVCRKGNBJj3o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=el8s2P6Gg/Ue1KOEpYwFV88dLH/7FZLDQQ1yUMZif19B5VSf/Vd1DSE6zWFaBtQQx
	 9xrD56k7SGqRvstN2b6Z4XCS2VpoAOHwTBovc3Oif0dV61rYPmDkd1Ccw24yZPiRIk
	 DqQYuGOr9CNQ+w8qCAcINiu6Ty8WFXxRfe6R7PCQ+FfRD/5AyqRmsQU4RL3BuA6+Jc
	 MjMX21x8jMy/Ue1tbGjnmRsupKZFl+FoSabCYwLhDfq1ejd8tlHwSaRhsMLraJPnnC
	 Lg9tqVqnQQLRaX1nqACWzh6cz8pDA6CzXu4Se9tr857OAYgSvtljkIh65wEZXjEgzv
	 EjhqiF3W+XxXQ==
Date: Fri, 2 Feb 2024 12:36:25 +0000
From: Lee Jones <lee@kernel.org>
To: Amitesh Singh <singh.amitesh@gmail.com>
Cc: pavel@ucw.cz, linux-leds@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] leds/pca963x: implement power management
Message-ID: <20240202123625.GB1379817@google.com>
References: <20240129111505.196068-1-singh.amitesh@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240129111505.196068-1-singh.amitesh@gmail.com>

Please use the following and observe the correct subject format:

`git log --oneline --no-merges -- drivers/leds`

On Mon, 29 Jan 2024, Amitesh Singh wrote:

> This implements power management for pca9633

44 chars is an odd place to '\n'.

This will give you a good idea of what is generally accepted:

`git log`

> which enables device sleep and resume on system-wide
> sleep/hibernation
> 
> Signed-off-by: Amitesh Singh <singh.amitesh@gmail.com>
> ---
>  drivers/leds/leds-pca963x.c | 30 ++++++++++++++++++++++++++++++
>  1 file changed, 30 insertions(+)
> 
> diff --git a/drivers/leds/leds-pca963x.c b/drivers/leds/leds-pca963x.c
> index 47223c850e4b..227f24ba2ca2 100644
> --- a/drivers/leds/leds-pca963x.c
> +++ b/drivers/leds/leds-pca963x.c
> @@ -39,6 +39,7 @@
>  #define PCA963X_LED_PWM		0x2	/* Controlled through PWM */
>  #define PCA963X_LED_GRP_PWM	0x3	/* Controlled through PWM/GRPPWM */
>  
> +#define PCA963X_MODE1_SLEEP     0x04    /* Normal mode or Low Power mode, oscillator off */

Tabs first, then line up with spaces.

>  #define PCA963X_MODE2_OUTDRV	0x04	/* Open-drain or totem pole */
>  #define PCA963X_MODE2_INVRT	0x10	/* Normal or inverted direction */
>  #define PCA963X_MODE2_DMBLNK	0x20	/* Enable blinking */
> @@ -380,6 +381,34 @@ static int pca963x_register_leds(struct i2c_client *client,
>  	return ret;
>  }
>  
> +#ifdef CONFIG_PM_SLEEP
> +static int pca963x_suspend(struct device *dev)
> +{
> +	struct pca963x *chip = dev_get_drvdata(dev);
> +	u8 reg;
> +
> +	reg = i2c_smbus_read_byte_data(chip->client, PCA963X_MODE1);
> +	reg = reg | BIT(PCA963X_MODE1_SLEEP);
> +	i2c_smbus_write_byte_data(chip->client, PCA963X_MODE1, reg);
> +
> +	return 0;
> +}
> +
> +static int pca963x_resume(struct device *dev)
> +{
> +	struct pca963x *chip = dev_get_drvdata(dev);
> +	u8 reg;
> +
> +	reg = i2c_smbus_read_byte_data(chip->client, PCA963X_MODE1);
> +	reg = reg & ~BIT(PCA963X_MODE1_SLEEP);
> +	i2c_smbus_write_byte_data(chip->client, PCA963X_MODE1, reg);
> +
> +	return 0;
> +}
> +#endif
> +
> +static SIMPLE_DEV_PM_OPS(pca963x_pm, pca963x_suspend, pca963x_resume);

Can you use DEFINE_SIMPLE_DEV_PM_OPS() and remove the #ifdefs?

>  static const struct of_device_id of_pca963x_match[] = {
>  	{ .compatible = "nxp,pca9632", },
>  	{ .compatible = "nxp,pca9633", },
> @@ -430,6 +459,7 @@ static struct i2c_driver pca963x_driver = {
>  	.driver = {
>  		.name	= "leds-pca963x",
>  		.of_match_table = of_pca963x_match,
> +		.pm = &pca963x_pm

If so, you'll also need pm_sleep_ptr() here.

See these commits for examples:

02313a90095fb ("mfd: tc3589x: Remove #ifdef guards for PM related functions")
f7f292fe819b6 ("mfd: stmpe: Remove #ifdef guards for PM related functions")
4d8a6ae23af64 ("mfd: stmfx: Remove #ifdef guards for PM related functions")
69bbab91835ac ("mfd: sprd-sc27xx: Remove #ifdef guards for PM related functions")
4060c6e50a77a ("mfd: motorola-cpcap: Remove #ifdef guards for PM related functions")
ef72ed420ea16 ("mfd: max77686: Remove #ifdef guards for PM related functions")
8a8d0485f5791 ("mfd: max14577: Remove #ifdef guards for PM related functions")
50d3ac7d3ce47 ("mfd: arizona: Remove #ifdef guards for PM related functions")
daf7ea817fda9 ("mfd: t7l66xb: Remove #ifdef guards for PM related functions")
9b990dc9f09fc ("mfd: max77620: Remove #ifdef guards for PM related functions")
9dd3baecebc3d ("mfd: wm8994: Remove #ifdef guards for PM related functions")
d115e88c29754 ("mfd: tps6586x: Remove #ifdef guards for PM related functions")
2d81212cb0c81 ("mfd: tc6387xb: Remove #ifdef guards for PM related functions")
3833239b5ba22 ("mfd: sm501: Remove #ifdef guards for PM related functions")
270a7c3eba574 ("mfd: sec: Remove #ifdef guards for PM related functions")
ff84723e5291c ("mfd: mcp-sa11x0: Remove #ifdef guards for PM related functions")
fdefee3073bc6 ("mfd: 88pm860x: Remove #ifdef guards for PM related functions")
03bf96cf8ecbd ("mfd: ucb1x00: Remove #ifdef guards for PM related functions")
e4b9a17c99d0b ("mfd: stpmic1: Remove #ifdef guards for PM related functions")
2662b90fd58b8 ("mfd: rc5t583-irq: Remove #ifdef guards for PM related functions")
245cb473e5388 ("mfd: pcf50633: Remove #ifdef guards for PM related functions")
e1243e0d72185 ("mfd: mt6397-irq: Remove #ifdef guards for PM related functions")
52c9d7193ba43 ("mfd: max8925-i2c: Remove #ifdef guards for PM related functions")
5745a90a930c8 ("mfd: adp5520: Remove #ifdef guards for PM related functions")
dce97f81fea6f ("mfd: aat2870: Remove #ifdef guards for PM related functions")
19755a0acb883 ("mfd: 88pm80x: Remove #ifdef guards for PM related functions")

>  	},
>  	.probe = pca963x_probe,
>  	.id_table = pca963x_id,
> -- 
> 2.43.0
> 

-- 
Lee Jones [李琼斯]

