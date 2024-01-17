Return-Path: <linux-kernel+bounces-29469-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C8BD830EBC
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 22:46:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 666DC1C236E3
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 21:46:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D23412557D;
	Wed, 17 Jan 2024 21:46:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WUzUTHgi"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1768125577
	for <linux-kernel@vger.kernel.org>; Wed, 17 Jan 2024 21:46:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705528006; cv=none; b=Uco0U9o/mheiS3QLOKZpDdfY7d0Qi7ImcQsFucMbtA2g1OlXZaBPRX2BQq4rGmLrgJ9IFlyrIJuFAPGs+KjOeGjUPLIu0Z/25WXe+Sx1PXkXMnzEXcpqosVIQcfvneeNDu4ai5hYLTSsuCzwLW7HlR41Tig0HSFLvgKwC2K+ZAQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705528006; c=relaxed/simple;
	bh=JeVSfy1WcN0zA1TvZfy+lzPXJGr3Ws8eFBa8RciWznk=;
	h=Received:DKIM-Signature:Received:Subject:From:In-Reply-To:
	 References:X-PR-Tracked-List-Id:X-PR-Tracked-Message-Id:
	 X-PR-Tracked-Remote:X-PR-Tracked-Commit-Id:X-PR-Merge-Tree:
	 X-PR-Merge-Refname:X-PR-Merge-Commit-Id:Message-Id:Date:To:Cc; b=RPFf0FctSH992/waqeiWiluYmAkD1IfIF165FDG7K3OvHgiV2Z9FV8Fn7qil0RSwSAW6D2IaqfYvj+tWQ/0qEgKkpu+yN+0+yekKoY/ywfqUP/i5SsQ7MLUx8RPPDPZLMoAslw1FzzsKNSRN2S/nleLdM9yyCGqhUxptn5z06/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WUzUTHgi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id E1B6DC433C7;
	Wed, 17 Jan 2024 21:46:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705528005;
	bh=JeVSfy1WcN0zA1TvZfy+lzPXJGr3Ws8eFBa8RciWznk=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=WUzUTHgi+rCsrJ66GGn5YRUwFF3+dH18VYSAUPqHbZifEkAH3GRA7HOZXc49+oozm
	 tmlR/VwOBcJSFy58BMKe21/IAk/thoOPBhXqoz77iSFlBMhYy7DMnqbdPaEl9TGmV7
	 WB3IvPot/PnUa/YRqOaIeVstui/iIEgV0hWSXcfSS+ioiS/sg8f9TrEQpo9m8FwA9h
	 T8J79nn2RD59T/PpL2pyY9frLDOp/4rnm9nagvk7tcog5cJBgsyAtUd4EwtGO9tueD
	 i1fYr1vRGwZbYmYAcUTGepWESq9b6eftd3gll/VoOoRUFp3iK1IgwIhOzC0vUAsbRN
	 6oqAAJL5t1a0w==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id CAE14D8C978;
	Wed, 17 Jan 2024 21:46:45 +0000 (UTC)
Subject: Re: [GIT PULL] xen: branch for v6.8-rc1
From: pr-tracker-bot@kernel.org
In-Reply-To: <20240111121943.3342-1-jgross@suse.com>
References: <20240111121943.3342-1-jgross@suse.com>
X-PR-Tracked-List-Id: Xen developer discussion <xen-devel.lists.xenproject.org>
X-PR-Tracked-Message-Id: <20240111121943.3342-1-jgross@suse.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/xen/tip.git for-linus-6.8-rc1-tag
X-PR-Tracked-Commit-Id: 2d2db7d40254d5fb53b11ebd703cd1ed0c5de7a1
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 82fd5ee9d8a516d47a17e8c99c2712a3fd937014
Message-Id: <170552800582.31446.6268487683399554343.pr-tracker-bot@kernel.org>
Date: Wed, 17 Jan 2024 21:46:45 +0000
To: Juergen Gross <jgross@suse.com>
Cc: torvalds@linux-foundation.org, linux-kernel@vger.kernel.org, xen-devel@lists.xenproject.org, sstabellini@kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Thu, 11 Jan 2024 13:19:43 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/xen/tip.git for-linus-6.8-rc1-tag

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/82fd5ee9d8a516d47a17e8c99c2712a3fd937014

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

