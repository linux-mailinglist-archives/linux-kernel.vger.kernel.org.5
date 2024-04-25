Return-Path: <linux-kernel+bounces-159346-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BC6B8B2D62
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 01:00:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 212F71F21CAE
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 23:00:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 112D815666A;
	Thu, 25 Apr 2024 23:00:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jjtB6vTq"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51F84155A57
	for <linux-kernel@vger.kernel.org>; Thu, 25 Apr 2024 23:00:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714086032; cv=none; b=tNOJCwndqPBN3RW9jOebJvhBuT88PN1wEYi57emYdKgX/4r85rhp/QRErUJxeXHMe2a9awjPH4z4XLOsberQ/UpfoEwjubSV39IQ1PjpkzSu/6Sqct9M3HGO2mYxB9KFD7GCUydx6FlQ6JSJY1sGieZJfSdEos7yZdUekBYhGtY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714086032; c=relaxed/simple;
	bh=BWCTdQoP4/3RTZr8W9fHb98CWImR4UwdaKkH2m5RqW8=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=NeM+j0RnsL5jLA2Elb2sokvX9T0QY+BmT2Bed+t9W1kd+SAo8WBxgWrludpi2nrLOc4i7yL17AjAvW0f3WjkfdQYikdKImGKEcTtDwwWBL6/YCdOwfG3MUQK0WPBYdsfpY35pfaDp8nrZYMgZrDCRNPl2Ud0dcfukbDaEXfSRlw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jjtB6vTq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id C9AB5C2BD10;
	Thu, 25 Apr 2024 23:00:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714086030;
	bh=BWCTdQoP4/3RTZr8W9fHb98CWImR4UwdaKkH2m5RqW8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=jjtB6vTqT3a9Zz29gTXjtQc9dFEWhS9QDTCNo677903vNbrF2txz30kOE/0m1jUyM
	 csIAlicgoFX4AgPKWzlQUiT3gU6e4/vFrvuJ7wqF/ytVAu8TpYzpGNYWZrAF1Aus4p
	 MoYhlYUhEwGAmH/ZbMUUm8lYcjYolFUwfwZEIqNiZpyW1KyHZfekIGBZN4qk3yJi1T
	 WKElBZI9BnSZ+PMCka+MbSyGcl/J22lFI6j8+D7qMiKpwr6chtsoHzAsb4BBXfYBzU
	 rtvVHBG4BFQus6/EgsiSTSGyOHB3tX2Xq0QlbTJC7tF7uiK7d9UDRw7LVdwyFTY0Nu
	 G2FaiXYezK2Xg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id B3BFEC43140;
	Thu, 25 Apr 2024 23:00:30 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v3 0/2] RISC-V: Test th.sxstatus.MAEE bit before enabling MAEE
From: patchwork-bot+linux-riscv@kernel.org
Message-Id: 
 <171408603073.8761.4519771274981632479.git-patchwork-notify@kernel.org>
Date: Thu, 25 Apr 2024 23:00:30 +0000
References: <20240407213236.2121592-1-christoph.muellner@vrull.eu>
In-Reply-To: <20240407213236.2121592-1-christoph.muellner@vrull.eu>
To: =?utf-8?q?Christoph_M=C3=BCllner_=3Cchristoph=2Emuellner=40vrull=2Eeu=3E?=@codeaurora.org
Cc: linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
 palmer@dabbelt.com, paul.walmsley@sifive.com, aou@eecs.berkeley.edu,
 philipp.tomsich@vrull.eu, bjorn@kernel.org, dbarboza@ventanamicro.com,
 heiko@sntech.de, cooper.qu@linux.alibaba.com, zhiwei_liu@linux.alibaba.com,
 eric.huang@linux.alibaba.com, alistair.francis@wdc.com,
 ajones@ventanamicro.com, conor@kernel.org, dqfext@gmail.com, alex@ghiti.fr,
 samuel.holland@sifive.com

Hello:

This series was applied to riscv/linux.git (fixes)
by Palmer Dabbelt <palmer@rivosinc.com>:

On Sun,  7 Apr 2024 23:32:34 +0200 you wrote:
> Currently, the Linux kernel suffers from a boot regression when running
> on the c906 QEMU emulation. Details have been reported here by Björn Töpel:
>   https://lists.gnu.org/archive/html/qemu-devel/2024-01/msg04766.html
> 
> The main issue is, that Linux enables XTheadMae for CPUs that have a T-Head
> mvendorid but QEMU maintainers don't want to emulate a CPU that uses
> reserved bits in PTEs. See also the following discussion for more
> context:
>   https://lists.gnu.org/archive/html/qemu-devel/2024-02/msg00775.html
> 
> [...]

Here is the summary with links:
  - [v3,1/2] riscv: thead: Rename T-Head PBMT to MAE
    https://git.kernel.org/riscv/c/6179d4a21300
  - [v3,2/2] riscv: T-Head: Test availability bit before enabling MAE errata
    https://git.kernel.org/riscv/c/65b71cc35cc6

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



