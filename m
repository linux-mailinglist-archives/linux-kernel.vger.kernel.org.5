Return-Path: <linux-kernel+bounces-32105-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C8610835684
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Jan 2024 16:51:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2F44D281DFE
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Jan 2024 15:51:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D031A37700;
	Sun, 21 Jan 2024 15:51:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="gFfv8cCn"
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE5E3376EC;
	Sun, 21 Jan 2024 15:51:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705852295; cv=none; b=Bqz9BXFRux2vqwDagXf6Vd64h+Oe4RL+/6YnRBAa+unXQ4/xK19Bzj+FwQqpOIoUcrLaSBN8tAcLbh6QVnKuWesq6DaspzzBbZ0v9X2Tdfo1l1z59GNjcg52Blr8MYoH/wxSiIZ2/MXIEaPDGCIVOWZWRFFUtsU1cmLjqjNDPxc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705852295; c=relaxed/simple;
	bh=LAFeba5psxn3wn60mOlpmb9xX3T5/Rf8R+4XFCVlniI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=U49QJMAD4QvsxxT9lDYDlSG/huWYuU2jFuwyJpxjf1IQt+UX4Bx+8UBRSaMn9SzomyDJiiv/AlRqT+kSkZUW1b8+HreyHAQZl52UdVzSOtm0fQh85Cw2xcii861uJXiq5ZXuDIIfNG2l9bDsRjQb4CvA+qxc7zrybR0ocXVF2xw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=gFfv8cCn; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=oQG4nHZXopQxzqSol4cwnGcgn3VgAtdNUYmrjVuxWfE=; b=gFfv8cCnZ6CMIr6F5ugXpN8Clw
	zx9Qh7kD7jkeJFfdlJu0flHDEqrqHw661qdrZdDEK8QVSgfledgmDer/kSHHQWJ6Wb8T64SWFje4+
	hPvZMBJX69a1i+oMghbrSt8Rgnscl9OrTbOkttD81MvVx4ia4cErLy60BqIFWF316Ats=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1rRa6Q-005exL-RX; Sun, 21 Jan 2024 16:51:18 +0100
Date: Sun, 21 Jan 2024 16:51:18 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Ziyang Huang <hzyitc@outlook.com>
Cc: mcoquelin.stm32@gmail.com, alexandre.torgue@foss.st.com,
	richardcochran@gmail.com, p.zabel@pengutronix.de,
	matthias.bgg@gmail.com, angelogioacchino.delregno@collabora.com,
	linux-kernel@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org, netdev@vger.kernel.org,
	linux-mediatek@lists.infradead.org
Subject: Re: [PATCH 0/8] ipq5018: enable ethernet support
Message-ID: <830a2717-c7f5-4bec-83b2-be14ba59337d@lunn.ch>
References: <TYZPR01MB55563BD6A2B78402E4BB44D4C9762@TYZPR01MB5556.apcprd01.prod.exchangelabs.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <TYZPR01MB55563BD6A2B78402E4BB44D4C9762@TYZPR01MB5556.apcprd01.prod.exchangelabs.com>

On Sun, Jan 21, 2024 at 08:40:39PM +0800, Ziyang Huang wrote:
> Enable ethernet support for IPQ5018.
> 
> Praveenkumar I (1):
>   clk: qcom: support for duplicate freq in RCG2 freq table
> 
> Ziyang Huang (7):
>   net: phy: Introduce Qualcomm IPQ5018 internal PHY driver
>   phy: Introduce Qualcomm ethernet uniphy driver
>   net: stmmac: Introduce Qualcomm IPQ50xx DWMAC driver
>   clk: qcom: gcc-ipq5018: correct gcc_gmac0_sys_clk reg
>   net: mdio: ipq4019: support reset control
>   arm64: dts: qcom: ipq5018: enable ethernet support
>   arm64: dts: qcom: ipq5018-rdp432-c2: enable ethernet support

Hi Ziyang

You failed to Cc: a number of Maintainers here. e.g for the PHY and
MDIO patches i would of expected the PHY and maintainers to be Cc:ed.

     Andrew

