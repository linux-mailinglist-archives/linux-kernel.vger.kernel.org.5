Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D69FA7DD57C
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Oct 2023 18:52:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347014AbjJaRwO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Oct 2023 13:52:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236514AbjJaRwM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Oct 2023 13:52:12 -0400
Received: from mail-oo1-f47.google.com (mail-oo1-f47.google.com [209.85.161.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82857E4;
        Tue, 31 Oct 2023 10:52:07 -0700 (PDT)
Received: by mail-oo1-f47.google.com with SMTP id 006d021491bc7-58706a0309dso1190509eaf.1;
        Tue, 31 Oct 2023 10:52:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698774727; x=1699379527;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ps8gVGM6a0bOEx91A6UnJicGRcymk1vWN92b42mtNSM=;
        b=O2jkyQw7QQvx14yMsbLfihpomX9ZH0Siw5YgfDy0CFxxZ0DfcDK/W5C2fhD0jad6El
         q20DRUnH9aHEYfdxMTcOOKsdFl+AsVmR+9ARZz6+wy+0jqhjJ4/2WEoj+cIFSO1+2+c9
         z4QbPymdaU5ROInfrb+19prXPsrVA76v6VLML8u+XPkWKBsktmN+0BtAKt16ttscVrHg
         qX+9pu9VUpXvDO2CybU5PS78aeRfRLIBgcTCcCX+RTGwB1lwdweUQAQnQFkxn6+C015N
         jkPe5wAw6HDaIg08hLdrQ0cSYXVApYYLAbsTa5HRi6VGzIyY1zE5Ly/wP7KblltxHVpH
         JDWw==
X-Gm-Message-State: AOJu0YyvTG+NtK3knuK2SSAuB5cEKk1fUVCJVDrEt7t32OzC1tnosI00
        WJOJMobIRX9sEjOdYseLDw==
X-Google-Smtp-Source: AGHT+IFm/2PqyMwMfeShka2egMe13aU06RVEJKKgsAtMIvpEmxd+3ZLD+dkvXXIbB8Am9NgEOO9ECQ==
X-Received: by 2002:a4a:a649:0:b0:582:c8b4:d9df with SMTP id j9-20020a4aa649000000b00582c8b4d9dfmr13003433oom.1.1698774726805;
        Tue, 31 Oct 2023 10:52:06 -0700 (PDT)
Received: from herring.priv ([4.31.143.193])
        by smtp.gmail.com with ESMTPSA id y127-20020a4a4585000000b00581e7506f2fsm342322ooa.9.2023.10.31.10.52.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Oct 2023 10:52:06 -0700 (PDT)
Received: (nullmailer pid 1805145 invoked by uid 1000);
        Tue, 31 Oct 2023 17:52:05 -0000
Date:   Tue, 31 Oct 2023 12:52:05 -0500
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
Subject: Re: [PATCH v3 2/5] dt-bindings: interrupt-controller:
 loongson,liointc: Fix dtbs_check warning for reg-names
Message-ID: <20231031175205.GA1803813-robh@kernel.org>
References: <cover.1698717154.git.zhoubinbin@loongson.cn>
 <fd5efc8a21b94e044e4e225255655fc92beb0c63.1698717154.git.zhoubinbin@loongson.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fd5efc8a21b94e044e4e225255655fc92beb0c63.1698717154.git.zhoubinbin@loongson.cn>
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

On Tue, Oct 31, 2023 at 10:36:37AM +0800, Binbin Zhou wrote:
> As we know, the Loongson-2K0500 is a single-core CPU, and the
> core1-related register (isr1) does not exist, and we need a separate
> declaration.
> 
> This fixes dtbs_check warning:
> 
> DTC_CHK arch/loongarch/boot/dts/loongson-2k0500-ref.dtb
> arch/loongarch/boot/dts/loongson-2k0500-ref.dtb: interrupt-controller@1fe11400: reg-names: ['main', 'isr0'] is too short
>         From schema: Documentation/devicetree/bindings/interrupt-controller/loongson,liointc.yaml
> arch/loongarch/boot/dts/loongson-2k0500-ref.dtb: interrupt-controller@1fe11400: Unevaluated properties are not allowed ('reg-names' was unexpected)
>         From schema: Documentation/devicetree/bindings/interrupt-controller/loongson,liointc.yaml
> arch/loongarch/boot/dts/loongson-2k0500-ref.dtb: interrupt-controller@1fe11400: reg: [[0, 534844416, 0, 64], [0, 534843456, 0, 8]] is too short
>         From schema: Documentation/devicetree/bindings/interrupt-controller/loongson,liointc.yaml
> arch/loongarch/boot/dts/loongson-2k0500-ref.dtb: interrupt-controller@1fe11440: reg-names: ['main', 'isr0'] is too short
>         From schema: Documentation/devicetree/bindings/interrupt-controller/loongson,liointc.yaml
> 
> Signed-off-by: Binbin Zhou <zhoubinbin@loongson.cn>
> ---
>  .../loongson,liointc.yaml                     | 22 ++++++++++++++-----
>  1 file changed, 16 insertions(+), 6 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/interrupt-controller/loongson,liointc.yaml b/Documentation/devicetree/bindings/interrupt-controller/loongson,liointc.yaml
> index 0d9511b8a792..7393d7dfbe82 100644
> --- a/Documentation/devicetree/bindings/interrupt-controller/loongson,liointc.yaml
> +++ b/Documentation/devicetree/bindings/interrupt-controller/loongson,liointc.yaml
> @@ -11,8 +11,13 @@ maintainers:
>  
>  description: |
>    This interrupt controller is found in the Loongson-3 family of chips and
> -  Loongson-2K1000 chip, as the primary package interrupt controller which
> +  Loongson-2K series chips, as the primary package interrupt controller which
>    can route local I/O interrupt to interrupt lines of cores.
> +  Be aware of the following points.
> +  1.The Loongson-2K0500 is a single core CPU, the isr1 register could not be defined;
> +  2.The Loongson-2K0500/2K1000 has 64 device interrupt sources as inputs, so we
> +    need to define two nodes in dts{i} to describe the "0-31" and "32-61" interrupt
> +    sources respectively.
>  
>  allOf:
>    - $ref: /schemas/interrupt-controller.yaml#
> @@ -29,10 +34,14 @@ properties:
>      maxItems: 3
>  
>    reg-names:
> -    items:
> -      - const: main
> -      - const: isr0
> -      - const: isr1
> +    oneOf:
> +      - items:
> +          - const: main
> +          - const: isr0
> +      - items:
> +          - const: main
> +          - const: isr0
> +          - const: isr1

Just adding 'minItems: 2' accomplishes the same thing without 
duplicating the list.

>  
>    interrupt-controller: true
>  
> @@ -94,7 +103,8 @@ if:
>  then:
>    properties:
>      reg:
> -      minItems: 3
> +      minItems: 2
> +      maxItems: 3
>  
>    required:
>      - reg-names
> -- 
> 2.39.3
> 
