Return-Path: <linux-kernel+bounces-23868-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CBEE082B2F6
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 17:29:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6B625B213BA
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 16:29:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 560E84F8B8;
	Thu, 11 Jan 2024 16:29:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="GbhQ7G7F";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="zuJNRwDW"
Received: from wout2-smtp.messagingengine.com (wout2-smtp.messagingengine.com [64.147.123.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14DD04F894;
	Thu, 11 Jan 2024 16:29:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailout.west.internal (Postfix) with ESMTP id 111253200ADC;
	Thu, 11 Jan 2024 11:29:24 -0500 (EST)
Received: from imap51 ([10.202.2.101])
  by compute5.internal (MEProxy); Thu, 11 Jan 2024 11:29:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1704990564; x=1705076964; bh=qG1X+E/oQ9
	F4Xh+PUMzTxFKU8hMR5oTJrNZlqH299pg=; b=GbhQ7G7FBsHEU118OQADqjY2xP
	8uwxPxBt2dNclimYzy2vt6XWJh6LkWF7INSXQW9pVHJAdbnS6QNooYWKbPT4U8OH
	N2d40hJW3ZWB3MJHaMv8yt5EyInTk9yAjDh9Wj4v/29s68DQbkVonIAHz/dYQq1O
	wlDX3Z/p9oSPS+Q4mpwt4t2pHh7KP7Vb5Rle6ffd3njscGxlXWJDMuRlH3DK5Sq4
	+m+1E0kwfgfa9tnIIkeeC0AEKVp51XH56hGHGVJRpxoyIp9mRJLXpmIwAMmw5w0U
	1f1oR5bjK6dXlHMuo20XP59caYv/uB92YJd33mmgnzCA6h0McTOLgg/dqJ3Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1704990564; x=1705076964; bh=qG1X+E/oQ9F4Xh+PUMzTxFKU8hMR
	5oTJrNZlqH299pg=; b=zuJNRwDW7+jCfVcUTZPkC9s7m2alPQEEMadMTObBusNf
	RNcDGFGa3+kXtyOdyrYqE29sBozVA/OQNxLNVY2WTStTfPU1l+kXJM5bzf9FNepV
	AtatVAvpl1VBFUP5sn7IuKYOO7cCbhBJCq/gPygbdqV9lwAUzcso8Sk8BoCn2rqN
	oO3iJQoigrpyoi0MvXVC0mkFxClkk7XSHKdoJNKPLoM4aZw0FONpMwmmWkDjqC2n
	GxQ1wXIdMWr1DMy1tMtDbVUpD6zUHTRdOHEKDV0VO+AhT77IZfe8e6TqcOm29qKj
	FRtitpsEMewW28RvNZblrnXrBUBM9m0Z9f6WWaVmbg==
X-ME-Sender: <xms:YhegZT4Q2tuB8tMTIHml5RGrIoBG1J8Q9ZFyYxJJ6GSJisrGFs7cSQ>
    <xme:YhegZY66jos8rjrrhiRl_pKloh0AVAoYr_q-jh7wrAXiQs0gJcLuDKcxkd7JnPrqd
    r7ormCnaqKPx0yqMYA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrvdeifedgkeekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedftehr
    nhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrth
    htvghrnhepffehueegteeihfegtefhjefgtdeugfegjeelheejueethfefgeeghfektdek
    teffnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprg
    hrnhgusegrrhhnuggsrdguvg
X-ME-Proxy: <xmx:YhegZadaqb3B38rQmQWRwV4RhsMOX1yntA7V5nn6nI_HJZ-UpSJZCA>
    <xmx:YhegZUIPZZFr88oSP8JZOChHK_edg9d25Lk1GX1omDWTzBKTEYzn3Q>
    <xmx:YhegZXKP2Dw1avO-2ElGlNf-tFC9FNGb6SNBbr207g0N8ZR0mT7OnA>
    <xmx:ZBegZUDiKXQqVPHcWebZ1L-2dKETcjPtd9lSnlwHDSz7Qng9meyPbg>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id 70131B6008F; Thu, 11 Jan 2024 11:29:22 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-1374-gc37f3abe3d-fm-20240102.001-gc37f3abe
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <5a08d4a0-a6d6-4c9a-8bdf-1ccb4f200d26@app.fastmail.com>
In-Reply-To: <ZaAOF/esan+HnufM@shell.armlinux.org.uk>
References: <20240109075656.2656359-1-arnd@kernel.org>
 <ZZ0TdiIDE2lqHE+8@shell.armlinux.org.uk>
 <ZaAOF/esan+HnufM@shell.armlinux.org.uk>
Date: Thu, 11 Jan 2024 17:29:02 +0100
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Russell King" <linux@armlinux.org.uk>, "Arnd Bergmann" <arnd@kernel.org>
Cc: "Jiawen Wu" <jiawenwu@trustnetic.com>,
 "Mengyuan Lou" <mengyuanlou@net-swift.com>,
 "Jakub Kicinski" <kuba@kernel.org>, "David S . Miller" <davem@davemloft.net>,
 "Eric Dumazet" <edumazet@google.com>, "Paolo Abeni" <pabeni@redhat.com>,
 "Andrew Lunn" <andrew@lunn.ch>,
 "Maciej Fijalkowski" <maciej.fijalkowski@intel.com>,
 "Andy Shevchenko" <andriy.shevchenko@linux.intel.com>,
 Netdev <netdev@vger.kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] wangxunx: select CONFIG_PHYLINK where needed
Content-Type: text/plain

On Thu, Jan 11, 2024, at 16:49, Russell King (Oracle) wrote:
> On Tue, Jan 09, 2024 at 09:35:50AM +0000, Russell King (Oracle) wrote:
>> On Tue, Jan 09, 2024 at 08:56:21AM +0100, Arnd Bergmann wrote:
>> > diff --git a/drivers/net/ethernet/wangxun/Kconfig b/drivers/net/ethernet/wangxun/Kconfig
>> > index 23cd610bd376..46630f05d8dd 100644
>> > --- a/drivers/net/ethernet/wangxun/Kconfig
>> > +++ b/drivers/net/ethernet/wangxun/Kconfig
>> > @@ -26,6 +26,7 @@ config NGBE
>> >  	tristate "Wangxun(R) GbE PCI Express adapters support"
>> >  	depends on PCI
>> >  	select LIBWX
>> > +	select PHYLINK
>> >  	select PHYLIB
>> 
>> You can drop PHYLIB when adding PHYLINK.
>
> Arnd,
>
> There are repeated complaints from the kernel build bot about this, and
> it would be good to get it solved. Could we have an updated patch
> submitted to netdev please? This is in net-next only at the moment,
> so I think that means it needs to be submitted with:
>
> 	[PATCH net-next ...]
>
> and please make it clear that it is a fix for code only in net-next.
> (However, netdev folk may request it to be referred until net-next is
> merged and then against the net tree...)

Sent now, thanks for the reminder.

     Arnd

