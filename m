Return-Path: <linux-kernel+bounces-118994-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D6A1088C25F
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 13:40:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 139131C3FBCC
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 12:40:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27EAA74BFB;
	Tue, 26 Mar 2024 12:39:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OrPLYl2F"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B04C745D5;
	Tue, 26 Mar 2024 12:39:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711456758; cv=none; b=Q81zVNtR32g4G0KNmqvU+oWVF+dEfjBTrS0NzNb5oaneG71S7Qufl2etEGFMYYlrI7AX6sIkg36XccPSncamyba7nlYTkKc2SZuPA7AmGV+Wfcp8EHJl4I1/wPPZwq0wWq//h5H0Jye0yuZLH3Y5hqGWYCrN0+v0FGfCYeyODh0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711456758; c=relaxed/simple;
	bh=QMvV+aytPVJmhFci7hk6Ko5lSwY2pJF8sC4QE4BcCWg=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=t4f6fxGhfSvgg8mWNZ82+WjJpn83k/VNKUzDoODCCj55QRKZOigA+povGZ9jkrqwho4bxF4q5SYEfOdjDHwXfUlPQhRYNUi/+8sJRjyNiAOFaaQu47TX4QNtN2w/nrtcHExG5lC6u46iBkUsdzfQonHuiDWMzkzs0Ok6GPDIyjE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OrPLYl2F; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D7D09C433F1;
	Tue, 26 Mar 2024 12:39:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711456758;
	bh=QMvV+aytPVJmhFci7hk6Ko5lSwY2pJF8sC4QE4BcCWg=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=OrPLYl2F0OYKwXK4qRH3euv7c43W2xM9R0V99W2s81E1tfM4nuhq7j1VnJsSfVDKv
	 1tpDAnjW1n/XmuUpBDF32iHmXV6SVyqpKWkJRL1pn7tWU2rUYqIE1w6o34NnAVhLEE
	 pL2mOaTCn4ukBCi2r9vySfi0PUIC9LVBav5uwJWtLHuCY45YnAFeAZ8tka9yDTYnEW
	 z/SZzPd+TBChidByOqTmUzKsZgg4pVxewhmGdWBBlh+5W+siCb3iu18lGZZFSGQyOv
	 qn/wfUZyXonlgjlwOLqDQw4CAPHMynCpKVQkjmwzZFBbf1XJ7KzXvYAO7ufkQIiFFp
	 qoIf8DfMHHSKA==
From: Mark Brown <broonie@kernel.org>
To: linux-spi@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-kernel@vger.kernel.org, 
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Michal Simek <michal.simek@amd.com>
In-Reply-To: <20240308162920.46816-1-andriy.shevchenko@linux.intel.com>
References: <20240308162920.46816-1-andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v2 0/3] spi: xilinx: Massage xilinx_spi.h
Message-Id: <171145675653.65249.1296672837105512587.b4-ty@kernel.org>
Date: Tue, 26 Mar 2024 12:39:16 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14-dev

On Fri, 08 Mar 2024 18:27:45 +0200, Andy Shevchenko wrote:
> Fix kernel documentation and inclusion block, and dropping the size
> of the num_chipselect.
> 
> In v2:
> - added tags (Michal)
> - reshuffled fields better to avoid gaps on 64-bits (Michal)
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/3] spi: xilinx: Fix kernel documentation in the xilinx_spi.h
      commit: d650d1c46d8471bf8ebf556629ac13077f13e647
[2/3] spi: xilinx: Add necessary inclusion and forward declaration
      commit: 8f40647d87610ecff6637d673024fe7bd045c913
[3/3] spi: xilinx: Make num_chipselect 8-bit in the struct xspi_platform_data
      commit: a39111b1cf0864b1782f30f9a1fa65260d057327

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


