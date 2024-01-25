Return-Path: <linux-kernel+bounces-37961-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4951983B8D8
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 06:00:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7C36B1C23301
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 05:00:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26B398493;
	Thu, 25 Jan 2024 05:00:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YE96pyIy"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67EF779E1;
	Thu, 25 Jan 2024 05:00:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706158826; cv=none; b=HhkLOupBr6pHgyUBE9HnyoVjdpYnSNyxBx2+Q6TxeMplU60rVuWGjv7kXyDAPLGHHFennIEQaPp/SUaIQuja8JvkzdzdvYMlXcktpZ37jYPzijQT34HL0rKkNeICWt1A5io4PnMTjzPh3gUoTzoCA1CeOsG1XSyiWG6DOydKqiY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706158826; c=relaxed/simple;
	bh=OOpECudB16BaNbre86p8JZ+UD6CaQR73+6tYwzCd7Zc=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=splZjY7VjME8g3kYU/SAfyMrtqVXaF3hv+kWLPMMTu/St6FPiNsJj1i6sJs1CjwwWxEZTD6KaS9WIcOngAh0y0uHd2H5M8VITle5sJt1ETjU5TgfnGZRtJvzw609d8dfQRcjyGFLYlUGV8ZYrS5eMxFgXTgpgcDMhcYBk+B9Jo4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YE96pyIy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 9714BC433F1;
	Thu, 25 Jan 2024 05:00:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706158825;
	bh=OOpECudB16BaNbre86p8JZ+UD6CaQR73+6tYwzCd7Zc=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=YE96pyIylmwVdK4lVqyDQgAIxqjnkNZ30wWVkAFqblhlOFr1+IzssjQ8aqPZ3MnAo
	 Q92HcpeWM59772PBPuKwJy7zR5btHEUWfKVFs2T1PQ3cDZUkU6Ppgp4udZ0vETOdHM
	 /a86D5vMYr6uzNh1kd0AsXDtVinByZnmF4C8SbEZELRPTRWV2+Ws/qDJT/KV91/Yoc
	 cCF0xeziWGAZBLqWmNNTpn0GlgplxNG2Ky3/7r+pcv0sqRfqVMq9ENozI5ut+wN2py
	 O4oJP38vJKth5bRB1MDZOESDtvwly4Q8+ckYaJQYVYoGacMwUa/HilHw+9CLIYbWtX
	 xk3zn+G4+OSDw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 7F16CDFF767;
	Thu, 25 Jan 2024 05:00:25 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] fjes: fix memleaks in fjes_hw_setup
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170615882551.24307.2022533204169513521.git-patchwork-notify@kernel.org>
Date: Thu, 25 Jan 2024 05:00:25 +0000
References: <20240122172445.3841883-1-alexious@zju.edu.cn>
In-Reply-To: <20240122172445.3841883-1-alexious@zju.edu.cn>
To: Zhipeng Lu <alexious@zju.edu.cn>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, izumi.taku@jp.fujitsu.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 23 Jan 2024 01:24:42 +0800 you wrote:
> In fjes_hw_setup, it allocates several memory and delay the deallocation
> to the fjes_hw_exit in fjes_probe through the following call chain:
> 
> fjes_probe
>   |-> fjes_hw_init
>         |-> fjes_hw_setup
>   |-> fjes_hw_exit
> 
> [...]

Here is the summary with links:
  - fjes: fix memleaks in fjes_hw_setup
    https://git.kernel.org/netdev/net/c/f6cc4b6a3ae5

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



