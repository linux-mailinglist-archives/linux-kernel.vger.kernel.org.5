Return-Path: <linux-kernel+bounces-162556-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 39E488B5D47
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 17:19:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CDB591F20172
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 15:19:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30FFE127E04;
	Mon, 29 Apr 2024 15:11:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hLJPYumP"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 703307E0F2;
	Mon, 29 Apr 2024 15:11:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714403503; cv=none; b=SmC1off2nnKvtaXfyyPJ1C9oj5wlH+4dAV6M0u0k+G9jcE4v4pDDjqCkZEeJ2TNyvSODxrUmTdRSH7+Qfh1I4K1aFfB0YnTengavqCQbk3ZtWoiLmIUmd1NoSg5hB6PPM88m5l+yFeIKTbpSDpkO4fr/6M6rQVbzrVpvTo0nR7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714403503; c=relaxed/simple;
	bh=CIXcvwGpFixZBreh058VGVZ+NOH7kWo7gvJMk6mMaT0=;
	h=From:To:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=TFfL+SVBncP76GNMDEBNGwYXnqUDH2NVtrrGzQZqp7KOK7SlxxGZpzZEiMTVGKb0rVpWuEduMEDfCaqfNcOyf0Iru6Qu1S2v4O6MleWVrqNIXkkE48H7AeZRRV1Ow44qOQtpg5i3xJsqI2zRVv0ouf3FslV2b2uaVcLAWZfbwEA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hLJPYumP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 253CEC113CD;
	Mon, 29 Apr 2024 15:11:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714403502;
	bh=CIXcvwGpFixZBreh058VGVZ+NOH7kWo7gvJMk6mMaT0=;
	h=From:To:In-Reply-To:References:Subject:Date:From;
	b=hLJPYumPEJljAUpSPqB51Tw+uwapqs/KBo9lShECozqJ4aDIqpBSZo7L6/mnlw5rM
	 5pRa1OSV220E6k9izAnlr/re74u/QJt3AHX83ZB3dsKBxHQYZTJQfgyJ+cuk0s2M5K
	 4N6ga9msjiTrxEFMhAtcRSQ6QxeNfLB+LiHJGiR2j/WOkbOiBGjGFcO6xDTsvYnFqF
	 eAYC9xpDPwgyAnLOM22W0e1jHI9fpugp77mMC9TK9D2fMdoqnFefQN2lra44ccFFSD
	 ad2/pP+ui/dy5IuchWSPBCRK4f6JnkVYWkd6P/JWgQjZMDBLIFXW6ktDHxi5F6a1oc
	 RP8ErvancuySQ==
From: Mark Brown <broonie@kernel.org>
To: lgirdwood@gmail.com, robh@kernel.org, krzk+dt@kernel.org, 
 conor+dt@kernel.org, shengjiu.wang@gmail.com, linux-sound@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Shengjiu Wang <shengjiu.wang@nxp.com>
In-Reply-To: <1714026906-16723-1-git-send-email-shengjiu.wang@nxp.com>
References: <1714026906-16723-1-git-send-email-shengjiu.wang@nxp.com>
Subject: Re: [PATCH v3] ASoC: dt-bindings: fsl,ssi: Convert to YAML
Message-Id: <171440350070.1835960.10169386594914544102.b4-ty@kernel.org>
Date: Tue, 30 Apr 2024 00:11:40 +0900
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14-dev

On Thu, 25 Apr 2024 14:35:06 +0800, Shengjiu Wang wrote:
> Convert the fsl,ssi binding to YAML.
> 
> Add below compatible strings which were not listed
> in document:
> 
> fsl,imx50-ssi
> fsl,imx53-ssi
> fsl,imx25-ssi
> fsl,imx27-ssi
> fsl,imx6q-ssi
> fsl,imx6sl-ssi
> fsl,imx6sx-ssi
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: dt-bindings: fsl,ssi: Convert to YAML
      commit: 2da01ca3674c6e90dbeeda02168849e2ec877edc

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


