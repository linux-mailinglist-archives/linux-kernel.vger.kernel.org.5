Return-Path: <linux-kernel+bounces-1292-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A4B2A814D00
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 17:27:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 44B561F24671
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 16:27:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 623F03BB25;
	Fri, 15 Dec 2023 16:26:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aWdiXOGv"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B01793C46A;
	Fri, 15 Dec 2023 16:26:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9644C433C7;
	Fri, 15 Dec 2023 16:26:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702657617;
	bh=dswOV6HcH9vvtiVIq8Rlgif+j3un84bC6L/Pr49F214=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=aWdiXOGvEG6pI+3xoEXeoPqsm5TrVy3R1fsZVvdwcZ1D18p/4BgNAMUfybVosvSLi
	 ISJIT1QLznvvRYkBijXjP08s8RlrwZb29gDpKmcSAixQLSxukCwOg1m9ADoqcCZrIZ
	 6umb516rMj00RHYKoiT/fXczcv4J0MHRBoEkKa4EsbUW+LP7C13uyPmaZbul7aXHaW
	 +78JmJVvlgdVDdiYwmChMyVE9bsAXBB9gBfCe7Cvk59XlBqOnglkrobcVaWU7ZT1bb
	 6pAu46vbJEA/z0HyegRaqnlArK9GYuChq9Z0GMt1R1NXXYVn6c8DkJQ+rlgocjCrjg
	 UTMWLD+lT6ekw==
From: Mark Brown <broonie@kernel.org>
To: linus.walleij@linaro.org, linux-arm-kernel@lists.infradead.org, 
 linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Nam Cao <namcao@linutronix.de>
Cc: kernel test robot <lkp@intel.com>
In-Reply-To: <f06a9b6eac184cc648ae7444c480add6da87a84d.1702639801.git.namcao@linutronix.de>
References: <f06a9b6eac184cc648ae7444c480add6da87a84d.1702639801.git.namcao@linutronix.de>
Subject: Re: [PATCH 1/2] spi: pl022: delete description of cur_msg
Message-Id: <170265761567.87261.2454124954064239265.b4-ty@kernel.org>
Date: Fri, 15 Dec 2023 16:26:55 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-5c066

On Fri, 15 Dec 2023 12:33:37 +0100, Nam Cao wrote:
> The variable cur_msg was removed, but its description is left behind.
> Delete this description.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/2] spi: pl022: delete description of cur_msg
      commit: e695c1fc5a3db1e161abe8061d715a504aff3f9f
[2/2] spi: pl022: update description of internal_cs_control()
      commit: 644f315d12ea29a67bc985d06ab0962452eb3605

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


