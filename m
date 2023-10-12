Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E05047C7282
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Oct 2023 18:27:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379537AbjJLQ1k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Oct 2023 12:27:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230274AbjJLQ1i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Oct 2023 12:27:38 -0400
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31FB3C0;
        Thu, 12 Oct 2023 09:27:37 -0700 (PDT)
Received: by mail-lj1-x236.google.com with SMTP id 38308e7fff4ca-2c135cf2459so13865771fa.0;
        Thu, 12 Oct 2023 09:27:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697128055; x=1697732855; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Sp6tD8+KN6PsbYQKVP/0VDekX8gNi8VlhDJAD3ZHp0c=;
        b=CAT3vsR+Rl4m/1ITD13Qt+eOxkL323bZLNMMJ/zcoc4A7N2KSJhbzFtCoWhv0u6P96
         XqvQ9sOVy1ozRrG/b97aE1UZLMovL+gIM2BEH2HDmP/y9Fa2ZvnAjNZM1+X36+vseMSL
         R9h5qWqUIlyeV/vBsJXHlJU1R6Jj0k1uNdNple8ctCskVbcixHwkJnPxpPyXe3j7mpwX
         lK0mk3PZ0dmwUJbtt5uglh/Nt2OicK7PegHVLz6PUlo/dp8EyjMpb2q1GihKoDvAxhYU
         4hQzB1awUs17feKmmzwVnuioVFFvBO9KCRB/tWDL82SvXnL8DHQAKKJy06lQt3GWSO+n
         a18g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697128055; x=1697732855;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Sp6tD8+KN6PsbYQKVP/0VDekX8gNi8VlhDJAD3ZHp0c=;
        b=httZfjHm2iFFkTg/OdkzsfA0QF2uMkpW29gWMJDWa5hNlnYmulz9xFDb9ZnNOgomUG
         3ElGYL0HV5EiQSmv3Llv2YvjhD6RDnKPfgI88i3jyex0TUgBg2/gRur/HuIhtQt2b2XQ
         olpOiuyt7Jti3ndKo9GjfzFoarFZszhOerVng1noBZcTvFLp/mXcEbgPkxCNZpUnohjD
         NHUlaXbzm2Oau1fkD48KW+MgwWTZAG3NMdJ/sCAOC5ZLYBInM5LhEY7zUredwcJTXucL
         baVIcVO+wYjcZ7jO46s1kgOg9BJ9kxDU1vOPeHaAOFvf6SsJZekdxL/xfzadiNaIHMcv
         OzOA==
X-Gm-Message-State: AOJu0YzwkVn7Zpuuy/hHtygpWzCDZfokes4+8O/3hVZL7Z+ezHyb5VBb
        JUOyKeHc6sWGxHCwt4TM+S55ZA7gfqNHRQ==
X-Google-Smtp-Source: AGHT+IGkYef1XiM7SVlE6kTk/l2piPS8fHkPNoyixjtHtcQhQZ3GMKu8am97cRT245bUy0cMvdBvYA==
X-Received: by 2002:a2e:90c3:0:b0:2bc:e882:f717 with SMTP id o3-20020a2e90c3000000b002bce882f717mr21270278ljg.53.1697128055059;
        Thu, 12 Oct 2023 09:27:35 -0700 (PDT)
Received: from [192.168.1.161] ([46.31.31.132])
        by smtp.gmail.com with ESMTPSA id u4-20020a2e9f04000000b002bcd94f9714sm3604605ljk.126.2023.10.12.09.27.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Oct 2023 09:27:34 -0700 (PDT)
Message-ID: <e7b74daa9d0131246fd10f47aa4128bc8f8f3177.camel@gmail.com>
Subject: Re: [PATCH v5 1/2] dt-bindings: adc: provide max34408/9 device tree
 binding document
From:   Ivan Mikhaylov <fr0st61te@gmail.com>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Date:   Thu, 12 Oct 2023 19:27:33 +0300
In-Reply-To: <20231012084052.504ac930@jic23-huawei>
References: <20231007234838.8748-1-fr0st61te@gmail.com>
         <20231007234838.8748-2-fr0st61te@gmail.com>
         <20231010154042.2ef667b2@jic23-huawei>
         <383064a5b0863a4a616cd60cff8d4bc18e397fd7.camel@gmail.com>
         <20231012084052.504ac930@jic23-huawei>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.0 
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

On Thu, 2023-10-12 at 08:40 +0100, Jonathan Cameron wrote:
> On Tue, 10 Oct 2023 23:22:48 +0300
> Ivan Mikhaylov <fr0st61te@gmail.com> wrote:
>=20
> > On Tue, 2023-10-10 at 15:40 +0100, Jonathan Cameron wrote:
> > > On Sun,=C2=A0 8 Oct 2023 02:48:37 +0300
> > > Ivan Mikhaylov <fr0st61te@gmail.com> wrote:
> > > =C2=A0=20
> > > > The hardware binding for i2c current monitoring device with
> > > > overcurrent
> > > > control.
> > > >=20
> > > > Signed-off-by: Ivan Mikhaylov <fr0st61te@gmail.com>
> > > > ---
> > > > =C2=A0.../bindings/iio/adc/maxim,max34408.yaml=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 | 141
> > > > ++++++++++++++++++
> > > > =C2=A01 file changed, 141 insertions(+)
> > > > =C2=A0create mode 100644
> > > > Documentation/devicetree/bindings/iio/adc/maxim,max34408.yaml
> > > >=20
> > > > diff --git
> > > > a/Documentation/devicetree/bindings/iio/adc/maxim,max34408.yaml
> > > > b/Documentation/devicetree/bindings/iio/adc/maxim,max34408.yaml
> > > > new file mode 100644
> > > > index 000000000000..9749f1fd1802
> > > > --- /dev/null
> > > > +++
> > > > b/Documentation/devicetree/bindings/iio/adc/maxim,max34408.yaml
> > > > @@ -0,0 +1,141 @@
> > > > +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> > > > +%YAML 1.2
> > > > +---
> > > > +$id:
> > > > http://devicetree.org/schemas/iio/adc/maxim,max34408.yaml#
> > > > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > > > +
> > > > +title: Two- and four-channel current monitors with overcurrent
> > > > control
> > > > +
> > > > +maintainers:
> > > > +=C2=A0 - Ivan Mikhaylov <fr0st61te@gmail.com>
> > > > +
> > > > +description: |
> > > > +=C2=A0 The MAX34408/MAX34409 are two- and four-channel current
> > > > monitors
> > > > that are
> > > > +=C2=A0 configured and monitored with a standard I2C/SMBus serial
> > > > interface. Each
> > > > +=C2=A0 unidirectional current sensor offers precision high-side
> > > > operation with a
> > > > +=C2=A0 low full-scale sense voltage. The devices automatically
> > > > sequence
> > > > through
> > > > +=C2=A0 two or four channels and collect the current-sense samples
> > > > and
> > > > average them
> > > > +=C2=A0 to reduce the effect of impulse noise. The raw ADC samples
> > > > are
> > > > compared to
> > > > +=C2=A0 user-programmable digital thresholds to indicate overcurren=
t
> > > > conditions.
> > > > +=C2=A0 Overcurrent conditions trigger a hardware output to provide
> > > > an
> > > > immediate
> > > > +=C2=A0 indication to shut down any necessary external circuitry.
> > > > +
> > > > +=C2=A0 Specifications about the devices can be found at:
> > > > +=C2=A0
> > > > https://www.analog.com/media/en/technical-documentation/data-sheets=
/MAX34408-MAX34409.pdf
> > > > +
> > > > +properties:
> > > > +=C2=A0 compatible:
> > > > +=C2=A0=C2=A0=C2=A0 enum:
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - maxim,max34408
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - maxim,max34409
> > > > +
> > > > +=C2=A0 "#address-cells":
> > > > +=C2=A0=C2=A0=C2=A0 const: 1
> > > > +
> > > > +=C2=A0 "#size-cells":
> > > > +=C2=A0=C2=A0=C2=A0 const: 0
> > > > +
> > > > +=C2=A0 reg:
> > > > +=C2=A0=C2=A0=C2=A0 maxItems: 1
> > > > +
> > > > +=C2=A0 interrupts:
> > > > +=C2=A0=C2=A0=C2=A0 maxItems: 1
> > > > +
> > > > +=C2=A0 powerdown-gpios:
> > > > +=C2=A0=C2=A0=C2=A0 description:
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Shutdown Output. Open-drain output.=
 This output
> > > > transitions
> > > > to high impedance
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 when any of the digital comparator =
thresholds are
> > > > exceeded
> > > > as long as the ENA
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 pin is high.
> > > > +=C2=A0=C2=A0=C2=A0 maxItems: 1
> > > > +
> > > > +=C2=A0 shtdn-enable-gpios:=C2=A0=20
> > >=20
> > > I guess the review crossed with you sending v5.=C2=A0 There is some
> > > feedback on v4 you need
> > > to address here.=C2=A0=20
> >=20
> > Jonathan, I thought I did, I've changed ena to powerdown-gpios from
> > Krzysztof's comments but about this one pin I'm still not sure, it
> > looks like *-enable-gpios (like in *-enable-gpios pins in
> > iio/frequency/adi,adf4377.yaml) pin or is it not? Or maybe any
> > other
> > suggestions about naming of this one?
> >=20
> > Thanks.
>=20
> shutdown-gpios and make the sense (active high / low) such that
> setting
> it results in teh device being shut down.
> Or treat it as an enable and enable-gpios
>=20
> Something that indicates both shutdown and enable is confusing ;)
>=20
> Jonathan


Jonathan, then I make these changes:

powerdown-gpios: -> output-enable:
shtdn-enable-gpios: -> enable-gpios:

Is it ok?

Thanks.
