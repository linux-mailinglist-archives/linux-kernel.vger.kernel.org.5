Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6A1C756AE7
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 19:43:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229669AbjGQRnd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 13:43:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230293AbjGQRnb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 13:43:31 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 372DF91;
        Mon, 17 Jul 2023 10:43:30 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C0A27611AC;
        Mon, 17 Jul 2023 17:43:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2FC32C433CB;
        Mon, 17 Jul 2023 17:43:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689615809;
        bh=WlylA38NBSrHdK1P/Qx5cdKzB17My2bbP8A4hWmtbl8=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=pCB0qRPm4TViuI8Fg0XfDsRLg2cStX3yi85bE2aX9JM2STvXpFJBkZv01TMRONP0v
         4BCch5u4Cfxc2q10XF7X8MlYlb8ZrEcmfwNbb6YHXoQY5gQfT+RaoaDjA6FvE1eHjM
         3v6jimLbsNHKi9Zfa5tpw4Qtn2ufZU3HZ5UK6k1Kc0wXQeqgPxgdOMDAMlvQaNHzn8
         Z9nrQ9fiOU63aNaOwpzQarIRbUBxsSACl0XHcxEIqNv8Tzec0OZENO5QJUjxlzB7dE
         CNvQd17kBAqxdZ+5e44s4eiNJhYtgPj4XwQfWrMAVKzXwptm7yM7tvd4Fvk/wJOtao
         Yn09Vf//WxeFg==
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-51e590a8ab5so6444129a12.2;
        Mon, 17 Jul 2023 10:43:29 -0700 (PDT)
X-Gm-Message-State: ABy/qLbctizCvB77CWdMJKuja7kiIyj0Q82FW8JIiA7/tYogJBWUEZF0
        ET2dXZLfYI5i68M5k5rEOTm85x6zFbq8d1UDMw==
X-Google-Smtp-Source: APBJJlGV73zzxjpVsO/f3440v/5dveoUtTcIX0eLkgnTaVgBrap1rMmgbikswqUTIe4Df1/8A6Rrn+UvYZaRh77UJxY=
X-Received: by 2002:a2e:9c91:0:b0:2b7:4169:fcf5 with SMTP id
 x17-20020a2e9c91000000b002b74169fcf5mr11677042lji.37.1689615786908; Mon, 17
 Jul 2023 10:43:06 -0700 (PDT)
MIME-Version: 1.0
References: <20230714175027.4065135-1-robh@kernel.org>
In-Reply-To: <20230714175027.4065135-1-robh@kernel.org>
From:   Rob Herring <robh@kernel.org>
Date:   Mon, 17 Jul 2023 11:42:54 -0600
X-Gmail-Original-Message-ID: <CAL_JsqLxL2Mpsi=idA0KkDWNhCZfP3Nw4c79d5CfkjVWnUsqyg@mail.gmail.com>
Message-ID: <CAL_JsqLxL2Mpsi=idA0KkDWNhCZfP3Nw4c79d5CfkjVWnUsqyg@mail.gmail.com>
Subject: Re: [PATCH] usb: Explicitly include correct DT includes
To:     Peter Chen <peter.chen@kernel.org>,
        Pawel Laszczak <pawell@cadence.com>,
        Roger Quadros <rogerq@kernel.org>,
        Aswath Govindraju <a-govindraju@ti.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Minas Harutyunyan <hminas@synopsys.com>,
        Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Li Yang <leoyang.li@nxp.com>, Daniel Mack <daniel@zonque.org>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        Herve Codina <herve.codina@bootlin.com>,
        Michal Simek <michal.simek@amd.com>,
        Alan Stern <stern@rowland.harvard.edu>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Claudiu Beznea <claudiu.beznea@microchip.com>,
        Mathias Nyman <mathias.nyman@intel.com>,
        Richard Leitner <richard.leitner@linux.dev>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Paul Cercueil <paul@crapouillou.net>, Bin Liu <b-liu@ti.com>,
        Conor Dooley <conor.dooley@microchip.com>,
        Daire McNamara <daire.mcnamara@microchip.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        "Bryan O'Donoghue" <bryan.odonoghue@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Cc:     devicetree@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linuxppc-dev@lists.ozlabs.org, linux-mediatek@lists.infradead.org,
        linux-mips@vger.kernel.org, linux-riscv@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 14, 2023 at 11:50=E2=80=AFAM Rob Herring <robh@kernel.org> wrot=
e:
>
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
> ---

[...]

> diff --git a/drivers/usb/host/fsl-mph-dr-of.c b/drivers/usb/host/fsl-mph-=
dr-of.c
> index a9877f2569f4..2574bccc151b 100644
> --- a/drivers/usb/host/fsl-mph-dr-of.c
> +++ b/drivers/usb/host/fsl-mph-dr-of.c
> @@ -10,10 +10,12 @@
>  #include <linux/fsl_devices.h>
>  #include <linux/err.h>
>  #include <linux/io.h>
> -#include <linux/of_platform.h>
> +#include <linux/of.h>
> +#include <linux/of_device.h>
>  #include <linux/clk.h>
>  #include <linux/module.h>
>  #include <linux/dma-mapping.h>
> +#include <linux/of.h>

Double include of of.h here. v2 coming.

Rob
