Return-Path: <linux-kernel+bounces-67373-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EE5D3856A95
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 18:09:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A6FEC281BBD
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 17:09:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88AEF13666F;
	Thu, 15 Feb 2024 17:09:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Vz3BXJ6+"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C84EA12DD9A;
	Thu, 15 Feb 2024 17:08:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708016939; cv=none; b=sNaMNCdR851fX61D8i5ZuQmw4wTbbxd2R4+DYB7KwarM5MWMsNM+bx1R+vY0iJk0BPeKPQQ9rb759dMBy/9rj9S6xtKyAsZtE/4Rm0CCLfmTkvRv0NKUi6Js2jL/Hxmj+z2HZRpZTkHjdO0gKXKa/DH2yeiKDWrDIQRKnNgQP/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708016939; c=relaxed/simple;
	bh=IMXJE45lWQekeaLIZjfOoc/Fs5C6NndcB5OT80m0SDc=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=HJg2pzczmAbRW8lQYB08dEzSGLngcFBUU6DJ7hfWAUP4kbFgInxKHLJY6q/cC+Zrm7TZjIHTCktPhJVXRiGdKQtuua5YmD4/wlin+6wSEVWyMVpbPMjfIcxt7fIwiEzFdMjIUzLpl9GdwELvtOKz548PTym9OUddAGn9q5CmMwQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Vz3BXJ6+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14BA2C433F1;
	Thu, 15 Feb 2024 17:08:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708016939;
	bh=IMXJE45lWQekeaLIZjfOoc/Fs5C6NndcB5OT80m0SDc=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=Vz3BXJ6+GCcZ4t9+MaxoAYpJ45VKTjECTSUsRCw+Cv1KFa6c5l5nlgnyQU3A/4nxF
	 b68y1NW3le5lEoi0pU58mdeADUp/P0yoJlcuF3gquGJ5ld9FHnwisB6G+xYMhL4nCO
	 UXtDjMSdX3D2yFs2ICxF3kTa3WzWGyR0V5IcilOQJbqY9Wz2j+ikMC/MqRB5/TUNTw
	 3sg3zddz7eCKnuY9j7xuH8nvbph/HqB0i4fcRLhj5BWrcqPKd2uhQZD/cKO/c/ONxd
	 0UvxiNFNWZ0S/1jtcYuqdUIgHurhqKxNI9vA1dKAgVyn4ilfVXRl//s81sn/6Jzx6P
	 Tkv+IELUXD2rQ==
From: Mark Brown <broonie@kernel.org>
To: linux-sound@vger.kernel.org, Masahiro Yamada <masahiroy@kernel.org>
Cc: Jaroslav Kysela <perex@perex.cz>, Liam Girdwood <lgirdwood@gmail.com>, 
 Takashi Iwai <tiwai@suse.com>, linux-kernel@vger.kernel.org
In-Reply-To: <20240215132854.1907630-1-masahiroy@kernel.org>
References: <20240215132854.1907630-1-masahiroy@kernel.org>
Subject: Re: [PATCH] ASoC: codecs: remove redundant 'tristate' in
 sound/soc/codecs/Kconfig
Message-Id: <170801693779.201416.2907627102331688225.b4-ty@kernel.org>
Date: Thu, 15 Feb 2024 17:08:57 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-a684c

On Thu, 15 Feb 2024 22:28:54 +0900, Masahiro Yamada wrote:
> The type 'tristate' is already specified three lines above.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: codecs: remove redundant 'tristate' in sound/soc/codecs/Kconfig
      commit: 74e0259495cfab4f92c64ddcbbfe454e5c2f962a

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


