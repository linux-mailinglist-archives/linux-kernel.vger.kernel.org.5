Return-Path: <linux-kernel+bounces-78408-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 91E98861315
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 14:44:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 229ADB22CF1
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 13:44:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31EDF811F1;
	Fri, 23 Feb 2024 13:44:02 +0000 (UTC)
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F010C8062E;
	Fri, 23 Feb 2024 13:43:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708695841; cv=none; b=UZR0TkRkKsZ9tzbssvlRxUU6F+gIQ0DG5Pi0jciElBUS/5mZF3P525YDEJatbFIRf0sBwwaAG9HZFNNg/d9yi3e4c+K5BC6UmFaYFNfD7sEXPtDqJ+iB8sruYqZ2dZN0bP65LiY5LVOSXG8BbUeJ4S3FWybKenr4DXOovtG7ED8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708695841; c=relaxed/simple;
	bh=XzO6MJifE+JArjb+66zzk/BVaQsPkGlLVFwOugc6dhw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=K1p0Lspuf5vYQFgUD43suCy6HrnnQON3t/ERfvlnWFODC2mxknmUWcCyAksVMWsGNloK7yOZCtiyHG3LGXdGZ8CZx8GknRIDIWXCiLsyX+ItYzFt49oC3i4HvPhLXE0kQLWBDSx+4up5dC7lrxn+FdOuxUEL5YCUN2ZdPmq9BFo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
Received: from i53875b6c.versanet.de ([83.135.91.108] helo=diego.localnet)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1rdVq2-0001HH-7o; Fri, 23 Feb 2024 14:43:42 +0100
From: Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
To: Jonathan Cameron <jic23@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 Andy Shevchenko <andy.shevchenko@gmail.com>,
 Shreeya Patel <shreeya.patel@collabora.com>, Simon Xue <xxm@rock-chips.com>,
 Philipp Zabel <p.zabel@pengutronix.de>,
 Quentin Schulz <foss+kernel@0leil.net>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>, linux-iio@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org,
 linux-kernel@vger.kernel.org,
 Quentin Schulz <quentin.schulz@theobroma-systems.com>,
 Quentin Schulz <foss+kernel@0leil.net>
Subject:
 Re: [PATCH 2/3] iio: adc: rockchip_saradc: use mask for write_enable bitfield
Date: Fri, 23 Feb 2024 14:43:41 +0100
Message-ID: <2385656.yKrmzQ4Hd0@diego>
In-Reply-To:
 <20240223-saradcv2-chan-mask-v1-2-84b06a0f623a@theobroma-systems.com>
References:
 <20240223-saradcv2-chan-mask-v1-0-84b06a0f623a@theobroma-systems.com>
 <20240223-saradcv2-chan-mask-v1-2-84b06a0f623a@theobroma-systems.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

Am Freitag, 23. Februar 2024, 13:45:22 CET schrieb Quentin Schulz:
> From: Quentin Schulz <quentin.schulz@theobroma-systems.com>
> 
> Some of the registers on the SARADCv2 have bits write protected except
> if another bit is set. This is usually done by having the lowest 16 bits
> store the data to write and the highest 16 bits specify which of the 16
> lowest bits should have their value written to the hardware block.
> 
> The write_enable mask for the channel selection was incorrect because it
> was just the value shifted by 16 bits, which means it would only ever
> write bits and never clear them. So e.g. if someone starts a conversion
> on channel 5, the lowest 4 bits would be 0x5, then starts a conversion
> on channel 0, it would still be 5.
> 
> Instead of shifting the value by 16 as the mask, let's use the OR'ing of
> the appropriate masks shifted by 16.
> 
> Note that this is not an issue currently because the only SARADCv2
> currently supported has a reset defined in its Device Tree, that reset
> resets the SARADC controller before starting a conversion on a channel.
> However, this reset is handled as optional by the probe function and
> thus proper masking should be used in the event an SARADCv2 without a
> reset ever makes it upstream.
> 
> Fixes: 757953f8ec69 ("iio: adc: rockchip_saradc: Add support for RK3588")
> Cc: Quentin Schulz <foss+kernel@0leil.net>
> Signed-off-by: Quentin Schulz <quentin.schulz@theobroma-systems.com>

Reviewed-by: Heiko Stuebner <heiko@sntech.de>



