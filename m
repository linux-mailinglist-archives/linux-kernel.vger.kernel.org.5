Return-Path: <linux-kernel+bounces-89095-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 184D286EA65
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 21:37:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AED2428B836
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 20:37:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08DFF3D0DD;
	Fri,  1 Mar 2024 20:37:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ewUDVgWN"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E6A73CF75
	for <linux-kernel@vger.kernel.org>; Fri,  1 Mar 2024 20:37:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709325441; cv=none; b=qQ50nU30wAvowBvue7qwvsp6E2urCKQ8SagBXiG3CstDKN+3+SF8RKU2sNt0qDOcd9JZmZS0WLiZmFDCx0DQ4v59i6rvw20SUEt+z7tUum8MicfMIq4suGYtvMsYyk6e4j7rrqhNxRracoGWjhpbV3rYneI1nIdssL4CWGbLfZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709325441; c=relaxed/simple;
	bh=VEfGe/8IbAGKsfqu4LEIt1VzKkHd31fLw8KOKPM3b/M=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=Y5qskzPT+B6l9B3KIBlDG07MECGom7shuC/l2eHiJFddXpwkFHVfRBCW8XeGjA75SZRfln6cCpxttj+grPQduUm420DjEqunBZg8NLHWdOnFzEPbNLX3k5PdG6BbyxGRfauxvbtMOLVxZGHQCxFruX0VR7jXMz2+gfUFmdoeVW8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ewUDVgWN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 2D03BC433F1;
	Fri,  1 Mar 2024 20:37:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709325441;
	bh=VEfGe/8IbAGKsfqu4LEIt1VzKkHd31fLw8KOKPM3b/M=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=ewUDVgWND/yRf3p5OT3IOQVTEpIhkDf7gDI2lJ8jdHLFBdmh3dbzbEhKqu/4NrVnf
	 HWMp3Q1VzGQP1C94doExBsGJL915in+P4keYC69i0gxwD7jb+IVei4cOBXJmyLVKvq
	 CT/HB/Qdp1vDkArAeyXS9Y+aRbZ4tVSdHbZklNjenRx0rFmUFhwgYuJfhUwfEgd3Xg
	 zeGz+ye1ARk0AID08lfYkmlWi+tHKYm+v3QoKeaWUnIiktBI1haPDs+SWM/R/XmFt3
	 aBVqikxtj1MglCTl6f1lkoYheDlMcItjo2grmajbPn3teR0DLYY67q3NnlCGL8K/vi
	 ItWku+fAMHv3A==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 10FCEC595C4;
	Fri,  1 Mar 2024 20:37:21 +0000 (UTC)
Subject: Re: [GIT PULL] exfat fixes for 6.8-rc7
From: pr-tracker-bot@kernel.org
In-Reply-To: <CAKYAXd8Jsoq=62ZaJxniETCexEFGxn3cBS42gdibuKYTJxbJkQ@mail.gmail.com>
References: <CAKYAXd8Jsoq=62ZaJxniETCexEFGxn3cBS42gdibuKYTJxbJkQ@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAKYAXd8Jsoq=62ZaJxniETCexEFGxn3cBS42gdibuKYTJxbJkQ@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/linkinjeon/exfat.git tags/exfat-for-6.8-rc7
X-PR-Tracked-Commit-Id: 3a7845041eb7235f2fb00ef0960995da5be63b11
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 3aec97e0c793353318235b5e9031f91b8f09241e
Message-Id: <170932544106.4935.15146100712331779711.pr-tracker-bot@kernel.org>
Date: Fri, 01 Mar 2024 20:37:21 +0000
To: Namjae Jeon <linkinjeon@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Sungjong Seo <sj1557.seo@samsung.com>, "Yuezhang.Mo" <Yuezhang.Mo@sony.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 1 Mar 2024 16:57:13 +0900:

> git://git.kernel.org/pub/scm/linux/kernel/git/linkinjeon/exfat.git tags/exfat-for-6.8-rc7

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/3aec97e0c793353318235b5e9031f91b8f09241e

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

