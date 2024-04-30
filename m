Return-Path: <linux-kernel+bounces-164162-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 32EE38B7A0C
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 16:38:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E2A7F2834A8
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 14:38:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E4EF1A0AE7;
	Tue, 30 Apr 2024 14:31:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Fhfzw95x"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A73319DF73
	for <linux-kernel@vger.kernel.org>; Tue, 30 Apr 2024 14:31:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714487492; cv=none; b=XfY3q9qWzslxV4gpO6Utjhz291ZhepSOdxa1AhtoHdYwmX4kRB1+z2yGmu7dsWfMjNP0SJl4iiT6Xua+OReLiD5BR/yXhygdUlXEfiniO3za8Z1v4uN/xVSn7h5TsQ0Hh8f9H2HX63A1P14vlhzeFWDfu/P8Pt7ei08tMq5s8m4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714487492; c=relaxed/simple;
	bh=TpIld0LnjkQmQ5PsI5skb5CrdOEKjutEJsH7FAf0+NE=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=p0giL0Z1469YoDUZI/YYb+Fht1FVV+4TrR8RnDbrEJRQS+7gETk89W2V0KxafvLEzRrl5tkYo5xt0OFonya18XmPoElYBdInGiXtx6NU7zogSoT3KCBnuUjXNOyoYGVaCsryoNxOreXHNBAKD0U+WIrgNGdMIhv0TE2FzeelPH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Fhfzw95x; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04429C2BBFC;
	Tue, 30 Apr 2024 14:31:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714487491;
	bh=TpIld0LnjkQmQ5PsI5skb5CrdOEKjutEJsH7FAf0+NE=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=Fhfzw95xZd3KJTF+cCGdHv5EaYCh88EHjU8X8xTwZ8XiZqYVfYcPkaRQIohdggJPy
	 WmRAfI/LaTfKGjSQP1hyncVMwFyA8Sjw0pWDoNgp8LVjWtUZGhTP2JpzjCw+8n2t0u
	 5+CzBUAJRvmzeeENLs9h3wUE0UFAXZw1yWN1kf4qwal+onpYkR8VfpWkNVFuJuJcH5
	 ueJ88sdZ8zG2RBw5pmuOTlQnkkwi7n7dHsuWoZlax1sN3te04Oix8U3fOq8PrYZBXY
	 uI3BLckXTXKzLTAz3frfU+05s+09aa9IiXJ0W8BH1il+W7oBRKNKP75YtSy44fXAiS
	 LAcE/5vF+PgEQ==
From: Mark Brown <broonie@kernel.org>
To: Liam Girdwood <lgirdwood@gmail.com>, 
 Jerome Brunet <jbrunet@baylibre.com>
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, 
 linux-amlogic@lists.infradead.org
In-Reply-To: <20240426134150.3053741-1-jbrunet@baylibre.com>
References: <20240426134150.3053741-1-jbrunet@baylibre.com>
Subject: Re: [PATCH] ASoC: meson: cards: select SND_DYNAMIC_MINORS
Message-Id: <171448748960.1870439.10234664957673529561.b4-ty@kernel.org>
Date: Tue, 30 Apr 2024 23:31:29 +0900
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14-dev

On Fri, 26 Apr 2024 15:41:47 +0200, Jerome Brunet wrote:
> Amlogic sound cards do create a lot of pcm interfaces, possibly more than
> 8. Some pcm interfaces are internal (like DPCM backends and c2c) and not
> exposed to userspace.
> 
> Those interfaces still increase the number passed to snd_find_free_minor(),
> which eventually exceeds 8 causing -EBUSY error on card registration if
> CONFIG_SND_DYNAMIC_MINORS=n and the interface is exposed to userspace.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: meson: cards: select SND_DYNAMIC_MINORS
      commit: 6db26f9ea4edd8a17d39ab3c20111e3ccd704aef

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


