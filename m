Return-Path: <linux-kernel+bounces-48714-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 846F6846018
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 19:39:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B70A31C24BE2
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 18:39:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FE2E7C6C9;
	Thu,  1 Feb 2024 18:39:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uAjMXxKM"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B1D241757;
	Thu,  1 Feb 2024 18:39:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706812782; cv=none; b=DpsK9tnMvJkyGv0pQhkze+vitNHeHlRrHJrgW6o3A3V9ikM/HAAJ9Ppattwt2d7un5B4kr/TREGhdLWDqTFA89HNFhKnGhmx+ZsVtmyHvDXT/AGCqPSEOWghClI3ic1wi5FQmCqfKhP+BjHQd5O+KM74IWJSVt6s3rwj3A+RMKs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706812782; c=relaxed/simple;
	bh=tgw4+yNSXYvoHx+l8Du/I6ui5/EiC9XA6FnewlYo6Ds=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=K82pyEUO9QUSwM1WfX5k7m01hfvcebFD1m+raVWaSYoXM8uxgseKuuRcGoaYo0BEjvSNg3+4Td1NOfM/TAD/VA+pYBuXtwAOflxsHqc6E9UBS6J6TpaKPibdRAuJvz1XMMD+ctFtWItb7pDhLRT3F3lhZF5AVYPW9NqtCsMx7Fk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uAjMXxKM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A25AC433F1;
	Thu,  1 Feb 2024 18:39:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706812781;
	bh=tgw4+yNSXYvoHx+l8Du/I6ui5/EiC9XA6FnewlYo6Ds=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=uAjMXxKMTVJzhSaQ6MunzoQr2LwnkYgozso/cc6+ZUewd58ICKl5RCUR8UYtxzWfD
	 QfajRXeB36x7zyK5WDXuh1esYUYTH0jW2QKjolsI1T5q4kYYG5LiYXQBd2o8x+ZR3T
	 bDCl8Qg+kfA1tIXXmSqL5UATJENyM8l8qMu2BpN2hvu12jLbGVHQoEXM0v7hA7Yw4/
	 wPsWe6Hq8QslfG8Ki4IPgaqTC680aHdlay95vZ8Xva3DWsNP/DHEprwbhE8rT4RoG/
	 NZkorIl6P9YBlQ3OTneFgjVEBzuQRrDLAXmobKcwZnAQC+lmPvxYfyzZ5E39Jja8VV
	 EKqLrSYNUXBrg==
From: Mark Brown <broonie@kernel.org>
To: tiwai@suse.com, Richard Fitzgerald <rf@opensource.cirrus.com>
Cc: alsa-devel@alsa-project.org, linux-sound@vger.kernel.org, 
 linux-kernel@vger.kernel.org, patches@opensource.cirrus.com
In-Reply-To: <20240129162737.497-1-rf@opensource.cirrus.com>
References: <20240129162737.497-1-rf@opensource.cirrus.com>
Subject: Re: [PATCH 00/18] ALSA: Various fixes for Cirrus Logic CS35L56
 support
Message-Id: <170681278028.203738.8808339176775600542.b4-ty@kernel.org>
Date: Thu, 01 Feb 2024 18:39:40 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-a684c

On Mon, 29 Jan 2024 16:27:19 +0000, Richard Fitzgerald wrote:
> This chain of patches fixes various things that were undocumented, unknown
> or uncertain when the original driver code was written. And also a few
> things that were just bugs.
> 
> The HDA patches have dependencies on the ASoC patches, except for the final
> patch that removes a bogus test stub function.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[01/18] ASoC: wm_adsp: Fix firmware file search order
        commit: 3657e4cb5a8abd9edf6c944e022fe9ef06989960
[02/18] ASoC: wm_adsp: Don't overwrite fwf_name with the default
        commit: daf3f0f99cde93a066240462b7a87cdfeedc04c0
[03/18] ASoC: cs35l56: cs35l56_component_remove() must clear cs35l56->component
        commit: ae861c466ee57e15a29d97629e1c564e3f714a4f
[04/18] ASoC: cs35l56: cs35l56_component_remove() must clean up wm_adsp
        commit: cd38ccbecdace1469b4e0cfb3ddeec72a3fad226
[05/18] ASoC: cs35l56: Don't add the same register patch multiple times
        commit: 07687cd0539f8185b6ba0c0afba8473517116d6a
[06/18] ASoC: cs35l56: Remove buggy checks from cs35l56_is_fw_reload_needed()
        commit: 3739cc0733ba7eeafc08d4d4208d1f3c2451eabd
[07/18] ASoC: cs35l56: Fix to ensure ASP1 registers match cache
        commit: 72a77d7631c6e392677c0134343cf5edcd3a4572
[08/18] ASoC: cs35l56: Fix default SDW TX mixer registers
        commit: 782e6c538be43a17e34f552ab49e8c713cac7883
[09/18] ALSA: hda: cs35l56: Initialize all ASP1 registers
        commit: 856ce8982169acb31a25c5f2ecd2570ab8a6af46
[10/18] ASoC: cs35l56: Fix for initializing ASP1 mixer registers
        commit: 07f7d6e7a124d3e4de36771e2a4926d0e31c2258
[11/18] ASoC: cs35l56: Fix misuse of wm_adsp 'part' string for silicon revision
        commit: f6c967941c5d6fa526fdd64733a8d86bf2bfab31
[12/18] ASoC: cs35l56: Firmware file must match the version of preloaded firmware
        commit: f4ef5149953f2fc04907ca5b34db3df667dcddef
[13/18] ASoC: cs35l56: Load tunings for the correct speaker models
        commit: 245eeff18d7a37693815250ae15979ce98c3d190
[14/18] ASoC: cs35l56: Allow more time for firmware to boot
        commit: 9e92b77ceb6f362eb2e7995dad6c7f9863053d97
[15/18] ALSA: hda: cs35l56: Fix order of searching for firmware files
        commit: 77c60722ded7d6739805e045e9648cda82dde5ed
[16/18] ALSA: hda: cs35l56: Fix filename string field layout
        commit: e82bc517c6ef5d5c04b845420406e694c31bdb8a
[17/18] ALSA: hda: cs35l56: Firmware file must match the version of preloaded firmware
        commit: 6f8ad0480d82245961dae4d3280908611633872d
[18/18] ALSA: hda: cs35l56: Remove unused test stub function
        commit: 28876c1ae8b8cd1dacef50bd6c0555824774f0d2

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


