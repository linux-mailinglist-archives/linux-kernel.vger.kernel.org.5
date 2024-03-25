Return-Path: <linux-kernel+bounces-117621-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 809F188AD55
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 19:14:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B23531C22E05
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 18:14:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3A4F130E39;
	Mon, 25 Mar 2024 17:44:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jhBdE2Et"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D091F12EBF2;
	Mon, 25 Mar 2024 17:44:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711388655; cv=none; b=VfDAaXOrAuL3kk4knLVai9FWCzCW1B1/qNRpxaFahA3nfxMtGOx764xJZ4zCgj38HTY+XxdD1H7QSGn0VsphxOp5hXZeIHjG9tsgLtEE9DVoP7n9WFtYZqL5X5NZXHM9J9BXhZ/F9XEtUJBalTbDFWbu5lrkwGXKkCV04BugtSI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711388655; c=relaxed/simple;
	bh=84QJw+nFRWJcCI9qLc+HWOqIdwtPfnng/a06NrPc9zg=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=nkBcVMxv/XkDUotxbj/YrWFdGLsUd+gVG3AUgH7sdlDBx3Jbkjh9UpKZphbg67OPdgVJlEys+MkODQ3xUKK7yEgXoOeo5wN8YStAXT0myQ23dxQ/AY20xm0nq90wu7bxFYWmXbJoWOpAoHjeRVae8cgf6mp+Ni+pI8OLLKIHhD0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jhBdE2Et; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 892D4C43390;
	Mon, 25 Mar 2024 17:44:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711388654;
	bh=84QJw+nFRWJcCI9qLc+HWOqIdwtPfnng/a06NrPc9zg=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=jhBdE2EtXZRXGWjy0Ty+MK0oU4ksW6nrbVRnDx+mSpLspg6shj4DC1wpBdRLN7Dc7
	 eXIP7eXXiw/beSozIggbEDp85tyoIkFqmn4j7iiIHSjK0pkwpughN3r79dWkEfrGdf
	 n4Mt46Q0NauarqspcR7w6gQb7Nr2pdEkmPOlTLVbj56kbnsWCCLX+V7dAEyR5yg5wt
	 tuDC1Ww5/J9XSAbjp54HbM9DUeikJYNAPWYNhk5fJ/xkLY2Sm9mpBhJMksOkeQBHtp
	 B4+grnwjxTsuE4NTo8RmYEedf8vGbIrXXw40qyssfXlPUMcO8X8Ai9jSdDxzaDfHFK
	 7Dg/paNrEVoRw==
From: Mark Brown <broonie@kernel.org>
To: lgirdwood@gmail.com, robh+dt@kernel.org, 
 krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org, 
 Kartik Agarwala <agarwala.kartik@gmail.com>
Cc: patches@opensource.cirrus.com, linux-sound@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 javier.carrasco.cruz@gmail.com
In-Reply-To: <20240317200201.119233-1-agarwala.kartik@gmail.com>
References: <20240317200201.119233-1-agarwala.kartik@gmail.com>
Subject: Re: [PATCH] ASoC: dt-bindings: wm8776: Convert to dtschema
Message-Id: <171138865226.327140.7724830944005917187.b4-ty@kernel.org>
Date: Mon, 25 Mar 2024 17:44:12 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14-dev

On Mon, 18 Mar 2024 01:32:02 +0530, Kartik Agarwala wrote:
> Convert WM8776 audio CODEC bindings from text to dtschema.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: dt-bindings: wm8776: Convert to dtschema
      commit: 1fdc23aa57913d7a0a521f71dcdefdde9364d4f9

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


