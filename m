Return-Path: <linux-kernel+bounces-37491-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 91D9983B125
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 19:29:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6E95CB32E0A
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 18:12:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 061D012BE8F;
	Wed, 24 Jan 2024 18:11:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YKj2F9ij"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45AD912AACB;
	Wed, 24 Jan 2024 18:11:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706119901; cv=none; b=fNcKQVZACnArDz5p1KYunjEpPDljdPea4SW4jhKAKbKhZaz6D3Bn5nbm2nNOMe1zUXDD+kzGxTzXMjiOiy1rtwXjeJpwRK9cLw0w95nk9PgbY++k+u9i3Nfj+CNM1hMbpjgAGOR2njooxYmF/k97ueHNU9xJd3vGTykis6mgMWM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706119901; c=relaxed/simple;
	bh=rgZYbWuTr7UWijpWFQLAMiqhX/DSQYZS2yL4ukleSjg=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=BUWeuiX/0BLq/E+Uq7P2IzR0Asv0od6euHOk0sg5hwKiDv0jQYIAIsF5LHc7nmpDJjjesUuyPtXDYnGhdn0lFKA/aTUKFeNiZLXSen6LKYBU9um1MdrcOJWL4KQvCc8br7xmikLvPZW7sSZZY/9cQCydV411lSPamO5F7uki75U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YKj2F9ij; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13072C43390;
	Wed, 24 Jan 2024 18:11:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706119901;
	bh=rgZYbWuTr7UWijpWFQLAMiqhX/DSQYZS2yL4ukleSjg=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=YKj2F9ij6ay8wJ1p+gf+i+Kb1O78e+M+bgn7a5yY3OWMohsKuburB/zlG7Ne5VhK3
	 Df//74UEpuwOt06mDEJd2VtghXhPae5ZVA2uqu8u4AEBr3tEgRVk7YrXPW55ZYtXkY
	 XxciXoGx8qIX56lRIi76i8Z+jTqf4Nh+3ssg/9DK/MJSyc/pSTZffk5TCCmHzzM+jZ
	 jwr9rsOYwrUOWDUg4ta4hMP7lvigK/Ev5IhNXLuqm9UnLl0OSDk83O/+75fSEcPpFc
	 hzbhryfM6QK42jD1BbtSRqqG4K1p+iYofsP6LMwX5LiRI6H7Ys26ppdrO318AK2zxZ
	 jrgxO/M6NU/ag==
From: Mark Brown <broonie@kernel.org>
To: Amit Kumar Mahapatra <amit.kumar-mahapatra@amd.com>, 
 Guenter Roeck <linux@roeck-us.net>, Mark Brown <broonie@kernel.org>
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20240124-spi-multi-cs-max-v2-1-df6fc5ab1abc@kernel.org>
References: <20240124-spi-multi-cs-max-v2-1-df6fc5ab1abc@kernel.org>
Subject: Re: [PATCH v2] spi: Raise limit on number of chip selects
Message-Id: <170611989980.57421.17503370766677660206.b4-ty@kernel.org>
Date: Wed, 24 Jan 2024 18:11:39 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-a684c

On Wed, 24 Jan 2024 13:24:24 +0000, Mark Brown wrote:
> As reported by Guenter the limit we've got on the number of chip selects is
> set too low for some systems, raise the limit. We should really remove the
> hard coded limit but this is needed as a fix so let's do the simple thing
> and raise the limit for now.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: Raise limit on number of chip selects
      commit: 2f8c7c3715f2c6fb51a4ecc0905c04dd78a3da29

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


