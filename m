Return-Path: <linux-kernel+bounces-35815-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D7B408396E7
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 18:51:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 90A7B2946F2
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 17:51:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0425781AA1;
	Tue, 23 Jan 2024 17:50:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U4uUotOR"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 431E7811F1
	for <linux-kernel@vger.kernel.org>; Tue, 23 Jan 2024 17:50:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706032230; cv=none; b=KLY21nlnnidFcF/YYxxWyzkF+oM+RucLYY3lhXYt2lWMoHBUBdTDt1NT0UEdAoRtAqZTqRZvKcrvD/cGe4dUvS3q663QJZO/TrbBSMEFs97d6kV/M/o36IV4MKEaECfIhpidDKp1bp4DpascLFwdDayULxvfHiCyrW0VurFyiA0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706032230; c=relaxed/simple;
	bh=awxAMzYU9HaDntJhzA+a1+0udHhkZHo7Vmb+bJNuLog=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=VYiAtnEckD04blHdAB/fS5n1KJ2Z0VCn8bHJZupsjUz6vXJ54seMymFboCSXa1BywhBgaBGEGCkyamLEhggQdN09xo46fmcHiCVAiIZghxILht+TXKvF+vTeZDtc/O5itb4lQTDa6yz9ItsMboffbxZWLgYlnJaj0LXeQXOQA8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U4uUotOR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 0B98EC433A6;
	Tue, 23 Jan 2024 17:50:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706032230;
	bh=awxAMzYU9HaDntJhzA+a1+0udHhkZHo7Vmb+bJNuLog=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=U4uUotORjnduHiJnhga9a9iSC5xexNraKM47i9W1TViRCenGXQS8oRUX8UCRh6rfu
	 YDW2oQBDn5cpyw5zPINkhy0C1lPJucdgs9c550n77DCcw3r52DD9IyfH/Xca5g0v/L
	 OkLkDoymMEcmVgxBuoqvRSRi6d+/a6EXQLl6RvKWzRW9nw6xToH/XeMMhq1dW89X37
	 MJKC2z0Jb1456T68ookjB95wDYtBBOKfuua69vH9xLiOfMncbdpERuXeIMZrqqWu9Q
	 2nu2froMu5VF7WV81pR8B8D5CRR/BOB1V0RESAs6N0proOmCD8JYCZqBu0j5VYMb92
	 82kr8pvY8Zh6A==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id E781FDFF764;
	Tue, 23 Jan 2024 17:50:29 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] clocksource: extend the max_delta_ns of timer-riscv and
 timer-clint to ULONG_MAX
From: patchwork-bot+linux-riscv@kernel.org
Message-Id: 
 <170603222994.30461.12710346561077104850.git-patchwork-notify@kernel.org>
Date: Tue, 23 Jan 2024 17:50:29 +0000
References: <20230905070945.404653-1-vincent.chen@sifive.com>
In-Reply-To: <20230905070945.404653-1-vincent.chen@sifive.com>
To: Vincent Chen <vincent.chen@sifive.com>
Cc: linux-riscv@lists.infradead.org, daniel.lezcano@linaro.org,
 tglx@linutronix.de, paul.walmsley@sifive.com, palmer@dabbelt.com,
 aou@eecs.berkeley.edu, linux-kernel@vger.kernel.org

Hello:

This patch was applied to riscv/linux.git (for-next)
by Palmer Dabbelt <palmer@rivosinc.com>:

On Tue,  5 Sep 2023 15:09:45 +0800 you wrote:
> When registering the riscv-timer or clint-timer as a clock_event device,
> the driver needs to specify the value of max_delta_ticks. This value
> directly influences the max_delta_ns, which represents the maximum time
> interval for configuring subsequent clock events. Currently, both
> riscv-timer and clint-timer are set with a max_delta_ticks value of
> 0x7fff_ffff. When the timer operates at a high frequency, this values
> limists the system to sleep only for a short time. For the 1GHz case,
> the sleep cannot exceed two seconds. To address this limitation, refer to
> other timer implementations to extend it to 2^(bit-width of the timer) - 1.
> Because the bit-width of $mtimecmp is 64bit, this value becomes ULONG_MAX
> (0xffff_ffff_ffff_ffff).
> 
> [...]

Here is the summary with links:
  - clocksource: extend the max_delta_ns of timer-riscv and timer-clint to ULONG_MAX
    https://git.kernel.org/riscv/c/d38e2e7bcb3e

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



