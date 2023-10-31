Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33CB57DD58E
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Oct 2023 18:54:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376553AbjJaRyK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Oct 2023 13:54:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347092AbjJaRxs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Oct 2023 13:53:48 -0400
Received: from mail-ot1-f44.google.com (mail-ot1-f44.google.com [209.85.210.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 479DE192;
        Tue, 31 Oct 2023 10:53:45 -0700 (PDT)
Received: by mail-ot1-f44.google.com with SMTP id 46e09a7af769-6ce2cf67be2so3747462a34.2;
        Tue, 31 Oct 2023 10:53:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698774824; x=1699379624;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JErNOeS484fSE6jMqFS1aWxPGk/XE6lq+FSKNBvOBGk=;
        b=tmMiyoirSofB5H3jwHjedPqHQASUoQn1sZEZ3BU3AYzVbOz763LaKDQZs727Vq3qyu
         8hgxXI0CLrdERf48iTbRTk/e2ekr9g9LglYUW7PzhZH2AtYlQn1uqc+YpC9xLvbGbfBo
         TVjuaRPzrpRnST37ceGgk1gm2qlZKHvskwqdnswr14FNUOo3tsXwPvjTH4JopXGgP1GU
         Jn/fW3AlpVglqwx/Rif7YPPpVBy4f/KFUhDojoKZS1ciZb7BGS8nGCyt4RPyMetaRM4Y
         TWslNQonZfEbARwlutUy8wtQb2Wu8BGEN/icfEzIisT7xX0YYJon91bF1dL7SofH52uf
         3jOQ==
X-Gm-Message-State: AOJu0YxiLwm3m0C4HRJl6ic+tggcuJp6dAjbOw+hdkrJYfA/ggLRmxBM
        WPYmpDYbX0aPuZRXyLvPTQ==
X-Google-Smtp-Source: AGHT+IHmDV7ekbXMqnPAI+zXPOg9uVdSiGo0HGjlgtqDy0nQceDIWHe1Ss1oJDxPVF8IkiT6rhqXwg==
X-Received: by 2002:a9d:7f85:0:b0:6b9:8357:61e6 with SMTP id t5-20020a9d7f85000000b006b9835761e6mr13026591otp.35.1698774824296;
        Tue, 31 Oct 2023 10:53:44 -0700 (PDT)
Received: from herring.priv ([4.31.143.193])
        by smtp.gmail.com with ESMTPSA id a3-20020a9d5c83000000b006c4d6a06a94sm290478oti.76.2023.10.31.10.53.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Oct 2023 10:53:43 -0700 (PDT)
Received: (nullmailer pid 1807481 invoked by uid 1000);
        Tue, 31 Oct 2023 17:53:42 -0000
Date:   Tue, 31 Oct 2023 12:53:42 -0500
From:   Rob Herring <robh@kernel.org>
To:     Binbin Zhou <zhoubinbin@loongson.cn>
Cc:     Binbin Zhou <zhoubb.aaron@gmail.com>,
        Huacai Chen <chenhuacai@loongson.cn>,
        Thomas Gleixner <tglx@linutronix.de>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Huacai Chen <chenhuacai@kernel.org>,
        loongson-kernel@lists.loongnix.cn, devicetree@vger.kernel.org,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        linux-mips@vger.kernel.org, lvjianmin@loongson.cn,
        WANG Xuerui <git@xen0n.name>, loongarch@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 3/5] dt-bindings: interrupt-controller:
 loongson,liointc: Fix dtbs_check for interrupt-names
Message-ID: <20231031175342.GA1805362-robh@kernel.org>
References: <cover.1698717154.git.zhoubinbin@loongson.cn>
 <7fae3ce932b455effcf73ff0208f4776959f2f44.1698717154.git.zhoubinbin@loongson.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7fae3ce932b455effcf73ff0208f4776959f2f44.1698717154.git.zhoubinbin@loongson.cn>
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

On Tue, Oct 31, 2023 at 10:36:38AM +0800, Binbin Zhou wrote:
> The Loongson-2K0500/2K1000 CPUs have 64 interrupt sources as inputs, and
> a route-mapped node handles up to 32 interrupt sources, so two liointc
> nodes are defined in dts{i}.
> Of course, we need to ensure that the routing outputs (intx) of the two
> nodes cannot conflict.
> 
> For example, in Loongson-2K1000, 'int0' is typically used by the liointc0
> node, then the liointc1 node can only use the outputs starting with
> 'int1'.
> 
> So "interrupt-names" should be defined by "pattern".
> 
> This fixes dtbs_check warning:
> 
> DTC_CHK arch/loongarch/boot/dts/loongson-2k0500-ref.dtb
> arch/loongarch/boot/dts/loongson-2k0500-ref.dtb: interrupt-controller@1fe11440: interrupt-names:0: 'int0' was expected
>         From schema: Documentation/devicetree/bindings/interrupt-controller/loongson,liointc.yaml
> arch/loongarch/boot/dts/loongson-2k0500-ref.dtb: interrupt-controller@1fe11440: Unevaluated properties are not allowed ('interrupt-names' was unexpected)
>         From schema: Documentation/devicetree/bindings/interrupt-controller/loongson,liointc.yaml
> DTC_CHK arch/loongarch/boot/dts/loongson-2k1000-ref.dtb
> arch/loongarch/boot/dts/loongson-2k1000-ref.dtb: interrupt-controller@1fe01440: interrupt-names:0: 'int0' was expected
>         From schema: Documentation/devicetree/bindings/interrupt-controller/loongson,liointc.yaml
> arch/loongarch/boot/dts/loongson-2k1000-ref.dtb: interrupt-controller@1fe01440: Unevaluated properties are not allowed ('interrupt-names' was unexpected)
>         From schema: Documentation/devicetree/bindings/interrupt-controller/loongson,liointc.yaml
> 
> Signed-off-by: Binbin Zhou <zhoubinbin@loongson.cn>
> ---
>  .../bindings/interrupt-controller/loongson,liointc.yaml    | 7 +++----
>  1 file changed, 3 insertions(+), 4 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/interrupt-controller/loongson,liointc.yaml b/Documentation/devicetree/bindings/interrupt-controller/loongson,liointc.yaml
> index 7393d7dfbe82..a90c609d351e 100644
> --- a/Documentation/devicetree/bindings/interrupt-controller/loongson,liointc.yaml
> +++ b/Documentation/devicetree/bindings/interrupt-controller/loongson,liointc.yaml
> @@ -54,11 +54,9 @@ properties:
>    interrupt-names:
>      description: List of names for the parent interrupts.
>      items:
> -      - const: int0
> -      - const: int1
> -      - const: int2
> -      - const: int3
> +      pattern: int[0-3]
>      minItems: 1
> +    maxItems: 4
>  
>    '#interrupt-cells':
>      const: 2
> @@ -87,6 +85,7 @@ required:
>    - compatible
>    - reg
>    - interrupts
> +  - interrupt-names

A new required property is an ABI break. Is that okay for this platform? 
The commit msg should answer that if so.


>    - interrupt-controller
>    - '#interrupt-cells'
>    - loongson,parent-int-map
> -- 
> 2.39.3
> 
