Return-Path: <linux-kernel+bounces-130058-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 52F6A8973A2
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 17:13:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 071B01F2A022
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 15:13:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6969714A0A4;
	Wed,  3 Apr 2024 15:10:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pD93qTpP"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F978148FE8;
	Wed,  3 Apr 2024 15:10:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712157034; cv=none; b=ZkFPM3GbS2aEDUMZVgwDNc5I21yIwgNo988z7iAQPv7ZFA+gm6JFbdBRrpb5b3KxNf7DWMAwY3RyQxKTa0dgqltW5riYKfm76BpFuifMK2psdTidmqt4H2gBPSdoCuhl2qvcyTL+F48KzwQksCe70JlL2brqpH6YcXiJ2PqE78w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712157034; c=relaxed/simple;
	bh=WDB90lsQ+FtQ63dHj01GVdGl3xWCx02Ocehnjixv9AA=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=de1NovAzNHHh+nof5ZD2L3kqcyoiyy065gCxdRedaRoWL4sqyJnENdgvft21zFgAaOHkuSKWibgaJkGAK7gzTJNgPp4dGiI5b2JA6f3iB6/clYvopmF9YEpmJb4ZkoJ+kdCEVEV8DDed4Vz/aDaL1zv+AIEDwAM1UJWkMpnV6+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pD93qTpP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 12AF2C433C7;
	Wed,  3 Apr 2024 15:10:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712157034;
	bh=WDB90lsQ+FtQ63dHj01GVdGl3xWCx02Ocehnjixv9AA=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=pD93qTpPUFNy00aVlUnbMvuHXfReOxlI98BoBE9BjAN4I48nW0+0E/p8ZDsj4JnGG
	 JQG9ZlIolRP8t9gXDc203LtOYFyvyvoxacwNSsSgLdd3R0bAWJBVu/DyNMsuuTzxZ0
	 71Pm6Fas6QRk+QFm88NSUEHyEeCBXq6L4L64M1R3lCU3F5EXKWMqRgxM9ps2LpQpYy
	 4xjJ06fRf6WJnC5qKzoF7/AVIO+pxCiwe9BGNK/OpPp0xuNR+g31pPluftUcvwXAHQ
	 HIDhbWtnfoSLy80j2fzF4HSi8aXndkWsL5AYLs4TEI/Mmtjwcq2rHjpRQxsqFoJPQA
	 bj610jIsnrxtw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 06CA8D84BB3;
	Wed,  3 Apr 2024 15:10:34 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] bpf: replace deprecated strncpy with strscpy
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171215703402.3781.6443239149248197570.git-patchwork-notify@kernel.org>
Date: Wed, 03 Apr 2024 15:10:34 +0000
References: <20240402-strncpy-kernel-bpf-core-c-v1-1-7cb07a426e78@google.com>
In-Reply-To: <20240402-strncpy-kernel-bpf-core-c-v1-1-7cb07a426e78@google.com>
To: Justin Stitt <justinstitt@google.com>
Cc: ast@kernel.org, daniel@iogearbox.net, john.fastabend@gmail.com,
 andrii@kernel.org, martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org,
 yonghong.song@linux.dev, kpsingh@kernel.org, sdf@google.com,
 haoluo@google.com, jolsa@kernel.org, nathan@kernel.org,
 ndesaulniers@google.com, morbo@google.com, bpf@vger.kernel.org,
 linux-kernel@vger.kernel.org, llvm@lists.linux.dev,
 linux-hardening@vger.kernel.org

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Daniel Borkmann <daniel@iogearbox.net>:

On Tue, 02 Apr 2024 23:52:50 +0000 you wrote:
> strncpy() is deprecated for use on NUL-terminated destination strings
> [1] and as such we should prefer more robust and less ambiguous string
> interfaces.
> 
> bpf sym names get looked up and compared/cleaned with various string
> apis. This suggests they need to be NUL-terminated (strncpy() suggests
> this but does not guarantee it).
> 
> [...]

Here is the summary with links:
  - bpf: replace deprecated strncpy with strscpy
    https://git.kernel.org/bpf/bpf-next/c/2e114248e086

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



