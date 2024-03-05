Return-Path: <linux-kernel+bounces-92977-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CEE078728DE
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 21:42:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 163261C29565
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 20:42:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C022612D1E3;
	Tue,  5 Mar 2024 20:42:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TEst1wRH"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 096A412C811;
	Tue,  5 Mar 2024 20:42:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709671334; cv=none; b=UVoxZLrblPLy1eayrae83pLAaXf0qrOVQo2jyxo/vwGhyNouJMfoNoJRI78ExID8xf7xrACBvdnnm+UUbWKYujFgSy+Fh87m1KHyblpD4A48C1m35CgPkgMyazD791I/FrB3tsUMlNVicMUQHBdeR1h2dtXMQlcnvZnXT+mMxIo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709671334; c=relaxed/simple;
	bh=U6U/tKB5/ThplqMAjY6bvXtQtE+7iNWfe3xadqfijik=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=tq/jjHbc1veYWwalEKgSV9qZPCMpVSoTFARjZw88cfNSrskzAs/UN1Twyz6LJc4p/IT3KiLqePs/INnNUMnzWPIbBKqhM1Q5BPyU86IH+fib//qZZXaWSph2e1LhVBznviCL2jKP6lSJnWP4luKC3HSYBrKJ4zxVxjE8SmMwFtA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TEst1wRH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7215CC43399;
	Tue,  5 Mar 2024 20:42:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709671333;
	bh=U6U/tKB5/ThplqMAjY6bvXtQtE+7iNWfe3xadqfijik=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=TEst1wRHEgaYoAooy+IPmlz+xRqwYPTTwA09b2jvjKBu1DB062fLjZC5LYPNREpth
	 Xk/H7ML9ku70HIsPI4mXSvIq3diZldIE56V495QFNQjLntdS2cDE1m2eDL7yM17zOL
	 JR5igTPBfFmJvSkf5GRcxM0Mm7vhDyWYrWlAhfURNiVNRHkvzOV5LoP6O7DAYpHTAI
	 7nBvT997wagvJMxdFhqcIuoyicdy/wrf+yv4jbDN8Df3KwJ4xMTyWlVmyte1wM+Opw
	 jtBRze9t4l5nKbsuCChdrEWQOe0f3nvzTaepqgM1/CA2407IM6C+6aSqCQJwkG6iW0
	 pZSvy60fZGfaw==
From: Mark Brown <broonie@kernel.org>
To: David Lechner <dlechner@baylibre.com>
Cc: Michael Hennerich <michael.hennerich@analog.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Kees Cook <keescook@chromium.org>, 
 "Gustavo A. R. Silva" <gustavoars@kernel.org>, linux-spi@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org, 
 Christophe JAILLET <christophe.jaillet@wanadoo.fr>
In-Reply-To: <20240304-mainline-axi-spi-engine-small-cleanups-v2-0-5b14ed729a31@baylibre.com>
References: <20240304-mainline-axi-spi-engine-small-cleanups-v2-0-5b14ed729a31@baylibre.com>
Subject: Re: [PATCH v2 0/3] spi: axi-spi-engine: small cleanups
Message-Id: <170967133115.228925.14810837415699118831.b4-ty@kernel.org>
Date: Tue, 05 Mar 2024 20:42:11 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-a684c

On Mon, 04 Mar 2024 10:04:22 -0600, David Lechner wrote:
> This series contains a few small cleanups to the axi-spi-engine driver,
> mostly suggested from previous reviews.
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/3] spi: axi-spi-engine: remove p from struct spi_engine_message_state
      commit: 69d54ee2e5b0dab9350be2a7019c472b9b8d4c14
[2/3] spi: axi-spi-engine: use __counted_by() attribute
      commit: c8340ac1015471ec5af234beff535efe15f382e9
[3/3] spi: axi-spi-engine: use struct_size() macro
      commit: 5c708541301e695b611cb0b9c6d732bed9b5d904

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


