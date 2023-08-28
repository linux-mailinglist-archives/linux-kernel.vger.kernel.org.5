Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F56A78A6D7
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Aug 2023 09:54:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229868AbjH1Hxy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Aug 2023 03:53:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229937AbjH1Hxs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Aug 2023 03:53:48 -0400
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5594711B
        for <linux-kernel@vger.kernel.org>; Mon, 28 Aug 2023 00:53:45 -0700 (PDT)
Received: by mail-pg1-x534.google.com with SMTP id 41be03b00d2f7-564b8e60ce9so1266691a12.2
        for <linux-kernel@vger.kernel.org>; Mon, 28 Aug 2023 00:53:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=9elements.com; s=google; t=1693209225; x=1693814025;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=yc5/64aDDHimpalFyKo/sDYTTFjFL1PiUBqmUUqNYNY=;
        b=EVNyxX2D6EZ5nzDDCwGTnaKtkt4faXDCrRZB+EWpBULWw6ZofaARnr23A2UfkDFslR
         VTHjtWH1hVnX6DCHF8Z9iAxLt1b1Tmgg0KwRSx0eTxhQlrrGKB+GRJb+qt+Mp637iu+1
         djvqqUloB8V3bujW+Mdax+wO37dYgmDLV9XdQZtqymlzzMqCS4QgC6eYtcdeHu2gOPIW
         42igJq3p/nyBsOyk6dUQ8NMZex3pu71WtSsJKnvwJsXe1yNt3w5luvk/LkE9tHSskA6Q
         8aYzN4CS3gI9Wvqe8y2VYcVR/yC2qROUREGW0D7O+jxuWsNG/Ttr6n+Pykn3HQTP6FJv
         Egvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693209225; x=1693814025;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yc5/64aDDHimpalFyKo/sDYTTFjFL1PiUBqmUUqNYNY=;
        b=adVyYy1fn3n9vt5gqCjXfMAHn2ok5CGXaam9kIXh/kTERZxXvKbvrWdvPcftePS1tX
         liZCIZpB/N32R+AUkMtYLPY+jCJprRlYr5U4o5l5JBNAE1Hj6Zjj6QDCqAEpROzifP34
         woqMjLm/Vb/WvgbtEMnmUGPLA5YbuyTCfkak1yrhKxA9BgD5iduRmgX7Vswn9sY/E1Le
         ciF+gm88biyHECR9EOP0pOtA4vYjOgpXTVM7Anld7mAJWIFkdzoApTvJScBBnHYCmNFt
         Hy8fmYVO+5c28zMPtrsgpc0dr5o3IxoCyClmFkq5Xqd1lGY61pmTc6569VOzhxQPeRsX
         p74w==
X-Gm-Message-State: AOJu0Yx0z0HvW1emzPkj+ymz8G7oceI+wvvTpxpkG6gE3/UDhJOQUlEG
        1/2onaHvY5yag/MKo2mkNf0Ba0ITOWBzBYuaLOORKA==
X-Google-Smtp-Source: AGHT+IE4ZTuCbpfSd2u26y/GnloivJyZc/YSoHKEwSl0YpsN37Q/7zIWDf5qfNHHW8SlBatqk5kJBNfX4i4HRUvRd2I=
X-Received: by 2002:a17:90a:3ec1:b0:26d:4642:1bd7 with SMTP id
 k59-20020a17090a3ec100b0026d46421bd7mr18663702pjc.34.1693209224797; Mon, 28
 Aug 2023 00:53:44 -0700 (PDT)
MIME-Version: 1.0
References: <20230817120029.221484-1-billy_tsai@aspeedtech.com>
 <20230817120029.221484-2-billy_tsai@aspeedtech.com> <20230823131334.GA2059582-robh@kernel.org>
 <SG2PR06MB33659FFB0CBFFA55295E6A098B1DA@SG2PR06MB3365.apcprd06.prod.outlook.com>
In-Reply-To: <SG2PR06MB33659FFB0CBFFA55295E6A098B1DA@SG2PR06MB3365.apcprd06.prod.outlook.com>
From:   Naresh Solanki <naresh.solanki@9elements.com>
Date:   Mon, 28 Aug 2023 13:23:33 +0530
Message-ID: <CABqG17g-s4h810JO-MO_TRRJhPkP=RMLDm7Jq6Sx4Gm1hRKqLg@mail.gmail.com>
Subject: Re: [PATCH v7 1/2] dt-bindings: hwmon: Support Aspeed g6 PWM TACH Control
To:     Billy Tsai <billy_tsai@aspeedtech.com>
Cc:     Rob Herring <robh@kernel.org>,
        "jdelvare@suse.com" <jdelvare@suse.com>,
        "linux@roeck-us.net" <linux@roeck-us.net>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "joel@jms.id.au" <joel@jms.id.au>,
        "andrew@aj.id.au" <andrew@aj.id.au>,
        "corbet@lwn.net" <corbet@lwn.net>,
        "thierry.reding@gmail.com" <thierry.reding@gmail.com>,
        "u.kleine-koenig@pengutronix.de" <u.kleine-koenig@pengutronix.de>,
        "p.zabel@pengutronix.de" <p.zabel@pengutronix.de>,
        "linux-hwmon@vger.kernel.org" <linux-hwmon@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-aspeed@lists.ozlabs.org" <linux-aspeed@lists.ozlabs.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>,
        BMC-SW <BMC-SW@aspeedtech.com>,
        "patrick@stwcx.xyz" <patrick@stwcx.xyz>,
        Luke Chen <luke_chen@aspeedtech.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Billy,


On Mon, 28 Aug 2023 at 09:33, Billy Tsai <billy_tsai@aspeedtech.com> wrote:
>
> On Thu, Aug 17, 2023 at 08:00:28PM +0800, Billy Tsai wrote:
>
> >> Document the compatible for aspeed,ast2600-pwm-tach device, which can
>
> >> support upto 16 PWM outputs and 16 fan tach input.
>
> >>
>
> >> Signed-off-by: Billy Tsai <billy_tsai@aspeedtech.com>
>
> >> ---
>
> >>  .../bindings/hwmon/aspeed,g6-pwm-tach.yaml    | 57 +++++++++++++++++++
>
> >>  1 file changed, 57 insertions(+)
>
> >>  create mode 100644 Documentation/devicetree/bindings/hwmon/aspeed,g6-pwm-tach.yaml
>
> >>
>
> >> diff --git a/Documentation/devicetree/bindings/hwmon/aspeed,g6-pwm-tach.yaml b/Documentation/devicetree/bindings/hwmon/aspeed,g6-pwm-tach.yaml
>
> >> new file mode 100644
>
> >> index 000000000000..1666304d0b0f
>
> >> --- /dev/null
>
> >> +++ b/Documentation/devicetree/bindings/hwmon/aspeed,g6-pwm-tach.yaml
>
> >> @@ -0,0 +1,57 @@
>
> >> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>
> >> +# Copyright (C) 2021 Aspeed, Inc.
>
> >> +%YAML 1.2
>
> >> +---
>
> >> +$id: http://devicetree.org/schemas/hwmon/aspeed,g6-pwm-tach.yaml#
>
> >> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>
> >> +
>
> >> +title: ASPEED G6 PWM and Fan Tach controller device driver
>
> >> +
>
> >> +maintainers:
>
> >> +  - Billy Tsai <billy_tsai@aspeedtech.com>
>
> >> +
>
> >> +description: |
>
> >> +  The ASPEED PWM controller can support upto 16 PWM outputs.
>
> >> +  The ASPEED Fan Tacho controller can support upto 16 fan tach input.
>
> >> +
>
> >> +properties:
>
> >> +  compatible:
>
> >> +    enum:
>
> >> +      - aspeed,ast2600-pwm-tach
>
> >> +
>
> >> +  reg:
>
> >> +    maxItems: 1
>
> >> +
>
> >> +  clocks:
>
> >> +    maxItems: 1
>
> >> +
>
> >> +  resets:
>
> >> +    maxItems: 1
>
> >> +
>
> >> +  "#pwm-cells":
>
> >> +    const: 3
>
> >> +
>
> >> +  aspeed,fan-tach-ch:
>
> >> +    description: Specify the Fan tach input channels.
>
> >> +    $ref: "/schemas/types.yaml#/definitions/uint8-array"
>
>
>
> >This property is already defined in aspeed-pwm-tacho.txt as a single u8
>
> >that goes in a fan node. You can't redefine its type and location here.
>
>
>
> Hi Rob,
>
>
>
> I didn't redefine the type of property. The type of the aspeed,fan-tach-ch is unit8-array
>
> in aspeed-pwm-tacho.txt.
>
> https://github.com/torvalds/linux/blob/master/Documentation/devicetree/bindings/hwmon/aspeed-pwm-tacho.txt#L48
>
> https://github.com/torvalds/linux/blob/master/Documentation/devicetree/bindings/hwmon/aspeed-pwm-tacho.txt#L71
>
>
>
> >To repeat what I've said in previous versions, work with others to
>
> >define a common fan and fan controller binding. Otherwise, anything new
>
> >with fan related properties is simply going to be rejected.
>
>
>
> Okay I will try to work with Naresh for defining a common fan binding.
>
>
>
> Thanks for your suggestion.
>
>
>
> Hi Naresh,
>
>
>
> As Rob mentioned, it would be advisable for my dt-bindings to reference the common fan bindings instead of introducing specific properties.
>
> I noticed that you have already submitted a related patch to the community, which seems to be pending for around 10 months.
>
> https://lore.kernel.org/lkml/20221116213615.1256297-2-Naresh.Solanki@9elements.com/
>
> Do you have plans to send the next version of the patch? Alternatively, can I proceed to cherry-pick this version of the patch and continue with
>
> the upstreaming process in my patch serial?
Sure, go ahead.

Regards,
Naresh
>
>
>
> Thanks
>
> Best Regards,
>
> Billy Tsai
