Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 520F0761B47
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jul 2023 16:20:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232574AbjGYOUz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jul 2023 10:20:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232553AbjGYOUq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jul 2023 10:20:46 -0400
Received: from mail-io1-xd2c.google.com (mail-io1-xd2c.google.com [IPv6:2607:f8b0:4864:20::d2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 357452690
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jul 2023 07:18:52 -0700 (PDT)
Received: by mail-io1-xd2c.google.com with SMTP id ca18e2360f4ac-78654448524so197749439f.2
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jul 2023 07:18:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=9elements.com; s=google; t=1690294639; x=1690899439;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=5zbYkfh1SiDjJgqpmePBnLBoSwyu543XXUBw08SwriI=;
        b=V6SpvZQnSwXd0cziqK5ZBgj+giZ3kTGHlNOo0Kyo2vuouII4BN1LlbqKfw4l2v+pFR
         RhaJROiPVwXpZNL2loi1avSfzBpAPSN5I/blvkKx8nihlRfbQzNRGoY0R0s9/p2hwJxm
         LBg3EuPYuNqnYsDUCRx2SklUAjnF9l/Z8eD4/d9xW0nZVQyi1g8b5EE3PuE1FxpzrXgW
         tbTdQ14YwCC73g9J/Gb7HdDQo3mRkLJ1LJBPzLiHsVGwbc6h8YTKQc+rwNyxX9w2jk8x
         N39n49amyD4Xf4Mw8Zcdf36FTv1DfCglG2JljEcEIGA8669+cYCCSETiUnZCrg8+t8JL
         RIqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690294639; x=1690899439;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5zbYkfh1SiDjJgqpmePBnLBoSwyu543XXUBw08SwriI=;
        b=jaOwrQzfWvZ7+2Zg4qps5M92WvEbPy/mtmO1tukowlXWufwsotp2dS0nsE8TnMtwHs
         N4NCEAbrq0JP19hLz14Lb4iiNanGe1dtd5YfzSCxpGo3b5BW0BzDzXZYDKrhhEiMixWO
         MoAQeb2Fmvj9TUYGidjiu9yYV4NykV54lgneyJybQ2qbKWH8vETeenPqZcypwlUKZUAp
         cHL9ImHIKE5GNP4h1BOZsvoyUyd/tsQ7C4OSF67YLsKcGPu+77KU382RBRX4YJ//H56Z
         sJgU8uIQbysge6bfP9IKD6R1f/BO1rwl1g11r/tbCpEBos6lAHXZcF1wzuf6UtYhcPxg
         2fiw==
X-Gm-Message-State: ABy/qLZvUzUaKSx4hk7j//fVYeQwa5CbKzpMtd0W/NxAvP1X8sG3I0uM
        H6D2LbJ0/aWwvRjQvsQEWLa9Y1Zlx8XGMWmxxV6RnA==
X-Google-Smtp-Source: APBJJlESVOsBHoa/sJ5VjYkg6XtupM70WUQs7FfzV+C9VGLCYKZr0yzLZXvlnWCeUUMe64jWPzi9qNjCF7n6bmFaJ9k=
X-Received: by 2002:a05:6e02:20ec:b0:346:77f7:e0e with SMTP id
 q12-20020a056e0220ec00b0034677f70e0emr3258932ilv.23.1690294639174; Tue, 25
 Jul 2023 07:17:19 -0700 (PDT)
MIME-Version: 1.0
References: <20230725114030.1860571-1-Naresh.Solanki@9elements.com> <20230725131006.GA2879331-robh@kernel.org>
In-Reply-To: <20230725131006.GA2879331-robh@kernel.org>
From:   Naresh Solanki <naresh.solanki@9elements.com>
Date:   Tue, 25 Jul 2023 19:47:09 +0530
Message-ID: <CABqG17iChAyb0gzb2uXfsv5GkiM3a+LoSavdqhjvw3FUccaw8A@mail.gmail.com>
Subject: Re: [PATCH 1/3] dt-bindings: hwmon: Add Infineon TDA38640
To:     Rob Herring <robh@kernel.org>
Cc:     Guenter Roeck <linux@roeck-us.net>,
        Jean Delvare <jdelvare@suse.com>,
        krzysztof.kozlowski+dt@linaro.org,
        Conor Dooley <conor+dt@kernel.org>,
        linux-hwmon@vger.kernel.org,
        Patrick Rudolph <patrick.rudolph@9elements.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rob,


On Tue, 25 Jul 2023 at 18:40, Rob Herring <robh@kernel.org> wrote:
>
> On Tue, Jul 25, 2023 at 01:40:26PM +0200, Naresh Solanki wrote:
> > From: Patrick Rudolph <patrick.rudolph@9elements.com>
> >
> > The TDA38640 has a bug in SVID mode and to enable a workaround
> > remove the TDA38640 from trivial-devices and add a complete schema.
> >
> > The schema adds the custom property 'infineon,en-pin-fixed-level' to
> > signal a fixed level on the ENABLE pin and to enable the workaround.
> > When the ENABLE pin is left floating it's internally pulled low.
> >
> > If not specified the driver will continue to use the PMBUS_OPERATION
> > register to enable the regulator. When specified the driver will use
> > the PMBUS_ON_OFF_CONFIG register to enable the regulator.
> >
> > Signed-off-by: Patrick Rudolph <patrick.rudolph@9elements.com>
> > Signed-off-by: Naresh Solanki <Naresh.Solanki@9elements.com>
> > ---
> >  .../hwmon/pmbus/infineon,tda38640.yaml        | 50 +++++++++++++++++++
> >  .../devicetree/bindings/trivial-devices.yaml  |  2 -
> >  2 files changed, 50 insertions(+), 2 deletions(-)
> >  create mode 100644 Documentation/devicetree/bindings/hwmon/pmbus/infineon,tda38640.yaml
> >
> > diff --git a/Documentation/devicetree/bindings/hwmon/pmbus/infineon,tda38640.yaml b/Documentation/devicetree/bindings/hwmon/pmbus/infineon,tda38640.yaml
> > new file mode 100644
> > index 000000000000..520112e4e271
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/hwmon/pmbus/infineon,tda38640.yaml
> > @@ -0,0 +1,50 @@
> > +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> > +%YAML 1.2
> > +---
> > +
> > +$id: http://devicetree.org/schemas/hwmon/pmbus/infineon,tda38640.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: Infineon TDA38640 Synchronous Buck Regulator with SVID and I2C
> > +
> > +description: |
> > +  The Infineon TDA38640 is a 40A Single-voltage Synchronous Buck
> > +  Regulator with SVID and I2C designed for Industrial use.
> > +
> > +  Datasheet: https://www.infineon.com/dgdl/Infineon-TDA38640-0000-DataSheet-v02_04-EN.pdf?fileId=8ac78c8c80027ecd018042f2337f00c9
> > +
> > +properties:
> > +  compatible:
> > +    enum:
> > +      - infineon,tda38640
> > +
> > +  reg:
> > +    maxItems: 1
> > +
> > +  infineon,en-pin-fixed-level:
> > +    $ref: /schemas/types.yaml#/definitions/uint32
> > +    description: |
> > +      Fixed level of the ENABLE pin. When specified the PMBUS_ON_OFF_CONFIG
> > +      register is used to enable the regulator instead of the PMBUS_OPERATION
> > +      register to workaround a bug of the tda38640 when operating in SVID-mode.
> > +      If the ENABLE pin is left floating the internal pull-down causes a low
> > +      level on the pin.
>
> Neither this nor the commit message answers how do I decide if I set
> this property or not? How you work-around it is not that relevant to the
> binding.
Sure will update this as:
The property becomes relevant when dealing with the tda38640 in
SVID-mode, providing an alternative method to enable the regulator by
using the PMBUS_ON_OFF_CONFIG register instead of the PMBUS_OPERATION
register

Regards,
Naresh
>
> > +
> > +required:
> > +  - compatible
> > +  - reg
> > +
> > +additionalProperties: false
> > +
> > +examples:
> > +  - |
> > +    i2c {
> > +        #address-cells = <1>;
> > +        #size-cells = <0>;
> > +
> > +        tda38640@40 {
> > +            compatible = "infineon,tda38640";
> > +            reg = <0x40>;
> > +        };
> > +    };
> > +
> > diff --git a/Documentation/devicetree/bindings/trivial-devices.yaml b/Documentation/devicetree/bindings/trivial-devices.yaml
> > index 6e24c4d25ec3..2b1fbb2a672b 100644
> > --- a/Documentation/devicetree/bindings/trivial-devices.yaml
> > +++ b/Documentation/devicetree/bindings/trivial-devices.yaml
> > @@ -151,8 +151,6 @@ properties:
> >            - infineon,slb9645tt
> >              # Infineon SLB9673 I2C TPM 2.0
> >            - infineon,slb9673
> > -            # Infineon TDA38640 Voltage Regulator
> > -          - infineon,tda38640
> >              # Infineon TLV493D-A1B6 I2C 3D Magnetic Sensor
> >            - infineon,tlv493d-a1b6
> >              # Infineon Multi-phase Digital VR Controller xdpe11280
> >
> > base-commit: 55612007f16b5d7b1fb83a7b0f5bb686829db7c7
> > --
> > 2.41.0
> >
