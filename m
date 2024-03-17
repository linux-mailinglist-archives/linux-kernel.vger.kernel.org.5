Return-Path: <linux-kernel+bounces-105405-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4690D87DD79
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Mar 2024 15:42:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BFAEEB20D90
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Mar 2024 14:42:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B9C71B7E4;
	Sun, 17 Mar 2024 14:42:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="alCHLXnX"
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2A7FEAE5;
	Sun, 17 Mar 2024 14:41:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710686521; cv=none; b=rF3mt2lUMmcM9ca7f3hcABEkWkYTAtVBrEtolGJYLn7xOrQcK2ATYJRYEjZc5g/n9kCIHa0KWGTy5upf2SC4e6fLG20ky+gxgffuuqlv/QNXp4dVlMQb0rr96Vr/O6FPJcf+g8U4wb+5yW7p2M/IzuBAhUlxEG+P8+TnYKofmzE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710686521; c=relaxed/simple;
	bh=akYMkoSZX1Qalm6t91YPfWIgthzaMLlI0SS1RHfyzE0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XrhWVZxewP9pdnWsrP051+uynr0ZhP5oCuxCLloS6j8+WHQSNZc2s/m0Ze0H79kYRidS1/Y5KRhvweNfLofoqGxpkt1YQUQAZdTaEREdrmpVyZPn3YTv2P6VvFJjSvuJFnaAkX4aEqWhG92XwJ/zJ872zF3rr6Ip83jjvsHLLZc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=alCHLXnX; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=nFaY47Y/DXxkjFbRQx1XtsLzmqfV/DOsE2eb/gKgyLw=; b=alCHLXnXhxvDpn11JZsvx5Uaxq
	dT4XcGlS14H0VQkoKpBSwWGxx1s3wOyeA5xKUyYI3IExpOEYiU1inILgxyJa0Reb4d6roXjWByRUT
	c/xN/HER0g/vorEWEKbx2i2lBFS26dBtbvnJGDPcrsX0G6CEbgIhhDGpn7ponT2xs4Bg=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1rlrhd-00AXxp-4q; Sun, 17 Mar 2024 15:41:33 +0100
Date: Sun, 17 Mar 2024 15:41:33 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Ayush Singh <ayushdevel1325@gmail.com>
Cc: Vaishnav M A <vaishnav@beagleboard.org>, linux-kernel@vger.kernel.org,
	jkridner@beagleboard.org, robertcnelson@beagleboard.org,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>, Nishanth Menon <nm@ti.com>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Tero Kristo <kristo@kernel.org>,
	Derek Kiernan <derek.kiernan@amd.com>,
	Dragan Cvetic <dragan.cvetic@amd.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>, Jiri Slaby <jirislaby@kernel.org>,
	Johan Hovold <johan@kernel.org>, Alex Elder <elder@kernel.org>,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-spi@vger.kernel.org, linux-serial@vger.kernel.org,
	greybus-dev@lists.linaro.org
Subject: Re: [PATCH v3 0/8] misc: Add mikroBUS driver
Message-ID: <0a0a6e14-ac7b-48fd-89d3-68f351e893c9@lunn.ch>
References: <20240315184908.500352-1-ayushdevel1325@gmail.com>
 <CALudOK5v_uCUffxHGKS-jA-DKLNV7xwmKkxJwjHaMWWgDdPDqA@mail.gmail.com>
 <656ca446-9e56-4879-bb42-cd29063e0a82@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <656ca446-9e56-4879-bb42-cd29063e0a82@gmail.com>

> Yes, I will add Co-author and Co-developed tags. I think I should use your
> ti email? I would have preferred to keep you as the author in the git commit
> but I could not get the patches applied cleanly back when I tried it.

Probably not required now, but

git commit --amend --author A U Thor <author@example.com>

allows you to change the author of a patch in git.

       Andrew

