Return-Path: <linux-kernel+bounces-50567-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F42C847AE1
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 22:00:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CEFA4284AB6
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 21:00:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F1CC8063F;
	Fri,  2 Feb 2024 21:00:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S+d9jS/J"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F9CB80606
	for <linux-kernel@vger.kernel.org>; Fri,  2 Feb 2024 21:00:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706907617; cv=none; b=oiDBnhXTa7emFTiaMyG8q1XLoWkZXZCAGOJPUbd2ZFBlYihrw2gqvZ+7sAyV6fnby1H7XG3PXsUrj1sNA3UjtmHbokM6RoYuMkhxEm8QL7E0QrbzI57LdC3SuHUbmQqd380cATZroPgpmW5iTb8hFzjzzeVvClMVbHYAb3aB3Gk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706907617; c=relaxed/simple;
	bh=3z8ofmCzYvF8tXaXQSGvPhJt+e5NgjIcmMFgWYE3r04=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=lCWADEaTiW8qlGfJTsycz+Zc3ZrHbDHMq1roqkVgc3Z893pifa5eS8C7my2f4359Pb41MW/kAclwfhq+OczAJND44xkjJOBKEQS7JuuRl0nB3vZi9lPQhTtQH40jsREd3J0C9oVw230gsBc+FSLTmIpukRmq9ea8KWGnonGZCYQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S+d9jS/J; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id D6604C433C7;
	Fri,  2 Feb 2024 21:00:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706907616;
	bh=3z8ofmCzYvF8tXaXQSGvPhJt+e5NgjIcmMFgWYE3r04=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=S+d9jS/J1xlsU2aBhTHuTmp0NwpzOcSJpPoCe1P9f9CXhIoV4NJA3rv0GHeEb+DuR
	 k72sIX/2AcvXmqRGW1jexPgvDSezBc/D+6TIH6NTfg74camxZGFfzKDvqzWApe5goQ
	 E/6zPUCHI5Um73LcEavhYgOeOCGOiBHWe+KCymEE2ctl+X0AXTusBVRRy8H5KwFaxn
	 eIchGSGeUq+ZB0GuLMoYRAusxufwWjsEaI1ch/1EvovrqmR6FMIGZQWxe4apRZPJAM
	 iWQJsoiTBTFJnxa8WPrg+5xFOzofrqYF5nOQ0Gjeuv07DP8xROwHoccCFL65hEuwl3
	 a177byKdxvdZg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id BA7B4D8C978;
	Fri,  2 Feb 2024 21:00:16 +0000 (UTC)
Subject: Re: [git pull] drm fixes for 6.8-rc3
From: pr-tracker-bot@kernel.org
In-Reply-To: <CAPM=9tyM-ERLs5LuMP_QOuJPtR6Yf4f_ON-0dHBd0B-fBVu-4w@mail.gmail.com>
References: <CAPM=9tyM-ERLs5LuMP_QOuJPtR6Yf4f_ON-0dHBd0B-fBVu-4w@mail.gmail.com>
X-PR-Tracked-List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
X-PR-Tracked-Message-Id: <CAPM=9tyM-ERLs5LuMP_QOuJPtR6Yf4f_ON-0dHBd0B-fBVu-4w@mail.gmail.com>
X-PR-Tracked-Remote: git://anongit.freedesktop.org/drm/drm tags/drm-fixes-2024-02-03
X-PR-Tracked-Commit-Id: 39126abc5e20611579602f03b66627d7cd1422f0
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 9c2f0338bbd132a4b12b988004d796798609d297
Message-Id: <170690761674.8980.17837173192749581139.pr-tracker-bot@kernel.org>
Date: Fri, 02 Feb 2024 21:00:16 +0000
To: Dave Airlie <airlied@gmail.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Daniel Vetter <daniel.vetter@ffwll.ch>, dri-devel <dri-devel@lists.freedesktop.org>, LKML <linux-kernel@vger.kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Sat, 3 Feb 2024 05:46:00 +1000:

> git://anongit.freedesktop.org/drm/drm tags/drm-fixes-2024-02-03

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/9c2f0338bbd132a4b12b988004d796798609d297

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

