Return-Path: <linux-kernel+bounces-144438-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D702A8A4672
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 03:08:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 92366282ABB
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 01:08:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49C444C9F;
	Mon, 15 Apr 2024 01:08:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ir74pn5T"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 899DEC8E1;
	Mon, 15 Apr 2024 01:08:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713143310; cv=none; b=S/ryTklIdhgu4+2saIO89SCtatz5ICOsc+phpKfzMK/WhL7B4jzlhNLLLEabUHM5BNGQY/LbcmoOEd+xTjrxaECmnOtI9VJ7yJ+kUYBeMp5K+ZEoAFVMOmODbpmoJWTO4dBHhwjluCFz9521Z++xmdzvuzSFlDQzxKA4b8SpUqE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713143310; c=relaxed/simple;
	bh=zpBvuQnPFxKq2nHUdYdTD5xTpzFHltAy/FweRAAelgM=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=Tu75Iv30U+WPP8JxHoMJLOnHKVkhnATOLsKpTRzBsCKOTbROrVAShDpiu97IE/eDZ7NWevsNyYWzH8JDzDN3BZ1c6Drhdq/mNawbyhavKRa8FeYE/aigZqEwXxdI5dwcuLmeoqUvESXwGaKvLRoP46iiLE7JMvLWR6gBaqZiM1U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ir74pn5T; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF514C072AA;
	Mon, 15 Apr 2024 01:08:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713143310;
	bh=zpBvuQnPFxKq2nHUdYdTD5xTpzFHltAy/FweRAAelgM=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=Ir74pn5TorqLemEcgPnpBcqlJKtgxB00MANYepJ6PDLETHJd9KUQD/6m4D+7dcOLW
	 /dYpxPJEi/aj2asCMZhKzmJW2TwYvrbQ1eNAJY6ReFlWDffpg7x11g0kaHYkrdex3V
	 2wgIAseRP9lLD8ej8jK4RfuR75wAJJm61NzRzbb1THGgOUiKooLJeqnx/oyTzw8g7c
	 zAAshFmfulXy6cnFHBYB1AWrQqQSOb8F5h6Tjb+hkdVjaSsxDa/gbPofPQlIhr65qw
	 Hc4OPGGMHyUPwwzlhovvWvmYPyrmgPhzS0bjs36zkjABMrdgt8Nj6L69EAiWlmyJze
	 4rsJNLSWHedSg==
From: Mark Brown <broonie@kernel.org>
To: David Lechner <dlechner@baylibre.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>, 
 Michael Hennerich <michael.hennerich@analog.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, linux-spi@vger.kernel.org, 
 linux-kernel@vger.kernel.org
In-Reply-To: <20240412-axi-spi-engine-version-printf-v1-1-95e1e842c1a6@baylibre.com>
References: <20240412-axi-spi-engine-version-printf-v1-1-95e1e842c1a6@baylibre.com>
Subject: Re: [PATCH] spi: axi-spi-engine: fix version format string
Message-Id: <171314330849.1643230.1623656878142423975.b4-ty@kernel.org>
Date: Mon, 15 Apr 2024 10:08:28 +0900
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-0438c

On Fri, 12 Apr 2024 17:52:48 -0500, David Lechner wrote:
> The version format string in the AXI SPI Engine driver was probably
> intended to print the version number in the same format as the DT
> compatible string (e.g. 1.00.a). However, the version just uses
> semantic versioning so formatting the patch number as a character
> is not correct and would result in printing control characters for
> patch numbers less than 32.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: axi-spi-engine: fix version format string
      commit: 0064db9ce4aa7cc794e6f4aed60dee0f94fc9bcf

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


