Return-Path: <linux-kernel+bounces-58711-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CD61184EA5B
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 22:23:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0C9081C23B39
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 21:23:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E4D950A72;
	Thu,  8 Feb 2024 21:22:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O5OKxmLY"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DEF350A65;
	Thu,  8 Feb 2024 21:22:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707427323; cv=none; b=J56YF63pLnw+44TTU6wYm89YAQbVZwIAymDffdTFJxqDmwzDwLkSsk65P2Hx9aUHdUmDfi8RZWG7jkk+n0ek7HeBge/5vRxsXEE4nJa4QSIfOKwA/TmsJ4EWCMI55sJf7jd45cGXKcmwyrDRBx1rE4Mh1b1ZgDf/jVguSAVGLz4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707427323; c=relaxed/simple;
	bh=hlfpOMjc2wHCb6Aasa8/yJSIz1ydkU62jVYWKmYJOYM=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=c/P/CmnUT0RWOaO9TcwfNMrcX37+GvuYyZNWHQAXkKqVak0lrvlsxfPv4AkrSXY3JwpnlUG6TmLBVb+4HOd7qsPVVKKPabTQht4iOQSD9GhRSYg5mwgzE657F67W6VlaBuzk3pEBov7gcoNS7Jx/sHDJ9D5hYCvaspP2cYR4vio=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O5OKxmLY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9AC19C433A6;
	Thu,  8 Feb 2024 21:21:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707427322;
	bh=hlfpOMjc2wHCb6Aasa8/yJSIz1ydkU62jVYWKmYJOYM=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=O5OKxmLYLEudCIe7Yg2TblxtmFgf8ULom/2gSuiwAHBZJcnCoiCc+LVgnua4YRLmE
	 vhsMqIhgW2o2p3hVqA2omJ7tXAs+os8h/ftymFs96HLXrMEA4YCRiIb4j2Wj1eS0Wz
	 jBFWC4B3izNw30D2ZjMfrpvCyel47TMOYSD75TVWp9EbjxAPSUWhPmM4PvBXdDwOB/
	 18378drKDCeLikDtFHzKpeAPKWk94w81wqqVlChaz6xOc7qZGSFrDh+nfJGMZ06O1N
	 wYPGQRfFj05oIeYwWoF6LoaIt2EtjEaHKc/j+q386brH1Ow3wiAaH65pTmiKRMMbGW
	 kyDs/wM4LlxYg==
From: Mark Brown <broonie@kernel.org>
To: andi.shyti@kernel.org, semen.protsenko@linaro.org, 
 Tudor Ambarus <tudor.ambarus@linaro.org>
Cc: krzysztof.kozlowski@linaro.org, alim.akhtar@samsung.com, 
 linux-spi@vger.kernel.org, linux-samsung-soc@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 andre.draszik@linaro.org, peter.griffin@linaro.org, kernel-team@android.com, 
 willmcvicker@google.com
In-Reply-To: <20240207120431.2766269-1-tudor.ambarus@linaro.org>
References: <20240207120431.2766269-1-tudor.ambarus@linaro.org>
Subject: Re: [PATCH v5 00/17] spi: s3c64xx: straightforward cleanup
Message-Id: <170742731939.2266792.15383830101755255462.b4-ty@kernel.org>
Date: Thu, 08 Feb 2024 21:21:59 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-0438c

On Wed, 07 Feb 2024 12:04:14 +0000, Tudor Ambarus wrote:
> The patch set has no dependency although Sam prefers to have this simple
> cleanup queued after the gs101 patches from:
> https://lore.kernel.org/linux-spi/20240207111516.2563218-1-tudor.ambarus@linaro.org/
> 
> Tested with gs101-spi.
> 
> Changes in v5:
> - don't abuse the Fixes tag, it was wrongly used for:
>     - explicit header inclusions
>     - possible negative array index fix, which is just a posibility,
>       it never happened
>     - typo fix
> - reorder patches, sort headers then explicitly include the missing ones
> - new patch: "spi: s3c64xx: explicitly include <linux/types.h>"
> - collect R-b tags
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[01/17] spi: s3c64xx: sort headers alphabetically
        commit: a77ce80f63f06d7ae933c332ed77c79136fa69b0
[02/17] spi: s3c64xx: explicitly include <linux/io.h>
        commit: 42a9ac378d918176e17592cbe79d8b0606f951e4
[03/17] spi: s3c64xx: explicitly include <linux/bits.h>
        commit: 4568fa574fcef3811a8140702979f076ef0f5bc0
[04/17] spi: s3c64xx: explicitly include <linux/types.h>
        commit: 7256d6bdd4fe0eac6d4bcd138c3d87f95f79c750
[05/17] spi: s3c64xx: avoid possible negative array index
        commit: a336d41bbea51e11e3e4f56bd3877a535c077129
[06/17] spi: s3c64xx: fix typo, s/configuartion/configuration
        commit: 97b63f4707046b2ef99d077dd4d333c3acca06ae
[07/17] spi: s3c64xx: remove unneeded (void *) casts in of_match_table
        commit: 271f18816b3ba2f75785660e427c16585b7302f2
[08/17] spi: s3c64xx: remove else after return
        commit: 9d47e411f4d636519a8d26587928d34cf52c0c1f
[09/17] spi: s3c64xx: move common code outside if else
        commit: 5d7f4f4367079992c7a1bb1654ffea87ddc82be8
[10/17] spi: s3c64xx: check return code of dmaengine_slave_config()
        commit: e9c49effde70fb4b10d0ad9c94b69fe6314fc608
[11/17] spi: s3c64xx: propagate the dma_submit_error() error code
        commit: 60dc8d342e933097eb82db5859edcac9077a6db5
[12/17] spi: s3c64xx: rename prepare_dma() to s3c64xx_prepare_dma()
        commit: 4c6452050530b741daf108de0c02cd2299f8f5d1
[13/17] spi: s3c64xx: return ETIMEDOUT for wait_for_completion_timeout()
        commit: 1a234accc93191a3a73eb4cc264abb6d79d63430
[14/17] spi: s3c64xx: drop blank line between declarations
        commit: 91a9b8e6b63eeb3634e736a4b65ae536c08155b2
[15/17] spi: s3c64xx: downgrade dev_warn to dev_dbg for optional dt props
        commit: f186d34071fb2a7db7249b09d5e1796b18b37d7d
[16/17] spi: s3c64xx: remove duplicated definition
        commit: eb8096c30ad07e6201830816e398b3ad603cc096
[17/17] spi: s3c64xx: drop a superfluous bitwise NOT operation
        commit: acd6c7b1d2765fd30b7d7487aff50dc824db314e

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


