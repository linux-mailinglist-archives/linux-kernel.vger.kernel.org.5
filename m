Return-Path: <linux-kernel+bounces-122867-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0625388FEB7
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 13:09:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 96F711F28FEC
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 12:09:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B60947EF06;
	Thu, 28 Mar 2024 12:09:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hGPmrgbR"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06ECD651AB;
	Thu, 28 Mar 2024 12:09:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711627752; cv=none; b=ldRe0GdUGjj1HDfQBfhyD4xKSJhkgXUDTbznho+StBedYzWUx+IKVM3Av7r2ytJFueXifFXmth24Ec50mOpFHj7GxUxQqONCTJ7O5ezmy8vPbmjQ2Aakmgb/bvdY+d7tdo1yknCLo9W8zvCm75Usd4s0vCnGAxRPzkGv0ZWOMCI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711627752; c=relaxed/simple;
	bh=bDdIQy3o9k9pDQhfcYuWNGkTquDBCyB4T3JOLOgtkNQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hIyWPpiglidn/d0uPhB9oY9Pl+NGVnoLRfxtbgMgy9WVIxTunfaCyDDoYFzLLf14YvaDlLw27v+Ugs4bO8OV94u5TakAJDZjMx+ghkx6C0No4FGff6jTt5hrE7DuQ8TDR/o0V1fLkVM2iq6HNw+ivN/VRp/yj12CVP3zPxSUX8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hGPmrgbR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B462C433C7;
	Thu, 28 Mar 2024 12:09:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711627751;
	bh=bDdIQy3o9k9pDQhfcYuWNGkTquDBCyB4T3JOLOgtkNQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hGPmrgbRnQJRoCHhQpGt0HJ6PALN9gotcdgM0UlhKS1MUU/Bb7c6LK+ap/VBA3t2e
	 dwLyEcgurYBkE2vZ1B9LEGWjZ5TlSK89ZF8067ImM9lK68gt9htkKaTFBd+HvyMl6E
	 WBWKpB5ymJuAihuUgJCtAllNu4+sWGcFjqPP2xB3ZiZNJ7BRysglmoXwQPD5ba/eyY
	 D2yMd02yc7bMD0+1oT27a+P7JTb1CpLpXf4FP3SPqGMh6WzK4CkF8Y2BEmVe73raoK
	 O+gvT6yLaOi+tRgLImcytU5WLOTOzVvu7kZKu6U7CJ+PXo9IRIZhKYMl/GZimQQjxi
	 m+4qp0ZmSqVXw==
Date: Thu, 28 Mar 2024 12:09:07 +0000
From: Lee Jones <lee@kernel.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, daniel.thompson@linaro.org,
	jingoohan1@gmail.com, deller@gmx.de,
	"Ricardo B. Marliere" <ricardo@marliere.net>
Subject: Re: [PATCH v2 1/2] video: backlight: make backlight_class constant
Message-ID: <20240328120907.GG13211@google.com>
References: <2024032805-putdown-mushy-a0f9@gregkh>
 <171162770830.1983471.4181539912129600848.b4-ty@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <171162770830.1983471.4181539912129600848.b4-ty@kernel.org>

On Thu, 28 Mar 2024, Lee Jones wrote:

> On Thu, 28 Mar 2024 12:59:06 +0100, Greg Kroah-Hartman wrote:
> > Since commit 43a7206b0963 ("driver core: class: make class_register() take
> > a const *"), the driver core allows for struct class to be in read-only
> > memory, so move the backlight_class structure to be declared at build time
> > placing it into read-only memory, instead of having to be dynamically
> > allocated at boot time.
> > 
> > 
> > [...]
> 
> Applied, thanks!
> 
> [1/2] video: backlight: make backlight_class constant
>       commit: 6683414cff25dc5b6e7dfe9dadf42b718384c892
> [2/2] video: backlight: lcd: make lcd_class constant
>       commit: d51564f749fe4e4efd570b0591f2d23696c90cc7

I also added Daniel's r/b.

-- 
Lee Jones [李琼斯]

