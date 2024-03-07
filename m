Return-Path: <linux-kernel+bounces-95733-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 184978751E1
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 15:30:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C27E21F26405
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 14:30:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E9DB1E529;
	Thu,  7 Mar 2024 14:30:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oHqZOzl4"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2CCA1DFC1;
	Thu,  7 Mar 2024 14:30:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709821829; cv=none; b=DYLegkc2riPXk6vkr+OvZL1NeDE3BJHh8IE5btKLO8gUH0Ur6YVySulbs4dUI/dMhz4YDddw7RjgCdpQpJytbbPC828AkMDMb2NOGyg8PBHB5qv3iOJ3l9jJm8PQzWnulCoYSaftfhxhpxGT2yC5erYxWpFrHZvHgI5i0jhlkLc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709821829; c=relaxed/simple;
	bh=A5XHbWQDmEQKfQ8MXuWsPcED1PZeiEmknAyPAY6s+SQ=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Rxv15gGg1PpcCYREvaGk1B+xDC9/q6tlztLyOm/VTRK9W9YGJjSOAd5Zg7TJ6r6XnplsrDV5HRDy5a9pPZzVvSWr+u8i8gFAzj++UrFT4IJ0vy8IR/NzVUU6Amit60/gLOOdV7bDak+UaRv02yR0fu/h92lkCf6R9wAHi0+5Tno=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oHqZOzl4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id F056DC433C7;
	Thu,  7 Mar 2024 14:30:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709821829;
	bh=A5XHbWQDmEQKfQ8MXuWsPcED1PZeiEmknAyPAY6s+SQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=oHqZOzl4vcUGExFJU+P7Q++iZGkrozSjUwOkg0EwuJjm3VVbzQJVptnQ4EY8Q6nLw
	 B+eRT77SlSBuShwp9AgN5lSTnX9d6YvlvCsqYBNh9fDCinyvbttKz1RPRcepSVPok8
	 FJLaUh++RtKg6lP02nc/1npixqa0RqpDp+J+bbH/065DRhoZ7JGw4IUz9uC7fat+Lq
	 GH6mivWPNHXr8c4wBR/bKvOF7gFiaSCMjsUVGDt6kocG1f3ewvXcmnUkJ7XEH+x4Lu
	 kJLXpxpKCMLB6sV8On25y7LOZM14gwGAn7Wmh7crFWBq5LckQHb2xrwCbaoF3DUpve
	 Ki9Ae8LHALgGQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id CDA7AC59A4C;
	Thu,  7 Mar 2024 14:30:28 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v3 0/2] doc: sfp-phylink: update the porting guide 
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170982182883.31331.10062654411732852553.git-patchwork-notify@kernel.org>
Date: Thu, 07 Mar 2024 14:30:28 +0000
References: <20240301164309.3643849-1-maxime.chevallier@bootlin.com>
In-Reply-To: <20240301164309.3643849-1-maxime.chevallier@bootlin.com>
To: Maxime Chevallier <maxime.chevallier@bootlin.com>
Cc: davem@davemloft.net, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 thomas.petazzoni@bootlin.com, andrew@lunn.ch, kuba@kernel.org,
 edumazet@google.com, pabeni@redhat.com, linux@armlinux.org.uk,
 f.fainelli@gmail.com, hkallweit1@gmail.com, corbet@lwn.net

Hello:

This series was applied to netdev/net-next.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Fri,  1 Mar 2024 17:43:06 +0100 you wrote:
> Hello everyone,
> 
> Here's a V3 for an update on the phylink porting guide. The only
> difference with V2 is a whitespace fix along with a line-wrap.
> 
> The main point of the update is the description of a basic process to
> follow to expose one or more PCS to phylink. Let me know if you spot any
> inaccuracies in the guide.
> 
> [...]

Here is the summary with links:
  - [net-next,v3,1/2] doc: sfp-phylink: update the porting guide with PCS handling
    https://git.kernel.org/netdev/net-next/c/9b1d8588397a
  - [net-next,v3,2/2] net: phylink: clean the pcs_get_state documentation
    https://git.kernel.org/netdev/net-next/c/68ac1e46425c

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



