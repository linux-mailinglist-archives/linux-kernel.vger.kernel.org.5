Return-Path: <linux-kernel+bounces-137916-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B7B489E985
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 07:15:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F21C3B21FB9
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 05:15:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CD2715E90;
	Wed, 10 Apr 2024 05:15:17 +0000 (UTC)
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82BB31119F;
	Wed, 10 Apr 2024 05:15:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712726116; cv=none; b=dc5cyR0ioWrxoahbfK7VKIVojfIkeibOYf8PWVfPjjLC23Kbu3jyWi92uCbU5dRFRj5CLp+Jo2sTwOrcPuxvLmdCIh4RelYhqA4An5o4w6YbZTpqYqwpAi8qH2bpcyHhg2JyrgMjnkvNk7Bfbjk2FToW5y7S3nr+ZhGGRUlhelA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712726116; c=relaxed/simple;
	bh=A4QV62qYSkw4FzaRG3KsH05efNPZfKUGtURiKjwZg0g=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XCzwYbV1mbzBVQrMxxTTSZ8DWEFi/SJDmiTwL6crX2zeP7yZdQJqwsnNW8s/qTfAjWIgQJBAG/ptqZ+KfPBYil+nBTtYRMeZCfBRjPw96uu8C+9R1isbaXKCFDk2z6ZeZxqo5c5L/mjfLuip06me2MPMipXB0FILHb8QhlTpLzM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
Received: from ip-185-104-138-50.ptr.icomera.net ([185.104.138.50] helo=phil..)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1ruQIi-0008Ut-76; Wed, 10 Apr 2024 07:15:12 +0200
From: Heiko Stuebner <heiko@sntech.de>
To: linux-rockchip@lists.infradead.org,
	Dmitry Yashin <dmt.yashin@gmail.com>
Cc: Heiko Stuebner <heiko@sntech.de>,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Conor Dooley <conor+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Rob Herring <robh+dt@kernel.org>
Subject: Re: [PATCH v2 0/3] arm64: dts: rockchip: add Forlinx OK3588-C
Date: Wed, 10 Apr 2024 07:15:00 +0200
Message-Id: <171272604793.1867483.15724948920615504695.b4-ty@sntech.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240403151229.30577-1-dmt.yashin@gmail.com>
References: <20240403151229.30577-1-dmt.yashin@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Wed, 3 Apr 2024 20:12:26 +0500, Dmitry Yashin wrote:
> This series add support for Forlinx RK3588 based SoM and carrier board.
> Devicetree split into .dtsi (FET3588-C SoM) and .dts (OK3588-C Board).
> 
> v1 Link: https://lore.kernel.org/all/cover.1710506373.git.dmt.yashin@gmail.com/
> 
> Changes in v2:
> Patch 1:
> - no changes
> Patch 2:
> - rename dtsi to rk3588-fet3588-c.dtsi
> - reorder regulator nodes
> - reorder properties in sdhci
> - drop regulator-always-on from vdd_gpu_s0
> - enable tsadc
> Patch 3:
> - update dtsi include
> - set more generic names for tca6424a, nau8822 and sound nodes
> - reorder regulator and nodes in pinctrl
> - reorder properties in gmac and sdmmc
> - drop vmmc-supply from sdmmc and update max-frequency
> - enable gpu (depends on for-next branch)
> - enable usb_host nodes
> 
> [...]

Applied, thanks!

[1/3] dt-bindings: arm: rockchip: add Forlinx FET3588-C
      commit: dbda7254e7df661fd4022c07dda3a7c9660eee47
[2/3] arm64: dts: rockchip: add Forlinx FET3588-C
      commit: f7a9a80da93178fe43b72f13dd55d717b5efff21
[3/3] arm64: dts: rockchip: add Forlinx OK3588-C
      commit: ae914513b2f566d995a41638b643ac8589b6275e

Best regards,
-- 
Heiko Stuebner <heiko@sntech.de>

