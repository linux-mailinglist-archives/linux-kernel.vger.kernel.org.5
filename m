Return-Path: <linux-kernel+bounces-123587-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 88E0C890B62
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 21:35:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 243D11F275F6
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 20:35:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E95013A3E9;
	Thu, 28 Mar 2024 20:34:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oYSUfcMa"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D412F13A3F3;
	Thu, 28 Mar 2024 20:34:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711658084; cv=none; b=XMsW4yB5+yd67NWReF6qVtxvVZFyh7LCKdyKm7Tk7cGQqPx88bx+PMsrgrqlakOMGVrb/Z4Ni11JJ47ssqF9pPOu2CupdJckQeYYg3ieQv28was2v9teWm29br3pFPTEoTL+gKFC79BoP8ivEigiPeho7OcmiFYcdPD79qg5U4o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711658084; c=relaxed/simple;
	bh=WciXvisTwwn5YpRXywBpuRTQE+pnq4LwgKyjmCglPu4=;
	h=From:To:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=qyXtLAGRaHbDYRnsIrntuIiocibwLbzxOqn3y2XrhV5vqi0Pppfh6LcYwisRGDX66784n+3p1yq7Q6Py3YUIRjuBPgp7DF3Z/qtfQv3w8Ibr4W3GPrSZwrB8+Q7Mff6hC1ne+XQzbaLAgNjgz7gdruRQs7jxQ4c2gtC9Px5g+xI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oYSUfcMa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8DFC1C433C7;
	Thu, 28 Mar 2024 20:34:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711658084;
	bh=WciXvisTwwn5YpRXywBpuRTQE+pnq4LwgKyjmCglPu4=;
	h=From:To:In-Reply-To:References:Subject:Date:From;
	b=oYSUfcMaex/0M99AkW+zTpwgWbtyyT2Ob8xqoAphU9x8Kqcw9fbpz31JZi+auJYlf
	 oVPhG0dfpaczBNfFVm8d5kowTuyJzkbo8AirEt2ySSicbkxj8s17SRq+yILk+Ttk6F
	 ULIMsu/85U0QJTIB+B1iOpj1mE8x5CPId+fJShQgIqjo0lugWDUjofPsts+896u+//
	 l3UiBMsEoktjo8mEsq5/M8c5ZU/nujkmSB3SL2uBYgswUtl8lbSlboiHnF/fN4DS4/
	 cS3Yc0iHzECowHzuzOZnv0vnyB9bZ00puqT5wkMdMEvD7BaekAh6OYQ/7IBhl7WdTY
	 Mw2lYIXfbh16Q==
From: Mark Brown <broonie@kernel.org>
To: Vladimir Oltean <olteanv@gmail.com>, linux-spi@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20240327174737.519637-1-krzysztof.kozlowski@linaro.org>
References: <20240327174737.519637-1-krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH 1/3] spi: loopback-test: drop driver owner assignment
Message-Id: <171165808327.133439.1100068523499926685.b4-ty@kernel.org>
Date: Thu, 28 Mar 2024 20:34:43 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14-dev

On Wed, 27 Mar 2024 18:47:35 +0100, Krzysztof Kozlowski wrote:
> Core in spi_register_driver() already sets the .owner, so driver
> does not need to.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/3] spi: loopback-test: drop driver owner assignment
      commit: f04cff14e2a4fff4068bd25455531e01089103a8
[2/3] spi: coldfire-qspi: drop driver owner assignment
      commit: 6c360d3e4962dfb5a525dfef1fe75620f6a29bc8
[3/3] spi: fsl-dspi: drop driver owner assignment
      commit: a5bef84422eb066ee8fa5c13960657a79b3cc1e7

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


