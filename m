Return-Path: <linux-kernel+bounces-84177-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A381286A360
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 00:13:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5817D1F2E42B
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 23:13:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE43756763;
	Tue, 27 Feb 2024 23:13:31 +0000 (UTC)
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5CC055E40;
	Tue, 27 Feb 2024 23:13:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709075611; cv=none; b=joJy+cjzqbqEySUwpwEU6h8bFdEN5xPbmn1Z3a/EJKkH/eWQifMwShHp562cjFKYuEM4/dl/VpGOwrkgm02qh2gffUmEg8G/wfscqrQR2vYgCH/YhT8FecnsAhwN2pf4rrX2Cm4y1DvzW6EyvK7M5o+cjaSym2H30B+/JArJS6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709075611; c=relaxed/simple;
	bh=VuBuF9yGCqTCh37BqBXbY+hS7Z8P6vlEOFLcsts82aI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hBntXtk1J0uBGE4+rG5w007OrFsYy7daH8emoiIytdcGyYYWAJmzWgTlwJx1/dqn1C57SZRYK70jed9ukQT8uguW8mxxyMQIxZJfTzSE6iv1VNPDA6nKlUZHW+YbSnkt3Kxdxp1xJlYYYHjmzhD04o4cbASYJFwwtZZpo3mpJ+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
Received: from i53875b6c.versanet.de ([83.135.91.108] helo=phil.lan)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1rf6dX-0002LS-AB; Wed, 28 Feb 2024 00:13:23 +0100
From: Heiko Stuebner <heiko@sntech.de>
To: linux-rockchip@lists.infradead.org,
	Tim Lunn <tim@feathertop.org>
Cc: Heiko Stuebner <heiko@sntech.de>,
	Conor Dooley <conor+dt@kernel.org>,
	devicetree@vger.kernel.org,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] dts fixes for Sonoff iHost
Date: Wed, 28 Feb 2024 00:13:19 +0100
Message-Id: <170907558762.800427.11245323145550658595.b4-ty@sntech.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240215110425.934740-1-tim@feathertop.org>
References: <20240215110425.934740-1-tim@feathertop.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Thu, 15 Feb 2024 22:04:23 +1100, Tim Lunn wrote:
> A couple of tweaks to the dts for Sonoff iHost.
> 
> Add aliases for sdio and sdmmc to ensure consistent ordering of devices
> on boot.
> 
> Tweak sdio properties to improve detection of the rtl8723ds sdio wifi module.
> 
> [...]

Applied, thanks!

[1/2] ARM: dts: rockchip: mmc aliases for Sonoff iHost
      commit: eb246eaaa55aaa52c0c183f835157a56270ce81e
[2/2] ARM: dts: rockchip: Wifi improvements for Sonoff iHost
      commit: 391f46c775fa2108952c8f9a88b5bea2c3c74d1d

Best regards,
-- 
Heiko Stuebner <heiko@sntech.de>

