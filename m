Return-Path: <linux-kernel+bounces-133281-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EA30689A1AE
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 17:45:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 196231C2378F
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 15:45:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A75F416EC0B;
	Fri,  5 Apr 2024 15:45:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZiX5QSqJ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCD7017BA0;
	Fri,  5 Apr 2024 15:45:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712331946; cv=none; b=ksO/9g6TWZ0qNaeXsg3YaMhtaq0N6P5thaxsmdKaClW0tZedVwATgJ4QZaGamLzOeqk8DzaRsR5xw/zrlGIW3wj3qUuuek67ba7uCHZlPFB/kQKo3blxi6IUpkRqbbOhFI3jXC2chIn3zmom4Z7T85CitBAk/FGyqpFnwZjSnJY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712331946; c=relaxed/simple;
	bh=qBnmNSTIQGGq5p7KWZLcDobYUZB2qgjqJ13DpGAaklE=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=b6WCxMfmeOrmXGzA1fLO4TblgWnP79PqVZvp24sCOZxZqzPZay7NLmhPSVvjJNbWN8CggHAmVcRX58z+m0nyyYzKrAveI/PNlmrwuqV8KpIBaGst7BbPaQtHORFrXjMG7FC244OEaMODTGWsQYIL/CDTb2FMIIt8GKIJS0rwAP4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZiX5QSqJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A44DC433C7;
	Fri,  5 Apr 2024 15:45:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712331946;
	bh=qBnmNSTIQGGq5p7KWZLcDobYUZB2qgjqJ13DpGAaklE=;
	h=Date:Subject:To:References:From:In-Reply-To:From;
	b=ZiX5QSqJd6Aqfzn9U3U3ZsRiUZqWpR2NlaW4g5wb+O79AjLkO0oe29EHplaeibh5H
	 +CjvvaKxlGC+i70BJYr6Wryn+VIKcnTNdOTkGteqokfR1OV3unC65E4MMELUw/wt5p
	 snEB1pe/DlMM2n/qD9fHJRo/ixWa1FYFUBlOt76PlGKoGW6oxr0IMakWA/h2volPd4
	 42tMyjCB0Qjh2+nWH+DzPtjYKWgXzkQfOhdloXM7AdT6QiVBD+2k2dUK+oVuniMpY7
	 Lx9ZVGeL89nppNQfX3JOteRrEZ/qC3bw1Q9SS3i1jF1g4PwrGafZ+jW3wnOV6GoPvN
	 LRkUyHvwa28HQ==
Message-ID: <e3723943-f6af-4a1d-81c7-3f4e890493ec@kernel.org>
Date: Fri, 5 Apr 2024 17:45:41 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFT 09/10] arm64: dts: microchip: sparx5_pcb134: drop
 duplicated NOR flash
To: Steen Hegelund <steen.hegelund@microchip.com>,
 Conor Dooley <conor@kernel.org>, Nicolas Ferre
 <nicolas.ferre@microchip.com>, Claudiu Beznea <claudiu.beznea@tuxon.dev>,
 Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Lars Povlsen <lars.povlsen@microchip.com>,
 Daniel Machon <daniel.machon@microchip.com>, UNGLinuxDriver@microchip.com,
 "David S. Miller" <davem@davemloft.net>,
 Bjarni Jonasson <bjarni.jonasson@microchip.com>,
 linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240401153740.123978-1-krzk@kernel.org>
 <20240401153740.123978-9-krzk@kernel.org>
 <67f29fa86207a68b148b826b71b1349d3552453d.camel@microchip.com>
Content-Language: en-US
From: Krzysztof Kozlowski <krzk@kernel.org>
Autocrypt: addr=krzk@kernel.org; keydata=
 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 fv0=
In-Reply-To: <67f29fa86207a68b148b826b71b1349d3552453d.camel@microchip.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 05/04/2024 14:10, Steen Hegelund wrote:
> Hi Krzysztof,
> 
> On Mon, 2024-04-01 at 17:37 +0200, Krzysztof Kozlowski wrote:
>> EXTERNAL EMAIL: Do not click links or open attachments unless you know the content is safe
>>
>> Since beginning the DTS extended the SPI0 in two places adding two SPI
>> muxes, each with same SPI NOR flash.  Both used exactly the same
>> chip-selects, so this was clearly buggy code.  Without checking in
>> datasheet, assume device has only one SPI NOR flash, so code was
>> duplicated.
>>
>> Fixes dtc W=1 warnings:
>>
>>   sparx5_pcb134_board.dtsi:277.10-281.4: Warning (unique_unit_address_if_enabled):
>> /axi@600000000/spi@600104000/flash@0: duplicate unit-address (also used in node
>> /axi@600000000/spi@600104000/spi@0)
>>
>> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
>>
>> ---
>>
>> Not tested on hardware
>> ---
>>  .../boot/dts/microchip/sparx5_pcb134_board.dtsi  | 16 ----------------
>>  1 file changed, 16 deletions(-)
>>
>> diff --git a/arch/arm64/boot/dts/microchip/sparx5_pcb134_board.dtsi
>> b/arch/arm64/boot/dts/microchip/sparx5_pcb134_board.dtsi
>> index f165a409bc1d..dc7b59dfcb40 100644
>> --- a/arch/arm64/boot/dts/microchip/sparx5_pcb134_board.dtsi
>> +++ b/arch/arm64/boot/dts/microchip/sparx5_pcb134_board.dtsi
>> @@ -281,22 +281,6 @@ flash@0 {
>>         };
>>  };
>>
>> -&spi0 {
>> -       status = "okay";
>> -       spi@0 {
>> -               compatible = "spi-mux";
>> -               mux-controls = <&mux>;
>> -               #address-cells = <1>;
>> -               #size-cells = <0>;
>> -               reg = <0>;      /* CS0 */
>> -               flash@9 {
>> -                       compatible = "jedec,spi-nor";
>> -                       spi-max-frequency = <8000000>;
>> -                       reg = <0x9>;    /* SPI */
>> -               };
>> -       };
>> -};
>> -
> 
> When testing this on actual HW the SPI NOR is no longer accessible.
> The reason is that it sits behind a SPI-MUX and that needs to be present in the Device Tree.
> 
> So if you do the "reverse" clean-up it works fine: Remove the simple spi0 node and keep the one that
> has the spi-mux reference.

Aaaa, so we need to do it that way. Thanks for testing! I'll send v2.

Best regards,
Krzysztof


