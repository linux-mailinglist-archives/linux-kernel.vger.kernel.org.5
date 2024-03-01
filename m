Return-Path: <linux-kernel+bounces-88133-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B14BD86DDBF
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 10:00:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1D6D6B2617C
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 09:00:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60C2D6A35B;
	Fri,  1 Mar 2024 09:00:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GeMImdcs"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BBB26A32B;
	Fri,  1 Mar 2024 09:00:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709283630; cv=none; b=BiHLRoht5h3mKJM8RzgQCu4FrSg9GYhn0XVzdfaUDuhCBDGbDlzlwwa1/aclVVmfTxVPpWnnVa62DRzn6NmolLvSmKPlb3toulVzbX1k1nAZy1j53AR4koK/BrIOOH8BgCwQlzPxHj0Z87QyyckDT78UCuQjTtvnSSwP0yHK+es=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709283630; c=relaxed/simple;
	bh=leN1vuAvIfepLb2hSMU5buc/ymONenIAbof+rx/vFqU=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=u5QQWqb8PANoVnwXhrFHQdef2Ydu+NCpMF/9TXFuvMNUAw/XpSERexnjAZ3sZZAPb+4I81u/NLOz8+G0EXW+Stx4Hof5ImLXXIa4v4zjdM4OFfj5IJciTW3bLkFAlofBEHe0kSNWwJdX5xTsc62salD2L3WJe/R7qxuexR52C/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GeMImdcs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 04469C433F1;
	Fri,  1 Mar 2024 09:00:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709283630;
	bh=leN1vuAvIfepLb2hSMU5buc/ymONenIAbof+rx/vFqU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=GeMImdcsKadKHmFsJOqrwRtWZAnSGdJtmY4rruOhLtVmCGBkRvGDUnjj7RKBvXEuy
	 rYjzy6xDTB2LhqUJ9Y2BKByqw8hxD9jacjB+Cn41o/ObomsoLE23SJViqe7UNR5/Z2
	 vGmzXCw998pW/1DCQ5WsD2Wg2vYYYdrrnKPNI5nV6da6geDYHBvROtItn6cn4qMib7
	 hwRR4RN37b7C7s0QwVG953ec0/8s4Cdi+bGocxqucTxh/cXk2xcud9l20OvX3AI7XU
	 vF+MuwL23Die66znRl03agBynIIBCQmdRX3fMlEewa05//Hgt3jAXDePKBnamcxwZZ
	 z0glLi8Ufpyzw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id E060CC595C4;
	Fri,  1 Mar 2024 09:00:29 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v2 0/2] net: phy: qcom: qca808x: fill in
 possible_interfaces
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170928362991.25916.1636738478818920019.git-patchwork-notify@kernel.org>
Date: Fri, 01 Mar 2024 09:00:29 +0000
References: <20240228172452.2456842-1-robimarko@gmail.com>
In-Reply-To: <20240228172452.2456842-1-robimarko@gmail.com>
To: Robert Marko <robimarko@gmail.com>
Cc: andersson@kernel.org, konrad.dybcio@linaro.org, andrew@lunn.ch,
 hkallweit1@gmail.com, linux@armlinux.org.uk, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 linux-arm-msm@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by David S. Miller <davem@davemloft.net>:

On Wed, 28 Feb 2024 18:24:08 +0100 you wrote:
> QCA808x does not currently fill in the possible_interfaces.
> 
> This leads to Phylink not being aware that it supports 2500Base-X as well
> so in cases where it is connected to a DSA switch like MV88E6393 it will
> limit that port to phy-mode set in the DTS.
> 
> That means that if SGMII is used you are limited to 1G only while if
> 2500Base-X was set you are limited to 2.5G only.
> 
> [...]

Here is the summary with links:
  - [net-next,v2,1/2] net: phy: qcom: qca808x: add helper for checking for 1G only model
    https://git.kernel.org/netdev/net-next/c/f058b2dd70b1
  - [net-next,v2,2/2] net: phy: qcom: qca808x: fill in possible_interfaces
    https://git.kernel.org/netdev/net-next/c/cb28f7029606

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



