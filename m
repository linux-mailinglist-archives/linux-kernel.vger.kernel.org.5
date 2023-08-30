Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8760178E0DA
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Aug 2023 22:43:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240253AbjH3Una (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Aug 2023 16:43:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239763AbjH3UnR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Aug 2023 16:43:17 -0400
Received: from mail-qt1-x82d.google.com (mail-qt1-x82d.google.com [IPv6:2607:f8b0:4864:20::82d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56C704204
        for <linux-kernel@vger.kernel.org>; Wed, 30 Aug 2023 13:29:45 -0700 (PDT)
Received: by mail-qt1-x82d.google.com with SMTP id d75a77b69052e-41095b84d8eso601121cf.2
        for <linux-kernel@vger.kernel.org>; Wed, 30 Aug 2023 13:29:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=9elements.com; s=google; t=1693427283; x=1694032083; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=J6hWfbIynnUP5BUpdi9sNEghPSzuJ8hcWhPiubhMdyQ=;
        b=DELDk1uORZONDwms8jfBUcF4ytRKlH2BRilYWRYhp1CqA+SBB2m+aEz2zZynQ2eJ09
         JuzVhScu0dkHrYJkzTBKQLnGXITvzuKg87CZx74w3N4dGCVRmQI6/azOVJYQUjCdgwfN
         e4adB66WuGdFMt/ng57IRH6pKvuLEwp4s8mawtmbVVgy2SJ1nTx2oKqCDJfI/Kuxz0c5
         zY2tqPeWKhdSVLB29+5joi+qzqf5dAoRVQxfvEgxc1Bxm31IvD9YjPFsdLPfkFp7bD/b
         PpFjkFIk/GZn9Q7vYR0WWhf7fSBwyMYm+auH9VJ5RW/u/WGzLTGPAbiP/Prv39q4NmEO
         Mnlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693427283; x=1694032083;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=J6hWfbIynnUP5BUpdi9sNEghPSzuJ8hcWhPiubhMdyQ=;
        b=hK6AdV14ViZb4CTlBZqKZ5xtfnAjpqgME+998YI6tA0sjnaGZmg30y/IXIyv2yHeEh
         QWoBT6W/LgV2GFg/r9rSTN4ek5YUGY2QcwspiSqLXiN2OQfWg+K/Q7ZM9LlqX6HECduL
         lWdCqWqinVQcfsXB+fnTOfoKEN1miLHlLht43FLuopMp++tf2MMefOG5k0tRVlRCSNZ4
         Y8p+qtIQvizjDUIJ82s8RvC9Nizw0Cb9Ond73zKwDvZhrV5JSJZ9H4bUjQ0zAmAQwQdF
         bIVNo5he4K1UduPbQSIAZreOOaFscrlNdryR9ryCAK319kmhJZgTDrXoBdmU/CXmS9je
         JtnQ==
X-Gm-Message-State: AOJu0YznxC03r17H8C8jhVVHuTZBlLlLcTCKDx2mMA+gFDW9Xqjt7Fbw
        YYE5dbHgqtxAPHg2/s9nhPgKKNFajuRRNoAvhC1YC7kKKqGfQInBbpM=
X-Google-Smtp-Source: AGHT+IFJ1DxDSDn+rxq1FvriBdkBpWWLRYcjePAYy/X7OVYKimW7wLrpeqNTC6UptcyifchQtbuSRLu3srnYZpvyNiE=
X-Received: by 2002:a17:90b:38c3:b0:26d:49c8:78aa with SMTP id
 nn3-20020a17090b38c300b0026d49c878aamr3089232pjb.32.1693423182647; Wed, 30
 Aug 2023 12:19:42 -0700 (PDT)
MIME-Version: 1.0
References: <20230830103620.3611761-1-Naresh.Solanki@9elements.com> <20230830-waving-stinky-d510fefbbf82@spud>
In-Reply-To: <20230830-waving-stinky-d510fefbbf82@spud>
From:   Naresh Solanki <naresh.solanki@9elements.com>
Date:   Thu, 31 Aug 2023 00:49:32 +0530
Message-ID: <CABqG17hvSYbsnYYGOQxVsiXsqLXFnovXvkhgc=pYR9osgF0-1g@mail.gmail.com>
Subject: Re: [PATCH v4 1/3] dt-bindings: hwmon: Add Infineon TDA38640
To:     Conor Dooley <conor@kernel.org>
Cc:     Guenter Roeck <linux@roeck-us.net>,
        Jean Delvare <jdelvare@suse.com>,
        krzysztof.kozlowski+dt@linaro.org,
        Rob Herring <robh+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        linux-hwmon@vger.kernel.org,
        Patrick Rudolph <patrick.rudolph@9elements.com>,
        Rob Herring <robh@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
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

Hi

On Wed, 30 Aug 2023 at 21:02, Conor Dooley <conor@kernel.org> wrote:
>
> Hey,
>
> On Wed, Aug 30, 2023 at 12:36:16PM +0200, Naresh Solanki wrote:
> > From: Patrick Rudolph <patrick.rudolph@9elements.com>
> >
> > Add the DT property 'infineon,en-pin-fixed-level' to
> > indicated that the chip ENABLE pin is at fixed level
> > or left unconnected(has internal pull-down).
> >
> > Signed-off-by: Patrick Rudolph <patrick.rudolph@9elements.com>
> > Signed-off-by: Naresh Solanki <Naresh.Solanki@9elements.com>
> > ----
> > Changes in V4:
> > - Update property name & description.
> > - Update commit message.
> > ---
> >  .../hwmon/pmbus/infineon,tda38640.yaml        | 50 +++++++++++++++++++
> >  .../devicetree/bindings/trivial-devices.yaml  |  2 -
> >  2 files changed, 50 insertions(+), 2 deletions(-)
> >  create mode 100644 Documentation/devicetree/bindings/hwmon/pmbus/infineon,tda38640.yaml
> >
> > diff --git a/Documentation/devicetree/bindings/hwmon/pmbus/infineon,tda38640.yaml b/Documentation/devicetree/bindings/hwmon/pmbus/infineon,tda38640.yaml
> > new file mode 100644
> > index 000000000000..1df40ee7454a
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
> > +maintainers:
> > +  - Naresh Solanki <naresh.solanki@9elements.com>
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
> > +    description: |
>
> The | isn't needed when there is no formatting requiring preservation.
Sure will remove.
>
> > +      Indicates that the chip ENABLE pin is at fixed level or left
> > +      unconnected(has internal pull-down).
>
> Maybe you've already been over this, but if the pin is called "enable"
> why not use the same wording in the property?
EN & ENABLE is used interchangeably in the datasheet.
Just to keep property name short I use EN.
>
> > +    type: boolean
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
>
> Use a generic node name please.
>
> Thanks,
> Conor.
>
> > +            compatible = "infineon,tda38640";
> > +            reg = <0x40>;
> > +        };
> > +    };
> > +
> > diff --git a/Documentation/devicetree/bindings/trivial-devices.yaml b/Documentation/devicetree/bindings/trivial-devices.yaml
> > index 40bc475ee7e1..86c7d34f63bf 100644
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
> > base-commit: 919a83d020a8dfa1411c1dc1cff23a833f0f5268
> > --
> > 2.41.0
> >
