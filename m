Return-Path: <linux-kernel+bounces-59686-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5830684FA6A
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 18:00:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0E70B1F2151C
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 17:00:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37E1545015;
	Fri,  9 Feb 2024 16:58:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Scr9FsGX"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76E6A76905;
	Fri,  9 Feb 2024 16:58:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707497928; cv=none; b=lFXSaJuNp4qR3ONQIdnfOnjG20NZ2NFmNu2Ju7CFo91zTKho5itN9TYSsIe9X1GWXIGR7/YwIKRcYgY87MhyUUTPEtmmYcDcAnSbj8nq752nSvARHEk6mg9zgDO+kosIF15h50gpTtJ83o68EqlZE2N9HSqClBgr9S0D3YCQNHA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707497928; c=relaxed/simple;
	bh=kuhUnzCpcWAZsuKu51d9PcrOT0KC6o/IE8So0bTZM10=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=lN3PZejK2+MD0Ao386hjBOwTy4n5bC9kpM3M9hbkjdOvpO90Oi3RsHpQq9VGa3opNYAu75ZTBAJnM3WPo0OfbmBdMVlBTAuXf/6LcwbCcXo3hObw6O0IMOQNLzVhTzHN0tnF/6w5SZsdQ1D4ekFa3oSqMlz57ehwPmzK23wZCzI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Scr9FsGX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB9A2C433C7;
	Fri,  9 Feb 2024 16:58:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707497928;
	bh=kuhUnzCpcWAZsuKu51d9PcrOT0KC6o/IE8So0bTZM10=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=Scr9FsGXcsuBKOvlL+iVqVzpnGXSG3msIvejh70Wp12tO2or4+9Xs0dxwa4knQq6h
	 rcAmrlG2Or8IxrQ6xq4xv0cRGfdEiZGwHUWKghHVh2ziIqoQ76WAMD3GnRLLH033Ww
	 O+jx2KCrE/Z0xF73YvIO2LSQ7fkeFApvh6/U2USGApatkAoTnZ0NGRRB8+zbGvBgrG
	 eTjCB+JIdijR44mUWme3djHlHvZzuyFEm9NNBLUpmLRpXtL+3QUnoA/Q2iciQUgr5i
	 hr6A3pYv3miKz7Iiv9l0EaMrYmvIcf5Ohy4phucoSvkmdKBaZiuphUj2cOVbBNQL0F
	 fb25VuaKDO7aA==
From: Mark Brown <broonie@kernel.org>
To: Shenghao Ding <shenghao-ding@ti.com>, Kevin Lu <kevin-lu@ti.com>, 
 Baojun Xu <baojun.xu@ti.com>, Jaroslav Kysela <perex@perex.cz>, 
 Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>, 
 Gergo Koteles <soyer@irl.hu>
Cc: linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org, 
 alsa-devel@alsa-project.org
In-Reply-To: <454639336be28d2b50343e9c8366a56b0975e31d.1707456753.git.soyer@irl.hu>
References: <454639336be28d2b50343e9c8366a56b0975e31d.1707456753.git.soyer@irl.hu>
Subject: Re: [PATCH v4] ASoC: tas2781: remove unused acpi_subysystem_id
Message-Id: <170749792315.2378624.13516253552080654959.b4-ty@kernel.org>
Date: Fri, 09 Feb 2024 16:58:43 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-0438c

On Fri, 09 Feb 2024 06:59:34 +0100, Gergo Koteles wrote:
> The acpi_subysystem_id is only written and freed, not read, so
> unnecessary.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: tas2781: remove unused acpi_subysystem_id
      commit: 4089d82e67a9967fc5bf2b4e5ef820d67fe73924

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


