Return-Path: <linux-kernel+bounces-62444-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DBB4A8520C8
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 22:54:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9684A285F38
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 21:54:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 257714EB3A;
	Mon, 12 Feb 2024 21:53:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="NS2eE5sr"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4C084E1D1;
	Mon, 12 Feb 2024 21:53:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707774834; cv=none; b=W2ZmmRE47Q5aLi1WBS7GunKu0K7LMEJxEmuJAy/TOjtUuRLcssPfBCh8AGnUOES4P7YALB/0Q1y3J+oYo0VxtzPSVaOojoqlfkDFXfNynWOnp0svaxv9NXh/3KgLWcBJ+HV6dru9aj7zUTkbFqN+ZU8jz5lgxJwVk+GWqpfnd9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707774834; c=relaxed/simple;
	bh=9WDRxW8U9j71xvOzyf2SRO3yDQYGi6yYhi5U65+yc2s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ljQYRkQhH3+OoylmdM/iLIXG9KD/wKhqLxZ8YnUDzuN1gM6B/4ODvjIeIQvWYWZiZGW880B9r4ntT07qFXZbZrAWJS/uBkn17oFhIZc5fw2C86/6xIDnzWkRJuza5eR75+hoMecOFfZQx6ntify+FKDx8eQ3m0JooYHB9biTo64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=NS2eE5sr; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1707774830;
	bh=9WDRxW8U9j71xvOzyf2SRO3yDQYGi6yYhi5U65+yc2s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NS2eE5srw/03SEixUV2Ed+/2VApYR5V5NKHpMVHvuydp3FVUqqSlRqHCutaXXsr+f
	 3+uWaTw0455gweqYl8dk6ngI1nsNKPpUsx9BQQzp8b2bUZ4MyLnDzb1ShOyf0M2crZ
	 cyqoBfPQ6C3sVvUVj0yXwsQT7k6aX4Pc84g7AjkSSgq7RrqLV6zN6eesRTwvfmgBuO
	 lINMLNDdTSeY5d9tcsPIe7EXvxFUkC+HD/aWWF1p4byj8kBkIydEOnAT/5gLOXdsLo
	 e2KbtkCpvxvR7P1gp2ABRRmEIbfRD1j3fZthrYF7JSIiPpnmyqVkUFolM/LW6O007V
	 zfbZ4lU0s1j8w==
Received: from notapiano (zone.collabora.co.uk [167.235.23.81])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: nfraprado)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 0DF6437813D5;
	Mon, 12 Feb 2024 21:53:47 +0000 (UTC)
Date: Mon, 12 Feb 2024 16:53:45 -0500
From: =?utf-8?B?TsOtY29sYXMgRi4gUi4gQS4=?= Prado <nfraprado@collabora.com>
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Matthias Brugger <matthias.bgg@gmail.com>
Cc: Chen-Yu Tsai <wenst@chromium.org>,
	Eugen Hristev <eugen.hristev@collabora.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Allen-KH Cheng <allen-kh.cheng@mediatek.com>, kernel@collabora.com,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Subject: Re: [PATCH] arm64: dts: mediatek: mt8186: Add missing clocks to
 ssusb power domains
Message-ID: <985e1a4f-c538-4a9d-be58-2c688aa7350c@notapiano>
References: <20240212-mt8186-ssusb-domain-clk-fix-v1-1-26cb98746aa3@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240212-mt8186-ssusb-domain-clk-fix-v1-1-26cb98746aa3@collabora.com>

On Mon, Feb 12, 2024 at 04:32:44PM -0500, Nícolas F. R. A. Prado wrote:
> The ssusb power domains currently don't list any clocks, despite
> depending on some, and thus rely on the bootloader leaving the required
> clocks on in order to work.
> 
> When booting with the upstream arm64 defconfig, the power domain
> controller will defer probe until modules have loaded since it has an
> indirect dependency on CONFIG_MTK_CMDQ, which is configured as a module.
> However at the point where modules are loaded, unused clocks are also
> disabled, causing the ssusb domains to fail to be enabled and
> consequently the controller to fail probe:
> 
> mtk-power-controller 10006000.syscon:power-controller: /soc/syscon@10006000/power-controller/power-domain@4: failed to power on domain: -110
> mtk-power-controller: probe of 10006000.syscon:power-controller failed with error -110
> 
> Add the missing clocks to the ssusb power domains so the power
> controller can boot without relying on bootloader state.
> 
> Fixes: d9e43c1e7a38 ("arm64: dts: mt8186: Add power domains controller")
> Signed-off-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>
> ---
>  arch/arm64/boot/dts/mediatek/mt8186.dtsi | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/mediatek/mt8186.dtsi b/arch/arm64/boot/dts/mediatek/mt8186.dtsi
> index adaf5e57fac5..02f33ec3cbd3 100644
> --- a/arch/arm64/boot/dts/mediatek/mt8186.dtsi
> +++ b/arch/arm64/boot/dts/mediatek/mt8186.dtsi
> @@ -931,11 +931,19 @@ power-domain@MT8186_POWER_DOMAIN_CSIRX_TOP {
>  
>  				power-domain@MT8186_POWER_DOMAIN_SSUSB {
>  					reg = <MT8186_POWER_DOMAIN_SSUSB>;
> +					clocks = <&topckgen CLK_TOP_USB_TOP>,
> +						 <&infracfg_ao CLK_INFRA_AO_SSUSB_TOP_REF>,
> +						 <&infracfg_ao CLK_INFRA_AO_SSUSB_TOP_XHCI>;
> +					clock-names = "sys_ck", "ref_ck", "xhci_ck";
>  					#power-domain-cells = <0>;
>  				};
>  
>  				power-domain@MT8186_POWER_DOMAIN_SSUSB_P1 {
>  					reg = <MT8186_POWER_DOMAIN_SSUSB_P1>;
> +					clocks = <&infracfg_ao CLK_INFRA_AO_SSUSB_TOP_P1_SYS>,
> +						 <&infracfg_ao CLK_INFRA_AO_SSUSB_TOP_P1_REF>,
> +						 <&infracfg_ao CLK_INFRA_AO_SSUSB_TOP_P1_XHCI>;
> +					clock-names = "sys_ck", "ref_ck", "xhci_ck";

I forgot to mention this here, but the XHCI clock wasn't needed to get the power
domains to work per se, but leaving it out caused issues when probing the mtu3
devices:
<3>[   15.431506] mtu3 11201000.usb: clks of sts1 are not stable!
<3>[   15.443965] mtu3 11201000.usb: device enable failed -110
<3>[   15.454306] mtu3 11201000.usb: mtu3 hw init failed:-110
<3>[   15.463865] mtu3 11201000.usb: failed to initialize gadget
<4>[   15.477890] mtu3: probe of 11201000.usb failed with error -110

<3>[   15.514603] mtu3 11281000.usb: clks of sts1 are not stable!
<3>[   15.525239] mtu3 11281000.usb: device enable failed -110
<3>[   15.614174] mtu3 11281000.usb: mtu3 hw init failed:-110
<3>[   15.619647] mtu3 11281000.usb: failed to initialize gadget
<4>[   15.630623] mtu3: probe of 11281000.usb failed with error -110

Not sure if this issue should be handled separately (maybe the mtu3 device
should enable the XHCI clock?), but I opted to include the clock here to get
boot working for this device at once.

Thanks,
Nícolas

