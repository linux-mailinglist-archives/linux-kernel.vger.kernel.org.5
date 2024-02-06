Return-Path: <linux-kernel+bounces-54870-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DF06E84B49E
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 13:13:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7EB521F291C4
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 12:13:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8259D132C25;
	Tue,  6 Feb 2024 12:09:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sK0C9Nyv"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACE8A132488;
	Tue,  6 Feb 2024 12:09:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707221345; cv=none; b=U57ntT0ELgZP5cm0Y+WPj30YzPfnBpqd/p4RYOv+krbN1boCARJhF4UBbs7T+TT57PLYKwb4OC4vK6NsY7OSRgyZnqoFJ9pGzUCT4OXZu9o7bEqfMcWd1vXD+aB/tCqbf2WKOekkHaD54nLfMvlykRfVaGfDX/Zd3LqkbhSbjAA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707221345; c=relaxed/simple;
	bh=eFULCdtRIMuBKJjgR2NGy0D9a+xMsiURswxpvWKcvgw=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=PJ0o3bYeT634vVxQHa6S830eO9M1d8J+2BGyY1ioKUQcIMQgWCR7URxVALbK9Paj1JdFQxwzP/HuBLr/VySQ02EudY1XDxTJeqY6QlhN0+sus01Yc9GqlAaSAGAhz3JyCy4VllUitvhYZbUw5uLdjcYKIX/XSJiHy6zyC0BaSGY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sK0C9Nyv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B9047C43390;
	Tue,  6 Feb 2024 12:09:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707221345;
	bh=eFULCdtRIMuBKJjgR2NGy0D9a+xMsiURswxpvWKcvgw=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=sK0C9NyvrPqgTXvCLutf+ZX4x9jQ4Y0ORnyspNPll8QZ6D5gEV1YWtV/ZNI62wo/x
	 R/zwJnvgEoQP+oj3cBekBmL2IRWGK0eDr2ZZFAVJ/Q9f7WbqkC8C+dCYk3PtlEAnKc
	 1of37JW6qaOM/sa9XUhs0ij+XjH+gIcV0hIaFTANdQ5vizlir4He5x2eswj/4cqzCS
	 gOrGqK45Cucaqmnl2hCMzVANGimGPG7mSjYrHieU6mYGKlUy1p/yAgrAfHYcs2rSHy
	 ZUMMH8I4xgVGtdqYIE2Ol1ElmR7uSznfDLkfg//9I4eeyYN5UwB8/g0i6USj6Izl9/
	 7e1ALaFEy9i6g==
From: Mark Brown <broonie@kernel.org>
To: Takashi Iwai <tiwai@suse.com>, 
 Mario Limonciello <mario.limonciello@amd.com>
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, 
 Stanislav Petrov <stanislav.i.petrov@gmail.com>, stable@vger.kernel.org
In-Reply-To: <20240205214853.2689-1-mario.limonciello@amd.com>
References: <20240205214853.2689-1-mario.limonciello@amd.com>
Subject: Re: [PATCH] ASoC: amd: yc: Add DMI quirk for Lenovo Ideapad Pro 5
 16ARP8
Message-Id: <170722134350.992147.6667675889497982798.b4-ty@kernel.org>
Date: Tue, 06 Feb 2024 12:09:03 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-0438c

On Mon, 05 Feb 2024 15:48:53 -0600, Mario Limonciello wrote:
> The laptop requires a quirk ID to enable its internal microphone. Add
> it to the DMI quirk table.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: amd: yc: Add DMI quirk for Lenovo Ideapad Pro 5 16ARP8
      commit: 610010737f74482a61896596a0116876ecf9e65c

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


