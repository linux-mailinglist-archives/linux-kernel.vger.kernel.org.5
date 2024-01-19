Return-Path: <linux-kernel+bounces-31616-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 255718330EB
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 23:51:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B8B3A1F2316F
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 22:51:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2DC05A0EE;
	Fri, 19 Jan 2024 22:50:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BGun5/rF"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4333A5A0E3
	for <linux-kernel@vger.kernel.org>; Fri, 19 Jan 2024 22:50:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705704620; cv=none; b=qAF0t7SdTvDo9/73lATzwxCkyKuTLwh1vkrv+9iJmp+fWROQ36uTdPB1/jDEYLHUx2R3krWcpKh0PPV1QFMglXch5nVhv3AXlaZc5VK5Te2X1ikqy+/2k/cLRGNo+jY99cKazK5nHneYhzufrUXg2u4+PYa+ptK/S7fKb5uPfUQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705704620; c=relaxed/simple;
	bh=tYWKSHcN97RwXND1o+pF4F0kzSiMQyxovu1R3nNftx8=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=pkEfIY6o8xJKH+Qc0psPhZjNIV9Ufn1ok/YmuP/6E9dQYUvkNlKBmjUQ64ab02tUJEdig2SBIN5/vNpbyOm9EaTaV+x5pzrwiHN7Nv9xr5bKUrTiHJVNnB4fWEUF8H3NornppULJh0w5Bz+s0rNQXj/ahiuz0c9TQjgZiuLlu+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BGun5/rF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 0EFCEC433F1;
	Fri, 19 Jan 2024 22:50:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705704620;
	bh=tYWKSHcN97RwXND1o+pF4F0kzSiMQyxovu1R3nNftx8=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=BGun5/rF/btnvhUcyUPAd7YoL9CosMiNK9t7NTjZuYzp6O9R8mihdQzS7Y6khWB18
	 PxBYMnHerDcxFBQg+wKfXOVq5RbR5m4safNO7QpbJ9Z4f2ctHTdzM3V64E+Zk1yFRr
	 ffM02smIVG2AzviJIs2PIBgrw2Oi8NNMjWfQ8Dei5eiYCaYSiFNTa2gsFxED98nxa0
	 b8PLi2F9BqK+KQ2iIkNBpXqXT13ymbLyW12oN8kIqjWbjs62EGO/Nzz/H5aBUmIGJ2
	 3V2/blxRcnERlTh2G0wLECvrBYABgwfQe9JcyaXxoZsxoCtxdeGeuGg8B0zqOUnTgW
	 pRTtbHNDjw8yQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id E6056DFC688;
	Fri, 19 Jan 2024 22:50:19 +0000 (UTC)
Subject: Re: [GIT PULL] arm64 fixes for -rc1
From: pr-tracker-bot@kernel.org
In-Reply-To: <20240119160528.GA5336@willie-the-truck>
References: <20240119160528.GA5336@willie-the-truck>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20240119160528.GA5336@willie-the-truck>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git tags/arm64-fixes
X-PR-Tracked-Commit-Id: 1b20d0486a602417defb5bf33320d31b2a7a47f8
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 18b5cb6cb85c2ac96b8e94e698d11b909225ce4a
Message-Id: <170570461993.3214.16288703189587345472.pr-tracker-bot@kernel.org>
Date: Fri, 19 Jan 2024 22:50:19 +0000
To: Will Deacon <will@kernel.org>
Cc: torvalds@linux-foundation.org, catalin.marinas@arm.com, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, kernel-team@android.com
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 19 Jan 2024 16:05:28 +0000:

> git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git tags/arm64-fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/18b5cb6cb85c2ac96b8e94e698d11b909225ce4a

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

