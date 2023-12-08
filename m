Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EECEA80A455
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Dec 2023 14:20:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233604AbjLHNUt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Dec 2023 08:20:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1573772AbjLHNUm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Dec 2023 08:20:42 -0500
Received: from mail-oi1-f171.google.com (mail-oi1-f171.google.com [209.85.167.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C8361716;
        Fri,  8 Dec 2023 05:20:48 -0800 (PST)
Received: by mail-oi1-f171.google.com with SMTP id 5614622812f47-3b844357f7cso1527794b6e.1;
        Fri, 08 Dec 2023 05:20:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702041648; x=1702646448;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3GWkhChzBrVtOeU/3PYH7j47YZqHzJKDjxr8GAc4ZOw=;
        b=ivGR82WFvch/6JAv8vt1M0oNkfky7tZ5CuPBjB8/WpOx4pBU4SGyeWaWDv3wUtNpkZ
         0joLdKZMbg0Lc4rNMS038PbiQ75AhMztiNhMF9qjma40fm5X3IPxZBEcAo8Gl/Qh0AvA
         wrRJSOwigez+aYKzfpBOE9OClheTjZto/Gx+VsT66fPV8zqQFDg44uA/PMM1n0aK0e5D
         xVE0+R0R1iXIe7URGCyi/rd9K7AySAfqvGvAWJP+34yR/a7qoHBEFTprXD6ZFX9bcrl/
         CpOMkUHp7uM/x6u3idTOxJgrryJLlAYO+X5JqrFMM1pZ9q89k3/TXbLHAWMh32aUB7QD
         EXRw==
X-Gm-Message-State: AOJu0YwoQn/DPREjYRx8TH74QQxW/W7wZAmq5jX3Dg9B32fNmrBgfphB
        e78NQF8TdbIDKUKyFKYC7A==
X-Google-Smtp-Source: AGHT+IHhjOKdr82/KWEUNguAY8qA+GeFTCHpi9kCQS9Pri7WMQvh8Y+6EdYb1Ewkf9ZsVhlkwwY9cg==
X-Received: by 2002:a05:6808:17a7:b0:3b9:dddb:2921 with SMTP id bg39-20020a05680817a700b003b9dddb2921mr3108634oib.78.1702041647743;
        Fri, 08 Dec 2023 05:20:47 -0800 (PST)
Received: from herring.priv (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id h6-20020a056808014600b003b9d5e265f1sm326913oie.2.2023.12.08.05.20.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Dec 2023 05:20:47 -0800 (PST)
Received: (nullmailer pid 1152053 invoked by uid 1000);
        Fri, 08 Dec 2023 13:20:46 -0000
Date:   Fri, 8 Dec 2023 07:20:46 -0600
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     linux-kernel@vger.kernel.org, Maxime Ripard <mripard@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Inki Dae <inki.dae@samsung.com>, devicetree@vger.kernel.org,
        dri-devel@lists.freedesktop.org, Daniel Vetter <daniel@ffwll.ch>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        David Airlie <airlied@gmail.com>
Subject: Re: [PATCH 1/5] dt-bindings: gpu: samsung-rotator: drop redundant
 quotes
Message-ID: <170204154631.1150150.906529488412217486.robh@kernel.org>
References: <20231112184403.3449-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231112184403.3449-1-krzysztof.kozlowski@linaro.org>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Sun, 12 Nov 2023 19:43:59 +0100, Krzysztof Kozlowski wrote:
> Compatibles should not use quotes in the bindings.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  .../devicetree/bindings/gpu/samsung-rotator.yaml         | 9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)
> 

Applied, thanks!

