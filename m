Return-Path: <linux-kernel+bounces-138419-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E6F589F0FD
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 13:36:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AD9CF1C2295C
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 11:36:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 609AD15A488;
	Wed, 10 Apr 2024 11:36:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=xff.cz header.i=@xff.cz header.b="yXwHNfQW"
Received: from vps.xff.cz (vps.xff.cz [195.181.215.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8AE8159218;
	Wed, 10 Apr 2024 11:36:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.181.215.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712748965; cv=none; b=RsoX0jHLtuivZ0XOTH7Puyf/GIxsfyTQ5sdYUwYhlEjB3caXUwGdGkFur6MLrY+FLpT9UUanZrdYj/PYjtUnyhHYpnD1GZNOeaf9dSfsIbxltfl/JISPCs3ZOhB5SfAJb40G6bD3jqDYydNdDqNjw5sNdXrcJPh8ZpnQUOidyQw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712748965; c=relaxed/simple;
	bh=Ic80lKxXlrfuGtHeTwfTiU1jBSV+pwad7wWYK2F09mg=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CMQTi7Wl18dRURzwEcC1mPDThkjSgoOEWcIqF1VYu6dWU1K8abGoJcyBw3o/mlF9p3Tr2CW0Zer7A9iZHY0NFgE2MiMx0nB94m5UJRNRgJW92h2MTGP/52cGiJSKIpHqXpWVFJseXgpzH9qghENmPtXzLVwx/xTk53wk2bbS0zA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=xff.cz; spf=pass smtp.mailfrom=xff.cz; dkim=pass (1024-bit key) header.d=xff.cz header.i=@xff.cz header.b=yXwHNfQW; arc=none smtp.client-ip=195.181.215.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=xff.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xff.cz
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=xff.cz; s=mail;
	t=1712748958; bh=Ic80lKxXlrfuGtHeTwfTiU1jBSV+pwad7wWYK2F09mg=;
	h=Date:From:To:Subject:X-My-GPG-KeyId:References:From;
	b=yXwHNfQWWvkoTi57EHqzuVcxUcyITpCFZzlkPxdhM0v2Lq7MNftqiLF5AdS9vl0Lm
	 cuXoqMPEuLU3VY33qn2jqCfZ0ALIDnKvGbMNr1aoG6JDzl+R/yncrm+dWij7quUdma
	 wg+BBryoHCFgsAYdGGFpNCcTngEC7bCixXWsWw0o=
Date: Wed, 10 Apr 2024 13:35:57 +0200
From: =?utf-8?Q?Ond=C5=99ej?= Jirman <megi@xff.cz>
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, 
	Pavel Machek <pavel@ucw.cz>, Heikki Krogerus <heikki.krogerus@linux.intel.com>, 
	phone-devel@vger.kernel.org, kernel list <linux-kernel@vger.kernel.org>, fiona.klute@gmx.de, 
	martijn@brixit.nl, samuel@sholland.org, gregkh@linuxfoundation.org, 
	linux-usb@vger.kernel.org
Subject: Re: [PATCHv3 2/2] usb: typec: anx7688: Add driver for ANX7688 USB-C
 HDMI bridge
Message-ID: <dm3zqvl45u2pfeje5ztmhjvflazztpd2xnagle2wztrebilggy@ie24awwsh6sl>
Mail-Followup-To: =?utf-8?Q?Ond=C5=99ej?= Jirman <megi@xff.cz>, 
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, Pavel Machek <pavel@ucw.cz>, 
	Heikki Krogerus <heikki.krogerus@linux.intel.com>, phone-devel@vger.kernel.org, 
	kernel list <linux-kernel@vger.kernel.org>, fiona.klute@gmx.de, martijn@brixit.nl, samuel@sholland.org, 
	gregkh@linuxfoundation.org, linux-usb@vger.kernel.org
X-My-GPG-KeyId: EBFBDDE11FB918D44D1F56C1F9F0A873BE9777ED
 <https://xff.cz/key.txt>
References: <ZhPMHdt6r/4D99Zg@duo.ucw.cz>
 <ZhPM4XU8ttsFftBd@duo.ucw.cz>
 <ZhUQ6kzV5ARlkfPC@kuha.fi.intel.com>
 <ZhUgrNwRYoaV1AIJ@duo.ucw.cz>
 <4q7o5vb26ibkbvqal5nn4kdnc32rrajhtszrf4fnuisnlfcsg5@6322saeu7qoe>
 <2panrf3dgpwkwywf4vv676tjlbdqpzjb75vpfhiohabhrxc6h2@tmouy7prgikm>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2panrf3dgpwkwywf4vv676tjlbdqpzjb75vpfhiohabhrxc6h2@tmouy7prgikm>

On Wed, Apr 10, 2024 at 01:32:27PM GMT, megi xff wrote:
> On Tue, Apr 09, 2024 at 06:35:50PM GMT, Dmitry Baryshkov wrote:
> > On Tue, Apr 09, 2024 at 01:04:12PM +0200, Pavel Machek wrote:
> > > Hi!
> > > 
> > > > > This is driver for ANX7688 USB-C HDMI, with flashing and debugging
> > > > > features removed. ANX7688 is rather criticial piece on PinePhone,
> > > > > there's no display and no battery charging without it.
> > > > > 
> > > > > There's likely more work to be done here, but having basic support
> > > > > in mainline is needed to be able to work on the other stuff
> > > > > (networking, cameras, power management).
> > > > > 
> > > > > Signed-off-by: Ondrej Jirman <megi@xff.cz>
> > > > > Co-developed-by: Martijn Braam <martijn@brixit.nl>
> > > > > Co-developed-by: Samuel Holland <samuel@sholland.org>
> > > > > Signed-off-by: Pavel Machek <pavel@ucw.cz>
> > > > 
> > > > Just couple of quick comments below - I did not have time to go over
> > > > this very thoroughly, but I think you need to make a new version in
> > > > any case because of comments in 1/2.
> > > 
> > 
> > [skipped]
> > 
> > > 
> > > > > +static int anx7688_connect(struct anx7688 *anx7688)
> > > > > +{
> > > > > +	struct typec_partner_desc desc = {};
> > > > > +	int ret, i;
> > > > > +	u8 fw[2];
> > > > > +	const u8 dp_snk_identity[16] = {
> > > > > +		0x00, 0x00, 0x00, 0xec,	/* id header */
> > > > > +		0x00, 0x00, 0x00, 0x00,	/* cert stat */
> > > > > +		0x00, 0x00, 0x00, 0x00,	/* product type */
> > > > > +		0x39, 0x00, 0x00, 0x51	/* alt mode adapter */
> > > > > +	};
> > > > > +	const u8 svid[4] = {
> > > > > +		0x00, 0x00, 0x01, 0xff,
> > > > > +	};
> > > > 
> > > > Why not get those from DT?
> > > 
> > > Are you sure it belongs to the DT (and that DT people will agree)?
> > 
> > From Documentation/devicetree/bindings/connector/usb-connector.yaml:
> > 
> >             altmodes {
> >                 displayport {
> >                     svid = /bits/ 16 <0xff01>;
> >                     vdo = <0x00001c46>;
> >                 };
> >             };
> > 
> > BTW, I don't see the VDO for the DP altmode in your code. Maybe I missed
> > it at a quick glance.
> 
> VDO is set via TYPE_DP_SNK_CFG message to the firmware. There may be some
> default in the firmware which matches Pinephone receptacle configuration.
> 
> I guess the driver can send the VDO value from DT after firmware is
> initialized. Other values can be set in DT too, but extreme care needs to
> ne take, because firmware has some bugs, which cause it to request
> high voltage from PD PSU when it's in fact not part of PDO, potentially
> destroying the device. So I'd rather not expose at least PDOs in DT to random
> unsuspecting DT users who just copy paste and edit DT without reading the driver
> code or some obscure notes somewhere.

Or at least have strong warnings everywhere this is used in DT, not just in DT
bindings documentation, because requesting 21V when PDO in DT says 5V is pretty
unpleasant.

kind regards,
	o.

> kind regards,
> 	o.
> 
> > > 
> > > > > +	u32 caps[8];
> > > > > +
> > 
> > 
> > -- 
> > With best wishes
> > Dmitry

