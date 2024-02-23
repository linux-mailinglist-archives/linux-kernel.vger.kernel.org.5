Return-Path: <linux-kernel+bounces-78797-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A88028618F6
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 18:12:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5B9B21F22DE1
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 17:12:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A252012D758;
	Fri, 23 Feb 2024 17:11:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Bbq9nHeF"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E48D012BE83;
	Fri, 23 Feb 2024 17:11:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708708307; cv=none; b=gm807CrTd2mfQndP8Zs3nPdeSYQI81c+OuArVlyuWG9FGtyNrjiV/qLjaS9Nqd20BD2yYlF6kTgI+285II2JoHxiG6Qt8lMr+7qusRarEjn5PcvA0OeE/SCIGT4a/N6XC/Igi+Nln5LbrpMou9EEfNFm8Qt2G3mbHHnBwePdMNM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708708307; c=relaxed/simple;
	bh=NKiCMZsW+vHlfHIMrRhhFVO3K8D2LzC0WPh4Wa95utI=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=dOYDAgHyw3izC3MIpb34DJ8AZwKujOJNPAR3WLPqbpWJbnPSrdGRFWjJMnrDoKWOQq3TC1NcZfqyzEYH4BlzxCYEkuov0Ss1RN63i94To+tPhMIRmOOX+JcBcsQtjUImCpo6Q+wjMAKTT/l8N+gcrFGBWf+ZzpbvLD9DaBKkg38=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Bbq9nHeF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id C636DC433F1;
	Fri, 23 Feb 2024 17:11:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708708306;
	bh=NKiCMZsW+vHlfHIMrRhhFVO3K8D2LzC0WPh4Wa95utI=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=Bbq9nHeF9wqvpaccSkJzsr2PQiwcoyzLd5jVDHv52RoeGXC46onilvq8YZ261wtr6
	 i+6UMf5fUowM2xD3a45e8KuodsHvkFQc8IQ/547A5Ucvw5k5vSgndj1B15Qkot8jJn
	 j+l0G5L++efRPVTtpvFMPfIAvzIFP6Lexke145II+SX9zD4sDMjRZ7ZyenGpWUhSS1
	 C3eP9AOujKPiCCcLqiyBLHRFLf7/KA1mH64RXlJJDzeJ2dsOGkRwn4roo/x1La9UbV
	 G/3YVZbyi8WKGVgd+A2DdWqiqWe7pETukz+n7JEyU8BZEUpMAkqkmaqr+BvSQkuLUA
	 WZH0ZUU3cRsGg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id B30CCD990CB;
	Fri, 23 Feb 2024 17:11:46 +0000 (UTC)
Subject: Re: [GIT PULL] gpio: fixes for v6.8-rc6
From: pr-tracker-bot@kernel.org
In-Reply-To: <20240223090821.15356-1-brgl@bgdev.pl>
References: <20240223090821.15356-1-brgl@bgdev.pl>
X-PR-Tracked-List-Id: <linux-gpio.vger.kernel.org>
X-PR-Tracked-Message-Id: <20240223090821.15356-1-brgl@bgdev.pl>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/brgl/linux.git gpio-fixes-for-v6.8-rc6
X-PR-Tracked-Commit-Id: ae366ba8576da0135d7d3db2dfa6304f3338d0c2
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 9cd42be825fa15609bf0616d70032d90e844282e
Message-Id: <170870830672.25757.6401287659948851383.pr-tracker-bot@kernel.org>
Date: Fri, 23 Feb 2024 17:11:46 +0000
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Linus Walleij <linus.walleij@linaro.org>, linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org, Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 23 Feb 2024 10:08:21 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/brgl/linux.git gpio-fixes-for-v6.8-rc6

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/9cd42be825fa15609bf0616d70032d90e844282e

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

