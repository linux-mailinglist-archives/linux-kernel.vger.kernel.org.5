Return-Path: <linux-kernel+bounces-38647-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5891E83C3A3
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 14:29:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0D8201F25E06
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 13:29:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52EE05024E;
	Thu, 25 Jan 2024 13:29:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hmoiqiCH"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 969554F89D;
	Thu, 25 Jan 2024 13:29:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706189372; cv=none; b=uYigFl5F/5I95hposg4wTuFHsAzZG2z77rSl7fd4TJ8xqjbeVX4embveRd5/zvDevZIg4sAZMwYbeQD4RbsS9mhfCsxlvqvT3xkvfCGDx6XLn5Gp2W9tPedWK3YQ3ZI3jHszaIPsvAL2g9Wu1m6sGpyzc0dM+yeVgnocPv/6fvM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706189372; c=relaxed/simple;
	bh=2aP1hL6O4sgcfosAPQiaW//ddZstCirad6SDpyyNrRo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=B0w9fYwQlF53HWPUcQ3R09iMw+2kno1Sh+n408H4+OFIJmuGWmfvIRWCMJxXzT+/oJ1wK5Z6ojlQgiy25VTMG2dbEAyrMRv/ZJxA1Q9S0oUApBHQzsbKgeWqmd6vnPjeV47bvsmjRhQ7aCpOrCfIbD60NHNSe9g9iMQoGDgYtUE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hmoiqiCH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F21CEC433C7;
	Thu, 25 Jan 2024 13:29:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706189372;
	bh=2aP1hL6O4sgcfosAPQiaW//ddZstCirad6SDpyyNrRo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hmoiqiCHJn21mmIhBP2zRzEiNbvSSiKbtsYZF8au9g7t3KiHUHG7pHJUNbgzHI9yf
	 4/qa46etGHHl0udUB7D69O9vdZEAEboHh6WcPvR3zJOJhm7CvJ6sHceJdm6CpaXa29
	 aJRUnsBCgy2HajYkn+GG/56ngGhk6M/rMmhTrNq2vZDDqo8nz0knIHj511RJsK7s+D
	 M9QS207LRVmlLA+99pnQlAAcUtrtd7LLiFjvrCrEkqg734e4r82UEoIMktZJg4AW5T
	 W0AdsfaChln8BDoneEC40xqbqLGr9LbU5r0KCzfKI3bYIq/ofFDj//BshyIxHmqs/X
	 FHNt0l6PMTI8Q==
Date: Thu, 25 Jan 2024 13:29:28 +0000
From: Lee Jones <lee@kernel.org>
To: Amitesh Singh <singh.amitesh@gmail.com>
Cc: pavel@ucw.cz, linux-leds@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] leds/pca963x: implement power management
Message-ID: <20240125132928.GI74950@google.com>
References: <20240116072457.383438-1-singh.amitesh@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240116072457.383438-1-singh.amitesh@gmail.com>

On Tue, 16 Jan 2024, Amitesh Singh wrote:

> This implements power management in upstream driver

This *is* the upstream driver.  No need to mention that.

> for pca9633 which enables device sleep and resume
> on system-wide sleep/hibernation
> 
> Signed-off-by: Amitesh Singh <singh.amitesh@gmail.com>
> ---
>  drivers/leds/leds-pca963x.c | 38 +++++++++++++++++++++++++++++++++++++
>  1 file changed, 38 insertions(+)
> 
> diff --git a/drivers/leds/leds-pca963x.c b/drivers/leds/leds-pca963x.c
> index 47223c850e4b..2474e40d8479 100644
> --- a/drivers/leds/leds-pca963x.c
> +++ b/drivers/leds/leds-pca963x.c
> @@ -39,6 +39,7 @@
>  #define PCA963X_LED_PWM		0x2	/* Controlled through PWM */
>  #define PCA963X_LED_GRP_PWM	0x3	/* Controlled through PWM/GRPPWM */
>  
> +#define PCA963X_MODE1_SLEEP     0x04    /* Normal mode or Low Power mode, oscillator off */
>  #define PCA963X_MODE2_OUTDRV	0x04	/* Open-drain or totem pole */
>  #define PCA963X_MODE2_INVRT	0x10	/* Normal or inverted direction */
>  #define PCA963X_MODE2_DMBLNK	0x20	/* Enable blinking */
> @@ -380,6 +381,42 @@ static int pca963x_register_leds(struct i2c_client *client,
>  	return ret;
>  }
>  
> +#ifdef CONFIG_PM_SLEEP
> +static int pca963x_suspend(struct device *dev)
> +{
> +	struct pca963x *chip;
> +	u8 reg;
> +
> +	chip = dev_get_drvdata(dev);

Do the assignment during declaration.

> +	reg = i2c_smbus_read_byte_data(chip->client, PCA963X_MODE1);
> +	reg = reg | (1 << PCA963X_MODE1_SLEEP);

BIT()

> +	i2c_smbus_write_byte_data(chip->client, PCA963X_MODE1, reg);
> +
> +	return 0;
> +}
> +
> +static int pca963x_resume(struct device *dev)
> +{
> +	struct pca963x *chip;
> +	u8 reg;
> +
> +	chip = dev_get_drvdata(dev);

As above.

> +	reg = i2c_smbus_read_byte_data(chip->client, PCA963X_MODE1);
> +	reg = reg & ~(1 << PCA963X_MODE1_SLEEP);

As above.

> +	i2c_smbus_write_byte_data(chip->client, PCA963X_MODE1, reg);
> +
> +	return 0;
> +}
> +#endif
> +
> +static const struct dev_pm_ops pca963x_pmops = {
> +	SET_SYSTEM_SLEEP_PM_OPS(pca963x_suspend, pca963x_resume)
> +};
> +

Remove this line.

> +static SIMPLE_DEV_PM_OPS(pca963x_pm, pca963x_suspend, pca963x_resume);
> +
>  static const struct of_device_id of_pca963x_match[] = {
>  	{ .compatible = "nxp,pca9632", },
>  	{ .compatible = "nxp,pca9633", },
> @@ -430,6 +467,7 @@ static struct i2c_driver pca963x_driver = {
>  	.driver = {
>  		.name	= "leds-pca963x",
>  		.of_match_table = of_pca963x_match,
> +		.pm = &pca963x_pmops
>  	},
>  	.probe = pca963x_probe,
>  	.id_table = pca963x_id,
> -- 
> 2.43.0
> 

-- 
Lee Jones [李琼斯]

