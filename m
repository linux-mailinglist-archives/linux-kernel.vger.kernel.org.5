Return-Path: <linux-kernel+bounces-141372-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A63D8A1D61
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 20:09:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 050022887F3
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 18:09:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 900271D6379;
	Thu, 11 Apr 2024 17:03:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P5iM75U/"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE0771D42B0;
	Thu, 11 Apr 2024 17:03:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712855031; cv=none; b=a3MGateQUzF5OqDeIFJTo1WfbuXd12UWadkk4dbcHpfy92wrRaiW/2kz6n9PQghg1Pj0MH1uUzoPIffu2LlQoyDR/mdZBk11fh2qPVYcXkUpZ7SBXmZvcBjuaa8NYElSZ2fa79QU3uWTEwRpm62I8sizLzjwZK+7hfsu3XBuxBM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712855031; c=relaxed/simple;
	bh=lPpn/1lYAEX/RQWD3CCHP7J3qXj3FuqzX1qZWbKaxOg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iGT3btVJNOqc70s2iyC3yLD3pakyUxUgZAnuDFspaqTk3lPuPgYgQzlaUvzjaWVyOGB0p1EXgfCHwJM5oY++wVLrd3r/8H5uu0hl5Mz116goASDeVQv9rIw8zhTMyGPWdUvOu9MeoBdGaPCJdMNYevVUqm9Vlxe7YVGgtJSd71E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P5iM75U/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0F8DC072AA;
	Thu, 11 Apr 2024 17:03:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712855031;
	bh=lPpn/1lYAEX/RQWD3CCHP7J3qXj3FuqzX1qZWbKaxOg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=P5iM75U/t7PYTCi8TtGpwLMD5ieVL5+YT9KZ46/LNzwwR/aSgh9Ar/RljmXmBIbRx
	 QJF+cxKGcEZ8+6XvtS9lVsF0mWec4sC/zIzwY+Jp/UqoM7wDe1UTckiN/i0xCnd53F
	 nwEpmQwFloWIRagKAy82womP1csk32tyu3WZ+EhQ3csrBQxD1JkN8ACQUuYCRMWx8T
	 LOdUXHGCT9RH68HLn74m5fmPCuciByXi0Iu+3CczesHPrFrHNn9j2OB5NZ7L/586hO
	 kfZsNw1fVw99FffvbS9aVrCE8fQtHnDo+c8/yHBApzPtpCB4ltNXG0xf9WhYs5w9eS
	 d7oOYz+1dsWsQ==
Date: Thu, 11 Apr 2024 18:03:44 +0100
From: Lee Jones <lee@kernel.org>
To: Bhargav Raviprakash <bhargav.r@ltts.com>
Cc: linux-kernel@vger.kernel.org, m.nirmaladevi@ltts.com,
	robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org, jpanis@baylibre.com,
	devicetree@vger.kernel.org, arnd@arndb.de,
	gregkh@linuxfoundation.org, lgirdwood@gmail.com, broonie@kernel.org,
	linus.walleij@linaro.org, linux-gpio@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, nm@ti.com, vigneshr@ti.com,
	kristo@kernel.org, eblanc@baylibre.com
Subject: Re: [PATCH v6 03/11] mfd: tps6594: add regmap config in match data
Message-ID: <20240411170344.GK2399047@google.com>
References: <20240408124047.191895-1-bhargav.r@ltts.com>
 <20240408124047.191895-4-bhargav.r@ltts.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240408124047.191895-4-bhargav.r@ltts.com>

On Mon, 08 Apr 2024, Bhargav Raviprakash wrote:

> Introduces a new struct tps6594_match_data. This struct holds fields for
> chip id and regmap config. Using this struct in of_device_id data field.
> This helps in adding support for TPS65224 PMIC.
> 
> Signed-off-by: Bhargav Raviprakash <bhargav.r@ltts.com>
> Acked-by: Julien Panis <jpanis@baylibre.com>
> ---
>  drivers/mfd/tps6594-i2c.c   | 24 ++++++++++++++++--------
>  drivers/mfd/tps6594-spi.c   | 24 ++++++++++++++++--------
>  include/linux/mfd/tps6594.h | 11 +++++++++++
>  3 files changed, 43 insertions(+), 16 deletions(-)
> 
> diff --git a/drivers/mfd/tps6594-i2c.c b/drivers/mfd/tps6594-i2c.c
> index c125b474b..9e2ed48b7 100644
> --- a/drivers/mfd/tps6594-i2c.c
> +++ b/drivers/mfd/tps6594-i2c.c
> @@ -192,10 +192,16 @@ static const struct regmap_config tps6594_i2c_regmap_config = {
>  	.write = tps6594_i2c_write,
>  };
>  
> +static const struct tps6594_match_data match_data[] = {
> +	[TPS6594] = {TPS6594, &tps6594_i2c_regmap_config},
> +	[TPS6593] = {TPS6593, &tps6594_i2c_regmap_config},
> +	[LP8764] = {LP8764, &tps6594_i2c_regmap_config},

Nit: There should be spaces after the '{' and before the '}'.

> +};
> +
>  static const struct of_device_id tps6594_i2c_of_match_table[] = {
> -	{ .compatible = "ti,tps6594-q1", .data = (void *)TPS6594, },
> -	{ .compatible = "ti,tps6593-q1", .data = (void *)TPS6593, },
> -	{ .compatible = "ti,lp8764-q1",  .data = (void *)LP8764,  },
> +	{ .compatible = "ti,tps6594-q1", .data = &match_data[TPS6594], },
> +	{ .compatible = "ti,tps6593-q1", .data = &match_data[TPS6593], },
> +	{ .compatible = "ti,lp8764-q1",  .data = &match_data[LP8764], },

Not keen on this.  Why do you pass the regmap data through here and
leave everything else to be matched on device ID?  It would be better to
keep passing the device ID through and match everything off of that.


-- 
Lee Jones [李琼斯]

