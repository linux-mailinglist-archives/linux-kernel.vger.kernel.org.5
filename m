Return-Path: <linux-kernel+bounces-151776-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CBF728AB3BE
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 18:50:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8A887286AE4
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 16:50:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA59713AD30;
	Fri, 19 Apr 2024 16:49:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ddLrNCwi"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 268F113A3E0;
	Fri, 19 Apr 2024 16:49:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713545384; cv=none; b=mHRTCSIFKLopozD6YrkSPT2U2KZmvFbLgBQYgoESrzDNSL3xE5TnpD8VWtiT4ljU83TEflMjdgDaY5d6fIyuun/vuQB1n5czu7iVVXkLUcs60BrffrmtZ83UlutMBbR/ALa9ZyZXBz6cghqhL1KYtaurj2tC5gQtc3wSx4W2EQI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713545384; c=relaxed/simple;
	bh=E79hZ2QghLLo5QrO4BmPDEtFN3OjS9FOE0wCUBix5g0=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=uVc14rXYfmTNKhPwF5Mf/Ra5fMDadyD8QWJriL92h4bKMjiPTBaIc+903AqzqBOpZyx87s6FpvtVhyQT1s/iAGzF8lVyHb769A3bckmxe7N90OJvt1Iyx5jAbWrs293+7JQUt7VO+heXgKSVAhTxLVNQ/mJFEVmMd4e1rua8YTk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ddLrNCwi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 094C1C4DDEA;
	Fri, 19 Apr 2024 16:49:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713545384;
	bh=E79hZ2QghLLo5QrO4BmPDEtFN3OjS9FOE0wCUBix5g0=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=ddLrNCwiU3tOUt9/lsCx5513E7XV2jK6TlqfME5MczjToomGB/FfQRn2smCo8iRD5
	 J/VseTkHzGjHtmXivf2FmtNrrz4X6SCL0seJBjv0RARGVaQMA+5XOCT8WDbzergYZK
	 13upo2HUSciUig2pe/XyCJPLEaDQVN0jscJjvWCJgOcK1Q8H6zS7ojBdjOZT7tSrCI
	 vFIj2bwCrQmkhqr9myzIUL4cN9xuUBKff5gzVHjfysNp7P7iBWPGVbIsULZjteWMVT
	 pMezw52oXYmRLWtANXBNBAh6sgOmsWW4gnW0jPOAZIYNBfTb4m6Q+h2qsi6lk+ZwDv
	 BqDyexy9sE91Q==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id F357AC433E9;
	Fri, 19 Apr 2024 16:49:43 +0000 (UTC)
Subject: Re: [GIT PULL] hotfixes for 6.9-rc5
From: pr-tracker-bot@kernel.org
In-Reply-To: <20240418144340.2f5d96a1c4e0a8fd2dc9cb66@linux-foundation.org>
References: <20240418144340.2f5d96a1c4e0a8fd2dc9cb66@linux-foundation.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20240418144340.2f5d96a1c4e0a8fd2dc9cb66@linux-foundation.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm tags/mm-hotfixes-stable-2024-04-18-14-41
X-PR-Tracked-Commit-Id: c4a7dc9523b59b3e73fd522c73e95e072f876b16
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 54c23548e0f5609f55b353bcd3c1aa295852f383
Message-Id: <171354538399.26173.7640383696126430263.pr-tracker-bot@kernel.org>
Date: Fri, 19 Apr 2024 16:49:43 +0000
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-mm@kvack.org, mm-commits@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Thu, 18 Apr 2024 14:43:40 -0700:

> git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm tags/mm-hotfixes-stable-2024-04-18-14-41

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/54c23548e0f5609f55b353bcd3c1aa295852f383

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

