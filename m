Return-Path: <linux-kernel+bounces-135729-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B67689CA75
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 19:11:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8E4441C243D1
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 17:11:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42AB3143888;
	Mon,  8 Apr 2024 17:11:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NwGn9HL/"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FC65143860;
	Mon,  8 Apr 2024 17:11:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712596274; cv=none; b=LPj2hxwa38kbxEixhzIvKJmdd2O7f31Q23uk1R34aV4PS8YTt1ORv8UoLjtkyjcwyMsnyvXGP+HHhL2c8aLEi8/y73IrmwglUMssAbv78lm2fXd5wwjayHIa4/nSJXeAJ7nenz9w0XZQT17QBjGrXsrp7mTXBCsufNlQ+XQXnnc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712596274; c=relaxed/simple;
	bh=3u24Gp54KTkQPBz1rIbYby/tHKVAqzkP2OKqWiCDgbI=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=EtGQyGG3mIlPtIEaNTT+Im3tILEkeHNw5kWSNWh4ZGlcgIM10r1aubVsFbByLL1lXyNP76m18ypER81bRW6GQDNP6svbUbFN/+ur2mcioEWEE0UC1iESei3usdDksznZHGj/XdMDpDzat4gZWCkV7mN/KYOBCooFDp+5eH6EPc4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NwGn9HL/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DEB1FC433C7;
	Mon,  8 Apr 2024 17:11:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712596274;
	bh=3u24Gp54KTkQPBz1rIbYby/tHKVAqzkP2OKqWiCDgbI=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=NwGn9HL/eGZJSbGzjzJd5AVMdstkb/GKuAen56ijpgCscqDqNRO6j/7L1c9SiAxjg
	 YUKAhQ2hEVO2fBWtJ7C8ZpG6Mi2d2/XV7TKxvkFNYPH2DQlZExD7vPOFJuB93YRfx6
	 mkOxtgJldkxsI93d4QJId1nNeEOwMLyN5wtf4197Cv56FAB89KDTLkjpKYQ5XovRye
	 NPT6YLEpGThCr01s9b0MiQJwwaKda02V6ZnGZEBbZ/i+mnSEIkthRg+Kh5rY98Y4cA
	 JW4M8xpXJDKGWpZHyhg8CR1WBKBmRFYEPEcgTiVvhEKZcynAN9ZrzeGRfU41en7w7c
	 6P/1L8Ka3kTRQ==
From: Mark Brown <broonie@kernel.org>
To: Animesh Agarwal <animeshagarwal28@gmail.com>
Cc: Shenghao Ding <shenghao-ding@ti.com>, Kevin Lu <kevin-lu@ti.com>, 
 Baojun Xu <baojun.xu@ti.com>, Liam Girdwood <lgirdwood@gmail.com>, 
 Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, alsa-devel@alsa-project.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20240406141454.45529-1-animeshagarwal28@gmail.com>
References: <20240406141454.45529-1-animeshagarwal28@gmail.com>
Subject: Re: [PATCH v2] dt-bindings: ti,pcm1681: Convert to dtschema
Message-Id: <171259627163.102594.17933281575225480570.b4-ty@kernel.org>
Date: Mon, 08 Apr 2024 18:11:11 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14-dev

On Sat, 06 Apr 2024 19:44:49 +0530, Animesh Agarwal wrote:
> Convert the Texas Instruments PCM1681 bindings to DT schema.
> Make bindings complete by adding #sound-dai-cells.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] dt-bindings: ti,pcm1681: Convert to dtschema
      commit: 8167bd1c8a45c289316417cf938bcd8ceec24fd5

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


