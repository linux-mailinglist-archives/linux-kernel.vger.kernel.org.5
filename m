Return-Path: <linux-kernel+bounces-150565-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F0CF88AA0FA
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 19:23:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AB110283C13
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 17:23:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FB81173341;
	Thu, 18 Apr 2024 17:23:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lY8OEkRB"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F91F171093;
	Thu, 18 Apr 2024 17:23:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713461000; cv=none; b=Zk37EXqIPfRaYmJCwIKYuWYskdBjR1AZDKh1sQTyl0j6LCXH7c86mH0vvqlsXc5OoxqSwywOjxWB5JYwg48lL01+xYztSMSR26T2ZY4Tu6S1KJea197pk+vUK7bIFzKod86TtzsrmiQOde97wzPC6gWuAe/mbYbl9MPPXA4SAXs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713461000; c=relaxed/simple;
	bh=OVXt2ZfjXcfSpWwWJQdD/G2vmX+KAN5kUbLV0gX6uvo=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=hzvw58qqRLtl30el82eksV98bwjnS869ZApGKGqd9UJ4nss+6Ezd8UmdRYHMULALpysdRDJ1olyD+rktyXrnEtsCNLbM9MlBtkTmh566KO2p6H+rm+G4VI6xqpi/A+F7NkBtMI55mHnWbWP0whabdhQU/0ITl7/dnRCujr/IEBE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lY8OEkRB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 3E072C113CC;
	Thu, 18 Apr 2024 17:23:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713461000;
	bh=OVXt2ZfjXcfSpWwWJQdD/G2vmX+KAN5kUbLV0gX6uvo=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=lY8OEkRB0Mqy7iuJKGXcxHryRMlhzZYtS4p1UkqwrnYfTf7EQ1cKKUJqLcJgG+fhc
	 HhNiQp6r7PRIMj/RA51mIJMIFyMJ7hp0GX3+MkpE1xu3IMs94/3FXRMQKAiWYl/lwL
	 bvBo4/p1D7AgSpBz22VYubQlIVEGBzV2bHpgK7so10nSgHuDbuko5rD8caSf/cD25i
	 R9qPZbrcvQc4WiNTLeH17Xs09btNOcpDq8DVQ4ezR5DEHdAjpscGZd7XJYNuI37OVb
	 sMCKkR2yOf14SbCY3RlJ0knkDHQssfIVFUv9yjRyje7g1t9yAFgkBVytzhLKGicaDB
	 EQJNhSWfvwtQg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 33335C43619;
	Thu, 18 Apr 2024 17:23:20 +0000 (UTC)
Subject: Re: [GIT PULL] gpio: fixes for v6.9-rc5
From: pr-tracker-bot@kernel.org
In-Reply-To: <20240418171329.6542-1-brgl@bgdev.pl>
References: <20240418171329.6542-1-brgl@bgdev.pl>
X-PR-Tracked-List-Id: <linux-gpio.vger.kernel.org>
X-PR-Tracked-Message-Id: <20240418171329.6542-1-brgl@bgdev.pl>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/brgl/linux.git tags/gpio-fixes-for-v6.9-rc5
X-PR-Tracked-Commit-Id: 69ffed4b62523bbc85511f150500329d28aba356
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 360a348fd7fe72ec42a80d025e6fc81cda19f48e
Message-Id: <171346100018.11189.5133191676673891264.pr-tracker-bot@kernel.org>
Date: Thu, 18 Apr 2024 17:23:20 +0000
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Linus Walleij <linus.walleij@linaro.org>, linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org, Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Thu, 18 Apr 2024 19:13:29 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/brgl/linux.git tags/gpio-fixes-for-v6.9-rc5

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/360a348fd7fe72ec42a80d025e6fc81cda19f48e

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

