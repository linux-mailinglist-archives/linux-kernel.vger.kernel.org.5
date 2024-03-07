Return-Path: <linux-kernel+bounces-95956-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AB76875555
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 18:39:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2BA52B25A82
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 17:39:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA4D7131733;
	Thu,  7 Mar 2024 17:39:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="t9b7OM/m"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A2B7130E2B
	for <linux-kernel@vger.kernel.org>; Thu,  7 Mar 2024 17:39:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709833143; cv=none; b=ev0W/QARzmnfwxd746ucdj6jg1T63wqUx/z2gssEal20qcJLd8iGP+HYiFPnlQiyjGhnc2VebIr+xd4dkzaU9wuc+Pwr70yxGdq9yN1FcLjPBzv3KiArTp8nYz3uwlh6jGpPedIGgIXe/lBzkl1ppEg6oM8eVkRaehLQlP+hPTI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709833143; c=relaxed/simple;
	bh=eY6pwd2Sm8srKSFa+2wJH2gUCUrvn8KY0DlfgRQmgv8=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=U0t5BIA2Hhej0tJ0q40IyReNI4NTPAhl3kLY+Z31GUGt6NZ8tVTJ8zezYlFFthValXpZiN7E5hINQ06aXr3ohOhDuY3KEQAILH5N8VSNnQGp5a94QlZV6hY5iJSC+/hRejhnDC6WSFXlrQ9JpFqIwqD8nj2yholZjWL1fRDvgtU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=t9b7OM/m; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id C5BBDC43394;
	Thu,  7 Mar 2024 17:39:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709833142;
	bh=eY6pwd2Sm8srKSFa+2wJH2gUCUrvn8KY0DlfgRQmgv8=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=t9b7OM/msr7W/spJG6R9TkPREpuE1oIpzhq2MAZGHjveN24XT+Hb/GXt67FN6oYze
	 h15Wez3K7ePaXgwKlW9OKCOTVJyHMpT5i1chBPQqlJYETtHIEQrayp5kAQNuVu1+1r
	 JfRNPzNOQ/0ZjN0i8bwLeW1NlgNAQbbn53vqfpFHV4MwlhmM6oVrMygF/RBoUCu0ag
	 d9jnAWID5TMYctnAPPQ9B/YaX/jPlz68XeVfzUhVK+bpcJFV/AhndUmeZ3XGiVdkkE
	 eRwCEbdGf9WU0Vktvr5L9WSQCI+0HRxOgH6Dd5MdNvK9gBTlK0aPpn9wq3qSm6IYNy
	 SmMd7FOAxWVpw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id ACAF5D84BB7;
	Thu,  7 Mar 2024 17:39:02 +0000 (UTC)
Subject: Re: [GIT PULL] arm64 fix for 6.8
From: pr-tracker-bot@kernel.org
In-Reply-To: <20240307172538.GA24546@willie-the-truck>
References: <20240307172538.GA24546@willie-the-truck>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20240307172538.GA24546@willie-the-truck>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git tags/arm64-fixes
X-PR-Tracked-Commit-Id: 2c79bd34af13de221ddab29d8dfc9d5eeca8fe9b
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 135288b73cef4ccc6e0f8bf1f06bad04128b987d
Message-Id: <170983314270.22258.10288632090906021975.pr-tracker-bot@kernel.org>
Date: Thu, 07 Mar 2024 17:39:02 +0000
To: Will Deacon <will@kernel.org>
Cc: torvalds@linux-foundation.org, catalin.marinas@arm.com, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, kernel-team@android.com
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Thu, 7 Mar 2024 17:25:38 +0000:

> git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git tags/arm64-fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/135288b73cef4ccc6e0f8bf1f06bad04128b987d

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

