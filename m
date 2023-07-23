Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4FF2075E1ED
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Jul 2023 14:39:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230088AbjGWMjC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Jul 2023 08:39:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229541AbjGWMjB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Jul 2023 08:39:01 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5025E1AA;
        Sun, 23 Jul 2023 05:39:00 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DD84160C80;
        Sun, 23 Jul 2023 12:38:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B11D6C433C7;
        Sun, 23 Jul 2023 12:38:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690115939;
        bh=DqMrwul8Z+Kp+FVoVrlZHdVil5ffk4Br9Pj1Hqbnxm4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Ob77RBPFBoVTTNibSWxMjo0wYIwPaVtL0+Hj7xKLbn+8iwdFiEl306vNqyY02UYoL
         jPYeKJ+MmA8RU2waU4uBNAvx+/k8LWhw1LvDiwwxOYcT8A1N61ZbBJwn2kgvupboS1
         BS/Ly2Fwldf5uZurcjDRKOMfZVR+pXchkx2F9ETNpzNFputSU9qCWgDPTK3ficVtVB
         hkKcaRcnMnpipcBvew2sRWfQD5EKlTmzr9CfzlxoWvfTNZGhet4PsFi1FmXGnXleMF
         gtaTvOuB9gZlAqFWvC0RyHGmfCN2287EnLmncsKSc1B6d50Aw/+XGT9xje7oGzxj+G
         JP70unohiRQRQ==
Date:   Sun, 23 Jul 2023 13:38:48 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Rob Herring <robh@kernel.org>
Cc:     Michael Hennerich <michael.hennerich@analog.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Alexandru Tachici <alexandru.tachici@analog.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Claudiu Beznea <claudiu.beznea@microchip.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Orson Zhai <orsonzhai@gmail.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        Crt Mori <cmo@melexis.com>, devicetree@vger.kernel.org,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-arm-msm@vger.kernel.org,
        linux-rockchip@lists.infradead.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-sunxi@lists.linux.dev
Subject: Re: [PATCH] iio: adc: Explicitly include correct DT includes
Message-ID: <20230723133848.5dc96150@jic23-huawei>
In-Reply-To: <20230715182510.3d09970c@jic23-huawei>
References: <20230714174628.4057920-1-robh@kernel.org>
        <20230715182510.3d09970c@jic23-huawei>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 15 Jul 2023 18:25:10 +0100
Jonathan Cameron <jic23@kernel.org> wrote:

> On Fri, 14 Jul 2023 11:46:26 -0600
> Rob Herring <robh@kernel.org> wrote:
> 
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
> 
> Hi Rob,
> 
> Just one in here that I noticed isn't quite right. I'd have fixed it 
> up (and can still do so if nothing else comes up) but I want to give
> this more time on list anyway so won't pick it up today.

Fixed up whilst applying.

Applied to the togreg branch of iio.git and pushed out as testing to see
if 0-day can find anything we missed.

Thanks,

Jonathan

> 
> Jonathan
> 
> > diff --git a/drivers/iio/adc/stmpe-adc.c b/drivers/iio/adc/stmpe-adc.c
> > index 67518e460e05..55e36b40fdf5 100644
> > --- a/drivers/iio/adc/stmpe-adc.c
> > +++ b/drivers/iio/adc/stmpe-adc.c
> > @@ -14,9 +14,10 @@
> >  #include <linux/kernel.h>
> >  #include <linux/mfd/stmpe.h>
> >  #include <linux/module.h>
> > -#include <linux/of_platform.h>
> > +#include <linux/of.h>
> >  #include <linux/platform_device.h>
> >  #include <linux/device.h>
> > +#include <linux/of.h>  
> 
> Duplicate include.
> 

