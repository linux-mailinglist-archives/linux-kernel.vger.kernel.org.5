Return-Path: <linux-kernel+bounces-104712-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8574A87D2A6
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 18:21:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 66DF81C21FBB
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 17:21:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57EBB482C6;
	Fri, 15 Mar 2024 17:20:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dIRP6H+6"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 959E951C30;
	Fri, 15 Mar 2024 17:20:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710523219; cv=none; b=HHmB6/RWzi6Lp4UjfZaSqlRhPUoQBO3AF4mQsbfwZ/W68x1oEbi3zp7h9T3Yi0pwXxnn7q9tWBhJ6IpT4jlFlIJuTYi10jGb+X4793T4vrVrxwud1NoLc8d6As4RMdmE334RYYph55HgNU6pP97/GqzvBZ03/Tmr/3zCDnw7F60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710523219; c=relaxed/simple;
	bh=e9xwoAtmUAJnKF1AMCjf6lzNiRqrdeFSB0YNtCK3VU8=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=S7oB8gFk042az4VPOsEf4vp4fe9rHBZfZHtE7VERumO2R+CxxClFUmJ8dYXaXHWAH/xwxZu5zlpgxUCmt42arznBB5kDHVN2SN2+Lrg84NwdZFnfLRoM7vPZRMjTbVOeWf+i1TJY3zPYJ+g0Js9A6+i1+7zg8/StpypcFVr3OL4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dIRP6H+6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 79AB0C433A6;
	Fri, 15 Mar 2024 17:20:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710523219;
	bh=e9xwoAtmUAJnKF1AMCjf6lzNiRqrdeFSB0YNtCK3VU8=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=dIRP6H+6Nnxs0pXEOqyV3un6FPSF/l8sN3Gks1scJS8NOPcs9MWZBvoTEZNX1Gis6
	 36lkj7AC3oUSvi9HzPbITzRlZQw3og9+F2xBx90NPX4jEByNhDcU83/EfmMejnKDrj
	 BRnN/IOA21xzmnFDhu5y9081xL/zdDQaO/P5hgtjgTVGjxgikjfUGsI866yoebt3KN
	 F+WKeGkfVY7KIcUA46wp6sky4AYqnCWYK9R4OuUjQv6AuIJjuevwGO2Hw2mpXDEdE8
	 np1FstQi6fK1i9WSaiFdslaiCEMGkaGjIZRBhgPbtR6Fb12ssKU9SMMJiSUWDKVIK7
	 /m0fXtgisKE9A==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 5D9A9D95060;
	Fri, 15 Mar 2024 17:20:19 +0000 (UTC)
Subject: Re: [GIT PULL] fs/9p patches for 6.9 merge window
From: pr-tracker-bot@kernel.org
In-Reply-To: <ZfRkyxUf8TIgsYjA@1149290c588b>
References: <ZfRkyxUf8TIgsYjA@1149290c588b>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <ZfRkyxUf8TIgsYjA@1149290c588b>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/ericvh/v9fs.git tags/9p-for-6.9
X-PR-Tracked-Commit-Id: be57855f505003c5cafff40338d5d0f23b00ba4d
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: c442a42363b2ce5c3eb2b0ff1e052ee956f0a29f
Message-Id: <171052321937.31681.10047137342837877893.pr-tracker-bot@kernel.org>
Date: Fri, 15 Mar 2024 17:20:19 +0000
To: Eric Van Hensbergen <ericvh@kernel.org>
Cc: torvalds@linux-foundation.org, v9fs@lists.linux.dev, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 15 Mar 2024 15:10:03 +0000:

> git://git.kernel.org/pub/scm/linux/kernel/git/ericvh/v9fs.git tags/9p-for-6.9

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/c442a42363b2ce5c3eb2b0ff1e052ee956f0a29f

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

