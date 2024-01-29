Return-Path: <linux-kernel+bounces-42618-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 742DF8403DC
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 12:30:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 30429286217
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 11:30:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD3F25DF1E;
	Mon, 29 Jan 2024 11:30:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XCkBz/Ru"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 163AA5BAE9;
	Mon, 29 Jan 2024 11:30:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706527828; cv=none; b=cusYi5Tq6zbuYEZLzPk36iwp6Eo1Y7RHO7Ewk1b4O4O+cHhB5B7mCTfDi1gC5dRAZUqMSTtJhR+IBP5IDGIzsjdyWGZnEEszXdVyGyvO/dBCsSDYtbWkY8Ul9gsqrdIaEqzHixDveiKXxxlKlj22PgyeYjbgnLKa4W8n7CzFHgo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706527828; c=relaxed/simple;
	bh=2NBlLrD6OUpsbhl/47skI0VcUOh6OWFbCziwg9GF5pk=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=X32iCz1Daw3UOuAfgH514xHYBn9qag88BCaBWCXNgJYENOUy8TighJhXXcg9Gr4bHNgL0X+JQfRnjN0hinP+YwiB3Yh4/jWsbNmLlEzpakZOaag+CU82lBB7D8LUbrX+EBgZlDuU8imsS0pGkWZfDIZaBPaSZeETn8A+cEnY2x4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XCkBz/Ru; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 92ED3C43390;
	Mon, 29 Jan 2024 11:30:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706527827;
	bh=2NBlLrD6OUpsbhl/47skI0VcUOh6OWFbCziwg9GF5pk=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=XCkBz/RuzUadgbEbgrXVQkwn9BWVSA9FIfM1J1LiFfPRbpN6P0YITOmpYzOMXaRWR
	 GP4oThw6QYUsDrBSZiroFgzvnCrAu4oEQ7FZxwHcJ5Oj3VO5PYRlxPBLU0473RqY8J
	 YxWAgrPzp091AZikq8dDF1+RYfITmsBMDkDzFz1BOj5LsrKyJMavOdeaOriE1EYBf5
	 XO997dgevbxYZcylNkJ8aem0jZ+Ecj0cIsebD+aywXilTc8Aipn6adySwQ3p6UlT1F
	 3c9gw3Ogp9kxjxGNY+oQO/1CiVQvlYJeKq8szzjt7sICqihjS4HgubilNB4QqueqOO
	 Qt3kgefM52+GA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 7CA7FE3237E;
	Mon, 29 Jan 2024 11:30:27 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [net-next PATCH] octeontx2-af: Add filter profiles in hardware to
 extract packet headers
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170652782750.19974.16872888286474534483.git-patchwork-notify@kernel.org>
Date: Mon, 29 Jan 2024 11:30:27 +0000
References: <20240124095338.1964327-1-sumang@marvell.com>
In-Reply-To: <20240124095338.1964327-1-sumang@marvell.com>
To: Suman Ghosh <sumang@marvell.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, sgoutham@marvell.com, sbhatta@marvell.com,
 jerinj@marvell.com, gakula@marvell.com, hkelam@marvell.com,
 lcherian@marvell.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by David S. Miller <davem@davemloft.net>:

On Wed, 24 Jan 2024 15:23:38 +0530 you wrote:
> This patch adds hardware profile supports for extracting packet headers.
> It makes sure that hardware is capabale of extracting ICMP, CPT, ERSPAN
> headers.
> 
> Signed-off-by: Suman Ghosh <sumang@marvell.com>
> ---
>  .../net/ethernet/marvell/octeontx2/af/mbox.h  |   1 +
>  .../net/ethernet/marvell/octeontx2/af/npc.h   |  15 +-
>  .../marvell/octeontx2/af/npc_profile.h        | 617 ++++++++++++++++--
>  .../ethernet/marvell/octeontx2/af/rvu_nix.c   |   7 +
>  4 files changed, 571 insertions(+), 69 deletions(-)

Here is the summary with links:
  - [net-next] octeontx2-af: Add filter profiles in hardware to extract packet headers
    https://git.kernel.org/netdev/net-next/c/c57e32fb29f2

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



