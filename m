Return-Path: <linux-kernel+bounces-54605-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B01A584B16E
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 10:38:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E360A1C2250E
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 09:38:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A38B012D77B;
	Tue,  6 Feb 2024 09:37:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tPlwOkxI"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E32BF12D75F;
	Tue,  6 Feb 2024 09:37:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707212266; cv=none; b=H2dX/Ddw+Vh9Ka9+pZAT1tgT+LvV6Oghv/Ug6hVSH1H9JUPCyeqxBurlLiMbfHd7rHcrBygATI74P0nKfAdtW4LkyX+eEC/kepLg55BKeHAJOmbRAkvsbet28B4Mxh87MXzjLzD9bZrCMPgPMbd5f5OAgqYWR9GLN3MXrkgNYFo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707212266; c=relaxed/simple;
	bh=ey/KtjqK4Luic175rFym94Q389ddvbeiHhTJCzGxn5E=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=Qms3tcw+31vhNdx+CDeYuga1lcMGeaTcnXKnf/+pwTQuqmLsxGJhDTD/d0hmMfDYQMuG05Ym2oNZebj4U0sXmT3eieKAcI7BWO6aed5+r3IzDa+5rcwCzLuJjwJ2DxosRZdKsa35hiXsQG2ubC0qb6A8JpzujSKj27B5Hde4Kio=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tPlwOkxI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE808C43394;
	Tue,  6 Feb 2024 09:37:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707212265;
	bh=ey/KtjqK4Luic175rFym94Q389ddvbeiHhTJCzGxn5E=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=tPlwOkxI80fYnUhabLFCowUT4kfZuNuI3s/5fw/IsdFWfh+vAXCobRxeOIdiXZgvr
	 ewKFTWAO8YNzfj+NEFEf0S1FWZzaNbal3rAxlMu1DqlfMLP7cT7uy9IqNvBNOCkn71
	 yiDcEO3E7FvfYxzXFo6uJt69SNdPysCxTiz3tppi2TX9yPAkfARsAfbOE2Eemp9UNa
	 jNS/Ywy+nHEmJU39JtBUAv77aomj2BI8im2kUAmLT99bHNh87z0/b+vpdIlYJKCwX3
	 0GUvIP+Qy4LiN9WEnpAhUpM+gZ9xJIyXL7wJSabFHXeL5KRObx3BSn7u38cO8fLCFC
	 RkPJh1lI5rYEg==
From: Mark Brown <broonie@kernel.org>
To: Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, 
 linux-sound@vger.kernel.org, Daniel Mack <daniel@zonque.org>, 
 Haojian Zhuang <haojian.zhuang@gmail.com>, 
 Robert Jarzmik <robert.jarzmik@free.fr>, 
 linux-arm-kernel@lists.infradead.org, 
 Masahiro Yamada <masahiroy@kernel.org>
Cc: Liam Girdwood <lgirdwood@gmail.com>, linux-kernel@vger.kernel.org
In-Reply-To: <20240204091424.38306-1-masahiroy@kernel.org>
References: <20240204091424.38306-1-masahiroy@kernel.org>
Subject: Re: [PATCH v2] ASoC: pxa: remove duplicated CONFIG_SND_PXA2XX_AC97
 entry
Message-Id: <170721226176.850647.15506347741778971521.b4-ty@kernel.org>
Date: Tue, 06 Feb 2024 09:37:41 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-0438c

On Sun, 04 Feb 2024 18:14:24 +0900, Masahiro Yamada wrote:
> 'config SND_PXA2XX_AC97' is already present in sound/arm/Kconfig with
> a prompt.
> 
> Commit 734c2d4bb7cf ("[ALSA] ASoC pxa2xx build support") redundantly
> added the second one to sound/soc/pxa/Kconfig.
> 
> Remove it.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: pxa: remove duplicated CONFIG_SND_PXA2XX_AC97 entry
      commit: 8f501d29c7a6a03303c1a085fd27948e1edb0c90

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


