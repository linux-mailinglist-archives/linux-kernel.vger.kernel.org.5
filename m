Return-Path: <linux-kernel+bounces-144333-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 750B18A44B9
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Apr 2024 20:49:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A5AF71C210F5
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Apr 2024 18:49:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01186137751;
	Sun, 14 Apr 2024 18:48:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iZ6HnXz5"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42351136E1E
	for <linux-kernel@vger.kernel.org>; Sun, 14 Apr 2024 18:48:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713120484; cv=none; b=EKT1fKLVVFPZ2A1kQb7wiZ5bjQUA3W2xG/7hqzI8Dyj5lr4GN1+c2+7YGCVSHchRqlbnY24WdjXYdsjMTINjPVGNQIKK//QImEEzB8wrHxExssTGGCXuZyHfAP+4mAFMNdbqedFJFFbVVcj5lrX+/F5siQIfMgGbX6KGTkCWzOc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713120484; c=relaxed/simple;
	bh=DpYNpH61qQGrs+5kdCvf/jK1bB84grwpDjNBCzHhJoQ=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=DWnDHRfgbiZaC/uPUpP426ZOR/mq8vcTFtGwlEbvBj0Ztg3qA6f6BwkQ92pPvtuhk0rt+9WP36+DuoMmV7xXwIwdAdGXr9k/KXRlFMdYOVjOPklMUrMrE364iWhEYsBvJUo0v+z7U7mz+4+3Z9B5IOBi7vm5Uynk6l6ySKJoVv8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iZ6HnXz5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id BB490C072AA;
	Sun, 14 Apr 2024 18:48:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713120483;
	bh=DpYNpH61qQGrs+5kdCvf/jK1bB84grwpDjNBCzHhJoQ=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=iZ6HnXz5bmDS0mXi16+eKDCNYZQNI6QozPKGM8fsEO/QZzQ5AyP26NxdXoNJv8xbK
	 bnA3dcrDVK1OCKuVbLZ/IpLMJVsSrbj/haPqfYEHgcJgbaJx50JZIkTvsE2Jt6qqsG
	 oQqQ/8XHnW8D0/b369Q8fNQqMjY4CKJxgzBVqQZUqqiv0Vby38mr+qbsM8t1QkVgBa
	 alvNMft90ClvEtcocfjcDwHuPpt9j/Dp9CxaKrxQ3FItwZXPX9SZruyBynE2xP8eSu
	 dPMUvYeIpr1tp7p11bz6u5d3OqsPqManbWsFVn00+8iiulsnV9ToEOroQ7a9gDlXZI
	 mEQOaeAMUs3ew==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id AE254DF7857;
	Sun, 14 Apr 2024 18:48:03 +0000 (UTC)
Subject: Re: [GIT PULL] timer fixes
From: pr-tracker-bot@kernel.org
In-Reply-To: <ZhuW2WdSHa8kdd1q@gmail.com>
References: <ZhuW2WdSHa8kdd1q@gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <ZhuW2WdSHa8kdd1q@gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git timers-urgent-2024-04-14
X-PR-Tracked-Commit-Id: 16767502aa990cca2cb7d1372b31d328c4c85b40
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: c748fc3b1f5605c12c8061ffb0c27707597b27b2
Message-Id: <171312048370.2589.17935255715467470180.pr-tracker-bot@kernel.org>
Date: Sun, 14 Apr 2024 18:48:03 +0000
To: Ingo Molnar <mingo@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>, Peter Zijlstra <peterz@infradead.org>, Andrew Morton <akpm@linux-foundation.org>, Anna-Maria Behnsen <anna-maria@linutronix.de>, Frederic Weisbecker <frederic@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Sun, 14 Apr 2024 10:42:01 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git timers-urgent-2024-04-14

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/c748fc3b1f5605c12c8061ffb0c27707597b27b2

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

