Return-Path: <linux-kernel+bounces-71654-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C1BF85A87E
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 17:16:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B6283285E09
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 16:16:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BB4C3B786;
	Mon, 19 Feb 2024 16:16:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U0OKRzGs"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6ED53C467;
	Mon, 19 Feb 2024 16:16:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708359363; cv=none; b=VfZNeBAFtnMBtxlkZxOe9GCU6dKAyh4a2dAsggdd+93E+bF2OrC+IoF6h5lJyahwhattAnyh/YjEOJjv/lhshDvZrnazAcMbMidkKiGCnzzDWYacHJezZ0YdsOat4l1jFjhvusb2H8Opl+G86wlxFrjMu4cPbVgsZVb00xr20rs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708359363; c=relaxed/simple;
	bh=7TeTYE5FYHpiZEIUtYer/6V4EaNEuuUI9XNpRz088Ag=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=NYsVb+z8HWNkcrurErkCLyt6Kxy+qKUuxTQWtpADxAnHoo51LgAMSfAckHRG75FLtbYxSk8WAZrELTPQknrQSSYH5o5tF2nvJ/4YEOZjCCZRA6me2Ny3OTPJt8ilWyPokwiI6F9qnq6G0ouZ+DtrzlRDqFNqKsVbeTDUzPD4rEE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U0OKRzGs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60AC1C433C7;
	Mon, 19 Feb 2024 16:16:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708359363;
	bh=7TeTYE5FYHpiZEIUtYer/6V4EaNEuuUI9XNpRz088Ag=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=U0OKRzGsfy+1eKP6lTDxqZgBbjft3IraQaUCmKwu+niY0pz0z0noAo1gpvm5Oyf+i
	 T7ix6etKR/H0/mAjf4fKiZXDylA/HslUQn3LsN/2gpBlhiyhXPZwFVBpecVBSi+Zvg
	 W7G4Ck2lNEcDBd+p4pFvfKZOADlndKsaEyWBq7VH8qKBr38T/RdqlYSWMNI8+XGRWT
	 41H5qZvvzk1Nj0L0zqX2bBUPb97Zw9tVHRAurmh/YtQE9zTSDm68BWoez+EQtXo/VN
	 7f/cC6HX5Ocaf+T/yBBbHunp/YkSg2dG0P8L4O5FnU120eWFoIxj4+zkw95nBINdxT
	 rnk3nUxeU6Pug==
From: Mark Brown <broonie@kernel.org>
To: linux-kernel@vger.kernel.org, Randy Dunlap <rdunlap@infradead.org>
Cc: Dhruva Gole <d-gole@ti.com>, linux-spi@vger.kernel.org
In-Reply-To: <20240216051637.10920-1-rdunlap@infradead.org>
References: <20240216051637.10920-1-rdunlap@infradead.org>
Subject: Re: [PATCH -next] spi: spi-summary.rst: fix underline length
Message-Id: <170835936210.1193742.13457285956321993317.b4-ty@kernel.org>
Date: Mon, 19 Feb 2024 16:16:02 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-a684c

On Thu, 15 Feb 2024 21:16:37 -0800, Randy Dunlap wrote:
> The change to use "target" requires an underline to be extended by
> one more character to fix a documentation build warning:
> 
>   Documentation/spi/spi-summary.rst:274: WARNING: Title underline too short.
>   Declare target Devices
>   ^^^^^^^^^^^^^^^^^^^^^
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: spi-summary.rst: fix underline length
      commit: afd2a4ae296d5e8b13aefb056c1060ddf302a199

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


