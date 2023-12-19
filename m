Return-Path: <linux-kernel+bounces-5702-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D2230818E52
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 18:40:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7BF4A1F2681B
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 17:40:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE022341AC;
	Tue, 19 Dec 2023 17:40:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z2dYm+ha"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D92C2E633
	for <linux-kernel@vger.kernel.org>; Tue, 19 Dec 2023 17:40:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F316AC433CC;
	Tue, 19 Dec 2023 17:40:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703007607;
	bh=L8xVLwt3tQ6pvVAZtDRn+YjjyaVE28kTVZV7CXDYa+0=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=Z2dYm+hak2hURTsNsqQht2I++J/LQYXXZYuyxvkpjGVrCkumh4Tjf38Ng6uL0ihcj
	 Ed2EOp1BtioVKdFHLDDxykwwzKJFEu9vx+aWFYLTeBq7SpvIMEY5W0lmvIuIK57DeO
	 2GAIbSnMjfQ9WBGcC/+1uDciheyAqCJdfGxHh4hWutFw2noXODSSqe+MCUtem+RMH7
	 gjXeuVkHFuhi6coqdlaLLqXOB2Is0O4pHRvVLCNa4PNUOa01+7fQ5KUeqEy+7epuXh
	 U8QY73Ios8AMZQ1xH/aSaiVJl2xzqWKYeEd33/uvsrxXVT24v8qGIFkaynuYEpk8tu
	 NrGzZ5YJqziTg==
From: Mark Brown <broonie@kernel.org>
To: linux-kernel@vger.kernel.org, 
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Liam Girdwood <lgirdwood@gmail.com>
In-Reply-To: <20231219154012.2478688-1-andriy.shevchenko@linux.intel.com>
References: <20231219154012.2478688-1-andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v1 1/1] regulator: Reuse LINEAR_RANGE() in
 REGULATOR_LINEAR_RANGE()
Message-Id: <170300760670.114978.15420282865343212029.b4-ty@kernel.org>
Date: Tue, 19 Dec 2023 17:40:06 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-5c066

On Tue, 19 Dec 2023 17:40:12 +0200, Andy Shevchenko wrote:
> REGULATOR_LINEAR_RANGE() repeats what LINEAR_RANGE() provides.
> Deduplicate the former by using the latter. No functional change
> intended.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git for-next

Thanks!

[1/1] regulator: Reuse LINEAR_RANGE() in REGULATOR_LINEAR_RANGE()
      commit: 67ba055dd7758c34f6e64c9d35132362c1e1f0b5

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


