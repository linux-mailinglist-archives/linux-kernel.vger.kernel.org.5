Return-Path: <linux-kernel+bounces-143011-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 169388A3330
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 18:08:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AA7D81F24237
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 16:08:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80E981494A4;
	Fri, 12 Apr 2024 16:08:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nqk+rlhO"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3ACC14882F
	for <linux-kernel@vger.kernel.org>; Fri, 12 Apr 2024 16:08:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712938113; cv=none; b=u5WFNrNHmAqNybajEowpTfj6G5Nih5iTBijTgrZHmTiarJqs/4yFjQEkclp355jUMC9KOsi4KTBMNlcq9YJX9kEeSXDoeGDA2ktrisKHTKlJ80GXEIDyATR7kowo5YIis1Yf1k4DlToO5w8pGqvlhsnm2tyt96l2E/K2OzlOCFw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712938113; c=relaxed/simple;
	bh=EQaip/3jpIkfvUiM1PHE/n7MMEHGcetbEGTURliVlN0=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=pUkpQFJVQ0r0XaxjgeV+bds7IfmN0nlzkI5Uf4VBLWjiT0awBOogsUXsXnHlmaSgEyN8IgeFke8sP+CFX1N7s2Us1D9w/qfMG4uZGyZZbYLCljOiwI+c8/DShM8Jkiapue3tDgT6e9xgkQHm0lGKwr9YVfB6BUZS9KLMhAHY3qc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nqk+rlhO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 9E846C32781;
	Fri, 12 Apr 2024 16:08:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712938113;
	bh=EQaip/3jpIkfvUiM1PHE/n7MMEHGcetbEGTURliVlN0=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=nqk+rlhOUilexb14qrIE9pxASSOpZtHo9bFpYoqEgpUlTNNC8Yyn724IoTgGq9nEN
	 rJtLdZJV/U5oXp+UstjXQaQNexQEqQgQAR0L4k2V/olVtI7jZjzTjK4j8N3tEOkeYC
	 m9tnxhVOgF8epOG2SZQW2E9saDrqbnmHM3stfrvYgVBMcAuQpZM+j1DxuaCJr8Whnx
	 oo2yOnc/JXdCCksUvycGEDF5kWHwK1wjAHK8Oj6mXJ5JgyZY7/pIaB8wz/6Qj8oTHq
	 4XCUpw9tJ3IrWK0ijhXlsaOcISLOW8bpXYp8G5Tif64GsDubnHLt4mPYrS09ZAZ2Hp
	 xvoZjzqyY7bBA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 93E08DF7857;
	Fri, 12 Apr 2024 16:08:33 +0000 (UTC)
Subject: Re: [GIT PULL] tracing: Fixes for v6.9
From: pr-tracker-bot@kernel.org
In-Reply-To: <20240412103204.453d912c@gandalf.local.home>
References: <20240412103204.453d912c@gandalf.local.home>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20240412103204.453d912c@gandalf.local.home>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace.git trace-v6.9-rc3
X-PR-Tracked-Commit-Id: ffe3986fece696cf65e0ef99e74c75f848be8e30
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 5939d45155bb405ab212ef82992a8695b35f6662
Message-Id: <171293811360.2506.5314754152004417233.pr-tracker-bot@kernel.org>
Date: Fri, 12 Apr 2024 16:08:33 +0000
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>, Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Andrew Morton <akpm@linux-foundation.org>, Arnd Bergmann <arnd@arndb.de>, Prasad Pandit <pjp@fedoraproject.org>, Yang Li <yang.lee@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 12 Apr 2024 10:32:04 -0400:

> git://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace.git trace-v6.9-rc3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/5939d45155bb405ab212ef82992a8695b35f6662

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

