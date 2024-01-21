Return-Path: <linux-kernel+bounces-32031-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 220CD835581
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Jan 2024 12:39:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D02E12822C6
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Jan 2024 11:39:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6597F36AF2;
	Sun, 21 Jan 2024 11:39:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=xff.cz header.i=@xff.cz header.b="nipXggtO"
Received: from vps.xff.cz (vps.xff.cz [195.181.215.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9529364D8;
	Sun, 21 Jan 2024 11:38:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.181.215.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705837140; cv=none; b=TCRmaNAzawnoRnpNmGsZsRIpYybp/p8yWbV+FCbLbwQIsrwjlsXh98Mw9HL3U25q+reFPFDUfhhQzms0VKCrst7Xk2wuTH0HzOPp8Bre/3DqxhR6354aDfJSoRdJtvUFCvD3sQLx5meF8jIakeTuryg9POczugfuuBLKKycMXmE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705837140; c=relaxed/simple;
	bh=Nz9E0ewi+wkPtlJl6b62OAa77mlQ6hVzBkiY09YrE+0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RboEydC0Bv1qLUJfdnKzVQjrWwuc8OwGChkEU97T1Nn7SLQ673aqORU5o6BM28+Jsyth5n4iV4V4j4qctNqniNaGf5cGKBP+vHrOptnjqYkRclTwzWu4whxwsKIknEymSY1CRsvUJzVX9a46EuNZCWUbjL+vsdNc7jIxINK4sGE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=xff.cz; spf=pass smtp.mailfrom=xff.cz; dkim=pass (1024-bit key) header.d=xff.cz header.i=@xff.cz header.b=nipXggtO; arc=none smtp.client-ip=195.181.215.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=xff.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xff.cz
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=xff.cz; s=mail;
	t=1705837135; bh=Nz9E0ewi+wkPtlJl6b62OAa77mlQ6hVzBkiY09YrE+0=;
	h=Date:From:To:Cc:Subject:X-My-GPG-KeyId:References:From;
	b=nipXggtOYkGjhLjzN8YHPF7FbdyfVGFErN4PUPRTwLHTAo+n+wMQifHtRxg7Wy5z2
	 IBU/jt1QLKmaBEgyskUJ6fOXhUei9U9kCHIa0z7FGLW0ElbnwWr7AD7XhZT1gUTBNu
	 mx1MUGa24sbNTAGon5IH1pZyEsaunE60g4F6KbHo=
Date: Sun, 21 Jan 2024 12:38:54 +0100
From: =?utf-8?Q?Ond=C5=99ej?= Jirman <megi@xff.cz>
To: Aren Moynihan <aren@peacevolution.org>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Aidan MacDonald <aidanmacdonald.0x0@gmail.com>, Chen-Yu Tsai <wens@csie.org>, Sebastian Reichel <sre@kernel.org>
Subject: Re: [PATCH 1/3] power: supply: axp20x_usb_power: add input current
 limit
Message-ID: <lz3sm6yxu3d5pgr2ffs4m3ive54lbiis6abmrph3u5wrav7lqu@qh2kivwzwd6z>
Mail-Followup-To: =?utf-8?Q?Ond=C5=99ej?= Jirman <megi@xff.cz>, 
	Aren Moynihan <aren@peacevolution.org>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Aidan MacDonald <aidanmacdonald.0x0@gmail.com>, Chen-Yu Tsai <wens@csie.org>, Sebastian Reichel <sre@kernel.org>
X-My-GPG-KeyId: EBFBDDE11FB918D44D1F56C1F9F0A873BE9777ED
 <https://xff.cz/key.txt>
References: <20240121014057.1042466-1-aren@peacevolution.org>
 <20240121014057.1042466-3-aren@peacevolution.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240121014057.1042466-3-aren@peacevolution.org>

Hello Aren,

On Sat, Jan 20, 2024 at 08:40:00PM -0500, Aren Moynihan wrote:
> Add properties for setting the maximum current that will be drawn from
> the usb connection.
> 
> These changes don't apply to all axp20x chips, so we need to add new
> power_desc and power supply property objects for axp813 specifically.
> These are copied from the axp22x variants that were used before, with
> extra fields added.
> 
> Also add a dev field to the axp20x_usb_power struct, so we can use
> dev_dbg and dev_err in more places.
> 
> Signed-off-by: Aren Moynihan <aren@peacevolution.org>
> ---
> 
>  drivers/power/supply/axp20x_usb_power.c | 127 +++++++++++++++++++++++-
>  1 file changed, 125 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/power/supply/axp20x_usb_power.c b/drivers/power/supply/axp20x_usb_power.c
> index e23308ad4cc7..8c0c2c25565f 100644
> --- a/drivers/power/supply/axp20x_usb_power.c
> +++ b/drivers/power/supply/axp20x_usb_power.c
> @@ -50,7 +50,10 @@ struct axp_data {
>  	const char * const		*irq_names;
>  	unsigned int			num_irq_names;
>  	const int			*curr_lim_table;
> +	int				input_curr_lim_table_size;
> +	const int			*input_curr_lim_table;
>  	struct reg_field		curr_lim_fld;
> +	struct reg_field		input_curr_lim_fld;
>  	struct reg_field		vbus_valid_bit;
>  	struct reg_field		vbus_mon_bit;
>  	struct reg_field		usb_bc_en_bit;
> @@ -59,7 +62,9 @@ struct axp_data {
>  };
>  
>  struct axp20x_usb_power {
> +	struct device *dev;
>  	struct regmap *regmap;
> +	struct regmap_field *input_curr_lim_fld;
>  	struct regmap_field *curr_lim_fld;
>  	struct regmap_field *vbus_valid_bit;
>  	struct regmap_field *vbus_mon_bit;
> @@ -115,6 +120,15 @@ static void axp20x_usb_power_poll_vbus(struct work_struct *work)
>  	if (val != power->old_status)
>  		power_supply_changed(power->supply);
>  
> +	if (power->usb_bc_en_bit && (val & AXP20X_PWR_STATUS_VBUS_PRESENT) !=
> +		(power->old_status & AXP20X_PWR_STATUS_VBUS_PRESENT)) {
> +		dev_dbg(power->dev, "Cable status changed, re-enabling USB BC");
> +		ret = regmap_field_write(power->usb_bc_en_bit, 1);
> +		if (ret)
> +			dev_err(power->dev, "failed to enable USB BC: errno %d",
> +				ret);
> +	}
> +
>  	power->old_status = val;
>  	power->online = val & AXP20X_PWR_STATUS_VBUS_USED;
>  
> @@ -123,6 +137,66 @@ static void axp20x_usb_power_poll_vbus(struct work_struct *work)
>  		mod_delayed_work(system_power_efficient_wq, &power->vbus_detect, DEBOUNCE_TIME);
>  }
>  
> +static int
> +axp20x_usb_power_set_input_current_limit(struct axp20x_usb_power *power,
> +					 int limit)
> +{
> +	int ret;
> +	unsigned int reg;
> +
> +	if (!power->axp_data->input_curr_lim_table)
> +		return -EINVAL;
> +
> +	if (limit < power->axp_data->input_curr_lim_table[0])
> +		return -EINVAL;

I think that you should just set the lowest possible limit. A caller (calling
driver or userspace or user) has no way to identify what is the lowest possible
limit on arbitrary PMIC and I kinda like having an option to
echo 0 > .../axp20x-usb/input_current_limit as a way to limit power consumption from
USB to a minimum without having to look up what actual minimum is in various
PMICs dataheets.

I looked through most of the uses of POWER_SUPPLY_PROP_INPUT_CURRENT_LIMIT in
the upstream drivers and both approaches are used. Erroring out when out of range
is less common.

Otherwise,

Reviewed-By: Ondrej Jirman <megi@xff.cz>

Thank you,
	Ondrej

