Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 472D87652AF
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jul 2023 13:40:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232387AbjG0Lkm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jul 2023 07:40:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233151AbjG0Lkh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jul 2023 07:40:37 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 404102127;
        Thu, 27 Jul 2023 04:40:35 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id a640c23a62f3a-99bdd262bb0so58804766b.3;
        Thu, 27 Jul 2023 04:40:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690458033; x=1691062833;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=/fChEvxMU1VyjUw70eOU9DlODWk8dCup0qBe13Xv7Vg=;
        b=X+a8afCTrh5zv54f6eSfcGhKmIHwLnoQM1KB7vJz0H2LKiGsjwuisH9A6mN+/LTQd/
         MWUH5ZjjD59fZ1M5oqxRB/nVIPz0U360yaEmU/Lat1ss4Rao3cdwycvW2+Dlj56H+gdL
         QkI4q7Yr85uB7wGt39DIaKs/VNBYgxHA/yZKJ70RcWDrqs2fmYRZsfwDkIOYXf7ZpLjx
         eZGb+eOf0tRmA3UqHovpsdswQ1eCmneJx7msCfBp/3ruv4S9nDQYj1xH+XTBOy4fPfc3
         nJrk5ozS8MvsdjlNWxkAKVsTNtQJpzkxLqgztn3KU4rBLnZp9a/zFjTNokNBhIK4p2V8
         3BcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690458033; x=1691062833;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/fChEvxMU1VyjUw70eOU9DlODWk8dCup0qBe13Xv7Vg=;
        b=MyN70bEWjxZ/V5gLWlYfFb/07dYPdb8wFkdN2zgopzjDeKI98vckH7T9UJYx8prljV
         1OzxQuF9GYVJ5+1ODt/8dnf4tryLZqEX47zl1u66rSql8bBdHPJ9NMzlcj9ef2vGLdAX
         HtclmJ60nu4ztv5KhAoy5tnhRy0M154MsSC5FDTaddxI/KQ2WRB2zPcvQJQhtkRH03Sr
         iG+AXHNstcMgwPl0MdZWWKt7/fDyBnmp+jKOnANrjlNPcjjFIgN/8knNcfb+sFiVlxhw
         nn7mxxpiItbFlHb7+UhYKIP5mdGs6yGzIDAys68Dl5g+WNDMA5L04ssj/OHbIVTEUCYf
         gw5Q==
X-Gm-Message-State: ABy/qLaDulFk4SLaFqbISCd93vkwVDbhd3af7ebz95GvAa7NIDsO7dSE
        zm5bJKVHkaOZm8iJWHHunTM=
X-Google-Smtp-Source: APBJJlFjF0UJt+iVWHdzXdcsAl556k8YonWZFChjgP85pP83lIPjvswb/wRIrjzRFp3QAno/9HnmQg==
X-Received: by 2002:a17:907:762a:b0:993:d6a7:13b with SMTP id jy10-20020a170907762a00b00993d6a7013bmr1679868ejc.22.1690458033416;
        Thu, 27 Jul 2023 04:40:33 -0700 (PDT)
Received: from ?IPv6:2001:a61:35be:1401:2331:c532:1717:d48c? ([2001:a61:35be:1401:2331:c532:1717:d48c])
        by smtp.gmail.com with ESMTPSA id qc8-20020a170906d8a800b00989828a42e8sm666431ejb.154.2023.07.27.04.40.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Jul 2023 04:40:32 -0700 (PDT)
Message-ID: <b2379aadad95d68ca9605bb9566ce6a70121a409.camel@gmail.com>
Subject: Re: [PATCH 1/2] Documentation: bindings: adi,axi-tdd.yaml: Add new
 TDD engine driver
From:   Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To:     "Balas, Eliza" <Eliza.Balas@analog.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Derek Kiernan <derek.kiernan@amd.com>,
        Dragan Cvetic <dragan.cvetic@amd.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Jonathan Cameron <jic23@kernel.org>
Date:   Thu, 27 Jul 2023 13:40:31 +0200
In-Reply-To: <BN7PR03MB454595EC3EABAEA5607BF1619701A@BN7PR03MB4545.namprd03.prod.outlook.com>
References: <20230726071103.12172-1-eliza.balas@analog.com>
         <61fce1da-c8dd-f911-e4bb-b2198612e7c6@linaro.org>
         <BN7PR03MB4545E574AB9886290115E5C89701A@BN7PR03MB4545.namprd03.prod.outlook.com>
         <ec964562-6ebb-e145-e850-0417a88077c2@linaro.org>
         <BN7PR03MB454595EC3EABAEA5607BF1619701A@BN7PR03MB4545.namprd03.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2023-07-27 at 09:46 +0000, Balas, Eliza wrote:
>=20
>=20
> > -----Original Message-----
> > From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> > Sent: Thursday, July 27, 2023 12:27
> > To: Balas, Eliza <Eliza.Balas@analog.com>
> > Cc: Rob Herring <robh+dt@kernel.org>; Krzysztof Kozlowski
> > <krzysztof.kozlowski+dt@linaro.org>; Conor Dooley
> > <conor+dt@kernel.org>; Derek Kiernan <derek.kiernan@amd.com>; Dragan Cv=
etic
> > <dragan.cvetic@amd.com>; Arnd Bergmann
> > <arnd@arndb.de>; Greg Kroah-Hartman <gregkh@linuxfoundation.org>;
> > linux-kernel@vger.kernel.org; devicetree@vger.kernel.org
> > Subject: Re: [PATCH 1/2] Documentation: bindings: adi,axi-tdd.yaml: Add=
 new TDD
> > engine driver
> >=20
> > [External]
> >=20
> > On 27/07/2023 11:05, Balas, Eliza wrote:
> > >=20
> > > > -----Original Message-----
> > > > From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> > > > Sent: Wednesday, July 26, 2023 21:35
> > > > To: Balas, Eliza <Eliza.Balas@analog.com>
> > > > Cc: Rob Herring <robh+dt@kernel.org>; Krzysztof Kozlowski
> > > > <krzysztof.kozlowski+dt@linaro.org>; Conor Dooley
> > > > <conor+dt@kernel.org>; Derek Kiernan <derek.kiernan@amd.com>; Draga=
n Cvetic
> > > > <dragan.cvetic@amd.com>; Arnd Bergmann
> > > > <arnd@arndb.de>; Greg Kroah-Hartman <gregkh@linuxfoundation.org>;
> > > > linux-kernel@vger.kernel.org;
> > devicetree@vger.kernel.org
> > > > Subject: Re: [PATCH 1/2] Documentation: bindings: adi,axi-tdd.yaml:=
 Add new
> > > > TDD engine driver
> > > >=20
> > > > [External]
> > > >=20
> > > > On 26/07/2023 09:11, Eliza Balas wrote:
> > > > > Add device tree documentation for the AXI TDD Core.
> > > > > The generic TDD controller is in essence a waveform generator cap=
able
> > > > > of addressing RF applications which require Time Division Duplexi=
ng,
> > > > > as well as controlling other modules of general applications thro=
ugh
> > > > > its dedicated 32 channel outputs.
> > > > >=20
> > > > > The reason of creating the generic TDD controller was to reduce t=
he
> > > > > naming confusion around the existing repurposed TDD core built fo=
r
> > > > > AD9361, as well as expanding its number of output channels for sy=
stems
> > > > > which require more than six controlling signals.
> > > >=20
> > > > Please use subject prefixes matching the subsystem. You can get the=
m for
> > > > example with `git log --oneline -- DIRECTORY_OR_FILE`
> > on
> > > > the directory your patch is touching.
> > > >=20
> > > > Subject: drop driver. Bindings are for hardware, not drivers... unl=
ess driver
> > > > is here a hardware term?
> > >=20
> > > It is not a hardware term in this case, I will make the changes.
> > >=20
> > > > >=20
> > > > > Signed-off-by: Eliza Balas <eliza.balas@analog.com>
> > > > > ---
> > > > > =C2=A0.../devicetree/bindings/misc/adi,axi-tdd.yaml | 51 ++++++++=
+++++++++++
> > > > > =C2=A0MAINTAINERS=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 |=C2=A0 7 +++
> > > > > =C2=A02 files changed, 58 insertions(+)
> > > > > =C2=A0create mode 100644
> > > > > Documentation/devicetree/bindings/misc/adi,axi-tdd.yaml
> > > > >=20
> > > > > diff --git a/Documentation/devicetree/bindings/misc/adi,axi-tdd.y=
aml
> > > > > b/Documentation/devicetree/bindings/misc/adi,axi-tdd.yaml
> > > > > new file mode 100644
> > > > > index 000000000000..1894c1c34d4f
> > > > > --- /dev/null
> > > > > +++ b/Documentation/devicetree/bindings/misc/adi,axi-tdd.yaml
> > > >=20
> > > > Why is this in misc? No suitable directory?
> > >=20
> > > I chose misc because I don't know where it should fit, I did not find=
 a
> > > suitable
> > > subsystem to include this driver because this is a driver for an FPGA=
 IP core.
> > > Do you have an idea where I should put it?
> >=20
> > Directory based on what this device does. Whether some device is
> > implemented as FPGA core or dedicated circuitry, it does not matter. Fe=
w
> > Time Division Multiplexing devices are related to audio, so they are in
> > sound. I don't know if TDD is something else than TDM. If nothing fits,
> > can be misc, but again - just because device does no fit, not the drive=
rs.
>=20
> This device resembles a bit with an IIO device (we are dealing with chann=
els and
> the
> sysfs interface follows the IIO specification), but is not registered int=
o the IIO
> device tree,=20
> and does not rely on IIO kernel APIs.=20
> Do you think this device is a better fit into the IIO subsystem?
>=20

We do have tons of specific attributes (non IIO ones) for this device. The =
ones
resembling IIO is likely because it feels familiar to us in ADI. Anyways, I=
 have my
doubts this fits (at least as IIO stands right now) but maybe Jonathan thin=
ks
otherwise.

+cc Jonathan...

- Nuno S=C3=A1

