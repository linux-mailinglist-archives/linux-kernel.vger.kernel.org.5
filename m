Return-Path: <linux-kernel+bounces-77368-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B56D7860473
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 22:11:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DEDFA1C212F9
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 21:11:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8320A73F08;
	Thu, 22 Feb 2024 21:10:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OhmUJICK"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 558F56AF8B;
	Thu, 22 Feb 2024 21:10:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708636219; cv=none; b=WJh9pFAPz6jC5zdf7chjTdo3hKyygKSQxUUYd9u04/CObx7jkOmF8lhdwr08V3ftcUwaVM0EAhRYqp66kE/WBE69xJp93EOsTbWvPwne2bUqc/tGtaCgeV7jsvLpTts6jepv8f4O5hCwaQaguMbvNNsDQanHg5Sdz/f/dLtlqGw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708636219; c=relaxed/simple;
	bh=MjyxgOR9Z/1Qv4zVUL+5Z9co3oChDavf9ax4CCR1GYA=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=owa9PTiI2IPp8mtmC5WBYLo3XHPN3TefZ2JQHurH7F82UlJ50MnW9nzcLy0UP7ARJwchEO3bxmhJHjYqoTB1HHeE/KdXGfwgOwMAIKm4LuFdlbuTpzwIphKng8uflQeAhU09KUAaEXxrWI6f2Wbc/LhvnXvCdViZtKl4KQazAs0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OhmUJICK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78DD2C433C7;
	Thu, 22 Feb 2024 21:10:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708636217;
	bh=MjyxgOR9Z/1Qv4zVUL+5Z9co3oChDavf9ax4CCR1GYA=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=OhmUJICK3sxYcnt6jfVX3f2ODrIcLWZQgqGcttIJv3jyYFoWJdHGWbWTlYfDlmeod
	 vqhpIMtRHQm1+Uj4S3ZKuTR+UCLV7bPlpPTVgY8t9HzrqKOyM5krKylIRalPUyIDeo
	 ABuuEWQcELEVmgU6iUHEDOzWdOD8Lw4QOo67D3K1m37dcC4P4YOnUlX3OmALQ+KhRC
	 QnbM+pv100cVkUsbyMlrAHqY4yKW9b0VqoK8YsLueGb3YEAs7tnzVPx5nDMXmPxCrY
	 SsrOIyHACLb1YGcS1mL1YSrYBUwJFIDHiCN6JgoODcM+xNs37Ei/cBeFAWjIJdz1iR
	 HzCUWunNbs77g==
From: Mark Brown <broonie@kernel.org>
To: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
Cc: alsa-devel@alsa-project.org, Mario.Limonciello@amd.com, 
 venkataprasad.potturu@amd.com, Basavaraj.Hiregoudar@amd.com, 
 Sunil-kumar.Dommati@amd.com, syed.sabakareem@amd.com, lgirdwood@gmail.com, 
 perex@perex.cz, tiwai@suse.com, linux-kernel@vger.kernel.org, 
 linux-sound@vger.kernel.org, arnd@arndb.de
In-Reply-To: <20240222102656.631144-1-Vijendar.Mukunda@amd.com>
References: <20240222102656.631144-1-Vijendar.Mukunda@amd.com>
Subject: Re: [PATCH 1/2] ASoC: amd: ps: update license
Message-Id: <170863621521.109182.12917169383809652232.b4-ty@kernel.org>
Date: Thu, 22 Feb 2024 21:10:15 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-a684c

On Thu, 22 Feb 2024 15:56:55 +0530, Vijendar Mukunda wrote:
> To align with AMD SoundWire manager driver license, update license as
> GPL-2.0-only for Pink Sardine ACP PCI driver and corresponding child
> drivers.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/2] ASoC: amd: ps: update license
      commit: 4c75493833a6e2095f03639f66aed5fbf2683c73
[2/2] ASoC: amd: ps: modify ACP register end address macro
      commit: 253ce07d2a091e98ef53e700e7fa221b28c4f964

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


