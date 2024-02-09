Return-Path: <linux-kernel+bounces-59195-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DC1184F2F5
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 11:11:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CEC48286FE0
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 10:11:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E01E67E8E;
	Fri,  9 Feb 2024 10:11:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lIr3pDCF"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72EC369949;
	Fri,  9 Feb 2024 10:11:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707473482; cv=none; b=LSMnUCCp46A6W4wrA1jRY90bpvofxAd6fkwt5mjGm8xwJiVchpD69SmOsxJeLH2ATY2sv5YMnyb/YcjxS1VsCgINkmPC2x9luveAm8Ss6TpHctqx8o9vlbl7SBc1Zxj3EIKHj7JKKSp8oYwDFOvBpVw0OPY7ayGjBHqBVR2CKmw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707473482; c=relaxed/simple;
	bh=4kE0Xp72c5D2/9w7aPNSE4fm2E5yXYPL/pccmrWilf8=;
	h=From:To:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=lfqzk+6WNX8tvHxMjR8dWRi0JGfv0LJbJmtoxAdqyuc0sih4s4sWcdB4V1dAccetubNT9YPJ3FvNitnhniut666y2N+D1+5v9sXq6iYU8yWBwicxcppJNfjLqDcaSJOzXbI82Vc+JX9OlZFcGwxEyHKKNYAId7jIdgK1e2QBRng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lIr3pDCF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12082C433F1;
	Fri,  9 Feb 2024 10:11:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707473481;
	bh=4kE0Xp72c5D2/9w7aPNSE4fm2E5yXYPL/pccmrWilf8=;
	h=From:To:In-Reply-To:References:Subject:Date:From;
	b=lIr3pDCF0p6eZfHqpiGEy/Izabg1uzNu1vCZShTYKewutZI5tz2aMwJZzFrjUBKVj
	 CAYs3LJlN6mgXP5AYiHBP/Nr0IEwcZ7U6dRbQjJ3VYXbH1UGZU5MmKqq+hI5/MCE0K
	 mVFgCAQ7NYoC120tO4QRUvjIva0tol0FqKMoxvhmj97kpgBH01F3u55egLhE2p9dyh
	 hMQtxYxcabHBcwXIW/MHdUJ+kWfLyf53TK3f0HFkGrHTCjV/3d0/tir0+JrEBVGJSz
	 9qU3q83IQMYnWRhH3Wlyc/8dQI9gc3h7jH/xjZhbToTkjnBaDXf3LwheN4RMJrxXfP
	 uSBVZaelUOYDw==
From: Mark Brown <broonie@kernel.org>
To: linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20240208202154.630336-1-krzysztof.kozlowski@linaro.org>
References: <20240208202154.630336-1-krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH 1/3] spi: pl022: Use typedef for dma_filter_fn
Message-Id: <170747348086.2331898.14827741193475765493.b4-ty@kernel.org>
Date: Fri, 09 Feb 2024 10:11:20 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-0438c

On Thu, 08 Feb 2024 21:21:52 +0100, Krzysztof Kozlowski wrote:
> Use existing typedef for dma_filter_fn to avoid duplicating type
> definition.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/3] spi: pl022: Use typedef for dma_filter_fn
      commit: d1ff85fdf0b8f63a6e042ae7559c630f9b1c50e2
[2/3] spi: pl022: Add missing dma_filter field kerneldoc
      commit: c42d9bead493854507e1a180942ebe33c9180598
[3/3] spi: pxa2xx: Use typedef for dma_filter_fn
      commit: 3d4dd10b376e1b8b6d0409f7e7b752f9baa51c24

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


