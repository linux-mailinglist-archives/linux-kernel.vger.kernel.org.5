Return-Path: <linux-kernel+bounces-164392-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 12F648B7D1F
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 18:35:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 34F72B26565
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 16:35:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78EAF194C93;
	Tue, 30 Apr 2024 16:33:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DJsxFxrX"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBDF2190692;
	Tue, 30 Apr 2024 16:33:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714494798; cv=none; b=EDa8Z9WdEEiNWXXu7nZM9VxhUmMrUFISYwRag0y3OGBy+7lgI//gs+95DXGmZgSZNXnqVQRgXnFCL1SQGiH0TEs8F+kQhcsOgY+9dFH7LQXWFc99QaheHRTbhQ2T+1HWzrPbvXLOUPeRHm2v/rh5QnhqdTTLSzhhu19zQVVSBXI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714494798; c=relaxed/simple;
	bh=PcbE5PES9xNZ4I4rsUJe/9WnJ5WpSn7r0RsEAjXrn1U=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=PPj8jPubDfrBpTBdxPOr51JVZxtSQKCFIJxQHDIb3aDYtf71juu4DAcBS8YVLk8M6DOaqsrpCm5MJbmaR65Nzu7iJnlCVtjliK5M33WkjaTXePUAFVJMPL7lRqba4z5CSrZKXI0fnkeN+rGekietJ297GtMxYHzqvo95zXCsRjs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DJsxFxrX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 593EEC2BBFC;
	Tue, 30 Apr 2024 16:33:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714494798;
	bh=PcbE5PES9xNZ4I4rsUJe/9WnJ5WpSn7r0RsEAjXrn1U=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=DJsxFxrXrvG9s3U/VKZOq1+fdXe8PI2/m+u6eJhOj2ndtO1Wu8mAA4rtOUkPJiqHy
	 0D5TROxZVGjRNUbp/PVffNzcELpaDUWCrsjWn+FK0Qw8+fQXQio7f+aVE1qLJKFqds
	 pNRnPtzi8ioroDdnkp5oSm79tl4qU6LD54vyijrx9ZzCr4ksrIeQXDZEWdRN19s4yL
	 Vhh7GWCKMG9C7bjIhjQRs0HZT2vv6jR5bKJ54BS2/VGmZHbzwFR9J92tCV6kuBLRzY
	 McGqYve0GctPPgcZhoSlUaZ7eGZKTqo2YwvPLHi8ECPdBn9fl0+OZ870Vwg2TYBg0c
	 yGH3/539SZnBw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 467EAC43616;
	Tue, 30 Apr 2024 16:33:18 +0000 (UTC)
Subject: Re: [GIT PULL] power-supply changes for 6.9-rc
From: pr-tracker-bot@kernel.org
In-Reply-To: <vreefzn65ijap4kxzxgfk5bom7uz5skoy3rn7fktydd7mgavbj@kfhvex76iw2z>
References: <vreefzn65ijap4kxzxgfk5bom7uz5skoy3rn7fktydd7mgavbj@kfhvex76iw2z>
X-PR-Tracked-List-Id: <linux-pm.vger.kernel.org>
X-PR-Tracked-Message-Id: <vreefzn65ijap4kxzxgfk5bom7uz5skoy3rn7fktydd7mgavbj@kfhvex76iw2z>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/sre/linux-power-supply.git tags/for-v6.9-rc
X-PR-Tracked-Commit-Id: 1e0fb113646182e073539db96016b00cfeb18ecc
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 50dffbf771802c4db88de2cb942affa0ada43ad0
Message-Id: <171449479828.9419.6574092389324799375.pr-tracker-bot@kernel.org>
Date: Tue, 30 Apr 2024 16:33:18 +0000
To: Sebastian Reichel <sre@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Tue, 30 Apr 2024 15:58:56 +0200:

> https://git.kernel.org/pub/scm/linux/kernel/git/sre/linux-power-supply.git tags/for-v6.9-rc

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/50dffbf771802c4db88de2cb942affa0ada43ad0

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

