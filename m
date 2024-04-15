Return-Path: <linux-kernel+bounces-145230-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6110B8A5126
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 15:25:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9326D1C220AE
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 13:25:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 037A67C090;
	Mon, 15 Apr 2024 13:11:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ltts.com header.i=@ltts.com header.b="rfmml2/9";
	dkim=pass (1024-bit key) header.d=amazonses.com header.i=@amazonses.com header.b="L74ojWGG"
Received: from c180-18.smtp-out.ap-south-1.amazonses.com (c180-18.smtp-out.ap-south-1.amazonses.com [76.223.180.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 548C279DC5;
	Mon, 15 Apr 2024 13:11:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=76.223.180.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713186670; cv=none; b=IVwPrpWwhPJFL7/hCUyR7jDgowrmbAB7vw07uRDnsDjCGGYcXJK5Ntqgj/aVO/xCtmLAbm4Q5IcFNI1LC8ViKKhvWGS+4ekX0+EWYqkNEJ9TgFRpGpZc7KRSZyr98wM51Kv+HQft4WCeb3wK3N3UrJw+5y1GhdeJb7QkreF5xa0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713186670; c=relaxed/simple;
	bh=3+tVMKLYVPytnjlmvJ023AHFKQjV5avFp/EbX6YmW4s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=d44SBNIkzsU626kqOpFqtNX3Vmkzqx2GZKsc8Kpx/6b71KIQmP6HdKxvseW935TeLFuV3nax46zUx1PqlvLwelgyJ0X3aLPjPIDaaV/6j7FqZvlZLLHRspUPVqpbNAtIlt2Q1dIT5oVJEeGJxKWvhe2mFSeNsVTMhyTa96QtnCs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ltts.com; spf=pass smtp.mailfrom=ap-south-1.amazonses.com; dkim=pass (2048-bit key) header.d=ltts.com header.i=@ltts.com header.b=rfmml2/9; dkim=pass (1024-bit key) header.d=amazonses.com header.i=@amazonses.com header.b=L74ojWGG; arc=none smtp.client-ip=76.223.180.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ltts.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ap-south-1.amazonses.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
	s=i3fe3efcd4pbz7ipgssfqjhzqx347xbc; d=ltts.com; t=1713186658;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=3+tVMKLYVPytnjlmvJ023AHFKQjV5avFp/EbX6YmW4s=;
	b=rfmml2/990hkt1QhOB1HFpgyGh+t9cG48SLlIjbCgTueVJQloJ+oUVUy9yXwqLHY
	KoSpqH/dvdTFkf8HQ9CsSuxFpenojcGxS1aB6n1BQS0WT8p0o4K0Eiyho4sRrN/dqI6
	F9EBXdpgv5zt2H3upd8kvwNGBL952kuO0hHA7XRrtlu0NUMbGeafjL9a76ws1swRmF5
	c5rAP/RhutpLIn8N/mPoUzJHfi3ewCmSaU2zXa8DmiykV8c9olmkDyDhY7pcFJFZNPl
	Rh0LlgviyPsbSgpZvuGCmKcpuyQ/sf7fYbtnDS58FEosmqEA+BlZhra8atb804BWKrK
	Cw/XOYPqCQ==
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
	s=rlntogby6xsxlfnvyxwnvvhttakdsqto; d=amazonses.com; t=1713186658;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:MIME-Version:Content-Type:Content-Transfer-Encoding:Feedback-ID;
	bh=3+tVMKLYVPytnjlmvJ023AHFKQjV5avFp/EbX6YmW4s=;
	b=L74ojWGGCTCc9CPFNBR+HigXfO+w+Rl0hcPO6NajqpLvNhAa4p2Dj9qMIAMwpQYP
	/wkCh15cgkMC8gUaO8d8PoFO6RUDW8xh8h+bCm703nQEbhr1JTSXnUkuKdgu6MzR6m4
	Cyh/OXQcYvqyfLoeYxy5vO4MpNoGYvYQ7N8rEfOA=
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
Subject: Re: [RESEND PATCH v1 05/13] mfd: tps6594-spi: Add TI TPS65224 PMIC SPI
Date: Mon, 15 Apr 2024 13:10:58 +0000
Message-ID: <0109018ee1e1d91a-d3a0a73a-548d-4b9c-a6a5-a4f375c3adf3-000000@ap-south-1.amazonses.com>
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
X-SES-Outgoing: 2024.04.15-76.223.180.18

Hello,

On Wed, 14 Feb 2024 10:10:17 -0800, Lee Jones wrote:
> On Mon, 08 Apr 2024, Bhargav Raviprakash wrote:
> 
> > Introduces a new struct tps6594_match_data. This struct holds fields for
> > chip id and regmap config. Using this struct in of_device_id data field.
> > This helps in adding support for TPS65224 PMIC.
> > 
> > Signed-off-by: Bhargav Raviprakash <bhargav.r@ltts.com>
> > Acked-by: Julien Panis <jpanis@baylibre.com>
> > ---
> >  drivers/mfd/tps6594-i2c.c   | 24 ++++++++++++++++--------
> >  drivers/mfd/tps6594-spi.c   | 24 ++++++++++++++++--------
> >  include/linux/mfd/tps6594.h | 11 +++++++++++
> >  3 files changed, 43 insertions(+), 16 deletions(-)
> > 
> > diff --git a/drivers/mfd/tps6594-i2c.c b/drivers/mfd/tps6594-i2c.c
> > index c125b474b..9e2ed48b7 100644
> > --- a/drivers/mfd/tps6594-i2c.c
> > +++ b/drivers/mfd/tps6594-i2c.c
> > @@ -192,10 +192,16 @@ static const struct regmap_config tps6594_i2c_regmap_config = {
> >  	.write = tps6594_i2c_write,
> >  };
> >  
> > +static const struct tps6594_match_data match_data[] = {
> > +	[TPS6594] = {TPS6594, &tps6594_i2c_regmap_config},
> > +	[TPS6593] = {TPS6593, &tps6594_i2c_regmap_config},
> > +	[LP8764] = {LP8764, &tps6594_i2c_regmap_config},
> 
> Nit: There should be spaces after the '{' and before the '}'.
> 

Sure! will fix it in the next version.

> > +};
> > +
> >  static const struct of_device_id tps6594_i2c_of_match_table[] = {
> > -	{ .compatible = "ti,tps6594-q1", .data = (void *)TPS6594, },
> > -	{ .compatible = "ti,tps6593-q1", .data = (void *)TPS6593, },
> > -	{ .compatible = "ti,lp8764-q1",  .data = (void *)LP8764,  },
> > +	{ .compatible = "ti,tps6594-q1", .data = &match_data[TPS6594], },
> > +	{ .compatible = "ti,tps6593-q1", .data = &match_data[TPS6593], },
> > +	{ .compatible = "ti,lp8764-q1",  .data = &match_data[LP8764], },
> 
> Not keen on this.  Why do you pass the regmap data through here and
> leave everything else to be matched on device ID?  It would be better to
> keep passing the device ID through and match everything off of that.
> 
> 
> -- 
> Lee Jones [李琼斯]

Thanks for the feedback!

These changes were made because of the following message:
https://lore.kernel.org/all/7hcysy6ho6.fsf@baylibre.com/

Please let us know which one to follow.

Regards,
Bhargav

