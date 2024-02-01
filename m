Return-Path: <linux-kernel+bounces-47455-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 91857844E2C
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 01:50:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2408628EB3D
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 00:50:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6544C440E;
	Thu,  1 Feb 2024 00:50:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V3LlxWj1"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A04561FDB;
	Thu,  1 Feb 2024 00:50:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706748627; cv=none; b=AQT2wlJ2hm23xIrcu40PHq5XlcZTA9hL6IdxzNL52DxmF7iySkEQKn8L21BrYkggmbUCfO3oCuVNcGsHCxsdL3FVYgjbdIdDpqBFDzSUBUebOkn+blP6ihEzQw/jCz0o95RiClVK7gMDEgatTySzfhDMNiFRy6RLLT+e8lHxTKc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706748627; c=relaxed/simple;
	bh=Z8/BUyh1zO7VkK/Z95QEQWiI4CaCboUScz5qDKCf52w=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=tyXz23hujpvbopAl24uaponAseteiSTfJGbEiwxpz66o6AAH09gWVolhXoYgxWDlRptv2bltGd4HxCzxWEnL+fNI5CL06vqBg4iehtEM8qyjU4CDwRaJpcN/j73Xfu68PjszNZs6ebF9v9jd8nnO85FBXDyJ9RDmt2XoSmHAQ3k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V3LlxWj1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 36213C43394;
	Thu,  1 Feb 2024 00:50:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706748627;
	bh=Z8/BUyh1zO7VkK/Z95QEQWiI4CaCboUScz5qDKCf52w=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=V3LlxWj1BtfdnbpotfYIP/AOJVD0kYrHuO4ila2uOh6DXOYcsCi5Eq3+JVUhl7bfX
	 O4+dzUQA7x4YaiOttpE8ANWhH7zd/4weXRPNKA/P+6MfeXvdsYNLSIDLlq9Qd2dI2F
	 0QUYzCFn/UXF/9H9GiiwDIEICGcz9fhvlY1uEVe8NycNPIEYT9fSYQrezI2XJUy1SJ
	 njwYbufd5cOV8NEglSUMHKXCitwYy+aGH7EhMc8aAaOh6NHtNmji6Ozr6oi/Zeuym6
	 8BT2UyI+l8R+07JZzJbFGXlIZNGy/8Q+58HYzOzy9LPcsmtz8DZ+dwv2KUH6DNWDHB
	 Qhya5+FfdNdJg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 1CCECD8C96C;
	Thu,  1 Feb 2024 00:50:27 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] net: bridge: Use KMEM_CACHE instead of
 kmem_cache_create
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170674862711.27305.15780784019014646394.git-patchwork-notify@kernel.org>
Date: Thu, 01 Feb 2024 00:50:27 +0000
References: <20240130092536.73623-1-chentao@kylinos.cn>
In-Reply-To: <20240130092536.73623-1-chentao@kylinos.cn>
To: Kunwu Chan <chentao@kylinos.cn>
Cc: roopa@nvidia.com, razor@blackwall.org, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 bridge@lists.linux.dev, netdev@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 30 Jan 2024 17:25:36 +0800 you wrote:
> commit 0a31bd5f2bbb ("KMEM_CACHE(): simplify slab cache creation")
> introduces a new macro.
> Use the new KMEM_CACHE() macro instead of direct kmem_cache_create
> to simplify the creation of SLAB caches.
> 
> Signed-off-by: Kunwu Chan <chentao@kylinos.cn>
> 
> [...]

Here is the summary with links:
  - [net-next] net: bridge: Use KMEM_CACHE instead of kmem_cache_create
    https://git.kernel.org/netdev/net-next/c/2dc23b6f852b

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



