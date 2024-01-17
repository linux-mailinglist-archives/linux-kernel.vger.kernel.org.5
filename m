Return-Path: <linux-kernel+bounces-28441-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D8B082FE8D
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 02:50:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 025B21F24917
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 01:50:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C933E4685;
	Wed, 17 Jan 2024 01:50:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fe+J+1fQ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18F42138E;
	Wed, 17 Jan 2024 01:50:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705456227; cv=none; b=PQfka2S+m+3bNWuC6qaZWMUhB7nsaPFYXAZMwS5sBtkuJfNr+e0R3QrxkWsVHlq9Cko6auk/6HPsS6C7e64GNMtWbl3ITdm2cu7C2L66Yo5VGD6+m8jwz38/hW3ONgza1BnlOBull0ujN3n14De2xfpOQfES0yacwth1WQKDgpo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705456227; c=relaxed/simple;
	bh=v0QaZYpEZ3EFQmzffLDj90LOeySkJ3srG0m9pc8pkIg=;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=lX9GniebjwsoYpSd5SRCQNbfna0yUb25pKGV2QNEwvSR8khRFNPMS+TbboIxjVClwIW9quV7XKj/gtJjJLXoDXOS0M0zZ7NNBpiINjRBhQirLKs46V+VWDf9WAFXz1Sp1iTegjrZZY5WTRY9GDJQd2LSmiWRd9a77D/imKPOVYI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fe+J+1fQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 77D5FC433B1;
	Wed, 17 Jan 2024 01:50:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705456226;
	bh=v0QaZYpEZ3EFQmzffLDj90LOeySkJ3srG0m9pc8pkIg=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=fe+J+1fQeEeBbQf9b95iompFPFXp2s81IkS6RA7zGHpStFWC4UbxMNEVreMWYCgvQ
	 Yd/omDU82ALi8Lzmn3R8JpNXajnARFcOT7hU8ypz3c03u+z77X6lUfuUoGGsAX+cyw
	 yff/HHU4ZMwwk4W08s0LJdMxvm+VrjrarKv45rdVWhDEljur/rjGNCU607uLtJIQUB
	 v6Lf/DElaKO+lYQpWVaXzKMPGvogaCRsl5jTyNoytKVLhRvnUnN7LE+hbh70Sx4Wn8
	 D65B5qINCNp436ZbVN9qmbDqc4h9dVupGNvs2XJsHV03Yz+npnWqMnamzqE+bbWYQS
	 tWNvSKpnPbgmA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 64D20D8C985;
	Wed, 17 Jan 2024 01:50:26 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2] net: dsa: vsc73xx: Add null pointer check to
 vsc73xx_gpio_probe
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170545622640.24208.16006278091291103156.git-patchwork-notify@kernel.org>
Date: Wed, 17 Jan 2024 01:50:26 +0000
References: <20240111072018.75971-1-chentao@kylinos.cn>
In-Reply-To: <20240111072018.75971-1-chentao@kylinos.cn>
To: Kunwu Chan <chentao@kylinos.cn>
Cc: andrew@lunn.ch, f.fainelli@gmail.com, olteanv@gmail.com,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, kunwu.chan@hotmail.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 11 Jan 2024 15:20:18 +0800 you wrote:
> devm_kasprintf() returns a pointer to dynamically allocated memory
> which can be NULL upon failure.
> 
> Cc: Kunwu Chan <kunwu.chan@hotmail.com>
> Signed-off-by: Kunwu Chan <chentao@kylinos.cn>
> Suggested-by: Jakub Kicinski <kuba@kernel.org>
> 
> [...]

Here is the summary with links:
  - [v2] net: dsa: vsc73xx: Add null pointer check to vsc73xx_gpio_probe
    https://git.kernel.org/netdev/net/c/776dac5a6627

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



