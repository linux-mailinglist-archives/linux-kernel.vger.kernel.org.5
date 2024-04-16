Return-Path: <linux-kernel+bounces-146428-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 01DAF8A6512
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 09:30:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 58C80B21A0E
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 07:30:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F59A7FBA4;
	Tue, 16 Apr 2024 07:29:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AeHNntX5"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 984FC6DCE8;
	Tue, 16 Apr 2024 07:29:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713252589; cv=none; b=GiGOSBceEyLsDkGgfexgyo85pcYshzM05tvGzhrqdkWmsbP3AYaZK4hnQ0BQyeHLyT0N01Cfsx2OrBzReJ6eavLVjdvgMKd6Iq+3V1sRdF4X8H9Y53IBwqDtYsTpHyQbhwNSyWuLZn39VFHBaMXtXSXwgXxIOF1GXN+bWx/TA88=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713252589; c=relaxed/simple;
	bh=YapcNKnRk49jVL0actAR4zPHO6NfkhFMbWWbyu3okcE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=j+y2fzeShenRT4PdrchNyhN8cLo4ZKlhhAp0sKNh3klSwT5UCGjP5JgvpNzipXcIH+lewKYOMRxwHEdoqAGBope76MOv9baM8Qa8DvD102/yS+56096Fdl6Y3Kq7zdinM2Jcu78/KOO7iFP3BBmID/wNCTco0NDXU2o1eofZSTA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=AeHNntX5; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713252587; x=1744788587;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=YapcNKnRk49jVL0actAR4zPHO6NfkhFMbWWbyu3okcE=;
  b=AeHNntX5SsfhChXjmMYNfuZ6yHTHymJ3fXILhq/6ysPgGpCTWWcqSlhM
   wu+moRxUuSlxZWwrJ49m4qxSLHtLqWsZRm5AXyLvrW5eHBIK6UT/ADV0F
   0m7zb6fAnU48K6z8Ksz5bMYic6mL4qzkyDAm7xZDDdDZrZnAm5QTLDtsr
   VYcVadeoGcRvhVjC0S/EAJAQ1ardGmrFzd/5aokklOvfhn875zv1w0Jor
   exwYGc8tMq/DD+q+JHx6HEt8KoqoFMzg9MxBq2Vmo/NsD3MCqD1sjgWAq
   HtijDvVrPgasWkjW3U2qcLVupBfsXDcY79cVPpNvWF9X38HJjhmpG1zN8
   w==;
X-CSE-ConnectionGUID: SAD8miaoTSC8rnM9zgTpwA==
X-CSE-MsgGUID: mEAhFsfEREeYLV2MjaqO/g==
X-IronPort-AV: E=McAfee;i="6600,9927,11045"; a="8802602"
X-IronPort-AV: E=Sophos;i="6.07,205,1708416000"; 
   d="scan'208";a="8802602"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Apr 2024 00:29:46 -0700
X-CSE-ConnectionGUID: xOYer0VFR4Ke7i/hFh4pMQ==
X-CSE-MsgGUID: cTtra31eQsGHpvbDx/r+1A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,205,1708416000"; 
   d="scan'208";a="22238467"
Received: from kuha.fi.intel.com ([10.237.72.185])
  by fmviesa009.fm.intel.com with SMTP; 16 Apr 2024 00:29:42 -0700
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Tue, 16 Apr 2024 10:29:41 +0300
Date: Tue, 16 Apr 2024 10:29:41 +0300
From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
To: Pavel Machek <pavel@ucw.cz>
Cc: phone-devel@vger.kernel.org, kernel list <linux-kernel@vger.kernel.org>,
	fiona.klute@gmx.de, martijn@brixit.nl, samuel@sholland.org,
	gregkh@linuxfoundation.org, linux-usb@vger.kernel.org, megi@xff.cz
Subject: Re: [PATCHv3 2/2] usb: typec: anx7688: Add driver for ANX7688 USB-C
 HDMI bridge
Message-ID: <Zh4o5Rw+tP9TSIVQ@kuha.fi.intel.com>
References: <ZhPMHdt6r/4D99Zg@duo.ucw.cz>
 <ZhPM4XU8ttsFftBd@duo.ucw.cz>
 <ZhUQ6kzV5ARlkfPC@kuha.fi.intel.com>
 <ZhUgrNwRYoaV1AIJ@duo.ucw.cz>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZhUgrNwRYoaV1AIJ@duo.ucw.cz>

On Tue, Apr 09, 2024 at 01:04:12PM +0200, Pavel Machek wrote:
> Hi!
> 
> > > This is driver for ANX7688 USB-C HDMI, with flashing and debugging
> > > features removed. ANX7688 is rather criticial piece on PinePhone,
> > > there's no display and no battery charging without it.
> > > 
> > > There's likely more work to be done here, but having basic support
> > > in mainline is needed to be able to work on the other stuff
> > > (networking, cameras, power management).
> > > 
> > > Signed-off-by: Ondrej Jirman <megi@xff.cz>
> > > Co-developed-by: Martijn Braam <martijn@brixit.nl>
> > > Co-developed-by: Samuel Holland <samuel@sholland.org>
> > > Signed-off-by: Pavel Machek <pavel@ucw.cz>
> > 
> > Just couple of quick comments below - I did not have time to go over
> > this very thoroughly, but I think you need to make a new version in
> > any case because of comments in 1/2.
> 
> Yes, there will be new version.
> 
> There is ton of sleep primitives, and existing ones are okay. I can
> change everything to fdelay or whatever primitive-of-the-day is, but
> I'd rather not do pointless changes.
> 
> You can ask for major changes, or complain about extra newlines, but
> doing both in the same email does not make sense.

I'm not telling you to do any major changes, yet. Right now I'm trying
to understand why you are doing thing the way you are doing them.

> > Btw, Co-developed-by comes before Signed-off-by I think.
> 
> I believe this order is fine, too.
> 
> > > +++ b/drivers/usb/typec/anx7688.c
> > > @@ -0,0 +1,1830 @@
> > > +// SPDX-License-Identifier: GPL-2.0
> > > +/*
> > > + * ANX7688 USB-C HDMI bridge/PD driver
> > > + *
> > > + * Warning, this driver is somewhat PinePhone specific.
> > 
> > So why not split this into core part and PinePhone specific glue
> > part?
> 
> Potentially a lot of work I can't really test and would rather not do.

Glue layer is usually an easy way to organise your driver into smaller
more manageable chunks, and most importantly, keep the core parts
generic. But just to be clear here, it is not always necessary - maybe
that's the case here.

> > > +	struct delayed_work work;
> > > +	struct timer_list work_timer;
> > > +
> > > +	struct mutex lock;
> > 
> > Undocumented lock.
> 
> This is simple driver. How do you expect me to document it? Protects
> this data structure, not exactly uncommon.

You use a comment to describe what the lock protects. You can use
"scripts/checkpatch.pl --strict" to spot this kind of stuff for you.

> > > +
> > > +	/* wait for power to stabilize and release reset */
> > > +	msleep(10);
> > > +	gpiod_set_value(anx7688->gpio_reset, 0);
> > > +	usleep_range(2, 4);
> > 
> > Why not just use usleep_range() in both cases.
> 
> It does not really make code any better. Can do if you insist.

Consistency makes any code better.

> > > +static int anx7688_connect(struct anx7688 *anx7688)
> > > +{
> > > +	struct typec_partner_desc desc = {};
> > > +	int ret, i;
> > > +	u8 fw[2];
> > > +	const u8 dp_snk_identity[16] = {
> > > +		0x00, 0x00, 0x00, 0xec,	/* id header */
> > > +		0x00, 0x00, 0x00, 0x00,	/* cert stat */
> > > +		0x00, 0x00, 0x00, 0x00,	/* product type */
> > > +		0x39, 0x00, 0x00, 0x51	/* alt mode adapter */
> > > +	};
> > > +	const u8 svid[4] = {
> > > +		0x00, 0x00, 0x01, 0xff,
> > > +	};
> > 
> > Why not get those from DT?
> 
> Are you sure it belongs to the DT (and that DT people will agree)?

Yes, they belong to the DT, and there are already bindings. Dmitry
gave you the link to the bindings I think (thanks for that Dmitry).

> > > +	u32 caps[8];
> > > +
> > > +	dev_dbg(anx7688->dev, "cable inserted\n");
> > > +
> > > +	anx7688->last_status = -1;
> > > +	anx7688->last_cc_status = -1;
> > > +	anx7688->last_dp_state = -1;
> > > +
> > > +	msleep(10);
> > 
> > Please make a comment here why you have to wait, and use
> > usleep_range().
> 
> /* Dunno because working code does that and waiting for hardware to
> settle down after cable insertion kind of looks like a good thing */
> 
> I did not write the driver, and there's no good documentation for this
> chip. I can try to invent something, but...
> 
> > > +	i = 0;
> > > +	while (1) {
> > > +		ret = anx7688_reg_read(anx7688, ANX7688_REG_EEPROM_LOAD_STATUS0);
> > > +
> > > +		if (ret >= 0 && (ret & ANX7688_EEPROM_FW_LOADED) == ANX7688_EEPROM_FW_LOADED) {
> > > +			dev_dbg(anx7688->dev, "eeprom0 = 0x%02x\n", ret);
> > > +			dev_dbg(anx7688->dev, "fw loaded after %d ms\n", i * 10);
> > > +			break;
> > > +		}
> > > +
> > > +		if (i > 99) {
> > > +			set_bit(ANX7688_F_FW_FAILED, anx7688->flags);
> > > +			dev_err(anx7688->dev,
> > > +				"boot firmware load failed (you may need to flash FW to anx7688 first)\n");
> > > +			ret = -ETIMEDOUT;
> > > +			goto err_vconoff;
> > > +		}
> > > +		msleep(5);
> > > +		i++;
> > > +	}
> > 
> > You need to use something like time_is_after_jiffies() here instead of
> > a counter.
> 
> Well, this works as well, but yes, I agree here.
> 
> > > +	ret = i2c_smbus_read_i2c_block_data(anx7688->client,
> > > +					    ANX7688_REG_FW_VERSION1, 2, fw);
> > > +	if (ret < 0) {
> > > +		dev_err(anx7688->dev, "failed to read firmware version\n");
> > > +		goto err_vconoff;
> > > +	}
> > > +
> > > +	dev_dbg(anx7688->dev, "OCM firmware loaded (version 0x%04x)\n",
> > > +		 fw[1] | fw[0] << 8);
> > > +
> > > +	/* Unmask interrupts */
> > > +	ret = anx7688_reg_write(anx7688, ANX7688_REG_STATUS_INT, 0);
> > > +	if (ret)
> > > +		goto err_vconoff;
> > > +
> > > +	ret = anx7688_reg_write(anx7688, ANX7688_REG_STATUS_INT_MASK, ~ANX7688_SOFT_INT_MASK);
> > > +	if (ret)
> > > +		goto err_vconoff;
> > > +
> > > +	ret = anx7688_reg_write(anx7688, ANX7688_REG_IRQ_EXT_SOURCE2, 0xff);
> > > +	if (ret)
> > > +		goto err_vconoff;
> > > +
> > > +	ret = anx7688_reg_write(anx7688, ANX7688_REG_IRQ_EXT_MASK2, (u8)~ANX7688_IRQ2_SOFT_INT);
> > > +	if (ret)
> > > +		goto err_vconoff;
> > > +
> > > +	/* time to turn off vbus after cc disconnect (unit is 4 ms) */
> > > +	ret = anx7688_reg_write(anx7688, ANX7688_REG_VBUS_OFF_DELAY_TIME, 100 / 4);
> > > +	if (ret)
> > > +		goto err_vconoff;
> > > +
> > > +	/* 300ms (unit is 2 ms) */
> > > +	ret = anx7688_reg_write(anx7688, ANX7688_REG_TRY_UFP_TIMER, 300 / 2);
> > > +	if (ret)
> > > +		goto err_vconoff;
> > > +
> > > +	/* maximum voltage in 100 mV units */
> > > +	ret = anx7688_reg_write(anx7688, ANX7688_REG_MAX_VOLTAGE, 50); /* 5 V */
> > > +	if (ret)
> > > +		goto err_vconoff;
> > > +
> > > +	/* min/max power in 500 mW units */
> > > +	ret = anx7688_reg_write(anx7688, ANX7688_REG_MAX_POWER, 15 * 2); /* 15 W */
> > > +	if (ret)
> > > +		goto err_vconoff;
> > > +
> > > +	ret = anx7688_reg_write(anx7688, ANX7688_REG_MIN_POWER, 1);  /* 0.5 W */
> > > +	if (ret)
> > > +		goto err_vconoff;
> > > +
> > > +	/* auto_pd, try.src, try.sink, goto safe 5V */
> > > +	ret = anx7688_reg_write(anx7688, ANX7688_REG_FEATURE_CTRL, 0x1e & ~BIT(2)); // disable try_src
> > 
> > Those two comments are obscure.

I'm making a note about the comments only because right now I have to
rely on things like them to get an idea about what's going on. I don't
know anything about this chip.

> I hoped they make sense to someone familiar with the area. Can't do
> much better than remove them.
> 
> > This function seems to have lot of hard coded information above.
> > Shouldn't much of that come from DT?
> 
> You tell me, I suppose you seen some similar drivers.
> 
> > Please note that if you have that PinePhone specific glue driver, you
> > can get much of the hard coded information from there, if getting the
> > information from DT is not an option for what ever reason.
> 
> Thanks for review.
> 
> Could you trim the parts of email you are not replying to?
> 
> Do you see any other major problems?
> 
> Do you have any idea if this chip is used elsewhere? I do not have any
> other hardware with anx7688, so I won't be able to test it elsewhere,
> and if there are no other users, having specific driver should not be
> a problem for anyone. If there's other user, well, there's chance they
> have docs and can help.

I don't know anything about this chip.

> How would you envision the split? Do you have any other driver that
> could be used as an example?

Check drivers/usb/dwc3/. It is a nice example how to decouple the glue
layer from the core completely - there is no API, not even driver data
is passed beteen the two.

For library like solutions, check:
drivers/usb/typec/tcpm/
drivers/usb/typec/ucsi/
drivers/usb/host/xhci*
drivers/tty/serial/8250/

But again, glue layer is just a suggestion. It would be one way to rid
of most of the hardcoded stuff by moving it there. But if much of
the hard coded parts can be moved to DT instead, then there is most
likely no need for the glue layers in this case.

thanks,

-- 
heikki

