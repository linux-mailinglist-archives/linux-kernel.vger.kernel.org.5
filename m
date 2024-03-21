Return-Path: <linux-kernel+bounces-110682-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A216C886258
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 22:12:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 43285B23CAA
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 21:12:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3042D1384BC;
	Thu, 21 Mar 2024 21:10:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GJ1ev17A"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A7E8138495
	for <linux-kernel@vger.kernel.org>; Thu, 21 Mar 2024 21:10:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711055412; cv=none; b=fPqCwTb9k6IRFeRIAPZN1dunayaWjn3MoNu2sUcha6ZA+LpkKW1RRnyopuGcTUeuPoIyybbn4njbNYT3ozGZ7rn53wCBcO7tG83H6EV8RPbak2N9Nbt0tZfGufNpM3ydSiZR8I+AhC6NaOz7Jt+wFPqtFZqrn6z/5SQFCVHbVgY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711055412; c=relaxed/simple;
	bh=r4QzsgdLOgAe4d4LXFtb/qZ7qV+G01TLLBp7KPgVyCA=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=KLghEN28LXrY2m2PmLLy5v3jiCjCi8x6rJiL308n/4JOa28uFAGcqOpbjprZK/Ea78xcVONgsf52lLrnEb1iYC/YiaYVxUvKGQMZGnLoy2AlDuX0niSSCtCQgqu4/fxLuhbJ47eUu5Zp8Zh6JW+HfDyqF7oKgcVfQ+S1Qo+6hO4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GJ1ev17A; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 3E0F5C43390;
	Thu, 21 Mar 2024 21:10:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711055412;
	bh=r4QzsgdLOgAe4d4LXFtb/qZ7qV+G01TLLBp7KPgVyCA=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=GJ1ev17A0unXQBeomUTK4G2dx2iD69GM7JSe3p7fX+bjiZuG+xbaTCLzij9nheY6F
	 OwADUMIcfSDbWPvtZrI/YF6XdiuUNRLw1aS+omzXT0ec6Jy196oMTCs9EXvGQ9QGQX
	 ZZb+Xxily6BKwkhoUl3QZniLRE2sRj21vwbN3Dr+VONFPrjwt3ptS1MsqBYsU+/TEq
	 2m0H1mPcQ1s/gAJjvjLqeBF/ovxpNQjk4BXsocb8DGrMptudtQl0AIfvrF0bl+mpZK
	 dbtdjVIhwpXLRm9e9pxM3bpVtR2QUejlE4iboJ2jMRdy5P7IGvA9p6UXFG4mAAToWV
	 WqV8UtxoKGQKA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 3530BD8C720;
	Thu, 21 Mar 2024 21:10:12 +0000 (UTC)
Subject: Re: [GIT PULL] Driver core changes for 6.9-rc1
From: pr-tracker-bot@kernel.org
In-Reply-To: <Zfwvx6WFIVY-YW0Z@kroah.com>
References: <Zfwvx6WFIVY-YW0Z@kroah.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <Zfwvx6WFIVY-YW0Z@kroah.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/driver-core.git tags/driver-core-6.9-rc1
X-PR-Tracked-Commit-Id: 6aeb8850e0f39869d43768603a75c0431562a429
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 241590e5a1d1b6219c8d3045c167f2fbcc076cbb
Message-Id: <171105541221.8284.16291246562752649995.pr-tracker-bot@kernel.org>
Date: Thu, 21 Mar 2024 21:10:12 +0000
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org, Stephen Rothwell <sfr@canb.auug.org.au>, Saravana Kannan <saravanak@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Thu, 21 Mar 2024 14:01:59 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/driver-core.git tags/driver-core-6.9-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/241590e5a1d1b6219c8d3045c167f2fbcc076cbb

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

