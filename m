Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F1467F8F1D
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Nov 2023 21:48:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229523AbjKYUs3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Nov 2023 15:48:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbjKYUs1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Nov 2023 15:48:27 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A11AAF
        for <linux-kernel@vger.kernel.org>; Sat, 25 Nov 2023 12:48:34 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 487CBC433C8;
        Sat, 25 Nov 2023 20:48:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700945313;
        bh=MP615DG3faCXFei6ez6/qbJ2Qn+AxlK3zXjwrEKNgcs=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=V3H6UDq7A3kCMLfHpZpSX7FXfzHuWMOtsplTH0sNtXsZgArz+P0U4eBCtxi3NSFFd
         /Qh78hVGqFA0WqXtaEMTLiv8fodY0nCNwQemnzy2nkPIc8A948DHrbP8ShAHXs9JEh
         DZSd65o2b/ffSmFfCaSmhQJlMgtpbBWoxv52RCHkCAWexYJeYwHrGLN9suMTTHOnuk
         DdSGqivh1nxdaSurglxzzB29rEdm+mzoC6D5xHsCr4gfSyRMDlvOZaKdKmw5u63wzf
         fjwHu1uh7qGvuEyyEExZqT+BueoGfafWluF3pHxDvInU7XHZpnYl45oF6XMQNbYQcP
         bHLD2kxsjKD7g==
Date:   Sat, 25 Nov 2023 20:48:14 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Andi Shyti <andi.shyti@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Lee Jones <lee@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Tomasz Figa <tomasz.figa@gmail.com>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Uwe =?UTF-8?B?S2xlaW5lLUvDtm5pZw==?= 
        <u.kleine-koenig@pengutronix.de>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaehoon Chung <jh80.chung@samsung.com>,
        Sam Protsenko <semen.protsenko@linaro.org>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-i2c@vger.kernel.org,
        linux-iio@vger.kernel.org, linux-mmc@vger.kernel.org,
        linux-gpio@vger.kernel.org, linux-pwm@vger.kernel.org,
        linux-rtc@vger.kernel.org, linux-serial@vger.kernel.org,
        alsa-devel@alsa-project.org, linux-sound@vger.kernel.org
Subject: Re: [PATCH 10/17] dt-bindings: iio: samsung,exynos-adc: add
 specific compatibles for existing SoC
Message-ID: <20231125204814.10fe16fa@jic23-huawei>
In-Reply-To: <20231108104343.24192-11-krzysztof.kozlowski@linaro.org>
References: <20231108104343.24192-1-krzysztof.kozlowski@linaro.org>
        <20231108104343.24192-11-krzysztof.kozlowski@linaro.org>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed,  8 Nov 2023 11:43:36 +0100
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org> wrote:

> Samsung Exynos SoC reuses several devices from older designs, thus
> historically we kept the old (block's) compatible only.  This works fine
> and there is no bug here, however guidelines expressed in
> Documentation/devicetree/bindings/writing-bindings.rst state that:
> 1. Compatibles should be specific.
> 2. We should add new compatibles in case of bugs or features.
> 
> Add compatibles specific to each SoC in front of all old-SoC-like
> compatibles.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Acked-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> 
> ---
> 
> I propose to take the patch through Samsung SoC (me). See cover letter
> for explanation.
> ---
>  .../bindings/iio/adc/samsung,exynos-adc.yaml  | 29 +++++++++++--------
>  1 file changed, 17 insertions(+), 12 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/iio/adc/samsung,exynos-adc.yaml b/Documentation/devicetree/bindings/iio/adc/samsung,exynos-adc.yaml
> index 582d0a03b814..4e40f6bed5db 100644
> --- a/Documentation/devicetree/bindings/iio/adc/samsung,exynos-adc.yaml
> +++ b/Documentation/devicetree/bindings/iio/adc/samsung,exynos-adc.yaml
> @@ -11,18 +11,23 @@ maintainers:
>  
>  properties:
>    compatible:
> -    enum:
> -      - samsung,exynos-adc-v1                 # Exynos5250
> -      - samsung,exynos-adc-v2
> -      - samsung,exynos3250-adc
> -      - samsung,exynos4212-adc                # Exynos4212 and Exynos4412
> -      - samsung,exynos7-adc
> -      - samsung,s3c2410-adc
> -      - samsung,s3c2416-adc
> -      - samsung,s3c2440-adc
> -      - samsung,s3c2443-adc
> -      - samsung,s3c6410-adc
> -      - samsung,s5pv210-adc
> +    oneOf:
> +      - enum:
> +          - samsung,exynos-adc-v1                 # Exynos5250
> +          - samsung,exynos-adc-v2
> +          - samsung,exynos3250-adc
> +          - samsung,exynos4212-adc                # Exynos4212 and Exynos4412
> +          - samsung,exynos7-adc
> +          - samsung,s3c2410-adc
> +          - samsung,s3c2416-adc
> +          - samsung,s3c2440-adc
> +          - samsung,s3c2443-adc
> +          - samsung,s3c6410-adc
> +          - samsung,s5pv210-adc
> +      - items:
> +          - enum:
> +              - samsung,exynos5433-adc
> +          - const: samsung,exynos7-adc
>  
>    reg:
>      maxItems: 1

