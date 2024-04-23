Return-Path: <linux-kernel+bounces-155589-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B1FFF8AF480
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 18:44:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6239B1F2666E
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 16:44:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D39D913D510;
	Tue, 23 Apr 2024 16:44:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JDzVq2m/"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22C2613B78A;
	Tue, 23 Apr 2024 16:44:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713890654; cv=none; b=dCVl3rcCE5XCQ1PWwO+BIHmWfInM6uV1uddwfcqv/G27cr/pI/uh1SPnQp3tPo5HjnPdJiX9SPUplAP/21T9GEHGMuVCMIgwszR7WS94AA7Ha002PGyO93P8phKwcj9YvzFBdFzKb9Fhy9onWbQ5FVLGLLgexIymKxRhhnXMN7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713890654; c=relaxed/simple;
	bh=+BAcbsuZcryChWyguKdPj+p3YVDJbsQh5L97uupUSIY=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=O9t3+IHulQBH3jJIapY3LVTyNVSkesLi+y5llfChvCqvcllvfMiipDDZzwBAv24bXSHbAhvL5PH8hNyIiHfrXeeBHCw9WsHj88Ueu9Xtvcj0avqz3/kJyauOM/O96JerPiDgOAuVRCfAqUwGvPT4GmaY66FbCSLSNeqTirRddLM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JDzVq2m/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 93CF8C116B1;
	Tue, 23 Apr 2024 16:44:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713890653;
	bh=+BAcbsuZcryChWyguKdPj+p3YVDJbsQh5L97uupUSIY=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=JDzVq2m/C4LGltKXMkqBOuBJbC2abWwAYPtQXC1+2gltAWMRpcYA2qi1V8LKoU3HL
	 W+5mWemPnvihpfn3Rx724QIrbStM3AQCWz5wJ0RL12igFfesu2Jjo5VeVZGu0NZDTl
	 B5SgV2WFCHzCeCatybFGwyJIsho2jDPe93EAabq1PKW/ZF/y+YbfYk1UMFIpbZr7SW
	 LgTRrnwVrcmRF2wtMmCmQHBhw/R458PJOV8N0dc8YWVT9U1kyuxZsbKZUuIpsDvlFc
	 AlKAfBRbBhw4zCNQmqI6EqL7Bw3wiEQXADsfWg8cpNyZBvAqic+6TC+8xIxx+i+uaW
	 Ld7nzJGE/jIzw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 8804DDEC7DE;
	Tue, 23 Apr 2024 16:44:13 +0000 (UTC)
Subject: Re: [GIT PULL] smb3 fixes
From: pr-tracker-bot@kernel.org
In-Reply-To: <CAH2r5muJrPsupmdXDDVV8vNjifZDnyrQoSHJSTDAUUckrX7JEw@mail.gmail.com>
References: <CAH2r5muJrPsupmdXDDVV8vNjifZDnyrQoSHJSTDAUUckrX7JEw@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAH2r5muJrPsupmdXDDVV8vNjifZDnyrQoSHJSTDAUUckrX7JEw@mail.gmail.com>
X-PR-Tracked-Remote: git://git.samba.org/sfrench/cifs-2.6.git tags/6.9-rc5-smb-client-fixes
X-PR-Tracked-Commit-Id: 77d8aa79ecfb209308e0644c02f655122b31def7
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 9d1ddab261f3e2af7c384dc02238784ce0cf9f98
Message-Id: <171389065354.9096.9105669446545071338.pr-tracker-bot@kernel.org>
Date: Tue, 23 Apr 2024 16:44:13 +0000
To: Steve French <smfrench@gmail.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, CIFS <linux-cifs@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Mon, 22 Apr 2024 23:27:33 -0500:

> git://git.samba.org/sfrench/cifs-2.6.git tags/6.9-rc5-smb-client-fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/9d1ddab261f3e2af7c384dc02238784ce0cf9f98

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

