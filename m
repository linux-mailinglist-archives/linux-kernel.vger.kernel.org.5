Return-Path: <linux-kernel+bounces-102425-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7436787B1D9
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 20:31:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2F8CB28E4C7
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 19:31:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5690B5D464;
	Wed, 13 Mar 2024 19:27:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WL/LLMLy"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99A1A5D460;
	Wed, 13 Mar 2024 19:27:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710358071; cv=none; b=IcwNUrg5v0XYqcg3husfBTDBCvPb2RjruCNxWO29SrI/CCXkO4N4iNWjoa25Itae1o1vAEOyVvvZ7kgC01RDOkQFRxZj2ycT/A3BmPfq0hP9IX16GDR6ekICduvyRR6xOrzRzKB2oaETJ396JfkcSqFFCJmmlkRdjf0kFyvFGqM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710358071; c=relaxed/simple;
	bh=jr2nOItYkrphtNE2RzR6Nvamiz6saLb5LIsrrN4gvZ0=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=rNO1LOtZdRg2NP/cZsXwp/CkTiOFEySjv+j7wsFYZoebErL6ZgFPCp12q0Dyg2WvNguCrJpYQRYRcATJUNzpKenRc2CYBc6qQnVeSZAf2oBO+ecyM6DuDmLDVQtUO8ZqDCdh4LJhrtdGCKbMNg3lgeVjuxvc8zrsNO4ILCL7zzQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WL/LLMLy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 7C4C9C433C7;
	Wed, 13 Mar 2024 19:27:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710358071;
	bh=jr2nOItYkrphtNE2RzR6Nvamiz6saLb5LIsrrN4gvZ0=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=WL/LLMLyJ4LtAz01+HbcP7sueMK6QmsTvt2YUgkIb/V3duSW9faMaCQAj6kELB6t3
	 q85Rc0gJoQAovy7b6MVIabn/EoTyOUKRva4oQfxCZQmPvivOUQgghaUQE0b0l28aAE
	 G37Ie6BZZrKeQKFdciGMXGrJ4Xd2YQ+1zS2wvIAmKJgBPcA71LX6KR0xjQQOwNuRLF
	 KaNfvBrmREM71/wwFGw4B6bLL63Wk3lz/JoeWQhnDXW+ZifFnMDux7A4oPs3F0zCoy
	 vPNzLDk+9h9oF/sDzQS9bEILBc16SLhfDLB9ILJtsXyHuVfpY1eJBtU/GrCWo6p3sH
	 l+60AF4K+cAnQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 69573D95054;
	Wed, 13 Mar 2024 19:27:51 +0000 (UTC)
Subject: Re: [GIT PULL] hwmon updates for v6.9
From: pr-tracker-bot@kernel.org
In-Reply-To: <20240311153710.3137686-1-linux@roeck-us.net>
References: <20240311153710.3137686-1-linux@roeck-us.net>
X-PR-Tracked-List-Id: <linux-hwmon.vger.kernel.org>
X-PR-Tracked-Message-Id: <20240311153710.3137686-1-linux@roeck-us.net>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/groeck/linux-staging.git hwmon-for-v6.9
X-PR-Tracked-Commit-Id: 8debe3c1295ef36958dae77487eed9cf6584c008
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 15223fdbdf4f75102c5507f764bda0fdcdf726ae
Message-Id: <171035807142.9850.18154459668324716214.pr-tracker-bot@kernel.org>
Date: Wed, 13 Mar 2024 19:27:51 +0000
To: Guenter Roeck <linux@roeck-us.net>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Mon, 11 Mar 2024 08:37:10 -0700:

> git://git.kernel.org/pub/scm/linux/kernel/git/groeck/linux-staging.git hwmon-for-v6.9

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/15223fdbdf4f75102c5507f764bda0fdcdf726ae

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

