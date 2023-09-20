Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C60B57A71AA
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Sep 2023 06:56:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231854AbjITE42 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Sep 2023 00:56:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229534AbjITE40 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Sep 2023 00:56:26 -0400
Received: from abb.hmeau.com (abb.hmeau.com [144.6.53.87])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7E6A9F;
        Tue, 19 Sep 2023 21:56:16 -0700 (PDT)
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
        by formenos.hmeau.com with smtp (Exim 4.94.2 #2 (Debian))
        id 1qipFK-00GCoh-9L; Wed, 20 Sep 2023 12:55:31 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Wed, 20 Sep 2023 12:55:33 +0800
Date:   Wed, 20 Sep 2023 12:55:33 +0800
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Alexey Romanov <avromanov@salutedevices.com>
Cc:     narmstrong@baylibre.com, neil.armstrong@linaro.org,
        olivia@selenic.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        conor@kernel.org, khilman@baylibre.com, jbrunet@baylibre.com,
        martin.blumenstingl@googlemail.com, f.fainelli@gmail.com,
        hkallweit1@gmail.com, lists@kaiser.cx,
        linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-crypto@vger.kernel.org,
        kernel@sberdevices.ru, Alexey Romanov <avromanov@sberdevices.ru>
Subject: Re: [PATCH v3 1/3] drivers: rng: meson: add support for S4
Message-ID: <ZQp7Rf3qzoN6c2Le@gondor.apana.org.au>
References: <20230911101129.10604-1-avromanov@salutedevices.com>
 <20230911101129.10604-2-avromanov@salutedevices.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230911101129.10604-2-avromanov@salutedevices.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 11, 2023 at 01:11:27PM +0300, Alexey Romanov wrote:
>
> +struct meson_rng_priv {
> +	int (*read)(struct hwrng *rng, void *buf, size_t max, bool wait);
> +};
>  
>  struct meson_rng_data {
>  	void __iomem *base;
>  	struct hwrng rng;
> +	struct device *dev;
> +	const struct meson_rng_priv *priv;
>  };

Is data->priv really necessary? It doesn't seem to be used anywhere
after the probe.

Thanks,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
