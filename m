Return-Path: <linux-kernel+bounces-69989-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 38D7C85915B
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Feb 2024 18:40:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6C1751C21012
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Feb 2024 17:40:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 050E67E582;
	Sat, 17 Feb 2024 17:40:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M25PZnOt"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F9327E0F0
	for <linux-kernel@vger.kernel.org>; Sat, 17 Feb 2024 17:40:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708191610; cv=none; b=ipqDAhw6gNZulFuC+PvTD+su4Fwvl0gFTTJ6iTuuLwdCme1/+OeVuazLOBdo5sgEq4gZt5KM2kjSe7wQnAXHefRuFB2R0bufYY9/1Gm+l2+6T+5g7zxAx89iYomGtyU5BA2+tRTYNnjhsVYfRsKm7sqrbziDPs5xZZ3p+EUZl18=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708191610; c=relaxed/simple;
	bh=MCwoo9YAJWVS7J4+prl3UuP56xcsSJvJSDwnvPHonj8=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=P9ZN9Hbvj7nLQ8BOCGVm986MN5h7JXMPp2zCBgCCyoBupm/fDx7jGbA14CKFTe8Y8y0OujevF1/GLnxr/F5WSCbdxEYjG8nrUwfdEEbuB+7p5RBbEUTJoEXw02UJN/pGqSccjymVCNbNZuNJlZVnj2nkZtAldw4jq7hPMTgXa58=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M25PZnOt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 098ACC43394;
	Sat, 17 Feb 2024 17:40:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708191610;
	bh=MCwoo9YAJWVS7J4+prl3UuP56xcsSJvJSDwnvPHonj8=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=M25PZnOtUo5oQ7iVHvUp+del9IzhxATJV244UtvQwQVQNppK2Kbv+h2RJ6MEMQiTz
	 KKw31suI++5yGQQsJvumGD07JyWA6UKPMdXoKZ2ClTH4mSnIi++0gU/zNos2rgGpuc
	 tgL9vwOqlisjgwleYVLTK8shvLtkWzC+5pp6y9zv6Jxr11r2xDQL5gB5ITQS8HT1DD
	 xjnkwRv7fgWBfYETgIgTna6sV2RZhRheTYnuQQy7EgASmAMONndAQpeWxfISjD3Y3I
	 kWrxhWhGkCeujwsdztIHovOAAMLJS71iO92IsZpoJaQ5JzPW6Nx74QxmwVdqUOLwjI
	 ZoI/j3QDPyE7A==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id D6301C04E24;
	Sat, 17 Feb 2024 17:40:09 +0000 (UTC)
Subject: Re: [GIT PULL] Driver core fixes for 6.8-rc5
From: pr-tracker-bot@kernel.org
In-Reply-To: <ZdDNSRgtgUoosT7Q@kroah.com>
References: <ZdDNSRgtgUoosT7Q@kroah.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <ZdDNSRgtgUoosT7Q@kroah.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/driver-core.git tags/driver-core-6.8-rc5
X-PR-Tracked-Commit-Id: 5928d411557ec5d53832cdd39fc443704a3e5b77
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: ced59052315615ffb3c39eb96e7b33f2cff6f781
Message-Id: <170819160986.11002.10552259114480208637.pr-tracker-bot@kernel.org>
Date: Sat, 17 Feb 2024 17:40:09 +0000
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org, Stephen Rothwell <sfr@canb.auug.org.au>, Saravana Kannan <saravanak@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Sat, 17 Feb 2024 16:14:17 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/driver-core.git tags/driver-core-6.8-rc5

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/ced59052315615ffb3c39eb96e7b33f2cff6f781

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

