Return-Path: <linux-kernel+bounces-109414-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 302E78818C9
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 21:52:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DDEB9284F0C
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 20:51:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57F3B8665A;
	Wed, 20 Mar 2024 20:50:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dTGTYnPJ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C90B585951
	for <linux-kernel@vger.kernel.org>; Wed, 20 Mar 2024 20:50:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710967839; cv=none; b=texvncaiNjLIt7B6FhnEDvYUB47j9of1lROf49ydqlYUVPrxYs558PvedynCsPSXmYy3TDVN8yJycv4WQYTnY1iswqFIBsOhighwPdxGuSwcCePTAQn2AzG/yl4aSnyaGNJRhivPyWpYNzOvm/OIV75bWrqURxsvVSElNcv8QCc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710967839; c=relaxed/simple;
	bh=x9hRnCs/W82hA20jbvKpA85eC7xzuNtacPnbZFWHB60=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=kZCYb24MkHLIvAas1ExWT7dWsMoIx6Gi3056FC5beldYoVFMVBLway1ltLovVh5cO6GtmOUTX25Lw3kaJA34Yve/jUzoQSBkpak2wFYzMhBZR1PvSdSLOVsydXCg44H7aUsjeDysHeBt1tGqKnomqBIREcWGvhAYnWuEsExA5Fg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dTGTYnPJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 5DD8EC43143;
	Wed, 20 Mar 2024 20:50:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710967839;
	bh=x9hRnCs/W82hA20jbvKpA85eC7xzuNtacPnbZFWHB60=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=dTGTYnPJPH05yZ4VXqcyl1PlIy9mVMiD2INE2pLDgJaHDGwF96rAY/5jOgPRWJm5Q
	 GHv/mSMJvvXOtp7qR/bU4JKGxZyr/nuXQjm7MrwCivr5XaXyZ00h7V0QKI4qeSLmHS
	 kEq6xnFwj9elxNEuC2Mc5BQfb24/YdBQ77Fct6I1MIOOfLV/CbNo/KNzz6DDhkbLUp
	 daws6tG2D4XQOXdYaYJr11UemCG1HhCEJIcbuIHtM5VnIFDFn3zZplirxyzpyYxeT7
	 q7+xvTaiyzqC87vWO812w5PD6DbBrvmcVIZuEO4evH7UUyIf1drcUrXrS7PP5BFqIr
	 8KqFwLCyInmVA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 56D4AD95060;
	Wed, 20 Mar 2024 20:50:39 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH V2] riscv: vector: Fix a typo of preempt_v
From: patchwork-bot+linux-riscv@kernel.org
Message-Id: 
 <171096783935.6804.17753775200299684808.git-patchwork-notify@kernel.org>
Date: Wed, 20 Mar 2024 20:50:39 +0000
References: <20240221100252.3990445-1-songshuaishuai@tinylab.org>
In-Reply-To: <20240221100252.3990445-1-songshuaishuai@tinylab.org>
To: Song Shuai <songshuaishuai@tinylab.org>
Cc: linux-riscv@lists.infradead.org, paul.walmsley@sifive.com,
 palmer@dabbelt.com, aou@eecs.berkeley.edu, andy.chiu@sifive.com,
 ebiggers@google.com, vincent.chen@sifive.com, greentime.hu@sifive.com,
 linux-kernel@vger.kernel.org, andybnac@gmail.com

Hello:

This patch was applied to riscv/linux.git (for-next)
by Palmer Dabbelt <palmer@rivosinc.com>:

On Wed, 21 Feb 2024 18:02:52 +0800 you wrote:
> The term "preempt_v" represents the RISCV_PREEMPT_V field of riscv_v_flags
> and is used in lots of comments.
> 
> Here corrects the miss-spelling "prempt_v". And s/acheived/achieved/.
> 
> Reviewed-by: Andy Chiu <andybnac@gmail.com>
> Signed-off-by: Song Shuai <songshuaishuai@tinylab.org>
> 
> [...]

Here is the summary with links:
  - [V2] riscv: vector: Fix a typo of preempt_v
    https://git.kernel.org/riscv/c/700c2d9b1b17

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



