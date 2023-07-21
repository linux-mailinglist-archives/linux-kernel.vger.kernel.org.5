Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF30D75C1E0
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jul 2023 10:42:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230348AbjGUImY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jul 2023 04:42:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230286AbjGUImW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jul 2023 04:42:22 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DD192D60
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jul 2023 01:42:17 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id 2adb3069b0e04-4fbf1f6c771so2678700e87.1
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jul 2023 01:42:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1689928936; x=1690533736;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=W6TNcuJ6KKeyZP2Qc4jlyhOYba3uwyITx3koQ5jSwOo=;
        b=HXARkpRe+Woy704jzyCB1PGGko82xLt9OG7PhRKVf+T/dDXg/HTeom6C04EO5/KTSg
         uYLQjum3/vFCHKVQR/H42P89Zp/H7rCobL+opuva5lCb6QODJZtrBr5CReJQt3lPWrD5
         lLWX+0+ZvOmqlBw/qvFGk1Id30q4dTNFPr6hEvPjGk3QZkp0Py47WpAKQ/l2ewGR7MOu
         gkxtsCSWZ9TYYIe4Z421Q1FxfjHKeyD8G2RorBxM+RSGqU/auqsWMhmL0AYVhcKUBZzC
         dcBGpsNMQ6LpJ6pPfof+QKchRCWK+Gt7CtMGjuIK8PfhnA9t39mQspBKhPJumjSVwNJr
         1p1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689928936; x=1690533736;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=W6TNcuJ6KKeyZP2Qc4jlyhOYba3uwyITx3koQ5jSwOo=;
        b=ZqNK0rNhRPJk5sW2pD33lhRBqE8B8Hbk03bINTo+cdlceApcSi3Yz2zW8PUFRYmhIm
         kx1lVXW+J0D0MgnCp1pEVVjC1lJv8bA+gB0VJ2nAa8I0QLZmsNJryStrz3rKiWJgN/Yr
         pnoWzEctYDAYkVZhLYHjwqO8VESw6rf3Af/bd6wrWwUNyxQTVP/Kiz8zLbuZzeO1zaJX
         MI4Nn/9jvMHKlB/VCo5lLe50NaS5JtLZ4bXXdjsw07Gi/U1QZPlHf1ssz9tkTl3B6Ylr
         SgMMGZv3PNUd/3aWOymW4AhQxXYkI93GjXE2g6PSbDerKRWnH838sFhhN46BW5dWs4uX
         /Lgw==
X-Gm-Message-State: ABy/qLaZNuBZsM9xWWo6fglNEFbB5AOKcC3mwmEMFzWPl6PYpSIyAahq
        fQD++xdjcOdOADaCiyuGv4mJ6g==
X-Google-Smtp-Source: APBJJlGKtETxxAKILcgSa+Bf4sk10TjgrNYisDXsNrKRx2MGlhPI/YEZW67N87KY8IC80WmfTGivlQ==
X-Received: by 2002:ac2:5225:0:b0:4f8:711b:18b0 with SMTP id i5-20020ac25225000000b004f8711b18b0mr866706lfl.3.1689928935769;
        Fri, 21 Jul 2023 01:42:15 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.223.104])
        by smtp.gmail.com with ESMTPSA id d15-20020a5d644f000000b003143c06135bsm3570899wrw.50.2023.07.21.01.42.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 21 Jul 2023 01:42:15 -0700 (PDT)
Message-ID: <5b9ceb0e-b7e4-d4b3-461e-c70f4a01fa5e@linaro.org>
Date:   Fri, 21 Jul 2023 10:42:13 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v3 1/2] dt-bindings: display: add bindings for pcd8544
 displays
Content-Language: en-US
To:     Viktar Simanenka <viteosen@gmail.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230720124026.356603-1-viteosen@gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230720124026.356603-1-viteosen@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20/07/2023 14:40, Viktar Simanenka wrote:
> Add device tree binding documentation for PCD8544 LCD display controller.
> 
> Signed-off-by: Viktar Simanenka <viteosen@gmail.com>
> ---
> v3:add a little more description to the exposed vendor properties
>    add commit message finally
> v2 link: https://lore.kernel.org/linux-devicetree/20230719154450.620410-1-viteosen@gmail.com/
> 
>  .../bindings/display/nxp,pcd8544.yaml         | 95 +++++++++++++++++++
>  1 file changed, 95 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/display/nxp,pcd8544.yaml
> 
> diff --git a/Documentation/devicetree/bindings/display/nxp,pcd8544.yaml b/Documentation/devicetree/bindings/display/nxp,pcd8544.yaml
> new file mode 100644
> index 000000000000..bacdeff9776e
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/display/nxp,pcd8544.yaml
> @@ -0,0 +1,95 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/display/nxp,pcd8544.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Philips Semiconductors PCD8544 LCD Display Controller
> +
> +maintainers:
> +  - Viktar Simanenka <viteosen@gmail.com>
> +
> +description: |
> +  Philips Semiconductors PCD8544 LCD Display Controller with SPI control bus.
> +  Designed to drive a graphic display of 48 rows and 84 columns,
> +  such as Nokia 5110/3310 LCDs.
> +
> +allOf:
> +  - $ref: panel/panel-common.yaml#

This is not a panel, is it?

> +  - $ref: /schemas/spi/spi-peripheral-props.yaml#
> +

Best regards,
Krzysztof

