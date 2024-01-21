Return-Path: <linux-kernel+bounces-32154-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CFD2083575B
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Jan 2024 20:34:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8A458281CD3
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Jan 2024 19:33:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBE3538395;
	Sun, 21 Jan 2024 19:33:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I1gJvvMO"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1ED721E878
	for <linux-kernel@vger.kernel.org>; Sun, 21 Jan 2024 19:33:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705865632; cv=none; b=nez9DKZ8xo/dx1MPlkFPSdj4cgbmczZuONe6BqFjAmwrfiiFb5aBb3UBem5Rh8i2JYw5rpooebhcDUXipDz6lk3cgi+LyL6qzaFXFpdo2Dt28bG/FwRmBFxjJI6pdACzGubbRdvGFetAw5PVxIn+FS+hzRbLgPSCT87yhk8S238=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705865632; c=relaxed/simple;
	bh=JAcvexAQOm6zkXOa3WMMQlCf6u2vPqTfhHb8PUSao3s=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=oq4bPylr4UE9m2eZB/JZgkWYPn5zrQsZ7FC0FXKFcjtyL6Bl82obMi9bYMtPkZE6CVofhXsNh4gh9CwhV5+DIgKdQ0j32PdGtz977KgafXMJlfS87P7IW4HYmfP+/j1r2tbSkSc6VmdoqB76159xO+aW0gSxrupc6FX+g87JQE0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I1gJvvMO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 8E619C433C7;
	Sun, 21 Jan 2024 19:33:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705865631;
	bh=JAcvexAQOm6zkXOa3WMMQlCf6u2vPqTfhHb8PUSao3s=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=I1gJvvMOTynskAseAkPfz2P9q0EE3ScXkFBL/xETNfCGJc0dte/r1NRYM9tWzgZoU
	 OQCCmkoC4RiXBZHtige4LmM95UYopVJVUTWQGA/Lp/tmRUYzPVnSgbz1jG0SHZkkAM
	 BnDGtCiR6NxD9gjkIVLNuPf0f4Z+ieb9a9YYJLXPz31aQxvHNZM0i8SmYKOYGFc6N0
	 2gi76+ggdQK9/GQJFHmecoHa0+jDRp2b5hKxVIdV9NEG9wZdfnbuKIcLmwLKOia0AT
	 VBOss0EG0+x+rdgpdOJPYNhb2KP4kalvCZPsJchDgcXv6Dxxxn6gdpbpH+xx02K/Pn
	 QOU9s+m/r0WEA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 7D524D8C978;
	Sun, 21 Jan 2024 19:33:51 +0000 (UTC)
Subject: Re: [GIT PULL] Please pull powerpc/linux.git powerpc-6.8-2 tag
From: pr-tracker-bot@kernel.org
In-Reply-To: <875xznql7c.fsf@kernel.org>
References: <875xznql7c.fsf@kernel.org>
X-PR-Tracked-List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
X-PR-Tracked-Message-Id: <875xznql7c.fsf@kernel.org>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git tags/powerpc-6.8-2
X-PR-Tracked-Commit-Id: 18f14afe281648e31ed35c9ad2fcb724c4838ad9
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 7b297a5cc9308b57c29635e00395f4005c9ba960
Message-Id: <170586563148.13428.17843378059290885207.pr-tracker-bot@kernel.org>
Date: Sun, 21 Jan 2024 19:33:51 +0000
To: "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, aneesh.kumar@kernel.org, linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org, Nicholas Piggin <npiggin@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Sun, 21 Jan 2024 11:31:11 +0530:

> https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git tags/powerpc-6.8-2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/7b297a5cc9308b57c29635e00395f4005c9ba960

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

