Return-Path: <linux-kernel+bounces-29394-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 960DE830DAE
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 21:05:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2E76428B5A5
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 20:05:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7046925573;
	Wed, 17 Jan 2024 20:03:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rnvAe5Qa"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B85AD25552
	for <linux-kernel@vger.kernel.org>; Wed, 17 Jan 2024 20:03:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705521829; cv=none; b=MoR1Jt8LK5LXfJUdr3dWxGDxVu1+yeLhUUagnmhrxX/5q1p6j5t0y6kH+m8d7WJ3HJR9NwG0pYAiZYGdUHPnxX2DZn+Aba/wHlLp35WrXpyoe25FQWcNF3xncurAbX9rOP8vqYRiLaLSDMxib5cKyMK0d3DkXhLi/iYOx5i4PRM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705521829; c=relaxed/simple;
	bh=u/18+wrcOaSYpC+wdRWxxLpbbgLUNGOBSI18d5aWRoI=;
	h=Received:DKIM-Signature:Received:Subject:From:In-Reply-To:
	 References:X-PR-Tracked-List-Id:X-PR-Tracked-Message-Id:
	 X-PR-Tracked-Remote:X-PR-Tracked-Commit-Id:X-PR-Merge-Tree:
	 X-PR-Merge-Refname:X-PR-Merge-Commit-Id:Message-Id:Date:To:Cc; b=meLeHr9VpS7kitz97Z1JTK8HtrB2MUcxpn/Djh6hElhIrx3h3Q9MVlbh61kT/+nsRPUtdtYJkYptGHS1o2eoag0oyzIqsEJyeZhSP7T8dWL2WIjKTs8WP7JFCkQ6Pv2qrwd7IInu7xPRI5tEZQHUTUFhzpcAfiYfJxkW5OoT504=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rnvAe5Qa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 45A0EC433F1;
	Wed, 17 Jan 2024 20:03:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705521829;
	bh=u/18+wrcOaSYpC+wdRWxxLpbbgLUNGOBSI18d5aWRoI=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=rnvAe5QaJqWi7iK2z32HyuWTTv4m0ZkUeQWyUPwEUwsfn6/6nfrKHm0QL95S5LglS
	 uejai86Ag8QktvKoJ+abf2ONOgoshSTE3BmHcEQbZbcV6pflKeyAGbT6u4Iea5605d
	 P/PbRidSHD2sGVaT7xNM4Gqeq2lAc8QylkSGuaP1pC6PwhulxemYko+bOTItlix2WR
	 5r5SU5Y+2ohrCssM8tAy5ZI0vyNRNE9z+s2DxETxJS7i6A7T339JtFNMCShU+jIA9g
	 i9clbQAkuaXn6pqqlUVA8rGrSMMn2m5F+XMq7UxrGsv1WEDwAjC42suVoxoRSzXvzc
	 chqnSD5sjDEfw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 33586D8C96C;
	Wed, 17 Jan 2024 20:03:49 +0000 (UTC)
Subject: Re: [GIT PULL] UML updates for v6.8-rc1
From: pr-tracker-bot@kernel.org
In-Reply-To: <618175332.231559.1705178304902.JavaMail.zimbra@nod.at>
References: <618175332.231559.1705178304902.JavaMail.zimbra@nod.at>
X-PR-Tracked-List-Id: <linux-um.lists.infradead.org>
X-PR-Tracked-Message-Id: <618175332.231559.1705178304902.JavaMail.zimbra@nod.at>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/uml/linux.git tags/uml-for-linus-6.8-rc1
X-PR-Tracked-Commit-Id: 83aec96c631e0fa75cfe6d6a1b113a32151aaa88
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 6cff79f4b90a42d73f039564f09fa5d59ec3d8ab
Message-Id: <170552182920.2985.5913378982154556147.pr-tracker-bot@kernel.org>
Date: Wed, 17 Jan 2024 20:03:49 +0000
To: Richard Weinberger <richard@nod.at>
Cc: torvalds <torvalds@linux-foundation.org>, linux-um <linux-um@lists.infradead.org>, linux-kernel <linux-kernel@vger.kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Sat, 13 Jan 2024 21:38:24 +0100 (CET):

> git://git.kernel.org/pub/scm/linux/kernel/git/uml/linux.git tags/uml-for-linus-6.8-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/6cff79f4b90a42d73f039564f09fa5d59ec3d8ab

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

