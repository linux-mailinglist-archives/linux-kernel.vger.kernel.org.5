Return-Path: <linux-kernel+bounces-109914-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E8D38857B7
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 12:00:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A2185B22C07
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 11:00:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 101AE57884;
	Thu, 21 Mar 2024 11:00:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ut7WX7Cx"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C74457311;
	Thu, 21 Mar 2024 11:00:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711018827; cv=none; b=QpAActWO2fXOsN9VdkokJSeEjAuzMGn2GdzbE7CVRRgZdiE/0QPpPgY0EliDopADnLCmdVNu7D2qUh/HVStyDhBLPok/I4lMpmYcJE4kuUn1yGj41+OzW5uC8/UhBIo7no2ido4tGV945xPHHWCUMGqjMrwlNbjRBDR2SrLgQpA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711018827; c=relaxed/simple;
	bh=JZ/uFKf0RYrnnxw9jJlX5wLrQamwRfdSTn6ZmoyBLug=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=oiKE2ea628i8Yf6Yre7GJFrEw3OSSfiR52/j9t2ypOf+K4FZ9cbBV31EdX3D6VBoIn4HN4TBbSSuPW9L+ABcMOHR65eT1seSovQ4mxNr8K44jquRpjw3rMnvvnTjJha0TrxFkbLFpEHF+T7CDzhwwdJZaoNZyOqSXfEHgblcRNI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ut7WX7Cx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id D58ACC433F1;
	Thu, 21 Mar 2024 11:00:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711018826;
	bh=JZ/uFKf0RYrnnxw9jJlX5wLrQamwRfdSTn6ZmoyBLug=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Ut7WX7CxUr7mAOvAi8yA1jqWL8pgL9mqvy6e6+Pd4AGyf9nqdcGO+9FYFn6BDEzFX
	 mJ/y8qj7sYpI7R6pYKFE34hE7CaVyufzNGty5bJK4Y44w3qPfwEDM3+NXKaAXMjsou
	 JQ6fUN3130aq6ZiiYQHenZOOeERvYhalEoWHlVAzLiV8DqzQyguOKN4iHcBHp/skVs
	 TQj/tD8EXUiYjLYcyYMuP07upJkT/PbauP1OoVzH0dCCie0tBvLbz+JIvFzSGXwVHN
	 p3ACx7X2nDmcdlDYwg9oWDNoJ2TD9W/Y4wtT77L6E1bMiXHyZPJPu7WaHLqUc6IiWT
	 v5FBEGf93o4KA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id C3726D84BA6;
	Thu, 21 Mar 2024 11:00:26 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v2] arm64: bpf: fix 32bit unconditional bswap
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171101882679.21551.11136604027550877391.git-patchwork-notify@kernel.org>
Date: Thu, 21 Mar 2024 11:00:26 +0000
References: <20240321081809.158803-1-asavkov@redhat.com>
In-Reply-To: <20240321081809.158803-1-asavkov@redhat.com>
To: Artem Savkov <asavkov@redhat.com>
Cc: xukuohai@huawei.com, xi.wang@gmail.com, ast@kernel.org,
 daniel@iogearbox.net, andrii@kernel.org, bpf@vger.kernel.org,
 netdev@vger.kernel.org, catalin.marinas@arm.com,
 linux-kernel@vger.kernel.org, puranjay12@gmail.com

Hello:

This patch was applied to bpf/bpf.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Thu, 21 Mar 2024 09:18:09 +0100 you wrote:
> In case when is64 == 1 in emit(A64_REV32(is64, dst, dst), ctx) the
> generated insn reverses byte order for both high and low 32-bit words,
> resuling in an incorrect swap as indicated by the jit test:
> 
> [ 9757.262607] test_bpf: #312 BSWAP 16: 0x0123456789abcdef -> 0xefcd jited:1 8 PASS
> [ 9757.264435] test_bpf: #313 BSWAP 32: 0x0123456789abcdef -> 0xefcdab89 jited:1 ret 1460850314 != -271733879 (0x5712ce8a != 0xefcdab89)FAIL (1 times)
> [ 9757.266260] test_bpf: #314 BSWAP 64: 0x0123456789abcdef -> 0x67452301 jited:1 8 PASS
> [ 9757.268000] test_bpf: #315 BSWAP 64: 0x0123456789abcdef >> 32 -> 0xefcdab89 jited:1 8 PASS
> [ 9757.269686] test_bpf: #316 BSWAP 16: 0xfedcba9876543210 -> 0x1032 jited:1 8 PASS
> [ 9757.271380] test_bpf: #317 BSWAP 32: 0xfedcba9876543210 -> 0x10325476 jited:1 ret -1460850316 != 271733878 (0xa8ed3174 != 0x10325476)FAIL (1 times)
> [ 9757.273022] test_bpf: #318 BSWAP 64: 0xfedcba9876543210 -> 0x98badcfe jited:1 7 PASS
> [ 9757.274721] test_bpf: #319 BSWAP 64: 0xfedcba9876543210 >> 32 -> 0x10325476 jited:1 9 PASS
> 
> [...]

Here is the summary with links:
  - [bpf-next,v2] arm64: bpf: fix 32bit unconditional bswap
    https://git.kernel.org/bpf/bpf/c/a51cd6bf8e10

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



