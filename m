Return-Path: <linux-kernel+bounces-31574-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BD096833042
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 22:28:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 76AE02864A2
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 21:28:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41D8859B45;
	Fri, 19 Jan 2024 21:27:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R4P6poek"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 837FB58AD3;
	Fri, 19 Jan 2024 21:27:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705699649; cv=none; b=ji923pVD7OJS47iaxRlu5Cvz2pNBteiEF+7GGgMrQn7oJzLl3u8CcAOb8SlpHw54Qp3fwUaOMaJbTffKE4UXaJN+wcvdXtpkPyBkd4ORIUsI/chZTg/xQJlz+nra9uYvn2Uc33tYa1EKPOQPm4ZR7QMA2Pxwn4czjOTTsjhe7NI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705699649; c=relaxed/simple;
	bh=pUGLxoRsz/H8zRHxHLNOc/0DMtA512B94VVuQ+HeGdE=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=rEJipj29wCy4Jx2Lf7/0YgOzTIfUiDsNesEv25QgUqiL3C1aR2FOWLeKZ9baY4uiuygq2salKws2HfQntQEiJ/5NJh20G+UGo89aeIoG4dA4GPV+0GwAHuO0NMsL7e0S5VvVoagWQ9ZuLlK4q829M5DHbRw+6Cpt9oib/PLnP3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R4P6poek; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 5A519C43390;
	Fri, 19 Jan 2024 21:27:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705699649;
	bh=pUGLxoRsz/H8zRHxHLNOc/0DMtA512B94VVuQ+HeGdE=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=R4P6poek70Llt7vtdomHpgA+SvucWCVWL9eHZ8F2nCn+zV1tnc4LBv8hJpIT2+zdC
	 ms2LIROpvSEeoiE9a9+sU/zzgX01MNzyGFJ+phfXQqv9Bf72U5xPndtZ7jSDv0OkMZ
	 pMrMsBeI97x0gR7Egf/mm631d9K6EUzHk0Id6Ia6BZXtzM6qdDD2QL8ZJHKRq/aHms
	 UYspG1GxmiVeXS1frRH/kV0uDqRA3hqE5E6AWicQLe180IqMrKCa1aPAJHBkVsxcQY
	 R12+cP7zBztGaAPfycEjYKDDPJm3rqdUdeHmwXQ49Jqnab+TcnBA6XAAj5AbE5ZsZI
	 aAF/HGb3G5LPA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 44B65DFC688;
	Fri, 19 Jan 2024 21:27:29 +0000 (UTC)
Subject: Re: [GIT PULL] power-supply changes for 6.8-v2
From: pr-tracker-bot@kernel.org
In-Reply-To: <ynrunm37opgms7vp4e2woj3nhqxkzvvg5bvrt3nquzndcsfc33@p46rdj6sipak>
References: <ynrunm37opgms7vp4e2woj3nhqxkzvvg5bvrt3nquzndcsfc33@p46rdj6sipak>
X-PR-Tracked-List-Id: <linux-pm.vger.kernel.org>
X-PR-Tracked-Message-Id: <ynrunm37opgms7vp4e2woj3nhqxkzvvg5bvrt3nquzndcsfc33@p46rdj6sipak>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/sre/linux-power-supply.git tags/for-v6.8-v2
X-PR-Tracked-Commit-Id: 17d49b7e47a1001c8796f05f4a2bbdef0a998213
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: ab1e2d0fccc570c950fd939840ebc8efa3bd39b8
Message-Id: <170569964927.21908.11135079422455416941.pr-tracker-bot@kernel.org>
Date: Fri, 19 Jan 2024 21:27:29 +0000
To: Sebastian Reichel <sre@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, Nathan Chancellor <nathan@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 19 Jan 2024 01:46:29 +0100:

> https://git.kernel.org/pub/scm/linux/kernel/git/sre/linux-power-supply.git tags/for-v6.8-v2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/ab1e2d0fccc570c950fd939840ebc8efa3bd39b8

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

