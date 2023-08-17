Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E828777F279
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Aug 2023 10:52:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349129AbjHQIwB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Aug 2023 04:52:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348939AbjHQIvi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Aug 2023 04:51:38 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 255E0173F;
        Thu, 17 Aug 2023 01:51:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9F0FF64FCD;
        Thu, 17 Aug 2023 08:51:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3DEF2C433C7;
        Thu, 17 Aug 2023 08:51:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692262296;
        bh=Qd8rl4dDsBAmRMc4EimuxKehqH1wLQ4n81jy3UW3lsM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=QZSSPTr7eM3f8k2zfZpHVWITTlizJVbw9j5zt2V7DY22lbOxShMS9fNDJQgT0GYdv
         OffwRPFi1iSqxDTx6b1aoN7UzQvSHwXlHMesTH1rfWjkmTqIp6OAElAP/Wz16pDsXt
         Cu5JfkmoG2UsvQJPvVUI4gDxf/h0lX+K9GgzyB+8aRZHTa9nhoARdwmfja79XlEehe
         PD8q7Sk+8ibp91++S531fcW5ajdYTtHs0LWYJqD6ca4u5vJt7BMMk75YOTlu4h9kvx
         ctOG1azQM4bTyO4BP8JrnW3yN+GDcxopUsAe8XtiD2PahKoFyEn6TnxIkBYGG6GogA
         6ZvxT000XxJxQ==
Date:   Thu, 17 Aug 2023 09:51:30 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Binbin Zhou <zhoubb.aaron@gmail.com>
Cc:     Binbin Zhou <zhoubinbin@loongson.cn>,
        Huacai Chen <chenhuacai@loongson.cn>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Huacai Chen <chenhuacai@kernel.org>,
        loongson-kernel@lists.loongnix.cn, devicetree@vger.kernel.org,
        Jiaxun Yang <jiaxun.yang@flygoat.com>, diasyzhang@tencent.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: interrupt-controller: loongson,liointc: Fix
 warnings about reg and interrupt description
Message-ID: <20230817-relic-anyplace-4df08eb6b0a9@spud>
References: <20230815084713.1627520-1-zhoubinbin@loongson.cn>
 <20230815-certainly-sprang-209024530924@spud>
 <CAMpQs4+68Ow4-rubj2ySiRiU7d0jc1F3GOsXqxaZdT27PZSuxg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="XGSBf4kp7vglWMW4"
Content-Disposition: inline
In-Reply-To: <CAMpQs4+68Ow4-rubj2ySiRiU7d0jc1F3GOsXqxaZdT27PZSuxg@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--XGSBf4kp7vglWMW4
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 17, 2023 at 10:56:37AM +0800, Binbin Zhou wrote:
> Hi Conor:
>=20
> Thanks for your reply.
>=20
> On Tue, Aug 15, 2023 at 10:20=E2=80=AFPM Conor Dooley <conor@kernel.org> =
wrote:
> >
> > Hey,
> >
> > On Tue, Aug 15, 2023 at 04:47:13PM +0800, Binbin Zhou wrote:
> > > As we know, some Loongson-2K CPUs are single-core, e.g. Loongson-2K05=
00,
> > > and the "isr1" means routing interrupts to core1, which should be
> > > optional. So add maxItems/minItems limits to reg/reg-names.
> > > Also, The interrupt-names attribute represents a list of parent
> > > interrupt names that should change with interrupts.
> >
> > This should have been with the other series that introduces the users
> > probably so that things make more sense to the reader.
>=20
> I was under the impression that the mips Loongson-2K1000 was also
> required for this patch, so I committed it separately.
> Maybe my commit should still be described in more detail.

Ah, I just assumed, given the timing, that it was for the loongson
stuff only.

> > > Signed-off-by: Binbin Zhou <zhoubinbin@loongson.cn>
> > > ---
> > >  .../interrupt-controller/loongson,liointc.yaml     | 14 ++++++------=
--
> > >  1 file changed, 6 insertions(+), 8 deletions(-)
> > >
> > > diff --git a/Documentation/devicetree/bindings/interrupt-controller/l=
oongson,liointc.yaml b/Documentation/devicetree/bindings/interrupt-controll=
er/loongson,liointc.yaml
> > > index 00b570c82903..adb428211a72 100644
> > > --- a/Documentation/devicetree/bindings/interrupt-controller/loongson=
,liointc.yaml
> > > +++ b/Documentation/devicetree/bindings/interrupt-controller/loongson=
,liointc.yaml
> > > @@ -11,7 +11,7 @@ maintainers:
> > >
> > >  description: |
> > >    This interrupt controller is found in the Loongson-3 family of chi=
ps and
> > > -  Loongson-2K1000 chip, as the primary package interrupt controller =
which
> > > +  Loongson-2K series chips, as the primary package interrupt control=
ler which
> > >    can route local I/O interrupt to interrupt lines of cores.
> > >
> > >  allOf:
> > > @@ -33,6 +33,7 @@ properties:
> > >        - const: main
> > >        - const: isr0
> > >        - const: isr1
> > > +    minItems: 2
> > >
> > >    interrupt-controller: true
> > >
> > > @@ -45,11 +46,9 @@ properties:
> > >    interrupt-names:
> > >      description: List of names for the parent interrupts.
> > >      items:
> > > -      - const: int0
> > > -      - const: int1
> > > -      - const: int2
> > > -      - const: int3
> > > +      pattern: int[0-3]
> >
> > From a quick look at the new devicetrees, I don't understand the
> > ordering relaxation. Do you actually have a system that only has, for
> > example, int3?
>=20
> For a better understanding, allow me to first explain the composition
> of the interrupt routing register:
> It is an 8 bit register that is divided into two parts:
> 0-3 : The processor core vector number of the route, this part is
> handled in the code.
> 4-7 : The processor core interrupt pin vector number for routing, i.e.
> int0-int3.
> Each intx can handle 32 interrupt sources.
>=20
> For example, in Loongson-2K1000/Loongson-2K0500, there are a total of
> 64 interrupt sources, and we need to route them to two intx.
>=20
> We don't mandate which interrupt vector number must be used, in our
> practice the tendency is to start with int0.
> It is worth noting that we must follow the following correspondence:
> interrupt->interrupt-names
> 2->int0
> 3->int1
> 4->int2
> 5->int3
>=20
> >
> > Also, as the interrupt-names are not required, changing the ordering
> > here is not ABI compatible AFAICT. Does that have any fallout?
>=20
> Oh, this should be another point that needs to be modified, the
> interrupt-names should be required. because in the driver code the
> parent interrupts are fetched through of_irq_get_byname().

Yeah, that should probably be made required so.

> Also the way liointc-2.0 is written in the dts does not match the dt-bind=
ing.
> The dts using loongson,liointc-2.0 are:


> arch/mips/boot/dts/loongson/loongson64-2k1000.dtsi (mips Loongson-2K1000)
> arch/loongarch/boot/dts/loongson-2k0500.dtsi
> arch/loongarch/boot/dts/loongson-2k1000.dtsi
> arch/loongarch/boot/dts/loongson-2k2000.dtsi
>=20
>                liointc0: interrupt-controller@1fe01400 {
> ......
>                         interrupts =3D <2>;
>                         interrupt-names =3D "int0";
>                         loongson,parent_int_map =3D <0xffffffff>, /* int0=
 */
>                                                 <0x00000000>, /* int1 */
>                                                 <0x00000000>, /* int2 */
>                                                 <0x00000000>; /* int3 */
>                 };
>=20
>                 liointc1: interrupt-controller@1fe01440 {
> ....
>                        interrupts =3D <3>;
>                         interrupt-names =3D "int1";
>                         loongson,parent_int_map =3D <0x00000000>, /* int0=
 */
>                                                 <0xffffffff>, /* int1 */
>                                                 <0x00000000>, /* int2 */
>                                                 <0x00000000>; /* int3 */
>                 };
>=20
> We split the two intx into two nodes because of register definitions
> etc. There is the following WARNING at liointc1:

Did you split it in two because of register definitions, or because
there are physically two controllers on the SoC? Your comments earlier
sound like there are physically two interrupt controllers, which would
be a valid reason to split the nodes.

Thanks,
Conor.

>       arch/loongarch/boot/dts/loongson-2k1000-ref.dtb:
> interrupt-controller@1fe01440: interrupt-names:0: 'int0' was expected
>             From schema:
> Documentation/devicetree/bindings/interrupt-controller/loongson,liointc.y=
aml
>       arch/loongarch/boot/dts/loongson-2k1000-ref.dtb:
> interrupt-controller@1fe01440: Unevaluated properties are not allowed
> ('interrupt-names' was unexpected)
>             From schema:
> Documentation/devicetree/bindings/interrupt-controller/loongson,liointc.y=
aml
>=20
> But actually, in liointc1, we only need int1.
>=20
> Thanks.
> Binbin
>=20
> >
> > Thanks,
> > Conor.
> >
> > >      minItems: 1
> > > +    maxItems: 4
> > >
> > >    '#interrupt-cells':
> > >      const: 2
> > > @@ -73,7 +72,6 @@ required:
> > >    - '#interrupt-cells'
> > >    - loongson,parent_int_map
> > >
> > > -
> > >  unevaluatedProperties: false
> > >
> > >  if:
> > > @@ -86,7 +84,8 @@ if:
> > >  then:
> > >    properties:
> > >      reg:
> > > -      minItems: 3
> > > +      minItems: 2
> > > +      maxItems: 3
> > >
> > >    required:
> > >      - reg-names
> > > @@ -113,7 +112,6 @@ examples:
> > >                                  <0x0f000000>, /* int1 */
> > >                                  <0x00000000>, /* int2 */
> > >                                  <0x00000000>; /* int3 */
> > > -
> > >      };
> > >
> > >  ...
> > > --
> > > 2.39.3
> > >

--XGSBf4kp7vglWMW4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZN3fkgAKCRB4tDGHoIJi
0qeiAQC48uJhGm5S0zx+3EjnM3KuMHRmghXyLuza1Y5CdbjqFQD+OuzLxoxk/izg
946fONTVDL2++8emavM3aos75p0WEAY=
=MxGk
-----END PGP SIGNATURE-----

--XGSBf4kp7vglWMW4--
