Return-Path: <linux-kernel+bounces-31911-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F5C783364A
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Jan 2024 22:12:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BD0E3B227A7
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Jan 2024 21:12:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2944C28365;
	Sat, 20 Jan 2024 21:10:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nZrt/GFW"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5107D17754
	for <linux-kernel@vger.kernel.org>; Sat, 20 Jan 2024 21:09:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705784999; cv=none; b=JOuXFOBzMZ7aUZ/MrV1LZ5AFb6WpEaQ2wn2ViMFWx/6FhyEzlLUCQKAuy/xbeuemIK6mLrLHyChE0M23C55dTK83DnqFAXZK2cqM5nP5KY9I+secMTcCCW/G3imrKBdaA43rFUbYIi6MBhGzdIL9Q9Q3DIbBPejWm4zcUTtS5fo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705784999; c=relaxed/simple;
	bh=7lzodkQb8V/3EVEvAvA4s28Kz+AbZj+UdtAJn77t/Vg=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=q4Az+MJP9d3akHLLHxpB+Ak355YYRD76/iukzMd9TyaIf06L902Ecjoah6dRsqDtKW4HlAm/70CBt1Ip58xp8mwugsSCKrPXogqjjH+bTeYOot1n5VUXSG93uAWksj4wgcwGO6ZWod/evu5jeGk408WUQ8GdfKBEUJIMAeTeH6c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nZrt/GFW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 264E9C43394;
	Sat, 20 Jan 2024 21:09:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705784999;
	bh=7lzodkQb8V/3EVEvAvA4s28Kz+AbZj+UdtAJn77t/Vg=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=nZrt/GFWs3IMUIg3JBeJKGApAgDTlt+hiUwtQRLs9+pGxoO6AMWtoBgmNsEkh2gMj
	 1FRkkhROw8yblMXe2afOfh3qgFfVirAy92IPiRHfj5FbRUaKt+fGRQfwJOdeIb0FXm
	 lzZXmGqYluHp0RCxJ1fiywjPX5lNtGDQY0oUeyZBf7FpSloPwQbtol4HmzHMMqi/B2
	 nnfxdwM0oahirxSJxVOpDcCYXW7ZqU1tQPxTj2Yur4kVIeE72QV9yLCjsPhbjzxjcN
	 tYljKDRMKUC3FmQIknC+cT2nmDC/GXOClqc1t99PAWfdDqdSo7x17A1ALbn8TL73KK
	 1Xl9a6x7VkaqA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 130CED8C978;
	Sat, 20 Jan 2024 21:09:59 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [GIT PULL] RISC-V Patches for the 6.8 Merge Window, Part 4
From: patchwork-bot+linux-riscv@kernel.org
Message-Id: 
 <170578499907.24348.2424712213063362005.git-patchwork-notify@kernel.org>
Date: Sat, 20 Jan 2024 21:09:59 +0000
References: <mhng-878cc879-7aa0-473f-91e4-8288072cdd4e@palmer-ri-x1c9>
In-Reply-To: <mhng-878cc879-7aa0-473f-91e4-8288072cdd4e@palmer-ri-x1c9>
To: Palmer Dabbelt <palmer@rivosinc.com>
Cc: linux-riscv@lists.infradead.org, torvalds@linux-foundation.org,
 linux-kernel@vger.kernel.org

Hello:

This pull request was applied to riscv/linux.git (fixes)
by Linus Torvalds <torvalds@linux-foundation.org>:

On Sat, 20 Jan 2024 10:17:18 -0800 (PST) you wrote:
> The following changes since commit cb51bfee7f62a8e26b694f9d84c0041b3e3ccc71:
> 
>   Merge patch series "riscv: hwprobe: add Zicond, Zacas and Ztso support" (2024-01-09 20:14:51 -0800)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/riscv/linux.git tags/riscv-for-linus-6.8-mw4
> 
> [...]

Here is the summary with links:
  - [GIT,PULL] RISC-V Patches for the 6.8 Merge Window, Part 4
    https://git.kernel.org/riscv/c/e5075d8ec564

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



