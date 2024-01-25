Return-Path: <linux-kernel+bounces-38857-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9581A83C753
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 16:53:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E40DEB24AE9
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 15:53:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4200874E06;
	Thu, 25 Jan 2024 15:53:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b="YEb60p/1";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ank+XVpr"
Received: from wout3-smtp.messagingengine.com (wout3-smtp.messagingengine.com [64.147.123.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D35F74E03;
	Thu, 25 Jan 2024 15:53:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706198018; cv=none; b=U/mSBZBS/bU99FLPmznWfA1U1j2Cy5UNUsKeTH8wOKinwqTa5fKGfHmA5SE9BJ0Tt0YZS5ri2mG6fTkJoCWNPMe+23St8HKhNdsiu2uNpyeWur26GbaF/Re3IkvqXrEfZj7d4h5+N0jIPUhJOBWPSXsJhbP3Ht8m0ttPUBydows=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706198018; c=relaxed/simple;
	bh=G18Ngnp8+N1SX1I5AuyLukD8rimjBcb0zqWv+2YoJXw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QIoPLlQ15gmT7MdSC+FLjCijXmvlnbA9PI/paHDaVoFI+K3TxuYQzXMvjdzrS7JI26k7VWXCAKr9xfv9s1GxWdgaHNqFf0IRmN/xJmRJcdwfTk4tuOMQIfwLxGkoQNpzNc1oxUiknfWFBvlICuofMHmupN70giR0JAfr830W0fA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com; spf=pass smtp.mailfrom=kroah.com; dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b=YEb60p/1; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ank+XVpr; arc=none smtp.client-ip=64.147.123.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kroah.com
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailout.west.internal (Postfix) with ESMTP id C713E3200AFB;
	Thu, 25 Jan 2024 10:53:34 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Thu, 25 Jan 2024 10:53:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1706198014; x=1706284414; bh=dt+FkIaJT/
	hPdAp0Of7+5zZJ/fkAAqP/0ySEwLtFymE=; b=YEb60p/1b6fJkCu68l1ALy0nSW
	M7hfMZxhsVozNcNFWVQxBDM/OpJwavHxEdIi3pNqZvej7mmoDdKVV18YulnTUyWr
	3kVVKrAa0nuBLkscRK+eDMXKxAJBYWC2K4xQs3HOHNUMIxal4JYylJBdqG7qITN2
	sobVWCWW4SGwOxsHyvQd6KRaP7m5ti7LqhIckYmeAo1337awImrJwaCos/wpKaI2
	bqkBXaaoGgvlm6fWqxvDiMopVGiZm12xm6YL+x0QqJMOR9+PLFD0DPo+2O2osGtc
	rkE6mEztgR8B73OKkKFLQc1Mji68wcsY9uUBrWh3N5S3NJ6yaO32LvD8DpkQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1706198014; x=1706284414; bh=dt+FkIaJT/hPdAp0Of7+5zZJ/fkA
	AqP/0ySEwLtFymE=; b=ank+XVpr4dKMIPQnzsa2yj+0e1iXBX/q/zoVYmjxczA/
	nBtOPTJI+tD1pUjl3g8HumdXzubeH5On6NLvMPdUTu14ErMBhAWWZdg/bIRAp6dO
	g9dSX6TprC2siiAxIIZm90lcD/hdAaWxKddjKWDMaufwPj9ymJULfOUG7lujv6e2
	gNddwwCZs8j6O61bLwXIcNIYcEPoS47HeWvVkbLjj1q7TIwYW8SewbBw6WjJEBP0
	Lf1ZrnoYg24+qYC5HXr/XijSRrZ4vyNl5RhWW0wVLKZ4SSUN1xCobqghKF+lI9tm
	21tArQ/MfPf5JPhz+c+P7XcmTbsvBSNJc1Tc5cIDEQ==
X-ME-Sender: <xms:_YOyZaR7S-czsr-1124zyjTkNnB805Zq78Uu6So5uOnUyaJQ5Dq5fA>
    <xme:_YOyZfwYX8cUohJaLpMuh21Jv4e0WRc3e97M8t1R7JqQwHmV5BGToAJnho16ZT8g2
    0p3v0gbdRn5gg>
X-ME-Received: <xmr:_YOyZX1joNvMgagCHL5SR_1ESgzmqVA_mXT0vskAtofBsJ4QOoTavK3PB4Ft>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrvdelgedgheehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepifhrvghg
    ucfmjfcuoehgrhgvgheskhhrohgrhhdrtghomheqnecuggftrfgrthhtvghrnhepgeehue
    ehgfdtledutdelkeefgeejteegieekheefudeiffdvudeffeelvedttddvnecuffhomhgr
    ihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehgrhgvgheskhhrohgrhhdrtghomh
X-ME-Proxy: <xmx:_YOyZWAWzP6GOCoTUKH8RA1crpKYPl8o4_5XlqI6LN1Z987jo40ayw>
    <xmx:_YOyZTiLw_WL5FPE59SNwP8CYYpIBMkxhqsO1H8yjxm6VgBJs7ZnKg>
    <xmx:_YOyZSoz3bsYdffLS3IblfoZQkF0gBNKWxlJUArTNfKCstIu7tp2mQ>
    <xmx:_oOyZeUR34K-SwCcf92h_RuyOtis8yms1g4eWWzka2rF9RKI7g45Mg>
Feedback-ID: i787e41f1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 25 Jan 2024 10:53:33 -0500 (EST)
Date: Thu, 25 Jan 2024 07:53:32 -0800
From: Greg KH <greg@kroah.com>
To: Krishna Kurapati PSSNV <quic_kriskura@quicinc.com>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: build warning after merge of the usb tree
Message-ID: <2024012518-quickness-breeder-d18d@gregkh>
References: <20240108160221.743649b5@canb.auug.org.au>
 <2024010816-fabric-cassette-1548@gregkh>
 <20240125113527.5c9fca93@canb.auug.org.au>
 <7d1babf5-0999-4528-8202-09b8dd0ab06b@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7d1babf5-0999-4528-8202-09b8dd0ab06b@quicinc.com>

On Thu, Jan 25, 2024 at 11:23:56AM +0530, Krishna Kurapati PSSNV wrote:
> 
> 
> On 1/25/2024 6:05 AM, Stephen Rothwell wrote:
> > Hi all,
> > 
> > On Mon, 8 Jan 2024 08:54:39 +0100 Greg KH <greg@kroah.com> wrote:
> > > 
> > > On Mon, Jan 08, 2024 at 04:02:21PM +1100, Stephen Rothwell wrote:
> > > > 
> > > > After merging the usb tree, today's linux-next build (htmldocs) produced
> > > > this warning:
> > > > 
> > > > Documentation/usb/gadget-testing.rst:459: ERROR: Malformed table.
> > > > Text in column margin in table line 9.
> > > > 
> > > > ===============   ==================================================
> > > > ifname            network device interface name associated with this
> > > >                    function instance
> > > > qmult             queue length multiplier for high and super speed
> > > > host_addr         MAC address of host's end of this
> > > >                    Ethernet over USB link
> > > > dev_addr          MAC address of device's end of this
> > > >                    Ethernet over USB link
> > > > max_segment_size  Segment size required for P2P connections. This
> > > >                    will set MTU to (max_segment_size - 14 bytes)
> > > > ===============   ==================================================
> > > > 
> > > > Introduced by commit
> > > > 
> > > >    1900daeefd3e ("usb: gadget: ncm: Add support to update wMaxSegmentSize via configfs")
> > > 
> > > Krishna, can you send a fixup patch for this?
> > 
> > I am still seeing this warning.
> > 
> HI Stephen,
> 
>  Udipto and Randy sent patches for fixing this:
> 
> https://lore.kernel.org/all/20240108132720.7786-1-quic_ugoswami@quicinc.com/
> 
> https://lore.kernel.org/all/20240110203558.2638-1-rdunlap@infradead.org/
> 
> Greg, can you help pick one of them up.

I will, sorry, at a conference this week, will catch up this weekend...

