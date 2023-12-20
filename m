Return-Path: <linux-kernel+bounces-6894-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B5363819F0A
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 13:30:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E6EF31C22A1B
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 12:30:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0ACC249E1;
	Wed, 20 Dec 2023 12:30:43 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D664A1B290
	for <linux-kernel@vger.kernel.org>; Wed, 20 Dec 2023 12:30:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mfe@pengutronix.de>)
	id 1rFvic-0004Kn-Pd; Wed, 20 Dec 2023 13:30:34 +0100
Received: from [2a0a:edc0:2:b01:1d::c0] (helo=ptx.whiteo.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <mfe@pengutronix.de>)
	id 1rFvia-000F3J-Bu; Wed, 20 Dec 2023 13:30:33 +0100
Received: from mfe by ptx.whiteo.stw.pengutronix.de with local (Exim 4.92)
	(envelope-from <mfe@pengutronix.de>)
	id 1rFvib-007vlc-Bq; Wed, 20 Dec 2023 13:30:33 +0100
Date: Wed, 20 Dec 2023 13:30:33 +0100
From: Marco Felsch <m.felsch@pengutronix.de>
To: Peng Fan <peng.fan@nxp.com>
Cc: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
	Rob Herring <robh+dt@kernel.org>,
	Oleksii Moisieiev <oleksii_moisieiev@epam.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Sudeep Holla <sudeep.holla@arm.com>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Cristian Marussi <cristian.marussi@arm.com>,
	dl-linux-imx <linux-imx@nxp.com>
Subject: Re: [PATCH 4/7] dt-bindings: firmware: arm,scmi: support pinctrl
 protocol
Message-ID: <20231220123033.nrbperhbr4jifuvh@pengutronix.de>
References: <20231215-pinctrl-scmi-v1-0-0fe35e4611f7@nxp.com>
 <20231215-pinctrl-scmi-v1-4-0fe35e4611f7@nxp.com>
 <20231219192912.yulmczvqbuh4jizg@pengutronix.de>
 <DU0PR04MB94170BCA413C2FD48A397B538896A@DU0PR04MB9417.eurprd04.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DU0PR04MB94170BCA413C2FD48A397B538896A@DU0PR04MB9417.eurprd04.prod.outlook.com>
User-Agent: NeoMutt/20180716
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mfe@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org

On 23-12-20, Peng Fan wrote:
> > Subject: Re: [PATCH 4/7] dt-bindings: firmware: arm,scmi: support pinctrl
> > protocol
> > 
> > Hi Peng,
> > 
> > On 23-12-15, Peng Fan (OSS) wrote:
> > > From: Peng Fan <peng.fan@nxp.com>
> > >
> > > Add SCMI v3.2 pinctrl protocol bindings and example.
> > >
> > > Signed-off-by: Peng Fan <peng.fan@nxp.com>
> > > ---
> > >  .../devicetree/bindings/firmware/arm,scmi.yaml     | 99
> > ++++++++++++++++++++++
> > >  1 file changed, 99 insertions(+)
> > >
> > > diff --git a/Documentation/devicetree/bindings/firmware/arm,scmi.yaml
> > > b/Documentation/devicetree/bindings/firmware/arm,scmi.yaml
> > > index 4591523b51a0..bfd2b6a89979 100644
> > > --- a/Documentation/devicetree/bindings/firmware/arm,scmi.yaml
> > > +++ b/Documentation/devicetree/bindings/firmware/arm,scmi.yaml
> > > @@ -247,6 +247,85 @@ properties:
> > >        reg:
> > >          const: 0x18
> > >
> > > +  protocol@19:
> > 
> > ...
> > 
> > > @@ -401,6 +480,26 @@ examples:
> > >              scmi_powercap: protocol@18 {
> > >                  reg = <0x18>;
> > >              };
> > > +
> > > +            scmi_pinctrl: protocol@19 {
> > > +                reg = <0x19>;
> > > +                #pinctrl-cells = <0>;
> > > +
> > > +                i2c2-pins {
> > > +                    groups = "i2c2_a", "i2c2_b";
> > > +                    function = "i2c2";
> > > +                };
> > > +
> > > +                mdio-pins {
> > > +                    groups = "avb_mdio";
> > > +                    drive-strength = <24>;
> > > +                };
> > > +
> > > +                keys_pins: keys-pins {
> > > +                    pins = "GP_5_17", "GP_5_20", "GP_5_22", "GP_2_1";
> > > +                    bias-pull-up;
> > > +                };
> > > +            };
> > 
> > This example is different to the one you mentioned within the cover-letter. I
> > didn't checked all patches just want to ask which API will be implemented by
> > this patchset?
> 
> I kept this change since it was tested by Oleksii, but anyway i.MX not use these.
> 
> The API, I suppose you are asking about this?
> static const struct pinctrl_ops pinctrl_scmi_pinctrl_ops = {                                        
>         .get_groups_count = pinctrl_scmi_get_groups_count,                                          
>         .get_group_name = pinctrl_scmi_get_group_name,                                              
>         .get_group_pins = pinctrl_scmi_get_group_pins,                                              
> #ifdef CONFIG_OF                                                                                    
>         .dt_node_to_map = pinconf_generic_dt_node_to_map_all,                                       
>         .dt_free_map = pinconf_generic_dt_free_map,                                                 
> #endif                                                                                              
> };
> 
> static const struct pinctrl_ops pinctrl_scmi_imx_pinctrl_ops = {                                    
>         .get_groups_count = pinctrl_scmi_get_groups_count,                                          
>         .get_group_name = pinctrl_scmi_get_group_name,                                              
>         .get_group_pins = pinctrl_scmi_get_group_pins,                                              
> #ifdef CONFIG_OF                                                                                    
>         .dt_node_to_map = pinctrl_scmi_imx_dt_node_to_map,                                          
>         .dt_free_map = pinconf_generic_dt_free_map,                                                 
> #endif                                                                                              
> };

I see, thanks for the clarification. In short: the i.MX SMCI pinctrl
DT-API is the same as the non-SCMI pinctrl API since the dt_node_to_map
will convert it.

Regards,
  Marco

