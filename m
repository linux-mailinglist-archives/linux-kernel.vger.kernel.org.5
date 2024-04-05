Return-Path: <linux-kernel+bounces-133575-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EAF689A5E6
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 23:06:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 36B2E283626
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 21:06:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EB56174EF4;
	Fri,  5 Apr 2024 21:06:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KXB12Ojk"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99CB3174ED4
	for <linux-kernel@vger.kernel.org>; Fri,  5 Apr 2024 21:06:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712351165; cv=none; b=tSDrdg+qat2EG6zwXRqgIC8yfMSLXuOj/AV3N40ajE/bH7cJpz7sj5wDWq5lOMmLyXuKLlV5usormwSZyekAr63nJ8IRbJJFRgboMgPyz8rsZvlgLl1qYVU1uQEQpFmb2lRzo2QILJG51yG8jjfTWZweUfNnVqO/fkKrfpgkFq0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712351165; c=relaxed/simple;
	bh=EcAUdrnqXJ9PBGU3ettWpVPFTJUJD/euERO6tJnwADs=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=YgVV1z/YuTRZ/qh/7l9p+k9Qu2WWGphQ+f2tKwUQTgPy9Es0lwVQMEyyqv1vxyj/4Hp2LYMCM5RgHq2RbAvT2jvQNjst89zSlv4xS77L7t7I219L+VwlQRlcst7LhjFc+6sElt3FQ9deCqRdgSfh3Iwpg4sS/Zd2auAuh3rGCaM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KXB12Ojk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 1ABBAC433F1;
	Fri,  5 Apr 2024 21:06:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712351165;
	bh=EcAUdrnqXJ9PBGU3ettWpVPFTJUJD/euERO6tJnwADs=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=KXB12Ojk6ENatCkMXXg8hQSqkJw409x96w/lMzmZ6AF8EhVObjljFS4ZZGkrbtup+
	 /ZfkN6ZEQ88BdQQtEtAgnO8ma9ECbVyFzfXGBQwB7L5cf0dKipMY9AmGGiDWMdDxVR
	 wAcvzV7n8oaC7acwWiVidDrjm3YEhktPQv1DjdmxwmK3ftE1wczdRRVbbqipgcYuvX
	 WWzB/HTbup4HRbNbU5yJUJOzaMCe78lPUiH1iVkQkAIcPnWZaxuWKZLTTt0MCofiKA
	 L8fFt8XBMsQmXwT/Ow1cbuFuhLdOEDV04jpW8lNMLohVeLoypnWmbv0gWKl6XW8R2d
	 5Tw3VWkBwHPEw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 12E19D8A100;
	Fri,  5 Apr 2024 21:06:05 +0000 (UTC)
Subject: Re: [GIT PULL] arm64 fix for 6.9-rc3
From: pr-tracker-bot@kernel.org
In-Reply-To: <ZhA9tWAmdQ0LGg8t@arm.com>
References: <ZhA9tWAmdQ0LGg8t@arm.com>
X-PR-Tracked-List-Id: <linux-arm-kernel.lists.infradead.org>
X-PR-Tracked-Message-Id: <ZhA9tWAmdQ0LGg8t@arm.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux tags/arm64-fixes
X-PR-Tracked-Commit-Id: b017a0cea627fcbe158fc2c214fe893e18c4d0c4
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: c7830236d58e9e982f3e180f054cfbc14788beca
Message-Id: <171235116507.3156.3596926036726564434.pr-tracker-bot@kernel.org>
Date: Fri, 05 Apr 2024 21:06:05 +0000
To: Catalin Marinas <catalin.marinas@arm.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Will Deacon <will@kernel.org>, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 5 Apr 2024 19:06:45 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux tags/arm64-fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/c7830236d58e9e982f3e180f054cfbc14788beca

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

