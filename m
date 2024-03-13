Return-Path: <linux-kernel+bounces-102431-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E93D87B1F1
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 20:33:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 79CA81C27F29
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 19:33:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 888B45E083;
	Wed, 13 Mar 2024 19:28:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CmtM2hno"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFA2C54669;
	Wed, 13 Mar 2024 19:28:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710358089; cv=none; b=IINzKpT7lYZqaWfI7oLOxAilwDelT4/ot6lV/4ZhkxtLAC3DLX/hG34e0a1LucTkC0PVjGU+UuKHp4DpxNSAYoIF3G+YX3xo0ut3G3LPjQYP8cBoIpB6rRW2oI9EMEaegUs/G9+rARIwWBMBibIaPWf3efF+RRLYNI+D++y5oxQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710358089; c=relaxed/simple;
	bh=acsIB1GFjSJHw0csPzKs/s7ia2vCWYWIk48+tXsLiUQ=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=CVCCkNgGf2ME6sSAf6M05UHyW2Gd5QIlg1SqxIDslw3K4nk4AcnH5iPCxXQiVBqcAgUb34FrPafzuuMVSfV4LfD6qLVviY2w4PZVmEyitn6QPtYjb6ZXR08x9N8FbUbQhESdUwaCYLXMzRJTEsb9zPeXqE57w4e420bzoBIuXlo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CmtM2hno; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id B179CC433F1;
	Wed, 13 Mar 2024 19:28:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710358089;
	bh=acsIB1GFjSJHw0csPzKs/s7ia2vCWYWIk48+tXsLiUQ=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=CmtM2hnoc64MwqVXqBrWpqLJn+n7jxydClktc6bO8T2sXLgI/7bSqDssv4bTQrxdV
	 0tWoWI0HjhuC/9zq/lzLNSHBkGIHODfx2mr9mgR6QrQrn7kMP/W7Y2r/mKETjpf/1y
	 Lf4CgVW4IDorkSf65yGk/Dixr/3BUfSRoeFqBqDygIVwoMJ5+B0oAgbqJn9BI/HTqD
	 zwDdnBjnn3+DBXDKL5L0S0f12HYpEBvsHRv6H2pVRIiwN3O1qRgVcZ/nKMP08295XK
	 NIYEzJIjXORRJYcd8FiGt6D6f5sd6J4fEHlAGPdTjbXvu/2vUpUKb5PHfjfvdXhtPr
	 P2+Jx3xLq3ooA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id A1CDED9505F;
	Wed, 13 Mar 2024 19:28:09 +0000 (UTC)
Subject: Re: [GIT PULL] pmdomain updates for v6.9
From: pr-tracker-bot@kernel.org
In-Reply-To: <20240311154604.3069122-1-ulf.hansson@linaro.org>
References: <20240311154604.3069122-1-ulf.hansson@linaro.org>
X-PR-Tracked-List-Id: <linux-pm.vger.kernel.org>
X-PR-Tracked-Message-Id: <20240311154604.3069122-1-ulf.hansson@linaro.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/linux-pm.git tags/pmdomain-v6.9
X-PR-Tracked-Commit-Id: ccabbb6768fc72d6cb0223324925c93658d91e63
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: a070a08d006d142e2ae0bf73843dc90c2b42b02f
Message-Id: <171035808965.9850.3802535926862311932.pr-tracker-bot@kernel.org>
Date: Wed, 13 Mar 2024 19:28:09 +0000
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Linus <torvalds@linux-foundation.org>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>, linux-arm-kernel@lists.infradead.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Mon, 11 Mar 2024 16:46:04 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/linux-pm.git tags/pmdomain-v6.9

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/a070a08d006d142e2ae0bf73843dc90c2b42b02f

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

