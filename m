Return-Path: <linux-kernel+bounces-87430-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 135CC86D450
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 21:36:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0AB541C2148F
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 20:36:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28D95142912;
	Thu, 29 Feb 2024 20:36:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lV4Ea411"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6ADFC5025E;
	Thu, 29 Feb 2024 20:36:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709238975; cv=none; b=Ph1VTj6+ruEeuZLZi5MhOtM6O9v0EGx9X3Ku4Gb1TAux7M65+ypng7uxKJhQpxgL4I4tLdNApl42R33pR8YnWlkWJYRWgZ3x1uHfZ8CcAu0Ds6lCaEG4IZyU8hAlrRtOBxYCfGjy++IkfjgdEzfQy1saGdMrJOtT7c5KjB97VL4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709238975; c=relaxed/simple;
	bh=ZsVI6ulKl3T7yhn4W9VMHmXsIE6Urv1VYjHT9iHu+fc=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=FkglhqFLdkUidhQsImLPwOGJevXch9VNxq+IfG3fxIc98nHF+Hnh87bdDGBTHVANIODvLx1aXfMUJFhyv9xqGWxSlp+gIGHw4k6xb65adHsBu82uvM6qAWfv4zvMlb+kA1kzuM5tZdhDydB+J6lZqCFJ/J45Y0ajh+7u82DxBhQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lV4Ea411; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40823C433C7;
	Thu, 29 Feb 2024 20:36:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709238975;
	bh=ZsVI6ulKl3T7yhn4W9VMHmXsIE6Urv1VYjHT9iHu+fc=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=lV4Ea4112hZJR3UCTEQmvQCrmFaWfIHmxUqhl+yyWZJLwhOYyUFg50r2JCFJdRLph
	 lTgQA+pvJv7EqefW8AisKcTS/uKVLTbLQ6HrcfaeChzB/suJDS3kVwbHwD0MFfah/K
	 d2OngZ+1i9y5TIr+DgRzyudvBa0Is3wMjHnE3Spl6/7uxR1i+/YXZHvv73JG7bEDtU
	 Yf+kAqyF8MAu78JBtuQD7Pu8+cjek0z8o8w5QWV4icdLxDnKtOPvXHgBsbjXjpBaiK
	 tK/Yv/aeb/Y4G0EFWKhzLwMcZ1M8mHHxcBZxQuObZs/tn5sxvtBbgJQVsLSGUZdce6
	 g9VOvcsWPzAFA==
From: Mark Brown <broonie@kernel.org>
To: linux-spi@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
 Alexandre Torgue <alexandre.torgue@foss.st.com>
In-Reply-To: <20240228194632.3606563-1-andriy.shevchenko@linux.intel.com>
References: <20240228194632.3606563-1-andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v1 1/1] spi: stm32-qspi: Replace of_gpio.h by proper
 one
Message-Id: <170923897279.237390.7206796794798995947.b4-ty@kernel.org>
Date: Thu, 29 Feb 2024 20:36:12 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-a684c

On Wed, 28 Feb 2024 21:46:32 +0200, Andy Shevchenko wrote:
> of_gpio.h is deprecated and subject to remove.
> The driver doesn't use it directly, replace it
> with what is really being used.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: stm32-qspi: Replace of_gpio.h by proper one
      commit: bc9c0a9967fea2c0333bea26ab1bbb66c2bff31a

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


