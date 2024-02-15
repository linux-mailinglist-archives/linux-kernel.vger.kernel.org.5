Return-Path: <linux-kernel+bounces-67352-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 70818856A51
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 17:58:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 100C01F2176F
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 16:58:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B81F71386DF;
	Thu, 15 Feb 2024 16:55:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D6i7tHUe"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 020A51386CA;
	Thu, 15 Feb 2024 16:55:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708016149; cv=none; b=rSbbdAuGZhJ36eze/vdvRcGPm4W7LUFglWdShdbzvOOMq3j7O5Mly+0ryM8E7GEZXg3WJAbT9cW533360mtVnhAlcf9kJiZT4oXjV8P1i5ge0/oyq9xmHDzPVpFLRu50LMIXgmKdhvamEywIFmWG+zFyEn03F4Xf09SH65fUkYc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708016149; c=relaxed/simple;
	bh=4cEg28HTp1ndA6GOOXkFg7o1OuWykGSd1a4ugoaUqMY=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=D8Z6HtqqceHpCvTPVyyM/7NjJduZbrqfK4pV8LegaoSmgH0Q+DuRRCt3VcVhoAhzDAZUBBK3ssZQzKSG/mYVBEBccxBwiScRbL7STmJMB9SEsGRMQKixcTxhm9t/s0UEGhpoOn4tRCjzgF1Ys79UdPzXXyX2zQdgKW/OrGUqXIY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D6i7tHUe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F7CAC433C7;
	Thu, 15 Feb 2024 16:55:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708016148;
	bh=4cEg28HTp1ndA6GOOXkFg7o1OuWykGSd1a4ugoaUqMY=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=D6i7tHUetaNsomsYw/2m960C7Q5Hsdtctux7h1WxMzl11gnQjK59LtqnHhIXDnEMC
	 MlppfvgapQnL8F3m4QSMF9ZpSM1PhV+NArOTNBEjj3iHhlkzQ2AdcZIqCMMxVs0Js3
	 /LRFTjcShkDg0kOvjVXRLe/T5heJy3Cb6mbcMRxFIZOhII4Uvh2KSKKjwpZIvJnm90
	 tdM0K9co/ji45rPzy+4fsJuARyfhvHxW5DwkMAac10JMsNhQlXZphWNOismh1V4MF6
	 GT7qPrCh1mbVkHB0fIxAPdPbZPxcuKO9RQu3MwCGrsq0lMKeb6FbDpYerWKNaii8GR
	 qgFy0gYRck+9w==
From: Mark Brown <broonie@kernel.org>
To: Serge Semin <fancer.lancer@gmail.com>, linux-spi@vger.kernel.org, 
 Colin Ian King <colin.i.king@gmail.com>
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20240215131603.2062332-1-colin.i.king@gmail.com>
References: <20240215131603.2062332-1-colin.i.king@gmail.com>
Subject: Re: [PATCH][next] spi: dw: remove redundant assignment to variable
 len
Message-Id: <170801614725.198390.9313586989047610393.b4-ty@kernel.org>
Date: Thu, 15 Feb 2024 16:55:47 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-a684c

On Thu, 15 Feb 2024 13:16:03 +0000, Colin Ian King wrote:
> The variable id len being initialized with a value that is never read,
> it is being re-assigned later on in a for-loop. The initialization is
> redundant and can be removed.
> 
> Cleans up clang scan build warning:
> drivers/spi/spi-dw-dma.c:580:17: warning: Although the value stored
> to 'len' is used in the enclosing expression, the value is never
> actually read from 'len' [deadcode.DeadStores]
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: dw: remove redundant assignment to variable len
      commit: 125b28b18926e050e770160a5897b81082304f8c

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark


