Return-Path: <linux-kernel+bounces-60207-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CE93850170
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Feb 2024 02:15:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8FAE41C21BAF
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Feb 2024 01:15:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACB8B4C81;
	Sat, 10 Feb 2024 01:15:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XI3oh/wu"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC3915231;
	Sat, 10 Feb 2024 01:15:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707527725; cv=none; b=k375kvRnPPMXMB3iKfsZrUaasHnosEauon2YhnXEFVDVs/OvCRA1CDDmbMUB89NFrCpBQrQNuLFVkRdQc5rTxYEotQ8BBfP9d52sRimsuHc5CEPzvGvT6e7mYDwRNP4qI1FSSMYmgHiyFLGZq2uWASdZrID7kJgEP6YCJOuv+3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707527725; c=relaxed/simple;
	bh=gNjc5lqSPkqehnfCQy5PrJNDIhARM8U76FIHC5s6cmU=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=e6O2G5fkvtMn7h4ncT8X8PAfU5nLzKfB5WLj4P122uSbmc1+XGEIO19cJOxmGub5BqRK0BEVpgDfqFsvIw+c0uia3OTJxztZOeDs73oN+nYCJfRkhV4S0peod77G2VqZ7zgLOsNF+221RupE7+fiNoM9fBDGaElfW1G7oDRhBNk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XI3oh/wu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id BEEFEC433F1;
	Sat, 10 Feb 2024 01:15:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707527724;
	bh=gNjc5lqSPkqehnfCQy5PrJNDIhARM8U76FIHC5s6cmU=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=XI3oh/wuobVIkaCoqQX9KuCFme11wgfEKM/FA8c6PcpcMB65bMr9sGYzvXMym9CFb
	 G0oLWy9xb2WR3V7MrXPRTfLODBTd7s7XJwy7bw+q7O+za2y940C2Op1Eo8iHLOm40q
	 3KaoGolDuqm8tkM/MFpQWZY0qCKc8DGuNq105hzU8rp7qzK68f/l8+METZghHCWuKJ
	 F9NYqHdCobcK8RPalL5f6TOq++Kcx6qeGcky78XknlrLiS253Jr1cMeQNgp0cyavSp
	 b2SULRBeOnsAj70JPKigskFm51XYMGEZt2T36TCCzytRCK+jrZnbB5/SCVCWA6hTv7
	 oldfkp5X1mO5A==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id ABDE7E2F2FC;
	Sat, 10 Feb 2024 01:15:24 +0000 (UTC)
Subject: Re: [GIT PULL] smb3 client fixes
From: pr-tracker-bot@kernel.org
In-Reply-To: <CAH2r5ms4uMTJ0V-eLhFcrpQe8f-LYYr-PLp8ixGyXwaWzjxH7w@mail.gmail.com>
References: <CAH2r5ms4uMTJ0V-eLhFcrpQe8f-LYYr-PLp8ixGyXwaWzjxH7w@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAH2r5ms4uMTJ0V-eLhFcrpQe8f-LYYr-PLp8ixGyXwaWzjxH7w@mail.gmail.com>
X-PR-Tracked-Remote: git://git.samba.org/sfrench/cifs-2.6.git tags/6.8-rc3-smb3-client-fixes
X-PR-Tracked-Commit-Id: a5cc98eba2592d6e3c5a4351319595ddde2a5901
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: ca00c700c521916bacf7d490a2a5fd908059a927
Message-Id: <170752772469.5962.8755705835672632205.pr-tracker-bot@kernel.org>
Date: Sat, 10 Feb 2024 01:15:24 +0000
To: Steve French <smfrench@gmail.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>, CIFS <linux-cifs@vger.kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 9 Feb 2024 18:33:12 -0600:

> git://git.samba.org/sfrench/cifs-2.6.git tags/6.8-rc3-smb3-client-fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/ca00c700c521916bacf7d490a2a5fd908059a927

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

