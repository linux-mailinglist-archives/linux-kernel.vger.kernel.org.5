Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 533CE80A528
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Dec 2023 15:11:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1573901AbjLHOLX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Dec 2023 09:11:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1573881AbjLHOLU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Dec 2023 09:11:20 -0500
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19A5610EB;
        Fri,  8 Dec 2023 06:11:26 -0800 (PST)
Received: by mail-lf1-x12e.google.com with SMTP id 2adb3069b0e04-50c04ebe1bbso1991762e87.1;
        Fri, 08 Dec 2023 06:11:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702044684; x=1702649484; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Ofk5EFlKJHCqg0e0b4hwUj6ByVii3nlBz86s3UMME0U=;
        b=QjXWUsLg24F6bBoLAWT3inePh9UrHcZbukyROPmGhFzA7Closh0Bupoc3TbTti2PbU
         RSU9dfW/dFxfjct3DqT7TdO5ZUsJhlLqtkxZrKTImVssro9QzrFCIWQjltSMIx90e+Fy
         d/x1MNDGi9UnTO8v3k429tC3ZXGKatHntO5HLI72CdBPczd/Xw6ujpYp9o57eD1x6Zsq
         X+3iS4Pi0/Nb3ybQr1UpjTga2ZUfqApbUek129ajr+wd5VIqrzHJ0RtTPxKaA4cxyTxU
         w1PGAylqrh+HEKlSCBxBeSsktGD0WppwwJlwB1j3Pqg8sMT2Rptb6DKz1wLTAFKI4ABx
         nssw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702044684; x=1702649484;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ofk5EFlKJHCqg0e0b4hwUj6ByVii3nlBz86s3UMME0U=;
        b=sRP4F3o8kcNYiRR5lY995q7ToPSB3g1S0HUVEELI9leInltcQFC7lbvVF+vwc12MUK
         1sElcDOVuyuz0Iq07GnZZD6t/HkwdsKgzIo6kERedVQonEDo4mISdW8JfLZBCjpEPOpy
         Z2cBITNIpADSKQROFKE9JN3r3P+h7JH4okX5oWjRsNVU+vcPjV/r+ZLYkAKNIxU5WWms
         3LM33bzSEIIqPxMd+0jzeSfS2ixjJ83xmfS02tcpTpw9p8/iW5HErffcwM/2nRgl45H6
         Xh+lBn23LFh1v8ATxVq/wv6LQki0Us1oufubRuFwTE3T8LpVB5PFew2umjbdVb0IoQl0
         R1hg==
X-Gm-Message-State: AOJu0YwzTnj/8+wFz85TI9iOb4qe4xMKyXV6Z1+cfI6M37fFX5ZIzFgS
        1/qxLatYoZb5CqPQa3ldlrk=
X-Google-Smtp-Source: AGHT+IHQoKexKqSk3g1ukd9drV99fhdVEIs2x55bN7mQBgSXsFoh7P9MpUi5tw0wGeY3is7raDfp6A==
X-Received: by 2002:a05:6512:3c96:b0:50b:c50c:dbc4 with SMTP id h22-20020a0565123c9600b0050bc50cdbc4mr189960lfv.0.1702044683891;
        Fri, 08 Dec 2023 06:11:23 -0800 (PST)
Received: from mobilestation ([178.176.56.174])
        by smtp.gmail.com with ESMTPSA id k4-20020a05651210c400b0050bef21a012sm226400lfg.191.2023.12.08.06.11.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Dec 2023 06:11:23 -0800 (PST)
Date:   Fri, 8 Dec 2023 17:11:20 +0300
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
Message-ID: <nflj4ajgx3byqhwna2eslldwulbbafmcwba4dwgxo65o5c7pmj@zbgqt2zje4ix>
References: <20231205103559.9605-1-fancer.lancer@gmail.com>
 <20231205103559.9605-11-fancer.lancer@gmail.com>
 <20231205111351.xjjuwpbf7kwg3vuh@skbuf>
 <uivunnjv5vi3w3fkc5w2f4lem5bingrgajgjfsu2ih7fuhz6hd@3naeubr5spak>
 <20231205122316.ihhpklv222f5giz3@skbuf>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231205122316.ihhpklv222f5giz3@skbuf>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Vladimir

On Tue, Dec 05, 2023 at 02:23:16PM +0200, Vladimir Oltean wrote:
> On Tue, Dec 05, 2023 at 02:35:46PM +0300, Serge Semin wrote:
> > Omg, thank you very much for testing the series straight away and
> > sorry for the immediate trouble it caused. I'll need some more time
> > for investigation. I'll get back to this topic a bit later on this
> > week.
> 
> Don't worry, I got suspicious when I was CCed to review only a one-line
> change in patch 11/16. It's never about that one line, is it?)

Right. I should have added you to the list of recipients of the entire
series since the patchset changes more than that. The bug you caught
brightly highlights my mistake. I'll make sure you are in the list.
I'll add Jiawen and Mengyuan there too since the driver under their
maintenance is also affected. Hopefully they'll get to test the series
too.

> 
> Anyway, the NULL dev->p is a symptom of device_add() not having been
> called, most likely from mdio_device_register().

Absolutely right. I thought that mdio_device_create() having the
device_initialize() method called was enough for the device_attach()
function being happy. It turns out it wasn't and I missed that the
device_private instance is allocated only on the device registration.
So I'll need to call mdio_device_register() after all, if I get to
preserve the current design of the solution.

> 
> I'll be honest and say that I still don't quite understand what you're
> trying to achieve. You're trying to bind the hardcoded mdio_devices
> created by xpcs_create() to a driver? 

My idea was to reuse the mdio_device which has already been created
either by means of the MDIO-bus OF-subnode or by means of the MDIO-bus
board_info infrastructure (can be utilized in the SJA1105 or Wangxun
Tx GBE). The xpcs_create() method then either probes the device on the MDIO
bus and gets ID from there, or just uses the custom IDs based on the
OF compatible match table or on the platform_data. If no MDIO-device
was created my patchset is supposed to preserve the previous
semantics: create MDIO-device, probe the device on the MDIO-bus, get
device IDs from there. See the next patch for more details:
https://lore.kernel.org/netdev/20231205103559.9605-11-fancer.lancer@gmail.com/

> That was attempted a while ago by
> Sean Anderson with the Lynx PCS. Are you aware of the fact that even in
> the good case in which binding the driver actually works, the user can
> then come along and unbind it from the PCS device, and phylink isn't
> prepared to handle that, so it will crash the kernel upon the next
> phylink_pcs call?

To be honest I didn't consider the driver bind/unbind option. But my
case a bit different. DW XPCS MDIO-device is supposed to be created
automatically by means of the DW XPCS MI driver from the DT-nodes
hierarchy like this:
mdio@1f05d000 {
	compatible = "snps,dw-xpcs-mi";
	reg = <0 0x1f05d000 0 0x1000>;

	xgmac_pcs: ethernet-pcs@0 {
		compatible = "snps,dw-xpcs";
		reg = <0>;
	};
};
The platform-device is created for the mdio@1f05d000 node for which
the DW XPCS MI driver is loaded, which calls the
devm_of_mdiobus_register() in the probe() method which registers the
MDIO-bus and then creates the MDIO-device from the ethernet-pcs@0
node. The DW XPCS MDIO-device driver is attached to that MDIO-device
then. In such model the PCS can be supplied to the DW *MAC via the
"pcs-handle = &xgmac_pcs" property.

Regarding the current semantics it's preserved in the framework of the
xpcs_create_byaddr() method (former xpcs_create_mdiodev()) by means of
the next code snippet:
        if (mdiobus_is_registered_device(bus, addr)) {
                mdiodev = bus->mdio_map[addr];
                mdio_device_get(mdiodev);
        } else {
                mdiodev = mdio_device_create(bus, addr);
                if (IS_ERR(mdiodev))
                        return ERR_CAST(mdiodev);
        }
Device can be automatically created if before registering the MDIO-bus
the xpcs_create_byaddr() caller registered the MDIO-device board info
by means of the mdiobus_register_board_info() method. In addition to
that it's now possible to supply some custom data (custom device IDs
in my implementation) to the XPCS driver by means of the
mdio_board_info.platform_data field. See the next patch for
reference:
https://lore.kernel.org/netdev/20231205103559.9605-14-fancer.lancer@gmail.com

So what the difference with the Lynx PCS is that in my case the
MDIO-device is created automatically as a result of the DW XPCS MI
MDIO-bus registration. Additionally I implemented the MDIO-device
creation based on the MDIO-board-info, thus there won't be need in the
calling mdio_device_create() on each xpcs_create_mdiodev() invocation.
The later part isn't that important in the framework of this
conversation, but just so you be aware.

Regarding the driver bind/unbind. As I said I didn't actually consider
that option. On the other hand my DW XPCS MDIO-device driver doesn't
do actual probe() or remove(). The only implemented thing is the
of_device_id table, which is used to assign PCS and PMA IDs if
required based on the DT compatible property. So I can easily drop any
MDIO device-driver part and parse the of_device_id table right in the
xpcs_create_bynode(). From that perspective my implementation won't
differ much from the Lynx PCS design. The only difference will be is
the way the MDIO-bus is created and registered. In case of Lynx PCS
the bus is created by the MAC-driver itself. In my case DW XPCS MI is
currently created in the framework of the separate platform driver. Do
you think it would be better to follow the Lynx design pattern in
order to get rid from the possibility of the DW XPCS MI driver being
unbound behind the STMMAC+XPCS couple back?

In this case the Dw MAC DT-node hierarchy would look like this:

xgmac: ethernet@1f054000 {
	compatible = "snps,dwxgmac";
	reg = <0 0x1f054000 0 0x4000>;
	reg-names = "stmmaceth";
	ranges;

	...

	pcs-handle = &xgmac_pcs;

	// DW XPCS MI to access the DW XPCS attached to the device
	mdio@1f05d000 {
		compatible = "snps,dwmac-mi";
		reg = <0 0x1f05d000 0 0x1000>;

		xgmac_pcs: ethernet-pcs@0 {
			compatible = "snps,dw-xpcs";
			reg = <0>;
		};
	};

	// Normal MDIO-bus to access external PHYs (it's also called
	// as SMA - Station Management Agent - by Synopsys)
	mdio {
		compatible = "snps,dwmac-mdio";
		#address-cells = <1>;
		#size-cells = <0>;
	};
};

I actually thought to use that hardware description pattern instead,
but after some meditation around that I decided that having the DW
XPCS device defined separately from the DW MAC node seemed better at
least from the code separation point of view. Now I think that it
wasn't the best decision. DW XPCS is always attached to the DW XGMAC
controller. So it would be more correct having it defined as a
sub-node. It would also helped to avoid the platform device driver
bind/unbind problem.

What do you think? Should I re-design my patchset to be supporting the
design above? (After having conversion with you I am more inclined to
do that now than to stick with the currently implemented solution.)

> 
> The pcs-rzn1-miic.c driver puts a device_link to the MAC to at least
> tear down the whole thing when the PCS is unbound, which is saner than
> crashing the kernel. I don't see the equivalent protection mechanism here?

You are right. I don't have any equivalent protection here. Thanks for
suggesting a solution.

> 
> Can't the xpcs continue to live without a bound driver? Having a
> compatible string in the OF description is perfectly fine though,
> and should absolutely not preclude that.

As I explained above Dw XPCS device can live without a bound driver
because the DW XPCS MDIO-driver doesn't do much but merely gets to be
bound based on the of_device_id table. In my case the problem is in
the DW XPCS MI driver which indeed can be detached. Please see my
long-read text above.

-Serge(y)
