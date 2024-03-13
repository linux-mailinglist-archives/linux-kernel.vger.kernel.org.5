Return-Path: <linux-kernel+bounces-102430-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8551387B200
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 20:36:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AF75EB2BE3B
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 19:33:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55C62612E7;
	Wed, 13 Mar 2024 19:28:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z71ikNde"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97C0862154;
	Wed, 13 Mar 2024 19:28:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710358083; cv=none; b=aMkMPmJQ/KehCfU3lNaC581D02iOWrXdyDluiGFE10871OSviJqt+ANiEUzcLAdY8TSMUvqUv091nH8RpYCdEpd2dcbBM4hTyVP4RcA3gY08xHu0f7LoZZUrTC3VxQKIoQt+rPy3MaNGm3Zhxd9DuPmGdrpZU8d1s48YRa4VQP8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710358083; c=relaxed/simple;
	bh=esSqTlaGGQAh1O4mGfFm8lLiLz0g25yYlnKusEmP1Vk=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=gVAZkuTeeRn3XcvclVJ9tUFj7G13J+g5vbpfk3BBONG/gjiWUtoMK2W/Rx+v9/6RYmGfq3LXkeqkG9pYgI/LexwJBLgkHcmgf0icq0MpQ/TNt9MfQcgP3N5qJcnmqim02x1r30zOEUFyIBtUz9HR0EYZe1sKZlE6UXQGDeH5tgs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z71ikNde; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 7C518C43390;
	Wed, 13 Mar 2024 19:28:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710358083;
	bh=esSqTlaGGQAh1O4mGfFm8lLiLz0g25yYlnKusEmP1Vk=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=Z71ikNde7s06GD4ulHbumVfKnX0Hteatm/y+HKIsHYO3d+0EELAvBz19+eGSXogQO
	 0nL+hxBBhUegOHRVycdXlTmD97f/MXyoAGcjSQiGAoNMH17W+Nvm2Vd9geTOcdYCz3
	 CMhpo6odzCg3wAiF0VFOYDbdLfMgcXmk+CMgZoWp9h6ec57XfjUmXefCLw8ejC3638
	 6JzBizAkZxCoFGWrtJUwl0bSuV3WxZPf+bTwKLrQwJgftKNrgfzyg95ZH4LSkHTPNi
	 tZ+h7yopSpnmiuXXo8143vQ8q7rR5a1hVM6l0TIJ7/tQAfq45mu8NzbhXqOSliwO74
	 /5NLvMYRCB9MQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 68CC4D95054;
	Wed, 13 Mar 2024 19:28:03 +0000 (UTC)
Subject: Re: [GIT PULL] gpio: updates for v6.9-rc1
From: pr-tracker-bot@kernel.org
In-Reply-To: <20240311102545.21177-1-brgl@bgdev.pl>
References: <20240311102545.21177-1-brgl@bgdev.pl>
X-PR-Tracked-List-Id: <linux-gpio.vger.kernel.org>
X-PR-Tracked-Message-Id: <20240311102545.21177-1-brgl@bgdev.pl>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/brgl/linux.git tags/gpio-updates-for-v6.9-rc1
X-PR-Tracked-Commit-Id: 8636f19c2d1f8199b27b4559d9caa115b3011f06
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 69afef4af453c913e31640f3b31103847b97fe2f
Message-Id: <171035808341.9850.13418085820819938859.pr-tracker-bot@kernel.org>
Date: Wed, 13 Mar 2024 19:28:03 +0000
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Linus Walleij <linus.walleij@linaro.org>, linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org, Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Mon, 11 Mar 2024 11:25:45 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/brgl/linux.git tags/gpio-updates-for-v6.9-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/69afef4af453c913e31640f3b31103847b97fe2f

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

