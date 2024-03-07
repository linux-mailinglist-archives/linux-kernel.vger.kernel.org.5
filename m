Return-Path: <linux-kernel+bounces-95200-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 73617874A92
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 10:19:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7EF13B21D5A
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 09:19:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2914839FE;
	Thu,  7 Mar 2024 09:19:03 +0000 (UTC)
Received: from esa1.ltts.com (unknown [118.185.121.105])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B523882D8E;
	Thu,  7 Mar 2024 09:19:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=118.185.121.105
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709803143; cv=none; b=he3hRQZPcZYiiG1Evn4FAWYi0G4S2B+zcIdvsIkCQ+e9aUup2L0w+n3iusP0DB2dNyYhX6QgTAIRp9WO4L/D9ItSnMjE9nOpenSlgL+YroSeyjY8gFcOzaoIChqbwhq6b2THwv24VtI8TkLEmycCoPilwfRVWb+3nSVlPTE4u4k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709803143; c=relaxed/simple;
	bh=aiV8qMXWS6Dq/pQyTCjQZnxVG4IQD/pOBZqiVbw3NbM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=iWUwwqF70S/+PQpFYIA36tfUsauf02DGl1N76r9XW4NqtDjY7pwCub3/FDrOMPdEvah3vX+0J0SGfpTAqQnWiSE30R7LtzonHPbrEIckzsKoUAYvP3Wkwsq9JQsNDUYBPrmwyYDLAKWjKxxtZelvuL8Vn8Bqa6fAwwZQnlFD05E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ltts.com; spf=pass smtp.mailfrom=ltts.com; arc=none smtp.client-ip=118.185.121.105
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ltts.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ltts.com
IronPort-SDR: 4/Skofcaf2Doci1p8JpwKKKqp5vHOQ0sfbjsjorvCW+ts+uCrs9ignP5fxHsnmLs0DA7/aDesm
 lbvRAmRM8B8g==
Received: from unknown (HELO localhost.localdomain) ([192.168.34.55])
  by esa1.ltts.com with ESMTP; 07 Mar 2024 14:47:44 +0530
From: Bhargav Raviprakash <bhargav.r@ltts.com>
To: eblanc@baylibre.com
Cc: arnd@arndb.de,
	bhargav.r@ltts.com,
	broonie@kernel.org,
	conor+dt@kernel.org,
	devicetree@vger.kernel.org,
	gregkh@linuxfoundation.org,
	jpanis@baylibre.com,
	kristo@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	lee@kernel.org,
	lgirdwood@gmail.com,
	linus.walleij@linaro.org,
	linux-arm-kernel@lists.infradead.org,
	linux-gpio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	m.nirmaladevi@ltts.com,
	nm@ti.com,
	robh+dt@kernel.org,
	vigneshr@ti.com
Subject: Re: [PATCH v2 12/14] regulator: tps6594-regulator: Add TI TPS65224 PMIC regulators
Date: Thu,  7 Mar 2024 14:47:34 +0530
Message-Id: <20240307091734.171367-1-bhargav.r@ltts.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <CZHN4S2QW6MY.KKKHHRPPY4ZG@baylibre.com>
References: <CZHN4S2QW6MY.KKKHHRPPY4ZG@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hello,

On Thu, 29 Feb 2024 15:42:50 +0100, Esteban Blanc wrote:
> On Fri Feb 23, 2024 at 10:36 AM CET, Bhargav Raviprakash wrote:
> > From: Nirmala Devi Mal Nadar <m.nirmaladevi@ltts.com>
> 
> > @@ -122,6 +131,27 @@ static const struct linear_range ldos_4_ranges[] = {
> >  	REGULATOR_LINEAR_RANGE(1200000, 0x20, 0x74, 25000),
> >  };
> >  
> > +/* Voltage range for TPS65224 Bucks and LDOs */
> > +static const struct linear_range tps65224_bucks_1_ranges[] = {
> 
> You prefixed your arrays with `tps65224` and that makes sense. However
> you should also prefix the old ones with `tps6594` then.
> This applies to the whole driver.
> 

Thnaks for the feedback! We will work on it.

> > @@ -374,11 +518,17 @@ static int tps6594_request_reg_irqs(struct platform_device *pdev,
> >  {
> >  	struct tps6594_regulator_irq_type *irq_type;
> >  	struct tps6594 *tps = dev_get_drvdata(pdev->dev.parent);
> > -	int j;
> > +	size_t j;
> >  	int irq;
> >  	int error;
> > +	size_t interrupt_cnt;
> >  
> > -	for (j = 0; j < REGS_INT_NB; j++) {
> > +	/* Number of interrupts supported by each voltage source */
> > +	interrupt_cnt = (tps->chip_id == TPS6594) ?
> > +			 ARRAY_SIZE(tps6594_buck1_irq_types) :
> > +			 ARRAY_SIZE(tps65224_buck1_irq_types);
> 
> The comment is not adding anything, the name is clear and ARRAY_SIZE is
> quite explicit.
> 

Sure, will remove it.

> > +		for (i = 0; i < LDO_NB; i++) {
> > +			if (ldo_configured[i] == 1)
> > +				continue;
> >  
> > -			error = tps6594_request_reg_irqs(pdev, rdev, irq_data,
> > -							 tps6594_ldos_irq_types[i],
> > -							 &irq_idx);
> > -			if (error)
> > -				return error;
> > +		struct tps6594_regulator_irq_type **ldos_irq_types = (tps->chip_id == TPS65224) ?
> > +								       tps65224_ldos_irq_types :
> > +								       tps6594_ldos_irq_types;
> > +
> > +		const struct regulator_desc *ldo_regs = (tps->chip_id == TPS65224) ?
> > +							 tps65224_ldo_regs :
> > +							 tps6594_ldo_regs;
> > +
> > +		rdev = devm_regulator_register(&pdev->dev, &ldo_regs[i], &config);
> > +		if (IS_ERR(rdev))
> > +			return dev_err_probe(tps->dev, PTR_ERR(rdev),
> > +					     "failed to register %s regulator\n", pdev->name);
> > +
> > +		error = tps6594_request_reg_irqs(pdev, rdev, irq_data, ldos_irq_types[i], &irq_idx);
> > +		if (error)
> > +			return error;
> 
> There is an indentation missing on the content of the `for` loop.
> 

Thanks for pointing it out.
It will be fixed in the next version.

> Best regards,
> 
> -- 
> Esteban "Skallwar" Blanc
> BayLibre

Regards,
Bhargav

