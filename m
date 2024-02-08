Return-Path: <linux-kernel+bounces-58470-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 44C2384E6EB
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 18:39:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 00B301F28D7F
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 17:39:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC200823D3;
	Thu,  8 Feb 2024 17:39:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="evu3PttG"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E23E881AC7;
	Thu,  8 Feb 2024 17:39:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707413992; cv=none; b=SK65jOI3EB5hil01pJrTb4K5yzORwP3hzjURRYoCDTVeWedoqotlQzS0dfsH1I3gqCgBZAdZZ8eTcz7R6q7g6s/dP0WMAkGGdBpdSPXvlrRIb7tbUHSIqmAv0vnyrL2NWL37ciCd3nIn+DK9ZHzniyUDsEUujalC8S7GuFAxd0g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707413992; c=relaxed/simple;
	bh=BLDjJ38BnZgGooci7rpMBki3qE7Nq/vz2SqBaf8tDzo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=vGNXBmoX63GOGUUxIpKm81nuQCIXHYt8vfXESz+11kEVvf2cROEoz9Ig9rVwfrUP3TeCKHBc/24C8NjADRD+dE1STpBs7/+faYv+8HZoCddH7Oggm+D0O5yS1Z2Y+k1Q7gW87ImG0PzqwyD7Nz5R/KOaygNOV62L55+0apRT48c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=evu3PttG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9FDD5C433F1;
	Thu,  8 Feb 2024 17:39:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707413991;
	bh=BLDjJ38BnZgGooci7rpMBki3qE7Nq/vz2SqBaf8tDzo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=evu3PttGEh9Y3+sMHYBw5zY2o+8AYCpHi7kcwWD+iUEmOU66tGNvGHhzONA/z/VQD
	 xPwCZ1Bdu73J52OuSD2bS14V7TXl59l8ftSU3hBxAgg+ehoURWf9eqxMmHQfKDFPem
	 DArgkB3rP0JsXuLh+amoeGLfuFpyft16yQ8ovJSEynbd2Eci4YUFs88M47V0J80+4H
	 7Ih0n2ADy6Zt6BGdAHdmEGjxPBnUOWgbMK/EvVuh7XxB3uBUrxmX9hnYoyX8oOdwPE
	 4UuUdBEQ7fEwTFxwRkEVfi8GqqKqgrvK5X4aMtNdf+GsWY3kGxQhfkm/F5XfEmI5Yc
	 2y40d2hUtXACA==
Date: Thu, 8 Feb 2024 17:39:46 +0000
From: Lee Jones <lee@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Flavio Suligoi <f.suligoi@asem.it>, dri-devel@lists.freedesktop.org,
	linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	Daniel Thompson <daniel.thompson@linaro.org>,
	Jingoo Han <jingoohan1@gmail.com>, Helge Deller <deller@gmx.de>
Subject: Re: [PATCH v2 0/3] backlight: mp3309c: Allow to use on non-OF
 platforms
Message-ID: <20240208173946.GX689448@google.com>
References: <20240201151537.367218-1-andriy.shevchenko@linux.intel.com>
 <20240208113425.GK689448@google.com>
 <ZcUMMyV_vBTNw8Rz@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZcUMMyV_vBTNw8Rz@smile.fi.intel.com>

On Thu, 08 Feb 2024, Andy Shevchenko wrote:

> On Thu, Feb 08, 2024 at 11:34:25AM +0000, Lee Jones wrote:
> > On Thu, 01 Feb 2024, Andy Shevchenko wrote:
> 
> ...
> 
> > >   backlight: mp3309c: Utilise temporary variable for struct device
> 
> (1)
> 
> > Set no longer applies.  Please rebase, thanks.
> 
> I got a contradictory messages:
> 1) email that says that all had been applied;
> 2) this email (that tells the complete opposite);
> 3) the repository where the first two were applied.
> 
> While you can amend your scripts, I think I need to rebase only the last patch

This is what I assume happened:

1. Attempted to apply the set (as a set)
2. 2 commits applied cleanly
3. The final commit conflicted
4. I sent you a message to say that the set failed to apply
5. *** I forgot to remove the 2 successful patches ***
6. I applied another patch
7. b4 noticed the 2 patches that were applied and thanked you for them
8. *** I didn't notice that those tys were sent ***

No need to update the scripts. :)

> (1) that may not be found in your tree currently.

I'm going to remove the other ones now.  Please submit the set.

-- 
Lee Jones [李琼斯]

