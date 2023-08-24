Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B94F78783F
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Aug 2023 20:51:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243128AbjHXSvI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Aug 2023 14:51:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243168AbjHXSvA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Aug 2023 14:51:00 -0400
Received: from mail-oi1-x229.google.com (mail-oi1-x229.google.com [IPv6:2607:f8b0:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9303D1BCE;
        Thu, 24 Aug 2023 11:50:58 -0700 (PDT)
Received: by mail-oi1-x229.google.com with SMTP id 5614622812f47-3a7e68f4214so122655b6e.1;
        Thu, 24 Aug 2023 11:50:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692903058; x=1693507858;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=aqVyJ9RUVtyyFKnwGC2cT2NgtLaSYlYeieCEq7zLn7A=;
        b=jM2PVtsKTwXStWBeVP6L5ykfpTvweRpjc4p4hUENOU2hL4/fi6HiXK0WPdeHx9nasP
         IjNijML+zxv3996HI4Do+YQ7xsu80s6ojONy/72S3AQEAjpitUNe4dRtGXcdmN5dG9h8
         1+e1uvLLM7TUnO/jFTaW71Y0r2QKzFW4iEXfQadzjM2yPR0sp9nYsiOvlTssFTR0oNn0
         SD3D+OOsfC4V9Qs0sIcG+JH4rKfPS0lxADSJrx3rvJk5PKwqNM+RyF4g540Ja4bN5YqY
         5b6MYRRkFEQn2PFwz/5vuO4Uv4YovXzsDv6S3iPoFHevO2nVEFIEDwZ+gcTFc3rzKUn5
         gk2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692903058; x=1693507858;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aqVyJ9RUVtyyFKnwGC2cT2NgtLaSYlYeieCEq7zLn7A=;
        b=ltFWeCa/Q3lUTOua4vcyRjgfVD8u+zNH2X+nJR0A3rn5kpkp4My3b01ICk5/b7GIVB
         MGnQJypJYumiTAGfQKHYMYsU6yVUVCHgZsMbq+kRZGoRMoU5pnq26z/DfTFgNFW1Rvu/
         9kDECemxzYdHwmpX8i3VW7ABU+stehE3yBGSEAp/BiCBwxMInodrI5+rIIX3/sN2Mrtb
         g5GTsirgwj9KkCvTP1r+vR4YFQetdemVHCh/D4Gj0b5d+Tqjp2pGDW/n6MFE6iZi1YFW
         DJgA5eTd0xy/7Eeblws4KdxZGZSb9uuElqEcsR+DDel71p9m4XITc6nnRQfHu0YzXPSa
         zhXw==
X-Gm-Message-State: AOJu0YwUFWle6AAQGBI9TWhL98qFABCiogQoHPpxMY3mA8XB/6QsGq41
        XEz3SNPOnS2G3P7eFDaiyMGW8VeeFIdVbns/
X-Google-Smtp-Source: AGHT+IFccbnP2QFsXt4xG63svj36Lg9j5RsmEKqyuRIdBVB6l8Uws8JJF0le51SOlq/ZRpUmOwnCbg==
X-Received: by 2002:a05:6358:429d:b0:134:c984:ab74 with SMTP id s29-20020a056358429d00b00134c984ab74mr14817501rwc.9.1692903057794;
        Thu, 24 Aug 2023 11:50:57 -0700 (PDT)
Received: from shaak (modemcable063.135-226-192.mc.videotron.ca. [192.226.135.63])
        by smtp.gmail.com with ESMTPSA id a10-20020ac8434a000000b004109d386323sm22148qtn.66.2023.08.24.11.50.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Aug 2023 11:50:57 -0700 (PDT)
Date:   Thu, 24 Aug 2023 14:50:54 -0400
From:   Liam Beguin <liambeguin@gmail.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH 3/3] dt-bindings: iio: adc: add lltc,ltc2309 bindings
Message-ID: <20230824185054.GA3659959@shaak>
References: <20230824-ltc2309-v1-0-b87b4eb8030c@gmail.com>
 <20230824-ltc2309-v1-3-b87b4eb8030c@gmail.com>
 <e54273c7-4728-7577-f053-b15307d3a083@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e54273c7-4728-7577-f053-b15307d3a083@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 24, 2023 at 07:56:29PM +0200, Krzysztof Kozlowski wrote:
> On 24/08/2023 18:55, Liam Beguin wrote:
> > Add devicetree bindings for the Linear Technology LTC2309 ADC driver.
> > 
> > Signed-off-by: Liam Beguin <liambeguin@gmail.com>
> 
> Thank you for your patch. There is something to discuss/improve.
> 
> > +++ b/Documentation/devicetree/bindings/iio/adc/lltc,ltc2309.yaml
> > @@ -0,0 +1,52 @@
> > +# SPDX-License-Identifier: GPL-2.0
> 
> Wrong license. Run checkpatch before sending patches.
> 

Sorry about that, I ran it through checkpatch but it didn't flag
anything.

> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/iio/adc/lltc,ltc2309.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: Linear Technology / Analog Devices LTC2309 ADC
> > +
> > +maintainers:
> > +  - Liam Beguin <liambeguin@gmail.com>
> > +
> > +properties:
> > +  compatible:
> > +    enum:
> > +      - lltc,ltc2309
> > +
> > +  refcomp-supply:
> > +    description: Power supply for the reference voltage
> 
> refcomp is not a supply. It is called "Reference Buffer Output.". You

That makes sense, I was going for the PIN name from the datasheet.

> probably wanted vref-supply, which suggests you should just add it to
> ltc2497 bindings. I don't see any differences.
> 

I hadn't thought of reusing an existing bindings file for a different
driver. I'll update ltc2497.yaml instead since it avoids duplicating the
whole file.

> > +
> > +  reg:
> > +    enum:
> > +      - 0x08
> > +      - 0x09
> > +      - 0x0a
> > +      - 0x0b
> > +      - 0x18
> > +      - 0x19
> > +      - 0x1a
> > +      - 0x1b
> > +      - 0x28
> > +
> > +  "#io-channel-cells":
> > +    const: 1
> > +
> > +required:
> > +  - compatible
> > +  - reg
> > +
> > +unevaluatedProperties: false
> > +
> > +examples:
> > +  - |
> > +    i2c {
> > +        #address-cells = <1>;
> > +        #size-cells = <0>;
> > +
> > +        adc@28 {
> > +            #io-channel-cells = <1>;
> > +            compatible = "lltc,ltc2309";
> > +            reg = <0x28>;
> 
> If the example stays, then order is compatible first, then reg, then the
> rest. Also add the supply to make example complete.

Thanks for pointing out the proper order.

> But I think this should be squashed with other binding so no need for
> the example.
> 
> Best regards,
> Krzysztof
> 

Thanks for your time!
Liam
