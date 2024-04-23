Return-Path: <linux-kernel+bounces-154517-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A857C8ADD08
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 07:04:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5131B1F22D48
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 05:04:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDAA3224D7;
	Tue, 23 Apr 2024 05:04:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k86VvsxN"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36A4320DD2;
	Tue, 23 Apr 2024 05:04:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713848651; cv=none; b=rIJgRTVVVsX2xVqTlBguMNGwj/73fo0iz4IkafsJ/iWf466jOOXqFF75stL2Lg/9YcNUK1BvnD6oOtgnNG5IxLa41tHjmhXhdK+nivGauWJrNqjp2Z3eqHkudT7y2W8lOmYZU1rcOCGUWFkV+NU8t9wuPoVLsMKCXq7HwcU39yU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713848651; c=relaxed/simple;
	bh=fyyNNc35kzUf08wTp1I94CCtJE66QRy40bl7jgbwPI0=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=smi5jBhaOA7LFRxRBz09gFBnBxBgNowpk4dXKNVO8xcUnwLTs8SDqsWEsqCFsGmiA2/6QUiImRFoeM/KB9CeNrFcIF/MdKgWS4Hh0KqEx47uhlICezAU+9BNgQqmN/kG4Rb15hpwbRcvVQ2ggnYP2p8kzOhTgNxImw+dnkWY6PU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k86VvsxN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D7F7FC2BD10;
	Tue, 23 Apr 2024 05:04:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713848650;
	bh=fyyNNc35kzUf08wTp1I94CCtJE66QRy40bl7jgbwPI0=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=k86VvsxNvKmKatUjSlNP1W6xBPp7fok45wJ/XmrsV3OHsiBtnaOW1m04D/O1zdZJ1
	 wucJyo6Mh6HJzcuTnjXoeU8KB6fSTZC6lAfp6fogp5nw/o5gayUm+w1riRRtNlp2es
	 Tuz1EAOFqQZply7pTOKVeWgj2akHu0j4sr5uoDjD/CyiDdxs6YS5b8EfEFPwusbhec
	 tQ24xwvU2eeTmKboYKF5nNJxoC/UNydgCmWku02BSeQewfBgAeYyrE4VBFDOC/ZaHo
	 zNkYCk+ji1cLhv9hx8VWrMVEps62F5+Hrq0+b7JFVflGPrb4hHRqoteehw4liuBmR9
	 xT3ebRB66RITQ==
From: Mark Brown <broonie@kernel.org>
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, 
 linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, 
 Takashi Iwai <tiwai@suse.com>
In-Reply-To: <20240422151513.2052167-1-andriy.shevchenko@linux.intel.com>
References: <20240422151513.2052167-1-andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v1 1/1] ASoC: soc.h: Don't use "proxy" headers
Message-Id: <171384864836.1769239.2563630658108188735.b4-ty@kernel.org>
Date: Tue, 23 Apr 2024 14:04:08 +0900
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14-dev

On Mon, 22 Apr 2024 18:15:13 +0300, Andy Shevchenko wrote:
> Update header inclusions to follow IWYU (Include What You Use)
> principle.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: soc.h: Don't use "proxy" headers
      commit: 3249c68e3cdacc2da8fe811a54f8db43df124c0e

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


