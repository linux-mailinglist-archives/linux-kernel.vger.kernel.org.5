Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65C9B7549E8
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Jul 2023 17:48:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230201AbjGOPsz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 15 Jul 2023 11:48:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbjGOPsx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Jul 2023 11:48:53 -0400
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41A162729;
        Sat, 15 Jul 2023 08:48:52 -0700 (PDT)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 713BCFF802;
        Sat, 15 Jul 2023 15:48:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1689436130;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Un+ufkhrXfZqLrVbDU6HeKyr3kcyHpaOW08JuHJOTAQ=;
        b=FqWexEyC5/ncjoaJwBj4G53wiu8VDHhDUUmjeiui8D15gl2UK0/z1/JhojGPaXb7myBHt0
        +m0+8luEUYwOnP8t5sbvBF01u6wPPDP8ekc+E+xiI5dXBEOsZg27UBqN6/Cx2Ykd/d38zY
        Uxi4xN1DsWH3172+Q9prP3vN3AfuAUnTk0v/cqkvsBuezHKkylG8hSiaysYLY7BLSvc/OK
        X/4nONxCNA9EoFF0A6ADkUMqN/54fCJrQYuzSAtxsbm00dNaTjHSMLlKGNk9Pa5uVm4JDa
        KtHa+BsMQbwWPxRZR03AmaWLttL4j4jDIfE8mWV10b4zCsVL6+eAIvNGObilXQ==
Date:   Sat, 15 Jul 2023 17:48:42 +0200
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Rob Herring <robh@kernel.org>
Cc:     Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Han Xu <han.xu@nxp.com>,
        Harvey Hunt <harveyhuntnexus@gmail.com>,
        Paul Cercueil <paul@crapouillou.net>,
        Liang Yang <liang.yang@amlogic.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Michal Simek <michal.simek@amd.com>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Heiko Stuebner <heiko@sntech.de>, Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        Vladimir Zapolskiy <vz@mleia.com>,
        Tudor Ambarus <tudor.ambarus@linaro.org>,
        Pratyush Yadav <pratyush@kernel.org>,
        Michael Walle <michael@walle.cc>, devicetree@vger.kernel.org,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-mips@vger.kernel.org,
        linux-amlogic@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-arm-msm@vger.kernel.org,
        linux-rockchip@lists.infradead.org, linux-sunxi@lists.linux.dev
Subject: Re: [PATCH] mtd: Explicitly include correct DT includes
Message-ID: <20230715174804.6fc2a4c1@xps-13>
In-Reply-To: <20230714174751.4060439-1-robh@kernel.org>
References: <20230714174751.4060439-1-robh@kernel.org>
Organization: Bootlin
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-GND-Sasl: miquel.raynal@bootlin.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rob,

robh@kernel.org wrote on Fri, 14 Jul 2023 11:47:49 -0600:

> The DT of_device.h and of_platform.h date back to the separate
> of_platform_bus_type before it as merged into the regular platform bus.

				 was?

Otherwise LGTM, I will fix it when applying.

> As part of that merge prepping Arm DT support 13 years ago, they
> "temporarily" include each other. They also include platform_device.h
> and of.h. As a result, there's a pretty much random mix of those include
> files used throughout the tree. In order to detangle these headers and
> replace the implicit includes with struct declarations, users need to
> explicitly include the correct includes.
>=20
> Signed-off-by: Rob Herring <robh@kernel.org>

Thanks,
Miqu=C3=A8l
