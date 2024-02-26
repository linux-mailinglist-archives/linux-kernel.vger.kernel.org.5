Return-Path: <linux-kernel+bounces-81996-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DAF8867DAA
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 18:11:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5B766B319EA
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 17:08:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EA8F130AFB;
	Mon, 26 Feb 2024 16:56:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pdAVHgWR"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7BD212C7E1
	for <linux-kernel@vger.kernel.org>; Mon, 26 Feb 2024 16:56:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708966592; cv=none; b=tMacgHqEaF0bjDPvkFs1CdlNsY85FaIvBUeh8alnrUL+Fji2n/PrNtTAPoQXfRdQpFyhJLPn0/QXdJeia1xnU6tzU5H8goeEhdrTqVtkFxfyO1HFf2r0Kc4lj+FOCCJwOdO31bFx0H/zneOtpqqzIH8bkVUEmERMr3pzTdCEOgY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708966592; c=relaxed/simple;
	bh=WJZ6wsDwgXxGIUBnlzspFyzPh0Ar2Fb0WGsY15dqn7s=;
	h=From:To:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=Cv/I3q4J3lHlKmX41jJ4E7W5MaLzdMHmB0YVfeAxrfuxsRgSPRQlz+CDnxUfyI+XQ3TO7JFzkeY2uMky6K+YXCopSexPvtDmwQyMMBgBPafoHDvWF6vcxiwXaGroG0umd1No0RrlQ5DWdZ8Z14MIkAB2hKsXjTfpiHu9gatrefU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pdAVHgWR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02CD0C433B1;
	Mon, 26 Feb 2024 16:56:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708966591;
	bh=WJZ6wsDwgXxGIUBnlzspFyzPh0Ar2Fb0WGsY15dqn7s=;
	h=From:To:In-Reply-To:References:Subject:Date:From;
	b=pdAVHgWRTJbKS9uISzKrFvBsOby9c30PjDtYXzQ6WOUltXgOFuZlNOaKd3nAR+7Ng
	 XNjyTVnJENJJCekHwQIBf+ZInievx1NjdFxgb3qtx5ph+RxAlxJ4qwH1Qy3pmUXPCR
	 Cnmxb7wHZiUwLeF4S8Dq6D3S/5Vl0vekLr3HkHddIhMS81wNEhyaVCbK/iw3evzvPP
	 JPtoICz/gzxegcKmCmdejv40xg0oGZMSRF6Tyf7sdC+EVEA2CrBkztIt+/fhd/7lj9
	 PheKn9i2n7HJj3xfE910m3d39O5CG6udlPxosuxr5QDcClxSr9eqaan61YZcHMAwdS
	 FjglB3HioU9jg==
From: Mark Brown <broonie@kernel.org>
To: linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
In-Reply-To: <20240225-regmap-test-format-v1-1-41e4fdfb1c1f@kernel.org>
References: <20240225-regmap-test-format-v1-1-41e4fdfb1c1f@kernel.org>
Subject: Re: [PATCH] regmap: kunit: Add a test for ranges in combination
 with windows
Message-Id: <170896659074.58811.16405947197376210469.b4-ty@kernel.org>
Date: Mon, 26 Feb 2024 16:56:30 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-a684c

On Sun, 25 Feb 2024 19:49:25 +0000, Mark Brown wrote:
> In preparation for taking advantage of the SPI support for pre-coooked
> messages add a test case covering the use of windows on a raw regmap,
> unfortunately the parameterisation prevents direct reuse and we will
> want to add some raw specific coverage anyway.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regmap.git for-next

Thanks!

[1/1] regmap: kunit: Add a test for ranges in combination with windows
      commit: bb92804ba2b6636e28db05f589a9a8ef62a07917

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


