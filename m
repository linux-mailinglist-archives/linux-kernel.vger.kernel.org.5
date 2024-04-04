Return-Path: <linux-kernel+bounces-132050-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E0DC898F1F
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 21:40:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CF6F61C26B45
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 19:40:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AD4F134733;
	Thu,  4 Apr 2024 19:40:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I2x9a9Ub"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C0D529403
	for <linux-kernel@vger.kernel.org>; Thu,  4 Apr 2024 19:40:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712259629; cv=none; b=S4bjMubIPPvw4+KQtknmtt5lBeWKiUe2iXgN/vUPmJNN7suSNnOF9nk9K40zjnSA73N2euhvS06Z7l97rwVQFivshRaStfJEfzGTrSvXGfrgSisgB99l1a2VrY2vdaQr0JufKRbSxynZZp84kwKKwmwcQuGkGjvlOjnbP2WL11g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712259629; c=relaxed/simple;
	bh=u334LWyOTdZGhrR0RV+2Ni31VxmZtcf+WWe2CyCtaO8=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=gNQGjLnLEAzxctmC0ypHmH/QJHH/iLN/pJkJYnBrn7I0tEa29FzFLbmMRZT8tCR0XoVyUK7Z2fr3+TEpL39s+xRqNZn5dnV/Avc596b9QKTL9vQJw9hlSU+BGo+A4RLXx64W2c1OBk0Sdo3CTOt2qI+gYCYWU0PiIPiA7g+/ViU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I2x9a9Ub; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 1CA2EC433F1;
	Thu,  4 Apr 2024 19:40:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712259629;
	bh=u334LWyOTdZGhrR0RV+2Ni31VxmZtcf+WWe2CyCtaO8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=I2x9a9UbzWbEfPh8ihDO2pb2IHBvS1TmZUAiqUqqPg8zyltRsr3w07uKmypFnUAu2
	 Oypzb0H1c78FgDzw4N3RDQ1joIOiye/lwz2+hqWTao4CjZSOkB875VGEDMo/BwD9zp
	 jQMmbWiGoBpuIdI/+5G+xnxltepfjzxLE0ONXWkQQS0EQQPqnIUEKMq4ure+hhTrf8
	 jZ/f1IEktwTvZTYsSZQ7OtLq2TwlFtSY2GM3B2yfTVitwZhRl4ZPFahlNr/JHc04Rh
	 RBJjnWOv4VZ8xqEryEyLcDTnGj0ORggYcttOPIBQ3GBoz3rNkwI/DJqO2okg2kkq4I
	 jZ10TaBwAu2lQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 08B19D9A150;
	Thu,  4 Apr 2024 19:40:29 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2] riscv: use KERN_INFO in do_trap
From: patchwork-bot+linux-riscv@kernel.org
Message-Id: 
 <171225962903.17194.5283335335364983285.git-patchwork-notify@kernel.org>
Date: Thu, 04 Apr 2024 19:40:29 +0000
References: <mvmy1aegrhm.fsf@suse.de>
In-Reply-To: <mvmy1aegrhm.fsf@suse.de>
To: Andreas Schwab <schwab@suse.de>
Cc: linux-riscv@lists.infradead.org, conor@kernel.org, palmer@dabbelt.com,
 cuiyunhui@bytedance.com, bjorn@rivosinc.com, linux-kernel@vger.kernel.org

Hello:

This patch was applied to riscv/linux.git (fixes)
by Palmer Dabbelt <palmer@rivosinc.com>:

On Tue, 19 Mar 2024 16:40:05 +0100 you wrote:
> Print the instruction dump with info instead of emergency level.  The
> unhandled signal message is only for informational purpose.
> 
> Fixes: b8a03a634129 ("riscv: add userland instruction dump to RISC-V splats")
> Signed-off-by: Andreas Schwab <schwab@suse.de>
> Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
> 
> [...]

Here is the summary with links:
  - [v2] riscv: use KERN_INFO in do_trap
    https://git.kernel.org/riscv/c/dd33e5dc7247

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



