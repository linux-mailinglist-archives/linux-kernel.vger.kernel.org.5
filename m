Return-Path: <linux-kernel+bounces-60578-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2807B850749
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Feb 2024 00:34:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 815DD283412
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Feb 2024 23:34:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63FB35FF18;
	Sat, 10 Feb 2024 23:34:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MzrBR7q9"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A52545F57C;
	Sat, 10 Feb 2024 23:34:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707608054; cv=none; b=Tb5N2n3CKLjtv6d4oR/n2G2YIB1W4cFvAJYqBTZNLWnc9s7L+FIBNxe3DIfLprUZ2NZHj4mS5x6SGPEUpnM0+vddrq0gtvzk1Dhe4hK+cIwsy3Mnmjip0BKbM+9+tfOxsR9AyYGkf/1mHnfi7R+Y7//wGjcMrpj0hWkKJyH0FkM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707608054; c=relaxed/simple;
	bh=6nNTF+faAHJi8hdlpBRPLLv2Tc58ORpaVWjWbvdmDeg=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=qpTJ+bM7ZqnsWOoRKIjSupQU/MGdj0rAGIke6t/+XREpGaXczn8NAIjbuVZxcQOxjvEg+/lx8UQz0dgPV+yAGvTYr3qIknFKPgaDRbiUA3OTs9vGDPgv1sIYtI83V5jKYgU379D/kwqHFUaB3Ig/m7qKtOHyv+AMuEafe+KlwWQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MzrBR7q9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 7C1C1C433F1;
	Sat, 10 Feb 2024 23:34:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707608054;
	bh=6nNTF+faAHJi8hdlpBRPLLv2Tc58ORpaVWjWbvdmDeg=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=MzrBR7q9vQgwY5kjuNJJNkCcAzG6h14J3KYmqmRs9afvs9GL6bBR1RJIXViW0XOWK
	 VbOLpSOf9ESl5XPdU3TKMg9f67N1HdPzGmGSMPYiQNWT3S5qkeXkYSc3PbVg/xEmNB
	 LrRAJheA5EQbSgvQ1RrFmV8mA0Je5vZ17jIrarUmvln8RhCKVV+dOnr1M/BdpHzeoz
	 0jKfErGK0E6zhAcAyw+seQMrYP4AZC0fjoy9LOEImYb7KznW8lOm7OCHx78V2FRsBt
	 /OIH7xWyiZi+GMGssRJGPZ1EFVmPB7MxA2gUP0Hb6z54H5x3j1qrvTFxzYAWzYuSHl
	 uCLK15rCLj7iA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 6BD31E2F2F0;
	Sat, 10 Feb 2024 23:34:14 +0000 (UTC)
Subject: Re: [GIT PULL] hotfixes for 6.8-rc4
From: pr-tracker-bot@kernel.org
In-Reply-To: <20240210112006.05781090736edc6e02de7e19@linux-foundation.org>
References: <20240210112006.05781090736edc6e02de7e19@linux-foundation.org>
X-PR-Tracked-List-Id: <linux-mm.kvack.org>
X-PR-Tracked-Message-Id: <20240210112006.05781090736edc6e02de7e19@linux-foundation.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm tags/mm-hotfixes-stable-2024-02-10-11-16
X-PR-Tracked-Commit-Id: 5bc09b397cbf1221f8a8aacb1152650c9195b02b
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 7521f258ea303c827434c101884b62a2b137a942
Message-Id: <170760805443.26012.2238777938908938531.pr-tracker-bot@kernel.org>
Date: Sat, 10 Feb 2024 23:34:14 +0000
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-mm@kvack.org, mm-commits@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Sat, 10 Feb 2024 11:20:06 -0800:

> git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm tags/mm-hotfixes-stable-2024-02-10-11-16

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/7521f258ea303c827434c101884b62a2b137a942

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

