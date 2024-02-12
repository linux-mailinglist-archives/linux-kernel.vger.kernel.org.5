Return-Path: <linux-kernel+bounces-62383-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 464EA851F7C
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 22:22:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 02580284EEA
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 21:22:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D7824CE19;
	Mon, 12 Feb 2024 21:22:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZZpjHlmt"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB3F14CB58;
	Mon, 12 Feb 2024 21:22:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707772932; cv=none; b=Fa+e4cfaVaFG+mBtqapmBenVIXTZhsw2tqP/a6PmdsUcVdHvNfIndv6O+y+kRdJHPsbFZtuHBmk+fjb9tdMfoqlkpHS7cgGvTxjkXdhiwIQN6I+zFNdNw3CY6qW1PF0YHLv4HjpOdZx8Kp1No1FXZ+JHLEkvznToJa2lu2Uxjyk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707772932; c=relaxed/simple;
	bh=bBnJAcjrD/zSSzGjcXde9b4BDGpdw4QEuQZ05XJYLc4=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=t2/8Q4gtZglZQjpwV+a8E0R2t0mfmbdYHohwaRlcrgDIQwo93Xd2RfeYnBjinueB/95oayaPcrTVYoTI0wMCgpBeqsCGQcVwA5F/9wq02FNGvRj37X5qqmuEZJgKBiQBMBQJQnoh2IAdWnbP0Te0NfMAt0Dk1tgjPfoa4tkjv9k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZZpjHlmt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0ADC9C433F1;
	Mon, 12 Feb 2024 21:22:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707772932;
	bh=bBnJAcjrD/zSSzGjcXde9b4BDGpdw4QEuQZ05XJYLc4=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=ZZpjHlmtMQMwhQeJ6x9EVau0ju6bxdzmJF947wPD1x3cZqpZoUbYPtmlc/HYfnKUF
	 GscWqHJrCc1EH2yaxFIMRjZp7USG7lBPdXl13AYyhvC6TbcSHJhmH6GOI1Nl4RDrum
	 HLsTh24s9AxoNUx1bXszr0edutVWfQMBBQqVuJc90DRMKBQ495eVA4ltY6zcXulL1r
	 K9hzi5Eyd6ZTOFUQnA0mpLCBh5fwPUpwgXgC3Sf6Bwpwm5f3fIBlU3Ce3XP1GwObIT
	 KMd5tpkxoNtvIXYwN8SNdgmjmFYsU0gSuSF7bJ/rS0mBuDwBmV5ZLZUWsxgpXzH/nl
	 KxlBw5gEwErGw==
From: Mark Brown <broonie@kernel.org>
To: Oder Chiou <oder_chiou@realtek.com>, 
 Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, 
 Takashi Iwai <tiwai@suse.com>, Yinchuan Guo <guoych37@mail2.sysu.edu.cn>
Cc: linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20240212144247.43744-1-guoych37@mail2.sysu.edu.cn>
References: <20240212144247.43744-1-guoych37@mail2.sysu.edu.cn>
Subject: Re: [PATCH] ASoC: codecs: fix TYPO 'reguest' to 'request' in error
 log
Message-Id: <170777293077.73793.4917696227318704930.b4-ty@kernel.org>
Date: Mon, 12 Feb 2024 21:22:10 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-a684c

On Mon, 12 Feb 2024 22:42:45 +0800, Yinchuan Guo wrote:
> This patch corrects a common misspelling of "request" as "reguest" found
> in error log across multiple files within sound/soc/codecs.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: codecs: fix TYPO 'reguest' to 'request' in error log
      commit: 00933c4993f132a53d31f995a011945b3835826c

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


