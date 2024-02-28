Return-Path: <linux-kernel+bounces-84873-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7588886ACE1
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 12:21:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A73721C250D7
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 11:21:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56F3D12F389;
	Wed, 28 Feb 2024 11:20:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fFHc1EqZ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82168135A69;
	Wed, 28 Feb 2024 11:20:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709119234; cv=none; b=LDmKyV1vMGb4UxMs8j8SQLp/q6mlOjP03WA9lqDpoKthjsZBxY5yAOYEmArPn77aLA0dHrW5McOmiNLJKImsAG/OPkTZYErbiZO4oCAsCqCBbPmbdbTG9uOuOgcbK9Bu7uzmB31zJBOs4/Q81Go1Ooxu+GedMyUbYQXTt4HS0MM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709119234; c=relaxed/simple;
	bh=OooMnjHi7YMrUZwdus2OFW8aszLN3QHbSEGzT6TdV9M=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=juvhj90IHbtXzOPnrMFgeLtYpfC06mScD12C2W4jYUYfeuKKI755Q4v99Dqv2kDKOOySxLS7WKZEDt36kCsDvUDhLs2K85jtwKedXAWqtZUGcGjjNXlvs3TFBPsTlPaLSuaGeKVEDoM+K1/eFi0jJ/eESFz3aqJXRhV5gZTDFww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fFHc1EqZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 20F79C43142;
	Wed, 28 Feb 2024 11:20:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709119234;
	bh=OooMnjHi7YMrUZwdus2OFW8aszLN3QHbSEGzT6TdV9M=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=fFHc1EqZqtMJGPGMFMLNeKAJT3wFESdlFg/oZBdLwAi8295jTLGN9i+ikG18yxGY4
	 faeS0Zz7g2/w730C/z2IVo4Uw9lC17mNsouPrBI2/L4qx+rLmIp7KeA00IaoWVIi0Y
	 iG28JoqYwMgx+rY1CAFRefY8evCy8GpqmC+B2gSrFbyVV9abAtQon7fcd+ZUhTq29O
	 8TsaiShCiMkY4BmKcgF2NuFDpLik/5vPxYf4v6dUXrYWxQbz9vm0nOejuJU0FG+2Q4
	 a1z4SMDawHIRhq631bNZRDFiG6psYEien4KjtPrj0xq4xwDvHoaQRTAf0rn69pwxQv
	 oCMf5MGnoEPeA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 0CC41C595D2;
	Wed, 28 Feb 2024 11:20:34 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] dt-bindings: net: ethernet-controller: drop
 redundant type from label
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170911923404.32073.12295008338288366328.git-patchwork-notify@kernel.org>
Date: Wed, 28 Feb 2024 11:20:34 +0000
References: <20240226122913.87669-1-krzysztof.kozlowski@linaro.org>
In-Reply-To: <20240226122913.87669-1-krzysztof.kozlowski@linaro.org>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, robh@kernel.org, krzysztof.kozlowski+dt@linaro.org,
 conor+dt@kernel.org, netdev@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by David S. Miller <davem@davemloft.net>:

On Mon, 26 Feb 2024 13:29:13 +0100 you wrote:
> dtschema defines label as string, so $ref in other bindings is
> redundant.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  Documentation/devicetree/bindings/net/ethernet-controller.yaml | 1 -
>  1 file changed, 1 deletion(-)

Here is the summary with links:
  - [net-next] dt-bindings: net: ethernet-controller: drop redundant type from label
    https://git.kernel.org/netdev/net-next/c/3e46ec180ed9

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



