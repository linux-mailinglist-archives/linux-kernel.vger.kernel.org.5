Return-Path: <linux-kernel+bounces-166816-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CD898B9FE5
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 19:58:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BC3F72842FB
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 17:58:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20675173333;
	Thu,  2 May 2024 17:58:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="p7srR3ww"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6574517106F
	for <linux-kernel@vger.kernel.org>; Thu,  2 May 2024 17:57:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714672679; cv=none; b=jb/8rxxTxuQsj9BzIeGImCAZFVaDji+ZyCYdYGkX4PUG1VNsTBl1Fn7dhls02+oVenx2hjuuyfh5RPUOMKRDxLaFNBFPkVNJurOS/3ZLbeyfsMddOYuRxAkQGa0fRrg7t7k6vOuSekmvDq15vL0BWynwHhEv0DaMQq48LxK1mrU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714672679; c=relaxed/simple;
	bh=KLVhGIFlooj6nz1Bom82FvJA8mSj8Vyyu6Br3WzBaa8=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=e0P+1ZzqgKvtr0KSC5duPvPcgcN/DGYua6lt6mUu9WFlyhIidrAJfHfTVli7hy7UQ8swBAa2evQdiXu6uM4bqpOoLicnHuki097ge7Lkdtw1ycYDndH1ITHKA0ytWQmocSsQRFUcle07WuVKl4iqMtaFmduDDjMIh90k8MLFdR8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=p7srR3ww; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id E7FF6C116B1;
	Thu,  2 May 2024 17:57:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714672678;
	bh=KLVhGIFlooj6nz1Bom82FvJA8mSj8Vyyu6Br3WzBaa8=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=p7srR3wwtRc0sWCcqUDL8fszFOdr77p0nPsXZGT85a3cUORrWHErRvqfUokyDHoE9
	 5pb1VFoenUlYC787vhmNI41q/Jh827oH+U6Crcy72FL9sH7k0/MF7Ihm3tdKSK+32u
	 MMplOlEGsGqD3cLS4gKGgHc/8vO+PlET4iHlbGMM+/0XwfxrJ30BZTJ/erNS/tT4KW
	 6bc8N93qrb1jI7awAZvmWKnjBrjeoD5wwIlgMN/BLpXBy5IJ3fi00AW+Ry5kmhn+r3
	 QeXxWiLX06uqP45W61uKVJClMd8WvqJ2qcz4LT68uqZfZT1X9343Kif48op8mdl/Bn
	 G7EXPGHygaNrQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id DE2B3C43443;
	Thu,  2 May 2024 17:57:58 +0000 (UTC)
Subject: Re: [PULL 0/3] xtensa fixes for v6.9
From: pr-tracker-bot@kernel.org
In-Reply-To: <20240502122130.2863322-1-jcmvbkbc@gmail.com>
References: <20240502122130.2863322-1-jcmvbkbc@gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20240502122130.2863322-1-jcmvbkbc@gmail.com>
X-PR-Tracked-Remote: https://github.com/jcmvbkbc/linux-xtensa.git tags/xtensa-20240502
X-PR-Tracked-Commit-Id: b7cf2a1d9881823133acc48427815a48b35b49f4
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 09bf0f196fbca1a343fffa2099d8cf492ba78f3a
Message-Id: <171467267890.26516.5557735959806308625.pr-tracker-bot@kernel.org>
Date: Thu, 02 May 2024 17:57:58 +0000
To: Max Filippov <jcmvbkbc@gmail.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org, Chris Zankel <chris@zankel.net>, Max Filippov <jcmvbkbc@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Thu,  2 May 2024 05:21:30 -0700:

> https://github.com/jcmvbkbc/linux-xtensa.git tags/xtensa-20240502

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/09bf0f196fbca1a343fffa2099d8cf492ba78f3a

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

