Return-Path: <linux-kernel+bounces-162380-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 391DB8B5A41
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 15:39:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E335D1F2456F
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 13:39:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 778787441F;
	Mon, 29 Apr 2024 13:39:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XZfa7dJK"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADF876A00B;
	Mon, 29 Apr 2024 13:39:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714397965; cv=none; b=pOSU/JBScw8B4xcRf1ukAgsH0beMQhfnhSNXG2/QxQyVUUivzXHsSIDqI+znxDdyM2pDAYLoVN4Zzz0pI0OvV50tresruQtzwC7ec63a9DnZSqaqkmj5BKq5rpByMXU9dSY1oyN2GbfhJd1SDTOREALxj0h8CSkfkIrO+uJk/oY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714397965; c=relaxed/simple;
	bh=Xd+ih7r9s5+9LMe8W6DLUFmMehgeoqexmv4quZsszi0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bALba64MMlDMh6kngkcCPOVbyPAyqoKFZ3HY9E2sAebpA5RoTKVHifEjv6JNK2hVaHBqZXqZNqSHB5U3D6iPw75WDXyAgXmV4CFiYMsC9C5FFWsW94oOAQM9sj9oQG+MPD3EQJXtvldIGX5lWQpwe0dqS/aclCc3oawpd33At1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XZfa7dJK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB757C113CD;
	Mon, 29 Apr 2024 13:39:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714397965;
	bh=Xd+ih7r9s5+9LMe8W6DLUFmMehgeoqexmv4quZsszi0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=XZfa7dJKWOKJ0OjsCShBm9W3KR8eIwmAPk3oQ0FoHLsoim3McvEROI79qoluZfVS4
	 9grNin8eT9RUMP/pmtCEMijbap0BaJMmJ6zQtND2dedNA5nqFsb2JC5lj+CqnVKFbq
	 fpo6tOBsity4C1OB4khsAZSYNwqwTPZuRZwJOTWfcASZDlgAe2qJMN/aajc5RgLeH9
	 vwK3mhzeg0edR+IRAa0rylEFIRG2Ilh+fe+wgIQmK5XbmrRdS+AmOeGBupy+decQDW
	 hXKiyPpS5to38jOpFqIhXeRwng64QrEEW3EnCwOfSDobZUeN5qwCe6omeH+b2jkD4L
	 XoZTcw888pgNQ==
Date: Mon, 29 Apr 2024 06:39:23 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Luiz Angelo Daros de Luca <luizluca@gmail.com>
Cc: Linus Walleij <linus.walleij@linaro.org>, Alvin =?UTF-8?B?xaBpcHJhZ2E=?=
 <alsi@bang-olufsen.dk>, Andrew Lunn <andrew@lunn.ch>, Florian Fainelli
 <f.fainelli@gmail.com>, Vladimir Oltean <olteanv@gmail.com>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo
 Abeni <pabeni@redhat.com>, Rob Herring <robh+dt@kernel.org>, Krzysztof
 Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley
 <conor+dt@kernel.org>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH net-next v2 3/3] net: dsa: realtek: add LED drivers for
 rtl8366rb
Message-ID: <20240429063923.648c927f@kernel.org>
In-Reply-To: <20240427-realtek-led-v2-3-5abaddc32cf6@gmail.com>
References: <20240427-realtek-led-v2-0-5abaddc32cf6@gmail.com>
	<20240427-realtek-led-v2-3-5abaddc32cf6@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 27 Apr 2024 02:11:30 -0300 Luiz Angelo Daros de Luca wrote:
> +static int rtl8366rb_setup_leds(struct realtek_priv *priv)
> +{
> +	struct device_node *leds_np, *led_np;
> +	struct dsa_switch *ds = &priv->ds;
> +	struct dsa_port *dp;
> +	int ret = 0;
> +
> +	dsa_switch_for_each_port(dp, ds) {
> +		if (!dp->dn)
> +			continue;
> +
> +		leds_np = of_get_child_by_name(dp->dn, "leds");
> +		if (!leds_np) {
> +			dev_dbg(priv->dev, "No leds defined for port %d",
> +				dp->index);
> +			continue;
> +		}
> +
> +		for_each_child_of_node(leds_np, led_np) {
> +			ret = rtl8366rb_setup_led(priv, dp,
> +						  of_fwnode_handle(led_np));
> +			if (ret) {
> +				of_node_put(led_np);
> +				break;
> +			}
> +		}
> +
> +		of_node_put(leds_np);
> +		if (ret)
> +			return ret;
> +	}
> +	return 0;
> +}

coccicheck generates this warning:

drivers/net/dsa/realtek/rtl8366rb.c:1032:4-15: ERROR: probable double put.

I think it's a false positive. But aren't you missing a put(dp) before
"return ret;" ?

