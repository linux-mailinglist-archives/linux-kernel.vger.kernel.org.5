Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B305D79F228
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Sep 2023 21:34:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232382AbjIMTeU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Sep 2023 15:34:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230475AbjIMTeS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Sep 2023 15:34:18 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B39C91;
        Wed, 13 Sep 2023 12:34:14 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id 5b1f17b1804b1-401da71b83cso1787435e9.2;
        Wed, 13 Sep 2023 12:34:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694633652; x=1695238452; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=WX/i3cNXS1oWxItg2qKc6j/aqyU+E77VPxnrUO0lQCo=;
        b=mQp2/0M6P4+BiN1YjhrxRXHR8pj82TPtWFqJxUkRRKKU44QHxXTciG8Vf8Qry/ZEPz
         /tFpnDkO3hHwS2mt5wDejF7euQaFUMqH8qzBgA+cVcLuJ3XGqQFxvsu7Esiwhi1z2alw
         rY3skCdqqzuA9nmK6pPKYqv4lAHxR91l/7koLNt0oWzS4/2Tv9PQrBWmQW9IWoiH2/+G
         FSc3eNrz6eVeMuoyoi3cESQgepz2betPIFqMtCydCUUp90FuBb9qeHOBgtb3PiGYHprD
         9AXKUra1dGXCHDAt8ywKD2gsh6uR+FVDBd0ZtGRRxy1MjxZH8VVDcilDc0/52buHwhXR
         dIbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694633652; x=1695238452;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WX/i3cNXS1oWxItg2qKc6j/aqyU+E77VPxnrUO0lQCo=;
        b=dez+4wFH6cBKwzUFE4XPS2o2HJP8OCg50t+dD9jxwWxBQHhF/U+UMcomQQ3MaTMMDH
         is8MK7rWTYuLFspCoZity1q0JSV4MSW+acZEIWzBWD0Lve8d0aa9/l53C3lc9Ig6Gpm0
         nlhtdVKhzovFl+3eZ9DmKMfj9D79yvXuNE41ETTcpYrgsqg50eims/UvT6V5PD/YiO8Q
         /ki5lr2S2I+/MiP80MPhTyEz3h/1D9KR3JqmLQXlfDPjNoh1qoefmP2Jk4s23md3lg8X
         SuoNbCHVwapwyJQlheFBBTPxM19cuwQIZRHJsGYUBGQZgYFQ0ZsbqNGoHvuqu3mNL2yJ
         1K0A==
X-Gm-Message-State: AOJu0YycmIVv1QJwTyFr/4gTKFl9Q5wgFEiU50NMi7qPAKEfAgRcuQrk
        h1zT5mUq1Bc+ARbSqYBcuvQ=
X-Google-Smtp-Source: AGHT+IGNs9Ohd0RDWMV5WiHbTxHTWdiuvdH47nKyV+uH98lkzRLtSYDiG05NSHMzOmqWSKTrRko3ZQ==
X-Received: by 2002:a1c:7204:0:b0:403:442:5421 with SMTP id n4-20020a1c7204000000b0040304425421mr2949761wmc.4.1694633652230;
        Wed, 13 Sep 2023 12:34:12 -0700 (PDT)
Received: from Ansuel-xps. (host-87-4-207-241.retail.telecomitalia.it. [87.4.207.241])
        by smtp.gmail.com with ESMTPSA id m25-20020a7bce19000000b003fe539b83f2sm2844488wmc.42.2023.09.13.12.34.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Sep 2023 12:34:11 -0700 (PDT)
Message-ID: <65020eb3.7b0a0220.fada9.b703@mx.google.com>
X-Google-Original-Message-ID: <ZQIOruZ/nfYK8ZQU@Ansuel-xps.>
Date:   Wed, 13 Sep 2023 21:34:06 +0200
From:   Christian Marangi <ansuelsmth@gmail.com>
To:     Rob Herring <robh@kernel.org>
Cc:     Robert Marko <robimarko@gmail.com>, ilia.lin@kernel.org,
        vireshk@kernel.org, nm@ti.com, sboyd@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        rafael@kernel.org, agross@kernel.org, andersson@kernel.org,
        konrad.dybcio@linaro.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, dmitry.baryshkov@linaro.org
Subject: Re: [PATCH v3 2/3] dt-bindings: opp: opp-v2-kryo-cpu: Document named
 opp-microvolt property
References: <20230909165739.1036263-1-robimarko@gmail.com>
 <20230909165739.1036263-2-robimarko@gmail.com>
 <20230912154239.GA833216-robh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230912154239.GA833216-robh@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 12, 2023 at 10:42:39AM -0500, Rob Herring wrote:
> On Sat, Sep 09, 2023 at 06:56:01PM +0200, Robert Marko wrote:
> > From: Christian Marangi <ansuelsmth@gmail.com>
> > 
> > Document named opp-microvolt property for opp-v2-kryo-cpu schema.
> > This property is used to declare multiple voltage ranges selected on the
> > different values read from efuses. The selection is done based on the
> > speed pvs values and the named opp-microvolt property is selected by the
> > qcom-cpufreq-nvmem driver.
> > 
> > Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
> > Signed-off-by: Robert Marko <robimarko@gmail.com>
> > ---
> >  .../bindings/opp/opp-v2-kryo-cpu.yaml         | 40 +++++++++++++++++++
> >  1 file changed, 40 insertions(+)
> > 
> > diff --git a/Documentation/devicetree/bindings/opp/opp-v2-kryo-cpu.yaml b/Documentation/devicetree/bindings/opp/opp-v2-kryo-cpu.yaml
> > index bbbad31ae4ca..6f216306a7eb 100644
> > --- a/Documentation/devicetree/bindings/opp/opp-v2-kryo-cpu.yaml
> > +++ b/Documentation/devicetree/bindings/opp/opp-v2-kryo-cpu.yaml
> > @@ -63,6 +63,12 @@ patternProperties:
> >            5:  MSM8996SG, speedbin 1
> >            6:  MSM8996SG, speedbin 2
> >            7-31:  unused
> > +
> > +          Bitmap for IPQ806X SoC:
> > +          0:  IPQ8062
> > +          1:  IPQ8064/IPQ8066/IPQ8068
> > +          2:  IPQ8065/IPQ8069
> > +          3-31:  unused
> >          enum: [0x1, 0x2, 0x3, 0x4, 0x5, 0x6, 0x7,
> >                 0x9, 0xd, 0xe, 0xf,
> >                 0x10, 0x20, 0x30, 0x70]
> > @@ -71,6 +77,24 @@ patternProperties:
> >  
> >        required-opps: true
> >  
> > +    patternProperties:
> > +      '^opp-microvolt-speed[0-9]+-pvs[0-9]+$':
> > +        description: |
> > +          Named opp-microvolt property following the same generic
> > +          binding for named opp-microvolt.
> > +
> > +          The correct voltage range is selected based on the values
> > +          in the efuse for the speed and the pvs.
> 
> What is "pvs"?
>

I will add the meaning in ().  

> > +
> > +          The qcom-cpufreq-nvmem driver will read all these values
> > +          and assign the correct named property.
> 
> Specific driver details don't belong in binding. If there's some detail 
> or requirement of all consumers, then that is fine here.
> 

Ok will drop.

> > +        $ref: /schemas/types.yaml#/definitions/uint32-matrix
> 
> The common binding already defines the type. Drop.
> 
> > +        minItems: 1
> > +        maxItems: 8   # Should be enough regulators
> 
> Does this really vary from 1 to 8 entries? Looks like copy-n-paste.
> 

Yes this comes from the default opp schema, actually the thing can
support 4 regulators so I will change to that.

> > +        items:
> > +          minItems: 1
> > +          maxItems: 3
> 
> Do you really need to support both single voltage and <nom min max> 
> forms?
>

It's all part of the OPP declaration so it would be supported anyway. Ok
for me to enforce <nom min max>. But is it really necessary?

-- 
	Ansuel
