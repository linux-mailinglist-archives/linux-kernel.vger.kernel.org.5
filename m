Return-Path: <linux-kernel+bounces-148519-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CA458A83E7
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 15:12:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AD57AB24BE9
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 13:12:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3239013D8AE;
	Wed, 17 Apr 2024 13:12:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SXBIrMMC"
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FAAF2770B;
	Wed, 17 Apr 2024 13:12:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713359523; cv=none; b=SKiAjHg63Bq1Rts8SLDVnJCVLGENj403leqW1bswptuLoTXyGFHTG955JQXX8eN5MEyCsuQzwZQtz26Fb0SyNSsCT8soASsQcOqbpR7nb3+cq0XeqdE4Gsr9Uu2XSyb7H08kcww8hmmdbIufpKg8GhOpic5DWeOVrh4gluFXxYI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713359523; c=relaxed/simple;
	bh=19fci4LLyfvbsiSMg+CCqqk9ZM2XGVW9YX76UIsPwO8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=X+3S7CumTHEDy/+swoec5jk/p7gV+qS3rLrakMpFERFM1YJKvawLvzkZgacuqKVjduS5KssvxGUfPd9fDU39LG2xij6GQU+5M9lGT6kGx/GSjYh8C6bHWUmwUxthf3pXrxwJil4+U0xwp6O4mgyqPT6eKvvj0Jiv6Bb5QRPG5+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SXBIrMMC; arc=none smtp.client-ip=209.85.208.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-2d718ee7344so56132791fa.2;
        Wed, 17 Apr 2024 06:12:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713359519; x=1713964319; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Xvq5XhFeUgxKjTzR6bSBfVpoXUJWQ7jeCb714ZUuuUI=;
        b=SXBIrMMCZHO/bt/n/qrtFdMS25rl+QyJeqEtEsSIfiYu64z82lNWjBA46TkojdsQlD
         TuKZQfk6F1RtB6LhslsSYgSIWc3A2Za32DrwhkUFa6h7tLW5tGGfJJ7QHSs6IsLY/u9f
         GRGO7D+mzaFvAG4Fy70UKeNaSt4R0Kgk5oIAMTW2hnxuZSAEkvQxIKAT26UZCg6lYvnY
         MnMbx5RbXCMJ09ks3yhN8a1P8loEldKvpedXPSF/64GLQ1n5PsuQ4KX69F5XxIczIYF1
         NVq/gJXNw/vRyZUOOmDRR+SxWL+zC7NYmrN5a8EZl6eMr3GH6jw4V/xSMc+iOSv9yzcm
         HGHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713359519; x=1713964319;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Xvq5XhFeUgxKjTzR6bSBfVpoXUJWQ7jeCb714ZUuuUI=;
        b=SMtPKdFfSjjxr49AUI0Y56INqBp/dy158mtezTTb+PscnS/gUxt3tNp0fF7s4fw+HU
         Nfc5YH1z2EyOkDWb2P60kwCHAaylTQSBOv8U+Q0+RTAIdO7/yJytBa2p/DkwLo0h8J3R
         8yXbpAd269xBQHuGLjJ1/QJG2KBZOpmGphfGAOnNfhIVipDas1UgLll32Wgi9I9sJY8b
         TSCkp+x5qFNjf47cY9cibHdVep8iTdfOg7U7TyYq7p7VBuT4c/VL78z4Z7sQFs7GvCva
         xq+NPUKlTChVQEtdxSllMc0RIPJKEqeOACEWT91ZDKddsIAur0Tc3P4AJp3Ls9t+Sf34
         0L2w==
X-Forwarded-Encrypted: i=1; AJvYcCWoQ/MScLI6luyuDf0FVI7ACv0dWbYdJbW1uo1RSsT4ITG7y7auZqCFxHlFbEayMWa9bGcKGYgws4h8eu1+tZxJRW2uZLEQ7roNthBRIQaRbNMc4ztqx60rRqnr+W1UXcedLcfpJaHuTPcPBq9IKHXnzhcZx9X1Np76Jp0P5ncmC11i7pPd01aJc53uDNQeB1FJppzuIeuE69D6uA5zopts32FS
X-Gm-Message-State: AOJu0YzPYtbwuaKa+LjBO4CFDXESozXGfbHjNy29r5IKP3mBPx0Pflah
	OP3D39EVsbJzNtzQ8izPPPr/1k5w9oLNvMZKDw9niG/Sf40auVKB
X-Google-Smtp-Source: AGHT+IHdGh0cJoN5BQEheZbFU09X48BOOMw+EqWuSPIB0M7jeLokHHm06r2P5q8vQRJCzBR50C7lPg==
X-Received: by 2002:a2e:9657:0:b0:2db:4f3f:55a7 with SMTP id z23-20020a2e9657000000b002db4f3f55a7mr655852ljh.45.1713359519045;
        Wed, 17 Apr 2024 06:11:59 -0700 (PDT)
Received: from mobilestation.baikal.int (srv1.baikalchip.ru. [87.245.175.227])
        by smtp.gmail.com with ESMTPSA id u22-20020a2e8456000000b002da25e60918sm1389162ljh.18.2024.04.17.06.11.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Apr 2024 06:11:58 -0700 (PDT)
Date: Wed, 17 Apr 2024 16:11:56 +0300
From: Serge Semin <fancer.lancer@gmail.com>
To: Romain Gantois <romain.gantois@bootlin.com>
Cc: "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	Geert Uytterhoeven <geert+renesas@glider.be>, Magnus Damm <magnus.damm@gmail.com>, 
	Alexandre Torgue <alexandre.torgue@foss.st.com>, Jose Abreu <joabreu@synopsys.com>, 
	Maxime Coquelin <mcoquelin.stm32@gmail.com>, Russell King <linux@armlinux.org.uk>, 
	=?utf-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <clement.leger@bootlin.com>, Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
	netdev@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-renesas-soc@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com, 
	linux-arm-kernel@lists.infradead.org, "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>, 
	Maxime Chevallier <maxime.chevallier@bootlin.com>
Subject: Re: [PATCH net-next v3 2/5] net: stmmac: introduce pcs_init/pcs_exit
 stmmac operations
Message-ID: <abgmcmebzv5323wmumurygggeho2mbyf2l24fe42c6zvvueutc@w7zpxqndlqox>
References: <20240415-rzn1-gmac1-v3-0-ab12f2c4401d@bootlin.com>
 <20240415-rzn1-gmac1-v3-2-ab12f2c4401d@bootlin.com>
 <42chuecdt7dpgm6fcrtt2crifvv5hflmtnmdrw5fvk3r7pwjgu@hlcv56dbeosf>
 <77722ced-4956-0e70-9492-c7b2e8557253@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <77722ced-4956-0e70-9492-c7b2e8557253@bootlin.com>

On Wed, Apr 17, 2024 at 11:30:09AM +0200, Romain Gantois wrote:
> Hi Serge,
> 
> On Tue, 16 Apr 2024, Serge Semin wrote:
> 
> > I am currently working on my Memory-mapped DW XPCS patchset cooking:
> > https://lore.kernel.org/netdev/20231205103559.9605-1-fancer.lancer@gmail.com/
> > The changes in this series seems to intersect to what is/will be
> > introduced in my patchset. In particular as before I am going to
> > use the "pcs-handle" property for getting the XPCS node. If so what
> > about collecting PCS-related things in a single place. Like this:
> > 
> > int stmmac_xpcs_setup(struct net_device *ndev)
> > {
> > 	...
> > 
> > 	if (priv->plat->pcs_init) {
> > 		return priv->plat->pcs_init(priv); /* Romain' part */
> >	} else if (fwnode_property_present(priv->plat->port_node, "pcs-handle")) {
> > 		/* My DW XPCS part */
> > 	} else if (priv->plat->mdio_bus_data && priv->plat->mdio_bus_data->has_xpcs) {
> > 		/* Currently implemented procedure */
> > 	}
> > 
> > 	...
> > }
> 
> That seems like a good idea to me, although those setup functions would have to 
> be renamed to stmmac_pcs_setup/exit.

Why not, seeing they will be responsible for any PCS attached to the
MAC.

-Serge(y)

> 
> Thanks,
> 
> -- 
> Romain Gantois, Bootlin
> Embedded Linux and Kernel engineering
> https://bootlin.com

