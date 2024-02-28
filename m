Return-Path: <linux-kernel+bounces-85290-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D304E86B38C
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 16:44:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6C9771F2C852
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 15:44:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01BF615D5C5;
	Wed, 28 Feb 2024 15:44:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aonVDHv0"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FB6A1487DC;
	Wed, 28 Feb 2024 15:44:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709135053; cv=none; b=e0uLu47Nts1zr/1OGkbs7mnlYTqihiaIhhz2S//Y4MNp7wFGMxBniDnBvELTM+pWA0+jqs3lPTpbDjdzpdIrCb771SMpNmMiiu2GKLp/qnpLzmJnVVP8zL5QYxLMcWf+jymqJvuKPgXz4eUuHNU10F6e1jY2Em0IUgXi8xuIUgE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709135053; c=relaxed/simple;
	bh=EpJLYJ6b85rFa9J1XyueUdyMW3coYJ0CvhXOXMVsYvA=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=TsyfAjr8xqcxjWAveGw5yQme4sKjEhdW0TIVfeAMW2srQ16sxVxKe7xxSjhdTc9TLLCbiVTaxVJQOgWtTQJwWyOALKNWu7fe9pGO6RX/Qb29Hopntp3o0tmybYmUYLGZpA4elB7xDk5YZnNI0iMi0lhR4ktqc3ZI8BvB/Enbb+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aonVDHv0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id C7E12C433C7;
	Wed, 28 Feb 2024 15:44:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709135052;
	bh=EpJLYJ6b85rFa9J1XyueUdyMW3coYJ0CvhXOXMVsYvA=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=aonVDHv0+gIs5d0kGPhHMl0GVrq1JvYpJCjkSx/6KoCHay79Kh4ev2K2T+VedOOeq
	 AkxYnfFsQqe71Snxdkd4IMfmIiJZ55b81xRaU0s3a0DmDvLHkw/U4HJqYqRULcQ2j0
	 /fB0fGLwYe6eGT5SxOFBoVtio2nHjtTmDsv7doLlFk5VPjUye3GdwLBoOQENduIEkf
	 DpRX8hVhkeIgo/bi46tkFLbAHYgseOTT9o+a1n32G+UU32XNJX5yIU9UgahWK7yTuc
	 IRiPMR05Nh2ym41CSCOgzNpF61zJze0tFud+VK6knCcB7xH1la7j4zFCzt6XLDDxkd
	 l4y0byx/fv6kw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id A8BD4D88FAF;
	Wed, 28 Feb 2024 15:44:12 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net 04/10] net: fill in MODULE_DESCRIPTION()s for 6LoWPAN
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <170913505268.28471.3417707935881083049.git-patchwork-notify@kernel.org>
Date: Wed, 28 Feb 2024 15:44:12 +0000
References: <20240205101400.1480521-5-leitao@debian.org>
In-Reply-To: <20240205101400.1480521-5-leitao@debian.org>
To: Breno Leitao <leitao@debian.org>
Cc: kuba@kernel.org, davem@davemloft.net, pabeni@redhat.com,
 edumazet@google.com, alex.aring@gmail.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, horms@kernel.org, andrew@lunn.ch,
 linux-bluetooth@vger.kernel.org, linux-wpan@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Jakub Kicinski <kuba@kernel.org>:

On Mon,  5 Feb 2024 02:13:53 -0800 you wrote:
> W=1 builds now warn if module is built without a MODULE_DESCRIPTION().
> Add descriptions to IPv6 over Low power Wireless Personal Area Network.
> 
> Signed-off-by: Breno Leitao <leitao@debian.org>
> ---
>  net/6lowpan/core.c | 1 +
>  1 file changed, 1 insertion(+)

Here is the summary with links:
  - [net,04/10] net: fill in MODULE_DESCRIPTION()s for 6LoWPAN
    https://git.kernel.org/bluetooth/bluetooth-next/c/2898f3075e6a

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



