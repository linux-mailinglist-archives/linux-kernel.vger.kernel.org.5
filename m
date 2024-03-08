Return-Path: <linux-kernel+bounces-97673-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C6E2876DAB
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Mar 2024 00:00:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DA2B6282F69
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 23:00:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F31D13BBCA;
	Fri,  8 Mar 2024 23:00:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="clS7HO8Q"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FF281DA52;
	Fri,  8 Mar 2024 23:00:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709938832; cv=none; b=deBS3RscFdQyp+nloHBA0McMx+6fgBAlBbS2EaRpSE0/SPK/AZQ8btxNroG7N1KyL+KuFh/YjFLipB+c5fGPN4SfvFviIEbDPMNgJ+nfxxSy0hqxpk8Bkeztcx5ENxa7gxGqL77+CqCKHB2Ubf6qoLrGdzlUER6H93z2L9kJVps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709938832; c=relaxed/simple;
	bh=hgauyfs0CuOwwpnTgH32w9+9nxlVw5ECI9wjU6LA1Bc=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=R3G+6xJThoUQLiNsYQiXp1k8I6J4Vkahd1ffMwZGPHL8dZNHlub1uRPRCUOCs3ctXiyuydy5QHOvdVx6roCB4lHLCIbD56nU6NJ/bX/WJpCdcBPBdErRLMYgpz789Rxzr7UI6OzoRrGvE3dNBK89UwPyJUsWm1AgjpOT4MA3ajg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=clS7HO8Q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 089B9C43390;
	Fri,  8 Mar 2024 23:00:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709938832;
	bh=hgauyfs0CuOwwpnTgH32w9+9nxlVw5ECI9wjU6LA1Bc=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=clS7HO8QJuegGS/mU0gJ222MnoXamq8PSidpDEPLycBMlYYNyGOhAoniT96KB4z0k
	 +bTdaFQ4KV4h0K2dnX2XhgcDBf+gkXlUspbZOgS4oW/Ta3UukAVfQI198R+whvcC+k
	 a2mINw/UwFEOdekVv/bUpDO2RpgmF4FvFY0q6+0q8+rcr4dH2KN3xgxJSfcxZ8tKH7
	 XVDXlJNyxnOQteDhzESy1Il4J7SZrcJNBwT3UKxYsi8IBZrB/0Q6kMrsad7w094tHy
	 EP8C5PGkpRx8M+Obl/iHctjex7ARTN80oBsWffdG3ToIlLmuFd9GdY6VoRopspVMt5
	 VGJDW+YdoNX/A==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id DB028C59A4C;
	Fri,  8 Mar 2024 23:00:31 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next] arm64,
 bpf: Use bpf_prog_pack for arm64 bpf trampoline
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170993883189.21366.2723021380774066449.git-patchwork-notify@kernel.org>
Date: Fri, 08 Mar 2024 23:00:31 +0000
References: <20240304202803.31400-1-puranjay12@gmail.com>
In-Reply-To: <20240304202803.31400-1-puranjay12@gmail.com>
To: Puranjay Mohan <puranjay12@gmail.com>
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 martin.lau@linux.dev, song@kernel.org, catalin.marinas@arm.com,
 mark.rutland@arm.com, bpf@vger.kernel.org, kpsingh@kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 xukuohai@huaweicloud.com

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Mon,  4 Mar 2024 20:28:03 +0000 you wrote:
> We used bpf_prog_pack to aggregate bpf programs into huge page to
> relieve the iTLB pressure on the system. This was merged for ARM64[1]
> We can apply it to bpf trampoline as well. This would increase the
> preformance of fentry and struct_ops programs.
> 
> [1] https://lore.kernel.org/bpf/20240228141824.119877-1-puranjay12@gmail.com/
> 
> [...]

Here is the summary with links:
  - [bpf-next] arm64, bpf: Use bpf_prog_pack for arm64 bpf trampoline
    https://git.kernel.org/bpf/bpf-next/c/d6f98243392f

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



