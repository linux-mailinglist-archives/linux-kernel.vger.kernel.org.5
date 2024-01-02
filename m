Return-Path: <linux-kernel+bounces-14483-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 74FEC821DA9
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 15:30:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9B7491C21F8B
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 14:30:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0828C12E4D;
	Tue,  2 Jan 2024 14:30:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aQqlvHyj"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 529181172D;
	Tue,  2 Jan 2024 14:30:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id F18E2C43397;
	Tue,  2 Jan 2024 14:30:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704205830;
	bh=a9sodbYm9U5Bqtf3uHkJyJDa6FhSRtb8xw31TmUxp/U=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=aQqlvHyjM2hN1amemHEt3rEyPGMYjW2MxedaJKyoawn4jQSp50aqO7tsTSxx7O9TQ
	 F2vNMdZcrgqxn1k1kRcBrxlCK8uK2i6ub1SkajcsHAZVt4LdN0fGvzqwiNeevFS1O8
	 L4Cjio6YgtCeo2r2GzxiXInJim6YMRzdq6J71zfUYHotPIA0O70NPRLr6gtwqPfj6/
	 F6yvp/aDRDjNulV7lvrc0jnmkWZl/Z8Cooaj3esUT71yuqq/oIXMloBJo3wv64ozFg
	 Pul48tJL1Pwu8Ib/hRfHU7x3D1yMfruZVwWRsJnlX5tRkK59DqdtSbaHfW17+RelGn
	 DeeoW1YEOcFig==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id D45FBC395C5;
	Tue,  2 Jan 2024 14:30:29 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v2 0/8] add octeon_ep_vf driver
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170420582986.19051.12786293440170247050.git-patchwork-notify@kernel.org>
Date: Tue, 02 Jan 2024 14:30:29 +0000
References: <20231223134000.2906144-1-srasheed@marvell.com>
In-Reply-To: <20231223134000.2906144-1-srasheed@marvell.com>
To: Shinas Rasheed <srasheed@marvell.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, hgani@marvell.com,
 vimleshk@marvell.com, sedara@marvell.com, egallen@redhat.com,
 mschmidt@redhat.com, pabeni@redhat.com, kuba@kernel.org, horms@kernel.org,
 wizhao@redhat.com, kheib@redhat.com, konguyen@redhat.com

Hello:

This series was applied to netdev/net-next.git (main)
by David S. Miller <davem@davemloft.net>:

On Sat, 23 Dec 2023 05:39:52 -0800 you wrote:
> This driver implements networking functionality of Marvell's Octeon
> PCI Endpoint NIC VF.
> 
> This driver support following devices:
>  * Network controller: Cavium, Inc. Device b203
>  * Network controller: Cavium, Inc. Device b403
>  * Network controller: Cavium, Inc. Device b103
>  * Network controller: Cavium, Inc. Device b903
>  * Network controller: Cavium, Inc. Device ba03
>  * Network controller: Cavium, Inc. Device bc03
>  * Network controller: Cavium, Inc. Device bd03
> 
> [...]

Here is the summary with links:
  - [net-next,v2,1/8] octeon_ep_vf: Add driver framework and device initialization
    https://git.kernel.org/netdev/net-next/c/ebdc193b2ce2
  - [net-next,v2,2/8] octeon_ep_vf: add hardware configuration APIs
    https://git.kernel.org/netdev/net-next/c/5f8c64c2344c
  - [net-next,v2,3/8] octeon_ep_vf: add VF-PF mailbox communication.
    https://git.kernel.org/netdev/net-next/c/db468f92c3b9
  - [net-next,v2,4/8] octeon_ep_vf: add Tx/Rx ring resource setup and cleanup
    https://git.kernel.org/netdev/net-next/c/6ca7b5486ebd
  - [net-next,v2,5/8] octeon_ep_vf: add support for ndo ops
    https://git.kernel.org/netdev/net-next/c/8f8d322bc47c
  - [net-next,v2,6/8] octeon_ep_vf: add Tx/Rx processing and interrupt support
    https://git.kernel.org/netdev/net-next/c/77cef1e02104
  - [net-next,v2,7/8] octeon_ep_vf: add ethtool support
    https://git.kernel.org/netdev/net-next/c/50648968b3e3
  - [net-next,v2,8/8] octeon_ep_vf: update MAINTAINERS
    https://git.kernel.org/netdev/net-next/c/c902ba322cfd

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



