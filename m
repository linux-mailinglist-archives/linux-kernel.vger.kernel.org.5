Return-Path: <linux-kernel+bounces-37287-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DF9C83ADC2
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 16:51:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B014E28CA44
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 15:51:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 333547C0B3;
	Wed, 24 Jan 2024 15:50:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="roqsoZzU"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75E0B40C1B;
	Wed, 24 Jan 2024 15:50:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706111453; cv=none; b=nWyLBTMjwFVZpNt2mLJ6qR23XY/Krw54kuO0EmfQUqp9YHBV8A6SGvSc90h1QUamM6RsDPQfJTQ+1ZRI7RwhKWjzxfd86aNMnj7Ih9JImu/B+77/2vKIZI7JXwsuYA5h6GRZOr15IzAlzB9a71kzOXBN/WTNNfdpXeD3c0B2Ypg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706111453; c=relaxed/simple;
	bh=+KGnq5xhZfux8mPndMDUbCACV0/9DWPx0zZEPoA/AyA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Qsy5DpjZ6gemMspLlZmrg8u9gWKs3s7rPao1Lpky2VLKsWpSzII8WmTxhmLi1BLPEvm91xSWHPMBoU4ciUHpbBdR2KDYySAQRo5V3Py4UIKHRHFvuWhxK41IMBYZqkLtuv2dEYROqapaIXrWdRvjpzzWx7/cmFYKGwwJOxpNF6c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=roqsoZzU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 320D5C433F1;
	Wed, 24 Jan 2024 15:50:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706111452;
	bh=+KGnq5xhZfux8mPndMDUbCACV0/9DWPx0zZEPoA/AyA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=roqsoZzUwrBCx6VpNHxpyMprPpNLzWwNxaC8J1QmWfTgfiPdVzTPZ7UERyMuvEju8
	 99NeRN/IW5xwDBI0dLBIpnPTBDqi4t1vVVDhMnkxvL8kcEp7Avs86EqcXsJVj07AG9
	 vEavvGENuv0YXcGwqG10PnFwaGWuibb+OfOhaDK0CDZq0AnkprMfFYpVUHIE6CWZW0
	 JsqscjfUejpb0p5aPEC4S6DxbgtRA1tSuQxPOAefieY1vkRC4CwwbhYQs8Z5wZwqeG
	 kgF7goIjeG2ZWbPCfXndgxJDn4ZuCk+HFQXQMJrd2o29lDH3SmUkXZ1L6s267QH/Mv
	 V69aCB1brVKqg==
Date: Wed, 24 Jan 2024 15:50:46 +0000
From: Lee Jones <lee@kernel.org>
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: Linux Next Mailing List <linux-next@vger.kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	David Miller <davem@davemloft.net>,
	"Eric W. Biederman" <ebiederm@xmission.com>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Hector Martin <marcan@marcan.st>,
	"Jason A. Donenfeld" <Jason@zx2c4.com>,
	Jean Delvare <jdelvare@suse.de>,
	Micah Morton <mortonm@chromium.org>,
	Mike Marshall <hubcap@omnibond.com>, Pavel Machek <pavel@ucw.cz>,
	Theodore Ts'o <tytso@mit.edu>
Subject: Re: linux-next: trees being removed
Message-ID: <20240124155046.GB74950@google.com>
References: <20240124130101.428c09a3@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240124130101.428c09a3@canb.auug.org.au>

On Wed, 24 Jan 2024, Stephen Rothwell wrote:

> The following trees are going to be removed from linux-next because they
> have not been updated in more than a year.  If you want a tree restored,
> just let me know (and update its branch).
> 
> Tree			Last commit date
>   URL
>   commits (if any)
> -----------------------------------------
> asahi-soc-fixes		2022-08-14 15:50:18 -0700
>   https://github.com/AsahiLinux/linux.git#asahi-soc/fixes
> backlight-fixes		2023-01-01 13:53:16 -0800
>   git://git.kernel.org/pub/scm/linux/kernel/git/lee/backlight.git#for-backlight-fixes

This is still active, when it's needed.

> broadcom-fixes		2022-10-16 15:36:24 -0700
>   https://github.com/Broadcom/stblinux.git#fixes
> dmi			2022-09-23 14:53:14 +0200
>   git://git.kernel.org/pub/scm/linux/kernel/git/jdelvare/staging.git#dmi-for-next
> leds			2022-12-25 13:41:39 -0800
>   git://git.kernel.org/pub/scm/linux/kernel/git/pavel/linux-leds.git#for-next
> mfd-fixes		2023-01-01 13:53:16 -0800
>   git://git.kernel.org/pub/scm/linux/kernel/git/lee/mfd.git#for-mfd-fixes

As is this one.

I'll update them both now if it helps.

> orangefs		2022-12-07 15:18:30 -0500
>   git://git.kernel.org/pub/scm/linux/kernel/git/hubcap/linux#for-next
> random			2023-01-04 12:11:29 -0800
>   git://git.kernel.org/pub/scm/linux/kernel/git/crng/random.git#master
> safesetid		2022-07-15 18:24:42 +0000
>   https://github.com/micah-morton/linux.git#safesetid-next
> sparc			2022-09-30 11:58:23 +0100
>   git://git.kernel.org/pub/scm/linux/kernel/git/davem/sparc.git#master
>   2d2b17d08bfc ("sparc: Unbreak the build")
>   (This commit has been included in Linus' tree as part of another commit)
> userns			2022-11-30 12:54:24 -0600
>   git://git.kernel.org/pub/scm/linux/kernel/git/ebiederm/user-namespace.git#for-next
>   54e1011bd95a ("sysctl: Allow change system v ipc sysctls inside ipc namespace")
>   f9b90c2062b2 ("docs: Add information about ipc sysctls limitations")
>   7608b6a72ed0 ("sysctl: Allow to change limits for posix messages queues")
>   a799be9bafe3 ("ipc/ipc_sysctl: Add missing include of linux/cred.h")
>   b895e6689ebf ("sysctl: Fix mq permission check")
>   295227b10192 ("ucount: Fix atomic_long_inc_below argument type")
>   b4b11b58cd02 ("ucount: Use atomic_long_try_cmpxchg in atomic_long_inc_below")
>   (only these last 2 commits actually change anything in Linus' tree)
> 
> -- 
> Cheers,
> Stephen Rothwell



-- 
Lee Jones [李琼斯]

