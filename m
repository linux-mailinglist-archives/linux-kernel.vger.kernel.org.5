Return-Path: <linux-kernel+bounces-133235-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DBE589A0FE
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 17:25:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A07311C235CA
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 15:25:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0015C16F90B;
	Fri,  5 Apr 2024 15:25:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PBeKJNVc"
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76ADB16F27D;
	Fri,  5 Apr 2024 15:25:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712330709; cv=none; b=jF1BBZyPoketxWnko19NZCb9S6EG3X5WyGaOLOuHGL0UjNFlgPGEZnBW7YU3Hnoohp6qATof38ARYTsD0CgJuZkVdliDscrESy3If46f5SYzWXiWhwS+MnAgJQCASxz2PUCbhGpyKx6st3MALVBXLZBbD3n0JAgZLhU4p6bSOY8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712330709; c=relaxed/simple;
	bh=PAxYQH0nqngIa5c83U5GYyoBUN9IQi1r2j+0wAE7N3s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nK48WlmX3/W34v1s8cZjs1GkIsP7H51RCrmOaHaK/RwWgNMo2GTMnl7fIiFD65AFUaQk0tK0x5Nwd7tFxUTk+mu86KAM3TOEoldWYefahC514g5EkVCr+5ONu4x+7asNpsoc4uGmV0NtPvDEW/N/IsZfMTbB95lGm2FltUw4JbU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PBeKJNVc; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-a4a393b699fso388725866b.0;
        Fri, 05 Apr 2024 08:25:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712330706; x=1712935506; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Lu+Hj8riJMjp8b2OVIDj4dkzNvAkKOcq97y/I5O3guk=;
        b=PBeKJNVcRP+MWVc7M9M/0Maa4uYH+hMYTR10fRufs+61o1CJxqH7m9lmyPqaWu/7Xf
         1s4dRQ9ETIIZH6QJbL6auASEOOmZ+Sr8RvBo9unvJ4zp8DAWpQ98NTGYydcHI6edUG+6
         dlUK4o+uCkaGzzIqVinKX8K4M4fCp8jXML0M1rltH+2i0v/DqxleETKJBMZovCZZ9T9o
         hWeFY5xIpAnefv5sVXX3O5XwERz90Cr1KC9m7w/oZFizSeaMyestK53jD2Nq6cBRvfNi
         a5ggt5HKcibdo9SbUyAcjI3adooUtLJJWzvy62zp80cQH+gG83x7EwKKBiK0ra8XtOE9
         MTVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712330706; x=1712935506;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Lu+Hj8riJMjp8b2OVIDj4dkzNvAkKOcq97y/I5O3guk=;
        b=Irm+dRr/d1IM315uyomlOEwBrfY0grGW/r5x+QMworsdZIN+AZSG1RIxaNgX1jbmvG
         YbXDY1BHIuhIJrVpYTtNZIH772bvrmgvmMSZuNJdPhHa/u2cdXnDtmRhZetaQXf0aWxI
         W80wj62Dy+vlwAPP6iJgJq760yL2KIM09JPNnP+Rh3++Z0tQdPMx/xlq1k5TOA8KJi6T
         iGOOC9rcYhQl3A9fSeYwd8nlAcNtJkQMzUMgz/E1GwrD3q8Xdwl2RT74LGumPJwPzjLM
         ifLSS0gc+4rY+QrewIuyircndrdDT0Er8jSOFH4KTmmvtqw3ijj4RY1ePPbxUiQO61N7
         6OSw==
X-Forwarded-Encrypted: i=1; AJvYcCXYggExE1UwoDkx83wTRRHoeanPV0K3zItn+LAfdOoP8chrgEV3lbQyCIgCaoDBOwPHSqrvgWQewNyjymDTpByAVZaWO2T2LKp+mu4U
X-Gm-Message-State: AOJu0Yz/KkrwyP7xtuhU/gIpva04cOEt1Wv1K2t85MNCav1A/0OqWk0b
	dtc8BhNh1d3u8NhSR+DBwTUUdD06xmfF8dfzcYuu5tL8l78jFr7VR6zYjUmsEYA=
X-Google-Smtp-Source: AGHT+IF3mPsWoszFNM80Yb/6z0v+v+2zLnSfa3H33asGWn8xzhfBSkE9M0qjGEQmsNkkUfqfMEy3LQ==
X-Received: by 2002:a17:907:a088:b0:a51:a288:4a4b with SMTP id hu8-20020a170907a08800b00a51a2884a4bmr2699103ejc.10.1712330705414;
        Fri, 05 Apr 2024 08:25:05 -0700 (PDT)
Received: from skbuf ([2a02:2f04:d700:2000::b2c])
        by smtp.gmail.com with ESMTPSA id h21-20020a1709066d9500b00a4dacd6b8b3sm952222ejt.68.2024.04.05.08.25.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Apr 2024 08:25:04 -0700 (PDT)
Date: Fri, 5 Apr 2024 18:25:02 +0300
From: Vladimir Oltean <olteanv@gmail.com>
To: Pawel Dembicki <paweldembicki@gmail.com>
Cc: netdev@vger.kernel.org, Linus Walleij <linus.walleij@linaro.org>,
	Simon Horman <horms@kernel.org>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Florian Fainelli <f.fainelli@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Claudiu Manoil <claudiu.manoil@nxp.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	UNGLinuxDriver@microchip.com, Russell King <linux@armlinux.org.uk>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v8 15/16] net: dsa: vsc73xx: Add bridge support
Message-ID: <20240405152502.wapf4btqq3dtqeq2@skbuf>
References: <20240403103734.3033398-1-paweldembicki@gmail.com>
 <20240403103734.3033398-1-paweldembicki@gmail.com>
 <20240403103734.3033398-16-paweldembicki@gmail.com>
 <20240403103734.3033398-16-paweldembicki@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240403103734.3033398-16-paweldembicki@gmail.com>
 <20240403103734.3033398-16-paweldembicki@gmail.com>

On Wed, Apr 03, 2024 at 12:37:31PM +0200, Pawel Dembicki wrote:
> This patch adds bridge support for vsc73xx driver.
> It introduce two functions for port_bridge_join and
> vsc73xx_port_bridge_leave handling.
> 
> Those functions implement forwarding adjust and use
> dsa_tag_8021q_bridge_* api for adjust VLAN configuration.
> 
> Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
> Signed-off-by: Pawel Dembicki <paweldembicki@gmail.com>
> Reviewed-by: Vladimir Oltean <olteanv@gmail.com>
> Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
> ---
> diff --git a/drivers/net/dsa/vitesse-vsc73xx-core.c b/drivers/net/dsa/vitesse-vsc73xx-core.c
> index d0442ea8a610..87922804d1c1 100644
> --- a/drivers/net/dsa/vitesse-vsc73xx-core.c
> +++ b/drivers/net/dsa/vitesse-vsc73xx-core.c
> +static int vsc73xx_port_bridge_join(struct dsa_switch *ds, int port,
> +				    struct dsa_bridge bridge,
> +				    bool *tx_fwd_offload,
> +				    struct netlink_ext_ack *extack)
> +{
> +	*tx_fwd_offload = true;
> +
> +	return dsa_tag_8021q_bridge_join(ds, port, bridge);
> +}
> +
> +static void vsc73xx_port_bridge_leave(struct dsa_switch *ds, int port,
> +				      struct dsa_bridge bridge)
> +{
> +	dsa_tag_8021q_bridge_leave(ds, port, bridge);
> +}
> +
>  static int vsc73xx_port_setup(struct dsa_switch *ds, int port)
>  {
>  	struct vsc73xx_portinfo *portinfo;
> @@ -1708,6 +1727,8 @@ static const struct dsa_switch_ops vsc73xx_ds_ops = {
>  	.port_setup = vsc73xx_port_setup,
>  	.port_enable = vsc73xx_port_enable,
>  	.port_disable = vsc73xx_port_disable,
> +	.port_bridge_join = vsc73xx_port_bridge_join,
> +	.port_bridge_leave = vsc73xx_port_bridge_leave,
>  	.port_change_mtu = vsc73xx_change_mtu,
>  	.port_max_mtu = vsc73xx_get_max_mtu,
>  	.port_stp_state_set = vsc73xx_port_stp_state_set,
> -- 
> 2.34.1
> 

Making a mental note here, out loud, that after this patch set is
merged, "*tx_fwd_offload = true" should be absorbed into
dsa_tag_8021q_bridge_join(). Then, you could simply point
ds->ops->port_bridge_join() and ds->ops->port_bridge_leave() to the
generic tag_8021q methods, without the need for intermediary shims.

Looking at my upcoming schedule, I'll probably forget. Could you please
try to remember to do it?

