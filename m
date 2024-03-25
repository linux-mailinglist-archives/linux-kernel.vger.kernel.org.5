Return-Path: <linux-kernel+bounces-117365-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E528288AA78
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 17:59:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 14B9C1C32198
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 16:59:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 599BB137906;
	Mon, 25 Mar 2024 15:28:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kemnade.info header.i=@kemnade.info header.b="0Y6YHIXs"
Received: from mail2.andi.de1.cc (vmd64148.contaboserver.net [161.97.139.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9A89745FA;
	Mon, 25 Mar 2024 15:28:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=161.97.139.27
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711380496; cv=none; b=CBmialUbifQ32D28df5qN/pvcpvo5Nb8hLVlXaKKfjGhWxxo2KtoewZEUle2v8SMgjI2uSFpinaqC2+Y0nNW6NZeZHk+dtswYa4fpLdDQm9f7CjI6zg+75aixwQAqg/Pkfsg0fKDrsl21Lz2K4omsr1PIfopEgnuOYJagAk767E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711380496; c=relaxed/simple;
	bh=kfH21rtagPKM4TfPELk1Qq0RJYu90Ijc8DkZ+yFtfSI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ITWVSd+l5ekwppFXm2Q934Rn9uOilPhg7Lu/tluBtrYWNaW1uuyJjBpLtabm3oP8MvmiC8uqGdqMA07tV9AVWqgr7Fxv1qv8p1e5oBm68RhhKnZtNvemydItKl8n0H4yThJRZb+965Q8wNhzJyW4sSsld6FAXoLFROt1e0xrppw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kemnade.info; spf=pass smtp.mailfrom=kemnade.info; dkim=pass (2048-bit key) header.d=kemnade.info header.i=@kemnade.info header.b=0Y6YHIXs; arc=none smtp.client-ip=161.97.139.27
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kemnade.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kemnade.info
Received: from mail.andi.de1.cc ([2a02:c205:3004:2154::1])
	by mail2.andi.de1.cc with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <andreas@kemnade.info>)
	id 1roltB-003KE3-28;
	Mon, 25 Mar 2024 16:05:29 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=kemnade.info; s=20220719; h=Content-Transfer-Encoding:Content-Type:
	MIME-Version:References:In-Reply-To:Message-ID:Subject:Cc:To:From:Date:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=Jji4OJyGIzKYC/XHH+rTL1kxSqhQZplsoNkI3fzj1SU=; b=0Y6YHIXsMArdgKBkv6vlMic+Y2
	qc6eIcHr14L1vFJW57KLqMUoGWvZqe6SgAF1wY/DjbHh/nunO9+2Y8f6JEMBGm4L4NPnOMzRHwjBs
	0Pi7VS1YMyPANsH8IEmKVghyrej2hsdMKFKo3VDvgGXBxz3JxCfTeqgaqTVnvXOaPeZ6Hxkm3ESCT
	YteLx/a6eePA8ebOq4TwuvT8WOWqZx3CVcOYR0Y6JM64+/R3v4An5VPhtBzaPbraqpktFl+TX24KG
	WuOASttYcZQOtX4XTPoHEdvZPQJddkJ9hMsQjA7zitVuVoCjIWkT6oHK9K7cOdfchA7L6EUMIhYCf
	qupxXYLg==;
Received: from p2003010777026a001a3da2fffebfd33a.dip0.t-ipconnect.de ([2003:107:7702:6a00:1a3d:a2ff:febf:d33a] helo=aktux)
	by mail.andi.de1.cc with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <andreas@kemnade.info>)
	id 1rojFI-000ZgA-JP; Mon, 25 Mar 2024 13:16:08 +0100
Date: Mon, 25 Mar 2024 13:16:05 +0100
From: Andreas Kemnade <andreas@kemnade.info>
To: Matti Vaittinen <mazziesaccount@gmail.com>
Cc: lee@kernel.org, robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
 conor+dt@kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, imx@lists.linux.dev
Subject: Re: [RFC PATCH 2/2] mfd: rohm-bd71828: Add power off functionality
Message-ID: <20240325131605.6607b778@aktux>
In-Reply-To: <472c6eaf-6cbc-484c-bc94-571d115176aa@gmail.com>
References: <20240324201210.232301-1-andreas@kemnade.info>
	<20240324201210.232301-3-andreas@kemnade.info>
	<472c6eaf-6cbc-484c-bc94-571d115176aa@gmail.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 25 Mar 2024 13:31:15 +0200
Matti Vaittinen <mazziesaccount@gmail.com> wrote:

> On 3/24/24 22:12, Andreas Kemnade wrote:
> > Since the chip can power off the system, add the corresponding
> > functionality.
> > Based on https://github.com/kobolabs/Kobo-Reader/raw/master/hw/imx6sll-clara2e/kernel.tar.bz2
> > No information source about the magic numbers found.  
> 
> Oh, interesting repository :) Thanks for linking to it! I didn't know 
> someone had reworked this driver...
> 
which btw: contains this interesting snippet (output from fdtdump)
  bd71828-i2c@4b {
                    reg = <0x0000004b>;
                    compatible = "rohm,bd71828";
                    gpio_int = <0x00000008 0x00000013 0x00000001>;
                    gpio_wdogb = <0x00000039 0x00000018 0x00000001>;
                    #address-cells = <0x00000001>;
                    #size-cells = <0x00000000>;
                    pmic@4b {
                        compatible = "rohm,bd71828";
             	        regulators {
                        	BUCK1 {
                            		regulator-name = "buck1";


and to make it work since basically no regulators are registered 
instead just some regmap_write()s are done to configure something
in probe(). It is a pitfall to think that the information below pmic@4b
is used, especially since it is not that obvious in the source.

> I have access to the data-sheets so I also have some pieces of 
> information. I hope I can clarify part of the puzzle. Unfortunately I 
> have no information about the magic delays. I guess I could try asking 
> though.
> 
> Oh, it seems to me this handler is only working on BD71828, not on 
> BD71815. So, it should be tied to the ROHM_CHIP_TYPE_BD71828.
> 
> > Signed-off-by: Andreas Kemnade <andreas@kemnade.info>
> > ---
> >   drivers/mfd/rohm-bd71828.c | 31 ++++++++++++++++++++++++++++++-
> >   1 file changed, 30 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/mfd/rohm-bd71828.c b/drivers/mfd/rohm-bd71828.c
> > index 594718f7e8e1..5a55aa3620d0 100644
> > --- a/drivers/mfd/rohm-bd71828.c
> > +++ b/drivers/mfd/rohm-bd71828.c
> > @@ -464,6 +464,24 @@ static int set_clk_mode(struct device *dev, struct regmap *regmap,
> >   				  OUT32K_MODE_CMOS);
> >   }
> >   
> > +static struct i2c_client *bd71828_dev;  
> 
> I'm not sure why to store pointer to the device and not a pointer to the 
> regmap?
> 
> > +static void bd71828_power_off(void)
> > +{
> > +	i2c_smbus_write_byte_data(bd71828_dev, 0x03, 0xff);  
> 
> 0x03 is a "reset reason" - register. Spec I have states that the 
> register should clear when a reset occurs - but it also says the bits 
> are "write '1' to clear". So, for some reason(?), this clears the 
> previous reset reason.

well, so just check in bootloader what the reset reason is and check if
there is anything odd.

> I am unsure why i2c_smbus_write_byte_data() and 
> not regmap()?
> 
regmap involves mutex_lock() and we are not allowed to sleep here.

> > +	mdelay(500);
> > +	i2c_smbus_write_byte_data(bd71828_dev, BD71828_REG_INT_DCIN2, 0x02);  
> 
> This clears the DCIN monitoring status bit from the IRQ status register. 
> I don't understand the purpose though.
> 
so maybe something to prevent power on by just plugging a usb cable? Will
experiment a bit with it.

> > +	mdelay(500);
> > +	while (true) {
> > +		i2c_smbus_write_byte_data(bd71828_dev, BD71828_REG_PS_CTRL_1, 0x02);  
> 
> This write to PS_CTRL_1 initiates a state transition. 0x2 equals to HBNT 
> state. Eg, in usual cases this should be a start of the power-off sequence.
> 
> > +		mdelay(500);
> > +	}
> > +}  
> 
> If you have the hardware to test this on, then it'd be great to see if 
> clearing the reset reason and IRQ status could be dropped. I can't 
> immediately think of a reason for those.
> 
I will to so. That will also remove the need for all those delays.

> > +static void bd71828_remove_poweroff(void *data)
> > +{
> > +	bd71828_dev = NULL;  
> 
> This does not smell correct to me. Should we remove the 
> bd71828_power_off() from the pm_power_off instead?
> 
oh, yes, that is not correct.

Regards,
Andreas

