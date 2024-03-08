Return-Path: <linux-kernel+bounces-97646-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DD21876D13
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 23:28:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4F07B1C2184C
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 22:28:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E024605C7;
	Fri,  8 Mar 2024 22:28:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PS+ZsCDC"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 922C160273;
	Fri,  8 Mar 2024 22:28:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709936891; cv=none; b=cgnpiTjmAhpZm7l/m0gV2j6eID3P36HFd6vu2/kePJq4toSyP2rxDPlqG6XW+32+Pgae2glpmJ5SgupsPkxdVrtSfSwbXUI/HKOuPeHb9G5F9MfF99dtHY8gMXewNkqN5S2BQ2qeMKiVChrcEk2iTJGsLUpqazOKh2ORzlcVn7g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709936891; c=relaxed/simple;
	bh=ciiZs7q1eA7AoVDXQLwAUf84ATrX4qskFdGSEyec+yw=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=ttgx76Xu1OCVC4myR7rkxR7btf/oDkRY1okH1C0VmJRsqTTRT4NRPR+yUs2aAqxRFPVg4TDFfaNwSorGXJTUlgvHrUwA/o70KVHk5c6uZBSQddC+92g5T0Y2QzTaSDbnSXCrHzU5JHV3kdfwKrhmxsdzuYR2H5v+0KfmaRwt104=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PS+ZsCDC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 634DEC433F1;
	Fri,  8 Mar 2024 22:28:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709936891;
	bh=ciiZs7q1eA7AoVDXQLwAUf84ATrX4qskFdGSEyec+yw=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=PS+ZsCDCIMtGrxhGdX5psVFkRYllePOszcKiO5k9b2tb4EadOgTJgsSu3KL0YlEUR
	 jWLQd2Lr+e6V1mecgcJ29k10FeysWo+G3Djd3V+KhLJ0tZF+ZgnF0FkLvX738MfrMd
	 +HoAzg8vjdIF7+SslVKQzJiDkugB344a7mglvSJOIBH/p/fvjzsMgBOPfnCS+v9hm3
	 0cjYDYbAI0TIVytNFpxIuVDA6Hm318F8GzgkzemIAIgoqKbY7iDOY1tCrW1M09dPn8
	 gxBGrC7w938PuOaYCsGtPGeDwcTiKHsNWYeM4Px5YOBshSK54UGuAjVwcOK72YIHSI
	 UOa2ZtKppMJLg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 50380C39562;
	Fri,  8 Mar 2024 22:28:11 +0000 (UTC)
Subject: Re: [GIT PULL] sound fixes for 6.8
From: pr-tracker-bot@kernel.org
In-Reply-To: <87plw4vrq1.wl-tiwai@suse.de>
References: <87plw4vrq1.wl-tiwai@suse.de>
X-PR-Tracked-List-Id: <linux-sound.vger.kernel.org>
X-PR-Tracked-Message-Id: <87plw4vrq1.wl-tiwai@suse.de>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound.git tags/sound-6.8
X-PR-Tracked-Commit-Id: 21e59fe2f7221cdc77b2e5ef90a04c302b237053
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 6dfeb04c467826fe6f808827e19abd5c6336a08d
Message-Id: <170993689132.2485.3610301827665451838.pr-tracker-bot@kernel.org>
Date: Fri, 08 Mar 2024 22:28:11 +0000
To: Takashi Iwai <tiwai@suse.de>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Linux Sound Mailing List <linux-sound@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 08 Mar 2024 13:21:58 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound.git tags/sound-6.8

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/6dfeb04c467826fe6f808827e19abd5c6336a08d

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

