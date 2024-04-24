Return-Path: <linux-kernel+bounces-157630-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 17B618B13D1
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 21:53:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C1F231F228AF
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 19:53:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CB6613B5BD;
	Wed, 24 Apr 2024 19:53:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="cXq6ERfA"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B4441848;
	Wed, 24 Apr 2024 19:53:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713988385; cv=none; b=OGQTYP8HEl7FYC0Wvn6attQEcqmitNb+WN69ZlcZ2Sh+MbwP1VWWUCG17o6BK/yuoMrfvGjyy2r3DPNp2tOqtkKYLihvm2DGhRv9D838yj3CC+UkXEoWLhosb6Z+NubO7XkFm6IDteuBMSPGEyrDUgsuOkRKa6bfykLqUD8dUCA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713988385; c=relaxed/simple;
	bh=GjKZEcEZNz517Hib5vIHPrJfExb6oo/SGzk4kdrUJ2Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pCdrfEY29TAJg2ZnLfvrcGSsjl4HrIoA9kyXt4Qos3kzXRFiNYDWI/grR/Mvwl+J2kkSlh8a60qc17cm+PSu7BCtp/kOYyzSQ1z9z2rTwKRrkc/McrS5IF1PvHmO+YtHFu8PSeEYlxclVxW639pgnith3AZmBA0WCqO38UraDIM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=cXq6ERfA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EBD6CC113CD;
	Wed, 24 Apr 2024 19:53:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1713988385;
	bh=GjKZEcEZNz517Hib5vIHPrJfExb6oo/SGzk4kdrUJ2Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=cXq6ERfA4ce7lVmRFDaE/b5ubkDHXq11uWlYLVa6opZhMrQcZfRLSTyvwJWeaDbAi
	 MI5pOHbzlf16nVefraWLp1/AzyM+6JrIK9pSZJX3V/YLTdFFnda/pjxgtRDGfnqjwX
	 tAMXhPyCIg4o0/akMSlsZObBkNYLaOMwokHvPwSw=
Date: Wed, 24 Apr 2024 15:53:03 -0400
From: Konstantin Ryabitsev <konstantin@linuxfoundation.org>
To: Mark Brown <broonie@kernel.org>
Cc: Conor Dooley <conor@kernel.org>, 
	=?utf-8?B?VGjDqW8=?= Lebrun <theo.lebrun@bootlin.com>, Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, 
	Rob Herring <robh+dt@kernel.org>, Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
	Conor Dooley <conor+dt@kernel.org>, Vaishnav Achath <vaishnav.a@ti.com>, 
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>, Rob Herring <robh@kernel.org>, linux-spi@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mips@vger.kernel.org, 
	Vladimir Kondratiev <vladimir.kondratiev@mobileye.com>, Gregory CLEMENT <gregory.clement@bootlin.com>, 
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>, Tawfik Bayouk <tawfik.bayouk@mobileye.com>
Subject: Re: (subset) [PATCH v3 0/9] spi: cadence-qspi: add Mobileye EyeQ5
 support
Message-ID: <20240424-calm-wolverine-of-drama-0349dc@lemur>
References: <20240410-cdns-qspi-mbly-v3-0-7b7053449cf7@bootlin.com>
 <171283699002.32012.7629247540689477794.b4-ty@kernel.org>
 <D0QT350IJHFH.36EXE1UT9QM10@bootlin.com>
 <ZidAefc0Ejrklopf@finisterre.sirena.org.uk>
 <D0RF1AKWAEAE.44N64GHMV2ZY@bootlin.com>
 <3f891794-0083-4245-bad7-518b1c48bb7c@linaro.org>
 <D0RIXN4JG6ZA.4W4HN68M9U6I@bootlin.com>
 <20240423-epidemic-schedule-6fa9869b3e87@spud>
 <ZihaBGwVRpI9hV0B@finisterre.sirena.org.uk>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZihaBGwVRpI9hV0B@finisterre.sirena.org.uk>

On Wed, Apr 24, 2024 at 10:01:56AM +0900, Mark Brown wrote:
> > > Thanks for the pointer. I've created an issue over at b4 to see what
> > > people think about this matter. Current behavior is not intuitive as a
> > > young contributor.
> 
> > FWIW, given I see `having a more confident comment such as
> > "(commit not applied)".` there, having (no commit info) doesn't mean
> > that it wasn't applied always. Sometimes I've found that due to changes
> > in the patch b4 could not detect that it was applied and reported (no
> > commit info).
> 
> Right, it can't prove a negative - if it can't find the patch it could
> be because it wasn't sent against current code and got changed
> sufficiently in application to cause issues.

We can also be a bit more relaxed. For example, we can look at 
consecutive commits and compare the subjects to see if there's a match.  
I'll see if that's something I can add in.

In general, though, I prefer to push people in a different direction -- 
we really shouldn't be fixing up people's patches, because this 
misattributes the code to the wrong author. Instead, we really should 
either ask senders to send an updated revision, or make the changes in 
merge commits instead.

Merge commits can be created using "b4 shazam -M", but I must admit that 
editing the contents of the merge commit isn't really that 
straightforward, unfortunately.

-K

