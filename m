Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F5FC7D40B4
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Oct 2023 22:17:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230265AbjJWURb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Oct 2023 16:17:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229482AbjJWUR3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Oct 2023 16:17:29 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30D80D6E;
        Mon, 23 Oct 2023 13:17:27 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id a640c23a62f3a-9adca291f99so543067966b.2;
        Mon, 23 Oct 2023 13:17:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698092245; x=1698697045; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=F3p2PnLUVcsWhyg9y4I5JwaQK0DHEZVP7M5znrQSP0s=;
        b=FMaZnOfwURsbnXVZ7L0SBH2BbWeaAl0FuDJ0Jee6F7jSUyByVahAsGEaR3YNG6IJAG
         bJAKj/HuwlM8Q7q+kc/wr6VadWNNwweSEo72j6n5ce5lbG4pCc0lQJjcrCySn0HpVHkX
         hiVCCL6WzGypAiuPMXbLavMY/H55Go8SG4oafr/BsWaJR6eP5TzvNw6cM8XLkekK9Nyg
         DuO6OpIkeZheCCqNcoErZfg5DVGR8NshIWRF5+VoipeGtKQozyFjD1IdYqev7qlmJuym
         7i5a9VDDOcujJaI51uuDA+u1d/hBvypmN/C+rhUyndH3myREkkOqnA0UM2LCPZaDnuCc
         PMsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698092245; x=1698697045;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=F3p2PnLUVcsWhyg9y4I5JwaQK0DHEZVP7M5znrQSP0s=;
        b=k01Yfr7e9q9K1aX0uhf1J2Q30J+dT5/4oogCchcUBTVOiFEzMb+VbXuskGlEg6Y/aj
         XTKw/IthqvMSFj41xdf7+LDx66x9Kp6KUHOCz6iMOZqhFdvO7qiEspnv1iO4ATRWUuZX
         JkbCvWO0SbI1xg0uFxv1/ji+bEfTFrRiG0PnztFpiCc/JgAyaXdcR4SPv+WiX5n8VeKy
         uekI+2fJbse5LiPys3V1gKDpy0+nKCFnToi9jTPZLZw+DdVGVpwXvtIia4EuUNWG/PUF
         kE+b+q0rVxjfG5vhUcGiRkDnZc4VzbkA0EJAR1WJy5gCBAnxYR6iq0fo1Sc4NUKvdHtB
         MJ8Q==
X-Gm-Message-State: AOJu0Yy0k4i89IIhRTURk+ogRvSWbV1LnEaRM8eKCQuDV1nrt7DEK9G8
        WriTcCM4XyK8FGKQ19fY62M=
X-Google-Smtp-Source: AGHT+IHsyiIrO3EdEjsHS/lptDQDezlTNE0C1bRSK1xDXvjW4+pDoJfdRGlYrl4dSWu+v6fYeQOs6w==
X-Received: by 2002:a17:907:9282:b0:9bd:fc4b:6c9b with SMTP id bw2-20020a170907928200b009bdfc4b6c9bmr8381154ejc.36.1698092245263;
        Mon, 23 Oct 2023 13:17:25 -0700 (PDT)
Received: from standask-GA-A55M-S2HP ([188.123.113.247])
        by smtp.gmail.com with ESMTPSA id k2-20020a1709067ac200b0099bcf1c07c6sm7177770ejo.138.2023.10.23.13.17.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Oct 2023 13:17:24 -0700 (PDT)
Date:   Mon, 23 Oct 2023 22:17:22 +0200
From:   Stanislav Jakubek <stano.jakubek@gmail.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Florian Fainelli <florian.fainelli@broadcom.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        bcm-kernel-feedback-list@broadcom.com, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Artur Weber <aweber.kernel@gmail.com>
Subject: Re: [PATCH] dt-bindings: clock: brcm,kona-ccu: convert to YAML
Message-ID: <ZTbU0rkGMhja+J24@standask-GA-A55M-S2HP>
References: <ZTUIJrTc6KKyT4xj@standask-GA-A55M-S2HP>
 <3df06d79-ea51-4202-8cc8-468f741603bf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3df06d79-ea51-4202-8cc8-468f741603bf@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 23, 2023 at 09:54:49AM +0200, Krzysztof Kozlowski wrote:
> On 22/10/2023 13:31, Stanislav Jakubek wrote:
> > Convert Broadcom Kona family clock controller unit (CCU) bindings
> > to DT schema.
> > 
> > Signed-off-by: Stanislav Jakubek <stano.jakubek@gmail.com>
> 
> Thank you for your patch. There is something to discuss/improve.
> 
> > +description:
> > +  Broadcom "Kona" style clock control unit (CCU) is a clock provider that
> > +  manages a set of clock signals.
> > +
> > +properties:
> > +  compatible:
> > +    enum:
> > +      - brcm,bcm11351-aon-ccu
> > +      - brcm,bcm11351-hub-ccu
> > +      - brcm,bcm11351-master-ccu
> > +      - brcm,bcm11351-root-ccu
> > +      - brcm,bcm11351-slave-ccu
> > +      - brcm,bcm21664-aon-ccu
> > +      - brcm,bcm21664-master-ccu
> > +      - brcm,bcm21664-root-ccu
> > +      - brcm,bcm21664-slave-ccu
> > +
> > +  reg:
> > +    maxItems: 1
> > +
> > +  '#clock-cells':
> > +    const: 1
> > +
> > +  clock-output-names:
> > +    minItems: 1
> > +    maxItems: 10
> > +
> > +allOf:
> > +  - if:
> > +      properties:
> > +        compatible:
> > +          contains:
> > +            enum:
> > +              - brcm,bcm11351-aon-ccu
> > +              - brcm,bcm11351-hub-ccu
> > +              - brcm,bcm11351-master-ccu
> > +              - brcm,bcm11351-root-ccu
> > +              - brcm,bcm11351-slave-ccu
> > +    then:
> > +      properties:
> > +        clock-output-names:
> > +          description: |
> > +            The following table defines the set of CCUs and clock specifiers
> > +            for BCM281XX family clocks.
> > +            These clock specifiers are defined in:
> > +                "include/dt-bindings/clock/bcm281xx.h"
> > +
> > +            CCU     Clock        Type  Index  Specifier
> > +            ---     -----        ----  -----  ---------
> > +            root    frac_1m      peri    0    BCM281XX_ROOT_CCU_FRAC_1M
> > +
> > +            aon     hub_timer    peri    0    BCM281XX_AON_CCU_HUB_TIMER
> > +            aon     pmu_bsc      peri    1    BCM281XX_AON_CCU_PMU_BSC
> > +            aon     pmu_bsc_var  peri    2    BCM281XX_AON_CCU_PMU_BSC_VAR
> > +
> > +            hub     tmon_1m      peri    0    BCM281XX_HUB_CCU_TMON_1M
> > +
> > +            master  sdio1        peri    0    BCM281XX_MASTER_CCU_SDIO1
> > +            master  sdio2        peri    1    BCM281XX_MASTER_CCU_SDIO2
> > +            master  sdio3        peri    2    BCM281XX_MASTER_CCU_SDIO3
> > +            master  sdio4        peri    3    BCM281XX_MASTER_CCU_SDIO4
> > +            master  dmac         peri    4    BCM281XX_MASTER_CCU_DMAC
> > +            master  usb_ic       peri    5    BCM281XX_MASTER_CCU_USB_IC
> > +            master  hsic2_48m    peri    6    BCM281XX_MASTER_CCU_HSIC_48M
> > +            master  hsic2_12m    peri    7    BCM281XX_MASTER_CCU_HSIC_12M
> > +
> > +            slave   uartb        peri    0    BCM281XX_SLAVE_CCU_UARTB
> > +            slave   uartb2       peri    1    BCM281XX_SLAVE_CCU_UARTB2
> > +            slave   uartb3       peri    2    BCM281XX_SLAVE_CCU_UARTB3
> > +            slave   uartb4       peri    3    BCM281XX_SLAVE_CCU_UARTB4
> > +            slave   ssp0         peri    4    BCM281XX_SLAVE_CCU_SSP0
> > +            slave   ssp2         peri    5    BCM281XX_SLAVE_CCU_SSP2
> > +            slave   bsc1         peri    6    BCM281XX_SLAVE_CCU_BSC1
> > +            slave   bsc2         peri    7    BCM281XX_SLAVE_CCU_BSC2
> > +            slave   bsc3         peri    8    BCM281XX_SLAVE_CCU_BSC3
> > +            slave   pwm          peri    9    BCM281XX_SLAVE_CCU_PWM
> 
> I don't really understand why this is in the binding schema. I guess you
> wanted to copy it from the old binding, but, unless there is real reason
> for it, don't. The clock IDs should be in the header file and that's it.
> Nothing here.

Hi Krzysztof, you're correct that I just copied this from the old bindings.
brcm,iproc-clocks.yaml has a similar table, so I thought this would be fine.
I'm OK with dropping it, but how should I document the clock-output-names
values then? A bunch of if-then blocks (per compatible)? Or should I not even
bother and just keep minItems/maxItems without documenting the values?

> 
> > +  - if:
> > +      properties:
> > +        compatible:
> > +          contains:
> > +            enum:
> > +              - brcm,bcm21664-aon-ccu
> > +              - brcm,bcm21664-master-ccu
> > +              - brcm,bcm21664-root-ccu
> > +              - brcm,bcm21664-slave-ccu
> > +    then:
> > +      properties:
> > +        clock-output-names:
> > +          maxItems: 8

I've also noticed that dtbs_check gives out warnings(?) like this for
bcm21664 ccu nodes:

/arch/arm/boot/dts/broadcom/bcm21664-garnet.dtb:
    root_ccu@35001000: clock-output-names: ['frac_1m'] is too short
    from schema $id: http://devicetree.org/schemas/clock/brcm,kona-ccu.yaml#

and this maxItems:8 seems to me like the culprit (since the bcm11351 if-then
doesn't have that). Seems to me like it also overrides the minItems to be 8
as well. I don't understand why it would do that though.

I suppose just adding minItems: 1 would be the correct fix in this case?

> > +          description: |
> > +            The following table defines the set of CCUs and clock specifiers
> > +            for BCM21664 family clocks.
> > +            These clock specifiers are defined in:
> > +                "include/dt-bindings/clock/bcm21664.h"
> > +
> > +            CCU     Clock         Type  Index  Specifier
> > +            ---     -----         ----  -----  ---------
> > +            root    frac_1m       peri    0    BCM21664_ROOT_CCU_FRAC_1M
> > +
> > +            aon     hub_timer     peri    0    BCM21664_AON_CCU_HUB_TIMER
> > +
> > +            master  sdio1         peri    0    BCM21664_MASTER_CCU_SDIO1
> > +            master  sdio2         peri    1    BCM21664_MASTER_CCU_SDIO2
> > +            master  sdio3         peri    2    BCM21664_MASTER_CCU_SDIO3
> > +            master  sdio4         peri    3    BCM21664_MASTER_CCU_SDIO4
> > +            master  sdio1_sleep   peri    4    BCM21664_MASTER_CCU_SDIO1_SLEEP
> > +            master  sdio2_sleep   peri    5    BCM21664_MASTER_CCU_SDIO2_SLEEP
> > +            master  sdio3_sleep   peri    6    BCM21664_MASTER_CCU_SDIO3_SLEEP
> > +            master  sdio4_sleep   peri    7    BCM21664_MASTER_CCU_SDIO4_SLEEP
> > +
> > +            slave   uartb         peri    0    BCM21664_SLAVE_CCU_UARTB
> > +            slave   uartb2        peri    1    BCM21664_SLAVE_CCU_UARTB2
> > +            slave   uartb3        peri    2    BCM21664_SLAVE_CCU_UARTB3
> > +            slave   uartb4        peri    3    BCM21664_SLAVE_CCU_UARTB4
> > +            slave   bsc1          peri    4    BCM21664_SLAVE_CCU_BSC1
> > +            slave   bsc2          peri    5    BCM21664_SLAVE_CCU_BSC2
> > +            slave   bsc3          peri    6    BCM21664_SLAVE_CCU_BSC3
> > +            slave   bsc4          peri    7    BCM21664_SLAVE_CCU_BSC4
> 
> Same comments.
> 
> In any case, allOf: goes after required: block.

Ack.

> 
> > +
> > +required:
> > +  - compatible
> > +  - reg
> > +  - '#clock-cells'
> > +  - clock-output-names
> > +
> > +additionalProperties: false
> > +
> Best regards,
> Krzysztof
> 

Thanks for the feedback,
Stanislav
