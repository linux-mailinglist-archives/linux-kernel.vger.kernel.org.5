Return-Path: <linux-kernel+bounces-144656-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1176F8A48DB
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 09:21:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1E4041C22E4E
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 07:21:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E14C0225D4;
	Mon, 15 Apr 2024 07:21:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b="DgirHl52";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="L2lCST4B"
Received: from fout7-smtp.messagingengine.com (fout7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BEB022083;
	Mon, 15 Apr 2024 07:21:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713165705; cv=none; b=kw7yGKU+5yMSA/8Yg40K7YHKWIuv+jm5FeYB3Y8ep0kc9C4VivmeihwvijgEDaES7SAYNHhnXwClzSF0NR2Eo0pMUcOSYki+yxOymt3gBmsOEMHkIVIMMv9ZX2kC4IV2xEI9si8PRApnudayZqjYoksGPtPpgQXNZZw3YqV4K2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713165705; c=relaxed/simple;
	bh=JhLbzZijpT79Z50ks1IAoM9MBSyAGnxr2O/ACfRFHfY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QNKLHk3DV/uGa4qggLfC5+sBxUPSuMvxZyyQ4ErzXGsbVX1dMy3kT0A0VT8GKmB76vltPOgKhnzgbxTN2CiDSYFQVqxei+NfSilYkTXKFylIgGkI4WWTvP0UWZb94c6x4J/Teg4EEZOGTLfZIpK9k83l7EFfdwvAtJQ/gtgk/00=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com; spf=pass smtp.mailfrom=kroah.com; dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b=DgirHl52; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=L2lCST4B; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kroah.com
Received: from compute7.internal (compute7.nyi.internal [10.202.2.48])
	by mailfout.nyi.internal (Postfix) with ESMTP id 21C6913803E7;
	Mon, 15 Apr 2024 03:21:42 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute7.internal (MEProxy); Mon, 15 Apr 2024 03:21:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1713165702; x=1713252102; bh=OzCVedbR40
	r+QabWhdCxji0PMrHt7vkLnWR49iF/or0=; b=DgirHl52+h3darQhUJ1NfuOCTo
	ex+HVDb/QmkU4uzynKMLmyfd3hgEMUyO0UqWCVpdarkc8N0EIJsHIlMqhyECe/td
	4DmonTBHeINGbkKwsgDU9ggz00Jh/mYI5K048q2NhSB/a5a9GkpRVUHJ9kTgTAih
	DQANbk/kqOjpYKE/SXrouGX9Ab7RBuBnqvmXGDXbh0gK9shlYPyVsIfySVDsddzR
	iBgWdb5PrGhShB95OtZ5StNS2vcbJR3/WCZbKQzHdVCncBPfZIA+82fCayj35UhS
	x+zlLDaXuY8ooVJy9YGBM7RfL5eG0KFSsW5wuhIq28ZhMU2K7gMeC2WJsabQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1713165702; x=1713252102; bh=OzCVedbR40r+QabWhdCxji0PMrHt
	7vkLnWR49iF/or0=; b=L2lCST4Bup5tov4hQeU/SdGva3cycMQFHvbusXi/0uia
	p/PvRUQSgKNwNB9evAoR1GwOjwQU+o9EbcpV1SDaUpV9Ezu5v48iRkHUWgyzMTW4
	NZr5voh21JOUBhleyRYx+h81FA9Yks6/MelPKFFOqvVEGXvbJAIz/Fj5MRCoa+Nq
	ZLizR0+McHczf7gqvBRXvrfv9ZPP9ixUAbgT4ZEIFW9kdFxtIDxfvI3/WhaNFNEV
	hZKz8exe1GIlJVDvWwjlSKnFXFXToabNu5OYwvIjukXNZ5TrEmP9ILjf7JRmwmJA
	aKOGEnQfE3jdSxlvzPnUHKtdpWOG+3zITTucQxbUpA==
X-ME-Sender: <xms:hdUcZjw8kpOJAtjE-b4HYUA343S2xWeUWtiB4KrHnph0LXlhuRpbEg>
    <xme:hdUcZrSppw73Vf_vylcjqGm8Pe6idvJtjT2BZQgcYuy0oPUoN2N0LvnrJC-dqThw7
    6fM4E2_5_Ws_w>
X-ME-Received: <xmr:hdUcZtVRK2EnlCALvVrHMF4k_nrsZ4HvjMIHs5x9lXyGnuLFM56S5xfTvqHkG_-WE-g4Q96vVmXIrGtMst5kHsz2KDIz0XV9cRERww>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrudejuddgieejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepifhrvghg
    ucfmjfcuoehgrhgvgheskhhrohgrhhdrtghomheqnecuggftrfgrthhtvghrnhepgeehue
    ehgfdtledutdelkeefgeejteegieekheefudeiffdvudeffeelvedttddvnecuffhomhgr
    ihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehgrhgvgheskhhrohgrhhdrtghomh
X-ME-Proxy: <xmx:hdUcZtihNrb-zICOdCat6VO6MUnW4A6HH8A99FDciVlLLeE_FtB8Eg>
    <xmx:hdUcZlC9Dmo0HPxsXFLQWr-jw2SJ-TAS8oULV28i2xv5kLbY-gtG_w>
    <xmx:hdUcZmIXA80DOWCg_dztCNgt2agNtgf9kY5FRhZOlAPkZxz2GyaeGg>
    <xmx:hdUcZkCSSA7vazFNry5c7TnLDSfxpc_TzjYHCgDXC0EuusKbBIAuhQ>
    <xmx:htUcZp5D32My3FcxtaOQLrYO-93FRRi8ScR1br3h_L6Z8MDyMGgWU4NL>
Feedback-ID: i787e41f1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 15 Apr 2024 03:21:40 -0400 (EDT)
Date: Mon, 15 Apr 2024 09:21:38 +0200
From: Greg KH <greg@kroah.com>
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: Arnd Bergmann <arnd@arndb.de>,
	Chris Packham <chris.packham@alliedtelesis.co.nz>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: build warning after merge of the char-misc tree
Message-ID: <2024041520-luxurious-accurate-5964@gregkh>
References: <20240415152227.14c877a7@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240415152227.14c877a7@canb.auug.org.au>

On Mon, Apr 15, 2024 at 03:22:27PM +1000, Stephen Rothwell wrote:
> Hi all,
> 
> After merging the char-misc tree, today's linux-next build (htmldocs)
> produced this warning:
> 
> drivers/uio/uio.c:446: warning: expecting prototype for uio_interrupt(). Prototype was for uio_interrupt_handler() instead
> 
> Introduced by commit
> 
>   f8a27dfa4b82 ("uio: use threaded interrupts")

Thanks:
	https://lore.kernel.org/r/20240414215220.2424597-1-chris.packham@alliedtelesis.co.nz
should fix this up, I'll go apply that now.

greg k-h

