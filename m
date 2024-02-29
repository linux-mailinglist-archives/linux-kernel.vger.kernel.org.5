Return-Path: <linux-kernel+bounces-87426-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B12D86D444
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 21:33:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 633711C20AEF
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 20:33:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA2D11428ED;
	Thu, 29 Feb 2024 20:33:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Kja5fG+U"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F6087BAEB
	for <linux-kernel@vger.kernel.org>; Thu, 29 Feb 2024 20:33:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709238801; cv=none; b=HJjSoo0sJznMs4AxNMm8cLp4gxvOhulIGkfzmnAD7WYQtyZ6muXGZQnzfVLjFmmPQAkimMQqQk9biQCh0yNAxaAUH3xVwwB4XQ1HPKaFeKoT/coGYMiI6UqjvMsDPB08l+ZQZ3uXr4Q9p81sSVSIaBLfKf/lqEbYrxIKH538gMc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709238801; c=relaxed/simple;
	bh=7tBEBdUVUlOtdIRXvrlqW8tSQoP1ifhYxfl+pl2lp5I=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=Cw/EvS7Ru2pyi1i5+yTkTGSKhUYJXFofIdycXqZTTYpN8T9de3VvieomMLsruZz6SQ0MbNCswJqhXyqg7GV/m7N94hoXZ0mZK1THYIjS87IYXHlE4NL8a0uYg0cz5QRHn66aoLPHZwaVTBSIICyBMn0hMLDAhc00LIW6+V8zz10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Kja5fG+U; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73B70C433C7;
	Thu, 29 Feb 2024 20:33:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709238800;
	bh=7tBEBdUVUlOtdIRXvrlqW8tSQoP1ifhYxfl+pl2lp5I=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=Kja5fG+UhiKbxfXWchmaMeGLGUtzKXDSiyVgnQJJwbDUTHK91rHefN8QVPWn7PQJd
	 kk31IC9TulxgX4qsSVxqcthH03HEt7L820NLn2sbmBO4Oe/tui22PqcAvlEIOwLST1
	 lUirTSz5dsf68LBC2KYpl1HlQ76siOe+8EG2/tmKGWEGJiR14foPDHKrIrKsBNOE9B
	 cUjDfCyjDRpiffNxerEn7SjJuh6oMyqNWhnqBMYOoiWQ6Az+7WpC64seS8hJ+h0hF7
	 MmU7TMdDnQQu7B7SFjPnGvRRwHAFCP4Zpt5jYEgg0I1TZvZr+WlY4wiQyS9ykHgYho
	 RJObCxDjPgLlw==
From: Mark Brown <broonie@kernel.org>
To: Chen Jiahao <chenjiahao16@huawei.com>, linux-kernel@vger.kernel.org, 
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Support Opensource <support.opensource@diasemi.com>, 
 Liam Girdwood <lgirdwood@gmail.com>
In-Reply-To: <20240228195730.3607154-1-andriy.shevchenko@linux.intel.com>
References: <20240228195730.3607154-1-andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v1 1/1] regulator: da9121: Remove unused of_gpio.h
Message-Id: <170923879911.233307.6279047989483513281.b4-ty@kernel.org>
Date: Thu, 29 Feb 2024 20:33:19 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-a684c

On Wed, 28 Feb 2024 21:57:30 +0200, Andy Shevchenko wrote:
> of_gpio.h is deprecated and subject to remove.
> The driver doesn't use it, simply remove the unused header.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git for-next

Thanks!

[1/1] regulator: da9121: Remove unused of_gpio.h
      commit: d73709646cafc0ea7e6cfa0bbc6fcd8a6c0f89c3

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


