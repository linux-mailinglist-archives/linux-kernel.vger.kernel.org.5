Return-Path: <linux-kernel+bounces-58709-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A2C7984EA57
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 22:23:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5F5D82860E4
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 21:23:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 793114C618;
	Thu,  8 Feb 2024 21:22:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b41Wji/P"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6A9C50240;
	Thu,  8 Feb 2024 21:21:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707427319; cv=none; b=SGtCbgKXs8gc5k4MuTzBLYyGQtIjK+xqgLQrRWFj29KNgOmUGHs4JGQRMPUrTv8BCwBHDETDgQFu37muvmDW9md4FBCkZ6aSSf0rdrwHHxMAdIxc39noZADv2hu1vED0vBMvrgRI0wWHiwrtqSlSM6Fwr9sW+d2+XJt+7WOzu8A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707427319; c=relaxed/simple;
	bh=7kFefmY9OkruYvpC22qfl6iaCiaO242TM4HTYdl5UDw=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=HkXcgmwe5oAkRf4CNnDE1qDlSnMHxOaRoJD0RZtwSRT7xWtFK1Pvf9m/2m1yU6vk5j4RFbZo9jdi2uxsqqvnBIurjRP6Lip0IcNlO4lzss4DiHIeGj8Bf4/wO2ivXfPqW145RpMjrdJy5JkFnGFra85wRZfZEka6IFDiifr0wQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b41Wji/P; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D29FC43390;
	Thu,  8 Feb 2024 21:21:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707427319;
	bh=7kFefmY9OkruYvpC22qfl6iaCiaO242TM4HTYdl5UDw=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=b41Wji/PSSGxOAp7tKK8Kd4OM532AlOMLT7ZaIXaY4g+XaOVdPWb8KrgOXWQmvPQx
	 dLE4r494hLgqrBFkVjCAmrLTkXfEFNxKdqmTOkBFYdxIj+YMoqu+okQ8nPJ6CKxW22
	 tiWpCCkDHhEHhh2cSyqljk9gosEddjLiODxvLo6RwLO0KEs38SrX60CLEv0Z7jSbsM
	 fc7kjPazyMo5mbAaThm5jfwKZVllAQxpGJ9zvBGTwlw91jYEkTkozDNaLbO8XqO5s+
	 uJKcmOOmvo48G9wuH+VqsISlVyQjkG/yIl1S5N1s+cjlA8P6Re2lDZSjLoqQoU8s4g
	 HKIOvBEK1hIwQ==
From: Mark Brown <broonie@kernel.org>
To: andi.shyti@kernel.org, semen.protsenko@linaro.org, 
 Tudor Ambarus <tudor.ambarus@linaro.org>
Cc: krzysztof.kozlowski@linaro.org, alim.akhtar@samsung.com, 
 linux-spi@vger.kernel.org, linux-samsung-soc@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 andre.draszik@linaro.org, peter.griffin@linaro.org, kernel-team@android.com, 
 willmcvicker@google.com, robh+dt@kernel.org, conor+dt@kernel.org, 
 devicetree@vger.kernel.org
In-Reply-To: <20240207111516.2563218-1-tudor.ambarus@linaro.org>
References: <20240207111516.2563218-1-tudor.ambarus@linaro.org>
Subject: Re: [PATCH v2 0/4] spi: s3c64xx: add support for google,gs101-spi
Message-Id: <170742731537.2266792.3851016361229293846.b4-ty@kernel.org>
Date: Thu, 08 Feb 2024 21:21:55 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-0438c

On Wed, 07 Feb 2024 11:15:12 +0000, Tudor Ambarus wrote:
> This applies on Mark's for-next branch. It can be queued before the
> simple cleanup patches.
> 
> v2:
> - drop the include linux/types.h patch
> - patch 2 is a preparation step as per Sam's suggestion
> - contrary to Sam's suggestion, I kept the style for the
>   s3c64xx_iowrite{8,16}_32_rep() methods, to be consistent with the
>   generic implementations from asm-generic/io.h.
> - s/just/only
> - collect R-b tags.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/4] spi: dt-bindings: samsung: add google,gs101-spi compatible
      commit: ff690e75d64b0ca119adbfc3bd0b444bc1d0a1c5
[2/4] spi: s3c64xx: prepare for a different flavor of iowrite rep
      commit: 80d3204a3b1dbef570ed29d4d375e4d6922da82d
[3/4] spi: s3c64xx: add s3c64xx_iowrite{8,16}_32_rep accessors
      commit: b7bafb9f54fc4609ff84ecd633f918f6f973f471
[4/4] spi: s3c64xx: add support for google,gs101-spi
      commit: 0f0212558bc9e33fad4148d3f44745a367076b20

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


