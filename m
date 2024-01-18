Return-Path: <linux-kernel+bounces-30250-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A744B831C3C
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 16:21:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DAA391C22651
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 15:21:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CBD524B32;
	Thu, 18 Jan 2024 15:21:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kUsk2a8R"
Received: from mail-oo1-f51.google.com (mail-oo1-f51.google.com [209.85.161.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2CE81E520;
	Thu, 18 Jan 2024 15:21:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705591270; cv=none; b=TanGCXTYM+SUJL6v544ROMm1t2qGLIxXU2G9A/tb/N0dJAF63nXlYa30EzSzDvLgYsKRlejtAQxvTB6Oy1YpBhii7S55rQjNoRG0qEwS9fRqaJNlvlRMgH52OZYC0UFkzuglynUmJxJNyfduZKr/EGCs2FiaDgaFJIhGQ1V388g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705591270; c=relaxed/simple;
	bh=Q0uFvttzQM/xHVr4MGjxmmaHruyejoVLaVqpqT0uaag=;
	h=Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Google-Smtp-Source:X-Received:Received:
	 Message-ID:X-Google-Original-Message-ID:Date:From:To:Cc:Subject:
	 References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To; b=Tv4qGy1atsbsLH1ncxfiQ8LHKUT31oqv2iNaIzMkVb9sMd8w1mHOE1TI6Wz2/tvII++hIdE7XPPZHTWIR7HTkKJdg6cCi+yA9NyLhDLn1hvKPIwSPAR9kBzYLcVR+NwexSFgQuRPNjjifpJahAdYfweU9poxMVuQsJ/F2C+xAHQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kUsk2a8R; arc=none smtp.client-ip=209.85.161.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f51.google.com with SMTP id 006d021491bc7-598699c0f1eso5576460eaf.2;
        Thu, 18 Jan 2024 07:21:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705591268; x=1706196068; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=OxhHEuq4UoGKdyKSn2yl78F78p0BZYUw4RlptfBHAvk=;
        b=kUsk2a8RDT1YAP8m5T1T8iNxsWv+OLM2mGXah0rT6FP7wkLzx/a/M4i0SNZzctAUYe
         49hbXWgzvnIOdrx+ufsF1jSO0GkAoZQJfFHep6b6UKsZ5ZAEAOHJ2KpXoTjwSA08lYdr
         RmMyQ1JFaWRuin3b70vLzMCfmj7LdxP7OXXE0Jf4p4Bn7Id/k/UsrzLV6mF6qChkEnmT
         0rWwwysUMx645WDd6uXIZk1ITMAgEoj1s/0o9x0j6p012v2wiSiJDv6KYE1XdNWjMOPD
         crKtxQYTFVgHESQ2vdvI4jLYYbnygzmpBHQRsfvEmVtaZIrytulxwY7uXfQ/8T0m36nK
         zLSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705591268; x=1706196068;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OxhHEuq4UoGKdyKSn2yl78F78p0BZYUw4RlptfBHAvk=;
        b=IY6S3lwVptffGQQaG6C8NkBAiwiGzdW6Bf0cm9vAJy6HEwoul6XA3Iy7soZYIO1P4f
         qzbcKidcJ+JVVfqh4RQ5OzW3EGNQexItgb3gzGdvRAP8EWtCKGX/9SiSdoY+r0QuztNk
         PeJzNTPljM1qfdfx4Ry/1fjb8cRNNw8zHov3L8OEYJssYPni22IItXHsmU9hkscUCcBg
         mjfhLmR8gR+kZa9S5ynRtzHEB7CgH22XuEKnewgLQ3htDQjetKps+ZVXMitucfF+VM3s
         CtpM5/aKSEJPcSh0xGeNnyd2JUgS0qrkvPDX/pTMUS+f7ox5GFYWnI0VJnL5zxfpFeZv
         mb9A==
X-Gm-Message-State: AOJu0Ywjti83+Zz3+sjtevJu3miEv8MDOSxauGDkG3bUhIDPkBzxwAFD
	nn9C2NsN7qE0B6XCswaHfY8LB9lDMxx0uHrzUfUwzUdU1lydvKiU
X-Google-Smtp-Source: AGHT+IH2BMhuQTwBXDYh4UyL8nSz7XvomyAtA2Fr7aMNO58k/+nLRU4T0sdfg/HjRYFAFfIrnghpBw==
X-Received: by 2002:a4a:b149:0:b0:596:eb1:1014 with SMTP id e9-20020a4ab149000000b005960eb11014mr900095ooo.5.1705591267916;
        Thu, 18 Jan 2024 07:21:07 -0800 (PST)
Received: from neuromancer. ([75.28.21.198])
        by smtp.gmail.com with ESMTPSA id z11-20020a4a304b000000b005990c400db8sm1187106ooz.46.2024.01.18.07.21.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Jan 2024 07:21:07 -0800 (PST)
Message-ID: <65a941e3.4a0a0220.673cc.7147@mx.google.com>
X-Google-Original-Message-ID: <ZalB4pIwnLf/zz2I@neuromancer.>
Date: Thu, 18 Jan 2024 09:21:06 -0600
From: Chris Morgan <macroalpha82@gmail.com>
To: Conor Dooley <conor@kernel.org>
Cc: Tim Lunn <tim@feathertop.org>, linux-rockchip@lists.infradead.org,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	Chris Zhong <zyw@rock-chips.com>,
	Conor Dooley <conor+dt@kernel.org>,
	Heiko Stuebner <heiko@sntech.de>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Lee Jones <lee@kernel.org>, Rob Herring <robh+dt@kernel.org>,
	Zhang Qing <zhangqing@rock-chips.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/3] dt-bindings: rockchip: Document rk809 support for
 rk817 audio codec
References: <20240116132102.3272682-1-tim@feathertop.org>
 <20240116132102.3272682-2-tim@feathertop.org>
 <20240116-mangle-parish-93b5cd672d17@spud>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240116-mangle-parish-93b5cd672d17@spud>

On Tue, Jan 16, 2024 at 05:06:34PM +0000, Conor Dooley wrote:
> On Wed, Jan 17, 2024 at 12:21:00AM +1100, Tim Lunn wrote:
> > Rockchip RK809 shares the same audio codec as the rk817 mfd, it is also
> > using the same rk817_codec driver. However it is missing from the
> > bindings.
> > 
> > Update dt-binding documentation for rk809 to include the audio codec
> > properties. This fixes the following warning from dtb check:
> > 
> > pmic@20: '#sound-dai-cells', 'assigned-clock-parents', 'assigned-clocks',
> >    'clock-names', 'clocks', 'codec' do not match any of the regexes:
> >    'pinctrl-[0-9]+'
> > 
> > Signed-off-by: Tim Lunn <tim@feathertop.org>
> > ---
> > 
> > (no changes since v1)
> > 
> >  .../bindings/mfd/rockchip,rk809.yaml          | 30 ++++++++++++++++++-
> >  1 file changed, 29 insertions(+), 1 deletion(-)
> > 
> > diff --git a/Documentation/devicetree/bindings/mfd/rockchip,rk809.yaml b/Documentation/devicetree/bindings/mfd/rockchip,rk809.yaml
> > index 839c0521f1e5..bac2e751e2f2 100644
> > --- a/Documentation/devicetree/bindings/mfd/rockchip,rk809.yaml
> > +++ b/Documentation/devicetree/bindings/mfd/rockchip,rk809.yaml
> > @@ -12,7 +12,7 @@ maintainers:
> >  
> >  description: |
> >    Rockchip RK809 series PMIC. This device consists of an i2c controlled MFD
> > -  that includes regulators, an RTC, and power button.
> > +  that includes regulators, an RTC, a power button, and an audio codec.
> >  
> >  properties:
> >    compatible:
> > @@ -93,6 +93,34 @@ properties:
> >          unevaluatedProperties: false
> >      unevaluatedProperties: false
> >  
> > +  clocks:
> > +    description:
> > +      The input clock for the audio codec.
> > +
> > +  clock-names:
> > +    description:
> > +      The clock name for the codec clock.
> > +    items:
> > +      - const: mclk
> 
> You have one clock only, why do you need to have clock-names?
> 
> Otherwise,
> Acked-by: Conor Dooley <conor.dooley@microchip.com>
> 
> Cheers,
> Conor.

The codec driver currently looks for a clock named "mclk".

Thank you,
Chris.

> 
> > +
> > +  '#sound-dai-cells':
> > +    description:
> > +      Needed for the interpretation of sound dais.
> > +    const: 0
> > +
> > +  codec:
> > +    description: |
> > +      The child node for the codec to hold additional properties. If no
> > +      additional properties are required for the codec, this node can be
> > +      omitted.
> > +    type: object
> > +    additionalProperties: false
> > +    properties:
> > +      rockchip,mic-in-differential:
> > +        type: boolean
> > +        description:
> > +          Describes if the microphone uses differential mode.
> > +
> >  allOf:
> >    - if:
> >        properties:
> > -- 
> > 2.40.1
> > 



> _______________________________________________
> Linux-rockchip mailing list
> Linux-rockchip@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-rockchip


