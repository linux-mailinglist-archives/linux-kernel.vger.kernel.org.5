Return-Path: <linux-kernel+bounces-99510-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C74C87896F
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 21:26:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 031C81F21EEC
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 20:26:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20B6757863;
	Mon, 11 Mar 2024 20:26:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DMg1O3hn"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B0E856B79
	for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2024 20:26:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710188770; cv=none; b=u/r8uqkwIt3UW7vBxj0T4vCTJKdT4BvV59l+O8pe69OWeMEG0N8H5cQJWnFzuwxTh2kOK5WIZRLvMVBKj1WUPm4A3HEl/JCIKyCHTpJKYEY706mll6qEbyEZUefCFlZ1g03TCGVJWQBymAzLVHPRCN4mi9EXbJTQrA7STBR2xj0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710188770; c=relaxed/simple;
	bh=cUxjwz3nZ5Ou5jdaLzrzhQsPhtt3CVxQ7e35DFjao3Y=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=QTu7tWZ7KbuwBbSbl05YFWgTivTnnwPLPr5Ec7ZRCj2pjfxP2uKOd68XWyFCgEcGCcjimiHcIBiOhEIJd2eDK59bQrAKntJGIzflYBg0Bcz+bMvNRc+fItgv9ruRBUHnu1d54BEgP3vX0Q/8UtWGK6QACYzoq3/lDVrES5ZR7EY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DMg1O3hn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id C4673C433C7;
	Mon, 11 Mar 2024 20:26:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710188769;
	bh=cUxjwz3nZ5Ou5jdaLzrzhQsPhtt3CVxQ7e35DFjao3Y=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=DMg1O3hnDW+oTUpwo8fFjGSfgZ9SsUEd66hMBol6Rflhj8/xyXRr2adQxpMoDrgqM
	 jm82HGqwCqerNKJO/xOmY9HHlD3ETjkEjWyUVkAUO8tsLS99oe9/PW7b9OEqASHrcm
	 4O+11IEYmctOPfzo8Ush+iF4uj7AKDeajNI1W/CFO5ovNXUYU4tcAJGPrq+0LcyXtX
	 t+VuyNzJ9sjo96FWikEUpFZzOG5a/vmCd6MJaepa5rvel/njFyBKJhO5OZDIEcxYlc
	 vTDZ2TfGrOE/Fnz61C3qx19Y6kVToWp0wSyW0AQtSKIKVUEnB99DTV8ZcYTPEiPis5
	 Wf6IukE/c8hyA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id AF351D95057;
	Mon, 11 Mar 2024 20:26:09 +0000 (UTC)
Subject: Re: [GIT PULL] workqueue changes for v6.9
From: pr-tracker-bot@kernel.org
In-Reply-To: <Ze7Jz9cQcUMtCqfk@slm.duckdns.org>
References: <Ze7Jz9cQcUMtCqfk@slm.duckdns.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <Ze7Jz9cQcUMtCqfk@slm.duckdns.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tj/wq.git/ tags/wq-for-6.9
X-PR-Tracked-Commit-Id: 1acd92d95fa24edca8f0292b21870025da93e24f
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: ff887eb07cf69a5c0a507a1311fb34bcd38450aa
Message-Id: <171018876970.21519.5824518086895586145.pr-tracker-bot@kernel.org>
Date: Mon, 11 Mar 2024 20:26:09 +0000
To: Tejun Heo <tj@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org, Lai Jiangshan <jiangshanlai@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Sun, 10 Mar 2024 23:07:27 -1000:

> git://git.kernel.org/pub/scm/linux/kernel/git/tj/wq.git/ tags/wq-for-6.9

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/ff887eb07cf69a5c0a507a1311fb34bcd38450aa

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

