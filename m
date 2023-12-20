Return-Path: <linux-kernel+bounces-6433-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B8FEE8198C6
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 07:45:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 41C16B25800
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 06:45:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B00E1401D;
	Wed, 20 Dec 2023 06:44:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ravnborg.org header.i=@ravnborg.org header.b="WTEfw2kB";
	dkim=permerror (0-bit key) header.d=ravnborg.org header.i=@ravnborg.org header.b="I7V1QNB2"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mailrelay4-1.pub.mailoutpod2-cph3.one.com (mailrelay4-1.pub.mailoutpod2-cph3.one.com [46.30.211.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B73601D532
	for <linux-kernel@vger.kernel.org>; Wed, 20 Dec 2023 06:44:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ravnborg.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ravnborg.org
X-HalOne-ID: 1e28ad07-9f03-11ee-ace3-2dc64a403fa2
Received: from mailrelay1.pub.mailoutpod3-cph3.one.com (unknown [104.37.34.38])
	by mailrelay4 (Halon) with ESMTPS
	id 1e28ad07-9f03-11ee-ace3-2dc64a403fa2;
	Wed, 20 Dec 2023 06:43:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=ravnborg.org; s=rsa2;
	h=in-reply-to:content-type:mime-version:references:message-id:subject:cc:to:
	 from:date:from;
	bh=czDnAIGqZkpfvoL/iiaTcwjziBrJyFAvdctS7icVWtc=;
	b=WTEfw2kBTisB9iFEa9k6bTNf3ZeFtX6YS/mDbeFYMeHjQUFMj+djmcVbc1cef/pSFwCRLCub/jnhv
	 2fHatP15emjbQbFiDThaWGqVzKmKZTqQ1B30zZ7bUqpGRIOScf1BV7XfkO0q+w/lvty/Pn0cL0On8W
	 oqU+A1ANEhmyyXukEtwPJG+6D/eltnGFElclkTn/gw7ypdxput8jsuCt5HYFjedLwRgmL7k62wX2W5
	 IiKKWdWv7A7Xvv0i7iN81LrU2MqpDrNWGFNT+dneqOhojAAtmAXX9/HCCeJ7aTlgviXPoBFtM6EX86
	 AexoXyioyxNrhwepKSz3ee+qdLEEb0Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed;
	d=ravnborg.org; s=ed2;
	h=in-reply-to:content-type:mime-version:references:message-id:subject:cc:to:
	 from:date:from;
	bh=czDnAIGqZkpfvoL/iiaTcwjziBrJyFAvdctS7icVWtc=;
	b=I7V1QNB20dvpYRV1erNIT0+pk9yXU6uliif9Cl438drmSB++wNLblgBunf6TvAnxaAm4ycM59iEKF
	 M4AyopcBg==
X-HalOne-ID: 1ce66959-9f03-11ee-964d-27feea414716
Received: from ravnborg.org (2-105-2-98-cable.dk.customer.tdc.net [2.105.2.98])
	by mailrelay1 (Halon) with ESMTPSA
	id 1ce66959-9f03-11ee-964d-27feea414716;
	Wed, 20 Dec 2023 06:43:43 +0000 (UTC)
Date: Wed, 20 Dec 2023 07:43:41 +0100
From: Sam Ravnborg <sam@ravnborg.org>
To: Arnd Bergmann <arnd@kernel.org>
Cc: "David S . Miller" <davem@davemloft.net>,
	Andreas Larsson <andreas@gaisler.com>, Helge Deller <deller@gmx.de>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Alan Stern <stern@rowland.harvard.edu>,
	Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
	sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-usb@vger.kernel.org, linux-fbdev@vger.kernel.org,
	dri-devel@lists.freedesktop.org, linux-sound@vger.kernel.org
Subject: Re: [PATCH 01/27] sparc32: Update defconfig to LEON SMP
Message-ID: <20231220064341.GA847783@ravnborg.org>
References: <20231219-sam-sparc32-sunset-v3-v1-0-64bb44b598c5@ravnborg.org>
 <20231219-sam-sparc32-sunset-v3-v1-1-64bb44b598c5@ravnborg.org>
 <2fc75a39-a6f4-42f4-ab09-d7622cb23b10@app.fastmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2fc75a39-a6f4-42f4-ab09-d7622cb23b10@app.fastmail.com>

Hi Arnd,

On Tue, Dec 19, 2023 at 10:23:05PM +0000, Arnd Bergmann wrote:
> On Tue, Dec 19, 2023, at 22:03, Sam Ravnborg via B4 Relay wrote:
> > From: Sam Ravnborg <sam@ravnborg.org>
> >
> > This is a copy of the leon_smp defconfig found in
> > gaisler-buildroot-2023.02-1.0.
> >
> > Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
> > Cc: "David S. Miller" <davem@davemloft.net>
> > Cc: Arnd Bergmann <arnd@kernel.org>
> > Cc: Andreas Larsson <andreas@gaisler.com>
> 
> I did not get a cover letter for the series, but I looked at
You are listed as a receiver?!?

It can be found here:
https://lore.kernel.org/sparclinux/20231219-sam-sparc32-sunset-v3-v1-0-64bb44b598c5@ravnborg.org/T/#m2fc5b3c23331efd12492a61ba39ac000a563ac52

> all 27 patches and they all look good to me, nice cleanup!
> 
> Acked-by: Arnd Bergmann <arnd@arndb.de>
Thanks!

	Sam

