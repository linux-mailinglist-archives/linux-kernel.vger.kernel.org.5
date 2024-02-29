Return-Path: <linux-kernel+bounces-87408-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 805C286D40C
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 21:19:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 19C2C1F24F00
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 20:19:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DAC813F44E;
	Thu, 29 Feb 2024 20:19:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iRSj4jc/"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50ADB2E410;
	Thu, 29 Feb 2024 20:19:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709237966; cv=none; b=e6Hsba85AcbxJ92yDPCuMjUy+sK6mSU2NkekRbJk9FJ+A8BvePKrNuu0HtGeJQDMtgbrWePGRTxYRer3d92BDGHDJrLSpAMs93KJ66o1HFwWgys29mwz1ESlWj7FDrkrDijDr9fSR6KhK8zpZXBYFsvG/W7YSsspEVsfRZcbR9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709237966; c=relaxed/simple;
	bh=NRKcIvncjU120/bj3dXn6VYXH6SarE/bKWVam/M2fx4=;
	h=From:To:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=cyyiy9qpNgvpFKLcLSrsWl8QtpKw7yWK7H4v5JU0qbnP/Y8L6lCqp08plqcXintDOdYRw/T99PwdhaxsxA07firP3lnHAviYM2qHMq1vkrIblE6FGERa6e7TdNzipeSnrspmBNfH4ZC/Jx4DBFhjcmAt6i0gkvALD8yxuyyf9OY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iRSj4jc/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F9AAC433C7;
	Thu, 29 Feb 2024 20:19:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709237964;
	bh=NRKcIvncjU120/bj3dXn6VYXH6SarE/bKWVam/M2fx4=;
	h=From:To:In-Reply-To:References:Subject:Date:From;
	b=iRSj4jc/g8IaK1yatuHAVfupr6y9WW6cGlGzfbfXTvr29HEIQ8ODlffgP7ns+4cpI
	 bSsd7x/gPoNAxvQkA5ZxK4XDvBfWuY4d3p+JB+XqElO+DQlZbwjH5Y+DmKs1T7c8O8
	 jNpOgX+EqXTf2ukQ11KsAZ9g6oz5Ac4VlD1wsB477mtE8s0pMnQZMp/Kwxj7JZs/rD
	 xYsSdjuVXaSNYTjDxTGYlAZ+Peb8aL33D92ccpqBiIan764rAd0M7ySw2Qsbu0yAYp
	 dkRnociqn/5gTF8ZkeyMiebmc3qitTkHWzVNAg7rW0DsgwmIEgPBQE6qmMIbiydNAc
	 KeGjJMpqoGyog==
From: Mark Brown <broonie@kernel.org>
To: cezary.rojewski@intel.com, pierre-louis.bossart@linux.intel.com, 
 linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org, 
 =?utf-8?q?Alban_Boy=C3=A9?= <alban.boye@protonmail.com>
In-Reply-To: <20240228192807.15130-1-alban.boye@protonmail.com>
References: <20240228192807.15130-1-alban.boye@protonmail.com>
Subject: Re: [PATCH v3] ASoC: Intel: bytcr_rt5640: Add an extra entry for
 the Chuwi Vi8 tablet
Message-Id: <170923796326.228603.1646568494147744323.b4-ty@kernel.org>
Date: Thu, 29 Feb 2024 20:19:23 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.13-dev-a684c

On Wed, 28 Feb 2024 19:28:41 +0000, Alban Boyé wrote:
> The bios version can differ depending if it is a dual-boot variant of the tablet.
> Therefore another DMI match is required.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: Intel: bytcr_rt5640: Add an extra entry for the Chuwi Vi8 tablet
      commit: f8b0127aca8c60826e7354e504a12d4a46b1c3bb

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


