Return-Path: <linux-kernel+bounces-163134-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 58B1A8B6636
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 01:25:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 89ACB1C21427
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 23:25:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33AC01836D1;
	Mon, 29 Apr 2024 23:25:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eG2XDF/q"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CA7113AD18
	for <linux-kernel@vger.kernel.org>; Mon, 29 Apr 2024 23:25:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714433144; cv=none; b=XLVNj7DB4tcz3+Of0qNj2ZeSp1RIt6HNFPizRkxpckinvAUZDpwORq0hoggEXWCoCgaUaS8vwk3349sFP+zwi9QWwqbO36OhlxlGGAJ6mZ6+K/bGVZkv7XDneRVqrFBHYTAAwnwAHYLZSzuETrf+j8LqyO8NkxCNj0jVijIWVII=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714433144; c=relaxed/simple;
	bh=303QcUdL9ELsWLH0JRcSIWwYOLBUvbsMYzfA9sSpzKM=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=kGQmHZBAaTVghOcuJhT/VT+tfyZCXzvI8THjMEP5pvIDE66GNWhZb1tQDFI8hihig2RENFCgFOqlRCUn26GNNrVlBdamSHRloI2NGsD00Xf/z7bS8iB0oMuWRbFDqDoXza4JRwuEHvfYpWRRBUvB/FzqQlmDr4AFskhoOCJF9pI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eG2XDF/q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 52F06C113CD;
	Mon, 29 Apr 2024 23:25:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714433144;
	bh=303QcUdL9ELsWLH0JRcSIWwYOLBUvbsMYzfA9sSpzKM=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=eG2XDF/qbWOu/1LA32z683sgfSgBpUBM5Y3XllkKOGrZ6NTEzfvvC62vj6o6vcTkz
	 nQBWEaI3iklcxXqv7zBDSUFUhr2ZHfrtYeZGBswfiHl72oO/jCGtN3vn+AA/93ub2l
	 kOtOv5iljKw6wafuasE3DhAu/yirX/fXH/xuskoZmzOWW2NDtq7hoR1J3OL1eE07et
	 zvCWEKQoQG6Nd4x0g28CDmdEruts07RavnHS3Wm+sEe714Zhw3u7MNXeRzj6bNN3hK
	 k8enBNnIW8qAhAnsodsp8qelEczN/64UQT2g9QlV6iSvA+uigTd1siRC0U0T1iJg/7
	 7heqPtH6dGJIQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 45E51C43613;
	Mon, 29 Apr 2024 23:25:44 +0000 (UTC)
Subject: Re: [GIT PULL] workqueue: Fixes for v6.9-rc6
From: pr-tracker-bot@kernel.org
In-Reply-To: <ZjAa4eL2plDnP-tD@slm.duckdns.org>
References: <ZjAa4eL2plDnP-tD@slm.duckdns.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <ZjAa4eL2plDnP-tD@slm.duckdns.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tj/wq.git/ tags/wq-for-6.9-rc6-fixes
X-PR-Tracked-Commit-Id: 91f098704c25106d88706fc9f8bcfce01fdb97df
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 98369dccd2f8e16bf4c6621053af7aa4821dcf8e
Message-Id: <171443314427.5000.9210669926499980163.pr-tracker-bot@kernel.org>
Date: Mon, 29 Apr 2024 23:25:44 +0000
To: Tejun Heo <tj@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org, Lai Jiangshan <jiangshanlai@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Mon, 29 Apr 2024 12:10:41 -1000:

> git://git.kernel.org/pub/scm/linux/kernel/git/tj/wq.git/ tags/wq-for-6.9-rc6-fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/98369dccd2f8e16bf4c6621053af7aa4821dcf8e

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

