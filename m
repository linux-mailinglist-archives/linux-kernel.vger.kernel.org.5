Return-Path: <linux-kernel+bounces-162599-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 459798B5DF4
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 17:44:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EA3B6B243BE
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 15:37:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B893839F1;
	Mon, 29 Apr 2024 15:37:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U2aUTXJ0"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67CA87BB17;
	Mon, 29 Apr 2024 15:37:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714405039; cv=none; b=LZiCASTHqW4z3GwZcaZ/LwzEOhThostncG7VdrcHsvbGcfj/evWfh6D/TRqUuyUeCoCXRhmkiNfN386Mzi989JXvdmVVSESqMaIxxaU0F4iKas4a1CTOUvMdYhGCPJXwBphy8T1knDVedVVrPLUFhaOjg22ZJmUfsiacTJ4OJvw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714405039; c=relaxed/simple;
	bh=wkw00x65JD2z/zUy53Xusx3TmiNHgV4aXrSReAeslNU=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=Px5oueUpA5Dup0VmfN7Vq1HXtX+8PM34DqKAsSHF283+m9TMFRPSVoz6CZ02jqPeG8qaiHn1qlmhBn0YQhe/rxsHnVMrPSmMxD5zwXNofZHuclyZUpRgSQY+2VGFiwPYt2+Qo4mvqJIGllUORbwXnly3k14fkEjSMiJLwA4isJE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U2aUTXJ0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B500C113CD;
	Mon, 29 Apr 2024 15:37:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714405038;
	bh=wkw00x65JD2z/zUy53Xusx3TmiNHgV4aXrSReAeslNU=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=U2aUTXJ0qBqnfV1G4kuhMFIHzs54ReUNSO9gdQNtg4aGDsfvXSEOuTceTJIHCrepO
	 enWS0OujmfpxwX44YIbD/uwDAXH+g3thvf3iqnDonevsW/ibWuO1issIRj68s6X5ep
	 TuOLh/uOmVlCl7Wc29Ak4CUQKxvedSO5ft1qKfGJng0yCptHMPdODDhJzQLQjsfs/l
	 wlvhb5J02hOJeMsxzxw6t/D8G4UL3WC/yHXQ4fssWwT8BLkn9jLpWH1Z7kkNmXwYGr
	 IjPG1cDEH5VNXTaduRwcJHGacrVRQzzcKpy3euQrZsOX1H03TxYl2IyQ08YvZ9n/nk
	 EvBLVSqx4zzmA==
From: Mark Brown <broonie@kernel.org>
To: Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, Vaishnav Achath <vaishnav.a@ti.com>, 
 Thomas Bogendoerfer <tsbogend@alpha.franken.de>, 
 Rob Herring <robh@kernel.org>, 
 =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
Cc: linux-spi@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-mips@vger.kernel.org, 
 Vladimir Kondratiev <vladimir.kondratiev@mobileye.com>, 
 Gregory CLEMENT <gregory.clement@bootlin.com>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Tawfik Bayouk <tawfik.bayouk@mobileye.com>
In-Reply-To: <20240423-cdns-qspi-mbly-v4-0-3d2a7b535ad0@bootlin.com>
References: <20240423-cdns-qspi-mbly-v4-0-3d2a7b535ad0@bootlin.com>
Subject: Re: (subset) [PATCH v4 0/6] spi: cadence-qspi: add Mobileye EyeQ5
 support
Message-Id: <171440503607.1841738.5217862939003945939.b4-ty@kernel.org>
Date: Tue, 30 Apr 2024 00:37:16 +0900
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.14-dev

On Tue, 23 Apr 2024 12:01:39 +0200, Théo Lebrun wrote:
> V4 of this series adding octal SPI-NOR support to Mobileye EyeQ5
> platform. It has been tested on EyeQ5 hardware successfully. Patches
> have been taken over time, meaning series got smaller over time.
> 
> Patches:
>  - Make cdns,fifo-depth optional by computing it from hardware.
>  - No-IRQ mode for indirect read operations. Behind a quirk flag.
>  - Busywait on commands and indirect reads; reduces hrtimeouts load.
>  - Add mobileye,eyeq5-ospi compatible.
>  - EyeQ5 devicetree:
>     - Add octal SPI-NOR node.
>     - Add SPI-NOR flash node on eval board.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/6] spi: cadence-qspi: allow FIFO depth detection
      commit: 3bf64a2b66edffd28614b004648ccd60e3139c9e
[2/6] spi: cadence-qspi: add no-IRQ mode to indirect reads
      commit: 1f257b92e6330d576cc826fb8f0b74fe0e8209de
[3/6] spi: cadence-qspi: add early busywait to cqspi_wait_for_bit()
      commit: c1887396373b8faecef61d352bd521ac66162706
[4/6] spi: cadence-qspi: add mobileye,eyeq5-ospi compatible
      commit: 47766799f546249813e97a0ccde8978ba114e89f

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


