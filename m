Return-Path: <linux-kernel+bounces-144946-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DDA98A4D00
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 12:54:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 222A62814F4
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 10:54:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A39D35CDDB;
	Mon, 15 Apr 2024 10:53:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sizdaTn6"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5A4A633FE;
	Mon, 15 Apr 2024 10:53:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713178408; cv=none; b=SoaA9dT7WStz/jbVMzUlyWyR+5c+Xvm8lSU75vGosG6+QvfiSaQdx2/XNyMpyqsxClXDm2CJjn8/Jh8JrQVHjOGBD8gmPBoJtPXHJhnowzfOA9jZSsPLGmmRNeFCJvZzuBBPzTwSm/nYTOb1U6q4hNsk5lamZb6W1QxbVnmniOg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713178408; c=relaxed/simple;
	bh=n16Rf7nOq1DEONMcgohfBYEG6w/SaJXkIbcfwHV22Gk=;
	h=From:To:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=kEm0d0548o+dGP463CSBtmPXZSzZZIqIac/vwAGEzpnxL86aIuftJuKlmxihSLyUbfq/UCFAYWSzq/DH5PLx1xpo3gkGyG2T6hSykW7PkpAwSvec3GbProA//aWIo1pSLm3aGig1CwfGH6j5q/6+QLrBylMqfY4Q2T3R4LekLkQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sizdaTn6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94702C113CC;
	Mon, 15 Apr 2024 10:53:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713178407;
	bh=n16Rf7nOq1DEONMcgohfBYEG6w/SaJXkIbcfwHV22Gk=;
	h=From:To:In-Reply-To:References:Subject:Date:From;
	b=sizdaTn6QTdBMtS9oKoSIk8h954pH0J+Zvp15nqoEioNThGzCwir2iMMvlpkxgDGT
	 Wbkl86+NvlBgLL5CR/C4sSC817sagZPT+L8KjCNSnccx1ajSDhy8CCEh2Kwdgu99Ob
	 XVi+X4CaoZaACd5QdjxrEK8Fwtsm+h43VBO+z8xX+/MllHcY/pz3CmIyj8uZpwNwr2
	 yEPC44Rh/nP0ZLK7DTTlJwezimVgW4G90FThqV5DbojZmluKic8IkWQO7obNHJB9hB
	 q/FKhd8Z9onIe9EQPW8REYLVesnWsbIWiBBA4nVR/36gLzNaKYwv/lcwfoXULBMG0C
	 HBm9+anPLQLig==
From: Mark Brown <broonie@kernel.org>
To: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Krzysztof Kozlowski <krzk@kernel.org>
In-Reply-To: <20240414154859.126931-1-krzk@kernel.org>
References: <20240414154859.126931-1-krzk@kernel.org>
Subject: Re: [PATCH] spi: altera: Drop unneeded MODULE_ALIAS
Message-Id: <171317840613.1652284.11599374071901058385.b4-ty@kernel.org>
Date: Mon, 15 Apr 2024 19:53:26 +0900
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14-dev

On Sun, 14 Apr 2024 17:48:59 +0200, Krzysztof Kozlowski wrote:
> The ID table already has respective entry and MODULE_DEVICE_TABLE and
> creates proper alias for platform driver.  Having another MODULE_ALIAS
> causes the alias to be duplicated.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: altera: Drop unneeded MODULE_ALIAS
      commit: 770e3da3fe7ee7ffca745b7ac300ce39fe40f465

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


