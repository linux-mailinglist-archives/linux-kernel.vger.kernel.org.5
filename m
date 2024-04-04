Return-Path: <linux-kernel+bounces-132051-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F09A6898F20
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 21:40:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 91EBD1F2AEB5
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 19:40:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AD9B13473D;
	Thu,  4 Apr 2024 19:40:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DXr/YNXM"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C16812D76B
	for <linux-kernel@vger.kernel.org>; Thu,  4 Apr 2024 19:40:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712259629; cv=none; b=mmSoYQk1/Mcjrr6I53EwOnRGhNwOkz/rw5Kt4HhiSujYXk9+R8Ti0BO4yrJqr6Y6yyHF7WLtHiHBrhG1P7mDJ4i8KIJxgxv6QaiCtyEakO/NBRZhu1mvZT01Oe1CBauiNHpHVTe4vHeXEfUHq4yWeGaSfW865GcI6YGotVy8kY0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712259629; c=relaxed/simple;
	bh=wL6xOxIQnHYILAX2319WBkm5eKkO5wAtkh1QB95emFc=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=IF7QKXhSLWiQS3at8jqsW1+lrbWlX+yrz7OmC5ctMW8YHS2yTrBHX71pHVcMqa+BhKE/RrDz5buU58bTrK+NyqiOuMQYMTrmw9M5/t9KQMQDb/UxHzMyAEGqdhxNYhI+fSqUd+HbD5wL+w7vqGNT03RSTQw0ZTE2PwYmIwQxV2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DXr/YNXM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 24DD2C43394;
	Thu,  4 Apr 2024 19:40:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712259629;
	bh=wL6xOxIQnHYILAX2319WBkm5eKkO5wAtkh1QB95emFc=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=DXr/YNXMVomqvEkbAo47XtTSMIApKsW/3HWYrSPJcPasdB1ktdOenA2XZ0/Evn4Og
	 NJ0DxbW0vPBeVO0R6hTKK6ssl6OgsdJWJoB6g5aF8JnPSupg+ZUWQsKVp0pUavFTWs
	 jk8VqYrbhHBERuhskZJkD8fkcFlGw2W2yxeT+mfME0ZONFNPNa9XP62ExLLyID2R9/
	 46aACig6oxnTuNrd7SXlQkrXxaXniD/p96uYIaVTl8lOMbjHryS0ERrMq8P8AGKqfM
	 AT4TbUYlo72oDTfJ0p42NQWu4GpH928HsPS3pDk6kefsdvG9as85pF25hVAKUctw9T
	 6ySi0Li0nsTqw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 1281DD84BAE;
	Thu,  4 Apr 2024 19:40:29 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] riscv: mm: implement pgprot_nx
From: patchwork-bot+linux-riscv@kernel.org
Message-Id: 
 <171225962907.17194.18344449254455951653.git-patchwork-notify@kernel.org>
Date: Thu, 04 Apr 2024 19:40:29 +0000
References: <20231121160637.3856-1-jszhang@kernel.org>
In-Reply-To: <20231121160637.3856-1-jszhang@kernel.org>
To: Jisheng Zhang <jszhang@kernel.org>
Cc: linux-riscv@lists.infradead.org, paul.walmsley@sifive.com,
 palmer@dabbelt.com, aou@eecs.berkeley.edu, linux-kernel@vger.kernel.org

Hello:

This patch was applied to riscv/linux.git (fixes)
by Palmer Dabbelt <palmer@rivosinc.com>:

On Wed, 22 Nov 2023 00:06:37 +0800 you wrote:
> commit cca98e9f8b5e ("mm: enforce that vmap can't map pages
> executable") enforces the W^X protection by not allowing remapping
> existing pages as executable. Add riscv bits so that riscv can benefit
> the same protection.
> 
> Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
> 
> [...]

Here is the summary with links:
  - riscv: mm: implement pgprot_nx
    https://git.kernel.org/riscv/c/0ffe1ae7026d

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



