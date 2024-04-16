Return-Path: <linux-kernel+bounces-146713-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C6DFE8A69BC
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 13:38:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E9A141C2107B
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 11:38:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 224F2129A71;
	Tue, 16 Apr 2024 11:38:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aiXjuupn"
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8DAC1292DB;
	Tue, 16 Apr 2024 11:38:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713267514; cv=none; b=vAZT66l7kRCp5Wc3+17047x+CKdd5D0ibYFR6JBTaTSlrSjIjYttjp2tw6BHT8qxlACZPK8bHHzKBL15M84IRG8tx3ZnDaiOTA4pn29wGpZJARB8kNdMa2K9Pu5G8IIbRnTQsIdovT+ohetSBnl7Wgibdn1vvTW77mzOOr1QvmA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713267514; c=relaxed/simple;
	bh=NIRfjbxBKlUF6UYKXQ9bPrhaNs+Ht9ITk6Oi0xFaqV0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aH0FHOolsv45f7veyorFFr1BbjmOB5Z0DsUk58Q7TNJNfAwwATF+7x/Mb00nP4aHFMDR7+3v0OjoFa4g7UPUcpuDVft5piFxzUu+nojAd766KHTho2G0lFJvQFsE2SIRhvcKpmxljpl8BGcrlWKWSHfnXoGvpCfm+ckx2uoNiuA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aiXjuupn; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-516f2e0edb7so5207646e87.1;
        Tue, 16 Apr 2024 04:38:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713267511; x=1713872311; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=3imXpN/x1JQtEA6zkUwudIXWS06IjOEYxP3aQIvEud0=;
        b=aiXjuupndvujWxncgReWgUH0eskEie/9LTEh8pssGvoFQo+ukmfrpp4GI6DCsSAnNv
         LaNDMwYNvLZdhd7y48m1kiifwYZcSYzogflePBuXIqCYFmkHFj5YKZZzJVm7Ykh5C+5p
         FygpGP/pquTHPomJsEhJZM7jN+zIOq8oqO1TExrK2ENkjI9V5wLK941aV6+0B0oz0eNY
         9JBEmQHxLYp+v0TIWF3kXcXrBS/KHwSpGQo7phfpJoggfi3sA6llzI0R7AYOT0MAWQN6
         SJrSlifY+0kI+KhPiOyBrVTurZYffsD0/++Qh5evED8SARknLWQ129nTCeJSE+hbm2SX
         gktg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713267511; x=1713872311;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3imXpN/x1JQtEA6zkUwudIXWS06IjOEYxP3aQIvEud0=;
        b=Wl7HwmVmGz04rpYWFoqWIiJi5cp4gAqRPgFMz1tfzhabqIbOornOE1qLaWAaqReMGy
         ZurEw+brn0alKQrRnLzu1qeJpbz41fTiD4JyejImGmmoqu5+ViUA9k+tiIPfZ+JblMfy
         TxrqCZshzrrUVmUbTqzAfwqd1tHShvVuCIJ8lsLJpfPKUWNPB8XTw/zy2GirCXaL3lnp
         F7OeKj77HiqNaOO6d7UNmSgAYhRMnTSRh5CEJ/Lv4bQwaHRDQuAGF6myT1A8xEHDIOq7
         Dky4MNGfyPNuAP/Zlo1HpJKk0/lhUbXeEf2Jc2abBWdmhm6Ti+mQ4Ntp8PLOjzDjNVTp
         fMHw==
X-Forwarded-Encrypted: i=1; AJvYcCWPZo+m7eQrIHS3KgW2acvmbGe1VPlv50Z8F8+469L1f8gZMiEiD5mJUzptSpv8qRGt97eFTD2bhGyAVoPjUnSxojbddkUoJfp6Bh/1Sy/Wp0BEMUmLEZ8HwZrXvj3sexf25HIb
X-Gm-Message-State: AOJu0YyCm+EJVzjSpliXViwdUuot6tXYu+6dfnWc0Dyrx8FvMP6Sl3Ak
	a8Xsvhm1aMgD/mcdcfkIyRQOV6R7t24/NqM5WHE2srS5nR2ls0mv
X-Google-Smtp-Source: AGHT+IFsv1t50cVsn9xtvOjs4g4KFGJI0LdCIc6Wa6MGsoQY1SUEtRqNz2Pjjzjb2zJlDyUmdLuf3A==
X-Received: by 2002:ac2:528c:0:b0:518:7e4a:2035 with SMTP id q12-20020ac2528c000000b005187e4a2035mr7410480lfm.45.1713267510734;
        Tue, 16 Apr 2024 04:38:30 -0700 (PDT)
Received: from mobilestation ([213.79.110.82])
        by smtp.gmail.com with ESMTPSA id bp22-20020a056512159600b00518e96b85b0sm568727lfb.234.2024.04.16.04.38.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Apr 2024 04:38:30 -0700 (PDT)
Date: Tue, 16 Apr 2024 14:38:28 +0300
From: Serge Semin <fancer.lancer@gmail.com>
To: Romain Gantois <romain.gantois@bootlin.com>
Cc: Alexandre Torgue <alexandre.torgue@foss.st.com>, 
	Jose Abreu <joabreu@synopsys.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Russell King <linux@armlinux.org.uk>, 
	Yanteng Si <siyanteng@loongson.cn>, Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
	Simon Horman <horms@kernel.org>, Huacai Chen <chenhuacai@kernel.org>, 
	Chen-Yu Tsai <wens@csie.org>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
	Samuel Holland <samuel@sholland.org>, netdev@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com, 
	linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 4/4] net: stmmac: Move MAC caps init to phylink
 MAC caps getter
Message-ID: <btgxb3ugs4apjvxj5hmpec3rtoxwdal7ms2z4s7pecdfefphiw@gd7ctqsh7wg2>
References: <20240412180340.7965-1-fancer.lancer@gmail.com>
 <20240412180340.7965-5-fancer.lancer@gmail.com>
 <714199e5-edf2-dcbb-216b-563431d70488@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <714199e5-edf2-dcbb-216b-563431d70488@bootlin.com>

Hi Romain

On Tue, Apr 16, 2024 at 09:56:32AM +0200, Romain Gantois wrote:
> Hi Serge,
> 
> On Fri, 12 Apr 2024, Serge Semin wrote:
> 
> > +static unsigned long stmmac_mac_get_caps(struct phylink_config *config,
> > +					 phy_interface_t interface)
> > +{
> > +	struct stmmac_priv *priv = netdev_priv(to_net_dev(config->dev));
> > +
> > +	/* Get the MAC-specific capabilities */
> > +	stmmac_mac_phylink_get_caps(priv);
> 
> This is a bit of a nitpick, but the terminology is quite confusing between 
> stmmac_mac_phylink_get_caps() and stmmac_mac_get_caps().

Right, the naming turns to be ambiguous "a bit".)

> Ideally, we could just 
> get rid of the whole stmmac_do_void_callback() complexity and just call 
> phylink_get_caps() directly.

No, this isn't a good solution. The local coding convention implies
using the macro-functions implemented to execute the callbacks. We
can't use the macros everywhere but in this place.

> In the meantime, maybe renaming this to 
> stmmac_mac_core_get_caps() would be acceptable?

The name was selected to align with the rest of the PHYLINK callbacks:

static const struct phylink_mac_ops stmmac_phylink_mac_ops = {
        .mac_get_caps = stmmac_mac_get_caps,
        .mac_select_pcs = stmmac_mac_select_pcs,
        .mac_config = stmmac_mac_config,
        .mac_link_down = stmmac_mac_link_down,
        .mac_link_up = stmmac_mac_link_up,
};

So I don't think that changing it to something different would be a
good alternative. What could be a better option is to rename the
stmmac_ops::phylink_get_caps() callback and
stmmac_mac_phylink_get_caps() macro-function to something like:

stmmac_ops::link_update_caps()
stmmac_mac_link_update_caps()

especially seeing the callback no longer sets the phylink MAC
capabilities directly. What do you think?

-Serge(y)

> 
> Please let me know what you think.
> 
> Thanks,
> 
> -- 
> Romain Gantois, Bootlin
> Embedded Linux and Kernel engineering
> https://bootlin.com

