Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE0DD809A03
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Dec 2023 04:05:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1573007AbjLHDF1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Dec 2023 22:05:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229531AbjLHDFZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Dec 2023 22:05:25 -0500
Received: from mail-io1-xd33.google.com (mail-io1-xd33.google.com [IPv6:2607:f8b0:4864:20::d33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08BB610CA;
        Thu,  7 Dec 2023 19:05:32 -0800 (PST)
Received: by mail-io1-xd33.google.com with SMTP id ca18e2360f4ac-7b459364167so59769439f.2;
        Thu, 07 Dec 2023 19:05:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702004731; x=1702609531; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AZaXVtqBhppjXjmoqpUNuqDGGoegj5M4hSRf/Ke94IU=;
        b=jZ/0AoWTkNbRvDqkB0cMTs2nMhx8kg8Xy2/qnlqd8B1cohUeKNrewbXRTIxg1h2TEL
         D2XLuFN2xmfWd2tdeKBOwwYMlMTWUMD5hXeAZVrvg9evagFXzC/hQeEKexM+BSU822DG
         5U4TFWTsW6zqBs8gGqQZGaN9HXP2NFwEGulWBpZCqRRr0Q4KuEHS9mDC7sfFSs4e49OB
         uZ7qH25cXJ8iRZdytCHiyz6Z+kMwdhSB+3hj5YeAmBvWby4y3RA0FV6RtqKell8aHURo
         AKgiu5SY0X5f6PT9r9xMRQkrqmUOTYNZLm1LLzw8Mk6zdmnQ9XDTo8p1cMIri8uSe+Sp
         Ywnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702004731; x=1702609531;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AZaXVtqBhppjXjmoqpUNuqDGGoegj5M4hSRf/Ke94IU=;
        b=a8wzRT8L5GkwiM8kFsuW2lpvRgo16Ncs+1Dm2197iYdaoRse8Zrp+Ey5iIFQFDZOrh
         19v42lMbXaCdQlpmid56VhTpI7IjyM4Jsfnsgzury9yWZP+PTapbAwRnOs9CZI8PoJ+5
         vMLuMkqlYsTMYfJDt5bauASCcNyh5FY/WU+PF9tr77437DCPVmFD6DRvUJm441Fo5FaO
         BJZo69bCZ0kgRtJ+xHzCYcDUrrGUMClwcnrHCIiPJuOELvncn1eJb3kk1ruilta/6vJE
         9F+PJEZE1JCQe8asElyRB4fgndKBSd20FnGB0BnXIvDRdO9LOwdHbwsAqUUo4AXS2OZb
         FAIw==
X-Gm-Message-State: AOJu0YzFs7kg6yaymfVv9+FFyj2bKypK/PRJ8bZf9yzylr7XBO+ugV3k
        bWZ7uzNLf+9MQiwwgEIuTL7dLfO/NapmfhP8qpk=
X-Google-Smtp-Source: AGHT+IHF2JAlxWeFTtregJQGo3fmEDecpJk0nQOZc5AqeUlVlnkR7CF7wXQ3t5CKlmvWcvePrVpWNlde8WGkU4sXJ8w=
X-Received: by 2002:a92:4b11:0:b0:35d:59a2:a321 with SMTP id
 m17-20020a924b11000000b0035d59a2a321mr3826015ilg.35.1702004731225; Thu, 07
 Dec 2023 19:05:31 -0800 (PST)
MIME-Version: 1.0
References: <20231204055650.788388-1-kcfeng0@nuvoton.com> <20231204055650.788388-2-kcfeng0@nuvoton.com>
 <94607c47-9824-4e2c-8f22-99ca2e088b27@linaro.org> <CALz278ZbjcbjUmFKv4B20DPDW33KPW-nZn4if3qTLjYKZZmWWw@mail.gmail.com>
 <4770f744-2309-4de0-8aaf-a221f69c08b7@linaro.org>
In-Reply-To: <4770f744-2309-4de0-8aaf-a221f69c08b7@linaro.org>
From:   Ban Feng <baneric926@gmail.com>
Date:   Fri, 8 Dec 2023 11:05:20 +0800
Message-ID: <CALz278bVoO=bKzgTbV7zBQHLwuKBB2PSxHMyxRYn3HWMA6z8xw@mail.gmail.com>
Subject: [PATCH v1 1/2] dt-bindings: hwmon: Add nct736x bindings
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     "jdelvare@suse.com" <jdelvare@suse.com>,
        "linux@roeck-us.net" <linux@roeck-us.net>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "conor+dt@kernel.org" <conor+dt@kernel.org>,
        "corbet@lwn.net" <corbet@lwn.net>,
        "linux-hwmon@vger.kernel.org" <linux-hwmon@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "openbmc@lists.ozlabs.org" <openbmc@lists.ozlabs.org>,
        "kwliu@nuvoton.com" <kwliu@nuvoton.com>,
        "kcfeng0@nuvoton.com" <kcfeng0@nuvoton.com>,
        "DELPHINE_CHIU@wiwynn.com" <DELPHINE_CHIU@wiwynn.com>,
        "Bonnie_Lo@wiwynn.com" <Bonnie_Lo@wiwynn.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Krzysztof,

On Tuesday, December 5, 2023, Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
>
> On 05/12/2023 10:31, Ban Feng wrote:
> > Hi Krzysztof,
> >
> > On Mon, Dec 4, 2023 at 4:04=E2=80=AFPM Krzysztof Kozlowski
> > <krzysztof.kozlowski@linaro.org> wrote:
> >>
> >> On 04/12/2023 06:56, baneric926@gmail.com wrote:
> >>> From: Ban Feng <kcfeng0@nuvoton.com>
> >>>
> >>> This change documents the device tree bindings for the Nuvoton
> >>> NCT7362Y, NCT7363Y driver.
> >>>
> >>> Signed-off-by: Ban Feng <kcfeng0@nuvoton.com>
> >>> ---
> >>>  .../bindings/hwmon/nuvoton,nct736x.yaml       | 80 +++++++++++++++++=
++
> >>>  MAINTAINERS                                   |  6 ++
> >>>  2 files changed, 86 insertions(+)
> >>>  create mode 100644 Documentation/devicetree/bindings/hwmon/nuvoton,n=
ct736x.yaml
> >>>
> >>> diff --git a/Documentation/devicetree/bindings/hwmon/nuvoton,nct736x.=
yaml b/Documentation/devicetree/bindings/hwmon/nuvoton,nct736x.yaml
> >>> new file mode 100644
> >>> index 000000000000..f98fd260a20f
> >>> --- /dev/null
> >>> +++ b/Documentation/devicetree/bindings/hwmon/nuvoton,nct736x.yaml
> >>> @@ -0,0 +1,80 @@
> >>> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> >>> +%YAML 1.2
> >>> +---
> >>> +
> >>> +$id: http://devicetree.org/schemas/hwmon/nuvoton,nct736x.yaml#
> >>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> >>> +
> >>> +title: Nuvoton NCT736X Hardware Monitoring IC
> >>> +
> >>> +maintainers:
> >>> +  - Ban Feng <kcfeng0@nuvoton.com>
> >>> +
> >>> +description: |
> >>> +  The NCT736X is a Fan controller which provides up to 16 independen=
t
> >>> +  FAN input monitors, and up to 16 independent PWM output with SMBus=
 interface.
> >>> +  Besides, NCT7363Y has a built-in watchdog timer which is used for
> >>> +  conditionally generating a system reset output (INT#).
> >>> +
> >>> +additionalProperties: false
> >>
> >> Please place it just like other bindings are placing it. Not in some
> >> random order. See example-schema.
> >
> > ok, I'll move additionalProperties to the correct place.
> >
> >>
> >> You should use common fan properties. If it was not merged yet, you mu=
st
> >> rebase on patchset on LKML and mention the dependency in the change lo=
g
> >> (---).
> >
> > please kindly see below
> >
> >>
> >>> +
> >>> +properties:
> >>> +  compatible:
> >>> +    enum:
> >>> +      - nuvoton,nct7362
> >>> +      - nuvoton,nct7363
> >>> +
> >>> +  reg:
> >>> +    maxItems: 1
> >>> +
> >>> +  nuvoton,pwm-mask:
> >>> +    description: |
> >>> +      each bit means PWMx enable/disable setting, where x =3D 0~15.
> >>> +      0: disabled, 1: enabled
> >>> +    $ref: /schemas/types.yaml#/definitions/uint32
> >>> +    minimum: 0x0
> >>> +    maximum: 0xFFFF
> >>> +    default: 0x0
> >>
> >> Use pwms, not own property for this.
> >
> > NCT736X has 16 funtion pins, they can be
> > GPIO/PWM/FANIN/Reserved_or_ALERT#, and default is GPIO.
> > We would like to add such a property that can configure the function
> > pin for pin0~7 and pin10~17.
>
> It looks you are writing custom pinctrl instead of using standard
> bindings and frameworks.


Please kindly see below

>
>
> >
> > My original design is only for PWM/FANIN, however,
> > I noticed that we can change the design to "nuvoton,pin[0-7]$" and
> > "nuvoton,pin[10-17]$", like example in adt7475.yaml.
> > I'm not sure if this can be accepted or not, please kindly review this.
>
> It looks like the same problem as with other fan/Nuvoton bindings we
> discussed some time ago on the lists.
>
> Please do not duplicate threads, work and reviews:
> https://lore.kernel.org/all/20230607101827.8544-5-zev@bewilderbeest.net/
>
> I already gave same comments there.


Thanks for your kindly sharing. I noticed that [1] defines some useful
properties, pwms and tach-ch, like you mentioned.

Therefore, I'll modify our design to follow the common fan properties in v2=
.

[1] https://lists.openwall.net/linux-kernel/2023/11/07/406

>
>
> >>> +  nuvoton,wdt-timeout:
> >>> +    description: |
> >>> +      Watchdog Timer time configuration for NCT7363Y, as below
> >>> +      0: 15 sec (default)
> >>> +      1: 7.5 sec
> >>> +      2: 3.75 sec
> >>> +      3: 30 sec
> >>> +    $ref: /schemas/types.yaml#/definitions/uint32
> >>> +    enum: [0, 1, 2, 3]
> >>> +    default: 0
> >>
> >> Nope, reference watchdog.yaml and use its properties. See other watchd=
og
> >> bindings for examples.
> >
> > NCT7363 has a built-in watchdog timer which is used for conditionally
> > generating a system reset
> > output (INT#) if the microcontroller or microprocessor stops to
> > periodically send a pulse signal or
> > interface communication access signal like SCL signal from SMBus interf=
ace.
> >
> > We only consider "Watchdog Timer Configuration Register" enable bit
> > and timeout setting.
> > Should we still need to add struct watchdog_device to struct nct736x_da=
ta?
>
> I do not see correlation between watchdog.yaml and some struct. I did
> not write anything about driver, so I don't understand your comments.
>
> Anyway, I don't like that we are duplicating entire effort and our
> review. Please join existing discussions, threads and build on top of it.
>

Thanks, I'll remove unused function in hwmon subsystem,
and consider a watchdog subsystem design if necessary.

>
> Best regards,
> Krzysztof
>
