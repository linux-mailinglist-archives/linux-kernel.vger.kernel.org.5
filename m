Return-Path: <linux-kernel+bounces-161589-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 37F398B4E61
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 00:00:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C8F9B1F21112
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Apr 2024 22:00:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0901D10976;
	Sun, 28 Apr 2024 22:00:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kELx0uKi"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37690B664;
	Sun, 28 Apr 2024 22:00:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714341635; cv=none; b=JM0w0+gMMnhgZg5DCS9bGspk18d9cxlqr2EPO4CRh5nFOm49P9q4AiOhrAoGAwPn6j6TCo06G0u/JKfotc3DUO/OHt6+G2sfGW1xvJF8d81Bl0+N7CEx/HIbClH3RMrKTj8fI6VWwUz7Dsc7FFsepFe9yFTitZzrLCoyzxTzkW4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714341635; c=relaxed/simple;
	bh=dcRqllzvCViq7JroGLfFRXWzRjL6MWy0dXcchL9hte8=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=N9n6AdgxOhqIZZpAfdpCztB+DGGV7Ctap/8/A98x1VFOoEyYnyPtJ9tWycM/lSbK28W8w4fO9o4vhBoTGXw/cvY9QUKnTMdugU3qbaRSTV8bOjypcC0dCcNrB3H2tDKuQHkE/FmPmsgOEb8oxYPRX9JH0EoDa603a99I3qvKf0U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kELx0uKi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id C455FC4AF18;
	Sun, 28 Apr 2024 22:00:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714341634;
	bh=dcRqllzvCViq7JroGLfFRXWzRjL6MWy0dXcchL9hte8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=kELx0uKi/H6bF9F8IQEsxAQ9T2dAnlx1PbdCIu98xcGm9MjoIRLYSKIsKVVmNwfRP
	 2JfASZ8kxefbl2gMOSF68JtoDFKejRMSH5Gs4UzW429IWKbowqj/8Ay3J1iu9yC49/
	 F0xzk6jNXDxTmE0lHLdirvgKp1nmE9/SzLlYQjtiavaiOfMGvuT9c561oDtcUFsu16
	 6OCXvwrgSy+bVIDmDxFZJhqdAXTUskIe+9m7x484damGNUrtxzgvj/tNQi43QXIS0p
	 7egOTOBaYK3n6DROAglIgSkcOrOah48QT+WyTGDmULo5NpHbMTkk63eKGXZrIl3nsT
	 jPgwCmh9egPsw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id B986CC4361C;
	Sun, 28 Apr 2024 22:00:34 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2] riscv: hwprobe: export Zihintpause ISA extension
From: patchwork-bot+linux-riscv@kernel.org
Message-Id: 
 <171434163475.22130.3242508482383867837.git-patchwork-notify@kernel.org>
Date: Sun, 28 Apr 2024 22:00:34 +0000
References: <20240221083108.1235311-1-cleger@rivosinc.com>
In-Reply-To: <20240221083108.1235311-1-cleger@rivosinc.com>
To: =?utf-8?b?Q2zDqW1lbnQgTMOpZ2VyIDxjbGVnZXJAcml2b3NpbmMuY29tPg==?=@codeaurora.org
Cc: linux-riscv@lists.infradead.org, corbet@lwn.net, paul.walmsley@sifive.com,
 palmer@dabbelt.com, aou@eecs.berkeley.edu, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, rehn@rivosinc.com, atishp@rivosinc.com

Hello:

This patch was applied to riscv/linux.git (for-next)
by Palmer Dabbelt <palmer@rivosinc.com>:

On Wed, 21 Feb 2024 09:31:06 +0100 you wrote:
> Export the Zihintpause ISA extension through hwprobe which allows using
> "pause" instructions. Some userspace applications (OpenJDK for
> instance) uses this to handle some locking back-off.
> 
> Signed-off-by: Clément Léger <cleger@rivosinc.com>
> Reviewed-by: Atish Patra <atishp@rivosinc.com>
> 
> [...]

Here is the summary with links:
  - [v2] riscv: hwprobe: export Zihintpause ISA extension
    https://git.kernel.org/riscv/c/63f93a3ca891

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



