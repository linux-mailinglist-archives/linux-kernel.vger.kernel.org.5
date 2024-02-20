Return-Path: <linux-kernel+bounces-72527-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5067285B4C8
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 09:19:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F110F1F2220F
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 08:19:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 171FF5C903;
	Tue, 20 Feb 2024 08:18:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VETVhiUG"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59CEA5C61E;
	Tue, 20 Feb 2024 08:18:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708417127; cv=none; b=Fzs+LPCUaWowqzeZ05vQHWKuvV+WLSQOChCfpWBxP6ngkX8YPWtzR4ZeFtQouFqY6GEeskPxdVIsdiyUddIjhNOZALGOlYsgUN/hbxr98sRsRop3RCFyCt/H/9FB1DYRM//Jy5CicbwTckrGS0reN7KMlb5qR5HpGjZCGgOrpdE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708417127; c=relaxed/simple;
	bh=UNLQOif7fmJJax3E38KDrW05Mmzsmh0eEm1H+yPRIs8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BwiSsw1Kk42QAjnP1MYhf4BI4gzDZldrbPFgHZoTb1+8zoZQgEY/EUr8ffMynxv5CwQohhefaPVrPdw1hi7WaCREtPU84Fsg3R7H6OmBjjGGKKAMf76DHufNKDRDfiZnx+eCgURqBci8Mwk+Bah+r3tmcxNjEE1EIoV+1OU8SZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VETVhiUG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8EC3C43394;
	Tue, 20 Feb 2024 08:18:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708417126;
	bh=UNLQOif7fmJJax3E38KDrW05Mmzsmh0eEm1H+yPRIs8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=VETVhiUGk0LAIW8FX4/ARlQCdMTKPauZb6sd6xroDdUJiMZ5owDNy6DvLy0DlYnRC
	 XtWovxU3+Ad1/CaShkFWqIdIJjXEUH18YTvsXhFm8P9eVcb5Kze4odIY8GsqWTDAt8
	 p0PsBSrBxaO1ZiQFJZtM3pf0AzOsc1g1TGrFUX5O227tlDFuJvc6Aup9SeTUeP36Nf
	 W1N4+xW3gv9Kos5MDs2e0Q+nsbr8uo5Oi614+OgcWYV1vN3zET2mhQWFCy2ei0/ao3
	 +evBV35HQ98qvFdWCV0Ubcn4pvxOzmcTMGqwGoOaNJgckKw77Brjov4ZTaHjiHi5oe
	 AQvRd9Y1pQ6/Q==
Date: Tue, 20 Feb 2024 08:18:42 +0000
From: Lee Jones <lee@kernel.org>
To: Chris Packham <Chris.Packham@alliedtelesis.co.nz>
Cc: Pavel Machek <pavel@ucw.cz>,
	"linux-leds@vger.kernel.org" <linux-leds@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: Linux support for a 7 segment LED display
Message-ID: <20240220081842.GF10170@google.com>
References: <1f598a72-dd9f-4c6c-af7f-29751f84bd23@alliedtelesis.co.nz>
 <20240219151332.GC10170@google.com>
 <a70425d3-95be-4360-9828-d5403404e803@alliedtelesis.co.nz>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <a70425d3-95be-4360-9828-d5403404e803@alliedtelesis.co.nz>

On Mon, 19 Feb 2024, Chris Packham wrote:

> Hi Lee,
> 
> On 20/02/24 04:13, Lee Jones wrote:
> > On Sun, 11 Feb 2024, Chris Packham wrote:
> >
> >> Hi Blinkenlight enthusiasts,
> >>
> >> I'm looking for something that I figured must exists but maybe it's so
> >> niche that no-one has bothered to upstream a driver for it.
> >>
> >> I have a requirement to support a 7-segment LED display[1] (one that can
> >> display a single digit from 0-9). Hardware wise it's just a bunch of
> >> individual GPIOs connected to each segment (plus an extra one for a
> >> dot). I can't see anything obvious in drivers/leds but maybe I'm looking
> >> in the wrong place. Or maybe it's the kind of thing on PC hardware that
> >> is just driven by the BIOS without the operating system knowing about it.
> >>
> >> Is there an existing in-kernel driver for such a thing?
> > Why would LEDs connected to a bunch of GPIOs in a specific fashion
> > require a hardware driver?  Doesn't drivers/leds/leds-gpio.c already
> > provide all the support you need?
> Yes I could expose the individual segments as gpio-ledsbut it would be 
> nicer if they worked in a more co-ordinated fashion so I didn't have to 
> care about the individual segments and could just say "display 7" or 
> "display 0".

Still not sure this sort of thing should be kernel-side.

Sounds more like the role of a library or middle-layer.

-- 
Lee Jones [李琼斯]

