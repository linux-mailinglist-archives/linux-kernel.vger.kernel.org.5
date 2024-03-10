Return-Path: <linux-kernel+bounces-98299-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 83ED7877813
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Mar 2024 19:52:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3F4DA281193
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Mar 2024 18:52:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B552C39FDA;
	Sun, 10 Mar 2024 18:52:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="LWuDYglI"
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59DD4200DD;
	Sun, 10 Mar 2024 18:52:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710096736; cv=none; b=jBqHRVYIRl1+Ojv3mkCma2jke1h4nQ14fsSEd60sghKjKs7ofakwblFoiK/Zty6guRp9+UXQhsuI362HuSueXZlQauxBhHON0Rw21ybT4dQ+/IraJGLarf8XXFtTusJ6TD3yieaGb3U/6ef6oxv9GAXrnKQl8FgEUJwojxKthAI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710096736; c=relaxed/simple;
	bh=PyiE+eMguPww4jANk/vO3f+RJgxXzpz5Dw9mnlTNxAA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lw6KwchZI2jado+W+AWj4EpyPlD//3l3e1kHOIEpL2yfAlhtm7NZJZNa5g8+EfMGIHHl7emFmqtvnora12X8wInH/xI52FL87rzg1peLXfeFDLgusLO8eHr4lpd9PnReeod62jD3UrUl47my/hnZuMOLNUUKL8dp/0bXT0v/nVI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=LWuDYglI; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=uNlaw3g4wwBNanhEYw5cc+Vm2nzhdvAOPOMqtxqaW2M=; b=LWuDYglIL+fPB5EYJ0AyIE9GwB
	QQlTloupfzxxQJPXhTjHdk9jh3sMuF1HZRbbvIqb/Sw30LU7rVwZQVxCmM6iMqmuST2Ghuje/w7zn
	O51SbDiu1a0QhQMN/Pr9M7QQzWY5mSdSge2/JB0wSNR8gzr2/L+FGJI4LeKKPo2L6Ds8=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1rjOHn-009v7h-7U; Sun, 10 Mar 2024 19:52:39 +0100
Date: Sun, 10 Mar 2024 19:52:39 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Luiz Angelo Daros de Luca <luizluca@gmail.com>
Cc: Linus Walleij <linus.walleij@linaro.org>,
	Alvin =?utf-8?Q?=C5=A0ipraga?= <alsi@bang-olufsen.dk>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: Re: [PATCH net-next 1/4] dt-bindings: net: dsa: realtek: describe
 LED usage
Message-ID: <80fee2d0-356b-4baf-bd7a-b338df3644fa@lunn.ch>
References: <20240310-realtek-led-v1-0-4d9813ce938e@gmail.com>
 <20240310-realtek-led-v1-1-4d9813ce938e@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240310-realtek-led-v1-1-4d9813ce938e@gmail.com>

> +                properties:
> +                  reg:
> +                    description:
> +                      "reg indicates the LED group for this LED"
> +                    enum: [0, 1, 2, 3]

Having read the code, i don't think the binding needs to say anything
about the group. It is implicit. Port LED 0 is in group 0. Port LED 1
is in group 1. So there is nothing here which is outside of the
standard LED binding. So as Linus said, i don't think you need any
YAML at all, the DSA port binding should be sufficient.

	Andrew

