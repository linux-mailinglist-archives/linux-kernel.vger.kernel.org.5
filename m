Return-Path: <linux-kernel+bounces-154771-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 451328AE0C4
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 11:12:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C822EB23ABF
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 09:12:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D607A5A788;
	Tue, 23 Apr 2024 09:12:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OG3we8e6"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2247C59161;
	Tue, 23 Apr 2024 09:12:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713863523; cv=none; b=VQJ9xWzVstKb11RrZbecOZwg2xJJOzoacQmv+04/OVzFeRSqsUYzLvwkBVfvmbSRYZ8XP8LJefufqwDsKyX8I0FIAbYkK1W1hn7oFUhgn1+ICT3v6Q37dij5ae1f4lh/HCfOXanM5dBqTtcWGgPLphtKFmRqHFeUodE1jMvfBiU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713863523; c=relaxed/simple;
	bh=P1+SzEkEbUxqtmErfXAFNFg5Ku/NbRzwah/IbK5buKo=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=IdSyDDM0BRLMWzTM5KG7NhE+w7fjQnDZxBzl62Y6L7SlKqV+NfDHRgy7WcWEWKWRJof1dDeUNxqrknV8RLDtxv5GPmILV/pxRK90684Nq9H8PRlMIqqCELpH4YMLlmpeC2K4+oas27A6iKH1uxTeGXHM6z+RoOApEQFlEkOaA9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OG3we8e6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38067C116B1;
	Tue, 23 Apr 2024 09:11:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713863522;
	bh=P1+SzEkEbUxqtmErfXAFNFg5Ku/NbRzwah/IbK5buKo=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=OG3we8e63RR7aBIv4n3fJsal430Fth8ths23XaenqeJbGWSq2YgbxSpP4Qik2ypcz
	 0Q7BlU1KlIKV6QK1Pvr8dIuo7kNyPFBA4xq5E/qjRcvyLaoWwQyh82l7QWTSIcioUs
	 M5dAk6rbW1dWFx6LTBEag3wvlmzx8i+uCwjKAVMj47HWYGFsBm2PqBkgRjG40tnRru
	 4aeAm5wBMls8vR1MasCo5fQlPArDTcqQP6Wh9hxoNbY9PT4u4X4vzr+0AT553Mmu6c
	 1PiJaHrKw1xsbNpV84wYeroaE4Vi9DzJe7KQh+qY2y1Wj0Ycj632uo3VX7v9+V8Zud
	 ulsYPhpYaFMnQ==
From: Mark Brown <broonie@kernel.org>
To: lgirdwood@gmail.com, robh@kernel.org, krzysztof.kozlowski+dt@linaro.org, 
 conor+dt@kernel.org, matthias.bgg@gmail.com, 
 angelogioacchino.delregno@collabora.com, 
 Kartik Agarwala <agarwala.kartik@gmail.com>
Cc: linux-sound@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org
In-Reply-To: <20240421033129.13076-1-agarwala.kartik@gmail.com>
References: <20240421033129.13076-1-agarwala.kartik@gmail.com>
Subject: Re: [PATCH v2] ASoC: dt-bindings: mt2701-wm8960: Convert to
 dtschema
Message-Id: <171386351991.1781735.5122768330810491305.b4-ty@kernel.org>
Date: Tue, 23 Apr 2024 18:11:59 +0900
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14-dev

On Sun, 21 Apr 2024 09:01:31 +0530, Kartik Agarwala wrote:
> Convert mt2701-wm890 bindings from text to dtschema. This is used by
> MediaTek mt7623a/n SoC.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: dt-bindings: mt2701-wm8960: Convert to dtschema
      commit: ab371a026a1a4ad81817d82ba433c19934082894

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


