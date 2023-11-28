Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5EB467FC296
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 19:17:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346389AbjK1PwT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Nov 2023 10:52:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344823AbjK1PwS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Nov 2023 10:52:18 -0500
Received: from mail-oa1-f50.google.com (mail-oa1-f50.google.com [209.85.160.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E36C190;
        Tue, 28 Nov 2023 07:52:24 -0800 (PST)
Received: by mail-oa1-f50.google.com with SMTP id 586e51a60fabf-1f0f94943d9so2858055fac.2;
        Tue, 28 Nov 2023 07:52:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701186744; x=1701791544;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NpwcFU+v81rNX9yOoWEAEytDSoMoPOtVuaO4Q23AamM=;
        b=ngUKOpfaG2idw0mBg/y2Mkvu3sazw+9wCQXt4xCNNYVH1JKMtXP0BkWZS25brsqs86
         5IsHBmbCLjZmFTKYHuqMMb3YWwAuDbfzsyUl+q7sKcFxxAq0tuQsAax36O43pANN9mLp
         0zsQXYdn8tn5TN5s9zzmT0otiFNvHpfrlVQRzz490CZdvdhiAYIgIg29xTHGe9NpOsGQ
         8d24sF20cyVFUx3go8tJREWRh8PYlKGCrasFhQLhO/rRXFVqdkjRMOs7GWDgkqPwqUIQ
         hIBIXbNyzuHQSwybBbguKApB9TsynGxAyPWkzlJ4JIRnXgWkUk5FcdCazpW+LmJGNbD/
         /ssQ==
X-Gm-Message-State: AOJu0Yxx6xn62nafqkrKPIWjL3QdHBOk8FBbLUQHPfRvOc1Dv1mTgEex
        wVz9lmm+jCg/aef+f/BUyA==
X-Google-Smtp-Source: AGHT+IGOObQFuIpAGX2qh0tH048w+P8whX0JpMfwqHCw3+gilpnx0P4tozSWhUirRDG3Lyt6B3Q1jA==
X-Received: by 2002:a05:6871:453:b0:1f4:dd99:b07 with SMTP id e19-20020a056871045300b001f4dd990b07mr17030773oag.49.1701186744081;
        Tue, 28 Nov 2023 07:52:24 -0800 (PST)
Received: from herring.priv (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id js4-20020a056870bac400b001fa3757b80esm1517332oab.5.2023.11.28.07.52.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Nov 2023 07:52:23 -0800 (PST)
Received: (nullmailer pid 3332019 invoked by uid 1000);
        Tue, 28 Nov 2023 15:52:22 -0000
Date:   Tue, 28 Nov 2023 09:52:22 -0600
From:   Rob Herring <robh@kernel.org>
To:     Shengyang Chen <shengyang.chen@starfivetech.com>
Cc:     devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org,
        andrzej.hajda@intel.com, neil.armstrong@linaro.org,
        rfoss@kernel.org, Laurent.pinchart@ideasonboard.com,
        jonas@kwiboo.se, jernej.skrabec@gmail.com,
        maarten.lankhorst@linux.intel.com, mripard@kernel.org,
        tzimmermann@suse.de, airlied@gmail.com, daniel@ffwll.ch,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        p.zabel@pengutronix.de, tomi.valkeinen@ideasonboard.com,
        r-ravikumar@ti.com, rdunlap@infradead.org,
        u.kleine-koenig@pengutronix.de, bbrezillon@kernel.org,
        changhuang.liang@starfivetech.com, keith.zhao@starfivetech.com,
        jack.zhu@starfivetech.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 1/2] dt-bindings: display: bridge: cdns: Add
 properties to support StarFive JH7110 SoC
Message-ID: <20231128155222.GA3319844-robh@kernel.org>
References: <20231127113436.57361-1-shengyang.chen@starfivetech.com>
 <20231127113436.57361-2-shengyang.chen@starfivetech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231127113436.57361-2-shengyang.chen@starfivetech.com>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 27, 2023 at 07:34:35PM +0800, Shengyang Chen wrote:
> From: Keith Zhao <keith.zhao@starfivetech.com>
> 
> Add properties in CDNS DSI yaml file to match with
> CDNS DSI module in StarFive JH7110 SoC.
> 
> Signed-off-by: Keith Zhao <keith.zhao@starfivetech.com>
> ---
>  .../bindings/display/bridge/cdns,dsi.yaml     | 38 ++++++++++++++++++-
>  1 file changed, 36 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/display/bridge/cdns,dsi.yaml b/Documentation/devicetree/bindings/display/bridge/cdns,dsi.yaml
> index 23060324d16e..3f02ee383aad 100644
> --- a/Documentation/devicetree/bindings/display/bridge/cdns,dsi.yaml
> +++ b/Documentation/devicetree/bindings/display/bridge/cdns,dsi.yaml
> @@ -17,6 +17,7 @@ properties:
>      enum:
>        - cdns,dsi
>        - ti,j721e-dsi
> +      - starfive,cdns-dsi
>  
>    reg:
>      minItems: 1
> @@ -27,14 +28,20 @@ properties:
>            Register block for wrapper settings registers in case of TI J7 SoCs.
>  
>    clocks:
> +    minItems: 2
>      items:
>        - description: PSM clock, used by the IP
>        - description: sys clock, used by the IP
> +      - description: apb clock, used by the IP
> +      - description: txesc clock, used by the IP
>  
>    clock-names:
> +    minItems: 2
>      items:
>        - const: dsi_p_clk
>        - const: dsi_sys_clk
> +      - const: apb
> +      - const: txesc
>  
>    phys:
>      maxItems: 1
> @@ -46,10 +53,21 @@ properties:
>      maxItems: 1
>  
>    resets:
> -    maxItems: 1
> +    minItems: 1
> +    items:
> +      - description: dsi sys reset line
> +      - description: dsi dpi reset line
> +      - description: dsi apb reset line
> +      - description: dsi txesc reset line
> +      - description: dsi txbytehs reset line
>  
>    reset-names:
> -    const: dsi_p_rst
> +    items:
> +      - const: dsi_p_rst
> +      - const: dsi_dpi
> +      - const: dsi_apb
> +      - const: dsi_txesc
> +      - const: dsi_txbytehs

Let's not continue the redundant 'dsi_' prefix. We're stuck with it for 
the first one, but not the new ones.

Rob
