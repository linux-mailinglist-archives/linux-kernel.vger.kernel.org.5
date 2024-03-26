Return-Path: <linux-kernel+bounces-118997-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 55C2F88C265
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 13:40:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CB3B8B259D9
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 12:40:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 534B97640B;
	Tue, 26 Mar 2024 12:39:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NoEtvvvO"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9292C6D1D7;
	Tue, 26 Mar 2024 12:39:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711456765; cv=none; b=C6LZMgG4O0f/bT2SL1e8VBR5ZkZBRT4KZRSKEElv4y6tQarDWHL01tD1h1a6XqiiAwH3YhdFV45Y1LAG8G4sSLebqFq676yV9aSt+5fDHynju21aR/InbTBxfrJmJ46z08mQp51xxSMK3iHuAxIt0CVo3IvJoRHPdC9lcgiX9SA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711456765; c=relaxed/simple;
	bh=7ddt6lUGtTA1+vsIZ4ig2QEADYdCEfJrWG+WuVweeZQ=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=S8e47qWzoXffoiJ93HB3JT9XHJoL9jW36/3N/t+IXZ0Cmzvq/xZ2ij7+IUkhmIplPtr98vBPc496sP1UVONfsm6TF54/zcXMQf2lIGlO1bIOEJoRXNvVPHBkysOOSl5T8hup+hKlOtQsmmsxfLXSG69WdTLNUKjj9IJJ1HEg1ao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NoEtvvvO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2F64C43394;
	Tue, 26 Mar 2024 12:39:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711456765;
	bh=7ddt6lUGtTA1+vsIZ4ig2QEADYdCEfJrWG+WuVweeZQ=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=NoEtvvvOfYig66WXa/RVrTBZp8qHzQ0LgtUJVx3K68BqCzkW6z1al6Owu3SpTN3uP
	 sG+51MqmTaG4UXso0PhEz1m5jNJ6nLBqC+BiSnf74I/KydKJYYvY4OH/c+3OMloXKU
	 ex8gkHl3hxA7awh/qnjGA2VsHJji92dM3mM1bPI0pomX51YQf8650EJIKdp6ze/Iyn
	 sCGWxqhwSazWrU002inUyun/izYT/f8IyKU54EoLNR0wNjSR5qEziGek1bbNQ+NIg3
	 pXn2KibQyqOG0TcVzMaKn37W41DVr/inVvqAezRGqFycSz9wdNl2spDSHHuXDJ6d5L
	 q1QsPcJImGvBw==
From: Mark Brown <broonie@kernel.org>
To: linux-spi@vger.kernel.org, Raju Rangoju <Raju.Rangoju@amd.com>
Cc: sanju.mehta@amd.com, linux-kernel@vger.kernel.org, 
 Sudheesh Mavila <sudheesh.mavila@amd.com>, 
 Krishnamoorthi M <krishnamoorthi.m@amd.com>, 
 Akshata MukundShetty <akshata.mukundshetty@amd.com>
In-Reply-To: <20240229134544.3461757-1-Raju.Rangoju@amd.com>
References: <20240229134544.3461757-1-Raju.Rangoju@amd.com>
Subject: Re: [PATCH] spi: spi_amd: Add support for SPI MEM framework
Message-Id: <171145676359.65249.16490947965037901357.b4-ty@kernel.org>
Date: Tue, 26 Mar 2024 12:39:23 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.14-dev

On Thu, 29 Feb 2024 19:15:44 +0530, Raju Rangoju wrote:
> Add support to the SPI controller driver to use SPI MEM framework.
> SPI subsystem utilizing the SPI memory operations allows to re-use
> SPI controller drivers for both SPI NOR devices, regular SPI devices
> as well as SPI NAND devices.
> 
> Add below functions of spi_mem_ops to support SPI MEM framework
> - exec-op(): to execute the memory operations.
> - supports_op(): to check if the memory operation is supported.
> - adjust_op_size(): to split data transfers so that they don’t exceed the
>   max transfer size supported by the controller.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: spi_amd: Add support for SPI MEM framework
      commit: 6defadbe6cbc3a87dc39c119a6748d19bfba0544

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


