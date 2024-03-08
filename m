Return-Path: <linux-kernel+bounces-96742-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E2F4C8760E4
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 10:26:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D4C7BB2125A
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 09:26:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D3285339B;
	Fri,  8 Mar 2024 09:26:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="FFiJHNoD"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E33B9524C3;
	Fri,  8 Mar 2024 09:26:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709889993; cv=none; b=OO++55WZVX//BdIJjuNWS2FFxtNGbP9HyMjMNonzb4vFcLKVO9VmEPLQXZd189d401cBU2sClXhSHEDWZAaCqqhADkWrOdZN6EiLQwUeTa2cS+YcKn6GYFuUpuKZytZ74CI5ZvjbWe8YhxCZG3wsDjf754L9Jt0DxRBoMd08Wm4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709889993; c=relaxed/simple;
	bh=KRZUlGTWRzGrR7yLdWDEn305HxXSJR1EKn16Bdbix+4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ik3PBNgI+cnhaAr1Swrlb80d3uplnTYg/AVFYcmAq52MxrZNGO7ZcP8KzwhU4EAPhJPxrh5xfDhgs41vVnvKCQfhy1JgQ+2+SpVbpDcPHeWD0Wnegg7si9Fb1U8BWUKghvOxdchO9eWD8PCiT5rGmXZZ4fOwZlTQu5alM0aowvg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=FFiJHNoD; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1709889990;
	bh=KRZUlGTWRzGrR7yLdWDEn305HxXSJR1EKn16Bdbix+4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=FFiJHNoDykG+2uhlCj93i8zAIq0SIR/ijA6ULLZgYvUETENjAZlQGCwPMO/w6IghQ
	 BSVYckpMP7ndpv00jmTipuD+FEZmde/B6J+RkW1eMnmef7bWh64diix37ZGrimziZ8
	 K2dCxjtl6QwX0H948FlKOBj9qT0hF0ZvEwyoYPSIOU8bThYhTxlJudbCLSW056eLUU
	 LWQFi93gNsyqZq+wVDgfoC5fe9mLBNo/9IZmMQSfH34q8cWA5f665k1n5w5MGwAuUJ
	 cnL/N6XJg3xeCzUdSlLqjb/SWUunpd2zSgNoilY8TEP5xSYW4I9bnoDHAxVRDLbjLz
	 KZ64/VXET7CWA==
Received: from [100.113.186.2] (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id EDBDD3780480;
	Fri,  8 Mar 2024 09:26:29 +0000 (UTC)
Message-ID: <3a0910c4-87f4-4c0f-b6b6-3f7bf553a5f0@collabora.com>
Date: Fri, 8 Mar 2024 10:26:29 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] power: supply: sbs-battery: Handle unsupported
 PROP_TIME_TO_EMPTY_NOW
Content-Language: en-US
To: =?UTF-8?B?TsOtY29sYXMgRi4gUi4gQS4gUHJhZG8=?= <nfraprado@collabora.com>,
 Sebastian Reichel <sre@kernel.org>
Cc: kernel@collabora.com, linux-pm@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240307-sbs-time-empty-now-error-v1-1-18d0f8702330@collabora.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20240307-sbs-time-empty-now-error-v1-1-18d0f8702330@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Il 07/03/24 23:05, Nícolas F. R. A. Prado ha scritto:
> Despite the RunTimeToEmpty() (0x11) function being defined in the SBS
> specification as required, it seems that not all batteries implement it.
> On platforms with such batteries, reading the property will cause an
> error to be printed:
> 
> power_supply sbs-8-000b: driver failed to report `time_to_empty_now' property: -5
> 
> This not only pollutes the log, distracting from real problems on the
> device, but also prevents the uevent file from being read since it
> contains all properties, including the faulty one.
> 
> The following table summarizes the findings for a handful of platforms:
> 
> Platform                                Status  Manufacturer    Model
> ------------------------------------------------------------------------
> mt8186-corsola-steelix-sku131072        OK      BYD             L22B3PG0
> mt8195-cherry-tomato-r2                 NOT OK  PANASON         AP16L5J
> mt8192-asurada-spherion-r0              NOT OK  PANASON         AP15O5L
> mt8183-kukui-jacuzzi-juniper-sku16      NOT OK  LGC KT0         AP16L8J
> mt8173-elm-hana                         OK      Sunwoda         L18D3PG1
> sc7180-trogdor-lazor-limozeen-nots-r5   NOT OK  Murata          AP18C4K
> sc7180-trogdor-kingoftown               NOT OK  333-AC-0D-A     GG02047XL
> rk3399-gru-kevin                        OK      SDI             4352D51
> 
> Identify during probe, based on the battery model, if this is one of the
> quirky batteries, and if so, don't register the
> POWER_SUPPLY_PROP_TIME_TO_EMPTY_NOW property.
> 
> Signed-off-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>
> ---
>   drivers/power/supply/sbs-battery.c | 45 ++++++++++++++++++++++++++++++++++++++
>   1 file changed, 45 insertions(+)
> 
> diff --git a/drivers/power/supply/sbs-battery.c b/drivers/power/supply/sbs-battery.c
> index a6c204c08232..85ff331cf87a 100644
> --- a/drivers/power/supply/sbs-battery.c
> +++ b/drivers/power/supply/sbs-battery.c
> @@ -1112,6 +1112,49 @@ static const struct power_supply_desc sbs_default_desc = {
>   	.external_power_changed = sbs_external_power_changed,
>   };
>   
> +static const char * const unsupported_time_to_empty_now_models[] = {
> +	"AP16L5J", "AP15O5L", "AP16L8J", "AP18C4K", "GG02047XL"
> +};

I think that you must make sure that this is seen as a quirk, rather than
"something normal" because - as you said - the SBS specification says that
the TIME_TO_EMPTY_NOW is *required*, so, this is a *deviation* from the spec
(so, the SBS implementation in those devices is *out of spec*!).

static const char * const quirk_remove_time_to_empty_now_models
or                        quirk_unsupported_time_to_empty_now_models

..the former, if you want to avoid having a variable name that is 5000 characters
long (:-P); the latter, if you don't care about that (there's no rule anyway).


Besides that, since I didn't like what I just saw, I looked for different
alternatives; the only other one is to de-constify the sbs_properties[] array,
which is something that I also dislike anyway.

I'm not sure if deconstifying that could be acceptable, but if it would, you
would be able to remove-reorder without copies of this and that.

Anyway - the only thing I really want here is to make sure that this is seen
as a quirk and a clear deviation from the specification - everything else is
a plus, and not really a blocker for me.

> +
> +static void sbs_remove_unsupported_properties(struct power_supply_config *psy_cfg,
> +					      struct power_supply_desc *sbs_desc)

P.S.: sbs_quirk_remove_unsupported_properties :-)

Cheers,
Angelo

> +{
> +	enum power_supply_property *new_properties;
> +	struct sbs_info *chip = psy_cfg->drv_data;
> +	bool missing_time_to_empty_now = false;
> +	const char *model_name;
> +	unsigned int new_num_properties;
> +	unsigned int i = 0, j = 0;
> +
> +	model_name = sbs_get_constant_string(chip, POWER_SUPPLY_PROP_MODEL_NAME);
> +	if (IS_ERR(model_name))
> +		return;
> +
> +	for (i = 0; i < ARRAY_SIZE(unsupported_time_to_empty_now_models); i++) {
> +		if (!strcmp(model_name, unsupported_time_to_empty_now_models[i])) {
> +			missing_time_to_empty_now = true;
> +			break;
> +		}
> +	}
> +
> +	if (!missing_time_to_empty_now)
> +		return;
> +
> +	new_num_properties = ARRAY_SIZE(sbs_properties) - 1;
> +	new_properties = devm_kzalloc(&chip->client->dev, new_num_properties * sizeof(sbs_properties[0]), GFP_KERNEL);
> +
> +	for (i = 0; i < sbs_desc->num_properties; i++) {
> +		if (sbs_desc->properties[i] == POWER_SUPPLY_PROP_TIME_TO_EMPTY_NOW)
> +			continue;
> +
> +		new_properties[j] = sbs_desc->properties[i];
> +		j++;
> +	}
> +
> +	sbs_desc->properties = new_properties;
> +	sbs_desc->num_properties = new_num_properties;
> +};
> +
>   static int sbs_probe(struct i2c_client *client)
>   {
>   	struct sbs_info *chip;
> @@ -1210,6 +1253,8 @@ static int sbs_probe(struct i2c_client *client)
>   	if (rc)
>   		return rc;
>   
> +	sbs_remove_unsupported_properties(&psy_cfg, sbs_desc);
> +
>   	chip->power_supply = devm_power_supply_register(&client->dev, sbs_desc,
>   						   &psy_cfg);
>   	if (IS_ERR(chip->power_supply))
> 
> ---
> base-commit: 11afac187274a6177a7ac82997f8691c0f469e41
> change-id: 20240307-sbs-time-empty-now-error-322bc074d3f2
> 
> Best regards,


