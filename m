Return-Path: <linux-kernel+bounces-158917-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 50A458B26AC
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 18:40:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0FED8284A45
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 16:39:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B68214D71D;
	Thu, 25 Apr 2024 16:39:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="steLnyY3"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B839914D6FB
	for <linux-kernel@vger.kernel.org>; Thu, 25 Apr 2024 16:39:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714063169; cv=none; b=qDep0OsnoiB8yuNfKg+NtB1sOsCl/UCRR1/yeuA2Mse25HV6MizdmL5LfuqkxCicDR37XKB+wbRN8j/+O7ZT+37fx5LRlpCldpV9yeAy+eRyJTFzRLQ0JWdZ3W9t4wc7JU/qn6vDVBJ6wVX1BIArZX28HygV5gM+dvBLgUSUvgE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714063169; c=relaxed/simple;
	bh=8PO9dYWM6Yx5/ndrQC1GCB6zNlbuCNtOAsNSVTuyvrc=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=JrOulNfPaPlafQhExeyOOlXZDAIYXiol7PSDCjEsWCVN0s2QxnJ1DVbm8FAlTAzsYwBDxFL92LjQ5lxfWa8GnN1ji9tE8IZ2yy5KKVRMB7KIrUyWQpuLwXIxnoiSSJgsG7g8C8qWeD8FGCq/++Jr2wq13jOh0iNeMtHfzaDDfPE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=steLnyY3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 990A1C113CC;
	Thu, 25 Apr 2024 16:39:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714063169;
	bh=8PO9dYWM6Yx5/ndrQC1GCB6zNlbuCNtOAsNSVTuyvrc=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=steLnyY3Wjqigf6kcdCv7spwcbff1Wmi3n+qdI5doKGAc5OcGbSuyhz95qc0Ak95l
	 U1AajQuGWwstrUykzzmGpM/9N7D6EEnbuZFn3QEA13SR3QbNrdfZgz1bLTViq0lVT/
	 thkwo6Q4S1P20RzkYhmsSD5bSVokjY1mnkKd+7/Dw3qmjq6O9+DdhV2noILJULC7ET
	 7IyfhNZytGY2/A5tqFXJsuFSpUPhEnMkvXsxAz0W7FQNonJNLgCES8rM+V/7R7mDPx
	 feSm9zpFExXC8u8bVC4Kbp1grjrbqeQfiirl0hw4DsnUbSzGLvw/+yjdXAuJE7fSsa
	 qCiYRXsZJzT2A==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 888DDC43140;
	Thu, 25 Apr 2024 16:39:29 +0000 (UTC)
Subject: Re: [GIT PULL] HID fixes for 6.9
From: pr-tracker-bot@kernel.org
In-Reply-To: <gj7iqr5pqrdolfrq7zwbj4uybipp64kj7nqphqovq4ixraefbx@rfda346sojjw>
References: <gj7iqr5pqrdolfrq7zwbj4uybipp64kj7nqphqovq4ixraefbx@rfda346sojjw>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <gj7iqr5pqrdolfrq7zwbj4uybipp64kj7nqphqovq4ixraefbx@rfda346sojjw>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/hid/hid.git tags/for-linus-2024042501
X-PR-Tracked-Commit-Id: 3cba9cfcc1520a2307a29f6fab887bcfc121c417
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: f9e023299bc3df3fe12f8e800ab512891dac47e0
Message-Id: <171406316955.18419.748212817407465348.pr-tracker-bot@kernel.org>
Date: Thu, 25 Apr 2024 16:39:29 +0000
To: Benjamin Tissoires <bentiss@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Jiri Kosina <jikos@kernel.org>, Thorsten Leemhuis <regressions@leemhuis.info>, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Thu, 25 Apr 2024 10:22:26 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/hid/hid.git tags/for-linus-2024042501

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/f9e023299bc3df3fe12f8e800ab512891dac47e0

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

