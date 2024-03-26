Return-Path: <linux-kernel+bounces-119594-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AAED88CADD
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 18:29:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D45361F658E3
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 17:29:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 432951D539;
	Tue, 26 Mar 2024 17:29:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b="CJj6p932";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="p6d9hWkt"
Received: from wflow2-smtp.messagingengine.com (wflow2-smtp.messagingengine.com [64.147.123.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BC9F1CD3F;
	Tue, 26 Mar 2024 17:29:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711474148; cv=none; b=Th7qMxaLucMxsZN0epuz6H5d5n3c3HeWSI+yj7euoUF5jl40KExy/y+rRwJSytnOPKiA2qoS6blhm0JIaiu9FXJHffdcyKuckGT3ckr7+hay1xspXlyJYLfJIMt7PGUIN3nJsdwKg4KnBjAA4Ig6FUopO/AC2z390iFOH82F3ZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711474148; c=relaxed/simple;
	bh=6bWEskWc1pQMSk1MaJdA6zTwY0qyPPBYbffQKRasgyM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qOicQmXaI3vij5CaJcvrzvqnsGaHluQAjLb7srhXKfbrzEhuAGeoKpRdhttQUB2FFTZV0SKmW9hTwgtYq2ktGE1AOjoffbZ7Oh1oG+oqE4U4w6od8hMwleaujvN1h0oQz/wOaWhijsL1grVyM9875zuQsGrzUxS6o27h1f2I+mA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com; spf=pass smtp.mailfrom=kroah.com; dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b=CJj6p932; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=p6d9hWkt; arc=none smtp.client-ip=64.147.123.137
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kroah.com
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailflow.west.internal (Postfix) with ESMTP id 2F6512CC0169;
	Tue, 26 Mar 2024 13:29:03 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Tue, 26 Mar 2024 13:29:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1711474142; x=1711481342; bh=caIEGTTY2N
	1d1nkbbbAZPRH6rbATMw7DUKeafmkAk3w=; b=CJj6p93294yHNjcxzIdWeYr8g2
	ESYnTenMK51iexTHF29IEaSaGLLw2UFz5Zo9pfLt3M6jQWy4BRlRNe9JtZYRRcF9
	pWZ1aHme9WpTl8cu81YFDJFAkS8bPRf3XgbbDVGTfg/0Et3P24vNCE0NgguCU8r7
	ZBgrfs2vU3xuz4Z6IcEeHPiUuE2Cc5d1SZVGLCWq3zzq3mv9/wy0B1cb5O4w1V/0
	OybF86BANvg8e4bK++4MkOT1Q84lGoAjdBbEhDaVhBxiDDxzYh9ttl+H16QzchPL
	t8H21KxDJgMsjxk/R2AnMH+m+4wpXCrCuJdJnhrHH6iGkDDwYpf4iuUDkiIw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1711474142; x=1711481342; bh=caIEGTTY2N1d1nkbbbAZPRH6rbAT
	Mw7DUKeafmkAk3w=; b=p6d9hWktDnMJGPDf6OTN4IX7D3l4TZ3bPoAp+UnR1x/e
	6ZsCDSi+K1o2e6oytkaV5uzObRqRDgJG+SVAapIl34t3WfxkTzYvmcBI3WJ/udnB
	rsZNnUnrWJTNx243w67aKfjsh6erve4mnnmeIu9rqTHeqdlvY7ISxjhwg1TaXPlV
	cALiIHSBbkFJ/XNaquf5zWYLctcKgdj/JjClRL0zLZUBbHvg0nYYwl/ffCK+Wtx9
	ff4/mtKtq4tZQ/1oSRmciNTPPzpHFJBh0bvtFVpb5C6wTlVoZ7TL4as4xxCUAP4M
	Na1w0N94iSrBFs+TYhvN+Q0aCMvKKbrzzX5bjGW9Og==
X-ME-Sender: <xms:3gUDZnSpOoG9MhjNZDHEe44RcJPgfHDLk8wqz1_ylCqynJGej2yUUg>
    <xme:3gUDZox6HtGMS7eeJmontelyOz4pMqTnv1wxUS09-VC254dHrt0xUOPSIxcKuMW8G
    yRrs9z-8SU4zQ>
X-ME-Received: <xmr:3gUDZs1NhMR9bQ5QpqbG2rS51FKUknQjKy3OC7sFRammxIbHwBbWd1yemxSxuVoOhPNUEPmI_LAhcDr2acu18pXoJAd01VMBhwbbgw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledruddufedguddtudcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefirhgv
    ghcumffjuceoghhrvghgsehkrhhorghhrdgtohhmqeenucggtffrrghtthgvrhhnpeehge
    dvvedvleejuefgtdduudfhkeeltdeihfevjeekjeeuhfdtueefhffgheekteenucevlhhu
    shhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgrhgvgheskhhroh
    grhhdrtghomh
X-ME-Proxy: <xmx:3gUDZnC6Gk5yJHRk9rYwhXpAcl_8LSCss4Q7gSW1T2TL2hEoBfXqSg>
    <xmx:3gUDZgjGZYDPektvzr6yd4c--KjbdAdLu1p6zgSzz5hpXKurVB_ROQ>
    <xmx:3gUDZrodhxtXdIqUP-FMvxBOgIRKLXcsHbiDjErFsWne9Zpkx5Y8AQ>
    <xmx:3gUDZrhVUkODtWQwHtyYPcoflQ7SX3efRk4FeV_qRtjOENYeBvCwYQ>
    <xmx:3gUDZnQab21b7X4yaoww_fwJtT4byaqhfULQURo-mEVD0n-UrW3ItErYC6LJmOmi>
Feedback-ID: i787e41f1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 26 Mar 2024 13:29:01 -0400 (EDT)
Date: Tue, 26 Mar 2024 18:28:57 +0100
From: Greg KH <greg@kroah.com>
To: Mark Brown <broonie@kernel.org>
Cc: Sasha Levin <sashal@kernel.org>, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org, torvalds@linux-foundation.org,
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
	patches@kernelci.org, lkft-triage@lists.linaro.org,
	florian.fainelli@broadcom.com, pavel@denx.de
Subject: Re: [PATCH 6.7 000/707] 6.7.11-rc2 review
Message-ID: <2024032644-speech-reformist-e41e@gregkh>
References: <20240325120003.1767691-1-sashal@kernel.org>
 <cb00ee0c-ed03-4351-9782-99eab1894234@sirena.org.uk>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cb00ee0c-ed03-4351-9782-99eab1894234@sirena.org.uk>

On Tue, Mar 26, 2024 at 04:16:13PM +0000, Mark Brown wrote:
> On Mon, Mar 25, 2024 at 08:00:03AM -0400, Sasha Levin wrote:
> > 
> > This is the start of the stable review cycle for the 6.7.11 release.
> > There are 707 patches in this series, all will be posted as a response
> > to this one.  If anyone has any issues with these being applied, please
> > let me know.
> > 
> > Responses should be made by Wed Mar 27 12:00:02 PM UTC 2024.
> > Anything received after that time might be too late.
> 
> This is broken on at least the original Raspberry Pi, no output appears
> on the console.  Bisection tells me that the problem is introduced by
> d7303ef54fae6 ("printk: Disable passing console lock owner completely
> during panic()") though I'm not entirely sure I believe this.  I've got
> some bisects running on other 32 bit arm platforms with the same
> symptoms which I suspect will turn out to be the same issue, and v6.8 is
> failing in what looks like the same way.
> 
> BTW I did ask to be CCed on the review mails, it'd make life a bit
> easier.

Sorry, that was on my side, I'll add you soon to the scripts.

greg k-h

