Return-Path: <linux-kernel+bounces-146446-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 994AD8A6567
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 09:47:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 518C1281A96
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 07:47:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4934B84E0A;
	Tue, 16 Apr 2024 07:47:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="KvpqMMrh"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9F6171B50;
	Tue, 16 Apr 2024 07:46:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713253620; cv=none; b=QiJOAm86jWwzRvU27pB/0bPPQeehXek6vUOfexOrn8lNUGtookFcnvBbUKTXrQoa45NdLy/XK5wMTYjvKQ+1Kw7FHqRQOWvYrHd4Wx+0+5r6mKLAVGII8HSf8eeegXtHmemPpaxv84EgqmSM5DXFWfXeN6l+eLcyijQTXFG7Ytc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713253620; c=relaxed/simple;
	bh=b6AuMh5gLX3160ojjBtFTN6qgvS8yoB21c3kcZg1+0Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MPzAKXBpiXou/bYt4U5a3WBNuvmz4DJ8EbxVpipqj0K6g/Yv0M7pIPeNuud1jFXERarqUyLOa6fkjAWDlM8B1TEuZod9dhVou4DDVW8mAR8KUxtxekEEl5Ey+YFKGfLsxg9IPGf/rXZEbukn61vPipd73auPkSqNmY0hyWjXjcc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=KvpqMMrh; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1713253617;
	bh=b6AuMh5gLX3160ojjBtFTN6qgvS8yoB21c3kcZg1+0Y=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=KvpqMMrhqwCbcEvibrA5hSNbFlzqC72Jy8lqP3e8RQGXIWofgKUtMyORRps8EUS8d
	 Zjt8Jc8J3WOk/w5QjarXQwC5XJzEDA2lizuTxdnqqCGzQqT5Zc56Oj6N3ntUFTxXaY
	 IuhNu3MbGqcMGQZkuP5SnhVCi9es+2uEAs1LEb+HhuN1eqc4IROUF2yUt7Drdb7p3a
	 0pX17qr0o0mFbFKa0rhvhf+q39PanGrx0ZVr6cqAzMNRnhU44SL0vHiaJZUpiZkfKj
	 qeN+i5Zsb+HCnXH7GLUz/H+JqLOk08BZQuysKD0XzMdKWqum5M9ulvfzNlgut6mCfY
	 U77CKGhUg468Q==
Received: from [100.113.186.2] (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id E5E7337804B2;
	Tue, 16 Apr 2024 07:46:56 +0000 (UTC)
Message-ID: <9ba1b4df-78dc-4f24-bb61-d7b168da18f8@collabora.com>
Date: Tue, 16 Apr 2024 09:46:56 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] power: supply: sbs-battery: Handle unsupported
 PROP_TIME_TO_EMPTY_NOW
To: =?UTF-8?B?TsOtY29sYXMgRi4gUi4gQS4gUHJhZG8=?= <nfraprado@collabora.com>,
 Sebastian Reichel <sre@kernel.org>
Cc: kernel@collabora.com, linux-pm@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240415-sbs-time-empty-now-error-v2-1-32d8a747e308@collabora.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <20240415-sbs-time-empty-now-error-v2-1-32d8a747e308@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Il 15/04/24 21:05, Nícolas F. R. A. Prado ha scritto:
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
> Detect if this is one of the quirky batteries during presence update, so
> that hot-plugging works as expected, and if so report -ENODATA for
> POWER_SUPPLY_PROP_TIME_TO_EMPTY_NOW, which removes it from uevent and
> prevents throwing errors.
> 
> Signed-off-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>
> ---
> Changes in v2:
> - Reworked patch to lay down and use a proper quirk infrastructure, and
>    update the quirks on the presence update callback so it works properly
>    even when hot-plugging different batteries
> - Link to v1: https://lore.kernel.org/r/20240307-sbs-time-empty-now-error-v1-1-18d0f8702330@collabora.com
> ---
>   drivers/power/supply/sbs-battery.c | 55 ++++++++++++++++++++++++++++++++++++++
>   1 file changed, 55 insertions(+)
> 
> diff --git a/drivers/power/supply/sbs-battery.c b/drivers/power/supply/sbs-battery.c
> index a6c204c08232..92acbda9e78e 100644
> --- a/drivers/power/supply/sbs-battery.c
> +++ b/drivers/power/supply/sbs-battery.c
> @@ -214,6 +214,7 @@ struct sbs_info {
>   	struct delayed_work		work;
>   	struct mutex			mode_lock;
>   	u32				flags;
> +	u32				quirks;
>   	int				technology;
>   	char				strings[NR_STRING_BUFFERS][I2C_SMBUS_BLOCK_MAX + 1];
>   };
> @@ -263,6 +264,54 @@ static void sbs_disable_charger_broadcasts(struct sbs_info *chip)
>   		dev_dbg(&chip->client->dev, "%s\n", __func__);
>   }
>   
> +/* Required by the spec, but missing in some implementations */
> +#define SBS_QUIRK_BROKEN_TTE_NOW	BIT(0)
> +
> +struct sbs_quirk_entry {
> +	const char *manufacturer;
> +	const char *model;
> +	u32 flags;
> +};
> +
> +static const struct sbs_quirk_entry sbs_quirks[] = {
> +	{"PANASON", "AP16L5J", SBS_QUIRK_BROKEN_TTE_NOW},
> +	{"PANASON", "AP15O5L", SBS_QUIRK_BROKEN_TTE_NOW},
> +	{"LGC KT0", "AP16L8J", SBS_QUIRK_BROKEN_TTE_NOW},
> +	{"Murata", "AP18C4K", SBS_QUIRK_BROKEN_TTE_NOW},
> +	{"333-AC-0D-A", "GG02047XL", SBS_QUIRK_BROKEN_TTE_NOW},
> +};
> +
> +static const char *sbs_get_constant_string(struct sbs_info *chip,
> +					   enum power_supply_property psp);
> +
> +static void sbs_update_quirks(struct sbs_info *chip)
> +{
> +	const char *model;
> +	const char *manufacturer;
> +	unsigned int i = 0;

Please reorder:

	const char *manufacturer;
	const char *model;
	unsigned int i;

..and please remove (like shown, of course) the double initialization of the
`i` variable, as you're initializing it again later in your for loop.

> +
> +	/* reset quirks from battery before the hot-plug event */
> +	chip->quirks = 0;
> +
> +	manufacturer = sbs_get_constant_string(chip, POWER_SUPPLY_PROP_MANUFACTURER);
> +	model = sbs_get_constant_string(chip, POWER_SUPPLY_PROP_MODEL_NAME);
> +	if (IS_ERR(manufacturer) || IS_ERR(model)) {
> +		dev_warn(&chip->client->dev, "Couldn't read manufacturer and model to set quirks\n");
> +		return;
> +	}
> +
> +	for (i = 0; i < ARRAY_SIZE(sbs_quirks); i++) {
> +		if (strcmp(manufacturer, sbs_quirks[i].manufacturer))
> +			continue;
> +		if (strcmp(model, sbs_quirks[i].model))
> +			continue;
> +		chip->quirks |= sbs_quirks[i].flags;
> +	}
> +
> +	if (chip->quirks & SBS_QUIRK_BROKEN_TTE_NOW)
> +		dev_info(&chip->client->dev, "Added quirk disabling TIME_TO_EMPTY_NOW\n");

I don't really expect many quirks, but having a dev_info() print for every
quirk that gets set would make this driver too chatty, IMO.

Please, either turn that into a dev_dbg() or print a mask of the quirks .. or both.

Cheers,
Angelo

> +}
> +
>   static int sbs_update_presence(struct sbs_info *chip, bool is_present)
>   {
>   	struct i2c_client *client = chip->client;
> @@ -323,6 +372,8 @@ static int sbs_update_presence(struct sbs_info *chip, bool is_present)
>   	dev_dbg(&client->dev, "PEC: %s\n", (client->flags & I2C_CLIENT_PEC) ?
>   		"enabled" : "disabled");
>   
> +	sbs_update_quirks(chip);
> +
>   	if (!chip->is_present && is_present && !chip->charger_broadcasts)
>   		sbs_disable_charger_broadcasts(chip);
>   
> @@ -614,6 +665,10 @@ static int sbs_get_battery_property(struct i2c_client *client,
>   	struct sbs_info *chip = i2c_get_clientdata(client);
>   	s32 ret;
>   
> +	if (psp == POWER_SUPPLY_PROP_TIME_TO_EMPTY_NOW &&
> +	    chip->quirks & SBS_QUIRK_BROKEN_TTE_NOW)
> +		return -ENODATA;
> +
>   	ret = sbs_read_word_data(client, sbs_data[reg_offset].addr);
>   	if (ret < 0)
>   		return ret;
> 
> ---
> base-commit: 11afac187274a6177a7ac82997f8691c0f469e41
> change-id: 20240307-sbs-time-empty-now-error-322bc074d3f2
> 
> Best regards,




