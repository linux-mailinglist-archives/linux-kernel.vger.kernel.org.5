Return-Path: <linux-kernel+bounces-64707-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E6D18541C4
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 04:20:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4AF2528A50A
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 03:20:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28561B673;
	Wed, 14 Feb 2024 03:20:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hAUYtPAE"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6546320EB;
	Wed, 14 Feb 2024 03:20:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707880828; cv=none; b=MEYN5WDEjxmnpW8zmI+dnWC8EC+ua40eHmmxeUz2p3uIY5TVtwJL33vwrsT3TPhyqu9AkH+IgO3aRLAxz+4JeEY7MNGHatHegsmXCDBOKVZYT9leHf3Z6+SNVxgjUdx8zO3z4zlQEBzMCihhYx2d0qwT4z62s48RbUsuCKgZqZs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707880828; c=relaxed/simple;
	bh=XjTwCFHpxyrJIwCIb3fyxD9On3e7S2NhTGj1avU1A3U=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=ADUGNCCfADHxVT8HUxyUeH8ZqS07x+/8XHtjSERJh2Sx7fvuSydfZAEpRuH4feyTrlAcY66gMjVrDGOTVqPQuw35INTvGgSPB/COeCRnZGf3NcI7EuNpJg31Go+2KgMel0vSbzQ3aLBXCBsB8XHOF00Vkqs9DQJSCWKrLpdSmT4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hAUYtPAE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id F4072C433F1;
	Wed, 14 Feb 2024 03:20:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707880828;
	bh=XjTwCFHpxyrJIwCIb3fyxD9On3e7S2NhTGj1avU1A3U=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=hAUYtPAEnkNlI0sp3Z3mIJDPFW0Q/pKSGVHY6iUZgu2DFWoYcYdkoOdkfn9/3iFN9
	 f0UA/KBn5jtQgTq3OOJyMfIl9YeNbAPtjqmgTcDWwuB6wM6GNKF6/MU0PR1fATzgCw
	 6wbxkmIVuzyUAw9AzIJd8tDK3KYThcw5pQICUO5h46x9DlS0JMWNlfVa5y7eP2yiMz
	 9gFNk9KwiCNnqjmpVOuTy2mGNZMTLSjMVEk/7Lmn6B0LioCcVedZn890o0gwzTF84R
	 x9eidxySk3bW3SaYgWZePkgVWpBrpR1x8D2u1NWF4P9oPEJrtTqNyTV+PC+gwqzcbc
	 ZT6F5cpKyYxyw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id D891CDC99FC;
	Wed, 14 Feb 2024 03:20:27 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] net: dsa: realtek: fix digital interface select
 macro for EXT0
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170788082787.27530.15182736427269542366.git-patchwork-notify@kernel.org>
Date: Wed, 14 Feb 2024 03:20:27 +0000
References: <20240212-realtek-fix_ext0-v1-1-f3d2536d191a@gmail.com>
In-Reply-To: <20240212-realtek-fix_ext0-v1-1-f3d2536d191a@gmail.com>
To: Luiz Angelo Daros de Luca <luizluca@gmail.com>
Cc: linus.walleij@linaro.org, alsi@bang-olufsen.dk, andrew@lunn.ch,
 f.fainelli@gmail.com, olteanv@gmail.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 12 Feb 2024 18:34:33 -0300 you wrote:
> While no supported devices currently utilize EXT0, the register reserves
> the bits for an EXT0. EXT0 is utilized by devices from the generation
> prior to rtl8365mb, such as those supported by the driver library
> rtl8367b.
> 
> Signed-off-by: Luiz Angelo Daros de Luca <luizluca@gmail.com>
> 
> [...]

Here is the summary with links:
  - [net-next] net: dsa: realtek: fix digital interface select macro for EXT0
    https://git.kernel.org/netdev/net-next/c/32e4a5447ed9

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



