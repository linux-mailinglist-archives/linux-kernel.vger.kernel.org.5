Return-Path: <linux-kernel+bounces-109479-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 12CDF881A0E
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 00:04:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A5D7F1F220C6
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 23:04:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C68C86122;
	Wed, 20 Mar 2024 23:04:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="roc24Lvw"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D0C86BFDB;
	Wed, 20 Mar 2024 23:04:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710975846; cv=none; b=DAq3SX9H0wksFV4h/Q45bC3GxJkZuM2nNK3lJ63/IKAfO1f9Xf98zwYHkycNGRy8mUAPSN5gbVVnyjWDYxt6VSzBe6mq9ZzySWZ1yVUZkyW+QXI9o/fUB3+Oul5WySaO8JDUG+jMh4Su4xUWTnJqxUXVz/4vs+M3JhF92sJ0ZJc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710975846; c=relaxed/simple;
	bh=TAatzuWm2HqdQG4JY+l9UJF3GxwuF/jivevfBscvcfo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kHGlG6Ec7KepFlH6jsLH14g8k2j7/SuUUZoY71Z5kUg6ISj6kcDsBf6HsUssOTcyWkoXJU8iUBFFrPHLPmRbgcNLRLtDa31VhLkov4tIg8kdqvoOlKZbMV8mPckjvEwoXmYtsB3SBuJbiXU6vbe2G4544qgw9mtl1Xj2nHoyJkw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=roc24Lvw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB7FAC433C7;
	Wed, 20 Mar 2024 23:04:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710975845;
	bh=TAatzuWm2HqdQG4JY+l9UJF3GxwuF/jivevfBscvcfo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=roc24LvwLgx0Gqc1wJS8R1OwkBVs4boegh5+XPMJyOSDy3nA0AVEjTf6WduCcgia5
	 TNW9ZfHGtlNNVV/bA41xqcYh0cfu+1eZZVP7adotwqzDypRwE6Uuwfhl3FVFj+k4Oc
	 NyN0x4Zi4Bk02+i8YNGOUww/CK0h+xJMHjO3z9Qjx32T669GrYEirhD5eqE4LsYFBf
	 2Xw/UQfdc+tntAecpHbeEECqqSOWv8BTes3Qv8NM5zfblDt2J0UmR4+yKQjAD1ylJp
	 +nr70e+N/N26LWZeXr6AiSpFFc++gYedARii3oRUGw4mq9KNmR3nsvS0PxsmKQYC9Z
	 bCaebnnTILsQA==
Date: Wed, 20 Mar 2024 18:12:46 -0400
From: Sasha Levin <sashal@kernel.org>
To: Pavel Machek <pavel@denx.de>
Cc: josef@toxicpanda.com, dsterba@suse.com, gregkh@linuxfoundation.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org,
	torvalds@linux-foundation.org, akpm@linux-foundation.org,
	linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
	lkft-triage@lists.linaro.org
Subject: Re: btrfs fix missing in 5.10-stable was Re: [PATCH 5.10 00/73]
 5.10.213-rc1 review
Message-ID: <ZftfXuwvpNVggouB@sashalap>
References: <20240313164640.616049-1-sashal@kernel.org>
 <ZfroJoVIz3dBrO1t@duo.ucw.cz>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <ZfroJoVIz3dBrO1t@duo.ucw.cz>

On Wed, Mar 20, 2024 at 02:44:06PM +0100, Pavel Machek wrote:
>Hi!
>
>> This is the start of the stable review cycle for the 5.10.213 release.
>> There are 73 patches in this series, all will be posted as a response
>> to this one.  If anyone has any issues with these being applied, please
>> let me know.
>
>While debugging "search for known-bad commit" script, I noticed:
>
>We have
>
>41b3cc57d626d c2e39305299f0 btrfs: clear extent buffer uptodate when
>we fail to write it
>
>commit in 5.10, which is fixed by this, but we don't have that one:
>
>651740a502411 btrfs: check WRITE_ERR when trying to read an extent
>buffer

Hey Pavel,

There are two reasons it didn't make it into 5.10 or 5.4:

1. It doesn't build on any of those kernels, and we haven't gotten a
backport we could apply.

2. There's a follow-up fix that happened soon after ( 40cdc509877b
("btrfs: skip reserved bytes warning on unmount after log cleanup
failure") ) which needs a backport on it's own.


-- 
Thanks,
Sasha

