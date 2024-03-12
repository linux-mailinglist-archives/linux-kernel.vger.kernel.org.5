Return-Path: <linux-kernel+bounces-100646-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 26C6C879B37
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 19:20:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 58DF21C22778
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 18:20:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43DD7139590;
	Tue, 12 Mar 2024 18:20:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GJ6SqkP4"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89A1A139568
	for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2024 18:20:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710267608; cv=none; b=nTYmwj7jzLZinFfKtux+Q9cJH1kIpy61Cp8uXnsVv8niVl8/hpFi0KKvhm8NpQi85gBNQE6VrY3/EieKcx+jc7BTVGhMTlO9cDGEMIjviwjqoQBFf5ZfZzMdlyk21VNRICrL1WIEZ9EEmhU99CHvcqHLwdZUhPpPk1CwJOAbQqg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710267608; c=relaxed/simple;
	bh=JLY/sOTrP1oowVnW3Jehl0yzoG3MEdas0xLWO23d8Yc=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=CvhFNDd29Lwwo1rngTRMUW8kivaXTQZW3all++UuFI1aDS/IHy5bTrE6U6b6/mb6J7+BX69eHTdjTScKn3ZcvLT1Z63rTaM1ktAoZ677CIOHhQRYRulZh7RKyHzkzWHyU4rZrjJ4FKzGARAOD9QxX96SWm18ctrwCFZJt7RnsL4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GJ6SqkP4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id F1A75C43390;
	Tue, 12 Mar 2024 18:20:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710267608;
	bh=JLY/sOTrP1oowVnW3Jehl0yzoG3MEdas0xLWO23d8Yc=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=GJ6SqkP4isf/fNZyPBKIznj9rtlT+ckeRrjx8u15bo9LJzpaRxHr/gmFtWQzCYPTj
	 x5SLZo3eFFa9q0wtvQtujyEk+WaduAPCwipcVxuWYDPg5yxJHCreqPk7EK2qm1HIED
	 HJesaqoVcKxvtwXpHNPdATBXeRUriHW6u4s2A7S+2wYDkZkANnfVu1LHf/D7O/IvCs
	 ZQ91AKNn3+Kj49i4Tgu/o7Ru2RPRkUH2G7s1w3+XUT6rRTP5E3NB6SBhjYQ5jCFIuA
	 EmFPAliFUvYByEAME1IZQFK4h5bWV6xAXcOlXX2rKklfbg8VHgaomWXaj2tt2+Pc9s
	 G0TDuJtitDNow==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id D8BD1D84BAF;
	Tue, 12 Mar 2024 18:20:07 +0000 (UTC)
Subject: Re: [GIT PULL] m68k updates for v6.9
From: pr-tracker-bot@kernel.org
In-Reply-To: <20240311125843.1295782-1-geert@linux-m68k.org>
References: <20240311125843.1295782-1-geert@linux-m68k.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20240311125843.1295782-1-geert@linux-m68k.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/geert/linux-m68k.git tags/m68k-for-v6.9-tag1
X-PR-Tracked-Commit-Id: e8a7824856def1c8608401b0d7d05566d6e81c95
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 508f34f2381eb84b2335abb970b940aefef50a19
Message-Id: <171026760788.25732.17362999737574094426.pr-tracker-bot@kernel.org>
Date: Tue, 12 Mar 2024 18:20:07 +0000
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>, Greg Ungerer <gerg@linux-m68k.org>, linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org, Geert Uytterhoeven <geert@linux-m68k.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Mon, 11 Mar 2024 13:58:43 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/geert/linux-m68k.git tags/m68k-for-v6.9-tag1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/508f34f2381eb84b2335abb970b940aefef50a19

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

