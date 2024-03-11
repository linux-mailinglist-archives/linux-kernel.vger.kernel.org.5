Return-Path: <linux-kernel+bounces-99550-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EDB1D8789DD
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 22:10:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9B7281F21919
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 21:10:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD8F05731E;
	Mon, 11 Mar 2024 21:10:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ntk2KMgQ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22F2756B63;
	Mon, 11 Mar 2024 21:10:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710191432; cv=none; b=hW10LFUT4DpL94/KJzRK3PBcWMbtlMpGEjW35TpF4MQZx2e4vvwUILMjM2dfGWX+x+Q8b7mB5dSQXg/hQ9qTpJJE4nl+ZbYVwKrJm1+ndve4OEFVXgFjwjL8lpZj4ftQeLnX2Lvn6mDC3hq56zhmzNx42UjRDxYkMSZsAF/ngyY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710191432; c=relaxed/simple;
	bh=+o7mv1cjyYTsa9bpXsMjAc0mxBD9nIfC2qmi/mgGAnk=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=fQLea35LfY8OEM009p3MeJUb7fithRc/gVGPpGJmM2+mHZPXdZICOXv8HlGT6y8sDGOZEPixqFf/0A3nP2s0qW/cYSyYx2Itn5eaRPY2et/zgAGFBZFuYqVxy1sBjmoLExwdpkfGkKwJYmhOQIDyeI9oXuAKeDEmljP+f1wCZbM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ntk2KMgQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id B8C94C43390;
	Mon, 11 Mar 2024 21:10:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710191431;
	bh=+o7mv1cjyYTsa9bpXsMjAc0mxBD9nIfC2qmi/mgGAnk=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=ntk2KMgQSTVcYWlrhUHpgdMsE2qJ6qfWeFom25F0RQubqoGPry/0Ve30ujYOw4Aa3
	 5nXd4owp0m7Gyju/1ibdupJc48jC7rn3GAIcChJ5IKEJqw51iJar58nayZpUbYGzzH
	 YI+wN9e8x0xhm6kIDAKpjfB5t8kX840XuO1dSRusSZwc40N4UqG0AwoD8w2IMqudPU
	 TNSLEEJxRc7DHufxQAEKhVkTz/kamDjdm4NY6lkEINGRnuGRTH77K2ZnYatIsDyTKp
	 KdSYcEAxwOjYBtCbXcNi7ww6lQKvV+NkQquthjfxrC8V9xjnC2ieL8+vvihBkTRpVO
	 RCxnTivu8qfDw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 9C07CC395F1;
	Mon, 11 Mar 2024 21:10:31 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] net: dsa: mt7530: disable LEDs before reset
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171019143163.14853.15330891015381229970.git-patchwork-notify@kernel.org>
Date: Mon, 11 Mar 2024 21:10:31 +0000
References: <20240305043952.21590-1-justin.swartz@risingedge.co.za>
In-Reply-To: <20240305043952.21590-1-justin.swartz@risingedge.co.za>
To: Justin Swartz <justin.swartz@risingedge.co.za>
Cc: arinc.unal@arinc9.com, daniel@makrotopia.org, dqfext@gmail.com,
 sean.wang@mediatek.com, andrew@lunn.ch, f.fainelli@gmail.com,
 olteanv@gmail.com, davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, matthias.bgg@gmail.com,
 angelogioacchino.delregno@collabora.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue,  5 Mar 2024 06:39:51 +0200 you wrote:
> Disable LEDs just before resetting the MT7530 to avoid
> situations where the ESW_P4_LED_0 and ESW_P3_LED_0 pin
> states may cause an unintended external crystal frequency
> to be selected.
> 
> The HT_XTAL_FSEL (External Crystal Frequency Selection)
> field of HWTRAP (the Hardware Trap register) stores a
> 2-bit value that represents the state of the ESW_P4_LED_0
> and ESW_P4_LED_0 pins (seemingly) sampled just after the
> MT7530 has been reset, as:
> 
> [...]

Here is the summary with links:
  - net: dsa: mt7530: disable LEDs before reset
    https://git.kernel.org/netdev/net-next/c/2920dd92b980

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



