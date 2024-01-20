Return-Path: <linux-kernel+bounces-31916-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 87C8A833650
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Jan 2024 22:13:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 41A6B282BF2
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Jan 2024 21:13:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF2A328E3A;
	Sat, 20 Jan 2024 21:10:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a2Ni8Gaj"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91FC3208D8;
	Sat, 20 Jan 2024 21:09:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705784999; cv=none; b=TiwMzbrfwRNwy4VKcqWv9BQU7/0sFJRZpRWmLI8kF1yppY76PDlr0kpZ46xnuu3gBwk0fsV8rROP5jsGHcExYkNZddHQXf4Cdm1jijhKQ01oF5mmEYKTgOgvGqx2CL4TcM59G+tg+hrnUYweke7YYlH+OSTGFBO6wn+HxeT0iRo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705784999; c=relaxed/simple;
	bh=tBihYQAUnauvx11/kprMMa7zEBfkVJTlWEglY1n6W24=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=aPuLSJoVSnwRLeFKY5IKb9/pJDRizaE6VoACOLCgZTUQAo8x+gb+X+4LgcEzInAyeEIuLsA9afT8GfCqX+7omxM28Hc5u8oCewiU8fZAPy2QZnR6HEyXeknIiAqS0WBJVS3IEue9BMYfBk/LplKYiBgF5K1aBEBwk847ZSJuVy0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a2Ni8Gaj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 2FC8EC43330;
	Sat, 20 Jan 2024 21:09:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705784999;
	bh=tBihYQAUnauvx11/kprMMa7zEBfkVJTlWEglY1n6W24=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=a2Ni8GajTJBMZhYjI/P1Gb1obqmTNY8oiBOjL/gc25l6/9JWBrkswOROVMAiU1ELz
	 qMgDyFGlwBMTunLLCthgMEtCKVoR3zibtD3dHXuju5NA6ma4S7gbUYR7G0ZzLD7CJi
	 nfczKrWkZQjn02b6dktq9bpOT5E6ocX0e7GkcCcEINEFxRt4JXQSA5IOKK6RZ7GI60
	 WQtdy4odT7xT7xR2ZXy+cVn56WP/+OEngZsL+z4IkAczCPpo9UI9m3Z2JJg2hUea4m
	 4kFAYe7Q/+R4+DJ3hZYXYP0II7ukaGha1aHmaJsC7PXBkphki9YjNdSyCFLy0jM1eh
	 GLB2fWOAO3ldA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 1F34CD8C985;
	Sat, 20 Jan 2024 21:09:59 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] riscv: Fix build error on rv32 + XIP
From: patchwork-bot+linux-riscv@kernel.org
Message-Id: 
 <170578499912.24348.17976593950031551472.git-patchwork-notify@kernel.org>
Date: Sat, 20 Jan 2024 21:09:59 +0000
References: <20240118212120.2087803-1-alexghiti@rivosinc.com>
In-Reply-To: <20240118212120.2087803-1-alexghiti@rivosinc.com>
To: Alexandre Ghiti <alexghiti@rivosinc.com>
Cc: linux-riscv@lists.infradead.org, rdunlap@infradead.org,
 sfr@canb.auug.org.au, linux-next@vger.kernel.org, paul.walmsley@sifive.com,
 palmer@dabbelt.com, aou@eecs.berkeley.edu, haxel@fzi.de,
 linux-kernel@vger.kernel.org

Hello:

This patch was applied to riscv/linux.git (fixes)
by Palmer Dabbelt <palmer@rivosinc.com>:

On Thu, 18 Jan 2024 22:21:20 +0100 you wrote:
> commit 66f1e6809397 ("riscv: Make XIP bootable again") restricted page
> offset to the sv39 page offset instead of the default sv57, which makes
> sense since probably the platforms that target XIP kernels do not
> support anything else than sv39 and we do not try to find out the
> largest address space supported on XIP kernels (ie set_satp_mode()).
> 
> But PAGE_OFFSET_L3 is not defined for rv32, so fix the build error by
> restoring the previous behaviour which picks CONFIG_PAGE_OFFSET for rv32.
> 
> [...]

Here is the summary with links:
  - riscv: Fix build error on rv32 + XIP
    https://git.kernel.org/riscv/c/66f962d8939f

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



