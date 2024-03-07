Return-Path: <linux-kernel+bounces-95783-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 206B287528C
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 15:59:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8B4911F24E27
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 14:59:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71C9312EBDC;
	Thu,  7 Mar 2024 14:59:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=risingedge.co.za header.i=@risingedge.co.za header.b="hylU8K6T"
Received: from outgoing1.flk.host-h.net (outgoing1.flk.host-h.net [188.40.0.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 145E412E1D1;
	Thu,  7 Mar 2024 14:58:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=188.40.0.86
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709823546; cv=none; b=l17UV7HuEhSeH4vSsGVhiojC6KRzxVg4TdGqsURNeqa1WsD48CXbYkqampTa3PVAfgxNj58nUZQ7xZEpxvEa2S68whquhRKDttC/mFblH4zZN89I46fzVw//cMR9DXX4eFfKFflEpYBSMNGcacvFTtvA54+9MfEFJL1RdKwNx2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709823546; c=relaxed/simple;
	bh=Ow23Vq5y+v302qmnpse4mNyyP2IvKIYhwVkgA0H0T4U=;
	h=MIME-Version:Content-Type:Date:From:To:Cc:Subject:In-Reply-To:
	 References:Message-ID; b=gMgfuyaDpB4sNiRdvKxG0h1CGQpNyOcCl3gnpNvzZBj54JCpDEK1QUBXz2xjejIJgMIdgynBUqhd2xKBATfrr1R3RUxDGHKaIC2K+QrbmbNgJCi9s+kPLU2ExsxXvE0tZODnFF7fOcLWh+DXiBPl8c5StMuCP5LbcLOn7ynJhOU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=risingedge.co.za; spf=pass smtp.mailfrom=risingedge.co.za; dkim=pass (2048-bit key) header.d=risingedge.co.za header.i=@risingedge.co.za header.b=hylU8K6T; arc=none smtp.client-ip=188.40.0.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=risingedge.co.za
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=risingedge.co.za
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=risingedge.co.za; s=xneelo; h=Message-ID:References:In-Reply-To:Subject:Cc:
	To:From:Date:Content-Transfer-Encoding:Content-Type:MIME-Version:reply-to:
	sender:bcc; bh=hN/u91xj7BffnOx3vRSR9HgNfOezdTOAMAhpnSwyelI=; b=hylU8K6TjiFbX2
	ATG5g/MCa1Vh9pc8P8jMEloPF5WHES66Cafp5SnTupzImw4jfyQNVj7qcyW6h0mtdNR47W6RR1G08
	MOMj9eiXyE+H7oQS70TtZJe4eZoAeCTV9/YA1+Flp8RJXwgEgTI0kbpayb63bS1XN44JrAsuPw2wB
	etXD5iBvdL1Ap9JuF7HQn3T3yxrd57+rz04kW2x87z1gC4INGBMMI3n+mS+8wmKKHLPIajg21O8D6
	3UulxA6sjv/qgHL7KeZKFQJRWpAOziOcYzu/UMuZ2a/FDTn+ws3iWQvjecQ+UKox+4+SxCxvozy88
	2CwCzUgyR7GIjkzXOrTQ==;
Received: from www31.flk1.host-h.net ([188.40.1.173])
	by antispam3-flk1.host-h.net with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <justin.swartz@risingedge.co.za>)
	id 1riFCp-00AwA7-62; Thu, 07 Mar 2024 16:58:49 +0200
Received: from roundcubeweb1.flk1.host-h.net ([138.201.244.33] helo=webmail9.konsoleh.co.za)
	by www31.flk1.host-h.net with esmtpa (Exim 4.92)
	(envelope-from <justin.swartz@risingedge.co.za>)
	id 1riFCl-00034L-MN; Thu, 07 Mar 2024 16:58:43 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date: Thu, 07 Mar 2024 16:58:43 +0200
From: Justin Swartz <justin.swartz@risingedge.co.za>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: =?UTF-8?Q?Ar=C4=B1n=C3=A7_=C3=9CNAL?= <arinc.unal@arinc9.com>, Sergio
 Paracuellos <sergio.paracuellos@gmail.com>, Rob Herring
 <robh+dt@kernel.org>, Krzysztof Kozlowski
 <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>,
 Thomas Bogendoerfer <tsbogend@alpha.franken.de>, Matthias Brugger
 <matthias.bgg@gmail.com>, AngeloGioacchino Del Regno
 <angelogioacchino.delregno@collabora.com>, linux-mips@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org
Subject: Re: [PATCH] mips: dts: ralink: mt7621: add cell count properties to
 usb0
In-Reply-To: <73e7a642-d993-485f-9ccc-abe3daf79390@linaro.org>
References: <20240306202131.2009-1-justin.swartz@risingedge.co.za>
 <73e7a642-d993-485f-9ccc-abe3daf79390@linaro.org>
Message-ID: <48fd88f29482fc1b94439727b2d2484f@risingedge.co.za>
X-Sender: justin.swartz@risingedge.co.za
User-Agent: Roundcube Webmail/1.3.17
X-Authenticated-Sender: justin.swartz@risingedge.co.za
X-Virus-Scanned: Clear
X-SpamExperts-Domain: risingedge.co.za
X-SpamExperts-Username: 
Authentication-Results: host-h.net; auth=pass (login) smtp.auth=@risingedge.co.za
X-SpamExperts-Outgoing-Class: ham
X-SpamExperts-Outgoing-Evidence: Combined (0.03)
X-Recommended-Action: accept
X-Filter-ID: Pt3MvcO5N4iKaDQ5O6lkdGlMVN6RH8bjRMzItlySaT+jMdw2bofFoyg6nBiIKW60PUtbdvnXkggZ
 3YnVId/Y5jcf0yeVQAvfjHznO7+bT5wCPRB8bAzJcv2cv+UqiTTc2+CpNcmBnO4XM3Sck4bwNogU
 WCl1nkLBzZX0KuJ9bXiS85Z42w/+2OBolTNFbPomXFWCX8oNdggW7HE9XDTdSejrkEpbuUvwMvHx
 3T+KSG//gbuP7hnUK8NQdLwsVWKIFDZRrTGv3rxiw9tFrqFSCFNiLZt/QXQnOBRD+jq1HsKsDh/6
 Srgk2K3gr1VBfJbChkYH6fbrypLNrde+UooQVNLReLErukdelEOHUIpaBbp5GdnsN8+UvimwMinK
 0+Txhz2u9qvrL2PODYgMZQApJXOjDLkqunZ9NcY2bHZn7CfFscMZZf3sCkN20I5vMh4akiObI7Kj
 vK7X04QEin24qbfMFd8eGjnYW8aSH5qj4ujh/13psIvqSqJFa1CcANErDW/w69saM9prk3jNnHtn
 nuEt/J9wDZeQfiNOYsLDFBdwYt2XtlLzy7G7T4kla0JNnAWQx3FS11bhwUa9HCIwKB+TroNcRY33
 oNmH4nRQzHQazgY7lmveanvOdQzf6IMJvXeR9sWP3X7B861DTGeXmiBZB5ABM5ibrJKBc41fzX2f
 c4dPBW7pWChw4uEjGhn8NxWJwjYpP3+Q3/7iG2wtXnUZ0us2LLf9HPH8wHoHg+3go+5B/jmqOvZj
 iTeRCozF+pjfbFrzHCaFHgNTrYhVbBAqR8ZRvY88PgTw/yJlftBcHX6tS8NW54gm54VAvfk9VDzu
 2DWvs648c5Z9erCJvY3rAVkRCEQYQbC3QS5oLY+kBVM18TehOmSn2kZRt3z8CHTZnKdQqcB0QMMU
 IPF3mL0sZmYqDqSi6Ubx7BN0H0IaZOsZnP36dPZwQWhvr8FGGENbqE9x654AXkUfGHPAHnWD1MEm
 8zNnsSuSxjl6RVTXva2Jl4AHe5oTGEWuK7wQuHiJKcf5Sqd6P3zHxU4Ham35bIM7+pzQRR2+p5za
 8H1gUaDJZGpg6c2oigrh+YcF3SeOS5epce2vBFQn8BLQG4wdJz5OZPl/85ViK8Ea0fe5iniRDU9a
 IkFLX1Ne1hGTitUHsPftyxriH1hAvmSO1crrLwiF2BozUnkjKLcelPzx2oqVYjg7pBU6N7n2Xnf9
 ORWrllgKtBSNx6xUC0rhukb6/HI5FFTbPOoZF9qxZ4tAl1zsvXmdn0dcjkDS25rwYtIS82VMysVJ
 IbwiF17/r3cXutruHTpS87YkskBoFo6eZ5Uv5yUh4sH+KRvQOJ2675fcuW/3lDmDZZ7XgBhunFdj
 VYxKH3qWyoySMt2NXQeSeCQL64BFVPTx/kcAi/BxTD536X9tHdQbSeO43htW0OUycBmbGvKlxEqV
 RjJltGRy2DNwOgV373pfDhBQ21Od8BCsodKtWDQizmRHoSVjKnexcCkQ+p5zWKzxeWKxLCyS8776
 l4RSwc4z5cqDb97hdiFVwaP90eVaqnDphEW4xEWnj3iKGpP30awjRzKpQ4kPl+3D1YhNMZlGTB68
 YWMe6VM9RYQVmV8q7nN/oibcn491jt+pt12gBHaGoo19huz2OKHH5lr9xXvSM4nM3avg
X-Report-Abuse-To: spam@antispamquarantine.host-h.net

Hi Krzysztof

On 2024-03-07 10:01, Krzysztof Kozlowski wrote:
> On 06/03/2024 21:21, Justin Swartz wrote:
>> Add default #address-cells and #size-cells properties to usb0,
>> suitable for hubs and devices without explicitly declared
>> interface nodes, as:
>> 
>>   "#address-cells":
>>     description: should be 1 for hub nodes with device nodes,
>>       should be 2 for device nodes with interface nodes.
>>     enum: [1, 2]
>> 
>>   "#size-cells":
>>     const: 0
>> 
>> -- from Documentation/devicetree/bindings/usb/usb-device.yaml
>> 
>> Signed-off-by: Justin Swartz <justin.swartz@risingedge.co.za>
>> ---
>>  arch/mips/boot/dts/ralink/mt7621.dtsi | 3 +++
>>  1 file changed, 3 insertions(+)
>> 
>> diff --git a/arch/mips/boot/dts/ralink/mt7621.dtsi 
>> b/arch/mips/boot/dts/ralink/mt7621.dtsi
>> index 2069249c8..f02965db1 100644
>> --- a/arch/mips/boot/dts/ralink/mt7621.dtsi
>> +++ b/arch/mips/boot/dts/ralink/mt7621.dtsi
>> @@ -309,6 +309,9 @@ usb: usb@1e1c0000 {
>> 
>>  		interrupt-parent = <&gic>;
>>  		interrupts = <GIC_SHARED 22 IRQ_TYPE_LEVEL_HIGH>;
>> +
>> +		#address-cells = <1>;
>> +		#size-cells = <0>;
> 
> Doesn't this bring new W=1 warnings?

For a fresh build (make O=build clean; make O=build W=1): I do not 
receive any warnings regarding mt7621.dtsi or my board's .dts file. I 
added these properties to the usb node because I had received warnings 
about a child node for a permenantly-connected/onboard hub:

--%--

/ {
	...

	usb_fixed_5v0: regulator {
		compatible = "regulator-fixed";
		regulator-name = "usb_vbus";
		regulator-min-microvolt = <5000000>;
		regulator-max-microvolt = <5000000>;
		regulator-boot-on;
		regulator-always-on;
	};

	usb_fixed_3v3: regulator {
		compatible = "regulator-fixed";
		regulator-name = "usb_vusb33";
		regulator-min-microvolt = <3300000>;
		regulator-max-microvolt = <3300000>;
		regulator-boot-on;
		regulator-always-on;
	};
};

&usb {
	usb3-lpm-capable;

	vbus-supply = <&usb_fixed_5v0>;
	vusb33-supply = <&usb_fixed_3v3>;

	hub: hub@0 {
		compatible = "usb5e3,608";
		reg = <1>;
	};
};

--%--

If the #address-cells and #size-cells properties are removed from the 
usb node, the following warnings are generated:

$ make O=build W=1 dtbs
make[1]: Entering directory 
'/home/user/projects/xfl-mt7621/src/linux/build'
   GEN     Makefile
   CALL    ../scripts/checksyscalls.sh
   DTC     arch/mips/boot/dts/ralink/mt7621-client-product.dtb
./arch/mips/boot/dts/ralink/mt7621-client-product.dts:276.3-13: Warning 
(reg_format): /usb@1e1c0000/hub@0:reg: property has invalid length (4 
bytes) (#address-cells == 2, #size-cells == 1)
arch/mips/boot/dts/ralink/mt7621-client-product.dtb: Warning 
(pci_device_reg): Failed prerequisite 'reg_format'
arch/mips/boot/dts/ralink/mt7621-client-product.dtb: Warning 
(pci_device_bus_num): Failed prerequisite 'reg_format'
arch/mips/boot/dts/ralink/mt7621-client-product.dtb: Warning 
(simple_bus_reg): Failed prerequisite 'reg_format'
arch/mips/boot/dts/ralink/mt7621-client-product.dtb: Warning 
(i2c_bus_reg): Failed prerequisite 'reg_format'
arch/mips/boot/dts/ralink/mt7621-client-product.dtb: Warning 
(spi_bus_reg): Failed prerequisite 'reg_format'
./arch/mips/boot/dts/ralink/mt7621-client-product.dts:274.13-277.4: 
Warning (avoid_default_addr_size): /usb@1e1c0000/hub@0: Relying on 
default #address-cells value
./arch/mips/boot/dts/ralink/mt7621-client-product.dts:274.13-277.4: 
Warning (avoid_default_addr_size): /usb@1e1c0000/hub@0: Relying on 
default #size-cells value
arch/mips/boot/dts/ralink/mt7621-client-product.dtb: Warning 
(avoid_unnecessary_addr_size): Failed prerequisite 
'avoid_default_addr_size'
arch/mips/boot/dts/ralink/mt7621-client-product.dtb: Warning 
(unique_unit_address_if_enabled): Failed prerequisite 
'avoid_default_addr_size'
   DTC     arch/mips/boot/dts/ralink/mt7621-gnubee-gb-pc1.dtb
   DTC     arch/mips/boot/dts/ralink/mt7621-gnubee-gb-pc2.dtb
   DTC     arch/mips/boot/dts/ralink/mt7621-tplink-hc220-g5-v1.dtb
make[1]: Leaving directory 
'/home/user/projects/xfl-mt7621/src/linux/build'


If I add add them back to the usb node, this is the result:

$ make O=build W=1 dtbs
make[1]: Entering directory 
'/home/user/projects/xfl-mt7621/src/linux/build'
   GEN     Makefile
   CALL    ../scripts/checksyscalls.sh
   DTC     arch/mips/boot/dts/ralink/mt7621-client-product.dtb
   DTC     arch/mips/boot/dts/ralink/mt7621-gnubee-gb-pc1.dtb
   DTC     arch/mips/boot/dts/ralink/mt7621-gnubee-gb-pc2.dtb
   DTC     arch/mips/boot/dts/ralink/mt7621-tplink-hc220-g5-v1.dtb
make[1]: Leaving directory 
'/home/user/projects/xfl-mt7621/src/linux/build'


> Best regards,
> Krzysztof

Regards
Justin

