Return-Path: <linux-kernel+bounces-87431-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CF3486D452
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 21:36:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2B7582841D6
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 20:36:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E02A144031;
	Thu, 29 Feb 2024 20:36:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZRVm5GsW"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81636142916;
	Thu, 29 Feb 2024 20:36:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709238976; cv=none; b=WIhRcVxYQK9rkiMuS+Scd1czSzbyUzyNAIfGR1TweU5nehgNrbcGsUNeVkv3FeCqb13rKbQLc63FLb5PuPFajzygz4Tgg4or6TsT1xT1v6YwlEMXyaA58xDyadFP0FySf4YwPhCn4OeRtl+owSGg5xayoZfc07/g/LK1NPQAkpY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709238976; c=relaxed/simple;
	bh=nP34NGSQNwe6QNazOIlFRyCKeC6s+ByReKFgz5kTUUA=;
	h=From:To:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=OO7aT/xVbzfPMAzK/3mQWRFwHVTv216rCPPAX7/PSk9C++TqbUg7k3Kd2nEa/AimCmyjbOmV/b19YPXQbmyAQi3Vnw12fpQV1GrCbxijHSaQMBq9I5iB7aTLvXo0fQIQl+9rW5F03hKOKeZ0chQVp3id1XtlWxsZh/ACkVVyWQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZRVm5GsW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 837DCC43390;
	Thu, 29 Feb 2024 20:36:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709238976;
	bh=nP34NGSQNwe6QNazOIlFRyCKeC6s+ByReKFgz5kTUUA=;
	h=From:To:In-Reply-To:References:Subject:Date:From;
	b=ZRVm5GsWcvG93KRCr4aChObX1l7dJ4CNsNE11kFVHc/36t7MkxN8iB5dW8ktCM2ft
	 +lVsSxQlx9AVxB8hzS1ntuGhRB5YEbSwq9mzpxvrsEuZncC8KDGfeRzTs7PRscqVmx
	 75kRisys8QDRKnmk5nO3Vi1xl7Nzjcv2uPx8XzGE5lVfXaiVkAEwvzlWwi+9JQf4k8
	 HgvnX2/2rdvf0Uigg9QAq86pkrgOOYXcplPm8YuS7+Sk5IPeY98sDoDlGzlq5O1D4X
	 1r8swUVJFXoVsCfkluhvr+hRfF+l/wuCYvANBz+p1VmOsPAUDwnW9jirf8BxlUlCsB
	 Imjt+DO6B0g3Q==
From: Mark Brown <broonie@kernel.org>
To: Yang Yingliang <yangyingliang@huawei.com>, linux-spi@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>
In-Reply-To: <20240228194818.3606841-1-andriy.shevchenko@linux.intel.com>
References: <20240228194818.3606841-1-andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v2 1/1] spi: pic32: Replace of_gpio.h by proper one
Message-Id: <170923897518.237390.1313071847105495953.b4-ty@kernel.org>
Date: Thu, 29 Feb 2024 20:36:15 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-a684c

On Wed, 28 Feb 2024 21:48:08 +0200, Andy Shevchenko wrote:
> of_gpio.h is deprecated and subject to remove.
> The driver doesn't use it directly, replace it
> with what is really being used.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: pic32: Replace of_gpio.h by proper one
      commit: 18ebe6f6fccfb093eec85bcdf3e77d48cc03a592

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


