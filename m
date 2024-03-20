Return-Path: <linux-kernel+bounces-108470-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 617DD880AE8
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 07:00:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 87CB91C20CBF
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 06:00:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 601CC182CC;
	Wed, 20 Mar 2024 06:00:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E8UbNUox"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B7671B7F5;
	Wed, 20 Mar 2024 06:00:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710914429; cv=none; b=dVUEJdSGbofC+GQNm3OtpvjUP6C1JqtPjM5t57q9GfxGhKhNxxH9CGPs+vfoAdEy4KCagTi9cdq8kbx+bwlSZ+Yba8aB5e6QE/vmO26YU67MCrEgezK4nQKVxpvQvGO64ePfIyEjRAkj1cQZWOUHyUg2n1TuauW4c02pRjtKgeA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710914429; c=relaxed/simple;
	bh=F+JD5BzN3CMt5iCweClrZTt7h+6Pfrn3HmIL6h5t0Wk=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=StCxjdL0yYnXOnMDtV/inxD0pamAjbKoFUYjQRti/qdbA5De1qRUz+1YHBq131d5dxUEcFQJhzj8dk/fPxpv4DeE8m7jmoBCBphYNv3RSL9+JFKzqV0wzXqfGlNaI/VF10ln75EACFaYPJPAbf0W/jDFsurybHW1OI0chzZhw2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E8UbNUox; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 0F868C43394;
	Wed, 20 Mar 2024 06:00:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710914429;
	bh=F+JD5BzN3CMt5iCweClrZTt7h+6Pfrn3HmIL6h5t0Wk=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=E8UbNUoxjBS40Za7tg92n197VGdLQ+f4LOl9fMFPoNZ9aoZiuhaWZq88UEB640mla
	 tKyOHjp41qNzFqHglDDCHl4eVDR7U5GBwpYxRZL9S2EkPR/E2XdP7l+V8QWMU0FPSy
	 cC5GujjtT0yL9oyXl2dnb+Jc55nrAlYgntZ8GWZ8SJiyaCplYE2P/TjzEMlw+5JPIV
	 ixA1Yc34Xn9NbJSoZRLGhmfbEf1kbvAxUaSXvOT1dXDPxnl4Ev/Rs2tuvzaHTtz+KW
	 hhsZy9hz4KZNjH6LtuMR5tyVnCsgYpPnDfYmpVGyQBO0WjFu+AimcsMLOhLnFYPFbl
	 skYbmd5Kn/p9Q==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id EBB53D84BB1;
	Wed, 20 Mar 2024 06:00:28 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf] bpf, arm64: fix bug in BPF_LDX_MEMSX
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171091442896.8613.6941801093368305972.git-patchwork-notify@kernel.org>
Date: Wed, 20 Mar 2024 06:00:28 +0000
References: <20240312235917.103626-1-puranjay12@gmail.com>
In-Reply-To: <20240312235917.103626-1-puranjay12@gmail.com>
To: Puranjay Mohan <puranjay12@gmail.com>
Cc: ast@kernel.org, daniel@iogearbox.net, john.fastabend@gmail.com,
 andrii@kernel.org, martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org,
 yonghong.song@linux.dev, kpsingh@kernel.org, sdf@google.com,
 haoluo@google.com, jolsa@kernel.org, bpf@vger.kernel.org,
 linux-kernel@vger.kernel.org

Hello:

This patch was applied to bpf/bpf.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Tue, 12 Mar 2024 23:59:17 +0000 you wrote:
> A64_LDRSW() takes three registers: Xt, Xn, Xm as arguments and it loads
> and sign extends the value at address Xn + Xm into register Xt.
> 
> Currently, the offset is being directly used in place of the tmp
> register which has the offset already loaded by the last emitted
> instruction.
> 
> [...]

Here is the summary with links:
  - [bpf] bpf, arm64: fix bug in BPF_LDX_MEMSX
    https://git.kernel.org/bpf/bpf/c/114b5b3b4bde

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



