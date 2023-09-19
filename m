Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97C8E7A64C5
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Sep 2023 15:21:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232324AbjISNWA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Sep 2023 09:22:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232257AbjISNVy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Sep 2023 09:21:54 -0400
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC1B0F9;
        Tue, 19 Sep 2023 06:21:47 -0700 (PDT)
Received: from wsk (85-222-111-42.dynamic.chello.pl [85.222.111.42])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: lukma@denx.de)
        by phobos.denx.de (Postfix) with ESMTPSA id 714F986A63;
        Tue, 19 Sep 2023 15:21:44 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
        s=phobos-20191101; t=1695129705;
        bh=HakaOJT9Ay+e2U9NkAP5DQlXMu7UmHCgYHGIGfiN5lw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=aV6M9f1yQYiTfTfVXp1hfaf/SJMNC1Oul2LykKwnfI5cx0mVZUWGKQnEU+Yn09LS7
         OTjyIC+8s8rRpYZBvWjs6ix+H5QtjYdEdha/AlL6yNwskLU4eGon2gamBQmr8LPrqW
         I3lR9RkYA2F/xJDw4Us2iT7qu/HNa1Z12YzISuBpIfJadVdsYdYGyC/gpUPfafj6AT
         VBfPplKibnLyd16f/C0nEas7hCkorqz2xCGv0y2XwNvTmsLm/XB9zg1Jj9SXNsJYPJ
         Ci2+OAoffkgVEE5Dm8vJe5NWXUBPTp+UtgyFQ0Sbw6lBTMBszoa+JtiG4Vr9ea6lS9
         PliEXxzwo8oAw==
Date:   Tue, 19 Sep 2023 15:21:37 +0200
From:   Lukasz Majewski <lukma@denx.de>
To:     <Parthiban.Veerasooran@microchip.com>
Cc:     <andrew@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
        <kuba@kernel.org>, <pabeni@redhat.com>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <corbet@lwn.net>, <Steen.Hegelund@microchip.com>,
        <rdunlap@infradead.org>, <horms@kernel.org>,
        <casper.casan@gmail.com>, <netdev@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-doc@vger.kernel.org>, <Horatiu.Vultur@microchip.com>,
        <Woojung.Huh@microchip.com>, <Nicolas.Ferre@microchip.com>,
        <UNGLinuxDriver@microchip.com>, <Thorsten.Kummermehr@microchip.com>
Subject: Re: [RFC PATCH net-next 2/6] net: ethernet: add mac-phy interrupt
 support with reset complete handling
Message-ID: <20230919152137.2d1cfb5c@wsk>
In-Reply-To: <852a61a5-8c15-1b5a-bea0-2f0d936722df@microchip.com>
References: <20230908142919.14849-1-Parthiban.Veerasooran@microchip.com>
        <20230908142919.14849-3-Parthiban.Veerasooran@microchip.com>
        <027d8f7b-6932-4d9d-b2f9-5369806a79a3@lunn.ch>
        <852a61a5-8c15-1b5a-bea0-2f0d936722df@microchip.com>
Organization: denx.de
X-Mailer: Claws Mail 3.19.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/qQnP1voX2Z88kBlC9I3wV7k";
 protocol="application/pgp-signature"; micalg=pgp-sha512
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/qQnP1voX2Z88kBlC9I3wV7k
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi Parthiban,

> On 13/09/23 8:09 am, Andrew Lunn wrote:
> > EXTERNAL EMAIL: Do not click links or open attachments unless you
> > know the content is safe=20
> >> +static int oa_tc6_sw_reset(struct oa_tc6 *tc6)
> >> +{
> >> +     long timeleft;
> >> +     u32 regval;
> >> +     int ret;
> >> +
> >> +     /* Perform software reset with both protected and
> >> unprotected control
> >> +      * commands because the driver doesn't know the current
> >> status of the
> >> +      * MAC-PHY.
> >> +      */
> >> +     regval =3D SW_RESET;
> >> +     reinit_completion(&tc6->rst_complete);
> >> +     ret =3D oa_tc6_perform_ctrl(tc6, OA_TC6_RESET, &regval, 1,
> >> true, false);
> >> +     if (ret) {
> >> +             dev_err(&tc6->spi->dev, "RESET register write
> >> failed\n");
> >> +             return ret;
> >> +     }
> >> +
> >> +     ret =3D oa_tc6_perform_ctrl(tc6, OA_TC6_RESET, &regval, 1,
> >> true, true);
> >> +     if (ret) {
> >> +             dev_err(&tc6->spi->dev, "RESET register write
> >> failed\n");
> >> +             return ret;
> >> +     }
> >> +     timeleft =3D
> >> wait_for_completion_interruptible_timeout(&tc6->rst_complete,
> >> +
> >> msecs_to_jiffies(1));
> >> +     if (timeleft <=3D 0) {
> >> +             dev_err(&tc6->spi->dev, "MAC-PHY reset failed\n");
> >> +             return -ENODEV;
> >> +     } =20
> >=20
> > This seems a bit messy and complex. I assume reset is performed once
> > during probe, and never again? So i wonder if it would be cleaner to
> > actually just poll for the reset to complete? You can then remove
> > all this completion code, and the interrupt handler gets simpler? =20
> Ok the spec says the below, that's why I implemented like this.
>=20
> 9.2.8.8 RESETC
> Reset Complete. This bit is set when the MAC-PHY reset is complete
> and ready for configuration. When it is set, it will generate a
> non-maskable interrupt assertion on IRQn to alert the SPI host.
> Additionally, setting of the RESETC bit shall also set EXST =3D 1 in
> the receive data footer until this bit is cleared by action of the
> SPI host writing a =E2=80=981=E2=80=99.

If you don't mind - I would like to ask some extra questions:

1. Could you share which silicon revision of LAN8651 (rev 1 =3D B0 or rev
2 =3D B1) are your using?

2. Do you use 10k Ohm pull up resistor between VDD and the IRQ_N line?

3. Are you using any standard development board with LAN865x device?
Could you share how do you connect reset and irq lines and which CPU do
you use?

Thanks in advance for your help.



>=20
> Yes, I agree that the reset is performed once in the beginning. So I=20
> will poll for the completion and remove this block in the next
> revision.
> >  =20
> >> +     /* Register MAC-PHY interrupt service routine */
> >> +     ret =3D devm_request_irq(&spi->dev, spi->irq, macphy_irq, 0,
> >> "macphy int",
> >> +                            tc6);
> >> +     if ((ret !=3D -ENOTCONN) && ret < 0) {
> >> +             dev_err(&spi->dev, "Error attaching macphy irq
> >> %d\n", ret);
> >> +             goto err_macphy_irq;
> >> +     } =20
> >=20
> > Why is -ENOTCONN special? A comment would be good here. =20
> Ah, it is a mistake. I supposed to use,
>=20
> if (ret)
>=20
> I will correct it in the next version.
> >  =20
> >> -void oa_tc6_deinit(struct oa_tc6 *tc6)
> >> +int oa_tc6_deinit(struct oa_tc6 *tc6)
> >>   {
> >> -     kfree(tc6);
> >> +     int ret;
> >> +
> >> +     devm_free_irq(&tc6->spi->dev, tc6->spi->irq, tc6);
> >> +     ret =3D kthread_stop(tc6->tc6_task);
> >> +     if (!ret)
> >> +             kfree(tc6);
> >> +     return ret;
> >>   } =20
> >=20
> > What is the MAC driver supposed to do if this fails?
> >=20
> > But this problem probably goes away once you use a threaded
> > interrupt handler. =20
> Yes, I agree. Will do that.
> >  =20
> > w> +/* Open Alliance TC6 Standard Control and Status Registers */
> >> +#define OA_TC6_RESET 0x0003          /* Reset Control and Status
> >> Register */ +#define OA_TC6_STS0  0x0008          /* Status
> >> Register #0 */ =20
> >=20
> > Please use the same name as the standard. It use STATUS0, so
> > OA_TC6_STATUS0. Please make sure all your defines follow the
> > standard. =20
> Yes sure.
> >  =20
> >> +
> >> +/* RESET register field */
> >> +#define SW_RESET     BIT(0)          /* Software Reset */ =20
> >=20
> > It is pretty normal to put #defines for a register members after the
> > #define for the register itself:
> >=20
> > #define OA_TC6_RESET    0x0003          /* Reset Control and Status
> > Register */ #define OA_TC6_RESET_SWRESET    BIT(0)
> >=20
> > #define OA_TC6_STATUS0  0x0008          /* Status Register #0 */
> > #define OA_TC6_STATUS0_RESETC           BIT(6)          /* Reset
> > Complete */
> >=20
> > The naming like this also helps avoid mixups. =20
> Ok, I will follow this in the next version.
>=20
> Best Regards,
> Parthiban V
> >=20
> >      Andrew
> >  =20
>=20




Best regards,

Lukasz Majewski

--

DENX Software Engineering GmbH,      Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-59 Fax: (+49)-8142-66989-80 Email: lukma@denx.de

--Sig_/qQnP1voX2Z88kBlC9I3wV7k
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEgAyFJ+N6uu6+XupJAR8vZIA0zr0FAmUJoGEACgkQAR8vZIA0
zr0uQAgA0xMyrDzGa5fGdxadtqyUyfG5sBGsBmqm44N0+h+lg/DcdsUrn+nhRum3
52rIg9c2BYJ7AclrBc+cECjeaYyJPt1ZOnTMaSvSgJCWtlwsS5NkE766nmb1I9C2
+3PS3CzlKhZLYsnHouoTI5/edJoD1bJDSFggKuk2cfaqMkA6BUnvInefFMdO59wA
ySoS+wNfhbMWhvN4w7Nfn/fT3beqRt2Lj+mG8I5q4ax8WqApVNjT7CuGJTgL8z69
rVsZMHeeXsbl+FQJlcSyWICFAYZ4Z+8A1StNqatNFAIGkQ0bbYalmM91O57Gxl3d
am40I8ceuyUsO7lfHrPaUREhp2Xn3w==
=C025
-----END PGP SIGNATURE-----

--Sig_/qQnP1voX2Z88kBlC9I3wV7k--
