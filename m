Return-Path: <linux-kernel+bounces-98284-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B44028777DC
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Mar 2024 19:02:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6F82B1F213BB
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Mar 2024 18:02:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 628B0339BC;
	Sun, 10 Mar 2024 18:02:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="w5FluFU2"
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BAFC21115;
	Sun, 10 Mar 2024 18:02:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710093761; cv=none; b=FjaSLXA5OXCQ3mvBkc5U3CeNptfkFY2R+CRUCl+y+WruEBKcBaN5eHwTlE0PPI42Gw25nhY6PQ/RIAE9mvRs61p8fBwzFpsDcCrFJl49rEd4iAxiIQzP32C5h5QRVLlb859URCj1upVddaPaf5Pi502V0aBek0/sVc5bCyhW0qg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710093761; c=relaxed/simple;
	bh=/uti3KhNUWLN2j9QKHNuTsykTW7CeAjkbaGcoIDvAX8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HbQSau2TBA3earAgw5x/46pBDza1lN1SZ25EbgXx93xA+/Mjr6dG/bcHtOu1EazkWj7hyuso80Mme6mYIDYIEuQndDRUxSGGtGsTUNLRsDQenntXLDvIiDTAKYwPcwE/KhyjOMsDvoUPFjgQH1KpAJw0o13UwbDQ7Z3jmkcuWoI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=w5FluFU2; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=nKRXGf8H98Z9tuuZUNbMP7MGE4PkRR7UCT/L+6ltYAE=; b=w5FluFU27o3T9ZV6+J2q4vNQ9v
	JIt6svUBCo3ZXxBsiBqliqW1LP2CFfMt31fzXHrLoNAvRwmOKo0OBZe+7t91n9aKrizryfZLHdMZ3
	ex6+Dya9ByuIBmgxubDerQSfrkxnPNldDnOA7zyAZfjFBgiy+HYMa5BJ5TqRHUHUO03g=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1rjNVc-009v1u-Sv; Sun, 10 Mar 2024 19:02:52 +0100
Date: Sun, 10 Mar 2024 19:02:52 +0100
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
Message-ID: <6705a278-d294-475f-bc4c-b08926c5017d@lunn.ch>
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

On Sun, Mar 10, 2024 at 01:51:58AM -0300, Luiz Angelo Daros de Luca wrote:
> Each port can have up to 4 LEDs (3 for current rtl8365mb devices). The
> LED reg property will indicate its LED group.
> +                properties:
> +                  reg:
> +                    description:
> +                      "reg indicates the LED group for this LED"
> +                    enum: [0, 1, 2, 3]

If this identifies the group, what identifies the actual LED? There
are four of them. How do i say LEDs 0 and 1 are unused, 2 and 3 are
wired to LEDs?

It would be much more usual for reg to be the LED number for the
port. And there then be a group property indicating what group the LED
belongs to. However, i'm wondering, is group fixed? Do we actually
need it in DT, or can there just be a table in the driver which maps
port:led to group?

	 Andrew

