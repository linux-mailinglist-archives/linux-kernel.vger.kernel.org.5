Return-Path: <linux-kernel+bounces-92921-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C4CA0872830
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 21:01:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 026921C27CC2
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 20:01:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F08EF12A149;
	Tue,  5 Mar 2024 20:00:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZzsmYdbS"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35C151B59F;
	Tue,  5 Mar 2024 20:00:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709668833; cv=none; b=THyV/G/vsPzB1SBgl1wNmmj3SQ6RQjB92GKEHdwJjilckQva9liYaxXqCwyJefxRqxLYq7Wx9FfWhGbLVMpYXohV5Z8Gr1onprM21pgf6tdN1xDcgFJSTzlMTkzID9InF+BeIU+1Su0QQXq9CNnNsWaBNzxXUau6qRmijz+Coto=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709668833; c=relaxed/simple;
	bh=b/y7JjjxnUdm+R8hNCO+v51ZljJ6BUuJ54yjwBQfOi4=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=aq+AspTcwhthyN2GUIsq2eVKDUOXfvmhiuEJk9P6twkIEbkBGr42zLEcwUmrWy95EY4n5tCpaN0fNTwLHAueDuQWiwnAdYxk9UO/fDbtOkA/USgQTu7qZkbPInBFg+4QMeL0G8/iaxOHIDmi09TRfteYfqAboa/XqrkbFIK9LkE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZzsmYdbS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 0C486C43390;
	Tue,  5 Mar 2024 20:00:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709668833;
	bh=b/y7JjjxnUdm+R8hNCO+v51ZljJ6BUuJ54yjwBQfOi4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=ZzsmYdbSqu2uTmHya40o7b+L43sOw8Ccsp1c3XGjWTyxQVnWf75pxJcoXrXcrGjCZ
	 PKdgIBb9fLCdTODyzFm/v3h9/99BAu2vHMjhoBy1JcVtVVhyUWPj0Dy+/LsGo7Q8tm
	 iYM/+gUCgc19eSZvV3oL1P+VtGgEOgfujvC6ehT6IQaA82F1jyW2BnzzqkwYrrCX9T
	 4nKdbPfjzuuyCanGKiqxwp300rGkKUUkY5Y1huCoTQDQt1Y+HgQNdhdBBGwP2p/QA4
	 qpiKejCKpBfuPbK/3XsRy48a0DA7QgUIl+Kcu47tHDW236w86s6/m+ofcB4eIBP8aw
	 +IW6C54RlewZg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id E0195D9A4BB;
	Tue,  5 Mar 2024 20:00:32 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next 0/6] net: constify struct class usage
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170966883291.18762.11753992579931321853.git-patchwork-notify@kernel.org>
Date: Tue, 05 Mar 2024 20:00:32 +0000
References: <20240302-class_cleanup-net-next-v1-0-8fa378595b93@marliere.net>
In-Reply-To: <20240302-class_cleanup-net-next-v1-0-8fa378595b93@marliere.net>
To: Ricardo B. Marliere <ricardo@marliere.net>
Cc: yisen.zhuang@huawei.com, salil.mehta@huawei.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 loic.poulain@linaro.org, ryazanov.s.a@gmail.com, johannes@sipsolutions.net,
 krzysztof.kozlowski@linaro.org, gregkh@linuxfoundation.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-ppp@vger.kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Sat, 02 Mar 2024 14:05:56 -0300 you wrote:
> This is a simple and straight forward cleanup series that aims to make the
> class structures in net constant. This has been possible since 2023 [1].
> 
> [1]: https://lore.kernel.org/all/2023040248-customary-release-4aec@gregkh/
> 
> Signed-off-by: Ricardo B. Marliere <ricardo@marliere.net>
> 
> [...]

Here is the summary with links:
  - [net-next,1/6] net: hns: make hnae_class constant
    https://git.kernel.org/netdev/net-next/c/b6e3c115efb5
  - [net-next,2/6] net: wan: framer: make framer_class constant
    https://git.kernel.org/netdev/net-next/c/63767a76318c
  - [net-next,3/6] net: ppp: make ppp_class constant
    https://git.kernel.org/netdev/net-next/c/2ad2018aa357
  - [net-next,4/6] net: wwan: hwsim: make wwan_hwsim_class constant
    https://git.kernel.org/netdev/net-next/c/d9567f212b15
  - [net-next,5/6] net: wwan: core: make wwan_class constant
    https://git.kernel.org/netdev/net-next/c/070bef83f03e
  - [net-next,6/6] nfc: core: make nfc_class constant
    https://git.kernel.org/netdev/net-next/c/e55600116929

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



