Return-Path: <linux-kernel+bounces-98011-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 76BF4877349
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Mar 2024 19:35:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2C3C31F2111B
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Mar 2024 18:35:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2633547F41;
	Sat,  9 Mar 2024 18:35:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oqgTD67i"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6214E4779C
	for <linux-kernel@vger.kernel.org>; Sat,  9 Mar 2024 18:35:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710009302; cv=none; b=SZfYtsvYS9gfWmSn8ybfhTd5L+3qeUWetmXFp/WPN09mg1hvg45MKJ8oI0gLIa/mdFYH/8SJb4s6Je4rjy98gyEP6ZAhr4qrsSLslRqYvtyl0HEZlAMJKKkLptsO/2iSacOgGLWZVTRC+2kSD/o4vOksMVGPA1mvFqTey1vuht4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710009302; c=relaxed/simple;
	bh=c7P08Zr1eGgmD9H5IqeZVnC6uFKbn32g9ZLd/VCk92g=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=enaNgGVA8S1LyvnMzpCUuXJJgfezDOyL7Vwk1fqpLuYjtGO+zXgGu+lD/U0wuh2xZBIS/TKR/Hg86asRX4+HJ3Xa8FB3Tecf9By5pT+rWl+d4v0OYxvjwcW97I0GbuA1DoCLS9Ltqlhj+xpHzLVtN7UBEMzxjFnwjdx8Mz9JszU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oqgTD67i; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 42022C433F1;
	Sat,  9 Mar 2024 18:35:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710009302;
	bh=c7P08Zr1eGgmD9H5IqeZVnC6uFKbn32g9ZLd/VCk92g=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=oqgTD67idk5KvXnUxtgkbxgqCKMAXWcOwEwyaNHHBbRd9iBNz4bbm7yyOc6KfjDsl
	 8wW5OSj0QfGndFKEb5d6JT0cWxGLMLaWsInHAkYPvv07koJB80Q7QVZ+aIJbyYpR3F
	 Gs0Iz92AnKe8BR0HLh1nM1eDkNJ9VTwaybqVvMI8L02fWQWgNbDC5pxEMLoFfg+trS
	 z5YyOQLqvbh2OXAYWHp9u/RzqmIvH7gMTTN1OrJatdE43/qf7FZuCg1rmOmPSu6Gha
	 p8muc0EP72jOrp6a0mhfZ9yODUQBN9mUuw0TUffHIWxaE8d9KKRATN9P0sMY+3Q/OY
	 cBmBWH3MH/csA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 3050FD84BDC;
	Sat,  9 Mar 2024 18:35:02 +0000 (UTC)
Subject: Re: [GIT PULL] firewire fixes for v6.8-final
From: pr-tracker-bot@kernel.org
In-Reply-To: <20240309040142.GA126658@workstation.local>
References: <20240309040142.GA126658@workstation.local>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20240309040142.GA126658@workstation.local>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/ieee1394/linux1394.git tags/firewire-fixes-6.8-final
X-PR-Tracked-Commit-Id: 575801663c7dc38f826212b39e3b91a4a8661c33
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 66695e7d94fc499f26411044e07cc1386e4f3aa7
Message-Id: <171000930219.24252.13599548042468530477.pr-tracker-bot@kernel.org>
Date: Sat, 09 Mar 2024 18:35:02 +0000
To: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Cc: torvalds@linux-foundation.org, linux-kernel@vger.kernel.org, edmund.raile@proton.me
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Sat, 9 Mar 2024 13:01:42 +0900:

> git://git.kernel.org/pub/scm/linux/kernel/git/ieee1394/linux1394.git tags/firewire-fixes-6.8-final

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/66695e7d94fc499f26411044e07cc1386e4f3aa7

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

