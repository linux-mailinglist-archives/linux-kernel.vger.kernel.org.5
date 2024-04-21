Return-Path: <linux-kernel+bounces-152463-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CECA68ABED4
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Apr 2024 10:52:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8663B280C3C
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Apr 2024 08:52:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50747DF51;
	Sun, 21 Apr 2024 08:52:50 +0000 (UTC)
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 605188F44
	for <linux-kernel@vger.kernel.org>; Sun, 21 Apr 2024 08:52:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713689569; cv=none; b=eSgqELsntPjTYavAbU/u1GzE3XYj8E7qDz2Ah0sF7bqUl1b1qrcLgCKZqYsUBpvweNUsMqaFDa3w7NNXhhJ1+Wotb4zJqvapfYyk6HIjlx9qCsMHluEcp8NR4rycmftwHHULVtLRhCT+UHty5doKJzhINpQjDKmAUTmpe8EfFhA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713689569; c=relaxed/simple;
	bh=JzMyXeVnKIp6JY/28uTyl7Y5lgxP7ECjjwC7XhLKwl0=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=Kg106WgvLirW5Rx4wmh5LOQKGJeHZWLCp3SHpiKuKNW1pASmuy/3z9FKbtaiYiWSeTG+H4N88Gq0AYRC9XG54Kb0ZVq0NU26kb3BdnAc7ZzoQYQQmu7CMAMr74UnLkMSfgjtf6ua5bRdWfHRwpvMGo9oOxwxh0bcJS/35T16W0U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 4CD3B40E00B2;
	Sun, 21 Apr 2024 08:52:46 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id ONrmXqlw5Pxj; Sun, 21 Apr 2024 08:52:42 +0000 (UTC)
Received: from zn.tnic (pd953020b.dip0.t-ipconnect.de [217.83.2.11])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 8C15240E0028;
	Sun, 21 Apr 2024 08:52:38 +0000 (UTC)
Date: Sun, 21 Apr 2024 10:52:37 +0200
From: Borislav Petkov <bp@alien8.de>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] sched/urgent for v6.9-rc5
Message-ID: <20240421085237.GAZiTT1fEGnBzUS55m@fat_crate.local>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

Hi Linus,

please pull a single sched/urgent fix for v6.9-rc5.

Thx.

---

The following changes since commit 0bbac3facb5d6cc0171c45c9873a2dc96bea9680:

  Linux 6.9-rc4 (2024-04-14 13:38:39 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip tags/sched_urgent_for_v6.9_rc5

for you to fetch changes up to fe90f3967bdb3e13f133e5f44025e15f943a99c5:

  sched: Add missing memory barrier in switch_mm_cid (2024-04-16 13:59:45 +0200)

----------------------------------------------------------------
- Add a missing memory barrier in the concurrency ID mm switching

----------------------------------------------------------------
Mathieu Desnoyers (1):
      sched: Add missing memory barrier in switch_mm_cid

 arch/x86/include/asm/barrier.h |  3 +++
 include/asm-generic/barrier.h  |  8 ++++++++
 kernel/sched/sched.h           | 20 ++++++++++++++------
 3 files changed, 25 insertions(+), 6 deletions(-)


-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

