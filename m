Return-Path: <linux-kernel+bounces-133550-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CABB89A571
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 22:10:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 04A7BB2137C
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 20:10:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DBAD173356;
	Fri,  5 Apr 2024 20:10:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J988fVb1"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A4D35D905;
	Fri,  5 Apr 2024 20:10:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712347805; cv=none; b=oBlRY4hCvHt/EyAeHRLRgCQqnGlwl0arwrPfIXlAjlLvCYUzSDD01HAS+Y2nwN/SGZrlabFvzW0dgXVNpkeHd0vS3ZQzqe6wX9annoo/+dEsy+WfVrb+jltbGjrYKNHg4yWMIrZqO6bXUEpxl+DTgtXjLhdL0W9TB55a3PTvmYg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712347805; c=relaxed/simple;
	bh=MSDF8pXLqi0ELwEUDNtVXJVd4VFE7Vt+jEAFdsx8/fE=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=p0CeMh2zYWO4dhMUdSC1Rksytzc8P9s5Sr95WljFh8hh9yEdW237sJPNjB6nCrhg22rbFhMS0l97Lgr3tK3ZJ7pcG79mU3hNJeCR09mXEumdXOyzuhGCWmz3pM/WnTRHxzLx/nLLdIiO4c3H/obUur0JqgF6ylI5bGlU/QOxuQE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J988fVb1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 20397C433C7;
	Fri,  5 Apr 2024 20:10:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712347805;
	bh=MSDF8pXLqi0ELwEUDNtVXJVd4VFE7Vt+jEAFdsx8/fE=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=J988fVb1ItV1olRZjYzQB5RYg8BHN/jdciXos3sH2/isrzlE/hV8g6BIbgdT/gV/I
	 Ozvzl4sRTux5TFgPlzHNX+1MzS0bBKJdV470nQYA1GIo4lrZPL38EkoyG78RpzFFQ7
	 9yWgwJ1KtF4Ebah6o1fS7qpnG6nHpJ19fIocpOJu2wxhD3JhkwSB3AjLuFqXEzOEpn
	 qQMwTxOj3Z6djC8AMiwbId3A42yG+GwCkxxy46Fpgen7aguVnlRm5HJgCFeTR2mPae
	 Q9yra7E/6WSqUw6SKzS+hNEtPDPoKmzejW8gRnCjYOIBsN0hX4wrzdNju08/qzH1Qj
	 U/gtb1UXZNEsQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 0A40ED8A124;
	Fri,  5 Apr 2024 20:10:05 +0000 (UTC)
Subject: Re: [GIT PULL] gpio: fixes for v6.9-rc3
From: pr-tracker-bot@kernel.org
In-Reply-To: <20240405175803.299328-1-brgl@bgdev.pl>
References: <20240405175803.299328-1-brgl@bgdev.pl>
X-PR-Tracked-List-Id: <linux-gpio.vger.kernel.org>
X-PR-Tracked-Message-Id: <20240405175803.299328-1-brgl@bgdev.pl>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/brgl/linux.git tags/gpio-fixes-for-v6.9-rc3
X-PR-Tracked-Commit-Id: 83092341e15d0dfee1caa8dc502f66c815ccd78a
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 2e69af16b03ff740ee5b607590877912fb3dac43
Message-Id: <171234780497.2800.10737036440130620103.pr-tracker-bot@kernel.org>
Date: Fri, 05 Apr 2024 20:10:04 +0000
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Linus Walleij <linus.walleij@linaro.org>, linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org, Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Fri,  5 Apr 2024 19:58:03 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/brgl/linux.git tags/gpio-fixes-for-v6.9-rc3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/2e69af16b03ff740ee5b607590877912fb3dac43

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

