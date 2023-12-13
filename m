Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C185811B94
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 18:54:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233496AbjLMRxs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Dec 2023 12:53:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233490AbjLMRxp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 12:53:45 -0500
Received: from mail-oo1-f41.google.com (mail-oo1-f41.google.com [209.85.161.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78C47100;
        Wed, 13 Dec 2023 09:53:51 -0800 (PST)
Received: by mail-oo1-f41.google.com with SMTP id 006d021491bc7-59082c4aadaso3726053eaf.0;
        Wed, 13 Dec 2023 09:53:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702490031; x=1703094831;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ik457hD1S5HlN6UXVZUgeJxpu7wQOeGH5KzQB0C5eQs=;
        b=l306RH7AOqwg4DubrcuQhIJGH6+EjGfKH1JrFJTvIzHx9Hk9Eel+gKneCFBjgGIYD4
         OgaS4+C70lB0wtvJ3jaTjYpYi+M66BL9drtGti+LMfYTbc48bvMydP5VvjeJUB1WH1r8
         QT7UnIjgzdnADOXldgHcOhwlSuMucTTc5pOGVGnWQDAFK90qGsCU4BHI3D6anutyitKE
         gXc4XVY8jFoP1iPeZb5jh5SIBNjOhIARNRvg+BouU3l9l/0VJVnva8ZspdphShFwi38o
         UAbnjFlMi64+eAP6/p1ZVry6ID2fzKC8PK/GUo7NRxfa2Vkozy3We0UtoJ32qM2q0N31
         n14g==
X-Gm-Message-State: AOJu0YyA7Mb8ElcBU+1Te5B3402xD3ScUh3T6JiMamV+BC7mUWveSz9O
        +gIAuEHdH3/QrCcenBgonw==
X-Google-Smtp-Source: AGHT+IFQdhMh1dSsniMj2RNwPjv0B28HP5zPIeWWFOApyiATpZiK/dIcArxyl75Ywe09m3an1QfhbQ==
X-Received: by 2002:a4a:385a:0:b0:590:8d23:34f0 with SMTP id o26-20020a4a385a000000b005908d2334f0mr5050443oof.10.1702490030707;
        Wed, 13 Dec 2023 09:53:50 -0800 (PST)
Received: from herring.priv (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id b30-20020a4a98e1000000b00590ded91500sm2027111ooj.47.2023.12.13.09.53.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Dec 2023 09:53:50 -0800 (PST)
Received: (nullmailer pid 1588510 invoked by uid 1000);
        Wed, 13 Dec 2023 17:53:48 -0000
Date:   Wed, 13 Dec 2023 11:53:48 -0600
From:   Rob Herring <robh@kernel.org>
To:     Dario Binacchi <dario.binacchi@amarulasolutions.com>
Cc:     linux-kernel@vger.kernel.org, Maxime Ripard <mripard@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, michael@amarulasolutions.com,
        devicetree@vger.kernel.org, David Airlie <airlied@gmail.com>,
        dri-devel@lists.freedesktop.org, Daniel Vetter <daniel@ffwll.ch>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        Amarula patchwork <linux-amarula@amarulasolutions.com>,
        Jessica Zhang <quic_jesszhan@quicinc.com>
Subject: Re: [PATCH v6 3/4] dt-bindings: display: panel: Add synaptics r63353
 panel controller
Message-ID: <170249002767.1588438.13395249907934528672.robh@kernel.org>
References: <20231213140437.2769508-1-dario.binacchi@amarulasolutions.com>
 <20231213140437.2769508-4-dario.binacchi@amarulasolutions.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231213140437.2769508-4-dario.binacchi@amarulasolutions.com>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 13 Dec 2023 15:03:44 +0100, Dario Binacchi wrote:
> From: Michael Trimarchi <michael@amarulasolutions.com>
> 
> Add documentation for "synaptics,r63353" panel.
> 
> Signed-off-by: Michael Trimarchi <michael@amarulasolutions.com>
> Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> 
> ---
> 
> (no changes since v3)
> 
> Changes in v3:
> - Add 'Reviewed-by' tag of Krzysztof Kozlowski.
> - Replace "synaptics,r63353" compatible with "syna,r63353", as
>   required by vendor-prefixes.yaml.
> 
> Changes in v2:
> - Add $ref to panel-common.yaml
> - Drop port, reset-gpios, and backlight
> - Set port and backlight ad required
> - Replace additionalProperties with unevaluatedProperties
> 
>  .../display/panel/synaptics,r63353.yaml       | 61 +++++++++++++++++++
>  1 file changed, 61 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/display/panel/synaptics,r63353.yaml
> 

Applied, thanks!

