Return-Path: <linux-kernel+bounces-123873-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 74CDD890F1A
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 01:20:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2B5541F23361
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 00:20:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CFE210A0A;
	Fri, 29 Mar 2024 00:19:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bsBV+tzJ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FFFB11CA0;
	Fri, 29 Mar 2024 00:19:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711671594; cv=none; b=m4dsVLaBbEhKT3enrxkLuzxtngXe0YT3/d08He7ZaU1d3mdmdtI4cO49ZGZMZhSLoVibiy2vsABmjc4nsb2WOx089WO8cDBoetVrwqqEaRtAeR3ldnmM2coJextf6svLYppXKwCp4PnK5cI3jfmahTU4ariVp1khsaL2qhrVzVQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711671594; c=relaxed/simple;
	bh=OCN5b3oKBqA5v8QFTEzu5JZAsBj8FlhKRX7u8VIemYc=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=eCucArcJQ1zdM3mFGT6il+kAAOU7/tg8iuUSu7HcuSD9bIL7eweSckA5DCAFDxfHMcq7yTsjvagTHxbItejuZ3mdkaP1tU5YFZlwvc1hIYFxh2SNDedlTdQSHrrO8GQbLe/KQlRLEV+4uv1BeLAJnA2yKTR+b/XH3bDeUn3ex98=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bsBV+tzJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 2A8C4C433C7;
	Fri, 29 Mar 2024 00:19:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711671594;
	bh=OCN5b3oKBqA5v8QFTEzu5JZAsBj8FlhKRX7u8VIemYc=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=bsBV+tzJZ/Q/RNuri/LAU8B42qRI4LvGQcNgzzV8lVyasAGqGQ997Ts2R/I5IJJ2H
	 FecnZrBUVjgCooNxeesp/JjGKeh6Zndh90mCQ3vKAk2Zkow5d5d02RYwP2e76yZ+h+
	 MNnaN2bi6KfxxdH7EzsfjqzsDeEM0eZflzfwvnm0GM7SXXJmI3/VvLkbnivbL/fhzY
	 JpwDYFXl+S8HtfXfpAPi5reh57WHbjEUYo42oTquSFp4Ty8egyvAw/XPpJYuvrEzyN
	 BwjWiwzL282aChn8diCAA9vjtAJp/d8GEDRMILgyQ/z857PEpr1WGJmJ97AwaJvBFp
	 mGcneDoUHbv2A==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 22DDED2D0EB;
	Fri, 29 Mar 2024 00:19:54 +0000 (UTC)
Subject: Re: [GIT PULL] sound fixes for 6.9-rc2
From: pr-tracker-bot@kernel.org
In-Reply-To: <87ttkqag3s.wl-tiwai@suse.de>
References: <87ttkqag3s.wl-tiwai@suse.de>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <87ttkqag3s.wl-tiwai@suse.de>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound.git tags/sound-6.9-rc2
X-PR-Tracked-Commit-Id: 1506d96119eb9454d64f5ae80ab8d04c1594ac25
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 529b10c0091d6bda6d54fc72711a28f3ea01a72c
Message-Id: <171167159413.21457.6579665218232911518.pr-tracker-bot@kernel.org>
Date: Fri, 29 Mar 2024 00:19:54 +0000
To: Takashi Iwai <tiwai@suse.de>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Linux Sound Mailing List <linux-sound@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Thu, 28 Mar 2024 09:57:27 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound.git tags/sound-6.9-rc2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/529b10c0091d6bda6d54fc72711a28f3ea01a72c

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

