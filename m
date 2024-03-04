Return-Path: <linux-kernel+bounces-90378-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E792086FE73
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 11:10:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A2C03282461
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 10:10:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32686225D2;
	Mon,  4 Mar 2024 10:10:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TP/R0yQS"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7015620B33;
	Mon,  4 Mar 2024 10:10:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709547028; cv=none; b=o6Qm1RuSeRIdfx3KQmhfv9864AbPbqW8sd0bwezsxLGuY34IiZp8D6VHPsVmnO9qdYwDBBTyRPDFwS4lbI7ROIWjc0ADMeX+/DDM9bP1Zmw6cMB157aSihS/tBoP5nxJwrZN2okbemnu8npEKRbzaC7WUS+lxS6X823GZjdPlvY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709547028; c=relaxed/simple;
	bh=B826BG/LabvHzX/qTThYEXRApaxmS5m/7jaE3+DLICE=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=QC1/ADCRTVorhaxDo/PMOQYei37Hu1GMwtWSPtipm2NhWOfjVN/ZwfqoQkqERRFwh4sgX2PCIAxuIbXvwcobXcrvsemiLHb0pJWlozVDEROiXuCPIJ8r1zJ2lwhIaTOT94xXI7enwYELirE+WS0pu6QH1mFFVI0cDCDOMD6MCxA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TP/R0yQS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 2EFC9C433C7;
	Mon,  4 Mar 2024 10:10:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709547028;
	bh=B826BG/LabvHzX/qTThYEXRApaxmS5m/7jaE3+DLICE=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=TP/R0yQScU7A9oo7JK2IJK6F1Cu+pbJvFHFTfd3w7ecqrW/nF3MLpLuVyEl6sus/D
	 l3DLo9YgpIHwomCL2w8MoYH3B4hZ4fyf22JS38RYyin1BgFlIqB2oj9VbGrj6+JOXA
	 /Yv6Gcc66KokxBxI2rzUiaMSwHOTa34MZMpHcPJPP/vxYWbNP9bxs1mvK8UqMsiTHc
	 K8wflKdElTFX5OuqA4Ci8UGu42NaLtv88IFFkPcSNW8Kl8fW4wqwb4nP8hOPV3ZUVr
	 Pa3W+Ni7Xb9W0CoKuRxO5fdiAhv8zzt/8HvfheAyUiDvxTaMx5tXZuoZw6RxTMFjIT
	 tsndoi4QFvUVg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 147ACD88F87;
	Mon,  4 Mar 2024 10:10:28 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next 0/3] gve: Add header split support
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170954702808.29163.14572409164565217897.git-patchwork-notify@kernel.org>
Date: Mon, 04 Mar 2024 10:10:28 +0000
References: <20240229212236.3152897-1-ziweixiao@google.com>
In-Reply-To: <20240229212236.3152897-1-ziweixiao@google.com>
To: Ziwei Xiao <ziweixiao@google.com>
Cc: netdev@vger.kernel.org, jeroendb@google.com, pkaligineedi@google.com,
 shailend@google.com, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, willemb@google.com, rushilg@google.com,
 jfraker@google.com, jrkim@google.com, hramamurthy@google.com,
 horms@kernel.org, linux-kernel@vger.kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by David S. Miller <davem@davemloft.net>:

On Thu, 29 Feb 2024 13:22:33 -0800 you wrote:
> Currently, the ethtool's ringparam has added a new field tcp-data-split
> for enabling and disabling header split. These three patches will
> utilize that ethtool flag to support header split in GVE driver.
> 
> Jeroen de Borst (3):
>   gve: Add header split device option
>   gve: Add header split data path
>   gve: Add header split ethtool stats
> 
> [...]

Here is the summary with links:
  - [net-next,1/3] gve: Add header split device option
    https://git.kernel.org/netdev/net-next/c/0b43cf527d1d
  - [net-next,2/3] gve: Add header split data path
    https://git.kernel.org/netdev/net-next/c/5e37d8254e7f
  - [net-next,3/3] gve: Add header split ethtool stats
    https://git.kernel.org/netdev/net-next/c/056a70924a02

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



