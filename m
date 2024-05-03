Return-Path: <linux-kernel+bounces-167288-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EF75E8BA738
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 08:48:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AB3D0282E21
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 06:48:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E145E14659F;
	Fri,  3 May 2024 06:48:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pAdgtNPV"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A94B57CA8;
	Fri,  3 May 2024 06:48:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714718931; cv=none; b=Y07Oby9QNRe9mPEAFvBUadtcubb24neA0r2iNIh7vB+CTuVGJlv9hKPqzXMsSLzmaaqkPuV4USMWgFi3fS+yW3wmGEpA3gr8bQSEoa49z+H+mxXAnNSVbhekMoQuHeQ1NxXsbzlnBIHxNC0i5vC5iA3zNm4HXsGTZ2N8vuW/cO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714718931; c=relaxed/simple;
	bh=Rlk2JdJLQfIWr3bOPVKzsCNfAPRlYscY3ZEGu+wdrqE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=C+SONrksN+rdzAyNN55/MpJRA2rTHely3pACIX+grUWluIXK/ongaaV+AvmXybcoKmYHMIzwuJqoPNAptAam5u/Gs2Ozd4I8n5ROlmpUmHnujFYqbqjQ9bwb1CeePUNT/whmSEHn6+6idv+ZAnQ4X5WYzqI5OsiuYD4EovXkIp4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pAdgtNPV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1268EC116B1;
	Fri,  3 May 2024 06:48:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714718930;
	bh=Rlk2JdJLQfIWr3bOPVKzsCNfAPRlYscY3ZEGu+wdrqE=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=pAdgtNPVXg+TSZI20J8ISr/7P41UuzCuBkw5Mm67Ar5UQZEyfFBI5CPtftboxUkEG
	 RoKHWgqUYR/MOF7CDbH6CTmKcdy+xkoZX8cX9G7uyrXtCuIzmbVcIpDDtRB4q8zdl5
	 3hFsphAJfOcYGtnn4aV9Kt3fIjk48LjLokVTlw1/js/NkdgPova7ENarcXEDWowDn4
	 +FIPBetNp+TQ3X5lHXkE3Eawisbx09vdvOKQkLly54YTrmGG7jNIe69vBxJZ1FuqHH
	 fnEEiidsZa0bfA+37ICZ48NOwZDgRsiV+6q5YebLNvbEPkCWOI6CPxvV8c9gXcn1oJ
	 RLovzWPhlFH4w==
Message-ID: <865b6c46-b09c-4251-867c-992f008001ae@kernel.org>
Date: Fri, 3 May 2024 09:48:45 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] arm64: dts: ti: k3-j784s4-evm: Enable USB3 support
To: Ravi Gunasekaran <r-gunasekaran@ti.com>, nm@ti.com, vigneshr@ti.com
Cc: kristo@kernel.org, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, srk@ti.com, linux-arm-kernel@lists.infradead.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240502053615.29514-1-r-gunasekaran@ti.com>
 <20240502053615.29514-3-r-gunasekaran@ti.com>
Content-Language: en-US
From: Roger Quadros <rogerq@kernel.org>
In-Reply-To: <20240502053615.29514-3-r-gunasekaran@ti.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 02/05/2024 08:36, Ravi Gunasekaran wrote:
> From: Matt Ranostay <mranostay@ti.com>
> 
> The board uses SERDES0 Lane 3 for USB3 IP. So update the
> SerDes lane info for USB. Add the pin mux data and
> enable USB3 support.
> 
> Signed-off-by: Matt Ranostay <mranostay@ti.com>
> Signed-off-by: Ravi Gunasekaran <r-gunasekaran@ti.com>
> ---
>  arch/arm64/boot/dts/ti/k3-j784s4-evm.dts | 41 ++++++++++++++++++++++++
>  1 file changed, 41 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/ti/k3-j784s4-evm.dts b/arch/arm64/boot/dts/ti/k3-j784s4-evm.dts
> index d511b25d62e3..bee73dab803d 100644
> --- a/arch/arm64/boot/dts/ti/k3-j784s4-evm.dts
> +++ b/arch/arm64/boot/dts/ti/k3-j784s4-evm.dts
> @@ -336,6 +336,13 @@
>  			J784S4_IOPAD(0x010, PIN_INPUT_PULLUP, 8) /* (AH33) MCAN13_RX.I2C4_SDA */
>  		>;
>  	};
> +
> +	main_usbss0_pins_default: main-usbss0-pins-default {

Should be main-usbss0-default-pins

This should fix the checkpatch warning.

> +		bootph-all;
> +		pinctrl-single,pins = <
> +			J784S4_IOPAD(0x0ec, PIN_OUTPUT, 6) /* (AN37) TIMER_IO1.USB0_DRVVBUS */
> +		>;
> +	};
>  };
>  
>  &wkup_pmx2 {
> @@ -1041,6 +1048,40 @@
>  				 <&k3_clks 218 22>;
>  };
>  
> +&serdes0 {
> +	status = "okay";
> +
> +	serdes0_usb_link: phy@3 {
> +		reg = <3>;
> +		cdns,num-lanes = <1>;
> +		#phy-cells = <0>;
> +		cdns,phy-type = <PHY_TYPE_USB3>;
> +		resets = <&serdes_wiz0 4>;
> +	};
> +};
> +
> +&serdes_wiz0 {
> +	status = "okay";
> +};
> +
> +&usb_serdes_mux {
> +	idle-states = <0>; /* USB0 to SERDES lane 3 */
> +};
> +
> +&usbss0 {
> +	status = "okay";
> +	pinctrl-0 = <&main_usbss0_pins_default>;
> +	pinctrl-names = "default";
> +	ti,vbus-divider;
> +};
> +
> +&usb0 {
> +	dr_mode = "otg";
> +	maximum-speed = "super-speed";
> +	phys = <&serdes0_usb_link>;
> +	phy-names = "cdns3,usb3-phy";
> +};
> +
>  &serdes_wiz4 {
>  	status = "okay";
>  };

-- 
cheers,
-roger

