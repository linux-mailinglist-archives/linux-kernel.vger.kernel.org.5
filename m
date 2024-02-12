Return-Path: <linux-kernel+bounces-61938-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B7268518AD
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 17:09:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4E8D51C21C46
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 16:09:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C6653D0BB;
	Mon, 12 Feb 2024 16:09:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="2o+41Bo6"
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBBDE3D0A9;
	Mon, 12 Feb 2024 16:09:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707754142; cv=none; b=f87YMEjNBUvQ0Qu0n12WboJOkOjoqSpppGA8pNroD+E6rIAWfrV5MrdnIp/ZCvNfxsvFPgrZYXhT5OJTnjr8lNwTkXxnmAU/OoKcz2i+Gy+qYV3k8c2E4Yq/hCUpvyvCnZyovg2fxvmwkCmtZRMXxbSFKpCqF5CxD4fz2101qek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707754142; c=relaxed/simple;
	bh=lFQ13ZdkGLoXG1jizC4q4UNS8hJ2RH6AqRXJj1aalVo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dqPaE1q4SueryUVL+m0TWICR5kEIqD4FkumKfTakMWoQEwKOdOab9DQ+D/pvtcsGZnA667CB+/0nZoTAm7QnJT++JDV43Q/5H7Ry9C3dBK5m9jUu45KtzB2euXwTBS4NIvsAZjadxAMp2KB1rNTC/LegSjpoShRteFRUX7QmuLY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=2o+41Bo6; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Transfer-Encoding:Content-Disposition:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:From:
	Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Content-Disposition:
	In-Reply-To:References; bh=6onZmQzOzTUVxLoq6PYi5yWge8qbTLIuvhUFhRpmHVs=; b=2o
	+41Bo6FmLs3CFKu7/PnppPbXJlVbPahVnWc8gQAehr0FYkL6JCAvclXwJ73rbToYbNuTK3lX8NnMh
	faq2sh3kD3SaMYmJrC0akBsQOya5VPkaj/o6Jm/FlknDTPuKtoLrS1Cr/Oe0xjxfRKJQOnpbXk0Ok
	lNvfbw7RV/jVIKQ=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1rZYra-007aZq-AW; Mon, 12 Feb 2024 17:08:58 +0100
Date: Mon, 12 Feb 2024 17:08:58 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Michal =?utf-8?B?Vm9rw6HEjQ==?= <michal.vokac@ysoft.com>
Cc: Shawn Guo <shawnguo@kernel.org>, Fabio Estevam <festevam@gmail.com>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	NXP Linux Team <linux-imx@nxp.com>, devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] ARM: dts: imx6dl-yapp4: Fix the QCA switch register
 address
Message-ID: <c5dad8e7-c486-4dd9-bfb5-bdfa2ddc18b3@lunn.ch>
References: <1707751422-31517-1-git-send-email-michal.vokac@ysoft.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1707751422-31517-1-git-send-email-michal.vokac@ysoft.com>

On Mon, Feb 12, 2024 at 04:23:41PM +0100, Michal Vokáč wrote:
> The switch address in the node name is in hex while the address in the reg
> property is decimal which is wrong. Fix that and write the reg address
> as a hexadecimal number.

This feels the wrong way around. The reg value is used by the kernel,
where as the node name is not. If the reg value was wrong, the switch
would not be found. If this file was tested, why did somebody not
notice the switch was missing?

Do you have the hardware? Can you confirm is really does not work
without this patch? Was 15b43e497ffd never actually tested?

Thanks
	Andrew

> 
> Fixes: 15b43e497ffd ("ARM: dts: imx6dl-yapp4: Use correct pseudo PHY address for the switch")
> Signed-off-by: Michal Vokáč <michal.vokac@ysoft.com>
> ---
>  arch/arm/boot/dts/nxp/imx/imx6dl-yapp4-common.dtsi | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm/boot/dts/nxp/imx/imx6dl-yapp4-common.dtsi b/arch/arm/boot/dts/nxp/imx/imx6dl-yapp4-common.dtsi
> index cfb0fc924b42..5763f8253d51 100644
> --- a/arch/arm/boot/dts/nxp/imx/imx6dl-yapp4-common.dtsi
> +++ b/arch/arm/boot/dts/nxp/imx/imx6dl-yapp4-common.dtsi
> @@ -143,7 +143,7 @@
>  
>  		switch@10 {
>  			compatible = "qca,qca8334";
> -			reg = <10>;
> +			reg = <0x10>;
>  			reset-gpios = <&gpio1 25 GPIO_ACTIVE_LOW>;
>  
>  			switch_ports: ports {
> -- 
> 2.1.4
> 

