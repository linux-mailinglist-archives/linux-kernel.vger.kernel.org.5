Return-Path: <linux-kernel+bounces-95981-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 17D3D87559B
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 18:55:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AC5001F222CE
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 17:55:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6539D130E5E;
	Thu,  7 Mar 2024 17:54:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JnuyfUZ5"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A85E517722;
	Thu,  7 Mar 2024 17:54:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709834097; cv=none; b=g5UE541XGVHZrzKTnQ/FKS6fVf1oxmfICFe7S0bnkEZfsmopGOxvX2XG7gvX3c4dK5SLW9kIKbaYHuehaB7z7O2SMRg58rBlcCwAfmdSs5qg7yokbn+M0HAOUa/FMEQ7lGyPdFJK/ef66s2lD/FFW0JM3dszWxEpi9nH/MOxlxQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709834097; c=relaxed/simple;
	bh=N/G00rBhFeUtQPFUnLF5UqWzkC0ItgBzrXMdpGLMz58=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=d3Ie7tjbZ415tluOgGbXrv5GzZ4dheQ+ASQU7JBwXxUW8MdZzDRVQENTM6WZr4JmdHAvGEZn0bGrZvRojDkewjq7szxnMGPffxdwobMGV/H0R3agYcpmOX+saW0/cR48LppS9wzdz2Ymoxd+vUji807Ch/wYyCaRgfWZQmtfbcY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JnuyfUZ5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CAE23C433C7;
	Thu,  7 Mar 2024 17:54:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709834097;
	bh=N/G00rBhFeUtQPFUnLF5UqWzkC0ItgBzrXMdpGLMz58=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=JnuyfUZ5k6RipLTJCjx0fB7LjTyCGUd8FcKG8zqs2T3r6UC2h3eX1v8ATZzAxx+Yp
	 pYZncg0OdtOt84ZvuAKkfXJKxNwf0HqcEWVnhbyHjrW3ZDMAPYsq/e1g36Zm69DCGz
	 y03mX2SOJHbBLK4ffQeATEek14ejx7XdAnKqQTZNV8SsaEAQww09Gh64i4Qnb7DucA
	 aY1B0UKXp3Jjv3ap6vh20yzAeTNc12yiFLnaimwhxwPpSVfQY1bupmajce3ey2MnRU
	 cHYXCVHj6fjAf7K3bh58r0ZIk1s3RA+wvMov59fRY/lH65ywsvr7EfRgW+oBrgc4M2
	 Q9OzcxFbbUI9Q==
From: Mark Brown <broonie@kernel.org>
To: alsa-devel@alsa-project.org, linux-sound@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Cezary Rojewski <cezary.rojewski@intel.com>, 
 Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, 
 Liam Girdwood <liam.r.girdwood@linux.intel.com>, 
 Peter Ujfalusi <peter.ujfalusi@linux.intel.com>, 
 Bard Liao <yung-chuan.liao@linux.intel.com>, 
 Ranjani Sridharan <ranjani.sridharan@linux.intel.com>, 
 Kai Vehmanen <kai.vehmanen@linux.intel.com>, 
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
In-Reply-To: <20240307163734.3852754-1-andriy.shevchenko@linux.intel.com>
References: <20240307163734.3852754-1-andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v1 1/1] ASoC: Intel: catpt: Carefully use PCI bitwise
 constants
Message-Id: <170983409454.99823.12509782331460236693.b4-ty@kernel.org>
Date: Thu, 07 Mar 2024 17:54:54 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-a684c

On Thu, 07 Mar 2024 18:37:34 +0200, Andy Shevchenko wrote:
> PM constants for PCI devices are defined with bitwise annotation.
> When used as is, sparse complains about that:
> 
>   .../catpt/dsp.c:390:9: warning: restricted pci_power_t degrades to integer
>   .../catpt/dsp.c:414:9: warning: restricted pci_power_t degrades to integer
> 
> Force them to be u32 in the driver.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: Intel: catpt: Carefully use PCI bitwise constants
      commit: 6c023ad32b192dea51a4f842cc6ecf89bb6238c9

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


