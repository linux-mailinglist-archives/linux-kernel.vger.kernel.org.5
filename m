Return-Path: <linux-kernel+bounces-164391-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E72AD8B7D1B
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 18:35:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 21E3A1C211A2
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 16:35:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAB12190670;
	Tue, 30 Apr 2024 16:33:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TjfLl3XL"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13B25180A8D;
	Tue, 30 Apr 2024 16:33:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714494796; cv=none; b=CpKUuHRWJBx6s7pBy6isapRDZ2mF5oPH9uPWTbiVi6/4btWI0k47M1dvydUsCtirO1Hmbup4YPy5xufqmH7GkiOAKgr2Rabhe8YOoW4k8ppxy8u/uSRMLs+J7lzpBLicD8IKEeMNa0uJRX942g+BMwGAvcCrvAqLeG8MCZ1nkno=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714494796; c=relaxed/simple;
	bh=2VW8d61N4NAeyGCm2dkIywGhQ7MuUKwRdc6tMwJHRnY=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=aJnogpI6H/Q/2/1YbZQg2zDdnep4wGqQGcYLVNDC0bVvFgY66BCnjJ5Ese6RcnEiKNATiKvPm3SA6pmY+k8FxEGaFe/OJQqPQLtxas1TWYzW45HQdBWmgyiIBT75Wru9nQZtlZwaronuTwd5gQUBmuItc/XHYm9mlBRBFv8ah3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TjfLl3XL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 9CC45C4AF18;
	Tue, 30 Apr 2024 16:33:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714494795;
	bh=2VW8d61N4NAeyGCm2dkIywGhQ7MuUKwRdc6tMwJHRnY=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=TjfLl3XL3UA0LP309RPQdyDMQIyP3YC6kDzHHKCnmxZnLyK+/MqPsXHMUKQlyjy0L
	 njBfF1eC97WcxTuDM0yBPtibjURdyFDW6vrcCJTI9hpzVI/3/Fa8VNhT1dsOF1yvjj
	 3pJK/+8Sjo/IkCmRmDUvCJD0dG/Ck9lp6AoKWOMCg5Ftrz8NJ0v61oHYRnQMIQwWFR
	 F7axWX7S3uCWQMDWbIu5p/nqTPDoXNJiojnqR3tiR0mJdGzxt7pi4oH1mYYK5600hk
	 1POXsRsvrkkpDsvcZUyZ9JNMCld7BfnrevrWmTtwgAdqvNdq2pqyF7eXLFuToPYsFw
	 VDkv5N2WklU1A==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 8BA9EC43443;
	Tue, 30 Apr 2024 16:33:15 +0000 (UTC)
Subject: Re: [GIT PULL] platform-drivers-x86 for v6.9-4
From: pr-tracker-bot@kernel.org
In-Reply-To: <pdx86-pr-20240430142334-272144146@linux.intel.com>
References: <pdx86-pr-20240430142334-272144146@linux.intel.com>
X-PR-Tracked-List-Id: <platform-driver-x86.vger.kernel.org>
X-PR-Tracked-Message-Id: <pdx86-pr-20240430142334-272144146@linux.intel.com>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-x86.git tags/platform-drivers-x86-v6.9-4
X-PR-Tracked-Commit-Id: 515a3c3a5489a890c7c3c1df3855eb4868a27598
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: a52a0b3997472d680b627170366c22a5c34b89c5
Message-Id: <171449479556.9419.1717364965416933589.pr-tracker-bot@kernel.org>
Date: Tue, 30 Apr 2024 16:33:15 +0000
To: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>, PDx86 <platform-driver-x86@vger.kernel.org>, Hans de Goede <hdegoede@redhat.com>, Andy Shevchenko <andy@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Tue, 30 Apr 2024 14:23:34 +0300:

> https://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-x86.git tags/platform-drivers-x86-v6.9-4

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/a52a0b3997472d680b627170366c22a5c34b89c5

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

