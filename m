Return-Path: <linux-kernel+bounces-158778-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BDF58B24CE
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 17:14:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9E23D1C21AC3
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 15:14:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18EED14AD10;
	Thu, 25 Apr 2024 15:14:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="lB5WciM7"
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05BFB14A623;
	Thu, 25 Apr 2024 15:14:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714058048; cv=none; b=W7TgOvIcy31TQ4dYbZoE3CuDQz3dngTx4m1t88V+5fdH03BgvQOJQec6z0iopb9lJGzo69rDXyf5SW2jDk7JzAzKUbffg1zPJZlsDw79cnjcvejT3QWOILzylvFcG/XcyzSDoreul6GeioU2IbNUESM4bhALhOPx679eiF+E0jw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714058048; c=relaxed/simple;
	bh=p5edgbalxUotiAK4g9UR1BVKXC2vuTUeta0FUdZr7qo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UPwVlpGWNltjVZmX10lJAR7fbd6vmacNl2y/FO46uwhTfwezBa4s51KkDcGSuA0v9BxkC+/49hVZnSCSSsMuu+nXNqNOs7/NaMDzm0xlVC0VvT/+GfA5NjE0IU8dypZTOvll5/hhiPr39VZZXeMR9Wi/5Ik5K6nUKzFDxYqAaHo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=lB5WciM7; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=SOcqtwMWjNdrJ7DWWV47YY5kyFrg6cLoJn7IbJl/aRk=; b=lB5WciM7UX8DfNBtZYPNwydUK5
	A1CQwdEOoWDDLpfYy1EoNst+ybo7mpFVMQBn0tAE/pKhNRFSdy4raiSMKTNNDLJRzN5Av0QJzkLsC
	pLOBsvdaOjBBLsEw2nnKSP4dPsTsUskX6t87asb4QzV70D/rVdKNyXbBw69aaEBcA9tE=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1s00nK-00Dzqc-5y; Thu, 25 Apr 2024 17:13:54 +0200
Date: Thu, 25 Apr 2024 17:13:54 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Sky Huang <SkyLake.Huang@mediatek.com>
Cc: Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Daniel Golle <daniel@makrotopia.org>,
	Qingfang Deng <dqfext@gmail.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	Steven Liu <Steven.Liu@mediatek.com>
Subject: Re: [PATCH 2/3] net: phy: mediatek: Add mtk phy lib for token ring
 access & LED/other manipulations
Message-ID: <d6c62ab9-256b-47d2-8145-7dc6ffcbd020@lunn.ch>
References: <20240425023325.15586-1-SkyLake.Huang@mediatek.com>
 <20240425023325.15586-3-SkyLake.Huang@mediatek.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240425023325.15586-3-SkyLake.Huang@mediatek.com>

On Thu, Apr 25, 2024 at 10:33:24AM +0800, Sky Huang wrote:
> From: "SkyLake.Huang" <skylake.huang@mediatek.com>
> 
> Integrate some common phy manipulations in mtk-phy-lib:
> 1. Token ring access: This is proprietary register access on page 52b5.
> Use these APIs so we can see which fields we're going to modify/set/clear.
> 2. LED: External/internal giga & internal 2.5g phy share almost the same
> LED control registers/logic.
> 3. Extend 1G TX/RX link pulse time: We observe that some devices' 1G
> training time violates specification, which may last 2230ms and affect
> later TX/RX link pulse time. So we try to extend our 1G TX/RX link pulse
> time so that we can still detect such devices.

Please break this up into 3 patches.

> -#define MTK_PHY_PAGE_EXTENDED_52B5		0x52b5
> +
> +/* Registers on Token Ring debug nodes */
> +/* ch_addr = 0x0, node_addr = 0x7, data_addr = 0x15 */
> +#define NORMAL_MSE_LO_THRESH_MASK		GENMASK(15, 8) /* NormMseLoThresh */
> +
> +/* ch_addr = 0x0, node_addr = 0xf, data_addr = 0x3c */
> +#define REMOTE_ACK_COUNT_LIMIT_CTRL_MASK	GENMASK(2, 1) /* RemAckCntLimitCtrl */
> +
> +/* ch_addr = 0x1, node_addr = 0xd, data_addr = 0x20 */
> +#define VCO_SLICER_THRESH_HIGH_MASK		GENMASK(23, 0) /* VcoSlicerThreshBitsHigh */
> +
> +/* ch_addr = 0x1, node_addr = 0xf, data_addr = 0x0 */
> +#define DFE_TAIL_EANBLE_VGA_TRHESH_1000		GENMASK(5, 1) /* DfeTailEnableVgaThresh1000 */
> +
> +/* ch_addr = 0x1, node_addr = 0xf, data_addr = 0x1 */
> +#define MRVL_TR_FIX_100KP_MASK			GENMASK(22, 20) /* MrvlTrFix100Kp */
> +#define MRVL_TR_FIX_100KF_MASK			GENMASK(19, 17) /* MrvlTrFix100Kf */
> +#define MRVL_TR_FIX_1000KP_MASK			GENMASK(16, 14) /* MrvlTrFix1000Kp */
> +#define MRVL_TR_FIX_1000KF_MASK			GENMASK(13, 11) /* MrvlTrFix1000Kf */

This is not what i would expect for moving code into a library. I
expect code to be deleted from one file and appear in another file,
with some minor changes, static dropped, EXPORT_SYMBOL_PHY added.  If
i see code just move, i don't need to review it line for line. If you
do want to change the code, please move it into the library first, and
make modifications.

Lots of small patches, which are obviously correct.

	Andrew

