Return-Path: <linux-kernel+bounces-143012-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AC9288A3331
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 18:08:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3BBEFB243DA
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 16:08:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 947651494A8;
	Fri, 12 Apr 2024 16:08:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hIt/acAl"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7FE0148850;
	Fri, 12 Apr 2024 16:08:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712938113; cv=none; b=Zmfc3pCK73JFjjkldm/kiGrcEKFdqTVwBPFz5llYOXF9LI728Q4snhEysix0Q3oXN1Ldn2zEMAOZhBb4S1eeyHbS3u8Piu+8CBTW6C2vYFSuU9BiQG9HFz1duieFLs7oiMftXmdV23QAsnNqJMiXEfJ/XPK2WpT/D6HH6wR2fwA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712938113; c=relaxed/simple;
	bh=xSWV+KnJYn2lSIamPr8N7d4rlC7P/QjHVeILNIKPSds=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=YDx1EZXloZzhoL7VqATOH4YreUEmyk6/aRPcGYNeDQURCJJ8bcYVCkoODksHu6DpiYttjtOqhW2eFvxt1VWe7N/zbxIMmfKGKuF49FQHqbb3+uiPGsbboe/3sAfIxlSRc2BOTXdx2c2Rtv+BxrljPgEh0U4o9SSLjZnhhX5kRGY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hIt/acAl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 70D07C2BD11;
	Fri, 12 Apr 2024 16:08:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712938113;
	bh=xSWV+KnJYn2lSIamPr8N7d4rlC7P/QjHVeILNIKPSds=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=hIt/acAlmEccT6NRuayraEKzmJaIbIS1JO2WKmlRJHSFKB8J9bAttxiCXFRn4T55p
	 8RKNzj8yPNxE8iNPUpGnMhU9iQ40rgQ2/dYJsrV72Ls8UXm9ha8MQ/NS5veYd2cbsR
	 yCIbXl7Bs9knslhhal6FmgjxqOgZ5/BZ4HL6LMCReveNHGw8//nThoh/vsOpKYJPZW
	 hmuFpjfW54Eb5KIgb8yITvbhF+xkyW0/25enQwi3HpLorpwe+OvY3C7b/MY77m002U
	 XRcsA/ywOxZEZm91fPQLgKJ5BvhRF5z2uTDlx65072kyCKf0zialCJFaRDqtbbuuC7
	 obcHN6jmLhtSQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 63450DF7854;
	Fri, 12 Apr 2024 16:08:33 +0000 (UTC)
Subject: Re: [GIT PULL] MIPS fixes for v6.9
From: pr-tracker-bot@kernel.org
In-Reply-To: <Zhjt0hXiftxCyFsH@alpha.franken.de>
References: <Zhjt0hXiftxCyFsH@alpha.franken.de>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <Zhjt0hXiftxCyFsH@alpha.franken.de>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/mips/linux.git/ tags/mips-fixes_6.9_1
X-PR-Tracked-Commit-Id: 4370b673ccf240bf7587b0cb8e6726a5ccaf1f17
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: e00011a146cde3a86fff96cb643f9b7dd40166ac
Message-Id: <171293811340.2506.13074166850125020009.pr-tracker-bot@kernel.org>
Date: Fri, 12 Apr 2024 16:08:33 +0000
To: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc: torvalds@linux-foundation.org, linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 12 Apr 2024 10:16:18 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/mips/linux.git/ tags/mips-fixes_6.9_1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/e00011a146cde3a86fff96cb643f9b7dd40166ac

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

