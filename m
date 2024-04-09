Return-Path: <linux-kernel+bounces-137698-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 29B4A89E61F
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 01:34:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2F69CB226E5
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 23:34:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22D0515921D;
	Tue,  9 Apr 2024 23:34:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e1YZi+yV"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69862159212
	for <linux-kernel@vger.kernel.org>; Tue,  9 Apr 2024 23:34:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712705660; cv=none; b=XxlC8wkZHI3z4lUFn5BZd3LeEIXhh/cW8ZhTKdkAksFzZPHGUEajxkgLcaeZn+sgwQsG+38ehiFv2zg26uXEsxgN5gROnd5r3fZ3sUeUygx0LzhmUHgI7oRN7jX87Nl49T+ekxTWMU6FJ2umT5jJQCSAUY0LfacATr3t7g39P7M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712705660; c=relaxed/simple;
	bh=waogLAz/SB0tT6Qc4LzIgOKW253P1evhT4wBfsvlx8U=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=fqo8V9U9Izzv9RGlzU55Oe4XNR8O+sePVXNX/D/p2DVsnKtOrSJAIUNp1Vzs36jZLHy/POXzL7rt4yW1MKLyXUv6NEH8+8e3RZIB8L/D0JpLIfjJxAR4Cx041sT+XwK6LjPigI4BrxOZbZGSMdY88RmMQPSJyKAwUNbMaMuoKZs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e1YZi+yV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9894CC433C7;
	Tue,  9 Apr 2024 23:34:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712705660;
	bh=waogLAz/SB0tT6Qc4LzIgOKW253P1evhT4wBfsvlx8U=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=e1YZi+yVZaTXExbyi2RFIfy4lgf6+Qv0QIai5fj78JHAVRj6dRiQaJ0DJVSISlVsJ
	 4TV6ABs2Vxu4fxtv0vmj3stkVV70t+3gI3dFv1VVEj3lC/qyU7iB5yOEbbxgiRpqIg
	 aDPnP+7LF9/mKAdD3cFNVKaCFeZQcMzVc68NMksa7c8ojzkZpxndyLRBgYdnPCX/xQ
	 To2B0lXpo37CO1pLAUXe/B1zGzN+qnvUVHHGlJT+KL6YoQFdIkyme/4fgQwtgyVx9G
	 fLdtO/fJUK3eypyqamykimv0z9/rIb0zBIe4J3udblnafEZIunLChW3cBbzDugyyar
	 9kZL9gmQYNm3Q==
From: Mark Brown <broonie@kernel.org>
To: Richard Fitzgerald <rf@opensource.cirrus.com>
Cc: linux-kernel@vger.kernel.org, patches@opensource.cirrus.com
In-Reply-To: <20240408144600.230848-1-rf@opensource.cirrus.com>
References: <20240408144600.230848-1-rf@opensource.cirrus.com>
Subject: Re: [PATCH 00/11] regmap: kunit: Add some test cases and a few
 small improvements
Message-Id: <171270565934.199621.5334533865002594899.b4-ty@kernel.org>
Date: Wed, 10 Apr 2024 00:34:19 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14-dev

On Mon, 08 Apr 2024 15:45:49 +0100, Richard Fitzgerald wrote:
> This series adds some more test cases, mainly for testing:
> 
> commit eaa03486d932 ("regmap: maple: Fix uninitialized symbol 'ret' warnings")
> commit 00bb549d7d63 ("regmap: maple: Fix cache corruption in regcache_maple_drop()")
> 
> And the pending patch ("regmap: Add regmap_read_bypassed()")
> https://lore.kernel.org/linux-sound/20240408101803.43183-1-rf@opensource.cirrus.com/T/#m2b99b1e01872bfc3597e89dee57dcdd5dbaf1b55
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regmap.git for-next

Thanks!

[01/11] regmap: kunit: Fix warnings of implicit casts to __le16 and __be16
        commit: 866f70211bf43927ca44d8e98b5266926fd51315
[02/11] regmap: kunit: Create a struct device for the regmap
        commit: 7b7982f14315e0f6910e13b22ed38a47144a83ec
[03/11] regmap: kunit: Introduce struct for test case parameters
        commit: 48bccea96fead1b212e19e38e50bf8e69287c45d
[04/11] regmap: kunit: Run sparse cache tests at non-zero register addresses
        commit: 710915743d53d19a1baf0326302aa1f743ab018e
[05/11] regmap: kunit: Run non-sparse cache tests at non-zero register addresses
        commit: ac4394bf9c5e065919a0e491bfd95e2106b1b9b2
[06/11] regmap: kunit: Add more cache-drop tests
        commit: 7dd52d301cfcff9a67be19d00289e03d80d05e46
[07/11] regmap: kunit: Add more cache-sync tests
        commit: 7903d15f008056c8c152f2aa3b36217917853264
[08/11] regmap: kunit: Use a KUnit action to call regmap_exit()
        commit: ce75e06eea9cfdddaa0082cef663cf2d4aa5ed1d
[09/11] regmap: kunit: Replace a kmalloc/kfree() pair with KUnit-managed alloc
        commit: d6f2fd7adcb5f25ac661808be9409f846b1de6fe
[10/11] regmap: kunit: Add cache-drop test with multiple cache blocks
        commit: 468d277e6fb112e7a5e816ef5f1f6bd86c29bea6
[11/11] regmap: kunit: Add test cases for regmap_read_bypassed()
        commit: f63eb9ae085dc6da27eebfe35317e07a6a02a160

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


