Return-Path: <linux-kernel+bounces-68550-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C88B3857C2E
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 12:58:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7BE241F23631
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 11:58:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE7977866D;
	Fri, 16 Feb 2024 11:58:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MzpqLh0y"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07D4759169;
	Fri, 16 Feb 2024 11:58:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708084689; cv=none; b=Q72BshkXtzF3rxJcm83S4QisfNfjKUIXQtUxKVVClb+CJMxv070XLvvKyXYvC4nlTKVQwEI2ri+ep07uF372guQqe31zpypimTrrN8ZM1x95dGdt70ZJP7q1R05F1O3oGCDn4IXqE3xUtQsAIyhHXrBIfex7D1G2kFSgG2QLjzU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708084689; c=relaxed/simple;
	bh=02zB0ODjIh7Ni22bBy7tChA9AIJOF8lNxePQq8wnRdk=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=CqPkIzbJTbYgqRh9N4KFYIXKO7eKG3KZO2eApOTw9QZXVBQK79w9ISw1gHiRoUJqcM/NfnjQWL0gLv965pW6Tn2sfs0dt3oBP1DS4x6NyUZ5I4FUNxn6Yv0nMqBZKiS8tP3CC4Zp3H76E4rQykdR7fETF1Y95eHWQkxFB56Ju0I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MzpqLh0y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A69EC433F1;
	Fri, 16 Feb 2024 11:58:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708084688;
	bh=02zB0ODjIh7Ni22bBy7tChA9AIJOF8lNxePQq8wnRdk=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=MzpqLh0y6hKn3tTEciOdvs8P4G6Ht+gx34okHzjAp26dx0rimQLB7q5B0dVsk8cb3
	 nzuRQMDVXTHpZkVv+pBuAnV5P4cPZD1fYeA+r+aX1nFay7F5a165rAU5JHQArPdCnT
	 6/DwO42uGzbeBCyIwqwQmXb/x8cRtek0nPgK9LEkkvCvziju0tvOUxvufyzbESioLE
	 jW6+nBJK6LgLsoVkl+/4KKR2N0xJRTb3Fx6CrVUrrSvec8zx4yKzpl5EClWigLa9ic
	 p1uYWwlHYfYE85j6A2V7gNE0g8APT8xKyFlURWCtiKIBikItL6oKLfzoFyUNRguZoO
	 VYwdQtDfV0bMw==
From: Vinod Koul <vkoul@kernel.org>
To: Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>, 
 Johan Jonker <jbx6244@gmail.com>, 
 Sebastian Reichel <sebastian.reichel@collabora.com>, 
 Sascha Hauer <s.hauer@pengutronix.de>, Andy Yan <andy.yan@rock-chips.com>, 
 Kishon Vijay Abraham I <kishon@kernel.org>, 
 Philipp Zabel <p.zabel@pengutronix.de>, 
 Algea Cao <algea.cao@rock-chips.com>, 
 Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org, 
 linux-phy@lists.infradead.org, kernel@collabora.com, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20240214-phy-hdptx-v4-0-e7974f46c1a7@collabora.com>
References: <20240214-phy-hdptx-v4-0-e7974f46c1a7@collabora.com>
Subject: Re: [PATCH v4 0/2] Add support for RK3588 HDMI/eDP Combo PHY
Message-Id: <170808468224.352706.3107795890372449699.b4-ty@kernel.org>
Date: Fri, 16 Feb 2024 17:28:02 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.3


On Wed, 14 Feb 2024 13:45:35 +0200, Cristian Ciocaltea wrote:
> Add driver and bindings to add initial support the Rockchip HDMI/eDP TX
> Combo PHY found on RK3588 SoC.
> 
> The PHY is based on a Samsung IP block and supports HDMI 2.1 TMDS, FRL
> and eDP links.
> 
> Please note that currently only the TMDS related functionality has been
> implemented.  This has been tested on Radxa ROCK 5B and Rockchip EVB1
> boards.
> 
> [...]

Applied, thanks!

[1/2] dt-bindings: phy: Add Rockchip HDMI/eDP Combo PHY schema
      commit: 3312a0e8f64ec68db695224fcc7457e7292426eb
[2/2] phy: rockchip: Add Samsung HDMI/eDP Combo PHY driver
      commit: 553be2830c5f33308483e8118de748a2c69fe593

Best regards,
-- 
~Vinod



