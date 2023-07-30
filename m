Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE72876866F
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Jul 2023 18:27:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229724AbjG3Q1U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 Jul 2023 12:27:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229487AbjG3Q1S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Jul 2023 12:27:18 -0400
Received: from viti.kaiser.cx (viti.kaiser.cx [IPv6:2a01:238:43fe:e600:cd0c:bd4a:7a3:8e9f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30E4910D7;
        Sun, 30 Jul 2023 09:27:15 -0700 (PDT)
Received: from martin by viti.kaiser.cx with local (Exim 4.89)
        (envelope-from <martin@viti.kaiser.cx>)
        id 1qQ9Fi-0003fq-1p; Sun, 30 Jul 2023 18:26:42 +0200
Date:   Sun, 30 Jul 2023 18:26:42 +0200
From:   Martin Kaiser <martin@kaiser.cx>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Fabio Estevam <festevam@gmail.com>,
        Arnd Bergmann <arnd@kernel.org>, soc@kernel.org,
        Russell King <linux@armlinux.org.uk>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Hartley Sweeten <hsweeten@visionengravers.com>,
        Alexander Sverdlin <alexander.sverdlin@gmail.com>,
        Andre Przywara <andre.przywara@arm.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>,
        Vladimir Zapolskiy <vz@mleia.com>,
        Aaro Koskinen <aaro.koskinen@iki.fi>,
        Janusz Krzysztofik <jmkrzyszt@gmail.com>,
        Tony Lindgren <tony@atomide.com>, Andrew Lunn <andrew@lunn.ch>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Daniel Mack <daniel@zonque.org>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        Viresh Kumar <vireshk@kernel.org>,
        Shiraz Hashim <shiraz.linux.kernel@gmail.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Linux-OMAP <linux-omap@vger.kernel.org>,
        linux-clk@vger.kernel.org, linux-usb@vger.kernel.org
Subject: Re: [PATCH 05/13] ARM: imx: remove unused mx25_revision()
Message-ID: <20230730162642.ib6hfbw5zgeked6h@viti.kaiser.cx>
References: <20230516153109.514251-1-arnd@kernel.org>
 <20230516153109.514251-6-arnd@kernel.org>
 <CAOMZO5B0stW2X6YqPTTKDpCOAzPDvm=4HT8jfBAgbTy11gnKgg@mail.gmail.com>
 <4e026f08-d733-4b01-ab47-e921d041e74e@app.fastmail.com>
 <20230517154525.ljoamjlfhpejtizm@viti.kaiser.cx>
 <0808604b-a26e-43b8-83da-2c3dc12446d2@app.fastmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0808604b-a26e-43b8-83da-2c3dc12446d2@app.fastmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: Martin Kaiser <martin@viti.kaiser.cx>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Arnd,

Arnd Bergmann (arnd@arndb.de) wrote:

> >> I'll leave it up to you, if you want to merge Martin's patches or
> >> a replacement for the soc-imx driver through the imx tree for 6.5,
> >> I'll drop my patch from this series, otherwise I'll keep it for now
> >> and we can still do it better at later point.

> > I suggest we merge my patches for imx25 first and then clean up all the
> > older imx families to use the common functions.

> > I've just rebased the patches against today's linux-next. My understanding
> > is that they have to go through the clk tree.

> This never happened, right? I see that mx25_revision() is still in the
> tree without any users, so I can't easily turn on the warning by default
> yet. Should I just go ahead and remove it for 5.6, or do you expect to
> have your patch ready in time for the merge window?

sorry for delaying your series.

So far, there's been no response to my patches from the clk maintainers.
Let me resend the patches one final time. If we don't hear anything back
within a week or so, feel free to remove mx25_revision (and probably all
of arch/arm/mach-imx/cpu-imx25.c) for the 6.6 merge window.

Thanks,
Martin
