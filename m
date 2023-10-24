Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E56837D47BD
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Oct 2023 08:50:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232772AbjJXGua (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Oct 2023 02:50:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232694AbjJXGu2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Oct 2023 02:50:28 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A121D7E;
        Mon, 23 Oct 2023 23:50:25 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id a640c23a62f3a-9c75ceea588so578589366b.3;
        Mon, 23 Oct 2023 23:50:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698130223; x=1698735023; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=52cX480DMRmgJFxJt8gKXrV9geIY85JmDTGzaX2CpEg=;
        b=BVU93BF0/34g+RErf6ezRAzfl7J18ANUSxPYX2gYyTxvRHbMSuWJkuJxQerFItFWvB
         cvFvfx82AKFYS1zHXiKOu/pmeu7NwttFXRoxAbakSb/pU1Ue7O/87IJVhWiZR/67ifu7
         7RibMByoknM0SziosrfRZ/6lRBqOI+bylry5o5eSg4jdLxESFq9tcSuGLrReBZMkW2/D
         ZQOtaR8+zIVixH0Da6ABH8oFS0YAcVzOMLWt+Mf1ffcWBvGSMeNPq+r3no1oKY+paqkZ
         Pv4HnkVPSPtCy9mlQ4gGFL8fhq5pztpLivEvRVgDL/XI8ZbV09dtO5DFGzes1X2HQUB6
         gTkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698130223; x=1698735023;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=52cX480DMRmgJFxJt8gKXrV9geIY85JmDTGzaX2CpEg=;
        b=Q/IeWb3BD4eNF/7x5+QC7ao/m9sI0+w5grYlINPhNkuXVnnX1J10BUP1CUSfNiPH9i
         Oty9R7P3JVVTC8/aYUT/6V2KJk/660UFlD2tNtptc3INJXEfLuiz3HFR9YYPgnoez9dy
         T2hkRqqMPXkKatabIFFDiG46K/qBgY+TVGpBfWj2x2Yimrbk4+3DIfrpOExYjCedYW0p
         gLuP6Fk/ImSbrJgFZk6vDIPB2ULmlEAqV1/cJltY1CISffGMoI7tPovT5dVwmaloDHIe
         RXbZfjkO6qtfxdAhpQ0UGxj+46gvQcQIEeT7rikZSJOcmOjqTW2fD4YYoZA7GEqrnSFO
         iu8w==
X-Gm-Message-State: AOJu0YwL2dVNtw009OIXB20uSkp1I+ykfnunEJmo7syPf6Md8N06eC5E
        m2dYsD4VToSNZrX+cU9GTfk=
X-Google-Smtp-Source: AGHT+IFEhMmhUR6aWcmp9FSFfDcol5+C0CsyhpYiUyBbE8PDIpq7LYECLq7CiUklSI1W8JJ2yN68eA==
X-Received: by 2002:a17:906:da88:b0:9be:7de2:927c with SMTP id xh8-20020a170906da8800b009be7de2927cmr8007488ejb.70.1698130223374;
        Mon, 23 Oct 2023 23:50:23 -0700 (PDT)
Received: from ?IPv6:2003:f6:ef1b:2000:361b:8f29:1cbf:5e69? (p200300f6ef1b2000361b8f291cbf5e69.dip0.t-ipconnect.de. [2003:f6:ef1b:2000:361b:8f29:1cbf:5e69])
        by smtp.gmail.com with ESMTPSA id x20-20020a170906149400b0098884f86e41sm7694117ejc.123.2023.10.23.23.50.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Oct 2023 23:50:22 -0700 (PDT)
Message-ID: <5c600a6db6173a56251302da8d2f438435959bd2.camel@gmail.com>
Subject: Re: [PATCH v2 3/3] dt-bindings: adis16460: Add
 'spi-cs-inactive-delay-ns' property
From:   Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To:     Conor Dooley <conor@kernel.org>
Cc:     Ramona Gradinariu <ramona.gradinariu@analog.com>, jic23@kernel.org,
        nuno.sa@analog.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Date:   Tue, 24 Oct 2023 08:53:14 +0200
In-Reply-To: <20231023-repost-coma-2f67ea8b95af@spud>
References: <20231023140534.704312-1-ramona.gradinariu@analog.com>
         <20231023140534.704312-4-ramona.gradinariu@analog.com>
         <e97ac024cb2654507ed8f7af715f3604efefbdbb.camel@gmail.com>
         <20231023-repost-coma-2f67ea8b95af@spud>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.0 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2023-10-23 at 17:06 +0100, Conor Dooley wrote:
> On Mon, Oct 23, 2023 at 04:27:48PM +0200, Nuno S=C3=A1 wrote:
> > On Mon, 2023-10-23 at 17:05 +0300, Ramona Gradinariu wrote:
> > > The adis16460 device requires a stall time between SPI
> > > transactions (during which the chip select is inactive),
> > > with a minimum value equal to 16 microseconds.
> > > This commit adds 'spi-cs-inactive-delay-ns' property, which should
> > > indicate the stall time between consecutive SPI transactions.
> > >=20
> > > Signed-off-by: Ramona Gradinariu <ramona.gradinariu@analog.com>
> > > ---
> > > changes in v2:
> > > =C2=A0- added default value
> > > =C2=A0- updated description
> > > =C2=A0- updated commit message
> > > =C2=A0.../devicetree/bindings/iio/imu/adi,adis16460.yaml=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 6 ++++++
> > > =C2=A01 file changed, 6 insertions(+)
> > >=20
> > > diff --git a/Documentation/devicetree/bindings/iio/imu/adi,adis16460.=
yaml
> > > b/Documentation/devicetree/bindings/iio/imu/adi,adis16460.yaml
> > > index 4e43c80e5119..f10469b86ee0 100644
> > > --- a/Documentation/devicetree/bindings/iio/imu/adi,adis16460.yaml
> > > +++ b/Documentation/devicetree/bindings/iio/imu/adi,adis16460.yaml
> > > @@ -25,6 +25,12 @@ properties:
> > >=20
> > > =C2=A0=C2=A0 spi-cpol: true
> > >=20
> > > +=C2=A0 spi-cs-inactive-delay-ns:
> > > +=C2=A0=C2=A0=C2=A0 minimum: 16000
> > > +=C2=A0=C2=A0=C2=A0 default: 16000
> > > +=C2=A0=C2=A0=C2=A0 description:
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Indicates the stall time between cons=
ecutive SPI transactions.
> > > +
> >=20
> > You should drop the description...=20
> >=20
> > Also, give more time before posting a v2 so others get a chance to revi=
ew
> > your
> > patches. It's also better for you since you can gather more change requ=
ests.
>=20
> Further, I don't see an answer to Krzysztof's question of why the stall
> time would not just be set to 16,000 ns in the driver, based on the
> compatible.

Hi Conor,

Regarding that, I'm the one to blame since I was the one asking for the pro=
perty
during internal review... The reason is that "spi-cs-inactive-delay-ns" is
already part of spi-peripheral-props.yaml which we already reference. So my
question would be why not using it?

These devices are a bit sensitive regarding these timings. Not in devices
supported by this driver but I already experienced having to set timings bi=
gger
than defined in the datasheet for spi to be reliable. this was true on a RP=
I but
might not be in another platform.

Hence having the flexibility to change the time in an already supported pro=
perty
does sound good to me. If not set, we still use the default value based on =
the
compatible. Now, if you tell me "let's just add this if we really get the n=
eed
for it", I get it but I also don't understand why not add it now...

Thanks!
- Nuno S=C3=A1

