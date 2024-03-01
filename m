Return-Path: <linux-kernel+bounces-89067-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 70BF686EA2C
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 21:17:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 885941C2440F
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 20:17:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4784E3C6BA;
	Fri,  1 Mar 2024 20:17:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BMHC61SH"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AA963C08F;
	Fri,  1 Mar 2024 20:17:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709324241; cv=none; b=UiG+q5BQ8SnELWXJEuJKKX9LiNMPndtgSGhj2Nio9ShW4hozP57VwcfImSNj4qQ2wR5eihuFUeDrNdVU/yRMoi9yU5vZM3VbgfGBtEosZWRRKO9ItOzy6OBq+AZLJ/OrjIFmqkHh+X1LX0sG9XdGrZJz1d14FxNrzFwg4izk3MU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709324241; c=relaxed/simple;
	bh=QPJ8ihpC7+Tx+yX8icQfH1hSIHnNISwez36/2mgHlWI=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=VKVu8PahxaCn8hVJ/4L/pIxaYOX215LsRj8uDrk5vcuCR8Ibqj1Uc9n7LYm7G1JMyXPwcEUPYJs9Y84PpSAswfxH/9+VxHSWL9hPtAkB/KmucRA+HwY1XGN6XXa3Lba8uZjRGOdI1zAlVWo6ox2zpIFdl1x0eSLdSqsEn1K16NY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BMHC61SH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 0B071C43399;
	Fri,  1 Mar 2024 20:17:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709324241;
	bh=QPJ8ihpC7+Tx+yX8icQfH1hSIHnNISwez36/2mgHlWI=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=BMHC61SHa7oeTCu76JmimYrKsUE4KQZIvmIo1V0W9Kx+Uir2ocolmHT/aYI+GZLDn
	 VtVVaKrNCSHTFOfEiZs2xc894FnsRBSkzx7cNYs2XppaKCx/vx/qpyR8r0MXJAtB/B
	 1/YyeOZ4RWObaJTxJo4Iy1hjFE3nC8UJ/oh/cD41F5rROS+Ea+C0vWbL8stZKx0a/j
	 tFqtZc0r2/Bq6MreqOPMhd7FU7EXvn7e/2qASAuXgni72qhEyJPDNV7L2AkT2fxxBK
	 5IWjc6RAwa5LfGyMzig3OWNPxD9qc7eMJGtWY1PVBMuaXzWGzuAme60SIS4mv7tqpK
	 exH0xqLyvmQWQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id EDC06C595D1;
	Fri,  1 Mar 2024 20:17:20 +0000 (UTC)
Subject: Re: [GIT PULL] pmdomain fixes for v6.8-rc7
From: pr-tracker-bot@kernel.org
In-Reply-To: <20240301095623.3659989-1-ulf.hansson@linaro.org>
References: <20240301095623.3659989-1-ulf.hansson@linaro.org>
X-PR-Tracked-List-Id: <linux-pm.vger.kernel.org>
X-PR-Tracked-Message-Id: <20240301095623.3659989-1-ulf.hansson@linaro.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/linux-pm.git tags/pmdomain-v6.8-rc4
X-PR-Tracked-Commit-Id: 2a93c6cbd5a703d44c414a3c3945a87ce11430ba
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: fafbad4a201e16c3213d595abda110d5e4261825
Message-Id: <170932424096.25962.9612744499307576727.pr-tracker-bot@kernel.org>
Date: Fri, 01 Mar 2024 20:17:20 +0000
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Linus <torvalds@linux-foundation.org>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>, linux-arm-kernel@lists.infradead.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Fri,  1 Mar 2024 10:56:23 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/linux-pm.git tags/pmdomain-v6.8-rc4

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/fafbad4a201e16c3213d595abda110d5e4261825

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

