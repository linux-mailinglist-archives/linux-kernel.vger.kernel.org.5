Return-Path: <linux-kernel+bounces-89850-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 478EC86F681
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Mar 2024 18:51:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 023E0281DF4
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Mar 2024 17:51:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88E7E768E6;
	Sun,  3 Mar 2024 17:51:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YjCvYMpV"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C83B87640F
	for <linux-kernel@vger.kernel.org>; Sun,  3 Mar 2024 17:51:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709488295; cv=none; b=cXuWdL9kLC7nXVQ/RTW0IPj2bp6uws+vejz08D58Hy2YHw0MEuwhTMmm3c+fwMLJIoRC378s04EFZ12WCQZ/m9TeB8E76JeUnuCN7zLGZ70eCxwqiFfT4pW/QNt3RTVjL2hRF3JFvqz2LiqWd8B3I8FhcrVv4xvcnAu5WpTUapI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709488295; c=relaxed/simple;
	bh=iFgKRwFJY2kKTDuf/uP7Sz+tYY0FkxokN94y3PFdji0=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=AsndE/ZcR5mzaB33niV55mLL0UtFncrL87cMRkk0VylahYfWrjssrUihKLIlGX/X609i1rwKy58/cOGiFqnZGOvZYggsj4fgUu5ZNWYxqmTPxamC7LhkHJSN/tEgsnvqO/ZWKzCcnZWdwvDrm5UyE/Z17PJtbJVE4xR11hoDTpg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YjCvYMpV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 5D9D4C433C7;
	Sun,  3 Mar 2024 17:51:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709488295;
	bh=iFgKRwFJY2kKTDuf/uP7Sz+tYY0FkxokN94y3PFdji0=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=YjCvYMpVV/2LCVOPP0cF4x2OQvd4Zdd+vkxMLlM1CYKTnYA15x4PJGnp0ctIKLfrr
	 1+UMUNvHvcyJJ5USiUt/mMKoMtKiKYzHkUHPfjqh9yv+ArvRh23Rj3SlXksaofnmdI
	 yph7RLk1xcMzfxRVLAOO9ggrq9+eiLNn0g/GDzh9dyLVmYklNP6AUmeC5gTJiW8/cG
	 iK+f8YIb8ikV7MzKm7+OqRS8tpqG/91oPOt2MQswuZ8TuQ9x7VbY8jypxO3QNEfwQF
	 CgYk+izR76MmVMtDULQrZRHh5G2IipM0M7FpDzJMm6Du1PbrAyQqUZQVsdYvMHIce2
	 RfAg48W81vmjA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 4B8DBC3274B;
	Sun,  3 Mar 2024 17:51:35 +0000 (UTC)
Subject: Re: [GIT PULL] x86/urgent for v6.8-rc7
From: pr-tracker-bot@kernel.org
In-Reply-To: <20240303105304.GAZeRWkNr8xmllFHr1@fat_crate.local>
References: <20240303105304.GAZeRWkNr8xmllFHr1@fat_crate.local>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20240303105304.GAZeRWkNr8xmllFHr1@fat_crate.local>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/x86_urgent_for_v6.8_rc7
X-PR-Tracked-Commit-Id: 7fd817c906503b6813ea3b41f5fdf4192449a707
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 73d35f83354c2b54a0bf52fef94b40f483680b91
Message-Id: <170948829530.18009.14144780735391346983.pr-tracker-bot@kernel.org>
Date: Sun, 03 Mar 2024 17:51:35 +0000
To: Borislav Petkov <bp@alien8.de>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Sun, 3 Mar 2024 11:53:04 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/x86_urgent_for_v6.8_rc7

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/73d35f83354c2b54a0bf52fef94b40f483680b91

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

