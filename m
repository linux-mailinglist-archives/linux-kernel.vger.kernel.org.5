Return-Path: <linux-kernel+bounces-96680-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 860FB875FE8
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 09:44:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 41D75284C97
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 08:44:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCB29535A2;
	Fri,  8 Mar 2024 08:41:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="GYeAJgDR"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 706C31CAB2;
	Fri,  8 Mar 2024 08:41:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709887300; cv=none; b=Cll5/NEGRlJphLGO0h0MdZGdvmBWdmap3KBN4DOKmYmq9tXdqBd4GkPGQ070R9LV5MxFqVu4K3UiyiiqeYAKdz4goOLK/SFZOACA5lJhm3WIjX7IM0SZK39RF4oSJuK0FKDieREO0Xw767+DvPjSqZc21jWf+SSPfSBY88eP10w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709887300; c=relaxed/simple;
	bh=kNO+vJ8sYUNufRYtszG1eobTNUFc3K/W3CZuPG5GR5A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=o0QXiTRlvtPSF4Arbfz2W8+5yY32cS8QAqCIdD69nqdtBqwPGdvPCE8NZDQL0gqpN1LTWWR/CBXI35tUjNTeESaF3PX5EFexrQouM/X0UBX+qKe0Xd4jv8ryPixxPeXjo54xkuga5gb3UTiSjvdgl3mbv8Pjhr1TvqI9zWcc9lM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=GYeAJgDR; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1709887296;
	bh=kNO+vJ8sYUNufRYtszG1eobTNUFc3K/W3CZuPG5GR5A=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=GYeAJgDRUl+YAm1bhqIwpML9GBTQZTluXVJd7rNZYWOFdBla8icE64WRxxIBtLv+d
	 VSAPhz2EojjofWKw15JrQhXR3gEEkrefHtzdEEEGOjWh38+ER4sQUnO+ZkpliqyzJy
	 Pe/4cXKdprikEYT2Gmqy+H0aNqrmOg/MxU/q3O02UDRlWlgtHzfj/9BwQNifM7PJj9
	 /rkrGozn6AMoa3RZdjL9fm/Z663mkHvvS6Nr/hY6Bcv4IyLhHPbVtWh//c6ye1Ckec
	 dGEaLAZ1RDyQd0rBeCj8GeaBrxAT7UPNunKeGtfysl3L18zGz4PbEGA761kdzK6brg
	 MRjPq+l3KRrlg==
Received: from [100.113.186.2] (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id C2EF937813CA;
	Fri,  8 Mar 2024 08:41:35 +0000 (UTC)
Message-ID: <ff708cd5-efe1-47e0-8112-ac7a2658cd8d@collabora.com>
Date: Fri, 8 Mar 2024 09:41:35 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/3] mips: dts: ralink: mt7621: associate uart1_pins
 with serial0
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
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20240307190408.23443-1-justin.swartz@risingedge.co.za>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 07/03/24 20:04, Justin Swartz ha scritto:
> Add missing pinctrl-name and pinctrl-0 properties to declare
> that the uart1_pins group is associated with serial0.
> 
> Signed-off-by: Justin Swartz <justin.swartz@risingedge.co.za>
> ---
>   arch/mips/boot/dts/ralink/mt7621.dtsi | 3 +++
>   1 file changed, 3 insertions(+)
> 
> diff --git a/arch/mips/boot/dts/ralink/mt7621.dtsi b/arch/mips/boot/dts/ralink/mt7621.dtsi
> index 35a10258f..dca415fdd 100644
> --- a/arch/mips/boot/dts/ralink/mt7621.dtsi
> +++ b/arch/mips/boot/dts/ralink/mt7621.dtsi
> @@ -123,6 +123,9 @@ serial0: serial@c00 {
>   			reg-shift = <2>;
>   			reg-io-width = <4>;
>   			no-loopback-test;
> +
> +			pinctrl-names = "default";
> +			pinctrl-0 = <&uart1_pins>;
>   		};
>   
>   		spi0: spi@b00 {

The pins are muxed and can be either UART, or some other function that
is supported by the mux: this means that the pinctrl-xxx properties shall
*not* go into the SoC dtsi file, but in board dts files instead.

Said differently: the usage of the UART pins is board-specific, not SoC-wide.

Regards,
Angelo

