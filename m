Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1199804DE9
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 10:31:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231760AbjLEJbq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Dec 2023 04:31:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235523AbjLEJb2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Dec 2023 04:31:28 -0500
Received: from mail-io1-xd2c.google.com (mail-io1-xd2c.google.com [IPv6:2607:f8b0:4864:20::d2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 496AA1712;
        Tue,  5 Dec 2023 01:31:12 -0800 (PST)
Received: by mail-io1-xd2c.google.com with SMTP id ca18e2360f4ac-7b3a8366e13so213787839f.1;
        Tue, 05 Dec 2023 01:31:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701768671; x=1702373471; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RenfwwRJ+AFtvegtJNUpHv8NSTFiZxHcpwZvmM/2PSE=;
        b=Jf4/LrIFbDZ7xFNQGncpPKfItPdWPYvYBQvqI+QqmOMwThh6UPSvitMCHKxa8S/kqd
         mkV2S2Cyudo5Xu2y7ofmZcWnFfbRAxl9G+ja1ocAjON2C2PLiC6pc4o0+y3vEcHAU5Pf
         sk26WfkbDhkydsyMBHKNkPxK0RIzYLY3vpQtDW59kpJb2ec8lEEloVSPkra9qcYrCUJT
         InY0GH8u0iYrkbxDAfZ9Ch5qsrNVUto1NNp9F4BTvT4KDOoI1eBy2lXl8/pUG4+CmHvv
         NnlaY7roj3Izz6wtRo+DNGzD7wVfKNpnabOLo/DXglVOOrGu7RUhC9bv+euXskc3S/EF
         Vx/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701768671; x=1702373471;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RenfwwRJ+AFtvegtJNUpHv8NSTFiZxHcpwZvmM/2PSE=;
        b=hbhumq5+L3TpqMeTCA4teO8fDR6oVo4rgJGmUo7CjiBpLy9MM6cFUYsqNLOBpO088z
         4T43wnu5Q46WoKJxpnjJogIiKQ+WvCddHZda/NWbl/n5z06zfzcMqlT9aqm84pBhbm9j
         uaX8lVi4457uh1vA7f1xKOKv/eY0nVXVj4wrElyumxusH5KvtYrX9snp5We2FI5rJ8t3
         XvzYJoEwmAV6dl2XaAhaAg8hl4q+c6yP04ifjNmhY/Et4qtunX2e+9Dt0u+jXbq9o+zs
         sdWZoFSPxdfFodCLLGx/E8pkMY6oOTyfkVILnGujsANis+WGGEIn3JsqeZPe/wAGRZM/
         xlaA==
X-Gm-Message-State: AOJu0Yw1Rm2W0qG4VVHMoAlI3bEwokGXG/TW2sm4yema5KaR2WqlSnfS
        +REEPjNLlPMUUztS8y8XO3hyxRPswiboiRHsJ/c=
X-Google-Smtp-Source: AGHT+IFr6D6BYqWGEyE3UMSbNV71rjyqF6qvTXD3vh+DfXrYkp9XBifnGHmOK8cQ4HX10HYIwoHFe7lh2PJHgyC+q1I=
X-Received: by 2002:a5d:974a:0:b0:7b4:28f8:1dfa with SMTP id
 c10-20020a5d974a000000b007b428f81dfamr7247279ioo.25.1701768671291; Tue, 05
 Dec 2023 01:31:11 -0800 (PST)
MIME-Version: 1.0
References: <20231204055650.788388-1-kcfeng0@nuvoton.com> <20231204055650.788388-2-kcfeng0@nuvoton.com>
 <94607c47-9824-4e2c-8f22-99ca2e088b27@linaro.org>
In-Reply-To: <94607c47-9824-4e2c-8f22-99ca2e088b27@linaro.org>
From:   Ban Feng <baneric926@gmail.com>
Date:   Tue, 5 Dec 2023 17:31:00 +0800
Message-ID: <CALz278ZbjcbjUmFKv4B20DPDW33KPW-nZn4if3qTLjYKZZmWWw@mail.gmail.com>
Subject: Re: [PATCH v1 1/2] dt-bindings: hwmon: Add nct736x bindings
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     jdelvare@suse.com, linux@roeck-us.net, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        corbet@lwn.net, linux-hwmon@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, openbmc@lists.ozlabs.org,
        kwliu@nuvoton.com, kcfeng0@nuvoton.com, DELPHINE_CHIU@wiwynn.com,
        Bonnie_Lo@wiwynn.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Krzysztof,

On Mon, Dec 4, 2023 at 4:04=E2=80=AFPM Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
>
> On 04/12/2023 06:56, baneric926@gmail.com wrote:
> > From: Ban Feng <kcfeng0@nuvoton.com>
> >
> > This change documents the device tree bindings for the Nuvoton
> > NCT7362Y, NCT7363Y driver.
> >
> > Signed-off-by: Ban Feng <kcfeng0@nuvoton.com>
> > ---
> >  .../bindings/hwmon/nuvoton,nct736x.yaml       | 80 +++++++++++++++++++
> >  MAINTAINERS                                   |  6 ++
> >  2 files changed, 86 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/hwmon/nuvoton,nct=
736x.yaml
> >
> > diff --git a/Documentation/devicetree/bindings/hwmon/nuvoton,nct736x.ya=
ml b/Documentation/devicetree/bindings/hwmon/nuvoton,nct736x.yaml
> > new file mode 100644
> > index 000000000000..f98fd260a20f
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/hwmon/nuvoton,nct736x.yaml
> > @@ -0,0 +1,80 @@
> > +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> > +%YAML 1.2
> > +---
> > +
> > +$id: http://devicetree.org/schemas/hwmon/nuvoton,nct736x.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: Nuvoton NCT736X Hardware Monitoring IC
> > +
> > +maintainers:
> > +  - Ban Feng <kcfeng0@nuvoton.com>
> > +
> > +description: |
> > +  The NCT736X is a Fan controller which provides up to 16 independent
> > +  FAN input monitors, and up to 16 independent PWM output with SMBus i=
nterface.
> > +  Besides, NCT7363Y has a built-in watchdog timer which is used for
> > +  conditionally generating a system reset output (INT#).
> > +
> > +additionalProperties: false
>
> Please place it just like other bindings are placing it. Not in some
> random order. See example-schema.

ok, I'll move additionalProperties to the correct place.

>
> You should use common fan properties. If it was not merged yet, you must
> rebase on patchset on LKML and mention the dependency in the change log
> (---).

please kindly see below

>
> > +
> > +properties:
> > +  compatible:
> > +    enum:
> > +      - nuvoton,nct7362
> > +      - nuvoton,nct7363
> > +
> > +  reg:
> > +    maxItems: 1
> > +
> > +  nuvoton,pwm-mask:
> > +    description: |
> > +      each bit means PWMx enable/disable setting, where x =3D 0~15.
> > +      0: disabled, 1: enabled
> > +    $ref: /schemas/types.yaml#/definitions/uint32
> > +    minimum: 0x0
> > +    maximum: 0xFFFF
> > +    default: 0x0
>
> Use pwms, not own property for this.

NCT736X has 16 funtion pins, they can be
GPIO/PWM/FANIN/Reserved_or_ALERT#, and default is GPIO.
We would like to add such a property that can configure the function
pin for pin0~7 and pin10~17.

My original design is only for PWM/FANIN, however,
I noticed that we can change the design to "nuvoton,pin[0-7]$" and
"nuvoton,pin[10-17]$", like example in adt7475.yaml.
I'm not sure if this can be accepted or not, please kindly review this.

>
> > +
> > +  nuvoton,fanin-mask:
> > +    description: |
> > +      each bit means FANINx monitoring enable/disable setting,
> > +      where x =3D 0~15.
> > +      0: disabled, 1: enabled
> > +    $ref: /schemas/types.yaml#/definitions/uint32
> > +    minimum: 0x0
> > +    maximum: 0xFFFF
> > +    default: 0x0
>
> Use properties from common fan bindings.

Ditto

>
> > +
> > +  nuvoton,wdt-timeout:
> > +    description: |
> > +      Watchdog Timer time configuration for NCT7363Y, as below
> > +      0: 15 sec (default)
> > +      1: 7.5 sec
> > +      2: 3.75 sec
> > +      3: 30 sec
> > +    $ref: /schemas/types.yaml#/definitions/uint32
> > +    enum: [0, 1, 2, 3]
> > +    default: 0
>
> Nope, reference watchdog.yaml and use its properties. See other watchdog
> bindings for examples.

NCT7363 has a built-in watchdog timer which is used for conditionally
generating a system reset
output (INT#) if the microcontroller or microprocessor stops to
periodically send a pulse signal or
interface communication access signal like SCL signal from SMBus interface.

We only consider "Watchdog Timer Configuration Register" enable bit
and timeout setting.
Should we still need to add struct watchdog_device to struct nct736x_data?

>
> > +
> > +required:
> > +  - compatible
> > +  - reg
> > +  - nuvoton,pwm-mask
> > +  - nuvoton,fanin-mask
> > +
> > +examples:
> > +  - |
> > +    i2c {
> > +        #address-cells =3D <1>;
> > +        #size-cells =3D <0>;
> > +
> > +        nct7363@22 {
>
> Node names should be generic. See also an explanation and list of
> examples (not exhaustive) in DT specification:
> https://devicetree-specification.readthedocs.io/en/latest/chapter2-device=
tree-basics.html#generic-names-recommendation

ok, I'll change nct7363@22 to hwmon@22.

Thanks,
Ban
