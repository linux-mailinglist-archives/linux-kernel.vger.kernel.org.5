Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A3F180B35B
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Dec 2023 10:05:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229595AbjLIJFa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Dec 2023 04:05:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229464AbjLIJF1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Dec 2023 04:05:27 -0500
Received: from nikam.ms.mff.cuni.cz (nikam.ms.mff.cuni.cz [195.113.20.16])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A69AE10D9;
        Sat,  9 Dec 2023 01:05:30 -0800 (PST)
Received: from gimli.ms.mff.cuni.cz (gimli.ms.mff.cuni.cz [195.113.20.176])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by nikam.ms.mff.cuni.cz (Postfix) with ESMTPS id 11D7328044F;
        Sat,  9 Dec 2023 10:05:28 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gimli.ms.mff.cuni.cz;
        s=gen1; t=1702112728;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=gbbyqSK5IuL9LoNBL2boJ6tt8JRfQONwCHbN5+ACzYI=;
        b=OANn2IQIc3+GqlzMzkV1EAEHwtDFF+uN0vIv2HceSdMIg2QaJ1wV3aHLzOLot7TaNkrxam
        sisI3ccxswiMrv1FhgKlKm1B6L/l2RYoR9LSMN3cOWEzN+DMR/a3P2DNx8jjsX8Dg3scXU
        NsEcTnH/OrasVDRlvmPjaoNRXywOjHI=
Received: from localhost (internet5.mraknet.com [185.200.108.250])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (Client did not present a certificate)
        (Authenticated sender: karelb)
        by gimli.ms.mff.cuni.cz (Postfix) with ESMTPSA id 997E544B369;
        Sat,  9 Dec 2023 10:05:27 +0100 (CET)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date:   Sat, 09 Dec 2023 10:05:27 +0100
Message-Id: <CXJOLS2I8WH7.1IMVJGPUNG4VB@gimli.ms.mff.cuni.cz>
From:   "Karel Balej" <karelb@gimli.ms.mff.cuni.cz>
Cc:     "Conor Dooley" <conor@kernel.org>,
        "Dmitry Torokhov" <dmitry.torokhov@gmail.com>,
        "Rob Herring" <robh+dt@kernel.org>,
        "Krzysztof Kozlowski" <krzysztof.kozlowski+dt@linaro.org>,
        "Conor Dooley" <conor+dt@kernel.org>,
        "Henrik Rydberg" <rydberg@bitmath.org>,
        <linux-input@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        =?utf-8?q?Duje_Mihanovi=C4=87?= <duje.mihanovic@skole.hr>,
        <~postmarketos/upstreaming@lists.sr.ht>,
        <phone-devel@vger.kernel.org>, "Karel Balej" <balejk@matfyz.cz>
Subject: Re: [PATCH v3 2/5] dt-bindings: input/touchscreen: Add compatible
 for IST3038B
To:     "Conor Dooley" <conor.dooley@microchip.com>,
        "Markuss Broks" <markuss.broks@gmail.com>
References: <20231202125948.10345-1-karelb@gimli.ms.mff.cuni.cz>
 <20231202125948.10345-3-karelb@gimli.ms.mff.cuni.cz>
 <20231203-outskirts-reformat-e0a833903841@spud>
 <0a035c62-9d35-4f85-b1f3-bcb7dea17d52@gmail.com>
 <20231204-stooge-impotent-fe8d2d9177e4@wendy>
In-Reply-To: <20231204-stooge-impotent-fe8d2d9177e4@wendy>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon Dec 4, 2023 at 1:52 PM CET, Conor Dooley wrote:
> On Mon, Dec 04, 2023 at 02:40:44PM +0200, Markuss Broks wrote:
> > On 12/3/23 13:20, Conor Dooley wrote:
> > > On Sat, Dec 02, 2023 at 01:48:33PM +0100, Karel Balej wrote:
> > > > From: Markuss Broks <markuss.broks@gmail.com>
> > > >=20
> > > > Imagis IST3038B is a variant (firmware?) of Imagis IST3038 IC,
> > > > add the compatible for it to the IST3038C bindings.
> > > This one is better, but would be well served by mentioning what
> > > specifically is different (register addresses or firmware commands?)
> >=20
> > I don't think anyone knows this other than Imagis itself. I would guess=
 it's
> > different hardware, since register addresses are indeed different, but =
on
> > the other hand, there is a possibility that firmware on the MCU could b=
e
> > responding to those commands. I suppose "... IST3038B is a hardware var=
iant
> > of ... IST3038" would be more correct.
>
> Only Imagis might know the specifics, but you (plural) have made driver
> changes so you know what is different in terms of the programming model.
> I'm just asking for you to mention how the programming model varies in
> the commit message. Otherwise I can't know whether you should have added
> a fallback compatible, without going and reading your driver change. The
> commit message for the bindings should stand on its own merit in that
> regard.
> "Variant" alone does not suffice, as many variants of devices have a
> compatible programming model, be that for a subset of features or
> complete compatibility.
>
> > The reason why I think it could be firmware-defined is because we have =
a lot
> > of variants (30xxA, 30xxB, 30xxC, plain 30xx), and the numbers usually =
mean
> > feature level/completeness, e.g. some don't support the touch pressure =
or
> > touchkeys, and we don't know what A/B/C/none means.
>
> Ultimately whether it is due to firmware or the hardware isn't
> particular important, just mention what is incompatibly different.

I propose to update the commit description as such:

	Imagis IST3038B is a variant (firmware?) of Imagis IST3038 IC
	differing from IST3038C in its register interface. Add the
	compatible for it to the IST3038C bindings.

>
> Cheers,
> Conor.
>
>
> > > > Signed-off-by: Markuss Broks <markuss.broks@gmail.com>
> > > > Signed-off-by: Karel Balej <balejk@matfyz.cz>
> > > > ---
> > > >   .../devicetree/bindings/input/touchscreen/imagis,ist3038c.yaml   =
| 1 +
> > > >   1 file changed, 1 insertion(+)
> > > >=20
> > > > diff --git a/Documentation/devicetree/bindings/input/touchscreen/im=
agis,ist3038c.yaml b/Documentation/devicetree/bindings/input/touchscreen/im=
agis,ist3038c.yaml
> > > > index 0d6b033fd5fb..b5372c4eae56 100644
> > > > --- a/Documentation/devicetree/bindings/input/touchscreen/imagis,is=
t3038c.yaml
> > > > +++ b/Documentation/devicetree/bindings/input/touchscreen/imagis,is=
t3038c.yaml
> > > > @@ -18,6 +18,7 @@ properties:
> > > >     compatible:
> > > >       enum:
> > > > +      - imagis,ist3038b
> > > >         - imagis,ist3038c
> > > >     reg:
> > > > --=20
> > > > 2.43.0
> > > >=20
> > - Markuss

Kind regards,
K. B.
