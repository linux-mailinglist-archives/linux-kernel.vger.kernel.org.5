Return-Path: <linux-kernel+bounces-84872-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 18DD186ACE0
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 12:21:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4B0E11C25146
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 11:21:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4724E13A868;
	Wed, 28 Feb 2024 11:20:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QoxYHj2c"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82191135A6A;
	Wed, 28 Feb 2024 11:20:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709119234; cv=none; b=c4sekmxzSennyp8pqkSpf3uAO1oarWMMzAPfJwDtWDnbbP0SGMsK64/AdqzdGyXbsULZQuQ7iE3WGHjPDr77K8nWVvmYOP9fkC6Edj+Iap1iNcb2/M1godooZij3JyZM28PokbaAKJ0G3dNPN743+szLefrrqq0vJRYc5ecCWmY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709119234; c=relaxed/simple;
	bh=KXWL5048DZU1pSGrmnaZz7TAdyC7SRezKhReC+a6rfA=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Dwkii5bc5CAMmi20BQRYyMLe3vZ8KnpmXKoYrY+2pocC4aBKJ4jooWTHLv5Z3LHfhwCdvYKpzVAhw4GP0W1XQD1WFio80PdvSNmufZvkiMYYIj9821HgsIMaCy4osL8YotuoxfpuE/Y1AEwgxvfDWQi/U7DH0t3LuphK76jrt2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QoxYHj2c; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 2732AC433C7;
	Wed, 28 Feb 2024 11:20:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709119234;
	bh=KXWL5048DZU1pSGrmnaZz7TAdyC7SRezKhReC+a6rfA=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=QoxYHj2c2XWinw7JE+NhoeUx9wRnJlok5OsTOUt2xgNTGxX0NV0ANBPV/mMt7t49C
	 KVuIyF6UYNUyxmXItdRCepeVTTPiHncFLpSN80jd8nbyRElVwT47ssm7Bhw1KHlayT
	 HFY4wr0YTOJ6YNY/fBMrxS4f2dfrRKFTsx5WluoeJvcejzLakuiNlWq3lItZ6tKoHv
	 wAxff6/6Z6c+F1cmrkeen0EnmujyLPHiGwzpk2afBBwvzzGUZZAzgQLToLQwBCDJeg
	 BX9f7AMlkC6l7vufc0PfSCgluFwbCu8mc2LRyucF3AweE3P8PfXw4INwvdlzg0zwOv
	 K4IEEPS3vmlhA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 14568D84BC5;
	Wed, 28 Feb 2024 11:20:34 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v5 0/3] ioam6: netlink multicast event
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170911923407.32073.2495064703412581430.git-patchwork-notify@kernel.org>
Date: Wed, 28 Feb 2024 11:20:34 +0000
References: <20240226131412.10214-1-justin.iurman@uliege.be>
In-Reply-To: <20240226131412.10214-1-justin.iurman@uliege.be>
To: Justin Iurman <justin.iurman@uliege.be>
Cc: netdev@vger.kernel.org, davem@davemloft.net, dsahern@kernel.org,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 linux-kernel@vger.kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by David S. Miller <davem@davemloft.net>:

On Mon, 26 Feb 2024 14:14:09 +0100 you wrote:
> v5:
>  - remove the "must be the destination" check before sending an ioam6
>    event
> v4:
>  - rebase on top of net merge
> v3:
>  - patchset was mistakenly superseded due to same cover title used for
>    iproute2-next equivalent patch -> resend (renamed)
> v2:
>  - fix warnings
> 
> [...]

Here is the summary with links:
  - [net-next,v5,1/3] uapi: ioam6: API for netlink multicast events
    https://git.kernel.org/netdev/net-next/c/5fa918a33563
  - [net-next,v5,2/3] net: ioam6: multicast event
    https://git.kernel.org/netdev/net-next/c/67c8e4bb4f54
  - [net-next,v5,3/3] net: exthdrs: ioam6: send trace event
    https://git.kernel.org/netdev/net-next/c/f655c78d6225

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



