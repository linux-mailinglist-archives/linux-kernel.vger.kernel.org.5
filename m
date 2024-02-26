Return-Path: <linux-kernel+bounces-82241-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A76D38680FB
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 20:28:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 46F811F2DA23
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 19:28:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E380212FF65;
	Mon, 26 Feb 2024 19:28:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XDn2P28F"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2ED8E12FB03
	for <linux-kernel@vger.kernel.org>; Mon, 26 Feb 2024 19:28:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708975705; cv=none; b=Oxgi2uPpWYcRiXMaw+vSNyg8dIk0ZRf2tKco4IztLFXLiFAm5U3n+LqmRXjjO0X0nNT9gdGkP9MN6psdHH+uR2YG9N0jmPeU4MswkyRhtcSDCLEHO1fNklZPW91LS7fLQJ2nXMNBKRk75lfGvq0/u+QCtx8Abbd85+TWI+26FFI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708975705; c=relaxed/simple;
	bh=w09eVwNl/udBZSm14ewjIAURwXfKkMekAoVbB7ELkK8=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=HLL1hhkZPLb4i5evzYsk96MdYQ0xrFvpgfAbOjyI3CqmhCID2yfAsgf3IwFsu8PTdp+wCuvfslVN6Sy+Dqt3NiatZnQx+CmEhVE8oBtTdRX61PAJ8mzJHTMx2XiNfBYMZu+4k39noEnT3IVD+gI4R4tzI1L3S1QelEmONl4qgG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XDn2P28F; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0AB5C43390;
	Mon, 26 Feb 2024 19:28:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708975704;
	bh=w09eVwNl/udBZSm14ewjIAURwXfKkMekAoVbB7ELkK8=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=XDn2P28FvP1BUb8/iHdXPrLLEU/UcXEvXdDNNArcIcqJZmopOzPChOLnkKiKAUbz+
	 CEO/zV216e0VjFSo1EC1Rr1j1BQwwcmRzHnCSefgLLFUvsFX93B7tWb2h5owJ7cvzP
	 C5fIRWg6+iD1/GsiKk6BG3mPMXvi42pwxqZoV/C6QUwMODC2pEdR5WfKDUD3VkgWHU
	 YvWaPutNbMJ/zAab0RAZp8eczvG8dfWNQ3srVwb92OgjuNdZNzoLm6YKSFVUgPQaOO
	 eOUaH8+EmPDYO8gVQK7cxttQtpmXlit5AvbP8uGv0FX4g74BbZBBj+7nIbCRiMI6ij
	 pQV0W0w4n4olw==
From: Mark Brown <broonie@kernel.org>
To: Liam Girdwood <lgirdwood@gmail.com>, 
 Jerome Brunet <jbrunet@baylibre.com>
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, 
 linux-amlogic@lists.infradead.org
In-Reply-To: <20240223175116.2005407-1-jbrunet@baylibre.com>
References: <20240223175116.2005407-1-jbrunet@baylibre.com>
Subject: Re: [PATCH 0/6] ASoC: meson: axg fixes and clean-up
Message-Id: <170897570345.121037.4947854271427341182.b4-ty@kernel.org>
Date: Mon, 26 Feb 2024 19:28:23 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-a684c

On Fri, 23 Feb 2024 18:51:06 +0100, Jerome Brunet wrote:
> This are various fixes and clean up gathered while working on Amlogic audio
> support. These help better handle higher and unusual clock configuration
> for TDM, SPDIF or PDM.
> 
> Jerome Brunet (6):
>   ASoC: meson: axg-tdm-interface: fix mclk setup without mclk-fs
>   ASoC: meson: axg-tdm-interface: add frame rate constraint
>   ASoC: meson: axg-tdm-interface: update error format error traces
>   ASoC: meson: axg-spdifin: use max width for rate detection
>   ASoC: meson: axg-fifo: take continuous rates
>   ASoC: meson: axg-fifo: use FIELD helpers
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/6] ASoC: meson: axg-tdm-interface: fix mclk setup without mclk-fs
      commit: e3741a8d28a1137f8b19ae6f3d6e3be69a454a0a
[2/6] ASoC: meson: axg-tdm-interface: add frame rate constraint
      commit: 59c6a3a43b221cc2a211181b1298e43b2c2df782
[3/6] ASoC: meson: axg-tdm-interface: update error format error traces
      commit: 48bbec092e4cf2fe1d3f81a889ec176e83aee695
[4/6] ASoC: meson: axg-spdifin: use max width for rate detection
      commit: a2417b6c0f9c3cc914c88face9abd6e9b9d76c00
[5/6] ASoC: meson: axg-fifo: take continuous rates
      commit: 8b410b3c46128f1eee78f1182731b84d9d2e79ef
[6/6] ASoC: meson: axg-fifo: use FIELD helpers
      (no commit info)

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


