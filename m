Return-Path: <linux-kernel+bounces-112202-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F36808876E5
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Mar 2024 04:30:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 86CD9282730
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Mar 2024 03:30:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E218440C;
	Sat, 23 Mar 2024 03:30:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uUqIvMdB"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBFA7372;
	Sat, 23 Mar 2024 03:30:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711164627; cv=none; b=pgKl7hOHsdkvoY6xbfIMXLEZDum7Nbbcx5ODUGxN3WD1wwMDFsoSh4NvtyaRiEI1U9vO3K0bi1D5c4fK192Z1H2Nm65altd2FxiHx4MznphPJ6Pl+F8YcYhygnrzqj996RfvpJdMoDULVcdTSGtVnBMEGAARfyNRjMljbHC5nKc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711164627; c=relaxed/simple;
	bh=+tGRBpJ9JnSVUiVKm52veEsP2Jzvsh+vYHAwZIZia/o=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=lPitpt+tVv11a7cmx1cHpp6EUOogLFZI/86Vk5ol11gyYnU2VRa4mm6X0gHrcT59UVptBbQYa4F5N2jUMOf1h57gKdLrrAIXmnEd2MgT8xrSRrt/yy9kzRwxf5of8T74fhqmKHoRGJUf9d6QRkIi4Rbp/oO1VE1Xx4EXd987+Ps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uUqIvMdB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 268C6C43390;
	Sat, 23 Mar 2024 03:30:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711164627;
	bh=+tGRBpJ9JnSVUiVKm52veEsP2Jzvsh+vYHAwZIZia/o=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=uUqIvMdB8deXAEMqq8YkQWpfVhM5Cgb4sgst2WIM3tqcdaDAbccbDaQ8XNLjdaKbh
	 KcQBLi92WFTmDpDIjn1zrMcD3T92olNIEDrThZTEsb6Ba/fciLgLdbgZXBMw06+wgN
	 PMZIif7RFIA/Ar5K8pBcXgfJdbzL4wD1dNPEJvtZuzMN17fO6r2HhnxZ37DqDl8rgj
	 LJ0p9qMW0wVKVlLrEj61tMF9QFKY+6t4nY2t3i0t+17bMD/8oFTaMcXOZgSyGKq1Rm
	 XIv4kyAv5pQ7MGnGFk2EYedRbRfxMJPl4zBgaxhccwquLgWWfhOJz/FckVOuN+B66q
	 IpV9PQMaEjIDg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 141F5D8BCE7;
	Sat, 23 Mar 2024 03:30:27 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [RESEND PATCH bpf] bpf: verifier: fix addr_space_cast from as(1) to
 as(0)
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171116462707.20726.11825470378202448490.git-patchwork-notify@kernel.org>
Date: Sat, 23 Mar 2024 03:30:27 +0000
References: <20240321153939.113996-1-puranjay12@gmail.com>
In-Reply-To: <20240321153939.113996-1-puranjay12@gmail.com>
To: Puranjay Mohan <puranjay12@gmail.com>
Cc: ast@kernel.org, daniel@iogearbox.net, john.fastabend@gmail.com,
 andrii@kernel.org, martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org,
 yonghong.song@linux.dev, kpsingh@kernel.org, sdf@google.com,
 haoluo@google.com, jolsa@kernel.org, bpf@vger.kernel.org,
 linux-kernel@vger.kernel.org

Hello:

This patch was applied to bpf/bpf.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Thu, 21 Mar 2024 15:39:39 +0000 you wrote:
> The verifier currently converts addr_space_cast from as(1) to as(0) that
> is: BPF_ALU64 | BPF_MOV | BPF_X with off=1 and imm=1
> to
> BPF_ALU | BPF_MOV | BPF_X with imm=1 (32-bit mov)
> 
> Because of this imm=1, the JITs that have bpf_jit_needs_zext() == true,
> interpret the converted instruction as BPF_ZEXT_REG(DST) which is a
> special form of mov32, used for doing explicit zero extension on dst.
> These JITs will just zero extend the dst reg and will not move the src to
> dst before the zext.
> 
> [...]

Here is the summary with links:
  - [RESEND,bpf] bpf: verifier: fix addr_space_cast from as(1) to as(0)
    https://git.kernel.org/bpf/bpf/c/c49cdf5b88aa

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



