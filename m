Return-Path: <linux-kernel+bounces-99801-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C5AD878D85
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 04:33:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 01047B22491
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 03:33:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1C005810D;
	Tue, 12 Mar 2024 03:32:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IYRmMf0I"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C679BE6D
	for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2024 03:32:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710214357; cv=none; b=GDhO3/3H0GQhnxS2TUfjTJKJQnsxu8LzC1R/udjQrPw+LG/WlKZCR7uVJyusl8Cjy3LRN9rLUKtmXFJfpOqmlf+IK6QmN2EKH7uwmO4/wGbIbkRgs1Gdp/BFsV+p2Y0Dg/IpaA3eEPKaUNyAY40J9xRtiiSkO+UndbBe3glmnaQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710214357; c=relaxed/simple;
	bh=G27xG04vKuwKOC/Pxwbz01B01I4ZChZwMweHc+uq/dM=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=VDiuwTwFQcv3aeEfIrnC1e1/TN66YtMpED9kxz7Eahm5WUvs4eOHN1VEJ2uSRGgpn/xS0BfyWJZy4Yx8NXLJL4rkZpxZLdFsWBTTyrA7/ieCZbJmlz/rTbl5jS+LftEguPOobAZxAHU74vypS+K2aWE5qqe71YLKccEgwqHV4WI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IYRmMf0I; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id E17CCC43390;
	Tue, 12 Mar 2024 03:32:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710214356;
	bh=G27xG04vKuwKOC/Pxwbz01B01I4ZChZwMweHc+uq/dM=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=IYRmMf0IOBivkpoKDQ7HK4wIm/DJ/tHZaLdtQkwellVKZeg5icUHhqfvHSfSxAJst
	 iQyL+1LKeZI73A+q1zham+CbyXDN+3vNp0whMHMmSJhaWicJLQGXSAyfi+Z7Abh7cX
	 NEUcNeT8Yp/s4DxjPttKuSDo9BMmeQ2pPo1+4vATsS7XIQki0TNIgx6sHVj06G0PMs
	 SudxftenVu2xBlw4/WQe+dNrIrZs5imeA4CCiDvATngtijWli66IeOOGruL1io2z08
	 2BJB8m1ESSgDDvg8z/HsOO+c91GJHmtBcmbz1ctgSOZGLxrBqcZVpoqZTnazHk796h
	 tFPTDbYZUpEHw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id CDF73D95055;
	Tue, 12 Mar 2024 03:32:36 +0000 (UTC)
Subject: Re: [GIT PULL] x86/mm for 6.9
From: pr-tracker-bot@kernel.org
In-Reply-To: <20240311173034.345007-1-dave.hansen@linux.intel.com>
References: <20240311173034.345007-1-dave.hansen@linux.intel.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20240311173034.345007-1-dave.hansen@linux.intel.com>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/x86_mm_for_6.9
X-PR-Tracked-Commit-Id: 82ace185017fbbe48342bf7d8a9fd795f9c711cd
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 555b68419000b4d406c2f3b62972e149ad780535
Message-Id: <171021435683.8573.13714974935274300637.pr-tracker-bot@kernel.org>
Date: Tue, 12 Mar 2024 03:32:36 +0000
To: Dave Hansen <dave.hansen@linux.intel.com>
Cc: torvalds@linux-foundation.org, x86@kernel.org, linux-kernel@vger.kernel.org, Dave Hansen <dave.hansen@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Mon, 11 Mar 2024 10:30:34 -0700:

> https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/x86_mm_for_6.9

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/555b68419000b4d406c2f3b62972e149ad780535

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

