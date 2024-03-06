Return-Path: <linux-kernel+bounces-93890-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 65368873667
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 13:31:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 96E091C24209
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 12:31:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5ED403214;
	Wed,  6 Mar 2024 12:30:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AbKfW3Kw"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2D1D7FBDB;
	Wed,  6 Mar 2024 12:30:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709728225; cv=none; b=gNeC2X7QEe3MkHIBAKBxYITHet3EnkZymEe1wiXCPbgmDejdeWx3UCnvfktidithr7im4gLRIs4uQVBRp7YMQ8hxKeOihOqIgvvXEESUP5FdiF7OavRFqZ2g9AsYoR4Zo6lJ1GxnchrysxXDvaiNNegsLMX2xitx+ooRiXxAcYU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709728225; c=relaxed/simple;
	bh=ACUqgCjJo7JEYLM2xMAXxnYe+kdtRCNrTmewwyMHvIo=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=SiLVUR6T2IP65fr7pTSGNoKW333L7F3zahj3sSAlCdeunytxi7+zbQkNFXzrHbD/zwNJzbj8W54msrte2e28TZVbjO0bBHsbg6LlaZhojY+x/Csje2JtiTSh8vaLGjln7CuKkDWiN1S6OdDacT1LqGaAstHpCm9URc4PKaIy6KQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AbKfW3Kw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC44CC433C7;
	Wed,  6 Mar 2024 12:30:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709728225;
	bh=ACUqgCjJo7JEYLM2xMAXxnYe+kdtRCNrTmewwyMHvIo=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=AbKfW3KwXVau1tZKRtk4dTZqLMIni8jAZU6sSVyyD5lvbvbdSuJxNSWpZxFL3CT5l
	 XjjrA8Oy6r2VEHOuF8oYS4K3h043WAbSh+3cs90AC4NuljJHavAwhqWSD2+Zea7+Ei
	 +1ukRKSLTe4eeyzs6WDVByizOhxlWy16HmuMOb1U6TlHk+VKKJFU8XzPLEPRsIX0eR
	 0S8LzPcfgcOe3GwW7+sKpcCRmELmV0p9ktkZctM1nptGbZPryszHWHhq7jmvPFehwN
	 xz4AvGc3tTle2VILWYwcMd82nHSKI3uxmItLtBHdrV6agzbQMS/w1enUALVBH/J1Ok
	 QqBeMwChC5BHQ==
From: Mark Brown <broonie@kernel.org>
To: =?utf-8?q?Javier_Garc=C3=ADa?= <javier.gar.tab@gmail.com>
Cc: daniel.baluta@nxp.com, Liam Girdwood <lgirdwood@gmail.com>, 
 Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, Jack Yu <jack.yu@realtek.com>, 
 alsa-devel@alsa-project.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org
In-Reply-To: <20240304142315.14522-1-javier.gar.tab@gmail.com>
References: <20240304142315.14522-1-javier.gar.tab@gmail.com>
Subject: Re: [PATCH] ASoC: dt-bindings: rt1015: Convert to dtschema
Message-Id: <170972822252.17598.17751393697250368989.b4-ty@kernel.org>
Date: Wed, 06 Mar 2024 12:30:22 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.13-dev-a684c

On Mon, 04 Mar 2024 15:23:07 +0100, Javier García wrote:
> Convert the RT1015 Mono Class D Audio Amplifier to DT schema.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: dt-bindings: rt1015: Convert to dtschema
      commit: 2ca703302a7f9dccdfb69f5a385f7828288b42e3

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


