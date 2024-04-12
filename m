Return-Path: <linux-kernel+bounces-142026-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B6D438A2666
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 08:22:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6C73B1F24691
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 06:22:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5131A2C87C;
	Fri, 12 Apr 2024 06:21:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uiNb6p15"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D755225D7;
	Fri, 12 Apr 2024 06:21:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712902916; cv=none; b=QLRulVKPrLSs/C3Er4X73DyEPZ/sj/6oUscgMdBquyBKcxkAmlxvTCutixSPf8ofxsNhEmL8VacibFFS0H8ph0IEJbHRYXW461qADznCy/2Ahw8AztaYKYdabE7u+EcKnqla6exlIsquGsoM3OBFd03wo+9Qvzdu01JfqHpwF+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712902916; c=relaxed/simple;
	bh=EB0K1UYoXpbb/oyBemibvLoZc40JGLrpFaRORwNFFUA=;
	h=Message-ID:Content-Type:MIME-Version:In-Reply-To:References:
	 Subject:From:Cc:To:Date; b=JfoozRCCSnxL7tu0EJazCQI6ekCRc9qyB0VnPR/hLTvz8v4JP5MjzTjFaeq83iCSA1n/CN1/vVnOQymFXIhiRYhn22wRBdkLdBxZ5MjxzNThsItrt3EKVxHp6tN4AiyIUfSDkcDVggme+7uhCp0UxRjgYZ/WppOJ6oQtbHgbEEM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uiNb6p15; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17F23C2BBFC;
	Fri, 12 Apr 2024 06:21:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712902916;
	bh=EB0K1UYoXpbb/oyBemibvLoZc40JGLrpFaRORwNFFUA=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
	b=uiNb6p15zFuDethSow2qeOXwb/YWAkR2w0U0jfRJYk7hJK/NjnGMpDgEvYMJyTXXE
	 AkVaZDKWHQ6QLrXYNhY0xreVHmL8PuGcsfM1AWbcji4HkCT9zDTA8BQR4RzehK09aR
	 CEQ51glnyZULOSjfyE6io2tFLqfDe+wtPwNAOOsHjeT8VjNI8FDozoV1uw2wABX2A4
	 uPVVavraGMr/hTB0ycKPFwpJWdzUV+SyvDgtMyaZG9iiUwvQKl3Bgs1aHxcGdZv2IP
	 LpVE9vVRMbY4iyjkbO3KpeEmiJYBl2E/1TrZ3XH1uOr+tH54xlh+8aywwTO0tNxscV
	 MsyhyvZu9Bavg==
Message-ID: <75d2aa0022d334d17c5ecf51f0e7684f.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20240411092453.243633-3-gabriel.fernandez@foss.st.com>
References: <20240411092453.243633-1-gabriel.fernandez@foss.st.com> <20240411092453.243633-3-gabriel.fernandez@foss.st.com>
Subject: Re: [PATCH v11 2/4] dt-bindings: clocks: stm32mp25: add description of all parents
From: Stephen Boyd <sboyd@kernel.org>
Cc: linux-clk@vger.kernel.org, devicetree@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Alexandre Torgue <alexandre.torgue@foss.st.com>, Conor Dooley <conor+dt@kernel.org>, Gabriel Fernandez <gabriel.fernandez@foss.st.com>, Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Maxime Coquelin <mcoquelin.stm32@gmail.com>, Michael Turquette <mturquette@baylibre.com>, Philipp Zabel <p.zabel@pengutronix.de>, Rob Herring <robh+dt@kernel.org>
Date: Thu, 11 Apr 2024 23:21:53 -0700
User-Agent: alot/0.10

Quoting gabriel.fernandez@foss.st.com (2024-04-11 02:24:51)
> From: Gabriel Fernandez <gabriel.fernandez@foss.st.com>
>=20
> RCC driver uses '.index' to define all parent clocks instead '.names'
> because the use of a name to define a parent clock is prohibited.
> This is ABI change, but the RCC driver has not yet merged, unlike all
> others drivers besides Linux.
>=20
> Fixes: b5be49db3d47 ("dt-bindings: stm32: add clocks and reset binding fo=
r stm32mp25 platform")
> Signed-off-by: Gabriel Fernandez <gabriel.fernandez@foss.st.com>
> Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---

Applied to clk-next

