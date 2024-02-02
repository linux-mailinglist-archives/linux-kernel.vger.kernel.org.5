Return-Path: <linux-kernel+bounces-49741-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2353C846ED4
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 12:21:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D2E88287BCF
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 11:21:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 828EC7A70B;
	Fri,  2 Feb 2024 11:20:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="oD4486gF"
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D76A913D51D;
	Fri,  2 Feb 2024 11:20:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706872849; cv=none; b=mE0B5ZJCrANOZ0Yd9aVCrLSmlr4K0bR4hIA8vaiyDYncozqf63peFDx95P4iTLGaxv6PQIJQsIQfBVyqghlILSbVztZUDItZX8GxtCkLTeLa+A5YJ54DnkqeMiVXZVOe5/amLBhiTpPClfqdJ1MQk6G57UDc9v0wH2ll8Epm5AM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706872849; c=relaxed/simple;
	bh=abfH953AdUwnMAFPZMBp1UHgIjuzPy5kyKWCCnyPpzg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ArcdB3dLjs3/dHnZk+3iSz7d0LeJ2J/OnC8gfgboeQWlIPRilhO1/Elqzjxdd+bQiQpBib4kPK3Nl9uzGCmMo/DZb6r6Ou/nN1t9wYkp/7BYom5gm4ecqhDih0HS8CdkHK5XGlaXCx0Eai8kEbXjGmIrQnCRQVpofSg7d1VM45g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=oD4486gF; arc=none smtp.client-ip=217.70.183.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 8667E1BF20A;
	Fri,  2 Feb 2024 11:20:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1706872839;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=C801XntAx6vFH+ttC2yyLkXTQzS50DDecHjK0YLEF9U=;
	b=oD4486gF+t55vbzZkQfwe6Ks80voR9BadNJK17DdKY2sGSYG3Mht8NVxspZipuV6rFKGZA
	tIGSBbv2mv4adrsdgRIKTzv7yRGxQoC0XHK8f/31SiRWvQ9fBeT9QNGkdcxYyPT4LKEVDZ
	XH7evlQ2OJcDlcJjIBtiwMpZAUxGoFR7tLGD2j5gOWQFgyFzPZOAtLfaLgvcuc2QHtLPPl
	8AzodWGrlZFdNRol8DJSOeyUKlwJuULAJ5DQlnLhsX6SD2cYyG3u/GYeP7P7FK1pjW32FM
	8HcdVuTZFig+4ifYlpN16pnaSMP0+5D4AP8QHG56UlZ8LySlFOFWcSnQVeN3vA==
Date: Fri, 2 Feb 2024 12:20:36 +0100
From: Luca Ceresoli <luca.ceresoli@bootlin.com>
To: Adam Ford <aford173@gmail.com>
Cc: dri-devel@lists.freedesktop.org, Kishon Vijay Abraham I
 <kishon@kernel.org>, devicetree@vger.kernel.org, Conor Dooley
 <conor+dt@kernel.org>, Fabio Estevam <festevam@gmail.com>, Pengutronix
 Kernel Team <kernel@pengutronix.de>, Shawn Guo <shawnguo@kernel.org>,
 Sascha Hauer <s.hauer@pengutronix.de>, linux-kernel@vger.kernel.org, Vinod
 Koul <vkoul@kernel.org>, Rob Herring <robh+dt@kernel.org>, NXP Linux Team
 <linux-imx@nxp.com>, Krzysztof Kozlowski
 <krzysztof.kozlowski+dt@linaro.org>, linux-phy@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH V2 2/2] phy: freescale: add Samsung HDMI PHY
Message-ID: <20240202122036.7aa66d9d@booty>
In-Reply-To: <20240106221907.325127-2-aford173@gmail.com>
References: <20240106221907.325127-1-aford173@gmail.com>
	<20240106221907.325127-2-aford173@gmail.com>
Organization: Bootlin
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-GND-Sasl: luca.ceresoli@bootlin.com

Hello Adam,

On Sat,  6 Jan 2024 16:19:05 -0600
Adam Ford <aford173@gmail.com> wrote:

> From: Lucas Stach <l.stach@pengutronix.de>
> 
> This adds the driver for the Samsung HDMI PHY found on the
> i.MX8MP SoC.
> 
> Signed-off-by: Lucas Stach <l.stach@pengutronix.de>
> Signed-off-by: Adam Ford <aford173@gmail.com>

I had already tested the v2 from Lucas, however I also tested this
version which works as well, on v6.8-rc1, custom hardware based on the
Avnet i.MX8MP SMARC SoM.

Tested-by: Luca Ceresoli <luca.ceresoli@bootlin.com>

Generally speaking, as there are several small patch series around which
together implement HDMI on iMX8MP and similar, I think it would be much
easier fore reviewing and testing if they were grouped into a unique
series.

Luca

-- 
Luca Ceresoli, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

