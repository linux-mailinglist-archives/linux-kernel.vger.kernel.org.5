Return-Path: <linux-kernel+bounces-83128-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F1EEF868ED2
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 12:31:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 295AC1C25334
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 11:31:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4ABD13A255;
	Tue, 27 Feb 2024 11:31:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JDi9+qXm"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 218E613A241
	for <linux-kernel@vger.kernel.org>; Tue, 27 Feb 2024 11:31:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709033494; cv=none; b=cQUlz+6cGMuHGgUmHliJjsORb39xdoWn3KktmPcbPJGVIdSqbAnr96yWl4Zgb6lWejd00egNCWFWiQ2eohIzqaKGRoHiu2vSYaNbcvif3XWRTYwViKXTeUAPg+Up+/1iCAIniwAOOeDbkRg+cDj0i5EFAiNF87GwlF0v/Nt1CS0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709033494; c=relaxed/simple;
	bh=Cr7MmxgTuDem0OxZOABddEuZGeXEks8j30PVFs4liZI=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=h0IHBQypj4FY30eslfTiufB82ZWHL07h0mgPqtBDqbq7SvNhrZoeS7BvTSmdShT0z9BgUj3poRO64DBBFY7CgREaTZsFhE5ix9hD9GoZJDmd3DWLhpXB075LGG069oPVNpBU8e68e5j5nih8qpXQe5VrvE7YRmuNOqNrlBgrpso=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JDi9+qXm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7C1EC43390;
	Tue, 27 Feb 2024 11:31:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709033493;
	bh=Cr7MmxgTuDem0OxZOABddEuZGeXEks8j30PVFs4liZI=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=JDi9+qXmXf40vcG+5maWgeJwM+Oq9unUqGJnwRvnSGI8WEIfNg9myiFpc0p5iH0WX
	 UH6wn2j+c9AvzyGEtZj8RDwDH4QFSskBE3AJL0oeTRad6mTJm+2dmkyE982uAE1aez
	 gk/MEmrAxiykmrBGAL83AbBCne5ksYLwlhZkrbJkNL1hXlOaAy7FPWJmLqrwFdWLBm
	 GL5Ls78xPzyRKoXmVnGQSRcPf4QcEqaGM66tVlfQiuHBnKsptkyLXcyTLNhHomc6O+
	 zjYHuchzH1kyR1vDPIMNhqkwh35T3B5oN0PNP4j1ZKpA7zBDhsK4mlQs8yhX3Ky3i8
	 h0EU3XmVcbcYw==
From: Mark Brown <broonie@kernel.org>
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>
Cc: linux-kernel@vger.kernel.org, Markus Reichl <m.reichl@fivetechno.de>
In-Reply-To: <20240225-regulator-mp8859-v1-0-68ee2c839ded@kernel.org>
References: <20240225-regulator-mp8859-v1-0-68ee2c839ded@kernel.org>
Subject: Re: [PATCH 0/8] regulator: mp8859: Cleanups and enhancements
Message-Id: <170903349247.16921.2831732986732449411.b4-ty@kernel.org>
Date: Tue, 27 Feb 2024 11:31:32 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-a684c

On Sun, 25 Feb 2024 14:59:26 +0000, Mark Brown wrote:
> I had cause to look at the MP8859 driver together with the datasheet and
> noticed a few small issues and missing features.  This series deals with
> many of these issues, the device also has support for interrupts which
> are not implemented here.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git for-next

Thanks!

[1/8] regulator: mp8859: Specify register accessibility and enable caching
      commit: b65e9149bdb76e9b09f6fb76fea1f10bde256619
[2/8] regulator: mp8859: Validate and log device identifier information
      commit: 6c848d772eee0f03b72542f35e1a66469030390f
[3/8] regulator: mp8859: Support enable control
      commit: b79d93d99e084bf1abafba2b7aabff6a06defcd0
[4/8] regulator: mp8859: Support mode operations
      commit: 673d06a858864c7dca9dd5c36a78f5f7fda793af
[5/8] regulator: mp8859: Support active discharge control
      commit: d7217c91bbde48ee60d3ce67cda6557f56c6b639
[6/8] regulator: mp8859: Support status and error readback
      commit: 4317ecadbeeab5464a8c34b27b73e2d2f81ef718
[7/8] regulator: mp8859: Report slew rate
      commit: 6df0921e9013622091c283aa2a5be8c5d1ca3642
[8/8] regulator: mp8859: Implement set_current_limit()
      commit: c8e794cfb05344af7b9ae920b5548a25a7e91fe9

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


