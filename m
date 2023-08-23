Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14014784F0A
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Aug 2023 05:02:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229824AbjHWDCU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Aug 2023 23:02:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231223AbjHWDCR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Aug 2023 23:02:17 -0400
Received: from 167-179-156-38.a7b39c.syd.nbn.aussiebb.net (167-179-156-38.a7b39c.syd.nbn.aussiebb.net [167.179.156.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E200E47;
        Tue, 22 Aug 2023 20:02:12 -0700 (PDT)
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
        by formenos.hmeau.com with smtp (Exim 4.94.2 #2 (Debian))
        id 1qYe6H-006o9O-CL; Wed, 23 Aug 2023 11:00:06 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Wed, 23 Aug 2023 11:00:06 +0800
Date:   Wed, 23 Aug 2023 11:00:06 +0800
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Rob Herring <robh@kernel.org>
Cc:     Corentin Labbe <clabbe.montjoie@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        Neal Liu <neal_liu@aspeedtech.com>,
        Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@aj.id.au>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Claudiu Beznea <claudiu.beznea@microchip.com>,
        Tudor Ambarus <tudor.ambarus@linaro.org>,
        Horia =?utf-8?Q?Geant=C4=83?= <horia.geanta@nxp.com>,
        Pankaj Gupta <pankaj.gupta@nxp.com>,
        Gaurav Jain <gaurav.jain@nxp.com>,
        Gilad Ben-Yossef <gilad@benyossef.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Hans Ulli Kroll <ulli.kroll@googlemail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Daniele Alessandrelli <daniele.alessandrelli@intel.com>,
        Declan Murphy <declan.murphy@intel.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Vladimir Zapolskiy <vz@mleia.com>,
        Jia Jie Ho <jiajie.ho@starfivetech.com>,
        William Qiu <william.qiu@starfivetech.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Michal Simek <michal.simek@amd.com>,
        Harsha <harsha.harsha@amd.com>, devicetree@vger.kernel.org,
        linux-crypto@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org,
        linux-amlogic@lists.infradead.org, linux-aspeed@lists.ozlabs.org,
        linux-samsung-soc@vger.kernel.org,
        linux-rockchip@lists.infradead.org,
        linux-stm32@st-md-mailman.stormreply.com
Subject: Re: [PATCH] crypto: Explicitly include correct DT includes
Message-ID: <ZOV2Nn4o8Ldy9P1i@gondor.apana.org.au>
References: <20230714174421.4054194-1-robh@kernel.org>
 <CAL_JsqL_CvroupJEFwrjt8WOq=4WBxvE3sOTMnY8hEuBAMG=1g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAL_JsqL_CvroupJEFwrjt8WOq=4WBxvE3sOTMnY8hEuBAMG=1g@mail.gmail.com>
X-Spam-Status: No, score=2.7 required=5.0 tests=BAYES_00,HELO_DYNAMIC_IPADDR2,
        PDS_RDNS_DYNAMIC_FP,RCVD_IN_DNSWL_BLOCKED,RDNS_DYNAMIC,SPF_HELO_NONE,
        SPF_PASS,TVD_RCVD_IP,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Level: **
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 22, 2023 at 05:40:57PM -0500, Rob Herring wrote:
> On Fri, Jul 14, 2023 at 12:44 PM Rob Herring <robh@kernel.org> wrote:
> >
> > The DT of_device.h and of_platform.h date back to the separate
> > of_platform_bus_type before it as merged into the regular platform bus.
> > As part of that merge prepping Arm DT support 13 years ago, they
> > "temporarily" include each other. They also include platform_device.h
> > and of.h. As a result, there's a pretty much random mix of those include
> > files used throughout the tree. In order to detangle these headers and
> > replace the implicit includes with struct declarations, users need to
> > explicitly include the correct includes.
> >
> > Signed-off-by: Rob Herring <robh@kernel.org>
> > ---
> >  drivers/crypto/allwinner/sun4i-ss/sun4i-ss-core.c   | 1 -
> >  drivers/crypto/allwinner/sun8i-ce/sun8i-ce-core.c   | 1 -
> >  drivers/crypto/allwinner/sun8i-ss/sun8i-ss-core.c   | 1 -
> >  drivers/crypto/amlogic/amlogic-gxl-core.c           | 1 -
> >  drivers/crypto/aspeed/aspeed-acry.c                 | 3 ---
> >  drivers/crypto/atmel-aes.c                          | 6 ++----
> >  drivers/crypto/atmel-ecc.c                          | 2 +-
> >  drivers/crypto/atmel-sha.c                          | 6 ++----
> >  drivers/crypto/atmel-tdes.c                         | 6 ++----
> >  drivers/crypto/bcm/cipher.c                         | 3 +--
> >  drivers/crypto/caam/ctrl.c                          | 1 +
> >  drivers/crypto/caam/jr.c                            | 1 +
> >  drivers/crypto/caam/qi.c                            | 1 +
> >  drivers/crypto/ccree/cc_driver.c                    | 1 -
> >  drivers/crypto/exynos-rng.c                         | 2 +-
> >  drivers/crypto/gemini/sl3516-ce-core.c              | 1 -
> >  drivers/crypto/img-hash.c                           | 4 ++--
> >  drivers/crypto/intel/keembay/keembay-ocs-hcu-core.c | 3 ++-
> >  drivers/crypto/n2_core.c                            | 2 +-
> >  drivers/crypto/omap-aes.c                           | 1 -
> >  drivers/crypto/omap-des.c                           | 2 --
> >  drivers/crypto/omap-sham.c                          | 1 -
> >  drivers/crypto/rockchip/rk3288_crypto.c             | 1 -
> >  drivers/crypto/s5p-sss.c                            | 1 -
> >  drivers/crypto/sa2ul.c                              | 3 ++-
> >  drivers/crypto/sahara.c                             | 1 -
> >  drivers/crypto/starfive/jh7110-cryp.c               | 2 +-
> >  drivers/crypto/starfive/jh7110-hash.c               | 1 -
> >  drivers/crypto/stm32/stm32-cryp.c                   | 2 +-
> >  drivers/crypto/stm32/stm32-hash.c                   | 2 +-
> >  drivers/crypto/talitos.c                            | 4 ++--
> >  drivers/crypto/xilinx/zynqmp-aes-gcm.c              | 2 +-
> >  drivers/crypto/xilinx/zynqmp-sha.c                  | 1 -
> >  33 files changed, 25 insertions(+), 45 deletions(-)
> 
> Ping!

Sorry, I misfiled this one.  I'll get onto it now.

Thanks,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
