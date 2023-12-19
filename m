Return-Path: <linux-kernel+bounces-5556-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CF26818C2F
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 17:27:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 019FD1F2580B
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 16:27:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 935711D55A;
	Tue, 19 Dec 2023 16:27:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NrWOh4Ca"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 905DB2030E;
	Tue, 19 Dec 2023 16:27:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f50.google.com with SMTP id 6a1803df08f44-67f2a5d8a05so26625216d6.3;
        Tue, 19 Dec 2023 08:27:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703003260; x=1703608060; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ZbuWW25Nxvjwkt+QpWELnr3IDh+YCdBkxC4WBshnkiM=;
        b=NrWOh4Caii5oCp+WXTgXExyygngb8xgZP7A/zHF741hiJc6lCYeuaARp2W+yFrSnkI
         6jFQFM0l3ucMBhZU6zNkDIF1JdWe8zDodtBDjWb+VdI6dC/MXBjxIr7bOejYPi0nS7/8
         YWlbbv8k/3hO53B0vJyXkd6LcIPnFUrupUwfJlgz1AOjlpsKPXLzWHQU4pEWTGfE22sC
         Zof1ERMlfERZHc0JAqBfY8KzoZZ5ci7tHGhDGihC4zDge2EnRLcGTMbeqMITAoR5mhJE
         EPPDg6DLtLqjANeIDmCEVYULBl8UAH4Q97XeJlqp39C6kqZAjApo4oW5//s7zyhMjFHw
         0rKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703003260; x=1703608060;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZbuWW25Nxvjwkt+QpWELnr3IDh+YCdBkxC4WBshnkiM=;
        b=Svfr7cZcnHJfz+DVH6TfMtP9XNzKFBBwpS43l5jyQ/6vBZVkq89pPndi9SRsoeHRte
         u1LAYWrggq0uMcKIp5+Mpmqsz2fpOdCko04PzgWyfEORMNbm/jYP2QmW2fW7uev9n18V
         oSgpv42SB1XUwFfVfyDfmi+gqM/Y7h9dO1P/XolpdX6P1ZsQwEFCptmXEN10NF71/isH
         VxlRGQbtfHeOfgHKp7/NSgvA/kDxVAbABlNIphoNK4fFxMdJCsM5Gv8Nb/8yCXADDLw8
         kXHVGtnb1eevLCv0dOiyS/vTg/sEAdnz+XiJoqO+XqvQu3gcyXtClvpgj6yiF1kvMdSg
         ibIQ==
X-Gm-Message-State: AOJu0YxdwqiZq3LipDWHv38SWsWcATco+7HyiC9Ah4aItRcE91xpLTnD
	5e0Pxci5QF3HoID1XqvFCfQ=
X-Google-Smtp-Source: AGHT+IGBYeDWnicGahL2bG0zvCTL1gPBw11B55VHGDfWpmfaAtL2dZzBZoPYzXQGM0RSw2GV/LIevA==
X-Received: by 2002:a05:6214:224e:b0:67f:39b0:39a8 with SMTP id c14-20020a056214224e00b0067f39b039a8mr6485289qvc.95.1703003260400;
        Tue, 19 Dec 2023 08:27:40 -0800 (PST)
Received: from abdel ([174.95.13.129])
        by smtp.gmail.com with ESMTPSA id da14-20020a05621408ce00b0067a276fd8d5sm3528624qvb.54.2023.12.19.08.27.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Dec 2023 08:27:39 -0800 (PST)
Date: Tue, 19 Dec 2023 11:27:29 -0500
From: Abdel Alkuor <alkuor@gmail.com>
To: Conor Dooley <conor@kernel.org>
Cc: Jean Delvare <jdelvare@suse.com>, Guenter Roeck <linux@roeck-us.net>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>, linux-hwmon@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org
Subject: Re: [PATCH v2 1/2] dt-bindings: hwmon: (lm75) Add AMS AS6200
 temperature sensor
Message-ID: <ZYHEcfB7b+k2g9Ge@abdel>
References: <89fb5eec30df734ee8fc58427cf5d94929076514.1702874115.git.alkuor@gmail.com>
 <20231219-mascot-semester-7d2c492b99bc@spud>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231219-mascot-semester-7d2c492b99bc@spud>

On Tue, Dec 19, 2023 at 03:18:24PM +0000, Conor Dooley wrote:
> On Sun, Dec 17, 2023 at 11:52:27PM -0500, Abdel Alkuor wrote:
> 
> Do the other devices here have interrupts? If not, you just allowed
> interrupts for them. You, at the very least, need to add something like:
> diff --git a/Documentation/devicetree/bindings/hwmon/lm75.yaml b/Documentation/devicetree/bindings/hwmon/lm75.yaml
> index 63b85a83ac18..d7ce96606400 100644
> --- a/Documentation/devicetree/bindings/hwmon/lm75.yaml
> +++ b/Documentation/devicetree/bindings/hwmon/lm75.yaml
> @@ -56,6 +56,17 @@ required:
>    - compatible
>    - reg
>  
> +allOf:
> +  - if:
> +      not:
> +        properties:
> +          compatible:
> +            contains:
> +              const: ams,as6200
> +    then:
> +      properties:
> +        interrupts: false
> +
>  additionalProperties: false
>  
No, not all of them support the interrupt. Just tmp101, tmp102, tmp112, and as6200.
For now, I'll add the check for ams,as6200.
>  examples:
> 
> I had a brief look at the driver though, but I could not immediately
> tell if the interrupt was required on the ams,as6200 or if the driver
> continued on without that functionality. It seemed like an additional
> feature that the interrupt was required for, but if not you should make
> the interrupt required for the as6200.
> 
It is an additional feature. The interrupt basically notifies the user space when the
alarm state changes through temp1_alarm sysfs using poll on the file for example. That
being said, we should still be able to read the alarm state for as6200 without the
interrupt present.
> > +
> >  required:
> >    - compatible
> >    - reg
> > @@ -66,3 +70,17 @@ examples:
> >          vs-supply = <&vs>;
> >        };
> >      };
> > +  - |
> > +    #include <dt-bindings/interrupt-controller/irq.h>
> > +    i2c {
> > +        #address-cells = <1>;
> > +        #size-cells = <0>;
> > +
> > +        temperature-sensor@48 {
> > +            compatible = "ams,as6200";
> > +            reg = <0x48>;
> > +            vs-supply = <&vs>;
> > +            interrupt-parent = <&gpio1>;
> > +            interrupts = <17 IRQ_TYPE_EDGE_BOTH>;
> > +        };
> > +    };
> 
> Can you make the indent here match that in the other example in this
> file please?
Sure. 

Thanks,
Abdel



