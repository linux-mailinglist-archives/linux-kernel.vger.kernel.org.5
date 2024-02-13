Return-Path: <linux-kernel+bounces-63665-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0934C8532FA
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 15:23:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B161A1F22046
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 14:23:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1BAA58133;
	Tue, 13 Feb 2024 14:22:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tDoOvZka"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 062DA5810A;
	Tue, 13 Feb 2024 14:22:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707834153; cv=none; b=FlkZ4HFO+I9L61ZI3Qn4bMmu1L0y9Vb19ZkW8ommb1Ybk24KlzM345H4jnHcuhRoCyPp+XueaM49W9xXdypXvzmayHd8JY2QETdU+Zm7Ef2DXqGN7rr194GcDQs6vLwb+ccLyWr2iSHYEjDsrwnyGtUxI+gm+h+InoDVdylmvto=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707834153; c=relaxed/simple;
	bh=MLO0eNfubsVaZ3+NJ0NwxvzUo8z9vzkOQ/E+hy/RX9w=;
	h=From:To:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=hcIoxddFmYzmUkO8BFcG0nOIOBuHh6WH8Z0G0+/yJkNH1qCUO//XesdrThXylL5UJH5F1ResqNF6Wu5oL2b85z6QKO+DgrrzV6E+nxz8pDaSXicaUJiethmMdVGxfOlDHRUGFclX850EhEAiurElD6EeGfMZKj/4vpUHWd3ofuU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tDoOvZka; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46611C43394;
	Tue, 13 Feb 2024 14:22:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707834152;
	bh=MLO0eNfubsVaZ3+NJ0NwxvzUo8z9vzkOQ/E+hy/RX9w=;
	h=From:To:In-Reply-To:References:Subject:Date:From;
	b=tDoOvZkavXJ2LFx03CzHfgMW3Swnt/rBeFpIem9eB9Wjdx7m6xxbT3fANKkR+s29z
	 AgKNEYnIeSYsr0s5FO4i8NZ3soCnTCJpi6hhnbFQdTdx3mDr1yl6qsnbJAwBpDNP0M
	 CLmDu+EHr4kaKnyIa2Qou3RcGN0AZgyLffQFOH7jmmp3L5ikOQRadHHRStZ/WKQ3QN
	 x32j1JePN9+bi31ZgnbhtBDixZ2E9UXSDgxo12PZl2i/qD88mgcYi4fh+2xm5n8CPQ
	 GX8GzZgXnVkRiC887oe2EJqjb7jEURzlbgnVdymRwlBhIG8w9edDnSRHmb0UGMvk9/
	 dQMHnV0uJDW3w==
From: Mark Brown <broonie@kernel.org>
To: Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konrad.dybcio@linaro.org>, 
 Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, 
 Banajit Goswami <bgoswami@quicinc.com>, Liam Girdwood <lgirdwood@gmail.com>, 
 Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, linux-arm-msm@vger.kernel.org, 
 alsa-devel@alsa-project.org, linux-sound@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20240212183800.243017-1-krzysztof.kozlowski@linaro.org>
References: <20240212183800.243017-1-krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH] ASoC: dt-bindings: qcom,sm8250: Allow up to 8 codec
 DAIs
Message-Id: <170783415002.38232.15876437530916950935.b4-ty@kernel.org>
Date: Tue, 13 Feb 2024 14:22:30 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-a684c

On Mon, 12 Feb 2024 19:38:00 +0100, Krzysztof Kozlowski wrote:
> Sound card on Qualcomm X1E80100 CRD board has eight DAIs in one DAI
> link (for WSA speakers).  Boards with older SoCs could technically have
> similar setup, even if it was not observed on mainlined devices.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: dt-bindings: qcom,sm8250: Allow up to 8 codec DAIs
      commit: d4a00d16f8367e09e8b8fb03028f22333fc368a5

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


