Return-Path: <linux-kernel+bounces-62382-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 85277851F7B
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 22:22:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 217D01F214A5
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 21:22:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D152C4CB3D;
	Mon, 12 Feb 2024 21:22:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i0yKSdNZ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18DC51DDC5;
	Mon, 12 Feb 2024 21:22:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707772931; cv=none; b=JdQuHyMIwSZ6VSSCF4J2POOqSuMSdGE6tacqFkWw/TuNZY0wRLIWTCDi+uvaOaAsbNcL62+yUQurqQyJPQFVFr1tq+yu2Iqrg2DDA+W5sTFUNiJl40sYcHPRDdmnuR8DG4Z/gcZXCN5peC3bI15nyYrXb3AOiY4f/AsqWBpI2pg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707772931; c=relaxed/simple;
	bh=1rx7kpjCPmL65LQFQpMRRKlfF+9sl509SCwN0u+4WzQ=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=atczVQZfzzS1AtBNcBHP7f6otMQGxpS+mlGbBIjx0F8YPZvVXGPT3ZeyO5m2QNLIZ3rhvyZZ1mjRmsdsRUF0n98pNUq2rcXEuFuoDo3dyGXCw1630/GbpUKaafY+rvtfDOkB+2FMtecK4GMreyiSVPb+FONKIEg3Rv9SroPUCAQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i0yKSdNZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F736C43390;
	Mon, 12 Feb 2024 21:22:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707772930;
	bh=1rx7kpjCPmL65LQFQpMRRKlfF+9sl509SCwN0u+4WzQ=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=i0yKSdNZAerspb+UsXpVYXVlPFqWmp0l+FG742f8AoBqcnMNuf/ALaKfDJ8kdgHo+
	 WoFa5dUMyHB/DY74o80FC9mfvgcvADXs0OnbXgu6dsNhFA4IBoHzFPcrF4bARfRGt+
	 treekkUGIdZY2CrFZBJKGoxRoWl0T7+DzUByd4mLuO22KsmoAEXcuREKPKNbxRGvB7
	 SUJ13qacE8eGYwm+t+pvkeBuPGXiii2eBKnckJGQaK64jYZu5TWFTbt6m3Y5LZrVj8
	 6W9IsFec1lPuxKoEsfI1606mYfWNq1PrvNTU9yEtgx3iEYn6LTiqovSTPehATfaIKG
	 Hc8mGKzgTWw7g==
From: Mark Brown <broonie@kernel.org>
To: linux-sound@vger.kernel.org, 
 "Daniel Baluta (OSS)" <daniel.baluta@oss.nxp.com>
Cc: lgirdwood@gmail.com, linux-kernel@vger.kernel.org, linux-imx@nxp.com, 
 kai.vehmanen@linux.intel.com, peter.ujfalusi@linux.intel.com, 
 Daniel Baluta <daniel.baluta@nxp.com>, 
 Iuliana Prodan <iuliana.prodan@nxp.com>, 
 Laurentiu Mihalcea <laurentiu.mihalcea@nxp.com>, 
 Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, 
 Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
In-Reply-To: <20240212125258.420265-1-daniel.baluta@oss.nxp.com>
References: <20240212125258.420265-1-daniel.baluta@oss.nxp.com>
Subject: Re: [PATCH] ASoC: SOF: imx: Add devicetree support to select
 topologies
Message-Id: <170777292803.73793.8628785100114235741.b4-ty@kernel.org>
Date: Mon, 12 Feb 2024 21:22:08 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-a684c

On Mon, 12 Feb 2024 14:52:58 +0200, Daniel Baluta (OSS) wrote:
> We describe tplg_file_name and drv_name using snd_sof_of_mach
> array and select correct machine description based on dts compatible
> string.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: SOF: imx: Add devicetree support to select topologies
      commit: 2b9cdef13648bebf79f029deb622e02099146c18

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


