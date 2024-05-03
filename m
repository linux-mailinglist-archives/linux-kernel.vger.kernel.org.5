Return-Path: <linux-kernel+bounces-167147-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CE1358BA4EF
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 03:33:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E01B01C21DAB
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 01:33:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DA70E541;
	Fri,  3 May 2024 01:32:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dKbVIiaX"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52BD5CA7D
	for <linux-kernel@vger.kernel.org>; Fri,  3 May 2024 01:32:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714699976; cv=none; b=tlyxF7dThEVfoeL7lZdy0ChjyaRxGf6bJK3dJ77Fy/3knR1w1pFB3vdNKvAReAI+ADjt3IlxBxFlLHrOPshgEqzqm27PhJ0yregSsv0aY0An4PFW3catXGErdKfvUj7ssVu5FuGe/d11dWTiBhtxdc8nxzou2x9OXfHOR/QD8R8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714699976; c=relaxed/simple;
	bh=O7W4PCpDqOMStSo109efjNwgfeLxdIEV56LbRQgketU=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=NISDtq3YFIwj9fvl9VfYv3B447LAaKvzfqKl5PclHDndGaX909KTMybgFYVebuy8Nu9VT6kvOyNX/WnMEjsz/3qYiNE91stEmQkE3fovn5tg5fXBCSCpiPQL9YilghtNhnmlWvib5s7LcEBIy8ry5lgYhZJIjx1RLbEzro0DPoI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dKbVIiaX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04DE7C113CC;
	Fri,  3 May 2024 01:32:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714699975;
	bh=O7W4PCpDqOMStSo109efjNwgfeLxdIEV56LbRQgketU=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=dKbVIiaXc+KU+beXSI9Ud2W/+wHyK5gaY1fgTOIN7M53+S/FLdQr0BG4e3ueUbZZF
	 NBdE82Y+8256ryPdDplcUVk4lz5fHxvUI8xUTcxY5Nxl54znQpty9agMb7jNdTm3nQ
	 0i/6YyHWEzzbcHWNb1gXgw0mlxBxQ46I6KRvyH75hN7dEq7sFmxGmSEgopJXNQuhmB
	 2Wo/6vSPlRg84LrJ0mfHg+e6J6hB9PcNilHfAIH0IjjyNhGq5wOKb+ngTHdJDE6TtM
	 WIM+Z56DqqzW4HcRrclxt26dqM49x4+9tk7WnYgU6Dxs8eSmS27QXobX8FHseNl9MJ
	 6sSnPg3TcJ8mg==
From: Mark Brown <broonie@kernel.org>
To: lgirdwood@gmail.com, Alina Yu <alina_yu@richtek.com>
Cc: linux-kernel@vger.kernel.org, johnny_lai@richtek.com, 
 cy_huang@richtek.com
In-Reply-To: <cover.1714467553.git.alina_yu@richtek.com>
References: <cover.1714467553.git.alina_yu@richtek.com>
Subject: Re: (subset) [PATCH v2 0/4] Fix rtq2208 BUCK ramp_delay and LDO
 dvs setting
Message-Id: <171469997425.1910608.5359659733562475823.b4-ty@kernel.org>
Date: Fri, 03 May 2024 10:32:54 +0900
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14-dev

On Tue, 30 Apr 2024 17:58:23 +0800, Alina Yu wrote:
> This series patches is for hardware modification of RTQ2208.
> ramp_delay range of BUCK is changed.
> The maximum ramp up and down range of BUCK are shorten
> from 64mVstep/us to 16mVstep/us.
> The LDO's Vout is adjustable if the hardware setting allow it,
> and it can be set either 1800mv or 3300mv.
> Additionally, the discharge register has been moved to another position.
> In this version, a software bug has been fixed.
> rtq2208_ldo_match is no longer a local variable.
> It prevents invalid memory access when devm_of_regulator_put_matches is called.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git for-next

Thanks!

[1/4] regulator: rtq2208: Fix LDO discharge register and add vsel setting
      commit: 38bcec0e7cbbd6566c12ae4f2b7a48bd50cd215c
[3/4] regulator: rtq2208: Fix invalid memory access when devm_of_regulator_put_matches is called
      (no commit info)
[4/4] regulator: rtq2208: Fix the BUCK ramp_delay range to maximum of 16mVstep/us
      commit: d1ef160b45a0010d1f1b3d601230457243a8f3e8

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


