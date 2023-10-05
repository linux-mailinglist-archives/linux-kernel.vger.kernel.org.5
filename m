Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F2C57B9F20
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Oct 2023 16:19:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233671AbjJEOS0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Oct 2023 10:18:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244294AbjJENwt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Oct 2023 09:52:49 -0400
Received: from mail-ed1-x542.google.com (mail-ed1-x542.google.com [IPv6:2a00:1450:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 162431BD9;
        Wed,  4 Oct 2023 20:51:53 -0700 (PDT)
Received: by mail-ed1-x542.google.com with SMTP id 4fb4d7f45d1cf-522bd411679so767196a12.0;
        Wed, 04 Oct 2023 20:51:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696477911; x=1697082711; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=roh/3oF0mjE39aoM1NTQvsLleoKoTO5BxmnoUyxuKlY=;
        b=TLTAj+pGiZ72hMjRAhGO11SIdgP4mFw36Pa9UqZ5WiuNrEBZHomSlNHGMK5i2gMt+z
         Y5vpfzx4mxDhxGhW0KkqOBdqCiYIoeZPX9xiUzR3d2mFvKVJxFcq7NnyK39MfdDoG0/C
         CLDLEUcW/PmB3D06NuBKEpuoQ6enkZwdIkCB8fnl85be/JyPVFlY+5q2iOJm1tPCRvjz
         zBPljnZfuf11Y1UIODQmggaZIykxMxy3e/WaNe2WsBAHWiWylWqhQVNqaFSiVlTmEsOq
         TNAYtGdevz60O0/MpTwoU5wMK7JIFhtHewpk7fhfi2JIp/mdPGn2iQILqJkEBDBdendb
         C0gA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696477911; x=1697082711;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=roh/3oF0mjE39aoM1NTQvsLleoKoTO5BxmnoUyxuKlY=;
        b=QknkDPRqPDuNeK4P8/w0mRdKyGTTvq5Qrm8ADiEETof5aRhmkFWWVjjakTObt0EcOP
         Rm70jcC9eLb0YmyxJF9qkqZJ7fHcIMusBd15Gy58nxh7ejF+ZRww3tpmZtXkE9FQNgA1
         dRgViZf7it9DteP4Y9vj8TsUr8v9fg8+3bi+O5GErNFty5if6EyDhUdnzg/omfS2sFkc
         BSNZx1XrQtXicaYNjp/OHdTBsIMEvthUJ4PBoOj3sW+M48lB0s6DsbfAmi5kakPCpb1G
         YEIkm6xY3ZxoxVvSKjnddSsWemjpwbtfCfJiLx3HmbGti73wgG/xdLWoZANRv9JHU8s7
         Cimg==
X-Gm-Message-State: AOJu0YzDGSr27lQjXvcF9E6tzif04HZzSfMzt8wuLgRaxggMAErIRaW4
        KbgjuVg52XTbGBwdYEBxNURZvqBuPl1W19gccNE=
X-Google-Smtp-Source: AGHT+IEkeAayZoj3Ww4/L18jOKisAzRetNqc7T3Fd0CzIXJ9UeFlREvjHH8dJ1h0z41Tx4nuo7M3G9S2wLcVicFodkM=
X-Received: by 2002:a05:6402:691:b0:534:2e79:6b01 with SMTP id
 f17-20020a056402069100b005342e796b01mr3594818edy.21.1696477911290; Wed, 04
 Oct 2023 20:51:51 -0700 (PDT)
MIME-Version: 1.0
References: <20231004102330.3713-1-andre.werner@systec-electronic.com> <20231004151150.GA3140591-robh@kernel.org>
In-Reply-To: <20231004151150.GA3140591-robh@kernel.org>
From:   werneazc <werneazc@gmail.com>
Date:   Thu, 5 Oct 2023 05:51:40 +0200
Message-ID: <CAKDJRcf4ikKWvENrg=9JW1EneY8qehD8HTxahL8x+5KxoCSQ0g@mail.gmail.com>
Subject: Re: [PATCH 1/2] dt-bindings: iio: adc: ti,ads7038: Add description
 for ADS7038
To:     Rob Herring <robh@kernel.org>
Cc:     jic23@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, lars@metafoo.de, devicetree@vger.kernel.org,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Andre Werner <andre.werner@systec-electronic.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear Mr. Herring,

On Wed, Oct 4, 2023 at 5:11=E2=80=AFPM Rob Herring <robh@kernel.org> wrote:
>
> On Wed, Oct 04, 2023 at 12:23:29PM +0200, werneazc@gmail.com wrote:
> > From: Andre Werner <andre.werner@systec-electronic.com>
> >
>
> Needs a commit message.

Added in an upcoming commit.

>
> > Signed-off-by: Andre Werner <andre.werner@systec-electronic.com>
> > ---
> >  .../bindings/iio/adc/ti,ads7038.yaml          | 51 +++++++++++++++++++
> >  1 file changed, 51 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/iio/adc/ti,ads703=
8.yaml
> >
> > diff --git a/Documentation/devicetree/bindings/iio/adc/ti,ads7038.yaml =
b/Documentation/devicetree/bindings/iio/adc/ti,ads7038.yaml
> > new file mode 100644
> > index 000000000000..37fbae95c8e6
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/iio/adc/ti,ads7038.yaml
> > @@ -0,0 +1,51 @@
> > +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/iio/adc/ti,ads7038.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: Texas Instruments ADS7038 and similar ADCs
> > +
> > +maintainers:
> > +  - Andre Werner <andre.werner@systec-electronic.com>
> > +
> > +description: |
> > +  Family of 7 channel, 12 bit ADCs with SPI/I2C interface.
> > +
> > +  Datasheet: https://www.ti.com/lit/gpn/ads7038
> > +
> > +properties:
> > +  compatible:
> > +    enum:
> > +      - ti,ads7038
> > +      - ti,ads7138
> > +
> > +  reg:
> > +    maxItems: 1
> > +
> > +  spi-max-frequency:
> > +    maximum: 60000000
> > +
> > +  vref-supply:
> > +    description: Supplies the 2.5V or 5V reference voltage
>
> I don't see that in the datasheet. It has AVDD and DVDD.

Yes, that was a copy-and-paste error from another description used as
a template.

>
> Also, looks like there are GPIOs. Those aren't ever exposed to the OS?

Yes, you are right. This is a fundamental implementation of the driver
to support the chip family. I want to add further functionalities in
upcoming commits.
I wanted to get some feedback when the first steps are done to not
reinvent everything from the beginning if something is generally
wrong in the driver structure and the way I had used the APIs.

>
> > +
> > +required:
> > +  - compatible
> > +  - reg
> > +  - vref-supply
> > +
> > +additionalProperties: false
> > +
> > +examples:
> > +  - |
> > +    spi {
> > +        #address-cells =3D <1>;
> > +        #size-cells =3D <0>;
> > +
> > +        adc@0 {
> > +            compatible =3D "ti,ads7038";
> > +            reg =3D <0>;
> > +            vref-supply =3D <&refin_supply>;
> > +            spi-max-frequency =3D <10000000>;
> > +        };
> > +    };
> > --
> > 2.42.0
> >

Regards,

Andr=C3=A9
