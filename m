Return-Path: <linux-kernel+bounces-141845-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C7D708A2433
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 05:10:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 04A0B1C219F4
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 03:10:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F09A17BA9;
	Fri, 12 Apr 2024 03:10:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZM1ArxsQ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA41D14016;
	Fri, 12 Apr 2024 03:10:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712891429; cv=none; b=OHUWARBDOJsK7xLBWY//IwYMXikQwraHBcPy/35eKbiUBWA78HNU55p+HLdbwAYC5rm5Lf4Dx/olBFsalM+wBSKB1VU/2MxEkC/sMa56/UTyeXCv93it342gmPOPl0iL1XwPt0ff8P5Ok7fBoPiNu31JVJd/uxl2u1WGD71NHDw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712891429; c=relaxed/simple;
	bh=kAWQtCPE7s4/t10iRouhzrduC5k5lVHNvQ94kj1uOe4=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Cold+sWGM54PVA7I7Y1kTtD9+UukRVIKlmZLU1eC//crs1QU9n+E8Z6K/unEw1/i/xD/21YjCpbavrb/b0ZvdbXWdmvIzCQJwJadRUJwlGIwA21tP1zzMu4ESGt6UelX+p8DTq/JNpeFYxMx8FYRWQgefsb25DbX4Be+XEy/a4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZM1ArxsQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 5BF7BC32781;
	Fri, 12 Apr 2024 03:10:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712891429;
	bh=kAWQtCPE7s4/t10iRouhzrduC5k5lVHNvQ94kj1uOe4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=ZM1ArxsQCas8hA0t62la9y4aMuPmMmIZL44mLakujCbaCd2SEw4W6PgoBt0t/PpfR
	 5wTasXKBwXRLeg+xzM59IlgqZMvtNLCY4bsipIlKRPsIMglgp6upP8pLMRhYh1I+hl
	 7+1Z/GCSGFiX0W9Zcfnj4t/JZeM3Lua8j22mM+omBCL0NzyyT0w6Nh77BpTr9xfDV7
	 yvAyPwcJzy/xa6MyxzYTAavhHVbFasEOJCt2ziMdpULHdHkfzsErmwprFwK4Nk6FtG
	 wZTP9kCjwCzSMClnhUUusswhsMxigk+9vqVL5G+WLyy/UtHQ4Nrj+drEJpnx1Po9Bl
	 ebISBF+JFdXNA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 41BC8C4339F;
	Fri, 12 Apr 2024 03:10:29 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH][next] tls: remove redundant assignment to variable decrypted
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171289142926.25647.8582026125131591464.git-patchwork-notify@kernel.org>
Date: Fri, 12 Apr 2024 03:10:29 +0000
References: <20240410144136.289030-1-colin.i.king@gmail.com>
In-Reply-To: <20240410144136.289030-1-colin.i.king@gmail.com>
To: Colin King (gmail) <colin.i.king@gmail.com>
Cc: borisp@nvidia.com, john.fastabend@gmail.com, kuba@kernel.org,
 davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 netdev@vger.kernel.org, kernel-janitors@vger.kernel.org,
 linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 10 Apr 2024 15:41:36 +0100 you wrote:
> The variable decrypted is being assigned a value that is never read,
> the control of flow after the assignment is via an return path and
> decrypted is not referenced in this path. The assignment is redundant
> and can be removed.
> 
> Cleans up clang scan warning:
> net/tls/tls_sw.c:2150:4: warning: Value stored to 'decrypted' is never
> read [deadcode.DeadStores]
> 
> [...]

Here is the summary with links:
  - [next] tls: remove redundant assignment to variable decrypted
    https://git.kernel.org/netdev/net-next/c/f7ac8fbd3215

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



