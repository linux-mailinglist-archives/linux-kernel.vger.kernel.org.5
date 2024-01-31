Return-Path: <linux-kernel+bounces-45738-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1ECEF8434CA
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 05:20:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7E6F5B255CB
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 04:20:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 340AA17BD2;
	Wed, 31 Jan 2024 04:20:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=peacevolution.org header.i=@peacevolution.org header.b="gzpn3RQx"
Received: from a.peacevolution.org (a.peacevolution.org [206.189.193.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08AAF20DE0;
	Wed, 31 Jan 2024 04:20:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=206.189.193.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706674836; cv=none; b=o7Dmi8yCJ97IsZ3yrawElgt1EY49gxLWD0H2oRtbjwEIrM7vpp94AsqWxxbWXVaIymI1X1OncxK/wiFk/mSUY6QzwW5WlyIEmXJzgiKHnTTpyY4rlqqEC6PZS5B18/e+e6NQDNiE97VAfoYtbChnOx/fs9JrEYCKoL+n7oYB4g0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706674836; c=relaxed/simple;
	bh=L6sD+oohOUyV59M7a4EMJuCqSkRVUhGojTTyyAFZlGM=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eH+xdtV5/FIwezzMl7uiOSu1HJemjvXMfRzgFHY4CLQG6bKGGoAGTtBSFtWLIxrX9sm07NGIp7tDuk9fuMG1mNC7FJ5XOHoNLDH38D5yvMGicxU0adZiSkIYn9fYpwG1rf58P4kggsYvgzqCD7OWbbcGc8Dn50LXrPoTZ6IYeB8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peacevolution.org; spf=pass smtp.mailfrom=peacevolution.org; dkim=pass (1024-bit key) header.d=peacevolution.org header.i=@peacevolution.org header.b=gzpn3RQx; arc=none smtp.client-ip=206.189.193.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peacevolution.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peacevolution.org
Received: from authenticated-user (PRIMARY_HOSTNAME [PUBLIC_IP])
	by a.peacevolution.org (Postfix) with ESMTPA id B4FD743C8C;
	Wed, 31 Jan 2024 04:20:31 +0000 (UTC)
Date: Tue, 30 Jan 2024 23:20:29 -0500
From: Aren <aren@peacevolution.org>
To: =?utf-8?Q?Ond=C5=99ej?= Jirman <megi@xff.cz>, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Hans de Goede <j.w.r.degoede@gmail.com>, 
	Aidan MacDonald <aidanmacdonald.0x0@gmail.com>, Chen-Yu Tsai <wens@csie.org>, 
	Quentin Schulz <quentin.schulz@bootlin.com>, Sebastian Reichel <sre@kernel.org>
Subject: Re: [PATCH v2 5/5] power: supply: axp20x_usb_power: set input
 current limit in probe
Message-ID: <hlnzivsmt66icz4bsayv5wtlgbktq355m4qxj532lg4lgeimju@jammw2y6zpha>
References: <20240130203714.3020464-1-aren@peacevolution.org>
 <20240130203714.3020464-6-aren@peacevolution.org>
 <6nf7h3nc4q7fwrnm4spmgv2sdkczowkfpietcv2tyv4mixkq3b@svxgzkdqnzlq>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <6nf7h3nc4q7fwrnm4spmgv2sdkczowkfpietcv2tyv4mixkq3b@svxgzkdqnzlq>
X-Spamd-Bar: /
Authentication-Results: auth=pass smtp.auth=aren@peacevolution.org smtp.mailfrom=aren@peacevolution.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=peacevolution.org;
	s=dkim; t=1706674832;
	h=from:subject:date:message-id:to:mime-version:content-type:content-transfer-encoding:in-reply-to:references;
	bh=L7xmgYy2TShL8M4YtYlyfP8oQps04WEC+psVsxEOru8=;
	b=gzpn3RQxkzha6+DZbcyd/goAVrz9mHRFlU8cJcWJjwIzORGW9jaEPS1Vsd15NBZ3T3MK/F
	oShFLspGIdTpQUHHVx4QF7N4iGoX0v0Fuh72auaqsoa43ECI5yv1aYMUBFR6CII7P0cg2A
	Dl6pYNr07hOM0bLke1Eqbhpt8xOZAGI=

On Tue, Jan 30, 2024 at 10:13:06PM +0100, Ondřej Jirman wrote:
> On Tue, Jan 30, 2024 at 03:28:01PM -0500, Aren Moynihan wrote:
> > axp803 sets the current limit to 3A by default if it doesn't detect a
> > battery. The datasheet says that register 0x2D bit 6 is used to indicate
> > first power on status. According to it, if that bit is 0 and the battery
> > is not detected, it will set the input current limit to 3A, however
> > setting that bit to 1 doesn't to prevent the pmic from setting the
> > current limit to 3A.
> > 
> > Waiting for USB BC detection doesn't work either, because (as far as I
> > can tell) USB BC detection isn't performed when there isn't a battery
> > detected.
> > 
> > Fixes: c279adafe6ab ("power: supply: axp20x_usb_power: add support for AXP813")
> 
> Breaks: ;)
> 
> Last time you wrote:
> 
> > Unfortunately BC 1.2 detection doesn't seem to be performed without a
> > battery, at least I wasn't able to trigger it.
> >
> > This will be worth revising once we have a driver that can provide a
> > signal that USB-PD is in progress and/or finished, but until then I'd
> > prefer not take on that complexity.
> 
> This patch adds complexity and will lead to hard to debug issues for some
> people. It certainly did cause issues for me, when I had similar patch in
> my tree a while ago, forcing me to drop it.
> 
> There are other situations you're not considering. Like battery being
> very discharged and unable to provide power, while still being detected
> and BC1.2 running correctly and successfully when the device is powered
> up by being plugged into DCP port (only option of powerup in such a 
> scenario).

Oh you're right, I overlooked the case where the battery is very low, in
which case bc detection should still be performed (I think, I haven't
tested it). This issue this patch is trying to fix doesn't apply in that
case, so it should be simple enough to check if the pmic has detected a
battery and skip setting the current limit if it has.

> Battery is detected at 2.2V and certainly it will not provide any power
> if OCV of the battery is anywhere below 3V. See "9.4.5 Battery detection"
> in AXP803 datasheet. So you have about 1V range of possible battery voltage
> where BC1.2 will work, but you'll force lower the correctly detected current
> limit and break boot, because 2.5W is too low for the boot time power surge.
> 
> The phone will just randomly die halfthrough boot for apparently no reason,
> despite being connected to DCP.
> 
> And also forget Pinephone, there may also be batteryless SBCs using this PMIC
> with battery as an option (similar to Quartz64-A - Rockchip SBC, but exactly
> this setup with battery capable PMIC in the power path on a normal SBC, with
> battery being optional), where this patch will break boot on them, too. I'm
> quite confident PMIC relaxing the limit without a battery is meant for such use
> cases.

Perhaps it would be better to read the limit from the device tree, that
way it could be set higher for a specific board if it needs to draw that
much current and be able to boot without a battery? It seems sketchy to
default to a current limit significantly higher than what the usb power
supply is required to support.

> If you insist on adding this, at least add dev_warn() about forcing lower
> limit than detected by the PMIC, so that people who'll do cursory debugging
> via serial console will know why's their device failing to boot on a strong
> enough power supply, or why their SBC is suddenly failing when used without
> battery.

Adding a dev_warn is a good idea, I'll do that.

Thanks for the review
 - Aren

> As for me, this patch should not be applied at all.
> 
> Kind regards,
>         o.
> 
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
> > (no changes since v1)
> > 
> >  drivers/power/supply/axp20x_usb_power.c | 13 +++++++++++++
> >  1 file changed, 13 insertions(+)
> > 
> > diff --git a/drivers/power/supply/axp20x_usb_power.c b/drivers/power/supply/axp20x_usb_power.c
> > index dae7e5cfc54e..751b9f02d36f 100644
> > --- a/drivers/power/supply/axp20x_usb_power.c
> > +++ b/drivers/power/supply/axp20x_usb_power.c
> > @@ -51,6 +51,7 @@ struct axp_data {
> >  	unsigned int			num_irq_names;
> >  	const int			*curr_lim_table;
> >  	int				curr_lim_table_size;
> > +	int				force_curr_lim;
> >  	struct reg_field		curr_lim_fld;
> >  	struct reg_field		vbus_valid_bit;
> >  	struct reg_field		vbus_mon_bit;
> > @@ -545,6 +546,7 @@ static const struct axp_data axp813_data = {
> >  	.curr_lim_table = axp813_usb_curr_lim_table,
> >  	.curr_lim_table_size = ARRAY_SIZE(axp813_usb_curr_lim_table),
> >  	.curr_lim_fld	= REG_FIELD(AXP22X_CHRG_CTRL3, 4, 7),
> > +	.force_curr_lim = 500000,
> >  	.usb_bc_en_bit	= REG_FIELD(AXP288_BC_GLOBAL, 0, 0),
> >  	.usb_bc_det_fld = REG_FIELD(AXP288_BC_DET_STAT, 5, 7),
> >  	.vbus_disable_bit = REG_FIELD(AXP20X_VBUS_IPSOUT_MGMT, 7, 7),
> > @@ -726,6 +728,17 @@ static int axp20x_usb_power_probe(struct platform_device *pdev)
> >  			return ret;
> >  	}
> >  
> > +	if (power->axp_data->force_curr_lim) {
> > +		/*
> > +		 * Some chips set the input current limit to 3A when there is no
> > +		 * battery connected. Normally the default is 500mA.
> > +		 */
> > +		ret = axp20x_usb_power_set_input_current_limit(power,
> > +				power->axp_data->force_curr_lim);
> > +		if (ret)
> > +			return ret;
> > +	}
> > +
> >  	if (power->usb_bc_en_bit) {
> >  		/* Enable USB Battery Charging specification detection */
> >  		ret = regmap_field_write(power->usb_bc_en_bit, 1);
> > -- 
> > 2.43.0
> > 

