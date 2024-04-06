Return-Path: <linux-kernel+bounces-133738-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EE7189A7EE
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Apr 2024 02:29:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 233821F23104
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Apr 2024 00:29:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F1B211723;
	Sat,  6 Apr 2024 00:29:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c8xJWWwW"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65BD9C8E1
	for <linux-kernel@vger.kernel.org>; Sat,  6 Apr 2024 00:29:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712363344; cv=none; b=X7n0UDp0Srvs32zOoRNBzxwFUlH7zxy6I9i0ybo0XhbSKb0B+V78diu6tRJgFSt0gTq6LCvXEOkekk1oy5ltDzv2JP8M0S0NUDU56kaPaza2et1tUexOqBPax/0e45J5RaAjbGAt02wks+w60ifXul0+cwv6co09e8S4BNXF948=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712363344; c=relaxed/simple;
	bh=DZ/MDDmJILpGLw0SLTEylEC3aNU2ei/mifNr4z1uPQc=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=E2rc+bbcGiam8yDkKDvjDWzucnynPRH7iIxThG3GYHfy3DSUmI9RNYTw4A2XZr8x/L1T5MuLtz9743O7ZQiybglSducxFAJ0/N0o7TVqBLYHPD1badvuRlNTytGsAxnzIAbHfl/h37SQ0wN76+rQ61d83KYln8oVFDb41wR8Xj0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c8xJWWwW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 45C8BC43394;
	Sat,  6 Apr 2024 00:29:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712363344;
	bh=DZ/MDDmJILpGLw0SLTEylEC3aNU2ei/mifNr4z1uPQc=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=c8xJWWwWwN+8pIFbamMFaxJQwA2Fux3MneibW+R3PNoyZDxuLrfDtdEyidEQFDQTc
	 DbY36pAwAPSV1fFQzU2PMBloMiovOm3z22e/rXmzddEU2DabM7CR/bmI58kHxhDMDt
	 aE1Fbiz6xhhioGr21wuFR1tqYgywQwuV5tsfdrMGm46b49I0ol1Z/aXG/sd02bxpD4
	 GNhC6jvhqqVQaIOIIPkphSim39MSphXh2olRzQRSOwKqO18IKnpvMByM/xeJzEJ/tW
	 8bz3XBQxQK9QzEPah9dGQIVi+7yM8LyGyt6S8ncA+wyC9jjs9cI/yMRMYjJeNuSEv2
	 btS1/9jxojdZg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 3AF9AD8A101;
	Sat,  6 Apr 2024 00:29:04 +0000 (UTC)
Subject: Re: [GIT PULL] regulator fixes for v6.9-rc2
From: pr-tracker-bot@kernel.org
In-Reply-To: <20240405222051.096C1C433F1@smtp.kernel.org>
References: <20240405222051.096C1C433F1@smtp.kernel.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20240405222051.096C1C433F1@smtp.kernel.org>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git tags/regulator-fix-v6.9-rc2
X-PR-Tracked-Commit-Id: a469158eaf8f4b10263b417856d923dfa38ae96d
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 20668408abc09f9ef07e1bcebd3560d420cdadc4
Message-Id: <171236334423.12657.9643631776226306702.pr-tracker-bot@kernel.org>
Date: Sat, 06 Apr 2024 00:29:04 +0000
To: Mark Brown <broonie@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Liam Girdwood <lgirdwood@gmail.com>, linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 05 Apr 2024 23:20:41 +0100:

> https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git tags/regulator-fix-v6.9-rc2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/20668408abc09f9ef07e1bcebd3560d420cdadc4

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

