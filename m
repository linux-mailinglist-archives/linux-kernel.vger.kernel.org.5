Return-Path: <linux-kernel+bounces-57578-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B94884DAEE
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 09:01:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3B5B81F22F07
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 08:01:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E4006A008;
	Thu,  8 Feb 2024 08:00:55 +0000 (UTC)
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFA5B69E11;
	Thu,  8 Feb 2024 08:00:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707379254; cv=none; b=Z59TDO1acRG0IKGUK6UiHXUMCmJl4AvynjTUZj8tx/2jE5XW3Dv/Omk1WpawSDkLQr6JXeFSN/JyypcgmprozUTanpMQmsIjVaX+KKxtwIEyZGpqtH7wWfEO9dq4PVuyT9GMSo4xEdyEXCjg1MW46qQ0lahCk4U+QUE5U0BJGEU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707379254; c=relaxed/simple;
	bh=RP0/rRTUu3t/ZaRdv+rLlAu/KYoai8wCB95wlw1Li+E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hDGPofQY9cMG7O/nZClNW0BQGqtZ2P8DRnoW/SvjKFOPP7JQzGE80WySfOwUDsphva5riJweDmKLpTJZ1jjG/Vun3TH8Q16PQ0iCH5QONQQdsRPtNfBpCkvDR7gZ3cJH8+REK/nAnQDANEqr2Jijb12dLHSEQQZfKgGR7rZx/KM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
Received: from i5e861914.versanet.de ([94.134.25.20] helo=diego.localnet)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1rXzKh-0001qH-DW; Thu, 08 Feb 2024 09:00:31 +0100
From: Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
To: Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Johan Jonker <jbx6244@gmail.com>,
 Sebastian Reichel <sebastian.reichel@collabora.com>,
 Cristian Ciocaltea <cristian.ciocaltea@collabora.com>,
 Sascha Hauer <s.hauer@pengutronix.de>, Andy Yan <andy.yan@rock-chips.com>,
 Vinod Koul <vkoul@kernel.org>, Kishon Vijay Abraham I <kishon@kernel.org>,
 Philipp Zabel <p.zabel@pengutronix.de>, Algea Cao <algea.cao@rock-chips.com>,
 Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-phy@lists.infradead.org, kernel@collabora.com
Subject:
 Re: [PATCH v2 2/2] phy: rockchip: Add Samsung HDMI/eDP Combo PHY driver
Date: Thu, 08 Feb 2024 09:00:30 +0100
Message-ID: <2670318.X9hSmTKtgW@diego>
In-Reply-To: <20240205-phy-hdptx-v2-2-a7150814c047@collabora.com>
References:
 <20240205-phy-hdptx-v2-0-a7150814c047@collabora.com>
 <20240205-phy-hdptx-v2-2-a7150814c047@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

Am Montag, 5. Februar 2024, 12:24:25 CET schrieb Cristian Ciocaltea:
> Add driver for the HDMI/eDP TX Combo PHY found on Rockchip RK3588 SoC.
> 
> The PHY is based on a Samsung IP block and supports HDMI 2.1 TMDS, FRL
> and eDP links.  The maximum data rate is 12Gbps (FRL), while the minimum
> is 250Mbps (TMDS).
> 
> Only the TMDS link is currently supported.
> 
> Co-developed-by: Algea Cao <algea.cao@rock-chips.com>
> Signed-off-by: Algea Cao <algea.cao@rock-chips.com>
> Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>

on a rk3588-jaguar
Tested-by: Heiko Stuebner <heiko@sntech.de>



