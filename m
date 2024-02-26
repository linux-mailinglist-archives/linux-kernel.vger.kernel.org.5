Return-Path: <linux-kernel+bounces-82243-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 81438868101
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 20:29:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3B8FE282FCD
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 19:29:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C091412FB39;
	Mon, 26 Feb 2024 19:29:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ovAXJWFg"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1371512FF93
	for <linux-kernel@vger.kernel.org>; Mon, 26 Feb 2024 19:29:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708975765; cv=none; b=GD36TjmKuN+AGSwgaqOjq/1geWlgopVwo8IvYOYoV7wul2duc3GNmjtE3Bnv3HnPsyuF/vohNnq6LG1MnYaw69vYmQDgJBAfo7vuA36R+JBEKYcLmEllCihmF/pJw5/Zlie+3k8bWYqPkHDAXaXJLxyQPzLS50rmQz0vEfDjFts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708975765; c=relaxed/simple;
	bh=niKZ/lRI4h/kD03F2e2I7XMUiGgLBQH11Hc98Y9cYKs=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=fCMAN2Dwc6dG8voEvKXEuATtbYV7i2Z1eW0mBjOpoJNUkwBkZpJNZxiB9aOklfthMh/h9XgMkwXmhhnPCFpC+GNyeNNImHNJ+gqqbNRw0pfgmEX/3NIeBbxNmRbAVQM4TJWoBzRi477H9/9BvcuUcCOv+oZI/RwGRumz8IuXkNY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ovAXJWFg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id A78E4C43601;
	Mon, 26 Feb 2024 19:29:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708975764;
	bh=niKZ/lRI4h/kD03F2e2I7XMUiGgLBQH11Hc98Y9cYKs=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=ovAXJWFg70SIUyaGDcOX9l/7yFQqqto5hruPy0HxFrnehkH9mRcZYUh/AHrclxgI4
	 GsxsBHlZSOP+5tOe+Sz/K/ZCLChbFcgP8g0mIpOHXi6QimIqyyGhHA507XVpeTgPpu
	 h/xIBc0R2PrDnjVCIriylhop3Cr7k+tg4SyFLdi7dqDG7h8lxVRgtpNKvWWwDWKNar
	 P7RydMyvH6DVOtUYNGLoX0i04ngV97O++VXiovnuPW7znANnHQBaiExuchLx5YAbmL
	 tk1NLDcMh8fsDPcCNDCN1arrIQGEOzXRF0glf1NQEriH6qcqbVi7yZx3V8yT6gvD4O
	 GPvajoozGobFQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 93D68C39562;
	Mon, 26 Feb 2024 19:29:24 +0000 (UTC)
Subject: Re: [GIT PULL] mtd: Fixes for 6.8-rc7
From: pr-tracker-bot@kernel.org
In-Reply-To: <20240226121124.0cad7cdf@xps-13>
References: <20240226121124.0cad7cdf@xps-13>
X-PR-Tracked-List-Id: Linux MTD discussion mailing list <linux-mtd.lists.infradead.org>
X-PR-Tracked-Message-Id: <20240226121124.0cad7cdf@xps-13>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git tags/mtd/fixes-for-6.8-rc7
X-PR-Tracked-Commit-Id: e6a30d0c48a1e8a68f1cc413bee65302ab03ddfb
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 45ec2f5f6ed3ec3a79ba1329ad585497cdcbe663
Message-Id: <170897576459.25041.18386446325033743059.pr-tracker-bot@kernel.org>
Date: Mon, 26 Feb 2024 19:29:24 +0000
To: Miquel Raynal <miquel.raynal@bootlin.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-mtd@lists.infradead.org, Richard Weinberger <richard@nod.at>, Tudor Ambarus <Tudor.Ambarus@linaro.org>, Vignesh Raghavendra <vigneshr@ti.com>, Frieder Schrempf <frieder.schrempf@kontron.de>, Michael Walle <michael@walle.cc>, Pratyush Yadav <pratyush@kernel.org>, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Mon, 26 Feb 2024 12:11:24 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git tags/mtd/fixes-for-6.8-rc7

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/45ec2f5f6ed3ec3a79ba1329ad585497cdcbe663

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

