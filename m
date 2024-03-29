Return-Path: <linux-kernel+bounces-125331-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F3DFF892431
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 20:28:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3197C1C2252F
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 19:28:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0C3013AD14;
	Fri, 29 Mar 2024 19:27:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="caXNQYLo"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02EE613341C;
	Fri, 29 Mar 2024 19:27:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711740452; cv=none; b=Ga6Vi3nCTNZeqfZ50jAGNp73p4mQ9EuPd9V3pdx7fJC4QGdiOeBpRfAAlluYQ1PJz0lTVkvHxHFeTIfKKAJj/MI5eCP/D4WqAgzOeJxB4I7Qyt74SAfoRC9HDUY5XQd+qQpbsSS7AivTOmfEb4pQMnfByAHIjkzpwEP9Tpd00JU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711740452; c=relaxed/simple;
	bh=bIiySNcHEEpAhlNGYrNClfJ1PPN1KAReCk7fKpKR/Uk=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=EYGsipeNsyVl7xJELadClOEe8LkbIYWYd9E6EVN9WGoWrEvd1jxjgwaoOKI71NXOKrT/McNBf5HORnviGxaOu92Pk+TAbPW5cqHDFJ35trvEfdGgFCElavXGmv8IXzEEjfok2zgOSw2KThtg5ygpkKR/DdmL10zdwgBABLFTPA8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=caXNQYLo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id D8B56C433C7;
	Fri, 29 Mar 2024 19:27:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711740451;
	bh=bIiySNcHEEpAhlNGYrNClfJ1PPN1KAReCk7fKpKR/Uk=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=caXNQYLo2maw5oSSUg2uMP4xSeOxobRymjlv0o+74Y1cWgKXfALO4iJp3R9SsZ8jV
	 sGhAhGOtBwpsOtjLN+s4DFAFq1TRXK36Ex8HTDV0pkFGM+nKk4fOUdaA60lNYFG4bC
	 wjqTtB8AIHLIKtD63chSkTBZXRSuvhqMBzd73WkjcPfiw9jnLawaMaxxxPfNlVWkrh
	 DGYEoR1gMny5c7Ryxtxmp6J7XVl4268JdlG80HbHDqw7lgOq5+5z7CGFxqBlC9BBbg
	 8qPse8k5HaWo00PEZ5nRyWzI2DO9rt7RFq0+bOdvISSK/EFEhXHD79LjGbOG89VR2a
	 i2APICEsUFInw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id D1891D2D0EB;
	Fri, 29 Mar 2024 19:27:31 +0000 (UTC)
Subject: Re: [GIT PULL] gpio: fixes for v6.9-rc2
From: pr-tracker-bot@kernel.org
In-Reply-To: <20240329105452.17036-1-brgl@bgdev.pl>
References: <20240329105452.17036-1-brgl@bgdev.pl>
X-PR-Tracked-List-Id: <linux-gpio.vger.kernel.org>
X-PR-Tracked-Message-Id: <20240329105452.17036-1-brgl@bgdev.pl>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/brgl/linux.git tags/gpio-fixes-for-v6.9-rc2
X-PR-Tracked-Commit-Id: 5c887b65bbd1a3fc28e2e20399acede0baa83edb
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 033e4491b6c614efddcf58927082887e2b78995d
Message-Id: <171174045185.16736.1447738889135500472.pr-tracker-bot@kernel.org>
Date: Fri, 29 Mar 2024 19:27:31 +0000
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Linus Walleij <linus.walleij@linaro.org>, linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org, Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 29 Mar 2024 11:54:52 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/brgl/linux.git tags/gpio-fixes-for-v6.9-rc2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/033e4491b6c614efddcf58927082887e2b78995d

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

