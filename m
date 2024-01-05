Return-Path: <linux-kernel+bounces-18230-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D9C73825A43
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 19:36:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 79CCC1F2458B
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 18:36:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8029035EE9;
	Fri,  5 Jan 2024 18:36:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XIKjLRB9"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5D5435882;
	Fri,  5 Jan 2024 18:36:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC92BC433C7;
	Fri,  5 Jan 2024 18:36:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704479771;
	bh=XRWPrr9T5/VjznaWQduTwmWpyc6/DLXZur01J8VMvoQ=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=XIKjLRB9QJu2dLH8eJNnGLTJ4pRoKkrphAbKeR7QfrqQT020dXWZHAV4jfs6S/F/m
	 qULEAbV5GQJIvcOpw7nkdY6SG7uP6xzFLBHBY2o7oSi7ZR1OqwUouKH4o9hA7g+HQB
	 MJSdHEZSYYN0NNWdSE9RN+rPJ2Xks2vMWmOEJNLpToLGGGcG+6Xjw6B5yRYqeB2i6f
	 9z+PR/9qIhdy/zhO9tQFeWBorou3pzwkqQ3L9Sk/NBjKhef8PE2HTYgCQuF9VlmEJT
	 XLgmlC612vD6RdHcqbEurGiDWa20vIYZ4BBBFipYkEsDZ/9uJBCA47p6XuSxRffOW1
	 Z+LjMmi+yG4pA==
From: Mark Brown <broonie@kernel.org>
To: Yuanjun Gong <ruc_gongyuanjun@163.com>, 
 Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc: alexis.lothore@bootlin.com, linux-kernel@vger.kernel.org, 
 kernel-janitors@vger.kernel.org, linux-spi@vger.kernel.org
In-Reply-To: <6670aed303e1f7680e0911387606a8ae069e2cef.1704464447.git.christophe.jaillet@wanadoo.fr>
References: <6670aed303e1f7680e0911387606a8ae069e2cef.1704464447.git.christophe.jaillet@wanadoo.fr>
Subject: Re: [PATCH] spi: coldfire-qspi: Remove an erroneous
 clk_disable_unprepare() from the remove function
Message-Id: <170447976960.321446.8658938868485382767.b4-ty@kernel.org>
Date: Fri, 05 Jan 2024 18:36:09 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-5c066

On Fri, 05 Jan 2024 15:21:00 +0100, Christophe JAILLET wrote:
> The commit in Fixes has changed a devm_clk_get()/clk_prepare_enable() into
> a devm_clk_get_enabled().
> It has updated the error handling path of the probe accordingly, but the
> remove has been left unchanged.
> 
> Remove now the redundant clk_disable_unprepare() call from the remove
> function.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: coldfire-qspi: Remove an erroneous clk_disable_unprepare() from the remove function
      commit: 17dc11a02d8dacc7e78968daa2a8c16281eb7d1e

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


