Return-Path: <linux-kernel+bounces-96782-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 91D5787615A
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 10:55:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1E6351F229D1
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 09:55:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA08353E1B;
	Fri,  8 Mar 2024 09:54:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eCh/g4jq"
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69137535A3;
	Fri,  8 Mar 2024 09:54:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709891689; cv=none; b=Wvszyko43yUQqi5+rFQ+NYwx4Yr345zUPa8QGxXESvYUS8aB/rSRpXMLq981F/YGUtd5YIcRAb3S6epYFy5Th7tU+nKnFFs3eZnQwHXK3YuMZoFv+sABwNtBGVNIOE1BjmdMPZFFXO6s+9v8g2yvd2OU4QSvboekHXz21d3H27s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709891689; c=relaxed/simple;
	bh=9+F2N1xirgPO1B/K5OKBxAdcA6ZxVjinMYU43eppFog=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MtvT7YfW4n5PqNcUqyrvsxC5qQzcetkAE1crvukdsnBysTBr2/wxUidlzBbcDPO9ksTcvQ1XFDdqla0nEhXvq2hWwTy22wDcfLia7MpFKtxjJajJTeSOjFwqe+yre6tIEFsHfD9PPA0SxqK1GT2JfJC4R98bdpU/XBNPBef1jC8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eCh/g4jq; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-a28a6cef709so97677466b.1;
        Fri, 08 Mar 2024 01:54:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709891686; x=1710496486; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=lx3npHykkw1gOdQqXLW5o/F+B78jLU3tilBWulRgUu0=;
        b=eCh/g4jqDMU+DIb1Xuo1g8UFa5GVdj/eOurzpE/mpP1FGEPS3sUsGP4obd4q3jv0ot
         Ynuj/+oUSaGg/8tnJx9tpbMj6k+McA5J9dUiuu8DcNz5hGiltVHHO+ekneafIo2ibRVi
         n9Lugq8Bl+Ylthl0D0tTCTDiGNd5GsvC0Id2y2i/CK9eEH72RkUoNZ1MMVbqNBUgc/0I
         bkQhNx8GxFynienzKMMQ6ZoEdzniNdzY4Ib39m8zgfkT5TAZnKcvllhhEQbwSa9oC/D4
         GTqUICVsz1b2cfLAk2DOpHsp2JhEbLL43/y/VCTNyO3/KQR87q6vzLZzopl3SLsOHqZF
         M9VQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709891686; x=1710496486;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lx3npHykkw1gOdQqXLW5o/F+B78jLU3tilBWulRgUu0=;
        b=Bz4UJb4PISRHtTtyfKhH/3uHeNNsZOeYH62EYfphS7QiE6sXOsRaeAr//rDFdi+42B
         Pg1sSRRaEG1wOFr+juEINd5SFuMmewExqZoeLnMMid2OJndF/+57MVB3/V1IygZnCIZb
         5k/wa3uCRYms4nVovBs0snaOTORPIlMMZnqYGVq/jswzTpKvIvnhRLS3zKaMo2LB3Lag
         PQwoCAF6Pz8DfgISSCqzrZr+ylZZh7O3iFPZDMLb0UknBzbxTVEeZNaSeuDy5NuzFCuf
         OnfV61gARZpVqGHyQgp38IYwJbnyrXBwxtL/ATAiC2MOqHcJxKv50nZdCAVj2QRK2QUM
         FZtA==
X-Forwarded-Encrypted: i=1; AJvYcCXOdGh1bgpA2CX7qwRB3VcORWFEU28VUPR4Ikpi1drSPejaOK+90I/g0slGPNjDFAzrURmY9rOpdm47oACZT59A7R7MM+Zms7IbZPIo
X-Gm-Message-State: AOJu0YzF/ULrOdMRgXUuwm6K+yPGBK7OrjxKRHBnPMdmCrsmei8oIaIw
	DAupka6vS/JM9FevwAm0c7PqA0EUrL0xAbaqmoqLpGvK4V8b1Lq2
X-Google-Smtp-Source: AGHT+IF38PLd9vqK/V55Sk1fgDRHT28mC+PYjI17HoOSs0pCHtJdQhnEXF3SzRGotS0o/cQ2MQuZAg==
X-Received: by 2002:a17:906:f850:b0:a45:bdc0:7f00 with SMTP id ks16-20020a170906f85000b00a45bdc07f00mr4849698ejb.46.1709891685642;
        Fri, 08 Mar 2024 01:54:45 -0800 (PST)
Received: from skbuf ([2a02:2f04:d207:f600::b2c])
        by smtp.gmail.com with ESMTPSA id cm26-20020a170906f59a00b00a3ca56e9bcfsm9199309ejd.187.2024.03.08.01.54.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Mar 2024 01:54:45 -0800 (PST)
Date: Fri, 8 Mar 2024 11:54:42 +0200
From: Vladimir Oltean <olteanv@gmail.com>
To: Pawel Dembicki <paweldembicki@gmail.com>
Cc: netdev@vger.kernel.org, Linus Walleij <linus.walleij@linaro.org>,
	Simon Horman <horms@kernel.org>, Andrew Lunn <andrew@lunn.ch>,
	Florian Fainelli <f.fainelli@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Claudiu Manoil <claudiu.manoil@nxp.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	UNGLinuxDriver@microchip.com, Russell King <linux@armlinux.org.uk>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v6 06/16] net: dsa: vsc73xx: add
 port_stp_state_set function
Message-ID: <20240308095442.ug4pmh4entgah5l3@skbuf>
References: <20240301221641.159542-1-paweldembicki@gmail.com>
 <20240301221641.159542-1-paweldembicki@gmail.com>
 <20240301221641.159542-7-paweldembicki@gmail.com>
 <20240301221641.159542-7-paweldembicki@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240301221641.159542-7-paweldembicki@gmail.com>
 <20240301221641.159542-7-paweldembicki@gmail.com>

On Fri, Mar 01, 2024 at 11:16:28PM +0100, Pawel Dembicki wrote:
> This isn't a fully functional implementation of 802.1D, but
> port_stp_state_set is required for a future tag8021q operations.
> 
> This implementation handles properly all states, but vsc73xx doesn't
> forward STP packets.
> 
> Signed-off-by: Pawel Dembicki <paweldembicki@gmail.com>
> ---
> v6:
>   - fix inconsistent indenting
> v5:
>   - remove unneeded 'RECVMASK' operations
>   - reorganise vsc73xx_refresh_fwd_map function
> v4:
>   - fully reworked port_stp_state_set
> v3:
>   - use 'VSC73XX_MAX_NUM_PORTS' define
>   - add 'state == BR_STATE_DISABLED' condition
>   - fix style issues
> v2:
>   - fix kdoc
> 
>  drivers/net/dsa/vitesse-vsc73xx-core.c | 99 +++++++++++++++++++++++---
>  1 file changed, 88 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/net/dsa/vitesse-vsc73xx-core.c b/drivers/net/dsa/vitesse-vsc73xx-core.c
> index 425999d7bf41..d1e84a9a83d1 100644
> --- a/drivers/net/dsa/vitesse-vsc73xx-core.c
> +++ b/drivers/net/dsa/vitesse-vsc73xx-core.c
> @@ -1036,6 +1029,89 @@ static void vsc73xx_phylink_get_caps(struct dsa_switch *dsa, int port,
>  	config->mac_capabilities = MAC_SYM_PAUSE | MAC_10 | MAC_100 | MAC_1000;
>  }
>  
> +static void vsc73xx_refresh_fwd_map(struct dsa_switch *ds, int port, u8 state)
> +{
> +	struct dsa_port *other_dp, *dp = dsa_to_port(ds, port);
> +	struct vsc73xx *vsc = ds->priv;
> +	u16 mask;
> +
> +	if (state != BR_STATE_FORWARDING) {
> +		/* Ports that aren't in the forwarding state must not
> +		 * forward packets anywhere.
> +		 */
> +		vsc73xx_update_bits(vsc, VSC73XX_BLOCK_ANALYZER, 0,
> +				    VSC73XX_SRCMASKS + port,
> +				    VSC73XX_SRCMASKS_PORTS_MASK, 0);
> +
> +		dsa_switch_for_each_available_port(other_dp, ds) {
> +			if (other_dp == dp)
> +				continue;
> +			vsc73xx_update_bits(vsc, VSC73XX_BLOCK_ANALYZER, 0,
> +					    VSC73XX_SRCMASKS + other_dp->index,
> +					    BIT(port), 0);
> +		}
> +
> +		return;
> +	}
> +
> +	/* Forwarding ports must forward to the CPU and to other ports
> +	 * in the same bridge
> +	 */
> +	vsc73xx_update_bits(vsc, VSC73XX_BLOCK_ANALYZER, 0,
> +			    VSC73XX_SRCMASKS + CPU_PORT, BIT(port), BIT(port));
> +
> +	mask = BIT(CPU_PORT);
> +
> +	if (dp->bridge) {
> +		dsa_switch_for_each_user_port(other_dp, ds) {
> +			if (other_dp->bridge == dp->bridge &&

You could use dsa_port_bridge_same(dp, other_dp) and that could
eliminate the extra "if (dp->bridge)" condition, because it explicitly
makes standalone ports isolated from other standalone ports.

> +			    other_dp->index != port &&

You could move the "int other_port" definition to dsa_switch_for_each_user_port()
scope, and thus reuse it here.

> +			    other_dp->stp_state == BR_STATE_FORWARDING) {

You could "continue" on the negated condition, and reduce the
indentation one level further.

> +				int other_port = other_dp->index;
> +
> +				mask |= BIT(other_port);
> +				vsc73xx_update_bits(vsc, VSC73XX_BLOCK_ANALYZER,
> +						    0,
> +						    VSC73XX_SRCMASKS +
> +						    other_port,
> +						    BIT(port), BIT(port));
> +			}
> +		}
> +	}

All in all, I would have written this as:

	dsa_switch_for_each_user_port(other_dp, ds) {
		int other_port = other_dp->index;

		if (port == other_port || !dsa_port_bridge_same(dp, other_dp) ||
		    other_dp->stp_state != BR_STATE_FORWARDING)
			continue;

		mask |= BIT(other_port);

		vsc73xx_update_bits(vsc, VSC73XX_BLOCK_ANALYZER, 0,
				    VSC73XX_SRCMASKS + other_port,
				    BIT(port), BIT(port));
	}

Anyway this does not affect functionality, and it is up to you if you
integrate these suggestions or not.

Reviewed-by: Vladimir Oltean <olteanv@gmail.com>

> +
> +	vsc73xx_update_bits(vsc, VSC73XX_BLOCK_ANALYZER, 0,
> +			    VSC73XX_SRCMASKS + port,
> +			    VSC73XX_SRCMASKS_PORTS_MASK, mask);
> +}

