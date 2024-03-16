Return-Path: <linux-kernel+bounces-105024-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E7E7A87D7BF
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Mar 2024 02:13:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8EAC11F2231C
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Mar 2024 01:13:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 373001879;
	Sat, 16 Mar 2024 01:12:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h84tYYEe"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78A3717F0
	for <linux-kernel@vger.kernel.org>; Sat, 16 Mar 2024 01:12:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710551577; cv=none; b=eWveS00JrCnqVI+EFLyHXguGOsKxlJ6MeBQ2+BenM+vH4POmGd7yWl9Zd4mpwPOAyJqX9fQBNHPkXQxTOwIi5uXhDEqzLxyk30ltCtxGXQz5+fERY/Laggz2YUfFaK8pCLMydbmqnpmou7BVcH4ZthXeMP5fDZZ2LZF+IWN4lMY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710551577; c=relaxed/simple;
	bh=AYCpYaUfYmtFgIobyEWOgpa5ZUdwm5RXbFeSBnlEDwk=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=WvW0NFnktc+f6nudoLjDbb1KCWdu+UaMHTouG5p+SzeNCRlnQ1XhxRrg/1KcfWRLhsn+ssi/1fuhQs9LOltwIgBc68Ty5i13Y+VMbGWHTsIkwyr+aYZi//p/Z7pnXpzfx6ycX/+wvStqS9BO/b6IW2UXxa/9Ce46acdOuMlBjgw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h84tYYEe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 4D6C1C433C7;
	Sat, 16 Mar 2024 01:12:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710551577;
	bh=AYCpYaUfYmtFgIobyEWOgpa5ZUdwm5RXbFeSBnlEDwk=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=h84tYYEeo4qYwUjyz8OYNbeEn9VgoRxng/MbOCQsWKKR6GFYmf0O0yeuQs5J/iWTH
	 F5Tb2i75RGoC4bi1Zsk7T3rMddB0CUpmHMr3pd1gsMKk2L1brB0uqZ2ifljd1hf+DP
	 mo8enxXBH+8mvhHJhBkWXiW32zcYT0GwPF/Xmoe948vE3RHZny9N4i3DIE3o4qaBrA
	 WtmrXnajqxzOv/M/X4OliZSdetOVYprzKeVlmVg+vbgOUeXYcSFrWQ+6gX82cLJLc+
	 shzWC9CxNdm0zmU5nPYVC3q1iQ2M9Nz+E45HIqXFQjVb8lWkcYtykBGdQXkriuFUx6
	 P+tSL0MJs6Rsw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 41AB0D95060;
	Sat, 16 Mar 2024 01:12:57 +0000 (UTC)
Subject: Re: [GIT PULL] Please pull powerpc/linux.git powerpc-6.9-1 tag
From: pr-tracker-bot@kernel.org
In-Reply-To: <87h6h72h38.fsf@mail.lhotse>
References: <87h6h72h38.fsf@mail.lhotse>
X-PR-Tracked-List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
X-PR-Tracked-Message-Id: <87h6h72h38.fsf@mail.lhotse>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git tags/powerpc-6.9-1
X-PR-Tracked-Commit-Id: 9db2235326c4b868b6e065dfa3a69011ee570848
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 66a27abac311a30edbbb65fe8c41ff1b13876faa
Message-Id: <171055157726.25988.1346643204579685627.pr-tracker-bot@kernel.org>
Date: Sat, 16 Mar 2024 01:12:57 +0000
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, chentao@kylinos.cn, szabolcs.nagy@arm.com, set_pte_at@outlook.com, ricardo@marliere.net, maddy@linux.ibm.com, damien.lemoal@opensource.wdc.com, u.kleine-koenig@pengutronix.de, kuba@kernel.org, zeming@nfschina.com, arnd@arndb.de, kjain@linux.ibm.com, sshegde@linux.ibm.com, npiggin@gmail.com, nathan@kernel.org, sv@linux.ibm.com, geoff@infradead.org, linqiheng@huawei.com, linux-kernel@vger.kernel.org, adhemerval.zanella@linaro.org, brking@linux.ibm.com, linuxppc-dev@lists.ozlabs.org, masahiroy@kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Sat, 16 Mar 2024 10:47:07 +1100:

> https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git tags/powerpc-6.9-1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/66a27abac311a30edbbb65fe8c41ff1b13876faa

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

