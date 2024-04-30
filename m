Return-Path: <linux-kernel+bounces-164339-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 972C78B7C83
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 18:12:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9A3751C22479
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 16:12:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFB7D175570;
	Tue, 30 Apr 2024 16:11:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b="Cza2eG/l";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="PRi6C307"
Received: from wfhigh8-smtp.messagingengine.com (wfhigh8-smtp.messagingengine.com [64.147.123.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6C01171E67;
	Tue, 30 Apr 2024 16:11:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714493514; cv=none; b=BO8Rr9thzntZtb+A6n79nGbp7OIdIICEkDFlJmshQ6JsQ3jR2ojj8XM+XGBKYjZQXYoDPv1rI0/2ocaSY09oAl5Y8oeOWfTBIJYqB69MoYhWSrSViAcvHpxP1SB9b6WshQKdi1P80nbT7J8KOsZ3bIWXsVGG8/lH8liAM/yppoA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714493514; c=relaxed/simple;
	bh=Ib+Yn6+KaZYvKEYc/HkJumSiDbXpygipaOcTFCInIbI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UHSe/Qh3MYYmYVpla1p1qD/eWKi5YrTa+59DAvI8qzCcXLmyAmkIM/QOw1lrVvWxJCzaVRVaNHcy4VpoP3tO0pzVf2fgVCBXYr9XUZrVg3IhCspt5ojJo48Bi5zO4ZRvhbtnQFMAlWLBpz7XkujNyqOVjUd8aODoUvFPVs74/ak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com; spf=pass smtp.mailfrom=kroah.com; dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b=Cza2eG/l; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=PRi6C307; arc=none smtp.client-ip=64.147.123.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kroah.com
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
	by mailfhigh.west.internal (Postfix) with ESMTP id EDC4118000B3;
	Tue, 30 Apr 2024 12:11:49 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Tue, 30 Apr 2024 12:11:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1714493509; x=1714579909; bh=zaWpMxopp6
	uJz5USPa3POwWXyr6pQ3Po4Q9MGv/3aFs=; b=Cza2eG/lZoBiJRFqxBv7chRsBU
	TmfMLNd+QKTxucADi4jqRy6gSvPCV6NWDH8i/VK1gFyRVeiUaPDP7qH00Qvyd6O/
	5Kz0xaBVKsb0ZmMijy1VoBe7vN85APui6nSl+A/q278bmxbTY6UVPCI+R3Sb+Kv2
	iDTrk8MAm4oA73mK+uPcPElEWGI6gmfmDknKbvkuf+qqrXEan0ZL527MwvM59bJz
	gE6t9ESchFc586VlB06awvpU3KtIoRPU/xliaT2JfdJnjrZouiytknYxVU6w2Wpz
	Z7QVX3FQkCq01yyBtG6660j4kFDOi6LBZ/L9BSEDnAx0bF0aHWWNlf77jBGQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1714493509; x=1714579909; bh=zaWpMxopp6uJz5USPa3POwWXyr6p
	Q3Po4Q9MGv/3aFs=; b=PRi6C307bV6wWJIxVR96XeiCHIlGS4KNS2XtlfxQolCq
	wWcDPWD2Zt7oYg7P+fOELyw7WyPY0gLOd2gA3AX/sstGjBPwNqDiETbCOi7aUSFj
	3eCh9EK1Yxpf3c9L+ES78DSrAkSbChteDPtPUBj+EJrBN0NQr8Lb6xk4Qo84IHpE
	+b8gd2mUFCjTtnwRVeW/wRiRf2aSODgUJQgLTIyxgLCRfQC1CKnK5JcrV0x8v0Gl
	RDJWZd6Q59/2lLRJvDWEyq6b6KTxClovfoMumBUzBWsFgxuMQAl15WuhhZdIZ89j
	H41t5S05EgeDyLd9q8a+QJ7PMcEagk04XwMEjJYVkQ==
X-ME-Sender: <xms:RBgxZu0nnSfc74C4U5aPx2EzbUpZY2tt9y1yEAZJBNIghEA9Cfhb5A>
    <xme:RBgxZhEKO6xUIkqUxM1eC64qEOTzI8fBSvsrKgpmMX2_kUnjh-HIZLmCoomg5GWaB
    oq2C_h5NhGnxg>
X-ME-Received: <xmr:RBgxZm7nOl2AvJD4LzWmYMXZW2-WhHXQ_doVdNgL8McTk8KtpGAY01ApiObH5T3xmquZbeqiY1Qot5jpV8S8wLszTEOhyA2AQVZc6g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvddufedgleeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepifhrvghg
    ucfmjfcuoehgrhgvgheskhhrohgrhhdrtghomheqnecuggftrfgrthhtvghrnhepheegvd
    evvdeljeeugfdtudduhfekledtiefhveejkeejuefhtdeufefhgfehkeetnecuvehluhhs
    thgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepghhrvghgsehkrhhorg
    hhrdgtohhm
X-ME-Proxy: <xmx:RBgxZv3JTKCLU3MBa864hMub0tAqJoI6CDV1C6fkUBUboLl1nJoXsw>
    <xmx:RBgxZhETqxWiCeWYv6mZX5mjIXIXeqdzH30q3DVRMMANLY_peSNTqg>
    <xmx:RBgxZo8Ai78JcGBfPD87wYuFPWz_f1NbOYStDEbd3EgKozttkzkZOg>
    <xmx:RBgxZmlIIWmmyM44qPQ-RRtsw2Zaht3l-01v7tUQ4qXhFn9jY7IHUg>
    <xmx:RRgxZp-LsGqG7wbFaBPFFZ7BRtvr_lh3ryhNetFnBvILGAT_6oGMPcap>
Feedback-ID: i787e41f1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 30 Apr 2024 12:11:48 -0400 (EDT)
Date: Tue, 30 Apr 2024 18:11:44 +0200
From: Greg KH <greg@kroah.com>
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: Fabio Estevam <festevam@denx.de>,
	Javier Carrasco <javier.carrasco@wolfvision.net>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: manual merge of the usb tree with the usb.current
 tree
Message-ID: <2024043031-resume-subtext-a3d3@gregkh>
References: <20240412142547.3598ff68@canb.auug.org.au>
 <2024041230-slaw-subsiding-9e85@gregkh>
 <20240424161202.7e45e19e@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240424161202.7e45e19e@canb.auug.org.au>

On Wed, Apr 24, 2024 at 04:12:02PM +1000, Stephen Rothwell wrote:
> Hi Greg,
> 
> On Fri, 12 Apr 2024 09:58:52 +0200 Greg KH <greg@kroah.com> wrote:
> >
> > On Fri, Apr 12, 2024 at 02:25:47PM +1000, Stephen Rothwell wrote:
> > > 
> > > Today's linux-next merge of the usb tree got a conflict in:
> > > 
> > >   drivers/usb/misc/onboard_usb_hub.c
> > > 
> > > between commit:
> > > 
> > >   34b990e9bb54 ("usb: misc: onboard_usb_hub: Disable the USB hub clock on failure")
> > > 
> > > from the usb.current tree and commit:
> > > 
> > >   31e7f6c015d9 ("usb: misc: onboard_hub: rename to onboard_dev")
> > > 
> > > from the usb tree.
> > > 
> > > I fixed it up (I deleted this file and applied the following patch) and
> > > can carry the fix as necessary. This is now fixed as far as linux-next
> > > is concerned, but any non trivial conflicts should be mentioned to your
> > > upstream maintainer when your tree is submitted for merging.  You may
> > > also want to consider cooperating with the maintainer of the conflicting
> > > tree to minimise any particularly complex conflicts.  
> > 
> > Thanks, I knew this would happen, I'll apply your fixup when merging the
> > two branches together.
> 
> It looks like the fix up patch did not get applied (repeated below).
> 
> -- 
> Cheers,
> Stephen Rothwell
> 
> From: Stephen Rothwell <sfr@canb.auug.org.au>
> Date: Fri, 12 Apr 2024 14:20:48 +1000
> Subject: [PATCH] fix up for "usb: misc: onboard_hub: rename to onboard_dev"
> 
> interacting with "usb: misc: onboard_usb_hub: Disable the USB hub clock
> on failure"
> 
> Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
> ---
>  drivers/usb/misc/onboard_usb_dev.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/usb/misc/onboard_usb_dev.c b/drivers/usb/misc/onboard_usb_dev.c
> index 648ea933bdad..f2bcc1a8b95f 100644
> --- a/drivers/usb/misc/onboard_usb_dev.c
> +++ b/drivers/usb/misc/onboard_usb_dev.c
> @@ -93,7 +93,7 @@ static int onboard_dev_power_on(struct onboard_dev *onboard_dev)
>  	if (err) {
>  		dev_err(onboard_dev->dev, "failed to enable supplies: %pe\n",
>  			ERR_PTR(err));
> -		return err;
> +		goto disable_clk;
>  	}
>  
>  	fsleep(onboard_dev->pdata->reset_us);
> @@ -102,6 +102,10 @@ static int onboard_dev_power_on(struct onboard_dev *onboard_dev)
>  	onboard_dev->is_powered_on = true;
>  
>  	return 0;
> +
> +disable_clk:
> +	clk_disable_unprepare(onboard_dev->clk);
> +	return err;
>  }
>  
>  static int onboard_dev_power_off(struct onboard_dev *onboard_dev)
> -- 
> 2.43.0
> 

Oops, good catch, I've applied this fix now, thanks!

greg k-h



