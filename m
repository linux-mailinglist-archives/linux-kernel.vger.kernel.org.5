Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9CC67B6295
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Oct 2023 09:36:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231465AbjJCHgh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Oct 2023 03:36:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231442AbjJCHgf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Oct 2023 03:36:35 -0400
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5A2CAF
        for <linux-kernel@vger.kernel.org>; Tue,  3 Oct 2023 00:36:32 -0700 (PDT)
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 580483F133
        for <linux-kernel@vger.kernel.org>; Tue,  3 Oct 2023 07:36:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1696318589;
        bh=lZyLBflGA1l7hiEVfFkxQiwJT+7Gv/7fvNwXxJdKogA=;
        h=From:In-Reply-To:References:Mime-Version:Date:Message-ID:Subject:
         To:Cc:Content-Type;
        b=qNY7pjybc3zm12mC52FOkh52cWM8hkbLg4dMDB6KwDmyKCwzcnvyCS27gww+dv79x
         r8pPGyUks6pR0DDgEq5yMIhmTJK+bsGEOXSnSNDIXJtrnrkDUJuAmC5UV53VM4FsCP
         3GS15c04z7SiDYhwlGhRr4qxI/r0tJUUihYbos7AqBOBYkc8MOlOaalgeZKjUkhFv3
         H7J9ojMxoqOJCUjrfFRLCsYZJqoyulJOPJBPmtmMBsqRUXQ9r+Hklr33bqGXWckPin
         ZZe0khc1dkMiSbcA7OaOt9aMWlwqRCRlfIHiJ2ec8g74tTwo1fGRd3/+z16I2VnGJq
         K93nk6IO7CF0Q==
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-774309ff5e2so93181685a.1
        for <linux-kernel@vger.kernel.org>; Tue, 03 Oct 2023 00:36:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696318588; x=1696923388;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lZyLBflGA1l7hiEVfFkxQiwJT+7Gv/7fvNwXxJdKogA=;
        b=ATVpy49sUHRjNxhFHkhQs1qsiSuzFLepJDhCAzlMQ/GOyPT4aGg/zx/3ssrQyG9Wzu
         pBLVTYXZVR4yb6rOPJQUmY2B4jI67mUFyztMyDMRBZFmobla55+Uo/2CxEjJljBe8cif
         vOcYz6lDMQAUgaFK0Ckjbuq7tjsUHjq5igx5lgYcU18wdXRqEpGjBO9p8Cm2MKPTbNdo
         TEe67pHNKgDDhDgxjz4cmjjk3RS84kdUDRBjlKBI1sgrMMDU7NtCczyWk4oMqU9cVC3w
         I50ABYVemP/zwGEIbFWXOwQoqojwCBBhI92lIUAganvdENWOBrDXYIO7OYqhM5YBNCyr
         x4JA==
X-Gm-Message-State: AOJu0Yy23Pv19tLqGlLWvviWwlhcF5nJGyMFmS5lERPAoUSPbs7Btyjz
        nHJrFo66teK/alSjOVd0UfCZdnY6r9UlHR9p+zQl+GXGjm8E3rdhEcp6GRuhFGuHXOQPJ5srPq6
        hU8/TXTMoSkHavTAI+62R7Hpin/++/lfQ/XtCcCnhUQ2bQVvg+EfAa3wWew==
X-Received: by 2002:ac8:5990:0:b0:417:eb3c:494e with SMTP id e16-20020ac85990000000b00417eb3c494emr16180655qte.59.1696318587824;
        Tue, 03 Oct 2023 00:36:27 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEj6SIXevimzokJVJXdsT4sE7rHESw1Wq+iHG4vgfpb3Vs/mWTK4xl1+YKBWHa12KFSBQhHVO0+qIfHciWDbuM=
X-Received: by 2002:ac8:5990:0:b0:417:eb3c:494e with SMTP id
 e16-20020ac85990000000b00417eb3c494emr16180640qte.59.1696318587540; Tue, 03
 Oct 2023 00:36:27 -0700 (PDT)
Received: from 348282803490 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 3 Oct 2023 00:36:27 -0700
From:   Emil Renner Berthing <emil.renner.berthing@canonical.com>
In-Reply-To: <20231003042215.142678-2-shravan.chippa@microchip.com>
References: <20231003042215.142678-1-shravan.chippa@microchip.com> <20231003042215.142678-2-shravan.chippa@microchip.com>
Mime-Version: 1.0
Date:   Tue, 3 Oct 2023 00:36:27 -0700
Message-ID: <CAJM55Z9ae_W7JvOHEFPNP491cexz5MbpBSFUOzuvbQK=HiftOw@mail.gmail.com>
Subject: Re: [PATCH v2 1/4] dmaengine: sf-pdma: Support of_dma_controller_register()
To:     shravan chippa <shravan.chippa@microchip.com>,
        green.wan@sifive.com, vkoul@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, palmer@dabbelt.com,
        paul.walmsley@sifive.com, conor+dt@kernel.org
Cc:     dmaengine@vger.kernel.org, devicetree@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        nagasuresh.relli@microchip.com, praveen.kumar@microchip.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

shravan chippa wrote:
> From: Shravan Chippa <shravan.chippa@microchip.com>
>
> Update sf-pdma driver to adopt generic DMA device tree bindings.
> It calls of_dma_controller_register() with sf-pdma specific
> of_dma_xlate to get the generic DMA device tree helper support
> and the DMA clients can look up the sf-pdma controller using
> standard APIs.
>
> Signed-off-by: Shravan Chippa <shravan.chippa@microchip.com>
> ---
>  drivers/dma/sf-pdma/sf-pdma.c | 44 +++++++++++++++++++++++++++++++++++
>  1 file changed, 44 insertions(+)
>
> diff --git a/drivers/dma/sf-pdma/sf-pdma.c b/drivers/dma/sf-pdma/sf-pdma.c
> index d1c6956af452..06a0912a12a1 100644
> --- a/drivers/dma/sf-pdma/sf-pdma.c
> +++ b/drivers/dma/sf-pdma/sf-pdma.c
> @@ -20,6 +20,7 @@
>  #include <linux/mod_devicetable.h>
>  #include <linux/dma-mapping.h>
>  #include <linux/of.h>
> +#include <linux/of_dma.h>
>  #include <linux/slab.h>
>
>  #include "sf-pdma.h"
> @@ -490,6 +491,33 @@ static void sf_pdma_setup_chans(struct sf_pdma *pdma)
>  	}
>  }
>
> +static struct dma_chan *sf_pdma_of_xlate(struct of_phandle_args *dma_spec,
> +					 struct of_dma *ofdma)
> +{
> +	struct sf_pdma *pdma = ofdma->of_dma_data;
> +	struct device *dev = pdma->dma_dev.dev;
> +	struct sf_pdma_chan  *chan;

If you're respinning this series anyway, you have two spaces here.

> +	struct dma_chan *c;
> +	u32 channel_id;
> +
> +	if (dma_spec->args_count != 1) {
> +		dev_err(dev, "Bad number of cells\n");
> +		return NULL;
> +	}
> +
> +	channel_id = dma_spec->args[0];
> +
> +	chan = &pdma->chans[channel_id];
> +
> +	c = dma_get_slave_channel(&chan->vchan.chan);
> +	if (!c) {
> +	dev_err(dev, "No more channels available\n");
> +		return NULL;
> +	}
> +
> +	return c;
> +}
> +
>  static int sf_pdma_probe(struct platform_device *pdev)
>  {
>  	struct sf_pdma *pdma;
> @@ -563,7 +591,20 @@ static int sf_pdma_probe(struct platform_device *pdev)
>  		return ret;
>  	}
>
> +	ret = of_dma_controller_register(pdev->dev.of_node,
> +					 sf_pdma_of_xlate, pdma);
> +	if (ret < 0) {
> +		dev_err(&pdev->dev,
> +			"Can't register SiFive Platform OF_DMA. (%d)\n", ret);
> +		goto err_unregister;
> +	}
> +
>  	return 0;
> +
> +err_unregister:
> +	dma_async_device_unregister(&pdma->dma_dev);
> +
> +	return ret;
>  }
>
>  static int sf_pdma_remove(struct platform_device *pdev)
> @@ -583,6 +624,9 @@ static int sf_pdma_remove(struct platform_device *pdev)
>  		tasklet_kill(&ch->err_tasklet);
>  	}
>
> +	if (pdev->dev.of_node)
> +		of_dma_controller_free(pdev->dev.of_node);
> +
>  	dma_async_device_unregister(&pdma->dma_dev);
>
>  	return 0;
> --
> 2.34.1
>
>
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv
