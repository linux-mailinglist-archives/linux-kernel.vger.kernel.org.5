Return-Path: <linux-kernel+bounces-60453-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E5275850520
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Feb 2024 17:26:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A53B928318B
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Feb 2024 16:26:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0C045C5F5;
	Sat, 10 Feb 2024 16:26:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hGWyfqwC"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E985D5C5EB
	for <linux-kernel@vger.kernel.org>; Sat, 10 Feb 2024 16:26:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707582373; cv=none; b=qP+F0zrviSt4F9QgtUpJ7m8xyA8+n+cW7nXOywt+IRhAOyZZWC+NfCKmMRUWcw+OgKaW5Dghhd78OdLTTafQvJRmapsgLbXvi1pMnxfkxytgBgO1QMZlE7h8GLoW7JMd1wQ2DxFjz+q10B2Vg+6dhMgQM5w42BoY6ng8a6qtZro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707582373; c=relaxed/simple;
	bh=zMfewQCuU/lPe9EpBkYjoo4h4fQQMyT2b2HoIEwE2UA=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=i7Cw1LgDFbflDcEB+hEguCfeLyYPSqjYo6BWkHBevl8jChyXSxY1E6QbgUOM0LPXwGlpS/0GqEEa+In/E5Mwk94KvWHFK4xkTP2S61gHLXwWmj6YZcOKH+esXodvzWSIusalEA0ULl6wgZnXwZRwRIkIXiEXwuL+cT4DxxT3Mok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hGWyfqwC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 6E6ECC43390;
	Sat, 10 Feb 2024 16:26:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707582372;
	bh=zMfewQCuU/lPe9EpBkYjoo4h4fQQMyT2b2HoIEwE2UA=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=hGWyfqwCdSS7KGVx0YhJygX0K/dUCJrm76ZQ88L5b2ZJ//ws+63pK+CKHeUag/xo8
	 jFHp+iLxETzkS2AnlriWogL0HlGe7juJ3qi0o/go0NBZTEaoaZbri/sNN0MhM6eJx9
	 eRu5AW+ab49YXC82OyiGIRRwHYkv8v2gSdtsgGVMdF57LTEy6tPJE+g9x79ELhPF6X
	 l3vQdPvr0j0HlwP7VElk34xRusBvz6hYGFeGPM0X4yPPLWVffmIQh6fjcMpyk0rfFF
	 wdCy7RFS6PZO/xJseEKYPGvu9oqGA2wKSkrZ3ppJrY/pHz0bYDIcH9GxfRyYfRfwGD
	 6fFBBxUFYPcNg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 57C20C395F1;
	Sat, 10 Feb 2024 16:26:12 +0000 (UTC)
Subject: Re: [GIT PULL] firewire fixes for v6.8-rc4
From: pr-tracker-bot@kernel.org
In-Reply-To: <20240210114823.GA114914@workstation.local>
References: <20240210114823.GA114914@workstation.local>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20240210114823.GA114914@workstation.local>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/ieee1394/linux1394.git tags/firewire-fixes-6.8-rc4
X-PR-Tracked-Commit-Id: 7ed4380009e96d9e9c605e12822e987b35b05648
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: a38ff5bbf9799dd944c762412aaebc54818407f5
Message-Id: <170758237234.1913.7759473988604976472.pr-tracker-bot@kernel.org>
Date: Sat, 10 Feb 2024 16:26:12 +0000
To: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Cc: torvalds@linux-foundation.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Sat, 10 Feb 2024 20:48:23 +0900:

> git://git.kernel.org/pub/scm/linux/kernel/git/ieee1394/linux1394.git tags/firewire-fixes-6.8-rc4

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/a38ff5bbf9799dd944c762412aaebc54818407f5

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

