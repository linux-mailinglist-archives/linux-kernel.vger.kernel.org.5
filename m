Return-Path: <linux-kernel+bounces-33705-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F0A2836D7E
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 18:32:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4617B288AE8
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 17:32:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01A555677A;
	Mon, 22 Jan 2024 16:33:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mUYO4Hjq"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E6C15675F;
	Mon, 22 Jan 2024 16:33:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705941228; cv=none; b=MPqVsjS9wc3MlETojaPA29XXM/uytFZY5M1O3jyIs/SRBQNAgsyd5UiTL/JgyDhbRsL5QxdUy6nMZ7tooD+9Bw+cddnvYVVfRTAFPV/wN9duO9kCixppMhhMHom6QL2k6ArmeFvR+hQ2D2h3/vw9bWL2q0PV66N2I0Q9wc0W+s4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705941228; c=relaxed/simple;
	bh=D8qsa3J9fjuu62+bhhSC18gBPXhzCi2KQ8gRk9xdu2o=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=JBIK5ys6sBLKCOsqEwAvBQuVxPHbd+kx5QrZdgVjfNzZ3hdgt1BLQOYC35lk9Z0pyJrCd2o3mox88Pfmkk8CeM+kL2eAAKuMyqBqJiKfpDd8RGOIOuXM/IGQ+6xI8fQ0YL3Srg5ktCyap43I20qm++V62WTXfKZH/rrOBAjWhzo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mUYO4Hjq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B9E82C43390;
	Mon, 22 Jan 2024 16:33:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705941227;
	bh=D8qsa3J9fjuu62+bhhSC18gBPXhzCi2KQ8gRk9xdu2o=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=mUYO4Hjqo7auYG21X1oZRnD6ZFNtL/fM2PMlBHYFTWhn31V2xmGxf+2pma+F6opWD
	 5qxkr9rzOwoB3RJsYmlQsGitgyUuRC6uPVWaG7767b77aZKTFaeXSoEDdUslR1DlRZ
	 7o5V0x7Id1Zd2TsCz7SsmnAqeYjfv3/Px8UY1pTRK6rdVbeT6wHniSLKI2yDdnDPrw
	 1r5l28m2QRY/Ry/cTb16MKDoUMRJpny1vLJ7rtoL8PtM8aCTVxZiCYJ3SuXxZkMulw
	 5P+F2FbpAl7ij5EKZNvtTg2LsJ1GTn2qfXq98moQqhDIoTc+LXuMLzGDcQ0EgjYULM
	 z+p0K+VtrJCRg==
From: Mark Brown <broonie@kernel.org>
To: Peter Ujfalusi <peter.ujfalusi@gmail.com>, 
 Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, 
 Takashi Iwai <tiwai@suse.com>, 
 "Gustavo A. R. Silva" <gustavoars@kernel.org>, 
 Erick Archer <erick.archer@gmx.com>
Cc: alsa-devel@alsa-project.org, linux-sound@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
In-Reply-To: <20240109181101.3806-1-erick.archer@gmx.com>
References: <20240109181101.3806-1-erick.archer@gmx.com>
Subject: Re: [PATCH v2] ASoC: ti: j721e-evm: Use devm_kcalloc() instead of
 devm_kzalloc()
Message-Id: <170594122547.63484.16523787632492370599.b4-ty@kernel.org>
Date: Mon, 22 Jan 2024 16:33:45 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-5c066

On Tue, 09 Jan 2024 19:11:01 +0100, Erick Archer wrote:
> Use 2-factor multiplication argument form devm_kcalloc() instead
> of devm_kzalloc().
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: ti: j721e-evm: Use devm_kcalloc() instead of devm_kzalloc()
      commit: be69eae9673638583cfcad44c1da6abf91efc4a3

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


