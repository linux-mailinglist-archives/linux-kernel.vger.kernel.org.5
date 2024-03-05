Return-Path: <linux-kernel+bounces-92976-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A578C8728DC
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 21:42:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 41417B29120
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 20:42:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93C1612BF35;
	Tue,  5 Mar 2024 20:42:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kaN0Phoi"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB5DD12AAF5;
	Tue,  5 Mar 2024 20:42:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709671331; cv=none; b=EwYr0TsEFYzjtvqypoyNJAH/klaLTyHk9Gb5MlPdbCgpDsWlfyHRsQOo4uvaoSPO9VupDO5SXnwH7ZuwNrlBvMbhj9w3eBh0UYSbEd3Z1FOXZyjBJNHhx5W2LYOpbkCzKi/H+TIuZia7l3VDJoQx64jU3TWLMhdnmd6q0wqRD9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709671331; c=relaxed/simple;
	bh=Fu16f7DpphDPkQLucekhzya2S7uBfLzRTS9lQLKo3Ro=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=oSNFa8z79H2r/hNogyM+chWqi13mZQ9xXikbjwQkFZ2J8lIng4ZryFuaq4rJQZllBwutmJa+vbsmOBJuX1Xfzc4fkHel9fFAiWVJKdrNmeelq/A5iP9Wkc0ModPlXINL9GeU+cKVTYKmUJxnQ+O8pUQb1GouWIjywITEziPNLWo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kaN0Phoi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 036D9C433C7;
	Tue,  5 Mar 2024 20:42:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709671330;
	bh=Fu16f7DpphDPkQLucekhzya2S7uBfLzRTS9lQLKo3Ro=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=kaN0PhoiGu1GcNUBcDRXNRFYlGier63O/E0Y1IgVg80Jb5DThALg/QYkSmXg/8EcE
	 Wb4CYcQFkESfh4Elm6SvRmn2P2NjtNr1+ZW+Ce4Rf5cQtBxp1vIthckscU3eJsEto0
	 UzaAEqrDpwmy4QvOK5lfRKkcQW0/jPMn8Hzi/n+HWF3ZkLNyiWUg9m24Vr8MjP1v97
	 Z2UuiW0We++OLWKuAfAAdy7bE62PSc01HwOUVMNwlEh/mQgQG6fYBIViFup9k2x2Ow
	 Ex4JW7LLhDnqWEtYY0kdW4aQGVTSXS8t8PMSNFp6NShQGp3fnN6loCecpDJBhUDWIl
	 EH47BvtMYDwWA==
From: Mark Brown <broonie@kernel.org>
To: andi.shyti@kernel.org, robh+dt@kernel.org, 
 krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org, 
 Tudor Ambarus <tudor.ambarus@linaro.org>
Cc: linux-spi@vger.kernel.org, linux-samsung-soc@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 andre.draszik@linaro.org, peter.griffin@linaro.org, 
 semen.protsenko@linaro.org, willmcvicker@google.com, 
 kernel-team@android.com
In-Reply-To: <20240301115546.2266676-1-tudor.ambarus@linaro.org>
References: <20240301115546.2266676-1-tudor.ambarus@linaro.org>
Subject: Re: [PATCH] spi: dt-bindings: samsung: make dma properties not
 required
Message-Id: <170967132774.228925.1759895846287455970.b4-ty@kernel.org>
Date: Tue, 05 Mar 2024 20:42:07 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-a684c

On Fri, 01 Mar 2024 11:55:46 +0000, Tudor Ambarus wrote:
> Since the addition of the driver in 2009, the driver selects between DMA
> and polling mode depending on the transfer length - DMA mode for
> transfers bigger than the FIFO depth, polling mode otherwise. All
> versions of the IP support polling mode, make the dma properties not
> required.
> 
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: dt-bindings: samsung: make dma properties not required
      commit: ee09bb727bff1f14f3f2d81592741b8a081af2ee

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


