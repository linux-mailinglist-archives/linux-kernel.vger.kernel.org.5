Return-Path: <linux-kernel+bounces-110887-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A0E888653F
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 03:42:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6C4721C2384E
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 02:42:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4C0563D5;
	Fri, 22 Mar 2024 02:41:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Rua9JkoT"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3868253A6;
	Fri, 22 Mar 2024 02:41:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711075308; cv=none; b=W/mT9H0HlrqSYwSdvfGRZwHln9G5X/jbrqqylK0O+DvobbotfTc+NOOff8ZqpuhabLHf5At0Jr4SdeLwX4oy7f2bxGeerubLw356J/L3D/BvrQjli1iYWPYzKC8fySXZT3OqUvrHa35UhNug29nnIp+swoE+ikSDuDqzXfKHW1w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711075308; c=relaxed/simple;
	bh=uQuVBu3KsSi8aaJrHc5aeNQDx744s8a5OAeHpim8S44=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=J4SR5sQ/CQ7g8+sNpC0qFg4UPFjeXnYKGuPGbOvIKbGmOo4MfobaymlCszw8Et/e0JnIfeM1Dydt+1HX6Kk14e7GIgeOpIXVTnoDL1KygME/xdkaLcJYKjZ/oEqqJdyDeZp0On4tD9VC1yWnylZpn/Y7swFdio5YL1oBuZ+YBQs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Rua9JkoT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 15E1AC433C7;
	Fri, 22 Mar 2024 02:41:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711075308;
	bh=uQuVBu3KsSi8aaJrHc5aeNQDx744s8a5OAeHpim8S44=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=Rua9JkoTFQZL2JYNR2iZyy5YxEupW4A07yW0JMLye3FjJD4LUyNmGW2yqkqETGI/R
	 FKGhGK0r1h5uxSu3JYaO4evB11b2aNlME5zorJO6DLEVDYrglCDCmzSeMi7aLiCS+J
	 xKBOsZCNexAtkOr6n/397NsoP0Q0rTC73kYgwPFa7KrUoDCleSv0UrYk6JrIKlpuh/
	 eJklR/8Jb5WHH+THdFycPqFIN9yP4asmFgMCJzMjaDnqFgu7ZfPcgKLDTCPzCGFzSC
	 5nIqPwyPyFYO/LCk2LSqBE7+PXySLQKhThJFL+wzJFQlHxc1rzQo5G4fXel7Nl82lW
	 wmU7/KmKCgpCw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 0F452D982E1;
	Fri, 22 Mar 2024 02:41:48 +0000 (UTC)
Subject: Re: [GIT PULL] smb client fixes
From: pr-tracker-bot@kernel.org
In-Reply-To: <CAH2r5mtMVc02DmB_hw_j49o6YQSD7Jwr4tbSMuTjxX5L7ZgkVA@mail.gmail.com>
References: <CAH2r5mtMVc02DmB_hw_j49o6YQSD7Jwr4tbSMuTjxX5L7ZgkVA@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-cifs.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAH2r5mtMVc02DmB_hw_j49o6YQSD7Jwr4tbSMuTjxX5L7ZgkVA@mail.gmail.com>
X-PR-Tracked-Remote: git://git.samba.org/sfrench/cifs-2.6.git tags/6.9-rc-smb3-client-fixes-part2
X-PR-Tracked-Commit-Id: e56bc745fa1de77abc2ad8debc4b1b83e0426c49
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 8e938e39866920ddc266898e6ae1fffc5c8f51aa
Message-Id: <171107530805.27086.3884323933850117088.pr-tracker-bot@kernel.org>
Date: Fri, 22 Mar 2024 02:41:48 +0000
To: Steve French <smfrench@gmail.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>, CIFS <linux-cifs@vger.kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Thu, 21 Mar 2024 20:55:53 -0500:

> git://git.samba.org/sfrench/cifs-2.6.git tags/6.9-rc-smb3-client-fixes-part2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/8e938e39866920ddc266898e6ae1fffc5c8f51aa

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

