Return-Path: <linux-kernel+bounces-13197-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 724D2820111
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Dec 2023 19:39:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 21C1E1F221E0
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Dec 2023 18:39:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58C6912B98;
	Fri, 29 Dec 2023 18:39:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rW4QzQXs"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 964C912B92;
	Fri, 29 Dec 2023 18:39:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8EDC1C433C7;
	Fri, 29 Dec 2023 18:39:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703875150;
	bh=sTxR6z5JOWgh+34pWTsQbRixIn+UfsgPr8ZOpdldSIg=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=rW4QzQXsxou3N/rtnJwoktJXEcINLWb+6cYcPwnu1jSUyQ/4Guh0j5AGr5fJeCsGi
	 u3IBxg42F87pjcnhpE5NyrJ/u14mgxwUIu/06jXkJXgNUfAjk0ehb4+igcjBiV+kFS
	 16TufM4Hc41S0hWv4vaf+24mf2qe/mnemI4BHe01NkbAoAWWvG5LkLbKeo03XiAISk
	 6/UI4LPySjsbOLv3fPyTKdxYnmxcDp7If7nGNGTGzKuoEiYy70vSesajOxdd1uYhwz
	 t51NAJJ/EE1oSMmBfUsQWEcNvsHrKD4ht76FY3HJaKyAvLltXuHhD996FfxuMCaxAn
	 nQloDkoTHS5bQ==
From: Mark Brown <broonie@kernel.org>
To: linux-sound@vger.kernel.org, linux-mediatek@lists.infradead.org, 
 Eugen Hristev <eugen.hristev@collabora.com>
Cc: matthias.bgg@gmail.com, angelogioacchino.delregno@collabora.com, 
 allen-kh.cheng@mediatek.com, jiaxin.yu@mediatek.com, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 kernel@collabora.com
In-Reply-To: <20231229114342.195867-1-eugen.hristev@collabora.com>
References: <20231229114342.195867-1-eugen.hristev@collabora.com>
Subject: Re: [PATCH] ASoC: mediatek: mt8186: fix AUD_PAD_TOP register and
 offset
Message-Id: <170387514707.3010118.10483161102893986503.b4-ty@kernel.org>
Date: Fri, 29 Dec 2023 18:39:07 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-0438c

On Fri, 29 Dec 2023 13:43:42 +0200, Eugen Hristev wrote:
> AUD_PAD_TOP widget's correct register is AFE_AUD_PAD_TOP , and not zero.
> Having a zero as register, it would mean that the `snd_soc_dapm_new_widgets`
> would try to read the register at offset zero when trying to get the power
> status of this widget, which is incorrect.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: mediatek: mt8186: fix AUD_PAD_TOP register and offset
      commit: 38744c3fa00109c51076121c2deb4f02e2f09194

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


