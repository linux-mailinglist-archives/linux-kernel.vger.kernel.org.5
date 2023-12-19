Return-Path: <linux-kernel+bounces-5534-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C068818BC9
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 17:06:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CF5EC2876E9
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 16:06:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB02F1DDF4;
	Tue, 19 Dec 2023 16:05:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qmUYPxhN"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45FC01DA46
	for <linux-kernel@vger.kernel.org>; Tue, 19 Dec 2023 16:05:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10C9DC433C7;
	Tue, 19 Dec 2023 16:05:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703001945;
	bh=jCafuXZMr4CVA6ZUTmd6i6uEsoZeucixacGiBD7RwNI=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=qmUYPxhNZWAocTkoQECmYZQFZ34/VqCmVQRLp/x4znYAOMATKsjCpJOSeJBucqVD1
	 J1E7k9VDZB5a5OdplC6Hbxv/CSeBUKETnSlQhWzrdZPlbacWcycx3gb/Jqr2h/iFoo
	 pZt5fd0PHnYOcRmfrnBmu3uTXD0Rsy2aYCP6mTLTI60DhbTwPbxQ6hMLP+pNytoKTR
	 Q9HAnCZEZP1WE+rVMLO2z2jQeYc4jpstcRRU7WqKPqa4CC+ajyDBmd3SNcTTuEAZrI
	 Tkj+nDRT9smYUHNCYCYbxMMdQggl4m6qyRjMkAkMx/krXz75+NDHwKtmmKDD8cewLq
	 AET82MXGYk4DA==
From: Mark Brown <broonie@kernel.org>
To: Jerome Brunet <jbrunet@baylibre.com>
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, 
 Zhengqiao Xia <xiazhengqiao@huaqin.corp-partner.google.com>, 
 Hsin-Yi Wang <hsinyi@google.com>
In-Reply-To: <20231218145655.134929-1-jbrunet@baylibre.com>
References: <20231218145655.134929-1-jbrunet@baylibre.com>
Subject: Re: [PATCH] ASoC: hdmi-codec: fix missing report for jack initial
 status
Message-Id: <170300194376.59057.11924859016246547455.b4-ty@kernel.org>
Date: Tue, 19 Dec 2023 16:05:43 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-5c066

On Mon, 18 Dec 2023 15:56:52 +0100, Jerome Brunet wrote:
> This fixes a problem introduced while fixing ELD reporting with no jack
> set.
> 
> Most driver using the hdmi-codec will call the 'plugged_cb' callback
> directly when registered to report the initial state of the HDMI connector.
> 
> With the commit mentionned, this occurs before jack is ready and the
> initial report is lost for platforms actually providing a jack for HDMI.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: hdmi-codec: fix missing report for jack initial status
      commit: 025222a9d6d25eee2ad9a1bb5a8b29b34b5ba576

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


