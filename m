Return-Path: <linux-kernel+bounces-34597-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DFF8A83821B
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 03:17:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 980951F22B5D
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 02:17:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C38258126;
	Tue, 23 Jan 2024 01:41:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=peacevolution.org header.i=@peacevolution.org header.b="dG12DKyp"
Received: from a.peacevolution.org (a.peacevolution.org [206.189.193.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 693F94EB2A;
	Tue, 23 Jan 2024 01:41:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=206.189.193.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705974062; cv=none; b=DSwfBxovTuGmxnDe+Vba4MLN7hVYwmwkfEk3FCFdSgqqLdHhIMoKTrpHY8LY8EuBMLajbVLq54BVd2wm4tulLK0aMz6w11Q3VQV6RtCc7ZifGgY3BC7mzzdFUICkptXd0yDLYnzF7UNDwjZlTOBWzR2G8AGQ6XqfGz3vr8AA5Gk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705974062; c=relaxed/simple;
	bh=Syz8seL94az5ymJrF8rtcA7PykegmWBR4oPRJPqmJig=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CDQ+Jm+n5zQw3FhTdARsnegPWir36qzpDUmKJZjRsUMuifJ0NU8kM7wp9CmlIaxCewS6bjW21WQ4Eo5vaQflVZYUwTloAf2FQmDX8piIH8Azobu2PYXTE53cZ1a3qM/LrsFeZjHAMSjAcXEGFRB+GM4ajJCT+51I544MuN+rD+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peacevolution.org; spf=pass smtp.mailfrom=peacevolution.org; dkim=pass (1024-bit key) header.d=peacevolution.org header.i=@peacevolution.org header.b=dG12DKyp; arc=none smtp.client-ip=206.189.193.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peacevolution.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peacevolution.org
Received: from authenticated-user (PRIMARY_HOSTNAME [PUBLIC_IP])
	by a.peacevolution.org (Postfix) with ESMTPA id DB5F94649D;
	Tue, 23 Jan 2024 01:40:57 +0000 (UTC)
Date: Mon, 22 Jan 2024 20:40:55 -0500
From: Aren <aren@peacevolution.org>
To: =?utf-8?Q?Ond=C5=99ej?= Jirman <megi@xff.cz>, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Aidan MacDonald <aidanmacdonald.0x0@gmail.com>, 
	Chen-Yu Tsai <wens@csie.org>, Quentin Schulz <quentin.schulz@bootlin.com>, 
	Sebastian Reichel <sre@kernel.org>
Subject: Re: [PATCH 3/3] power: supply: axp20x_usb_power: set input current
 limit in probe
Message-ID: <wavexoz34i5qq53iyb33k4ned37lpwzkr7lstddddjc6cmdkpe@nbd4fymlnrzp>
References: <20240121014057.1042466-1-aren@peacevolution.org>
 <20240121014057.1042466-7-aren@peacevolution.org>
 <tgejuevbkneg5vmo7lnxf7ml3z2g3jcjweii7lxqp5lrxs6srd@la3rdfiiqbun>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <tgejuevbkneg5vmo7lnxf7ml3z2g3jcjweii7lxqp5lrxs6srd@la3rdfiiqbun>
X-Spamd-Bar: /
Authentication-Results: auth=pass smtp.auth=aren@peacevolution.org smtp.mailfrom=aren@peacevolution.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=peacevolution.org;
	s=dkim; t=1705974058;
	h=from:subject:date:message-id:to:mime-version:content-type:content-transfer-encoding:in-reply-to:references;
	bh=FhMSIDj3bfkwvKkldesDlbuQ7+XEiiQAXcqPh5ECF08=;
	b=dG12DKypd21XN+Lh42t9dVJYE8oxAX26aHotZ3psk/4l0E9IOV3dpSwubkhjQTsm7yx3Dx
	k3AuRfetObcSl2L3ZZ5vfOssp3S8gno5QTZ8xYXyPbsN9jLE/njhYfqnfg/5tqliknlwCI
	MPERDx4avCe6aTUTTZfQ1Zcic8tOOAw=

On Sun, Jan 21, 2024 at 12:08:37PM +0100, Ondřej Jirman wrote:
> Hello Aren,
> 
> On Sat, Jan 20, 2024 at 08:40:04PM -0500, Aren Moynihan wrote:
> > axp803 sets the current limit to 3A by default if it doesn't detect a
> > battery. The datasheet says that reg 0x2D bit 6 is used to indicate
> > first power on status. According to it, if that bit is 0 and the
> > battery is not detected, it will set the input current limit to 3A,
> > however setting that bit to 1 doesn't to prevent the pmic from setting
> > the current limit to 3A.
> > 
> > Fixes: c279adafe6ab ("power: supply: axp20x_usb_power: add support for AXP813")
> > 
> > Signed-off-by: Aren Moynihan <aren@peacevolution.org>
> > ---
> > I'm not sure if the pmic simply ignores the first power on field, or if
> > it needs to be set in a specific way / at a specific time. I tried
> > setting it in arm-trusted-firmware, and the pmic still set the input
> > current limit to 3A.
> > 
> > The datasheet for axp813 says it has the same first power on bit, but I
> > don't have hardware to test if it behaves the same way. This driver uses
> > the same platform data for axp803 and axp813.
> > 
> >  drivers/power/supply/axp20x_usb_power.c | 13 +++++++++++++
> >  1 file changed, 13 insertions(+)
> > 
> > diff --git a/drivers/power/supply/axp20x_usb_power.c b/drivers/power/supply/axp20x_usb_power.c
> > index 5656f6e57d54..95b136ee20f2 100644
> > --- a/drivers/power/supply/axp20x_usb_power.c
> > +++ b/drivers/power/supply/axp20x_usb_power.c
> > @@ -52,6 +52,7 @@ struct axp_data {
> >  	const int			*curr_lim_table;
> >  	int				input_curr_lim_table_size;
> >  	const int			*input_curr_lim_table;
> > +	int				force_input_curr_lim;
> >  	struct reg_field		curr_lim_fld;
> >  	struct reg_field		input_curr_lim_fld;
> >  	struct reg_field		vbus_valid_bit;
> > @@ -599,6 +600,7 @@ static const struct axp_data axp813_data = {
> >  	.input_curr_lim_table_size = ARRAY_SIZE(axp_813_usb_input_curr_lim_table),
> >  	.input_curr_lim_table = axp_813_usb_input_curr_lim_table,
> >  	.input_curr_lim_fld = REG_FIELD(AXP22X_CHRG_CTRL3, 4, 7),
> > +	.force_input_curr_lim = 500000,
> >  	.usb_bc_en_bit	= REG_FIELD(AXP288_BC_GLOBAL, 0, 0),
> >  	.usb_bc_det_fld = REG_FIELD(AXP288_BC_DET_STAT, 5, 7),
> >  	.vbus_disable_bit = REG_FIELD(AXP20X_VBUS_IPSOUT_MGMT, 7, 7),
> > @@ -786,6 +788,17 @@ static int axp20x_usb_power_probe(struct platform_device *pdev)
> >  			return ret;
> >  	}
> >  
> > +	if (power->axp_data->force_input_curr_lim) {
> > +		/*
> > +		 * Certain chips set the input current limit to 3A when there is
> > +		 * no battery connected. Normally the default is 500mA.
> > +		 */
> > +		ret = axp20x_usb_power_set_input_current_limit(power,
> > +				power->axp_data->force_input_curr_lim);
> > +		if (ret)
> > +			return ret;
> > +	}
> 
> This will break the usecase of powering Pinephone from USB without a battery
> present (or fully discharged).
> 
> The phone can require more than 500mA before USB power supply detection manages
> to run and sets the higher limit. Linux should keep the limit set by the
> bootloader until it figures out something better based on BC 1.2 or USB-PD.
> 
> You should only change the limit as the result of negotiation.

Unfortunately BC 1.2 detection doesn't seem to be performed without a
battery, at least I wasn't able to trigger it.

This will be worth revising once we have a driver that can provide a
signal that USB-PD is in progress and/or finished, but until then I'd
prefer not take on that complexity.

 - Aren

> Kind regards,
> 	o.
> 
> >  	if (power->usb_bc_en_bit) {
> >  		/* Enable USB Battery Charging specification detection */
> >  		ret = regmap_field_write(power->usb_bc_en_bit, 1);
> > -- 
> > 2.43.0
> > 

