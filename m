Return-Path: <linux-kernel+bounces-87620-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C43486D699
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 23:10:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3D7611C2282D
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 22:10:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBC2974C01;
	Thu, 29 Feb 2024 22:10:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ma9GepHy"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2ECBF6D53A
	for <linux-kernel@vger.kernel.org>; Thu, 29 Feb 2024 22:10:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709244635; cv=none; b=jJuqkjZ5ir4i0WLjSGek8WYokxR2Sz4JClUu4QYBAenOf8ZSvBR+LLyXh/7Ggu7WKuNmqOqgRnlF5bgpZXHKn/y2ulKO7mgp1tfExzoLCvonJk/0FYgmIfU8oz2BP7iJtOScoF7pKxlqDrhHeoNpRDJIHbOrZRlLyjLH+1Yik8k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709244635; c=relaxed/simple;
	bh=3cFNJDOvNB4UfHtvAGBxHkMi/gySnAOSMqMm61Zsibk=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=iE+cFeeucEqAo5ALj+HJv4NXCmpKnGLBfu4+vNB0Jvgm2GEBCC+rrwt6hTXdUGEM2phmWBdT1844rttBQBv3N4m+wR5/27eqFCY4bspBr6RbG08O3WGc6U330Zt+V1ingKETAYys+6BgDfJBi1jR3Dwsl0p4/CCPwvBP9/xMxlA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ma9GepHy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id A405CC43390;
	Thu, 29 Feb 2024 22:10:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709244634;
	bh=3cFNJDOvNB4UfHtvAGBxHkMi/gySnAOSMqMm61Zsibk=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=ma9GepHyz2UlZW6t7USASudgBRjp1fOpyB6swY8MAPhLe17A27LnpG4kZ/l7NqwYq
	 XOJ+mT3wHYAMXLQqH8qk9n89fSeERJa39eqEg+/a72AETQsd6JEKXP89fbSOBp4V7w
	 OL4JrmHmYwuw/6Wd/kG53oIUYIwdLCg9DfaZ7fT7S1V8pqbl4g4wzcj95WTfgE0vhx
	 BgugBCObwBQO2j/thM1dQka/jh8hlqbJZcQpiGQNwXX/NfnngjbL/6kOywzujYAiIO
	 9cZ2+S0j4oZpaVdSQ+FuAgfimfHKmtb3ANIbYsU03A8c8TNdY/AMh9iUa9/sBcmuWX
	 AjlLcHi5b2CGg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 872DCC595D1;
	Thu, 29 Feb 2024 22:10:34 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH -fixes v4 0/3] riscv: cbo.zero fixes
From: patchwork-bot+linux-riscv@kernel.org
Message-Id: 
 <170924463455.14902.4462676677426238717.git-patchwork-notify@kernel.org>
Date: Thu, 29 Feb 2024 22:10:34 +0000
References: <20240228065559.3434837-1-samuel.holland@sifive.com>
In-Reply-To: <20240228065559.3434837-1-samuel.holland@sifive.com>
To: Samuel Holland <samuel.holland@sifive.com>
Cc: linux-riscv@lists.infradead.org, palmer@dabbelt.com,
 ajones@ventanamicro.com, linux-kernel@vger.kernel.org, conor@kernel.org,
 alex@ghiti.fr, sorear@fastmail.com

Hello:

This series was applied to riscv/linux.git (fixes)
by Palmer Dabbelt <palmer@rivosinc.com>:

On Tue, 27 Feb 2024 22:55:32 -0800 you wrote:
> This series fixes a couple of issues related to using the cbo.zero
> instruction in userspace. The first patch fixes a bug where the wrong
> enable bit gets set if the kernel is running in M-mode. The remaining
> patches fix a bug where the enable bit gets reset to its default value
> after a nonretentive idle state. I have hardware which reproduces this:
> 
> Before this series:
>   $ tools/testing/selftests/riscv/hwprobe/cbo
>   TAP version 13
>   1..3
>   ok 1 Zicboz block size
>   # Zicboz block size: 64
>   Illegal instruction
> 
> [...]

Here is the summary with links:
  - [-fixes,v4,1/3] riscv: Fix enabling cbo.zero when running in M-mode
    https://git.kernel.org/riscv/c/3fb3f7164edc
  - [-fixes,v4,2/3] riscv: Add a custom ISA extension for the [ms]envcfg CSR
    https://git.kernel.org/riscv/c/4774848fef60
  - [-fixes,v4,3/3] riscv: Save/restore envcfg CSR during CPU suspend
    https://git.kernel.org/riscv/c/05ab803d1ad8

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



