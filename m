Return-Path: <linux-kernel+bounces-125252-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A042A8922CD
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 18:35:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 40D05B22338
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 17:35:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCA6B137774;
	Fri, 29 Mar 2024 17:35:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bfRWs+u9"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2820B13249F;
	Fri, 29 Mar 2024 17:35:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711733734; cv=none; b=hYPOeNjI00aNXZQZlpHlzN8mTHacJDJy2rblx8EceBCBaQ48KCZQy0H21HvCXhxX23CVmG2+JKlN8x0j8ARM/nZOcMj78cg5Ee7ECZRk2UuAt4h2tRJiR214YFwr1Hzu60IbqpvCDV0u/hoLXt1e/Qi2oY6MN2H35jibKgfC/F0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711733734; c=relaxed/simple;
	bh=y6qwd8KK7Pm5FtdvuKlL0xIXI1ScjBkJ9gawPwSV41Q=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=oj6UUx0/RX43yMHc2v94GG3KdMGyjgcTVLIP/Ig9qO3/+1pOUbvajPIt+s3m3tqx9UO9H3Zk6FlwZvxcKo6MFFw9tSrdQ3sB5nh2rT7JL8V2xYz59+aCVvp9PP9Ukehz4C8DEqTp1JTomrZ6glA7/2v85xKAONY8j2zYG54n1ew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bfRWs+u9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8DADBC433C7;
	Fri, 29 Mar 2024 17:35:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711733733;
	bh=y6qwd8KK7Pm5FtdvuKlL0xIXI1ScjBkJ9gawPwSV41Q=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=bfRWs+u9xE+EFFApVRk+ylrfLh5ohRUjgQnJohM2PHYlSEP2A6NwexmUzDpXgV+2/
	 qLdMiOySrOovSjj4QlcMeSsTko23gebicm5dsScMg6BYzTg62kS266YGEFofYa+LFr
	 Y8bKYiWWJb2R/pN2cUSO1ZLVMaIjXqdkiDbdhDYdRM0xsyTqlH1Vpapblq+1Eqhwdv
	 mUh/IHFg0NFeS1bChaWIF7WO36ydGO+C0QzLftIvHzWxpvtN7NXr0z/bqr6iIcfWqv
	 BMKUx40kNDFhju9d/rjueISp50buEC0wLNGSRX2nWhXz4g9LDOnhjsfDgNIa/P6GuI
	 rZRVwYFdCBCJA==
From: Mark Brown <broonie@kernel.org>
To: linux-kernel@vger.kernel.org, Randy Dunlap <rdunlap@infradead.org>
Cc: Andy Shevchenko <andy@kernel.org>, linux-spi@vger.kernel.org, 
 Amit Kumar Mahapatra <amit.kumar-mahapatra@amd.com>
In-Reply-To: <20240328223340.17159-1-rdunlap@infradead.org>
References: <20240328223340.17159-1-rdunlap@infradead.org>
Subject: Re: [PATCH v2] spi: spi.h: add missing kernel-doc for
 @last_cs_index_mask
Message-Id: <171173373178.1605661.3810768018562164520.b4-ty@kernel.org>
Date: Fri, 29 Mar 2024 17:35:31 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-0438c

On Thu, 28 Mar 2024 15:33:40 -0700, Randy Dunlap wrote:
> kernel-doc complains about last_cs_index_mask not described, so add its
> description.
> 
> spi.h:778: warning: Function parameter or struct member 'last_cs_index_mask' not described in 'spi_controller'
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: spi.h: add missing kernel-doc for @last_cs_index_mask
      commit: ba5206881843e16b74a07c37970dcc44d22f8f6f

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


