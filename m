Return-Path: <linux-kernel+bounces-139335-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D28A08A0188
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 22:55:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 100F91C23280
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 20:55:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A118181D0E;
	Wed, 10 Apr 2024 20:55:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HMqBxNSU"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B2E7181CF8;
	Wed, 10 Apr 2024 20:55:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712782530; cv=none; b=VMH6to5xKUVH13qtO8ms4C0xkmkxNXsVnFG92pk/FVDClslkTqaOHxs5uvz0VtzDwX2kRmU/ZCxoH05dsjMtc6F4+P/a4hL5rXRRwtnfHrORq8D4zymBTYoUPAgZdOO9bG0Agani54B8uumM3m2+y86OZDNLI8NEiDj0uDgwXOA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712782530; c=relaxed/simple;
	bh=2qgYIUsKC6A86MIt26fLri2Ven5GAoDHsQxb1eD5z/I=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=QGlbWqvRaeD+FvfTJaOFIGS2aVu+UpltTDHuJpfGZwQzoVAtMjycxseEA8FUdwykvUZxShwRk7hI9NoKZuhzAzvkZgDZfqM6QzgIjjVXHferheMowIcvD3rieNL1DNbQ49rcCYVg+BIHzN5Fk51ShsdJ5c9BiQ+8HTgi00ooC5o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HMqBxNSU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 590DCC43394;
	Wed, 10 Apr 2024 20:55:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712782530;
	bh=2qgYIUsKC6A86MIt26fLri2Ven5GAoDHsQxb1eD5z/I=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=HMqBxNSUI0gFdUP/v1rqFDE2bNjLnaXz4IgflzuqxPIgTAjfkZCuGMew2Lq0lCRhV
	 8nyK3WClSLMlxfplc4LcBUDlNHH4cbA30C0tI6fHycgaW4W/zRi5rvDWCEGdC6ITB7
	 njPnC8RnQyreRyBGUcyZ2ocCKQ1PTNr5DdZU5OzeAUsFkQvc//GO6y01V0VS8NAI6E
	 20AsV7l2SZ2KynL4zmm5R7lzXBvLvyNokXtwMfx0xY5oIp6I/qjzCe5dQh6LyrSoAJ
	 sLjE5etnSw/GAPTVYz95+CRPFbUDlw4LeiYulHuAQElgY6QGFMBn/7VUkeZItNRvMK
	 uVvOZ2kf7Qu1A==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 48BCBD6030E;
	Wed, 10 Apr 2024 20:55:30 +0000 (UTC)
Subject: Re: [GIT PULL for v6.9-rc4] media fixes
From: pr-tracker-bot@kernel.org
In-Reply-To: <20240410183852.6df5011e@coco.lan>
References: <20240410183852.6df5011e@coco.lan>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20240410183852.6df5011e@coco.lan>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/mchehab/linux-media tags/media/v6.9-2
X-PR-Tracked-Commit-Id: d353c3c34af08cfd4eaafc8c55f664eacec274ee
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 9875c0beb8adaab602572b983fb59dbd761d5882
Message-Id: <171278253029.335.15909459080788933877.pr-tracker-bot@kernel.org>
Date: Wed, 10 Apr 2024 20:55:30 +0000
To: Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Andrew Morton <akpm@linux-foundation.org>, Linux Media Mailing List <linux-media@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Wed, 10 Apr 2024 18:38:52 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/mchehab/linux-media tags/media/v6.9-2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/9875c0beb8adaab602572b983fb59dbd761d5882

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

