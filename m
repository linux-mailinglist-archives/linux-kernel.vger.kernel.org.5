Return-Path: <linux-kernel+bounces-131717-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 95263898B06
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 17:24:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A215E1C219DC
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 15:24:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0173C129A7E;
	Thu,  4 Apr 2024 15:24:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ryY/kRh+"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EAD02C189;
	Thu,  4 Apr 2024 15:24:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712244257; cv=none; b=YXUemypNnwAaYZ7tgUZ5wP85J93NTzb7dZSzCzjIr1Nwjx5mM4OJ+R82F9hnqnDac3S7jV2hBOmTLPlyGpqaqErT5I7eGMzf699NUm5uq/pBtawf44J9wrf3miN7g79/E95itE2D+AHomoGpgr2IArNbbyCRZVhLAM8x48KBOls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712244257; c=relaxed/simple;
	bh=x6ZnJOxjC4HEHWF02HQuM7ePfGFQL8u36kT/pJhsobo=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=U+O1Etcog3GnBItee+KSDtSsgH6kmLK8nB07ouGh3+GhFnUts0F8O+e9W6JsDsBUByXCNImMsJu4Oy46R12s8U/V1cz87NoptzXfh0h6/yH8NZDSCkGsGymmuSDWFndBW8levtLp9KHBKyfUxj+OqNRsW8SCHwjg/GxEotivcUc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ryY/kRh+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C41E9C433C7;
	Thu,  4 Apr 2024 15:24:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712244256;
	bh=x6ZnJOxjC4HEHWF02HQuM7ePfGFQL8u36kT/pJhsobo=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=ryY/kRh+/ufffsN8DaR0ct4bU3rygt8kfnJ3maY/xjWFSzGD6hsvN7MeK7gSgFdqY
	 i54TJl4UgPs5YANHwB8p07inmx6cAY1Z7x55qy7wEt8rFKfJmhCBsoXq0a0Ge95Gai
	 t/uatqc18KyefAndYvVgOQz30nj9uZWH6aMphs8CPDU7LphPqx8ivsxlHZpEjpPZu4
	 3NU5PW/haV37AIE8RHK85KTws2tX0P05e80aEBcbwUwtg09T8uw2/B1c0SCQQvBzEP
	 xMkk4M3akIQ556GGQY7geSJ3FZ3v2IknFL8SvUwb3nT0K74DU0eeyfHU44uoIzs/Wn
	 cygkmP//SJr2g==
From: Mark Brown <broonie@kernel.org>
To: Laurentiu Mihalcea <laurentiumihalcea111@gmail.com>
Cc: lgirdwood@gmail.com, peter.ujfalusi@linux.intel.com, 
 pierre-louis.bossart@linux.intel.com, daniel.baluta@nxp.com, 
 iuliana.prodan@nxp.com, linux-sound@vger.kernel.org, imx@lists.linux.dev, 
 laurentiu.mihalcea@nxp.com, linux-kernel@vger.kernel.org
In-Reply-To: <20240328221201.24722-1-laurentiumihalcea111@gmail.com>
References: <20240328221201.24722-1-laurentiumihalcea111@gmail.com>
Subject: Re: [PATCH 0/2] ASoC: SOF: imx: stop using the imx8_*_clocks API
Message-Id: <171224425330.53181.2036893108505184171.b4-ty@kernel.org>
Date: Thu, 04 Apr 2024 16:24:13 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14-dev

On Fri, 29 Mar 2024 00:11:59 +0200, Laurentiu Mihalcea wrote:
> The imx8_*_clocks API requires keeping track of all of the clocks used
> by the IMX SOF driver via an array. This is unnecessary and doesn't
> scale well. As such, remove it altogether and replace it with
> devm_clk_bulk_get_all() and friends.
> 
> Laurentiu Mihalcea (2):
>   ASoC: SOF: imx: drop usage of the imx8_*_clocks API
>   ASoC: SOF: imx: remove imx8_*_clocks API
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/2] ASoC: SOF: imx: drop usage of the imx8_*_clocks API
      commit: a358f67d16942f3bbc4d6b0e4b65efd5dda1c304
[2/2] ASoC: SOF: imx: remove imx8_*_clocks API
      commit: e618b8b37aa1dac42f50c87373d71ecc68ead97d

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


