Return-Path: <linux-kernel+bounces-144232-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BCC48A436F
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Apr 2024 17:34:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D11D11F21390
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Apr 2024 15:34:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 629521369AB;
	Sun, 14 Apr 2024 15:32:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pQfimu3o"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B576F134CC7
	for <linux-kernel@vger.kernel.org>; Sun, 14 Apr 2024 15:32:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713108765; cv=none; b=GdpFfcTdJi5gAxifgl7Feu3QiywLyCyR04omvXAqu0v8IyLdDN3loK02XSX8oxymbaulqGLg8MXrXB05HzCi/LUjcdUFpw3J5KCeWP19QW6xn4oGCNiWS0r6B/3o8whcr6s6SQtpKmDNmFtH3X4SZBBjdHIwZYwg+ZM8LQAijaA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713108765; c=relaxed/simple;
	bh=Nq3NlHtxi8rvfgNbkSAh4DaAAJW8IF5KEUOEpD4s3qM=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=QbqXRl/j30sD+GGlRFvKY+jlZvYlEM5Kvr9iWJJ9Z6RnhShcL9fQFccAOGQZrKOpAPLth3Yepc2jJzpQHUJaneer+Hx3YQLc/3RyVDD5yC4A1jx19h5D3SBe8wg2duBCe16Yl4piBAtcpqtPyrdfll8C4cbgh7zZQM+o7fTjslc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pQfimu3o; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 85571C4AF4D;
	Sun, 14 Apr 2024 15:32:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713108765;
	bh=Nq3NlHtxi8rvfgNbkSAh4DaAAJW8IF5KEUOEpD4s3qM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=pQfimu3oZuJOYZZZ4vviipCEbG7l8+Dq62nBa+BXxQ5b0RVm1HEBIu/tsiEPs0pSY
	 OrrJZmqNMxpNWD0dG+vdzK7vVXv7xq7qmfblr7MxvRWmfPTW4wyxW7dZqMDpPvO3hQ
	 gGwXyCYT8EwX3QuODm48po/PJJW6kO2FAqClPO+8JrHVysS6wVClj7HuTGfvvz41V1
	 eqaZpf2Bfq1VrzBRCt3oF79gun+rSj7iMKP9jT81VNE3Ilq6JghTi8tRgCetEzhuJ5
	 VQXQl05v7TU00Q2cMc776UgtgHUlMxwLTvDBKMDNdI286D4AtvTWQnzSnoL1W+sej6
	 B07hckn2BHdfQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 7ACCFDF7857;
	Sun, 14 Apr 2024 15:32:45 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [f2fs-dev] [PATCH 2/2] f2fs: allow direct io of pinned files for
 zoned storage
From: patchwork-bot+f2fs@kernel.org
Message-Id: 
 <171310876549.3156.14230955021108259973.git-patchwork-notify@kernel.org>
Date: Sun, 14 Apr 2024 15:32:45 +0000
References: <20240411183753.2417792-1-daeho43@gmail.com>
In-Reply-To: <20240411183753.2417792-1-daeho43@gmail.com>
To: Daeho Jeong <daeho43@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
 kernel-team@android.com, daehojeong@google.com

Hello:

This patch was applied to jaegeuk/f2fs.git (dev)
by Jaegeuk Kim <jaegeuk@kernel.org>:

On Thu, 11 Apr 2024 11:37:53 -0700 you wrote:
> From: Daeho Jeong <daehojeong@google.com>
> 
> Since the allocation happens in conventional LU for zoned storage, we
> can allow direct io for that.
> 
> Signed-off-by: Daeho Jeong <daehojeong@google.com>
> 
> [...]

Here is the summary with links:
  - [f2fs-dev,2/2] f2fs: allow direct io of pinned files for zoned storage
    https://git.kernel.org/jaegeuk/f2fs/c/b2cf5a1ff236

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



