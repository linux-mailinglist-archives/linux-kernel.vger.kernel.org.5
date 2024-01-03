Return-Path: <linux-kernel+bounces-15981-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 37006823689
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 21:25:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E084B1F22515
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 20:25:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FCA51D541;
	Wed,  3 Jan 2024 20:24:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UsfZ5GLY"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D9481D530;
	Wed,  3 Jan 2024 20:24:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8DDEC433C7;
	Wed,  3 Jan 2024 20:24:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704313495;
	bh=7vxiVQamR3pRKvlcOZeP+eFNosrKWWV5Djb3Z0x4Wa4=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=UsfZ5GLY4QmiNBLcKHbUuoGVupm7p8Kps4Q30yw/O78ZuO1Rp+Nk0o4JmditS5dAC
	 EpZKGZLk3FPOk/mDj2JbHjPPdXTeD/EeT2GC9Kyyq2xFbrJD5jlz5c+gfXTsTTv1ge
	 L2Zpc5ldsfTj2lMupkyHNhu4tH0KGt8U+XGjyu0xqjZXomchIQ3PsMKHo1F91+EkPO
	 Ca8xH1Bg1TSSQlnum6PqcpK6Hy5gbbGd+qE+cwprYoDdTzDWwSArztU8rVJZ5AplRj
	 1YnPmqBKB6NGZKEHMuZIu6+lWG5uuhUOA/4l2BKL5JKLFpaKUZsXgrF206ZqZ9pO/U
	 MNllPsFqa+A2A==
From: Mark Brown <broonie@kernel.org>
To: Jerome Brunet <jbrunet@baylibre.com>, 
 Liam Girdwood <lgirdwood@gmail.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Kevin Hilman <khilman@baylibre.com>, 
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>, 
 Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org, linux-sound@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-amlogic@lists.infradead.org, 
 linux-kernel@vger.kernel.org
In-Reply-To: <20240103-meson-enum-val-v1-0-424af7a8fb91@kernel.org>
References: <20240103-meson-enum-val-v1-0-424af7a8fb91@kernel.org>
Subject: Re: [PATCH 0/4] ASoC: meson: Fix issues with LibreTech Saphire
Message-Id: <170431349265.3159626.5476717975051420559.b4-ty@kernel.org>
Date: Wed, 03 Jan 2024 20:24:52 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-0438c

On Wed, 03 Jan 2024 18:34:00 +0000, Mark Brown wrote:
> This fixes a few issues I identified when integrating a LibreTech
> Saphire (based on S905D3) into my CI.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/4] ASoC: meson: g12a-toacodec: Validate written enum values
      commit: 3150b70e944ead909260285dfb5707d0bedcf87b
[2/4] ASoC: meson: g12a-tohdmitx: Validate written enum values
      commit: 1e001206804be3f3d21f4a1cf16e5d059d75643f
[3/4] ASoC: meson: g12a-toacodec: Fix event generation
      commit: 172c88244b5f2d3375403ebb504d407be0fded59
[4/4] ASoC: meson: g12a-tohdmitx: Fix event generation for S/PDIF mux
      commit: b036d8ef3120b996751495ce25994eea58032a98

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


