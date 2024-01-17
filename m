Return-Path: <linux-kernel+bounces-29392-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DB3EB830DAB
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 21:04:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 900771F27BEA
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 20:04:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB885250FB;
	Wed, 17 Jan 2024 20:03:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HuOa92Wz"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A41424A1F;
	Wed, 17 Jan 2024 20:03:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705521828; cv=none; b=WPR1yqfl1Ij/MKQ2OxxB9V0hTmteCgewqCiX4agReubjvzm+4pv5A85jo+J/kdkzeslzq2GLg2JaBP+5NqPgoDZvtdzTSiP7FoeHBPZYIU7DOhgRyvcMxSubSOZVN9Tnu4OnEwDU/PF7djlLMfbq8tTAJbEjwFEpDxFFNJkseA4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705521828; c=relaxed/simple;
	bh=wx6wOmiRxTpKBRcpaxFfkcfe8MsQ0EYB44nlE8dPfis=;
	h=Received:DKIM-Signature:Received:Subject:From:In-Reply-To:
	 References:X-PR-Tracked-List-Id:X-PR-Tracked-Message-Id:
	 X-PR-Tracked-Remote:X-PR-Tracked-Commit-Id:X-PR-Merge-Tree:
	 X-PR-Merge-Refname:X-PR-Merge-Commit-Id:Message-Id:Date:To:Cc; b=Vmr+eCQau+c5aTCnrtWI3XVr/irXyFAJqSceFzJShJCZFECgfALoI1suVqG2pnsmpXMUCdaSp/3N3YjC+5Ez987Z15X0hs6ZjROLdvykN58k1WOqNjpqR9T+JDnMaAuepEOncqlQTEoJnW3QjesicvaTAWE7MvAj3QRV16znRno=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HuOa92Wz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 8AE05C433C7;
	Wed, 17 Jan 2024 20:03:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705521827;
	bh=wx6wOmiRxTpKBRcpaxFfkcfe8MsQ0EYB44nlE8dPfis=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=HuOa92Wzt6SiavNHCsBbLhAQozOYxSnYVYRkQG1UWsdkzyO4oLjgrJEe4hL1R0Kcm
	 myKpxX4Rk0jcCbXBsKlpzKOq0/SNi8o45tp2xGxWeKkNcBi/7r45VKN4I3TO9IEg33
	 JJ9OUH8GK8Afo+OpFQOo2c4q9IR8MAfQBt32xrV6IC3xmP36yNKSHcYcdzqD7/FU3E
	 mapXHnCGH9d0Qp9O2J3ZkxVc865YaUBKXt5vLqwPI+zkQAD+AsoQaRPtfEDDyIcHrf
	 c+UB37eQNGZehaP3OqlWu0jrjYTN4XmSSYPkItrgXIcg2Jsrv7qN7qxVRpwia+38gI
	 8jFFmZzIFWU7A==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 790ADD8C97B;
	Wed, 17 Jan 2024 20:03:47 +0000 (UTC)
Subject: Re: [GIT PULL] Documentation fixes for 6.8
From: pr-tracker-bot@kernel.org
In-Reply-To: <87h6jb6hzf.fsf@meer.lwn.net>
References: <87h6jb6hzf.fsf@meer.lwn.net>
X-PR-Tracked-List-Id: <linux-doc.vger.kernel.org>
X-PR-Tracked-Message-Id: <87h6jb6hzf.fsf@meer.lwn.net>
X-PR-Tracked-Remote: git://git.lwn.net/linux.git tags/docs-6.8-2
X-PR-Tracked-Commit-Id: ead8467f96d6dc35bbf8c63ee9d244a357ede84a
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 1b1934dbbdcf9aa2d507932ff488cec47999cf3f
Message-Id: <170552182749.2985.6346589998341850599.pr-tracker-bot@kernel.org>
Date: Wed, 17 Jan 2024 20:03:47 +0000
To: Jonathan Corbet <corbet@lwn.net>
Cc: Linus Torvalds <torvalds@linuxfoundation.org>, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Wed, 17 Jan 2024 09:29:40 -0700:

> git://git.lwn.net/linux.git tags/docs-6.8-2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/1b1934dbbdcf9aa2d507932ff488cec47999cf3f

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

