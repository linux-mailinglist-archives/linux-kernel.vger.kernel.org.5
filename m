Return-Path: <linux-kernel+bounces-34145-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 27A5B837458
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 21:46:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 595611C26386
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 20:46:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAF54495FB;
	Mon, 22 Jan 2024 20:44:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Vt5Hgc4+"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E415495DF;
	Mon, 22 Jan 2024 20:44:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705956280; cv=none; b=SlFuX1mEKn+SOwxIGd3m9/AlyvF5oUrfWD095GEHsajdmvSKYIggDpYv9ylxAlozkFj5sbRybY4ZV27dNcHYP44JsF78lFNF91ayA3+JJTTBpyCFNp/Bd3K39hZ7Xddm4mMyqxZxpdpOXmmTw/VZ85rPF1hgQbS5XMbT1vD8dz0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705956280; c=relaxed/simple;
	bh=PeIl/ehh+Zh7UoFmAl9FwVNaJ2HBqHlBBURFLXdEfiM=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=AuJpnywd8JCs3knBazBMFba2KWGMEd8Md2hne9wXvCsrNkkLYk9aQRRkq5TSpj4BPghcEvXzOv/14SOJ6l2OqttRa+1gSivAyERNmi/9sBGP6Ons9jII2ejkTBvNuHDrnAhXGF71ZfyMijONDP+nZ52Tu0LTwiWCu9HKcmMT+cY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Vt5Hgc4+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F880C43399;
	Mon, 22 Jan 2024 20:44:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705956279;
	bh=PeIl/ehh+Zh7UoFmAl9FwVNaJ2HBqHlBBURFLXdEfiM=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=Vt5Hgc4+U6tiA2MbikPCABygUv7RDGh0qHoOe+iQ2dVce0W9HJ4DnNcX9bvJ3y+rZ
	 w3LL8xoVNKdfzV4iH2kt9N44EAPqIzr0MgPx1Yowo8XN37cn/6RL7utqBoBpGS7Ks0
	 8igUSlX0d0YuXGXumeOPE5vAAzAHpzYyst190s6f8x2deobYnLdKKonR4aD/VVemXz
	 3sqUEE3fXQmx8J3HC8JPHwf24npM49S7jMJvOeog8GmcJxyPVwKum7qvbEIeitlHM7
	 KJn+DCU8sr7OG+sa+yKzXrz7Km0XFOSgQssaKcc0p2YIRasc9xqtp6SxibHzgh0mw0
	 uwpW5InLKdAyQ==
From: Mark Brown <broonie@kernel.org>
To: Liam Girdwood <lgirdwood@gmail.com>, Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 =?utf-8?q?Andr=C3=A9_Apitzsch?= <git@apitzsch.eu>
Cc: linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
In-Reply-To: <20240104-tps65132-v2-1-6c77fe2f4787@apitzsch.eu>
References: <20240104-tps65132-v2-1-6c77fe2f4787@apitzsch.eu>
Subject: Re: [PATCH v2] dt-bindings: regulator: Convert ti,tps65132 to YAML
Message-Id: <170595627803.145638.1453622208828773553.b4-ty@kernel.org>
Date: Mon, 22 Jan 2024 20:44:38 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.13-dev-5c066

On Thu, 04 Jan 2024 23:40:40 +0100, André Apitzsch wrote:
> Convert TI TPS65132 bindings from .txt to .yaml format.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git for-next

Thanks!

[1/1] dt-bindings: regulator: Convert ti,tps65132 to YAML
      commit: a6ffa02ba7a28fe1bba06eacb224554d89a1cd4d

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


