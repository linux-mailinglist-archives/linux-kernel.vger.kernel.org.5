Return-Path: <linux-kernel+bounces-101092-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 036F987A232
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 05:11:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 92DCBB21DCC
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 04:11:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53C2010A2E;
	Wed, 13 Mar 2024 04:11:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tRpw79mL"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97C6610A11;
	Wed, 13 Mar 2024 04:11:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710303103; cv=none; b=VewNPDZmCmNJOxoX6fN8hE8tR3OXYMC2zMbIrM1PrdLx6s59XM8EAr1lw74cbGA1fun+BIplVadIlBqLDRz5nxTaO3ItZ+SwHow5rcEIr73nBJZNdGbxQ+zp76fDu7dlRrBuDEtJ2z6lTUfFklBAEB67pyzY/NCCbXiHVLYY3UY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710303103; c=relaxed/simple;
	bh=zY1KoiX+P/u5npblXX8FugJaWuLHZzg5yqRZL3d9kts=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=VY1plTKx0yEx30tircskJ2pwFYWdoahx3yFvvE3qnmTQJM1uzhzlO1uinlKjWJYFdOEWjlCzJOa6ImfyJ54s5jaTyEITAyMog2H07Rg7IR5N09xUBe/B7iOKwnfdlVlenjR25bD71AwOkOT3md+8kmlcqF7S6sbICXE46TGR4XU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tRpw79mL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 34612C433F1;
	Wed, 13 Mar 2024 04:11:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710303103;
	bh=zY1KoiX+P/u5npblXX8FugJaWuLHZzg5yqRZL3d9kts=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=tRpw79mLCpaJVewK5Ea7Ng/6HpTaio/PtG70ou5flFFlYd5uZPeVEwS88qTi6/xJF
	 IDFIYGSdIXbJJ8i4+cMsZDB7Thk/gkYS7VM7ds80h8o1m58V2whp9MSfjfPmRflb+q
	 Gk6GNt3/0ePue31+ReFTJl/tkzygOE8D4WRl9HYM5pneccLkOy3GGtp+9zj5pQRgYc
	 L6ycKFMxSdPdlpHp4rb+qbp7I7tQjCNaXusVZnQSW2qmKMMhDd1ASLzsOY9LFfaHSB
	 oEAI0TYsbv0Q3P+R3C+RO/+FpE/ctcRndVvSxVmp3Zq1lyc0S+myDQrGataBRDKyZK
	 /dWc9bQpgg6wg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 20FF3D95057;
	Wed, 13 Mar 2024 04:11:43 +0000 (UTC)
Subject: Re: [GIT PULL] slab updates for 6.9
From: pr-tracker-bot@kernel.org
In-Reply-To: <c021631d-29e5-432f-bfcd-1d75ec28d065@suse.cz>
References: <c021631d-29e5-432f-bfcd-1d75ec28d065@suse.cz>
X-PR-Tracked-List-Id: <linux-mm.kvack.org>
X-PR-Tracked-Message-Id: <c021631d-29e5-432f-bfcd-1d75ec28d065@suse.cz>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/vbabka/slab.git tags/slab-for-6.9
X-PR-Tracked-Commit-Id: 1a1c4e4576d439a14b2499de52b9225c69348903
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 0ea680eda6c9f59a9512f8b0dd4abf229bb9f6cf
Message-Id: <171030310312.24236.16630999580576162174.pr-tracker-bot@kernel.org>
Date: Wed, 13 Mar 2024 04:11:43 +0000
To: Vlastimil Babka <vbabka@suse.cz>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, David Rientjes <rientjes@google.com>, Joonsoo Kim <iamjoonsoo.kim@lge.com>, Christoph Lameter <cl@linux.com>, Pekka Enberg <penberg@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, "linux-mm@kvack.org" <linux-mm@kvack.org>, LKML <linux-kernel@vger.kernel.org>, patches@lists.linux.dev, Roman Gushchin <roman.gushchin@linux.dev>, Hyeonggon Yoo <42.hyeyoo@gmail.com>, Chengming Zhou <chengming.zhou@linux.dev>, Xiongwei Song <xiongwei.song@windriver.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Tue, 12 Mar 2024 10:55:33 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/vbabka/slab.git tags/slab-for-6.9

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/0ea680eda6c9f59a9512f8b0dd4abf229bb9f6cf

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

