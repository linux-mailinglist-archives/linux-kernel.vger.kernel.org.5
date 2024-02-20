Return-Path: <linux-kernel+bounces-72620-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5222885B64C
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 09:58:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0E5602895B0
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 08:58:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 245C65FB83;
	Tue, 20 Feb 2024 08:54:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="DR+iocJ0"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F00EE5F481;
	Tue, 20 Feb 2024 08:54:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708419252; cv=none; b=MaC6DUdLL0C2caYbmTxiz73GW3MZDVMgsSqtkkC7cNDRBQs9v7ZFCI4/7hOY+I8aOXM2hP+ZV0D3lTqBvyUr4l6GUYhtogZbyJETUv2XXVP1CPdWlOb8JZ6O3oZFsLVyTew2DOGdgGr4dUVcqa6z2mLdAGEnF/eD8eo/BW0oOIE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708419252; c=relaxed/simple;
	bh=M8/PhF0aAqABF/pRPoLSGcD9DP7US6tDXUQJIwRD354=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Iqz3KjVQFZTcdhynKGC8Jf2shxY8D8BhwNYyuaRNc30ISEhMA1sWJH6Ro0ijxuhnDtGRwvg6W1wiDX3YLyU2/rs/E4/5pMfpzX9fZRbvoH0WJ+XZql2MzPjp9p4336F3Lc+26trQ0RCQCsoAuTTYuIiMJ2WovmWhis5/7+u9Uio=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=DR+iocJ0; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1708419249;
	bh=M8/PhF0aAqABF/pRPoLSGcD9DP7US6tDXUQJIwRD354=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=DR+iocJ0Rz307omPoFvSmgFRhhtAABmY+XrQiLAQTlRAUrlFw0GZNJHxjMmhx0/Bt
	 t5k9wtlV0/qqG4tbCx4SsErlOTi62v7aAYS+RtHrrdZ0jEIhRS/GtenkuekSVt9Kxr
	 CoktsWi4i1CuJOQP8KRT7wmCsu4YKDQlTGOnGeBo/CwD2kA83Al4KOzpFyMWL/WheZ
	 XuQ3HJEKCfQUD8iRPn62+QpsOgdO1Ic5ZHti6deOh38+fO8tOzBdL6SKSsr9dnXYEl
	 KSGJ91O8qNhbfMIurf044wjDJA7C2ERHwCRHWNfXtcUGoP1LngdopvU5C0derCZWRP
	 bKQtUiDOAwfqA==
Received: from [100.113.186.2] (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id E581E37820C1;
	Tue, 20 Feb 2024 08:54:08 +0000 (UTC)
Message-ID: <e0c44c03-8c66-4a44-9c6d-6b8c83e9d16f@collabora.com>
Date: Tue, 20 Feb 2024 09:54:08 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] arm64: dts: mediatek: add Kontron 3.5"-SBC-i1200
To: Michael Walle <mwalle@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>
Cc: devicetree@vger.kernel.org, Sean Wang <sean.wang@mediatek.com>,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org
References: <20240219084456.1075445-1-mwalle@kernel.org>
 <20240219084456.1075445-2-mwalle@kernel.org>
 <2ad6bda8-a457-421b-b35d-dc005fb00ae9@collabora.com>
 <CZ92W3VSYV1A.1693O76GY1XDP@kernel.org>
 <b50d49fd-2976-46fc-9f35-354fb39720ad@collabora.com>
 <CZ93XYV3MB10.YRCFWLLHIICY@kernel.org>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <CZ93XYV3MB10.YRCFWLLHIICY@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 19/02/24 14:59, Michael Walle ha scritto:
> On Mon Feb 19, 2024 at 2:35 PM CET, AngeloGioacchino Del Regno wrote:
>>>> vbus is always supplied by something, as otherwise USB won't work - whether this
>>>> is an always-on regulator or a passthrough from external supply this doesn't really
>>>> matter - you should model a regulator-fixed that provides the 5V VBUS line.
>>>
>>> I don't think this is correct, though. Think of an on-board USB
>>> hub. There only D+/D- are connected (and maybe the USB3.2 SerDes
>>> lanes). Or have a look at the M.2 pinout. There is no Vbus.
>>>
>>
>> Yes but the MediaTek MTU3 and/or controllers do have it ;-)
> 
> .. and ..
> 
>>>> For example:
>>>> 	vbus_fixed: regulator-vbus {
>>>> 		compatible = "regulator-fixed";
>>>> 		regulator-name = "usb-vbus";
>>>> 		regulator-always-on;
>>>> 		regulator-boot-on;
>>>> 		regulator-min-microvolt = <5000000>;
>>>> 		regulator-max-microvolt = <5000000>;
>>>> 	};
>>>
>>> As mentioned above, I don't think this will make sense in my case.
>>>   >> P.S.: If the rail has a different name, please use that different name. Obviously
>>>> that requires you to have schematics at hand, and I don't know if you do: if you
>>>> don't, then that regulator-vbus name is just fine.
>>>
>>> I do have the schematics.
>>
>> In that case, you should model the power tree with the fixed power lines,
>> check mt8195-cherry (and/or cherry-tomato) and radxa-nio-12l; even though
>> those are technically "doing nothing", this is device tree, so it should
>> provide a description of the hardware ... and the board does have fixed
>> power lines.
>> It has at least one: DC-IN (typec, barrel jack or whatever, the board needs
>> power, doesn't it?!).
> 
> Mh, maybe I don't get it. But within the hardware there is simply no
> Vbus. Thus I'd argue it doesn't make sense to have a vbus-supply
> property. Besides, the mediatek,mtu3.yaml binding lists it as
> deprecated anyway and it should rather be on the connector. There,
> it makes perfectly sense (at least if it's a USB connector).
> 
> Thus in my case, the xhci for the front port has a vbus-supply
> property (but it should rather have a connector node, as I've just
> learned). But the internal port which connects to the USB hub
> shouldn't have one.
> 
> 
>    +-----+           +-----+                  +------+
>    |     |<--Dp/Dn-->|     |<------Dp/Dn----->| USB  |
>    | SoC |           |     |                  | Conn |
>    |     |           |     |   +-----+        |      |
>    +-----+           | USB |   | PWR |--Vbus->|      |
>                      | Hub |   | SW  |        +------+
>                      |     |   +-----+
>                      |     |     ^
>                      |     |     | PRTPWR
>                      |     |-----'
>                      +-----+
> 
> "PWR SW" is a power switch, the input (+5V) isn't shown here. The
> power will be enabled by the USB Hub.
> 

Ok then, put the vbus on the connector, where applicable.

If PWR_SW is a physical switch (not detectable), then you can still model it as an
always-on regulator-fixed, as there's no other clean way of doing that.

As for modeling the power tree with the fixed power lines, I mean that you should
add the power rails as described in your schematics.
You will surely have one DC-IN supply, and others. That should be modeled as a
fixed regulator, which outputs to (probably) the PMIC, using it as an input for
its buck regulators.

Again, your PMIC must be getting a voltage from somewhere in order to regulate
that to a different voltage for a different power rail, right? :-)

Regards,
Angelo

