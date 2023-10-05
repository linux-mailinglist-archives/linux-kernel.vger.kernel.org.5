Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E690B7B9FE5
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Oct 2023 16:31:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231483AbjJEOaa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Oct 2023 10:30:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234144AbjJEO2c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Oct 2023 10:28:32 -0400
Received: from mail-ed1-x541.google.com (mail-ed1-x541.google.com [IPv6:2a00:1450:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBF7B21D01;
        Thu,  5 Oct 2023 02:43:30 -0700 (PDT)
Received: by mail-ed1-x541.google.com with SMTP id 4fb4d7f45d1cf-51e28cac164so4129652a12.1;
        Thu, 05 Oct 2023 02:43:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696499009; x=1697103809; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yFk1hMyZRR6j/Q7MSUiSQpNux3PKUHqj/LJOWiGIaOc=;
        b=Qan5Z/GKLo1blKcuGgBwMCp0WOHAo/yDJuTzlDQPwAxR0RhTDs1dK5Yz6Af8PiJozm
         r2pSeHQTCGv9+PqJNxESy4eWiJsVAGXEexJ1XoDJTY7v/J/95JFI/uVIRuVWRcYmxJ1k
         zP1/xq4pxt1EqbxEEjvx4hKN6DcHkZ8guYW2TP7vWYvk2er8bNS0RrSgQwuGOXaDDpzC
         OyRVvWBX9jsUcKWo3QgBboqnpf7tGEseXF1GEoCADqoCWQkP8lk3O9v7DulbNhsHhLGx
         GHBFuKWrTTvTvTFl6d7Horu/l8DHCan/lihdYCj0pTXmF77+h2cKszNFEnR3v7MdZT0f
         1EhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696499009; x=1697103809;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yFk1hMyZRR6j/Q7MSUiSQpNux3PKUHqj/LJOWiGIaOc=;
        b=dMaxldNOieM9KCdpMK9Sf2GCVWR/TCkIn4EB8n7s82njw2jDElToqwEKAELEk0xZkw
         X6UBZim7JhdUDtkoOlWcA6ylaz8RJCuS6zSh8u/6vQGyVK3USupAo0YSFaZrcsbdM7uH
         UeoYsLjzgqHnd8z5I5vWZM6zbBQMeohD9+9VT/574zNfXeJdR3LYl0iqHuj+5WP0vyE5
         eLWx4iyAj6mQdQU20g2JK2WxdIGBI5+GsRfbY3gMWY5ecR/6bVSg8RXGq+kXA9aXwT+g
         CDWqlgiY2bwRapMVs0mr8yEP0F81rIhmlf7sNTS2SEjfnEdvybMJJMdiebvPFZDwtNOb
         Z7aA==
X-Gm-Message-State: AOJu0YxA3TBh2SajVOZlmZzzHOOhXy8Q0RKS7CQxvApGLgJH4n75KV6X
        gbxYoLg22snWnFTmjuGwarLxtyxc3vbfL6wHT3knLH/8aTw=
X-Google-Smtp-Source: AGHT+IEUPEfNrlvMx3t5Sfp8v/9vGMhpyGjbTnVN6udKEfGdXvyew0SV3xmGgz4HOrJ5XMN/i8O1g6gCEDL32l2P1mg=
X-Received: by 2002:a05:6402:2037:b0:534:2e37:dfd4 with SMTP id
 ay23-20020a056402203700b005342e37dfd4mr1824893edb.1.1696499009070; Thu, 05
 Oct 2023 02:43:29 -0700 (PDT)
MIME-Version: 1.0
References: <20231005035933.31016-1-andre.werner@systec-electronic.com> <f2e2d122-f5a7-401e-a429-0a86c2c0b3ab@linaro.org>
In-Reply-To: <f2e2d122-f5a7-401e-a429-0a86c2c0b3ab@linaro.org>
From:   werneazc <werneazc@gmail.com>
Date:   Thu, 5 Oct 2023 11:43:18 +0200
Message-ID: <CAKDJRcczo+8FAfDzNBhdZb8uBx_q5zP+f_X+jdZTr0qENj6vuA@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] dt-bindings: iio: adc: ti,ads7038: Add description
 for ADS7038
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     jic23@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        lars@metafoo.de, devicetree@vger.kernel.org,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Andre Werner <andre.werner@systec-electronic.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Renaming is done and will be published in v3 version of the patch.
Waiting for remarks for the second patch file before publishing the
next version of the patch set.

Regards,
Andr=C3=A9

On Thu, Oct 5, 2023 at 9:33=E2=80=AFAM Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
>
> On 05/10/2023 05:54, werneazc@gmail.com wrote:
> > From: Andre Werner <andre.werner@systec-electronic.com>
> >
> > Add basic description for ADS7x38 ADC devices. The driver does only
> > support a very basic set of functionalities provided by the chip.
> > Also, the example in the description covers only a setup for ADS7038 de=
vices
> > while the driver structure will support both ADS7038 (SPI) and ADS7138 =
(I2C) devices.
> >
> > Signed-off-by: Andre Werner <andre.werner@systec-electronic.com>
> > ---
> > - v2: Add commit message and correct vref-description copy-paste-error.
> > ---
> >  .../bindings/iio/adc/ti,ads7038.yaml          | 51 +++++++++++++++++++
> >  1 file changed, 51 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/iio/adc/ti,ads703=
8.yaml
> >
> > diff --git a/Documentation/devicetree/bindings/iio/adc/ti,ads7038.yaml =
b/Documentation/devicetree/bindings/iio/adc/ti,ads7038.yaml
> > new file mode 100644
> > index 000000000000..d40869b9a604
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
> > +    description: Supplies the reference voltage AVDD
>
> Didn't you already get a comment that there is no vref but avdd, so
> avdd-supply?
>
>
> Best regards,
> Krzysztof
>
