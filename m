Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 812C2812F7C
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 12:54:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1444162AbjLNLyC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Dec 2023 06:54:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1444112AbjLNLyB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Dec 2023 06:54:01 -0500
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3907711D;
        Thu, 14 Dec 2023 03:54:06 -0800 (PST)
Received: by mail-lj1-x236.google.com with SMTP id 38308e7fff4ca-2cc3f5e7451so14210131fa.2;
        Thu, 14 Dec 2023 03:54:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702554844; x=1703159644; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=V7+aRWAkIzgyWUY4sx/7QAS6Ypietmy0ZSqo26FsTYc=;
        b=jt1S1Jn0UoCWU5vrlky3cHoetimvGr/bmq0JF1fh+C93JXq6Vti9QLBnw3dNWe9lYj
         vVC10WbVKUdaoRynO2vH4FbjHE2HbZvGRaeT2chx5OjjSmm0uuFjHk4iFVGX6/iKYE+N
         h1hm7/KA4fduzMsVX1LfblArtTRo7vF8UWVw7AsrsQhsA4CpJcu09Cc1mmaz45TTFffA
         jboRDdbzmTzyreBDe8foieurfX9NioUQ7+ftM7D50tFUQZBpfZNEdv/Apa2w+Gyy7c68
         xfT0KsxfbbSbRbVYAoNxy6o6H68+UQKm6Zr0Z31FpKhXSB90797mJy0kzmwAFUeK89t1
         CGJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702554844; x=1703159644;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=V7+aRWAkIzgyWUY4sx/7QAS6Ypietmy0ZSqo26FsTYc=;
        b=IQWZcedF8n/cdFoJ1viPk0vjMmf1bhbc3oEjn6OGNMDhTA063gm5k8sXzFi3fwWLGq
         qbjggViSet3Nib7udMbUomV/Njxo1oATtghvVH0eFtMouxAoqGfyCFz9h5MKWiADDm9+
         Gi77iBaIkBYrhPqh3nyt1r+9GVLlPo0fIFr3r2Nph38NEHVDoSScPobP8ndCW/+nJMap
         xSj928PnA578phEyOGnOEYgH8CvRSuoUiiK1WL+ZPmofXi8h2v6XzWxAZ3lf7rBQ2dTS
         N5ds1GCV7kFKKIpMwNF+yFOdELgnN0LiHxXypjHgPYO7tW3y0whmkQlWhzh+w+qyVwLQ
         3FIg==
X-Gm-Message-State: AOJu0YzHvXY8IpSOTnknWxPbphHFMWV03tBnZOiJbY2uuKghcOVuu25d
        F8xn0w2DIwAwVYaUTd1wbQs=
X-Google-Smtp-Source: AGHT+IFVVY4pImoqnAUyUVlk7V/S6BT5WxbYZaKOhIh94uqdiYOlxxGRKgPTh8K6SjUjLK8UYPu4Uw==
X-Received: by 2002:a05:651c:506:b0:2cb:3ece:1235 with SMTP id o6-20020a05651c050600b002cb3ece1235mr3754474ljp.38.1702554844048;
        Thu, 14 Dec 2023 03:54:04 -0800 (PST)
Received: from mobilestation ([178.176.56.174])
        by smtp.gmail.com with ESMTPSA id cy22-20020a2e9a16000000b002cc47070ec5sm63225ljb.66.2023.12.14.03.54.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Dec 2023 03:54:03 -0800 (PST)
Date:   Thu, 14 Dec 2023 14:54:00 +0300
From:   Serge Semin <fancer.lancer@gmail.com>
To:     Vladimir Oltean <olteanv@gmail.com>
Cc:     Andrew Lunn <andrew@lunn.ch>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Jose Abreu <joabreu@synopsys.com>,
        Jose Abreu <Jose.Abreu@synopsys.com>,
        Maxime Chevallier <maxime.chevallier@bootlin.com>,
        Tomer Maimon <tmaimon77@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, openbmc@lists.ozlabs.org,
        netdev@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 10/16] net: pcs: xpcs: Add generic DW XPCS
 MDIO-device support
Message-ID: <xhj7jchcv63y2bmnedxqffnmh3fvdxirccdugnnljruemuiurz@ceafs7mivbqp>
References: <20231205103559.9605-1-fancer.lancer@gmail.com>
 <20231205103559.9605-11-fancer.lancer@gmail.com>
 <20231205111351.xjjuwpbf7kwg3vuh@skbuf>
 <uivunnjv5vi3w3fkc5w2f4lem5bingrgajgjfsu2ih7fuhz6hd@3naeubr5spak>
 <20231205122316.ihhpklv222f5giz3@skbuf>
 <nflj4ajgx3byqhwna2eslldwulbbafmcwba4dwgxo65o5c7pmj@zbgqt2zje4ix>
 <20231208163343.5s74bmirfna3o7yw@skbuf>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231208163343.5s74bmirfna3o7yw@skbuf>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Vladimir,

Sorry for the delayed response. Too much work at this time of the year
(ah, Decembers)..(

On Fri, Dec 08, 2023 at 06:33:43PM +0200, Vladimir Oltean wrote:
> On Fri, Dec 08, 2023 at 05:11:20PM +0300, Serge Semin wrote:
> > My idea was to reuse the mdio_device which has already been created
> > either by means of the MDIO-bus OF-subnode or by means of the MDIO-bus
> > board_info infrastructure (can be utilized in the SJA1105 or Wangxun
> > Tx GBE). The xpcs_create() method then either probes the device on the MDIO
> > bus and gets ID from there, or just uses the custom IDs based on the
> > OF compatible match table or on the platform_data. If no MDIO-device
> > was created my patchset is supposed to preserve the previous
> > semantics: create MDIO-device, probe the device on the MDIO-bus, get
> > device IDs from there. See the next patch for more details:
> > https://lore.kernel.org/netdev/20231205103559.9605-11-fancer.lancer@gmail.com/
> > 
> > > That was attempted a while ago by
> > > Sean Anderson with the Lynx PCS. Are you aware of the fact that even in
> > > the good case in which binding the driver actually works, the user can
> > > then come along and unbind it from the PCS device, and phylink isn't
> > > prepared to handle that, so it will crash the kernel upon the next
> > > phylink_pcs call?
> > 
> > To be honest I didn't consider the driver bind/unbind option. But my
> > case a bit different. DW XPCS MDIO-device is supposed to be created
> > automatically by means of the DW XPCS MI driver from the DT-nodes
> > hierarchy like this:
> > mdio@1f05d000 {
> > 	compatible = "snps,dw-xpcs-mi";
> > 	reg = <0 0x1f05d000 0 0x1000>;
> > 
> > 	xgmac_pcs: ethernet-pcs@0 {
> > 		compatible = "snps,dw-xpcs";
> > 		reg = <0>;
> > 	};
> > };
> > The platform-device is created for the mdio@1f05d000 node for which
> > the DW XPCS MI driver is loaded, which calls the
> > devm_of_mdiobus_register() in the probe() method which registers the
> > MDIO-bus and then creates the MDIO-device from the ethernet-pcs@0
> > node. The DW XPCS MDIO-device driver is attached to that MDIO-device
> > then. In such model the PCS can be supplied to the DW *MAC via the
> > "pcs-handle = &xgmac_pcs" property.
> > 
> > Regarding the current semantics it's preserved in the framework of the
> > xpcs_create_byaddr() method (former xpcs_create_mdiodev()) by means of
> > the next code snippet:
> >         if (mdiobus_is_registered_device(bus, addr)) {
> >                 mdiodev = bus->mdio_map[addr];
> >                 mdio_device_get(mdiodev);
> >         } else {
> >                 mdiodev = mdio_device_create(bus, addr);
> >                 if (IS_ERR(mdiodev))
> >                         return ERR_CAST(mdiodev);
> >         }
> > Device can be automatically created if before registering the MDIO-bus
> > the xpcs_create_byaddr() caller registered the MDIO-device board info
> > by means of the mdiobus_register_board_info() method. In addition to
> > that it's now possible to supply some custom data (custom device IDs
> > in my implementation) to the XPCS driver by means of the
> > mdio_board_info.platform_data field. See the next patch for
> > reference:
> > https://lore.kernel.org/netdev/20231205103559.9605-14-fancer.lancer@gmail.com
> > 
> > So what the difference with the Lynx PCS is that in my case the
> > MDIO-device is created automatically as a result of the DW XPCS MI
> > MDIO-bus registration. Additionally I implemented the MDIO-device
> > creation based on the MDIO-board-info, thus there won't be need in the
> > calling mdio_device_create() on each xpcs_create_mdiodev() invocation.
> > The later part isn't that important in the framework of this
> > conversation, but just so you be aware.
> 

> It's not really different, though. You can connect to the Lynx PCS both
> ways, see dpaa2_pcs_create() which also searches for a pcs-handle before
> calling lynx_pcs_create_fwnode().

Ah, right. Lynx PCS also implements the fwnode-based PCS descriptor
creation.

> What's subtly different is that we
> don't (yet) have "fsl,lynx-pcs" compatible strings in the device tree.
> So the MDIO controller will register the PCS devices as struct phy_device
> (which still have an underlying struct mdio_device). The PCS layer
> connects to the underlying struct mdio_device, and the phy_device on top
> remains unconnected to any phylib/phylink MAC driver. That is confusing,
> I should really get to adding those compatible strings to suppress the
> phy_device creation.

It hasn't been confirmed yet here
https://lore.kernel.org/netdev/na6krkoco7pmsl62dfuj2xlrvpsnod74ptpfyy6gv7dzwmowga@mzsiknjian2i/
but AFAICS it is wrong to have a PCS device registered as PHY by any
means: unmasking address in mii_bus->phy_mask or having the
of_mdiobus_child_is_phy() returned true for a DT-node. So right, a
specific compatible should be added to the PCS DT-nodes.

> 
> > Regarding the driver bind/unbind. As I said I didn't actually consider
> > that option. On the other hand my DW XPCS MDIO-device driver doesn't
> > do actual probe() or remove(). The only implemented thing is the
> > of_device_id table, which is used to assign PCS and PMA IDs if
> > required based on the DT compatible property. So I can easily drop any
> > MDIO device-driver part and parse the of_device_id table right in the
> > xpcs_create_bynode(). From that perspective my implementation won't
> > differ much from the Lynx PCS design. The only difference will be is
> > the way the MDIO-bus is created and registered. In case of Lynx PCS
> > the bus is created by the MAC-driver itself.
> 

> Nope, not true. Follow the pcs-handle in arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi.

Ah, right, I missed that case. I was referring to the cases when the
Lynx PCS MDIO node is defined as a sub-node of the MAC node.

> 
> > In my case DW XPCS MI is currently created in the framework of the
> > separate platform driver. Do you think it would be better to follow
> > the Lynx design pattern in order to get rid from the possibility of
> > the DW XPCS MI driver being unbound behind the STMMAC+XPCS couple
> > back?
> 
> I think you actually pointed out a flaw in the Lynx PCS design too.
> Actually, it is a larger flaw in the kernel. You can also unbind the
> MDIO bus which holds the phy_device, and phylib (and therefore also
> phylink) won't expect that either, so it will crash.
> 
> > In this case the Dw MAC DT-node hierarchy would look like this:
> > 
> > xgmac: ethernet@1f054000 {
> > 	compatible = "snps,dwxgmac";
> > 	reg = <0 0x1f054000 0 0x4000>;
> > 	reg-names = "stmmaceth";
> > 	ranges;
> > 
> > 	...
> > 
> > 	pcs-handle = &xgmac_pcs;
> > 
> > 	// DW XPCS MI to access the DW XPCS attached to the device
> > 	mdio@1f05d000 {
> > 		compatible = "snps,dwmac-mi";
> > 		reg = <0 0x1f05d000 0 0x1000>;
> > 
> > 		xgmac_pcs: ethernet-pcs@0 {
> > 			compatible = "snps,dw-xpcs";
> > 			reg = <0>;
> > 		};
> > 	};
> > 
> > 	// Normal MDIO-bus to access external PHYs (it's also called
> > 	// as SMA - Station Management Agent - by Synopsys)
> > 	mdio {
> > 		compatible = "snps,dwmac-mdio";
> > 		#address-cells = <1>;
> > 		#size-cells = <0>;
> > 	};
> > };
> > 
> > I actually thought to use that hardware description pattern instead,
> > but after some meditation around that I decided that having the DW
> > XPCS device defined separately from the DW MAC node seemed better at
> > least from the code separation point of view. Now I think that it
> > wasn't the best decision. DW XPCS is always attached to the DW XGMAC
> > controller. So it would be more correct having it defined as a
> > sub-node. It would also helped to avoid the platform device driver
> > bind/unbind problem.
> > 
> > What do you think? Should I re-design my patchset to be supporting the
> > design above? (After having conversion with you I am more inclined to
> > do that now than to stick with the currently implemented solution.)
> 
> I think that the placement of the "mdio" node as lateral vs subordinate
> to the "ethernet" node would have fixed the issue by mistake. We should
> be looking at it as a structural problem of the kernel instead. Don't
> let it influence what you believe should be the correct design.

Ok. Thanks for clarification. I won't move the PCS device DT-node to
being subordinate of the MAC DT-node then. Although after some more
digging into the problem I figured out that the solution still needs
to be re-designed a bit. Currently I have the DW XPCS device represented as
the nodes hierarchy:
mdio@1f05d000 {
	compatible = "snps,dwmac-mi";
	reg = <0 0x1f05d000 0 0x1000>;

	xgmac_pcs: ethernet-pcs@0 {
		compatible = "snps,dw-xpcs";
		reg = <0>;
	};
};
When I introduced such representation I assumed that it was possible
to have more than one DW XPCS devices accessible over the same MCI/APB
interface with for instance some static offset. But it turned out I
was wrong again. DW XPCS HW databook explicitly states that
port_id_i[4:0] input signal is specific to the MDIO interface only.
That signal is the MDIO-bus address of the device and it doesn't exist
for the DW XPCS devices mapped to the system IO-memory via the MCI/APB
buses. So there can't be more than one XPCS device accessible over the
same MCI/APB port and the correct way to represent the DW XPCS device
is just:
xgmac_pcs: ethernet-pcs@0 {
	compatible = "snps,dw-xpcs";
	reg = <0 0x1f05d000 0 0x1000>;
};
with no superior MI node. I'll re-design my patchset to support the
device representation above then: just create a hidden MDIO-bus in the
DW XPCS driver probe method and directly register the XPCS-device on
it. The patch for the MDIO-bus subsystem will be gone after that.

> 
> > > The pcs-rzn1-miic.c driver puts a device_link to the MAC to at least
> > > tear down the whole thing when the PCS is unbound, which is saner than
> > > crashing the kernel. I don't see the equivalent protection mechanism here?
> > 
> > You are right. I don't have any equivalent protection here. Thanks for
> > suggesting a solution.
> 
> I think that a device link between the "ethernet" device and the "mdio"
> device (controller, parent of the PHY or PCS), if the Ethernet is not a
> parent of the MDIO controller, could also solve that. But it would also
> require ACK from PHY maintainers, who may have grander plans to address
> this snag.

Ok. I'll add it in v2. Let's see what the maintainers think about
that.

Thanks for all your comments in my patchset regard. They are really
helpful.

-Serge(y)

> 
> > > Can't the xpcs continue to live without a bound driver? Having a
> > > compatible string in the OF description is perfectly fine though,
> > > and should absolutely not preclude that.
> > 
> > As I explained above Dw XPCS device can live without a bound driver
> > because the DW XPCS MDIO-driver doesn't do much but merely gets to be
> > bound based on the of_device_id table. In my case the problem is in
> > the DW XPCS MI driver which indeed can be detached. Please see my
> > long-read text above.
> 
> Yeah, common design, common problem.
