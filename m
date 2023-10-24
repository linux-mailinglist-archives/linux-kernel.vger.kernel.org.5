Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE3A37D5CC3
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Oct 2023 22:58:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344095AbjJXU6e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Oct 2023 16:58:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344399AbjJXU62 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Oct 2023 16:58:28 -0400
Received: from mail-oo1-f52.google.com (mail-oo1-f52.google.com [209.85.161.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDA7010FB;
        Tue, 24 Oct 2023 13:58:23 -0700 (PDT)
Received: by mail-oo1-f52.google.com with SMTP id 006d021491bc7-5845a94dae1so102465eaf.0;
        Tue, 24 Oct 2023 13:58:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698181103; x=1698785903;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gImLv6Y8NnjeTz7dQ0WcIB2xeIpe49LYR/tvFnfDL/Q=;
        b=k+vmq5pz3enf5Rz73t6tiTmYXovGi3tF2WtiSkqr7ZXiEKARrZAv1FhFJWxrE2ySqX
         M65R3MOPgTSLuRBt4xRmeKA1e0W1A8w9HHJSd5mBotceQ3n6qM57n3NkoY4YGIpWZPFl
         fvlOomIz7OCsmeq/Uczy6fYIRgPaeMXbrELUS5V5xYBRtQCHFXx9OxGecqFQthQVz1gO
         GNPWm/W5b6dSdl4nCXZU0NhgDPQIoiHpAzOgk4BoCcsXbQMsMcYcMb4dEe/WhQAu/BPR
         PEfNSCoeEj1lEBTx9yXSs0WdCAHNMZzSJ220iA7nJ4jTVPW8J9R6ZciixjzUtV+ILYXF
         8iXQ==
X-Gm-Message-State: AOJu0YxFsrfmWyMTFgsmW164jACb8rRxJuEinQZxnUnnMSAZpcZ8yOce
        lOjRpAhlGWJFs5UE8NpYCr6a6Yj0/g==
X-Google-Smtp-Source: AGHT+IE1z5Wnc9bHS6/09yv+hrma7Pg98VUrO9Y8WkEXtI0anq09u6uD9L71sy3NQfmWDCVp/Pnt6Q==
X-Received: by 2002:a05:6870:459a:b0:1e9:cba3:a329 with SMTP id y26-20020a056870459a00b001e9cba3a329mr9010193oao.14.1698181102804;
        Tue, 24 Oct 2023 13:58:22 -0700 (PDT)
Received: from herring.priv (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id eg41-20020a05687098a900b001eb0e8b75cdsm2022007oab.10.2023.10.24.13.58.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Oct 2023 13:58:22 -0700 (PDT)
Received: (nullmailer pid 559118 invoked by uid 1000);
        Tue, 24 Oct 2023 20:58:21 -0000
Date:   Tue, 24 Oct 2023 15:58:21 -0500
From:   Rob Herring <robh@kernel.org>
To:     Geert Uytterhoeven <geert+renesas@glider.be>
Cc:     Lee Jones <lee@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, devicetree@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC] dt-bindings: mfd: ams,as3711: Convert to json-schema
Message-ID: <20231024205821.GA529288-robh@kernel.org>
References: <9af48b816f2b6397f5ada58a9b5ced85213e5194.1698085945.git.geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9af48b816f2b6397f5ada58a9b5ced85213e5194.1698085945.git.geert+renesas@glider.be>
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 23, 2023 at 08:38:07PM +0200, Geert Uytterhoeven wrote:
> Convert the Austria MicroSystems AS3711 Quad Buck High Current PMIC with
> Charger Device Tree binding documentation to json-schema.
> 
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---
> RFC, as I couldn't get the multiple dependencies right (see FIXMEs):
>   1. How to incorporate "su2-dev: [ su2-max-uA ]" and
>      "su2-feedback-curr-auto: [ su2-dev ]"?
>   2. su2-dev requiring one of su2-fbprot-* does not seem to work?
> 
> Anyone with better *Of foo? Thanks!
> ---
>  .../devicetree/bindings/mfd/ams,as3711.yaml   | 223 ++++++++++++++++++
>  .../devicetree/bindings/mfd/as3711.txt        |  73 ------
>  2 files changed, 223 insertions(+), 73 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/mfd/ams,as3711.yaml
>  delete mode 100644 Documentation/devicetree/bindings/mfd/as3711.txt


> +    dependencies:
> +      # To use the SU1 converter as a backlight source the following two
> +      # properties must be provided:
> +      su1-dev: [ su1-max-uA ]
> +      su1-max-uA: [ su1-dev ]
> +
> +      # To use the SU2 converter as a backlight source the following two
> +      # properties must be provided:
> +      # FIXME How to incorporate "su2-dev: [ su2-max-uA ]"?

You've stumbled into the evolution of jsonschema. Newer versions split 
'dependencies' into 'dependentSchemas' and 'dependentRequired' (more 
generally, they split keywords that could be either a list or schema). 
That will let you have both forms. The new keywords are already 
supported and you can use them (internally, dtschema is converting 
every 'dependencies' to the new forms because json-schema likes flag 
days, sigh).


> +      # FIXME su2-dev requiring one of su2-fbprot-* does not seem to work?
> +      su2-dev:
> +        allOf:
> +          - oneOf:
> +              - required:
> +                  - su2-feedback-voltage
> +              - required:
> +                  - su2-feedback-curr1
> +              - required:
> +                  - su2-feedback-curr2
> +              - required:
> +                  - su2-feedback-curr3
> +              - required:
> +                  - su2-feedback-curr-auto
> +          - oneof:

Your second problem is here.

s/oneof/oneOf/

Got to love json-schema's default silence on unknown keywords. I'll 
figure out why we don't descend here and find this.

> +              - required:
> +                  - su2-fbprot-lx-sd4
> +              - required:
> +                  - su2-fbprot-gpio2
> +              - required:
> +                  - su2-fbprot-gpio3
> +              - required:
> +                  - su2-fbprot-gpio4
