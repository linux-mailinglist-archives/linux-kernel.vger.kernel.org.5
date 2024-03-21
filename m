Return-Path: <linux-kernel+bounces-109949-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0596B88581C
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 12:20:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AB1191F21503
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 11:20:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18EE45822A;
	Thu, 21 Mar 2024 11:20:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Rhwb3exD"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4644F57880;
	Thu, 21 Mar 2024 11:20:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711020028; cv=none; b=ow1nzuMEaWn/w46+p9sIG47E9HCPwPAer/BcYhZ4M1T0MC/PKwZroA8lWZjORUAc45yX7kfcxDBaxUQhjWAJTeb2c4b2gGynX5kE6A/2qawUWs2SMzJjf6ZT5f3rxFujH1Gy/3fI5tPhqMNDuBDdF+vBlAhBO083oh4YmAL6iss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711020028; c=relaxed/simple;
	bh=d1IRr9TtFAq/n2fJtDW0qRO01a2/SWstmEFZu1BOraE=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=lI70w8Yf7LYZL/QWbslPEvIkxYgx0qjPU5cCPbjIOIA9WKUmwO7sb2BXSBAR2imHVkKY5q4fBhBRY0S0Gzo3XV8AoL5QJROrtUFp5bmsrqEE3cpdF+9lX3Rcnki+6BHVZYrzZW5u4pTZsmZI7cdlyhEJf7o14bsGbgclDODLRFE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Rhwb3exD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id C12E2C43390;
	Thu, 21 Mar 2024 11:20:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711020027;
	bh=d1IRr9TtFAq/n2fJtDW0qRO01a2/SWstmEFZu1BOraE=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Rhwb3exDfDWmBO90fT1a0fkQLgef4yEAzzKgEAobppkvMshOCR2wZN3cqDBmrtaOx
	 7c4y5T0NGz9+bGnVBzRyiVvFZTYEJ5XCayNNjUFxciIKD1kZBUKKl8AOdewq+s4Kt/
	 nYMA5ak/WYGfjjy1lzoa3aAcMZLxeDJUV8Knw92odKp/9MyZgFQwcVosjYtNw/W3dk
	 hW+H1+Q/gCs6H9veYwlVtjGbTIqD0jBTWqFM9oo7I+33Ro6NOcUjZjPfahjSG67hcS
	 avWM+6RxAyjlgb/R3UALjpEPhlGgKUbvX/YY2o+PdDZLWOC/Hy5bMUOvcoccHYOVE+
	 uPya8JOMmBB4g==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id A62C9D982E3;
	Thu, 21 Mar 2024 11:20:27 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v2 0/2] MT7530 DSA subdriver fix VLAN egress and
 handling of all link-local frames
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171102002767.1229.13788293979924606218.git-patchwork-notify@kernel.org>
Date: Thu, 21 Mar 2024 11:20:27 +0000
References: <20240314-b4-for-net-mt7530-fix-link-local-vlan-v2-0-7dbcf6429ba0@arinc9.com>
In-Reply-To: <20240314-b4-for-net-mt7530-fix-link-local-vlan-v2-0-7dbcf6429ba0@arinc9.com>
To: =?utf-8?b?QXLEsW7DpyDDnE5BTCB2aWEgQjQgUmVsYXkgPGRldm51bGwrYXJpbmMudW5hbC5h?=@codeaurora.org,
	=?utf-8?b?cmluYzkuY29tQGtlcm5lbC5vcmc+?=@codeaurora.org
Cc: daniel@makrotopia.org, dqfext@gmail.com, sean.wang@mediatek.com,
 andrew@lunn.ch, f.fainelli@gmail.com, olteanv@gmail.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 matthias.bgg@gmail.com, angelogioacchino.delregno@collabora.com,
 frank-w@public-files.de, bartel.eerdekens@constell8.be,
 mithat.guner@xeront.com, erkin.bozoglu@xeront.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org, arinc.unal@arinc9.com

Hello:

This series was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Thu, 14 Mar 2024 12:33:40 +0300 you wrote:
> Hi.
> 
> This patch series fixes the VLAN tag egress procedure for link-local
> frames, and fixes handling of all link-local frames.
> 
> Signed-off-by: Arınç ÜNAL <arinc.unal@arinc9.com>
> 
> [...]

Here is the summary with links:
  - [net,v2,1/2] net: dsa: mt7530: fix link-local frames that ingress vlan filtering ports
    https://git.kernel.org/netdev/net/c/e8bf353577f3
  - [net,v2,2/2] net: dsa: mt7530: fix handling of all link-local frames
    https://git.kernel.org/netdev/net/c/69ddba9d170b

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



