Return-Path: <linux-kernel+bounces-100519-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 64836879904
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 17:35:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 21045282130
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 16:35:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8488A7E114;
	Tue, 12 Mar 2024 16:34:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YAK8SFV4"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF68D7B3C7;
	Tue, 12 Mar 2024 16:34:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710261298; cv=none; b=KsxBxW/MLT+RwNDZoKt33G1qt62+yq8lFF8dzittY1ZFnNI/6qmiOLzHpmBLVAjj2EckDBKMoleLE/3UMKfBac7ZoFuxiR+GKb5ADUuLARr1sEH2alZr5SFEboth828xAU4kmbaBkZ13sBGRQlVzwiG8jTTlZob60UVAxQ4+8IY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710261298; c=relaxed/simple;
	bh=Cmo2h33xnIVZ51l0Jr3ECDBtOxBycgNPcKHNVQygTMc=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=Bv9s8XzHsvP+67zrvjWyBELdJHqipPNqXaObTb3axWBaDhucEuVKXhmyYuwP9B1kfsBp5I9gxFsecr2ahOPA16GdH2VjNto6VqmuppAqhuiJH37ILkUgPO8Ib5I3DLsGUek/BTCmqfsr0CFPaEfMCl3lVIB2Ovmzy9In5QRVsh4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YAK8SFV4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0244CC43390;
	Tue, 12 Mar 2024 16:34:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710261298;
	bh=Cmo2h33xnIVZ51l0Jr3ECDBtOxBycgNPcKHNVQygTMc=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=YAK8SFV4cvlTKno3xc3IG3AmdA59fqu8UcsDkl1snvFC9k5zpk8/V568tyFt+1bjs
	 r+TOK5lqddbgXdLLCLtGogNgilHOFP6wBCtm/39CKveeqjui6wUJv6rcrlJfXKrGqe
	 gSgXzEyocOKQ+P8rlR2n1cWj0ntcTMSRtbWASNHWx9hm77gMM/u9EKYlHxXyX2gGep
	 fxbqSF+ZEqbKNDGvzPIqtVHLuo8fkrnM3z4LEYXKup0gEZfG51imwuzE2eT6GEeSHD
	 UIZkjtTxmSvZjHCq2FJ9udEQReoRpNyWnBKs1vN7ju1w1bZ3VTrH4A8XSaxwWXIXBW
	 N1Km9vM9s4gzw==
From: Mark Brown <broonie@kernel.org>
To: James Schulman <james.schulman@cirrus.com>, 
 David Rhodes <david.rhodes@cirrus.com>, 
 Richard Fitzgerald <rf@opensource.cirrus.com>, 
 Liam Girdwood <lgirdwood@gmail.com>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, patches@opensource.cirrus.com, 
 Rob Herring <robh@kernel.org>
Cc: alsa-devel@alsa-project.org, linux-sound@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20240311222554.1940567-1-robh@kernel.org>
References: <20240311222554.1940567-1-robh@kernel.org>
Subject: Re: [PATCH] ASoC: dt-bindings: cirrus,cs42l43: Fix 'gpio-ranges'
 schema
Message-Id: <171026129573.52506.3566774903045990906.b4-ty@kernel.org>
Date: Tue, 12 Mar 2024 16:34:55 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-a684c

On Mon, 11 Mar 2024 16:25:53 -0600, Rob Herring wrote:
> 'gpio-ranges' is a phandle-array which is really a matrix. The schema in
> cirrus,cs42l43 is incomplete as it doesn't define there's only a single
> entry. Add the outer array constraints that there is a single entry.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: dt-bindings: cirrus,cs42l43: Fix 'gpio-ranges' schema
      commit: 10eb0d3314c59dd0497282b33afabddf607b3050

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


