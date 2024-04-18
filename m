Return-Path: <linux-kernel+bounces-149370-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AA778A9030
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 02:51:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5A99E1C21098
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 00:51:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 748985CB8;
	Thu, 18 Apr 2024 00:51:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WKf+OguL"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B66444411;
	Thu, 18 Apr 2024 00:51:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713401502; cv=none; b=V8SPHiN/xkP3P9DmdkRa4AnP60SjbRGBcyhVquQ5IFiALU2TgpVSl1ImQGuKN/cflzdlCNrlAhOybBUpeB7J79lhjLufnNxpzIJ5fqmKJF0rWKltiKWDIO8PWc0wyDCPJ3+u/pGqSzt/0xj1lZokmR18T8CpY/m07sX/ocOB5S8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713401502; c=relaxed/simple;
	bh=mMCx+Q5ZhD8dntQuzq//+QwDx2PsSxKIUdRbMcDpWLM=;
	h=From:To:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=m3kPZDBM1slNjAuBgxz9R5HXheS9RGSXhQlhhhaJJHdqDSo4AayiNi4nTGWntJIeRIPnRqtlLInlWpVb1bhN2aPslqymxfGd0BkGHOOlsWluwfLMGWdfUcrEk7h7KHB1J+1Vgq67Wf0wsuqBcZJD//44t3H4xaD9SzjIbG0aIH4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WKf+OguL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4938FC2BD11;
	Thu, 18 Apr 2024 00:51:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713401502;
	bh=mMCx+Q5ZhD8dntQuzq//+QwDx2PsSxKIUdRbMcDpWLM=;
	h=From:To:In-Reply-To:References:Subject:Date:From;
	b=WKf+OguLQQ+TmOzEaXzWP9IdL+Qru1u7iFeAYUnMqUswylLRvZbLbENHh9ZBjjwlX
	 0z5XQT+AcZRyT/+7s+URchFYpVqvhX6tz+DKM2Uzl2xXB+gVHBBvb275nL+Qg8/GCI
	 hTxiPp+qqEeRSE8bYWMyzF4R0jde7EdJEGwFoXUq4aQxO4lgQX1GapTH/h5jI66PCD
	 t5WYaXspdszdrqo6TVWuEX1OEsD22MfdZDmwd6SoC0akrf3QrSzwn0xbTai3DoV2MR
	 zBXNpSlv37Bjp3bRyt0O2WX6SytcfWNP/Nzz/RTXU335IWgTxp4jN3vqeTQTq5qZNH
	 VfcV+qDOehlbA==
From: Mark Brown <broonie@kernel.org>
To: Yang Yingliang <yangyingliang@huawei.com>, linux-spi@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>
In-Reply-To: <20240417104730.2510856-1-andriy.shevchenko@linux.intel.com>
References: <20240417104730.2510856-1-andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH, resend v1 1/1] spi: oc-tiny: Remove unused of_gpio.h
Message-Id: <171340150106.1715024.6887354681093706976.b4-ty@kernel.org>
Date: Thu, 18 Apr 2024 09:51:41 +0900
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14-dev

On Wed, 17 Apr 2024 13:47:30 +0300, Andy Shevchenko wrote:
> of_gpio.h is deprecated and subject to remove.
> The driver doesn't use it, simply remove the unused header.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: oc-tiny: Remove unused of_gpio.h
      commit: 037c633df6680500f35a9e9a06286d4e1401897e

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


