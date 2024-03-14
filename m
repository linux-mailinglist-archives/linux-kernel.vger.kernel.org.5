Return-Path: <linux-kernel+bounces-103652-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D886287C27A
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 19:20:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6A6162856A7
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 18:20:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3ECDE74C1A;
	Thu, 14 Mar 2024 18:20:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kFcYiUhn"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8306774C14;
	Thu, 14 Mar 2024 18:20:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710440427; cv=none; b=Ey3BKorQD8esYDswP466AlRNWqbvJky9I3EpOTji7rVyqr5zJNYcjrnlZmjMNrUY2sU2TXDHlCuHDKzTRFzzIfARe86jeiPiSeCJK1b3B92OIT62dzvRaq2o2uQsn60tqNTFwf3TIQWEPh8NYqz5qW3jxNOKS1NiY6lPfuwRuV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710440427; c=relaxed/simple;
	bh=fwfoBdSO8malZWXE3votyGS7Cq/TkMRqxo+zv7Ju66Y=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=oLdtW6C8RgUyAzNBiQuoi8x1+/ddySzKaxUg/EC2T5WeByfB6fXcvfgicjiOaV9Qnh4+dDLpWWiyP43uV9WYewW9SwChg+qPCm6c0FK2nviGJou6X/lzAEpipxFwesCbM0Ynb3/SoAO28eHJxvPvcEfnipL2bzaAK4+RSd371n4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kFcYiUhn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 5D184C43390;
	Thu, 14 Mar 2024 18:20:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710440427;
	bh=fwfoBdSO8malZWXE3votyGS7Cq/TkMRqxo+zv7Ju66Y=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=kFcYiUhnfLLmT+vHR+FCMc8A+2P8GhryVhdAU5yDP/g9TWXG8IRD79jEvWTEuuZ/7
	 7Cj/McJa9Am0K4nvoilMfvC8eouAPFyjXd6DQHVCaO9AyFuLQZRd+m8+ZMa3wEGbVC
	 AvaoY7hQd/47dKI0/mXCRIj+tDBRWKUik3XwD6bbTZ8O/JGgZXj4OeO8NqU9j9tcfu
	 LB3zMM3PC35e7mwOMEWtr2y3F0bVmKmSmK2Z03bkL2WtPIVXo70hpGYrGRe63tjmEa
	 YUgq28cBUJeo7Q12vOSANvhc4GTfOtKVUzT5uszf0TEJlqJYsqxuUNXBSTHoohRddR
	 VSZ60K4VUPI1Q==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 55FD3D95055;
	Thu, 14 Mar 2024 18:20:27 +0000 (UTC)
Subject: Re: [GIT PULL] sound updates for 6.9-rc1
From: pr-tracker-bot@kernel.org
In-Reply-To: <874jd9m69o.wl-tiwai@suse.de>
References: <874jd9m69o.wl-tiwai@suse.de>
X-PR-Tracked-List-Id: <linux-sound.vger.kernel.org>
X-PR-Tracked-Message-Id: <874jd9m69o.wl-tiwai@suse.de>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound.git tags/sound-6.9-rc1
X-PR-Tracked-Commit-Id: a39d51ff1f52cd0b6fe7d379ac93bd8b4237d1b7
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: fe46a7dd189e25604716c03576d05ac8a5209743
Message-Id: <171044042734.24196.6958519905217855170.pr-tracker-bot@kernel.org>
Date: Thu, 14 Mar 2024 18:20:27 +0000
To: Takashi Iwai <tiwai@suse.de>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Linux Sound Mailing List <linux-sound@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Thu, 14 Mar 2024 11:56:03 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound.git tags/sound-6.9-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/fe46a7dd189e25604716c03576d05ac8a5209743

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

