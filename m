Return-Path: <linux-kernel+bounces-148331-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 293688A8108
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 12:35:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BCF411F21F59
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 10:35:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45A6213C667;
	Wed, 17 Apr 2024 10:35:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ltts.com header.i=@ltts.com header.b="BI6QR0uj";
	dkim=pass (1024-bit key) header.d=amazonses.com header.i=@amazonses.com header.b="g1xXHKQ1"
Received: from c180-18.smtp-out.ap-south-1.amazonses.com (c180-18.smtp-out.ap-south-1.amazonses.com [76.223.180.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB81D80BE0;
	Wed, 17 Apr 2024 10:35:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=76.223.180.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713350144; cv=none; b=V9QFYReWWASkz44IZLISJyujeWZ2uw6KCZ5vk+mr5qdxRDjJsdT0eCnTMSYVv9ZDXmjCBFOd+W6BU/TXhqVyt4VB70Gp7dGZkzvXwyh9rCiUR4QAghh1gt4VakRTPctqJjQ+YkIh+7ePlBqbRfEowyHXqmvfWvuxdPECIpbXdew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713350144; c=relaxed/simple;
	bh=MPA/yCGAeV9r3zQj7UZwA1/FORgOEaCJc7t+9vex2kY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cKubOoKu27fKs5r5z03jfRGBP6x+spsiHd4SzcxEoTT1GijJMePXEQXzswTOTHhxTGGZy3K/gZp7MvuovFNTSfLtuItVL7tTTOzch8Lyzq6TTY4QEVr3YdMptMiIWwLPviFAjKSaPYE9drjaiXKFAZ6w4051YZBVTHlnBL5KiqU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ltts.com; spf=pass smtp.mailfrom=ap-south-1.amazonses.com; dkim=pass (2048-bit key) header.d=ltts.com header.i=@ltts.com header.b=BI6QR0uj; dkim=pass (1024-bit key) header.d=amazonses.com header.i=@amazonses.com header.b=g1xXHKQ1; arc=none smtp.client-ip=76.223.180.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ltts.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ap-south-1.amazonses.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
	s=i3fe3efcd4pbz7ipgssfqjhzqx347xbc; d=ltts.com; t=1713350138;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=MPA/yCGAeV9r3zQj7UZwA1/FORgOEaCJc7t+9vex2kY=;
	b=BI6QR0ujVVqAvr+8gEtHK+VZQxEiwpZB74n8cBP7ctcA8BW/qjQxmFEuFKEH2x3Q
	I0Nt1zPwyyxknt8rCtMnELyTNbWvtoDI9TGqVNoYcvgRR8S/eChyZ+yeflBIPdsade/
	+XZJAUTgskd3kabFLEuqqoy7kbmFr+pkrYzCIJzm6cyAy/gEv9A/ZeGIDVIVG0sycEn
	rWE7QzD5gNFGkHEfrq4xdOV6kozY7wJreDAAJX4TXnKVCe/8RBLhIfv9XPDY6yr4GjB
	0ytMfU6zRWPTvCTCrJPNiNQEDMg//qeIvx2yWOBWar/+cmVl7PScsiAw2BXicHr8NR3
	WneEsE9eaA==
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
	s=rlntogby6xsxlfnvyxwnvvhttakdsqto; d=amazonses.com; t=1713350138;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:MIME-Version:Content-Type:Content-Transfer-Encoding:Feedback-ID;
	bh=MPA/yCGAeV9r3zQj7UZwA1/FORgOEaCJc7t+9vex2kY=;
	b=g1xXHKQ1vAtrtjihxlrA6d7AQPBE/IEEz3uez8vIIqiX+lONosMproEb/sYQTj4J
	g4A54PqyPxUEfMc4SXTht8W/+SDxg336Ys0boWR2kfpQIEfZ8qIknizraNbgthTKdvA
	6SmKiOSgqM4mAFy0BNVh3+wDWRnCwCU7CRJMQXS0=
From: Bhargav Raviprakash <bhargav.r@ltts.com>
To: lee@kernel.org
Cc: arnd@arndb.de, bhargav.r@ltts.com, broonie@kernel.org, 
	conor+dt@kernel.org, devicetree@vger.kernel.org, eblanc@baylibre.com, 
	gregkh@linuxfoundation.org, jpanis@baylibre.com, kristo@kernel.org, 
	krzysztof.kozlowski+dt@linaro.org, lgirdwood@gmail.com, 
	linus.walleij@linaro.org, linux-arm-kernel@lists.infradead.org, 
	linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org, 
	m.nirmaladevi@ltts.com, nm@ti.com, robh+dt@kernel.org, 
	vigneshr@ti.com
Subject: Re: [PATCH v6 03/11] mfd: tps6594: add regmap config in match data
Date: Wed, 17 Apr 2024 10:35:38 +0000
Message-ID: <0109018eeba05ad9-f837b6c7-70cf-4a2a-9aeb-3ef245e18862-000000@ap-south-1.amazonses.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240411170344.GK2399047@google.com>
References: <20240411170344.GK2399047@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Feedback-ID: 1.ap-south-1./RC/PI2M8xOxQmTMPi0M1Q8h2FX69egpT62QKSaMPIA=:AmazonSES
X-SES-Outgoing: 2024.04.17-76.223.180.18

Hello,

On Tue, 16 Apr 2024 13:25:04 +0100, Lee Jones wrote:

> > Hello,
> > 
> > On Wed, 14 Feb 2024 10:10:17 -0800, Lee Jones wrote:
> > > On Mon, 08 Apr 2024, Bhargav Raviprakash wrote:
> > > 
> > > > Introduces a new struct tps6594_match_data. This struct holds fields for
> > > > chip id and regmap config. Using this struct in of_device_id data field.
> > > > This helps in adding support for TPS65224 PMIC.
> > > > 
> > > > Signed-off-by: Bhargav Raviprakash <bhargav.r@ltts.com>
> > > > Acked-by: Julien Panis <jpanis@baylibre.com>
> > > > ---
> > > >  drivers/mfd/tps6594-i2c.c   | 24 ++++++++++++++++--------
> > > >  drivers/mfd/tps6594-spi.c   | 24 ++++++++++++++++--------
> > > >  include/linux/mfd/tps6594.h | 11 +++++++++++
> > > >  3 files changed, 43 insertions(+), 16 deletions(-)
> > > > 
> > > > diff --git a/drivers/mfd/tps6594-i2c.c b/drivers/mfd/tps6594-i2c.c
> > > > index c125b474b..9e2ed48b7 100644
> > > > --- a/drivers/mfd/tps6594-i2c.c
> > > > +++ b/drivers/mfd/tps6594-i2c.c
> > > > @@ -192,10 +192,16 @@ static const struct regmap_config tps6594_i2c_regmap_config = {
> > > >  	.write = tps6594_i2c_write,
> > > >  };
> > > >  
> > > > +static const struct tps6594_match_data match_data[] = {
> > > > +	[TPS6594] = {TPS6594, &tps6594_i2c_regmap_config},
> > > > +	[TPS6593] = {TPS6593, &tps6594_i2c_regmap_config},
> > > > +	[LP8764] = {LP8764, &tps6594_i2c_regmap_config},
> > > 
> > > Nit: There should be spaces after the '{' and before the '}'.
> > > 
> > 
> > Sure! will fix it in the next version.
> > 
> > > > +};
> > > > +
> > > >  static const struct of_device_id tps6594_i2c_of_match_table[] = {
> > > > -	{ .compatible = "ti,tps6594-q1", .data = (void *)TPS6594, },
> > > > -	{ .compatible = "ti,tps6593-q1", .data = (void *)TPS6593, },
> > > > -	{ .compatible = "ti,lp8764-q1",  .data = (void *)LP8764,  },
> > > > +	{ .compatible = "ti,tps6594-q1", .data = &match_data[TPS6594], },
> > > > +	{ .compatible = "ti,tps6593-q1", .data = &match_data[TPS6593], },
> > > > +	{ .compatible = "ti,lp8764-q1",  .data = &match_data[LP8764], },
> > > 
> > > Not keen on this.  Why do you pass the regmap data through here and
> > > leave everything else to be matched on device ID?  It would be better to
> > > keep passing the device ID through and match everything off of that.
> > > 
> > > 
> > > -- 
> > > Lee Jones [李琼斯]
> > 
> > Thanks for the feedback!
> > 
> > These changes were made because of the following message:
> > https://lore.kernel.org/all/7hcysy6ho6.fsf@baylibre.com/
> > 
> > Please let us know which one to follow.
> 
> Right, except this doesn't eliminate "any \"if (chip_id)\" checking".
> Instead you have a hodge-podge of passing a little bit of (Regmap) data
> via match and the rest via "if (chip_id)".  So either pass all platform
> type data via .data or just the chip ID.  My suggestion 99% of the time
> is the latter.

Got it. Thanks! Will revert back to .data having chip_id.

Regards,
Bhargav

