Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2FEFB7EE611
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Nov 2023 18:40:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345324AbjKPRkz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Nov 2023 12:40:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbjKPRkw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Nov 2023 12:40:52 -0500
Received: from mail-oa1-f43.google.com (mail-oa1-f43.google.com [209.85.160.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6176A1A8;
        Thu, 16 Nov 2023 09:40:48 -0800 (PST)
Received: by mail-oa1-f43.google.com with SMTP id 586e51a60fabf-1f48ad1700aso509976fac.1;
        Thu, 16 Nov 2023 09:40:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700156447; x=1700761247;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XVlonfuXcyY4FJzpA36LqmNpUEIgZNzkmfekYli/Iv4=;
        b=PO07x4rf0bCe0FsIIvF5CLTtuas9Fa/VmMSLLaVWbA/rw1P1x2wXAzhIdz5/OPIqPa
         VpYh5XwxymdeBiodxcApekAdbxZhx1LatVMNxvPADGJb4HYMIh0gosw9nE2+88Rc3FCi
         1nT8aBdxzmTeqcboAcmnH8QH8ugaC70rR/+sk0q/b9FMteSm0UUctd4j9HPhMsf/Vm1j
         msIbx236PyBAtT3mtb++ntZ6nhLOid1DsG/dzg9uDOewvY9IE5k+SKEbyNZjMQ2VH0Oc
         QOrGLdXPP0A1VufePLAYp0PWDHO8Y2oEZGnvQ2ljOFB7VGxLMZ9xdMBaaQSUXeXzepa8
         egNw==
X-Gm-Message-State: AOJu0YyLlWcHRZHp4YmGQ8kf0L+oLmUWtfVlwZfZNCQPUko1zuM++hmW
        U3Bi2z9AHuSa/DOqD0L+aQ==
X-Google-Smtp-Source: AGHT+IHcR2mFJJO/I2dSRQmde4Q1Z1Ep57hlSQO6O8mHsC/e90Oxx9dd3UekKvWIdFGevP2c+LrbAQ==
X-Received: by 2002:a05:6870:460d:b0:1e9:668f:46d0 with SMTP id z13-20020a056870460d00b001e9668f46d0mr1083386oao.19.1700156447533;
        Thu, 16 Nov 2023 09:40:47 -0800 (PST)
Received: from herring.priv (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id pi5-20020a056871d10500b001e578de89cesm2295626oac.37.2023.11.16.09.40.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Nov 2023 09:40:46 -0800 (PST)
Received: (nullmailer pid 2521463 invoked by uid 1000);
        Thu, 16 Nov 2023 17:40:45 -0000
Date:   Thu, 16 Nov 2023 11:40:45 -0600
From:   Rob Herring <robh@kernel.org>
To:     Binbin Zhou <zhoubinbin@loongson.cn>
Cc:     loongarch@lists.linux.dev,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Conor Dooley <conor+dt@kernel.org>,
        Huacai Chen <chenhuacai@kernel.org>,
        loongson-kernel@lists.loongnix.cn, WANG Xuerui <git@xen0n.name>,
        linux-kernel@vger.kernel.org,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        Binbin Zhou <zhoubb.aaron@gmail.com>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        lvjianmin@loongson.cn, Huacai Chen <chenhuacai@loongson.cn>,
        linux-mips@vger.kernel.org
Subject: Re: [PATCH v4 2/5] dt-bindings: interrupt-controller:
 loongson,liointc: Fix dtbs_check warning for reg-names
Message-ID: <170015642605.2521005.9993251175536603536.robh@kernel.org>
References: <cover.1699521866.git.zhoubinbin@loongson.cn>
 <3a5bba5929691b6bcd0d09acacc5b6c246292ce1.1699521866.git.zhoubinbin@loongson.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3a5bba5929691b6bcd0d09acacc5b6c246292ce1.1699521866.git.zhoubinbin@loongson.cn>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 13 Nov 2023 10:36:22 +0800, Binbin Zhou wrote:
> As we know, the Loongson-2K0500 is a single-core CPU, and the
> core1-related register (isr1) does not exist. So "reg" and "reg-names"
> should be set to "minItems 2"(main nad isr0).
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
> Acked-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
> Signed-off-by: Binbin Zhou <zhoubinbin@loongson.cn>
> ---
>  .../interrupt-controller/loongson,liointc.yaml        | 11 +++++++++--
>  1 file changed, 9 insertions(+), 2 deletions(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>

