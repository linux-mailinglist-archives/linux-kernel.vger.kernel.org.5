Return-Path: <linux-kernel+bounces-96966-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CDB08763E9
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 13:01:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0089A1F21A64
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 12:01:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19AB25645C;
	Fri,  8 Mar 2024 12:01:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arinc9.com header.i=@arinc9.com header.b="RqQcen2r"
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5601C56471;
	Fri,  8 Mar 2024 12:01:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709899276; cv=none; b=aaOavy84v2//TM/BDbZ2lAi0SgR/+iYQrI2+LFBPEO6mLn3BdfySGuWN/2+XHvkppdt5PH4x4e74oxqtUGxSehDAN2+cAiiiQ/Et10TeRlQlJvS7lwsPvum/wZW760Rv1fpfqNYvZxKKkusMmOacJRZ+V0R3BpDFP5xV1EqMjOo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709899276; c=relaxed/simple;
	bh=V7A96oraRe9YWxYqcMUNe5v9rhQHsYIqyuX4fkycyss=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XCtFriYzH14Wvrojs7FqKHY9VwvSA/fxoR8N+RzHAgctJE/MnWcfR9UGDS9vGEh1E/DGBRLOeyWqZjwqSynzDYRJ32yLLRnKd0pkEzCWGVfMXuJ9cER/hQkDGSFMWNoOCl9ZcyUNd/tJkqk8mdNNP5OvEgWhkhuefoUNzRNwtzY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arinc9.com; spf=pass smtp.mailfrom=arinc9.com; dkim=pass (2048-bit key) header.d=arinc9.com header.i=@arinc9.com header.b=RqQcen2r; arc=none smtp.client-ip=217.70.183.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arinc9.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arinc9.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id EFDF7240003;
	Fri,  8 Mar 2024 12:01:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arinc9.com; s=gm1;
	t=1709899271;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GQFLpfmyEqeXPKgqckeD2rd+DY5hIF5n/f8YwLuQ74w=;
	b=RqQcen2rU6DljnjLVlUeNiNNuf9fm3lZOkjI55/yyHCmvShczq9vN3ZJ14+nSt8BMKYGO1
	wKRlLOr/UwG6pcKGVVXYtqKBKJL9hj7nmvuYeniwqbILC6NzGJ1m/UFSYqIYNIXkKn6BXk
	p/pwpdcOoNLZVpShHlBCBJRqXD4FDL98f54Zo5C8rADOrLZFa59wIpTeLsg6UluaoRE9VB
	uUGZzD/WTi5GYch6f73VKRaOFHdopxNAzh4Y75Z+2Eb1DqHjlsOiIes9VJQuKdibJg2kV0
	xpBWX+oGOy72hio8Eq00BRTwk7XUkBj3lNL7XoDx7eSPyNtapfA5++IhfvhNEQ==
Message-ID: <c445fd12-f8a8-41df-bee8-8b126b26110b@arinc9.com>
Date: Fri, 8 Mar 2024 15:01:00 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] mips: dts: ralink: mt7621: add cell count properties
 to usb
Content-Language: en-US
To: Justin Swartz <justin.swartz@risingedge.co.za>,
 Sergio Paracuellos <sergio.paracuellos@gmail.com>,
 Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
 Matthias Brugger <matthias.bgg@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: linux-mips@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org
References: <0001-mips-dts-ralink-mt7621-add-cell-count-properties-to-.patch>
 <20240307223756.31643-1-justin.swartz@risingedge.co.za>
From: =?UTF-8?B?QXLEsW7DpyDDnE5BTA==?= <arinc.unal@arinc9.com>
In-Reply-To: <20240307223756.31643-1-justin.swartz@risingedge.co.za>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Flag: yes
X-Spam-Level: **************************
X-GND-Spam-Score: 400
X-GND-Status: SPAM
X-GND-Sasl: arinc.unal@arinc9.com

On 8.03.2024 01:37, Justin Swartz wrote:
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
> -- Documentation/devicetree/bindings/usb/usb-device.yaml
> 
> This version of the patch places the properties according to
> the order recommended by:
> 
>     Documentation/devicetree/bindings/dts-coding-style.rst
> 
> Signed-off-by: Justin Swartz <justin.swartz@risingedge.co.za>
> ---
>   arch/mips/boot/dts/ralink/mt7621.dtsi | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/mips/boot/dts/ralink/mt7621.dtsi b/arch/mips/boot/dts/ralink/mt7621.dtsi
> index 5a89f0b8c..7532e17dd 100644
> --- a/arch/mips/boot/dts/ralink/mt7621.dtsi
> +++ b/arch/mips/boot/dts/ralink/mt7621.dtsi
> @@ -289,10 +289,10 @@ usb: usb@1e1c0000 {
>   		reg = <0x1e1c0000 0x1000
>   		       0x1e1d0700 0x0100>;
>   		reg-names = "mac", "ippc";
> -
> +		#address-cells = <1>;
> +		#size-cells = <0>;
>   		clocks = <&sysc MT7621_CLK_XTAL>;
>   		clock-names = "sys_ck";
> -

Please keep the empty lines. It's easier to read. I don't see anything on
the Devicetree Sources (DTS) Coding Style that would restrict this.

Arınç

