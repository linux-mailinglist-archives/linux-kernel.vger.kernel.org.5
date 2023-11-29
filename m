Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F00247FD6BA
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Nov 2023 13:28:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233461AbjK2M1x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Nov 2023 07:27:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229708AbjK2M1v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 07:27:51 -0500
Received: from mail-oi1-f173.google.com (mail-oi1-f173.google.com [209.85.167.173])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49E76D7E;
        Wed, 29 Nov 2023 04:27:58 -0800 (PST)
Received: by mail-oi1-f173.google.com with SMTP id 5614622812f47-3b896a0aee5so257816b6e.1;
        Wed, 29 Nov 2023 04:27:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701260877; x=1701865677;
        h=date:subject:message-id:references:in-reply-to:cc:to:from
         :mime-version:content-transfer-encoding:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=opRq8HhMKtPyRUv5kMZKX/NFDoGBi9Z7K4WbMMCtpbM=;
        b=st1P3nf8XyZieuFwJY0JXwW13coFzB/t8ddMZfnJGA9Y8bcanGGHOuZzMy8ko9Qk5d
         3rs9qB4S9obhUvYuJSzONnirJMn63umGWU3OHTeXWXyN9Ok2CeRv+hH8822yJihs5z6/
         tPvpAILaNYfUsElhvNjjW+PkUdYGCnUG6mJKN0FrJWiwA9eeKO8e93mxrWa6wbSXP2Zj
         x4P1swDmRTl9bqPXiuJ2fHnBvFGzgsyVZTBDt/Dw6dpaBHsDyluopmleqegpe+TPzaDb
         sLeFt3gTd55afi+eyM0oRncSjjxflsRBTCBuoRiNlUu6gP66xCXKuaLTI0PXJnPiUjVw
         XQVA==
X-Gm-Message-State: AOJu0Yzds7hRwJFcfKFCjRfgTZy8iEp2RHFy0h9gxym5KCg61u6kndLB
        xMeogV94QxqRcCakV8PDv6Rrfz51Ew==
X-Google-Smtp-Source: AGHT+IFeT4TOS1lwCniGFpFyRlrKaGQoldYYSp6/qieipLGGVk/fxUG/nFPnWWnb5eqEqOt+HkpFbA==
X-Received: by 2002:a05:6808:2102:b0:3b8:3cfd:f0f0 with SMTP id r2-20020a056808210200b003b83cfdf0f0mr5877834oiw.5.1701260877457;
        Wed, 29 Nov 2023 04:27:57 -0800 (PST)
Received: from herring.priv (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id bf4-20020a056808190400b003af56ef1510sm2181994oib.20.2023.11.29.04.27.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Nov 2023 04:27:56 -0800 (PST)
Received: (nullmailer pid 1991760 invoked by uid 1000);
        Wed, 29 Nov 2023 12:27:55 -0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     devicetree@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>,
        Jonathan Cameron <jic23@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        linux-kernel@vger.kernel.org, Andreas Klinger <ak@it-klinger.de>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-iio@vger.kernel.org
In-Reply-To: <20231129111041.26782-1-krzysztof.kozlowski@linaro.org>
References: <20231129111041.26782-1-krzysztof.kozlowski@linaro.org>
Message-Id: <170126087595.1991744.9053853140300681368.robh@kernel.org>
Subject: Re: [PATCH] dt-bindings: iio: honeywell,mprls0025pa: drop ref from
 pressure properties
Date:   Wed, 29 Nov 2023 06:27:55 -0600
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


On Wed, 29 Nov 2023 12:10:41 +0100, Krzysztof Kozlowski wrote:
> The dtschema treats now properties with '-pascal' suffix as standard one
> and already defines $ref for them, thus the $ref should be dropped from
> the bindings.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> 
> ---
> 
> dtschema change was merged:
> https://github.com/devicetree-org/dt-schema/commit/2a1708dcf4ff0b25c4ec46304d6d6cc655c3e635
> but not yet released as new dtschema version.
> 
> This change should be applied once new dtschema version is released or
> Rob says otherwise.
> ---
>  .../devicetree/bindings/iio/pressure/honeywell,mprls0025pa.yaml | 2 --
>  1 file changed, 2 deletions(-)
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/iio/pressure/honeywell,mprls0025pa.yaml: honeywell,pmin-pascal: missing type definition
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/iio/pressure/honeywell,mprls0025pa.yaml: honeywell,pmax-pascal: missing type definition

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20231129111041.26782-1-krzysztof.kozlowski@linaro.org

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.

