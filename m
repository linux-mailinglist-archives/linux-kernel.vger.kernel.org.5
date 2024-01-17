Return-Path: <linux-kernel+bounces-28864-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 117FD8303EB
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 11:49:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 28C2A1C24C30
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 10:49:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E028E1C6A8;
	Wed, 17 Jan 2024 10:49:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b="f64Vv8nc"
Received: from mail11.truemail.it (mail11.truemail.it [217.194.8.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC0B71DDC8;
	Wed, 17 Jan 2024 10:49:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.194.8.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705488569; cv=none; b=nssm62qLCY99jjTp5cUu3DYctcZgYMU/c+1sgdkLRKXXN8Pk26ysNivybY5rNK+AWRyHfZPhUlIKDcMrzn6jek6fAiMZf8e7eSQ6uC4olPC9TAJOnmCM/rqq+NObFd98SgOZkqRWS1tL66OHQ4fXFiwENBmBjmfUUege70dGusk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705488569; c=relaxed/simple;
	bh=jX2cdqcLpBQzcWIBENftQiKzPzrKqoxmLPIwI1/XU30=;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To; b=OLQkTvtVPP1IeobunMyNVclo9ux5jNiDdU8hqAAT/1xisRXEtSdjYL0E4J2ky5//VF8sEbpji+XIoyQHSrFdk6sePtyAvsxJdJVBqHTTOdFp8iyigFfKWTtbGyuiR7IUDstZapIbma0G83Z8aMqGIY1tbEVfrS9CQa9Ea41joY8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it; spf=pass smtp.mailfrom=dolcini.it; dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b=f64Vv8nc; arc=none smtp.client-ip=217.194.8.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dolcini.it
Received: from francesco-nb (93-49-2-63.ip317.fastwebnet.it [93.49.2.63])
	by mail11.truemail.it (Postfix) with ESMTPA id CB0272033B;
	Wed, 17 Jan 2024 11:49:22 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dolcini.it;
	s=default; t=1705488563;
	bh=EWc2weFPaZUQNvKleAvgHjxorQ76XVMc1DcqvHyufgM=; h=From:To:Subject;
	b=f64Vv8ncs7xzPhh7d6/fwsQQQRldCLB/QpqfJrIM2xfbvbKCOy5iAJTDAQ+un8Lcg
	 idWaBZA/RwqyXZHNItygGim0tsDsPCsjbc7oc9COnvOA+1sNSM5MjIWS1qvdFbeT/h
	 CAUEqV0Rzgb2TZ8lr3oOEShIf5pEBPDXBv7ThU/ucXJOWAkTFIr3H7CFfT+xYkfddH
	 1dxJkpdSu0A8XBBbq8wlW0UZ8Kyeh+sJ1B9xvrjt1FyxIG5WasvS2Ys8aSIQgEMyPr
	 43472cjVGV04eiRM7uhFcbfHh6AnYWRdHKFGVykA/VJnUsMHf8dFKLAyBzDbNg++lr
	 5i92cm7biiTyA==
Date: Wed, 17 Jan 2024 11:49:17 +0100
From: Francesco Dolcini <francesco@dolcini.it>
To: Neeraj Sanjay Kale <neeraj.sanjaykale@nxp.com>
Cc: Francesco Dolcini <francesco@dolcini.it>,
	"marcel@holtmann.org" <marcel@holtmann.org>,
	"johan.hedberg@gmail.com" <johan.hedberg@gmail.com>,
	"luiz.dentz@gmail.com" <luiz.dentz@gmail.com>,
	Marcel Ziswiler <marcel.ziswiler@toradex.com>,
	Amitkumar Karwar <amitkumar.karwar@nxp.com>,
	"linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Sherry Sun <sherry.sun@nxp.com>, Rohit Fule <rohit.fule@nxp.com>
Subject: Re: [RFC PATCH] Bluetooth: btnxpuart: Fix nxp_setup in case chip is
 powered on late
Message-ID: <20240117104917.GA6138@francesco-nb>
References: <20240117030501.149114-1-neeraj.sanjaykale@nxp.com>
 <20240117090932.GA3787@francesco-nb>
 <AS4PR04MB9692991FC87A8FF21E455BC8E7722@AS4PR04MB9692.eurprd04.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <AS4PR04MB9692991FC87A8FF21E455BC8E7722@AS4PR04MB9692.eurprd04.prod.outlook.com>

On Wed, Jan 17, 2024 at 09:38:43AM +0000, Neeraj Sanjay Kale wrote:
> > > diff --git a/drivers/bluetooth/btnxpuart.c
> > > b/drivers/bluetooth/btnxpuart.c index 7f88b6f52f26..20a3a5bd5529
> > > 100644
> > > --- a/drivers/bluetooth/btnxpuart.c
> > > +++ b/drivers/bluetooth/btnxpuart.c
> > > @@ -1036,6 +1048,13 @@ static int nxp_setup(struct hci_dev *hdev)
> > >               err = nxp_download_firmware(hdev);
> > >               if (err < 0)
> > >                       return err;
> > > +     } else if (!serdev_device_get_cts(nxpdev->serdev)) {
> > > +             /* CTS is high and no bootloader signatures detected */
> > > +             bt_dev_dbg(hdev, "Controller not detected. Will check again in %d
> > msec",
> > > +                        NXP_SETUP_RETRY_TIME_MS);
> > > +             schedule_delayed_work(&nxpdev->setup_retry_work,
> > > +                                   msecs_to_jiffies(NXP_SETUP_RETRY_TIME_MS));
> > > +             return -ENODEV;
> > why not just
> > 
> > return -EPROBE_DEFER;
> > 
> > and remove everything else, no need for any kind of retry or delayed work if
> > the driver core takes care of it.
> > 
> Wouldn't returning -EPROBE_DEFER make more sense in driver probe context?

Yes, you are right. I was rushing to this suggestion without thinking at this
properly.

> Here, the driver probe registers an hci interface
> (hci_register_dev()), and returns success to kernel.
> 
> The hci_register_dev() queues hdev->power_on work at the end, which
> opens the hci dev, and ultimately calls this setup function.
> 
> In this patch, we are queueing the same work from the delayed
> setup_retry_work().
> 
> Returning -ENODEV (or -EPROBE_DEFER) would only affect hci_dev_open(),
> which is in power_on work context, and not driver probe context.
> 
> Perhaps, we should call it hci_retry_power_on() work or something
> similar?
> 
> Please let me know your thoughts on this.

Do you see any way to get rid of this complexity? Maybe having this
check done during probe, deferring there till we know the device is in a
suitable state (e.g. either you received the bootloader signature, you
know the device is powered or that the firmware is loaded and ready?).

In other words returning EPROBE_DEFER before calling hci_register_dev()?


With that said I still see an issue if the firmware is loaded by the
wifi driver and the BT driver start sending commands before the firware
load procedure is concluded and the firmware is ready. Not sure if you
have a way to wait for this "firmware ready" state.

Francesco


