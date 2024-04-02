Return-Path: <linux-kernel+bounces-127472-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CC4CA894C33
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 09:09:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6C0A91F22FEC
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 07:09:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 627E6383A4;
	Tue,  2 Apr 2024 07:09:00 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC70E364BE
	for <linux-kernel@vger.kernel.org>; Tue,  2 Apr 2024 07:08:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712041740; cv=none; b=O7YIJ1TCPhRCTUqn4N0r3gAX0LfbiXkWyVwI7JPzUK3Nmy09qF40ls90jwvHrVMN5VLCxNeeOmx0SJDZ/yiBd9mGeeGaqjW2XyAmfMyyX+/uQKLimbDhpPkjIVVkO3SOZIbF5lBRkxQ8ujmhxPubgc8xMyr4t+dSxeKdSVDTogQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712041740; c=relaxed/simple;
	bh=vVL1WWKaLXDtUUSbsz1I2qpNUvjQSsHeYGcRZRo6rm4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ape4gC82KW3iDE6UYDRYb12ToJaNyzm8oVERoWWdVaWkpmvpVvnTestu3bsPM/UyIpxygjsZQK1bFMiXtYUSHdX3DgsGpbdigi/l9OgK22In4VSwducBDDqbFBVZnPhWtu5iMKi9aNqn/irT3ziUwGsvs3j8PcvHoRdp7d93Dcc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1rrYGI-00046x-E6; Tue, 02 Apr 2024 09:08:50 +0200
Received: from [2a0a:edc0:2:b01:1d::c5] (helo=pty.whiteo.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ore@pengutronix.de>)
	id 1rrYGH-009w6P-2e; Tue, 02 Apr 2024 09:08:49 +0200
Received: from ore by pty.whiteo.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1rrYGG-00AjC1-3A;
	Tue, 02 Apr 2024 09:08:48 +0200
Date: Tue, 2 Apr 2024 09:08:48 +0200
From: Oleksij Rempel <o.rempel@pengutronix.de>
To: Arun.Ramadoss@microchip.com
Cc: andrew@lunn.ch, olteanv@gmail.com, davem@davemloft.net,
	Woojung.Huh@microchip.com, pabeni@redhat.com, edumazet@google.com,
	f.fainelli@gmail.com, kuba@kernel.org, kernel@pengutronix.de,
	dsahern@kernel.org, san@skov.dk, willemb@google.com,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	horms@kernel.org, UNGLinuxDriver@microchip.com
Subject: Re: [PATCH net-next v1 7/9] net: dsa: microchip: enable ETS support
 for KSZ989X variants
Message-ID: <ZguvAP1PHB9Rs74U@pengutronix.de>
References: <20240328160518.2396238-1-o.rempel@pengutronix.de>
 <20240328160518.2396238-8-o.rempel@pengutronix.de>
 <b3229336ecdcba1adbca4a3392e5726c418647ad.camel@microchip.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <b3229336ecdcba1adbca4a3392e5726c418647ad.camel@microchip.com>
X-Sent-From: Pengutronix Hildesheim
X-URL: http://www.pengutronix.de/
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ore@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org

Hi Arun,

On Tue, Apr 02, 2024 at 03:38:33AM +0000, Arun.Ramadoss@microchip.com wrote:
> Hi Oleksij,
> 
> 
> On Thu, 2024-03-28 at 17:05 +0100, Oleksij Rempel wrote:
> > EXTERNAL EMAIL: Do not click links or open attachments unless you
> > know the content is safe
> > 
> > I tested ETS support on KSZ9893, so it should work other KSZ989X
> > variants too.
> 
> You have enabled ETS for KSZ9897, KSZ9896, KSZ9893. There are other
> switches similar to KSZ9893,
> 
> KSZ9563 - Same as KSZ9893 but with PTP capability
> KSZ8563 - Same as KSZ9563 but without gigabit
> KSZ9567 - Same as KSZ9897 but with PTP capability
> KSZ8567 - Same as KSZ9567 but without gigabit
> 
> Do we need enable ETS for those switches also.

No, this variants are already enabled.

Regards,
Oleksij
-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

