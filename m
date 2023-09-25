Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46D0B7ADD65
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Sep 2023 18:48:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232294AbjIYQsw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Sep 2023 12:48:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbjIYQsv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Sep 2023 12:48:51 -0400
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB5B5A3;
        Mon, 25 Sep 2023 09:48:43 -0700 (PDT)
Received: by mail-lj1-x232.google.com with SMTP id 38308e7fff4ca-2bffc55af02so110705511fa.2;
        Mon, 25 Sep 2023 09:48:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695660522; x=1696265322; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=OgBsAd/QWJQgGJNC3m+4R0/2TnVRrjSUYCfTXHiq3R0=;
        b=CeNOiIpxlGo/qqEoOTMXgWc9mkaiLstxCE7aIvIndpegv5loU7zsHFEV0ywsN/sVCZ
         VURvy1XVOGfNzYjekM1oYR/fO1nGYauGogu29lGv/ZK9Z8rhyagXMJwt6uD4/b/w0SVz
         xJeoRXJz1HPOXxDeJ6X3DJUq6e85xUGbfjTFKY7oHVrj9atPK8cLQKI8gd6y7L1hC7Hi
         sbDKI0AE3u2dVFWqGBq4CJIrsmMh0gNBY9N4IBBFDRm6o1eBRZVt8s+Q8zAv3Uu5L0//
         Pqo29x/yaOAnj4E8c27KG//R9dHC3EUs9ERDJ//A+iySfFBGqdcVsPwuDKcAAjk91Me8
         rFMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695660522; x=1696265322;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=OgBsAd/QWJQgGJNC3m+4R0/2TnVRrjSUYCfTXHiq3R0=;
        b=tDjtKcKmB4+Vfye++hH35zJho+kSsxI/e/EafyrqxZBj+2fKsOB+sWzrz0SwvzwtQq
         0Mhbr/I6EpAitrI0oPNqogFFouf1M4bClZ6eSq3vIBgOEljCSyen3HanhO/Qvk4/7kfS
         8HNVzua4/hM2aam6orrWrc/toepFbt0K0o07qDyIfWcDAnx+t8vCWSnW7MvcjSFm47Jw
         tvT5M8CCvUOqqbzD4LqcWID83jSh+LkvymSklsgbsDxz9lgcMEDAjvJIGfAVxw4oMdvT
         fYluhY2hO1ZkvBy8j3aYxq7AMPD2wovCAJ/7dUJY83aPxJT4CmcMIdiwFYXLZb0nnRvg
         FJPQ==
X-Gm-Message-State: AOJu0YxJTCPTMtAVMqmZ/o2pQmw2EbwUte94GPKfRauuO95XIMs2dFy2
        rM7eH8jhxE+YGZJua/imDdk=
X-Google-Smtp-Source: AGHT+IFza5MB8Jk1iCt4fMZi9+1R0Nd9dmGgy/HoAlNgj3C7VZ7/bNvxWVPNh8U3bwD7JlXE0Vtbng==
X-Received: by 2002:a2e:320b:0:b0:2bc:f39b:d1a8 with SMTP id y11-20020a2e320b000000b002bcf39bd1a8mr5832755ljy.46.1695660521516;
        Mon, 25 Sep 2023 09:48:41 -0700 (PDT)
Received: from [192.168.1.161] ([46.31.31.132])
        by smtp.gmail.com with ESMTPSA id j8-20020a2e8008000000b002bcc303bbffsm2172830ljg.104.2023.09.25.09.48.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Sep 2023 09:48:41 -0700 (PDT)
Message-ID: <f8735a6d81d485eb8e822e4fd55a00269ae688c2.camel@gmail.com>
Subject: Re: [PATCH 1/2] dt-bindings: adc: provide max34408/9 device tree
 binding document
From:   Ivan Mikhaylov <fr0st61te@gmail.com>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Date:   Mon, 25 Sep 2023 19:48:39 +0300
In-Reply-To: <20230924135359.6404a867@jic23-huawei>
References: <20230917211143.7094-1-fr0st61te@gmail.com>
         <20230917211143.7094-2-fr0st61te@gmail.com>
         <20230924135359.6404a867@jic23-huawei>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2023-09-24 at 13:53 +0100, Jonathan Cameron wrote:
> On Mon, 18 Sep 2023 00:11:42 +0300
> Ivan Mikhaylov <fr0st61te@gmail.com> wrote:
>=20
> > The i2c driver with Rsense option for current monitoring.
> >=20
> > Signed-off-by: Ivan Mikhaylov <fr0st61te@gmail.com>
>=20
> Hi Ivan,
>=20
> Welcome to IIO!
>=20
> Looks good, but there are a few things I'd add to make this describe
> the device
> a little more fully and flexibly.=C2=A0 Ideally we want a binding to full=
y
> describe
> a device, even if the particular driver for Linux doesn't use all the
> features.
> Some are easy though such as enabling regulators (that are probably
> turned on
> already on your board)
>=20
> Thanks,
>=20
> Jonathan
>=20
> > ---
> > =C2=A0.../bindings/iio/adc/maxim,max34408.yaml=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 | 63
> > +++++++++++++++++++
> > =C2=A01 file changed, 63 insertions(+)
> > =C2=A0create mode 100644
> > Documentation/devicetree/bindings/iio/adc/maxim,max34408.yaml
> >=20
> > diff --git
> > a/Documentation/devicetree/bindings/iio/adc/maxim,max34408.yaml
> > b/Documentation/devicetree/bindings/iio/adc/maxim,max34408.yaml
> > new file mode 100644
> > index 000000000000..ae7c6ddb13d8
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/iio/adc/maxim,max34408.yaml
> > @@ -0,0 +1,63 @@
> > +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/iio/adc/maxim,max34408.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: Two- and four-channel current monitors with overcurrent
> > control.
> > +
> > +maintainers:
> > +=C2=A0 - Ivan Mikhaylov <fr0st61te@gmail.com>
> > +
> > +description: |
> > +=C2=A0 The MAX34408/MAX34409 are two- and four-channel current monitor=
s
> > that are
> > +=C2=A0 configured and monitored with a standard I2C/SMBus serial
> > interface. Each
> > +=C2=A0 unidirectional current sensor offers precision high-side
> > operation with a
> > +=C2=A0 low full-scale sense voltage. The devices automatically sequenc=
e
> > through
> > +=C2=A0 two or four channels and collect the current-sense samples and
> > average them
> > +=C2=A0 to reduce the effect of impulse noise. The raw ADC samples are
> > compared to
> > +=C2=A0 user-programmable digital thresholds to indicate overcurrent
> > conditions.
> > +=C2=A0 Overcurrent conditions trigger a hardware output to provide an
> > immediate
> > +=C2=A0 indication to shut down any necessary external circuitry.
> > +
> > +=C2=A0 Specifications about the devices can be found at:
> > +=C2=A0
> > https://www.analog.com/media/en/technical-documentation/data-sheets/MAX=
34408-MAX34409.pdf
> > +
> > +properties:
> > +=C2=A0 compatible:
> > +=C2=A0=C2=A0=C2=A0 enum:
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - maxim,max34408
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - maxim,max34409
> > +
> > +=C2=A0 reg:
> > +=C2=A0=C2=A0=C2=A0 maxItems: 1
> > +
> > +=C2=A0 interrupts:
> > +=C2=A0=C2=A0=C2=A0 maxItems: 1
> > +
> > +=C2=A0 maxim,rsense-val-micro-ohms:
> From the datasheet you link, it looks like this could be different
> for
> the inputs?

Hi Jonathan, "maxim,input1-rsense-val-micro-ohms", "maxim,input2-
rsense-val-micro-ohms" and etc would be better?

>=20
> > +=C2=A0=C2=A0=C2=A0 description:
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Adjust the Rsense value to monitor high=
er or lower current
> > levels.
> > +=C2=A0=C2=A0=C2=A0 enum: [250, 500, 1000, 5000, 10000, 50000, 100000, =
200000,
> > 500000]
>=20
> These come from Table 18 which is example values I think?=C2=A0 Not sure
> there
> is anything limiting us to those particular values given the equation
> given
> just above that table should apply more generally.
>=20
> > +=C2=A0=C2=A0=C2=A0 default: 1000
>=20
> Please add regulator definitions.
>=20
> supply-vdd: true
> and add it to the required properties. It might be provided by a stub
> regulator
> but we still list that as required.
>=20
> Also good to add bindings for the other control pins that might be
> wired to be
> in the binding from the start - no need for the driver to use them
> though.
> Looks like we have SHTDN and ENA here that could be wired to GPIOs on
> the host.
>=20
> > +
> > +required:
> > +=C2=A0 - compatible
> > +=C2=A0 - reg
> > +=C2=A0 - maxim,rsense-val-micro-ohms
> > +
> > +additionalProperties: false
> > +
> > +examples:
> > +=C2=A0 - |
> > +=C2=A0=C2=A0=C2=A0 i2c {
> > +
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 #address-cells =3D <1>;
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 #size-cells =3D <0>;
> > +
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 adc@1e {
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 compatible =3D "maxim,max34409";
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 reg =3D <0x1e>;
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 maxim,rsense-val-micro-ohms =3D <1000>;
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 };
> > +=C2=A0=C2=A0=C2=A0 };
>=20

Rob, Jonathan, thanks for review, will do the changes which you asked.

