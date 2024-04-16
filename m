Return-Path: <linux-kernel+bounces-146784-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F00578A6ADC
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 14:25:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2C5D41C20C61
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 12:25:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7A8312B143;
	Tue, 16 Apr 2024 12:25:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dLELNjgk"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32FFC12A172;
	Tue, 16 Apr 2024 12:25:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713270312; cv=none; b=Qe5J1eNSOSqBwscL+8IEhnl9NCKmewC+awJiclVuDx+xUa7UK4Pf/20YC0bxlccLdECXO9NmAhbCu0zsDORi/aZu7/GwDKImMx5UWz0m0FE9mfRmJZYyP0ghzgTHp32a3SsGbYQXRNfpNOLNR5wkDasidj+Vz8Vpr4QxkO4EaiM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713270312; c=relaxed/simple;
	bh=SCges8dT7+vStvKdwldW6puBln6FxrIx8NsJAHgA4dU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tNYm8ufJuJN+AH3w4DrNDr89FfVakeI3R/dvZRa07QZNzhAWpf4gquWKLi/ir7xdscGggddLZjxtqCWo8z9vyl8Y4VOqSrAovEjbHyeI2/pkzi0O6kFa9s5yiWKLFonfPRpS11iPwTpQjFwnWCVnEEgPzxGF2TbpjBbhB8lR0Yw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dLELNjgk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94C9BC113CE;
	Tue, 16 Apr 2024 12:25:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713270311;
	bh=SCges8dT7+vStvKdwldW6puBln6FxrIx8NsJAHgA4dU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dLELNjgkJ8uBxjq5d2HVAG08umXZz/asximy7u3HShHBTFfgOWEGJQWA622y7ObRc
	 zwYF9hPOT7NdQVDUdTZwnZ1xUGEDJTt9WeKDhPBm2C+kJz7+p+7x2pc/bVZZfhh39w
	 sodPEU/xXGMH/4wjk2TIC360/+5OSZjMVgcQSDXQoftnCch459y7MjvWxHg6SXTi7c
	 YLTbZdm75kYJJ0x8sCY+evcTzIqg3sx6JX6+3Mbm/ESrqflBuZ1zzQcoJFy9bIW9IL
	 312F2PowTrdWU8sOy1ILgv0n0T23QKhxjaiL3QhoxHsk6qBYb2iiw5lq+CCjmxRENe
	 W//ndQe/2SA0A==
Date: Tue, 16 Apr 2024 13:25:04 +0100
From: Lee Jones <lee@kernel.org>
To: Bhargav Raviprakash <bhargav.r@ltts.com>
Cc: arnd@arndb.de, broonie@kernel.org, conor+dt@kernel.org,
	devicetree@vger.kernel.org, eblanc@baylibre.com,
	gregkh@linuxfoundation.org, jpanis@baylibre.com, kristo@kernel.org,
	krzysztof.kozlowski+dt@linaro.org, lgirdwood@gmail.com,
	linus.walleij@linaro.org, linux-arm-kernel@lists.infradead.org,
	linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
	m.nirmaladevi@ltts.com, nm@ti.com, robh+dt@kernel.org,
	vigneshr@ti.com, khilman@kernel.org
Subject: Re: [RESEND PATCH v1 05/13] mfd: tps6594-spi: Add TI TPS65224 PMIC
 SPI
Message-ID: <20240416122504.GV2399047@google.com>
References: <20240411170344.GK2399047@google.com>
 <0109018ee1e1d91a-d3a0a73a-548d-4b9c-a6a5-a4f375c3adf3-000000@ap-south-1.amazonses.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <0109018ee1e1d91a-d3a0a73a-548d-4b9c-a6a5-a4f375c3adf3-000000@ap-south-1.amazonses.com>

On Mon, 15 Apr 2024, Bhargav Raviprakash wrote:

> Hello,
> 
> On Wed, 14 Feb 2024 10:10:17 -0800, Lee Jones wrote:
> > On Mon, 08 Apr 2024, Bhargav Raviprakash wrote:
> > 
> > > Introduces a new struct tps6594_match_data. This struct holds fields for
> > > chip id and regmap config. Using this struct in of_device_id data field.
> > > This helps in adding support for TPS65224 PMIC.
> > > 
> > > Signed-off-by: Bhargav Raviprakash <bhargav.r@ltts.com>
> > > Acked-by: Julien Panis <jpanis@baylibre.com>
> > > ---
> > >  drivers/mfd/tps6594-i2c.c   | 24 ++++++++++++++++--------
> > >  drivers/mfd/tps6594-spi.c   | 24 ++++++++++++++++--------
> > >  include/linux/mfd/tps6594.h | 11 +++++++++++
> > >  3 files changed, 43 insertions(+), 16 deletions(-)
> > > 
> > > diff --git a/drivers/mfd/tps6594-i2c.c b/drivers/mfd/tps6594-i2c.c
> > > index c125b474b..9e2ed48b7 100644
> > > --- a/drivers/mfd/tps6594-i2c.c
> > > +++ b/drivers/mfd/tps6594-i2c.c
> > > @@ -192,10 +192,16 @@ static const struct regmap_config tps6594_i2c_regmap_config = {
> > >  	.write = tps6594_i2c_write,
> > >  };
> > >  
> > > +static const struct tps6594_match_data match_data[] = {
> > > +	[TPS6594] = {TPS6594, &tps6594_i2c_regmap_config},
> > > +	[TPS6593] = {TPS6593, &tps6594_i2c_regmap_config},
> > > +	[LP8764] = {LP8764, &tps6594_i2c_regmap_config},
> > 
> > Nit: There should be spaces after the '{' and before the '}'.
> > 
> 
> Sure! will fix it in the next version.
> 
> > > +};
> > > +
> > >  static const struct of_device_id tps6594_i2c_of_match_table[] = {
> > > -	{ .compatible = "ti,tps6594-q1", .data = (void *)TPS6594, },
> > > -	{ .compatible = "ti,tps6593-q1", .data = (void *)TPS6593, },
> > > -	{ .compatible = "ti,lp8764-q1",  .data = (void *)LP8764,  },
> > > +	{ .compatible = "ti,tps6594-q1", .data = &match_data[TPS6594], },
> > > +	{ .compatible = "ti,tps6593-q1", .data = &match_data[TPS6593], },
> > > +	{ .compatible = "ti,lp8764-q1",  .data = &match_data[LP8764], },
> > 
> > Not keen on this.  Why do you pass the regmap data through here and
> > leave everything else to be matched on device ID?  It would be better to
> > keep passing the device ID through and match everything off of that.
> > 
> > 
> > -- 
> > Lee Jones [李琼斯]
> 
> Thanks for the feedback!
> 
> These changes were made because of the following message:
> https://lore.kernel.org/all/7hcysy6ho6.fsf@baylibre.com/
> 
> Please let us know which one to follow.

Right, except this doesn't eliminate "any \"if (chip_id)\" checking".
Instead you have a hodge-podge of passing a little bit of (Regmap) data
via match and the rest via "if (chip_id)".  So either pass all platform
type data via .data or just the chip ID.  My suggestion 99% of the time
is the latter.

-- 
Lee Jones [李琼斯]

