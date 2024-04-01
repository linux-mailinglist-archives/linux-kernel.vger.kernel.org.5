Return-Path: <linux-kernel+bounces-127211-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F17189480D
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 01:55:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 04438282AFB
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 23:55:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 439CE5730A;
	Mon,  1 Apr 2024 23:55:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp header.b="CC9x9WuW";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="EY7SLQ/U"
Received: from wfout2-smtp.messagingengine.com (wfout2-smtp.messagingengine.com [64.147.123.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78A632A1BF
	for <linux-kernel@vger.kernel.org>; Mon,  1 Apr 2024 23:55:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712015722; cv=none; b=chfaKU4ioVXuq+ZkeeJOAixOFkUKf1/+u77xzkUddleTjj1od8zWLXj6XE6aYX8RhwFPI7jq0DFo3Y/E3J2yNvsYdIJb2YDsea+pq+lNEKj2VDPrpmmeHlLyzFpJiIWxjYgq351L9cWsoMtBNmI0OEE2bTY+LS0tPD/R3/CC+zA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712015722; c=relaxed/simple;
	bh=GBn7iRT2l6zemV9FXXjCxeGfWOplTVbEMCNad3ouFWM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WMsnZcaPE0GnLEdMW1JuL9zGkLGZXgGPNDBA7gc4R5fi/C6M4lc8VMS8EcfFU2+yAJjnbQtp3coNfesnYxSEA0JAWwPwfWQnq3vCFfIWu1PsCnWtar2PyOWd+HXwqa0Dji87Rq52rnjFM31VfF3GmDX3kqR5HuP/NysUCGJNB5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sakamocchi.jp; spf=pass smtp.mailfrom=sakamocchi.jp; dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp header.b=CC9x9WuW; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=EY7SLQ/U; arc=none smtp.client-ip=64.147.123.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sakamocchi.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sakamocchi.jp
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailfout.west.internal (Postfix) with ESMTP id 765F21C0008B;
	Mon,  1 Apr 2024 19:55:19 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Mon, 01 Apr 2024 19:55:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sakamocchi.jp;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1712015718; x=
	1712102118; bh=zPMXLNT+Y0CToVj0ettUX2YI972veEPf5jnDTl4OFu8=; b=C
	C9x9WuWJ6IL5z0AU74H2T9/bwu2P6F3a1sRu0Fg4G2BE1b8C632+CZ7LwG9BfG5Z
	0DWXwKrEjAOKVgmfASD3CARGDvlxJcxUtd9NOPYilWwDOmNO2nnxzhaypo/fUCHO
	5Eu6YRorpUHlvaJsMw6cUxft0HNOoC9mGSRmMWq6TQTGXJ9iua8iecf2jr5meW/7
	xezlsaSnHBBYEB97xlyjFpRuDdaO/uB/iX5a5umRUJ75AAb7Atc7XEztTRiA67fS
	Y7Rjkx2clpfuPOJh4y6PisxZ6wWdnIE8l8DJi2tDomIJ0s6qq5KXtkq91PGwAgvr
	g2c0wU27cXkTKBiKhM38w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1712015718; x=1712102118; bh=zPMXLNT+Y0CToVj0ettUX2YI972v
	eEPf5jnDTl4OFu8=; b=EY7SLQ/UoGWL/ITpBoUYrP62IiKGYMkYK92a+rYJS1yG
	LUgaFIloqoH+TpA6zG4Xll6yvsKzs7pxO3NsTUkHxcbWebr9k3nX2Wtaqy2il35q
	wsrMWdpQbTs4i356SwMteOQik1TxvwD+aLxx3iCCxxYoX8WNcnfSE0RirLugATjl
	u+ChbQLkgbN9VbVuPMze1uLlv6h4Fjv3P6L4uiROCiUMRj4WfEOjp6kPCs1G276T
	jJVIXap647Kmd5/T8kMMnsh8JcRI4mcWw9t+Gq8lcpCFRMufN1rNAgT9tLl8XWPQ
	I/dIFVPtxtf/x65jNeET3NiZlxaQ895Xeqtk5HO1FA==
X-ME-Sender: <xms:ZkkLZvEXFC5OBa9ypXtlY2lmOgl0J4__j-ch_sRWkKlRoFV3d4XkHA>
    <xme:ZkkLZsXTMgREAKkB4eTug_MvVPm9_DPZNwZQAnsKu_ovDKw2rlryj-PnqZfI7Mu_R
    pNKrzC4VhZNdLhmlTs>
X-ME-Received: <xmr:ZkkLZhKB43qFOJv41MtXapiZ5yQa1CEEfSvm41FL75nYOej4OkhQibspo2UxNqesme9CNDuOfqG8mbiohb_tUDo-4Y0sCQo9iA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrudefuddgvdejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvvefukfhfgggtuggjsehttd
    ertddttddvnecuhfhrohhmpefvrghkrghshhhiucfurghkrghmohhtohcuoehoqdhtrghk
    rghshhhisehsrghkrghmohgttghhihdrjhhpqeenucggtffrrghtthgvrhhnpeehhffhte
    etgfekvdeiueffveevueeftdelhfejieeitedvleeftdfgfeeuudekueenucevlhhushht
    vghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehoqdhtrghkrghshhhise
    hsrghkrghmohgttghhihdrjhhp
X-ME-Proxy: <xmx:ZkkLZtGMT5bvWEjZ4cogtPi_2IFBkvAV2i8lEHsk_2ZMIvEDnEuUJg>
    <xmx:ZkkLZlV_UsOtuXIKBKC7YqEOlsBwEav3_yO68wKY2oFZgjs4hB3IRA>
    <xmx:ZkkLZoMxyeFhOcdORkUbhZNc-9hoct4k--66l0eNNK1MeZvvR_66ow>
    <xmx:ZkkLZk1Yh5Yzqt-pghNwSTek13OfUFLKb6nPrDM12hNk5rnG685fvQ>
    <xmx:ZkkLZoQkR3ufAhamDV4Z9wyw3NA6u-cU9FCBt3xmnF3BaTlnfI9U0DLNaRo>
Feedback-ID: ie8e14432:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 1 Apr 2024 19:55:17 -0400 (EDT)
Date: Tue, 2 Apr 2024 08:55:14 +0900
From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
To: linux1394-devel@lists.sourceforge.net
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/4] firewire: ohci: obsolete usage of legacy API for IRQ
 request and MSI
Message-ID: <20240401235514.GA231753@workstation.local>
Mail-Followup-To: linux1394-devel@lists.sourceforge.net,
	linux-kernel@vger.kernel.org
References: <20240331135037.191479-1-o-takashi@sakamocchi.jp>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240331135037.191479-1-o-takashi@sakamocchi.jp>

On Sun, Mar 31, 2024 at 10:50:33PM +0900, Takashi Sakamoto wrote:
> Hi,
> 
> The pair of pci_enable_msi() and pci_disable_msi() is deprecated
> nowadays, while it is still used in 1394 OHCI driver in FireWire
> subsystem. This series of changes is to use modern API sets for the
> driver.
> 
> 
> Takashi Sakamoto (4):
>   Revert "firewire: ohci: use devres for requested IRQ"
>   firewire: ohci: replace request_irq() with request_threaded_irq()
>   firewire: ohci: obsolete usage of deprecated API for MSI
>   firewire: ohci: use pci_irq_vector() to retrieve allocated interrupt
>     line
> 
>  drivers/firewire/ohci.c | 35 +++++++++++++++++++++++++----------
>  1 file changed, 25 insertions(+), 10 deletions(-)

Applied to for-next branch for v6.10.


Thanks

Takashi Sakamoto

