Return-Path: <linux-kernel+bounces-142598-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 238D88A2DA0
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 13:38:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CC68B1F2142F
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 11:38:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 360D658AA8;
	Fri, 12 Apr 2024 11:36:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M8w1HujX"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7949554BD3
	for <linux-kernel@vger.kernel.org>; Fri, 12 Apr 2024 11:36:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712921800; cv=none; b=Bt4JXSi2aDJgnoEJlHk8ifT3wxoLk2/vaCJZ77l140NNH4lTLV4WXUFEZfqqWlVFgfFyC1or8ebHBYy8SeKKMfmyjrZiPM1z0O0gSDvGmpLW50G/QUhvZQlZhbP4RIjyXSwjd7S1ItcNWwvEuDLhuYylAu5+tf8QgzlPdS6hT0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712921800; c=relaxed/simple;
	bh=0B7OZ4+cm6zX6NHLWDukEzHI5Sp9zfAE8/FxHCWBZTs=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=jb7ySPmDOx2dmV7r2AYYYU8QYzmrlysNREdkrGnC5JmFCuhCwYxZpBjFkptGrPrwEaCgQFo2qIcBdXnbiNxEsGcsvMfV6rzv9igYy+uPuAQclmByy+2ZWYU5yYBqJQQgvK9dUtInuMyTpQzkJRaQOSNY4TapTQPB/othrPzB2ns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M8w1HujX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2833C2BD11;
	Fri, 12 Apr 2024 11:36:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712921800;
	bh=0B7OZ4+cm6zX6NHLWDukEzHI5Sp9zfAE8/FxHCWBZTs=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=M8w1HujX7Xic2R9CyhILYprTMR60t/5vkkUbAkGgjqG5XQ0wdRUKX15KAuSPy44JK
	 HUIWKb+ddZIPuFyb17fkFY4YkyZB2gEWQ6Av1Kc/Pg+JA1no+WcgYh6mIP7uekxfLu
	 VWxJEZSxxIb6Xt7ab/dcorooioBhHovpPY3YTwKtTbnA2dXdJ6zdqtvq9HI9iM4p11
	 aEY1vpbNpYmetpPndHlBXmBnZ9s/FzFwNGieVg/Hy5nvs8s6ffI30SToBP7cys/QUw
	 L6xTxVjlOdeVU7z+TREN3Yr/fl7d6P59hAig7IeA5xV8b+Ex5wa1a7mO3nYerkBGfo
	 rKQN3blVHp7+Q==
From: Mark Brown <broonie@kernel.org>
To: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, 
 linux-kernel@vger.kernel.org, 
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>
In-Reply-To: <20240410202912.1659275-1-andriy.shevchenko@linux.intel.com>
References: <20240410202912.1659275-1-andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v2 0/2] regmap: Amend MODULE_DESCRIPTION() texts
Message-Id: <171292179844.7190.3919795371064412980.b4-ty@kernel.org>
Date: Fri, 12 Apr 2024 12:36:38 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14-dev

On Wed, 10 Apr 2024 23:27:51 +0300, Andy Shevchenko wrote:
> A couple of MODULE_DESCRIPTION() text related changes.
> 
> v2:
> - added first patch to change spelling (Mark)
> - updated second one accordingly (Mark)
> 
> Andy Shevchenko (2):
>   regmap: Drop capitalisation in MODULE_DESCRIPTION()
>   regmap: spi: Add missing MODULE_DESCRIPTION()
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regmap.git for-next

Thanks!

[1/2] regmap: Drop capitalisation in MODULE_DESCRIPTION()
      commit: c1ffff88750a697483eabb052004a937631720b6
[2/2] regmap: spi: Add missing MODULE_DESCRIPTION()
      commit: 135cec6ba82ebffc0275c5228b4c4bf279fbf6f5

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


