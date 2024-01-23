Return-Path: <linux-kernel+bounces-34611-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C008B8382ED
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 03:25:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6D7F12895EA
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 02:25:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4087F5FF0C;
	Tue, 23 Jan 2024 01:51:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=peacevolution.org header.i=@peacevolution.org header.b="UXbzk5RJ"
Received: from a.peacevolution.org (a.peacevolution.org [206.189.193.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D8DE5A0F0;
	Tue, 23 Jan 2024 01:51:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=206.189.193.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705974663; cv=none; b=N7m6dFGHFMgqNnjuKD4DBKmM6cfQRPfx8YObgIrQ4fgVhvUIdD8fEI3uz915LZkh64urNl/Xlq3G29x237pjHmPt1ICPacAFE8b1gy615ZqwRWFtHB+3gZbwLOll+TZbu2gTAh2fKirwOTY26uhlJt5DSbk03+t+JC7J+kZr668=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705974663; c=relaxed/simple;
	bh=iqYg3UpTXCnDmbVXDKfyRC2z962mH7p82hDUCR95FlU=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nRSOW9urt1+SQggQApIKZ3/4UJwrxecu1SSjdszW6Nu61O0P7dk5vdFgwLP1tw/uNkhbEh7RPoR/PlAwEPDgcXBiKqvWE6bqSrpDqxMvHvhOrpdZJXATWBdZWihWQ+IyDpT/lRQQGk55iEanQhgT6nsoG+oxDfEKKKJ7vN/Z+t8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peacevolution.org; spf=pass smtp.mailfrom=peacevolution.org; dkim=pass (1024-bit key) header.d=peacevolution.org header.i=@peacevolution.org header.b=UXbzk5RJ; arc=none smtp.client-ip=206.189.193.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peacevolution.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peacevolution.org
Received: from authenticated-user (PRIMARY_HOSTNAME [PUBLIC_IP])
	by a.peacevolution.org (Postfix) with ESMTPA id BC1D54649D;
	Tue, 23 Jan 2024 01:50:59 +0000 (UTC)
Date: Mon, 22 Jan 2024 20:50:57 -0500
From: Aren <aren@peacevolution.org>
To: =?utf-8?Q?Ond=C5=99ej?= Jirman <megi@xff.cz>, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Aidan MacDonald <aidanmacdonald.0x0@gmail.com>, 
	Chen-Yu Tsai <wens@csie.org>, Sebastian Reichel <sre@kernel.org>
Subject: Re: Re: [PATCH 1/3] power: supply: axp20x_usb_power: add input
 current limit
Message-ID: <vwhypt7y4j55kdpxs2u5nltcpseoz2jgs46d7cbqfef5sfi574@t3etq66zf6qe>
References: <20240121014057.1042466-1-aren@peacevolution.org>
 <20240121014057.1042466-3-aren@peacevolution.org>
 <lz3sm6yxu3d5pgr2ffs4m3ive54lbiis6abmrph3u5wrav7lqu@qh2kivwzwd6z>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <lz3sm6yxu3d5pgr2ffs4m3ive54lbiis6abmrph3u5wrav7lqu@qh2kivwzwd6z>
X-Spamd-Bar: /
Authentication-Results: auth=pass smtp.auth=aren@peacevolution.org smtp.mailfrom=aren@peacevolution.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=peacevolution.org;
	s=dkim; t=1705974660;
	h=from:subject:date:message-id:to:mime-version:content-type:content-transfer-encoding:in-reply-to:references;
	bh=Fp3w+4ku2lZV/PjN7XpiNe0tI5XHQrA9Pauz3PXIubI=;
	b=UXbzk5RJDKBpAbCNCuqSlE+78TsFWHGjVdhWGxnjziw+2qI6iXqg4SBFLSYrjLDgcI+fgl
	XJbVWsUGengB8S0EK46VFXyrdqoZCORHyjrskWKLrkM41T1oE62R0I8T9ehSYstIV8dHxg
	oa2L3W8qVgQK/2lfBpHSeR/w1ov0oO4=

On Sun, Jan 21, 2024 at 12:38:54PM +0100, Ondřej Jirman wrote:
> Hello Aren,
> 
> On Sat, Jan 20, 2024 at 08:40:00PM -0500, Aren Moynihan wrote:
> > Add properties for setting the maximum current that will be drawn from
> > the usb connection.
> > 
> > These changes don't apply to all axp20x chips, so we need to add new
> > power_desc and power supply property objects for axp813 specifically.
> > These are copied from the axp22x variants that were used before, with
> > extra fields added.
> > 
> > Also add a dev field to the axp20x_usb_power struct, so we can use
> > dev_dbg and dev_err in more places.
> > 
> > Signed-off-by: Aren Moynihan <aren@peacevolution.org>
> > ---
> > 
> >  drivers/power/supply/axp20x_usb_power.c | 127 +++++++++++++++++++++++-
> >  1 file changed, 125 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/power/supply/axp20x_usb_power.c b/drivers/power/supply/axp20x_usb_power.c
> > index e23308ad4cc7..8c0c2c25565f 100644
> > --- a/drivers/power/supply/axp20x_usb_power.c
> > +++ b/drivers/power/supply/axp20x_usb_power.c
> > @@ -50,7 +50,10 @@ struct axp_data {
> >  	const char * const		*irq_names;
> >  	unsigned int			num_irq_names;
> >  	const int			*curr_lim_table;
> > +	int				input_curr_lim_table_size;
> > +	const int			*input_curr_lim_table;
> >  	struct reg_field		curr_lim_fld;
> > +	struct reg_field		input_curr_lim_fld;
> >  	struct reg_field		vbus_valid_bit;
> >  	struct reg_field		vbus_mon_bit;
> >  	struct reg_field		usb_bc_en_bit;
> > @@ -59,7 +62,9 @@ struct axp_data {
> >  };
> >  
> >  struct axp20x_usb_power {
> > +	struct device *dev;
> >  	struct regmap *regmap;
> > +	struct regmap_field *input_curr_lim_fld;
> >  	struct regmap_field *curr_lim_fld;
> >  	struct regmap_field *vbus_valid_bit;
> >  	struct regmap_field *vbus_mon_bit;
> > @@ -115,6 +120,15 @@ static void axp20x_usb_power_poll_vbus(struct work_struct *work)
> >  	if (val != power->old_status)
> >  		power_supply_changed(power->supply);
> >  
> > +	if (power->usb_bc_en_bit && (val & AXP20X_PWR_STATUS_VBUS_PRESENT) !=
> > +		(power->old_status & AXP20X_PWR_STATUS_VBUS_PRESENT)) {
> > +		dev_dbg(power->dev, "Cable status changed, re-enabling USB BC");
> > +		ret = regmap_field_write(power->usb_bc_en_bit, 1);
> > +		if (ret)
> > +			dev_err(power->dev, "failed to enable USB BC: errno %d",
> > +				ret);
> > +	}
> > +
> >  	power->old_status = val;
> >  	power->online = val & AXP20X_PWR_STATUS_VBUS_USED;
> >  
> > @@ -123,6 +137,66 @@ static void axp20x_usb_power_poll_vbus(struct work_struct *work)
> >  		mod_delayed_work(system_power_efficient_wq, &power->vbus_detect, DEBOUNCE_TIME);
> >  }
> >  
> > +static int
> > +axp20x_usb_power_set_input_current_limit(struct axp20x_usb_power *power,
> > +					 int limit)
> > +{
> > +	int ret;
> > +	unsigned int reg;
> > +
> > +	if (!power->axp_data->input_curr_lim_table)
> > +		return -EINVAL;
> > +
> > +	if (limit < power->axp_data->input_curr_lim_table[0])
> > +		return -EINVAL;
> 
> I think that you should just set the lowest possible limit. A caller (calling
> driver or userspace or user) has no way to identify what is the lowest possible
> limit on arbitrary PMIC and I kinda like having an option to
> echo 0 > .../axp20x-usb/input_current_limit as a way to limit power consumption from
> USB to a minimum without having to look up what actual minimum is in various
> PMICs dataheets.
> 
> I looked through most of the uses of POWER_SUPPLY_PROP_INPUT_CURRENT_LIMIT in
> the upstream drivers and both approaches are used. Erroring out when out of range
> is less common.

That should be pretty easy, I love a good reason to delete code :)

Thanks
 - Aren

> Otherwise,
> 
> Reviewed-By: Ondrej Jirman <megi@xff.cz>
> 
> Thank you,
> 	Ondrej

