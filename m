Return-Path: <linux-kernel+bounces-128942-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 46EE289621D
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 03:41:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F3AE6284E6A
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 01:41:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2479B1BC58;
	Wed,  3 Apr 2024 01:40:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lE+6ZRD0"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46B3814F70;
	Wed,  3 Apr 2024 01:40:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712108435; cv=none; b=rNN7tVF/gdRFF88OYlDeVW9PhwSlFKZX5ooAgylkVKNW5CMj1ysKzYn+53ox6oCtvThRfi7Ed6DwUq8aZG5dKCCrFEc1GtA2YYs6JSqYadIHTPhlDH4OFCSbRBZZT1tvBGjgLdZzF+Dk0mSoE+kmmecYHoS8pHxvzUK7kmel6xY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712108435; c=relaxed/simple;
	bh=TtYpX5o1SaCeDSwJWpxTFrJL0tn5JioRilj/w9tPs0k=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=SLFDXSpQSva6frDH+GAOrlc29DkCTNKyiwNh20t1OCMq8DRr4cJ9OPhvbWHhYMI6viA5oJQApJkQ/+Nq3LyhSwp7mKAambiTWweg7M4P8+o7jb4GM+eLn/AUMDSfPUuDFPs1XbhGCUtuY8eK4HGNdksxhcu5rRvb+9RoAXSsFlc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lE+6ZRD0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id C8489C43394;
	Wed,  3 Apr 2024 01:40:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712108434;
	bh=TtYpX5o1SaCeDSwJWpxTFrJL0tn5JioRilj/w9tPs0k=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=lE+6ZRD0dWzfaeAvzxDV2/1WLyzDaNgfMguytYcWTSGpfSUrDCp8AaVhcWErYDnpc
	 m6LYqaLXUfXtfF18ozyS8YBpqb77WnXNR7lFFdpoMAwiRJT0SZm7d6rkpxyxanByUN
	 cel0mjsTVUNlpoiweQ5/xE+ufsZs9yl55/0xpyGt8JUlm1EBXHaY2yCXjjrwvdMg1M
	 XuPk61G/+Hoxes9JdAo7jhUEJ9i/e2RDXHB1LgrhIG8xEPh/3mZuchGJImzRpUqeYc
	 l633z0meLaVny82w2SRg9Ay2e4hetlvuhlNosQuseeV4g0S0Cj/S65GrYpemQpD0Gd
	 8+r0d6eYi4PdA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id B8B8FD8BD1B;
	Wed,  3 Apr 2024 01:40:34 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [net-next PATCH 1/2] net: dsa: microchip: drop driver owner
 assignment
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171210843475.14193.13174868089209942320.git-patchwork-notify@kernel.org>
Date: Wed, 03 Apr 2024 01:40:34 +0000
References: <20240330211023.100924-1-krzysztof.kozlowski@linaro.org>
In-Reply-To: <20240330211023.100924-1-krzysztof.kozlowski@linaro.org>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: woojung.huh@microchip.com, UNGLinuxDriver@microchip.com, andrew@lunn.ch,
 f.fainelli@gmail.com, olteanv@gmail.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Sat, 30 Mar 2024 22:10:22 +0100 you wrote:
> Core in spi_register_driver() already sets the .owner, so driver
> does not need to.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  drivers/net/dsa/microchip/ksz_spi.c | 1 -
>  1 file changed, 1 deletion(-)

Here is the summary with links:
  - [net-next,1/2] net: dsa: microchip: drop driver owner assignment
    https://git.kernel.org/netdev/net-next/c/a343eb0343e5
  - [net-next,2/2] net: dsa: sja1105: drop driver owner assignment
    https://git.kernel.org/netdev/net-next/c/ad6afdfc638a

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



