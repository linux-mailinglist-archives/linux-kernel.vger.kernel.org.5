Return-Path: <linux-kernel+bounces-58351-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 64EAE84E50C
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 17:33:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A16991C21924
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 16:33:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBF877E771;
	Thu,  8 Feb 2024 16:33:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YA+ccIpL"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E022256B67;
	Thu,  8 Feb 2024 16:33:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707409992; cv=none; b=j4Hvf74YsohMk0UABj5iWYm1IL2QSXuG5zf3t3+GuuZk4pFzRsHuFWZpyhrMuzXdKwsnA5lXfjp21XPM3fN07WcWdSBTZ5sInu+2yRKlKaw26OaMmfO040D4eSWf3SeYozzfFrXvixpCWRs8h6Zkj7xfg7YQDyAWPHvnBEh1ylI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707409992; c=relaxed/simple;
	bh=U2h6ifeTXfp7OttADtuI4LwK9zFHLvjT3WhsVAKEzwU=;
	h=From:To:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=PtrGHbGZhuWzW8BJItNxAYil5wOlJDl5abV8OLQ9KZ/dN02E3+0BYXehZl+zpWR5UtKdQ5g0nPBtb+XHRGnbuLk6fCqIqjIW408tYbFVvWeDsBzSZA5ZObxWbxncX28GNHpZABD/KotHfdD1B3fNOGzU+Fj6nuds+Ahus9TAUxA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YA+ccIpL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A134C433F1;
	Thu,  8 Feb 2024 16:33:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707409991;
	bh=U2h6ifeTXfp7OttADtuI4LwK9zFHLvjT3WhsVAKEzwU=;
	h=From:To:In-Reply-To:References:Subject:Date:From;
	b=YA+ccIpLfMKbG95rD80swyjPLGgz6tnxxQQHF9rAY2r6HQ9irarVLaXuMSJxUoMfw
	 6+oL6T7vplA0dyUrWIV5bYf6P6V9iyF7+SJvhb3fJ5UBVDvRfRTdTXDla3z6l7s9hK
	 jhiToqEYAcGYVZgAyCFt5FWsjlCC3elTeeHGKlYAyV5Qydo8aVWFVZ4fESWbQPAC+W
	 KA/AsOFyII3x46nk/7sjJla8lNDQ/V3MnMhMXnbL95iNy5qcvG7BAynfqWvYe0rT+F
	 LO5bt+FBWy+B5Z2yRWCtaHuYYDGBINFamFI9JEwTah9jQwR2mx7L0VAORZtFH0uVTs
	 CCM4kUaHKpDbw==
From: Mark Brown <broonie@kernel.org>
To: Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, 
 Takashi Iwai <tiwai@suse.com>, Oder Chiou <oder_chiou@realtek.com>, 
 linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20240208105011.128294-1-krzysztof.kozlowski@linaro.org>
References: <20240208105011.128294-1-krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH] ASoC: codecs: constify static sdw_slave_ops struct
Message-Id: <170740998921.1643172.8207372175499167352.b4-ty@kernel.org>
Date: Thu, 08 Feb 2024 16:33:09 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-0438c

On Thu, 08 Feb 2024 11:50:11 +0100, Krzysztof Kozlowski wrote:
> The struct sdw_slave_ops is not modified and sdw_driver takes pointer to
> const, so make it a const for code safety.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: codecs: constify static sdw_slave_ops struct
      commit: fd38b4e41096f5c72a1623ba5984e2d4d2a799c4

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


