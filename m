Return-Path: <linux-kernel+bounces-46298-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ACDF8843D9E
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 12:03:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6285728D818
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 11:03:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDBF371B39;
	Wed, 31 Jan 2024 11:00:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="plKxS+iE"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDBEC6A353;
	Wed, 31 Jan 2024 11:00:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706698828; cv=none; b=NEFZk3zhf/WGEJeLGQmM/zbnV/vIs3TQN/J5iPgnRm7Xz1VRQCD16JkBU1BPSR73LpHAwERQAgD4dV2QAg3rhpkc1p213Y05LAGtOzoRCkX2pEDIPaqn0aaXm4TAkURyLDbZQrczXRiVkV3cJN13AMI048LtWS3F3PlevAktMm4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706698828; c=relaxed/simple;
	bh=2OUC4XA7Q0LIf8v5IFYO9haKVHB68Tj7j3b/DXJXe9g=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=TFEGU+d7dLwQVfDK3M+6Rey9faVf3r6IS5CHfV8M3qjqHnSDNsyl+LZfX8TkguXiKAuEdYjS8T9aygrremzfGdJI4dhcOuEZfJ+r6A+Fx5llqdV9OpeSPpXjBUNKte4opRTryY2EWy1plpHAHOCYFgEQupUlT32+WY0hIaenAfE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=plKxS+iE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 8A26AC43394;
	Wed, 31 Jan 2024 11:00:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706698827;
	bh=2OUC4XA7Q0LIf8v5IFYO9haKVHB68Tj7j3b/DXJXe9g=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=plKxS+iET1RueRPgBNLtSNmMwCnOnRrjOLJbNWxwmaEntP+1rH1CKp1MM1G6zXcaP
	 j17n8UjrSOi7C6eLeqczfw8h9qYMekKFJ3N4G4ZoTHSeCpvh8TLhR48CsivI6rSlRM
	 laTMRkb/UAV4auNptcIwRO5FTTTCkH7pGTLFNYjKvI3vV90VouyPhD8IxEL/iWo3/V
	 7jG+e1E30FpAqJ7OmaJurugNVsygY/m3S/OPYVCdV6zeelNeaSG/N+OpqPfzCGE42T
	 om0OJpafqacnOjUO83FpxRyYfwvGOBX3xyVSKaAskCsRbdUcqDUyZ6vkjEau4lbxDx
	 OQnUDn8YV912Q==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 6EA9DC4166F;
	Wed, 31 Jan 2024 11:00:27 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [RESEND PATCH v4 0/2] StarFive DWMAC support for JH7100
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170669882745.1676.8675995195978883744.git-patchwork-notify@kernel.org>
Date: Wed, 31 Jan 2024 11:00:27 +0000
References: <20240126192128.1210579-1-cristian.ciocaltea@collabora.com>
In-Reply-To: <20240126192128.1210579-1-cristian.ciocaltea@collabora.com>
To: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
 conor+dt@kernel.org, kernel@esmil.dk, samin.guo@starfivetech.com,
 alexandre.torgue@foss.st.com, joabreu@synopsys.com,
 mcoquelin.stm32@gmail.com, peppe.cavallaro@st.com, andrew@lunn.ch,
 jacob.e.keller@intel.com, netdev@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, kernel@collabora.com

Hello:

This series was applied to netdev/net-next.git (main)
by David S. Miller <davem@davemloft.net>:

On Fri, 26 Jan 2024 21:21:24 +0200 you wrote:
> This is just a subset of the initial patch series [1] adding networking
> support for StarFive JH7100 SoC.
> 
> [1]: https://lore.kernel.org/lkml/20231218214451.2345691-1-cristian.ciocaltea@collabora.com/
> 
> Changes in v4:
>  - Rebased series onto next-20240125
>  - Added R-b tag from Rob in PATCH 1
>  - v3:
>    https://lore.kernel.org/lkml/20231222101001.2541758-1-cristian.ciocaltea@collabora.com/
> 
> [...]

Here is the summary with links:
  - [RESEND,v4,1/2] dt-bindings: net: starfive,jh7110-dwmac: Add JH7100 SoC compatible
    https://git.kernel.org/netdev/net-next/c/53e41b76a8ff
  - [RESEND,v4,2/2] net: stmmac: dwmac-starfive: Add support for JH7100 SoC
    https://git.kernel.org/netdev/net-next/c/8d4597b87121

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



