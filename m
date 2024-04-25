Return-Path: <linux-kernel+bounces-158321-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E8DC88B1E50
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 11:45:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 267E11C21D0A
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 09:45:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53C1184FD0;
	Thu, 25 Apr 2024 09:44:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b="d0krcBJi";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b="Nq8CLYD8"
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C68D484DFB;
	Thu, 25 Apr 2024 09:44:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.104.207.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714038296; cv=none; b=NR+xtk2td+kreOpJziw0yV9jEiTlb9LmxspcALPX8yduU2wZ6SOJaPmZniuCWRZ3Sa92BVrys64BaQ2BnNXhlEKZm/rktmb6X3Q8NcWMLt7DjG/2cpjnr8Q2OmOp2uDHjb/rYkcwX5MTTn8074Zhl7YzhMsbY3ZWE8yG6dWkrUw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714038296; c=relaxed/simple;
	bh=3DB11IKP/T9/3xhOrWwdKlbwGKlVUxdv7gsOBmdeDHI=;
	h=Subject:Date:From:To:Cc:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JzVAEJY6opSqDj/GkcrW11mPFJ7IhK0cy5fiVWxRz1n/XeJL1jYPkPzr18AgBJ7OQ91pqJUywNf8akwaO+v7Sz3Zh9KXydX9RQpt3Nxw04TLwfvlzaCTFgTSeOC77q8oM++XN0iUtLcjOTfK4LnB/j6x+2qjYh8gJdKGLmUjMP0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com; spf=pass smtp.mailfrom=ew.tq-group.com; dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b=d0krcBJi; dkim=fail (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b=Nq8CLYD8 reason="key not found in DNS"; arc=none smtp.client-ip=93.104.207.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ew.tq-group.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1714038292; x=1745574292;
  h=date:from:to:cc:message-id:references:mime-version:
   content-transfer-encoding:in-reply-to:subject;
  bh=HLlh2QL5TbXjyNAR69Yvmpo/xTGS9Lo12NgQNCZ06YQ=;
  b=d0krcBJiCro8dwV/UsQ41hTNK00RhxCS9pxR/t7ur4wyBZ+SNfGTqVzW
   77IMTjoM2UunbSDklUQeCOESuBSnZjdWRFFhz+d9nAZ2acsexxsdaz2Q8
   qYBXxTFMTQDqS5eZ5JeccM0O5Kw/YHhoPnXFd4cLTJ9KUV7tC4n1NL8rI
   wImJT8RfCrJmHE+cVywmIEmGzJncWd9dVEa9pwW/DRk98NUOQsM+UTD5y
   ZsxY0vlxepmzu7vwsJ8L33B87fmKxyDJaLisBleyGsjLnkxyXcf+MZAOZ
   GaAjsBkjmASW5boKxt74t7kgKT/0J0Nx+a8QWc93pG1VJuhhtSKx+ac7E
   g==;
X-IronPort-AV: E=Sophos;i="6.07,228,1708383600"; 
   d="scan'208";a="36610690"
Subject: Re: Re: [PATCH 1/4] can: mcp251xfd: stop timestamp before sending chip to
 sleep
Received: from vmailcow01.tq-net.de ([10.150.86.48])
  by mx1.tq-group.com with ESMTP; 25 Apr 2024 11:44:48 +0200
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id BCAC516E686;
	Thu, 25 Apr 2024 11:44:41 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ew.tq-group.com;
	s=dkim; t=1714038284;
	h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=HLlh2QL5TbXjyNAR69Yvmpo/xTGS9Lo12NgQNCZ06YQ=;
	b=Nq8CLYD8RZR4BApO/dYg4PxApypWD1JWXYNDBi/QoJZKiDwzuBjz23RL6l+nX4XByGNPHU
	JTMkKfte6NNmdQYX8pu5+xfAhavNby5URmwXf5jTSeDp+nLjuJ7kK1X65VVJfvXSXVKPep
	NyOPhpcMVH3GSF6xsvBdqxYhekw4348A+7ngA3vEUDkZ9xOe7/qQf1G3vTIlU9Lp+Qo9IQ
	/9qHR5VCjjDvZPrM8bYobzMlAT1v1gMaJObL/fKP6O0wdFrlhe8MTlQ9XcoAKE2PGJjPEG
	0IdG3KOk9DEhyoEOeN5yuaNa1rC46QDyoO6syTp1xZHQbBCm7s+GQWGnXBv5KQ==
Date: Thu, 25 Apr 2024 11:44:36 +0200
From: Gregor Herburger <gregor.herburger@ew.tq-group.com>
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Thomas Kopp <thomas.kopp@microchip.com>,
	Vincent Mailhol <mailhol.vincent@wanadoo.fr>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-can@vger.kernel.org,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org, linux@ew.tq-group.com,
	alexander.stein@ew.tq-group.com
Message-ID: <ZiomBNoSsXlYfKN2@herburgerg-w2>
References: <20240417-mcp251xfd-gpio-feature-v1-0-bc0c61fd0c80@ew.tq-group.com>
 <20240417-mcp251xfd-gpio-feature-v1-1-bc0c61fd0c80@ew.tq-group.com>
 <20240424-adaptable-zircon-badger-1fefd9-mkl@pengutronix.de>
 <ZinnV+GA20LWGUOV@herburgerg-w2>
 <20240425-tall-quiet-wren-f00e44-mkl@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240425-tall-quiet-wren-f00e44-mkl@pengutronix.de>
X-Last-TLS-Session-Version: TLSv1.3

On Thu, Apr 25, 2024 at 08:29:13AM +0200, Marc Kleine-Budde wrote:
> On 25.04.2024 07:17:11, Gregor Herburger wrote:
> > On Wed, Apr 24, 2024 at 01:54:54PM +0200, Marc Kleine-Budde wrote:
> > > On 17.04.2024 15:43:54, Gregor Herburger wrote:
> > > > MCP2518FD exits Low-Power Mode (LPM) when CS is asserted. When chip
> > > > is send to sleep and the timestamp workqueue is not stopped chip is
> > > > waked by SPI transfer of mcp251xfd_timestamp_read.
> > > 
> > > How does the Low-Power Mode affect the GPIO lines? Is there a difference
> > > if the device is only in sleep mode?
> > 
> > The MCP251XFD_REG_IOCON is cleared when leaving Low-Power Mode. This is
> > why I implemented regcache.
> 
> But that means you have to power the chip if a GPIO is requested. You
> have to power up the chip in the request() callback and power it down in
> the free() callback.

Ah I see. Currently the GPIO rigister is cached and only written to the
chip if the netdevice is set up. I think to have a more generic gpio controller
the chip should wake up when the GPIO is requested. Also the chip should
not go to sleep while GPIO is requested and netdevice is set down.

> I've 2 patches laying around, one that moves the timestamp
> init/start/stop into the chip_start/stop. And another one that moves the
> soft reset and basic configuration of the chip into the runtime pm
> functions. I have to make both patches compatible and send them to the
> list. Feel free to pick them up and integrate them into your series.

I will have a look at them.
> 
> regards,
> Marc
> 
> -- 
> Pengutronix e.K.                 | Marc Kleine-Budde          |
> Embedded Linux                   | https://www.pengutronix.de |
> Vertretung Nürnberg              | Phone: +49-5121-206917-129 |
> Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

Best regards
Gregor
-- 
TQ-Systems GmbH | Mühlstraße 2, Gut Delling | 82229 Seefeld, Germany
Amtsgericht München, HRB 105018
Geschäftsführer: Detlef Schneider, Rüdiger Stahl, Stefan Schneider
https://www.tq-group.com/

