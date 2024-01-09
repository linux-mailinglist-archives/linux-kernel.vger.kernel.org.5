Return-Path: <linux-kernel+bounces-20228-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CB491827C36
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 01:47:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F07E11C2307B
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 00:47:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E0A733F6;
	Tue,  9 Jan 2024 00:47:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aKPN44X5"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75A7123D8
	for <linux-kernel@vger.kernel.org>; Tue,  9 Jan 2024 00:47:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 3FFF5C43390;
	Tue,  9 Jan 2024 00:47:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704761256;
	bh=kaSVqiylQ1OVriAgdma+o2NRk9xOptJaNNEg23+9Xfo=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=aKPN44X5J90DbTq/d3/8G5LS22i+GKq7yQ+FUJHJp9k6qA4iNjaH1rQcfRs0baUz4
	 WMJNMTZQ2N8kyliL4/BiZYuUR5WTVTsYAfbbhkVyRir6NzHoyOJm1WLbDo7aJ+EGvp
	 aucHna/IHol+tC2wvyKc6nQjr+FOyACuWUhwclZ08WkcD3aq0vWGEjvMkogEP7l9Hq
	 j8EkxUUz8uJJ2PtQembhyWVGxIgz55X2oi0Dt7TBBxTvWWIspd/EXhTdz9Y2QUZ8lg
	 +/nthpRxNwlV9o6ZiOiHMjCXw5X27LtHzX9PZUM8Jn19hiiVN0ffzfKPLqcIvdrN/6
	 alFQe6gcjtzig==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 2AEF8DFC686;
	Tue,  9 Jan 2024 00:47:36 +0000 (UTC)
Subject: Re: [GIT PULL] Please pull powerpc/linux.git powerpc-6.8-1 tag
From: pr-tracker-bot@kernel.org
In-Reply-To: <87r0j2k231.fsf@mail.lhotse>
References: <87r0j2k231.fsf@mail.lhotse>
X-PR-Tracked-List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
X-PR-Tracked-Message-Id: <87r0j2k231.fsf@mail.lhotse>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git tags/powerpc-6.8-1
X-PR-Tracked-Commit-Id: 44a1aad2fe6c10bfe0589d8047057b10a4c18a19
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 968b80332432172dbbb773e749a43bdc846d1a13
Message-Id: <170476125616.27312.16824249786810615337.pr-tracker-bot@kernel.org>
Date: Tue, 09 Jan 2024 00:47:36 +0000
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, srikar@linux.vnet.ibm.com, chentao@kylinos.cn, jniethe5@gmail.com, kunyu@nfschina.com, dario.binacchi@amarulasolutions.com, sfr@canb.auug.org.au, adityag@linux.ibm.com, aneesh.kumar@linux.ibm.com, masahiroy@kernel.org, aneesh.kumar@kernel.org, kuba@kernel.org, colin.i.king@gmail.com, nathanl@linux.ibm.com, ajd@linux.ibm.com, arnd@arndb.de, kjain@linux.ibm.com, naveen@kernel.org, npiggin@gmail.com, oss@buserror.net, sv@linux.ibm.com, liuhaoran14@163.com, haokexin@gmail.com, ke.zhao@shingroup.cn, geoff@infradead.org, rdunlap@infradead.org, linux-kernel@vger.kernel.org, david@ixit.cz, zeming@nfschina.com, fbarrat@linux.ibm.com, vaibhav@linux.ibm.com, linuxppc-dev@lists.ozlabs.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Sun, 31 Dec 2023 23:07:14 +1100:

> https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git tags/powerpc-6.8-1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/968b80332432172dbbb773e749a43bdc846d1a13

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

