Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6FBC07F4085
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Nov 2023 09:47:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230257AbjKVIrz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Nov 2023 03:47:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229631AbjKVIry (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Nov 2023 03:47:54 -0500
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B814BB9;
        Wed, 22 Nov 2023 00:47:49 -0800 (PST)
Received: by mail.gandi.net (Postfix) with ESMTPSA id DC35BFF80E;
        Wed, 22 Nov 2023 08:47:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1700642868;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=O42yIZF/FBtiU/QrYdS0P/jngo4oYqUoJrQRE/yZW/c=;
        b=bnRM8IX/lXpPFM5Okre0WxThQ3inTIopOK0YRLbMVS5KmW16c02QgAyw9hFe7ljLHc7/Cn
        fOG0y1Z0hEPOflWcqGMV7/VuwB7p5rnKvJPT9nAdjRyAIp2Ta5UrZR4ggz7LPXuCGtw5P+
        yfehH6YdbpIpZLapq4bAHg0eD7JsChReoVxNmAuzGMUb5Xbs+cXrad0vRxAIotqkx5PEtv
        aBDlGOYevquzG0xrLcWilja+dw98arueW5vdu7bE7gDUZaNa9MKb2pve9BQFTiP1eQoGDr
        RudeN3TzIEgoT1rT0sQVRvaD0oXZXCR6H5tChpftnh6jFQspOfxnj5vZOnD1uQ==
Date:   Wed, 22 Nov 2023 09:47:47 +0100
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Santhosh Kumar K <s-k6@ti.com>
Cc:     <lee@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH] dt-bindings: iio: adc: ti,am3359-adc: Allow dmas
 property to be optional
Message-ID: <20231122094747.34db981c@xps-13>
In-Reply-To: <20231122083608.136071-1-s-k6@ti.com>
References: <20231122083608.136071-1-s-k6@ti.com>
Organization: Bootlin
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-GND-Sasl: miquel.raynal@bootlin.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Santhosh,

s-k6@ti.com wrote on Wed, 22 Nov 2023 14:06:08 +0530:

> ADC module can function without DMA, so there may not be dma channel
> always associated with device. Hence, remove "dmas", "dma-names" from list
> of required properties.
>=20
> Signed-off-by: Santhosh Kumar K <s-k6@ti.com>

Reviewed-by: Miquel Raynal <miquel.raynal@bootlin.com>

> ---
>  Documentation/devicetree/bindings/mfd/ti,am3359-tscadc.yaml | 2 --
>  1 file changed, 2 deletions(-)
>=20
> diff --git a/Documentation/devicetree/bindings/mfd/ti,am3359-tscadc.yaml =
b/Documentation/devicetree/bindings/mfd/ti,am3359-tscadc.yaml
> index 23a63265be3c..70b5dfce07d2 100644
> --- a/Documentation/devicetree/bindings/mfd/ti,am3359-tscadc.yaml
> +++ b/Documentation/devicetree/bindings/mfd/ti,am3359-tscadc.yaml
> @@ -61,8 +61,6 @@ required:
>    - interrupts
>    - clocks
>    - clock-names
> -  - dmas
> -  - dma-names
> =20
>  additionalProperties: false
> =20


Thanks,
Miqu=C3=A8l
