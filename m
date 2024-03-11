Return-Path: <linux-kernel+bounces-98888-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 11D948780B4
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 14:34:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B89121F22D91
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 13:34:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BF5D3FB95;
	Mon, 11 Mar 2024 13:33:54 +0000 (UTC)
Received: from elvis.franken.de (elvis.franken.de [193.175.24.41])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB3903FB3F;
	Mon, 11 Mar 2024 13:33:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.175.24.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710164034; cv=none; b=kP8rhnJbDCVeSnAmhY0C9X89bly/fDSjvMxSnnraVDOe9z2uKZ242cAP842PH3ARLz0gR+dnJbo+oPrjkSB9LTzxw2h8K2bK4zHdzNxXefgMl5CalTqklE5/G98GHBjxuvA/FxrfwhPazHGxQALKU2gSNbqH7FgTc7myu6EG7wU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710164034; c=relaxed/simple;
	bh=Es3yd8d2cdOCIm/8CB1nM2w+I5Mj+9uunlwN2DPeups=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FZYtA2zgcbkduZoPLND7C5DKqoUVJjALKiFNpjVhZ2ro0MXrMM9f4+aYYY85iOKVQemukIkoTr9000grR7QIgGuTZTFJ1TEp7gEBo3voaeV6obSysTups42lxwO4OECWDInbk2kx83g5I3I5lmdUSlxeaCaro8KLzHziJ4X8rT8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=alpha.franken.de; spf=pass smtp.mailfrom=alpha.franken.de; arc=none smtp.client-ip=193.175.24.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=alpha.franken.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alpha.franken.de
Received: from uucp by elvis.franken.de with local-rmail (Exim 3.36 #1)
	id 1rjfO2-0001be-00; Mon, 11 Mar 2024 14:08:14 +0100
Received: by alpha.franken.de (Postfix, from userid 1000)
	id 0B6CEC066F; Mon, 11 Mar 2024 14:04:44 +0100 (CET)
Date: Mon, 11 Mar 2024 14:04:44 +0100
From: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
To: Justin Swartz <justin.swartz@risingedge.co.za>
Cc: =?utf-8?B?QXLEsW7DpyDDnE5BTA==?= <arinc.unal@arinc9.com>,
	Sergio Paracuellos <sergio.paracuellos@gmail.com>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	linux-mips@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Subject: Re: [PATCH v3] mips: dts: ralink: mt7621: add cell count properties
 to usb
Message-ID: <Ze8BbC5i94jbote1@alpha.franken.de>
References: <20240308161130.12228-1-justin.swartz@risingedge.co.za>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240308161130.12228-1-justin.swartz@risingedge.co.za>

On Fri, Mar 08, 2024 at 06:11:30PM +0200, Justin Swartz wrote:
> Add default #address-cells and #size-cells properties to the
> usb node, which should be suitable for hubs and devices without
> explicitly declared interface nodes, as:
> 
>    "#address-cells":
>      description: should be 1 for hub nodes with device nodes,
>        should be 2 for device nodes with interface nodes.
>      enum: [1, 2]
> 
>    "#size-cells":
>      const: 0
> 
> -- from Documentation/devicetree/bindings/usb/usb-device.yaml
> 
> Acked-by: Sergio Paracuellos <sergio.paracuellos@gmail.com>
> Signed-off-by: Justin Swartz <justin.swartz@risingedge.co.za>
> ---
> v2 -> v3: Patch revision commentary removed from commit message
>           as instructed by Sergio Paracuellos.
> 
> v1 -> v2: Reorder the properties according to
>           Documentation/devicetree/bindings/dts-coding-style.rst
> 
>  arch/mips/boot/dts/ralink/mt7621.dtsi | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/arch/mips/boot/dts/ralink/mt7621.dtsi b/arch/mips/boot/dts/ralink/mt7621.dtsi
> index 02e1f2491..6e95e6f19 100644
> --- a/arch/mips/boot/dts/ralink/mt7621.dtsi
> +++ b/arch/mips/boot/dts/ralink/mt7621.dtsi
> @@ -307,6 +307,9 @@ usb: usb@1e1c0000 {
>  		       0x1e1d0700 0x0100>;
>  		reg-names = "mac", "ippc";
>  
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +
>  		clocks = <&sysc MT7621_CLK_XTAL>;
>  		clock-names = "sys_ck";
>  
> -- 

applied to mips-next.

Thomas.

-- 
Crap can work. Given enough thrust pigs will fly, but it's not necessarily a
good idea.                                                [ RFC1925, 2.3 ]

