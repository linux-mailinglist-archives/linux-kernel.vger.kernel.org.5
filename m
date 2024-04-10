Return-Path: <linux-kernel+bounces-139336-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 029D68A0189
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 22:56:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 341191C234A6
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 20:56:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 862C5181CF2;
	Wed, 10 Apr 2024 20:55:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TE/fwInJ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C993F15EFAD;
	Wed, 10 Apr 2024 20:55:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712782540; cv=none; b=eHMHlNddefyrtdgbPEhZ8fB9WgGFyxArW+1xFuQslPEGW1G3D/yF2wnaEu5V6Oh6I2FSVnOL9UOnfdniD95BNDsQKQrhjmFSStf4Y1GtPBEv+nTSyrPtrAZm2Q6GD+i9WeX6DgxW6hOf1Cd6q/nE78eamvfWH5Sj7bst7SC3pV4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712782540; c=relaxed/simple;
	bh=0WYBVqUQGlOFYyjVjE2osoofygiFLNbiCtHVQPVQu4E=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=ugNkSaQQy/GDcEEEBNRtfwRzzBPYwIaDqNZMwqKe+6TEqofn1wMOTosRW9g4XfF4XmF2ZtK1vD3E/o1t3Id4lwn53T2iiOZfA0trF3Su7POYmajbDIR0UmB7/ylpe/Jl7J47Jmh8I/vZ4WWfv0z6n8lBOd2vFJWRl5FV/gXG7VI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TE/fwInJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92322C43390;
	Wed, 10 Apr 2024 20:55:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712782540;
	bh=0WYBVqUQGlOFYyjVjE2osoofygiFLNbiCtHVQPVQu4E=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=TE/fwInJJNLo+8+zEovfg9Yn56tMOFWPy/MhjARmjwfHXzKNwCFJmIia2V4/0WkiH
	 DuWBqTZs/AodA4+xnh4Pqmfovx2BV7buW3XpL30p61A/0SC1YjSqEBNTbQDgwIiLEp
	 3M/JEpf6fABvQsdUJfevfHgNNdksq7OtU2rzQg0+HJlblCC8dEB6wJ+xG3Qft8+PqI
	 yyTvx7HyH69REQMeyeAroYr27aPUpKr90XtP7aD5aBH4TwCS+tFbOIQbpD1XsdDbCe
	 9aprvXG6JZnzfRR25Zen+cFEOlS+Uv7ZO8JlJLMG6Mtrsy5LAdI/3yE/Pbkk81iX4C
	 LMwqK1U89D31w==
From: Mark Brown <broonie@kernel.org>
To: Richard Fitzgerald <rf@opensource.cirrus.com>
Cc: alsa-devel@alsa-project.org, linux-sound@vger.kernel.org, 
 linux-kernel@vger.kernel.org, patches@opensource.cirrus.com
In-Reply-To: <20240410160833.20837-1-rf@opensource.cirrus.com>
References: <20240410160833.20837-1-rf@opensource.cirrus.com>
Subject: Re: [PATCH] ASoC: cs35l56: Include array_size.h
Message-Id: <171278253931.69181.5426734835911028247.b4-ty@kernel.org>
Date: Wed, 10 Apr 2024 21:55:39 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14-dev

On Wed, 10 Apr 2024 17:08:33 +0100, Richard Fitzgerald wrote:
> Explicitly #include array_size.h for the source files that use
> ARRAY_SIZE().
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: cs35l56: Include array_size.h
      commit: 28d31ffac3d3ef6d60c4eb392a47d5e19dbb15e8

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


