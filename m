Return-Path: <linux-kernel+bounces-147858-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 57F3A8A7AA0
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 04:40:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 141742836A0
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 02:40:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65075747F;
	Wed, 17 Apr 2024 02:40:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j2Y9A9uY"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9955F4685;
	Wed, 17 Apr 2024 02:40:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713321627; cv=none; b=BF5yn7yKo1ZubeGb4p3QRNsNQqWV5Aax1Y/wyJLltBWDZoGprQmV5sdHFqmHl8nF2nSFlzMI/5aMnc63cPcl7cRC22AkXbYSK3sD0tDnXnEOknHO1pX+aW1O7muZyLfZbF2bwv++8wFaI0gPjgzLU77XGo9B2uz9jThXeJu0NT4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713321627; c=relaxed/simple;
	bh=V99ZMHxoBTHytjMQdtrR3q5MRRZkyWWbMOm1NYQYc0I=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=pv7i4JgLwz89rG/wGxZswRPGuSgEfsGitaV/bl3Z9z4MuKBEo5Mf9q5If4ENLOiEGYZYMJK94izTtqxLzIcS4AsuhEXZMTOtQq/yTvTSYzWvSAvuSf82mIUBeiYCl9DEF1AdM28GYrFqdRCdZvm1kZonOwX4uCTmbNQk/+eLfAo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j2Y9A9uY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 183C9C3277B;
	Wed, 17 Apr 2024 02:40:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713321627;
	bh=V99ZMHxoBTHytjMQdtrR3q5MRRZkyWWbMOm1NYQYc0I=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=j2Y9A9uYUAmJdyWQQtnOwgfA++w7VjBu304Y5yKqRaGqu0NQruRhzkbSzpN7zV93j
	 BnsOeYvEuAtXQ3ikRVpx6Q99H1oqw2ogVOdWZxnZKTPI3qUJsWj7wxtwqbeRK+AXWQ
	 3JwZQRu3quwASWKDMYXyLlMrU1hbAPhyVJ8K6FDbuYJ+Xn1T8eCs4Ie/zlmBZD21JL
	 rqHhoSaJr2xZL19d4N3QyKkgAwZ4xQwBxrBYy9cIaUWqY9WQsd+8pVqwPG9CvNdqTy
	 Zlp94C8NVE0kzfu82DkURI8f36Ww8dpWHsKAN/gnfm/XTu1yfylywQEO81E0fDAwWu
	 UqQdVGWz1X+Og==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 07FD8D4F15F;
	Wed, 17 Apr 2024 02:40:27 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v8 01/17] MAINTAINERS: net: Add Oleksij to pse-pd
 maintainers
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171332162702.29795.17179061419076983944.git-patchwork-notify@kernel.org>
Date: Wed, 17 Apr 2024 02:40:27 +0000
References: <20240414-feature_poe-v8-1-e4bf1e860da5@bootlin.com>
In-Reply-To: <20240414-feature_poe-v8-1-e4bf1e860da5@bootlin.com>
To: Kory Maincent <kory.maincent@bootlin.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, corbet@lwn.net, mcgrof@kernel.org, russ.weight@linux.dev,
 gregkh@linuxfoundation.org, rafael@kernel.org, robh+dt@kernel.org,
 krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
 o.rempel@pengutronix.de, broonie@kernel.org, frowand.list@gmail.com,
 andrew@lunn.ch, hkallweit1@gmail.com, linux@armlinux.org.uk,
 thomas.petazzoni@bootlin.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
 devicetree@vger.kernel.org, dentproject@linuxfoundation.org,
 kernel@pengutronix.de, maxime.chevallier@bootlin.com

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Sun, 14 Apr 2024 16:21:50 +0200 you wrote:
> From: Kory Maincent (Dent Project) <kory.maincent@bootlin.com>
> 
> Oleksij was the first to add support for pse-pd net subsystem.
> Add himself to the maintainers seems logical.
> 
> Acked-by: Oleksij Rempel <o.rempel@pengutronix.de>
> Signed-off-by: Kory Maincent <kory.maincent@bootlin.com>
> Reviewed-by: Andrew Lunn <andrew@lunn.ch>
> 
> [...]

Here is the summary with links:
  - [net-next,v8,01/17] MAINTAINERS: net: Add Oleksij to pse-pd maintainers
    https://git.kernel.org/netdev/net-next/c/57f73805b99d
  - [net-next,v8,02/17] of: property: Add fw_devlink support for pse parent
    https://git.kernel.org/netdev/net-next/c/93c0d8c0ac30
  - [net-next,v8,03/17] net: pse-pd: Rectify and adapt the naming of admin_cotrol member of struct pse_control_config
    https://git.kernel.org/netdev/net-next/c/b010bf72da5a
  - [net-next,v8,04/17] ethtool: Expand Ethernet Power Equipment with c33 (PoE) alongside PoDL
    (no matching commit)
  - [net-next,v8,05/17] net: pse-pd: Introduce PSE types enumeration
    (no matching commit)
  - [net-next,v8,06/17] net: ethtool: pse-pd: Expand pse commands with the PSE PoE interface
    (no matching commit)
  - [net-next,v8,07/17] netlink: specs: Modify pse attribute prefix
    (no matching commit)
  - [net-next,v8,08/17] netlink: specs: Expand the pse netlink command with PoE interface
    (no matching commit)
  - [net-next,v8,09/17] MAINTAINERS: Add myself to pse networking maintainer
    (no matching commit)
  - [net-next,v8,10/17] net: pse-pd: Add support for PSE PIs
    (no matching commit)
  - [net-next,v8,11/17] dt-bindings: net: pse-pd: Add another way of describing several PSE PIs
    (no matching commit)
  - [net-next,v8,12/17] net: pse-pd: Add support for setup_pi_matrix callback
    (no matching commit)
  - [net-next,v8,13/17] net: pse-pd: Use regulator framework within PSE framework
    (no matching commit)
  - [net-next,v8,14/17] dt-bindings: net: pse-pd: Add bindings for PD692x0 PSE controller
    (no matching commit)
  - [net-next,v8,15/17] net: pse-pd: Add PD692x0 PSE controller driver
    (no matching commit)
  - [net-next,v8,16/17] dt-bindings: net: pse-pd: Add bindings for TPS23881 PSE controller
    (no matching commit)
  - [net-next,v8,17/17] net: pse-pd: Add TI TPS23881 PSE controller driver
    (no matching commit)

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



