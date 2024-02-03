Return-Path: <linux-kernel+bounces-51091-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C643E848663
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Feb 2024 14:00:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2D9B1B218FC
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Feb 2024 13:00:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EFED5D904;
	Sat,  3 Feb 2024 13:00:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PHHAPXOr"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD0DD5D8F8;
	Sat,  3 Feb 2024 13:00:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706965225; cv=none; b=WheK4NVgEskO07WF60XnulKNnBEyJyjISQxRKLDOh75DmmvxBropctrw0VWzZdsNyaNaWwBYo0kDiUalgrFMPy4MDQTdLFefs41ehJ63lZoOalG94wq/As3y3xKqJVzK/fvJxSE9rQpo5r5ONxmp+JTdwFciEP+ZGVlfXc8g9Co=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706965225; c=relaxed/simple;
	bh=FJ8Nj0hzNhpNxCGXjpL0hGqqjoeOXzwYxUtzxxHfV0M=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=FWBHUXmQxKrAw89jiJLDTiQmgoLTe9WVpHObCo1nPdbZ+Xq87nddsWm7I8Smqi1plIC9MXpXvchN2A1qOGDT9bYeYMSRT0aAxMn7LISI3HzKA3rfUR7x+aKKHnRo0Ultm6OOTz6OVSigbu/KpdY54XUAr42k6nQCQy5gbRVpyYo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PHHAPXOr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 135BEC433C7;
	Sat,  3 Feb 2024 13:00:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706965225;
	bh=FJ8Nj0hzNhpNxCGXjpL0hGqqjoeOXzwYxUtzxxHfV0M=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=PHHAPXOrLbqA84PtmYXxkDExvNrInzqsIfgyNRtbfnfxOXolW41ilDMKPcrsqnutB
	 XbbBzyvstc3Ykx1Dtb5cQyya23kcKcvZUNF7X/4uk/VrSCSlXGoiCGlu80vYP3pXKE
	 KgOKqERb/anPsRtjafQbOKn3g9PmE8Fs06ks+hFNeBaHcMYmqtXLY+d/DESHas30+n
	 4+XDh/hQiTgoOCddvt3QEH1cwDpf1WvU+dypW1G9jeFtGDcYGU6+G1jzR00MnJND1s
	 f97DvMUS1+dVetEHqznkl/6WQSBFbz5Ch9ptLrzUIcU0glCngAGO7T/8A2mWOCXPL8
	 +p//LVsMTwynw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id E917EC395F3;
	Sat,  3 Feb 2024 13:00:24 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [net-next PATCH 0/2] net: phy: qcom: qca808x: fixup qca808x LED
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170696522495.24738.13214617196290591760.git-patchwork-notify@kernel.org>
Date: Sat, 03 Feb 2024 13:00:24 +0000
References: <20240201134602.11085-1-ansuelsmth@gmail.com>
In-Reply-To: <20240201134602.11085-1-ansuelsmth@gmail.com>
To: Christian Marangi <ansuelsmth@gmail.com>
Cc: andersson@kernel.org, konrad.dybcio@linaro.org, andrew@lunn.ch,
 hkallweit1@gmail.com, linux@armlinux.org.uk, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 linux-arm-msm@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by David S. Miller <davem@davemloft.net>:

On Thu,  1 Feb 2024 14:45:59 +0100 you wrote:
> This is a bit embarassing and totally my fault so sorry for that!
> 
> While reworking the patch to phy_modify API, it was done a logic
> error and made the brightness_set function broken. It wasn't
> notice in last revisions test as the testing method was to verify
> if hw control was correctly working.
> 
> [...]

Here is the summary with links:
  - [net-next,1/2] net: phy: qcom: qca808x: fix logic error in LED brightness set
    https://git.kernel.org/netdev/net-next/c/f2ec98566775
  - [net-next,2/2] net: phy: qcom: qca808x: default to LED active High if not set
    https://git.kernel.org/netdev/net-next/c/f203c8c77c76

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



