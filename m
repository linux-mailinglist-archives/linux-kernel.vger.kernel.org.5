Return-Path: <linux-kernel+bounces-148486-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 839F08A834C
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 14:42:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0DAC9B22E26
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 12:42:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B71B13D61A;
	Wed, 17 Apr 2024 12:42:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="aOUSpA2i"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 563D913D2BA;
	Wed, 17 Apr 2024 12:42:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713357742; cv=none; b=adqMK6VPd+JpDbtJvzcjxJe65yXuhbPGjWA6W0FErMTc+9N9WlAfcUKXcb8/BgESplBtq/GhFFdgZ1d6GzESyg4s4LZgiY/cRGFJgZupLrZTzRduG9uh6FzVCnsdKfFhjxhyl8PAi0fc7uyyYlelhYXMm6vtSBcwd24OtKiRUhA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713357742; c=relaxed/simple;
	bh=iElS8fLYtQfkeJ74Kw3ZZys+/3ME/EXDLVa34ENKV2w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BSWIofdunBgHBoXSQAvLtELnY17zGbrSQHsjd763Q1iSRf1gdKzFfeyGcsEEE6lwpnsUNjgdLOHJHcMZy5tMH5torJv86O9PFVNbzlf8wvHndmVpBkrlhY3/he44NIepBxMPELO0B7Y+o8EkWNXYvlP3NTbyLUDVgZh6y4cHwUE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b=aOUSpA2i; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B7F2C072AA;
	Wed, 17 Apr 2024 12:42:20 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="aOUSpA2i"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
	t=1713357739;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=nhGk4qQoX6Vgfs3FX2NokLuDYqMjjQUysDddQh+F5Ec=;
	b=aOUSpA2iqqAFoAaoF1qsBUUCw8TiJlDAqdWwniW4Z1WMUCMmLjMzLESJjhk5KT+IBBZ30q
	Pk/saUu2ma4Gh+N5QHJN5NT95kdi+MbojjsJFloP8IZ+rOd0SY8PgCNHUeIwfGg8pIY9Is
	1uaYzzO+TYwQRjOXmuiwVEczgRzYreE=
Received: 
	by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 91e10a78 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 17 Apr 2024 12:42:16 +0000 (UTC)
Date: Wed, 17 Apr 2024 14:42:14 +0200
From: "Jason A. Donenfeld" <Jason@zx2c4.com>
To: Babis Chalios <bchalios@amazon.es>
Cc: Alexander Graf <graf@amazon.de>, tytso@mit.edu, olivia@selenic.com,
	herbert@gondor.apana.org.au, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, linux-crypto@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	sudanl@amazon.com, xmarcalx@amazon.co.uk, dwmw@amazon.co.uk
Subject: Re: [PATCH v5 1/5] virt: vmgenid: rearrange code to make review
 easier
Message-ID: <Zh_Dpi630-LXJkJm@zx2c4.com>
References: <20240417081212.99657-1-bchalios@amazon.es>
 <20240417081212.99657-2-bchalios@amazon.es>
 <10d41e7e-87b1-4036-a740-da36270a4325@amazon.de>
 <2838b126-ad87-4642-9223-e24f3fdb2c63@amazon.es>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <2838b126-ad87-4642-9223-e24f3fdb2c63@amazon.es>

On Wed, Apr 17, 2024 at 11:05:27AM +0200, Babis Chalios wrote:
> 
> 
> On 17/4/24 10:35, Alexander Graf wrote:
> >
> > On 17.04.24 10:12, Babis Chalios wrote:
> >> From: Sudan Landge <sudanl@amazon.com>
> >>
> >> Rearrage the functions of vmgenid to make the next commit,
> >> which re-implements vmgenid as a platform driver, easier to review.
> >>
> >> Signed-off-by: Sudan Landge <sudanl@amazon.com>
> >
> >
> > You can't sign off on behalf of someone else. The SoB here needs to be 
> > yours. If you are taking over this code from Sudan, I'd suggest to 
> > take over full ownership of it and put your own name as author and SoB 
> > in all patches.
> >
> 
> I thought about it and it seemed weird to me that I take over SoB and 
> authorship since I only touched one line in one of
> the patches, but I will be taking over the patches, so I can do that if 
> that's the way we things are done.
> 
> Does it make sense to at least add "Co-authored-by Sudan Landge 
> <sudanl@amazon.com>" here?

Wait, what? No. If you didn't write these patches, you're not the
author. Sudan is the author. However, if they passed through you, it's
fine to add your S-o-b. You can even mention the trivial change you made
between Sudan's S-o-b and your own.

Anyway, if there doesn't wind up being a need for another patchset, I
can fix this up upon committing to the tree.

Jason

