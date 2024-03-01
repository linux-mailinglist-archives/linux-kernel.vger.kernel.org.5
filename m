Return-Path: <linux-kernel+bounces-88267-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E65B86DF68
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 11:40:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8B7F31C21676
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 10:40:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4660D6CBFF;
	Fri,  1 Mar 2024 10:40:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CIVg0ItN"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 820E86A8DE;
	Fri,  1 Mar 2024 10:40:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709289628; cv=none; b=oMo2KImTviXGnj+iAPAMYbr8G71XMVPz6U7gg5A/U+ddZUkmL5KJY5KFPZfbOXC4Q6q8mS1mjIColl1QgjGorDUYB1ddV7c7P79Gtt3N4/vIs+76I1SOdTM6RcdDd7hESgdvzL9FF4Ug21VN3BQLYuSiz7uPwmQzGHmOeC8Mul4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709289628; c=relaxed/simple;
	bh=jP94fBknknAzdulhkf9CYCryAxyaB7QvH16j0Z/Y9gA=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=gFANVGuPet38OLCbFjeddiPqV4dIvBlVI1K0aoxT45tuFYSpKUXTwR9m8AlKbyU8CsS4ixhg7e1xp9emlapxOcS/c6Yn1jbf4hDsrtHnlKPHUcDh7MXnrt4eKBQq0HHv1LZ6WB7goeEsSzxa41QfTijkA6QCipCwOsNPl8glsDA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CIVg0ItN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 10011C43390;
	Fri,  1 Mar 2024 10:40:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709289628;
	bh=jP94fBknknAzdulhkf9CYCryAxyaB7QvH16j0Z/Y9gA=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=CIVg0ItNva/uo0rnXBffFfREbf5V9yqs8YnddQGgv5yemBON4qSoNC04cKCq5QJEM
	 9AYrn/k2l0XaysGMvlD3HInwUQVxZDMWpDH1mhY6Lj6QJuG2OzkXVFqpGt1v7ALkcX
	 tSOI/Bh5l4l/FSL+C3wtz0t1moKGch82bcBbQ8jNOOY4KgPIVKOYw+Ywz4JUYIf7MU
	 gnu22B9tJarBbL0rMgNHRPbdqNhJv2cMHwPntcdfAOFUaJP5ZvjNFjOWHrc+r46jPZ
	 f5U4C9RJNN09IQYoSd9aCFtChinex9AFUJrJ4NXEGEFA/yonPQiJwLpNc7+n8qT0ED
	 XCxoDLQpHdPmg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id DF07ED990AE;
	Fri,  1 Mar 2024 10:40:27 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] MAINTAINERS: net: netsec: add myself as co-maintainer
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170928962790.1389.4056833631071061951.git-patchwork-notify@kernel.org>
Date: Fri, 01 Mar 2024 10:40:27 +0000
References: <20240301063214.2310855-1-kojima.masahisa@socionext.com>
In-Reply-To: <20240301063214.2310855-1-kojima.masahisa@socionext.com>
To: Masahisa Kojima <kojima.masahisa@socionext.com>
Cc: jaswinder.singh@linaro.org, ilias.apalodimas@linaro.org,
 davem@davemloft.net, netdev@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by David S. Miller <davem@davemloft.net>:

On Fri,  1 Mar 2024 15:32:14 +0900 you wrote:
> Add myself as co-maintainer for Socionext netsec driver.
> This commit also removes Jassi from maintainer since he
> no longer has a Developerbox.
> 
> Cc: Jassi Brar <jaswinder.singh@linaro.org>
> Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> Signed-off-by: Masahisa Kojima <kojima.masahisa@socionext.com>
> 
> [...]

Here is the summary with links:
  - MAINTAINERS: net: netsec: add myself as co-maintainer
    https://git.kernel.org/netdev/net/c/1c61728be22c

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



