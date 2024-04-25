Return-Path: <linux-kernel+bounces-157980-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 42A718B19B9
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 05:50:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 88FB0B23242
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 03:50:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F5332C69B;
	Thu, 25 Apr 2024 03:50:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uTaM8r1A"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FD721CFAF;
	Thu, 25 Apr 2024 03:50:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714017028; cv=none; b=nRuOde2yUFdh+2I5foeIsDMhzg0Cfnv4wPQ4YWLuV9SQcOQFNlbcpl3MT7VSkdYivqd/R2TFyDOSSNOihp9DY7JKh18JNmeQf9ej56pW6VnpvuUipselaW9Y7fPtPfi0PQv4no+cSgJJ0Honpplp9R5ratIi/7zzrXGuZscYl+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714017028; c=relaxed/simple;
	bh=V6A7xEEwHSmN9XOdUsMP+K63NokIKrr+DoQ1VWdGu/Q=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=DT0ykYT6Xm23ak6QlUit/6IR5jQInz/Ryg+ptoGsiWHJtQHNkmA5MHy1W4SSAwWiz0/YQxeirFhZqxbjoDptnow0WO6mQPAR98BdJ9JCYu9UxXKWGUeiFBPW8zZeFMZC9aU/0DKBi7IJAgpzn4maeqZnQItBcssf34c+BOsKtPE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uTaM8r1A; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 52373C2BD10;
	Thu, 25 Apr 2024 03:50:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714017028;
	bh=V6A7xEEwHSmN9XOdUsMP+K63NokIKrr+DoQ1VWdGu/Q=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=uTaM8r1A2hSXcgeMMo4LslAGBfl+miRnqoKZ4csbPGY866cfrMCQ3TGa6VI18R3QB
	 CtOYpQP3SgvcVVxBk3DXlbB/O4wlNpCLWgSvvH0VffAA7mS3J/Aywf0//W1Un7KFJK
	 NSUIYoA1tiyBPlJ0CsSTgsHgW3EUNZ++7i+DvAuNPjaCbAi4EzW2Etq1nUEH3J1jFx
	 tgZloF5/HvFWK8eeih5e6W/SzElyLklBaKY+acJ9WMpzVQ4W1u3jJ2bFmq+jUkZ09e
	 qr7YjlxrdnRusOtJn+XUHCHVCpNdKicwcwK+VDj6iB5frMCWu4dklFqjP8yRqI9EmV
	 +jm2UFphfO6Yg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 3C7E0C43614;
	Thu, 25 Apr 2024 03:50:28 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v3 1/3] net: pse-pd: pse_core: Add missing kdoc
 return description
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171401702824.27021.7662896832481098233.git-patchwork-notify@kernel.org>
Date: Thu, 25 Apr 2024 03:50:28 +0000
References: <20240423-fix_poe-v3-1-e50f32f5fa59@bootlin.com>
In-Reply-To: <20240423-fix_poe-v3-1-e50f32f5fa59@bootlin.com>
To: Kory Maincent <kory.maincent@bootlin.com>
Cc: o.rempel@pengutronix.de, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, andrew@lunn.ch,
 thomas.petazzoni@bootlin.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, kyle.swenson@est.tech

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 23 Apr 2024 11:21:10 +0200 you wrote:
> From: Kory Maincent (Dent Project) <kory.maincent@bootlin.com>
> 
> Add missing kernel documentation return description.
> This allows to remove all warning from kernel-doc test script.
> 
> Reviewed-by: Andrew Lunn <andrew@lunn.ch>
> Acked-by: Oleksij Rempel <o.rempel@pengutronix.de>
> Signed-off-by: Kory Maincent <kory.maincent@bootlin.com>
> 
> [...]

Here is the summary with links:
  - [net-next,v3,1/3] net: pse-pd: pse_core: Add missing kdoc return description
    https://git.kernel.org/netdev/net-next/c/fb1676ed7114
  - [net-next,v3,2/3] net: pse-pd: pse_core: Fix pse regulator type
    https://git.kernel.org/netdev/net-next/c/326f442784c2
  - [net-next,v3,3/3] net: pse-pd: Kconfig: Add missing Regulator API dependency
    https://git.kernel.org/netdev/net-next/c/2fa809b90617

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



