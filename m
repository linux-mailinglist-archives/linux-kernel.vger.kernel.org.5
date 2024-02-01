Return-Path: <linux-kernel+bounces-48257-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D2B1845932
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 14:47:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 574FA1C231A6
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 13:47:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C90D75F487;
	Thu,  1 Feb 2024 13:46:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GguYjvij"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19D885F49A;
	Thu,  1 Feb 2024 13:46:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706795180; cv=none; b=jHvjwnh7BEvwZnhKJ5NYX/bD3eAGQDUxiiJLzfQFQU5LT5UhwJsJVIn4wPqR4jqu/lltjFMzguwp16VwIFC1q9hgpllWhLpkr5NPJ7E/YgndJKFqOhvLmHcWq+Qz+CESYomMijc6oRsHcS1ca+Z5WqLs5CSuV29D97obDvzL88Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706795180; c=relaxed/simple;
	bh=mgkZCQe2ZfC4Vr+cDksWu3g9ll9f/vF9teBjp5C+U10=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=Swg3Tmj4ppXU3Ot0Oe2ghBgeUDn/x2Z5Yx/+NJ4txOHLNRrWyCC4n0lKE6cb1+P/qSK2Y2bb88vmzQgXqCw12oOzgI5hhTGCP/wS0KJCeidieBOlhQTlwRBsvToRNCD8qmf7ouvJAsYJyS6J1gH1nDBhteELOhQu3ZPS3i4yZLg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GguYjvij; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E3CC0C433F1;
	Thu,  1 Feb 2024 13:46:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706795179;
	bh=mgkZCQe2ZfC4Vr+cDksWu3g9ll9f/vF9teBjp5C+U10=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=GguYjvijDtxr2EayWPON19C2uI9BKESmTgVslpl5TwXeMHgqmmCZv1jUXTe6n/aQL
	 airLKDzFFekksM3KEWfTvlwFB+MHox9CeRztnmYvGksCn45RDreOOyGiFqCuxGWGgI
	 UvsAR0a1cyaBCemW6jrg7Y2IM2fi/Jxxgv+cdO0ck0nivuIjedCJ7c8kDyudQ1f7mb
	 mlSur0NeV+OnQbSflQvZqGJ6ohf1r63pbfg/Z15uMAglRQKFMv4f/8lE31SewAKa6J
	 WuKHdWAVzv+oscxfttIWq4Lgj3ulh9lEmGJeg13j4SjYKmCvEITf0GLtcK3sSIej06
	 xj2ORJGd265uw==
From: Mark Brown <broonie@kernel.org>
To: David Lechner <dlechner@baylibre.com>
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20240131170732.1665105-1-dlechner@baylibre.com>
References: <20240131170732.1665105-1-dlechner@baylibre.com>
Subject: Re: [PATCH] spi: reorder spi_message struct member doc comments
Message-Id: <170679517864.44749.10082747405846291000.b4-ty@kernel.org>
Date: Thu, 01 Feb 2024 13:46:18 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-a684c

On Wed, 31 Jan 2024 11:07:27 -0600, David Lechner wrote:
> The members of `struct spi_message` were reordered in commit
> ae2ade4ba581 ("spi: Reorder fields in 'struct spi_message'")
> but the documentation comments were not updated to match.
> 
> This commit updates the comments to match the new order.
> 
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: reorder spi_message struct member doc comments
      commit: e6c5812dc4d0b3e890608cb9c98597d1bed7e937

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


