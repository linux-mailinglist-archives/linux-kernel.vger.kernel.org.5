Return-Path: <linux-kernel+bounces-125819-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 60D45892C9C
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Mar 2024 19:41:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 907A41C21768
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Mar 2024 18:41:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E91C43BBE4;
	Sat, 30 Mar 2024 18:40:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ravnborg.org header.i=@ravnborg.org header.b="W1nqs/H5";
	dkim=permerror (0-bit key) header.d=ravnborg.org header.i=@ravnborg.org header.b="f4Dkfc8k"
Received: from mailrelay1-1.pub.mailoutpod2-cph3.one.com (mailrelay1-1.pub.mailoutpod2-cph3.one.com [46.30.211.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4455A1FB2
	for <linux-kernel@vger.kernel.org>; Sat, 30 Mar 2024 18:40:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.30.211.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711824052; cv=none; b=oJxJYf694GOjFeoLvAVQlyL9hKQDY6tr/6NhQKkgWYzXKvLz/OdfUfhin+cILjkKrSulvZ72f6WbII7Un6nN0tH/fQazYlaH1NARSuuEtzO/4fnvd3/r11pe3NQ+VaJKrcAguJh9nK6j7/suKkQJSzQkFy/kPbQXmTP3htvkXCQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711824052; c=relaxed/simple;
	bh=+fKm55pvJInq7E1oiY4SA54W6AbzUuuzHvH9tWxJRYU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Hk/j8kqgVlB0B8B6PLwx0jUKtTLo5s0jazK0JQbpm1Oi7UmlXv5O2XfMKaPhrUgs0zn4zrjv94iZ+7GE8moBWHVLB1GKjp9YXfQhp/W+IzfK87pwNv4Y0pcLFq2kWIFNfCdchBZUISF/nsEwCcaxe3fIG4Y06meEdQUIlPOaPqI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ravnborg.org; spf=none smtp.mailfrom=ravnborg.org; dkim=pass (2048-bit key) header.d=ravnborg.org header.i=@ravnborg.org header.b=W1nqs/H5; dkim=permerror (0-bit key) header.d=ravnborg.org header.i=@ravnborg.org header.b=f4Dkfc8k; arc=none smtp.client-ip=46.30.211.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ravnborg.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ravnborg.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=ravnborg.org; s=rsa2;
	h=in-reply-to:content-type:mime-version:references:message-id:subject:cc:to:
	 from:date:from;
	bh=Xeeh2dg6zdnZbEZ/lUmV7A/JWt00HE94jarkf2OAKXw=;
	b=W1nqs/H5MmWtsVize4yOqv5zdPv5BOIEbvoB7e+mMiiTmOTMjUevbBzHBATpsEk5ypP+S0gb07Ea7
	 lYIwTt7rTRjGJK04mnHWquqc4RfbS/2FdyNOapO2cDBM8jHPt0DFb5p9FXWM2pgCHkwS1hJhLmm1hb
	 UfgPQjbXjjvGpXKSXisIHKdtWrR57wFf6vKW1JCLfjzl6UQqwNwFZx6uG3hiQYtNnURydBl82WqyL8
	 8Khl7QCX0SIKmVe8XhdZ4fT1A0rPLgPU1jE0jyE9ebkJeZQHjRcHGsAk6sfww+GqU5zrpR+v0Qv8fJ
	 gDl3Zsjg/AQUE4+cLwF1EYXMacoW2Pg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed;
	d=ravnborg.org; s=ed2;
	h=in-reply-to:content-type:mime-version:references:message-id:subject:cc:to:
	 from:date:from;
	bh=Xeeh2dg6zdnZbEZ/lUmV7A/JWt00HE94jarkf2OAKXw=;
	b=f4Dkfc8kcLussvHSfDwqYMUW8E8Ke7ibwfhSRoadQwiTSPL1XpNhGZ4TBp+VxxwEsa4367kFop+2M
	 kmnjvaFCg==
X-HalOne-ID: dba5c148-eec4-11ee-9dce-516168859393
Received: from ravnborg.org (2-105-2-98-cable.dk.customer.tdc.net [2.105.2.98])
	by mailrelay1.pub.mailoutpod2-cph3.one.com (Halon) with ESMTPSA
	id dba5c148-eec4-11ee-9dce-516168859393;
	Sat, 30 Mar 2024 18:39:39 +0000 (UTC)
Date: Sat, 30 Mar 2024 19:39:37 +0100
From: Sam Ravnborg <sam@ravnborg.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Andreas Larsson <andreas@gaisler.com>,
	"David S . Miller" <davem@davemloft.net>,
	sparclinux@vger.kernel.org, Nick Bowler <nbowler@draconx.ca>,
	linux-kernel@vger.kernel.org, Atish Patra <atish.patra@oracle.com>,
	stable@vger.kernel.org, Bob Picco <bob.picco@oracle.com>,
	Vijay Kumar <vijay.ac.kumar@oracle.com>
Subject: Re: [PATCH 00/10] sparc64: Fix CPU online bug and warning fixes
Message-ID: <20240330183937.GA191882@ravnborg.org>
References: <20240330-sparc64-warnings-v1-0-37201023ee2f@ravnborg.org>
 <4e57929b-1539-4a25-ab05-a2a9e04ecc1d@app.fastmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4e57929b-1539-4a25-ab05-a2a9e04ecc1d@app.fastmail.com>

Hi Arnd,

On Sat, Mar 30, 2024 at 11:19:37AM +0100, Arnd Bergmann wrote:
> On Sat, Mar 30, 2024, at 10:57, Sam Ravnborg via B4 Relay wrote:
> > Nick Bowler reported that sparc64 failed to bring all his CPU's online,
> > and that turned out to be an easy fix.
> >
> > The sparc64 build was rather noisy with a lot of warnings which had
> > irritated me enough to go ahead and fix them.
> > With this set of patches my arch/sparc/ is almost warning free for
> > all{no,yes,mod}config + defconfig builds.
> 
> Patches 1-9 look good to me,
> 
> Acked-by: Arnd Bergmann <arnd@arndb.de>
Thanks!

> 
> > There is one warning about "clone3 not implemented", which I have ignored.
> >
> > The warning fixes hides the fact that sparc64 is not yet y2038 prepared,
> > and it would be preferable if someone knowledgeable would fix this
> > poperly.
> 
> The clone3 bug has been around for ages, it's probably not even that
> hard to fix and just needs a little bit of testing.
I looked briefly and it involves a better understanding of the window
register manipulation than what I have today.

> 
> If anyone wants to work on the time64 support for the vdso, I can
> explain the details for how it's done.
I am happy to type the patches but need to rely on others for testing.
Anything to help me get started would be super.

	Sam

