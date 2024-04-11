Return-Path: <linux-kernel+bounces-140004-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C88478A0A37
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 09:41:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 65B6D1F21DDB
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 07:41:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41FB11422DC;
	Thu, 11 Apr 2024 07:40:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gFIkAYs2"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D1BC13E057;
	Thu, 11 Apr 2024 07:40:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712821229; cv=none; b=IfEPV9PfQwzzbn4ij8bjw4Y8VG+zEAQKSMRct23mSbzidd72nmUE21pYASrb9Zwm698ad/r7dPoe3Wg40utQAfCGv2RTBdoZ3tH+J9tT8ZL3WR19LTUH+6RKdTZs+JX7y990r623AiMy3gfrFGlLeztDQre4j3qqaU+dlVBsheo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712821229; c=relaxed/simple;
	bh=WN6WaVVKPVzN1O+fWKy4FYDq59aud5xZF7mOkpu11LI=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=FS55fDbyroHqR9bBzaGIX7973aRdYBqefgUxPIxD+fzAk8T2KUHqs3OrEnDF1vKe7TeJGYrCE+YhrZGQTR3T3oes0wI0vOItpLpiXur/wmhD35KaHTd+HT3ER5Ejh8SAvZ363/0ZFcXRHKT6Xz0KGIIN3xr9NnybS7GlGrPWJwY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gFIkAYs2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 2096BC43394;
	Thu, 11 Apr 2024 07:40:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712821229;
	bh=WN6WaVVKPVzN1O+fWKy4FYDq59aud5xZF7mOkpu11LI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=gFIkAYs2EkWX00Vj7c5JkqiwbPeTMCFZ6Z6iMTmRFtFyNNvl90bDkuH8Cgxtnmf37
	 dDlpoJeQG4kpVZQWhmKrDmlhFAJsUzk4CDzuIAmehrfSpSls5xXZHOj+KymRlB4BtM
	 Gm5/mFJRxCg+AYEtkhA2oKmBXI0Wr7IAshtnH2ykLVI05LePqGzmE6F5WJhFoOV0T9
	 CnuYEkvbUUfo9MLwLxRDwBbz+m+YTE7F/w6UAbh95RVlVzTffARNDXnneM/yvVOBJ9
	 V+WGg3IDpPGMS4Ne1w7te9BdiO+kNLyo4tGXf1a24VFXxcGln3ZV+UTbK5u0TRIhJM
	 mCebcBNdZ8XrA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 0C764C54BD0;
	Thu, 11 Apr 2024 07:40:29 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v2] net: dsa: mt7530: trap link-local frames regardless
 of ST Port State
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171282122904.27809.12270334252049024856.git-patchwork-notify@kernel.org>
Date: Thu, 11 Apr 2024 07:40:29 +0000
References: <20240409-b4-for-net-mt7530-fix-link-local-when-stp-discarding-v2-1-07b1150164ac@arinc9.com>
In-Reply-To: <20240409-b4-for-net-mt7530-fix-link-local-when-stp-discarding-v2-1-07b1150164ac@arinc9.com>
To: =?utf-8?b?QXLEsW7DpyDDnE5BTCB2aWEgQjQgUmVsYXkgPGRldm51bGwrYXJpbmMudW5hbC5h?=@codeaurora.org,
	=?utf-8?b?cmluYzkuY29tQGtlcm5lbC5vcmc+?=@codeaurora.org
Cc: daniel@makrotopia.org, dqfext@gmail.com, sean.wang@mediatek.com,
 andrew@lunn.ch, f.fainelli@gmail.com, olteanv@gmail.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 matthias.bgg@gmail.com, angelogioacchino.delregno@collabora.com,
 bartel.eerdekens@constell8.be, mithat.guner@xeront.com,
 erkin.bozoglu@xeront.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org, arinc.unal@arinc9.com

Hello:

This patch was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Tue, 09 Apr 2024 18:01:14 +0300 you wrote:
> From: Arınç ÜNAL <arinc.unal@arinc9.com>
> 
> In Clause 5 of IEEE Std 802-2014, two sublayers of the data link layer
> (DLL) of the Open Systems Interconnection basic reference model (OSI/RM)
> are described; the medium access control (MAC) and logical link control
> (LLC) sublayers. The MAC sublayer is the one facing the physical layer.
> 
> [...]

Here is the summary with links:
  - [net,v2] net: dsa: mt7530: trap link-local frames regardless of ST Port State
    https://git.kernel.org/netdev/net/c/17c560113231

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



