Return-Path: <linux-kernel+bounces-95955-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D1F71875553
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 18:39:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8DAF8282461
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 17:39:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96A80130E58;
	Thu,  7 Mar 2024 17:39:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K+XnL7PX"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF2B112FB26
	for <linux-kernel@vger.kernel.org>; Thu,  7 Mar 2024 17:39:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709833142; cv=none; b=HZRza4pNb+E5VVaYEghFfHLbWeRHSZyqEyNvg4/OBrPMCFWXjRLqMyLZ4Okha8tB8x54EpxistZr92BJG4NJ954jc11BPO9d6tO/jpnNtRZappVEMJHMttRK87lp8OlAcenyl0W4mhSfSKp1u+QexnN2XRiW7KyMzWoo5KdjQak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709833142; c=relaxed/simple;
	bh=oM4uNQBsXyZN8KJ4oiekxNVeuoHLyJp4B1XAD6FI0zk=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=jZQHXpuvTSOW1Jfv//mj425OZcuePSshRlP9B0ZdVY7dxnTelv41Ik+J6lADlErd8/wVe1CJExUESPI0ubnpmvKL/23X3pzDYqzt3VAD6Np1q/sq3yswTkvgYNQuCJqM6/iUojrLy8Xt4chiTuBZzST7i7cq3LFVZA+SVmTWd9E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K+XnL7PX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id A8681C43390;
	Thu,  7 Mar 2024 17:39:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709833142;
	bh=oM4uNQBsXyZN8KJ4oiekxNVeuoHLyJp4B1XAD6FI0zk=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=K+XnL7PXs/XrQREfoJh9BZlafNSSi6T2CPvFluvNTuXHQojpw4fiEKdH9gquIwvcb
	 8jPgB2FgA+q1W1FSBOhXu4UuuH9H4jCrZFgyWDYaCObJkpgwljfB+GdDXQn/30t37c
	 /aKZFgKzqwLSTWCoGkqibXmF1yEj/RY2X0OBq5l6jgnbRPcbMPAKbyQfENH6YLYlYP
	 w9MP85ck8Y3QEAMo3oEhP5ussSS+aVREI4Cexcfz30Ya/cIA1KKAPxT9SAZw19fIUo
	 zNFLP/4agVYc/e44TFTg3D7u7DDA6YZRQvdW5HCWhpjXsmRYuhGc4YVjarCW6N76GB
	 yvxeW91q0c0CA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 8BACCC04D3F;
	Thu,  7 Mar 2024 17:39:02 +0000 (UTC)
Subject: Re: [GIT PULL] erofs fixes for 6.8-final
From: pr-tracker-bot@kernel.org
In-Reply-To: <ZensqX1/c0L/hZJf@debian>
References: <ZensqX1/c0L/hZJf@debian>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <ZensqX1/c0L/hZJf@debian>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs.git tags/erofs-for-6.8-fixes
X-PR-Tracked-Commit-Id: 4127caee89612a84adedd78c9453089138cd5afe
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: d0e88885b8865ad1d57d9fd991f85d410175143b
Message-Id: <170983314256.22258.12631287813216370479.pr-tracker-bot@kernel.org>
Date: Thu, 07 Mar 2024 17:39:02 +0000
To: Gao Xiang <xiang@kernel.org>
Cc: Linus Torvalds <torvalds@linuxfoundation.org>, linux-erofs@lists.ozlabs.org, LKML <linux-kernel@vger.kernel.org>, Sandeep Dhavale <dhavale@google.com>, Chao Yu <chao@kernel.org>, Jingbo Xu <jefflexu@linux.alibaba.com>, Yue Hu <huyue2@coolpad.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 8 Mar 2024 00:34:49 +0800:

> git://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs.git tags/erofs-for-6.8-fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/d0e88885b8865ad1d57d9fd991f85d410175143b

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

