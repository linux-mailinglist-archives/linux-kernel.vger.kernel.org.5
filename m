Return-Path: <linux-kernel+bounces-89851-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E40BD86F685
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Mar 2024 18:59:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 685C41F215A2
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Mar 2024 17:59:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B18A768E1;
	Sun,  3 Mar 2024 17:59:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q3GhRNfK"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71503B654
	for <linux-kernel@vger.kernel.org>; Sun,  3 Mar 2024 17:59:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709488770; cv=none; b=J5LKw9MhX/pYeWN6YkyZNgkFANmgI3W93GphqbLQHTTncuCc1yzPvz3uUerCvIw02wE2QNWbZhNZWwB6jdReNQkiv2oMwkWM3q6DuzvAl5qvLp0rAU8vDHJtOf8MC1QKBu8wnH5jjDOa/7ORzntRZOnXCm+Ms9aUfj8esnB+gmA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709488770; c=relaxed/simple;
	bh=6m/LzgQhNgQXzRlQRytSjwhCsXeO9Db0U4EL+xqO9n8=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=L7DCO2pokFEyO1tu1SkF8zMjydWO0qVm/h1abpbt7xNMhpIhJ19ZMNjgJJd9cBpQfrT5RN66YOsFGtv6Fem7bKJOg2RK4oncskGK9uRwtQpDqh5RwoPBm3Fl5uPDetpQ9TTEGP4dtxTpj8GjStrYLxcyJBPHGCYF/z0q75uesnY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q3GhRNfK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 50C8DC433C7;
	Sun,  3 Mar 2024 17:59:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709488770;
	bh=6m/LzgQhNgQXzRlQRytSjwhCsXeO9Db0U4EL+xqO9n8=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=Q3GhRNfK8s2rYc1FpZK3RqKlY8OuLowVVSV9+nQ9IExM8prCfK3XGdBngNAhTUQyC
	 bV5olJwDECtR53c0P0OSqQsq5DHHXWvKtrgSLG/N3yzC8jWDyiItDrTsrZsspAq55n
	 yPYQwYfOSnf5CZ7tLHhARIFTmoJ2cDOEm/Lrvor34U+TTMyaqxO+Rue1/RS6AFNyqD
	 E8LpzorAla1FP+s5otHQwTKlaTEJIZUH2acEhCBkL0JsC2IKTKpXgIe1n6tbqcpqzX
	 f2tKC3uF5lNKIRwWU1vpW/VVZOdqm6LUTRc9mqjt4IC1pW/V/VOI7v3yYoc8FeWa16
	 W9BSh2qPJlTmQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 3894CC3274B;
	Sun,  3 Mar 2024 17:59:30 +0000 (UTC)
Subject: Re: [GIT PULL]: dmaengine fixes for v6.8
From: pr-tracker-bot@kernel.org
In-Reply-To: <ZeSqMxRO_GVABeW5@matsya>
References: <ZeSqMxRO_GVABeW5@matsya>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <ZeSqMxRO_GVABeW5@matsya>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/vkoul/dmaengine.git tags/dmaengine-fix2-6.8
X-PR-Tracked-Commit-Id: df2515a17914ecfc2a0594509deaf7fcb8d191ac
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: d57dd2d24ddb4c69635a72c6c36e7dc82142d499
Message-Id: <170948877019.21543.8976004237074093852.pr-tracker-bot@kernel.org>
Date: Sun, 03 Mar 2024 17:59:30 +0000
To: Vinod Koul <vkoul@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Sun, 3 Mar 2024 22:19:55 +0530:

> git://git.kernel.org/pub/scm/linux/kernel/git/vkoul/dmaengine.git tags/dmaengine-fix2-6.8

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/d57dd2d24ddb4c69635a72c6c36e7dc82142d499

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

