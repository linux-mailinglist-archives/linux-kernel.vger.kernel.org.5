Return-Path: <linux-kernel+bounces-72524-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CF76385B4C0
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 09:18:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0E3F11C214E6
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 08:18:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2453D5C612;
	Tue, 20 Feb 2024 08:18:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b="BKPPpyyV";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="IsLqLA+k"
Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com [66.111.4.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17C21537E8;
	Tue, 20 Feb 2024 08:18:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.111.4.29
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708417088; cv=none; b=vByp+nDnnufttdxqDLnO6OyNN8htPtGu6PHoFekXiSP+k438zCmKwlef0O/P1xB8JQhBVy0UyPBkrNXthBmkojNH97N91TK9hvOk98u4etCRjYXdRs44fZyvdFpbyATOn3rOUWvJbKDGG6qxGwJQlG4cMIZn0Tn83xdfa+upZ3Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708417088; c=relaxed/simple;
	bh=218+sberme46w4rSLdtDFR3cksdp3fFHIxSU5GzNgM0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tuPpaVJk+eBXXHHaNit3br1VsWuIaknP4VXtofOHPs//fXLw3V1c2CV9ZrHyUjYIQSzaPhGSioTZFlC7Hk2dQRJ/phLEf2Lz91b+BQv/DWAiRHjbXfrBvp+Ak4aocTII1UbGUn3mEAA1+msmsPVrJNEoo1xUfRY1y/SkBFCpses=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com; spf=pass smtp.mailfrom=kroah.com; dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b=BKPPpyyV; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=IsLqLA+k; arc=none smtp.client-ip=66.111.4.29
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kroah.com
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
	by mailout.nyi.internal (Postfix) with ESMTP id 0FBF55C004A;
	Tue, 20 Feb 2024 03:18:05 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Tue, 20 Feb 2024 03:18:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1708417085; x=1708503485; bh=EiWWdFwzmI
	XHz/UfrI0jy1S2jX2ItN7cQKgmDZYaw2g=; b=BKPPpyyVX18xov6QoEcaPWfJe7
	43hSSkkr69x0MWfYosW+Ir0prNa7PQbaK6TqQCIxtik0+Mr4GBfr24ipA78rTDr7
	5VWtRDbRTcusbo9PH507aEqmUJuomFYtchBqmX6a5UCAUGLbUCVqD+cqUtwgyGZu
	dHJbHu7HvaKYlsVuXWKlZEmvgCjst1ROX6c4ivw812DjxUYoAD4diYnuSdug+QWp
	QXCt3AYLYW8RYgunAGAhYDNsOWOwTJzt/0a/DPeF7A8aCK5+HaPCERy0K2ZO5Bqn
	Yye+Laxiy/kVBtQoEpE1axcbeSI001nV+wTZL2g/MN7vKB08Lwf9R2vFCGUg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1708417085; x=1708503485; bh=EiWWdFwzmIXHz/UfrI0jy1S2jX2I
	tN7cQKgmDZYaw2g=; b=IsLqLA+kSVfyZNYWO10MajbsIQCYaJuqV8N4fu0twgGC
	iNbr8OEu7lSLAHZkVzfNKKkoh1khW6Y8ZMYks7yfcWNIEAYWKVtpyLMQdJ/NnmKc
	gj81C1lTFoK7x28iIdwGUwXD53rZqBkAKV8hhqFosNskNHbAwxomYE1LTbBAZwn3
	YMVoWP95+o500Stvl41B8VGSt3sdxw/FXjL48uG2sstA0R2+mXELW/SX6w4kYRTR
	FgOQVDv+b63TpNto/CD+Rvq+1C/w0hmT/nlSwYDKdcPk+XLJgDd1peW5ICXirO8r
	y0deRqro0MoPCqfR2Qut3tZAOyCrLUeDuqY+fMOfEA==
X-ME-Sender: <xms:PGDUZXwEIZe-gWo4j0oj-xqAqT6Irso695m0xFABb3V6X6DvCCMYYQ>
    <xme:PGDUZfRsXPWR6EHmvC2ZRk3qtj1EqU_YOg7q3klbjC4Pdjaw4QwEzzX-xbBaX_hje
    f7Wyi6Vlf1HGg>
X-ME-Received: <xmr:PGDUZRX0jYKG4Twoeva-vIg0Md4eUh8E3Vfu-5DePNmPDGwfT3o6VnQDUXki4puCLr7qo88nNgmI-Z7EQlm7fXlYVarPOllnHQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdelgdduudekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepifhrvghg
    ucfmjfcuoehgrhgvgheskhhrohgrhhdrtghomheqnecuggftrfgrthhtvghrnhepheegvd
    evvdeljeeugfdtudduhfekledtiefhveejkeejuefhtdeufefhgfehkeetnecuvehluhhs
    thgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepghhrvghgsehkrhhorg
    hhrdgtohhm
X-ME-Proxy: <xmx:PGDUZRg3-522QAR3lTcCEmSLjoLAgFvTJ0SmGqmzibci8dZezbZxHA>
    <xmx:PGDUZZDJ2c1nc7EmElZiRjrLt2INM4Ix3ryCPtX0SVWiT7_sj_fdgA>
    <xmx:PGDUZaLOeIKo3VD7NIWKr5UOZa77fXJYuD0_7ZLVISRf9TNbBGdiEQ>
    <xmx:PWDUZdtNLCd0IIGrIcjyJlhbI9eFankuIxeVeHZ92Ay3SO5oIc1I2A>
Feedback-ID: i787e41f1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 20 Feb 2024 03:18:03 -0500 (EST)
Date: Tue, 20 Feb 2024 09:18:02 +0100
From: Greg KH <greg@kroah.com>
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux Next Mailing List <linux-next@vger.kernel.org>,
	Xu Yang <xu.yang_2@nxp.com>
Subject: Re: linux-next: manual merge of the usb tree with the usb.current
 tree
Message-ID: <2024022052-booted-landlord-dd40@gregkh>
References: <20240220143919.40257e7b@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240220143919.40257e7b@canb.auug.org.au>

On Tue, Feb 20, 2024 at 02:39:19PM +1100, Stephen Rothwell wrote:
> Hi all,
> 
> Today's linux-next merge of the usb tree got a conflict in:
> 
>   drivers/usb/roles/class.c
> 
> between commit:
> 
>   b787a3e78175 ("usb: roles: don't get/set_role() when usb_role_switch is unregistered")
> 
> from the usb.current tree and commit:
> 
>   9a270ec7bfb0 ("usb: roles: Link the switch to its connector")
> 
> from the usb tree.
> 
> I fixed it up (I think - see below) and can carry the fix as
> necessary. This is now fixed as far as linux-next is concerned, but any
> non trivial conflicts should be mentioned to your upstream maintainer
> when your tree is submitted for merging.  You may also want to consider
> cooperating with the maintainer of the conflicting tree to minimise any
> particularly complex conflicts.

Looks good, thanks!

greg k-h

