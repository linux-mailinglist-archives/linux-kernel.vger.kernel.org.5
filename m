Return-Path: <linux-kernel+bounces-78996-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BDDA6861BF5
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 19:44:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 792442841E7
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 18:44:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D0E0143C78;
	Fri, 23 Feb 2024 18:44:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JskIj9bT"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5FD2143C4D
	for <linux-kernel@vger.kernel.org>; Fri, 23 Feb 2024 18:43:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708713839; cv=none; b=M1EJz/v+q3M7AawQwZsgn2cm9K1kE+pDQEFCaapgKLtZVHiyAlmPpS7QZdEP7CSQoVHz0pHUOLZoJfGJRSeEd9qf/giYoKX6H8l6WM/sc9kv34faUHuLjw1zuwYJRJLkP41JWPNhj9paPgwUx5xA69d65Yp1r4jBlTe7C84O1Ek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708713839; c=relaxed/simple;
	bh=xwhC1q2OH8q1Wg/lJNrUdbwYB/T54zVwQfjfRqupRAQ=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=C0NmUZchTZotpzLMtAXGEolPEFrcoFzCo0Kyp8M6Hxfhk5NGcP+UjH6fX8MeChb7jtx1nD5KkYs8bEvQJCXizul7mbmvW1joI8gPV80UrbnyqMBZFym92YLRbTEu2NK6ugHMJDmgfat8Bkh7Qkuf1BskspPzhhbHJdMzfA99i64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JskIj9bT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id BA1CFC43390;
	Fri, 23 Feb 2024 18:43:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708713839;
	bh=xwhC1q2OH8q1Wg/lJNrUdbwYB/T54zVwQfjfRqupRAQ=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=JskIj9bTq7wzw+w5Kb6u9Jai2jg0GAmYPu2HB+zdoWeAAjtrfQQRrIj2p0Q9pAjoY
	 KbfH4OPRWQ7o/82MjtQ+hwg34CsmMpgJmhzQ5ovLuCTMls9T7mGH7NlXCRH0tH8tdj
	 vVxiXdcrERg0wQ5vkvSY6KoaOb7Pm5HCDkKvQW4ev7x+T7P6DsK53V8NjAz+08o7sJ
	 DCGkqaZCtDcT28qOfdv1S8Dz5nFLY+BG0akJEO1n0RbZ1fTzFinhjlaIlDNoEXiSa7
	 uiIEyWR5Aq2200YJCEyMJLJnpQkaI4TjYEJQsU7QO1ee/50IN78kdLaA7vP5lywjdZ
	 y1SITRG7EKDDw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id A97CBC39563;
	Fri, 23 Feb 2024 18:43:59 +0000 (UTC)
Subject: Re: [git pull] drm fixes for 6.8-rc6
From: pr-tracker-bot@kernel.org
In-Reply-To: <CAPM=9tzmzFd8UsKbpvo0vMh08DmgKMNgOCVZ-T5KgfZHyw-4bw@mail.gmail.com>
References: <CAPM=9tzmzFd8UsKbpvo0vMh08DmgKMNgOCVZ-T5KgfZHyw-4bw@mail.gmail.com>
X-PR-Tracked-List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
X-PR-Tracked-Message-Id: <CAPM=9tzmzFd8UsKbpvo0vMh08DmgKMNgOCVZ-T5KgfZHyw-4bw@mail.gmail.com>
X-PR-Tracked-Remote: git://anongit.freedesktop.org/drm/drm tags/drm-fixes-2024-02-23
X-PR-Tracked-Commit-Id: 72fa02fdf83306c52bc1eede28359e3fa32a151a
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 06b7ef70b1f29de685ea80f0c1b8f0a0b0e16d18
Message-Id: <170871383969.26987.10729430010375333667.pr-tracker-bot@kernel.org>
Date: Fri, 23 Feb 2024 18:43:59 +0000
To: Dave Airlie <airlied@gmail.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Daniel Vetter <daniel.vetter@ffwll.ch>, dri-devel <dri-devel@lists.freedesktop.org>, LKML <linux-kernel@vger.kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 23 Feb 2024 11:32:09 +1000:

> git://anongit.freedesktop.org/drm/drm tags/drm-fixes-2024-02-23

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/06b7ef70b1f29de685ea80f0c1b8f0a0b0e16d18

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

