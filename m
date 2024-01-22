Return-Path: <linux-kernel+bounces-32914-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CC8948361D5
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 12:34:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 82A2E1F2273E
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 11:34:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50D533D577;
	Mon, 22 Jan 2024 11:23:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lybWg096"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DC633AC1A;
	Mon, 22 Jan 2024 11:23:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705922634; cv=none; b=l6Tcm0sPRK/1yI9eD88aczQmM63wRuxCR5kBaNCj6a9kV6lwVRIkcX6idj2mNY6YdP5/dqazedXr31HNJtjXPApc3r41VLUxSm7yhTYk1/+SGEWQVcijzslNkFF0ps32XPpkdqamkdjCvNwdXY7ttuTTohS5O0UsBQ5xUvuldEk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705922634; c=relaxed/simple;
	bh=TxrQIO/al2GpWVkrfoDOU0cuM/hyz+aCVqOTBlEjz+E=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=XoYcA978gAMO/7exkOz/dwMRjIINIbFLJtKFQmwUW5lraGwblxzwx3FB3j1OyvNgZ1CF2oftkEfeX/G4b4/az94A42A0esSF9/4jLkZewBoKGQVxQ30bpmfBErZ+fDY9/Hj3knC5puXKI0hizTyL+z+C2PdfBZwPF1HGljvEaTs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lybWg096; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 2E3B8C433F1;
	Mon, 22 Jan 2024 11:23:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705922634;
	bh=TxrQIO/al2GpWVkrfoDOU0cuM/hyz+aCVqOTBlEjz+E=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=lybWg096e++sBoglThrFVRtkfC+B0mQsXLbOr2TbdDXl5s38zX+Hl+bjzANohFp1P
	 a+GCBlo2bG3KgTrLSXFNJ14UmqGCpYf4xXFJA7I/iH856cDEujaJdJzWNAs3y9f2Ae
	 zNcQXI05cI+UZ5zFgrt+izVWTW7l14fTi4zHfoxsGA/kfpB7f0Eja8t4RYZk+OuUiX
	 YlpdAzoKW/b0Ft+r1Q2xy6Xa2a5mdzDzl/Rd/zTFBo+kNSw5EBFaLauS7q3sHdZ3xB
	 kIothxjAuEp7pRrL/WM23KEQx7kJsIhaqgXtoL2VyrH2Q9jg75uND0RBJdkvbGna1X
	 TrG4DgwK/ecAA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 1C24DE0B62F;
	Mon, 22 Jan 2024 11:23:54 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net 0/2] fixes for tun 
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170592263411.5359.10540209008963512195.git-patchwork-notify@kernel.org>
Date: Mon, 22 Jan 2024 11:23:54 +0000
References: <1705659669-26120-1-git-send-email-wangyunjian@huawei.com>
In-Reply-To: <1705659669-26120-1-git-send-email-wangyunjian@huawei.com>
To: Yunjian Wang <wangyunjian@huawei.com>
Cc: willemdebruijn.kernel@gmail.com, jasowang@redhat.com, kuba@kernel.org,
 davem@davemloft.net, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 xudingke@huawei.com

Hello:

This series was applied to netdev/net.git (main)
by David S. Miller <davem@davemloft.net>:

On Fri, 19 Jan 2024 18:21:09 +0800 you wrote:
> There are few places on the receive path where packet receives and
> packet drops were not accounted for. This patchset fixes that issue.
> 
> Yunjian Wang (2):
>   tun: fix missing dropped counter in tun_xdp_act
>   tun: add missing rx stats accounting in tun_xdp_act
> 
> [...]

Here is the summary with links:
  - [net,1/2] tun: fix missing dropped counter in tun_xdp_act
    https://git.kernel.org/netdev/net/c/5744ba05e7c4
  - [net,2/2] tun: add missing rx stats accounting in tun_xdp_act
    https://git.kernel.org/netdev/net/c/f1084c427f55

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



