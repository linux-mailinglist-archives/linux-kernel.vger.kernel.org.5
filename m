Return-Path: <linux-kernel+bounces-110528-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CB5A88602C
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 18:58:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9E899B222D3
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 17:57:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4089E1339B5;
	Thu, 21 Mar 2024 17:57:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CKb+8ag+"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60AB0133413;
	Thu, 21 Mar 2024 17:57:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711043859; cv=none; b=dIYyttin+hJeWoKTr7IFjIeZjzLDNvKmOC6Zc8GwtGDesvueYieaDRjcTGc8P8dKZmTayyEAtbtNFhVJBFJCUZQqvmCtHQqgtJXwJGrqgrYmBjHzRSmLu9lhqjpRNdXJdndtFGLRGAWn9w302Xf18sqBWzMganWXrjqNXkBBLnM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711043859; c=relaxed/simple;
	bh=E1v3vmpsG1X62FPbnWwNy3JFqJsLIzB/DJg8aspblb0=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=kuU8DXHnkZE0gZ9U4QneO8Ai3CM4FkUtynlTST51PL2aIf9S0rVr0wh1WXH+pa8vZkTCyjE4jFR5JQAOVkxZNo05GwyXjZPTeNLaYIqEHI52Gt+QNbk1BXhGtb3qTD50kQtAWdzBRr+Y4RuQYOic6vdJhoqmOttvkk6Jw/3k+l4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CKb+8ag+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 40520C43399;
	Thu, 21 Mar 2024 17:57:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711043859;
	bh=E1v3vmpsG1X62FPbnWwNy3JFqJsLIzB/DJg8aspblb0=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=CKb+8ag+6cvKUPyPhelOTY2u13Um1kXLfNC/agy2DMPxSQBu2EY+KPamnY0yVZF/g
	 kPg7xd6O0Pb3AiIgLorodKCir80kvxBK6JY/LZ4N219m40BHyGj/jk9ynxPVYR5OJK
	 ZLtNhtpMMS5Ko9l4oQ4IZ1ZIJfMsCVxaheVX79ZXg/oLxBm4Ai3B/40PRJCUmp5QCF
	 Zx7fETVqzpuQf4ksQEYJqAe0indgU04nFK8zF9l997lylO1DPAxz89GoMQzHrC2QuZ
	 k/JoSuXllHTMKFAY7o9y9CZcBVrqHmNtAoAGzrc/RNK3YRIxzY0lmNbEsTtYcX3Hcs
	 GGK9XEdE1FOiw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 30811D84BA6;
	Thu, 21 Mar 2024 17:57:39 +0000 (UTC)
Subject: Re: [GIT PULL] hwspinlock updates for v6.9
From: pr-tracker-bot@kernel.org
In-Reply-To: <20240321125730.1676568-1-andersson@kernel.org>
References: <20240321125730.1676568-1-andersson@kernel.org>
X-PR-Tracked-List-Id: <linux-remoteproc.vger.kernel.org>
X-PR-Tracked-Message-Id: <20240321125730.1676568-1-andersson@kernel.org>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/remoteproc/linux.git tags/hwlock-v6.9
X-PR-Tracked-Commit-Id: cebaa386d5ee1a44a58c12f1d220f62cc567fdb0
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 2ac2b1665d3fbec6ca709dd6ef3ea05f4a51ee4c
Message-Id: <171104385919.25447.4626527420330598569.pr-tracker-bot@kernel.org>
Date: Thu, 21 Mar 2024 17:57:39 +0000
To: Bjorn Andersson <andersson@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org, Andrew Davis <afd@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Thu, 21 Mar 2024 05:57:28 -0700:

> https://git.kernel.org/pub/scm/linux/kernel/git/remoteproc/linux.git tags/hwlock-v6.9

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/2ac2b1665d3fbec6ca709dd6ef3ea05f4a51ee4c

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

