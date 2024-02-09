Return-Path: <linux-kernel+bounces-59088-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 70A1484F10E
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 08:51:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F071A1F226C1
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 07:51:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7A4065BA9;
	Fri,  9 Feb 2024 07:50:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lnPUwN+N"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22BE365BA4;
	Fri,  9 Feb 2024 07:50:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707465058; cv=none; b=dbKbO8yGzX1szZ8NbG7pSvbKVJhkidWhWk1eOTM6tfDDgKQnKXsKAtIXyl5SMDdfR1Xmv5keyY134lQsPqlGMBrw/mJ6X1c72TyuDvBADI7WcTT/8feJnCTsSHKOeightoCe2oyxuC8tYAhsVquAKtDiJDGZRouMp0pmMIxhAVU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707465058; c=relaxed/simple;
	bh=4P6Q65OM5G13zMp416D3cDinlUrcM6b83+wzrToei0M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Xvi36v+myxiIako4urLW67sBqGZgku7WqLqqh7HU6HoKZaiKP7VGOxDVkjr+GlUF5eAm+moTFZjrmqMVOoMt8IPOUhvZ4rDPIcYkw0fN78NC+2PF7QQvbhmnmCCLgNG1ES2O/fkRCWWY5nQ9HeLdIZqOKhj5yCGDrTIB5garGzg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lnPUwN+N; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D91CDC433F1;
	Fri,  9 Feb 2024 07:50:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707465057;
	bh=4P6Q65OM5G13zMp416D3cDinlUrcM6b83+wzrToei0M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lnPUwN+N4dSqR1G2m4/Shb6BfsucY08qgzOFcXugXnckCcVdvF1wGZ0aILmxTOMsM
	 C56jh6Jw+CakVwpePLel2TaWMoasjS/C5oqvus9tzKaHiA6L7taFAv1I5i6u807TVR
	 90hYAIoQbOYugq8Ay1h/66+tVpfx4BMx2p2BVX55eavp98uoH0SxpiU8L1+AUsyfl0
	 sMenFXiE/i9Tt/wyf0vgE4o7czT0/aEAbnlUpAIUIMynHFOWgLVZWMRScY+qG1lhnz
	 QqHCuoHfOAlJYzoZSmy6Cowr+AVOiZF2a/7voIyUlS7aEYvEznJhP8c837/SyF/oVw
	 cmewdN5M7vZhQ==
Date: Fri, 9 Feb 2024 07:50:52 +0000
From: Lee Jones <lee@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Flavio Suligoi <f.suligoi@asem.it>, dri-devel@lists.freedesktop.org,
	linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	Daniel Thompson <daniel.thompson@linaro.org>,
	Jingoo Han <jingoohan1@gmail.com>, Helge Deller <deller@gmx.de>
Subject: Re: [PATCH v2 0/3] backlight: mp3309c: Allow to use on non-OF
 platforms
Message-ID: <20240209075052.GB689448@google.com>
References: <20240201151537.367218-1-andriy.shevchenko@linux.intel.com>
 <20240208113425.GK689448@google.com>
 <ZcUMMyV_vBTNw8Rz@smile.fi.intel.com>
 <20240208173946.GX689448@google.com>
 <ZcUYZRDVmHhKQu9j@smile.fi.intel.com>
 <20240208181455.GA689448@google.com>
 <ZcUcRlcQmQG4s42k@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZcUcRlcQmQG4s42k@smile.fi.intel.com>

On Thu, 08 Feb 2024, Andy Shevchenko wrote:

> On Thu, Feb 08, 2024 at 06:14:55PM +0000, Lee Jones wrote:
> > On Thu, 08 Feb 2024, Andy Shevchenko wrote:
> > > On Thu, Feb 08, 2024 at 05:39:46PM +0000, Lee Jones wrote:
> > > > On Thu, 08 Feb 2024, Andy Shevchenko wrote:
> > > > > On Thu, Feb 08, 2024 at 11:34:25AM +0000, Lee Jones wrote:
> > > > > > On Thu, 01 Feb 2024, Andy Shevchenko wrote:
> 
> ...
> 
> > > > > > >   backlight: mp3309c: Utilise temporary variable for struct device
> > > > > 
> > > > > (1)
> > > > > 
> > > > > > Set no longer applies.  Please rebase, thanks.
> > > > > 
> > > > > I got a contradictory messages:
> > > > > 1) email that says that all had been applied;
> > > > > 2) this email (that tells the complete opposite);
> > > > > 3) the repository where the first two were applied.
> > > > > 
> > > > > While you can amend your scripts, I think I need to rebase only the last patch
> > > > 
> > > > This is what I assume happened:
> > > > 
> > > > 1. Attempted to apply the set (as a set)
> > > > 2. 2 commits applied cleanly
> > > > 3. The final commit conflicted
> > > 
> > > Which is really strange. I have just applied (with b4) on top of your changes
> > > and no complains so far.
> > > 
> > > $ git am ./v2_20240201_andriy_shevchenko_backlight_mp3309c_allow_to_use_on_non_of_platforms.mbx
> > > Applying: backlight: mp3309c: Make use of device properties
> > > Applying: backlight: mp3309c: use dev_err_probe() instead of dev_err()
> > > Applying: backlight: mp3309c: Utilise temporary variable for struct device
> > > 
> > > Can you show what b4 tells you about this?
> > 
> > Fetching patch(es)
> > Analyzing 14 messages in the thread
> > Checking attestation on all messages, may take a moment...
> > ---
> >   ✓ [PATCH v2 1/3] backlight: mp3309c: Make use of device properties
> >     + Reviewed-by: Daniel Thompson <daniel.thompson@linaro.org> (✓ DKIM/linaro.org)
> >     + Link: https://lore.kernel.org/r/20240201151537.367218-2-andriy.shevchenko@linux.intel.com
> >     + Signed-off-by: Lee Jones <lee@kernel.org>
> >   ✓ [PATCH v2 2/3] backlight: mp3309c: use dev_err_probe() instead of dev_err()
> >     + Tested-by: Flavio Suligoi <f.suligoi@asem.it> (✗ DKIM/asem.it)
> >     + Reviewed-by: Daniel Thompson <daniel.thompson@linaro.org> (✓ DKIM/linaro.org)
> >     + Link: https://lore.kernel.org/r/20240201151537.367218-3-andriy.shevchenko@linux.intel.com
> >     + Signed-off-by: Lee Jones <lee@kernel.org>
> >   ✓ [PATCH v2 3/3] backlight: mp3309c: Utilise temporary variable for struct device
> >     + Link: https://lore.kernel.org/r/20240201151537.367218-4-andriy.shevchenko@linux.intel.com
> >     + Signed-off-by: Lee Jones <lee@kernel.org>
> >   ---
> >   ✓ Signed: DKIM/intel.com (From: andriy.shevchenko@linux.intel.com)
> > ---
> > Total patches: 3
> > Prepared a fake commit range for 3-way merge (672ecc5199b5..d507b9f4c5b9)
> > ---
> >  Link: https://lore.kernel.org/r/20240201151537.367218-1-andriy.shevchenko@linux.intel.com
> >  Base: not specified
> > 
> > Running through checkpatch.pl
> > total: 0 errors, 0 warnings, 103 lines checked
> > 
> > "[PATCH v2 1/3] backlight: mp3309c: Make use of device properties" has no obvious style problems and is ready for submission.
> > total: 0 errors, 0 warnings, 41 lines checked
> > 
> > "[PATCH v2 2/3] backlight: mp3309c: use dev_err_probe() instead of" has no obvious style problems and is ready for submission.
> > total: 0 errors, 0 warnings, 81 lines checked
> > 
> > "[PATCH v2 3/3] backlight: mp3309c: Utilise temporary variable for" has no obvious style problems and is ready for submission.
> > 
> > Check the results (hit return to continue or Ctrl+c to exit)
> > 
> > 
> > Applying patch(es)
> > Applying: backlight: mp3309c: Make use of device properties
> > Applying: backlight: mp3309c: use dev_err_probe() instead of dev_err()
> > Applying: backlight: mp3309c: Utilise temporary variable for struct device
> > Using index info to reconstruct a base tree...
> > M	drivers/video/backlight/mp3309c.c
> > Checking patch drivers/video/backlight/mp3309c.c...
> > Applied patch drivers/video/backlight/mp3309c.c cleanly.
> > Falling back to patching base and 3-way merge...
> > error: Your local changes to the following files would be overwritten by merge:
> > 	drivers/video/backlight/mp3309c.c
> > Please commit your changes or stash them before you merge.
> > Aborting
> > error: Failed to merge in the changes.
> > Patch failed at 0003 backlight: mp3309c: Utilise temporary variable for struct device
> > hint: Use 'git am --show-current-patch=diff' to see the failed patch
> > When you have resolved this problem, run "git am --continue".
> > If you prefer to skip this patch, run "git am --skip" instead.
> > To restore the original branch and stop patching, run "git am --abort".
> 
> Thank you!
> 
> It seems I have reduced context, so if you do `git am -C2 ...` it should apply.
> Never mind, I'll send a new version which should work with -C3.

I just use the default matching context lines.

Do you have a special config that reduces you context in patches?

-- 
Lee Jones [李琼斯]

