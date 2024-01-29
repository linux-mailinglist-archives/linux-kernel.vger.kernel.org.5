Return-Path: <linux-kernel+bounces-43304-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DD1E48411EF
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 19:18:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8F2DD1F21EE9
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 18:18:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9895176022;
	Mon, 29 Jan 2024 18:17:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uJ77QawL"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC4A96F08F;
	Mon, 29 Jan 2024 18:17:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706552261; cv=none; b=X7a5bseOgxxWKYcFnsyG2PluW5265Ummxh0g+ptvinurTL09Sg2pAbp2xDlWXZwPosq+TXeicZ9cc67CFV+Z73Zdp3e6f+3XEIalFukSIycKfXN+RcJ0JFphfLn85c4zuge3lZlog5kDs7wjp3769B9+dgPL06ZtQG7WVojmNHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706552261; c=relaxed/simple;
	bh=49ZgUEVbVodDebsS/zs/njKL8YNT0LxkCXkY07rOi2Q=;
	h=From:To:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=k4uGZk78etCOtX2cg5RUj0FkzBnXqoeuUoUHjN3tzdMnLe37pecVxqquSG4d2ZH0Un5uStcmJY7V9eYmeYtHYbNBjzOF6IqZHt2jysYrvFTW1TkTXgQfP45LdoWlKf0wSgVjw+0Z549QkiENxx9gDcLt8Kd2B9KpN6rRreDF8BM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uJ77QawL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB6A6C43601;
	Mon, 29 Jan 2024 18:17:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706552260;
	bh=49ZgUEVbVodDebsS/zs/njKL8YNT0LxkCXkY07rOi2Q=;
	h=From:To:In-Reply-To:References:Subject:Date:From;
	b=uJ77QawLFCLXhAKhL+/R9BAXsDobzt7ItBEfu00BhM77MaS8DU1T894kzP5QZyrev
	 2MZVMx4z2nale4XdFwYkafdHvYnrPGjk4FPUAr3gF+xgj3znJBbqmFO/RF4RHIf75X
	 QYqLqSJHOVg7suDPWVOtTjeSS/He3YB8Ltw9BnPtmYojMK1Uoh+a8zU4xQiOhtfok0
	 +8wunBZOtLf+TuvNMLwJFsCqDqew++wgZV3pRCR3iHkdEfnYyrCHqDoDTPVdpbPf8I
	 s5WCv7WznGSuOI7BMJn8daxwMrMBEHEkD5uqvDjfV4mVMtwMIjviVZ81r/r3fR/NCc
	 X5PKXiTPl3TVw==
From: Mark Brown <broonie@kernel.org>
To: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org, 
 =?utf-8?q?Ahelenia_Ziemia=C5=84ska?= <nabijaczleweli@nabijaczleweli.xyz>
In-Reply-To: <lq6gstev3sd7i4iw2btiq3gg7lhsraj5w74fkbp6lpbl6nkyff@tarta.nabijaczleweli.xyz>
References: <lq6gstev3sd7i4iw2btiq3gg7lhsraj5w74fkbp6lpbl6nkyff@tarta.nabijaczleweli.xyz>
Subject: Re: [PATCH] spi: Kconfig: cap[c]ability
Message-Id: <170655225943.66398.6005857144828431709.b4-ty@kernel.org>
Date: Mon, 29 Jan 2024 18:17:39 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.13-dev-a684c

On Sun, 28 Jan 2024 06:53:19 +0100, Ahelenia Ziemiańska wrote:
> 


Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: Kconfig: cap[c]ability
      commit: 8613dda6af8ee1e8675a37c86bf8d4661d24bf14

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


