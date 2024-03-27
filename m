Return-Path: <linux-kernel+bounces-120293-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 38DC288D56B
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 05:17:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B5C601F2EC02
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 04:17:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED1A6288B6;
	Wed, 27 Mar 2024 04:16:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GnlfFfiw"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B26C25570;
	Wed, 27 Mar 2024 04:16:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711513015; cv=none; b=AbBcF6Wa4c+7iITW6Z2NPWDpz1mldHbsQdP496UVWqKBEdhphZG4KiPDz9jbmvUDgPnr3q3LHoW9hFLMbKRdMa607FomjvA1Jd8mjPiu9Amil3hwqvSAyFNeLBPaUxO1BYvGmNTWZmDSk22/L7MdQ2EUN4G/Vp3QzQEfhoP1/io=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711513015; c=relaxed/simple;
	bh=n05MMmO+BSVxv1H0YbTNysNuJeKZRVi+Byqw6wJO4/s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CnplcqvLrrQcJDaShEX4Ig5sAfGziu/hyAUmKBiehYyO9DV5oEyxfRNwPyTehriqwywJJXg8CWkgqAvQFLF0OEfoRV3uqfE9AuppNr9asB7azOBeQ9dYloGHKNBPVijrVbT9SvHq1rp1MjN3FZnbhD7q5cjbLgPDdPcQjRY5UX4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GnlfFfiw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34217C43394;
	Wed, 27 Mar 2024 04:16:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711513014;
	bh=n05MMmO+BSVxv1H0YbTNysNuJeKZRVi+Byqw6wJO4/s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GnlfFfiwNaGrzktKGU1wr0NTgmkSrHqLFKN5h6bTaTcA/nbwMZhwC9u7zQjsJzm8d
	 lPSfewf9W7aX82qC9KCJxLe4hDxUT9xZwJIsncKIjL+bSCKgPI1vXWP6I12kqvxmlX
	 sRY4logGUEQxzfogVKV2/NqIXkmJSs+IGoEELTxuU5FuQAyDQH7H10CdKlynsLRDl0
	 QqAeFX+bNlhdhhrVM5lWmLWaz0fVKqoq0FuCM2Xeke4vlkgBCiq8g6QLANVeYyzAaw
	 2WtUiWSdEF47AsPRyPFK01f37NlezC84a1vc514fomksOuA9Abnf1lEB1z2gaFuKAF
	 WuLCO34Td6uTA==
Date: Tue, 26 Mar 2024 21:16:53 -0700
From: Eric Biggers <ebiggers@kernel.org>
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: Linux Next Mailing List <linux-next@vger.kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Jaegeuk Kim <jaegeuk@kernel.org>,
	Jens Wiklander <jens.wiklander@linaro.org>,
	Luis Chamberlain <mcgrof@kernel.org>,
	Richard Weinberger <richard@nod.at>, Theodore Ts'o <tytso@mit.edu>,
	Tyler Hicks <code@tyhicks.com>
Subject: Re: linux-next: trees being removed
Message-ID: <20240327041653.GA35281@sol.localdomain>
References: <20240327101309.4e7d04f3@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240327101309.4e7d04f3@canb.auug.org.au>

On Wed, Mar 27, 2024 at 10:13:09AM +1100, Stephen Rothwell wrote:
> The following trees are going to be removed from linux-next because they
> have not been updated in more than a year.  If you want a tree restored,
> just let me know (and update its branch).
> 
> Tree			Last commit date
>   URL
>   comits (if any)
> ----			----------------
> ecryptfs		2023-03-24 17:26:44 -0500
>   git://git.kernel.org/pub/scm/linux/kernel/git/tyhicks/ecryptfs.git#next
>   c1cc2db21607 ("ecryptfs: keystore: Fix typo 'the the' in comment")
>   a3d78fe3e1ae ("fs: ecryptfs: comment typo fix")
> fscrypt-current		2023-03-18 21:08:03 -0700
>   git://git.kernel.org/pub/scm/fs/fscrypt/linux.git#for-current
> fsverity-current	2023-03-15 22:50:41 -0700
>   git://git.kernel.org/pub/scm/fs/fsverity/linux.git#for-current
> modules-fixes		2023-02-06 08:45:55 -0800
>   git://git.kernel.org/pub/scm/linux/kernel/git/mcgrof/linux.git#modules-linus
> rtc-fixes		2023-01-23 23:33:47 +0100
>   git://git.kernel.org/pub/scm/linux/kernel/git/abelloni/linux.git#rtc-fixes
> tee-fixes		2023-02-12 14:10:17 -0800
>   https://git.linaro.org/people/jens.wiklander/linux-tee.git#fixes
> ubifs-fixes		2023-01-21 16:27:01 -0800
>   git://git.kernel.org/pub/scm/linux/kernel/git/rw/ubifs.git#fixes

fscrypt-current and fsverity-current are technically still in use.  I just
haven't used them recently because there haven't been any bug fixes that needed
to go in while other commits were already applied for the next merge window.

I've updated them to v6.9-rc1.

I'd guess that some of those *-fixes branches have something similar going on,
where they may be rarely used fixes branches as opposed to the main development
branch.

- Eric

