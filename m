Return-Path: <linux-kernel+bounces-166236-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A7F18B97E5
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 11:37:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7CA97B24E57
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 09:37:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDFAE55E48;
	Thu,  2 May 2024 09:37:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lPPwQXi9"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0913F537E7;
	Thu,  2 May 2024 09:37:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714642661; cv=none; b=CzAq5gxD1ylz4c5qJHRmAog2GSgvDGkyY/QR+OnsOI7ea84RqpUx1T3Uq25vwBfv2HwT8Ba9cbivZOIgA4cwqeTop2a0aV4VzWU6+z0t75eWtrn1gcYonsye/5HakZVDRy8SW5q7xQDY55PnAkF3uYbI8oCe4oPe2IMXFTWxjmE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714642661; c=relaxed/simple;
	bh=RnY2mHcy5s3RJThqemCEECImstQv/0eAsLqYWQqx2tU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bbbFj2yQZQlJMe4WEJsXAL+MvjhnOxSwHztiJiRZghZ3tr03+jkoJ/h7nJbc4nAYY2m2l2v2dIS005qfUqiQCTZl+wcuWdMbWryp1P1cdcxiXKLNeFW1EP7P1SK8T66W2JLwrX0794IBs7j6BcBKmuFvPCdA/x1acw80Sj3py0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lPPwQXi9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 121A3C113CC;
	Thu,  2 May 2024 09:37:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714642660;
	bh=RnY2mHcy5s3RJThqemCEECImstQv/0eAsLqYWQqx2tU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lPPwQXi98HzM6jGfYAgRqIcHBMr9YrZ2xhPPAoEhJLzoahliDjqS3qpsyi2mfOT4O
	 Pe82VCZWek9mTR+2lZiCVfKgXKFBZefcSPB4+b+p1CjvAkK5iWtqdMAdoUh9usYNEy
	 9MnuVkkEo3HxLawUhyJm9jQw3/dvS8+8QnJEkBrYADACam70584lD2tuGEfiGYp+zw
	 cac9fuMh0OloP5KWjOT8dowYHtF/GM6vfIrPFtEBTDdqXxdKhkde5Y0xkFmTzCpGOl
	 EgAw8t40lhq6PpYIaO4jtqRthLAHg+twcsgXqRsudn0b9vnzKi/LU0TOi7I7BqzP/Q
	 s86gdo75JZJhg==
Date: Thu, 2 May 2024 10:37:35 +0100
From: Lee Jones <lee@kernel.org>
To: Ryan Walklin <ryan@testtoast.com>
Cc: Andre Przywara <andre.przywara@arm.com>, Chen-Yu Tsai <wens@csie.org>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-sunxi@lists.linux.dev,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.org>,
	Chris Morgan <macroalpha82@gmail.com>
Subject: Re: [PATCH v2 0/5] regulator: Fix AXP717 PMIC support
Message-ID: <20240502093735.GK5338@google.com>
References: <20240418000736.24338-1-andre.przywara@arm.com>
 <c17d163e-29cc-4049-985e-d1ef91d764cb@app.fastmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <c17d163e-29cc-4049-985e-d1ef91d764cb@app.fastmail.com>

On Sun, 28 Apr 2024, Ryan Walklin wrote:

> On Thu, 18 Apr 2024, at 12:07 PM, Andre Przywara wrote:
> > This is v2 of the fixes to the AXP717 PMIC support series. 
> <snip>
> > I don't know if that's still feasible, but those two patches would be a
> > good candidate to squash into the patches that they fix.
> >
> > The other three patches add the "boost" regulator, which is meant to
> > provide the 5V USB VBUS power when operating from the battery. It's the
> > usual trinity of binding/mfd/regulator patches.
> > Again this could be squashed into the respective patches from the
> > original series, if people agree.
> >
> > Please have a look and test!
> >
> > Based on mfd/ib-mfd-regulator-6.10, as detailed below.
> 
> Looks good here, RSB communication, regulator and 5v boost support configured via DT working well on my H700 board, established by a combination of successful device bringup and kernel reporting. Concur with the request to be squashed into the mfd-next tree for 6.10 if possible, thanks!
> 
> Ryan
> 
> Tested-by: Ryan Walklin <ryan@testtoast,com>

This doesn't look like a valid email address.

Did you manually type it out?  I suggest against doing that.

-- 
Lee Jones [李琼斯]

