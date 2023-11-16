Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B67C87EE693
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Nov 2023 19:19:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345425AbjKPSTA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Nov 2023 13:19:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232555AbjKPSS7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Nov 2023 13:18:59 -0500
Received: from mail-ot1-f47.google.com (mail-ot1-f47.google.com [209.85.210.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2C9DD56;
        Thu, 16 Nov 2023 10:18:55 -0800 (PST)
Received: by mail-ot1-f47.google.com with SMTP id 46e09a7af769-6ce2ea3a944so664382a34.1;
        Thu, 16 Nov 2023 10:18:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700158735; x=1700763535;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Mvdm8s7CLiAWc1zAvkwb+zCVPLYN6IW325FSx81hTfY=;
        b=uvaiwSezERSvr5uuo6ESbE2Y/GmSfRqUXRKb4NLb/pE9ZgqsSa2jm1zy+JDEr/+nLu
         9/hwxKhESDiJR3jv43VEo552E4Or/qr+Fda+pdKY8umHkpBL9BeqbGRe3iLngIwGuj6a
         EOiHFrHQiACge09hLrWsncD1OkH8453F0Aa9F1UinYEK4kGUKPhFSJBrsRxqTyJXe+jA
         n31/DwQ4ujq9V8EKWSPwTfLLkoog3qQ5d1kVMKwPaCk2Or5CoDD4cvHy9hKa+/YAe4GW
         Aq41R5cQw1MYuRMTlqPbq3yVnQZZ/7ngfXaeS+1yj41lt9Usg1Ij7/06c3boJr5c5IkE
         L3Og==
X-Gm-Message-State: AOJu0YzUE2tW53795m/j0dIWCQWn373sEJzaj7N9gsoIFFc+GgvPlm4r
        eYjOc5wk4952E5MiKwlgBw==
X-Google-Smtp-Source: AGHT+IEwmVU0R+k/HtPd1oq3ffY8WltHJ7y4wNFhcwB+B3/35kMpJHdybuQBwbbX2qDPkK5mAxrwNw==
X-Received: by 2002:a05:6870:418e:b0:1f4:be52:b14b with SMTP id y14-20020a056870418e00b001f4be52b14bmr21955186oac.12.1700158735208;
        Thu, 16 Nov 2023 10:18:55 -0800 (PST)
Received: from herring.priv (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id y4-20020a056870a34400b001e9ce1b5e8fsm2220517oak.15.2023.11.16.10.18.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Nov 2023 10:18:54 -0800 (PST)
Received: (nullmailer pid 2710216 invoked by uid 1000);
        Thu, 16 Nov 2023 18:18:47 -0000
Date:   Thu, 16 Nov 2023 12:18:47 -0600
From:   Rob Herring <robh@kernel.org>
To:     Chen Wang <unicornxw@gmail.com>
Cc:     aou@eecs.berkeley.edu, chao.wei@sophgo.com, conor@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, mturquette@baylibre.com,
        palmer@dabbelt.com, paul.walmsley@sifive.com,
        richardcochran@gmail.com, sboyd@kernel.org,
        devicetree@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        haijiao.liu@sophgo.com, xiaoguang.xing@sophgo.com,
        Chen Wang <unicorn_wang@outlook.com>
Subject: Re: [PATCH 3/5] dt-bindings: clock: sophgo: Add SG2042 bindings
Message-ID: <20231116181847.GA2659392-robh@kernel.org>
References: <cover.1699879741.git.unicorn_wang@outlook.com>
 <1e5836360485b63e15bdf58da59e83139666b290.1699879741.git.unicorn_wang@outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1e5836360485b63e15bdf58da59e83139666b290.1699879741.git.unicorn_wang@outlook.com>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 13, 2023 at 09:19:31PM +0800, Chen Wang wrote:
> From: Chen Wang <unicorn_wang@outlook.com>
> 
> Add bindings for the clock generator on the SG2042 RISC-V SoC.
> 
> Signed-off-by: Chen Wang <unicorn_wang@outlook.com>
> ---
>  .../clock/sophgo/sophgo,sg2042-clkgen.yaml    | 48 +++++++++++++++++++
>  1 file changed, 48 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/clock/sophgo/sophgo,sg2042-clkgen.yaml
> 
> diff --git a/Documentation/devicetree/bindings/clock/sophgo/sophgo,sg2042-clkgen.yaml b/Documentation/devicetree/bindings/clock/sophgo/sophgo,sg2042-clkgen.yaml
> new file mode 100644
> index 000000000000..e372d5dca5b9
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/clock/sophgo/sophgo,sg2042-clkgen.yaml
> @@ -0,0 +1,48 @@
> +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/clock/sophgo/sophgo,sg2042-clkgen.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Sophgo SG2042 Clock Generator
> +
> +maintainers:
> +  - Chen Wang <unicorn_wang@outlook.com>
> +
> +properties:
> +  compatible:
> +    const: sophgo,sg2042-clkgen
> +
> +  system-ctrl:
> +    $ref: /schemas/types.yaml#/definitions/phandle-array
> +    items:
> +      - items:
> +          - description: phandle to System Register Controller syscon node.
> +    description:
> +      The phandle to System Register Controller syscon node.

Forget what I just said about syscon.yaml...

You don't need a phandle here. Just make this node a child of the 
syscon. However, why do you need a child at all? Just add 'clocks' and 
'#clock-cells' to the parent directly. You don't need a child node when 
there's only 1 child node. Maybe there's other functions, but I have no 
visibility into that. IOW, define what all the functions are so we can 
provide better guidance.

Rob
