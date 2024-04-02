Return-Path: <linux-kernel+bounces-127360-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DAFA8894A4C
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 06:10:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9DA9E286051
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 04:10:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB541179A8;
	Tue,  2 Apr 2024 04:10:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iZLi/Jis"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E90C315E96;
	Tue,  2 Apr 2024 04:10:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712031029; cv=none; b=crEknnn/UISmW6tyxBT4biKpk9m+o+z376Q0T7i5tygQ6HmXsGE51Xx9X/girIBnuvQ9zVsQAfPoshVFbVdMQceJsKUli3JjLCY6WXpPdaMIf0qzoMsgb0C3tH4Vk/aR7sXWhJL57Q9FbvcJSJE2otDH4ashP2Klkv4gaA+JfDY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712031029; c=relaxed/simple;
	bh=SBs90Y5ttoDDVvNSham9+zrWHG5GensFCQ441PcbOOw=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=mfdtZQuaPkmjI+WhIONbE48ObTY8eOmbq1C+6FX9kqa2T8Z7xgRicVT4yLEMlQT8K0TQgcLEm7cHxiaHXlT2xBmzFCi86AocJeSEzU++YLK/sjFQXSktMqpZnN9AvsPwtlEqLClSTJbj1/R+OHB20/knccwnVAV/YZsFA6f7htI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iZLi/Jis; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 652A4C433F1;
	Tue,  2 Apr 2024 04:10:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712031028;
	bh=SBs90Y5ttoDDVvNSham9+zrWHG5GensFCQ441PcbOOw=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=iZLi/Jis0uM+dXR7kvhNquGpUPnEILCB2aiy/A4O+gOyHATDQk1/xm2Bva5EdHM50
	 t9AcCQpA/8m1Fqiji0Z/Qw0gz+IFPcya4MDA7Qq4fOjgA9IT4zmGmUrz+6+Uh3xpqZ
	 r+471FAqVanIZZJHRpiHorxT+8OPZJbMiob6248x23Bz+zowkp9Yj6CUaBGzkxGEZO
	 VrvAN3JbXbvtrrXYu9Amw259sWz4A9h5KuOk5qPQakOggXFDo6rAwubO8v85JU19gY
	 MmFypySYM7xY+72K2gymZlp5VJwJaSO4Swm5F6KitePUXv4j2rCNI9fPUomGo3mabA
	 QBooaQTB7abKA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 55282D9A156;
	Tue,  2 Apr 2024 04:10:28 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH RESEND bpf v2 0/2] x86/bpf: Fixes for the BPF JIT with
 retbleed=stuff
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171203102833.24910.7566029980709800852.git-patchwork-notify@kernel.org>
Date: Tue, 02 Apr 2024 04:10:28 +0000
References: <20240401185821.224068-1-ubizjak@gmail.com>
In-Reply-To: <20240401185821.224068-1-ubizjak@gmail.com>
To: Uros Bizjak <ubizjak@gmail.com>
Cc: x86@kernel.org, bpf@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net

Hello:

This series was applied to bpf/bpf.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Mon,  1 Apr 2024 20:55:28 +0200 you wrote:
> From: Joan Bruguera Micó <joanbrugueram@gmail.com>
> 
> Fixes two issues that cause kernels panic when using the BPF JIT with
> the call depth tracking / stuffing mitigation for Skylake processors
> (`retbleed=stuff`). Both issues can be triggered by running simple
> BPF programs (e.g. running the test suite should trigger both).
> 
> [...]

Here is the summary with links:
  - [RESEND,bpf,v2,1/2] x86/bpf: Fix IP after emitting call depth accounting
    https://git.kernel.org/bpf/bpf/c/9d98aa088386
  - [RESEND,bpf,v2,2/2] x86/bpf: Fix IP for relocating call depth accounting
    https://git.kernel.org/bpf/bpf/c/6a537453000a

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



