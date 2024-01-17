Return-Path: <linux-kernel+bounces-28902-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 32264830468
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 12:19:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B3C8DB241C2
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 11:19:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 594F01DDDA;
	Wed, 17 Jan 2024 11:19:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b="yLzhjQc6"
Received: from mail11.truemail.it (mail11.truemail.it [217.194.8.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B030314009;
	Wed, 17 Jan 2024 11:19:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.194.8.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705490378; cv=none; b=d0sWoRSBWJVe3AkelyKytK26Is7XOoVGUcfH1k8844x7EPUqQmmhUC+HuHCJnRbnMnPYqVgUc4beIw5AcNa60PFxU6HxY5wKbQwsCVTK5tS3K2Ti2e35ttPdOOA4EkqDaHwvFElqOcnPBcg6jVj6DANhXVce6Utfqhg6pF3FAo8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705490378; c=relaxed/simple;
	bh=DFR5q08xfazOTnbgRWb+uSdJGoNugFRnE0ltvreNM8I=;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To; b=lSvSCCABy1hy2TrmAqqk+hXD3ezMEkmXFXqrOzmCcgZOrVZ5DQng0VVS+VhXRzgtDm6XM1hcOXL6oKXnlHRPuYWAPBSXvUssRNZ1Q5J34ZbpfX8DWIFXVVATDd/DdW0cmGg0rHN89LU/6m+p4HrLU3JS9abJb/84PFy6ZR9QEdM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it; spf=pass smtp.mailfrom=dolcini.it; dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b=yLzhjQc6; arc=none smtp.client-ip=217.194.8.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dolcini.it
Received: from francesco-nb (93-49-2-63.ip317.fastwebnet.it [93.49.2.63])
	by mail11.truemail.it (Postfix) with ESMTPA id 493CB2033B;
	Wed, 17 Jan 2024 12:19:32 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dolcini.it;
	s=default; t=1705490372;
	bh=OaVpQxU9tuOaCurGuNd34rO9GrjjPTEuMDV5HDmI4uI=; h=From:To:Subject;
	b=yLzhjQc6AlHnKFBwuXI8+/2I56RJjxUp9P3H4clkgSJrEHOyzbyRlrMZ/WVP2ih+V
	 CNG7IQF3HswUZNZAqAmFUOX6zOBCbsQh0rMJOxkmFen3XDzQBkkgKH0ZoKeohzyztk
	 4jIcyHUcSg4QTtmtzw1qZrIrJ2Fb7KMPWrus0qdGBYSAW8gbxGynYkVFU4fLqqB9y4
	 XZBtNo8hc5i34koCK6ZRF7G5lTbb8LtnhqN3DwqTkwmbR/7a1SktrdRKiW1bAGe/LW
	 vWSCXDX8NivPnubWa3oNX1aWXsB1eR5IxeYpfdszmn5grclUdmRPp9rHf6xH+wFAyp
	 EKfM0fCuK1qwg==
Date: Wed, 17 Jan 2024 12:19:27 +0100
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
Message-ID: <20240117111927.GA8616@francesco-nb>
References: <20240117030501.149114-1-neeraj.sanjaykale@nxp.com>
 <20240117090932.GA3787@francesco-nb>
 <AS4PR04MB9692991FC87A8FF21E455BC8E7722@AS4PR04MB9692.eurprd04.prod.outlook.com>
 <20240117104917.GA6138@francesco-nb>
 <AS4PR04MB969292D8951C3C93FD23099AE7722@AS4PR04MB9692.eurprd04.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <AS4PR04MB969292D8951C3C93FD23099AE7722@AS4PR04MB9692.eurprd04.prod.outlook.com>

On Wed, Jan 17, 2024 at 11:11:44AM +0000, Neeraj Sanjay Kale wrote:
> > > Here, the driver probe registers an hci interface
> > > (hci_register_dev()), and returns success to kernel.
> > >
> > > The hci_register_dev() queues hdev->power_on work at the end, which
> > > opens the hci dev, and ultimately calls this setup function.
> > >
> > > In this patch, we are queueing the same work from the delayed
> > > setup_retry_work().
> > >
> > > Returning -ENODEV (or -EPROBE_DEFER) would only affect hci_dev_open(),
> > > which is in power_on work context, and not driver probe context.
> > >
> > > Perhaps, we should call it hci_retry_power_on() work or something
> > > similar?
> > >
> > > Please let me know your thoughts on this.
> > 
> > Do you see any way to get rid of this complexity? Maybe having this check
> > done during probe, deferring there till we know the device is in a suitable
> > state (e.g. either you received the bootloader signature, you know the device
> > is powered or that the firmware is loaded and ready?).
> > 
> > In other words returning EPROBE_DEFER before calling hci_register_dev()?
> > 
> Unfortunately no. To read any bootloader signatures, or read CTS line,
> we need serdev device opened, which is done only after
> hci_register_dev() -> power_on work -> hci_dev_open()->serdev_open().

Ok, thanks, it makes sense and it's clear.

> We could simplify this by only returning -ENODEV, without the
> delayed_work handling, but then user would have to remove and
> re-insert the btnxpuart driver after mwifiex driver is loaded
> successfully.
>
> This may not seam like a user-friendly approach.

I think that something like that is pretty much useless, manual
reloading is already possible, and this can also be solved
"artificially" serializing loading the wifi driver and the bt one (the
latter is what we are currently doing to overcome this limitation).

Francesco


