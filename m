Return-Path: <linux-kernel+bounces-99799-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3234A878D82
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 04:33:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 303A51C214E5
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 03:33:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D7D7D26D;
	Tue, 12 Mar 2024 03:32:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F1D6XzSd"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EBEEB67F
	for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2024 03:32:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710214356; cv=none; b=Dd8wOeM8NIZnYGnJYpxWrYwAdZXbRTfz+igGg13kay4Vc/R4dDM/fBfJjBZC1DS7YY8UWxwuatLugyDbuCbTkBBERvwyIY8X65KFizRedso71u9z0FaNlvOtNsPa2hx/Btc5zKeYrRzKMS346v7EUehyMw+umagnNYyDPUlCvnI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710214356; c=relaxed/simple;
	bh=HzlMt2jxN2wCfkkV2GPj0DEtTRZw7MMr98HkWO0baKg=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=ldY+XzaiHT1k/LDfmMhh2ZsBfgislAHjp29P9gUPehkJxzfdEwojsqb2VY5x68xBhnnID+GIghz3wev1Pzn6qood45TnhsMfWBgTu77ekWCn2VSg7RTvzQ0RQQLCiEJ87RZPVUKKIDzqDA1q1QNftHQJd/SpbeVp47zyCPCxnps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F1D6XzSd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 7C53CC43601;
	Tue, 12 Mar 2024 03:32:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710214356;
	bh=HzlMt2jxN2wCfkkV2GPj0DEtTRZw7MMr98HkWO0baKg=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=F1D6XzSdiNJSZaNBI6UdToeoMRGqcoEdbedPgBFFhgvjltD8xGyD0B+G/KHePLKAP
	 YDCigklBMWCFRpqoXZasD3+qx5npV/8Q6AZeLn8DnpOO2TKqVqOz5zckLuIKJco+B4
	 lp/BNDkZYDvQpyZlWkND8U5xBihGSrt8IyYSmbnHlguTUi4Md8xJBDMctlxamhk6g3
	 +pkKOEjwsS4ItPaRf+qajz9y2B0kJu15wnFl3sMqu+kM8hj8gQl3XYaKOYrIoISeS2
	 mR7dJVqWiHbiqFHXTyPMhXpuKFJO9PpRuZQtZIDJylmwHw+2DoZ+bMi7m0YbOVI3p0
	 RnNsmJNa359XA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 61C6FD95055;
	Tue, 12 Mar 2024 03:32:36 +0000 (UTC)
Subject: Re: [GIT PULL] x86/cleanups for v6.9
From: pr-tracker-bot@kernel.org
In-Reply-To: <Ze8BMARCnxKAt/VL@gmail.com>
References: <Ze8BMARCnxKAt/VL@gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <Ze8BMARCnxKAt/VL@gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-cleanups-2024-03-11
X-PR-Tracked-Commit-Id: 774a86f1c885460ade4334b901919fa1d8ae6ec6
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: fcc196579aa1fc167d6778948bff69fae6116737
Message-Id: <171021435638.8573.16064398775541748528.pr-tracker-bot@kernel.org>
Date: Tue, 12 Mar 2024 03:32:36 +0000
To: Ingo Molnar <mingo@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org, the arch/x86 maintainers <x86@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Mon, 11 Mar 2024 14:03:44 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-cleanups-2024-03-11

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/fcc196579aa1fc167d6778948bff69fae6116737

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

