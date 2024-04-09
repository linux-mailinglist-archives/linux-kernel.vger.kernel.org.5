Return-Path: <linux-kernel+bounces-136230-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1825C89D187
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 06:32:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3DA8A1C21DF7
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 04:32:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61A3734CDE;
	Tue,  9 Apr 2024 04:32:09 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06B8F26AC5
	for <linux-kernel@vger.kernel.org>; Tue,  9 Apr 2024 04:32:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712637129; cv=none; b=krHgITtY+8U53cljtHidYy85Hj78PJMaPHCHyMrCiDG7c2d1AuTf6/emoFH6Png7qygWmihrocBUhVvYqfOoGA1+VTBz815bMltKRJO0hZGFQwJblB6ENyZXeSW6SKTq70Rm4Bx8/uzQBPV/6zhut6ObiwBZF0nEkO/Gd0YZrBI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712637129; c=relaxed/simple;
	bh=dPvPqUERy12DlCuYBp4kJOrK+EGsyRWG0aIs7+b7590=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=X4zBTPYOD3yCIZVM/N1yiudhl5dQJzTn0/kdZvP5FA1VRedM/MeL70zasoI3ePqGrzm2cMWu97bLxCOktuqB6E7XEqfxIabiZzneRQJMxKkm/qJ88fjs/pSQEote2tuSRxD3wq5DGjpAvpX6rng3FtURaleGGy6szaPwa/Q5NI0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1ru39E-0004ek-Fn; Tue, 09 Apr 2024 06:31:52 +0200
Received: from [2a0a:edc0:2:b01:1d::c5] (helo=pty.whiteo.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ore@pengutronix.de>)
	id 1ru39C-00BErS-Fh; Tue, 09 Apr 2024 06:31:50 +0200
Received: from ore by pty.whiteo.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1ru39C-004MsH-1F;
	Tue, 09 Apr 2024 06:31:50 +0200
Date: Tue, 9 Apr 2024 06:31:50 +0200
From: Oleksij Rempel <o.rempel@pengutronix.de>
To: Arun.Ramadoss@microchip.com
Cc: andrew@lunn.ch, olteanv@gmail.com, davem@davemloft.net,
	Woojung.Huh@microchip.com, pabeni@redhat.com, edumazet@google.com,
	f.fainelli@gmail.com, kuba@kernel.org, kernel@pengutronix.de,
	dsahern@kernel.org, san@skov.dk, willemb@google.com,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	horms@kernel.org, UNGLinuxDriver@microchip.com
Subject: Re: [PATCH net-next v4 5/9] net: dsa: microchip: add support for
 different DCB app configurations
Message-ID: <ZhTEtmcvubthMXmB@pengutronix.de>
References: <20240408074758.1825674-1-o.rempel@pengutronix.de>
 <20240408074758.1825674-6-o.rempel@pengutronix.de>
 <40d90a28d95bff48f352a3aaf81df2b1a6133cc7.camel@microchip.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <40d90a28d95bff48f352a3aaf81df2b1a6133cc7.camel@microchip.com>
X-Sent-From: Pengutronix Hildesheim
X-URL: http://www.pengutronix.de/
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ore@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org

Hi Arun,

On Mon, Apr 08, 2024 at 04:10:15PM +0000, Arun.Ramadoss@microchip.com wrote:
> > +int ksz_port_get_default_prio(struct dsa_switch *ds, int port)
> > +{
> > +       struct ksz_device *dev = ds->priv;
> > +       int ret, reg, shift;
> > +       u8 data, mask;
> > +
> > +       ksz_get_defult_port_prio_reg(dev, &reg, &mask, &shift);
> > +
> > +       ret = ksz_pread8(dev, port, reg, &data);
> > +       if (ret)
> > +               return ret;
> > +
> > +       return (data & mask) >> shift;
> 
> I assume we can use retrun FIELD_GET(mask, data), since mask is GENMASK
> format. 
> 
> > 
> > +int ksz_port_set_default_prio(struct dsa_switch *ds, int port, u8
> > prio)
> > prio)
> > +{
> > +       struct ksz_device *dev = ds->priv;
> > +       int reg, shift;
> > +       u8 mask;
> > +
> > +       if (prio >= dev->info->num_tx_queues)
> > +               return -EINVAL;
> > +
> > +       ksz_get_defult_port_prio_reg(dev, &reg, &mask, &shift);
> > +
> > +       return ksz_prmw8(dev, port, reg, mask, (prio << shift) &
> > mask);
> 
> FIELD_PREP(mask, prio)

Sadly, FIELD_GET() and FIELD_PREP() do not work with dynamic masks.

Regards,
Oleksij
-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

