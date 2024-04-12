Return-Path: <linux-kernel+bounces-143297-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 432538A36EC
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 22:18:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7F524B25433
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 20:18:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65830152187;
	Fri, 12 Apr 2024 20:17:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZPJn5CmS"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C44715217D
	for <linux-kernel@vger.kernel.org>; Fri, 12 Apr 2024 20:17:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712953054; cv=none; b=Cl4SEJyMMWAIjP41qnxNhdfejW8O8AGfHwZ9Q7oVN16lD5Ub31PSugzfksrzzUjiVENPXPXzZLUzCCIRbcEGy/aepA9bBMWixACSS/8x1GS381cJcn8ADPiRBKiTyl6jiQ1o7TnhCyS+orQJtjZDa6NvjLk3tONo6gtShBZixjc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712953054; c=relaxed/simple;
	bh=l6MVm4fYmOjNFAcaZ+mBIuLxVK28bF5PHXlbB/aZFqA=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=u/6YGz3qhbcvbfPOOuQtqgyUtUBV6NRGJV+SvR6NMjZQpptzA4XOKS62Pktwsnj/ARl6UU8A/CR106OZlzd0uBd7L6UhtfRobzp4NS1G6Uq65xWciMnkebg2RehAOUa/qoIscja1y4s13BHtkg+pIcfssld5gz3ibL2mGoWfaqY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZPJn5CmS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 33C43C32783;
	Fri, 12 Apr 2024 20:17:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712953054;
	bh=l6MVm4fYmOjNFAcaZ+mBIuLxVK28bF5PHXlbB/aZFqA=;
	h=Subject:From:In-Reply-To:References:Date:To:List-Id:Cc:From;
	b=ZPJn5CmS54Dw7dfTctA4rwwB8LmqndbaYm0YMlmcCSXa0Zmy4yQrr9yFHrRWty9GA
	 OkIY1sV+cpYqgnhASILyU+lVwOAdMCxIgFUyuF20qBoY2qeR6N77HB5MDGzQwtZup7
	 /ZD7ViVqrssWTyu/qibKkFnTXlmnlncnKRxjaj2ojFxecIigAPeDHXReF2OrZeXHTn
	 2RCEPeD7Pb8Got96CUfyvWaumkzPxrZSXPYptXvnao8WXn7WOac6HwniStTdzS6OxO
	 TcMu8sKK9JuMUEtZu0h0m1vi/Xw5fI569EbrPL2CMV6MSfN7EuiiDA2XptHJE4g//+
	 Amv6La2qFEIYQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 27BB8DF7856;
	Fri, 12 Apr 2024 20:17:34 +0000 (UTC)
Subject: Re: [GIT PULL] SoC fixes for 6.9
From: pr-tracker-bot@kernel.org
In-Reply-To: <4c6039da-5362-46ad-8126-dacaf7ad1169@app.fastmail.com>
References: <4c6039da-5362-46ad-8126-dacaf7ad1169@app.fastmail.com>
X-PR-Tracked-List-Id: <linux-arm-kernel.lists.infradead.org>
X-PR-Tracked-Message-Id: <4c6039da-5362-46ad-8126-dacaf7ad1169@app.fastmail.com>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/soc/soc.git tags/soc-fixes-6.9-1
X-PR-Tracked-Commit-Id: 011d79ef1cfad701c2d8e7e80d8c77523af9c771
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 678e14c772130d3a83225ed56fb9860a40bca38b
Message-Id: <171295305415.15771.6575415152452339171.pr-tracker-bot@kernel.org>
Date: Fri, 12 Apr 2024 20:17:34 +0000
To: Arnd Bergmann <arnd@arndb.de>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, soc@kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 12 Apr 2024 21:48:34 +0200:

> https://git.kernel.org/pub/scm/linux/kernel/git/soc/soc.git tags/soc-fixes-6.9-1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/678e14c772130d3a83225ed56fb9860a40bca38b

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

