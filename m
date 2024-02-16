Return-Path: <linux-kernel+bounces-69042-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 18F848583AB
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 18:12:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C2A281F25029
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 17:12:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EF77132C0F;
	Fri, 16 Feb 2024 17:11:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sizmEqbF"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90065134CCC;
	Fri, 16 Feb 2024 17:11:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708103470; cv=none; b=Umw8eJ3Ad7oVSiDJPK3Ge1tSZ0sJgEyNEcVpDL4TVoeE3u41wSuiPQUs/S7id3Ytz3YvKvCQrm/k/s3xPzq9pKnWCBh9r6mlVTqLBaVi/5RD3sm4PqUTdKW88EgNCBwv0d2wGX2jQOVTP0zGHLACF2Pw1cuVrBs+Y2Ed8EKuwv0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708103470; c=relaxed/simple;
	bh=E9xIn1JUm5rieXsFuUmmwS3Zw+8rfsyQv8CZ64rzJxY=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=dirY7QMtahSIc0dJ62cE4RusoF1I9v0ABrnVW3mXOEkg15u4tMtFN76UkwaHt04Dzzhog/2dcJqpurct8xnwrxh2IpFpPsQQf9RPh4oy7/wPdV0E7x651JZmPhG0pGCGwsKhffmMqn0wlyDwxkpZXTFgtASqxtRp1xKZ6Z3MzdI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sizmEqbF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 681FEC43390;
	Fri, 16 Feb 2024 17:11:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708103470;
	bh=E9xIn1JUm5rieXsFuUmmwS3Zw+8rfsyQv8CZ64rzJxY=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=sizmEqbFhaN5OR/V+4XH9TRWaUrSXZa2IY1c9uhUh8C/eq45JSajMn//KNVvAK2PT
	 jX8logjK0qNhhK0FhggmmVuSm9BjZ//gxSo+f42ztFz+w647yc5pEAWyL/sfspTLzF
	 fKVEJcTab26uDeQ/OD2ZVYyQuH5uH5jtCi8h5mIY0byStlRkLy3Fx6zNhihDyr91n0
	 fEABg1HmHSuL/s0EOtxJJjp1TL+NyMymaK1uc0LLXGtRt3UBFZekwu5HXRa15teobv
	 n3clS4ObpH8Yxa2v/BIWB/E93WAlYyTGKCaCVFhkIEesj9qYzO6La8lgQ/AF6gRyBC
	 06pHflz6A3xvw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 52DBBD84BCD;
	Fri, 16 Feb 2024 17:11:10 +0000 (UTC)
Subject: Re: [GIT PULL] gpio: fixes for v6.8-rc5
From: pr-tracker-bot@kernel.org
In-Reply-To: <20240216110827.16793-1-brgl@bgdev.pl>
References: <20240216110827.16793-1-brgl@bgdev.pl>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20240216110827.16793-1-brgl@bgdev.pl>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/brgl/linux.git tags/gpio-fixes-for-v6.8-rc5
X-PR-Tracked-Commit-Id: 2df8aa3cad407044f2febdbbdf220c6dae839c79
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: beda9c23ad82aa37be7f4a457e9b9544d04b84fd
Message-Id: <170810347033.29072.11416451962557929749.pr-tracker-bot@kernel.org>
Date: Fri, 16 Feb 2024 17:11:10 +0000
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Linus Walleij <linus.walleij@linaro.org>, linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org, Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 16 Feb 2024 12:08:27 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/brgl/linux.git tags/gpio-fixes-for-v6.8-rc5

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/beda9c23ad82aa37be7f4a457e9b9544d04b84fd

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

