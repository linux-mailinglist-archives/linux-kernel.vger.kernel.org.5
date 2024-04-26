Return-Path: <linux-kernel+bounces-159860-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 645E38B3533
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 12:20:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 23E041F230AE
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 10:20:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDA80143C55;
	Fri, 26 Apr 2024 10:20:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fvS9qy2R"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39546142E64;
	Fri, 26 Apr 2024 10:20:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714126828; cv=none; b=B1E6bRUDR0oGJuREG5fspRHYYFgX+gegZUY+YHPYFeRJEFNgofEGM/bo4hzQLcjK1bjPKdkW7vh1Vr64EZYmn8/R0V2qiHmq1NjnukibqAj6s5MWDNE8vogtk/k0L6Q+bYh1Q4pl1JW50cH02HznsTG0TDJGxPRtxh/kpvGeDp8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714126828; c=relaxed/simple;
	bh=xvoKNHa/ZpIVIBwyN+89zRcKPdpGyfcVEh9uW/gH6HA=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=FamuT9Y/T0cpSgt1QIZr/UF2dT/pVD0BW8IthsKds433CA6D90kwkAelx1mXt1uYSjuXY5EiDYnOfqmzhhW+MVdoF5W73BDp0rLImoRQ7uigi7D7wfUXWUxFCd2sRP4+3IKskc7x5qdgUiIdhuPNHLCmLsGSgG81AkeCh2CG6tU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fvS9qy2R; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id C0A73C113CE;
	Fri, 26 Apr 2024 10:20:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714126827;
	bh=xvoKNHa/ZpIVIBwyN+89zRcKPdpGyfcVEh9uW/gH6HA=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=fvS9qy2R1GGUCn82fMLnfoT3DEC/Ri3ki7hPEqFYyo87x6cGv8S0kQMX00zjtTjG9
	 b71ntpZtED1ZUq2OlwrBYUdnDCx8TXxILmPSv5jZ1GsIva4YdVR3DrBs0TiSabEJni
	 sVNBy+WYnKb6/qWnJowZoVPTaVbFFHKsWKdYpF7pK1PpvSI8dVQV8W1n6RkP6itPCu
	 XA4XHdRmjytKLmchQ+EugjWdTQ1n4cCb53u0UgHsdy8+xTgM41SMvwxfYCild/VQ5x
	 OS0neUSfMIW38JbdlFCD/+Rpn1LlX5UcBjcPw0w1xV9ISGDyLoJqz/xPJdaVsnBXxf
	 jOqtLYnMIL0yw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id ADCBEC54BA8;
	Fri, 26 Apr 2024 10:20:27 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [net-next PATCH v6 0/5] net: hsr: Add support for HSR-SAN (RedBOX)
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171412682770.25431.50996926778696217.git-patchwork-notify@kernel.org>
Date: Fri, 26 Apr 2024 10:20:27 +0000
References: <20240423124908.2073400-1-lukma@denx.de>
In-Reply-To: <20240423124908.2073400-1-lukma@denx.de>
To: Lukasz Majewski <lukma@denx.de>
Cc: netdev@vger.kernel.org, pabeni@redhat.com, casper.casan@gmail.com,
 andrew@lunn.ch, edumazet@google.com, olteanv@gmail.com, davem@davemloft.net,
 kuba@kernel.org, o.rempel@pengutronix.de, Tristram.Ha@microchip.com,
 bigeasy@linutronix.de, r-gunasekaran@ti.com, horms@kernel.org,
 n.zhandarovich@fintech.ru, m-karicheri2@ti.com, jiri@resnulli.us,
 dan.carpenter@linaro.org, william.xuanziyang@huawei.com, syoshida@redhat.com,
 ricardo@marliere.net, linux-kernel@vger.kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Tue, 23 Apr 2024 14:49:03 +0200 you wrote:
> This patch set provides v6 of HSR-SAN (RedBOX) as well as hsr_redbox.sh
> test script.
> 
> The most straightforward way to test those patches is to use buildroot
> (2024.02.01) to create rootfs and QEMU based environment to run x86_64
> Linux.
> 
> [...]

Here is the summary with links:
  - [net-next,v6,1/5] net: hsr: Provide RedBox support (HSR-SAN)
    https://git.kernel.org/netdev/net-next/c/5055cccfc2d1
  - [net-next,v6,2/5] test: hsr: Remove script code already implemented in lib.sh
    https://git.kernel.org/netdev/net-next/c/680fda4f6714
  - [net-next,v6,3/5] test: hsr: Move common code to hsr_common.sh file
    https://git.kernel.org/netdev/net-next/c/154a82cb64be
  - [net-next,v6,4/5] test: hsr: Extract version agnostic information from ping command output
    https://git.kernel.org/netdev/net-next/c/40b90bf60ce1
  - [net-next,v6,5/5] test: hsr: Add test for HSR RedBOX (HSR-SAN) mode of operation
    https://git.kernel.org/netdev/net-next/c/542e645c4a4d

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



