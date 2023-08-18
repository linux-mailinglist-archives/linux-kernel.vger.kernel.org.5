Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67175780A51
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Aug 2023 12:39:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358975AbjHRKjM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Aug 2023 06:39:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358836AbjHRKhx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Aug 2023 06:37:53 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id AD4092D4A;
        Fri, 18 Aug 2023 03:37:51 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CA532D75;
        Fri, 18 Aug 2023 03:38:31 -0700 (PDT)
Received: from donnerap.manchester.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7C1263F762;
        Fri, 18 Aug 2023 03:37:48 -0700 (PDT)
Date:   Fri, 18 Aug 2023 11:37:46 +0100
From:   Andre Przywara <andre.przywara@arm.com>
To:     Martin Botka <martin.botka@somainline.org>
Cc:     Vasily Khoruzhick <anarsoul@gmail.com>,
        Yangtao Li <tiny.windzz@gmail.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org,
        Alan Ma <tech@biqu3d.com>,
        Luke Harrison <bttuniversity@biqu3d.com>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Martin Botka <martin@biqu3d.com>
Subject: Re: [PATCH 1/3] dt-bindings: thermal: sun8i: Add binding for H616
 THS controller
Message-ID: <20230818113746.5b86d766@donnerap.manchester.arm.com>
In-Reply-To: <20230818-ths-h616-v1-1-0e1e058b9c7a@somainline.org>
References: <20230818-ths-h616-v1-0-0e1e058b9c7a@somainline.org>
        <20230818-ths-h616-v1-1-0e1e058b9c7a@somainline.org>
Organization: ARM
X-Mailer: Claws Mail 3.18.0 (GTK+ 2.24.32; aarch64-unknown-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 18 Aug 2023 10:43:16 +0200
Martin Botka <martin.botka@somainline.org> wrote:

> Add binding for H616 THS controller.

You could add:
This controller is similar to the H6, but covers four sensors and uses
slightly different calibration methods.

One minor question below:

> Signed-off-by: Martin Botka <martin.botka@somainline.org>
> ---
>  .../devicetree/bindings/thermal/allwinner,sun8i-a83t-ths.yaml          | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/thermal/allwinner,sun8i-a83t-ths.yaml b/Documentation/devicetree/bindings/thermal/allwinner,sun8i-a83t-ths.yaml
> index fbd4212285e2..79692f8360f5 100644
> --- a/Documentation/devicetree/bindings/thermal/allwinner,sun8i-a83t-ths.yaml
> +++ b/Documentation/devicetree/bindings/thermal/allwinner,sun8i-a83t-ths.yaml
> @@ -20,6 +20,7 @@ properties:
>        - allwinner,sun50i-a100-ths
>        - allwinner,sun50i-h5-ths
>        - allwinner,sun50i-h6-ths
> +      - allwinner,sun50i-h616-ths
>  
>    clocks:
>      minItems: 1
> @@ -63,6 +64,7 @@ allOf:
>              enum:
>                - allwinner,sun50i-a100-ths
>                - allwinner,sun50i-h6-ths
> +              - allwinner,sun50i-h616-ths
>  
>      then:
>        properties:
> @@ -107,6 +109,7 @@ allOf:
>                - allwinner,sun50i-a100-ths
>                - allwinner,sun50i-h5-ths
>                - allwinner,sun50i-h6-ths
> +              - allwinner,sun50i-h616-ths

I wonder if this list can be negated. Because what this currently says is:
"Every controller except the A83T one requires clocks and resets."
Can we write this more explicitly?

Regardless:

Reviewed-by: Andre Przywara <andre.przywara@arm.com>

Cheers,
Andre


>  
>      then:
>        required:
> 

