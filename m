Return-Path: <linux-kernel+bounces-96876-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E7FA987627D
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 11:57:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 53E7DB22D7A
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 10:56:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9334B5579C;
	Fri,  8 Mar 2024 10:56:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arinc9.com header.i=@arinc9.com header.b="ZKRh7LPs"
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [217.70.183.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13AAF14A82;
	Fri,  8 Mar 2024 10:56:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709895410; cv=none; b=hHhdzmpTqXjbiJVMGsyLec42L6/Re+7mKqZkZb36KtewpA3HcL6Z5istlhs9X8+dM+reZBiJG19aQ3kZKLk307dkQL+OSM3TuQId9loF5NetN4yoc2B3SgeUAjk6KwXqgOa8GhoHE4/if6TBNBb4Rb7ahy6PDfuVlwQFo6vMNcA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709895410; c=relaxed/simple;
	bh=eDfcAFfLtMAlFQpX5YR9ldUyPqNu/0sGMCe5kqrcRug=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kEMvYftsMnNdjfU9aGI8NC1oS6pBypI8BbzVo9lxdQIchtJe2FEYvgNGpVq7RxIlt9lOqxUInonHBHkABRRUi1SFtkr7JzU/1Aaaoycxe7HMoGHlZhEq4eErUgh+C74314QaPPJDc4TZ6aiMylDxz63or5F1vRee3gOIK8qKGdg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arinc9.com; spf=pass smtp.mailfrom=arinc9.com; dkim=pass (2048-bit key) header.d=arinc9.com header.i=@arinc9.com header.b=ZKRh7LPs; arc=none smtp.client-ip=217.70.183.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arinc9.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arinc9.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 56D8260007;
	Fri,  8 Mar 2024 10:56:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arinc9.com; s=gm1;
	t=1709895406;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FAw+Jiw7p+B61UXDy8G+fuIZSzLjdiTqt3xioTIben4=;
	b=ZKRh7LPs2bNtgyVYQTqeYkjYgvW7RBQ5+YMIvWLIvDz8aufrottZli9Ee2KqTBPg5+EtmB
	avSkIHL6LDhcQT+DlHLu94zY3CVZgDBM1aT4jEU9NfmKw6208gaTnadJoUBlT5k3khH5Lf
	PqeH4U/dEaVCVfFsZRAHuP3oxjsfnd0VA58m7y3OXLCFRohw98X1i338I/1u+Ry92C8kRW
	zvkATcllLMAKFQR5bbca/rJZumSkl5o7XPaEaUgqIVrhf/Vv2uch35TCSOG04KrO6yQ0m6
	tCLGnVmQXa6oVJa50i63+fIG0UtyK7BaXLIni8YwM/o7m4cAGTm6sIF9/pZVMA==
Message-ID: <0af41707-9d00-4eec-91b0-352f75a89360@arinc9.com>
Date: Fri, 8 Mar 2024 13:56:35 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/3] mips: dts: ralink: mt7621: add serial1 and serial2
 nodes
Content-Language: en-US
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 Justin Swartz <justin.swartz@risingedge.co.za>,
 Sergio Paracuellos <sergio.paracuellos@gmail.com>,
 Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
 Matthias Brugger <matthias.bgg@gmail.com>
Cc: linux-mips@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org
References: <CAMhs-H_eUKm7C40oCzuKwwEMZAcOJ-g4MghAfkGAmxRM0AXPUw@mail.gmail.com>
 <20240307190408.23443-1-justin.swartz@risingedge.co.za>
 <20240307190408.23443-3-justin.swartz@risingedge.co.za>
 <221bb898-a98f-4a2d-9301-84a3baefbbc7@collabora.com>
From: =?UTF-8?B?QXLEsW7DpyDDnE5BTA==?= <arinc.unal@arinc9.com>
In-Reply-To: <221bb898-a98f-4a2d-9301-84a3baefbbc7@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Flag: yes
X-Spam-Level: **************************
X-GND-Spam-Score: 400
X-GND-Status: SPAM
X-GND-Sasl: arinc.unal@arinc9.com

On 8.03.2024 11:44, AngeloGioacchino Del Regno wrote:
> Il 07/03/24 20:04, Justin Swartz ha scritto:
>> Add serial1 and serial2 nodes to define the existence of
>> the MT7621's second and third UARTs.
>>
>> Signed-off-by: Justin Swartz <justin.swartz@risingedge.co.za>
>> ---
>>   arch/mips/boot/dts/ralink/mt7621.dtsi | 28 +++++++++++++++++++++++++++
>>   1 file changed, 28 insertions(+)
>>
>> diff --git a/arch/mips/boot/dts/ralink/mt7621.dtsi b/arch/mips/boot/dts/ralink/mt7621.dtsi
>> index 3ad4e2343..5a89f0b8c 100644
>> --- a/arch/mips/boot/dts/ralink/mt7621.dtsi
>> +++ b/arch/mips/boot/dts/ralink/mt7621.dtsi
>> @@ -124,6 +124,34 @@ serial0: serial@c00 {
>>               pinctrl-0 = <&uart1_pins>;
>>           };
>> +        serial1: serial@d00 {
>> +            compatible = "ns16550a";
>> +            reg = <0xd00 0x100>;
>> +            reg-io-width = <4>;
>> +            reg-shift = <2>;
>> +            clocks = <&sysc MT7621_CLK_UART2>;
>> +            interrupt-parent = <&gic>;
>> +            interrupts = <GIC_SHARED 27 IRQ_TYPE_LEVEL_HIGH>;
>> +            no-loopback-test;
>> +            pinctrl-names = "default";
>> +            pinctrl-0 = <&uart2_pins>;
> 
> As already commented on patch [1/3], pin muxing is board specific. Please remove.
> 
> Also, is there any reason why you can't simply use the `interrupts-extended`
> property instead of interrupt-parent and interrupts?

I'm looking at the documentation [1], it seems to be useful when multiple
interrupt parents need to be defined on a node. I'd continue using
interrupt-parent and interrupts in this case.

[1] https://www.kernel.org/doc/Documentation/devicetree/bindings/interrupt-controller/interrupts.txt

Arınç

