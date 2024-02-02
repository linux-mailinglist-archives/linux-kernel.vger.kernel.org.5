Return-Path: <linux-kernel+bounces-49828-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 06088847023
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 13:20:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8E5B3B25F5F
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 12:20:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AA8B1419BB;
	Fri,  2 Feb 2024 12:20:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gIAb62S3"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B88E140798;
	Fri,  2 Feb 2024 12:20:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706876430; cv=none; b=hUXbK3sFIyB2CGCcJNkqLMZ6gA9kh+7sGQJsSzOBFSeRDQl1xzqADpkJlhibKkfM6O0ufHKvvDMX7ExLblx1cFkMNLjDB5Q4kDjs1ELJa0WGEwPceCzWWG4FOvayC/sww7rp1fhmxH4OXBwWRZU4eB7qHoxGovsgzLmxyNNdaAc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706876430; c=relaxed/simple;
	bh=pezjORKs04TnxA6x46I1xjMr8qV0y5m9v8yy8dTTw5o=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=lHLAvKmiKCYlNT3HaezWmmareCOQwTIPIsFDzXUo2Y8wxH7m6EcMshq73tT4mpNNcy4krdrjAR1DI5I4IuFhnuJ1z96JAofCegQiIf5ZRV1blCkIWuS8s30Jsya/kWFb1KDcPUgc1XUlbs9gTiTQryQ03kFzG/4v0nHN3sT9pgc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gIAb62S3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id EB0AEC43390;
	Fri,  2 Feb 2024 12:20:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706876430;
	bh=pezjORKs04TnxA6x46I1xjMr8qV0y5m9v8yy8dTTw5o=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=gIAb62S3JB78JiYv3JDYZaNDAFPQPmq9l8EHrRvXCqNJslNZg+Sd9eFLPYONMYVh6
	 cWe2psaordvNU8XWP/YhqmkI30sval5P98sLjtvceyw+t+3POzOuftX7RtV5bSrSpu
	 pX4MKhlVvamvOKyVRnegSlvvGAN5theyStISUT0LJdmiCGmBACQMTLylPlechcqx2B
	 S3hBEMlG+WY04tO26b/BeJ9j067SWWqgai32cYJ1Lt19iOjSCGpvU9leDyn/zfnUO2
	 sHUsGp/dfESJFG3wBH9DCe+cNnYv3wlxVbKXnQOIMTYxYlpabkG5CH9A3gV5sIHUkB
	 HIzxMMAk00ecw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id CE088D8C978;
	Fri,  2 Feb 2024 12:20:29 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] dt-bindings: net: ti: Update maintainers list
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170687642984.27809.11207868729935632125.git-patchwork-notify@kernel.org>
Date: Fri, 02 Feb 2024 12:20:29 +0000
References: <20240131085351.25103-1-r-gunasekaran@ti.com>
In-Reply-To: <20240131085351.25103-1-r-gunasekaran@ti.com>
To: Ravi Gunasekaran <r-gunasekaran@ti.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
 conor+dt@kernel.org, s-vadapalli@ti.com, rogerq@kernel.org, srk@ti.com,
 netdev@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by David S. Miller <davem@davemloft.net>:

On Wed, 31 Jan 2024 14:23:51 +0530 you wrote:
> Update the list with the current maintainers of TI's CPSW ethernet
> peripheral.
> 
> Signed-off-by: Ravi Gunasekaran <r-gunasekaran@ti.com>
> ---
>  Documentation/devicetree/bindings/net/ti,cpsw-switch.yaml    | 5 +++--
>  .../devicetree/bindings/net/ti,k3-am654-cpsw-nuss.yaml       | 5 +++--
>  Documentation/devicetree/bindings/net/ti,k3-am654-cpts.yaml  | 5 +++--
>  3 files changed, 9 insertions(+), 6 deletions(-)

Here is the summary with links:
  - [net-next] dt-bindings: net: ti: Update maintainers list
    https://git.kernel.org/netdev/net-next/c/84f90efd5076

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



