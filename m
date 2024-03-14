Return-Path: <linux-kernel+bounces-103311-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FBFE87BDE7
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 14:40:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 43B821C220EA
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 13:40:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F065B6EB4B;
	Thu, 14 Mar 2024 13:40:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="TMbtXgu4"
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [217.70.183.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95DE24691;
	Thu, 14 Mar 2024 13:40:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710423638; cv=none; b=tB00ri7tBvWp7eNBFlTT9H6QlKF2N5t1HZJf6MHI4ly5eulL6S5XzKL/NoWA1oKsPlqI9Jh1yGUUyXJlW84BPzAk0HBeXZncMlg2Hu5PYPCIDTYlMmCbsW6ihpk+fKJBBH9+dPMEpLxEkniuOARz5al5lJ3KVEKD4VRrzpmxQYM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710423638; c=relaxed/simple;
	bh=6gzsPs8DS1bbnchxZSKKpfQvGwLQMdsVuv/ZEKsw7e0=;
	h=Mime-Version:Content-Type:Date:Message-Id:From:Subject:Cc:To:
	 References:In-Reply-To; b=r/l+8jjZx40/SSdzK+INxnUn3bIId/AZkghhE8lbqeIbFRy4LgsKY6VKPSDPUory7nUoZhE4KpWYOtQmAuInFz2AXGfsFssJAmq6ICQVBCwa52IWjoGsi3qRKwV/3HMzLnQRl1YQoAvT8hkeaL371WgQ3PJlOHOEb7Ds7VxMBek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=TMbtXgu4; arc=none smtp.client-ip=217.70.183.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 6B0A560006;
	Thu, 14 Mar 2024 13:40:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1710423632;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CLf5KWnS0dc/LL0QiiVlehpC6eAdJafxsnoavfmgLwM=;
	b=TMbtXgu4lYq5V/tieYmz1HsaYW6Rf/HEvX1GdFOAxI1luJbA3OTFwnc25WNGUP7TapolIZ
	cDcKPi2ywWCc9mMVPnVjQROKoWDsMLHGCIZ7TzidDZ+YwGYO+OAluQc2ndlAc0PJsEmefJ
	XrJTBbJ28o/xljiXryj/iOIiX/LRX6nscU3dmPaSAiFfsQwrBcR37hWb+lg7QFQeHi16lr
	CNnPofB0aC4ATC7UGT+Kb9lKFywZSibzLB6wcLKnOi+FdLoy2uqn8UL5Ej3IGUO5qkGx96
	krup5ruJqBBYd/pfzqFIEb/JtE2OyukuLukbVMD7prikikeyrYPt+VvYWglrNA==
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 14 Mar 2024 14:40:31 +0100
Message-Id: <CZTIKOLPZ86I.2BDL7IHLG1VVC@bootlin.com>
From: =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
Subject: Re: [PATCH v4 4/9] usb: cdns3-ti: support reset-on-resume behavior
Cc: "Thomas Petazzoni" <thomas.petazzoni@bootlin.com>,
 =?utf-8?q?Gr=C3=A9gory_Clement?= <gregory.clement@bootlin.com>, "Alan
 Stern" <stern@rowland.harvard.edu>, <linux-usb@vger.kernel.org>,
 <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <linux-arm-kernel@lists.infradead.org>
To: "Kevin Hilman" <khilman@kernel.org>, "Greg Kroah-Hartman"
 <gregkh@linuxfoundation.org>, "Rob Herring" <robh+dt@kernel.org>,
 "Krzysztof Kozlowski" <krzysztof.kozlowski+dt@linaro.org>, "Conor Dooley"
 <conor+dt@kernel.org>, "Roger Quadros" <rogerq@kernel.org>, "Peter Chen"
 <peter.chen@kernel.org>, "Pawel Laszczak" <pawell@cadence.com>, "Nishanth
 Menon" <nm@ti.com>, "Vignesh Raghavendra" <vigneshr@ti.com>, "Tero Kristo"
 <kristo@kernel.org>
X-Mailer: aerc 0.15.2
References: <20240307-j7200-usb-suspend-v4-0-5ec7615431f3@bootlin.com>
 <20240307-j7200-usb-suspend-v4-4-5ec7615431f3@bootlin.com>
 <7h4jdgperi.fsf@baylibre.com>
In-Reply-To: <7h4jdgperi.fsf@baylibre.com>
X-GND-Sasl: theo.lebrun@bootlin.com

Hello,

On Fri Mar 8, 2024 at 10:58 PM CET, Kevin Hilman wrote:
> Th=C3=A9o Lebrun <theo.lebrun@bootlin.com> writes:
> > Add match data support, with one boolean to indicate whether the
> > hardware resets after a system-wide suspend. If hardware resets, we
> > force execute ->runtime_resume() at system-wide resume to run the
> > hardware init sequence.
>
> Is "whether the hardware resets after a system-wide suspend" really a
> function of the IP itself, or rather whether the IP is in a power domain
> that might power down?

Is a compatible defining (1) the IP block involved or (2) the IP block
involved and its integration? This is a rethorical question, I've asked
it internally at Bootlin and we had some interesting discussions. :-)

Whether compatible or some other mechanism indicate expected suspend
behavior, we agreed that suspend types where not modeled properly by
the kernel currently.

> > No compatible exploits this functionality, just yet.
> >
> > Signed-off-by: Th=C3=A9o Lebrun <theo.lebrun@bootlin.com>
> > ---
> >  drivers/usb/cdns3/cdns3-ti.c | 27 +++++++++++++++++++++++++++
> >  1 file changed, 27 insertions(+)
> >
> > diff --git a/drivers/usb/cdns3/cdns3-ti.c b/drivers/usb/cdns3/cdns3-ti.=
c
> > index 4c8a557e6a6f..f76327566798 100644
> > --- a/drivers/usb/cdns3/cdns3-ti.c
> > +++ b/drivers/usb/cdns3/cdns3-ti.c
> > @@ -57,9 +57,14 @@ struct cdns_ti {
> >  	unsigned vbus_divider:1;
> >  	struct clk *usb2_refclk;
> >  	struct clk *lpm_clk;
> > +	const struct cdns_ti_match_data *match_data;
> >  	int usb2_refclk_rate_code;
> >  };
> > =20
> > +struct cdns_ti_match_data {
> > +	bool reset_on_resume;
> > +};
> > +
> >  static const int cdns_ti_rate_table[] =3D {	/* in KHZ */
> >  	9600,
> >  	10000,
> > @@ -101,6 +106,7 @@ static int cdns_ti_probe(struct platform_device *pd=
ev)
> >  	platform_set_drvdata(pdev, data);
> > =20
> >  	data->dev =3D dev;
> > +	data->match_data =3D device_get_match_data(dev);
> > =20
> >  	data->usbss =3D devm_platform_ioremap_resource(pdev, 0);
> >  	if (IS_ERR(data->usbss)) {
> > @@ -220,8 +226,29 @@ static int cdns_ti_runtime_resume(struct device *d=
ev)
> >  	return 0;
> >  }
> > =20
> > +static int cdns_ti_suspend(struct device *dev)
> > +{
> > +	struct cdns_ti *data =3D dev_get_drvdata(dev);
> > +
> > +	if (data->match_data && data->match_data->reset_on_resume)
> > +		return pm_runtime_force_suspend(dev);
> > +	else
> > +		return 0;
> > +}
> > +
> > +static int cdns_ti_resume(struct device *dev)
> > +{
> > +	struct cdns_ti *data =3D dev_get_drvdata(dev);
> > +
> > +	if (data->match_data && data->match_data->reset_on_resume)
> > +		return pm_runtime_force_resume(dev);
> > +	else
> > +		return 0;
> > +}
>
> Conditionally forcing runtime suspend/resume based on a property of the
> IP doesn't feel right to me.
>
> IMO, the device should always runtime suspend/resume, and in the
> runtime PM hooks is where the conditional logic should be.
>
> And speaking of the conditional logic... let's go back to whether
> "resets_on_resume" is a property of the IP or the enclosing power
> domain.
>
> Instead of having an IP-specific flag, another way of approaching this
> when ->runtime_resume() is called every time is simply for that hook to
> check if a reset has happend.  Sometimes you can tell this simply by
> reading a register that has been previously programmed by the driver but
> has a known reset.  Simply check that regisister and you can tell
> whether context has been lost.
>
> Doing it this way makes the driver "smart" and then you don't have to
> rely on bool flag based on the IP and dependent on the DT compatible.

I agree! I never digged into this for a reason: the HXCI subsystem takes
a quirk flag that tells it whether it resets on resume
(XHCI_RESET_ON_RESUME). My plans weren't grandiose enough to think
about touching this aspect. That means we need to know this bool value
at probe.

About a smart ->runtime_resume() implementation: it is doable. I've
experimented with that following your message. The condition is rather
simple, looking like:

	static int cdns_ti_runtime_resume(struct device *dev)
	{
		struct cdns_ti *data =3D dev_get_drvdata(dev);
		u32 w1, mask;

		w1 =3D cdns_ti_readl(data, USBSS_W1);
		mask =3D USBSS_W1_PWRUP_RST | USBSS_W1_MODESTRAP_SEL;

		if ((w1 & mask) !=3D mask)
			cdns_ti_reset_and_init_hw(dev, data);

		return 0;
	}

Tested on J7200-EVM, works as expected. Both bits reset to zero. First
is software reset; second is described as "this bit has to be always
set to 1".

cdns_ti_reset_and_init_hw() would also be call at probe before enabling
runtime PM to ensure we always reset the IP at probe.
Then ->runtime_resume() would get called once during probe without any
impact as the conditional would return false. It would trigger at
resume. System-wide suspend/resume hooks would become:

	SYSTEM_SLEEP_PM_OPS(pm_runtime_force_suspend,
			pm_runtime_force_resume)

Do you have any ideas related to the handling of XHCI_RESET_ON_RESUME?
See xhci_resume(). Some notes:

 - XHCI is capable of detect what it calls reinit (reset after resume).
   The flags only shortcut the restore attempt (which is useless when
   the controller reset) and disables warning because of reinit. Logs
   contain this when we do not pass the flag:

   [   18.518138] xhci-hcd xhci-hcd.11.auto: xHC error in resume, USBSTS 0x=
401, Reinit
   [   18.525522] usb usb1: root hub lost power or was reset
   [   18.530647] usb usb2: root hub lost power or was reset

 - Ways forward I can imagine:

    - A quick and dirty solution would be to grab a reference to the
      xhci_hcd struct pointer from TI wrapper and update quirks on the
      go.

    - Another one would be to keep as-is and let xhci-hcd warn on each
      resume. Mentioning this for exhaustiveness.

    - Introduce a new mechanism to communicate through the stack: from
      the TI wrapper, to cdns3 core, to the xhci-hcd device. Or use an
      existing mechanism if one is present.

    - Remove the assumption xHCI does that a suspend is broken if the
      controller was reset during it. That doesn't sound right to me,
      can you confirm?

Thanks!

--
Th=C3=A9o Lebrun, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com


