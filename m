Return-Path: <linux-kernel+bounces-129523-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 69B71896C01
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 12:20:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 20C481F26660
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 10:20:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AD79136997;
	Wed,  3 Apr 2024 10:20:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q2rhF9Vi"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AF1913666E;
	Wed,  3 Apr 2024 10:20:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712139630; cv=none; b=nSjVp1WiNY5WUX52e58EqXwqEF/nC5Su7yAuuk5sdrFM4I0vL4LfBNbST2nGeBOkedapEG9I6LZRjUCpiBr54pQ0AQGVReyHwc0DrMH/Dxofl571yuDFKTrLb7ECZs30AYcF0JuwAn+LGiFhivoKjXEvsk3HM71emjIlN8NHmys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712139630; c=relaxed/simple;
	bh=AL0Qnrd/A8TDJ9H5AMWkoE6i8w6NSYh0c+VGA6etYWQ=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=aFzxsUNuqU5CIV6DnbwB+UpEZ1Mjh0bGRhga2npVd68H48MAdOudeo24F+bZqWvL6JZskocVBcphkSzZ4enikr0oGxF9Yc0uwLe0TD21IBTqbIoVRoB/4+qqWwVq4fNj791wOlCazG2JoHnKQOzXYarTPQYcTq0M6eINw20D/5w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q2rhF9Vi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id BD9EFC43399;
	Wed,  3 Apr 2024 10:20:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712139629;
	bh=AL0Qnrd/A8TDJ9H5AMWkoE6i8w6NSYh0c+VGA6etYWQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Q2rhF9Vix+dbTxZ4Xo7xBDZ0/be2uxb3mjd3fQ4wsXHl15CA3H4VzEU4Ju2gwyDNb
	 sSzb+51n+JmwV9El5ZEecRycWGY4Wu0dngYxKJQ8/RvUWd/Kp/cNwH870cIAHGvSvb
	 EQyY39h9RN9jKcYcrLvPcPw1x9lv2G/3ta4ymuoTD+6QBdaHLBpj55y3478Wl/NGEZ
	 8bnJSnnul+lBh/xqSJtOMXJTQ+iTUdhmlANh98kBY/Qol14/6qESDduEbsv6z12WX/
	 xrZH95j/CbNfn0V7YwVLqCsDBYlDXJbVv/VJTywRj1x/U9g2YtOw5Lw6MChLH4zJVE
	 3FfM9sHHlc4eQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id AE141D9A158;
	Wed,  3 Apr 2024 10:20:29 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next 0/5] gve: enable ring size changes
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171213962970.11580.1669175780446197637.git-patchwork-notify@kernel.org>
Date: Wed, 03 Apr 2024 10:20:29 +0000
References: <20240401234530.3101900-1-hramamurthy@google.com>
In-Reply-To: <20240401234530.3101900-1-hramamurthy@google.com>
To: Harshitha Ramamurthy <hramamurthy@google.com>
Cc: netdev@vger.kernel.org, jeroendb@google.com, pkaligineedi@google.com,
 shailend@google.com, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, willemb@google.com, rushilg@google.com,
 jfraker@google.com, linux-kernel@vger.kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by David S. Miller <davem@davemloft.net>:

On Mon,  1 Apr 2024 23:45:25 +0000 you wrote:
> This series enables support to change ring size via ethtool
> in gve.
> 
> The first three patches deal with some clean up, setting
> default values for the ring sizes and related fields. The
> last two patches enable ring size changes.
> 
> [...]

Here is the summary with links:
  - [net-next,1/5] gve: simplify setting decriptor count defaults
    https://git.kernel.org/netdev/net-next/c/4cbc70f6ec5e
  - [net-next,2/5] gve: make the completion and buffer ring size equal for DQO
    https://git.kernel.org/netdev/net-next/c/5dee3c702c20
  - [net-next,3/5] gve: set page count for RX QPL for GQI and DQO queue formats
    https://git.kernel.org/netdev/net-next/c/b94d3703c1a6
  - [net-next,4/5] gve: add support to read ring size ranges from the device
    https://git.kernel.org/netdev/net-next/c/ed4fb326947d
  - [net-next,5/5] gve: add support to change ring size via ethtool
    https://git.kernel.org/netdev/net-next/c/834f9458f2fd

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



