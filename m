Return-Path: <linux-kernel+bounces-82269-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 719CF868178
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 20:51:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F140D1F251F4
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 19:51:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4F02130ADD;
	Mon, 26 Feb 2024 19:51:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a65+NByE"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 378DC12FF76
	for <linux-kernel@vger.kernel.org>; Mon, 26 Feb 2024 19:51:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708977087; cv=none; b=kQ8JgPwDrgFsrS9gVCqyKEcfPkjaSjs49mmvtl5fXxbhoxY/NxLj9U4UNrujMLzEzl2PhqIDoZZlUsywmjjD9OmFInOE30GKd/wcu4L6kwYtKRC+P4ujYRWGMW4bTaZx9BwwsiXz3+8l7yu8ggDpn6xCcIEIyVMfsonM/mA3vpA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708977087; c=relaxed/simple;
	bh=sWelx89DM1Lt1LXndbDBZHqht2mSf708l8xhGVLbqho=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=kv07d0gyC/M1cC/TH5/9DCD9vzdo1KT0kt2aOksLpLS0Jupsd4kVkSsXtYVjUbWXSUr1VK67nc1GHlldraVWz5GJVh/GKJddeNxjTklUmzxKoy/IzUSpt9A+vgp0Q81bpHdSJBrAQ1XcaDyZD5w/mk+MTdxWGGs/vz2yxBgED6o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a65+NByE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E59C0C433C7;
	Mon, 26 Feb 2024 19:51:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708977085;
	bh=sWelx89DM1Lt1LXndbDBZHqht2mSf708l8xhGVLbqho=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=a65+NByEpbHRHjLj8DIteMqzQ3/fYCSqg/xxy/g8xXnuEdimliqvJlb1W/AOnFusV
	 CMxAUFm+AH2eWFoi9zkZSZRNCInyuzLKF6QaMCJU/byvPXhrZdwzhJgiZAF+33NRFh
	 kpk5idA9jr3/yizEMOUifRcKRvnGhF5UYQJeA/keyWmtEJPmMAPv4hU/yRLfVxeml3
	 Pe0OVQ3NsuHObMmUFIXEEvkUPWi/LJYOHQg2UYEfA+DrKBfy07rvhtBpbFHONgTHdN
	 t58eN5QlHbmHd89zp9jPlehZKe5+whISTPwUfjvMek2Ymtkbzb3WYrkIatT7q9x+pJ
	 T+IJPHrv4gq5w==
From: Mark Brown <broonie@kernel.org>
To: linux-kernel@vger.kernel.org, John Keeping <jkeeping@inmusicbrands.com>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Zev Weiss <zev@bewilderbeest.net>
In-Reply-To: <20240226160554.1453283-1-jkeeping@inmusicbrands.com>
References: <20240226160554.1453283-1-jkeeping@inmusicbrands.com>
Subject: Re: [PATCH] regulator: userspace-consumer: add module device table
Message-Id: <170897708467.124661.5920836739900608106.b4-ty@kernel.org>
Date: Mon, 26 Feb 2024 19:51:24 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-a684c

On Mon, 26 Feb 2024 16:05:53 +0000, John Keeping wrote:
> The userspace consumer can be built as a module but it cannot be
> automatically probed as there is no device table to match it up with
> device tree nodes.
> 
> Add the missing macro so that the module can load automatically.
> 
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git for-next

Thanks!

[1/1] regulator: userspace-consumer: add module device table
      commit: 531a0c0cdbff9cecf41073220a826f8b1132f9ab

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


