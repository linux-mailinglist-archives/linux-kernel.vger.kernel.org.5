Return-Path: <linux-kernel+bounces-75957-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 566AE85F123
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 06:52:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D7BF11F244C7
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 05:52:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7696B1426C;
	Thu, 22 Feb 2024 05:52:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QBdSbnGQ"
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08D2810A12;
	Thu, 22 Feb 2024 05:52:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708581160; cv=none; b=nR/9k6f+3usFlSJdfnW0cwlKANGRkDp5hY5ib1tc9wgC8kOqdAUEiCyz+HmJ4xkWWdP6LGzeRlvPCsEE8kZ5JdFUg7f5ePd+8mmBQBHHcFkUTRGSFv1xj3vknwt8iEUy6frnGj5n4rhK1WRXB5V4p3VPdW8puJ9DFsORAgfycY4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708581160; c=relaxed/simple;
	bh=FmpeXwY298dFTsBLYLuwofqCqU5dk5P0Wqy+OQi80qs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dNQPpjYfQfJHiYBNT3ZmVFGEqQZSysDjp7H2YXyO/w+dsU+LW9rg3Lu+5plTb/llZR5hKU6USTucJ479lKOW9bRsWqCNZuiVhL/cGpd2MTmqtt4Eql/AHsHqEsjUfYTwc07T7Y3mLGBgQh8E4SLZ8gw72aa2QU4qbQnQVL9OoH4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QBdSbnGQ; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-5129cdae3c6so1734569e87.1;
        Wed, 21 Feb 2024 21:52:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708581157; x=1709185957; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sXA7lyFstanngNGr2/M9csPhL2B/gz+98wMPcW+AEzc=;
        b=QBdSbnGQNYtJulCicxMIg/EqS/Gu8sEJzuX1DFfCFE8l5HxnTW9VbUg9b7v82qD0nT
         VYFIXV796gv/IZ1dLXrSWK5lihtutTQZ8AEAlv/zqPLDokFvhHcqjylYtUHegXNs4Ks5
         l3b6tvwLoGY3R96VrKJTIKqnDS1kA9FF8e7u3CbiQrkjQ5tZnAK6ONtYw2bprqzRWRvP
         SRUXFlzfxBiEj3PI0dFdhUBn0bp3GyBM3pdry2BuioOcjCHfW71FegHtCWrw637JTO7E
         prT0GWnEuPfh0yY/0ZSwkMljmu4Nz/vkuKwT9kzuZxk3o6/ftUNcZ4kMA7CkiCymAW7K
         mLig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708581157; x=1709185957;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sXA7lyFstanngNGr2/M9csPhL2B/gz+98wMPcW+AEzc=;
        b=Rzpg/fklhteVYhopQ23+6ap0fa4jjzmFAEvnojXJnM8qOTrH3282XX2gGDhlJWOeui
         ek0UI2QpcJwPpADpjQNrj3SuvWzQrYHw4q9D+0FO8tg2Bz0n2koRyR083b+1bMBJklj6
         l/UuCneNmn/0D2mIHwQ8b+jnM6WyvM1PjvkVc3K2HuvFcsieade3HrjeL1zqwo0KVNqT
         TxtOGHNo+tYCeIWzs1Ym/JF/TqlddOzCEDCsE74nXDvynIXaKn1xOJVMpW7CZ1g/7DfB
         DCnNYgie91rQleda6Ocs2PLQkXT0jbOmZdwoA2ihiISaJXnMqQcpL+nK+kU1eN1G11+Z
         53oA==
X-Forwarded-Encrypted: i=1; AJvYcCUH8LRfLmkI0EdY8tOf6PICWVwwbiVRMCJd2PwrrIKghTqhjR0RxnV/EmnVKC94y9yNR1Kd/3cO/YreuKmqNBBXAxyEX3Kxtg0EHD/X/kPizWJQCJwXOw8/tNSKmaSCUIscFI0vz3puaEXwXMKZLiwYMtNxgCkaLHdqyfY3D02LwGHbII4c
X-Gm-Message-State: AOJu0Yw1TilZTT6aZxVMvtIXSuAgbo5ItaHPXM6KsyThsVDvJ4HXkJaY
	LJoYT2sx9B7/uyTpYhuWORjXyn4B0c+tFsqPa5y8K0rr4x5sgwFn
X-Google-Smtp-Source: AGHT+IHJnkBj1yFw5Q7Fs1/yOwoPxmv+yiz/WNbQ2xn3rIQim8+VnKeb88VVH+vmUoYLD8PkSVZGOw==
X-Received: by 2002:a05:6512:4020:b0:512:9e58:b1ad with SMTP id br32-20020a056512402000b005129e58b1admr11885177lfb.57.1708581156995;
        Wed, 21 Feb 2024 21:52:36 -0800 (PST)
Received: from localhost ([2a05:3580:f312:6c02:29d4:49b1:c3dc:494c])
        by smtp.gmail.com with ESMTPSA id c6-20020ac25306000000b00512ab050435sm57420lfh.100.2024.02.21.21.52.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Feb 2024 21:52:31 -0800 (PST)
Date: Thu, 22 Feb 2024 08:52:23 +0300
From: Andrey Skvortsov <andrej.skvortzov@gmail.com>
To: Sakari Ailus <sakari.ailus@linux.intel.com>
Cc: Alain Volmat <alain.volmat@foss.st.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-media@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	=?utf-8?Q?Ond=C5=99ej?= Jirman <megi@xff.cz>,
	Pavel Machek <pavel@ucw.cz>,
	Arnaud Ferraris <arnaud.ferraris@collabora.com>
Subject: Re: [PATCH 1/2] dt-bindings: media: i2c: add galaxycore,gc2145 DVP
 bus support
Message-ID: <ZdbdDqbaA9pyw88s@skv.local>
Mail-Followup-To: Andrey Skvortsov <andrej.skvortzov@gmail.com>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	Alain Volmat <alain.volmat@foss.st.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-media@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	=?utf-8?Q?Ond=C5=99ej?= Jirman <megi@xff.cz>,
	Pavel Machek <pavel@ucw.cz>,
	Arnaud Ferraris <arnaud.ferraris@collabora.com>
References: <20240217220308.594883-1-andrej.skvortzov@gmail.com>
 <20240217220308.594883-2-andrej.skvortzov@gmail.com>
 <ZdSC_xulFQ84TtLT@kekkonen.localdomain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZdSC_xulFQ84TtLT@kekkonen.localdomain>

On 24-02-20 10:46, Sakari Ailus wrote:
> Hi Andrey,
> 
> Thanks for the patchset.
> 
> On Sun, Feb 18, 2024 at 01:03:07AM +0300, Andrey Skvortsov wrote:
> > Don't require link-frequencies like it's done for ov5640, that
> > supports both CSI-2 and DVP. And v4l2_fwnode_endpoint_alloc_parse
> > ignores link-frequencies property for DVP endpoint. It's used only for
> > CSI-2 endpoints
> > 
> > Signed-off-by: Andrey Skvortsov <andrej.skvortzov@gmail.com>
> > ---
> >  .../bindings/media/i2c/galaxycore,gc2145.yaml | 33 +++++++++++++++++--
> >  1 file changed, 30 insertions(+), 3 deletions(-)
> > 
> > diff --git a/Documentation/devicetree/bindings/media/i2c/galaxycore,gc2145.yaml b/Documentation/devicetree/bindings/media/i2c/galaxycore,gc2145.yaml
> > index 1726ecca4c77..fb376b9d0f2a 100644
> > --- a/Documentation/devicetree/bindings/media/i2c/galaxycore,gc2145.yaml
> > +++ b/Documentation/devicetree/bindings/media/i2c/galaxycore,gc2145.yaml
> > @@ -61,9 +61,6 @@ properties:
> >          properties:
> >            link-frequencies: true
> >  
> > -        required:
> > -          - link-frequencies
> 
> That seems like a bad idea to me.
> 
> While for parallel interface it may not be often important, for CSI-2 it
> should stay.

I'll add this type and make link-frequencies required based on that
for CSI-2 bus.

> 
> > -
> >      required:
> >        - endpoint
> >  
> > @@ -110,4 +107,34 @@ examples:
> >          };
> >      };
> >  
> > +  - |
> > +    #include <dt-bindings/gpio/gpio.h>
> > +
> > +    i2c {
> > +        #address-cells = <1>;
> > +        #size-cells = <0>;
> > +
> > +        camera@3c {
> > +            compatible = "galaxycore,gc2145";
> > +            reg = <0x3c>;
> > +            clocks = <&clk_ext_camera>;
> > +            iovdd-supply = <&scmi_v3v3_sw>;
> > +            avdd-supply = <&scmi_v3v3_sw>;
> > +            dvdd-supply = <&scmi_v3v3_sw>;
> > +            powerdown-gpios = <&mcp23017 3 (GPIO_ACTIVE_LOW | GPIO_PUSH_PULL)>;
> > +            reset-gpios = <&mcp23017 4 (GPIO_ACTIVE_LOW | GPIO_PUSH_PULL)>;
> > +
> > +            port {
> > +                endpoint {
> > +                    remote-endpoint = <&parallel_from_gc2145>;
> > +                    bus-width = <8>;
> > +                    hsync-active = <1>;
> > +                    vsync-active = <1>;
> > +                    data-active = <1>;
> > +                    pclk-sample = <1>;
> 
> Are there defaults for these if there are no such properties?

good point. I'll add them to the endpoint properties description then.

-- 
Best regards,
Andrey Skvortsov

