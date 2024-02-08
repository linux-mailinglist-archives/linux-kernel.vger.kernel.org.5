Return-Path: <linux-kernel+bounces-58202-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F38784E2A9
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 14:58:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5535D292D18
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 13:58:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6F5878B6F;
	Thu,  8 Feb 2024 13:57:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nI7bLWpB"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3474A78B43;
	Thu,  8 Feb 2024 13:57:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707400636; cv=none; b=RUlh0MMW4RE7iRnyG9Xn+ArG7I2LhTG+kx0lPG66oaGcx23u19x2D1FaIx/qLet21W/6muRaxZglTEDWcFj8/iwGXwCI7R6mru+MibCsrnuo63fFTahgQTkBj15kixHbLDv1Mceo7tN+G0uHH98elSwQ4uDShiCvU/K5uJKfK2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707400636; c=relaxed/simple;
	bh=ESrUmfo/ZX4uBY/0ol0jgHD3Zqoak75Rank2w+OqQBk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WbpW9TPGzu4JGF4qzxlMtbUWHbtKrYnVHP8JSJUA42LMCKW1R4hTGFMOJ2cxRdVRK/6aXqe45QRsAUaq1v6TnO1z6xmwQ46c2ghfsF/SDvJF9basHsEQYs1sR7jOZWQ3kem6RWL1uV6n3wF+yfpwBvS+uZLD7pCKTkAlEtx71s8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nI7bLWpB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36DD8C433F1;
	Thu,  8 Feb 2024 13:57:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707400635;
	bh=ESrUmfo/ZX4uBY/0ol0jgHD3Zqoak75Rank2w+OqQBk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nI7bLWpBmO+OYuR2UTxJAGDK7hB+c79O+YFXKa5DUo7VMgKCHNU/yAUEvk4CaWQ+b
	 3ReU6g2yUkegtPR9GK7/3rBNYQvJXx5FOb8WJ+z+dy/yKOBm55y/mUk4p1nmAf8L66
	 jyYAsrizURwntFX5I1j23qFmdPaBwLBQXl4lKOt4YrRGioyJcljvasdXXt+21oAcBI
	 5cBYn+9p2MLqOYkH3iPjCiGvCj192LjZWSDjvmckZbEGi7d1avofsF2WgAiq6oXw9g
	 1PMeke4nQmX7Qeng5RP7X35VWKncdmP5nzt+hxkzKHZpgDazqESFz3oXUtFXxFl57D
	 v3g0PUxSBqJ/w==
Date: Thu, 8 Feb 2024 13:57:11 +0000
From: Lee Jones <lee@kernel.org>
To: Charles Keepax <ckeepax@opensource.cirrus.com>
Cc: broonie@kernel.org, andy.shevchenko@gmail.com,
	patches@opensource.cirrus.com, linux-kernel@vger.kernel.org,
	linux-spi@vger.kernel.org
Subject: Re: (subset) [PATCH v4 1/6] spi: cs42l43: Tidy up header includes
Message-ID: <20240208135711.GO689448@google.com>
References: <20240129152557.3221212-1-ckeepax@opensource.cirrus.com>
 <170738736196.904064.7729211182384063971.b4-ty@kernel.org>
 <ZcTYift6P9KkiI7g@ediswmail9.ad.cirrus.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZcTYift6P9KkiI7g@ediswmail9.ad.cirrus.com>

On Thu, 08 Feb 2024, Charles Keepax wrote:

> On Thu, Feb 08, 2024 at 10:16:01AM +0000, Lee Jones wrote:
> > On Mon, 29 Jan 2024 15:25:52 +0000, Charles Keepax wrote:
> > > Including some missing headers.
> > > 
> > > 
> > 
> > Applied, thanks!
> > 
> > [2/6] mfd: cs42l43: Tidy up header includes
> >       commit: a5bc1c6c93853fb1026fb5feb6c36c9cd9512724
> > [3/6] mfd: cs42l43: Use __u8 type rather than u8 for firmware interface
> >       commit: eb40e181cc480c89b906aca1f29ff6f6df6b66b9
> > [4/6] mfd: cs42l43: Add time postfixes on defines
> >       commit: 43a94a8cf0fa136d5fc726121ff7a602754c9680
> > [5/6] mfd: cs42l43: Add some missing dev_err_probe()s
> >       commit: 104c68194edbe0e8c3036ce283a3f69434415be2
> > [6/6] mfd: cs42l43: Handle error from devm_pm_runtime_enable()
> >       commit: 8716f2c79eb82bd4dc5d7f9523a560e35efe0795
> > 
> > --
> > Lee Jones [李琼斯]
> > 
> 
> The SPI one needs to be applied along with these, otherwise
> this will cause build breakage in the SPI driver.

Okay.

Mark, can I just take it without sending a PR?

-- 
Lee Jones [李琼斯]

