Return-Path: <linux-kernel+bounces-96685-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 64117875FFB
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 09:45:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C4635B237F9
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 08:45:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B579F2D04C;
	Fri,  8 Mar 2024 08:44:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="Jc+M824n"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8785922EF8;
	Fri,  8 Mar 2024 08:44:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709887471; cv=none; b=Wcqz5kHsF7iDOB61fahyM2AMUgoQdBpOUyE1U/Ib3hBhqBAneYygGgpT2nCMVfxFyAnpd+sofr4H8VaSQ7ExcQQllIMu3CQMf/6HejCnGEpfD1nlCpf8S/4V8ZDx/84R5oMTbu2whIeht3ikSWwdats18yXMpdbIZZQliJm448Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709887471; c=relaxed/simple;
	bh=B7LQlsTP8n7h7BoltSXzPKTfWSgRJiLpFX0/sEPwOfA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pQzVwrBTp+7m+bl0tYkKSxVHWFkWv9RhukheVNe56xH/Jw+BZ2Q9R1xraUm1FQmKYjBMagwAKxgLw8FYXTknjj0LMYPd8afOqMRKH+1BVujMIHvXn0jJXVAXbQkCqxlyBRXcqpMXBNjx6S6XH0JYl3ftivPz4Iq486NfOrliinY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=Jc+M824n; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1709887467;
	bh=B7LQlsTP8n7h7BoltSXzPKTfWSgRJiLpFX0/sEPwOfA=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Jc+M824nUahP8KaBVrM5zRu5925hP6lIzzPi9RvYdAN4ZFGx9IuYsUdbEWnHfhNs4
	 y9hSpl1tXJtpmYJpU9NT5yp73X/ME3on1IV3XeTm6B/nFHVU693lXJI4u46UFfAj6/
	 Kpuc5/jlSQx9D5CdTXBHyqdBFDgbzRCBd9sVbvb7Z5QeSZPx0RC3GO49TLhZ4Xe6Ks
	 FZmsTzSz90xrSazCH46Xhmb9Hu7Ttutt3LpgrNt7Q6La+/SWMSVOoGjqkftFjEjLYV
	 giFDm+rC8kokq1qLuBsaX9jZ+XMpoUzqI7OK/8nMqrqpl0MDiAEV+WldQ/P4u0V5u+
	 Ih0a6OXos1bHg==
Received: from [100.113.186.2] (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id DC7A437813CA;
	Fri,  8 Mar 2024 08:44:26 +0000 (UTC)
Message-ID: <221bb898-a98f-4a2d-9301-84a3baefbbc7@collabora.com>
Date: Fri, 8 Mar 2024 09:44:26 +0100
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
To: Justin Swartz <justin.swartz@risingedge.co.za>,
 =?UTF-8?B?QXLEsW7DpyDDnE5BTA==?= <arinc.unal@arinc9.com>,
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
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20240307190408.23443-3-justin.swartz@risingedge.co.za>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 07/03/24 20:04, Justin Swartz ha scritto:
> Add serial1 and serial2 nodes to define the existence of
> the MT7621's second and third UARTs.
> 
> Signed-off-by: Justin Swartz <justin.swartz@risingedge.co.za>
> ---
>   arch/mips/boot/dts/ralink/mt7621.dtsi | 28 +++++++++++++++++++++++++++
>   1 file changed, 28 insertions(+)
> 
> diff --git a/arch/mips/boot/dts/ralink/mt7621.dtsi b/arch/mips/boot/dts/ralink/mt7621.dtsi
> index 3ad4e2343..5a89f0b8c 100644
> --- a/arch/mips/boot/dts/ralink/mt7621.dtsi
> +++ b/arch/mips/boot/dts/ralink/mt7621.dtsi
> @@ -124,6 +124,34 @@ serial0: serial@c00 {
>   			pinctrl-0 = <&uart1_pins>;
>   		};
>   
> +		serial1: serial@d00 {
> +			compatible = "ns16550a";
> +			reg = <0xd00 0x100>;
> +			reg-io-width = <4>;
> +			reg-shift = <2>;
> +			clocks = <&sysc MT7621_CLK_UART2>;
> +			interrupt-parent = <&gic>;
> +			interrupts = <GIC_SHARED 27 IRQ_TYPE_LEVEL_HIGH>;
> +			no-loopback-test;
> +			pinctrl-names = "default";
> +			pinctrl-0 = <&uart2_pins>;

As already commented on patch [1/3], pin muxing is board specific. Please remove.

Also, is there any reason why you can't simply use the `interrupts-extended`
property instead of interrupt-parent and interrupts?

Regards,
Angelo


