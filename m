Return-Path: <linux-kernel+bounces-149856-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0073E8A96E0
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 12:00:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B00872832D4
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 10:00:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4492015B56A;
	Thu, 18 Apr 2024 10:00:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pgaKqiNc"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DCEA15AAB2;
	Thu, 18 Apr 2024 10:00:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713434431; cv=none; b=sQwRNf5oiC8hA9Cq6J85fTK3BAzgX1BGiRFzztBgIBANadHtwgDHxtiqbAYNQDAUFV/5RYl4a4U/uMYjRKC7eGkvphU/9l/3PtnCBsOf1yYWwMSGc9ByHBIaX1EpaCeHrJvXmjNLFw78P+YJjRaWnWS2O7VlCNL1KwLCiD/ANa8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713434431; c=relaxed/simple;
	bh=VZ8PSIQDBZok+yillN9+DRYAlL6mgmiVxKVpDWlsKh4=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=d7qfn/BGgf/5LY7hR6df/5rvRwpfd6viAaSe/rGY7FoGVH7CKMETT5ZgeyiaR7mkvmyQ6sQCTK7cp+uvoUjMgPnqGW0/yHoSmuQkDyNLHrtRDqVXB+yJ85KhWwY9WyXlOyQvJ2UIbYV7AZDEAZGTvMa9wc9rjPgiD9IekKM6r60=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pgaKqiNc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 6261DC2BD11;
	Thu, 18 Apr 2024 10:00:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713434430;
	bh=VZ8PSIQDBZok+yillN9+DRYAlL6mgmiVxKVpDWlsKh4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=pgaKqiNcAG7IEKmoE5YEi+tenjJE2ph2OUf5hpzmDgS55MHyINo4EV1np3TllCwZa
	 CGGFuinqg6K4Af/oq7PI77a/uHPi2N4ypylANDrSaaxLneNmpmYlNy8n3yb7EqkfFq
	 eXvBYBtzMs/xiBsn75S5YpJhTeq3BoIpz7xBOG016iXGOghsJkHTuUzTlPferwGvQP
	 SI6GoB2yB1Y6ios9ZBiWX2ke2a/fzqbu6VkU0NS/cXrVajTOt5uru/+Y2L0Ue6MrsY
	 gWcXLL5V1/+HZYYBARXAdYQg+UAnDeBLws7sUOPtDWbD5FlBQVL43jUHR7xaWbDZo4
	 Kt7I+L/52yP7A==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 4E266C43618;
	Thu, 18 Apr 2024 10:00:30 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [net PATCH v3 0/4] ravb Ethernet driver bugfixes
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171343443031.11236.5934225163473526469.git-patchwork-notify@kernel.org>
Date: Thu, 18 Apr 2024 10:00:30 +0000
References: <20240416120254.2620-1-paul.barker.ct@bp.renesas.com>
In-Reply-To: <20240416120254.2620-1-paul.barker.ct@bp.renesas.com>
To: Paul Barker <paul.barker.ct@bp.renesas.com>
Cc: s.shtylyov@omp.ru, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, niklas.soderlund+renesas@ragnatech.se,
 geert+renesas@glider.be, claudiu.beznea.uj@bp.renesas.com,
 biju.das.jz@bp.renesas.com, yuehaibing@huawei.com, netdev@vger.kernel.org,
 linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This series was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Tue, 16 Apr 2024 13:02:50 +0100 you wrote:
> These patches fix bugs found during recent work on the ravb driver.
> 
> Patches 1 & 2 affect the R-Car code paths so have been tested on an
> R-Car M3N Salvator-XS board - this is the only R-Car board I currently
> have access to.
> 
> Patches 2, 3 & 4 affect the GbEth code paths so have been tested on
> RZ/G2L and RZ/G2UL SMARC EVK boards.
> 
> [...]

Here is the summary with links:
  - [net,v3,1/4] net: ravb: Count packets instead of descriptors in R-Car RX path
    https://git.kernel.org/netdev/net/c/def52db470df
  - [net,v3,2/4] net: ravb: Allow RX loop to move past DMA mapping errors
    https://git.kernel.org/netdev/net/c/a892493a3434
  - [net,v3,3/4] net: ravb: Fix GbEth jumbo packet RX checksum handling
    https://git.kernel.org/netdev/net/c/c7c449502b51
  - [net,v3,4/4] net: ravb: Fix RX byte accounting for jumbo packets
    https://git.kernel.org/netdev/net/c/2e36c9fbc476

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



