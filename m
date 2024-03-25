Return-Path: <linux-kernel+bounces-117455-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CFF1188AB9C
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 18:27:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0D5D91C28770
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 17:27:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 525AC131BA7;
	Mon, 25 Mar 2024 16:20:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iqP4grem"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E73B131723;
	Mon, 25 Mar 2024 16:20:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711383628; cv=none; b=Ru9HZ3lUMTZLQdWSKz3rPrOQgPs2MotfCOsgAH/sVADurOA2meVG1Wks4wGQFc4CcuP+AWrwDidhIDIbLbjEYL/e73BaBcQ/lu4yLVrIhTn6pckhSrQkCf1afY9hvqo79uyLrDegAhebiIq+tSRBV2m5sUJ8me4Zi52wVgz+LSA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711383628; c=relaxed/simple;
	bh=ltBtyPVxgqhzLh0IZKywxFfFfTKdkDs61NrhFpBQnzI=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=sOVnMIa0MkElDaVWCXFCJHfLdQyp2cdPtv+qTblMtq2UDe8avlfY4ujWbJsJeulgJCD6C1D2zfpkJ4ycYxthhDGrOZtJs6r0Cdfb5dAIYho2sMgHuibIWJF8G2TqH6gjhH2e8SfaQNUGFSAXIgLT1VNV0Wb6NMGNEHF6DhGlInM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iqP4grem; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 4F000C433C7;
	Mon, 25 Mar 2024 16:20:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711383628;
	bh=ltBtyPVxgqhzLh0IZKywxFfFfTKdkDs61NrhFpBQnzI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=iqP4gremXlRbe5bmkGC4/oKNuNm9wAt+mn2bxmG38EOsmc8limtkxpbV3YDclyDOV
	 W9gq6tHuBVx6PrJu10zGi86asC0FDK1+rbHTe4LFI18jpqyGGWJcKN6v5wR07oLloO
	 3+pJtM9peRuMajMAtnVC7bgcLcbalkBGe4x9G214UjaBpT7Zxn/VcPhNai2nQgjch7
	 vkobVdZ3bYPPgANIU7tPElIGZmswhirh5gRz5Zs2r3S5HG76Pmhfax16mwj3ZylnGS
	 92iwgKckRRscrvCO5w3vpAlOVDXSTe/OeEytUW+TtOpwHw3p4Oco08IYxn6AIMTjft
	 CdY7FbqITZ7NQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 316D1D2D0EA;
	Mon, 25 Mar 2024 16:20:28 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next] bpf: implement insn_is_cast_user() helper for JITs
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171138362819.15634.1745974998731724546.git-patchwork-notify@kernel.org>
Date: Mon, 25 Mar 2024 16:20:28 +0000
References: <20240324183226.29674-1-puranjay12@gmail.com>
In-Reply-To: <20240324183226.29674-1-puranjay12@gmail.com>
To: Puranjay Mohan <puranjay12@gmail.com>
Cc: davem@davemloft.net, dsahern@kernel.org, ast@kernel.org,
 daniel@iogearbox.net, andrii@kernel.org, martin.lau@linux.dev,
 eddyz87@gmail.com, song@kernel.org, yonghong.song@linux.dev,
 john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
 haoluo@google.com, jolsa@kernel.org, tglx@linutronix.de, mingo@redhat.com,
 bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
 netdev@vger.kernel.org, bpf@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Sun, 24 Mar 2024 18:32:26 +0000 you wrote:
> Implement a helper function to check if an instruction is
> addr_space_cast from as(0) to as(1). Use this helper in the x86 JIT.
> 
> Other JITs can use this helper when they add support for this instruction.
> 
> Signed-off-by: Puranjay Mohan <puranjay12@gmail.com>
> 
> [...]

Here is the summary with links:
  - [bpf-next] bpf: implement insn_is_cast_user() helper for JITs
    https://git.kernel.org/bpf/bpf-next/c/770546ae9f4c

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



