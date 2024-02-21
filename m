Return-Path: <linux-kernel+bounces-73878-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4942685CCED
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 01:49:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 04F01285C73
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 00:49:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C7C34428;
	Wed, 21 Feb 2024 00:48:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aPrYYuCB"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7F153FDB;
	Wed, 21 Feb 2024 00:48:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708476524; cv=none; b=aA0VHpIGnq1QS+uH+daVY+laku9CMBDurjYsLOygF1/5t56yFRyA4kWeZLCQCsAYNI1my7LT+ccPsSAA4wtUP4IR9AmO/Q+qhGL25wtF/D2pVeVLib3PHDgZq5PF1s3BdDeXWN5yfjmChsAZzXVotU+QImjRAwMJEcLo3C2Qz+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708476524; c=relaxed/simple;
	bh=f0jG7JZ9oh2O1noEl7FSZJMj5418rIWIIHqWyudoGRk=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=g3DXciLnPqki63LV44LKYnSnG+9iDLNkrSuIJoo6aL5O4iEaQLHOsdsBt3/IhQThbgIQcscwS6vggWGDON2PRpPyucu5EcaVT4zwawAn8/ZzV2Gu8nv2sKePIlBBfm/89baLCa2BCpeIRTM5Kgf0CxWKVEEZn+2oYopuiQhyCyM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aPrYYuCB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30ADEC433F1;
	Wed, 21 Feb 2024 00:48:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708476524;
	bh=f0jG7JZ9oh2O1noEl7FSZJMj5418rIWIIHqWyudoGRk=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=aPrYYuCBOEeHEvtgSRelFiBVH9qMaD+KPqoooZBez0TvDeo/idezdVyG/a/ZeA7TZ
	 R6ykl9fL46Hrvgp0COwiog14DB0o9T11hfZmPL7natdSMoGIBGmXuRbp3xCek3jtJp
	 NWjld4EeunGceUwcWYjnbatJ4bvfVENx3B2X64n4H2l2qq2yfIEm8xIOaq44eTDESj
	 kTalKSYeB97PYgepODNne24nkHiZqDoirwZBfH3/y1tv5ZhRpXA3mbDiji5TXdiZ5J
	 h1t6Lat8viEhVL0gxNTyy2CwhXr8R1ZtvnwRals7CWkLSP5KF8q+UZ7hh/INAtT9EA
	 i/rdPoNJCHHBQ==
From: Mark Brown <broonie@kernel.org>
To: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
Cc: alsa-devel@alsa-project.org, Basavaraj.Hiregoudar@amd.com, 
 Sunil-kumar.Dommati@amd.com, Mario.Limonciello@amd.com, 
 venkataprasad.potturu@amd.com, Liam Girdwood <lgirdwood@gmail.com>, 
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, 
 Arnd Bergmann <arnd@arndb.de>, 
 Cristian Ciocaltea <cristian.ciocaltea@collabora.com>, 
 Lucas Tanure <lucas.tanure@collabora.com>, 
 Syed Saba Kareem <Syed.SabaKareem@amd.com>, 
 Carlos Bilbao <carlos.bilbao@amd.com>, 
 Mario Limonciello <mario.limonciello@amd.com>, 
 "open list:SOUND - SOC LAYER / DYNAMIC AUDIO POWER MANAGEM..." <linux-sound@vger.kernel.org>, 
 open list <linux-kernel@vger.kernel.org>
In-Reply-To: <20240214104014.1144668-1-Vijendar.Mukunda@amd.com>
References: <20240214104014.1144668-1-Vijendar.Mukunda@amd.com>
Subject: Re: [PATCH 1/5] ASoC: amd: ps: refactor acp device configuration
 read logic
Message-Id: <170847652092.70487.7212581816199412994.b4-ty@kernel.org>
Date: Wed, 21 Feb 2024 00:48:40 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-a684c

On Wed, 14 Feb 2024 16:10:01 +0530, Vijendar Mukunda wrote:
> Refactor acp device configuration read logic and use common function
> to scan SoundWire devices.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/5] ASoC: amd: ps: refactor acp device configuration read logic
      commit: 0386d765f27a1fd3ed2ed6388a07e26d9659936d
[2/5] ASoC: amd: ps: refactor acp child platform device creation code
      commit: eaf825037d6df89811d43391be920bf6ad731463
[3/5] ASoC: amd: ps: remove acp_reset flag
      commit: 3c697ced399cac295c34c9611f05d04f4c951aa9
[4/5] ASoC: amd: ps: fix for acp pme wake for soundwire configuration
      commit: c76f3b1f9b9ae20f8c944bb01c395329d525a917
[5/5] ASoC: amd: ps: add machine select and register code
      commit: bbf3e6145ea09cf346ce09146b0b98415095f170

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


