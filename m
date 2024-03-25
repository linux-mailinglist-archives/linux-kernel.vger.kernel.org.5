Return-Path: <linux-kernel+bounces-117927-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C5E4E88B165
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 21:30:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7F03F2C4427
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 20:30:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8FA04E1A2;
	Mon, 25 Mar 2024 20:30:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NMzq9x/B"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA2DF495FD;
	Mon, 25 Mar 2024 20:30:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711398602; cv=none; b=AHLpPoFNh89QOzROSdQja5eJdYJS+5aWS2OBUFAwxXePhLEpiRwRofTcKJnhH5s/AdSc7X5ycbTWOapHRv2hYG7QkpOfDb7RibqU32TcDFh2eEKr65uJPMh6ixDzhWArgHJ6+GG3y4imUIOhWCIhKgs3qfrzGI6qGNXWiG5uPSE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711398602; c=relaxed/simple;
	bh=nT5+aUKI6Dug+L78q2tWnezBjghHEOaZ8JFTxvYy/T0=;
	h=From:To:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=KNmeV3v9EBVbfHgS6l3gbLCa8X3fm1HXqyBBHrnvIa2rbplAAMDVSXVQl5uwLI6PjzRtvFklfRt9Q9Ra4eVy8NoM7jQEHcZ/uY29+aARftgwPVg88SFhh+WlZUpMODd5NaqdfVn3ZbUlyDBYApeYgfrJAcvf8GPTUeweSvw/NGY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NMzq9x/B; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C35A7C43390;
	Mon, 25 Mar 2024 20:30:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711398601;
	bh=nT5+aUKI6Dug+L78q2tWnezBjghHEOaZ8JFTxvYy/T0=;
	h=From:To:In-Reply-To:References:Subject:Date:From;
	b=NMzq9x/B/TvuHFOdRkHUio44CG24lY4QODx9bUrlBxe9Y1zG2Mqc6KtURVwrqolur
	 +p11qdewAwUV9eFFfj/8WjbauXixUg4wBAnyigd9vjrH+XPexBnLQ35PZu0JkBcZVQ
	 EHYO6B/4j2IQrl0d9dagAdvTCBzV7hwAjSHrNnnS2tLfLCU3i6aB5ALNe1F4EuedOc
	 G9zWg5645ijs/I+v1eci7UlMU9Otg9AcjhOs2pYfm+SUYTAsqxFqhUsyRR7P51/olX
	 QOuqQ3ejYvz12YHXzzZSGT2KkPb8u4qdc2p4dnNyvdvkiAMw7i6t5KywL89fN51h4O
	 5HAb3nDV1s1GA==
From: Mark Brown <broonie@kernel.org>
To: linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org, 
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>
In-Reply-To: <20240325142118.3210915-1-andriy.shevchenko@linux.intel.com>
References: <20240325142118.3210915-1-andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v2 1/1] spi: rspi: Get rid of unused struct
 rspi_plat_data
Message-Id: <171139860053.356390.383776514283618109.b4-ty@kernel.org>
Date: Mon, 25 Mar 2024 20:30:00 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14-dev

On Mon, 25 Mar 2024 16:20:04 +0200, Andy Shevchenko wrote:
> No in-kernel users of struct rspi_plat_data. If required,
> the software nodes should be used for such users. For now
> just get rid of it.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: rspi: Get rid of unused struct rspi_plat_data
      commit: bdeef5dcea6b164f4bd614655821b1ef12ebec9a

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


