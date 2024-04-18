Return-Path: <linux-kernel+bounces-150567-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 135068AA0FD
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 19:23:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BEA6C285A09
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 17:23:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E85D17556A;
	Thu, 18 Apr 2024 17:23:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Eis3hRb6"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4A91172BC6
	for <linux-kernel@vger.kernel.org>; Thu, 18 Apr 2024 17:23:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713461005; cv=none; b=apOiwgx0fuihkmM8eKvvxTNmD+XiDo3nHr7EdR0Q/yvdzR+16Cos5EOD8VZUlSqvbmipiEZP1LCy28flg1Fuft6NoCKuW2lD+9myLkVyyEmgYXisUUKxekai6LPekvcAOJC4ESbVSwEpgL+RhuZu24C8j0u2TN7m/ZU1AibhUBY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713461005; c=relaxed/simple;
	bh=IJ2lEuV74eFW3VetmAOc9Er7xJsIH+58/HXpxW/mB/M=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=IIJWmdbTJVwYXQVTjV6iy5i72PkOsuUDgT2NRQugU+z2tKYommFVVVvgDs2m5qeAk6lgQ9u6d6oBM09Brk5atJJHU6p7VFqkogwNROpwK9B1YtFBvsScliEGQsbzKbghwA9sFdVog6YQU4mGZMpQMOx9FTxuaPWBl37gUBfcsLE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Eis3hRb6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id A6037C32781;
	Thu, 18 Apr 2024 17:23:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713461005;
	bh=IJ2lEuV74eFW3VetmAOc9Er7xJsIH+58/HXpxW/mB/M=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=Eis3hRb6JyiJlwkA56JpKrAFIQ8DOFpUjb6nLnmAV2Mt8yaa0no21M4jw3sHJUvax
	 102frs06Hw/APlsMWwYSyxKbOvewU7DgwkLOndQLoAUdMyU/eWARqTlKVN03NKQsup
	 zhJPZ7hJyMZAffusfzZZe3TU39sxyCMgny3El9p0ZIzlXzKUCdT4jhXm9AzWvgGRAV
	 qLxBHeZmECmOU7FYLrAa5HqUzQbuEx082pqExl1uRQqil6VhsGrHdJk6L2jxE90DmB
	 WfCr6iO/9vqrhsPhIP/+QA8es3nPGMPh8QUdi0OVczIOJBZpeamWYgCHBthNkqwjtN
	 DS0G1dyYQ5Gsw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 96B9FD5B3C0;
	Thu, 18 Apr 2024 17:23:25 +0000 (UTC)
Subject: Re: [GIT PULL] random number generator fixes for 6.9-rc5
From: pr-tracker-bot@kernel.org
In-Reply-To: <20240418154717.427109-1-Jason@zx2c4.com>
References: <20240418154717.427109-1-Jason@zx2c4.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20240418154717.427109-1-Jason@zx2c4.com>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/crng/random.git tags/random-6.9-rc5-for-linus
X-PR-Tracked-Commit-Id: 3aadf100f93d80815685493d60cd8cab206403df
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: e4add02086a61247e9ff65a4600dd84a31aacc92
Message-Id: <171346100561.11189.8062412567602603821.pr-tracker-bot@kernel.org>
Date: Thu, 18 Apr 2024 17:23:25 +0000
To: "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Thu, 18 Apr 2024 17:47:17 +0200:

> https://git.kernel.org/pub/scm/linux/kernel/git/crng/random.git tags/random-6.9-rc5-for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/e4add02086a61247e9ff65a4600dd84a31aacc92

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

