Return-Path: <linux-kernel+bounces-67194-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 67B458567DD
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 16:34:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8486D1C232B9
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 15:34:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58C7713473F;
	Thu, 15 Feb 2024 15:31:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XxJ2RWLJ"
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7684F133431;
	Thu, 15 Feb 2024 15:31:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708011089; cv=none; b=KK2QrWBPZGl4/0Sc3dKAnHytgtQZYN6XaLXta8LxA+g6CWd2q7wCcMog4YbVkBLCJEPyuymeF7fxFBhXKkpkqgiXGphXOrXYqktheiME6msnfarmRN8qKZiU5j4HN1ZbTeX077woM2dmcxuZr+d0P1jy4ja1Y9FlWnxsC8nbaDU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708011089; c=relaxed/simple;
	bh=7vl1kCkvjz6scu8vDPSkvjGYnpAchzHZHbEVrVnvb1o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=l+yR7ZPnVBgXoIqowNBjfU4Fb4vaWNtjrjDGQDR5I/cAC+SuMeaKJh5UU6dFcbvTKQPoX7ZkEn6mQcBKZPQakpyHCGVtZ7KBfNoFQrOmWWLiExMiAlfBb3mLGfPpK/5Wp/d8HYMMpMLjD9LClrmgLSqOWZeKUPCRBxzVqKS82P0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XxJ2RWLJ; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-a26fa294e56so150451366b.0;
        Thu, 15 Feb 2024 07:31:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708011085; x=1708615885; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=r7UD9avYlTfXdKicyv5fR2h38R4kWgYZjYIwKPNJrUc=;
        b=XxJ2RWLJfP2Sz8PGOptewdceV+VGA28b9hwMGmIjCQEjEgIL8BLc+sIGJjErxtEMmZ
         mUrAua5fI85mGCokvfI7u7r/2PXjJCvaUZljfn6sZubtyA8018r0593G3/Ey+H8UFecZ
         h2Bk0VZUU8VCvwx/yXFje30hzcAPZ/q3ZTKCjVvFM3Za2pYCTklFIKoSZKZTdqFNqRJH
         tCoQyiYaVZNwR0GNECnD1sygh51Pw9Cpnw0p0/QoUAfo0xSPVzq2sWzg878UNKMgQowh
         094DnDCl8PeQOANTrPBir2FwfzQHtrEnQdIjqQEEONF/SiQKB9yKtiKhGrDhxe/t4Lwf
         gSPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708011085; x=1708615885;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=r7UD9avYlTfXdKicyv5fR2h38R4kWgYZjYIwKPNJrUc=;
        b=eMm1j8JG4tCaUvrx9xCf0gGSHg2C3krqLrcX4dovbpr+fij3hSrMOJWpuOPdLK6yWJ
         w38uspv0H0Ox4U2rNcwlqLWc1bVtYhGn4oD49RQl9CzuLagt3wJXGYntHVJo+cxeTBQq
         wOeMKRwxrysWjKb2+5OTx1dsZU3XKXHr9tAir5PXEual3Fek8yTe78rRLZwU55QTg9xq
         pUi5KayL4MVVGIgobQbkQp2BXU34K+YXptOKHH5FJMor9Dx0xeKLHk7nc/5os9ehx3fL
         AcggN7w56BmXG0gk1aLKNMHuG+SLVhLM/Ova6FNA80uEvry7k0kMapczxdCRzGnFLmxy
         xeHw==
X-Forwarded-Encrypted: i=1; AJvYcCWvvtgmEWh9p15N2FMH1BYIaGEwLZlYrrBmHAbl7UraaR8LTc8TfnSIJwZeABYf1KoL6jXVw9YLKl19xeksULscge9rGeWh8w6CRrKj
X-Gm-Message-State: AOJu0YybfRHms45Jj48eJiocwgfX3+kPsRTdRXgzGOugs5ivOYyn1/jv
	wQAggcOxD2hb8yZwgazEpQqW6c8QQAzNrUpp0Wg/W8lGiZDwUuwk
X-Google-Smtp-Source: AGHT+IFHGM699ejx+gQ04Gkuc8hUd0L+PgWyXlHMws9CqpaAFmuNVotAZcmTtYRuv5faDGNi10tHJA==
X-Received: by 2002:a17:906:280c:b0:a3d:78a:bffa with SMTP id r12-20020a170906280c00b00a3d078abffamr1894987ejc.0.1708011084305;
        Thu, 15 Feb 2024 07:31:24 -0800 (PST)
Received: from skbuf ([188.25.173.195])
        by smtp.gmail.com with ESMTPSA id md8-20020a170906ae8800b00a3d581658bfsm673007ejb.24.2024.02.15.07.31.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Feb 2024 07:31:23 -0800 (PST)
Date: Thu, 15 Feb 2024 17:31:21 +0200
From: Vladimir Oltean <olteanv@gmail.com>
To: Pawel Dembicki <paweldembicki@gmail.com>
Cc: netdev@vger.kernel.org, linus.walleij@linaro.org,
	Andrew Lunn <andrew@lunn.ch>,
	Florian Fainelli <f.fainelli@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Claudiu Manoil <claudiu.manoil@nxp.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	UNGLinuxDriver@microchip.com, Russell King <linux@armlinux.org.uk>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v4 06/15] net: dsa: vsc73xx: add
 port_stp_state_set function
Message-ID: <20240215153121.ixvcgalqk3w5f5rg@skbuf>
References: <20240213220331.239031-1-paweldembicki@gmail.com>
 <20240213220331.239031-1-paweldembicki@gmail.com>
 <20240213220331.239031-7-paweldembicki@gmail.com>
 <20240213220331.239031-7-paweldembicki@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240213220331.239031-7-paweldembicki@gmail.com>
 <20240213220331.239031-7-paweldembicki@gmail.com>

On Tue, Feb 13, 2024 at 11:03:19PM +0100, Pawel Dembicki wrote:
> This isn't a fully functional implementation of 802.1D, but
> port_stp_state_set is required for a future tag8021q operations.
> 
> This implementation handles properly all states, but vsc73xx doesn't
> forward STP packets.
> 
> Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
> Signed-off-by: Pawel Dembicki <paweldembicki@gmail.com>
> ---
> v4:
>   - fully reworked port_stp_state_set

A "fully reworked" patch isn't exactly compatible with keeping attached
Reviewed-by tags attached to the patch. It implies Linus didn't actually
review the code you are submitting now.

> v3:
>   - use 'VSC73XX_MAX_NUM_PORTS' define
>   - add 'state == BR_STATE_DISABLED' condition
>   - fix style issues
> v2:
>   - fix kdoc
> 
>  drivers/net/dsa/vitesse-vsc73xx-core.c | 83 ++++++++++++++++++++++++--
>  1 file changed, 77 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/net/dsa/vitesse-vsc73xx-core.c b/drivers/net/dsa/vitesse-vsc73xx-core.c
> index 75597daaad17..1dca3c476fac 100644
> --- a/drivers/net/dsa/vitesse-vsc73xx-core.c
> +++ b/drivers/net/dsa/vitesse-vsc73xx-core.c
> @@ -163,6 +163,10 @@
>  #define VSC73XX_AGENCTRL	0xf0
>  #define VSC73XX_CAPRST		0xff
>  
> +#define VSC73XX_SRCMASKS_CPU_COPY		BIT(27)
> +#define VSC73XX_SRCMASKS_MIRROR			BIT(26)
> +#define VSC73XX_SRCMASKS_PORTS_MASK		GENMASK(7, 0)
> +
>  #define VSC73XX_MACACCESS_CPU_COPY		BIT(14)
>  #define VSC73XX_MACACCESS_FWD_KILL		BIT(13)
>  #define VSC73XX_MACACCESS_IGNORE_VLAN		BIT(12)
> @@ -619,9 +623,6 @@ static int vsc73xx_setup(struct dsa_switch *ds)
>  	vsc73xx_write(vsc, VSC73XX_BLOCK_SYSTEM, 0, VSC73XX_GMIIDELAY,
>  		      VSC73XX_GMIIDELAY_GMII0_GTXDELAY_2_0_NS |
>  		      VSC73XX_GMIIDELAY_GMII0_RXDELAY_2_0_NS);
> -	/* Enable reception of frames on all ports */
> -	vsc73xx_write(vsc, VSC73XX_BLOCK_ANALYZER, 0, VSC73XX_RECVMASK,
> -		      0x5f);
>  	/* IP multicast flood mask (table 144) */
>  	vsc73xx_write(vsc, VSC73XX_BLOCK_ANALYZER, 0, VSC73XX_IFLODMSK,
>  		      0xff);
> @@ -841,9 +842,6 @@ static void vsc73xx_phylink_mac_link_up(struct dsa_switch *ds, int port,
>  	if (duplex == DUPLEX_FULL)
>  		val |= VSC73XX_MAC_CFG_FDX;
>  
> -	/* Enable port (forwarding) in the receieve mask */
> -	vsc73xx_update_bits(vsc, VSC73XX_BLOCK_ANALYZER, 0,
> -			    VSC73XX_RECVMASK, BIT(port), BIT(port));
>  	vsc73xx_adjust_enable_port(vsc, port, val);
>  }
>  
> @@ -1026,6 +1024,78 @@ static void vsc73xx_phylink_get_caps(struct dsa_switch *dsa, int port,
>  	config->mac_capabilities = MAC_SYM_PAUSE | MAC_10 | MAC_100 | MAC_1000;
>  }
>  
> +static void vsc73xx_refresh_fwd_map(struct dsa_switch *ds, int port, bool configure)

Why have you chosen the name "bool configure" exactly? It is not
intuitive. Could you just pass the STP state of the port as an argument?

> +{
> +	struct dsa_port *dp = dsa_to_port(ds, port);
> +	struct vsc73xx *vsc = ds->priv;
> +	int i;
> +
> +	if (configure) {
> +		u16 mask = BIT(CPU_PORT);
> +
> +		vsc73xx_update_bits(vsc, VSC73XX_BLOCK_ANALYZER, 0,
> +				    VSC73XX_SRCMASKS + CPU_PORT, BIT(port), BIT(port));
> +
> +		if (dp->bridge) {
> +			struct dsa_port *other_dp;
> +
> +			dsa_switch_for_each_user_port(other_dp, ds) {
> +				if (other_dp->bridge == dp->bridge &&
> +				    other_dp->index != port &&
> +				    other_dp->stp_state == BR_STATE_FORWARDING) {
> +					int other_port = other_dp->index;
> +
> +					mask |= BIT(other_port);
> +					vsc73xx_update_bits(vsc, VSC73XX_BLOCK_ANALYZER, 0,
> +							    VSC73XX_SRCMASKS + other_port,
> +							    BIT(port), BIT(port));
> +				}
> +			}
> +		}
> +
> +		vsc73xx_update_bits(vsc, VSC73XX_BLOCK_ANALYZER, 0, VSC73XX_SRCMASKS + port,
> +				    VSC73XX_SRCMASKS_PORTS_MASK, mask);
> +	} else {
> +		for (i = 0; i < vsc->ds->num_ports; i++) {

Try to refrain from doing plain integer iterations through ports when
there are holes in the port indices. Use dsa_switch_for_each_available_port()
which skips the unused/absent ports, and consequently you're not
touching unwanted registers.

> +			if (i == port)
> +				vsc73xx_update_bits(vsc, VSC73XX_BLOCK_ANALYZER, 0,
> +						    VSC73XX_SRCMASKS + i,
> +						    VSC73XX_SRCMASKS_PORTS_MASK, 0);
> +			else
> +				vsc73xx_update_bits(vsc, VSC73XX_BLOCK_ANALYZER, 0,
> +						    VSC73XX_SRCMASKS + i, BIT(port), 0);
> +		}
> +	}

To save on indentation, I would simplify the big if () else () block
like this.

	if (state != BR_STATE_FORWARDING) {
		/* Ports that aren't in the forwarding state must not
		 * forward packets anywhere.
		 */
		vsc73xx_update_bits(vsc, VSC73XX_BLOCK_ANALYZER, 0,
				    VSC73XX_SRCMASKS + port,
				    VSC73XX_SRCMASKS_PORTS_MASK, 0);

		dsa_switch_for_each_available_port(other_dp, ds) {
			if (dp == other_dp)
				continue;

			vsc73xx_update_bits(vsc, VSC73XX_BLOCK_ANALYZER, 0,
					    VSC73XX_SRCMASKS + other_dp->index,
					    BIT(port), 0);
		}

		return;
	}

	/* Forwarding ports must forward to the CPU and to other ports
	 * in the same bridge
	 */
	vsc73xx_update_bits(vsc, VSC73XX_BLOCK_ANALYZER, 0,
			    VSC73XX_SRCMASKS + CPU_PORT, BIT(port), BIT(port));

	mask = BIT(CPU_PORT);

	if (dp->bridge) {
		struct dsa_port *other_dp;

		dsa_switch_for_each_user_port(other_dp, ds) {
			if (other_dp->bridge == dp->bridge &&
			    other_dp->index != port &&
			    other_dp->stp_state == BR_STATE_FORWARDING) {
				int other_port = other_dp->index;

				mask |= BIT(other_port);
				vsc73xx_update_bits(vsc, VSC73XX_BLOCK_ANALYZER, 0,
						    VSC73XX_SRCMASKS + other_port,
						    BIT(port), BIT(port));
			}
		}
	}

	vsc73xx_update_bits(vsc, VSC73XX_BLOCK_ANALYZER, 0, VSC73XX_SRCMASKS + port,
			    VSC73XX_SRCMASKS_PORTS_MASK, mask);

> +}
> +
> +/* FIXME: STP frames aren't forwarded at this moment. BPDU frames are
> + * forwarded only from and to PI/SI interface. For more info see chapter
> + * 2.7.1 (CPU Forwarding) in datasheet.
> + * This function is required for tag8021q operations.

Please keep the name consistent at "tag_8021q".

> + */
> +

nitpick: remove the blank line.

> +static void vsc73xx_port_stp_state_set(struct dsa_switch *ds, int port, u8 state)
> +{
> +	struct vsc73xx *vsc = ds->priv;
> +	u32 val;
> +
> +	val = (state == BR_STATE_BLOCKING || state == BR_STATE_DISABLED) ?
> +	      0 : BIT(port);
> +	vsc73xx_update_bits(vsc, VSC73XX_BLOCK_ANALYZER, 0,
> +			    VSC73XX_RECVMASK, BIT(port), val);
> +
> +	val = (state == BR_STATE_LEARNING || state == BR_STATE_FORWARDING) ?
> +	      BIT(port) : 0;
> +	vsc73xx_update_bits(vsc, VSC73XX_BLOCK_ANALYZER, 0,
> +			    VSC73XX_LEARNMASK, BIT(port), val);

I am extremely particular about this. Please also implement .port_pre_bridge_flags()
and .port_bridge_flags(), and treat the BR_LEARNING flag. The idea is
that standalone ports are in the BR_STATE_FORWARDING state (it's a DSA
API thing), but learning should _not_ be enabled (it breaks things when
one port sees traffic originated from the other). So you need to set the
bit in VSC73XX_LEARNMASK only if the port is in the BR_STATE_LEARNING ||
BR_STATE_FORWARDING, _and_ the BR_LEARNING flag is set.

This should be relatively easy to do. If you're not going to do it now
because of patch set size constraints, at least leave a big FIXME in the
code or in the commit message.

> +
> +	/* CPU Port should always forward packets when user ports are forwarding
> +	 * so let's configure it from other ports only.
> +	 */
> +	if (port != CPU_PORT)
> +		vsc73xx_refresh_fwd_map(ds, port, state == BR_STATE_FORWARDING);
> +}
> +
>  static const struct dsa_switch_ops vsc73xx_ds_ops = {
>  	.get_tag_protocol = vsc73xx_get_tag_protocol,
>  	.setup = vsc73xx_setup,
> @@ -1041,6 +1111,7 @@ static const struct dsa_switch_ops vsc73xx_ds_ops = {
>  	.port_disable = vsc73xx_port_disable,
>  	.port_change_mtu = vsc73xx_change_mtu,
>  	.port_max_mtu = vsc73xx_get_max_mtu,
> +	.port_stp_state_set = vsc73xx_port_stp_state_set,
>  	.phylink_get_caps = vsc73xx_phylink_get_caps,
>  };
>  
> -- 
> 2.34.1
> 


