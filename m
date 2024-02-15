Return-Path: <linux-kernel+bounces-67351-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C09C856A4D
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 17:58:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4A7E61F21665
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 16:58:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F5571386C0;
	Thu, 15 Feb 2024 16:55:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N3aBavaZ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F3A513666C;
	Thu, 15 Feb 2024 16:55:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708016147; cv=none; b=RQzOpe21jW2J5iL8LlDZh2EUN1P8Sfu5egYTLCFh8w4N8e31r3ZqPWO9bgHCWLiXVQDdteEAePKesQfwn46iYo/7tM8u5R0j/TByC241Y7gkV1PZ4p85RsbtxSODENFOKYbam7+zv6QjHhqFUaLQWyUA4bQiGuUWQlY4UygPrl0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708016147; c=relaxed/simple;
	bh=tc9lE5jUtqndXu7SkdkaLPIe4SlHgaUur29V3Q6LJfk=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=enmqmKRn8xVng61yxB4NUqN+bDC6zwP7BN0Zx7WTE1t8Dso25ay4mkQHbbY901U5ief27wIZCn1OOg5drUjaJILjc1jPbxx1plnOI5WzLR2FufLXg5syex3BvnIs4E+AdVjAZEWeNUPPfpII7O2xNjcxk1Uj0gKD5dVs9UTHXIU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N3aBavaZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 093EEC433F1;
	Thu, 15 Feb 2024 16:55:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708016147;
	bh=tc9lE5jUtqndXu7SkdkaLPIe4SlHgaUur29V3Q6LJfk=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=N3aBavaZoUU8FVyfXbewNpdBejFJcXc0oMm+hYYBRIL/ihD5VFuxDzFfDts/qZHj1
	 wNM83n/IPhOAvOV4/HTMVWNCVw1Z2hmQGAASVOVR9mjf/pKE5U28LWpThM8wu8RvwS
	 hs7e4sEVs+2F/CLFgxIQuCDwm0SEuyGVh/fpsM26EcdqNoJpkOuqnQNQh6sEJ3WY5q
	 8YKnQrfCy+ZKAhwfvxmp8LUYPSlCskl1SdgZZWIBJQYH/yD2bsw1SNSogV52w4V+48
	 CmV9p//oG2P9pXh44wJmty49dc7c567sn+++3cseAfNUPgi1E+ncZ9xmLmR4Azsojk
	 1ziDGaCd1Hi9g==
From: Mark Brown <broonie@kernel.org>
To: Dhruva Gole <d-gole@ti.com>
Cc: Tudor Ambarus <tudor.ambarus@linaro.org>, theo.lebrun@bootlin.com, 
 linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20240215085404.1711976-1-d-gole@ti.com>
References: <20240215085404.1711976-1-d-gole@ti.com>
Subject: Re: [PATCH] Documentation: spi: Update the "master/slave"
 terminology
Message-Id: <170801614576.198390.7530746643717040868.b4-ty@kernel.org>
Date: Thu, 15 Feb 2024 16:55:45 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-a684c

On Thu, 15 Feb 2024 14:24:05 +0530, Dhruva Gole wrote:
> Update the master/slave terminology wherever possible to adopt usage of
> the controller/host/target. Some parts have been left untouched because
> they were sysfs entries and will probably end up being inaccurate if
> simply replaced here.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] Documentation: spi: Update the "master/slave" terminology
      commit: 99769a52464d9f4c3b44bf903d08743cd53c49f6

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


