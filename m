Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9CEE8809EC2
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Dec 2023 10:06:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235787AbjLHJG1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Dec 2023 04:06:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230390AbjLHJG0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Dec 2023 04:06:26 -0500
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E9B110F9;
        Fri,  8 Dec 2023 01:06:31 -0800 (PST)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 524531BF203;
        Fri,  8 Dec 2023 09:06:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1702026389;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5roaO/aCwaahSO4dVcVLdUYTbvQ3YTQ8egLwSPxt4bM=;
        b=N/IR1J3YGaG2B3y3zFV5bXYB/qJZnhP4RPeZyLOfqlRuwKanawRdBlJDF22sBUFThQchD7
        /UVT6ICns1gH9xX1QMFXv8ZaH1zlfWauOJAfcVMP+VFSgBPrb/gxChfVoLoIrqYyHoud3G
        MygZEk60WMv22KgmDavkfpi6ipk7rOe41YYEHhM+TYwHJsj1pvctPODZfdoHvkefKZ/EF+
        zYmnXIVNq0qPNA6KLk5sZt7MJHVsCJxr4Wzcc8xQ75qKRx/+rDQMzpQmX5H/ljfy9YbJ/B
        ArG/ZX6o3Qc17fygz5FLMqiHckunX4p+ZInvovVUq+szi/rumCkGPEXV54t8mw==
Date:   Fri, 8 Dec 2023 10:06:27 +0100
From:   =?UTF-8?B?S8O2cnk=?= Maincent <kory.maincent@bootlin.com>
To:     Oleksij Rempel <o.rempel@pengutronix.de>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Russ Weight <russ.weight@linux.dev>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, devicetree@vger.kernel.org,
        Dent Project <dentproject@linuxfoundation.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH net-next v2 7/8] dt-bindings: net: pse-pd: Add bindings
 for PD692x0 PSE controller
Message-ID: <20231208100627.2a78e720@kmaincent-XPS-13-7390>
In-Reply-To: <20231205162321.4bd165eb@kmaincent-XPS-13-7390>
References: <20231201-feature_poe-v2-0-56d8cac607fa@bootlin.com>
 <20231201-feature_poe-v2-7-56d8cac607fa@bootlin.com>
 <20231204230845.GH981228@pengutronix.de>
 <20231205063606.GI981228@pengutronix.de>
 <20231205111501.43f80846@kmaincent-XPS-13-7390>
 <20231205143123.703589c8@kmaincent-XPS-13-7390>
 <20231205142147.GL981228@pengutronix.de>
 <20231205162321.4bd165eb@kmaincent-XPS-13-7390>
Organization: bootlin
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-GND-Sasl: kory.maincent@bootlin.com
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 5 Dec 2023 16:23:21 +0100
K=C3=B6ry Maincent <kory.maincent@bootlin.com> wrote:

> On Tue, 5 Dec 2023 15:21:47 +0100
> Oleksij Rempel <o.rempel@pengutronix.de> wrote:
>=20
> > On Tue, Dec 05, 2023 at 02:31:23PM +0100, K=C3=B6ry Maincent wrote: =20
> > > On Tue, 5 Dec 2023 11:15:01 +0100
> > > K=C3=B6ry Maincent <kory.maincent@bootlin.com> wrote:
> > >    =20
> > > > On Tue, 5 Dec 2023 07:36:06 +0100
> > > > Oleksij Rempel <o.rempel@pengutronix.de> wrote:   =20
> > >     =20
> > > > > I would expect a devicetree like this:
> > > > >=20
> > > > >         ethernet-pse@3c {
> > > > > 	  // controller compatible should be precise
> > > > >           compatible =3D "microchip,pd69210";
> > > > >           reg =3D <0x3c>;
> > > > >           #pse-cells =3D <1>;
> > > > >          =20
> > > > > 	  managers {
> > > > > 	    manager@0 {
> > > > > 	      // manager compatible should be included, since we are
> > > > > 	      // able to campare it with communication results
> > > > > 	      compatible =3D "microchip,pd69208t4"
> > > > > 	      // addressing corresponding to the chip select
> > > > > addressing reg =3D <0>;
> > > > >=20
> > > > > 	      physical-ports {
> > > > > 	        phys0: port@0 {
> > > > > 		  // each of physical ports is actually a regulator
> > > > > =20
> > >=20
> > > If this phys0 is a regulator, which device will be the consumer of th=
is
> > > regulator? log_port0 as the phys0 regulator consumer seems a bit odd!=
   =20
> >=20
> > Why?
> >  =20
> > > A 8P8C node should be the consumer.   =20
> >=20
> > PHY is not actual consumer of this regulator. State of the Ethernet PHY
> > is not related to the power supply. We should deliver power independent
> > of network interface state. There is no other local consumer we can
> > use in this case. =20
>=20
> Just to be clear, are you saying we should use the regulator framework or=
 is
> it simply a way of speaking as it behaves like regulator?
>=20
> > > Finally, the devicetree would not know the matrix between logical por=
t and
> > > physical port, this would be cleaner.
> > >=20
> > > Did I miss something?   =20
> >=20
> > In case different PSE suppliers are linked withing the PHY node, we
> > loose most of information needed for PSE functionality. For example how
> > we will know if our log_port supports PoE4 and PoE2 mode, or only PoE2.
> > This information is vital for proper PSE configuration, this is why I
> > suggested to have logica-ports subnodes. With the price of hawing huge
> > DT on a switch with 48 ports. =20
>=20
> It could be known in the of_pse_control_get() function if there is two
> phandles in the "pses" parameter. Then we add a new enum c33_pse_mode mem=
ber
> in the pse_control struct to store the mode.
> PoE2 and PoE4 is not a parameter of the logical port, it depends of the n=
umber
> of PSE ports wired to an 8P8C connector.=20
>=20
> In fact I am also working on the tps23881 driver which aimed to be added =
to
> this series soon. In the tps23881 case the logical port can only be confi=
gured
> to one physical port. Two physical ports (which mean two logical ports) c=
an
> still be used to have PoE4 mode.
> For PoE4, in the pd692x0 driver we use one logical port (one pse_control-=
>id)
> configured to two physical ports but in the tps23881 we will need two log=
ical
> ports (two pse_control->id).
>=20
> So with the tps23881 driver we will need two phandle in the "pses" parame=
ter
> to have PoE4, that's why my proposition seems relevant.
>=20
> The same goes with your pse-regulator driver, you can't do PoE4 if two
> regulators is needed for each two pairs group.

Oleksij, what your thought for the binding I have proposed in the thread.
For the PoE4 we could add a "pses-poe4" bool property alongside the two pha=
ndle
in "pses" property.
Here is the current binding proposition:
        ethernet-pse@3c {
	  // controller compatible should be precise
          compatible =3D "microchip,pd69210";
          reg =3D <0x3c>;
          #pse-cells =3D <1>;
         =20
	  managers {
	    manager@0 {
	      // manager compatible should be included, since we are
	      // able to compare it with communication results
	      compatible =3D "microchip,pd69208t4"
	      // addressing corresponding to the chip select addressing
	      reg =3D <0>;

	      physical-ports {
	        phys_port0: port@0 {
		  // each of physical ports is actually a regulator
		  reg =3D <0>;
		};
	        phy_port1: port@1 {
		  reg =3D <1>;
		};
	        phy_port2: port@2 {
		  reg =3D <2>;
		};

               ...
	      }
	    manager@1 {
            ...
            };
          };
	};

....
  ethernet-phy@1 {
    reg =3D <1>;
    pses-poe4;
    pses =3D <&phy_port0, &phy_port1>;
  };
  ethernet-phy@2 {
    reg =3D <2>;
    pses =3D <&phy_port2>;
  }

Regards,
--=20
K=C3=B6ry Maincent, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com
