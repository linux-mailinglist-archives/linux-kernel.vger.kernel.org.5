Return-Path: <linux-kernel+bounces-146690-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 99E9D8A696A
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 13:10:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CB15A1C20F4A
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 11:10:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14E9D128816;
	Tue, 16 Apr 2024 11:10:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GeFTlQ3J"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59C5E128393;
	Tue, 16 Apr 2024 11:10:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713265846; cv=none; b=LorbWjwLKXpwY0zOwO4L2FbcRNO6m/Ej6QKnNMYb7jE17i6WaAlw6tPaHocOhyOvx31WTaabLmk28Ab499JBfL58doi33flhjf+bGOvBLeBBi3KRhuDaUhXgD/F3bLjf0PJAdaultoVzU0WTjm1eSAlLBn07fS+TYy1BIbmUrPU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713265846; c=relaxed/simple;
	bh=JdpwCJ0sXpu10EiZS9M7KZj/uP44nfa2lKrsWpOLHY4=;
	h=From:To:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=a4amqaeD6zJ/31zFI6UaaBjuEar0r2MvwJJmnzKEZnZ8c4BTzkv+lEojd7a4ZyzBqZFAHj8/bsHN5+Qq44V2IfFQ7c4s0J7mAqAIeRKbngCzHdgiU5rrzo6UgAmVuFl32u6IZaSEXQwhXtvCfQ0zhUSF6ilBv4OdfSpduS+RqGs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GeFTlQ3J; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C5BDC113CE;
	Tue, 16 Apr 2024 11:10:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713265845;
	bh=JdpwCJ0sXpu10EiZS9M7KZj/uP44nfa2lKrsWpOLHY4=;
	h=From:To:In-Reply-To:References:Subject:Date:From;
	b=GeFTlQ3J4rLiH514WI9hurQUwVLaAzJ1NK8HkFJTA/EAWQFQEmFLR4kBYX4yNhxfH
	 QZF7mHxIlGgN/hbJS72oWT6u3djeinfpNxaiikcdKq4lDGN81CVlZTvcVJdtZhVeMg
	 r20orwPqIeCFoglRH2dX7fxA0+H6FiAEWsrbVeGOCSM/MGBH47Xtea0I0x4NjzsllX
	 SEh6St2zvVV12rLqcY+y6WblSsMUrLxgPLzuN6cMZ4986aAzkKeL1mwxfNWjvEGPM9
	 vrj/f7LHBhKaOXWb5e2qaH66BmhXVv9kkMhyKcS0s5WYvm5YRIMjzBd5Un/Xco1Qlh
	 gtFCWGXS0G19g==
From: Mark Brown <broonie@kernel.org>
To: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>
In-Reply-To: <20240415184757.1198149-1-andriy.shevchenko@linux.intel.com>
References: <20240415184757.1198149-1-andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v1 1/1] spi: Consistently use BIT for cs_index_mask
 (part 2)
Message-Id: <171326584478.1678604.5209919543907385015.b4-ty@kernel.org>
Date: Tue, 16 Apr 2024 20:10:44 +0900
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14-dev

On Mon, 15 Apr 2024 21:47:57 +0300, Andy Shevchenko wrote:
> For some reason the commit 1209c5566f9b ("spi: Consistently use BIT
> for cs_index_mask") missed one place to change, do it here to finish
> the job.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: Consistently use BIT for cs_index_mask (part 2)
      commit: bb40996267670862544cb8e740afb77cbf3a7949

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


