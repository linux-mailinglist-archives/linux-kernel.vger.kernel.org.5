Return-Path: <linux-kernel+bounces-142207-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 74AD68A28DC
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 10:07:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C31BCB26CB2
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 08:07:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B484A502B3;
	Fri, 12 Apr 2024 08:05:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="Iqd20tE2"
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE29E4EB3F;
	Fri, 12 Apr 2024 08:05:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712909158; cv=none; b=q97ZBJD9VJPtBqiH/CJhXCroDxBzvvYjuEl7sSpSGe/fiodbhan8Gln1bcr2el3RPYlGEcMeU64u1iIUc+FGb1it0k83wPMgQAAI15KzWfFa3fdRo9Eb7xv2qtdrHwDJaA50uh46U1rJRwC9+VQYCaVENzRVVpYe/73tIBrx4U0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712909158; c=relaxed/simple;
	bh=4CskdLgbUVprZnubh6yZ7NlP7rLNczK+XHRCfd4/p2A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LPzgosgMZoMhUfVl8VoM8/2BpMFCqI4t/8GnhSxz8CMiZE/UKZleXufLDaQOphqkFhEZy7oH0lwshCvcUSHQHx/DW7yj5dyENRl23wa1kMB5COo5Vs+1mm86Nj+iYT0RyZDcpf4hEXquFUEHkXob9p2iZhbK/pd+8cBN3O2e7ZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=Iqd20tE2; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1712909151;
	bh=4CskdLgbUVprZnubh6yZ7NlP7rLNczK+XHRCfd4/p2A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Iqd20tE2EqLaPcWkOTarV4ImSsrSjZQioR/KfOjcx4F/+GEkgpdEC2NC8xmA4wdgN
	 F2H6Wkla6UU3UWrUX41zc3wi4vHL8kCXampMqR3QwVVvx2S0jA81240JVEGflj1WTL
	 DOCk/t4r8Ai6omdBgDWdhvPR2WCRYScd9tKOxEGs=
Date: Fri, 12 Apr 2024 10:05:51 +0200
From: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Subject: Re: [PATCH] misc/pvpanic-pci: register attributes via pci_driver
Message-ID: <bcf71f9a-5f6c-4bd3-bbbb-b3d84a5e31e6@t-8ch.de>
References: <20240411-pvpanic-pci-dev-groups-v1-1-db8cb69f1b09@weissschuh.net>
 <2024041228-maximum-aware-f078@gregkh>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2024041228-maximum-aware-f078@gregkh>

On 2024-04-12 09:45:28+0200, Greg Kroah-Hartman wrote:
> On Thu, Apr 11, 2024 at 11:33:51PM +0200, Thomas Weißschuh wrote:
> > In __pci_register_driver(), the pci core overwrites the dev_groups field of
> > the embedded struct device_driver with the dev_groups from the outer
> > struct pci_driver unconditionally.
> > 
> > Set dev_groups in the pci_driver to make sure it is used.
> > 
> > This was broken since the introduction of pvpanic-pci.
> > 
> > Fixes: db3a4f0abefd ("misc/pvpanic: add PCI driver")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
> > ---
> > Greg,
> > 
> > does it make sense to duplicate fields between struct pci_driver and
> > struct device_driver?
> > The fields "name", "groups" and "dev_groups" are duplicated.
> > 
> > pci_driver::dev_groups was introduced in
> > commit ded13b9cfd59 ("PCI: Add support for dev_groups to struct pci_driver")
> > because "this helps converting PCI drivers sysfs attributes to static"
> > 
> > I don't understand the reasoning. The embedded device_driver shares the
> > same storage lifetime and the fields have the exact same type.
> 
> It's "simpler" to have the fields be in the pci_driver structure as then
> you don't need to do the crazy:
> 	.driver = {
> 		.field = FOO,
> 	},
> 
> type of declaration just for simplicity.

You can also do

	.driver.field = FOO

which doesn't seem all that crazy and which is already used in many
places.

> And as the number overall of these structures is very very small,
> duplication on the driver level is not really an issue.

For me it's less about an issue about memory usage but correctness and
developer experience.
It took me some wondering why the attributes didn't show up.

> Duplication on a device level is another story, there should not be any
> duplication at all if possible there, as that is where it really
> matters.
> 
> > ---
> >  drivers/misc/pvpanic/pvpanic-pci.c | 4 +---
> >  1 file changed, 1 insertion(+), 3 deletions(-)
> > 
> > diff --git a/drivers/misc/pvpanic/pvpanic-pci.c b/drivers/misc/pvpanic/pvpanic-pci.c
> > index 9ad20e82785b..b21598a18f6d 100644
> > --- a/drivers/misc/pvpanic/pvpanic-pci.c
> > +++ b/drivers/misc/pvpanic/pvpanic-pci.c
> > @@ -44,8 +44,6 @@ static struct pci_driver pvpanic_pci_driver = {
> >  	.name =         "pvpanic-pci",
> >  	.id_table =     pvpanic_pci_id_tbl,
> >  	.probe =        pvpanic_pci_probe,
> > -	.driver = {
> > -		.dev_groups = pvpanic_dev_groups,
> > -	},
> > +	.dev_groups =   pvpanic_dev_groups,
> 
> Maybe we should throw a trace in the pci core if we find that dev_groups
> is set to something before we override it to catch this type of mistake
> in the future?

The current state which fields are available on which struct foo_driver
seem very ad-hoc. From the ones I looked at:

pci_driver duplicates "name", "groups" and "dev_groups".
(Of which "groups" seems wholly unused)

usb_{device_,}_driver only has "name" and "dev_groups".

platform_driver has none of them.

Instead of adding traces all over the place to me it feels better to
drop the duplication and let the compiler worry about it.

> Although, given that this never worked in the first place, it seems odd
> that the original developer never noticed it, so perhaps that's not
> really an issue here.
> 
> Oh wait, it originally did, but the pci change caused it to break,
> nevermind, it is relevent, thanks.

Indeed. Do you want me to resend it with

    Fixes: ded13b9cfd59 ("PCI: Add support for dev_groups to struct pci_driver")

?


Thomas

