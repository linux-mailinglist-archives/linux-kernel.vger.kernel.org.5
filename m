Return-Path: <linux-kernel+bounces-133553-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 79A3589A579
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 22:10:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 192641F2326F
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 20:10:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84DBA174EFF;
	Fri,  5 Apr 2024 20:10:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YWWN6Rrd"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C71F617335A;
	Fri,  5 Apr 2024 20:10:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712347817; cv=none; b=OmC8jrcAm9IDhKHiJ5Fe7+iE0CF8cb35kJWJ7apg9gdOlEdvEOHtyTtLdPrzsd/DCVQNMny0CZA+S2tgLl64ywBUBOaMMkPcXNWelUbtW9s2rmwsWd7aEjYq2JZMIjxgiKkTYC5mRQothjyFra9cemQSybYNfaw78dr1B9gwXwo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712347817; c=relaxed/simple;
	bh=vdvVwN/G2WCdNRTpeEh4NsfdIbkqmx2jt2A5wlQfpOQ=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=KDQ5rGaGyFBurNCPCMurbruQbhr312sUnBm2DDw1qfg0SFqU+rR2EZfG/yumQNFR2i/q7xqFpfnc8qQtZnEoj8PO+ztXFkJj4w9MGNII4jP61+EIx10MFw4OgTJ9EatrLbuYd/ZfrfatsogEo5ON4RbBTNLuO1WL09WCdNE5ccA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YWWN6Rrd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 55541C43390;
	Fri,  5 Apr 2024 20:10:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712347817;
	bh=vdvVwN/G2WCdNRTpeEh4NsfdIbkqmx2jt2A5wlQfpOQ=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=YWWN6RrdJzyg79DRshqJn2NLP4or5MVHEKKP+uZDuo/wH6nsbxPnwHXtak5MrL0pO
	 t3hi+GXss/772mopBqbs4XxUtaXd8052Q0LR7j02mmowtKLu/zvDYCiBkxK+dhuXCo
	 dxhLzoKVdakmj6Cn3K7AGEbrHTTMNXxW7kxjT65/Zcul91ZfDqSN/bGc1tDwbRsm2q
	 qTip5aiJTUKnOn965LS0T02Ux/KXowng4PYUubA/lRGLr/SWTw3qxheV8990XJMavz
	 gtyQcR+jACGM+FXH9y2w5qEcl2i1xqWGr4pRBqR22zd+OKgLjfMkKIe3vGhLTusYKx
	 ulDjJCy4JzkOA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 40250D8A100;
	Fri,  5 Apr 2024 20:10:17 +0000 (UTC)
Subject: Re: [GIT PULL] Power management fixes for v6.9-rc3
From: pr-tracker-bot@kernel.org
In-Reply-To: <CAJZ5v0gVqOUuFfJ8um+_F_ubU4QsWYneyQsFBHu9rG10-rJYEg@mail.gmail.com>
References: <CAJZ5v0gVqOUuFfJ8um+_F_ubU4QsWYneyQsFBHu9rG10-rJYEg@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-pm.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAJZ5v0gVqOUuFfJ8um+_F_ubU4QsWYneyQsFBHu9rG10-rJYEg@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git pm-6.9-rc3
X-PR-Tracked-Commit-Id: 8130b05c559d1aa83d0c8971b422ba0da18ef24a
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 2f9fd9e439706c615b77c23d70184ddefa7fb9e0
Message-Id: <171234781725.2800.10648619102197054859.pr-tracker-bot@kernel.org>
Date: Fri, 05 Apr 2024 20:10:17 +0000
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Linux PM <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 5 Apr 2024 20:42:04 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git pm-6.9-rc3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/2f9fd9e439706c615b77c23d70184ddefa7fb9e0

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

