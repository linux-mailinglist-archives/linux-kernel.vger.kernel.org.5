Return-Path: <linux-kernel+bounces-96185-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A630875839
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 21:24:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 24A7C282476
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 20:24:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D124D1386B3;
	Thu,  7 Mar 2024 20:24:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DCFDLIVq"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FBF65B1FD;
	Thu,  7 Mar 2024 20:24:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709843082; cv=none; b=qhM0Di8wITBjQ0Bqzghmpz7N87C/xiVf0zf7ZVMNgePesSy1HcO8fMvcEZW6+V7bjdXcr7/84Kb1ME8BUmZqtbanSD9u2fi9ue8tp1819DtHop4qITd9zISVmmKmilWbZmxXWoPPKBRCvf7VhQC7YxAriKkY3v5iGVENF9BQkf4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709843082; c=relaxed/simple;
	bh=mfMsswA25eISL9h44d/40uJKpiBOlislgzTn+L5cpEY=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=fXwiKvGV+Py06OfjFOzIHVAALxCCoFJlw/2X/zdxT6vU7uYzLY1txAuYUZoQecTfZCJQT+To+6oNatFa72itxCGA+jCuDBLHXDJmZp8tHAPQpq3hB+5Wd05N99t0JVKbtidnGE9VYmtY5lCUS+r9wTBgFMYNwjkInzdHO9Ze4vU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DCFDLIVq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 8492FC433C7;
	Thu,  7 Mar 2024 20:24:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709843081;
	bh=mfMsswA25eISL9h44d/40uJKpiBOlislgzTn+L5cpEY=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=DCFDLIVqY0kXmnHDXvJTh6QgHPwoRh3gzYQXSChSDN5giYEaeOS3WulNWFO59Airi
	 PkKR2TEwv947z4I52V3h4LGlHW3NRdcC5ouo5so/zVtJDCqoVmOP+TRaQNLvRrjxQr
	 ZYoUcDz/3ALQA0KFi7VOPJag7EXaSd58YCSupVx1C6BD43Kcb8ib4QT0q8L8a0QMBz
	 8+DWyySsj9h7qadaMem1CubYthKg8WBbgjCXFG129xFmCDG6dKvBg1jx+XJx11y0pJ
	 qtCW7w7kh44WS3WAmUFjEV4XAlYWRteJQr2PLsUCvW/olAJ4dmybG+pfhej8n/IPPm
	 BK+ihFo9YZX/g==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 514BEC04D3F;
	Thu,  7 Mar 2024 20:24:41 +0000 (UTC)
Subject: Re: [GIT PULL] SPI fixes for v6.8-rc7
From: pr-tracker-bot@kernel.org
In-Reply-To: <20240307201347.377CAC433F1@smtp.kernel.org>
References: <20240307201347.377CAC433F1@smtp.kernel.org>
X-PR-Tracked-List-Id: <linux-spi.vger.kernel.org>
X-PR-Tracked-Message-Id: <20240307201347.377CAC433F1@smtp.kernel.org>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git tags/spi-fix-v6.8-rc7
X-PR-Tracked-Commit-Id: 177cddaa5bdfcbc4c3d4594bb44ed8338765fc29
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: c381c89de18015fab265d18d2fa2f30b395be216
Message-Id: <170984308132.27811.738003157188193683.pr-tracker-bot@kernel.org>
Date: Thu, 07 Mar 2024 20:24:41 +0000
To: Mark Brown <broonie@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Thu, 07 Mar 2024 20:13:39 +0000:

> https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git tags/spi-fix-v6.8-rc7

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/c381c89de18015fab265d18d2fa2f30b395be216

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

