Return-Path: <linux-kernel+bounces-24183-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AC3A282B8B1
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 01:40:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 59E371F25AED
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 00:40:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00969139F;
	Fri, 12 Jan 2024 00:40:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DU+qZefg"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C8C1A54;
	Fri, 12 Jan 2024 00:40:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id D930DC433C7;
	Fri, 12 Jan 2024 00:40:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705020025;
	bh=s2hBOTXz+KuvOtZwfWWY9GxmJDRmYMHcIwsJPhDI8v0=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=DU+qZefg9pSeIqBxkKXvhACO0w5xXYYu5eA9ohNGTjn/XNrEriEggZt95z6vTquKN
	 6j2UxNgXXQMUBiTN3dYocg/PtajZTf+auILkfNsJl+UqhEdjMZDH9iGmhVaeyLjb8m
	 OAAG+rstvoVN2IJJ5eEC25zR6jd5ObCZ7wq7EZp7UlO+M7WQRvaLL9kxiZ5muhmCR0
	 6A0dOvTcX61SHqBNu25UHCRgI+jzQ5VsSoQLq+7luzdunGvCxR15CfurUmt3FTiL9C
	 lZHwcv+9YnKkNhyb8K/iUGcmU8GVTXuJEaOG+Nv2rm/Dk9R9AwvfhrydNV4SKF680q
	 1P/jT2g3fjDYA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id BEB38DFC698;
	Fri, 12 Jan 2024 00:40:25 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v1] net: qualcomm: rmnet: fix global oob in rmnet_policy
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170502002577.17549.410019327464907355.git-patchwork-notify@kernel.org>
Date: Fri, 12 Jan 2024 00:40:25 +0000
References: <20240110061400.3356108-1-linma@zju.edu.cn>
In-Reply-To: <20240110061400.3356108-1-linma@zju.edu.cn>
To: Lin Ma <linma@zju.edu.cn>
Cc: quic_subashab@quicinc.com, quic_stranche@quicinc.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 10 Jan 2024 14:14:00 +0800 you wrote:
> The variable rmnet_link_ops assign a *bigger* maxtype which leads to a
> global out-of-bounds read when parsing the netlink attributes. See bug
> trace below:
> 
> ==================================================================
> BUG: KASAN: global-out-of-bounds in validate_nla lib/nlattr.c:386 [inline]
> BUG: KASAN: global-out-of-bounds in __nla_validate_parse+0x24af/0x2750 lib/nlattr.c:600
> Read of size 1 at addr ffffffff92c438d0 by task syz-executor.6/84207
> 
> [...]

Here is the summary with links:
  - [net,v1] net: qualcomm: rmnet: fix global oob in rmnet_policy
    https://git.kernel.org/netdev/net/c/b33fb5b801c6

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



