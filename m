Return-Path: <linux-kernel+bounces-96429-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CF44A875BF8
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 02:29:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 768891F225B8
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 01:29:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC4E3225DD;
	Fri,  8 Mar 2024 01:29:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jNlPW6O1"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B8AF23B0;
	Fri,  8 Mar 2024 01:29:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709861388; cv=none; b=hezIuHDgfNevn+gmaXyv5VzaQxGdAmN68KseMWDk48s6n+mcBmM8Zvp+0ZYsoBsMpBkWhUgQ7YiKnfmC2jHwW5ohe+CpiL8vJMYAJvSFtN2NL13V+Y0sOcSVP9f22UcNRgTI+095y8SlFwAgE8IcV4GUdyw4cm/o9xW43WVewY4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709861388; c=relaxed/simple;
	bh=tukQ8PJbFYzuhglG3bgjuKipBqcjA69LgbygXnieDrw=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=Dt7lyDo+aLKbfsu1/T3oLRbctgbcKKfMNaYIr7i7JxPW7NwJZPhStc28IGo7ak8xBAcyjDnPAbF8/lDQ79gX4IBGtUXVEBsQ/FtRyYUoZWlqQ6jSopRB/Lhl5upeBsemjtmZlAYPHqm/bkhhHnjQCyFfBENXSdNUTUGXkOoNM9E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jNlPW6O1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id C13D2C433F1;
	Fri,  8 Mar 2024 01:29:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709861387;
	bh=tukQ8PJbFYzuhglG3bgjuKipBqcjA69LgbygXnieDrw=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=jNlPW6O1NAmPMOd/tobrJ0G3HGCvL6dISUgE/rcB9XYGwF50Gpjn+C9gXdrpoQT9b
	 SgD+sJ6nOLI5m8+316yZJ4exc9PA135Ozh0i4zk1GRubcp0M1/5P4FsR1qhMbxW9Ny
	 5TUF4Swz5OO5qbghN9E5niwEomYriVN9AYp5me3ufowRmkgZpZ9vdkNFy9Mnj9xII8
	 oV+qtuwH1+XS0SJItnkMRxRCp8Qt59TC6rEVHg9AAyYVvEvS6Yd2de2dJr5+6waimP
	 HZkxHubQVRBgbuekwru2NawjX0mP4I8cRlgzTET3hrdF878+C2xTT60WMeMcc1fA0q
	 PpNtamIgC1bYw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id AF2BBC04D3F;
	Fri,  8 Mar 2024 01:29:47 +0000 (UTC)
Subject: Re: [GIT PULL] hotfixes for 6.8
From: pr-tracker-bot@kernel.org
In-Reply-To: <20240307162059.88fcc2a013c9ce1f3f72042d@linux-foundation.org>
References: <20240307162059.88fcc2a013c9ce1f3f72042d@linux-foundation.org>
X-PR-Tracked-List-Id: <linux-mm.kvack.org>
X-PR-Tracked-Message-Id: <20240307162059.88fcc2a013c9ce1f3f72042d@linux-foundation.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm tags/mm-hotfixes-stable-2024-03-07-16-17
X-PR-Tracked-Commit-Id: ded79af42f114bb89f8e90c8e7337f5b7bb5f015
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 3aaa8ce7a3350d95b241046ae2401103a4384ba2
Message-Id: <170986138770.3360.16836002430977814085.pr-tracker-bot@kernel.org>
Date: Fri, 08 Mar 2024 01:29:47 +0000
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-mm@kvack.org, linux-kernel@vger.kernel.org, mm-commits@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Thu, 7 Mar 2024 16:20:59 -0800:

> git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm tags/mm-hotfixes-stable-2024-03-07-16-17

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/3aaa8ce7a3350d95b241046ae2401103a4384ba2

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

