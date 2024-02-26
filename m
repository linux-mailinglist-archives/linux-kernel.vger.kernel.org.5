Return-Path: <linux-kernel+bounces-81549-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 24C29867764
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 14:58:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5615C1C29B57
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 13:58:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E776129A8F;
	Mon, 26 Feb 2024 13:57:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="XKuYZxOI"
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D53B1292D2;
	Mon, 26 Feb 2024 13:57:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708955839; cv=none; b=LMR9IHT4+5BEj+9RAQ0sEoepgNORq0wkLR3dHzxEJL7kYUqLWGXI6+cWwmesXDXuM6zdMN4mwoIPojUqe55GiefLRdFWAUXMhxoaL8y//WpxKhOQ5ny2oYHpPG5Igde6rWvpLouEfdTQPa6QqIPHglsI/E9QRYGnj1oPEJrNGDs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708955839; c=relaxed/simple;
	bh=y9DpvrMKncsJIyMpWz8tOjPI2WeSTcMqZkZG7j7ckAI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rQnS7uDvc+JVC+d+thgosDHOpXLt05fxaT0ATSriPNvkKD9Lm4uSkadeT/BhhKJIQX/vw5o36/eNTGg4MGjrHMqZm7Wp5uZWAUmwYOrzlSPDCcPzygsJW/if+dph0cIEpzfs63A0Eh+MmLndZ28yT9p2LWaFRAEndPFpKiI7fxY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=XKuYZxOI; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=5HgsmUy/QJ0+mc91YMn/OH0OmZCKCaNpc6mj1PBX7x0=; b=XKuYZxOIycao5s/ijRy8JRxuOc
	V3esM+UT/Gg0r1oeAmX+uHuUxnqslv+y0La5V1j59sA9Ma6C0utAc+N8rBEHtiLFHj05tb37ihI++
	Y7dOEVwqYlw7w6/zLjAsEhzvFIRbl+Lmbf94AQuQOZc3r6zg7ev5S7d0sJ4+9r04A4To=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1rebTz-008jE1-G0; Mon, 26 Feb 2024 14:57:27 +0100
Date: Mon, 26 Feb 2024 14:57:27 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Robert Marko <robimarko@gmail.com>
Cc: f.fainelli@gmail.com, olteanv@gmail.com, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] net: dsa: mv88e6xxx: add Amethyst specific SMI
 GPIO function
Message-ID: <cb5c185f-1946-4548-9918-01548e9dd9cf@lunn.ch>
References: <20240224203349.1358064-1-robimarko@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240224203349.1358064-1-robimarko@gmail.com>

On Sat, Feb 24, 2024 at 09:33:09PM +0100, Robert Marko wrote:
> The existing mv88e6xxx_g2_scratch_gpio_set_smi() cannot be used on the
> 88E6393X as it requires certain P0_MODE, it also checks the CPU mode
> as it impacts the bit setting value.
> 
> This is all irrelevant for Amethyst (MV88E6191X/6193X/6393X) as only
> the default value of the SMI_PHY Config bit is set to CPU_MGD bootstrap
> pin value but it can be changed without restrictions so that GPIO pins
> 9 and 10 are used as SMI pins.
> 
> So, introduce Amethyst specific function and call that if the Amethyst
> family wants to setup the external PHY.

This looks good. The only comment i have is maybe we should rename
mv88e6xxx_g2_scratch_gpio_set_smi() to something more specific. It
seems it is only applicable to MV88E6XXX_FAMILY_6390, so maybe
mv88e6390_g2_scratch_gpio_set_smi()?

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

