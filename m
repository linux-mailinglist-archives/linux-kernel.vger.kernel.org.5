Return-Path: <linux-kernel+bounces-23430-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id ADD3582ACA6
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 11:57:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 631C91F226BE
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 10:57:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C953914F9C;
	Thu, 11 Jan 2024 10:54:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tq7X+Qxj"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 180C31773B;
	Thu, 11 Jan 2024 10:54:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1867BC433C7;
	Thu, 11 Jan 2024 10:54:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704970471;
	bh=F45rGXqUG2uAkO0sp6Ly0dJuN2iXFQzvSxj7Y6KeR94=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=tq7X+QxjA7bK4hgFg/yRiSGes3CiIQLvTBm4H5I9KTPtRbxND+zNAKYU0PLj7Ap1R
	 CvRC6cKJRCwHqizTqFnswDwJVOcF/aAkT4AHOM9uGrTaUNqYiY7B5X5RfTmZKyyqFh
	 i7iOvGxQDyaOHxClroicbwMDQ9bKSqjsaieL++1zqqvk6zHIHCP7t8WlIVbT7nU224
	 usYwsP/+8yu7cqzB940YwaMlKyYIF1XsLSz3YbrCkVwJKH4tlMBSztbMW65Sh33bES
	 fQ9UOyYqCeaHtc/zShPXFtojLHtL2oBy9drYTpgquaNAZPU2QhQk7F0WZFzn3zxrVa
	 hacLHu73nSflg==
Date: Thu, 11 Jan 2024 10:54:26 +0000
From: Lee Jones <lee@kernel.org>
To: Karel Balej <karelb@gimli.ms.mff.cuni.cz>
Cc: Karel Balej <balejk@matfyz.cz>, Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Duje =?utf-8?Q?Mihanovi=C4=87?= <duje.mihanovic@skole.hr>,
	~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org
Subject: Re: [RFC PATCH 1/5] mfd: 88pm88x: differences with respect to the
 PMIC RFC series
Message-ID: <20240111105426.GA1678981@google.com>
References: <20231228100208.2932-1-karelb@gimli.ms.mff.cuni.cz>
 <20231228100208.2932-2-karelb@gimli.ms.mff.cuni.cz>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231228100208.2932-2-karelb@gimli.ms.mff.cuni.cz>

The subject needs work.  Please tell us what the patches is doing.

On Thu, 28 Dec 2023, Karel Balej wrote:

> From: Karel Balej <balejk@matfyz.cz>

A full an complete commit message is a must.

> Signed-off-by: Karel Balej <balejk@matfyz.cz>
> ---
>  drivers/mfd/88pm88x.c       | 14 ++++++++------
>  include/linux/mfd/88pm88x.h |  2 ++
>  2 files changed, 10 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/mfd/88pm88x.c b/drivers/mfd/88pm88x.c
> index 5db6c65b667d..3424d88a58f6 100644
> --- a/drivers/mfd/88pm88x.c
> +++ b/drivers/mfd/88pm88x.c
> @@ -57,16 +57,16 @@ static struct reg_sequence pm886_presets[] = {
>  	REG_SEQ0(PM88X_REG_BK_OSC_CTRL3, 0xc0),
>  };
>  
> -static struct resource onkey_resources[] = {
> +static struct resource pm88x_onkey_resources[] = {
>  	DEFINE_RES_IRQ_NAMED(PM88X_IRQ_ONKEY, "88pm88x-onkey"),
>  };
>  
> -static struct mfd_cell pm88x_devs[] = {
> +static struct mfd_cell pm886_devs[] = {
>  	{
>  		.name = "88pm88x-onkey",
> -		.num_resources = ARRAY_SIZE(onkey_resources),
> -		.resources = onkey_resources,
> -		.id = -1,
> +		.of_compatible = "marvell,88pm88x-onkey",
> +		.num_resources = ARRAY_SIZE(pm88x_onkey_resources),
> +		.resources = pm88x_onkey_resources,
>  	},
>  };
>  
> @@ -74,6 +74,8 @@ static struct pm88x_data pm886_a1_data = {
>  	.whoami = PM886_A1_WHOAMI,
>  	.presets = pm886_presets,
>  	.num_presets = ARRAY_SIZE(pm886_presets),
> +	.devs = pm886_devs,
> +	.num_devs = ARRAY_SIZE(pm886_devs),
>  };
>  
>  static const struct regmap_config pm88x_i2c_regmap = {
> @@ -157,7 +159,7 @@ static int pm88x_probe(struct i2c_client *client)
>  	if (ret)
>  		return ret;
>  
> -	ret = devm_mfd_add_devices(&client->dev, 0, pm88x_devs, ARRAY_SIZE(pm88x_devs),
> +	ret = devm_mfd_add_devices(&client->dev, 0, chip->data->devs, chip->data->num_devs,
>  			NULL, 0, regmap_irq_get_domain(chip->irq_data));
>  	if (ret) {
>  		dev_err(&client->dev, "Failed to add devices: %d\n", ret);
> diff --git a/include/linux/mfd/88pm88x.h b/include/linux/mfd/88pm88x.h
> index a34c57447827..9a335f6b9c07 100644
> --- a/include/linux/mfd/88pm88x.h
> +++ b/include/linux/mfd/88pm88x.h
> @@ -49,6 +49,8 @@ struct pm88x_data {
>  	unsigned int whoami;
>  	struct reg_sequence *presets;
>  	unsigned int num_presets;
> +	struct mfd_cell *devs;
> +	unsigned int num_devs;

Why are you adding extra abstraction?

>  };
>  
>  struct pm88x_chip {
> -- 
> 2.43.0
> 

-- 
Lee Jones [李琼斯]

