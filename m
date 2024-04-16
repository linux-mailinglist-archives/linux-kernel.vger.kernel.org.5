Return-Path: <linux-kernel+bounces-146460-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id F05D48A65AB
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 10:05:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 88491B222D2
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 08:05:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0238282C8E;
	Tue, 16 Apr 2024 08:05:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kwiboo.se header.i=@kwiboo.se header.b="HWK+CtFd"
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64B6184DE6
	for <linux-kernel@vger.kernel.org>; Tue, 16 Apr 2024 08:05:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=149.28.215.223
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713254725; cv=none; b=OGIedM8hNx/6IhT8jMO5OX4iUhTJaDRW/tvrQD3yPtEAmvZFshsD738EgWACa9UIhp7tZ35kaID9xfhbqPwBTOXcgeP3q3gYrw/xFcB7sxWXxLhU7Ywf/a/NoNbsT0Uhr1fEcxl41DI7Kk04RKDXDFcG93eLOFNG5R/NAGSUu+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713254725; c=relaxed/simple;
	bh=jmOu2PsQhNoTt9z6LN3rQcp77Qspy3rBNUwBSbFMvxI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VJzX3mlDmTRM3gB1nAUS3y0hhL2Uao30a7UR94IRvE9pMOM8XRlDHcqbzEvU7Vk93N3EYtIoblNE0sjoPiXzXc7DP5x2KzhsbbZId4+j3zMJg6k+ii3DY3Phedoz/v/R5C3dvaRZJq8VpOScsVSvfwQbsj7MNunMXoqUNuylR/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kwiboo.se; spf=pass smtp.mailfrom=fe-bounces.kwiboo.se; dkim=pass (2048-bit key) header.d=kwiboo.se header.i=@kwiboo.se header.b=HWK+CtFd; arc=none smtp.client-ip=149.28.215.223
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: Content-Type: In-Reply-To: From: References:
 Cc: To: Subject: MIME-Version: Date: Message-ID; q=dns/txt;
 s=fe-e1b5cab7be; t=1713254714;
 bh=9v28hOIUE9GkM0a76qA4AwgtWDjyV1OaSvUjBLLAPY8=;
 b=HWK+CtFdqlfcCh0mmfXdyKbDIxtifX9DA2Yz5T+Gtbu9xskeu/1MKoki1WMnCWovx89Vt4HDm
 wJcO+eEraJWf65BgmA+UAqFk16FkoQpAgMRIQ3CNrH/waHhO9vmO1deULXy7FLvBCnkxMCn/sFK
 KvXQn0su+k89Y9o+Rf6egTtIwREkdfRsCp7QvOjO0qyiKHlb5G4fxUaRZb+f52APvzs3e/Ob9On
 wrorhEaE7dKDxBlB/oW354NUEIFhE11JDrhzPQcM3Zq5zrvOrZcZevy55MyMYww3UMG85+iZCxG
 L/quX65XN8qTqznAw9W5c2StwlhAWjjY7z8+WLT8sLLw==
Message-ID: <f5a9e7c0-1d8c-462b-bf7a-d6aa73f63afa@kwiboo.se>
Date: Tue, 16 Apr 2024 10:05:09 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/2] arm64: dts: rockchip: Add Radxa ZERO 3W/3E
To: Heiko Stuebner <heiko@sntech.de>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley
 <conor+dt@kernel.org>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20240415150349.2207075-1-jonas@kwiboo.se>
 <20240415150349.2207075-3-jonas@kwiboo.se>
Content-Language: en-US
From: Jonas Karlman <jonas@kwiboo.se>
In-Reply-To: <20240415150349.2207075-3-jonas@kwiboo.se>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Report-Abuse-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-ForwardEmail-Version: 0.4.40
X-ForwardEmail-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 149.28.215.223
X-ForwardEmail-ID: 661e313a0360d053efe603b4

On 2024-04-15 17:03, Jonas Karlman wrote:
> The Radxa ZERO 3W/3E is an ultra-small, high-performance single board
> computer based on the Rockchip RK3566, with a compact form factor and
> rich interfaces.
> 
> The ZERO 3W and ZERO 3E are basically the same size and model, but
> differ only in storage and network interfaces.
> 
> - eMMC (3W)
> - SD-card (both)
> - Ethernet (3E)
> - WiFi/BT (3W)
> 
> This adds initial support for eMMC, SD-card, Ethernet, HDMI and USB.
> 
> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
> ---
> v2: Add to Makefile
> v3: Sort hdmi-con and leds nodes alphabetically
> v3: Sort pmic@20 and regulator@40 nodes by reg
> v3: Change to regulator-off-in-suspend for vdd_logic
> 
> Following issue is reported by dtbs_check and is fixed by patch at [1]:
> 
>   hdmi@fe0a0000: Unevaluated properties are not allowed ('#sound-dai-cells' was unexpected)
>   from schema $id: http://devicetree.org/schemas/display/rockchip/rockchip,dw-hdmi.yaml#
> 
> [1] https://lore.kernel.org/linux-rockchip/3a035c16-75b5-471d-aa9d-e91c2bb9f8d0@gmail.com/
> ---
>  arch/arm64/boot/dts/rockchip/Makefile         |   2 +
>  .../dts/rockchip/rk3566-radxa-zero-3e.dts     |  41 ++
>  .../dts/rockchip/rk3566-radxa-zero-3w.dts     |  26 +
>  .../boot/dts/rockchip/rk3566-radxa-zero3.dtsi | 443 ++++++++++++++++++
>  4 files changed, 512 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/rockchip/rk3566-radxa-zero-3e.dts
>  create mode 100644 arch/arm64/boot/dts/rockchip/rk3566-radxa-zero-3w.dts
>  create mode 100644 arch/arm64/boot/dts/rockchip/rk3566-radxa-zero3.dtsi
> 

[snip]

> diff --git a/arch/arm64/boot/dts/rockchip/rk3566-radxa-zero3.dtsi b/arch/arm64/boot/dts/rockchip/rk3566-radxa-zero3.dtsi
> new file mode 100644
> index 000000000000..ea8ade3a4c99
> --- /dev/null
> +++ b/arch/arm64/boot/dts/rockchip/rk3566-radxa-zero3.dtsi

[snip]

> +
> +&i2c0 {
> +	status = "okay";
> +

[snip]

> +	vdd_cpu: regulator@40 {
> +		compatible = "silergy,syr827";

After checking once more on schematic and inspecting the board this is
actually a RK860-0 regulator and should use following:

  compatible = "rockchip,rk8600";

Will send a v4 with this change later this week.

Regards,
Jonas

> +		reg = <0x40>;
> +		fcs,suspend-voltage-selector = <1>;
> +		regulator-name = "vdd_cpu";
> +		regulator-always-on;
> +		regulator-boot-on;
> +		regulator-min-microvolt = <712500>;
> +		regulator-max-microvolt = <1390000>;
> +		regulator-ramp-delay = <2300>;
> +		vin-supply = <&vcc_sys>;
> +
> +		regulator-state-mem {
> +			regulator-off-in-suspend;
> +		};
> +	};
> +};

[snip]

