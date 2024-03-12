Return-Path: <linux-kernel+bounces-100883-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F0648879E92
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 23:27:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AC105285B91
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 22:27:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78924146E7A;
	Tue, 12 Mar 2024 22:24:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rcgcvNUG"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4841144055;
	Tue, 12 Mar 2024 22:24:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710282265; cv=none; b=VPMrGn/skbsNnca6cPMMgLCDuSDwlGq/DJSd4wNGojkJj6OIPVcy/cAY871Qo1iPy7oDBwsVtlh1E7+tlBDrbsTaIswACCQduJvhm/KIew+XufTRlRMpH9JwbkzcfeQX/ebHSs3aM+1HN5weqrX9fgTUe05fTaefziQhRlPnaFY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710282265; c=relaxed/simple;
	bh=sNe+jdXp5gLZtIDfWj+gNMAK7ppKKGTMga/SGdLvIHU=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=OKKzbO82WhJvnT46otRWPFxw4lIGmpi///qZ7lTp9/bS/PdcVBPekgPICiyiqoHltfLRqXb8AMDor9mylSW5JjnAacaA9n1mzkJAB3aCAVl+ZBrBFgKJnZcxdOcmlA5LwE8HGt2qufxUMjAbCOu/3XaDwcxfzFi31ppMOQkVxi8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rcgcvNUG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 1265FC43390;
	Tue, 12 Mar 2024 22:24:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710282265;
	bh=sNe+jdXp5gLZtIDfWj+gNMAK7ppKKGTMga/SGdLvIHU=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=rcgcvNUGyVz3rNESXsAonfYCODuWg4jfanDMTlmA9jgWdIbiKupkV+jjZUrHjQrpF
	 SChe65OF4MMhGVt6WzNTJLr2+QDEL646r2dhlo2B+6W7SOmoDzq08FHVKyaJ319SRX
	 zBb9oqxMdDFGUqR2QcBoTFO6EPmQs/K/h47b6D45IbSdByMHD/q3EAVpQWPcGOkZ0G
	 j3YK25kqQg6GMduIKiS2dwvnYIeD3NijAjHltyzya8mkGuk3sS8O2RYMFBfbV+NrOy
	 uwU0KHeRUe67tHp7fPzFeNyeUHT93j7E9gVeeyzPK6pr3ywCTDEuBcbQSYdQRaYPfW
	 kBYQorw3DOwpg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id F3A77D95057;
	Tue, 12 Mar 2024 22:24:24 +0000 (UTC)
Subject: Re: [GIT PULL] audit/audit-pr-20240312
From: pr-tracker-bot@kernel.org
In-Reply-To: <a51f65333f170f8079c72d98c16137d9@paul-moore.com>
References: <a51f65333f170f8079c72d98c16137d9@paul-moore.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <a51f65333f170f8079c72d98c16137d9@paul-moore.com>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/audit.git tags/audit-pr-20240312
X-PR-Tracked-Commit-Id: aa13b709084a0287ef250a9fbde5993e4dfc3078
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 3749bda230478a8716a812f4d069c2f29dd246c4
Message-Id: <171028226499.16151.7359529784475955596.pr-tracker-bot@kernel.org>
Date: Tue, 12 Mar 2024 22:24:24 +0000
To: Paul Moore <paul@paul-moore.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, audit@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Tue, 12 Mar 2024 17:07:33 -0400:

> https://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/audit.git tags/audit-pr-20240312

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/3749bda230478a8716a812f4d069c2f29dd246c4

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

