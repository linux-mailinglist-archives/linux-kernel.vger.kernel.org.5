Return-Path: <linux-kernel+bounces-38666-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9ACE683C3DC
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 14:39:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 51B621F2495A
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 13:39:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2507456466;
	Thu, 25 Jan 2024 13:39:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="p5eHH+W3"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6329A58115;
	Thu, 25 Jan 2024 13:39:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706189956; cv=none; b=byaCnv0EE8TL950pYIj9TN7oDP44u1HDwKVWx9xuaC6nhqkzbQGRBRhYfgFbg2Yo/rK3kh/L6fZfpQbb7TKq55JCgQvAp/DVhCZdNtQQCbP47s3A+TVl0loOarSannrJ95vFl/2dZN4Z7U0+MQ/wnIwPspBXif+NL1gQgiw52sg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706189956; c=relaxed/simple;
	bh=25UBNvhMxiqFOHiYLxmtgtWnMrtX2HH33lq0Ekw4/6U=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=igSD3WC9aTjk/tTwH3l5B+hV5NFm5OXoORK9UcKp2QnIvOGNYLHOIT3tImcLlyDBKQF9FuXKrAxZfg0+lBnQbrIsFCE9pySnZviAs6gwR9s8COkCQ0aI6r79brGX/gmqvyHIuVXGyBip+Vy/NmanToLF+MQfOJLZnzRRftWkVfo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=p5eHH+W3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8BDDEC433F1;
	Thu, 25 Jan 2024 13:39:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706189955;
	bh=25UBNvhMxiqFOHiYLxmtgtWnMrtX2HH33lq0Ekw4/6U=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=p5eHH+W3nPMe/y4cHYa4nd9DSYCc/HzO8CegT4O7m7P2Fen9uu+XjA+WEnMH3xPC7
	 Okll24pHczi28dGuaMQCJjQoEbQ63Nxum50yd7VJ3NK1Yle0VbSL0eNS1SQoKTawCO
	 vD1maq4cmFAApVm+cujpr10G+RcALTmfSLs4+Thwbh0ys1hxbrx0Ak2+wkPMBcof8Y
	 8VDJn/RnBmDg9xYGuRzYkFXpqzm9xBrto4kx6qhuvmKV7349LFNeeOSXdQuhbLhpBZ
	 KZtPf3G0aHF05WFpenHz9EUC8booijNYZHROIqcH9buPy1iHpd2y750y8lyDwK/159
	 PvKbpLWeLoEtg==
From: Mark Brown <broonie@kernel.org>
To: lgirdwood@gmail.com, perex@perex.cz, tiwai@suse.com, 
 Yang Li <yang.lee@linux.alibaba.com>
Cc: linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20240124004425.54020-1-yang.lee@linux.alibaba.com>
References: <20240124004425.54020-1-yang.lee@linux.alibaba.com>
Subject: Re: [PATCH -next] ASoC: codecs: Remove unneeded semicolon
Message-Id: <170618995429.31781.12764498423630220145.b4-ty@kernel.org>
Date: Thu, 25 Jan 2024 13:39:14 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-a684c

On Wed, 24 Jan 2024 08:44:25 +0800, Yang Li wrote:
> In the wcd939x codec driver, there are two instances where semicolons
> are used after closing braces of a switch-case statement. These
> semicolons are not required and do not adhere to the coding style
> guidelines.
> 
> This patch removes the unnecessary semicolons at the end of the
> switch-case statements which cleans up the code and ensures consistency
> with the rest of the kernel coding style.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: codecs: Remove unneeded semicolon
      commit: e7214441ca1562fbfb002200f46d7f83bbc2e621

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


