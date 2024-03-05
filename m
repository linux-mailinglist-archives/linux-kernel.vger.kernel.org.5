Return-Path: <linux-kernel+bounces-92236-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FAE9871D34
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 12:17:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 75A35B231FF
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 11:17:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6DDB548FF;
	Tue,  5 Mar 2024 11:17:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="1k3VDPOt"
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B889C5786A
	for <linux-kernel@vger.kernel.org>; Tue,  5 Mar 2024 11:17:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709637445; cv=none; b=IAPGcvL6DmulwsvVu8oKzIGUQOaxKxfGlxZ0UlJc8GlEp2erWOkk/uMufJt52V1cOosnpR3nQm8Ng6OO9MFkJ9gkKvQ9rnJCmCKVlnANlo015/MdnelR/X1wGBYCvgimMkYM8fCe5kfYtJtmQ9r4PoSRgSMzxM9rbJBfO45R5Eg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709637445; c=relaxed/simple;
	bh=ag16qgtV0b3r73sf9dBSndiHcOqr5fxKPRVdAlFbtIs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MZbpVRlKOMCINlS83K09BtktdntZZ8zz0sj+BDpuKfEyxhbQDFFhikeg5R6M36m/4B1xjjQJCPD4isl1w1CznBveyzlxoYAGZSvpuNbdsssxnt9kazYN+fk1G7Yv603w2kWvkectr4W2FXGZxr2uOm6IKoUh4fhL+DPtbdupWno=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=1k3VDPOt; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-51321e71673so6369953e87.2
        for <linux-kernel@vger.kernel.org>; Tue, 05 Mar 2024 03:17:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1709637441; x=1710242241; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=j2ULHLhroOyDBrYbmargHZ3lXfCo0OB1feNvDkZhuNg=;
        b=1k3VDPOtpZ6Qzv9F8C27gggRpsMaNSD62wBNyEKAsf8gw7aVpKzo+gYokaAlBCpDbo
         5e48kE413hmuZVyQzVUPF0zpCejArn+AI/HJ1fbgmjCpI+qksh8i8/t70qpxezaHScHO
         MYm5F/f8ULb/0ch0itZC6xXOJXeCcA4pAFcXK8H2UFbkrR7eQliPNERq4FaaF3SPd6X+
         U3F5HaRgzCcOsRwxtCdzSa0BLriHn04CrbN3RQsfoR4s2s0h1o6K7CbJjxyq7m8x2LNV
         13LDdD0WG5r2dWj64EiaSjstQoAU56JJ+VpjUtJx7TkwWBe6Y/HQ7sY5mUEekpvDZ1lc
         yl6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709637441; x=1710242241;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=j2ULHLhroOyDBrYbmargHZ3lXfCo0OB1feNvDkZhuNg=;
        b=MQELw11YBGkKKfElAsVvkP6K2CT49rGsWAAssmYS8joTXVMLuu/+/ZlO/xPS3DnVZ/
         9TnnLAVInkD0SLpIhU1g6nUkOqYU5AwobR/X5w3uGaW3k1DFX/pf+/mjTdCthVpxgQ+V
         Rx78QjDddhoSdr1Oe4aWpd6mWIwkgYOxcTiHLLLdrbTqcUTLY/KVGX4txvBxBEWo5tjb
         LTJuIIQXm8/jOZlmcDSCJ+Q3JNV65g0EEY0qN1QGzPHraSIifG31Mea1hzrd7pj62G+H
         oQc+pcf8GgYrRAhR04DyIxOGYzhWJbiGcU8PW7Okyij7bJW4P51RNv+SZYBYyZENj9Az
         uIUw==
X-Forwarded-Encrypted: i=1; AJvYcCUXVy0J29hXW3uNyWsa+oPXrAapa5hCjebn0x/nK5G6V2nazMvPAL765hYloghogXH445T/pdF0XixN2AKPn4WMHejhweB02j01C83K
X-Gm-Message-State: AOJu0YxUCQM2d9LLyZpxomyWfj2G/KAcjh2uestMSXsNi7LiABWs9+hv
	faVcoQOPnZoFD1nRPcLGv8I8wlQc+c5mB3jjWVDj8YstukH/UbNeAmAWRsdDVRw=
X-Google-Smtp-Source: AGHT+IHCfdanPuTNNxlu2M0jKSAisxwUOSu72YtEDH8PxdOjlG67vui+HF5ei4BhpYu0Mex9c5cPrg==
X-Received: by 2002:a05:6512:b8c:b0:513:2102:7afe with SMTP id b12-20020a0565120b8c00b0051321027afemr1333821lfv.7.1709637440593;
        Tue, 05 Mar 2024 03:17:20 -0800 (PST)
Received: from blmsp ([2001:4091:a246:821e:6f3b:6b50:4762:8343])
        by smtp.gmail.com with ESMTPSA id pw20-20020a17090720b400b00a450164cec6sm3223199ejb.194.2024.03.05.03.17.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Mar 2024 03:17:20 -0800 (PST)
Date: Tue, 5 Mar 2024 12:17:19 +0100
From: Markus Schneider-Pargmann <msp@baylibre.com>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Rob Herring <robh@kernel.org>, Nishanth Menon <nm@ti.com>, 
	Vignesh Raghavendra <vigneshr@ti.com>, Tero Kristo <kristo@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, Santosh Shilimkar <ssantosh@kernel.org>, 
	Andrew Davis <afd@ti.com>, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/4] dt-bindings: hwinfo: ti,k3-socinfo: Add nvmem-cells
Message-ID: <sowpixx2u4d5alj4udzr3qt47zevylukhpwkw3pfwnogqjse5w@xrxcozzvog6v>
References: <20240206143711.2410135-1-msp@baylibre.com>
 <20240206143711.2410135-3-msp@baylibre.com>
 <20240206184305.GA1875492-robh@kernel.org>
 <z56fiu2jpokp57sjvnrdcbfy7brpq2ag4yxpektqlhtidecx4n@vc7dsurhxorb>
 <cb75c098-521e-4eed-bc3e-7237f8a6498f@linaro.org>
 <ut63wrhsewkpfdgaatd6hqmj5upvyamjhf2rsecju2v2o3hdod@kyi5sezcggl7>
 <48902771-5d3b-448a-8a74-ac18fb4f1a86@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <48902771-5d3b-448a-8a74-ac18fb4f1a86@linaro.org>

Hi Krzysztof,

On Tue, Mar 05, 2024 at 08:43:03AM +0100, Krzysztof Kozlowski wrote:
> On 04/03/2024 11:36, Markus Schneider-Pargmann wrote:
> > Hi,
> > 
> > On Sat, Feb 17, 2024 at 03:25:30PM +0100, Krzysztof Kozlowski wrote:
> >> On 14/02/2024 10:31, Markus Schneider-Pargmann wrote:
> >>> Hi Rob,
> >>>
> >>> On Tue, Feb 06, 2024 at 06:43:05PM +0000, Rob Herring wrote:
> >>>> On Tue, Feb 06, 2024 at 03:37:09PM +0100, Markus Schneider-Pargmann wrote:
> >>>>> The information k3-socinfo requires is stored in an efuse area. This
> >>>>> area is required by other devices/drivers as well, so using nvmem-cells
> >>>>> can be a cleaner way to describe which information are used.
> >>>>>
> >>>>> If nvmem-cells are supplied, the address range is not required.
> >>>>> Cells chipvariant, chippartno and chipmanufacturer are introduced to
> >>>>> cover all required information.
> >>>>>
> >>>>> Signed-off-by: Markus Schneider-Pargmann <msp@baylibre.com>
> >>>>> Reviewed-by: Andrew Davis <afd@ti.com>
> >>>>> ---
> >>>>>  .../bindings/hwinfo/ti,k3-socinfo.yaml        | 23 ++++++++++++++++++-
> >>>>>  1 file changed, 22 insertions(+), 1 deletion(-)
> >>>>>
> >>>>> diff --git a/Documentation/devicetree/bindings/hwinfo/ti,k3-socinfo.yaml b/Documentation/devicetree/bindings/hwinfo/ti,k3-socinfo.yaml
> >>>>> index dada28b47ea0..f085b7275b7d 100644
> >>>>> --- a/Documentation/devicetree/bindings/hwinfo/ti,k3-socinfo.yaml
> >>>>> +++ b/Documentation/devicetree/bindings/hwinfo/ti,k3-socinfo.yaml
> >>>>> @@ -26,9 +26,24 @@ properties:
> >>>>>    reg:
> >>>>>      maxItems: 1
> >>>>>  
> >>>>> +  nvmem-cells:
> >>>>> +    $ref: /schemas/types.yaml#/definitions/phandle-array
> >>>>> +
> >>>>> +  nvmem-cell-names:
> >>>>> +    items:
> >>>>> +      - const: chipvariant
> >>>>> +      - const: chippartno
> >>>>> +      - const: chipmanufacturer
> >>>>> +
> >>>>>  required:
> >>>>>    - compatible
> >>>>> -  - reg
> >>>>> +
> >>>>> +oneOf:
> >>>>> +  - required:
> >>>>> +      - reg
> >>>>> +  - required:
> >>>>> +      - nvmem-cells
> >>>>> +      - nvmem-cell-names
> >>>>>  
> >>>>>  additionalProperties: false
> >>>>>  
> >>>>> @@ -38,3 +53,9 @@ examples:
> >>>>>          compatible = "ti,am654-chipid";
> >>>>>          reg = <0x43000014 0x4>;
> >>>>>      };
> >>>>> +  - |
> >>>>> +    chipid: chipid@14 {
> >>>>> +        compatible = "ti,am654-chipid";
> >>>>
> >>>> This isn't compatible if you have a completely different way to access 
> >>>> it. 
> >>>
> >>> Thanks, it is not entirely clear to me how I could go forward with this?
> >>> Are you suggesting to use a different compatible? Or is it something
> >>> else I could do to proceed with this conversion?
> >>
> >> What you claim now, is that you have one device with entirely different
> >> interfaces and programming model. So either this is not the same device
> >> or you just wrote bindings to whatever you have in driver.
> >>
> >> Nothing in commit msg explains this.
> >>
> >> What you should do? Depends. If you just write bindings for driver, then
> >> stop. It's a NAK. Instead write bindings for hardware.
> >>
> >> If the first choice, just the hardware is somehow like this, then
> >> explain in commit msg and device description, how this device can be
> >> connected over other bus, not MMIO. You can draw some schematics in
> >> commit msg explaining architecture etc.
> > 
> > Sorry the information provided in the commit message is not very clear.
> > 
> > The basic access to the registes is still MMIO. nvmem is used to have a
> > better abstraction and cleaner description of the hardware.
> > 
> > Currently most of the data is exported using the parent syscon device.
> > The relevant data is read-only and contained in a single register with
> > offset 0x14:
> >   - Chip variant
> >   - Chip part number
> >   - Chip manufacturer
> > 
> > There are more read-only registers in this section of address space.
> > These are relevant to other components as they define the operating
> > points for example. For the OPP table relevant are chip variant and chip
> > speed (which is in a different register).
> > 
> > Instead of devices refering to this whole register range of 0x20000 in
> 
> Whaaaaat?
> 
> > size, I would like to introduce this nvmem abstraction in between that
> > describes the information and can directly be referenced by the devices
> > that depend on it. In this case the above mentioned register with offset
> > 0x14 is instead described as nvmem-layout like this:
> > 
> > 	nvmem-layout {
> > 		compatible = "fixed-layout";
> > 		#address-cells = <1>;
> > 		#size-cells = <1>;
> > 
> > 		chip_manufacturer: jtagidmfg@14 {
> > 			reg = <0x14 0x2>;
> > 			bits = <1 11>;
> > 		};
> > 
> > 		chip_partno: jtagidpartno@15 {
> > 			reg = <0x15 0x3>;
> > 			bits = <4 16>;
> > 		};
> > 
> > 		chip_variant: jtagidvariant@17 {
> > 			reg = <0x17 0x1>;
> > 			bits = <4 4>;
> > 		};
> > 
> > 		chip_speed: jtaguseridspeed@18 {
> > 			reg = <0x18 0x4>;
> > 			bits = <6 5>;
> > 		};
> > 
> > The underlying registers are still the same but they are not hidden
> > by the syscon phandles anymore.
> > 
> > The device that consumes this data would now use
> > 
> > 	nvmem-cells = <&chip_variant>, <&chip_speed>;
> > 	nvmem-cell-names = "chipvariant", "chipspeed";
> > 
> > instead of
> > 
> > 	syscon = <&wkup_conf>;
> 
> syscon allows you this as well - via phandle arguments.
> 
> nvmem is for non-volatile memory, like OCOTP and eFUSE. This is not for
> accessing regular MMIO registers of system-controller, regardless
> whether they are read-only or not (regmap handles this nicely, BTW).
> Although probably Apple efuses and few others can confuse here. It still
> looks like you convert regular system-controller block into nvmem,
> because you prefer that Linux driver abstraction...

The above mentioned data is set in the factory. There is other
non-volatile data, like device feature registers, in the same address
region, as well as OTP data like MAC and USB IDs. But it is not a pure
non-volatile memory region. The data is copied into these registers by
the ROM at boot.

Best,
Markus

