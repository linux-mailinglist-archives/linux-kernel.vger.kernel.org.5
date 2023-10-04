Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2CAB37B7755
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Oct 2023 07:04:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241322AbjJDFEz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Oct 2023 01:04:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241314AbjJDFEx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Oct 2023 01:04:53 -0400
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADE34B8
        for <linux-kernel@vger.kernel.org>; Tue,  3 Oct 2023 22:04:49 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mfe@pengutronix.de>)
        id 1qnu3i-0002VK-99; Wed, 04 Oct 2023 07:04:30 +0200
Received: from [2a0a:edc0:2:b01:1d::c0] (helo=ptx.whiteo.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <mfe@pengutronix.de>)
        id 1qnu3g-00Ax5H-J1; Wed, 04 Oct 2023 07:04:28 +0200
Received: from mfe by ptx.whiteo.stw.pengutronix.de with local (Exim 4.92)
        (envelope-from <mfe@pengutronix.de>)
        id 1qnu3g-00ChlX-Fh; Wed, 04 Oct 2023 07:04:28 +0200
Date:   Wed, 4 Oct 2023 07:04:28 +0200
From:   Marco Felsch <m.felsch@pengutronix.de>
To:     Peng Fan <peng.fan@nxp.com>
Cc:     Bartosz Golaszewski <brgl@bgdev.pl>,
        "Peng Fan (OSS)" <peng.fan@oss.nxp.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Andy Shevchenko <andy@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Stefan Agner <stefan@agner.ch>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v5 4/7] gpio: vf610: add i.MX8ULP of_device_id entry
Message-ID: <20231004050428.o7l2e23xjcjkzzck@pengutronix.de>
References: <20231001-vf610-gpio-v5-0-8d873a8f224a@nxp.com>
 <20231001-vf610-gpio-v5-4-8d873a8f224a@nxp.com>
 <CAMRc=MdXkFBWMuyr8sbetyP2sJX2QG6Ce=Tsb7RVMguvGdC3TA@mail.gmail.com>
 <DU0PR04MB9417594B2DFDA6056AEC4CB988C5A@DU0PR04MB9417.eurprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <DU0PR04MB9417594B2DFDA6056AEC4CB988C5A@DU0PR04MB9417.eurprd04.prod.outlook.com>
User-Agent: NeoMutt/20180716
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mfe@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Peng,

On 23-10-02, Peng Fan wrote:
> > Subject: Re: [PATCH v5 4/7] gpio: vf610: add i.MX8ULP of_device_id entry
> > 
> > On Sun, Oct 1, 2023 at 10:23 AM Peng Fan (OSS) <peng.fan@oss.nxp.com>
> > wrote:
> > >
> > > From: Peng Fan <peng.fan@nxp.com>
> > >
> > > i.MX8ULP/93 GPIO supports similar feature as i.MX7ULP GPIO, but
> > > i.MX8ULP is actually not hardware compatible with i.MX7ULP. i.MX8ULP
> > > only has one register base, not two bases. i.MX8ULP and i.MX93
> > > actually has two interrupts for each gpio controller, one for
> > > Trustzone non-secure world, one for secure world.
> > >
> > > Although the Linux Kernel driver gpio-vf610.c could work with
> > > fsl,imx7ulp-gpio compatible, it is based on some tricks did in device
> > > tree with some offset added to base address.
> > >
> > > Add a new of_device_id entry for i.MX8ULP. But to make the driver
> > > could also support old bindings, check the compatible string first,
> > > before check the device data.
> > >
> > > Signed-off-by: Peng Fan <peng.fan@nxp.com>
> > > ---
> > >  drivers/gpio/gpio-vf610.c | 47
> > > ++++++++++++++++++++++++++++++++++++++++-------
> > >  1 file changed, 40 insertions(+), 7 deletions(-)
> > >
> > > diff --git a/drivers/gpio/gpio-vf610.c b/drivers/gpio/gpio-vf610.c
> > > index dbc7ba0ee72c..8e12706c0b22 100644
> > > --- a/drivers/gpio/gpio-vf610.c
> > > +++ b/drivers/gpio/gpio-vf610.c
> > > @@ -25,6 +25,7 @@
> > >  struct fsl_gpio_soc_data {
> > >         /* SoCs has a Port Data Direction Register (PDDR) */
> > >         bool have_paddr;
> > > +       bool have_dual_base;
> > >  };
> > >
> > >  struct vf610_gpio_port {
> > > @@ -60,13 +61,26 @@ struct vf610_gpio_port {
> > >  #define PORT_INT_EITHER_EDGE   0xb
> > >  #define PORT_INT_LOGIC_ONE     0xc
> > >
> > > +#define IMX8ULP_GPIO_BASE_OFF  0x40
> > > +#define IMX8ULP_BASE_OFF       0x80
> > > +
> > > +static const struct fsl_gpio_soc_data vf610_data = {
> > > +       .have_dual_base = true,
> > > +};
> > > +
> > >  static const struct fsl_gpio_soc_data imx_data = {
> > >         .have_paddr = true,
> > > +       .have_dual_base = true,
> > > +};
> > > +
> > > +static const struct fsl_gpio_soc_data imx8ulp_data = {
> > > +       .have_paddr = true,
> > >  };
> > >
> > >  static const struct of_device_id vf610_gpio_dt_ids[] = {
> > > -       { .compatible = "fsl,vf610-gpio",       .data = NULL, },
> > > +       { .compatible = "fsl,vf610-gpio",       .data = &vf610_data },
> > >         { .compatible = "fsl,imx7ulp-gpio",     .data = &imx_data, },
> > > +       { .compatible = "fsl,imx8ulp-gpio",     .data = &imx8ulp_data, },
> > >         { /* sentinel */ }
> > >  };
> > >
> > > @@ -263,19 +277,38 @@ static int vf610_gpio_probe(struct
> > platform_device *pdev)
> > >         struct gpio_irq_chip *girq;
> > >         int i;
> > >         int ret;
> > > +       bool dual_base;
> > >
> > >         port = devm_kzalloc(dev, sizeof(*port), GFP_KERNEL);
> > >         if (!port)
> > >                 return -ENOMEM;
> > >
> > >         port->sdata = of_device_get_match_data(dev);
> > > -       port->base = devm_platform_ioremap_resource(pdev, 0);
> > > -       if (IS_ERR(port->base))
> > > -               return PTR_ERR(port->base);
> > >
> > > -       port->gpio_base = devm_platform_ioremap_resource(pdev, 1);
> > > -       if (IS_ERR(port->gpio_base))
> > > -               return PTR_ERR(port->gpio_base);
> > > +       dual_base = port->sdata->have_dual_base;
> > > +
> > > +       /* support old compatible strings */
> > > +       if (device_is_compatible(dev, "fsl,imx7ulp-gpio") &&
> > > +           (device_is_compatible(dev, "fsl,imx93-gpio") ||
> > 
> > Why not just add this compatible to vf610_gpio_dt_ids?
> 
> "fsl,imx93-gpio", "fsl,imx7ulp-gpio" is not a correct entry
> combination. This is to support legacy old compatible
> strings.

The "/* support old compatible strings */" may a bit misleading here?
Should we be a bit more verbose for the reader of the code, e.g.:

		/*
		 * Handle legacy compatible combinations which used two
		 * reg values for the i.MX8ULP and i.MX93.
		 */

Regards,
  Marco

> 
> Thanks,
> Peng.
> > 
> > Bart
> > 
> > > +           (device_is_compatible(dev, "fsl,imx8ulp-gpio"))))
> > > +               dual_base = true;
> > > +
> > > +       if (dual_base) {
> > > +               port->base = devm_platform_ioremap_resource(pdev, 0);
> > > +               if (IS_ERR(port->base))
> > > +                       return PTR_ERR(port->base);
> > > +
> > > +               port->gpio_base = devm_platform_ioremap_resource(pdev, 1);
> > > +               if (IS_ERR(port->gpio_base))
> > > +                       return PTR_ERR(port->gpio_base);
> > > +       } else {
> > > +               port->base = devm_platform_ioremap_resource(pdev, 0);
> > > +               if (IS_ERR(port->base))
> > > +                       return PTR_ERR(port->base);
> > > +
> > > +               port->gpio_base = port->base + IMX8ULP_GPIO_BASE_OFF;
> > > +               port->base = port->base + IMX8ULP_BASE_OFF;
> > > +       }
> > >
> > >         port->irq = platform_get_irq(pdev, 0);
> > >         if (port->irq < 0)
> > >
> > > --
> > > 2.37.1
> > >
