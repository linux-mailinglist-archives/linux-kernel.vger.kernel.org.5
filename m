Return-Path: <linux-kernel+bounces-80247-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CC053862C82
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Feb 2024 19:46:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 38646B20E47
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Feb 2024 18:46:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB54A18EB3;
	Sun, 25 Feb 2024 18:46:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Wza4mBh9"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E86C28F66
	for <linux-kernel@vger.kernel.org>; Sun, 25 Feb 2024 18:46:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708886766; cv=none; b=O2dtZE5YOjNYeAtRrl7ps6bGOfwkegdbPJK7Bo2bBu0e721tse9KRPW28IsiZbmYVB8MSJwbw1cnGpLtZO1gqGlB5xq2c2nwZXkNIR78+xJsZv9azDEoYSOq94cuFfnkz3yJJE12JFXqWTfafQTpMaDph4c/uoKVGU1McWFAiTk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708886766; c=relaxed/simple;
	bh=K+lFGVwfXeK+9qFubsXetoUjb4RHFuGoIKwzd++OZH8=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=c12qr4GM3j7i1qOr66cg92/klbtqTAMJJmnkYQQbVsIF0KukbEgrB6YXAUOGzzZMG/3PyBGmNWZPAuJ764UP2PYghF6/ldmAgmFxMgM9TGrm4D4JC9ggfawPg7IexovV989cnQGWiy6xwHTn4zn49aKRshCbOrL6JH6W8oyi3OU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Wza4mBh9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id BCC2FC433C7;
	Sun, 25 Feb 2024 18:46:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708886765;
	bh=K+lFGVwfXeK+9qFubsXetoUjb4RHFuGoIKwzd++OZH8=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=Wza4mBh9wX3P9o8NcR+ba65rX4ng8Dt2pCL9ezcEdEJW1zMaoB52OVqD+1HmLW3Rm
	 TrPEpmz5wZEx8JYUJ4mgxf7koOdcEMF6BndjZysWNslVWtfLTux3fBC1ko0zgVu1UG
	 aJnInRS5jEK/7C/tA4DGJJvu4fPhLReXACc06O2oy61iQDxIngm6nR46Pw0cDqo6dH
	 crdb4pnckm77WmaW1VylWqE/A8sxBuKEVsqLvKJk3dO+6plcD/yLvky6YX33t8S5Db
	 4OPYnrzJTvLxhb8UZs2tYWBLceYrzkvQo9kHkiqJzDQZjSy3NkQWcDL7szlCzB1tKX
	 yEymw4wILGs7w==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id A25BCD84BBB;
	Sun, 25 Feb 2024 18:46:05 +0000 (UTC)
Subject: Re: [GIT PULL] x86/urgent for v6.8-rc6
From: pr-tracker-bot@kernel.org
In-Reply-To: <20240225105320.GAZdscIJ3wxkU8_6At@fat_crate.local>
References: <20240225105320.GAZdscIJ3wxkU8_6At@fat_crate.local>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20240225105320.GAZdscIJ3wxkU8_6At@fat_crate.local>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/x86_urgent_for_v6.8_rc6
X-PR-Tracked-Commit-Id: 43fb862de8f628c5db5e96831c915b9aebf62d33
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 1eee4ef38ca15137379028a5a7b0f859bd1bb9b0
Message-Id: <170888676566.24357.16298346833334212688.pr-tracker-bot@kernel.org>
Date: Sun, 25 Feb 2024 18:46:05 +0000
To: Borislav Petkov <bp@alien8.de>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Sun, 25 Feb 2024 11:53:20 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/x86_urgent_for_v6.8_rc6

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/1eee4ef38ca15137379028a5a7b0f859bd1bb9b0

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

