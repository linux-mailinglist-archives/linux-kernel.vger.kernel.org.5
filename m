Return-Path: <linux-kernel+bounces-90438-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AB7CE86FF2B
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 11:36:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CE34D1C20FD7
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 10:36:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEBDD36B04;
	Mon,  4 Mar 2024 10:36:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="aZbOpFn2"
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2D62364C8
	for <linux-kernel@vger.kernel.org>; Mon,  4 Mar 2024 10:36:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709548604; cv=none; b=WfwIgEgvnfHww1x92V3e65Z8cShPXgIJQ1hOAywonyilOKnXiD13f9G8NsM8FSGOXQVDWIi1DEVNbGQcKKu5T2ejC6GpFdxnBd4m1qfZ0XsDORloYuQ5cDbetncBO1F65Bc/iMKLVVa5b/PcB7FyGHldxYlp7qaZ5fDJQmrLt50=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709548604; c=relaxed/simple;
	bh=UX5YF4W56ntd36mBIiVH2Uco8VkUW6EgvRqqGgklGZ0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hZRJ1buiNkDVsOeQsInLTFOWY7P6CGOFWOr4Kf8n1AgZ77b3JGE5j5Uv5huOHPQc0MsC0Vnra41volIUyJab7KPpCxo1GMMJC9Pt9C0uT0OtvIK1H33855HZWi7GOqJWTYigDNIN2gq4CTaGMcTlRX0e16HnuyTh7HFpTndkiHU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=aZbOpFn2; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-a4532f84144so108614666b.3
        for <linux-kernel@vger.kernel.org>; Mon, 04 Mar 2024 02:36:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1709548599; x=1710153399; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=PlGXNWGMo4pJQFRq+xZGyujsJmpDZaBsIZ2TP4Gpjps=;
        b=aZbOpFn28sRGtiCgiTLzPRkrdB+O0pF+NXhClMNzmT0VRol3ciNfXm/r2vRd5F/Dl4
         zdfQ2aju3sP05NyDVljz+Gr5HyW7DLi+15efNK1ael7B66+jcUR6guxbanN8SKJmMtb/
         pda+BM3JNgdbRbLtn9zBz2a6Tjwq794b4FqROIrSZlrbPvVd6E2et0/J3TPoZ43C36+7
         AXlGXEF6kR8AYOEGl375WZgoXyDj0TtdBO/ubdP+ZseRpVKNkdtDG6PtY8KO98eac6+g
         F+w5lpxxyhwBgxRZuXGTc0tqCESWUg+kSRQj+y75M6whpaREUyj4etCymkj8xCN/vVPP
         BCdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709548599; x=1710153399;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PlGXNWGMo4pJQFRq+xZGyujsJmpDZaBsIZ2TP4Gpjps=;
        b=TZfxLPF+s2S4OIvIdjAuhNbNb8473cNHee5XDBM+Jus4C15L9K0H5jFE/IFAGuOOIQ
         +Hqi2FhSbRxmVyr0lKOgNLaldrxg5En0gQVsqqWzar0SgvucvaFej+onyTT+Zi3lRISA
         XXMmN+9dyNeR5kc9dUTTCy4iR0CC5D38glpLZPGDIzku9ZQCMFfydGSLT2RnZNWXK+hI
         C4UBJxCOGj2Nyg2/VR5g0V8wcFZv8RN2u8/Inf0IqzxWu6v9Y5qfHH4dgae5TZS7aJTQ
         mrhRKT5j2HBBgN3vh/40IbSu00jqbzxNheMHBX5XrswoPQ8EIEGbI60DedxBHKh39kLW
         GAyA==
X-Forwarded-Encrypted: i=1; AJvYcCWqeiXBLODOlqEw0RBmTsgyh6YZYOP95TaxiWxbaSFlkZWBe2oWeobaIxerxWy2UkGsSuiS1VJl89ydLR5QcmQhcWr5EpqQ2qB99W81
X-Gm-Message-State: AOJu0YxK0C7XZwubTekWcy98NcDdLzW7Kyxo6tIuc+Le4XD9mkJrsRA3
	Za4BdZriB1rLoGYZqJM3RJjjWg9pALdm48SdrzcYDMeXWHQmAjdR3/Mh2VOW0Gml8Wtpryw5CN7
	6
X-Google-Smtp-Source: AGHT+IH8N0rqvwBU5ivIjiPim0o/6SLIPNFeS88SV7TISdMdIW6DxXfuObmFcFTYe3ST96SGzp12YA==
X-Received: by 2002:a17:906:e0c:b0:a45:817f:fd85 with SMTP id l12-20020a1709060e0c00b00a45817ffd85mr262396eji.48.1709548599000;
        Mon, 04 Mar 2024 02:36:39 -0800 (PST)
Received: from blmsp ([2001:4091:a246:821e:6f3b:6b50:4762:8343])
        by smtp.gmail.com with ESMTPSA id ao17-20020a170907359100b00a4581ea674esm137554ejc.223.2024.03.04.02.36.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Mar 2024 02:36:38 -0800 (PST)
Date: Mon, 4 Mar 2024 11:36:37 +0100
From: Markus Schneider-Pargmann <msp@baylibre.com>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Rob Herring <robh@kernel.org>, Nishanth Menon <nm@ti.com>, 
	Vignesh Raghavendra <vigneshr@ti.com>, Tero Kristo <kristo@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, Santosh Shilimkar <ssantosh@kernel.org>, 
	Andrew Davis <afd@ti.com>, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/4] dt-bindings: hwinfo: ti,k3-socinfo: Add nvmem-cells
Message-ID: <ut63wrhsewkpfdgaatd6hqmj5upvyamjhf2rsecju2v2o3hdod@kyi5sezcggl7>
References: <20240206143711.2410135-1-msp@baylibre.com>
 <20240206143711.2410135-3-msp@baylibre.com>
 <20240206184305.GA1875492-robh@kernel.org>
 <z56fiu2jpokp57sjvnrdcbfy7brpq2ag4yxpektqlhtidecx4n@vc7dsurhxorb>
 <cb75c098-521e-4eed-bc3e-7237f8a6498f@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cb75c098-521e-4eed-bc3e-7237f8a6498f@linaro.org>

Hi,

On Sat, Feb 17, 2024 at 03:25:30PM +0100, Krzysztof Kozlowski wrote:
> On 14/02/2024 10:31, Markus Schneider-Pargmann wrote:
> > Hi Rob,
> > 
> > On Tue, Feb 06, 2024 at 06:43:05PM +0000, Rob Herring wrote:
> >> On Tue, Feb 06, 2024 at 03:37:09PM +0100, Markus Schneider-Pargmann wrote:
> >>> The information k3-socinfo requires is stored in an efuse area. This
> >>> area is required by other devices/drivers as well, so using nvmem-cells
> >>> can be a cleaner way to describe which information are used.
> >>>
> >>> If nvmem-cells are supplied, the address range is not required.
> >>> Cells chipvariant, chippartno and chipmanufacturer are introduced to
> >>> cover all required information.
> >>>
> >>> Signed-off-by: Markus Schneider-Pargmann <msp@baylibre.com>
> >>> Reviewed-by: Andrew Davis <afd@ti.com>
> >>> ---
> >>>  .../bindings/hwinfo/ti,k3-socinfo.yaml        | 23 ++++++++++++++++++-
> >>>  1 file changed, 22 insertions(+), 1 deletion(-)
> >>>
> >>> diff --git a/Documentation/devicetree/bindings/hwinfo/ti,k3-socinfo.yaml b/Documentation/devicetree/bindings/hwinfo/ti,k3-socinfo.yaml
> >>> index dada28b47ea0..f085b7275b7d 100644
> >>> --- a/Documentation/devicetree/bindings/hwinfo/ti,k3-socinfo.yaml
> >>> +++ b/Documentation/devicetree/bindings/hwinfo/ti,k3-socinfo.yaml
> >>> @@ -26,9 +26,24 @@ properties:
> >>>    reg:
> >>>      maxItems: 1
> >>>  
> >>> +  nvmem-cells:
> >>> +    $ref: /schemas/types.yaml#/definitions/phandle-array
> >>> +
> >>> +  nvmem-cell-names:
> >>> +    items:
> >>> +      - const: chipvariant
> >>> +      - const: chippartno
> >>> +      - const: chipmanufacturer
> >>> +
> >>>  required:
> >>>    - compatible
> >>> -  - reg
> >>> +
> >>> +oneOf:
> >>> +  - required:
> >>> +      - reg
> >>> +  - required:
> >>> +      - nvmem-cells
> >>> +      - nvmem-cell-names
> >>>  
> >>>  additionalProperties: false
> >>>  
> >>> @@ -38,3 +53,9 @@ examples:
> >>>          compatible = "ti,am654-chipid";
> >>>          reg = <0x43000014 0x4>;
> >>>      };
> >>> +  - |
> >>> +    chipid: chipid@14 {
> >>> +        compatible = "ti,am654-chipid";
> >>
> >> This isn't compatible if you have a completely different way to access 
> >> it. 
> > 
> > Thanks, it is not entirely clear to me how I could go forward with this?
> > Are you suggesting to use a different compatible? Or is it something
> > else I could do to proceed with this conversion?
> 
> What you claim now, is that you have one device with entirely different
> interfaces and programming model. So either this is not the same device
> or you just wrote bindings to whatever you have in driver.
> 
> Nothing in commit msg explains this.
> 
> What you should do? Depends. If you just write bindings for driver, then
> stop. It's a NAK. Instead write bindings for hardware.
> 
> If the first choice, just the hardware is somehow like this, then
> explain in commit msg and device description, how this device can be
> connected over other bus, not MMIO. You can draw some schematics in
> commit msg explaining architecture etc.

Sorry the information provided in the commit message is not very clear.

The basic access to the registes is still MMIO. nvmem is used to have a
better abstraction and cleaner description of the hardware.

Currently most of the data is exported using the parent syscon device.
The relevant data is read-only and contained in a single register with
offset 0x14:
  - Chip variant
  - Chip part number
  - Chip manufacturer

There are more read-only registers in this section of address space.
These are relevant to other components as they define the operating
points for example. For the OPP table relevant are chip variant and chip
speed (which is in a different register).

Instead of devices refering to this whole register range of 0x20000 in
size, I would like to introduce this nvmem abstraction in between that
describes the information and can directly be referenced by the devices
that depend on it. In this case the above mentioned register with offset
0x14 is instead described as nvmem-layout like this:

	nvmem-layout {
		compatible = "fixed-layout";
		#address-cells = <1>;
		#size-cells = <1>;

		chip_manufacturer: jtagidmfg@14 {
			reg = <0x14 0x2>;
			bits = <1 11>;
		};

		chip_partno: jtagidpartno@15 {
			reg = <0x15 0x3>;
			bits = <4 16>;
		};

		chip_variant: jtagidvariant@17 {
			reg = <0x17 0x1>;
			bits = <4 4>;
		};

		chip_speed: jtaguseridspeed@18 {
			reg = <0x18 0x4>;
			bits = <6 5>;
		};

The underlying registers are still the same but they are not hidden
by the syscon phandles anymore.

The device that consumes this data would now use

	nvmem-cells = <&chip_variant>, <&chip_speed>;
	nvmem-cell-names = "chipvariant", "chipspeed";

instead of

	syscon = <&wkup_conf>;

Best,
Markus

