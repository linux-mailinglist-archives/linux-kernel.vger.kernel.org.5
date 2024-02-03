Return-Path: <linux-kernel+bounces-51235-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2448E84882B
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Feb 2024 19:18:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7C30EB2521F
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Feb 2024 18:18:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C4335FBAE;
	Sat,  3 Feb 2024 18:18:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=xff.cz header.i=@xff.cz header.b="y3ZNKGcF"
Received: from vps.xff.cz (vps.xff.cz [195.181.215.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68CC85FB8D;
	Sat,  3 Feb 2024 18:18:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.181.215.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706984307; cv=none; b=oIkYgNwWXzhBcjzyMQHu3pX3ZC0z6qOWEKDm+6yfqqthyBQA2ByH/BIxuy6t05WOWjHQn4DlXvy0DWY0M/SknHvXGKIMFKpzy8K9XpFWU0S29njGlh0x/8ST61grZ0WeiabPJUXrioJgrJMngaFFTh5YRHDTklxCoPYlMjgB7y4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706984307; c=relaxed/simple;
	bh=v18Uq25xFd0lAYlqmeeW1rPPUfvDN/gZuKrB7cBLNgk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=J1lXNUUiL4aBXovL0VKGeNnz6qBWk57l8p4euQSWSq4Qlhg4Nu1MyfcVtParGCXDGcZgx9yj1hLL21djHbhjdmW1NDgg/XBrU8yAwuzfAolwFB0LCGIm2n6oQ4oLQWP7sMk6XZVieeNmbWTfL+tQxCE/krPQT+CTjFwTce4bpok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=xff.cz; spf=pass smtp.mailfrom=xff.cz; dkim=pass (1024-bit key) header.d=xff.cz header.i=@xff.cz header.b=y3ZNKGcF; arc=none smtp.client-ip=195.181.215.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=xff.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xff.cz
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=xff.cz; s=mail;
	t=1706984294; bh=v18Uq25xFd0lAYlqmeeW1rPPUfvDN/gZuKrB7cBLNgk=;
	h=Date:From:To:Cc:Subject:X-My-GPG-KeyId:References:From;
	b=y3ZNKGcFub4QSs9xq0iVNFE7+KJSaXXYyWbxvggkDoGYxo6ADvmOOyh3q97eGngaY
	 7NqT787d2NhDpOozFjmHwAAiNLLNbVsbNOK/8+dYHxKsKZ8if65gNuI2FO5qbw8JSd
	 8NRQYdjVNQAUC89HwrkKZJAbGcCaiysmIsGTVWWE=
Date: Sat, 3 Feb 2024 19:18:13 +0100
From: =?utf-8?Q?Ond=C5=99ej?= Jirman <megi@xff.cz>
To: Pavel Machek <pavel@ucw.cz>
Cc: phone-devel@vger.kernel.org, 
	kernel list <linux-kernel@vger.kernel.org>, fiona.klute@gmx.de, martijn@brixit.nl, samuel@sholland.org, 
	heikki.krogerus@linux.intel.com, gregkh@linuxfoundation.org, linux-usb@vger.kernel.org
Subject: Re: [PATCH] usb: typec: anx7688: Add driver for ANX7688 USB-C HDMI
 bridge
Message-ID: <iikhv7e2z3pk7nr6bvtuepwyrmukym5fjtc2xspsmhxzz5jlwe@5vfs4i3w66kc>
Mail-Followup-To: =?utf-8?Q?Ond=C5=99ej?= Jirman <megi@xff.cz>, 
	Pavel Machek <pavel@ucw.cz>, phone-devel@vger.kernel.org, 
	kernel list <linux-kernel@vger.kernel.org>, fiona.klute@gmx.de, martijn@brixit.nl, samuel@sholland.org, 
	heikki.krogerus@linux.intel.com, gregkh@linuxfoundation.org, linux-usb@vger.kernel.org
X-My-GPG-KeyId: EBFBDDE11FB918D44D1F56C1F9F0A873BE9777ED
 <https://xff.cz/key.txt>
References: <Zbt1dIByBZ2stzjm@mobian>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zbt1dIByBZ2stzjm@mobian>

Hi Pavel,

On Thu, Feb 01, 2024 at 11:41:56AM +0100, Pavel Machek wrote:
> From: Ondrej Jirman <megi@xff.cz>
> 
> This is driver for ANX7688 USB-C HDMI, with flashing and debugging
> features removed. ANX7688 is rather criticial piece on PinePhone,
> there's no display and no battery charging without it.

Don't remove the flashing part. Some Pinephones come without the firmware
in the past. Even recently, I've seen some people in the Pine chat
asking how to flash the firmware on some old PinePhone.

It's a safe operation that can be done at any time and can only be done
from the kernel driver.

> There's likely more work to be done here, but having basic support
> in mainline is needed to be able to work on the other stuff
> (networking, cameras, power management).
> 
> Signed-off-by: Ondrej Jirman <megi@xff.cz>

I should be second in order of sign-offs. Martijn wrote a non-working skeleton
https://megous.com/git/linux/commit/?h=pp-5.7&id=30e33cefd7956a2b49fb27008b4af9d868974e58
driver. Then I picked it up and developed it over years to a working thing.
Almost none of the skeleton remains.

License is GPLv2.

> Signed-off-by: Martijn Braam <martijn@brixit.nl>
> Signed-off-by: Samuel Holland <samuel@sholland.org>
> Signed-off-by: Pavel Machek <pavel@ucw.cz>
> 
> [...]
>
> +static int anx7688_i2c_probe(struct i2c_client *client)
> +{
> +        struct anx7688 *anx7688;
> +        struct device *dev = &client->dev;
> +        struct typec_capability typec_cap = { };
> +        int i, vid_h, vid_l;
> +        int irq_cabledet;
> +        int ret = 0;
> +
> +        anx7688 = devm_kzalloc(dev, sizeof(*anx7688), GFP_KERNEL);
> +        if (!anx7688)
> +                return -ENOMEM;
> +
> +        i2c_set_clientdata(client, anx7688);
> +        anx7688->client = client;
> +        anx7688->dev = &client->dev;
> +        mutex_init(&anx7688->lock);
> +        INIT_DELAYED_WORK(&anx7688->work, anx7688_work);
> +	anx7688->last_extcon_state = -1;
> +
> +	ret = of_property_read_variable_u32_array(dev->of_node, "source-caps",
> +						  anx7688->src_caps,
> +						  1, ARRAY_SIZE(anx7688->src_caps));
> +	if (ret < 0) {
> +		dev_err(dev, "failed to get source-caps from DT\n");
> +		return ret;
> +	}
> +	anx7688->n_src_caps = ret;
> +
> +	ret = of_property_read_variable_u32_array(dev->of_node, "sink-caps",
> +						  anx7688->snk_caps,
> +						  1, ARRAY_SIZE(anx7688->snk_caps));
> +	if (ret < 0) {
> +		dev_err(dev, "failed to get sink-caps from DT\n");
> +		return ret;
> +	}

^^^ The driver will need to follow usb-c-connector bindings and it will need
a bindings documentation for itself.

That's one of the missing things that I did not implement, yet.

Kind regards,
	o.

