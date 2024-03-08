Return-Path: <linux-kernel+bounces-96504-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 88B4B875D29
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 05:30:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1A2631F21F38
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 04:30:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82E1A2E84F;
	Fri,  8 Mar 2024 04:30:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uCULTRvG"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B88A02134B;
	Fri,  8 Mar 2024 04:30:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709872229; cv=none; b=Du2pyxoBH1So4I4PjNE0SmLJQFiD7hSUE87XX6aEbxsluwF298Au7NcwYMcvoU97NvIOw0TMiGzHG55IH05Q7tH8m2hPSgCtpuvGwU8zNJ9M6j8qLxlZoELuCUbCHRA3gP79Y3wC5HGgJYGtrh1jezxxN8MbQPS2JqlQFZl67qw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709872229; c=relaxed/simple;
	bh=Bhr4Dtpl623FH4HAMUZOgSXCCm8xgmxDleW5A1X397Q=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=BB1/oa8Cny2GL0+PzMGrUH+8XhJw5tE9XEDqvxTCTzXq/aA62O3KKomQ0/ARMUswRpcjRTyKypLJB9N1OP4K8SRUOCt3EpCdWhTintiaug+PzWmr1d6ySDR7aJyDbEh6auuXnzJzGr/xl+C5UXi84oS+iZSW3fFptLhIkAfG6Ak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uCULTRvG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 4C10BC43394;
	Fri,  8 Mar 2024 04:30:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709872229;
	bh=Bhr4Dtpl623FH4HAMUZOgSXCCm8xgmxDleW5A1X397Q=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=uCULTRvGMHIapWzkUMeWz+mn1kZZKPuDWSz2n/Dji1x/ucOz9rKUVl+PiRZx83xRw
	 R4cJP0u5JMiSYiXdVRjsY+YSxlwCUpREVp6vPE7oddTHDmpA+JITtuAQTmh93RcoLF
	 f1+AhINduqEIkNUPiN/S51QqRH8mqcOTkmWWxjnsg2rC5yenJvj68G+6p7fSR2ptUK
	 XgA4uisaDVpePuirTEAq4v3RsJe84EVLHmjRRVf/g5fJRzHfbdpvJoTEQlkDdy0UeR
	 MsuRIixPXmeleCLcX14vKiC2huG+dTzlO3smGVivZ5AO3ZiAUd4vGU+PxCcNFUQShC
	 H1KScnrQ5uawA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 30FD8D84BC1;
	Fri,  8 Mar 2024 04:30:29 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] net: x25: remove dead links from Kconfig
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170987222919.2034.12421653557670790951.git-patchwork-notify@kernel.org>
Date: Fri, 08 Mar 2024 04:30:29 +0000
References: <20240306112659.25375-1-justin.swartz@risingedge.co.za>
In-Reply-To: <20240306112659.25375-1-justin.swartz@risingedge.co.za>
To: Justin Swartz <justin.swartz@risingedge.co.za>
Cc: ms@dev.tdt.de, davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, linux-x25@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed,  6 Mar 2024 13:26:59 +0200 you wrote:
> Remove the "You can read more about X.25 at" links provided in
> Kconfig as they have not pointed at any relevant pages for quite
> a while.
> 
> An old copy of https://www.sangoma.com/tutorials/x25/ can be
> retrieved via https://archive.org/web/ but nothing useful seems
> to have been preserved for http://docwiki.cisco.com/wiki/X.25
> 
> [...]

Here is the summary with links:
  - net: x25: remove dead links from Kconfig
    https://git.kernel.org/netdev/net-next/c/7a04ff127786

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



