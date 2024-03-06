Return-Path: <linux-kernel+bounces-93892-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CF6F487366B
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 13:31:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 657C51F245DE
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 12:31:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A28EC8120E;
	Wed,  6 Mar 2024 12:30:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mO9dGTVu"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB70D81AA7
	for <linux-kernel@vger.kernel.org>; Wed,  6 Mar 2024 12:30:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709728238; cv=none; b=XVpOTeLPrhtw+Kn12zRW5+z3EAK/08kUnaWFlwrFox6477Mz+iDmvx7lbFW0T9s9yEgbfQv4OAtE3q8WL78l9l0c5eykD8pbxqI+3/ldKyiIKg7EeMAzfHGsI5Epjru63kYFBFE9VbSYe/ENODstwbeN+7659ZyjetPyC07pHYc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709728238; c=relaxed/simple;
	bh=pdMYFUtmmmiHYhf0XcZfaR/D30jt3cb2Ukz7Zk/Zn7U=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=gjqCBAloOCzxQvG4+2ATpFt2EYI6mdk9+b2e0anUbOW7EKYPiEURhllUoOFdJ2gzuaAIJEMqDBZ9KJE8qNTJ9pY1/UnIuOThHSywKm99SpDHHPXjhaIRwSYnEFHR1y2QiQrGJbHAh7wboLs0w5myp95N0Xwazfy3dWSQPrf9t6Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mO9dGTVu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76E80C433F1;
	Wed,  6 Mar 2024 12:30:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709728237;
	bh=pdMYFUtmmmiHYhf0XcZfaR/D30jt3cb2Ukz7Zk/Zn7U=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=mO9dGTVuVm6qAACXwrFIOPdjQghjj2/fWHwiTAS7YKYreqNFSCpIAhTNbOtFyMI+u
	 AXAh/mHIOOY0wjd5YkimFhVMDT9lgmVaoEyQ/ZtxiMI69nmdTW/MxGDM0qvHun2K3d
	 POn/JpUuoq2Xjbj3HeeOamuSPRUgMQR+8EO5lKLr009aYeV9v1DwGwXNRr5b1zSoda
	 8Oa6yIdbT2ZvigrZlrFHUrltS0lwzR9URi7gNYJqUWvKa8gKkNtHZivkAKL043rtoP
	 ud7VcBlcX+vMwtk8NRCYjKPO+qGX0Ez12rxbYCBt6dz5C8ZV78dG9WGfOXT5tUSsiv
	 ZR0puu5316BUg==
From: Mark Brown <broonie@kernel.org>
To: Liam Girdwood <lgirdwood@gmail.com>, 
 "Ricardo B. Marliere" <ricardo@marliere.net>
Cc: linux-kernel@vger.kernel.org, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
In-Reply-To: <20240305-class_cleanup-regulator-v1-1-4950345d6d8f@marliere.net>
References: <20240305-class_cleanup-regulator-v1-1-4950345d6d8f@marliere.net>
Subject: Re: [PATCH] regulator: core: make regulator_class constant
Message-Id: <170972823620.17754.2739172116321783279.b4-ty@kernel.org>
Date: Wed, 06 Mar 2024 12:30:36 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-a684c

On Tue, 05 Mar 2024 16:00:45 -0300, Ricardo B. Marliere wrote:
> Since commit 43a7206b0963 ("driver core: class: make class_register() take
> a const *"), the driver core allows for struct class to be in read-only
> memory, so move the regulator_class structure to be declared at build time
> placing it into read-only memory, instead of having to be dynamically
> allocated at boot time.
> 
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git for-next

Thanks!

[1/1] regulator: core: make regulator_class constant
      commit: 4fe6207508d6525e87149348daeafde152ba672c

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


