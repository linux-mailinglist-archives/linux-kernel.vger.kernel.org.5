Return-Path: <linux-kernel+bounces-96503-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DDFC5875D28
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 05:30:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 98481282A1E
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 04:30:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82DD42E84A;
	Fri,  8 Mar 2024 04:30:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qsvQCtLT"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B885E1E4A4;
	Fri,  8 Mar 2024 04:30:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709872229; cv=none; b=s2Q2VGyWaE5Zvi9Uj+Kr/OnyC1wxhlNhz7ha8/pr0VgQpSSwTxUgulVOkZjIyHevASR58dMQHET5G30ESj2RYD//EAdZhfiK01V7Mwn3XIIfnzHqfg2eKpCorHZTzdySOS37dpRYgA8Xw2+pAwls11+hx9Hau4zusSrn0yw2Pv0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709872229; c=relaxed/simple;
	bh=fJ6NAKODlt0NG2MhAdXUHK2ZCec42rPyXfyuZicuCw8=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=mEb9prdEUvly2HSAqxCmZlgzFqB0Akg2PzbgGRZsHz52RMjNhXm1xTtczZ7n+Yg6JO1cybXjXhAeIaZBy3NZnJ9JHL/NKM9mWUcrEEIDtzu97NrhKATjQaNxcI3juMmdJaKYu8fj+Xr5eD++xO0QnQ8pzAnBA9Apm8mZa7S3kKw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qsvQCtLT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 40545C433C7;
	Fri,  8 Mar 2024 04:30:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709872229;
	bh=fJ6NAKODlt0NG2MhAdXUHK2ZCec42rPyXfyuZicuCw8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=qsvQCtLTX/tPCHyhg5Haavr3aq7w8EnlOzjSEB6SeswhHer2s+E9ZmHnOdGYKvH7P
	 Dnx0lrhy0KKF9bH9vbzPR9VX6s0oeWyDuaXWgZrdZiXzL1kgNevoyosRoHRRMfaSr2
	 Wb3Jm4FuBjg3blNVVoGRMDxktvD4pAwaeivd7sxv6DqTZLfHIvVVosBLKMDNLaF+92
	 7KwbbtbbhwdElVBSVaikaJRHN1kfHdAfOn7DxC8UufsvLsmORrGQNyjU3PscEqyJFR
	 cY1RY3ls+GNYa25T3mGeKHf9sjVZdvfBARCrAgqEQwvRvjlqNRMcsc4LTzxChXYcM6
	 t8uhS72XPhwaw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 214DFD84BBF;
	Fri,  8 Mar 2024 04:30:29 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH RESEND net-next] dt-bindings: net: dp83822: change
 ti,rmii-mode description
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170987222912.2034.16944334972154168429.git-patchwork-notify@kernel.org>
Date: Fri, 08 Mar 2024 04:30:29 +0000
References: <20240305141309.127669-1-jeremie.dautheribes@bootlin.com>
In-Reply-To: <20240305141309.127669-1-jeremie.dautheribes@bootlin.com>
To: =?utf-8?q?J=C3=A9r=C3=A9mie_Dautheribes_=3Cjeremie=2Edautheribes=40bootlin?=@codeaurora.org,
	=?utf-8?q?=2Ecom=3E?=@codeaurora.org
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
 conor+dt@kernel.org, afd@ti.com, andrew@lunn.ch, netdev@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 thomas.petazzoni@bootlin.com, yen-mei.goh@keysight.com,
 miquel.raynal@bootlin.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue,  5 Mar 2024 15:13:09 +0100 you wrote:
> Drop reference to the 25MHz clock as it has nothing to do with connecting
> the PHY and the MAC.
> Add info about the reference clock direction between the PHY and the MAC
> as it depends on the selected rmii mode.
> 
> Suggested-by: Andrew Lunn <andrew@lunn.ch>
> Signed-off-by: Jérémie Dautheribes <jeremie.dautheribes@bootlin.com>
> 
> [...]

Here is the summary with links:
  - [RESEND,net-next] dt-bindings: net: dp83822: change ti,rmii-mode description
    https://git.kernel.org/netdev/net-next/c/b72413211b48

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



