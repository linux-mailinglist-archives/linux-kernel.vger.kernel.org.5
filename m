Return-Path: <linux-kernel+bounces-95779-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 40B8387527C
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 15:56:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E61B81F245A2
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 14:56:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF37112DDBE;
	Thu,  7 Mar 2024 14:55:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ttJeT32c"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F61A1EB40;
	Thu,  7 Mar 2024 14:55:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709823355; cv=none; b=nS1+JtiVtQwKTxw2UgcCzA6NVheTSItwjRPYx38XptJsDkt6RTwRD3b+E0faJdmsTtp/poGQU2RerTIEkTVeVfkh9MSH8cu9kkLZ6btoeT7sWuz2dXr3lLwkoqr/ctyz2I4VHtUzsgcxtgEPRGrAivRed8HweC+1wL6htaxIGSQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709823355; c=relaxed/simple;
	bh=yvWbqsd/c+r0lbhGPO4lqFdi7lTy3J5AN6rJtoM7+iQ=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=gduGtl3mHYB+6BDeRBuRaixdKqrBSTkeYuLdCE5BLoIyfsCZFrbF+MMy+PvJ2YL32sFzKabgonvlRLJUPd6+jhTXmXUypsA7MyWUZmXvPJ73oxtOTGGd6GMsp6TXJHCzERcJ+h6tOHGFoUpBks/g+dP1YtPZNJOWf035eVKzX9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ttJeT32c; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0ADBDC433C7;
	Thu,  7 Mar 2024 14:55:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709823355;
	bh=yvWbqsd/c+r0lbhGPO4lqFdi7lTy3J5AN6rJtoM7+iQ=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=ttJeT32c3lIc134VYxIOjcK8MhEEqbVKwiDgEsM2Pdaqx3typMN2W1KAhZqRlFiJp
	 Lz8fgI+EqclmMZ5xA+o50omWpXLT0Vt+Qvfjq6DhCeOKXaFbKQY6WFreY7oqchxZo3
	 AfwMs8MnHHI8/bFbrhR5ut2Kv7UOhev/xVysDqaKB2Q7vuAtqnEWRDT4MRUHyP9EPP
	 WkfQqS5MQJQ+GmaBdKflAsy5ad7e0Nwcqzsbt8tyKQUBm5EHgsjZojK9KoR4tUYzmS
	 HpjZCcR3lFw76siSnnbRGxHdjIIIWUQ0qxZS053FXnUbt2XSTvlnIVoFetAZvqyxKx
	 NOLlfxKr2yD0g==
From: Mark Brown <broonie@kernel.org>
To: Richard Fitzgerald <rf@opensource.cirrus.com>
Cc: linux-sound@vger.kernel.org, alsa-devel@alsa-project.org, 
 linux-kernel@vger.kernel.org, patches@opensource.cirrus.com
In-Reply-To: <20240307105353.40067-1-rf@opensource.cirrus.com>
References: <20240307105353.40067-1-rf@opensource.cirrus.com>
Subject: Re: [PATCH] firmware: cirrus: cs_dsp: Initialize debugfs_root to
 invalid
Message-Id: <170982335375.46708.557228863521307529.b4-ty@kernel.org>
Date: Thu, 07 Mar 2024 14:55:53 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-a684c

On Thu, 07 Mar 2024 10:53:53 +0000, Richard Fitzgerald wrote:
> Initialize debugfs_root to -ENODEV so that if the client never sets a
> valid debugfs root the debugfs files will not be created.
> 
> A NULL pointer passed to any of the debugfs_create_*() functions means
> "create in the root of debugfs". It doesn't mean "ignore".
> 
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] firmware: cirrus: cs_dsp: Initialize debugfs_root to invalid
      commit: 66626b15636b5f5cf3d7f6104799f77462748974

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


