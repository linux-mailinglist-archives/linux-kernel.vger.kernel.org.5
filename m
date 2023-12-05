Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2FBF180571E
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 15:22:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345903AbjLEOVy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Dec 2023 09:21:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345927AbjLEOVv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Dec 2023 09:21:51 -0500
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA05AB9
        for <linux-kernel@vger.kernel.org>; Tue,  5 Dec 2023 06:21:54 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ore@pengutronix.de>)
        id 1rAWJ2-0000Ia-Mh; Tue, 05 Dec 2023 15:21:48 +0100
Received: from [2a0a:edc0:2:b01:1d::c0] (helo=ptx.whiteo.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <ore@pengutronix.de>)
        id 1rAWJ1-00DlP4-J3; Tue, 05 Dec 2023 15:21:47 +0100
Received: from ore by ptx.whiteo.stw.pengutronix.de with local (Exim 4.92)
        (envelope-from <ore@pengutronix.de>)
        id 1rAWJ1-005POG-Ff; Tue, 05 Dec 2023 15:21:47 +0100
Date:   Tue, 5 Dec 2023 15:21:47 +0100
From:   Oleksij Rempel <o.rempel@pengutronix.de>
To:     =?utf-8?B?S8O2cnk=?= Maincent <kory.maincent@bootlin.com>
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
Message-ID: <20231205142147.GL981228@pengutronix.de>
References: <20231201-feature_poe-v2-0-56d8cac607fa@bootlin.com>
 <20231201-feature_poe-v2-7-56d8cac607fa@bootlin.com>
 <20231204230845.GH981228@pengutronix.de>
 <20231205063606.GI981228@pengutronix.de>
 <20231205111501.43f80846@kmaincent-XPS-13-7390>
 <20231205143123.703589c8@kmaincent-XPS-13-7390>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231205143123.703589c8@kmaincent-XPS-13-7390>
X-Sent-From: Pengutronix Hildesheim
X-URL:  http://www.pengutronix.de/
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
User-Agent: Mutt/1.10.1 (2018-07-13)
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ore@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 05, 2023 at 02:31:23PM +0100, Köry Maincent wrote:
> On Tue, 5 Dec 2023 11:15:01 +0100
> Köry Maincent <kory.maincent@bootlin.com> wrote:
> 
> > On Tue, 5 Dec 2023 07:36:06 +0100
> > Oleksij Rempel <o.rempel@pengutronix.de> wrote:
>  
> > > I would expect a devicetree like this:
> > > 
> > >         ethernet-pse@3c {
> > > 	  // controller compatible should be precise
> > >           compatible = "microchip,pd69210";
> > >           reg = <0x3c>;
> > >           #pse-cells = <1>;
> > >           
> > > 	  managers {
> > > 	    manager@0 {
> > > 	      // manager compatible should be included, since we are
> > > 	      // able to campare it with communication results
> > > 	      compatible = "microchip,pd69208t4"
> > > 	      // addressing corresponding to the chip select addressing
> > > 	      reg = <0>;
> > > 
> > > 	      physical-ports {
> > > 	        phys0: port@0 {
> > > 		  // each of physical ports is actually a regulator
> 
> If this phys0 is a regulator, which device will be the consumer of this
> regulator? log_port0 as the phys0 regulator consumer seems a bit odd!

Why?

> A 8P8C node should be the consumer.

PHY is not actual consumer of this regulator. State of the Ethernet PHY
is not related to the power supply. We should deliver power independent
of network interface state. There is no other local consumer we can
use in this case.

> > > 		  reg = <0>;
> > > 		};
> > > 	        phys1: port@1 {
> > > 		  reg = <1>;
> > > 		};
> > > 	        phys2: port@2 {
> > > 		  reg = <2>;
> > > 		};
> > > 
> > >                ...
> > > 	      }
> > > 
> > >           // port matrix can be calculated by using this information
> > >           logical-ports {
> > > 	    log_port0: port@0 {
> > > 	      // PoE4 port
> > > 	      physical-ports = <&phys0, &phys1>;
> > > 	    };
> > > 	    log_port1: port@1 {
> > > 	      // PoE2 port
> > > 	      physical-ports = <&phys2>;
> > > 	    };
> > > 	  };
> > > 
> > > ....
> > >    ethernet-phy@1 {
> > >      reg = <1>;
> > >      pses = <&log_port0>;
> > >    }
> > >    ethernet-phy@2 {
> > >      reg = <2>;
> > >      pses = <&log_port1>;
> > >    }  
> 
> In fact if we want to really fit the PoE architecture topology we should wait
> for the support of 8P8C connector from Maxime. Then it will look like that:
> SoC  --- i2c/uart --> controller -- spi --> manager0 -- phys_port0 --> 8P8C_connector0 (PoE4)
>                                          |           \- phys_port1 --> 8P8C_connector0 (PoE4)
> 					 |	     \- phys_port2 --> 8P8C_connector1 (PoE2)
> 					 |	     \- phys_port3 --> 8P8C_connector2 (PoE2)
>                                          \- manager1 -- phys_port0 ..
> 
> With this type of devicetree:
>         ethernet-pse@3c {
> 	  // controller compatible should be precise
>           compatible = "microchip,pd69210";
>           reg = <0x3c>;
>           #pse-cells = <1>;
>           
> 	  managers {
> 	    manager@0 {
> 	      // manager compatible should be included, since we are
> 	      // able to compare it with communication results
> 	      compatible = "microchip,pd69208t4"
> 	      // addressing corresponding to the chip select addressing
> 	      reg = <0>;
> 
> 	      physical-ports {
> 	        phys_port0: port@0 {
> 		  // each of physical ports is actually a regulator
> 		  reg = <0>;
> 		};
> 	        phy_port1: port@1 {
> 		  reg = <1>;
> 		};
> 	        phy_port2: port@2 {
> 		  reg = <2>;
> 		};
> 
>                ...
> 	      }
> 	    manager@1 {
>             ...
>             };
>           };
> 	};
> 
> ....
>   rj45_0:8p8c@0 {
>     pses = <&phy_port0, &phy_port1>;
>   };
>   rj45_1:8p8c@1 {
>     pses = <&phy_port2>;
>   };
>   ethernet-phy@1 {
>     reg = <1>;
>     connector = <&rj45_0>;
>   };
>   ethernet-phy@2 {
>     reg = <2>;
>     connector = <&rj45_1>;
>   }
> 
> 
> The drawback is that I don't really know for now, how port matrix can be
> calculated with this. Maybe by adding a "conf_pse_cell()" callback, call
> in the of_pse_control_get() for each ports.
> 
> For now 8p8c connector are not supported, we could keep using pse phandle
> in the phy node like you described but for physical port:
>    ethernet-phy@1 {
>      reg = <1>;
>      pses = <&phy_port0, &phy_port1>;
>    }
>    ethernet-phy@2 {
>      reg = <2>;
>      pses = <&phy_port2>;
>    }
> 
> 
> 
> Finally, the devicetree would not know the matrix between logical port and
> physical port, this would be cleaner.
> 
> Did I miss something?

In case different PSE suppliers are linked withing the PHY node, we
loose most of information needed for PSE functionality. For example how
we will know if our log_port supports PoE4 and PoE2 mode, or only PoE2.
This information is vital for proper PSE configuration, this is why I
suggested to have logica-ports subnodes. With the price of hawing huge
DT on a switch with 48 ports.

-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
