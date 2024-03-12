Return-Path: <linux-kernel+bounces-99726-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 82D12878C45
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 02:30:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B20A11C21198
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 01:30:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 457F88F51;
	Tue, 12 Mar 2024 01:30:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XndmzQg/"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CA2F79DC
	for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2024 01:30:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710207012; cv=none; b=uYwTxYmHq3z57Y1E8h2YVlOgLko7BK3JbWzxlw2gEOWFDfc7++av4wLw5nJIzclHRL0P2BU+0Trxsq+5jend+ywgFleUWkY48htz1BOWIX0rsi4Ba1RHJDr0W0En11cfkTD1jPlIa43AZ2tZE6k7L3ROONe5DXcerBQyTfL10dc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710207012; c=relaxed/simple;
	bh=90OzkBkF5Ial5XZnjmysREdr2gMluUdXHuVMOtjNzNs=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=pr277Z89bHpU4GAfVfRqg2IwDIAOt6+MPah/k3UEsWeEPNHQXqNlMfRS2JcJUGQXmwcuyzIOKnukKLda06ZzYTzXKmJOHz+upXOaderwg0h/myp7AS+Co01EnOaa4TZ88DGUYlJ6Vvo+Pzv8nlmQVv8/le/ccNRXW/OyH+2foHA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XndmzQg/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 66BFFC43390;
	Tue, 12 Mar 2024 01:30:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710207012;
	bh=90OzkBkF5Ial5XZnjmysREdr2gMluUdXHuVMOtjNzNs=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=XndmzQg/oh/ixwwd3+05+DxnNTx6Nj0qGCpxmN/yTiOyznKomSzFmlnhHLdm4msk1
	 DYRIW8xb+U/sejLOEDXiDU2D3XD5FA+On7VopUxnaXnF1WOd91czB0UFcDgctukP5M
	 TtDG7tv3vCf1yq+scqPPFupM5PvzuuvyCdc0T6afYX/1v6r4w2758cEy6EFT0ZcjV6
	 ZtSCgqW2F9WYj/2UeS5j6IhND2lmUMJYYsZ9uZnxYAHJV12KOefuZ1GFx9BWVplKQq
	 byPXWId4SNL32Dw1WhaOa9zIw64T2QB1OwDFCs6bcDVWRSyyUUzSnsF1lZ2tIxVN3Q
	 Gw/vDWv5PvcRw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 4F0E5C39563;
	Tue, 12 Mar 2024 01:30:12 +0000 (UTC)
Subject: Re: [GIT PULL] x86/cpu for v6.9-rc1
From: pr-tracker-bot@kernel.org
In-Reply-To: <20240311085424.GAZe7GwJr7hzOjLHC_@fat_crate.local>
References: <20240311085424.GAZe7GwJr7hzOjLHC_@fat_crate.local>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20240311085424.GAZe7GwJr7hzOjLHC_@fat_crate.local>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/x86_cpu_for_v6.9_rc1
X-PR-Tracked-Commit-Id: 03ceaf678d444e67fb9c1a372458ba869aa37a60
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 742582acec1e894b80815ab379e1c9d347a0406b
Message-Id: <171020701231.888.2237364649092254548.pr-tracker-bot@kernel.org>
Date: Tue, 12 Mar 2024 01:30:12 +0000
To: Borislav Petkov <bp@alien8.de>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Mon, 11 Mar 2024 09:54:24 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/x86_cpu_for_v6.9_rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/742582acec1e894b80815ab379e1c9d347a0406b

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

