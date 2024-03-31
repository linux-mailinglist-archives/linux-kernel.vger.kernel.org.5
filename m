Return-Path: <linux-kernel+bounces-126342-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A86A89355A
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Mar 2024 20:21:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 451DB1C214A2
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Mar 2024 18:21:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF3AF146583;
	Sun, 31 Mar 2024 18:20:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LdUfmhgV"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12104145B21
	for <linux-kernel@vger.kernel.org>; Sun, 31 Mar 2024 18:20:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711909251; cv=none; b=p4nyYp9KrsXC0udDraAzb2fAMNsNhtJ7ZfzRrUJhq6J+GmjhbpFZghFUhoLYStrZMZ9P/5cnVR3netulWR6Qyf3VbiTHxRRUJWi8h8MCqEZcS+rNKVy77HPKysq9AmfVxdwbr0RfuL766gJ2TtdBbsQh0tZpHfxyAb0ui8LrKzg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711909251; c=relaxed/simple;
	bh=XI8AXfCGcBalU8MTYL44g5rkivbNDHJ1Y/mW/fPiExM=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=gUWFWyWE5nu5/3MwIB6Q7r1FBUnk6aWVsudQPkADT0yjY07EL7I6B1M5SR+97COGMPTouAyT1kpDNrIq9G8pErlMMk6WXrjFQBziEYgpdqrZnbvmrowLYBwdADSrbAZHuXZWAGmWPl7Qen4N7ySbOxgf6xL7DL+TXL8eCoScmKs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LdUfmhgV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id DF27CC43394;
	Sun, 31 Mar 2024 18:20:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711909250;
	bh=XI8AXfCGcBalU8MTYL44g5rkivbNDHJ1Y/mW/fPiExM=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=LdUfmhgV6TwjGIAjW6n86sr0bI1HpGv4+851eigZfMCfWXURmu2JvnWDI4FrRD10e
	 RmuPYbSdFWFV5c6WBcm6eyxnoMikQ7xgs8Ex3RD64PKoj2Muy8bDF1/JY65JPxGATA
	 b0Re2sXXZ7xjvkHBvLGHeQM9kGn/ph8FfeON2/1EakJhOnEIJZaXUKGMHDt6igRx2o
	 BOGKZtzoSry8gR0ZZMAVWudS81SM4MhnDoE0+juOs5uid6aKC/+KK0FZ2Ob5jRayYQ
	 fVhJfZ6pnHZzx3/0mdeE7FGKrqNFVRvDEiH7P1uD8/48vPRfeJSKvS7mi6NuojzZlk
	 8FovJMFgcSzOg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id D4433D8BCE4;
	Sun, 31 Mar 2024 18:20:50 +0000 (UTC)
Subject: Re: [GIT PULL] timers/urgent for v6.9-rc2
From: pr-tracker-bot@kernel.org
In-Reply-To: <20240331103027.GAZgk7Q5vR6nlYkmm8@fat_crate.local>
References: <20240331103027.GAZgk7Q5vR6nlYkmm8@fat_crate.local>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20240331103027.GAZgk7Q5vR6nlYkmm8@fat_crate.local>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/timers_urgent_for_v6.9_rc2
X-PR-Tracked-Commit-Id: 1fed2f1ea62aa79e8c1df79b26e5bf5c8cf45065
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 8d338df72d53eaf1b7c10177c0bc7229b15df2b5
Message-Id: <171190925086.27603.13989123261411064232.pr-tracker-bot@kernel.org>
Date: Sun, 31 Mar 2024 18:20:50 +0000
To: Borislav Petkov <bp@alien8.de>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Sun, 31 Mar 2024 12:30:27 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/timers_urgent_for_v6.9_rc2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/8d338df72d53eaf1b7c10177c0bc7229b15df2b5

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

