Return-Path: <linux-kernel+bounces-89849-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BC15986F680
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Mar 2024 18:51:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 553F41F214BE
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Mar 2024 17:51:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E19C768E4;
	Sun,  3 Mar 2024 17:51:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LQ4Y8UY4"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB30941A80
	for <linux-kernel@vger.kernel.org>; Sun,  3 Mar 2024 17:51:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709488285; cv=none; b=bU/EkP7ukbxF9xiZdfLoNagugI0UB9v7PwWlQ0MgojQVldG/ii9wPVM1jLIB0hlZyBAMDRAJrL3gb8VQ0MeUbf/PsY5nm+fuVlZAzs/KM01IbdbWYQzmRWuqyrggx6SUjkEB51xqF3FGqjCkk79XmpIVAt1KZD9sFFP9P02V6Ig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709488285; c=relaxed/simple;
	bh=2uvuRaWkLrGESmenV903LCAfTK3BJdqWUG1Xl119G38=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=eXZTsNSNyxPCh21OQ0Y504qL7D0NIRJ5mzbGmUQ0tpkxGF/umIfx9153aZdEL2Ok1bkZMsLRnG/9tpfWVKSnATUdvTdtdvY9Z4Thq/ZtuhynUkVVYRGfA2BfW/nzkj6NtUKaOmdxp4uVHo7oe8dGpQkFBTMiNrSv3j9Gq+f98ag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LQ4Y8UY4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id BD57AC433F1;
	Sun,  3 Mar 2024 17:51:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709488285;
	bh=2uvuRaWkLrGESmenV903LCAfTK3BJdqWUG1Xl119G38=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=LQ4Y8UY4b7ZnofFGk+rti4u6IHB+psCXAxhez6UZ/Rg3e2d9loT5E74SfhEV2XrTb
	 UmcmY5s/L2tErZ150GkiL6c5ikNSBagLfRCa+v4KUqhjTJZmeU0kEj6qx20+4bF4qK
	 3mEF59MsI8shS27uIW1HtPsW8kPQq6+/z/3YT6GxbYyNY3STnptxr4J1+VvyLx8vGd
	 mmjBG9pGohNBRRyW5pTl9uDDh5PGD6BlW6civ3AivD169YxY7XaFpaStEH3jPCRI/z
	 JZGEZoW/R0muojR5Ax3mJnMOzSdNkKunCG/ioyJ9lssbE9yH+33MpmEpG1Xx31p+Aw
	 Q0fpY1HRpZ50g==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id A8B36C39563;
	Sun,  3 Mar 2024 17:51:25 +0000 (UTC)
Subject: Re: [GIT PULL] Please pull powerpc/linux.git powerpc-6.8-5 tag
From: pr-tracker-bot@kernel.org
In-Reply-To: <877cijfqk4.fsf@mail.lhotse>
References: <877cijfqk4.fsf@mail.lhotse>
X-PR-Tracked-List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
X-PR-Tracked-Message-Id: <877cijfqk4.fsf@mail.lhotse>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git tags/powerpc-6.8-5
X-PR-Tracked-Commit-Id: 380cb2f4df78433f64847cbc655fad2650e4769c
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: e4f79000952e819d58b1edf56466413e7081e6ed
Message-Id: <170948828568.18009.13363747961648679635.pr-tracker-bot@kernel.org>
Date: Sun, 03 Mar 2024 17:51:25 +0000
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, nathanl@linux.ibm.com, linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org, gbatra@linux.vnet.ibm.com
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Sun, 03 Mar 2024 23:27:55 +1100:

> https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git tags/powerpc-6.8-5

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/e4f79000952e819d58b1edf56466413e7081e6ed

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

