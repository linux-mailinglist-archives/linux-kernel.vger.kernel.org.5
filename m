Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D14080897C
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Dec 2023 14:49:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442128AbjLGNtT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Dec 2023 08:49:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232849AbjLGNtS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Dec 2023 08:49:18 -0500
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 604DE10C2;
        Thu,  7 Dec 2023 05:49:24 -0800 (PST)
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 3B7DnDJu093419;
        Thu, 7 Dec 2023 07:49:13 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1701956953;
        bh=WfaUI8G9Kw7xD7ihODTl/rr/KLgCLlkJ948Ob9AdpUM=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=S82R8HymbzabOPl6K5p2XZefLK42I9gmZQg56r+XWlp4KgeFDdGeE14x6s3PNmnER
         wS0bomgdrW3EHScHeqltr1TR0Ga1muYuJVXRiJBq56xCDj2cglW/OgI5zdXp6NVqe/
         Kdx0mluCpWBlWAiRCqwcTbdIHO/2JiDKytyJSh+U=
Received: from DFLE101.ent.ti.com (dfle101.ent.ti.com [10.64.6.22])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 3B7DnDjM012734
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 7 Dec 2023 07:49:13 -0600
Received: from DFLE113.ent.ti.com (10.64.6.34) by DFLE101.ent.ti.com
 (10.64.6.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 7
 Dec 2023 07:49:12 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 7 Dec 2023 07:49:12 -0600
Received: from localhost (uda0133052.dhcp.ti.com [128.247.81.232])
        by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 3B7DnCf8020264;
        Thu, 7 Dec 2023 07:49:12 -0600
Date:   Thu, 7 Dec 2023 07:49:12 -0600
From:   Nishanth Menon <nm@ti.com>
To:     Neha Malcom Francis <n-francis@ti.com>
CC:     "Kumar, Udit" <u-kumar1@ti.com>, <vigneshr@ti.com>,
        <kristo@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <a-nandan@ti.com>, <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <eblanc@baylibre.com>, <jneanne@baylibre.com>,
        <aseketeli@baylibre.com>, <jpanis@baylibre.com>, <j-luthra@ti.com>,
        <vaishnav.a@ti.com>, <hnagalla@ti.com>, <devarsht@ti.com>,
        <sjg@chromium.org>, <trini@konsulko.com>
Subject: Re: [PATCH v9 6/7] arm64: dts: ti: k3-j721e-sk: Add TPS6594 family
 PMICs
Message-ID: <20231207134912.olfhmcz5kkbx47wo@landmine>
References: <20231205093439.2298296-1-n-francis@ti.com>
 <20231205093439.2298296-7-n-francis@ti.com>
 <20231205151647.vh6rlhro7qlwoerc@knelt>
 <5e22f8cb-1004-4bcc-9bd0-2c30180ba10e@ti.com>
 <cc2c3e97-e2c6-487b-91a5-c5f5fbe2c3bc@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cc2c3e97-e2c6-487b-91a5-c5f5fbe2c3bc@ti.com>
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11:01-20231207, Neha Malcom Francis wrote:
> Hi Nishanth, Udit,
> 
> On 07/12/23 10:12, Kumar, Udit wrote:
> > 
> > On 12/5/2023 8:46 PM, Nishanth Menon wrote:
> > > On 15:04-20231205, Neha Malcom Francis wrote:
> > > > This patch adds support for TPS6594 PMIC family on wakeup I2C0 bus.
> > > > These devices provide regulators (bucks and LDOs), but also GPIOs, a
> > > > RTC, a watchdog, an ESM (Error Signal Monitor) which monitors the SoC
> > > > error output signal, and a PFSM (Pre-configurable Finite State Machine)
> > > > which manages the operational modes of the PMIC.
> > > > 
> > > > Signed-off-by: Neha Malcom Francis <n-francis@ti.com>
> > > > ---
> > > >   arch/arm64/boot/dts/ti/k3-j721e-sk.dts | 158 +++++++++++++++++++++++++
> > > >   1 file changed, 158 insertions(+)
> > > > 
> > > > diff --git a/arch/arm64/boot/dts/ti/k3-j721e-sk.dts
> > > > b/arch/arm64/boot/dts/ti/k3-j721e-sk.dts
> > > > index 42fe8eee9ec8..e600825f7e78 100644
> > > > --- a/arch/arm64/boot/dts/ti/k3-j721e-sk.dts
> > > > +++ b/arch/arm64/boot/dts/ti/k3-j721e-sk.dts
> > > > @@ -459,6 +459,13 @@ J721E_IOPAD(0x234, PIN_INPUT, 7) /* (U3)
> > > > EXT_REFCLK1.GPIO1_12 */
> > > >   };
> > > >   &wkup_pmx0 {
> > > > +    pmic_irq_pins_default: pmic-irq-default-pins {
> > > > +        bootph-pre-ram;
> > > > +        pinctrl-single,pins = <
> > > > +            J721E_WKUP_IOPAD(0x0cc, PIN_INPUT, 7) /* (G28) WKUP_GPIO0_7 */
> > > > +        >;
> > > > +    };
> > > > +
> > > >       mcu_cpsw_pins_default: mcu-cpsw-default-pins {
> > > >           pinctrl-single,pins = <
> > > >               J721E_WKUP_IOPAD(0x84, PIN_INPUT, 0) /* (B24) MCU_RGMII1_RD0 */
> > > > @@ -560,6 +567,157 @@ eeprom@51 {
> > > >           compatible = "atmel,24c512";
> > > >           reg = <0x51>;
> > > >       };
> > > > +
> > > > +    tps659413: pmic@48 {
> > > > +        bootph-pre-ram;
> > > only for the leaf nodes. See
> > > https://libera.irclog.whitequark.org/armlinux/2023-10-19
> > 
> > 
> > AFAIK, please correct me, u-boot still needs in all nodes ?
> > 
> 
> That's what I believe as well, is it better to have only the leaf nodes in
> kernel and have U-Boot DTSI handle the parent bootph properties? If so I'll
> send out v10 making change accordingly.
> 

Yes, u-boot today needs it in all nodes. BUT, u-boot needs to be fixed in
line to obey the rules of the schema convention that Rob clarified in
the discussion above.

The other choice is NOT to introduce new bootph properties till u-boot
is fixed up (this is also why I haven't sent out further updates for
bootph properties for kernel in this cycle).

-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D
