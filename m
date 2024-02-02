Return-Path: <linux-kernel+bounces-49633-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 65CEF846D42
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 11:02:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9FB54B2885C
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 10:00:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 530C077F3E;
	Fri,  2 Feb 2024 10:00:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oEgjRovb"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93B1D61682;
	Fri,  2 Feb 2024 10:00:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706868031; cv=none; b=ipUHQX3RAqqPWc+G7v+MN0YBFPRBhuv/7AZXV3AilLKidrqCcC4z4fPMxeetqgPNoyrCJrgO751AlXTcdRf+bqO2Lntb9PhjNI56T+zwJ1kmeG7aos0FHQdK9wBGlNGJv50zQpmSF9lshjrJhXnnpBcfpGlWMYw1XtnG+Y9l8d4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706868031; c=relaxed/simple;
	bh=REjEIQrnQERARGidm7gNYzGY6yUMPRZUpbx7KHkn8Jo=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=k1yu345EYtlBpcsFdk/auCGDqMVHRwd0FRUMikJCFflyK18yCoNlOWn7YkDuvmfNNaA/saOub9m0/SHFTtBn+Lepmzd9wkiNBpy5llwDuGoar3KSkLdyxdEpH4uAV+4h5QQTr0KDb3XWElB6kVeGmoj5YSaWac29xE0oWw1M9LI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oEgjRovb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 4A738C433F1;
	Fri,  2 Feb 2024 10:00:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706868030;
	bh=REjEIQrnQERARGidm7gNYzGY6yUMPRZUpbx7KHkn8Jo=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=oEgjRovbR2P8NSAlqdZ6bYr8Yq/WI2RmzrN3RC2XXakiaY6HdFrKK/OoNJkPHLKug
	 bDQathmKTYSuEQc3Jy0tyCsQZw0hfUP8rx18E0wbKRgMYi+POupmghy/o33MSbHHCX
	 VQsvBJKF7St19tA0OTA/wNEUFL0i5PfqHfkdCACXX6GEHuhEsLgnTEWFWT+bqkcfbf
	 xlZCTNiqiKN6yWjZ1wrR2eG46jM0cOT9Owa4Is9QisZ60t1T/6AGph+ApgmY2jKNfP
	 hj9JoKecy95QsViDRZftZEQksaptQYmVPha2uGdkBH1U9FukybWFfXTWU1k1euNnSC
	 SstKzcvVkO3Sw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 2C758D8C970;
	Fri,  2 Feb 2024 10:00:30 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v3] net: stmmac: xgmac: fix handling of DPP safety error
 for DMA channels
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170686803017.11061.18210179700306129756.git-patchwork-notify@kernel.org>
Date: Fri, 02 Feb 2024 10:00:30 +0000
References: <20240131020828.2007741-1-0x1207@gmail.com>
In-Reply-To: <20240131020828.2007741-1-0x1207@gmail.com>
To: Furong Xu <0x1207@gmail.com>
Cc: davem@davemloft.net, alexandre.torgue@foss.st.com, joabreu@synopsys.com,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 mcoquelin.stm32@gmail.com, jpinto@synopsys.com, horms@kernel.org,
 fancer.lancer@gmail.com, netdev@vger.kernel.org,
 linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 xfr@outlook.com, rock.xu@nio.com

Hello:

This patch was applied to netdev/net.git (main)
by David S. Miller <davem@davemloft.net>:

On Wed, 31 Jan 2024 10:08:28 +0800 you wrote:
> Commit 56e58d6c8a56 ("net: stmmac: Implement Safety Features in
> XGMAC core") checks and reports safety errors, but leaves the
> Data Path Parity Errors for each channel in DMA unhandled at all, lead to
> a storm of interrupt.
> Fix it by checking and clearing the DMA_DPP_Interrupt_Status register.
> 
> Fixes: 56e58d6c8a56 ("net: stmmac: Implement Safety Features in XGMAC core")
> Signed-off-by: Furong Xu <0x1207@gmail.com>
> 
> [...]

Here is the summary with links:
  - [net,v3] net: stmmac: xgmac: fix handling of DPP safety error for DMA channels
    https://git.kernel.org/netdev/net/c/46eba193d04f

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



