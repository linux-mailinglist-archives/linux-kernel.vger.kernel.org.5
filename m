Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03A5A7D5C04
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Oct 2023 21:59:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344261AbjJXT7y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Oct 2023 15:59:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344012AbjJXT7w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Oct 2023 15:59:52 -0400
Received: from mail-ot1-f42.google.com (mail-ot1-f42.google.com [209.85.210.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A010210C9;
        Tue, 24 Oct 2023 12:59:50 -0700 (PDT)
Received: by mail-ot1-f42.google.com with SMTP id 46e09a7af769-6c7b3adbeb6so3199443a34.0;
        Tue, 24 Oct 2023 12:59:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698177590; x=1698782390;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=X34cwpBpiuP3aqf5QjDCKfEoi+InD6TZZpa1Cm188qc=;
        b=Pv2pZVK+Je40RwnG8Ae1km7ocgLJvXvhzpRBZcwBbMvD+/78oK+wUydfKathlhsROV
         8+PN2h7cQ6tHT5xwoSqe/4iHflrkYy4VX+w0rG1oPGpTku9LKlh95rjtM2chomxsLRfB
         S7chYLHLx0Rt5nkN7yHLSYJkdqM2K8IBxCAwXaHCGnx/2rTRdXs7GEwAQMee9iTov0LO
         vkTfYv+Yo+p0IVtnsHY5KdnoI0WUTKYmvbHlVpyFfMBChpWP3jNfbkn5dUSzKLGQIFZ/
         ewWjQYl39ifGznDDBxfyfT6JuLq8JnPe5F7I+wlq0kLtHoJMyJi/ejI4MLkUDKTAgVw4
         yKXQ==
X-Gm-Message-State: AOJu0YyoORVT2IKYK9eAjxvimho2w/ctT6xiu4YZd7ftsk71MHMa2aoB
        utUdfOgxELX1zcgabHgUsQ==
X-Google-Smtp-Source: AGHT+IHIr4W8mfEnqO6DkV45UgvYeE2TGYjTXkCq8izEC3MLiXPtFc1Gm393ANejfie00c/rIq/f4w==
X-Received: by 2002:a9d:6286:0:b0:6bd:152f:9918 with SMTP id x6-20020a9d6286000000b006bd152f9918mr14956463otk.14.1698177589921;
        Tue, 24 Oct 2023 12:59:49 -0700 (PDT)
Received: from herring.priv (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id q13-20020a9d57cd000000b006ce2f4861c5sm1961116oti.62.2023.10.24.12.59.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Oct 2023 12:59:49 -0700 (PDT)
Received: (nullmailer pid 465614 invoked by uid 1000);
        Tue, 24 Oct 2023 19:59:48 -0000
Date:   Tue, 24 Oct 2023 14:59:48 -0500
From:   Rob Herring <robh@kernel.org>
To:     Stanislav Jakubek <stano.jakubek@gmail.com>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Florian Fainelli <florian.fainelli@broadcom.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        bcm-kernel-feedback-list@broadcom.com, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Artur Weber <aweber.kernel@gmail.com>
Subject: Re: [PATCH] dt-bindings: clock: brcm,kona-ccu: convert to YAML
Message-ID: <20231024195948.GA459344-robh@kernel.org>
References: <ZTUIJrTc6KKyT4xj@standask-GA-A55M-S2HP>
 <3df06d79-ea51-4202-8cc8-468f741603bf@linaro.org>
 <ZTbU0rkGMhja+J24@standask-GA-A55M-S2HP>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZTbU0rkGMhja+J24@standask-GA-A55M-S2HP>
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 23, 2023 at 10:17:22PM +0200, Stanislav Jakubek wrote:
> On Mon, Oct 23, 2023 at 09:54:49AM +0200, Krzysztof Kozlowski wrote:
> > On 22/10/2023 13:31, Stanislav Jakubek wrote:
> > > Convert Broadcom Kona family clock controller unit (CCU) bindings
> > > to DT schema.
> > > 
> > > Signed-off-by: Stanislav Jakubek <stano.jakubek@gmail.com>
> > 
> > Thank you for your patch. There is something to discuss/improve.
> > 
> > > +description:
> > > +  Broadcom "Kona" style clock control unit (CCU) is a clock provider that
> > > +  manages a set of clock signals.
> > > +
> > > +properties:
> > > +  compatible:
> > > +    enum:
> > > +      - brcm,bcm11351-aon-ccu
> > > +      - brcm,bcm11351-hub-ccu
> > > +      - brcm,bcm11351-master-ccu
> > > +      - brcm,bcm11351-root-ccu
> > > +      - brcm,bcm11351-slave-ccu
> > > +      - brcm,bcm21664-aon-ccu
> > > +      - brcm,bcm21664-master-ccu
> > > +      - brcm,bcm21664-root-ccu
> > > +      - brcm,bcm21664-slave-ccu
> > > +
> > > +  reg:
> > > +    maxItems: 1
> > > +
> > > +  '#clock-cells':
> > > +    const: 1
> > > +
> > > +  clock-output-names:
> > > +    minItems: 1
> > > +    maxItems: 10
> > > +
> > > +allOf:
> > > +  - if:
> > > +      properties:
> > > +        compatible:
> > > +          contains:
> > > +            enum:
> > > +              - brcm,bcm11351-aon-ccu
> > > +              - brcm,bcm11351-hub-ccu
> > > +              - brcm,bcm11351-master-ccu
> > > +              - brcm,bcm11351-root-ccu
> > > +              - brcm,bcm11351-slave-ccu
> > > +    then:
> > > +      properties:
> > > +        clock-output-names:
> > > +          description: |
> > > +            The following table defines the set of CCUs and clock specifiers
> > > +            for BCM281XX family clocks.
> > > +            These clock specifiers are defined in:
> > > +                "include/dt-bindings/clock/bcm281xx.h"
> > > +
> > > +            CCU     Clock        Type  Index  Specifier
> > > +            ---     -----        ----  -----  ---------
> > > +            root    frac_1m      peri    0    BCM281XX_ROOT_CCU_FRAC_1M
> > > +
> > > +            aon     hub_timer    peri    0    BCM281XX_AON_CCU_HUB_TIMER
> > > +            aon     pmu_bsc      peri    1    BCM281XX_AON_CCU_PMU_BSC
> > > +            aon     pmu_bsc_var  peri    2    BCM281XX_AON_CCU_PMU_BSC_VAR
> > > +
> > > +            hub     tmon_1m      peri    0    BCM281XX_HUB_CCU_TMON_1M
> > > +
> > > +            master  sdio1        peri    0    BCM281XX_MASTER_CCU_SDIO1
> > > +            master  sdio2        peri    1    BCM281XX_MASTER_CCU_SDIO2
> > > +            master  sdio3        peri    2    BCM281XX_MASTER_CCU_SDIO3
> > > +            master  sdio4        peri    3    BCM281XX_MASTER_CCU_SDIO4
> > > +            master  dmac         peri    4    BCM281XX_MASTER_CCU_DMAC
> > > +            master  usb_ic       peri    5    BCM281XX_MASTER_CCU_USB_IC
> > > +            master  hsic2_48m    peri    6    BCM281XX_MASTER_CCU_HSIC_48M
> > > +            master  hsic2_12m    peri    7    BCM281XX_MASTER_CCU_HSIC_12M
> > > +
> > > +            slave   uartb        peri    0    BCM281XX_SLAVE_CCU_UARTB
> > > +            slave   uartb2       peri    1    BCM281XX_SLAVE_CCU_UARTB2
> > > +            slave   uartb3       peri    2    BCM281XX_SLAVE_CCU_UARTB3
> > > +            slave   uartb4       peri    3    BCM281XX_SLAVE_CCU_UARTB4
> > > +            slave   ssp0         peri    4    BCM281XX_SLAVE_CCU_SSP0
> > > +            slave   ssp2         peri    5    BCM281XX_SLAVE_CCU_SSP2
> > > +            slave   bsc1         peri    6    BCM281XX_SLAVE_CCU_BSC1
> > > +            slave   bsc2         peri    7    BCM281XX_SLAVE_CCU_BSC2
> > > +            slave   bsc3         peri    8    BCM281XX_SLAVE_CCU_BSC3
> > > +            slave   pwm          peri    9    BCM281XX_SLAVE_CCU_PWM
> > 
> > I don't really understand why this is in the binding schema. I guess you
> > wanted to copy it from the old binding, but, unless there is real reason
> > for it, don't. The clock IDs should be in the header file and that's it.
> > Nothing here.
> 
> Hi Krzysztof, you're correct that I just copied this from the old bindings.
> brcm,iproc-clocks.yaml has a similar table, so I thought this would be fine.
> I'm OK with dropping it, but how should I document the clock-output-names
> values then? A bunch of if-then blocks (per compatible)? Or should I not even
> bother and just keep minItems/maxItems without documenting the values?
> 
> > 
> > > +  - if:
> > > +      properties:
> > > +        compatible:
> > > +          contains:
> > > +            enum:
> > > +              - brcm,bcm21664-aon-ccu
> > > +              - brcm,bcm21664-master-ccu
> > > +              - brcm,bcm21664-root-ccu
> > > +              - brcm,bcm21664-slave-ccu
> > > +    then:
> > > +      properties:
> > > +        clock-output-names:
> > > +          maxItems: 8
> 
> I've also noticed that dtbs_check gives out warnings(?) like this for
> bcm21664 ccu nodes:
> 
> /arch/arm/boot/dts/broadcom/bcm21664-garnet.dtb:
>     root_ccu@35001000: clock-output-names: ['frac_1m'] is too short
>     from schema $id: http://devicetree.org/schemas/clock/brcm,kona-ccu.yaml#
> 
> and this maxItems:8 seems to me like the culprit (since the bcm11351 if-then
> doesn't have that). Seems to me like it also overrides the minItems to be 8
> as well. I don't understand why it would do that though.

Indeed it does. That should be fixed soon such that minItems/maxItems 
will never be added implicitly to if/then/else schemas.

Rob
