Return-Path: <linux-kernel+bounces-59885-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 756A784FCE8
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 20:32:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 903F4B295D1
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 19:32:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 506CF86AE7;
	Fri,  9 Feb 2024 19:32:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vGihRs5X"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9484C84A3E
	for <linux-kernel@vger.kernel.org>; Fri,  9 Feb 2024 19:32:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707507121; cv=none; b=oZXyN9PjEwGaVYJ6xT7BuRfbHE+zsF0uvGLBra92wUs8HrpES/f6IoeSz/l6XPgVURsQAuH521EX2iVz7jGLoR49911BdMOiz3QtPt5QKSk9X6vykNCY12bblHpjN+6EuGZgSS2mvE2W/E8gACs0yauVaMbUsH/9AEhL8z1paiY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707507121; c=relaxed/simple;
	bh=1Yw4jQ4LFJihZthUSxjoizmvJLyoCoNkHVHZ49vzjrk=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=ThFgsgbCcyVADl1n9vuMb9qxId4zRBThasp+SvuKBHvdrQDIU8k2KREvFkVG9JgwZrsLoPQECG+HgLFUAt2ySI3mzh9LMy6LJ+6RO9mwxXczcvAfS47MCE44WNd+wzM2AjrozwMxXD21Edr6Baoce+ZzTDD2HXixiHQg2ILxMTA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vGihRs5X; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 6C1D1C43399;
	Fri,  9 Feb 2024 19:32:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707507121;
	bh=1Yw4jQ4LFJihZthUSxjoizmvJLyoCoNkHVHZ49vzjrk=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=vGihRs5XW32TDsPeOxG0DlRci46hkzF+jkdcMrjhiaPc4FJ244HEMQRyg6PpQVSRV
	 3DYuMijF+7URFzQdj6rv+yGxFXXf/2n0246IOaz7j9h6hSkjgs5Upm5Na6PS4TY8YC
	 mGniwiwAC0cCoY+j5bTntJgVhqzIHer2DfpHhFI+8n+33vQvMFAKqquPWrcMq1c9lA
	 AAifaUZAtv0wtThYysSN0pMhK2Ff9qJOX/b0X4H0+N9ymDRFdZnrOnlqLWd+hKApaI
	 ngbg9qLrhC2R2MOmSVSY5DPwPfe2LsyuxYr1KvpWAMtArnMldKlS8w5R9yoh7S4TEB
	 6Lg/9nbgIe4KA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 5582EE2F312;
	Fri,  9 Feb 2024 19:32:01 +0000 (UTC)
Subject: Re: [GIT PULL] RISC-V Fixes for 6.8-rc4
From: pr-tracker-bot@kernel.org
In-Reply-To: <mhng-cb58eea8-c84e-4aaf-ab71-f445d3b46de0@palmer-ri-x1c9>
References: <mhng-cb58eea8-c84e-4aaf-ab71-f445d3b46de0@palmer-ri-x1c9>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <mhng-cb58eea8-c84e-4aaf-ab71-f445d3b46de0@palmer-ri-x1c9>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/riscv/linux.git tags/riscv-for-linus-6.8-rc4
X-PR-Tracked-Commit-Id: 3951f6add519a8e954bf78691a412f65b24f4715
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 9ed18b0b7765ec3aa5f10843d1c3daaa1a225337
Message-Id: <170750712134.26526.9089159200603791474.pr-tracker-bot@kernel.org>
Date: Fri, 09 Feb 2024 19:32:01 +0000
To: Palmer Dabbelt <palmer@rivosinc.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 09 Feb 2024 08:42:32 -0800 (PST):

> git://git.kernel.org/pub/scm/linux/kernel/git/riscv/linux.git tags/riscv-for-linus-6.8-rc4

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/9ed18b0b7765ec3aa5f10843d1c3daaa1a225337

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

