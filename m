Return-Path: <linux-kernel+bounces-158425-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 64E668B1FE4
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 13:06:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 19E121F22B66
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 11:06:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68EAC84FD6;
	Thu, 25 Apr 2024 11:06:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QA0+PpbW"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 972BD84DEE;
	Thu, 25 Apr 2024 11:06:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714043179; cv=none; b=mH6FhVzdlojaxNKy1ZJW2uIq9A/T8lJaHBhRJy97T20/5kzgEAl96ytdVOcWkf4TGnZAEZpAA8DRArNc9X79PxnPgfh1UehtzGnE6qjPt5o+NrxF49ePF8ZmUR3nCPhcMrKol9WXaGQW8Cny9vu4e3bhGJODCn+dmFk/ekN7c7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714043179; c=relaxed/simple;
	bh=7MlyFh3idC/2fg0ESo5n3eeC4q0V5+E+zLSKJ2s9SHQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XI5c5Xp6Vv1nDaPnIHrxHQjw4dW47ScwbesD8499ZQTJv5d87P2BS61jVAxT6PvaOjcAQNzKamGkSKhxLCPSzpier6h1Tm2Vme4xDYqaj2fxZr2l9WqrydQSaBH4LpOXU77XoZH0cJlB7QjYIt5G+pRDd88a7kvfUY0a8IDMYb8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QA0+PpbW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47578C113CC;
	Thu, 25 Apr 2024 11:06:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714043179;
	bh=7MlyFh3idC/2fg0ESo5n3eeC4q0V5+E+zLSKJ2s9SHQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=QA0+PpbW+unPO/3OhxSkHI6SXnfE21R3j24oMVNz3bAvF54ZzOebzEUS3vW2THGU6
	 yqKI5qjU4V2gSKMbbC4qhAafnLYFVc5rp4GIKXauX7uNOXh3c67RS37Z6hIWUGAxft
	 jv8K4JKR22rGCexGrlU4QVcSEha90mZLn2/wX1PoSp7qwPN74pSgGg+RVAhJ29ahAL
	 7yrinZjLs8Q6EYVXYVYvY4wIMNUieIPlJuzakSSur8IuzJqBo+8BJVOujTxVKTVVdy
	 NHK/f4KxFKiXuX8gHbgFrvtr3eHmoeRF05v7kOJP3/Rv95aljDMalLRJSjUs5vYVJD
	 z3T0koqHw3r6g==
Date: Thu, 25 Apr 2024 13:06:13 +0200
From: Alexey Gladkov <legion@kernel.org>
To: Helge Deller <deller@gmx.de>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	LKML <linux-kernel@vger.kernel.org>, kbd@lists.linux.dev,
	linux-api@vger.kernel.org, linux-fbdev@vger.kernel.org,
	linux-serial@vger.kernel.org
Subject: Re: [PATCH v5 2/3] VT: Add KDFONTINFO ioctl
Message-ID: <Zio5JfRBvzxuVUbX@example.org>
References: <cover.1712080158.git.legion@kernel.org>
 <cover.1713375378.git.legion@kernel.org>
 <bd2755e7b6ebe9b49e82d04d9908a176e0fe2f15.1713375378.git.legion@kernel.org>
 <9019dc74-35ad-43d7-8763-cea3da93e9c1@gmx.de>
 <ZiD50WZZv3OOad7L@example.org>
 <9993ad2d-48a8-43be-ae41-4b8d710c1ea7@gmx.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <9993ad2d-48a8-43be-ae41-4b8d710c1ea7@gmx.de>

On Thu, Apr 25, 2024 at 12:33:28PM +0200, Helge Deller wrote:
> >>> diff --git a/include/uapi/linux/kd.h b/include/uapi/linux/kd.h
> >>> index 8ddb2219a84b..68b715ad4d5c 100644
> >>> --- a/include/uapi/linux/kd.h
> >>> +++ b/include/uapi/linux/kd.h
> >>> @@ -185,6 +185,20 @@ struct console_font {
> >>>
> >>>    #define KD_FONT_FLAG_DONT_RECALC 	1	/* Don't recalculate hw charcell size [compat] */
> >>>
> >>> +/* font information */
> >>> +
> >>> +#define KD_FONT_INFO_FLAG_LOW_SIZE	_BITUL(0) /* 256 */
> >>> +#define KD_FONT_INFO_FLAG_HIGH_SIZE	_BITUL(1) /* 512 */
> >>
> >> Do we really need those bits?
> >> You set a default min/max font size in con_font_info() above,
> >> and all drivers can override those values.
> >> So, there are always min/max sizes available.
> >
> > These bits are not about the minimum and maximum glyph size, but about the
> > number of glyphs in the font.
> >
> > Maybe this is an overkill, but sticon has this check:
> >
> > if ((w < 6) || (h < 6) || (w > 32) || (h > 32) || (vpitch != 32)
> >      || (op->charcount != 256 && op->charcount != 512))
> >
> > [ to be honest, I don’t know why this driver doesn’t accept a glyph of
> > width 4 ]
> 
> I think there was no technical limitation when I added that.
> It's just that the font would be so small...

If so, then I can remove min_height/min_width from the ioctl structure.
And most likely the flags can also be left empty since at the moment all
drivers support 512.

> > I thought it would be worth fixing the maximum number of requirements in
> > the drivers since I started adding a new ioctl.
> 
> Ok.
> 
> Helge
> 

-- 
Rgrds, legion


