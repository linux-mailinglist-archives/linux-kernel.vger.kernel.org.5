Return-Path: <linux-kernel+bounces-65061-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F091854751
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 11:40:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2AE09286C71
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 10:40:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1108518042;
	Wed, 14 Feb 2024 10:40:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S2koEJ1o"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5532316423;
	Wed, 14 Feb 2024 10:40:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707907228; cv=none; b=RUgVH4fy00jlgqC7bKbsa0Io6HkfkokVANfbxP5GZOyDf7LfWJS+bXQWNrFiTUnxEOzFPn1DjQqvX7NOKZQoUuJlYcQJuKLSWL5VNhwwUva4OB9RVWDmFy9l/djRtAVihDIh5GiRFMGfe7uLMJPQsXrIrz2kgj+WHzyRfxtTA5o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707907228; c=relaxed/simple;
	bh=cMR8GwfjKhWu2bmBabwP8pWMVjFOLU4bR5rhua7s1Gc=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=n+Ig6Lwx8ZufuQ/YM3XNXkzEzxRmlwX0UzZizlsMONrS+q0v2h2LlgHipJl4peRVz1s3qQwGfGQyVoxIw46ZbIJDCiptAOKn9i/YS1PnNbXNqfugob9rr8wNWmq9+gAnXuSqwpnsry/azYXjNiYnEp3G7QzdV3jvpN2E0M3TI2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S2koEJ1o; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id A67E8C43390;
	Wed, 14 Feb 2024 10:40:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707907227;
	bh=cMR8GwfjKhWu2bmBabwP8pWMVjFOLU4bR5rhua7s1Gc=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=S2koEJ1oKIUGeiCX6mLUHwmStja2IvCr1dUwFgIxZ/Zgi3uidNaXH63n8GDRtxRnM
	 kQH06Vp+Egk4ZSXNXn/FBI127/KVAVQGOKeXflQAGvgHoNbdLNks8CX+k3sEUCe2ZR
	 2LKPf5Jfzbp4q2AWXOdDBvzbGxPbYBUc9pYssnfwrMAUL38wlfCu6vxgQ25+PhhbXX
	 Xcd/3n6iYNmfdKeTGphGMCI/BWxjrZRt2cZ0GMTYVb8uHJ+VxiyhgbtkXkiQcbs7eO
	 OcxrIOdX9ywOVUNcMSWWT2K+vzMSdukDm6WuvxE5qnafdWwWb4fBvSEMOQoy8vhMku
	 ZX51WqtIaFxxw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 8FC7DD84BCE;
	Wed, 14 Feb 2024 10:40:27 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [net-next] Octeontx2-af: Fetch MAC channel info from firmware
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170790722758.32380.8519631130744109763.git-patchwork-notify@kernel.org>
Date: Wed, 14 Feb 2024 10:40:27 +0000
References: <20240212131523.4522-1-hkelam@marvell.com>
In-Reply-To: <20240212131523.4522-1-hkelam@marvell.com>
To: Hariprasad Kelam <hkelam@marvell.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, kuba@kernel.org,
 davem@davemloft.net, sgoutham@marvell.com, gakula@marvell.com,
 jerinj@marvell.com, lcherian@marvell.com, sbhatta@marvell.com,
 naveenm@marvell.com, edumazet@google.com, pabeni@redhat.com

Hello:

This patch was applied to netdev/net-next.git (main)
by David S. Miller <davem@davemloft.net>:

On Mon, 12 Feb 2024 18:45:23 +0530 you wrote:
> Packet ingress and egress MAC/serdes channel numbers are configurable
> on CN10K series of silicons. These channel numbers inturn used while
> installing MCAM rules to match ingress/egress port. Fetch these channel
> numbers from firmware at driver init time.
> 
> Signed-off-by: Hariprasad Kelam <hkelam@marvell.com>
> Signed-off-by: Sunil Kovvuri Goutham <sgoutham@marvell.com>
> 
> [...]

Here is the summary with links:
  - [net-next] Octeontx2-af: Fetch MAC channel info from firmware
    https://git.kernel.org/netdev/net-next/c/997814491cee

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



