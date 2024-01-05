Return-Path: <linux-kernel+bounces-17850-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EBADD82538B
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 14:05:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 934EFB224D3
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 13:05:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A5B42D616;
	Fri,  5 Jan 2024 13:05:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IdGT7zuy"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81BA12D605
	for <linux-kernel@vger.kernel.org>; Fri,  5 Jan 2024 13:04:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0CCFCC433C8;
	Fri,  5 Jan 2024 13:04:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704459898;
	bh=LeWaPTeDIkwBlLEs63CvJ1TbgWY1BSqBo04lSpFso9M=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=IdGT7zuyh46LItWs7AWkZGU0raVSbTOeaUnhuvFjqmdcr8t+tP2lqbZouDPSpVlw7
	 N3mma1DwtMCtr+HpUE+GYFeuL9anC/Jc3OfyGL5IEiZskeZ1D71oNPjI+pnJycJsx2
	 F7DCwvmzBN5WPte9LUV6kR2JwNrEtx9027RAKVO0gAp1ENVB3AdN7sOqd15+PLONRn
	 rdeJvXxEq0dJIXoIYdyFnUmrXirn53NECOLJQ7ZQ09jqSGT9kvEm4iXQaMKaED9z/e
	 UR5g568mI0lS2bZVmJMFen/kGXjvJFGFLPRGNkD1SyE1WnTo80crrlTMQegF+zzgFN
	 j2UWIuhHX2sDA==
From: Mark Brown <broonie@kernel.org>
To: Liam Girdwood <lgirdwood@gmail.com>, 
 Naresh Solanki <naresh.solanki@9elements.com>
Cc: mazziesaccount@gmail.com, linux-kernel@vger.kernel.org
In-Reply-To: <20240104141314.3337037-1-naresh.solanki@9elements.com>
References: <20240104141314.3337037-1-naresh.solanki@9elements.com>
Subject: Re: [PATCH] regulator: event: Ensure atomicity for sequence number
Message-Id: <170445989773.6633.7562365006999842625.b4-ty@kernel.org>
Date: Fri, 05 Jan 2024 13:04:57 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-5c066

On Thu, 04 Jan 2024 19:43:13 +0530, Naresh Solanki wrote:
> Previously, the sequence number in the regulator event subsystem was
> updated without atomic operations, potentially leading to race
> conditions. This commit addresses the issue by making the sequence
> number atomic.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git for-next

Thanks!

[1/1] regulator: event: Ensure atomicity for sequence number
      commit: 1cadc04c1a1ac5015c2eb0fadfabf4b61bbe167e

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


