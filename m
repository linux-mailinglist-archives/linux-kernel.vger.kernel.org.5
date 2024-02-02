Return-Path: <linux-kernel+bounces-50570-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A3CB847AE8
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 22:01:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EB860284ADE
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 21:01:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FF4585925;
	Fri,  2 Feb 2024 21:00:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KrH23P0m"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 614838061F;
	Fri,  2 Feb 2024 21:00:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706907621; cv=none; b=iwlzlnTSexftHYLZxaFFdL42Rf+g/mni0BqdOFTTudOmpQzlO5U607SnmYiUl+8lOvs3p4Wx5VNwkxXg4aIbIdb8K6w2I2Us7cV7+bsrHXcISlTpzzzl5rp4FaMbICJV5W0v9MMnxiB1spPUwubKv2Jrt7p8+g24T/98QmNGQ2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706907621; c=relaxed/simple;
	bh=OQ5nbFiEtivjhJxUZSfz9gQDcLZLItn5nCWd8cF0eD4=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=UpU1+q92dd5cY9KB2CtW5U38Wr9myhz6D3lDf6ywsryTuzyXA6NxNUL8IGzdn1WInF9sM3O8dwtmnVwHOvxUbZrfhr9OBUBnchpn2ETCvZIUOBGTX8gP/Soaxd7T52P3CvX+0H+5hyWykaXkwu07SX2imzdx6WFvreUz0Od6iUY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KrH23P0m; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 42E54C43394;
	Fri,  2 Feb 2024 21:00:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706907621;
	bh=OQ5nbFiEtivjhJxUZSfz9gQDcLZLItn5nCWd8cF0eD4=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=KrH23P0mKqLVgIzZYi1tBCO3+1LuzgOAiUl1pk0kIp+6KusMk/bUp2rAsqnEG0vhY
	 ZW9ChkNI97h5fK1hLJuElAe+Q5Hb9/ZDU+gkbBgIsfchs/Wd0yk/Jw336jnv20kqUC
	 ihbNZqjkQZL7wAjuSG7Yij95w+jl24+/vsCdetMbN1gw238HPWkxsx/YugXe5ZFl+3
	 1TmAj5Ag2zY8c0tUhdl8F9/gR71eXBmC69XbUyYu7TfyVDHjQBYqJ3PMLC8l5mjTGq
	 GTETkdKZART4MqaUQPcS7D/Xj6nMJ/5F7s/eJFJICBpwAXPrtnF11HmDUmd2vu6syo
	 /KB5GRmLq16tQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 2D103C04E27;
	Fri,  2 Feb 2024 21:00:21 +0000 (UTC)
Subject: Re: [GIT PULL] sound fixes for 6.8-rc3
From: pr-tracker-bot@kernel.org
In-Reply-To: <875xz7e0fs.wl-tiwai@suse.de>
References: <875xz7e0fs.wl-tiwai@suse.de>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <875xz7e0fs.wl-tiwai@suse.de>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound.git tags/sound-6.8-rc3
X-PR-Tracked-Commit-Id: d4ea2bd1bb502c54380cc44a4130660494679bb8
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 01370ceb2ae66ffc1b35dd4907bf1f6009bac200
Message-Id: <170690762117.8980.12652723445190810749.pr-tracker-bot@kernel.org>
Date: Fri, 02 Feb 2024 21:00:21 +0000
To: Takashi Iwai <tiwai@suse.de>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Linux Sound Mailing List <linux-sound@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 02 Feb 2024 09:26:47 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound.git tags/sound-6.8-rc3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/01370ceb2ae66ffc1b35dd4907bf1f6009bac200

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

