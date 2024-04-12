Return-Path: <linux-kernel+bounces-143152-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 133778A3514
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 19:45:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C11792878F1
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 17:45:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 332A114E2C8;
	Fri, 12 Apr 2024 17:45:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F+ze7DwJ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75FDD84A35;
	Fri, 12 Apr 2024 17:45:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712943931; cv=none; b=Rc86bt6t41MBmNufQzyRWD0IeuttdLOb7Klp4QV4sj+8hkffMAiOlkYwJxkQC7ajz2aqAQDxkiaPBL2dF1H7kW2oYgC5dgisTEJkqQ4SHmbHqmgvlIv50w4QEwxcP0QZqi0xBNmG5fOq+VnuEiTuAqVytbPboUFJO6TOrTP2XbY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712943931; c=relaxed/simple;
	bh=ENVt3zmAgsH3ymYiPjuTxchP7Skz5NOapQ8N/0iOiGw=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=Fnz+I5sIqGi8gowWgI2axhGQ5RYVUvBXd0cbNSl9Uv4J9SRhARPpdchKUAsfUMF2YxlqZrWfbX38yGBUJUMlJ98RhktVfGUSfH9UYgtx2bMzw6tQfBBMV8//Ov8aklZAGiDzMsY9HZYjhoehB/Vg93/OG1Nt87xJltGi5imI+rA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F+ze7DwJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 004C2C113CC;
	Fri, 12 Apr 2024 17:45:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712943931;
	bh=ENVt3zmAgsH3ymYiPjuTxchP7Skz5NOapQ8N/0iOiGw=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=F+ze7DwJ4nd78p3JiS6LvI6fU1AWxs9GHuLh1gG8+llphlX7xAh2/XEiLMPmpoPOS
	 zemYTMdQlp7Hw8+ukU9yzIA9eCgFsUDCQI904VqLmn+mIJFQ4fCYttcbpfZnPozyno
	 2OgzQzQRtU3Nj7qDY8KJnJ96yfityadSfwiA9eX7hGoaYICUmjhVWXGu4IZbMZHkgd
	 nkbDh0V5ZDFzpC2GXN/fhFGZd7i26f/J47JxhdSkAWM3HLp1Kb0nze/QmqWvdEFhX7
	 uzAcIbdYat5/RYd2WnvxcpRiN+V9tB6uISxn1sGFy5/BwzQsV3QTFAlcoILcsaBKn+
	 47lVGcY6JSPSg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id E975ADF7854;
	Fri, 12 Apr 2024 17:45:30 +0000 (UTC)
Subject: Re: [GIT PULL] Ceph fixes for 6.9-rc4
From: pr-tracker-bot@kernel.org
In-Reply-To: <20240412162028.2447687-1-idryomov@gmail.com>
References: <20240412162028.2447687-1-idryomov@gmail.com>
X-PR-Tracked-List-Id: <ceph-devel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20240412162028.2447687-1-idryomov@gmail.com>
X-PR-Tracked-Remote: https://github.com/ceph/ceph-client.git tags/ceph-for-6.9-rc4
X-PR-Tracked-Commit-Id: d3e0469306793972fd2b1ea016fa7ab0658c9849
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 90d3eaaf4f401b334aa5d156f843df3a3e7b30a0
Message-Id: <171294393095.29341.5510521715939994211.pr-tracker-bot@kernel.org>
Date: Fri, 12 Apr 2024 17:45:30 +0000
To: Ilya Dryomov <idryomov@gmail.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, ceph-devel@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 12 Apr 2024 18:20:27 +0200:

> https://github.com/ceph/ceph-client.git tags/ceph-for-6.9-rc4

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/90d3eaaf4f401b334aa5d156f843df3a3e7b30a0

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

