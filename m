Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03331800D73
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Dec 2023 15:40:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379202AbjLAOkP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Dec 2023 09:40:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379190AbjLAOkN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Dec 2023 09:40:13 -0500
Received: from mail-oo1-f48.google.com (mail-oo1-f48.google.com [209.85.161.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D131129;
        Fri,  1 Dec 2023 06:40:20 -0800 (PST)
Received: by mail-oo1-f48.google.com with SMTP id 006d021491bc7-58ceabd7cdeso1190242eaf.3;
        Fri, 01 Dec 2023 06:40:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701441619; x=1702046419;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BPLkrlm9gZVlYXuoUeDN/da2+V/b7EdhYfyZ64pS0T0=;
        b=GCZoIot9wKxwIvOx6dGtjUox2t9qGwS2JoKLvhs8ISYvth1AJ+RU3kbeVHqlW3Grg0
         7LcR4E0ENAjbqRK1RgWhAUIXDBb/bpeIvV4hMEcwUKhWJbWJiop8MxMffAyHDqcLkLLA
         xfnSwxTqx3APSFDyuQgRdd7xIdgaQBYBVmnX9n9km76sUm0XIc+mNX+hT6xR4enDFDLA
         2EQzPOLUdeihyrZc78j1di61nJg0GLWj5aUpWa2xjZocjYpHoGtWYr5T+buVS4/+0Sf4
         tx12xcV/K6sJH86zuXcVaoOHytikSJUDVfaavHiCiKHZ44kXgmbWe8P0Ov+oeRcMo+fL
         0pIA==
X-Gm-Message-State: AOJu0Yy4ajR9ED8hb9fGKACTJhgUtQK1blcorw4cziM/M4ipSNFCojoH
        IjW7PyMBvqXCVQOrXqp5CGcdMofM2A==
X-Google-Smtp-Source: AGHT+IFnVaLtGBZSRFE+8EltoRFz+TGBmX+kUC5B5eFKmVZnbvjoZC2TUoFYtce5BLXnLC1Hp5uivQ==
X-Received: by 2002:a05:6820:80b:b0:56c:d297:164c with SMTP id bg11-20020a056820080b00b0056cd297164cmr3319008oob.4.1701441619419;
        Fri, 01 Dec 2023 06:40:19 -0800 (PST)
Received: from herring.priv (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id v5-20020a4a2445000000b0058a1d87d96csm589185oov.41.2023.12.01.06.40.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Dec 2023 06:40:18 -0800 (PST)
Received: (nullmailer pid 976451 invoked by uid 1000);
        Fri, 01 Dec 2023 14:40:17 -0000
Date:   Fri, 1 Dec 2023 08:40:17 -0600
From:   Rob Herring <robh@kernel.org>
To:     Johan Hovold <johan+linaro@kernel.org>
Cc:     Lee Jones <lee@kernel.org>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH 2/4] dt-bindings: mfd: hisilicon,hi6421-spmi-pmic: fix
 example regulator node
Message-ID: <20231201144017.GA974717-robh@kernel.org>
References: <20231130172547.12555-1-johan+linaro@kernel.org>
 <20231130172547.12555-3-johan+linaro@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231130172547.12555-3-johan+linaro@kernel.org>
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

On Thu, Nov 30, 2023 at 06:25:45PM +0100, Johan Hovold wrote:
> The example regulator child nodes do not have unit addresses so drop the
> incorrect '#address-cells' and '#size-cells' properties from the parent
> node.
> 
> Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
> ---
>  .../devicetree/bindings/mfd/hisilicon,hi6421-spmi-pmic.yaml    | 3 ---
>  1 file changed, 3 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/mfd/hisilicon,hi6421-spmi-pmic.yaml b/Documentation/devicetree/bindings/mfd/hisilicon,hi6421-spmi-pmic.yaml
> index e36e5ce58136..60d5e6b3de33 100644
> --- a/Documentation/devicetree/bindings/mfd/hisilicon,hi6421-spmi-pmic.yaml
> +++ b/Documentation/devicetree/bindings/mfd/hisilicon,hi6421-spmi-pmic.yaml
> @@ -77,9 +77,6 @@ examples:
>        interrupts = <0 0>;
>  
>        regulators {
> -        #address-cells = <1>;
> -        #size-cells = <0>;
> -

It's the right fix, but I have to wonder why these are not schema 
errors? Seems like something in the schemas needs fixing.

>          ldo3: ldo3 {
>            regulator-name = "ldo3";
>            regulator-min-microvolt = <1500000>;
> -- 
> 2.41.0
> 
