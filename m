Return-Path: <linux-kernel+bounces-94019-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E84F873884
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 15:09:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B3DED1F22F66
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 14:09:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 065B6132C1F;
	Wed,  6 Mar 2024 14:08:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OfmRchC8"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EA70131E27;
	Wed,  6 Mar 2024 14:08:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709734128; cv=none; b=PlCIYHDSrpH0ZTeAANCW+tCSSNXmEonZWcLb2RH+xMS0A8HJfByxvbqI7Zq0aGvQmW9Dpt0uy2lWn/MiucTs0UY0IUQvWsCUSHOsXCZVrZrH27FrI4lOptLdf7TkhWDqxNGPMEsR7kQYYkmPVnL6bQPMELL1e8QQevfhY0QDc0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709734128; c=relaxed/simple;
	bh=RG0W/+RUSiHi+MbIBgdiFtijyxDD7F+zc1eridG9d5I=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=DyAbGuj9oiWvnq0CUwKktXJoKOLd29B0rqiCB5dlv8mSs2Tp7dtsoO2+klpf8jmrA5rt3wWhdjv1yy4ISKKjTVzrT+zqz/91sqHGf9sLRDnuMkYrEhjadS5zV7u8/6ZVm+a4Xk1SbntlCljYDmRAlysd5O3LU58eGOW/1AodsZ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OfmRchC8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2681C433C7;
	Wed,  6 Mar 2024 14:08:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709734127;
	bh=RG0W/+RUSiHi+MbIBgdiFtijyxDD7F+zc1eridG9d5I=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=OfmRchC8sHDnTnzGcRHVyPhc0Uy5pNu9t3KdG12ZlnGyxWWrBVDK2K9j/J6ZFgsMF
	 4c/J16xwc83sM4siFxZ3EwBhrI73xyZa+2oYaCcRfwWgKT7cHMGm6MTNrcKiQSJwT+
	 8BbJrkAWkNITxbecpq1Hp4xGey1oHAs58jC4X7sP6dBdzfSOaxR3Eeb/6WhJFCt+Qd
	 VK8YJrXJu25HthQyv0/XDmYzp16evOdwnXnQehU07CXGHPKUW47oJUHXI20jBsVlaw
	 B/HhDzdxlj3KM3hk43t2nOA4owjNpF6pRb1aL6FU5eCMWolGU5KN2dgESGNF5SnpTn
	 Lxp/SwUtPCtpg==
From: Mark Brown <broonie@kernel.org>
To: robh@kernel.org, andi.shyti@kernel.org, krzysztof.kozlowski@linaro.org, 
 semen.protsenko@linaro.org, conor+dt@kernel.org, 
 Tudor Ambarus <tudor.ambarus@linaro.org>
Cc: alim.akhtar@samsung.com, linux-spi@vger.kernel.org, 
 linux-samsung-soc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-kernel@vger.kernel.org, andre.draszik@linaro.org, 
 peter.griffin@linaro.org, kernel-team@android.com, willmcvicker@google.com, 
 devicetree@vger.kernel.org
In-Reply-To: <20240216070555.2483977-1-tudor.ambarus@linaro.org>
References: <20240216070555.2483977-1-tudor.ambarus@linaro.org>
Subject: Re: [PATCH v3 00/12] spi: s3c64xx: remove OF alias ID dependency
Message-Id: <170973412458.162474.13178252432739879797.b4-ty@kernel.org>
Date: Wed, 06 Mar 2024 14:08:44 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-a684c

On Fri, 16 Feb 2024 07:05:43 +0000, Tudor Ambarus wrote:
> The driver was wrong as it assumed that the alias values in devicetree
> have a particular meaning in identifying instances. This immediately
> breaks when there is a dtb file that does not use the same alias values,
> e.g. because it only needs some of the SPI ports.
> 
> Tested gs101 SPI with spi-loopback-test, all went fine. I updated
> exynos850 as it uses the same USI.SPI_VERSION as gs101. Maybe Sam can
> test exynos850, if not, we can drop that patch (12/12).
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[01/12] spi: dt-bindings: introduce FIFO depth properties
        commit: 80a38bfbbd5965c8bda73b20aa78d308739bbc31
[02/12] spi: s3c64xx: define a magic value
        commit: ff8faa8a5c0f4c2da797cd22a163ee3cc8823b13
[03/12] spi: s3c64xx: allow full FIFO masks
        commit: d6911cf27e5c8491cbfedd4ae2d1ee74a3e685b4
[04/12] spi: s3c64xx: determine the fifo depth only once
        commit: c6e776ab6abdfce5a1edcde7a22c639e76499939
[05/12] spi: s3c64xx: retrieve the FIFO depth from the device tree
        commit: 414d7b8c9147db7dc34c0e2bae2e2361b922dc07
[06/12] spi: s3c64xx: allow FIFO depth to be determined from the compatible
        commit: 82b98fb8cd33db7793e3e695c44e4e75bca03b3e
[07/12] spi: s3c64xx: let the SPI core determine the bus number
        commit: e08433e095dda8b5e44c376648dbf65c6fb6771a
[08/12] spi: s3c64xx: introduce s3c64xx_spi_set_port_id()
        commit: 2cda3623ff4f002877a81f4e7a4c3401fd98aa2d
[09/12] spi: s3c64xx: get rid of the OF alias ID dependency
        commit: ea3fba7c41babda225fea324a72d171be9ff6de6
[10/12] spi: s3c64xx: deprecate fifo_lvl_mask, rx_lvl_offset and port_id
        commit: ad0adac84d42b693295f4bde407d9f20c9a694ab
[11/12] spi: s3c64xx: switch gs101 to new port config data
        commit: e8b16c7a420420a994f68c181abc4a82dcca0616
[12/12] spi: s3c64xx: switch exynos850 to new port config data
        commit: 7ad288208d24e42047e5bf0b88271684a32aa967

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


