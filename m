Return-Path: <linux-kernel+bounces-97645-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B595876D11
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 23:28:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 43FF51F224D2
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 22:28:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E6456026D;
	Fri,  8 Mar 2024 22:28:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="APUFTHCS"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C98F56026E;
	Fri,  8 Mar 2024 22:28:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709936890; cv=none; b=eto1aCd+3Wl9bBPz76mGwZj4BduUK7pE5Gj77aCJW9KABn/imZuv+aDH2lv8vG9NoE4s8YqKGrV8MXJMoJnl767qaa1/X6f195tQiWd6u6gHMcOaspd1LD85WyhNBdC7DyRNNKCz1/JAQX1R+SLuwy94AzJ655FIgsXNRFXI+gk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709936890; c=relaxed/simple;
	bh=kGYnXvV9zc5Crz8Tj47y5Q2/IMnBrxmIwE/yxMQ518g=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=gNB5Wt/g5zXGEskt2wBuiD8a9iFf/Epae+ccaQ2kJwnC7ILEdyfbxwKPNyO8VXT2XZtyHqrDNb2ZLa6QBsKH4iqbBspIrDnQJDTGewf6Kwzj0fcTN82Yx2B6kfqQJrI3zgALX+ro56RmIyn2+TlX/VJxF3l3YjBeGOpflFF/yaw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=APUFTHCS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id ABB77C433C7;
	Fri,  8 Mar 2024 22:28:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709936890;
	bh=kGYnXvV9zc5Crz8Tj47y5Q2/IMnBrxmIwE/yxMQ518g=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=APUFTHCSs3b3ApjbwLSLeiesShwV1hhsiOnwDVzHMGZAhn4GWYVIbDGTY8n6Y4qkY
	 wBe+gDUKORQh63yxU5x00EV/x4M69h0CrH4tp3czvhDoG+TU6baV3eThw/kZr82ZhJ
	 4maNrQfdak9TRDF66wD9KqvVIXCknBd3G9gGUBA0vxYNZv/OCYmusqoKkM3CNUjClt
	 5TZvJ24GtgZMdUoRwAx2joB0yCRQHNEU1FVFYK5TLq100rKYGJv+AAUL6ujADCSoQt
	 zIb/vqlytUDkzsX3LW/OdlHgaqE2fwgL27EEoZINtmvIjroUBh9h+ar6k9esd4zHni
	 0qeqDJ2o+DVWg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 97F3CC59A4C;
	Fri,  8 Mar 2024 22:28:10 +0000 (UTC)
Subject: Re: [GIT PULL] late pin control fixes for the v6.8 kernel
From: pr-tracker-bot@kernel.org
In-Reply-To: <CACRpkdYomV_hSse7tExpQXzuOarC35cqAJoSQPwwwbN0mi81yQ@mail.gmail.com>
References: <CACRpkdYomV_hSse7tExpQXzuOarC35cqAJoSQPwwwbN0mi81yQ@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-gpio.vger.kernel.org>
X-PR-Tracked-Message-Id: <CACRpkdYomV_hSse7tExpQXzuOarC35cqAJoSQPwwwbN0mi81yQ@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-pinctrl.git tags/pinctrl-v6.8-3
X-PR-Tracked-Commit-Id: f6443e0177a55f78e94ccc1a43eb63a023a0b6fd
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 49deb2805fdcd366b7a9123cec7914b93b543f75
Message-Id: <170993689061.2485.2548727277665390131.pr-tracker-bot@kernel.org>
Date: Fri, 08 Mar 2024 22:28:10 +0000
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel <linux-kernel@vger.kernel.org>, "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>, Bartosz Golaszewski <brgl@bgdev.pl>, Antonio Borneo <antonio.borneo@foss.st.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 8 Mar 2024 15:04:32 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-pinctrl.git tags/pinctrl-v6.8-3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/49deb2805fdcd366b7a9123cec7914b93b543f75

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

