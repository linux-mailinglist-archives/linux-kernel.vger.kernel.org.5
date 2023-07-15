Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CAA3D754A8F
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Jul 2023 19:57:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230111AbjGOR5U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 15 Jul 2023 13:57:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230027AbjGOR5S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Jul 2023 13:57:18 -0400
Received: from mail-yw1-x112b.google.com (mail-yw1-x112b.google.com [IPv6:2607:f8b0:4864:20::112b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5E221FC0
        for <linux-kernel@vger.kernel.org>; Sat, 15 Jul 2023 10:57:16 -0700 (PDT)
Received: by mail-yw1-x112b.google.com with SMTP id 00721157ae682-57012b2973eso29289237b3.2
        for <linux-kernel@vger.kernel.org>; Sat, 15 Jul 2023 10:57:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1689443836; x=1692035836;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MWfuaj908ezvTCArkn3iKuZY57pS5DEGCvs818aKT1g=;
        b=hXFWx/7V2ilUSpF3voEEHL3miMi68ZScjxXTYKsraLjLXai5wQQF4WPMOEwKknT73Z
         TosQJPQ0jcS9mV4PZ/Hrjat87xHfW1QZJJvKse42oBPzZB+EGbp2N3i5id7JTxjUsgtN
         WDL0fBXFgAJ7IwzYFb0eaIrxQI4wqfHa1Tk5UXF4g6QhSgtnbN6HAd5LXyrsoH093BeZ
         dnzHSgUdn7weBlTbCB7MsfNkTRHFyDdDqy3vayXALCvXkwp2xHLINAeKis0MHStT3gGB
         zSRQipZgpEoUedpY9iX8KSuraRlyBWdrTzGFZ/p6RBKPRCTekMb8kbzZG2seChNlsEGP
         QXtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689443836; x=1692035836;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MWfuaj908ezvTCArkn3iKuZY57pS5DEGCvs818aKT1g=;
        b=dpA8NFhrwYDkSa3mo2sxtt9wvlP2z+pcuP5smxmdAeYVHv64QlNI2irCRW7mDLD0EO
         NNXgdnzYJUphiFtiUdYgj4yOAk+2OWULjE3sqTezj3vOggTpNRsplOyRegqQxw3DiIWU
         zzvzyngfKIXny32YmUgK/3oNqOJXmL/fj6Gct6BBQqCNF5dmvjFtQYmXPGDRfxeeDoPu
         UOOlkq9QO/HPM3UkOxVGtJR4ZGXFqnoItyNPl3RGCoImyjLoZA7rtGXAVjqGufPVSsnc
         ZFKMRzvqYG7jhxc/p3Xm+fu92gyJPAlzhIPrvRAbu89CZ2mtzxghnabnW4Uylyx8afTh
         9H9w==
X-Gm-Message-State: ABy/qLYoIiCPDAyArd+1B8dbnxWVgOoPaMFC7Tyfj1WhvCsBiE3SoA1W
        eCu00XGiEwevWM62pj9heTvz4cDp7MpdBY9x6eG8Dg==
X-Google-Smtp-Source: APBJJlEOgFSlT/aTEORmFdIMvrXhSvSNS+ivT8OhWO9TBnbzSoXq3K3OfZ5ITuyPBt0YYAqSQP7aCMjSrPWQ6SLmwFM=
X-Received: by 2002:a81:4ec2:0:b0:573:cacd:3b6e with SMTP id
 c185-20020a814ec2000000b00573cacd3b6emr7407493ywb.30.1689443836031; Sat, 15
 Jul 2023 10:57:16 -0700 (PDT)
MIME-Version: 1.0
References: <20230714174751.4060439-1-robh@kernel.org>
In-Reply-To: <20230714174751.4060439-1-robh@kernel.org>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Sat, 15 Jul 2023 19:57:04 +0200
Message-ID: <CACRpkdaxqeZH_SOhmuZ2rhoU73uDVNPmzGFpCEuk636Jb2qMsw@mail.gmail.com>
Subject: Re: [PATCH] mtd: Explicitly include correct DT includes
To:     Rob Herring <robh@kernel.org>
Cc:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 14, 2023 at 7:48=E2=80=AFPM Rob Herring <robh@kernel.org> wrote=
:

> The DT of_device.h and of_platform.h date back to the separate
> of_platform_bus_type before it as merged into the regular platform bus.
> As part of that merge prepping Arm DT support 13 years ago, they
> "temporarily" include each other. They also include platform_device.h
> and of.h. As a result, there's a pretty much random mix of those include
> files used throughout the tree. In order to detangle these headers and
> replace the implicit includes with struct declarations, users need to
> explicitly include the correct includes.
>
> Signed-off-by: Rob Herring <robh@kernel.org>

Thanks for going back and fixing up this!
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
