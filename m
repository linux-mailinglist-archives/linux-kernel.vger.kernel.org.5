Return-Path: <linux-kernel+bounces-66130-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E6D0F855774
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 00:46:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 168131C21C3F
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 23:46:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 501311420D0;
	Wed, 14 Feb 2024 23:46:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PgnnRWR4"
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C19AE1420B4;
	Wed, 14 Feb 2024 23:46:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707954384; cv=none; b=IgRP9YGSI0MY2XA49YgtIJa04yNAA319FtinuQ0FjjmZ0OgH6nfUIUwUcYEGsi0L9nUllSYzDg4cU3g0lD8UBKgcRZzXMn2X18Qh+zNDFzxTR+TbCI/q46Z4d73uvhT3gUIqU6zGW2blzym14GPiF5fGizqiEquuL8LOxNwRyk4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707954384; c=relaxed/simple;
	bh=vM5LV0bgJnYCoYbnuehayMAo2Z6Rn3ErOzpg2M6ffXU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MbugzrVYtJ01KQarnzOwVBd+lzdzN0Mr94HMWRyauSR4ZSeZsnlfF+d/nNrFCYDe8XdKJkiATDsDcct3/OsW41TXgB+Y6t83Nt+/Y5X+gRxjyYKpCqOqWLd2lo+FIW2T7eUcb4YYbz4M8GdQyOvX/eSguo53NkjMPHnjyCRGZbI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PgnnRWR4; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-55f0b2c79cdso470458a12.3;
        Wed, 14 Feb 2024 15:46:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707954381; x=1708559181; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Pf9NdgBQNRoMuxuHiS061fyD7EA6QdWqQVzZdoymaX4=;
        b=PgnnRWR4xqrwtn14sV7EJWnA4Pzkc6L6xa9mXTcJrqYviGAFmGJ/EFNHDQ0JojA23F
         qU7oe1bzdAX5S4yS9VpUZzkhr2tie3Oh9Q/AFlcMgiA9Ncy11IPmaGVgyVz8wfJB9Gfc
         ib2cpaF7h+k0xhulXiDWOyeS/2ditsdkp8yX3PNk1bhGmw0rZOL9XmupwtLqXZrcqtFa
         TR6WMZ6FWGsYe5AlOE9PAuNCVRIyQnsEFxyIQeHu00GTijgqmi6sJmIzCJcbry7Mqda+
         VZdo6sFzvjHpTMox+E/i38SVWqiPmAR5hpnUngf3WHNz2fB9f2X3UYCvn8aEDaRyVlkK
         Z04A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707954381; x=1708559181;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Pf9NdgBQNRoMuxuHiS061fyD7EA6QdWqQVzZdoymaX4=;
        b=ug69F6GdP30OWecCBJn5IIg0k/TGv3yvAci+PQjreombfc5FzgkdrGshnpBgA2ko/e
         1VXQwe7YreZyDawal7yANAxVO4pD7L3zdfkXwXp0jIWtwF47QyOidmLAML03My+g2gVS
         pYByyqfANfAg1kScQ5lw7nmtje3d68GyoB85PMzfZDZt68S++OP+a827JkKt2Tu1/WKY
         lU42Musv+NmfSI2ur8OLlXu5+Y5uT2z31VWVwa4SmnqGSUi1QOUU6M+GxTKlhex9Q8U/
         x6N4cOqLDSh/t8OvOc0E771tS4GeC6IXPorD3EwNj930NgrClb/JyQ3O872jJS/U1Dh3
         +bGQ==
X-Forwarded-Encrypted: i=1; AJvYcCUxAg1wxDR7l65Mht/fqoI91Mmv1LheSbC7cq/eaY7mCX9hdowoztN+mOp5BSwMfC0UGd+QfAgsOSFdLFiaYtP4cUbmcQVpx8tsgXui
X-Gm-Message-State: AOJu0Yw3Rgo//yA07K5SjEO1MCxVYYZRMPOUPfYQGGDTg1LyQ4JjJzYy
	HdpKdnxGZzy9EglTYIm1vQfEPvhvC9qALX41Jnk+X7O7wXIGzucj
X-Google-Smtp-Source: AGHT+IFEdCvqtuH9QJ4fTTQsdBLyoHmoAYhys4d0EcaWj75efx62YufKh6TfKDrUsPdQwEEr8R8WDg==
X-Received: by 2002:a17:906:7189:b0:a3c:edf6:a735 with SMTP id h9-20020a170906718900b00a3cedf6a735mr39373ejk.47.1707954380500;
        Wed, 14 Feb 2024 15:46:20 -0800 (PST)
Received: from skbuf ([188.25.173.195])
        by smtp.gmail.com with ESMTPSA id w24-20020a170906131800b00a3d22f53210sm3280ejb.188.2024.02.14.15.46.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Feb 2024 15:46:20 -0800 (PST)
Date: Thu, 15 Feb 2024 01:46:17 +0200
From: Vladimir Oltean <olteanv@gmail.com>
To: Pawel Dembicki <paweldembicki@gmail.com>
Cc: netdev@vger.kernel.org, linus.walleij@linaro.org,
	Russell King <linux@armlinux.org.uk>, Andrew Lunn <andrew@lunn.ch>,
	Florian Fainelli <f.fainelli@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Claudiu Manoil <claudiu.manoil@nxp.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	UNGLinuxDriver@microchip.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v4 01/15] net: dsa: vsc73xx: use
 read_poll_timeout instead delay loop
Message-ID: <20240214234617.c4vz66ntydr7dw3v@skbuf>
References: <20240213220331.239031-1-paweldembicki@gmail.com>
 <20240213220331.239031-2-paweldembicki@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240213220331.239031-2-paweldembicki@gmail.com>

On Tue, Feb 13, 2024 at 11:03:14PM +0100, Pawel Dembicki wrote:
> This commit switches delay loop to read_poll_timeout macro during
> Arbiter empty check in adjust link function.

Replace "This commit does X" with imperative mood: "Switch the delay
loop during the Arbiter empty check from vsc73xx_adjust_link() to use
read_poll_timeout(). Functionally, one msleep() call is eliminated at
the end of the loop, in the timeout case".

> 
> As Russel King suggested:

s/Russel/Russell/

> 
> "This [change] avoids the issue that on the last iteration, the code reads
> the register, test it, find the condition that's being waiting for is

s/test/tests/
s/find/finds/

> false, _then_ waits and end up printing the error message - that last
> wait is rather useless, and as the arbiter state isn't checked after
> waiting, it could be that we had success during the last wait."
> 
> It also remove one short msleep delay.

Apart from the fact that there's a grammatical mistake in this phrase
("it remove" -> "it removes"), it's also a bit redundant, since
Russell's explanation above implies this is what would happen. Anyway,
I've suggested a replacement for it in the first paragraph, the one
describing the change.

> Suggested-by: Russell King <linux@armlinux.org.uk>
> Signed-off-by: Pawel Dembicki <paweldembicki@gmail.com>
> Reviewed-by: Andrew Lunn <andrew@lunn.ch>
> ---
> v4:
>   - Resend patch
> v3:
>   - Add "Reviewed-by" to commit message only
> v2:
>   - introduced patch
> 
>  drivers/net/dsa/vitesse-vsc73xx-core.c | 25 +++++++++++--------------
>  1 file changed, 11 insertions(+), 14 deletions(-)
> 
> diff --git a/drivers/net/dsa/vitesse-vsc73xx-core.c b/drivers/net/dsa/vitesse-vsc73xx-core.c
> index ae70eac3be28..8b2219404601 100644
> --- a/drivers/net/dsa/vitesse-vsc73xx-core.c
> +++ b/drivers/net/dsa/vitesse-vsc73xx-core.c
> @@ -779,7 +779,7 @@ static void vsc73xx_adjust_link(struct dsa_switch *ds, int port,
>  	 * after a PHY or the CPU port comes up or down.
>  	 */
>  	if (!phydev->link) {
> -		int maxloop = 10;
> +		int ret, err;
>  
>  		dev_dbg(vsc->dev, "port %d: went down\n",
>  			port);
> @@ -794,19 +794,16 @@ static void vsc73xx_adjust_link(struct dsa_switch *ds, int port,
>  				    VSC73XX_ARBDISC, BIT(port), BIT(port));
>  
>  		/* Wait until queue is empty */
> -		vsc73xx_read(vsc, VSC73XX_BLOCK_ARBITER, 0,
> -			     VSC73XX_ARBEMPTY, &val);
> -		while (!(val & BIT(port))) {
> -			msleep(1);
> -			vsc73xx_read(vsc, VSC73XX_BLOCK_ARBITER, 0,
> -				     VSC73XX_ARBEMPTY, &val);
> -			if (--maxloop == 0) {
> -				dev_err(vsc->dev,
> -					"timeout waiting for block arbiter\n");
> -				/* Continue anyway */
> -				break;
> -			}
> -		}
> +		ret = read_poll_timeout(vsc73xx_read, err,
> +					err < 0 || (val & BIT(port)),
> +					1000, 10000, false,

Some #defines for 1000 and 10000 please (VSC73XX_ARBITER_SLEEP_US,
VSC73XX_ARBITER_TIMEOUT_US)?

> +					vsc, VSC73XX_BLOCK_ARBITER, 0,
> +					VSC73XX_ARBEMPTY, &val);
> +		if (ret)
> +			dev_err(vsc->dev,
> +				"timeout waiting for block arbiter\n");
> +		else if (err < 0)
> +			dev_err(vsc->dev, "error reading arbiter\n");
>  
>  		/* Put this port into reset */
>  		vsc73xx_write(vsc, VSC73XX_BLOCK_MAC, port, VSC73XX_MAC_CFG,
> -- 
> 2.34.1
> 

