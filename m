Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 868AA781C89
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Aug 2023 07:57:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229929AbjHTF5x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Aug 2023 01:57:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229885AbjHTF5l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Aug 2023 01:57:41 -0400
Received: from mail-qt1-x82f.google.com (mail-qt1-x82f.google.com [IPv6:2607:f8b0:4864:20::82f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EFDB44B8;
        Sat, 19 Aug 2023 21:12:25 -0700 (PDT)
Received: by mail-qt1-x82f.google.com with SMTP id d75a77b69052e-40fd276621aso15304231cf.2;
        Sat, 19 Aug 2023 21:12:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692504744; x=1693109544;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=OCLLu1xh4hLECfYJNulYJKBxk+onbXBF4HdtgW6Lrbs=;
        b=o94k4LES0VEuLNcGgG8/cl6XJBVd+/+Jj6XD0aMLNEGiFmyqGWmFYSLHILZcVTlWsn
         LuPNZrfUnGHYBMDbjb1lfOJsP42UY+9kqnh5J1+Ur/Lmb7WxE0oXNTwbDo1YQjRv/US2
         newMZ4KfYJViOZ2yx4ZZQ4p5NAFOusKe1+4HUV/K2bdaz9J3WJujHWZITo2iG+NtqHZ1
         rmRetD8U39YxAWIFp7SlOjqpYl55ZTkxZi3yZudossLoJmtJwZIPDMrdUD3j6d0NNg5m
         7I9OE74oOadt884wrw7Bb5rW4MbUhT9vigLa2A/x20o3BOmwQjrIBMHljkqalhv1Avwq
         oa6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692504744; x=1693109544;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OCLLu1xh4hLECfYJNulYJKBxk+onbXBF4HdtgW6Lrbs=;
        b=W1gPVUs8eWKYRMDN54C4aaA06Fthp4dRGAKxwPQ2gBvnoB8S6lE5hV/w8rU9inamzL
         nGJQ2Fyucm165cBzYlygdlnbErWW9n07BtUbnOt1s3b21MFuRxAhe8RVAucBpN7itiNC
         V2SDJzOQ0CjyhY4NJkDvUXJeQ8P3vfv+IsAz6QCG9VyX051qTTbSue+rUMqaSSu+XTnO
         LCk9ii32D5XKRdw3BnZ2/7tSe46mf/bn2MzSrQdCHOWqmLJTcrZr6dMrCqFS9G5CvLl8
         ppaebQftHoeToNaQYI7G7CLYT95Csz7vHX5SK3s41/K0+jZ1TetiEu+F8FleWCwvqAND
         GsXQ==
X-Gm-Message-State: AOJu0Yw7fM2VUaajuMp2sQLjTopqcL9OMcx50D3rq/uSG2xRNo9GnUpP
        Um45MSHqiJqey9ZD2ASPzvHAO8/fPPaljQ==
X-Google-Smtp-Source: AGHT+IFOWomLZtaC8QB4RADHeE4mhq0eLA+GRVlxZk8S9guVmhV3YG8OHIbDH3o6SB7HIgieBhKxcA==
X-Received: by 2002:ac8:5e4f:0:b0:410:8bcc:fbac with SMTP id i15-20020ac85e4f000000b004108bccfbacmr4222094qtx.7.1692504744363;
        Sat, 19 Aug 2023 21:12:24 -0700 (PDT)
Received: from abdel ([174.95.13.129])
        by smtp.gmail.com with ESMTPSA id v10-20020ac83d8a000000b0041079ba4f6bsm1574458qtf.12.2023.08.19.21.12.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Aug 2023 21:12:23 -0700 (PDT)
Date:   Sun, 20 Aug 2023 00:12:14 -0400
From:   Abdel Alkuor <alkuor@gmail.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     gregkh@linuxfoundation.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Abdel Alkuor <abdelalkuor@geotab.com>
Subject: Re: [PATCH] dt-bindings: usb: Add ti,tps25750
Message-ID: <ZOGSnpQR/yeHpcF+@abdel>
References: <20230818153015.513053-1-alkuor@gmail.com>
 <ba8e2a3c-8abd-8cd1-7490-10b13b131af3@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ba8e2a3c-8abd-8cd1-7490-10b13b131af3@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 19, 2023 at 02:46:18PM +0200, Krzysztof Kozlowski wrote:
> On 18/08/2023 17:30, Abdel Alkuor wrote:
> > From: Abdel Alkuor <abdelalkuor@geotab.com>
> > 
> > TPS25750 provides power negotiation and capabilities management
> > for USB Type-C applications.
> > 
> > Signed-off-by: Abdel Alkuor <abdelalkuor@geotab.com>
> > ---
> > v2: 
> 
> git format-patch -v2 -1
Sorry about this. I realized after I sent the patch. Fixed in v3.
> 
> >  - Remove redundant word 'binding' from Subject
> >  - Add new line before reg property
> >  - Remove unused description in interrupts property
> >  - Drop interrupt-names property
> >  - Add maxItems to firmware-name property
> >  - Use generic node name 'typec' instead of 'tps25750'
> > ---
> >  .../devicetree/bindings/usb/ti,tps25750.yaml  | 81 +++++++++++++++++++
> >  1 file changed, 81 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/usb/ti,tps25750.yaml
> > 
> > diff --git a/Documentation/devicetree/bindings/usb/ti,tps25750.yaml b/Documentation/devicetree/bindings/usb/ti,tps25750.yaml
> > new file mode 100644
> > index 000000000000..d98c34df340d
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/usb/ti,tps25750.yaml
> > @@ -0,0 +1,81 @@
> > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/usb/ti,tps25750.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: Texas Instruments 25750 Type-C Port Switch and Power Delivery controller
> > +
> > +maintainers:
> > +  - Abdel Alkuor <abdelalkuor@geotab.com>
> > +
> > +description: |
> > +  Texas Instruments 25750 Type-C Port Switch and Power Delivery controller
> > +
> > +properties:
> > +  compatible:
> > +    enum:
> > +      - ti,tps25750
> > +
> > +  reg:
> > +    maxItems: 1
> > +
> > +  interrupts:
> > +    maxItems: 1
> > +
> > +  firmware-name:
> > +    description: |
> > +      Should contain the name of the default patch binary
> > +      file located on the firmware search path which is
> > +      used to switch the controller into APP mode
> > +    maxItems: 1
> > +
> > +  connector:
> > +    type: object
> > +    $ref: ../connector/usb-connector.yaml#
> > +    description:
> > +      Properties for usb c connector.
> > +    required:
> > +      - data-role
> > +
> > +required:
> > +  - compatible
> > +  - reg
> > +  - interrupts
> > +  - connector
> > +
> > +additionalProperties: true
> > +
> > +examples:
> > +  - |
> > +    #include <dt-bindings/interrupt-controller/irq.h>
> > +    i2c {
> > +        #address-cells = <1>;
> > +        #size-cells = <0>;
> > +
> > +        typec: tps25750@21 {
> 
> Nothing improved in node name. Drop the label "typec", because it is not
> used.
> 
> I still wait for the user, as I wrote in your v1.
Dropped the label and used typec@21 as the node name in v3
> 
> Best regards,
> Krzysztof
>

Thank you,
Abdel
