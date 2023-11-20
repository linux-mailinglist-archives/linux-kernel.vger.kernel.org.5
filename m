Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C0DC7F1E99
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Nov 2023 22:16:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232227AbjKTVQl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Nov 2023 16:16:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233746AbjKTVAM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Nov 2023 16:00:12 -0500
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8CBDA2;
        Mon, 20 Nov 2023 13:00:08 -0800 (PST)
Received: by mail-wm1-x32b.google.com with SMTP id 5b1f17b1804b1-4079ed65471so21334415e9.1;
        Mon, 20 Nov 2023 13:00:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700514007; x=1701118807; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=jYKLLE+jJbOuTTyZediGWw7197Qa90AHY4Go8ZX9f18=;
        b=LhyQ6Hyg9/4JPaQMpQYcoikvP6HmTagLd+gZVTUT0HbbnHCMRUYMpoCPt81JSej1Wu
         oU6QS/j/JeKKiCmhzY9I0GgXp6KAAXOKlxzJS/flQOUoDkb9GR4sR5FvnzqIKqCJj8Cf
         qJzsYr5XX+nSmRJuqVkUENYAjK4ZTIwPj2Oh7XH0bDEUeiYFtTzZYF3aoeU0qCCfpeZh
         UYtP1tPf4OC5/3+o39ptNsEJ7d1iYCtkd1gcndJJKkit32w2vpji245+/7SZuty2Asyk
         A14Kr+KlnSZuaBggCYSXVGDFGFs+0YArdo6CE4nk7VHSkg7lE+1Mz+dHWIJhsb7b+02B
         gbsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700514007; x=1701118807;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jYKLLE+jJbOuTTyZediGWw7197Qa90AHY4Go8ZX9f18=;
        b=atEoazu2QE22NV1RXA0jkpF4Jy8F0dWRKJmUgqMTdmSwyQ+adxDy405HUsYGFfq2Xz
         Sz9gMVvLUcWPOHDWm8SlfMMQogg3IqdngrE8RGPzYx3ic8LMLcW/ZJ2INZ8Ky1n3xPjZ
         7C+j7gu+RRtGAkR0VXgzEp+JzytSrjYDRnPVhjjaF34jWIr1n7HaU9f5jd2YjQHMhh/h
         31u1BeB8R9WV0k8UHmiKBVwHjQYS48njJ++lS8n7iYcRe5jjllAUFlKx0B+OGokEeXlz
         aWwqFBJTl6x3k/wNh0tC/U0fc4Q0FPPlDOlHL0PvRxoErF0cgYPay6wqwmEZI4qnrc9K
         rhZg==
X-Gm-Message-State: AOJu0YwrXU16aQ2XZ1O4rswyqrcGOLO3B92FfvSyUmxPhYUH0b1oWvEu
        iO90UrendafT+M0KvHByaBs=
X-Google-Smtp-Source: AGHT+IFp1HLEPbyavvdDiwhKJ8BkAi0jfFUb1yVWVJkvHyRyRHYQ7STDgdXMMPdlUQts0uv0rR4Yww==
X-Received: by 2002:a05:600c:524c:b0:40a:28b1:70f8 with SMTP id fc12-20020a05600c524c00b0040a28b170f8mr6734823wmb.21.1700514006622;
        Mon, 20 Nov 2023 13:00:06 -0800 (PST)
Received: from Ansuel-xps. (93-34-89-13.ip49.fastwebnet.it. [93.34.89.13])
        by smtp.gmail.com with ESMTPSA id p13-20020a05600c358d00b0040841e79715sm14886075wmq.27.2023.11.20.13.00.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Nov 2023 13:00:06 -0800 (PST)
Message-ID: <655bc8d6.050a0220.d22f2.315f@mx.google.com>
X-Google-Original-Message-ID: <ZVugxvXKbZqD3MXC@Ansuel-xps.>
Date:   Mon, 20 Nov 2023 19:09:10 +0100
From:   Christian Marangi <ansuelsmth@gmail.com>
To:     Andrew Lunn <andrew@lunn.ch>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        Florian Fainelli <florian.fainelli@broadcom.com>,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>,
        Daniel Golle <daniel@makrotopia.org>,
        Qingfang Deng <dqfext@gmail.com>,
        SkyLake Huang <SkyLake.Huang@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        David Epping <david.epping@missinglinkelectronics.com>,
        Vladimir Oltean <olteanv@gmail.com>,
        "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
        Harini Katakam <harini.katakam@amd.com>,
        Simon Horman <horms@kernel.org>,
        Robert Marko <robert.marko@sartura.hr>, netdev@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Subject: Re: [net-next RFC PATCH 03/14] dt-bindings: net: document ethernet
 PHY package nodes
References: <20231120135041.15259-1-ansuelsmth@gmail.com>
 <20231120135041.15259-4-ansuelsmth@gmail.com>
 <c21ff90d-6e05-4afc-b39c-2c71d8976826@lunn.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c21ff90d-6e05-4afc-b39c-2c71d8976826@lunn.ch>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 20, 2023 at 09:44:58PM +0100, Andrew Lunn wrote:
> On Mon, Nov 20, 2023 at 02:50:30PM +0100, Christian Marangi wrote:
> > Document ethernet PHY package nodes used to describe PHY shipped in
> > bundle of 4-5 PHY. These particular PHY require specific PHY in the
> > package for global onfiguration of the PHY package.
> > 
> > Example are PHY package that have some regs only in one PHY of the
> > package and will affect every other PHY in the package, for example
> > related to PHY interface mode calibration or global PHY mode selection.
> 
> I think you are being overly narrow here. The 'global' registers could
> be spread over multiple addresses. Particularly for a C22 PHY. I
> suppose they could even be in a N+1 address space, where there is no
> PHY at all.
> 
> Where the global registers are is specific to a PHY package
> vendor/model. The PHY driver should know this. All the PHY driver
> needs to know is some sort of base offset. PHY0 in this package is
> using address X. It can then use relative addressing from this base to
> access the global registers for this package.

Yes that would also work but adds extra fragile code in PHY driver.
An idea might be define PHY package node with a reg that is the base
addr... and if we really want every PHY in the PHY package node is an
offset of the base addr.

>  
> > It's also possible to specify the property phy-mode to specify that the
> > PHY package sets a global PHY interface mode and every PHY of the
> > package requires to have the same PHY interface mode.
> 
> I don't think it is what simple. See the QCA8084 for example. 3 of the
> 4 PHYs must use QXGMII. The fourth PHY can also use QXGMII but it can
> be multiplexed to a different PMA and use 1000BaseX, SGMII or
> 2500BaseX.

Yes that is totally a problem but I think it can only be handled with
some validation in the PHY driver... I assume probe_once would validate
the modes?

> 
> I do think we need somewhere to put package properties. But i don't
> think phy-mode is such a property. At the moment, i don't have a good
> example of a package property.
> 

And this is the main problem with this thing... Find a good way to
define them that everyone is OK with.

Another idea might be introduce to each PHY a property that point to the
PHY package node (phandle) with all the info... But where to place
that??? Outside mdio node? That would be confusing... This is why I like
this subnode way.

I know it deviates a bit from the normal way of defining small node in
the mdio node one for each PHY.

> > +examples:
> > +  - |
> > +    ethernet {
> > +        #address-cells = <1>;
> > +        #size-cells = <0>;
> > +
> > +        ethernet-phy-package {
> > +            compatible = "ethernet-phy-package";
> > +            #address-cells = <1>;
> > +            #size-cells = <0>;
> 
> You have the PHYs within the Ethernet node. This is allowed by DT, for
> historic reasons. However, i don't remember the last time a patch was
> submitted that actually used this method. Now a days, PHYs are on an
> MDIO bus, and they are children of that bus in the DT representation.
> However you represent the package needs to work with MDIO busses.
> 

Using the ethernet node was an oversight and actually this is defined as
a subnode in the mdio node.

A real DT that use this is (ipq807x):

&mdio {
	status = "okay";
	pinctrl-0 = <&mdio_pins>;
	pinctrl-names = "default";
	reset-gpios = <&tlmm 37 GPIO_ACTIVE_LOW>;

	ethernet-phy-package {
		compatible = "ethernet-phy-package";
		phy-mode = "psgmii";

		global-phys = <&qca8075_4>, <&qca8075_psgmii>;
		global-phy-names = "combo", "analog_psgmii";

		qca8075_0: ethernet-phy@0 {
			compatible = "ethernet-phy-ieee802.3-c22";
			reg = <0>;
		};

		qca8075_1: ethernet-phy@1 {
			compatible = "ethernet-phy-ieee802.3-c22";
			reg = <1>;
		};

		qca8075_2: ethernet-phy@2 {
			compatible = "ethernet-phy-ieee802.3-c22";
			reg = <2>;
		};

		qca8075_3: ethernet-phy@3 {
			compatible = "ethernet-phy-ieee802.3-c22";
			reg = <3>;
		};

		qca8075_4: ethernet-phy@4 {
			compatible = "ethernet-phy-ieee802.3-c22";
			reg = <4>;
		};

		qca8075_psgmii: ethernet-phy@5 {
			compatible = "ethernet-phy-ieee802.3-c22";
			reg = <5>;
		};
	};

	qca8081: ethernet-phy@28 {
		compatible = "ethernet-phy-id004d.d101";
		reg = <28>;
		reset-gpios = <&tlmm 31 GPIO_ACTIVE_LOW>;
	};

	aqr113c: ethernet-phy@8 {
		compatible = "ethernet-phy-ieee802.3-c45";
		reg = <8>;
		reset-gpios = <&tlmm 63 GPIO_ACTIVE_LOW>;
	};
};

-- 
	Ansuel
