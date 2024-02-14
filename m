Return-Path: <linux-kernel+bounces-65176-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BBB5B8548F0
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 13:10:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EE5B41C248FB
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 12:10:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48D3A1B962;
	Wed, 14 Feb 2024 12:10:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FyrMFbas"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 708D94436;
	Wed, 14 Feb 2024 12:10:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707912626; cv=none; b=iiYMDnbpkR5DeUsUBduHlejVKzCsSMfwoFs6fUo+huNWr0lgnHup11u38irC5QcCKgKY+ozoTyNz74b3H+CgA4+6cg7b553Not2yuW487o+38WniO/oTPqP0TpM8x5x7yCJ42LGO+bg/I38bpY8YpLgc/zGhb4jw9jbQe2OP+Og=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707912626; c=relaxed/simple;
	bh=x1g6GMNkLoMW1m0Fc0n7IJtC/rw991yy2r9DfS39pRQ=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=jWYfN5vPmkL6AITZvEl9rg0S0khMBpX48Zrvz9fZFzAJGOUYLMGWs9Oq1SbOHGwoBlu00tCnYXR+61GGV05usdLlQTfWhrAfrU5JNOw/bao4tk+UWnrsUVVeaGaopO9mlADvBVTJYQa+xE3TSPjNsmqc02Bc2lbnEAgSzYAXibk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FyrMFbas; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 6A0D7C433F1;
	Wed, 14 Feb 2024 12:10:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707912625;
	bh=x1g6GMNkLoMW1m0Fc0n7IJtC/rw991yy2r9DfS39pRQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=FyrMFbasaadIkbNrMUy9vE03K5vYZIFJmQbWGN/ptTjFv7K9HCTHXzZBXawzonz8S
	 Cv/g6bGaiMnf0fVZexvFbzuAiXhkdlrwDPFuOxcZPbBQSWzndY5OV+kTLW5llA4Y+q
	 q23zc3E9syZRXI79Tuyel5Iuayuw29+4z8k+UKhVgWPZFhLy3OzOel/kAQi1RmxCLm
	 3JHkGJXDsxbH6IYn5kgOWV3WzbsiEYskXvur066PmvyRp8FroeZUmfpECCSDvjGXfb
	 ESnxF72KUryMNRP5R3FNTyJC3n681zigVIV25s4ApnZtTAzGWB06XpORABq6TrJLFZ
	 gfjfNcv6LS4wg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 4D476D84BCD;
	Wed, 14 Feb 2024 12:10:25 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v5 1/2] dt-bindings: net: dp83826: support TX data voltage
 tuning
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170791262530.17764.12992441887115183588.git-patchwork-notify@kernel.org>
Date: Wed, 14 Feb 2024 12:10:25 +0000
References: <20240213080705.4184566-1-catalin.popescu@leica-geosystems.com>
In-Reply-To: <20240213080705.4184566-1-catalin.popescu@leica-geosystems.com>
To: Catalin Popescu <catalin.popescu@leica-geosystems.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
 afd@ti.com, andrew@lunn.ch, hkallweit1@gmail.com, linux@armlinux.org.uk,
 netdev@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, bsp-development.geo@leica-geosystems.com,
 m.felsch@pengutronix.de, krzysztof.kozlowski@linaro.org

Hello:

This series was applied to netdev/net-next.git (main)
by David S. Miller <davem@davemloft.net>:

On Tue, 13 Feb 2024 09:07:04 +0100 you wrote:
> Add properties ti,cfg-dac-minus-one-bp/ti,cfg-dac-plus-one-bp
> to support voltage tuning of logical levels -1/+1 of the MLT-3
> encoded TX data.
> 
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> Signed-off-by: Catalin Popescu <catalin.popescu@leica-geosystems.com>
> 
> [...]

Here is the summary with links:
  - [v5,1/2] dt-bindings: net: dp83826: support TX data voltage tuning
    https://git.kernel.org/netdev/net-next/c/ed1d7dac08c5
  - [v5,2/2] net: phy: dp83826: support TX data voltage tuning
    https://git.kernel.org/netdev/net-next/c/d1d77120bc28

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



