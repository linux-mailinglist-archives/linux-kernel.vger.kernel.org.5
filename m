Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5AC027BF2C3
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Oct 2023 08:06:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377940AbjJJGGm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Oct 2023 02:06:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376502AbjJJGGi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Oct 2023 02:06:38 -0400
Received: from meesny.iki.fi (meesny.iki.fi [195.140.195.201])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AAFEAC;
        Mon,  9 Oct 2023 23:06:35 -0700 (PDT)
Received: from hillosipuli.retiisi.eu (185-9-11-240.cust.suomicom.net [185.9.11.240])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: sailus)
        by meesny.iki.fi (Postfix) with ESMTPSA id 4S4QQF6XLFzyWn;
        Tue, 10 Oct 2023 09:06:27 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=meesny;
        t=1696917992;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=6+kUZ8PXCIiQYOaRsg+lVPSGx1V+n4P7FYahLIA1VgI=;
        b=uocPHBA/W+9y9OmEAhXzwnDc7SwM2UNcMhHAm7jezccmUryQGIVWTGCSdsIIC66FSF2AMu
        A8CPTEyVV/NHfw/SUFpq0L9G6kEpclmdarioAtmlQ0JW5KTNDa1O6ufGr5xCWQBRK6YK72
        95jfvYgfTPKYaD9K6Pw6VHinSvAqUrk=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
        s=meesny; t=1696917992;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=6+kUZ8PXCIiQYOaRsg+lVPSGx1V+n4P7FYahLIA1VgI=;
        b=U5f3RTcaItTeIklJyU8l0HnyinZmbgSvEWtXI4hnWsl+Tl6kEWaehe7NLPuVLcd0i+sHd4
        IK8Pwx8xeChPgYNQpJfj+f3oy6lB2w1Su8vV59U9tGOpuOAglr52Ppq0w9MHBBTGDYEgLZ
        a0GMXLj0KZpZzKFKFYMLweiMnA7SZOk=
ARC-Authentication-Results: i=1;
        ORIGINATING;
        auth=pass smtp.auth=sailus smtp.mailfrom=sakari.ailus@iki.fi
ARC-Seal: i=1; s=meesny; d=iki.fi; t=1696917992; a=rsa-sha256; cv=none;
        b=ZE2Miv8CLD5pyxxx5ZKzlNxzBn58XYlXP9DA/0AyzO8qxiJEWKwNl/KfhvzxdeLvNQfzbk
        JoOppgcivP5Atrq11q6CSJ6rMZOFPq4Tq/K6qqpO6Y/sOGJeJ/t0Vbupukv1nBuduUv2e6
        9KfyfLdVS5sAz5ciGouNRf0Op+rplhY=
Received: from valkosipuli.retiisi.eu (valkosipuli.localdomain [192.168.4.2])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by hillosipuli.retiisi.eu (Postfix) with ESMTPS id 7A300634CBD;
        Tue, 10 Oct 2023 09:06:26 +0300 (EEST)
Date:   Tue, 10 Oct 2023 06:06:26 +0000
From:   Sakari Ailus <sakari.ailus@iki.fi>
To:     Kieran Bingham <kieran.bingham@ideasonboard.com>
Cc:     linux-media@vger.kernel.org, devicetree@vger.kernel.org,
        "Paul J. Murphy" <paul.j.murphy@intel.com>,
        Daniele Alessandrelli <daniele.alessandrelli@intel.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/5] media: dt-bindings: media: imx335: Add supply
 bindings
Message-ID: <ZSTp4jXKPVrbo5oU@valkosipuli.retiisi.eu>
References: <20231010005126.3425444-1-kieran.bingham@ideasonboard.com>
 <20231010005126.3425444-2-kieran.bingham@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231010005126.3425444-2-kieran.bingham@ideasonboard.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Kieran,

On Tue, Oct 10, 2023 at 01:51:22AM +0100, Kieran Bingham wrote:
> Add the bindings for the supply references used on the IMX335.
> 
> Signed-off-by: Kieran Bingham <kieran.bingham@ideasonboard.com>
> ---
>  .../bindings/media/i2c/sony,imx335.yaml          | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/media/i2c/sony,imx335.yaml b/Documentation/devicetree/bindings/media/i2c/sony,imx335.yaml
> index a167dcdb3a32..1863b5608a5c 100644
> --- a/Documentation/devicetree/bindings/media/i2c/sony,imx335.yaml
> +++ b/Documentation/devicetree/bindings/media/i2c/sony,imx335.yaml
> @@ -32,6 +32,15 @@ properties:
>      description: Clock frequency from 6 to 27 MHz, 37.125MHz, 74.25MHz
>      maxItems: 1
>  
> +  avdd-supply:
> +    description: Analog power supply (2.9V)
> +
> +  ovdd-supply:
> +    description: Interface power supply (1.8V)
> +
> +  dvdd-supply:
> +    description: Digital power supply (1.2V)

I wonder what's the policy in this case --- some of the regulators are
often hard-wired and the bindings didn't have them previously either (I
wonder why, maybe they were all hard wired in the board??).

Could they be optional? The driver will need to be able to do without these
in any case.

> +
>    reset-gpios:
>      description: Reference to the GPIO connected to the XCLR pin, if any.
>      maxItems: 1
> @@ -60,6 +69,9 @@ required:
>    - compatible
>    - reg
>    - clocks
> +  - avdd-supply
> +  - ovdd-supply
> +  - dvdd-supply
>    - port
>  
>  additionalProperties: false
> @@ -79,6 +91,10 @@ examples:
>              assigned-clock-parents = <&imx335_clk_parent>;
>              assigned-clock-rates = <24000000>;
>  
> +            avdd-supply = <&camera_vdda_2v9>;
> +            ovdd-supply = <&camera_vddo_1v8>;
> +            dvdd-supply = <&camera_vddd_1v2>;
> +
>              port {
>                  imx335: endpoint {
>                      remote-endpoint = <&cam>;

-- 
Kind regards,

Sakari Ailus
