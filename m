Return-Path: <linux-kernel+bounces-75249-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B6F9485E544
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 19:10:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 47E35B24540
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 18:10:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B0828529D;
	Wed, 21 Feb 2024 18:10:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qO7HGtcs"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D45983CCC
	for <linux-kernel@vger.kernel.org>; Wed, 21 Feb 2024 18:10:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708539031; cv=none; b=hBXB/aWN/TGJRibW0Tyv99h9tol7V0CbDAoqb8m1+mqBaAijqIES9UX1oPMn651mYCWYjPkJn0ffsBSWXnL4KQf29tY3PBaZgWsXU8zD7x3rNcqWqMDXiCq4uK6uwC4V+H8OWjwgGhOcbPSbnTPonph2tcizKunSgBjfY7ksvFg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708539031; c=relaxed/simple;
	bh=V+n8U7f/vFWbDQbJTX2eAMwPJvubmBJIUIGS9j/t+m4=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=kaL4c/aV/jUOANsN0UPSp3YQi5A9HbJET5TLXvKYAZdxY2HGLcma5BQ1qo/YBLFj2Nin0qLMaxDjAQRLiqSkKi8qfB31xhDqnSEsxKe/YRhIVXYW+snHUSyzJwYxsSPF9qbuRFi+XSv//c+5KaXred6oG4dnpEmsyJH8gUlb3CY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qO7HGtcs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 00F53C43394;
	Wed, 21 Feb 2024 18:10:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708539031;
	bh=V+n8U7f/vFWbDQbJTX2eAMwPJvubmBJIUIGS9j/t+m4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=qO7HGtcsoY6/mL3oTWvDGEZcz9aGRuQQTq4wEwE/eSJdiex+FkGs2cphNdKft/tqI
	 bHeDaY2e8A7oNG5mO0V5HfGcWoRVG/Vh2NQqzrIW+/bPFglRII6OM8CcANVdZxJR91
	 B4kAU0JkSQ3A5RZuH2GSdQU0vrxR/iD+gBTJxWDWmjc5dKXOQzNBx8UpBODlHrMRfF
	 LMNLTeKK6PC2Ai+HBPARimAURPB3tzjYaAeL2M0PTI80ZWQ48S2Y/GJKcFhSchCcxG
	 bXYvsogR1hHZzZlmEdjHcJAT1dC8sk6lWUTfKKxTAukksL8EJedeyqAQS4H1nArM8t
	 4/VnaAyHz8Kbw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id D0659D84BCB;
	Wed, 21 Feb 2024 18:10:30 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [f2fs-dev] [PATCH v2] f2fs: introduce get_available_block_count()
 for cleanup
From: patchwork-bot+f2fs@kernel.org
Message-Id: 
 <170853903084.7043.17909787736652958140.git-patchwork-notify@kernel.org>
Date: Wed, 21 Feb 2024 18:10:30 +0000
References: <20240220031515.4039498-1-chao@kernel.org>
In-Reply-To: <20240220031515.4039498-1-chao@kernel.org>
To: Chao Yu <chao@kernel.org>
Cc: jaegeuk@kernel.org, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net

Hello:

This patch was applied to jaegeuk/f2fs.git (dev)
by Jaegeuk Kim <jaegeuk@kernel.org>:

On Tue, 20 Feb 2024 11:15:15 +0800 you wrote:
> There are very similar codes in inc_valid_block_count() and
> inc_valid_node_count() which is used for available user block
> count calculation.
> 
> This patch introduces a new helper get_available_block_count()
> to include those common codes, and used it to clean up codes.
> 
> [...]

Here is the summary with links:
  - [f2fs-dev,v2] f2fs: introduce get_available_block_count() for cleanup
    https://git.kernel.org/jaegeuk/f2fs/c/48238f7bb552

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



