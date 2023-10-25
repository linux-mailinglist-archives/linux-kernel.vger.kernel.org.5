Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A117B7D63A4
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Oct 2023 09:40:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234186AbjJYHkg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Oct 2023 03:40:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234023AbjJYHkU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Oct 2023 03:40:20 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D9514C1E;
        Wed, 25 Oct 2023 00:39:12 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id a640c23a62f3a-9bf86b77a2aso770087966b.0;
        Wed, 25 Oct 2023 00:39:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698219541; x=1698824341; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Te1iHE/rzZPd9szXvKoHrxnrvsuWVQsV/Q92fJ/vORo=;
        b=EPIx3n7e+pKQ0f80dUAfj5PpO8iMz7j2601FY/O/+xPLEWGdw9qm3yamGwfJksJ1PY
         CQUVqn1z/2tvxEBbnGDGcJzvTVzIjH74cdQXKVnJY15jFk4mKmTimkBq3I8fIMwm44kT
         PybAY0AyhSB1FwpgdWhNOlf3u+Ahtdxx4ObFD90r/3GuRhcYhRh10P/mrMYL2dVEBWhr
         OT6gkhNLFZVSGgXuhM+BUVl4YgXapvkyZ4P+H5gY1Onc3mnpj5F4uA1coiYKunfreySt
         L8K+f+8S+cM7YUJ9v2AyIPBAkZcwPRQgESEFialvYiRVZ4IaM6wvys6b074YnOESgyvH
         ROiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698219541; x=1698824341;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Te1iHE/rzZPd9szXvKoHrxnrvsuWVQsV/Q92fJ/vORo=;
        b=Gg/wVVUtixvW5ifoGjhWiZewYD7RJmU5ReNb0iqd30AcBaSpV9a8jU5rShlpJVXtZO
         ipwaEoD/Wzcs1vNL0x57no1iKxMYZl7PmdvtxoUzr7+1yOcQp+Cx9pPMtCFdL2milUqz
         WO2lvVxJwCIrx5ie5X44XWY6sbpHbfCsjnKuq9XTE9UC3CqSMeSFoksmzLLXrxw4QI0F
         1eGknJ39v7eGPIhQ7wmkEbN2wqmss4uD0+WVo29avGwZMoOZAtMftapcAki453S/gCXv
         Ay5CZeAAoKx7lfeXDysRbU6CxMIv949Otfc7iiPWMkVIMtxAazAzvGPMfElmRN40AjM7
         9goQ==
X-Gm-Message-State: AOJu0YyKJwA9/gPA5fvEMMD00BI60Wpxvk7sPbY4IseEO5VAdoHKCCa3
        BkYkFqPMhN9XM+Txgxr4Yco=
X-Google-Smtp-Source: AGHT+IE0lUpM0EUlNscdNWAa/Cl2VZY0CrTcHc+MBtp3QU0BStJqOcVAL3+/3sISUqbrTUhYArOsiA==
X-Received: by 2002:a17:907:a4b:b0:9c6:4dec:b1f0 with SMTP id be11-20020a1709070a4b00b009c64decb1f0mr10296102ejc.74.1698219540729;
        Wed, 25 Oct 2023 00:39:00 -0700 (PDT)
Received: from ?IPv6:2003:f6:ef1b:2000:4423:d503:bf11:e8c6? (p200300f6ef1b20004423d503bf11e8c6.dip0.t-ipconnect.de. [2003:f6:ef1b:2000:4423:d503:bf11:e8c6])
        by smtp.gmail.com with ESMTPSA id g27-20020a170906395b00b00988dbbd1f7esm9266810eje.213.2023.10.25.00.38.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Oct 2023 00:39:00 -0700 (PDT)
Message-ID: <1a7e525c664fe964606fa7fd1a5f5022111e6e2a.camel@gmail.com>
Subject: Re: [PATCH v2 3/3] dt-bindings: adis16460: Add
 'spi-cs-inactive-delay-ns' property
From:   Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To:     Conor Dooley <conor@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Ramona Gradinariu <ramona.gradinariu@analog.com>, jic23@kernel.org,
        nuno.sa@analog.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Date:   Wed, 25 Oct 2023 09:41:52 +0200
In-Reply-To: <20231024-backache-unranked-c4905d8944b7@spud>
References: <20231023140534.704312-1-ramona.gradinariu@analog.com>
         <20231023140534.704312-4-ramona.gradinariu@analog.com>
         <e97ac024cb2654507ed8f7af715f3604efefbdbb.camel@gmail.com>
         <20231023-repost-coma-2f67ea8b95af@spud>
         <5c600a6db6173a56251302da8d2f438435959bd2.camel@gmail.com>
         <8391fb67-e575-49e6-9857-806cb85e9e59@linaro.org>
         <20231024-backache-unranked-c4905d8944b7@spud>
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

On Tue, 2023-10-24 at 16:11 +0100, Conor Dooley wrote:
> On Tue, Oct 24, 2023 at 03:47:16PM +0200, Krzysztof Kozlowski wrote:
> > On 24/10/2023 08:53, Nuno S=C3=A1 wrote:
> > > On Mon, 2023-10-23 at 17:06 +0100, Conor Dooley wrote:
> > > > On Mon, Oct 23, 2023 at 04:27:48PM +0200, Nuno S=C3=A1 wrote:
> > > > > On Mon, 2023-10-23 at 17:05 +0300, Ramona Gradinariu wrote:
> > > > > > The adis16460 device requires a stall time between SPI
> > > > > > transactions (during which the chip select is inactive),
> > > > > > with a minimum value equal to 16 microseconds.
> > > > > > This commit adds 'spi-cs-inactive-delay-ns' property, which sho=
uld
> > > > > > indicate the stall time between consecutive SPI transactions.
> > > > > >=20
> > > > > > Signed-off-by: Ramona Gradinariu <ramona.gradinariu@analog.com>
> > > > > > ---
> > > > > > changes in v2:
> > > > > > =C2=A0- added default value
> > > > > > =C2=A0- updated description
> > > > > > =C2=A0- updated commit message
> > > > > > =C2=A0.../devicetree/bindings/iio/imu/adi,adis16460.yaml=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 6
> > > > > > ++++++
> > > > > > =C2=A01 file changed, 6 insertions(+)
> > > > > >=20
> > > > > > diff --git
> > > > > > a/Documentation/devicetree/bindings/iio/imu/adi,adis16460.yaml
> > > > > > b/Documentation/devicetree/bindings/iio/imu/adi,adis16460.yaml
> > > > > > index 4e43c80e5119..f10469b86ee0 100644
> > > > > > --- a/Documentation/devicetree/bindings/iio/imu/adi,adis16460.y=
aml
> > > > > > +++ b/Documentation/devicetree/bindings/iio/imu/adi,adis16460.y=
aml
> > > > > > @@ -25,6 +25,12 @@ properties:
> > > > > >=20
> > > > > > =C2=A0=C2=A0 spi-cpol: true
> > > > > >=20
> > > > > > +=C2=A0 spi-cs-inactive-delay-ns:
> > > > > > +=C2=A0=C2=A0=C2=A0 minimum: 16000
> > > > > > +=C2=A0=C2=A0=C2=A0 default: 16000
> > > > > > +=C2=A0=C2=A0=C2=A0 description:
> > > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Indicates the stall time betwee=
n consecutive SPI
> > > > > > transactions.
> > > > > > +
> > > > >=20
> > > > > You should drop the description...=20
> > > > >=20
> > > > > Also, give more time before posting a v2 so others get a chance t=
o
> > > > > review
> > > > > your
> > > > > patches. It's also better for you since you can gather more chang=
e
> > > > > requests.
> > > >=20
> > > > Further, I don't see an answer to Krzysztof's question of why the s=
tall
> > > > time would not just be set to 16,000 ns in the driver, based on the
> > > > compatible.
> > >=20
> > > Hi Conor,
> > >=20
> > > Regarding that, I'm the one to blame since I was the one asking for t=
he
> > > property
> > > during internal review... The reason is that "spi-cs-inactive-delay-n=
s" is
> > > already part of spi-peripheral-props.yaml which we already reference.=
 So
> > > my
> > > question would be why not using it?
> > >=20
> > > These devices are a bit sensitive regarding these timings. Not in dev=
ices
> > > supported by this driver but I already experienced having to set timi=
ngs
> > > bigger
> > > than defined in the datasheet for spi to be reliable. this was true o=
n a
> > > RPI but
> > > might not be in another platform.
> > >=20
> > > Hence having the flexibility to change the time in an already support=
ed
> > > property
> > > does sound good to me. If not set, we still use the default value bas=
ed on
> > > the
> > > compatible. Now, if you tell me "let's just add this if we really get=
 the
> > > need
> > > for it", I get it but I also don't understand why not add it now...
>=20
> I don't object to having the property, it'd just be good for the commit
> message to have mentioned that the minimum time may not be sufficient
> for all configurations.
>=20

Fair enough...

Thanks!
- Nuno S=C3=A1


