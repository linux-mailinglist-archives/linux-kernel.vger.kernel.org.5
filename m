Return-Path: <linux-kernel+bounces-39316-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C67B883CEA6
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 22:30:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EEB1E1C23210
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 21:30:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7185713AA47;
	Thu, 25 Jan 2024 21:30:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fEmX87PL"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACFBA13A248
	for <linux-kernel@vger.kernel.org>; Thu, 25 Jan 2024 21:30:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706218229; cv=none; b=VsKlJNjrp+Nxp886s8L/tSxk8UBNll7uxmFyd6+D03TBmcn/95uR8lnB2JpGEBRqxONuLBldMAEMQEa8vBe76OY3lvQ3TgFRJVdAc7SLozDmXrl5vMhbGuskg8N68I+SlJ1LjO8sjFKVKEZmqgD/TCHohw8XiszPmMO8xr8m+mo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706218229; c=relaxed/simple;
	bh=+MxR9NaWaOppxz1CebUGCA3UGwUCCpm+2/tjFMQvNwY=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=UBVWAd96GS0ytDsNg4NvzNgFW71m/LDoQBFUw96YF+FR4PSfYBul0URzJ1PIxwchOoWASngg1Q/8MMd1E3oTbgbQoEkf2HjqW+m90jjhnwB4HNX8dVmNtQAKYsELj+yfx7ljnsYbsGT4fGi3ecjm/9Wa3QvIzNslMfDI3xvHWPQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fEmX87PL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 4E8EDC43394;
	Thu, 25 Jan 2024 21:30:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706218229;
	bh=+MxR9NaWaOppxz1CebUGCA3UGwUCCpm+2/tjFMQvNwY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=fEmX87PLzrdwWTQWwpSjg37S+uSvU5viqmA3eY4LAPTBEKTn8Vy5Xm6i+fPIO1+Uh
	 698K8Ka5acpgEBwfIC7w2+8OWBKMWs1J2ck0ocGIMrQDiA73js8KC1HeezbpNt7q9W
	 u7gN1weUog8LWrOEfMzYUYWvJFT2tKV3WxwK9lYofwX9hCpwXpjzPaSXEKuYEsKbcm
	 zM5beLowdfluCqT2cPW34KIBG4e2OAih7VZarzFfBh/ZKt+NC0mKRGjxDUwGkKBgo4
	 AO4wsAGtx9tP1nuVXiK9Zo4lTwmSmUf/GcXZGrrcNd4H/t9sX9zd3qTOrOVC0TO9LS
	 dfyXIqSe5s+kg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 36D8ED8C966;
	Thu, 25 Jan 2024 21:30:29 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] riscv: blacklist assembly symbols for kprobe
From: patchwork-bot+linux-riscv@kernel.org
Message-Id: 
 <170621822922.6239.4505416696182414411.git-patchwork-notify@kernel.org>
Date: Thu, 25 Jan 2024 21:30:29 +0000
References: <20231004131009.409193-1-cleger@rivosinc.com>
In-Reply-To: <20231004131009.409193-1-cleger@rivosinc.com>
To: =?utf-8?b?Q2zDqW1lbnQgTMOpZ2VyIDxjbGVnZXJAcml2b3NpbmMuY29tPg==?=@codeaurora.org
Cc: linux-riscv@lists.infradead.org, paul.walmsley@sifive.com,
 palmer@dabbelt.com, aou@eecs.berkeley.edu, linux-kernel@vger.kernel.org

Hello:

This patch was applied to riscv/linux.git (for-next)
by Palmer Dabbelt <palmer@rivosinc.com>:

On Wed,  4 Oct 2023 15:10:09 +0200 you wrote:
> Adding kprobes on some assembly functions (mainly exception handling)
> will result in crashes (either recursive trap or panic). To avoid such
> errors, add ASM_NOKPROBE() macro which allow adding specific symbols
> into the __kprobe_blacklist section and use to blacklist the following
> symbols that showed to be problematic:
> - handle_exception()
> - ret_from_exception()
> - handle_kernel_stack_overflow()
> 
> [...]

Here is the summary with links:
  - riscv: blacklist assembly symbols for kprobe
    https://git.kernel.org/riscv/c/5014396af9bb

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



